---
title: Transformer
aliases:
  - 变换器架构
  - Encoder-Decoder Transformer
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

# 核心图景：位置之间交流，再逐位置加工

Transformer 块的两个主要工作是：**注意力让不同位置交换信息，前馈网络对每个位置的表示做非线性加工**。残差连接保留原有表示，归一化组织信号尺度，位置机制补充顺序信息。

整条数据路线可以记为：词元编号 → 嵌入与位置 → 多个计算块 → 任务输出头。它仍然是通过损失与梯度训练的网络，不是仅靠一个注意力公式就自动工作的系统。

# 问题域与提出背景

机器翻译等任务既要处理长距离关系，也要有效利用并行计算。RNN／LSTM 按时间递推，同一序列的下一状态要等上一状态；早期注意力缓解了固定摘要瓶颈，但循环计算仍然存在。

2017年的[Attention Is All You Need](https://arxiv.org/abs/1706.03762)用注意力组织序列交互，提出编码器—解码器 Transformer。其改动不是只把网络加深，而是改变位置之间传递信息的方式。前馈网络、残差和归一化等组件也共同参与工作。

后来仅编码器、仅解码器等结构分别服务于理解、表征与生成。原始翻译架构和生成式语言模型采用的结构，需要明确区分。

# 嵌入之后，为什么还需要位置

词元编号查表得到$d$维向量。将$T$个位置按行堆叠，得到$T\times d$矩阵。只依赖内容的注意力不会自动知道“谁先谁后”，而语序往往影响含义。

原始正弦位置编码为

$$
\operatorname{PE}(p,2i)=\sin\left(p/10000^{2i/d}\right),\quad
\operatorname{PE}(p,2i+1)=\cos\left(p/10000^{2i/d}\right).
$$

$p$是位置，$i$编号一对正弦／余弦分量。不同频率描述不同尺度的位置变化。例如首对分量在位置0为$[0,1]$，位置1约为$[0.841,0.540]$。

原始模型将缩放后的词嵌入与位置向量相加。相加保持隐藏维度固定，是需要模型在训练中利用的一种融合安排；不能据此保证任意两类向量都能被唯一分离。

学习式位置嵌入直接训练位置表；RoPE 对查询和键作与位置有关的旋转。后者并不等于在输入端简单相加。下方微型项目使用学习式位置表，属于具体变体。

# 用一次形状追踪看懂多头注意力

假设序列有4个词元，隐藏维度8，使用2个头，每头查询／键／值维度均为4，暂时省略批次维：

| 步骤 | 形状变化 |
|---|---|
| 输入表示 | $4\times8$ |
| 每头投影 Q/K/V | 各为$4\times4$ |
| 每头计算$QK^T$ | $4\times4$的位置关系矩阵 |
| 行 Softmax 后乘 V | 每头输出$4\times4$ |
| 拼接两个头 | $4\times8$ |
| 输出投影 | 仍为$4\times8$ |

注意力矩阵的两条轴都对应序列位置，不能把它与8维隐藏特征混为一谈。保留多个头，使网络可以在多种投影下组织关系。

# 前馈网络为什么放在注意力后面

注意力已经汇入其他位置的信息，还需要对每个位置的新内容做特征组合。常见前馈形式为

$$
\operatorname{FFN}(x)=\phi(xW_1+b_1)W_2+b_2.
$$

例如隐藏维度8、中间维度32：先8→32，经过 ReLU／GELU 等非线性，再32→8。每个位置独立执行同一组权重，因此它负责位置内的非线性变换，位置间的交流主要由注意力承担。

升维提供更多可训练的组合容量，不保证仅因处于高维就更容易学好。降回8维还使输出可以与原输入相加。

# 残差与归一化怎样拼成一个块

忽略 Dropout 等细节，原始典型 Post-LN 写成

$$
U=\operatorname{LN}(X+\operatorname{MHA}(X)),\quad
Y=\operatorname{LN}(U+\operatorname{FFN}(U)).
$$

常见 Pre-LN 形式则为

$$
U=X+\operatorname{MHA}(\operatorname{LN}(X)),\quad
Y=U+\operatorname{FFN}(\operatorname{LN}(U)).
$$

两者都包含残差相加，但归一化位置不同，优化行为也可能不同。LayerNorm 在典型文本块中对每个位置的隐藏特征维计算统计；具体作用见[[神经网络优化与泛化]]。

下方例程采用 Pre-LN。对照公式时，应先定位子层前后的归一化与相加位置，而不能只根据模块名称推定顺序。

# 三种架构怎样对应任务

| 架构 | 可见信息与计算 | 常见用途 |
|---|---|---|
| 仅编码器 | 输入内可双向交流 | 分类、上下文表示、检索编码 |
| 仅解码器 | 因果自注意力，只看当前及过去 | 下一词元生成 |
| 编码器—解码器 | 编码器处理源输入，解码器因果生成并查询源表示 | 翻译、摘要等条件生成 |

交叉注意力中，查询来自解码器当前表示，键和值来自编码器输出。源长和目标长可以不同，注意力矩阵形状相应为“目标位置数×源位置数”。各层通常拥有自己的可训练投影。

# 为什么训练能并行，生成仍常逐步进行

训练时，完整参考序列已经给出。把输入与目标错开一位，再加因果掩码，可以一次计算所有位置的下一词元损失。并行的是**已知输入位置的计算**，掩码仍限制了每个位置的信息。

生成时，新的词元还没有产生，需要先选出下一个，再追加到前缀。KV cache 保存各层过去位置的键和值，减少反复计算，但不会把尚未生成的未来变成已知。

# 长距离交互的收益与代价

单层注意力允许两个远位置直接建立联系，减少了像 RNN 那样沿很多步传递的路径。普通密集注意力同时需要两两打分，其核心计算随$T^2d$增长，分数矩阵规模随$T^2$增长；投影和前馈也有额外成本。

更长窗口、较短交互路径或更大模型，都不自动保证事实性、推理可靠性和无限记忆。训练目标、数据与位置处理仍然重要。

下方项目用形状与因果性断言核对结构，并完成一次下一词元反向传播。完整的微型训练与生成流程见[[大语言模型的训练与生成]]。

# 可复原例程

实现一个带学习式位置嵌入的 Pre-LN 因果 Transformer 块。检查多头权重形状、未来掩码、前缀不变性，并完成一次下一词元损失的反向传播。

## 项目目录

```text
Transformer-demo/
├── runtime.py  # 统一处理项目路径、随机种子、CPU线程与计算设备
├── model.py  # 实现带学习式位置嵌入和 Pre-LN 残差块的微型因果 Transformer
├── main.py  # 检查 Transformer 的形状、因果前缀与一次下一词元训练更新
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
"""实现带学习式位置嵌入和 Pre-LN 残差块的微型因果 Transformer。"""

# 第三方库（由统一环境提供）
import torch
from torch import nn


class TinyTransformer(nn.Module):
    """实现带学习式位置嵌入和 Pre-LN 残差块的微型因果 Transformer。"""

    def __init__(self, vocab=16, dim=32, heads=4, max_length=32):
        """vocab 为词表大小；dim 为隐藏维度；heads 为头数；max_length 限制位置表长度。"""

        super().__init__()

        # 1. 词元编号映射为 dim 维向量；位置表具有相同维度，可以逐元素相加。
        self.token = nn.Embedding(vocab, dim)
        self.position = nn.Embedding(max_length, dim)

        # 2. 两个 LayerNorm 分别位于注意力和前馈子层之前，即 Pre-LN。
        self.norm1, self.norm2 = nn.LayerNorm(dim), nn.LayerNorm(dim)

        # 多头自注意力内部完成 Q/K/V 投影；dim 必须能被 heads 整除。
        self.attn = nn.MultiheadAttention(dim, heads, dropout=0, batch_first=True)

        # 前馈网络逐位置共享：dim → 64 → dim，以便与残差相加。
        self.ffn = nn.Sequential(
            nn.Linear(dim, 64),
            nn.GELU(),
            nn.Linear(64, dim),
        )

        # 3. 最后归一化并投影到词表，为每个位置产生下一词元 logits。
        self.final_norm = nn.LayerNorm(dim)
        self.head = nn.Linear(dim, vocab)

    def forward(self, ids):
        """输入整数编号 (B, T)，返回每位置词表 logits 与各头注意力权重。"""

        # 输入 ids 为 (B, T)；位置索引按序列长度创建，不在批次之间分别学习。
        length = ids.shape[1]

        # 词元和位置向量广播相加，得到 (B, T, dim)。
        x = self.token(ids) + self.position(torch.arange(length, device=ids.device))

        # 布尔上三角屏蔽未来；此处 True 的含义是该位置禁止被关注。
        mask = torch.ones(length, length, device=ids.device, dtype=torch.bool).triu(1)

        # 4. 先归一化，再用同一序列构造 Q、K、V。
        normalized = self.norm1(x)

        # 保留各个头的权重，形状 (B, heads, T, T)，便于可视化或掩码检查。
        mixed, weights = self.attn(
            normalized,
            normalized,
            normalized,
            attn_mask=mask,
            need_weights=True,
            average_attn_weights=False,
        )

        # 第一条残差连接：注意力只提供对原表示的增量。
        x = x + mixed

        # 第二条残差连接：前馈变换仍保持隐藏维度不变。
        x = x + self.ffn(self.norm2(x))

        # 最终返回 (B, T, vocab) logits 和全部头的注意力矩阵。
        return self.head(self.final_norm(x)), weights
```

### `main.py`

```python
"""检查 Transformer 的形状、因果前缀与一次下一词元训练更新。"""

# 标准库
import json

# 第三方库（由统一环境提供）
import torch
from torch import nn

# 本项目模块
from model import TinyTransformer
from runtime import setup, OUT


def main():
    """检查 Transformer 的形状、因果前缀与一次下一词元训练更新。

    按分段注释依次准备数据、执行计算并保存结果。
    """

    # 1. 初始化模型，词表默认包含16个词元编号。
    device = setup()
    model = TinyTransformer().to(device)

    # 2. 构造两个长度6的序列，形状 (2, 6)，元素必须是合法词元编号。
    ids = torch.tensor([[1, 2, 3, 4, 5, 6], [2, 4, 6, 8, 10, 12]], device=device)

    # 复制序列后只修改第4、5号位置，前4个词元保持不变。
    changed = ids.clone()
    changed[:, 4:] = 15

    # 切换到评价模式；若含 Dropout／BatchNorm，其行为随之切换。
    model.eval()

    # 不记录这一段的求导图；适用于评价、参数初始化或手动更新。
    with torch.no_grad():
        # 3. 先在评价模式检查：改变未来词元不能影响前4个位置的 logits。
        before, weights = model(ids)
        after, _ = model(changed)

    # 前缀输出最大差异应在浮点容差内；不检查已经被修改的位置。
    difference = (before[:, :4] - after[:, :4]).abs().max().item()
    assert difference < 1e-5

    # 检查每个头的严格上三角权重都为零，直接验证掩码方向。
    assert (
        weights[..., torch.ones(6, 6, dtype=torch.bool, device=device).triu(1)]
        .abs()
        .max()
        .item()
        < 1e-6
    )

    # 4. 切回训练模式，进行一次真实的梯度更新。
    model.train()
    optimizer = torch.optim.Adam(model.parameters(), lr=0.001)

    # 清除上一轮梯度；PyTorch 的 backward 默认会累加到 .grad。
    optimizer.zero_grad()

    # 输入取前5个词元，目标取后5个词元，形成相差一个位置的预测任务。
    logits, _ = model(ids[:, :-1])

    # 将批次和时间维合并为样本维，交叉熵仍以16类词表 logits 为输入。
    loss = nn.functional.cross_entropy(logits.reshape(-1, 16), ids[:, 1:].reshape(-1))

    # 沿计算图计算参数梯度；此时参数数值尚未更新。
    loss.backward()

    # 优化器根据当前梯度真正更新可训练参数。
    optimizer.step()

    # 5. 保存形状、前缀差异、单步损失及权重；一次更新不表示已经学会序列规律。
    report = {
        "logits_shape": list(before.shape),
        "attention_shape": list(weights.shape),
        "prefix_difference": difference,
        "one_step_loss": loss.item(),
    }
    print(report)
    (OUT / "metrics.json").write_text(json.dumps(report, indent=2), encoding="utf-8")
    torch.save(model.state_dict(), OUT / "transformer.pt")


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

logits 形状应为 `(2, 6, 16)`，四头注意力权重为 `(2, 4, 6, 6)`，前缀差异应接近0。一次反向传播仅验证结构与损失连接正确，不表示模型已经掌握序列规律。完整微型语言模型训练见下一篇。

## 实测记录

2026-10-25，在[[机器学习与人工智能#统一运行环境|统一运行环境]]中从上述代码块还原项目进行验证。数值与生成结果会受硬件和随机过程影响，不能要求逐位一致。

| 入口 | CPU | CUDA |
|---|---|---|
| `main.py` | 运行通过（12.1秒） | 运行通过（12.0秒） |

CPU 运行的主要观测：logits 形状 [2, 6, 16]，注意力权重形状 [2, 4, 6, 6]；前缀差异 0，下一词元损失完成反向传播。

## 小实验

- 修改头数为2或8，检查形状；隐藏维度必须能被头数整除。
- 移除位置嵌入，比较模型对顺序的表达。
- 将 Pre-LN 改为 Post-LN，逐行对照公式。

# 关联阅读

- [[注意力机制]]
- [[残差网络]]
- [[大语言模型的训练与生成]]

# 参考资料

- [Attention Is All You Need](https://arxiv.org/abs/1706.03762)
- [PyTorch：MultiheadAttention](https://pytorch.org/docs/2.2/generated/torch.nn.MultiheadAttention.html)
- [RoFormer：旋转位置编码](https://arxiv.org/abs/2104.09864)
