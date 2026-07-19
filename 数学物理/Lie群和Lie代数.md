#微分几何 #抽象代数 
# 李群和李代数
## Lie群
>若$G$既是$n$维（实）流形又是群，且群上定义的乘法、求逆运算都是光滑的，则称$G$是一个$n$维（实）*Lie群*。

这里只讨论有限维Lie群，虽然很多结论对无限维Lie群也适用。
- $\mathbb{R}$和加法构成一个Lie群。
- $\mathbb{R}$和$\mathbb{R}$的直积群$\mathbb{R}^2$构成一个Lie群，从而$\mathbb{R}^n$都是Lie群。
- 设$\phi:\mathbb{R}\times M\to M$是$M$上的任意单参数微分同胚群，则$\{ \phi_{t}|t \in \mathbb{R} \}$是1维Lie群，同构于$\mathbb{R}$。
- $(M,g_{ab})$上的等度规映射关于映射乘法构成一个群，称为*等度规群*，并且是Lie群。

Minkowski空间的等度规群是10维Lie群。有多少个Killing矢量场就对应着多少维的Lie群。
Lie群既是流形又是群，这意味着它之中的元素同时有两重身份：一个是类似流形，它们可以视作是空间中的点；一个是类似群，它们可以视作变换。
例如实数乘法群$G=(\mathbb{R},\times)$是一个Lie群，它里面的元素2，既描述了实数轴上的那个标记为2的点，同时也表达了一个$L_{2}:\mathbb{R}\to \mathbb{R}$的左平移映射，实数轴上的任意元素$g \in G$都可以通过与2相乘变成$2g \in G$。

>设$G$和$G'$是两个Lie群，如果$G$到$G'$存在一个映射$\sigma$，使得$$\forall a,b\in G,\quad \sigma(ab)=\sigma(a)\sigma(b)$$并且$\sigma \in C^{\infty}$，则称$\sigma$是*Lie群同态*。

>设$G$和$G'$是两个Lie群，如果$G$到$G'$存在一个双射$\sigma$，使得$$\forall a,b\in G,\quad \sigma(ab)=\sigma(a)\sigma(b)$$并且$\sigma$是微分同胚（$\sigma ,\sigma^{-1} \in C^{\infty}$），则称$\sigma$是*Lie群同构*。

>若$H$既是$G$的子流形，又是$G$的子群，则称$H$是*Lie子群*（Lie Subgroup）。

上面这些都是继承自群论的一般概念。
## 左平移与左不变矢量场
>$\forall g \in G$，映射$L_{g}:h\mapsto gh$，$\forall h \in G$，称为由$g$生成的*左平移*（Left Translation）。

之所以引入左平移的概念，就是为了突出Lie群中元素的“变换”性质。实际上，李群元素生成的左平移映射与李群元素本身并无实质上的差别，只是在讨论时，我们使用左平移映射更突出“变换”的性质，而直接使用李群中的元素容易让人想到“点”的性质。
左平移有如下性质：
- $L_{e}$是恒等映射。
- $L_{gh}=L_{g}\circ L_{h},\forall g,h \in G$。
- $L_{g}^{-1}=L_{g^{-1}}$。
- $L_{g}$是个微分同胚。

>若$G$上的矢量场$\mathbf{A}$满足$$L_{g*}\mathbf{A}=\mathbf{A}$$其中$L_{g*}$是由$L_{g}$诱导的推前映射，则称$\mathbf{A}$是*左不变的*（Left Invariant）。

