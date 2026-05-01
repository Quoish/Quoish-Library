#微分几何 #抽象代数 
# Lie群
>若$G$既是$n$维（实）流形又是群，且群上定义的乘法、求逆运算都是光滑的，则称$G$是一个$n$维（实）*Lie群*。

- $\mathbb{R}$和加法构成一个Lie群。
- $\mathbb{R}$和$\mathbb{R}$的直积群$\mathbb{R}^2$构成一个Lie群，从而$\mathbb{R}^n$都是Lie群。
- 设$\phi:\mathbb{R}\times M\to M$是$M$上的任意单参数微分同胚群，则$\{ \phi_{t}|t \in \mathbb{R} \}$是1维Lie群，同构于$\mathbb{R}$。
- $(M,g_{ab})$上的等度规映射关于映射乘法构成一个群，称为*等度规群*，并且是Lie群。

Minkowski空间的等度规群是10维Lie群。有多少个Killing矢量场就对应着多少维的Lie群。
## Lie群同态和同构
>设$G$和$G'$是两个Lie群，如果$G$到$G'$存在一个映射$\sigma$，使得$$\forall a,b\in G,\quad \sigma(ab)=\sigma(a)\sigma(b)$$并且$\sigma \in C^{\infty}$，则称$\sigma$是*Lie群同态*。

>设$G$和$G'$是两个Lie群，如果$G$到$G'$存在一个双射$\sigma$，使得$$\forall a,b\in G,\quad \sigma(ab)=\sigma(a)\sigma(b)$$并且$\sigma$是微分同胚（$\sigma ,\sigma^{-1} \in C^{\infty}$），则称$\sigma$是*Lie群同构*。


设$G,G'$是两个Lie群，若存在映射$\mu:G\to G'$，满足：
1. 保群乘法：$\mu(a\cdot b)=\mu(a)\cdot \mu(b),\forall a,b \in G$。
2. 光滑：$\mu \in C^{\infty}$。
则称$\mu$是Lie群*同态*。
