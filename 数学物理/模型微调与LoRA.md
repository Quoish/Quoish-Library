---
title: 模型微调与LoRA
aliases:
  - Fine-tuning
  - 参数高效微调
  - PEFT
  - 低秩适配
tags:
  - 机器学习
  - 人工智能
category:
  - 机器学习和深度学习
status: 完成
created: 2026-10-25
updated: 2026-10-25
---

导航：[[机器学习与人工智能]]

# 为什么微调

预训练模型提供通用起点，具体任务可能需要不同的输出格式、领域表达或分类边界。微调在已有参数基础上继续优化。全量微调更新全部参数；参数高效微调只训练少量新增参数或部分已有参数，减少梯度与优化器状态的成本。

冻结参数并不意味着整个模型无需前向计算。反向传播仍可能经过冻结层来计算适配器的梯度，激活内存也可能占很大部分。微调效果取决于基座模型、数据、目标、学习率和评价方式。

# LoRA 的矩阵分解

设一个线性层$y=W_0x$，$W_0\in\mathbb R^{d_{out}\times d_{in}}$。LoRA 冻结$W_0$，添加低秩增量：

$$
W=W_0+\Delta W,\quad \Delta W=\frac\alpha rBA,
$$
$$
A\in\mathbb R^{r\times d_{in}},\quad B\in\mathbb R^{d_{out}\times r}.
$$

新增参数量$r(d_{in}+d_{out})$，通常远小于$d_{in}d_{out}$。例如64×64线性层全量权重有4096个参数，$r=4$时只有512个低秩参数。$\alpha/r$控制增量尺度，但也与学习率等因素共同作用。

常用初始化令$A$随机、$B=0$，使初始增量为0。如果两者都初始化为零，乘积对两者的梯度都为零，训练无法启动。第一步$A$的梯度可能为零而$B$非零，这是正常的初始化行为。

# 如何接到语言模型

LoRA 常应用于注意力的查询、键、值或输出投影，也可用于前馈层。选择哪些层和秩会改变能力与资源消耗。完整语言模型适配还需正确的 tokenizer、对话模板、标签掩码、序列截断和独立验证集。

训练完成后，适配器权重需要与对应基座及配置配套。推理时可以分别计算两条支路，也可在适用条件下把增量合并到权重。本例无 Dropout、使用浮点线性层，可以直接验证合并前后等价。量化模型的合并需要另外考虑精度和实现。

# 与其他方法的关系

提示工程改变输入，RAG 增加外部检索上下文，微调改变模型参数。它们可以结合使用。LoRA 能低成本调整某些行为，但有限数据微调可能过拟合或遗忘已有能力；新增动态知识通常还要考虑检索更新。

QLoRA 在量化基座上训练低秩适配器，包含额外量化与内存技术，不等同于普通 LoRA。为保持统一环境和机制清楚，本例手写 LoRA 线性层，不引入额外量化框架。

# 可复原例程

构造一个已知低秩的目标权重变化，只训练 LoRA 的 A、B 来拟合它；检查冻结权重是否保持不变，以及合并推理是否等价。这是线性层机制验证，不是完整大模型微调。

## 项目目录

```text
模型微调与LoRA-demo/
├── runtime.py
├── model.py
├── main.py
└── outputs/  # 运行时自动生成，无须手工创建
```

## 环境与文件

