#数学分析 #场论 #微分几何
# 前置概念
## Jordan曲线/简单闭曲线
设$L$为平面上一条曲线，$L:\vec{r}(t)=x(t)\vec{i}+y(t)\vec{j}+z(t)\vec{k},t\in[\alpha,\beta]$。
若$\vec{r}(\alpha)=\vec{r}(\beta)$，且当$t_1\neq t_2$时，总有$\vec{r}(t_1)\neq\vec{r}(t_2)$，
则称L为*简单闭曲线*，即首尾相连，没有相交的曲线。
## 单/复连通区域
### 平面的情况
设$D$为平面上一个区域，若$D$内任意一条闭曲线都可以不经过$D$以外的点而连续地收缩为一点，则称$D$为*单连通区域*，否则称为*复连通区域*。
即单连通区域无洞，复连通区域有洞。
### 空间的情况
设$\Omega$为空间上一个区域，若$\Omega$内任何一张封闭曲面所围成的立体仍属于$\Omega$，则称$\Omega$为*二维单连通区域*，否则称为*二维复连通区域*。
## 诱导定向
### 一维单连通区域
单连通区域边界的诱导定向为：沿着正向走时，区域在左侧时的方向。
### 二维单连通区域
二维单连通区域的诱导定向为：外侧
### 边界分段光滑的非封闭光滑双侧曲面
单张曲面：右手的四指向$\partial \Sigma$的正向弯曲时，大拇指指向$\Sigma$的法向量
多张曲面：曲面的公共边界曲线方向相反
# Green定理
## 分量式
设$D$为平面上由光滑或分段光滑的简单闭曲线所围的单连通闭区域。
若函数$P(x,y),Q(x,y)$在$D$上有连续偏导数，则$$\oint_{\partial D}P\mathrm{d}x+Q\mathrm{d}y=\iint_{D}(\frac{\partial Q}{\partial x}-\frac{\partial P}{\partial y})\mathrm{d}x\mathrm{d}y$$其中$\partial D$指$D$的边界，取诱导定向。
## 法向量式
$$\int_{\partial D}(P\cos\alpha+Q\cos\beta)\mathrm{d}s=\iint_{D}(\frac{\partial Q}{\partial x}+\frac{\partial P}{\partial y})\mathrm{d}x\mathrm{d}y$$
其中$$(\cos\alpha,\cos\beta)$$是曲线的单位法向量。
## 行列式
$$\int_{\partial D}P\mathrm{d}x+Q\mathrm{d}y=\iint_{D}\left|
\begin{matrix}
\frac{\partial}{\partial x}&\frac{\partial}{\partial y}\\
P&Q\\
\end{matrix}
\right|\\
\mathrm{d}x\mathrm{d}y$$
## 场论式
$$\oint \vec{A} \cdot \hat{t} \mathrm{d} l=\iint \nabla \times \vec{A} \cdot \hat{k}\mathrm{d}S$$
## Newton-Leibniz公式
取$D=[a,b]\times[0,1],P=f(x),Q=0$，即得Newton-Leibniz公式。
## 路径无关
设$D$为平面区域$P(x,y),Q(x,y)$为$D$上的连续函数，
若对于$D$中任意两点$A,B$，积分值$$\int_L P\mathrm{d}y+Q\mathrm{d}x$$
只与$A,B$两点有关，而与$AB$间的路径无关，则称该曲线积分路径无关。
### Green定律
设D为平面上的单连通区域，$P(x,y),Q(x,y)$在其上有连续偏导数
则下列四个命题等价：
1. 对于$D$中任一闭曲线$L$，$\int_LP\mathrm{d}y+Q\mathrm{d}x=0$
2. 曲线积分$\int_LP\mathrm{d}y+Q\mathrm{d}x$路径无关
3. 存在$D$上的可微函数$U(x,y)$，使得$\mathrm{d}U=P\mathrm{d}x+Q\mathrm{d}y$，此时称$U$为1-微分形式$P\mathrm{d}x+Q\mathrm{d}y$的原函数
	- $A(x_1,y_1),B(x_2,y_2)\in D,\overset{\LARGE{\frown}}{AB}$为两点间的任一路径，$\int_{\overset{\LARGE{\frown}}{AB}}P\mathrm{d}y+Q\mathrm{d}x=U(x_2,y_2)-U(x_1,y_1)$