一个例子就是实数加法群$G=(\mathbb{R},+)$，左不变映射就是平移$L_{a}f(x)=f(x+a)$，设有一个矢量场$f(x)\dfrac{ \mathrm{d}   }{ \mathrm{d}  x}$，它如果要是左不变矢量场，那就必须$$L_{a}f(x)\dfrac{ \mathrm{d}   }{ \mathrm{d}  x} =f(x+a)\frac{ \mathrm{d}   }{ \mathrm{d}  x} =f(x)\frac{ \mathrm{d}   }{ \mathrm{d}  x} $$这只有是常函数$f(x)=c$，所以$c\dfrac{ \mathrm{d}   }{ \mathrm{d}  x}$是$(\mathbb{R},+)$的一个左不变矢量场。
- 左不变矢量场一定是光滑的。
- $\mathbf{A}$是左不变矢量场的充要条件是$$\mathbf{A}|_{gh}=(L_{g*}\mathbf{A})|_{gh}=L_{g*}(\mathbf{A}|_{h})$$
左不变矢量场乘上常数仍是左不变矢量场，左不变矢量场与左不变矢量场求和也仍是左不变矢量场，所以$G$上全体左不变矢量场构成一个线性空间$\mathcal{L}$。
- **$G$上全体左不变矢量场的集合$\mathcal{L}$与$G$的恒等元$e$的切空间$V_{e}$同构**。
证明：对任意一个矢量$\vec{A} \in V_{e}$，用下面的方式定义左不变矢量场$\mathbf{A}$：$$\mathbf{A}|_{g}:= L_{g*}\vec{A},\quad \forall g \in G$$然后$$\mathbf{A}|_{gh}=L_{gh*}\vec{A}=(L_{g*}\circ L_{h*})\vec{A}=L_{g*}A|_{h}$$故而是左不变矢量场，之后可证明它是双射并且保运算，因此同构。
## Lie代数
设$V$是域$F$上的一个线性空间，定义一种运算称为*Lie括号*$[\cdot,\cdot]:V\times V\to V$，其满足：
1. 反对称性：$[\vec{A},\vec{B}]=-[\vec{B},\vec{A}],\forall \vec{A},\vec{B} \in V$。
2. Jacobi恒等式：$[\vec{A},[\vec{B},\vec{C}]]+[\vec{B},[\vec{C},\vec{A}]]+[\vec{C},[\vec{A},\vec{B}]]=0,\forall \vec{A},\vec{B},\vec{C} \in V$。

则称定义了Lie括号的线性空间为*Lie代数*。任意两个元素的Lie括号都为零的Lie代数称为*Abel Lie代数*。
这里只讨论有限维线性空间的Lie代数，虽然很多结论对无限维Lie代数也适用。
- $\mathbb{R}^3$是线性空间，若定义Lie括号为$$[\vec{a},\vec{b}]:=\vec{a}\times \vec{b},\forall \vec{a},\vec{b} \in \mathbb{R}^3$$则$\mathbb{R}^3$是一个Lie代数。
- 域$F$上的全体$n$阶矩阵$M_{n}(F)$是$n^2$维线性空间，若在其上定义Lie括号为$$[A,B]:= AB-BA,\quad \forall A,B \in M_{n}(F)$$则$M_{n}(F)$是Lie代数。
- $G$上全体左不变矢量场的集合$\mathcal{L}$是线性空间，若在其上定义Lie括号为矢量场的对易子，则$\mathcal{L}$是Lie代数。

>设$V,W$是线性空间，若存在映射$\sigma:V\to W$保Lie括号，则$\sigma$是*Lie代数同态*。
>若$\sigma$还是双射，则$\sigma$是*Lie代数同构*。

同构的Lie代数今后当做它们相等。
>若Lie群$G$恒等元$e$的切空间$V_{e}$上定义Lie括号为$$[\vec{A},\vec{B}]:=[\mathbf{A},\mathbf{B}]|_{e},\quad \forall \vec{A},\vec{B} \in V_{e}$$则$V_{e}$称为Lie代数，称为*Lie群$G$的Lie代数*，记作$\mathcal{G}$。

从空间的视角看，Lie群中的元素是一个个点，而Lie代数中的元素是一个个原点处的矢量；从变换的角度看，Lie群中的元素是一个个完整的变换，而Lie代数中的元素是一个个无穷小的变换，也就是生成元，这一点在后面会看出来。
Lie代数中的Lie括号则是衡量两类无穷小变换之间有何种程度的影响。
给定一个Lie群，就能找到一个Lie代数。然而，**给定一个Lie代数，找到的Lie群不一定唯一（同构的Lie群视作同一个），它至少相差到拓扑结构的不同**。例如实数轴$\mathbb{R}$是1维Lie群，圆环$S^1$是1维Lie群，它们并不同构（因为并不同胚），但是它们有相同的Lie代数。
准确来说，**给定一个Lie代数，总可以找到唯一一个单连通Lie群**（流形是单连通流形），它能给出这个Lie代数。
- 设$\mathcal{G},\mathcal{G}'$是Lie群$G,G'$的Lie代数，$\rho:G\to G'$是同态映射，则$\rho$在$e \in G$处诱导的推前映射$\rho_{*}:\mathcal{G}\to \mathcal{G}'$是Lie代数同态。
>Lie代数$\mathcal{G}$的子空间$\mathcal{H}$若$$[\vec{A},\vec{B}]\in \mathcal{H},\quad \forall \vec{A},\vec{B} \in \mathcal{H}$$则称$\mathcal{H}$是$\mathcal{G}$的*Lie子代数*，$\mathcal{G}$的Lie括号现在也称$\mathcal{H}$的Lie括号。