先按[[机器学习与人工智能#统一运行环境|统一运行环境]]建立 `ml-ai-notes` 环境。以下每个代码块均为所标文件的完整内容，文件名和大小写应与目录一致。

### `runtime.py`

```python
from pathlib import Path
import argparse
import random
import numpy as np
import torch

ROOT = Path(__file__).resolve().parent
OUT = ROOT / "outputs"
OUT.mkdir(exist_ok=True)

def setup():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cpu", action="store_true")
    args = parser.parse_args()
    random.seed(7)
    np.random.seed(7)
    torch.manual_seed(7)
    torch.set_num_threads(2)
    device = torch.device("cuda" if torch.cuda.is_available() and not args.cpu else "cpu")
    print("device:", device)
    return device
```

### `model.py`

```python
import math
import torch
from torch import nn

class LoRALinear(nn.Module):
    def __init__(self, base_weight, rank=4, alpha=4):
        super().__init__()
        cout, cin = base_weight.shape
        self.base = nn.Linear(cin, cout, bias=False)
        with torch.no_grad():
            self.base.weight.copy_(base_weight)
        self.base.weight.requires_grad_(False)
        self.A = nn.Parameter(torch.empty(rank, cin, device=base_weight.device))
        self.B = nn.Parameter(torch.zeros(cout, rank, device=base_weight.device))
        nn.init.kaiming_uniform_(self.A, a=math.sqrt(5))
        self.scale = alpha / rank

    def forward(self, x):
        return self.base(x) + self.scale * (x @ self.A.T @ self.B.T)

    def merged_weight(self):
        return self.base.weight + self.scale * (self.B @ self.A)
```

### `main.py`

```python
import json
import torch
from model import LoRALinear
from runtime import setup, OUT

def main():
    device = setup()
    size, rank = 64, 4
    base = torch.randn(size, size, device=device) * 0.1
    target = base + (torch.randn(size, rank, device=device) @
                     torch.randn(rank, size, device=device)) * 0.03
    x = torch.randn(512, size, device=device)
    y = x @ target.T
    model = LoRALinear(base, rank).to(device)
    frozen = model.base.weight.detach().clone()
    optimizer = torch.optim.Adam([model.A, model.B], lr=0.03)
    initial = (model(x)-y).square().mean().item()
    for step in range(500):
        optimizer.zero_grad()
        loss = (model(x)-y).square().mean()
        loss.backward()
        optimizer.step()
    test_x = torch.randn(128, size, device=device)
    with torch.no_grad():
        adapted = model(test_x)
        merged = test_x @ model.merged_weight().T
        test_mse = (adapted - test_x @ target.T).square().mean().item()
    assert torch.equal(frozen, model.base.weight)
    assert model.base.weight.grad is None
    assert torch.allclose(adapted, merged, atol=1e-5, rtol=1e-4)
    report = {"trainable_parameters": sum(p.numel() for p in model.parameters() if p.requires_grad),
        "full_weight_parameters": size * size, "initial_mse": initial,
        "test_mse": test_mse, "merge_max_error": (adapted-merged).abs().max().item()}
    print(report)
    (OUT / "metrics.json").write_text(json.dumps(report, indent=2), encoding="utf-8")
    torch.save({"A": model.A.detach().cpu(), "B": model.B.detach().cpu(),
                "scale": model.scale, "base": base.cpu()}, OUT / "adapter_demo.pt")

if __name__ == "__main__":
    main()
```

## 运行步骤

在 VS Code 中打开项目根目录，选择 `ml-ai-notes` 的 Python 解释器，再在终端执行：

```powershell
conda activate ml-ai-notes
python main.py
```

所有相对输出路径均以代码所在目录为基准；运行生成的文件位于 `outputs/`。

## 结果与解释

可训练参数应为512，完整权重参数为4096。目标增量特意设为秩不超过4，因此训练和测试误差应明显下降。断言检查基座未更新、没有基座梯度，以及合并推理等价；这一合成结果不能推断真实语言任务中所需的秩。

## 实测记录

2026-10-25，在[[机器学习与人工智能#统一运行环境|统一运行环境]]中从上述代码块还原项目进行验证。数值与生成结果会受硬件和随机过程影响，不能要求逐位一致。

| 入口 | CPU | CUDA |
|---|---|---|
| `main.py` | 运行通过（14.4秒） | 运行通过（15.3秒） |

CPU 运行的主要观测：训练参数 512，完整权重参数 4096；测试 MSE 1.06e-06，合并最大误差 1.19e-06。冻结与等价性断言通过。

## 小实验

- 将训练秩改为1，保持目标秩4，观察拟合残差。
- 将 A、B 都改为零初始化，验证训练停滞。
- 增加目标增量的秩，对比低秩约束与表达能力。

# 关联阅读

- [[大语言模型的训练与生成]]
- [[神经网络优化与泛化]]
- [[检索增强生成]]

# 参考资料

- [LoRA 原论文](https://arxiv.org/abs/2106.09685)
- [QLoRA 原论文](https://arxiv.org/abs/2305.14314)