4. $D$中恒成立$\frac{\partial Q}{\partial x}-\frac{\partial P}{\partial y}=0$
# Gauss定理
## 分量式
设$\Omega$为$\mathbb{R}^3$上由光滑或分片光滑的封闭曲面所围的二维单连通闭区域。
若函数$P(x,y,z),Q(x,y,z),R(x,y,z)$在$\Omega$上有连续偏导数,则
$$\iint_{\partial \Omega}\kern{-22.8pt}\subset\kern{-2pt}\supset    P\mathrm{d}x+Q\mathrm{d}y+R\mathrm{d}z=\iiint_{\Omega}(\frac{\partial P}{\partial x}+\frac{\partial Q}{\partial y}+\frac{\partial R}{\partial z})\mathrm{d}x\mathrm{d}y\mathrm{d}z$$其中$\partial \Omega$取诱导定向
## 法向量式
$$\iint_{\partial \Omega}\kern{-22.8pt}\subset\kern{-2pt}\supset  (P\cos\alpha+Q\cos\beta+R\cos\gamma)\mathrm{d}\sigma=\iiint_{\Omega}(\frac{\partial P}{\partial x}+\frac{\partial Q}{\partial y}+\frac{\partial R}{\partial z})\mathrm{d}x\mathrm{d}y\mathrm{d}z$$
其中$(\cos\alpha,\cos\beta,\cos\gamma)$是曲面的单位法向量。
## 场论式
$$\iint_{\partial \Omega}\kern{-22.8pt}\subset\kern{-2pt}\supset  \vec{A}\cdot\mathrm{d}\vec{\sigma} =
 \iiint_{\Omega} \nabla \cdot \vec{A}\mathrm{d}V$$
# Stokes定理
## 分量式
设$\Sigma$为光滑曲面，其边界$\partial\Sigma$为分段光滑闭曲线
若函数$P(x,y,z),Q(x,y,z),R(x,y,z)$在$\Sigma$及$\partial\Sigma$上有连续偏导数，则
$$\int_{\partial \Sigma}P\mathrm{d}x+Q\mathrm{d}y+R\mathrm{d}z=\iint_{\Sigma}
(\frac{\partial R}{\partial y}-\frac{\partial Q}{\partial z})\mathrm{d}y\mathrm{d}z+
(\frac{\partial P}{\partial z}-\frac{\partial R}{\partial x})\mathrm{d}z\mathrm{d}x+
(\frac{\partial Q}{\partial x}-\frac{\partial P}{\partial y})
\mathrm{d}x\mathrm{d}y,$$
其中$\partial \Sigma$取诱导定向。
## 行列式
$$\int_{\partial \Sigma}P\mathrm{d}x+Q\mathrm{d}y+R\mathrm{d}z=\iint_{\Sigma}\left|
\begin{matrix}
\mathrm{d}y\mathrm{d}z&\mathrm{d}z\mathrm{d}x&\mathrm{d}x\mathrm{d}y\\
\frac{\partial}{\partial x}&\frac{\partial}{\partial y}&\frac{\partial}{\partial z}\\
P&Q&R\\
\end{matrix}
\right|=\iint_{\Sigma}\left|
\begin{matrix}
\cos\alpha&\cos\beta&\cos\gamma\\
\frac{\partial}{\partial x}&\frac{\partial}{\partial y}&\frac{\partial}{\partial z}\\
P&Q&R\\
\end{matrix}
\right|\mathrm{d}\sigma$$
其中$(\cos\alpha,\cos\beta,\cos\gamma)$是曲面的单位法向量。
## 场论式
$$\oint_{\partial \Sigma} \vec{A}\cdot\mathrm{d}\vec{l} =
 \iint_{\Sigma} (\nabla \times \vec{A})\cdot\mathrm{d}\vec{\sigma}$$
# 微分形式
## 楔积
在向量之中定义一种乘法运算，如果它满足：
1. 反对称性：$$\vec{a}_1\wedge\vec{a}_{2}=-\vec{a}_{2}\wedge \vec{a}_{1}$$
2. 双线性：$$(k_{1}\vec{a}_{1}+k_{2}\vec{a}_{2})\wedge(k_{3}\vec{a}_{3}+k_{4}\vec{a}_{4})=k_{1}k_{3}\vec{a}_{1}\wedge \vec{a}_{3}+k_{2}k_{3}\vec{a}_{2}\wedge \vec{a}_{3}+k_{1}k_{4}\vec{a}_{1}\wedge \vec{a}_{4}+k_{2}k_{4}\vec{a}_{2}\wedge \vec{a}_{4}$$

