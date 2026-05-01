#微分几何 #抽象代数 
# Lie群
>若$G$既是$n$维（实）流形又是群，且群上定义的乘法、求逆运算都是光滑的，则称$G$是一个$n$维（实）*Lie群*。

这里只讨论有限为Lie群，虽然很多结论对无限维Lie群也适用。
- $\mathbb{R}$和加法构成一个Lie群。
- $\mathbb{R}$和$\mathbb{R}$的直积群$\mathbb{R}^2$构成一个Lie群，从而$\mathbb{R}^n$都是Lie群。
- 设$\phi:\mathbb{R}\times M\to M$是$M$上的任意单参数微分同胚群，则$\{ \phi_{t}|t \in \mathbb{R} \}$是1维Lie群，同构于$\mathbb{R}$。
- $(M,g_{ab})$上的等度规映射关于映射乘法构成一个群，称为*等度规群*，并且是Lie群。

Minkowski空间的等度规群是10维Lie群。有多少个Killing矢量场就对应着多少维的Lie群。

>设$G$和$G'$是两个Lie群，如果$G$到$G'$存在一个映射$\sigma$，使得$$\forall a,b\in G,\quad \sigma(ab)=\sigma(a)\sigma(b)$$并且$\sigma \in C^{\infty}$，则称$\sigma$是*Lie群同态*。

>设$G$和$G'$是两个Lie群，如果$G$到$G'$存在一个双射$\sigma$，使得$$\forall a,b\in G,\quad \sigma(ab)=\sigma(a)\sigma(b)$$并且$\sigma$是微分同胚（$\sigma ,\sigma^{-1} \in C^{\infty}$），则称$\sigma$是*Lie群同构*。

>若$H$既是$G$的子流形，又是$G$的子群，则称$H$是*Lie子群*（Lie Subgroup）。

>$\forall g \in G$，映射$L_{g}:h\mapsto gh$，$\forall h \in G$，称为由$g$生成的*左平移*（Left Translation）。

左平移有如下性质：
- $L_{e}$是恒等映射。
- $L_{gh}=L_{g}\circ L_{h},\forall g,h \in G$。
- $L_{g}^{-1}=L_{g^{-1}}$。
- $L_{g}$是个微分同胚。

>若$G$上的矢量场$\mathbf{A}$满足$$L_{g*}\mathbf{A}=\mathbf{A}$$其中$L_{g*}$是由$L_{g}$诱导的推前映射，则称$\mathbf{A}$是*左不变的*（Left Invariant）。

- 左不变矢量场一定是光滑的。
- $\mathbf{A}$是左不变矢量场的充要条件是$$\mathbf{A}|_{gh}=(L_{g*}\mathbf{A})|_{gh}=L_{g*}(\mathbf{A}|_{h})$$

左不变矢量场乘上常数仍是左不变矢量场，左不变矢量场与左不变矢量场求和也仍是左不变矢量场，所以$G$上全体左不变矢量场构成一个线性空间$\mathcal{L}$。
- $G$上全体左不变矢量场的集合$\mathcal{L}$与$G$的恒等元$e$的切空间$V_{e}$同构。
证明：对任意一个矢量$A \in V_{e}$，用下面的方式定义左不变矢量场$\mathbf{A}$：$$\mathbf{A}|_{g}:= L_{g*}A,\quad \forall g \in G$$然后$$\mathbf{A}|_{gh}=L_{gh*}A=(L_{g*}\circ L_{h*})A=L_{g*}A|_{h}$$故而是左不变矢量场，之后可证明它是双射并且保运算，因此同构。
# Lie代数
设$V$是域$F$上的一个线性空间，定义一种运算称为*Lie括号*$[\cdot,\cdot]:V\times V\to V$，其满足：
1. 反对称性：$[A,B]=-[B,A],\forall A,B \in V$。
2. Jacobi恒等式：$[A,[B,C]]+[B,[C,A]]+[C,[A,B]]=0,\forall A,B,C \in V$。

则称定义了Lie括号的线性空间为*Lie代数*。任意两个元素的Lie括号都为零的Lie代数称为*Abel Lie代数*。
这里只讨论有限维线性空间的Lie代数，虽然很多结论对无限维Lie代数也适用。
- $\mathbb{R}^3$是线性空间，若定义Lie括号为$$[\vec{a},\vec{b}]:=\vec{a}\times \vec{b},\forall \vec{a},\vec{b} \in \mathbb{R}^3$$则$\mathbb{R}^3$是一个Lie代数。
- 域$F$上的全体$n$阶矩阵$M_{n}(F)$是$n^2$维线性空间，若在其上定义Lie括号为$$[A,B]:= AB-BA,\quad \forall A,B \in M_{n}(F)$$则
