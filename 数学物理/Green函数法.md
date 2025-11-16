#数理方法 
# Green恒等式
根据[[广义Stokes定理#Gauss定理]]$$\iiint \nabla \cdot \vec{A}\mathrm{d}V=\iint_{}\kern{-13.5pt}\subset\kern{-2pt}\supset  \vec{A}\cdot \mathrm{d}\vec{S}  $$
令$\vec{A}=u\nabla v$，有$$\iiint \nabla \cdot (u\nabla v)\mathrm{d}V=\iint_{}\kern{-13.5pt}\subset\kern{-2pt}\supset  (u\nabla v)\cdot \mathrm{d}\vec{S}  $$
运用[[Nabla算子#乘法法则#点乘矢常函数]]，$$\iiint \nabla u \cdot \nabla v\mathrm{d}V+\iiint u \nabla^2 v \mathrm{d}V=\iint_{}\kern{-13.5pt}\subset\kern{-2pt}\supset  u\nabla v\cdot \mathrm{d}\vec{S}  $$
这就是*格林第一恒等式*。
也可以交换$u,v$，得到$$\iiint \nabla v \cdot \nabla u\mathrm{d}V+\iiint v \nabla^2 u \mathrm{d}V=\iint_{}\kern{-13.5pt}\subset\kern{-2pt}\supset  v\nabla u\cdot \mathrm{d}\vec{S}  $$
跟第一公式相减，得到
$$\iiint (u \nabla^2 v-v\nabla^2 u) \mathrm{d}V=\iint_{}\kern{-13.5pt}\subset\kern{-2pt}\supset  (u\nabla v - v\nabla u)\cdot \mathrm{d}\vec{S}  $$
这就是*格林第二恒等式*。
事实上，对于任意线性微分算子$\mathcal{L}$，都有
$$
\int_V \left[ v (\mathcal{L} u) - u (\mathcal{L}^\dagger v) \right] dV = \iint_{S}\kern{-17.8pt}\subset\kern{-2pt}\supset     \mathbf{J}(u, v) \cdot d\mathbf{S}
$$
其中$\mathcal{L}^\dagger$ 是 $\mathcal{L}$ 的伴随算子， $\mathbf{J}(u, v)$ 是一个由 $u$, $v$ 及其导数构成的向量函数，称为双线性共变式。它的具体形式完全取决于算子 $\mathcal{L}$ 的形式。
# Green函数
若对于线性算子$\mathcal{L}$，一般的线性方程形如$$\mathcal{L}u(\vec{r})=-f(\vec{r})$$
可以定义若
$$\mathcal{L}G(\vec{r};\vec{r}')=-\delta^n (\vec{r}-\vec{r}')$$
则称$G(\vec{r}-\vec{r}')$是Green函数，其中$\delta^n(\vec{r}-\vec{r}')$是$n$维Dirac函数。
>Green函数法的核心思想是：将一个复杂源 $f(\vec{r})$ 产生的场，看作是无数个点源 $\delta^n(\vec{r} - \vec{r}')$ 产生的场的线性叠加。

之后，我们需要求解一个最简单的问题：*点源的响应*。这个响应就是格林函数 $G(\mathbf{r}, \mathbf{r}')$
注意：
- 格林函数是一个仅与求解问题的线性算子和空间边界形状有关的函数，跟待求函数的边界值无关。
- 格林函数往往不止一个
知道了Green函数以后，把$f(\vec{r})$看成$\delta^n(\vec{r}-\vec{r}')$的叠加，$u(\vec{r})$看成$G(\vec{r})$的叠加
*在无界条件下*，实际上就是两边跟$f(\vec{r}')$作卷积（全空间积分）
等式右边利用Dirac函数的卷积特性$$-\int f(\vec{r}')\delta^n(\vec{r}-\vec{r}')\mathrm{d}\tau'=-f(\vec{r})$$
左边$$\mathcal{L} u(\vec{r})=\mathcal{L}\int f(\vec{r}')G(\vec{r};\vec{r}')\mathrm{d}\tau'=\int f(\vec{r}')\mathcal{L}G(\vec{r};\vec{r}')\mathrm{d}\tau'=-\int f(\vec{r}')\delta^n(\vec{r}-\vec{r}')\mathrm{d}\tau'$$
于是可以发现$$u(\vec{r})=\int f(\vec{r}')G(\vec{r};\vec{r}')\mathrm{d}\tau'$$
*在有界条件下*，情况会更加复杂，必须利用Green恒等式
假设$\mathcal{L}=\nabla^2 + c$，于是方程形式为$$(\nabla^2 +c)u(\vec{r}')=-f(\vec{r}'),\quad(\nabla^2 +c)G(\vec{r};\vec{r}')=-\delta(\vec{r}-\vec{r}')$$
前式乘以$G$，后式乘以$u$，然后二者相减就能得到$$G(\vec{r};\vec{r}')\nabla^2 u(\vec{r}')-u(\vec{r}')\nabla^2 G(\vec{r};\vec{r}')=-G(\vec{r};\vec{r}')f(\vec{r}')+u(\vec{r}')\delta(\vec{r}-\vec{r}')$$
两边对源点体积分，$$\iiint_{V} [G(\vec{r};\vec{r}')\nabla^2 u(\vec{r}')-u(\vec{r}')\nabla^2 G(\vec{r};\vec{r}')] \mathrm{d}V'=\iiint_{V} [-G(\vec{r};\vec{r}')f(\vec{r}')+u(\vec{r}')\delta(\vec{r}-\vec{r}')]\mathrm{d}V'$$
在利用Green第二恒等式$$\iint_{S}\kern{-17.8pt}\subset\kern{-2pt}\supset  \left[ G(\vec{r};\vec{r}')\nabla u(\vec{r}')-u(\vec{r}')\nabla G(\vec{r};\vec{r}') \right]  \cdot\mathrm{d}\vec{S}'=\iiint_{V} [-G(\vec{r};\vec{r}')f(\vec{r}')]\mathrm{d}V'+u(\vec{r})$$
最终得到$$u(\vec{r})=\underbrace{\iiint_{V} G(\vec{r};\vec{r}')f(\vec{r}')\mathrm{d}V'}_{\text{体积分：真实源贡献}}+\underbrace{\iint_{S}\kern{-17.8pt}\subset\kern{-2pt}\supset  \left[ G(\vec{r};\vec{r}')\frac{ \partial  u(\vec{r}') }{ \partial  n'} -u(\vec{r}')\frac{ \partial   G(\vec{r};\vec{r}')  }{ \partial  n'} \right]  \mathrm{d}S'}_{\text{面积分：边界贡献}}$$
这是Green函数法的通解。
这个是可以直接把第一，第二类边界条件代入的表达式。
部分教材中第二项面积分部分可能符号与这里相反，这是由于它们定义的格林函数是$\mathcal{L}G(\vec{r};\vec{r}')=\delta^n (\vec{r}-\vec{r}')$
如果是齐次边界条件，则边界项就可以大幅简化。
# Poisson方程的Green函数
## 无界问题
[[位势方程#Poisson方程]]的表达式为$$\nabla^2 u(\vec{r})=-f(\vec{r})$$
考虑其Green函数$$\nabla^2 G(\vec{r};\vec{r}')=-\delta^n(\vec{r}-\vec{r}')$$
这里仅推导三维的情况。
由于无界空间中的平移不变性，相应只与源点和场点的相对位置有关，所以可以令$\vec{R}=\vec{r}-\vec{r}'$
然后$$\nabla^2_{\vec{R}}G(\vec{R})=-\delta^3(\vec{R}) $$
又因为旋转对称性$G(\vec{R})$必然与角度无关，所以当$R>0$时
$$\nabla^2_{R}G(R)=0,\quad R>0$$
用[[正交曲线坐标系的场论#球坐标系#调和量]]展开，得到
$$\frac{1}{R^2} \frac{\mathrm{d}}{\mathrm{d} R} \left( R^2 \frac{\mathrm{d} G}{\mathrm{d} R} \right)=0 $$
积分一次$$R^2 \frac{ \mathrm{d}  G }{ \mathrm{d}  R} =C_1$$
再积分一次$$G(R)=-\frac{C_1}{R}+C_2$$
需要$\lim_{ R \to \infty }G(R)=0$，所以$C'=0$（实际上这一点不一定要满足，因为Green函数可以有很多个，只是在这个问题里，这样可以方便表示）
为了确定$C$，我们需要考虑一个以$R=0$为球心，半径为$\delta$的小球$V$，在小球中心挖个洞，洞是以$R=0$为球心，半径为$\varepsilon<\delta$的小小球$V_{\varepsilon}$。考虑在$V$中体积分$$\iiint_{V}\nabla^2 G(\vec{R})\mathrm{d}V=\iiint_{V-V_{\varepsilon}}\nabla^2 G(\vec{R})\mathrm{d}V+\iiint_{V_{\varepsilon}}\nabla^2 G(\vec{R})\mathrm{d}V=\iiint_{V} -\delta^3(\vec{R})=-1$$
$G(\vec{R})$在$V-V_{\varepsilon}$中是解析的，所以可以使用[[广义Stokes定理#Gauss定理]]：$$\iint_{S}\kern{-17.8pt}\subset\kern{-2pt}\supset \nabla G(\vec{R})\cdot\mathrm{d}\vec{S}+ \iiint_{V_{\varepsilon}}\nabla^2 G(\vec{R})\mathrm{d}V=-1  $$
其中代入$G(\vec{R})$表达式，利用[[正交曲线坐标系的场论#球坐标系#梯度]]$$\nabla G(\vec{R})=\frac{C}{R^2}\hat{R}$$
计算出$$\iint_{S}\kern{-17.8pt}\subset\kern{-2pt}\supset \nabla G(\vec{R})\cdot\mathrm{d}\vec{S}=\iint_{\theta,\varphi}\frac{C}{R^2}R^2\sin \theta \mathrm{d}\theta \mathrm{d}\varphi=4\pi\cdot \frac{C}{R^2}$$
然后又由于$$\lim_{ \varepsilon \to 0 } \iiint_{V_{\varepsilon}}\nabla^2 G(\vec{R})\mathrm{d}V=0$$
所以$$C=-\frac{1}{4\pi}$$
终$$G(\vec{r};\vec{r}')=\frac{1}{4\pi}\cdot \frac{1}{|\vec{r}-\vec{r}'|}$$
类似的可以得出二维，一维的情况。
### 一维
$$G(x;x')=\frac{1}{2}|x-x'|$$
### 二维
$$G(\vec{r};\vec{r}')=\frac{1}{2\pi}\ln\left(\frac{1}{|\vec{r}-\vec{r}'|}\right)$$
### 三维
$$G(\vec{r};\vec{r}')=\frac{1}{4\pi}\cdot \frac{1}{|\vec{r}-\vec{r}'|}$$
## 边界问题
Poisson方程的边界问题在求解的过程中，可以运用[[镜像法]]，把复杂的边界问题改成求解少数几个点产生的场。
### 半空间问题
对于方程$$\begin{equation}
        \left\{
	\begin{aligned}
		&\nabla^2 G(\vec{r};\vec{r}')=-\delta^3(\vec{r}-\vec{r}')\\
		&G(\vec{r};\vec{r}')|_{z=0}=0\\
	\end{aligned}
	\right.
\end{equation}$$
可以通过[[镜像法#无限大平面]]解得$$G(\vec{r};\vec{r}')=\frac{1}{4\pi}\left [
\frac{1}{\sqrt[]{(x-x')^2+(y-y')^2+(z-z')^2}}-
\frac{1}{\sqrt[]{(x-x')^2+(y-y')^2+(z+z')^2}}  \right ] $$
### 球外问题
对于方程
$$\begin{equation}
        \left\{
	\begin{aligned}
		&\nabla^2 G(\vec{r};\vec{r}')=-\delta^3(\vec{r}-\vec{r}')\\
		&G(\vec{r};\vec{r}')|_{|\vec{r}|=R_0}=0\quad\text{(球面边界条件)}\\
	\end{aligned}
	\right.
\end{equation}$$
可以通过[[镜像法#导体球]]解得$$G(\vec{r};\vec{r}')=\frac{1}{4\pi}\left [
\frac{1}{|\vec{r}-\vec{r}'|}-
\frac{R_0}{r'\cdot|\vec{r}-\frac{R_0^2}{r'^2}\vec{r}'|}  \right ] $$
其中$r'=|\vec{r}'|$。

# Helmholtz方程的Green函数
## 无界问题
[[位势方程#Helmholtz方程]]的表达式为$$(\nabla^2+k^2) u(\vec{r})=-f(\vec{r})$$
考虑其Green函数$$(\nabla^2+k^2) G(\vec{r};\vec{r}')=-\delta^n(\vec{r}-\vec{r}')$$
同样只讨论三维的情况。
同样的类似上面的Poisson方程的方式利用对称性，在$R>0$时可以得到$$(\nabla_{R}^2+k^2)G(R)=0$$
变成$$\frac{1}{R^2} \frac{\mathrm{d}}{\mathrm{d} R} \left( R^2 \frac{\mathrm{d} G}{\mathrm{d} R} \right) +k^2 G=0 $$
根据Poisson方程中Green函数和$R$成反比的经验，可以令$T=RG$，于是原式变换为$$\frac{ \mathrm{d}  ^2 T }{ \mathrm{d}  R^2} +k^2 T=0$$
解为$$T(R)=Ae^{ikR}+Be^{-ikR}$$
所以$$G(R)=\frac{Ae^{ikR}+Be^{-ikR}}{R}$$
无界空间中的波动方程需要满足[[波动方程#Sommerfeld辐射条件]]，即只有向外传播的波，所以$B=0$。
常数按类似Poisson方程的方式求得，可以最终解得$$G(\vec{r};\vec{r}')=\frac{1}{4\pi}\cdot \frac{e^{ik|\vec{r}-\vec{r}'|}}{|\vec{r}-\vec{r}'|}$$