则称该运算为*楔积*。
楔积的结果是一种特殊的张量并矢，只是可以满足反对称运算。
在域$F$上的$n$维线性空间$V$中，有n个向量$\vec{v}_{1},\vec{v}_{2},\dots,\vec{v}_{n}$，如果选定一组基$\{\alpha_{1},\alpha_{2},\dots,\alpha_{n}\}$，$\vec{v}_{i}$在该基下的坐标为$(v_{1i},v_{2i},\dots,v_{ni}),i=1,2,\dots,n$，则$$\vec{v}_{1}\wedge\vec{v}_{2}\wedge\dots \wedge\vec{v}_{n}=\begin{vmatrix}
v_{11} & v_{12} & \dots & v_{1n} \\
v_{21} & v_{22} & \dots & v_{2n}  \\
\vdots & \vdots &  & \vdots \\
v_{n_{1}} & v_{n_{2}} & \dots & v_{nn}
\end{vmatrix}\alpha_{1}\wedge \alpha_{2}\wedge\dots \alpha_{n}$$
借由音乐同构，在3维空间中可以看出叉乘和楔积的关系$$\vec{a}\times \vec{b}=\star(\vec{a}^\flat\wedge \vec{b}^{\flat})^{\sharp}$$
在域$C^1(U)$上的线性空间$\Lambda^q$中，基底是$q$次微分形式，因为音乐同构，对于$q$次微分形式也可以定义楔积。
在定义了楔积之后，重积分变换中的Jacobi行列式可以去掉绝对值$$\mathrm{d}x\wedge\mathrm{d}y=\frac{ \partial  (x,y) }{ \partial  (u,v)} \mathrm{d}u\wedge\mathrm{d}v$$
## 微分形式
### 一次微分形式
设$U$为$\mathbb{R}^n$上的区域，记$\vec{x}=(x_1,x_2,\cdots,x_n)$，$C^1(U)$为$U$上有一阶连续偏导数的函数全体，将$\{\mathrm{d}x_1,\mathrm{d}x_2,\cdots,\mathrm{d}x_n\}$看作一组基，其线性组合$$a_1(\vec{x})\mathrm{d}x_1+a_2(\vec{x})\mathrm{d}x_2+\cdots+a_n(\vec{x})\mathrm{d}x_n,a_i(\vec{x})\in C^1(U),i=1,2,\cdots,n.$$称作*一次微分形式*或*1-微分形式*
### k次微分形式
从$\{\mathrm{d}x_1,\mathrm{d}x_2,\cdots,\mathrm{d}x_n\}$任意选取k个组成有序元$\mathrm{d}x_{i1}\wedge\mathrm{d}x_{i2}\wedge\cdots\wedge\mathrm{d}x_{ik}$，以这些$C_{n}^{k}$个非零有序元为基，在域$C^1(U)$上的线性空间$\Lambda^k$，其中的元素即是$k$次微分形式
一般表达式为$\omega=\sum_{1\leqslant i_1<i_2<\cdots<i_k\leqslant<n}g_{i_1,i_2,\cdots,i_k}(\vec{x})\mathrm{d}x_{i_1}\wedge\mathrm{d}x_{i_2}\wedge\cdots\wedge\mathrm{d}x_{i_k}$
### 0次微分形式
就是$C^1(U)$里的元素（有一阶连续偏导的函数）。
### 微分形式的楔积性质
- 性质1：$\omega\in \Lambda^p,\eta\in \Lambda^q$，若$p+q>n$，则$\omega\wedge\eta=0$
- 性质2：$\omega\in \Lambda^p,\eta\in \Lambda^q$，则$\omega\wedge\eta=(-1)^{pq}\eta\wedge\omega$
- 性质3：$\omega\in \Lambda^p,\omega\ne 0$，若$p$为奇数，则$\omega\wedge\omega=0$（偶数不一定）
- 左右分配律，结合律
# 外微分
普通的全微分是：设$U\subset \mathbb{R}^n$上可微的函数$f(x_{1},x_{2},\dots,x_{n})$的全微分为$$\mathrm{d}f=\sum_{i=1}^n\frac{ \partial   f}{ \partial  x_{i}} \mathrm{d}x_{i}$$
我们把上式看成对0-微分形式求微分。
接着扩展定义，对于$k$-微分形式$$\omega=\sum_{1\leqslant i_1<i_2<\cdots<i_k\leqslant<n}g_{i_1,i_2,\cdots,i_k}(\vec{x})\mathrm{d}x_{i_1}\wedge\mathrm{d}x_{i_2}\wedge\cdots\wedge\mathrm{d}x_{i_k}$$来说，其*外微分*定义为
$$\mathrm{d}\omega := \sum_{1\leqslant i_1<i_2<\cdots<i_k\leqslant<n}(\sum_{i=1}^n \frac{\partial g_{i_1,i_2,\cdots,i_k}}{\partial x_i}\mathrm{d}x_{i})\mathrm{d}x_{i_1}\wedge\mathrm{d}x_{i_2}\wedge\cdots\wedge\mathrm{d}x_{i_k}$$
示例：
- 对于1-微分形式$\omega = P dx + Q dy + R dz$，结果是2-微分形式$$\mathrm{d}\omega = \left( \frac{\partial R}{\partial y} - \frac{\partial Q}{\partial z} \right) \mathrm{d}y \wedge \mathrm{d}z + \left( \frac{\partial P}{\partial z} - \frac{\partial R}{\partial x} \right) \mathrm{d}z \wedge \mathrm{d}x + \left( \frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} \right) \mathrm{d}x \wedge \mathrm{d}y$$
- 对于2-微分形式$\omega = A \mathrm{d}y \wedge \mathrm{d}z + B \mathrm{d}z \wedge \mathrm{d}x + C \mathrm{d}x \wedge \mathrm{d}y$，结果是3-微分形式$$\mathrm{d}\omega = \left( \frac{\partial A}{\partial x} + \frac{\partial B}{\partial y} + \frac{\partial C}{\partial z} \right) \mathrm{d}x \wedge \mathrm{d}y \wedge \mathrm{d}z$$
- 对于3-微分形式$\omega = (x+y+z) \mathrm{d}x \wedge \mathrm{d}y \wedge \mathrm{d}z$，结果是0-微分形式，体系了外微分的闭合性$$\mathrm{d}\omega = (\mathrm{d}x + \mathrm{d}y + \mathrm{d}z) \wedge \mathrm{d}x \wedge \mathrm{d}y \wedge \mathrm{d}z = 0$$
## 外微分的性质
- 设$\omega$是$k$-微分形式，$\eta$为$l$-微分形式，则$$\mathrm{d}(\omega \wedge \eta)=\mathrm{d}\omega \wedge \eta+(-1)^k\omega \wedge \mathrm{d}\eta$$
- 对于任意$\omega \in \Lambda^q$，有$\mathrm{d}^2\omega=0$
## 外微分和Nabla算子的关系
Nabla算子是外微分算子$\mathrm{d}$在三维Euclidean空间上呈现。其关系是
$$\nabla u=(\mathrm{d}u)^{\sharp},\quad \nabla \times \vec{A}=\star[\mathrm{d}(\vec{A}^{\flat})],\quad \nabla\cdot \vec{A}=\star[\mathrm{d(\star \vec{A}^{\flat})}]$$
在三维Euclidean空间中，外微分可以写成如下形式