- 若$H$是$G$的Lie子群，则$\mathcal{H}$也是$\mathcal{G}$的Lie子代数。
>Lie代数$\mathcal{G}$的Lie子代数$\mathcal{H}$若满足$$[\vec{A},\mathcal{H}] = \mathcal{H},\quad \forall \vec{A}\in \mathcal{G}$$则称$\mathcal{H}$是*理想（Ideal）Lie子代数*。

理想Lie子代数在Lie代数中的角色相当于正规子群在群论中的角色。
>设$\mathcal{H}\subseteq\mathcal{G}$是理想的，则有商集$\mathcal{G}/\mathcal{H}$是Lie代数，称为*商Lie代数*。
## 单参数子群和指数映射
>光滑曲线$\gamma:\mathbb{R}\to G$若满足$$\gamma(s+t)=\gamma(s)\cdot\gamma(t),\quad \forall s,t \in \mathbb{R}$$则称$\gamma$是Lie群$G$的*单参数子群*（且是Abel群），并且$\gamma$是$\mathbb{R}$到$G$的Lie群同态。

- 设$\gamma:\mathbb{R}\to G$是左不变矢量场$\mathbf{A}$的积分曲线，满足$\gamma(0)=e$，则$\gamma$是$G$的一个单参数子群。
- 设单参数子群$\gamma:\mathbb{R}\to G$在恒等元$e$处的切矢为$\vec{A}$，则$\gamma(t)$是$\vec{A}$对应的左不变矢量场$\mathbf{A}$的积分曲线。

所以左不变矢量场的集合$\mathcal{L}$和单参数子群的集合$\{ \gamma \}$有一一对应的关系，然后左不变矢量场的集合$\mathcal{L}$又和$e$的切空间$V_{e}$有一一对应的关系，所以Lie代数$\mathcal{G}(=V_{e})$中的每一个元素$\vec{A}$生成一个单参数子群$\gamma(t)$，称$\mathcal{G}$中每一个元素是一个（无限小）*生成元*（Generator）。
>注意：$\mathcal{G}$的零元对应的单参数子群就是只包含一个点$e$的曲线，它把整个$\mathbb{R}$映射到这一个点上。

>Lie群$G$上的指数映射（Expontential Map） $\exp:V_{e}\to G$定义为$$\exp(\vec{A}):=\gamma(1),\quad \forall \vec{A} \in \mathcal{G}$$其中$\gamma:\mathbb{R}\to G$是与$\vec{A}$对应的那个单参数子群。

- 可以用指数映射的方式表示单参数子群$$\exp(s\vec{A})=e^{ s\vec{A} }=\gamma(s)$$其中$\gamma(s)$是由$\vec{A}$决定的单参数子群。

