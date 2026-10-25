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
updated: 2026-10-25
---

导航：[[机器学习与人工智能]]

# 将序列交互与逐位置变换组合起来

Transformer 用注意力进行位置之间的信息交互，用前馈网络变换每个位置的特征，并用残差与归一化组织深层计算。原始2017年架构是编码器—解码器翻译模型；后续发展出仅编码器与仅解码器等结构。

理解它可以沿数据流推进：词元编号进入嵌入层，叠加或引入位置信息，经过多个块得到上下文表示，最后由任务头输出分类分数或下一词元概率。

# 输入表示与位置信息

长度$T$的词元序列查表后得到$X\in\mathbb R^{T\times d}$。原始正弦位置编码使用

$$
\operatorname{PE}(p,2i)=\sin(p/10000^{2i/d}),\quad
\operatorname{PE}(p,2i+1)=\cos(p/10000^{2i/d}).
$$

原始输入可写作$X=\sqrt d E+\operatorname{PE}$。加和是一种固定维度的融合方式，需要模型在训练中利用这些信号；不能保证对任意词向量与位置向量都能唯一分离。学习式位置嵌入和旋转位置编码 RoPE 是其他选择。RoPE 作用于查询和键的分量旋转，不等同于把位置向量加到输入上。

# 一个块中的计算

以常见 Pre-LN 形式为例：

$$
U=X+\operatorname{MHA}(\operatorname{LN}(X)),\quad
Y=U+\operatorname{FFN}(\operatorname{LN}(U)).
$$

原论文采用子层后归一化，即 Post-LN。两者的位置和优化行为不同，阅读实现时要明确约定。残差要求子层输入输出的隐藏维度一致。

前馈网络对每个位置共享同一组权重：

$$
\operatorname{FFN}(x)=\phi(xW_1+b_1)W_2+b_2.
$$

$W_1$把$d$映射为$d_{ff}$，$W_2$映射回$d$。扩大中间维度提供更多非线性组合的容量，效果依赖训练，不应解释为高维空间自动解决问题。现代模型常使用 GELU、SwiGLU 等变体。

# 编码器与解码器

| 架构 | 注意力可见范围 | 常见用途 |
|---|---|---|
| 仅编码器 | 可访问输入的前后位置 | 文本分类、表征、检索编码 |
| 仅解码器 | 因果掩码，只访问当前及过去 | 自回归生成 |
| 编码器—解码器 | 编码器双向；解码器因果并交叉查询编码器 | 翻译、条件生成 |

交叉注意力的$Q$来自解码器，$K,V$来自编码器输出，但并非只有一组静态投影在模型外计算：通常每个交叉注意力层各自拥有可训练投影。

# 训练、生成与复杂度

因果模型训练时，所有输入位置已知，可以用掩码并行计算各位置损失；生成时新的词元尚不存在，通常逐步采样。教师强制与时间移位标签确保位置$t$预测$t+1$。KV cache 在生成时复用历史键值，减少重复计算，但会占用缓存内存。

标准注意力的两两分数随$T^2$增长；前馈部分也有显著计算成本。Transformer 的长距离交互路径短，不意味着无限长上下文或稳定事实推理能力。实际能力还依赖训练目标、数据与规模。

# 可复原例程

实现一个带学习式位置嵌入的 Pre-LN 因果 Transformer 块。检查多头权重形状、未来掩码、前缀不变性，并完成一次下一词元损失的反向传播。

## 项目目录

```text
Transformer-demo/
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

class TinyTransformer(nn.Module):
    def __init__(self, vocab=16, dim=32, heads=4, max_length=32):
        super().__init__()
        self.token = nn.Embedding(vocab, dim)
        self.position = nn.Embedding(max_length, dim)
        self.norm1, self.norm2 = nn.LayerNorm(dim), nn.LayerNorm(dim)
        self.attn = nn.MultiheadAttention(dim, heads, dropout=0, batch_first=True)
        self.ffn = nn.Sequential(nn.Linear(dim, 64), nn.GELU(), nn.Linear(64, dim))
        self.final_norm = nn.LayerNorm(dim)
        self.head = nn.Linear(dim, vocab)

    def forward(self, ids):
        length = ids.shape[1]
        x = self.token(ids) + self.position(torch.arange(length, device=ids.device))
        mask = torch.ones(length, length, device=ids.device, dtype=torch.bool).triu(1)
        normalized = self.norm1(x)
        mixed, weights = self.attn(normalized, normalized, normalized,
            attn_mask=mask, need_weights=True, average_attn_weights=False)
        x = x + mixed
        x = x + self.ffn(self.norm2(x))
        return self.head(self.final_norm(x)), weights
```

### `main.py`

```python
import json
import torch
from torch import nn
from model import TinyTransformer
from runtime import setup, OUT

def main():
    device = setup()
    model = TinyTransformer().to(device)
    ids = torch.tensor([[1, 2, 3, 4, 5, 6], [2, 4, 6, 8, 10, 12]], device=device)
    changed = ids.clone()
    changed[:, 4:] = 15
    model.eval()
    with torch.no_grad():
        before, weights = model(ids)
        after, _ = model(changed)
    difference = (before[:, :4] - after[:, :4]).abs().max().item()
    assert difference < 1e-5
    assert weights[..., torch.ones(6, 6, dtype=torch.bool, device=device).triu(1)].abs().max().item() < 1e-6
    model.train()
    optimizer = torch.optim.Adam(model.parameters(), lr=0.001)
    optimizer.zero_grad()
    logits, _ = model(ids[:, :-1])
    loss = nn.functional.cross_entropy(logits.reshape(-1, 16), ids[:, 1:].reshape(-1))
    loss.backward()
    optimizer.step()
    report = {"logits_shape": list(before.shape), "attention_shape": list(weights.shape),
              "prefix_difference": difference, "one_step_loss": loss.item()}
    print(report)
    (OUT / "metrics.json").write_text(json.dumps(report, indent=2), encoding="utf-8")
    torch.save(model.state_dict(), OUT / "transformer.pt")

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

logits 形状应为 `(2, 6, 16)`，四头注意力权重为 `(2, 4, 6, 6)`，前缀差异应接近0。一次反向传播仅验证结构与损失连接正确，不表示模型已经掌握序列规律。完整微型语言模型训练见下一篇。

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