| 微分形式阶数                            | 外微分的结果                                                                |
| --------------------------------- | --------------------------------------------------------------------- |
| **0-微分形式**$u$                     | $\mathrm{d}u = \nabla u \cdot \mathrm{d}\vec{r}$                      |
| **1-微分形式**$\vec{A}^{\flat}$       | $\mathrm{d}\omega = (\nabla \times \vec{A}) \cdot \mathrm{d}\vec{S}$) |
| **2-微分形式**$\star \vec{A}^{\flat}$ | $\mathrm{d}\omega = (\nabla \cdot \vec{A})\mathrm{d}V$                |
| **3-微分形式**$u\mathrm{d}V$          | $\mathrm{d}\omega = 0$                                                |
# 广义Stokes定理
设$M$是一个带有边界的定向$n$维可微流形，$\omega$是在$M$上定义的一个$(n-1)$-微分形式，且具有紧支撑或在边界上光滑，则：$$\int_{M}\mathrm{d}\omega=\int_{\partial M}\omega$$
其中$\partial M$是$M$的边界流形，方向由$M$的方向诱导。这被称作*广义Stokes公式*。
广义Stokes公式描述了边界和内里的关系，或者可以说是形式和内容的关系。
## 统一公式
### 一维流形（Newton-Leibniz公式）
取$\omega = f(x),M=[a,b]$，即Newton-Leibniz公式
$$\int_{a}^b f'(x)\mathrm{d}x=f(b)-f(a)$$
### 二维流形(Green公式)
取$\omega = P\mathrm{d}x + Q\mathrm{d}y$，$M=D$，即Green公式
$$\oint_{\partial D}P\mathrm{d}x+Q\mathrm{d}y=\iint_{D}(\frac{\partial Q}{\partial x}-\frac{\partial P}{\partial y})\mathrm{d}x\mathrm{d}y$$
### 三维流形(Gauss公式和Stokes公式)
取$\omega = P\mathrm{d}y\mathrm{d}z + Q\mathrm{d}z\mathrm{d}x + R\mathrm{d}x\mathrm{d}y$，$M=\Omega$，即Gauss公式
$$\iint_{\partial \Omega}P\mathrm{d}x+Q\mathrm{d}y+R\mathrm{d}z=\iiint_{\Omega}(\frac{\partial P}{\partial x}+\frac{\partial Q}{\partial y}+\frac{\partial R}{\partial z})\mathrm{d}x\mathrm{d}y\mathrm{d}z$$
取$\omega = P\mathrm{d}x + Q\mathrm{d}y + R\mathrm{d}z$，$M=\Sigma$，即Stokes公式
$$\int_{\partial \Sigma}P\mathrm{d}x+Q\mathrm{d}y+R\mathrm{d}z=\iint_{\Sigma}
(\frac{\partial R}{\partial y}-\frac{\partial Q}{\partial z})\mathrm{d}y\mathrm{d}z+
(\frac{\partial P}{\partial z}-\frac{\partial R}{\partial x})\mathrm{d}z\mathrm{d}x+
(\frac{\partial Q}{\partial x}-\frac{\partial P}{\partial y})
\mathrm{d}x\mathrm{d}y,$$
## 内容-形式变换
### 体-面变换
体积分和面积分满足$$\iiint \mathrm{d}V \nabla \Leftrightarrow \iint_{}\kern{-13.8pt}\subset\kern{-2pt}\supset \mathrm{d}\vec{S}    $$
- 梯度
$$\iiint \nabla u\mathrm{d}V=\iint_{}\kern{-13.8pt}\subset\kern{-2pt}\supset \mathrm{d}\vec{S}u    $$
- 散度
$$\iiint \nabla\cdot \vec{A}\mathrm{d}V=\iint_{}\kern{-13.8pt}\subset\kern{-2pt}\supset \mathrm{d}\vec{S}\cdot\vec{A}    $$
- 旋度
$$\iiint \nabla \times \vec{A}\mathrm{d}V=\iint_{}\kern{-13.8pt}\subset\kern{-2pt}\supset \mathrm{d}\vec{S}\times\vec{A}    $$
注：$$\iint_{}\kern{-13.8pt}\subset\kern{-2pt}\supset \mathrm{d}\vec{S}\times\vec{A}=-\iint_{}\kern{-13.8pt}\subset\kern{-2pt}\supset \vec{A}\times\mathrm{d}\vec{S}$$
### 面-线变换
面积分和线积分满足$$\iint \mathrm{d}\vec{S}\times \nabla\Leftrightarrow \oint \mathrm{d}\vec{l}$$
- 梯度
$$\iint \mathrm{d}\vec{S}\times \nabla u=\oint \mathrm{d}\vec{l} u$$
- 散度
$$\iint \mathrm{d}\vec{S}\times \nabla\cdot \vec{A}【不合法】=\iint \nabla \times \vec{A}\cdot\mathrm{d}\vec{S}=\oint \mathrm{d}\vec{l} \cdot\vec{A}$$
- 旋度
$$\iint \mathrm{d}\vec{S}\times (\nabla \times \vec{A})=\oint \mathrm{d}\vec{l} \times \vec{A}$$