所以许多地方会直接用$e^{ s\vec{A} }$来代指$\vec{A}$生成的单参数子群。
指数映射建立起了生成元与单参数子群的联系，确定了一个生成元，就确定了一个单参数子群。从空间的角度看，类似于确定了一个切矢量，就确定了一条直线；从变换的角度看，类似于确定了一个变换的“倾向”，就确定了整个变换的过程。
例如平移算符$T_{a}f(x)=f(x+a)$，那么$T_{a}=e^{a\frac{ \mathrm{d}   }{ \mathrm{d}  x} }$，算符$\dfrac{ \mathrm{d}   }{ \mathrm{d} x }$是平移群的生成元。对位置的微分$\dfrac{ \mathrm{d}   }{ \mathrm{d}  x}$是无穷小的平移，由这个平移的趋势，就确定了整个平移的轨迹。
# 常见李群和李代数
## 一般线性群GL
### 一般线性群作为李群
域$F$上$n$阶可逆矩阵的集合$GL_{n}(F)$对于矩阵乘法构成一般线性群。
所有$n\times n$矩阵都可以用$n^2$个实数表示，因而它和$\mathbb{R}^{n^2}$一一对应，而一般线性群是行列式非零的$n\times n$矩阵，因而是$\mathbb{R}^{n^2}$的子集。行列式$\det:\mathbb{R}^{n^2}\to \mathbb{R}$是连续函数，一般线性群是$(-\infty,0)\cap(0,+\infty)$关于行列式映射的原像集，因而一般线性群是$\mathbb{R}^{n^2}$的开子集（**非连通的**）。拓扑流形要求与Euclidean空间同胚，所$\mathbb{R}^{n^2}$的任意开子集都必定是个流形，然后因为矩阵乘法、求逆的运算都是有理函数，所以它必定是光滑流形。一般线性群既是个群又是个流形，因而是Lie群，它是一个**非连通群**。
### 一般线性群的李代数
一般线性群的Lie代数的线性空间应当是它单位元的切空间，它的单位元是$I$。倘若以$I$为起点向外引出曲线$\gamma(t)$，这个曲线设为$$\gamma(t)=I+tA,\quad A\in M_{n}(F)$$在$t$比较小的时候，$\det\gamma(t)$一定不会距离1太远，所以这个曲线是落在$GL_{n}(F)$里面的，起码原点附近是。那么这个曲线在单位元附近的切矢就是$$\left. \frac{ \mathrm{d}   }{ \mathrm{d}  t}  \right| _{t=0}\gamma(t)=A$$这就是说，$GL_{n}(F)$的单位元处的切空间$V_{I}$实际上是$M_{n}(F)$，它是所有$n$阶方阵的集合，无论可逆或不可逆。准确来说有以下结论：
- $GL_{n}(F)$的Lie代数$\mathcal{G}\mathcal{L}_{n}(F)$作为一个线性空间，它和全体$n$阶方阵的集合$M_{n}(F)$（包括行列式等于零的方阵）同构。

接下来我们就可以定义$GL_{n}(F)$上的李代数了。
- 在$M_{n}(F)$上定义矩阵的对易子$[A,B]=AB-BA$为Lie括号，则$\mathcal{G}\mathcal{L}_{n}(F)$与$M_{n}(F)$有Lie代数同构。
### 矩阵的指数
引入矩阵的指数符号$$\mathrm{Exp}(A)=e^{A}:=I+A+\frac{1}{2!}A^2+\frac{1}{3!}A^3+\dots$$可以证明
- 级数收敛于一个$n\times n$矩阵。
- 当$[A,B]=0$时，$e^{ A+B }=e^{ A }\cdot e^{ B }$。
- 矩阵指数的行列式$$\det(e^{ A })=e^{ \mathrm{Tr}(A) }$$
证明：设矩阵的特征值为$\lambda_{1},\lambda_{2},\dots,\lambda_{n}$，即使矩阵不可对角化，这些特征值依然存在于复数域。对于$A$的任意一个特征向量$v$，$$e^{ A }v=\left( I+A+\frac{1}{2!}A^2+\dots \right)v=\left( 1+\lambda+\frac{1}{2!}\lambda^2+\dots \right)v=e^{ \lambda v }$$所以$e^{ A }$的特征值就是$e^{ \lambda_{1} },e^{ \lambda_{2} },\dots,e^{ \lambda_{n} }$。
而$$\det(e^{ A })=\prod_{i}e^{ \lambda_{i} }=e^{ \sum_{i}\lambda_{i} }=e^{ \mathrm{Tr}(A) }$$证毕。
- 矩阵的指数就是一般线性群的指数映射$$\mathrm{Exp}(A)=\exp(A)$$今后都用$e^{ A }$表示。这是因为矩阵的指数的确可以视作一个$M_n(F)\to GL_{n}(F)$的映射，$$\forall A\in M_{n}(F),\quad\det (e^{ A })=e^{ \mathrm{Tr}(A) }>0\implies e^{ A }\in GL_{n}(F)$$

从这一结论我们可以更深刻地看出为什么当初我们要将指数映射命名为指数映射。当Lie群为一般线性群的时候，指数映射就相当于是对矩阵做像实数指数的运算。