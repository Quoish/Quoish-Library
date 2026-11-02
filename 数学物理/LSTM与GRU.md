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
updated: 2026-11-02
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
├── runtime.py  # 统一处理项目路径、随机种子、CPU线程与计算设备
├── model.py  # 用统一接口包装 RNN、LSTM 和 GRU，读取序列后输出类别
├── main.py  # 比较三种循环层能否在噪声序列后保留开头的一位信号
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
"""用统一接口包装 RNN、LSTM 和 GRU，读取序列后输出类别。"""

# 第三方库（由统一环境提供）
import torch
from torch import nn


class Remember(nn.Module):
    """用统一接口包装 RNN、LSTM 和 GRU，读取序列后输出类别。"""

    def __init__(self, kind):
        """kind 可取 RNN、LSTM、GRU；各模型从零状态开始读取独立序列。"""

        super().__init__()

        # 按名称选择循环层，三种结构均使用1维输入和24维隐藏状态。
        layer = {
            "RNN": nn.RNN,
            "LSTM": nn.LSTM,
            "GRU": nn.GRU,
        }[kind]

        # batch_first 只改变输入／逐步输出的轴顺序，不改变最终状态的轴顺序。
        self.core = layer(1, 24, batch_first=True)

        # LSTM 专门设置忘记门的初始偏置，减轻训练初期首位信息迅速衰减的问题。
        if kind == "LSTM":
            # 门排列为输入、忘记、候选、输出；提高初始保留倾向。

            # 不记录这一段的求导图；适用于评价、参数初始化或手动更新。
            with torch.no_grad():
                self.core.bias_ih_l0[24:48].fill_(2.0)
                self.core.bias_hh_l0[24:48].zero_()

        # 用最后一个有效时间步的24维表示，输出0/1两类 logits。
        self.head = nn.Linear(24, 2)

    def forward(self, x):
        """输入 (B, T, 1)，返回 (B, 2) logits 和对应结构的最终状态。"""

        # RNN、GRU 的 state 是 h；LSTM 的 state 是 (h, c)。
        sequence, state = self.core(x)

        # 本例所有序列等长且没有填充，故可直接取 [:, -1]；变长填充序列需另行处理。
        return self.head(sequence[:, -1]), state
```

### `main.py`

```python
"""比较三种循环层能否在噪声序列后保留开头的一位信号。"""

# 标准库
import json

# 第三方库（由统一环境提供）
import torch
from torch import nn

# 本项目模块
from model import Remember
from runtime import setup, OUT


def batch(n, device, length=16):
    """返回首位携带类别信号的等长序列及标签；默认长度16。"""

    # 1. 随机生成二分类标签，然后把类别写成首时刻的 -1/+1 信号。
    y = torch.randint(0, 2, (n,), device=device)

    # 其余时间步只有小噪声；任务要求在最后一步回忆首位信息。
    x = 0.05 * torch.randn(n, length, 1, device=device)
    x[:, 0, 0] = y.float() * 2 - 1

    # 输入形状 (n, length, 1)，标签形状 (n,)；分类目标不是序列最后一个噪声值。
    return x, y


def main():
    """比较三种循环层能否在噪声序列后保留开头的一位信号。

    按分段注释依次准备数据、执行计算并保存结果。
    """

    # 2. 初始化设备和结果字典。
    device = setup()
    report = {}

    # 3. 三种模型分别初始化、训练、评价，避免继承上一个模型的权重。
    for kind in ["RNN", "LSTM", "GRU"]:
        torch.manual_seed(7)
        model = Remember(kind).to(device)
        optimizer = torch.optim.Adam(model.parameters(), lr=0.01)

        # 每次更新使用一批新生成的序列，训练共400步。
        for step in range(400):
            x, y = batch(64, device)

            # 清除上一轮梯度；PyTorch 的 backward 默认会累加到 .grad。
            optimizer.zero_grad()

            # 只使用序列末尾得到的分类分数计算损失；state 用于后续结构检查。
            logits, state = model(x)

            # 构造当前批次的标量训练目标，反向传播将从这里开始。
            loss = nn.functional.cross_entropy(logits, y)

            # 沿计算图计算参数梯度；此时参数数值尚未更新。
            loss.backward()

            # 限制全部参数梯度的总范数，缓解梯度爆炸；不改变前向预测。
            torch.nn.utils.clip_grad_norm_(model.parameters(), 1)

            # 优化器根据当前梯度真正更新可训练参数。
            optimizer.step()

        # 切换到评价模式；若含 Dropout／BatchNorm，其行为随之切换。
        model.eval()

        # 不记录这一段的求导图；适用于评价、参数初始化或手动更新。
        with torch.no_grad():
            # 4. 额外生成512条测试序列；不使用训练批次评价记忆效果。
            x, y = batch(512, device)

            # 只使用序列末尾得到的分类分数计算损失；state 用于后续结构检查。
            logits, state = model(x)
            accuracy = (logits.argmax(1) == y).float().mean().item()

        # 5. LSTM 记录 h、c 两个形状；RNN、GRU 各记录一个 h 的形状。
        state_shapes = (
            [list(t.shape) for t in state]
            if isinstance(state, tuple)
            else [list(state.shape)]
        )

        # 将各结构的准确率、训练末次损失和状态尺寸分开记录。
        report[kind] = {
            "test_accuracy": accuracy,
            "last_loss": loss.item(),
            "state_shapes": state_shapes,
        }
        torch.save(model.state_dict(), OUT / (kind + ".pt"))
    print(json.dumps(report, indent=2))
    (OUT / "metrics.json").write_text(json.dumps(report, indent=2), encoding="utf-8")


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

LSTM 应打印两个状态形状，其他模型各一个。随机二分类基线约为0.5，接近1表示在当前长度与噪声下能保留首位信号。若某模型未学会，应检查曲线、种子与训练轮数；一次失败不能推出结构不具备该能力。

## 实测记录

2026-10-25，在[[机器学习与人工智能#统一运行环境|统一运行环境]]中从上述代码块还原项目进行验证。数值与生成结果会受硬件和随机过程影响，不能要求逐位一致。

| 入口 | CPU | CUDA |
|---|---|---|
| `main.py` | 运行通过（24.5秒） | 运行通过（22.2秒） |

CPU 运行的主要观测：首位记忆任务的测试准确率：RNN 1.0000；LSTM 1.0000；GRU 1.0000。LSTM 的隐藏状态与细胞状态均已检查。

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
