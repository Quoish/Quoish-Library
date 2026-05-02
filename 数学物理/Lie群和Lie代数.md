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
- 域$F$上的全体$n$阶矩阵$M_{n}(F)$是$n^2$维线性空间，若在其上定义Lie括号为$$[A,B]:= AB-BA,\quad \forall A,B \in M_{n}(F)$$则$M_{n}(F)$是Lie代数。
- $G$上全体左不变矢量场的集合$\mathcal{L}$是线性空间，若在其上定义Lie括号为矢量场的对易子，则$\mathcal{L}$是Lie代数。

>设$V,W$是线性空间，若存在映射$\sigma:V\to W$保Lie括号，则$\sigma$是Lie代数同态。
>若$\sigma$还是双射，则$\sigma$是Lie代数同构。

同构的Lie代数今后当做它们相等。
>若Lie群$G$恒等元$e$的切空间$V_{e}$上定义Lie括号为$$[A,B]:=[\mathbf{A},\mathbf{B}]|_{e},\quad \forall A,B \in V_{e}$$则$V_{e}$称为Lie代数，称为*Lie群$G$的Lie代数*，记作$\mathcal{G}$。

易证$\mathcal{G}=\mathcal{L}$。
给定一个Lie群，就能找到一个Lie代数。然而，**给定一个Lie代数，找到的Lie群不一定唯一（同构的Lie群视作同一个），它至少相差到拓扑结构的不同**。例如实数轴$\mathbb{R}$是1维Lie群，圆环$S^1$是1维Lie群，它们并不同构（因为并不同胚），但是它们有相同的Lie代数。
准确来说，给定一个Lie代数，总可以找到唯一一个单连通Lie群（流形是单连通流形），它能给出这个Lie代数。
- 设$\mathcal{G},\mathcal{G}'$是Lie群$G,G'$的Lie代数，$\rho:G\to G'$是同态映射，则$\rho$在$e \in G$处诱导的推前映射$\rho_{*}:\mathcal{G}\to \mathcal{G}'$是Lie代数同态。
>Lie代数$\mathcal{G}$的子空间$\mathcal{H}$若$$[A,B]\in \mathcal{H},\quad \forall A,B \in \mathcal{H}$$则称$\mathcal{H}$是$\mathcal{G}$的*Lie子代数*，$\mathcal{G}$的Lie括号现在也称$\mathcal{H}$的Lie括号。

- 若$H$是$G$的Lie子群，则$\mathcal{H}$也是$\mathcal{G}$的Lie子代数。
>Lie代数$\mathcal{G}$的Lie子代数$\mathcal{H}$若满足$$[A,\mathcal{H}] = \mathcal{H},\quad \forall A\in \mathcal{G}$$则称$\mathcal{H}$是*理想（Ideal）Lie子代数*。

理想Lie子代数在Lie代数中的角色相当于正规子群在群论中的角色。
>设$\mathcal{H}\subseteq\mathcal{G}$是理想的，则有商集$\mathcal{G}/\mathcal{H}$是Lie代数，称为*商Lie代数*。
# 单参数子群和指数映射
>光滑曲线$\gamma:\mathbb{R}\to G$若满足$$\gamma(s+t)=\gamma(s)\cdot\gamma(t),\quad \forall s,t \in \mathbb{R}$$则称$\gamma$是Lie群$G$的*单参数子群*（且是Abel群），并且$\gamma$是$\mathbb{R}$到$G$的Lie群同态。

- 设$\gamma:\mathbb{R}\to G$是左不变矢量场$\mathbf{A}$的积分曲线，满足$\gamma(0)=e$，则$\gamma$是$G$的一个单参数子群。
- 设单参数子群$\gamma:\mathbb{R}\to G$在恒等元$e$处的切矢为$A$，则$\gamma(t)$是$A$对应的左不变矢量场$\mathbf{A}$的积分曲线。

所以左不变矢量场的集合$\mathcal{L}$和单参数子群的集合$\{ \gamma \}$有一一对应的关系，然后左不变矢量场的集合$\mathcal{L}$又和$e$的切空间$V_{e}$有一一对应的关系，所以Lie代数$\mathcal{G}(=V_{e})$中的每一个元素$A$生成一个单参数子群$\gamma(t)$，称$\mathcal{G}$中每一个元素是一个（无限小）*生成元*（Generator）。
>注意：$\mathcal{G}$的零元对应的单参数子群就是只包含一个点$e$的曲线，它把整个$\mathbb{R}$映射到这一个点上。

>Lie群$G$上的指数映射（Expontential Map） $\exp:V_{e}\to G$定义为$$\exp(A):=\gamma(1),\quad \forall A \in \mathcal{G}$$其中$\gamma:\mathbb{R}\to G$是与$A$对应的那个单参数子群。

- $$\exp(sA)=\gamma(s)$$其中$\gamma(s)$是由$A$决定的单参数子群。