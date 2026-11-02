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

# 核心图景：为状态增加可学习的保留与写入比例

普通 RNN 反复改写整个状态，较早信息可能在多次变换后衰减。LSTM 和 GRU 让网络根据当前输入与旧状态，决定**保留多少、引入多少、对外暴露多少**。

“门”通常是 Sigmoid 的输出，介于0和1之间。它按特征维度控制比例，是可连续调节的量，并非必须取开或关两个值。标量形式为$\sigma(a)=1/(1+e^{-a})$：输入0得到0.5，较大正值接近1，较大负值接近0。候选内容使用的$\tanh$则把数值压到$(-1,1)$，允许写入正、负信息。

# 问题域与发展背景

语音、文字与时间序列经常需要把一个事件的影响保留到很远的位置。普通循环网络中梯度沿时间连乘，早期事件即使影响最终答案，也可能得不到足够的调整信号。

Hochreiter 与 Schmidhuber 的[LSTM，1997](https://pubmed.ncbi.nlm.nih.gov/9377276/)围绕长期信用分配与状态传播设计记忆单元。后续[Learning to forget，2000](https://pubmed.ncbi.nlm.nih.gov/11032042/)进一步引入忘记机制以处理持续输入。这里给出的是常见的带忘记门形式，不能把所有门都直接归到最初版本。

2014年[Cho 等的编码器—解码器工作](https://arxiv.org/abs/1406.1078)引入了后来常称 GRU 的门控单元。它用更少的状态与门来组织保留和更新。二者是不同的结构折中，较晚提出不意味着在所有数据上更好。

# LSTM 为什么有两份状态

LSTM 常同时维护：

- **细胞状态$c_t$**：内部记忆通路，通过加法与门控逐步更新。
- **隐藏状态$h_t$**：当前对外输出的表示，也参与下一步门的计算。

可以把$c_t$类比为持续修改的工作记录，$h_t$类比为当前从记录中拿出来给下游用的摘要。这个类比帮助区分职责，不代表状态每一维都能对应一个明确的人类概念。

# 把一次 LSTM 更新拆开

先拼接当前输入与旧隐藏状态，记$u_t=[x_t;h_{t-1}]$。四组投影分别产生三个门和一份候选记忆：

$$
f_t=\sigma(W_fu_t+b_f),\quad i_t=\sigma(W_iu_t+b_i),
$$
$$
o_t=\sigma(W_ou_t+b_o),\quad \tilde c_t=\tanh(W_cu_t+b_c).
$$

随后更新：

$$
c_t=f_t\odot c_{t-1}+i_t\odot\tilde c_t,\quad
h_t=o_t\odot\tanh(c_t).
$$

$\odot$是逐元素乘法。按计算顺序阅读：

1. 忘记门$f_t$给旧记忆乘一个保留比例。
2. 输入门$i_t$给候选内容乘一个写入比例。
3. 两部分相加得到新记忆。
4. 输出门$o_t$决定哪些内容以多大比例进入当前隐藏表示。

若输入$x_t$有$d$维，隐藏状态和细胞状态各有$m$维，则拼接的$u_t$有$d+m$维；每个$W$都是$m\times(d+m)$，偏置和各门均有$m$维。门控作用在记忆的各个分量上，并非整条序列共用一个标量开关。这些门各自独立，不要求$f_t+i_t=1$。

# 单个维度的手算

若旧记忆为2，忘记门0.9、输入门0.1、候选内容$-1$，则

$$
c_t=0.9\times2+0.1\times(-1)=1.7.
$$

若输出门为0.5，隐藏输出约为$0.5\tanh(1.7)\approx0.468$。内部记忆与对外隐藏状态的数值、作用都不同。

若一段时间内忘记门固定接近1、写入接近0，就可以较少改写地保留旧内容。只看直接记忆路径，固定保留比例0.5经过20步约剩$9.54\times10^{-7}$，比例0.99则约剩0.818。这展示了门控提供的调节空间。

完整梯度还经过门本身对状态的依赖等其他路径，门也需要从任务中学会何时开合。因此“有 LSTM”不能保证任意长的依赖都能学好。

# GRU 如何合并记忆职责

GRU 通常只维护一个$h_t$，主要有重置门$r_t$、更新门$z_t$和候选状态$n_t$。与 PyTorch 一致的常见实现为

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

先看最后一式：它在候选状态与旧状态之间作逐维混合。在这一约定中，$z_t$接近1就更保留旧值。若旧值2、候选$-1$、$z_t=0.9$，新值同样为1.7。

重置门影响**候选状态怎样使用过去**。即便$r_t$很小，最终混合中的旧状态仍可能通过$z_t$保留，所以不能把重置门理解成清空整个记忆的统一按钮。

不同资料可能对更新门采用相反约定；原始及其他实现也可能先对旧状态作重置再乘矩阵。比较公式时应核对乘法顺序，不能只看相同的门名称。

# LSTM 与 GRU 的比较

| 方面 | LSTM | GRU |
|---|---|---|
| 状态 | 隐藏状态$h$与细胞状态$c$ | 通常只有$h$ |
| 门与候选 | 三个主要门及候选内容 | 两个主要门及候选状态 |
| 同隐藏维度下的参数规模 | 通常较多 | 通常较少 |
| 任务效果 | 依赖数据、初始化和训练配置 | 同样需要实际比较 |

门多提供了控制自由度，也增加计算和优化对象。真正应用时需考虑序列长度、噪声、样本量、资源与评价方式。

# 从门控走向直接访问

门控改进了状态的保存与更新，但仍把过去持续压入有限维状态。长句翻译等任务还需要按当前需要访问某个较早位置，于是出现[[注意力机制]]这样的另一条思路。Transformer 又进一步改变了序列交互的组织方式。

RNN 家族仍有逐步读入、状态大小固定等特点，适合不少流式任务；注意力与循环也可以组合。

# 阅读例程时的检查点

本例在首位放入类别信号，后面加入噪声，到最后再分类。状态在独立样本之间重置。LSTM 返回$(h,c)$，另两种结构返回$h$；相同维度并不意味着参数量完全一致。

例程还设置了 LSTM 忘记门的初始偏置，这会影响训练起点。若把比较结果归因于架构本身，应同时考虑这种优化配置。变长序列带填充时，也不能直接把最后一个填充位置当成有效结尾。

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
