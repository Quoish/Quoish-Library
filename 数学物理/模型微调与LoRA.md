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
updated: 2026-11-02
---

导航：[[机器学习与人工智能]]

# 核心图景：保留已有权重，只学习一小份可组合的改动

微调从一个已有模型出发，继续用具体任务的数据优化。LoRA 把某些权重的改动限制为两个较小矩阵的乘积，冻结原权重，只训练这份低秩增量。

它属于参数适配方法。模型仍要做前向计算，训练也仍需要损失、梯度和评价；改变的是哪些参数可训练，以及怎样表示它们的变化。

# 问题域与提出背景

预训练模型越大，为每个任务都保存和训练一套完整模型就越昂贵。全量微调不仅要放下权重，还要保存梯度、优化器的一阶／二阶状态，以及反向传播需要的激活。

2021年的[LoRA 论文](https://arxiv.org/abs/2106.09685)把大模型适配中的更新表示为低秩分解，减少训练参数和每个任务需要单独保存的内容。这里的低秩约束是一种有效的适配假设，不保证所有任务的最佳变化都具有极低秩。

2023年的[QLoRA](https://arxiv.org/abs/2305.14314)进一步结合量化的冻结基座与低秩适配器，针对基座权重本身仍占用很多内存的问题。它包含额外量化与内存技术，不能等同于普通 LoRA 的另一个名字。

# 全量微调、冻结与提示分别改了什么

| 方式 | 变化对象 | 训练时的主要特点 |
|---|---|---|
| 提示设计 | 模型输入内容 | 通常不更新权重 |
| 全量微调 | 全部或大部分原权重 | 梯度与优化器状态规模较大 |
| 冻结特征＋新任务头 | 新增输出头等少量参数 | 可调整范围主要在任务头 |
| LoRA | 注入指定层的低秩增量 | 在冻结基座内部增加可训练变化 |
| RAG | 检索得到的外部上下文 | 可在不更新生成器的情况下使用新资料 |

这些方法可以组合。例如对话风格通过微调调整，频繁更新的知识通过检索提供。不能只按数据是否“属于某个领域”就自动决定选哪一种。

# 一层 LoRA 怎样计算

设原线性层对列向量输入计算$y=W_0x$，其中$W_0\in\mathbb R^{d_{out}\times d_{in}}$。LoRA 写成

$$
W=W_0+\Delta W,\quad
\Delta W=\frac\alpha rBA,
$$
$$
A\in\mathbb R^{r\times d_{in}},\quad
B\in\mathbb R^{d_{out}\times r}.
$$

先由$A$把输入映射到$r$维，再由$B$映射回输出维，结果乘缩放系数并加到基座输出上。$r$是秩上限，$\alpha$控制增量尺度，二者的作用不能混为一个学习率参数。

与直接训练$d_{out}d_{in}$个权重相比，新参数量为$r(d_{in}+d_{out})$。例如64×64矩阵有4096项，取$r=4$，两矩阵合计只有$4\times64+64\times4=512$项。

# 一个两维手算例子

令基座为单位矩阵，$A=\begin{bmatrix}1&0\end{bmatrix}$、$B=\begin{bmatrix}0.2\\0.3\end{bmatrix}$，并取$\alpha/r=1$，则

$$
BA=\begin{bmatrix}0.2&0\\0.3&0\end{bmatrix}.
$$

对$x=(2,5)^T$，基座输出为$(2,5)^T$，低秩支路先取得$Ax=2$，再得到$B(Ax)=(0.4,0.6)^T$，总输出为$(2.4,5.6)^T$。

这份变化只通过一个中间方向传递，所以受到低秩限制。增加$r$扩大可调整空间，也增加参数和优化状态；它不是免费的容量提升。

# 为什么常把一个矩阵初始化为零

通常让$A$随机、$B=0$，初始增量就是0，模型从基座行为开始训练。若两者都为0，乘积对任一个矩阵的梯度都含另一个零矩阵，更新无法启动。

当$B=0$而$A$随机时，第一步$A$的梯度可能为0，但$B$可以先得到非零更新；随后$A$也能参与学习。这与两者都置零导致的停滞不同。

冻结$W_0$表示不更新它，并不等于删掉这条支路的前向计算。模型还需根据基座表示计算输出；为了训练内部适配器，也可能需要沿冻结层把导数传回更早位置。

# 合并推理为什么可行

若只有两个线性支路且没有额外随机操作，可以先算$W_{merged}=W_0+\alpha BA/r$，再用一个矩阵作推理。它在实数运算上等价于两路相加，浮点运算次序不同会产生微小误差。

量化、Dropout、多个适配器和不同框架可能引入额外条件。适配器文件也必须配合相应基座、秩、缩放与注入位置，不能把一份增量随意加到任意模型。

# 怎样用于语言模型

常见做法是选择注意力或前馈网络中的线性投影，保留预训练权重，并插入 LoRA。任务训练还需要正确的 tokenizer、对话模板、目标掩码和验证集。

较少参数可以降低部分成本，却不能消除数据质量问题、过拟合或已有能力的变化。显存还受激活、长度、批次与基座精度影响，不能只用“可训练参数减少多少”推断总内存同比减少。

下方项目人为设置一个秩不超过4的目标变化，再训练秩4适配器。它核对参数量、冻结与合并行为，适合理解机制；不能据其低误差断言真实语言任务都只需要这么低的秩。

# 可复原例程

构造一个已知低秩的目标权重变化，只训练 LoRA 的 A、B 来拟合它；检查冻结权重是否保持不变，以及合并推理是否等价。这是线性层机制验证，不是完整大模型微调。

## 项目目录

```text
模型微调与LoRA-demo/
├── runtime.py  # 统一处理项目路径、随机种子、CPU线程与计算设备
├── model.py  # 为一个冻结线性层添加可训练的低秩增量，并提供合并权重接口
├── main.py  # 用已知秩的目标变化验证 LoRA 的拟合、冻结与合并行为
└── outputs/  # 运行时自动生成，无须手工创建
```

## 环境与文件

先按[[机器学习与人工智能#统一运行环境|统一运行环境]]建立 `ml-ai-notes` 环境。以下每个代码块均为所标文件的完整内容，文件名和大小写应与目录一致。

### `runtime.py`

```python
"""统一处理项目路径、随机种子、CPU线程与计算设备。"""

# 标准库
from pathlib import Path
import argparse
import random

# 第三方库（由统一环境提供）
import numpy as np
import torch

# 1. 路径统一从 runtime.py 所在目录出发，复制项目后无须改绝对路径。
ROOT = Path(__file__).resolve().parent

# outputs/ 存放本项目的图像、指标与模型权重；不存在时自动创建。
OUT = ROOT / "outputs"
OUT.mkdir(exist_ok=True)


def setup():
    """初始化运行环境并返回 torch.device。

    命令行参数只有 --cpu；ROOT、OUT 是导入时建立的项目路径。
    """

    # 2. 读取命令行选项：--cpu 允许在有显卡的机器上仍强制使用 CPU。
    parser = argparse.ArgumentParser()
    parser.add_argument("--cpu", action="store_true")
    args = parser.parse_args()

    # 3. 固定 Python、NumPy 和 PyTorch 的随机种子；跨设备仍不保证逐位相同。
    random.seed(7)
    np.random.seed(7)
    torch.manual_seed(7)

    # 小型教学网络限制 CPU 线程数，避免线程调度开销过大。
    torch.set_num_threads(2)

    # 4. 仅当 CUDA 可用且没有指定 --cpu 时使用 GPU；调用方负责移动模型和数据。
    device = torch.device(
        "cuda" if torch.cuda.is_available() and not args.cpu else "cpu"
    )
    print("device:", device)

    # 返回 torch.device；各入口脚本共用相同的设备选择规则。
    return device
```

### `model.py`

```python
"""为一个冻结线性层添加可训练的低秩增量，并提供合并权重接口。"""

# 标准库
import math

# 第三方库（由统一环境提供）
import torch
from torch import nn


class LoRALinear(nn.Module):
    """为一个冻结线性层添加可训练的低秩增量，并提供合并权重接口。"""

    def __init__(self, base_weight, rank=4, alpha=4):
        """base_weight 是 (cout, cin) 张量；rank 控制低秩中间维度，alpha 控制缩放。"""

        super().__init__()

        # 1. 基座权重按 (输出维, 输入维) 排列，沿用 PyTorch Linear 的存储约定。
        cout, cin = base_weight.shape

        # 建立不带偏置的基座层，再复制外部提供的权重。
        self.base = nn.Linear(cin, cout, bias=False)

        # 不记录这一段的求导图；适用于评价、参数初始化或手动更新。
        with torch.no_grad():
            self.base.weight.copy_(base_weight)

        # 冻结基座：优化过程只应更新 A、B，不应给基座累计梯度。
        self.base.weight.requires_grad_(False)

        # 2. A 为 (rank, 输入维)，先降维；B 为 (输出维, rank)，再升维。
        self.A = nn.Parameter(torch.empty(rank, cin, device=base_weight.device))
        self.B = nn.Parameter(torch.zeros(cout, rank, device=base_weight.device))

        # A 随机、B 为零，使初始增量恰为零；两者都置零会使乘积梯度无法启动。
        nn.init.kaiming_uniform_(self.A, a=math.sqrt(5))

        # alpha/rank 是增量缩放系数，与矩阵秩分开控制。
        self.scale = alpha / rank

    def forward(self, x):
        """输入 (B, cin)，返回 (B, cout)；基座冻结，A、B 保留求导能力。"""

        # 3. 行批量输入先乘 A.T 再乘 B.T；与冻结基座输出相加。
        return self.base(x) + self.scale * (x @ self.A.T @ self.B.T)

    def merged_weight(self):
        """返回 W0 + scale * B@A，不修改原始基座参数。"""

        # 4. 将增量合并进同一权重矩阵，用于检查分支推理与合并推理是否等价。
        return self.base.weight + self.scale * (self.B @ self.A)
```

### `main.py`

```python
"""用已知秩的目标变化验证 LoRA 的拟合、冻结与合并行为。"""

# 标准库
import json

# 第三方库（由统一环境提供）
import torch

# 本项目模块
from model import LoRALinear
from runtime import setup, OUT


def main():
    """用已知秩的目标变化验证 LoRA 的拟合、冻结与合并行为。

    按分段注释依次准备数据、执行计算并保存结果。
    """

    # 1. 初始化设备，设置64×64权重及秩4的适配器。
    device = setup()
    size, rank = 64, 4

    # 2. 生成冻结基座，再人为添加秩不超过4的目标增量，便于验证表达能力。
    base = torch.randn(size, size, device=device) * 0.1
    target = (
        base
        + (
            torch.randn(size, rank, device=device)
            @ torch.randn(rank, size, device=device)
        )
        * 0.03
    )

    # 训练输入为 (512, 64)，目标输出由已知目标矩阵直接计算。
    x = torch.randn(512, size, device=device)
    y = x @ target.T

    # 3. 建立适配器并复制基座快照；快照用于检查训练是否意外改写了基座。
    model = LoRALinear(base, rank).to(device)
    frozen = model.base.weight.detach().clone()

    # 优化器仅接收 A、B；固定权重无需梯度和优化器状态。
    optimizer = torch.optim.Adam([model.A, model.B], lr=0.03)

    # 记录训练前误差，以确认后续变化确实来自适配器学习。
    initial = (model(x) - y).square().mean().item()

    # 4. 最小化适配输出与目标输出的平方误差，共更新500步。
    for step in range(500):
        # 清除上一轮梯度；PyTorch 的 backward 默认会累加到 .grad。
        optimizer.zero_grad()

        # 构造当前批次的标量训练目标，反向传播将从这里开始。
        loss = (model(x) - y).square().mean()

        # 沿计算图计算参数梯度；此时参数数值尚未更新。
        loss.backward()

        # 优化器根据当前梯度真正更新可训练参数。
        optimizer.step()

    # 5. 用新的输入测试目标映射，避免只看训练样本。
    test_x = torch.randn(128, size, device=device)

    # 不记录这一段的求导图；适用于评价、参数初始化或手动更新。
    with torch.no_grad():
        # 分别执行两条支路相加，以及使用已合并的单一矩阵，两者应接近。
        adapted = model(test_x)
        merged = test_x @ model.merged_weight().T
        test_mse = (adapted - test_x @ target.T).square().mean().item()

    # 6. 冻结检查使用逐元素严格相等；另外检查基座没有梯度。
    assert torch.equal(frozen, model.base.weight)
    assert model.base.weight.grad is None

    # 合并涉及不同浮点乘法顺序，因此使用合理容差而非逐位相等。
    assert torch.allclose(adapted, merged, atol=1e-5, rtol=1e-4)

    # 7. 对比512个可训练参数与4096个完整权重参数，并保存误差和适配器。
    report = {
        "trainable_parameters": sum(
            p.numel() for p in model.parameters() if p.requires_grad
        ),
        "full_weight_parameters": size * size,
        "initial_mse": initial,
        "test_mse": test_mse,
        "merge_max_error": (adapted - merged).abs().max().item(),
    }
    print(report)
    (OUT / "metrics.json").write_text(json.dumps(report, indent=2), encoding="utf-8")
    torch.save(
        {
            "A": model.A.detach().cpu(),
            "B": model.B.detach().cpu(),
            "scale": model.scale,
            "base": base.cpu(),
        },
        OUT / "adapter_demo.pt",
    )


if __name__ == "__main__":
    main()
```

## 运行步骤

在 VS Code 中打开项目根目录，选择 `ml-ai-notes` 的 Python 解释器，再在终端执行：

```powershell
# 先激活环境，让下面的 python 使用指定解释器和依赖。
conda activate ml-ai-notes

# 从项目根目录执行主入口，结果将写入本项目的 outputs/。
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
