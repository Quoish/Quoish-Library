---
title: LSTM与GRU
aliases:
  - 长短期记忆网络
  - 门控循环单元
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

# 门控为何有用

基本 RNN 每一步都对全部状态进行非线性变换。若某些信息需要保留很久，这种反复变换可能破坏信号。门控网络学习“保留多少、写入多少、输出多少”，提供可调节的信息通路。

门通常使用 Sigmoid，输出介于0与1之间，逐元素控制比例。它是连续的可训练权重，不等同于严格的逻辑开关。

# LSTM：细胞状态与隐藏状态

LSTM 维护细胞状态$c_t$和输出隐藏状态$h_t$。将输入与上一步隐藏状态拼接为$u_t=[x_t;h_{t-1}]$，常见无 peephole 形式为

$$
f_t=\sigma(W_fu_t+b_f),\quad i_t=\sigma(W_iu_t+b_i),
$$
$$
o_t=\sigma(W_ou_t+b_o),\quad \tilde c_t=\tanh(W_cu_t+b_c),
$$
$$
c_t=f_t\odot c_{t-1}+i_t\odot\tilde c_t,\quad
h_t=o_t\odot\tanh(c_t).
$$

$\odot$表示逐元素乘法。忘记门$f_t$控制旧细胞状态保留比例；输入门$i_t$控制候选信息写入；输出门$o_t$决定细胞内容以多大比例暴露给隐藏状态。

例如单个维度上$c_{t-1}=2,f_t=0.9,i_t=0.1,\tilde c_t=-1$，新细胞状态为1.7。若长期令$f_t$接近1、$i_t$接近0，则可以在直接路径上持续保留信息。只沿直接细胞路径考察，导数包含忘记门连乘；完整导数还包含门依赖状态的其他路径，因此长期学习仍非无条件保证。

# GRU：合并状态的简化设计

GRU 通常只维护$h_t$，使用重置门$r_t$和更新门$z_t$。与 PyTorch 实现一致的一种形式为

$$
r_t=\sigma(W_{ir}x_t+b_{ir}+W_{hr}h_{t-1}+b_{hr}),
$$
$$
z_t=\sigma(W_{iz}x_t+b_{iz}+W_{hz}h_{t-1}+b_{hz}),
$$
$$
n_t=\tanh(W_{in}x_t+b_{in}+r_t\odot(W_{hn}h_{t-1}+b_{hn})),
$$
$$
h_t=(1-z_t)\odot n_t+z_t\odot h_{t-1}.
$$

在这一约定下，$z_t$越接近1，越保留旧状态。不同资料可能对更新门采用相反的命名约定；部分原始形式将重置门放在隐藏状态矩阵乘法之前，与 PyTorch 候选状态公式有差异。

# 结构选择与使用细节

相同隐藏维度下，LSTM 通常比 GRU 有更多门和参数。两者的效果依赖任务、数据与超参数，不能仅凭结构复杂程度排序。序列填充会影响最终状态，应采用真实长度索引或打包序列；变长序列不能直接把所有样本的最后填充位置当成有效结束。

LSTM 的状态是`(h, c)`，GRU 和普通 RNN 的状态是`h`。若分段处理连续序列，需要明确何时保留状态、何时重置、何时切断计算图。本例每个样本独立，状态在每次前向开始时重置。

# 可复原例程

训练 RNN、LSTM、GRU 记住序列开头的一位信号，经过若干噪声步后再分类。固定输入长度，比较训练损失和独立测试准确率。LSTM 将忘记门的初始总偏置设为2，使训练开始时更倾向于保留信息；这是优化配置的一部分，比较结果不能全部归因于架构本身。

## 项目目录

```text
LSTM与GRU-demo/
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
import torch
from torch import nn

class Remember(nn.Module):
    def __init__(self, kind):
        super().__init__()
        layer = {"RNN": nn.RNN, "LSTM": nn.LSTM, "GRU": nn.GRU}[kind]
        self.core = layer(1, 24, batch_first=True)
        if kind == "LSTM":
            # 门排列为输入、忘记、候选、输出；提高初始保留倾向。
            with torch.no_grad():
                self.core.bias_ih_l0[24:48].fill_(2.0)
                self.core.bias_hh_l0[24:48].zero_()
        self.head = nn.Linear(24, 2)

    def forward(self, x):
        sequence, state = self.core(x)
        return self.head(sequence[:, -1]), state
```

### `main.py`

```python
import json
import torch
from torch import nn
from model import Remember
from runtime import setup, OUT

def batch(n, device, length=16):
    y = torch.randint(0, 2, (n,), device=device)
    x = 0.05 * torch.randn(n, length, 1, device=device)
    x[:, 0, 0] = y.float() * 2 - 1
    return x, y

def main():
    device = setup()
    report = {}
    for kind in ["RNN", "LSTM", "GRU"]:
        torch.manual_seed(7)
        model = Remember(kind).to(device)
        optimizer = torch.optim.Adam(model.parameters(), lr=0.01)
        for step in range(400):
            x, y = batch(64, device)
            optimizer.zero_grad()
            logits, state = model(x)
            loss = nn.functional.cross_entropy(logits, y)
            loss.backward()
            torch.nn.utils.clip_grad_norm_(model.parameters(), 1)
            optimizer.step()
        model.eval()
        with torch.no_grad():
            x, y = batch(512, device)
            logits, state = model(x)
            accuracy = (logits.argmax(1) == y).float().mean().item()
        state_shapes = [list(t.shape) for t in state] if isinstance(state, tuple) else [list(state.shape)]
        report[kind] = {"test_accuracy": accuracy, "last_loss": loss.item(),
                        "state_shapes": state_shapes}
        torch.save(model.state_dict(), OUT / (kind + ".pt"))
    print(json.dumps(report, indent=2))
    (OUT / "metrics.json").write_text(json.dumps(report, indent=2), encoding="utf-8")

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

LSTM 应打印两个状态形状，其他模型各一个。随机二分类基线约为0.5，接近1表示在当前长度与噪声下能保留首位信号。若某模型未学会，应检查曲线、种子与训练轮数；一次失败不能推出结构不具备该能力。

## 小实验

- 将序列长度由16增至64，观察长期依赖训练的难度。
- 增加中间噪声，比较门控与普通 RNN。
- 分别改变隐藏维度和训练步数，避免把参数量差异混同于架构优势。

# 关联阅读

- [[循环神经网络]]
- [[残差网络]]
- [[Transformer]]

# 参考资料

- [LSTM 原论文](https://www.bioinf.jku.at/publications/older/2604.pdf)
- [GRU：RNN Encoder–Decoder](https://arxiv.org/abs/1406.1078)
- [PyTorch：GRU 公式与实现差异](https://pytorch.org/docs/2.2/generated/torch.nn.GRU.html)
