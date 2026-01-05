#电磁学 #场论
Maxwell方程组、Lorentz力公式、[[物质的电磁特性#物质方程]]构成了经典电磁学的全部图景。
Maxwell方程组由四部分组成：
- 积分形式：
	- 电场Gauss定理：$$\iint_{\Sigma}\kern{-18.8pt}\subset\kern{-2pt}\supset \vec{D}\cdot \mathrm{d}\vec{S}=\sum q$$
	- 磁场Gauss定理：$$\iint\kern{-16.8pt}\subset\kern{-2pt}\supset \vec{B}\cdot \mathrm{d}\vec{S}=0$$
	- Faraday电磁感应定理：$$\oint \vec{E}\cdot \mathrm{d}\vec{l}=-\iint\kern{-16.8pt}\subset\kern{-2pt}\supset \frac{ \partial  \vec{B} }{ \partial  t} \cdot \mathrm{d}\vec{S}   $$
	- 全电流Ampere环路定理：$$\oint \vec{H}\cdot\mathrm{d}\vec{l}=\sum (I+i)$$
- 微分形式：
	- 电场Gauss定理：$$\nabla \cdot\vec{D}=\rho$$
	- 磁场Gauss定理：$$\nabla \cdot \vec{B}=0$$
	- Faraday电磁感应定理：$$\nabla \times \vec{E}=-\frac{ \partial  \vec{B} }{ \partial  t} $$
	- 全电流Ampere环路定理：$$\nabla \times \vec{H}=\vec{J}+\vec{j}$$
# 电场的Gauss定理
-  积分形式
$$
\iint_{\Sigma}\kern{-18.8pt}\subset\kern{-2pt}\supset \vec{D}\cdot \mathrm{d}\vec{S}=\sum q
$$
-  微分形式
$$
\nabla \cdot\vec{D}=\rho
$$
Gauss定理是Coulumb定律的直接推论。
## Coulumb定律
Charles-Augustin de Coulumb经过大量实验发现：
处于$\vec{r}'$的点电荷$q'$作用于处于$\vec{r}$点电荷$q$的力为
$$\vec{F}=\frac{q'q}{4\pi\varepsilon_{0}} \frac{\vec{r}-\vec{r}'}{|\vec{r}-\vec{r}'|^3}=\frac{q'q}{4\pi\varepsilon_{0}} \frac{\vec{R}^0}{R^2}$$
这就是*Coulumb定律*。
## 电场强度
电荷$q'$对电荷$q$产生作用力，是因为$q'$在空间产生电场，电荷$q$在电场里受力。
我们使用*电场强度*描述电场，空间一点的电场强度$\vec{E}$定义为该点的单位试验电荷$q$所受到的力。
$$\vec{F}(\vec{r})=q \vec{E}(\vec{r})$$
位于$\vec{r}'$处的点电荷$q'$在$\vec{r}$处产生的电场强度为
$$\vec{E}(\vec{r})=\frac{q'}{4\pi\varepsilon_{0}} \frac{\vec{r}-\vec{r}'}{|\vec{r}-\vec{r}'|^3}=\frac{q'}{4\pi\varepsilon_{0}} \frac{\vec{R}^0}{R^2}$$
### 电位移矢量
电位移矢量是考虑[[物质的电磁特性]]后引入的折合量。
$$\vec{D}=\varepsilon \vec{E}=\varepsilon_{0}\vec{E}+\vec{P}$$
### 电通量
电场强度$\vec{E}$在有向曲面$\Sigma$上的通量称为*电通量*。
$$\Phi=\iint_{\Sigma}\vec{E}\cdot \mathrm{d}\vec{\sigma}$$
## Gauss定理
设任意闭合曲面$\Sigma$（Gauss面），其包裹的空间$\Omega$中在$\vec{r}'_{i}$处存在$q_{i}$的电荷。
我们计算这个闭合曲面的电通量$$\Phi=\iint_{\Sigma}\kern{-18.8pt}\subset\kern{-2pt}\supset \vec{E}\cdot \mathrm{d}\vec{\sigma}   $$
由Coulumb定律可知，在空间中任意$|\vec{r}-\vec{r}'|\neq 0$的区域，$\vec{E}$都解析，且$\nabla\cdot \vec{E}=0$。
因此在空间，挖$i$个小洞，把各个点电荷占的部位去掉，在这些地方，$\vec{E}$是解析的，可以利用[[广义Stokes定理#Gauss定理]]
$$\Phi=\iint_{\Sigma}\kern{-18.8pt}\subset\kern{-2pt}\supset \vec{E}\cdot \mathrm{d}\vec{\sigma}   =\iiint_{\Omega/\delta^3(\vec{r}-\vec{r}_{i}')} \nabla\cdot \vec{E}\mathrm{d}\omega+\sum_{i} \iint_{\delta(\vec{r}-\vec{r}'_{i})}\kern{-35.8pt}\subset\kern{-2pt}\supset \vec{E}\cdot \mathrm{d}\vec{\sigma}   =\sum_{i} \iint_{\delta(\vec{r}-\vec{r}'_{i})}\kern{-35.8pt}\subset\kern{-2pt}\supset \vec{E}\cdot \mathrm{d}\vec{\sigma}$$
对于那些点电荷，我们不妨设那些挖掉的小洞都是半径为$r_{\varepsilon}$的球体，此时可以不计点电荷之间的相互影响，各个点电荷的电场关于球体对称，每个点电荷的电通量都是
$$\Phi=\sum_{i} \iint_{\delta(\vec{r}-\vec{r}'_{i})}\kern{-35.8pt}\subset\kern{-2pt}\supset \vec{E}\cdot \mathrm{d}\vec{\sigma}=\sum_{i}4\pi r_{\varepsilon}^2 \cdot \frac{q_{i}}{4\pi\varepsilon r_{\varepsilon}^2}=\sum_{i} \frac{q_{i}}{\varepsilon}$$
因此证明了电场的Gauss定理$$\iint_{\Sigma}\kern{-18.8pt}\subset\kern{-2pt}\supset \vec{D} \cdot\mathrm{d}\vec{\sigma}=\sum_{i}q_{i}   $$
# 磁场的Gauss定理
- 积分形式
$$\iint\kern{-16.8pt}\subset\kern{-2pt}\supset \vec{B}\cdot \mathrm{d}\vec{S}=0$$
- 微分形式
$$\nabla \cdot \vec{B}=0$$

磁场的高斯定理源于“不存在磁单极”这一实验事实。
## 磁通量
磁感应强度在有向曲面上的通量称为*磁通量*
$$\Phi=\iint_{\Sigma}\vec{B}\cdot \mathrm{d}\vec{\sigma}$$
对于任何闭曲面，有穿出曲面的磁感应线，就有同样的穿入曲面的磁感应线，磁感应线必定首尾相连，没有断开。所以任意闭曲面的磁通量为0。
也可以利用Biot-Savart定律，证明$\nabla\cdot \vec{B}=0$。
# Faraday电磁感应定理
- 积分形式
$$\oint \vec{E}\cdot \mathrm{d}\vec{l}=-\iint\kern{-16.8pt}\subset\kern{-2pt}\supset \frac{ \partial  \vec{B} }{ \partial  t} \cdot \mathrm{d}\vec{S}   $$
- 微分形式
$$\nabla \times \vec{E}=-\frac{ \partial  \vec{B} }{ \partial  t} $$
## 感应电动势
Michael Faraday在实验中发现时变磁场会产生感应电动势。
当穿过闭合回路$C$所限定的曲面$\Sigma$的磁通量$\Phi$发生变化时，回路中会产生感应电动势$\mathscr{E}$，这被称为*Faraday电磁感应定律*。
感应电动势在回路中引起的感应电流产生阻止回路中磁通变化的磁场，这被称为*Lenz定律*。Lenz定律的规律可以总结为”来去拒留“。
数学表达式为$$\mathscr{E}=-\frac{ \partial  \Phi }{ \partial  t} =-\frac{ \partial   }{ \partial  t} \iint_{\Sigma} \vec{B} \cdot \mathrm{d}\vec{\sigma} $$
Lenz定律即体现在那个负号里。
对于多匝线圈，磁通量$\Phi$换成总磁通$\Psi$（磁链）。
## 感应电场
感应电动势是*感应电场*沿闭合回路$C$路径积分得到的。即
$$\mathscr{E}=\oint_{C}\vec{E}\cdot \mathrm{d}\vec{l}$$
联立即是Faraday电磁感应定律的积分形式$$\oint_{C} \vec{E}\cdot \mathrm{d}\vec{l}=-\iint_{\Sigma} \frac{ \partial  \vec{B} }{ \partial  t} \cdot \mathrm{d}\vec{S}   $$
# 全电流Ampere环路定理
- 积分形式
$$\oint \vec{H}\cdot\mathrm{d}\vec{l}=\sum (I+i)$$
- 微分形式
$$\nabla \times \vec{H}=\vec{J}+\vec{j}$$
## Ampere定律
Andre-Marie Ampere经过实验发现：
在真空中载有电流$I_{1}$的回路$C_{1}$上任意一线元$\mathrm{d}\vec{l}_{1}$对另一载有电流$I_{2}$的回路$C_{2}$上任一线元$\mathrm{d}\vec{l}_{2}$的作用力为
$$\mathrm{d}\vec{F}_{12}=\frac{\mu_{0}}{4\pi} \frac{I_{2}\mathrm{d}\vec{l}_{2} \times[I_{1}\mathrm{d}\vec{l}_{1}\times (\vec{r}-\vec{r}')]}{|\vec{r}-\vec{r}'|^3}$$
可以理解为第一个回路产生磁感应强度，第二个回路受Lorentz力，于是改写为
$$\vec{F}_{12}=\oint_{C_{2}}I_{2}\mathrm{d}\vec{l}_{2} \times \left(\frac{\mu_{0}}{4\pi} \oint_{C_{1}} \frac{I_{1}\mathrm{d}\vec{l}_{1} \times(\vec{r}-\vec{r}')}{|\vec{r}-\vec{r}'|^3} \right)$$
## Biot-Savart定律
定义磁感应强度
$$\vec{B}=\frac{\mu_{0}}{4\pi}\oint_{C_{1}} \frac{I_{1}\mathrm{d}\vec{l}_{1} \times(\vec{r}-\vec{r}')}{|\vec{r}-\vec{r}'|^3} $$
此为Biot-Savart定律。
若电流不是线电流，而是具有体分布的$\vec{J}(\vec{r}')$，则
$$\vec{B}(\vec{r})=\frac{\mu_{0}}{4\pi}\iiint_{\Omega} \frac{\vec{J}(\vec{r}')\times(\vec{r}-\vec{r}')}{|\vec{r}-\vec{r}'|^3}\mathrm{d}\omega'$$
## Ampere环路定理
计算$\vec{B}(\vec{r})$的旋度：
$$\nabla \times \vec{B}(\vec{r})=\frac{\mu_{0}}{4\pi}\iiint_{\Omega} \nabla \times \left( \vec{J}(\vec{r}')\times  \frac{\vec{r}-\vec{r}'}{|\vec{r}-\vec{r}'|^3} \right)\mathrm{d}\omega'$$
因为$\nabla$是对$\vec{r}$作用的，所以$\nabla_{\vec{J}}\times$的部分全部为0，可以直接用$(\vec{a}\cdot \vec{c})\vec{b}-(\vec{a}\cdot \vec{b})\vec{c}$展开双叉乘
$$\nabla \times \left( \vec{J}(\vec{r}')\times  \frac{\vec{r}-\vec{r}'}{|\vec{r}-\vec{r}'|^3} \right)=\left( \nabla\cdot \frac{\vec{r}-\vec{r}'}{|\vec{r}-\vec{r}'|^3} \right)\vec{J}(\vec{r}')-(\vec{J}(\vec{r}')\cdot \nabla) \frac{\vec{r}-\vec{r}'}{|\vec{r}-\vec{r}'|^3}$$
利用位矢矢量的性质：
对于第一项，$$\left( \nabla\cdot \frac{\vec{r}-\vec{r}'}{|\vec{r}-\vec{r}'|^3} \right)\vec{J}(\vec{r}')=\nabla^2\left( \frac{1}{|\vec{r}-\vec{r}'} \right)\vec{J}(\vec{r}')=\delta(\vec{r}-\vec{r}')J(\vec{r}')$$
我们发现，对第一项作积分已经能得到$\vec{J}(\vec{r})$。
对于第二项，因为
$$
\begin{align}
(\vec{A}\cdot \nabla_{B})\vec{B}&=(A_{x}\partial_{xB}+A_{y}\partial_{yB}+A_{z}\partial_{zB})\vec{B}\\
&=(\partial_{xB}A_{x}+\partial_{yB}A_{y}+\partial_{zB}A_{z})\vec{B} \\
&=\nabla_{B}(\vec{A}\cdot \vec{B})
\end{align}
$$
所以$$-(\vec{J}(\vec{r}')\cdot \nabla) \frac{\vec{r}-\vec{r}'}{|\vec{r}-\vec{r}'|^3}=-\nabla\left( \vec{J}(\vec{r}')\cdot \frac{\vec{r}-\vec{r}'}{|\vec{r}-\vec{r}'|^3} \right)=-\nabla\left( \vec{J}(\vec{r}')\cdot \nabla\left( \frac{1}{|\vec{r}-\vec{r}'} \right) \right)=\nabla\left( \vec{J}(\vec{r}')\cdot \nabla'\left( \frac{1}{|\vec{r}-\vec{r}'} \right) \right)$$
$\nabla$是可以提到积分号外面的，我们只用管里面的东西。
又因为
$$\nabla'\cdot\left( \frac{\vec{J}(\vec{r}')}{|\vec{r}-\vec{r}'|} \right)=(\nabla'\cdot \vec{J}(\vec{r}')) \frac{1}{|\vec{r}-\vec{r}'|}+\left( \vec{J}(\vec{r}')\cdot \nabla'\left( \frac{1}{|\vec{r}-\vec{r}'} \right) \right)$$
假如$\frac{ \partial  \rho }{ \partial  t} =0$，根据[[电荷守恒定律]]，$\nabla'\cdot \vec{J}(\vec{r}')$也为0。
所以积分的时候可以直接运用[[广义Stokes定理#Gauss定理]]。
$$\iiint_{\Omega}\nabla'\cdot\left( \frac{\vec{J}(\vec{r}')}{|\vec{r}-\vec{r}'|} \right)\mathrm{d}\omega'=\iint_{\Sigma}\kern{-18.8pt}\subset\kern{-2pt}\supset  \frac{\vec{J}(\vec{r}')}{|\vec{r}-\vec{r}'|}\cdot \mathrm{d}\vec{\sigma}  $$
我们完全可以把$\Sigma$选取为能把所有电流包裹进去的曲面，电流不会从曲面跑出来，也没有新的电流进去，所以在边界上我们有$\vec{J}(\vec{r}')=0$，那上面那个积分就为0了。
这样我们就在电荷不变的情况下（$\frac{ \partial  \rho }{ \partial  t} =0$）证明了Ampere环路定理
$$\nabla \times \vec{B}(\vec{r})=\mu_{0}\vec{J}(\vec{r})$$
## 位移电流
上面的Ampere环路定理推导依赖于$\dfrac{ \partial  \rho }{ \partial  t} =0$，对于时变场来说，这并不成立。
但若我们假定时变场依然成立电场的Gauss定理$\nabla\cdot \vec{D}=\rho$，重新改写电荷守恒定律$$\nabla\cdot \vec{J}+\frac{ \partial  \rho }{ \partial  t} =\nabla\cdot \vec{J}+\nabla\cdot \frac{ \partial  \vec{D} }{ \partial  t} =\nabla\cdot\left( \vec{J}+\frac{ \partial  \vec{D} }{ \partial  t}  \right)=0$$
这样我们能得到和静态场一样的形式。
James Maxwell认为$\dfrac{ \partial  \vec{D} }{ \partial  t}$也是一种形式的电流，称作*位移电流*，即$$\vec{j}=\frac{ \partial  \vec{D} }{ \partial  t} $$
引入位移电流的概念后，修正Ampere环路定理，就得到了全电流Ampere环路定理$$\nabla \times \vec{H}=\vec{J}+\vec{j}$$
# Lorentz力
## Coulumb力
电荷q在外电场$\vec{E}$作用下受到的力为$$\vec{F}=q\vec{E}$$
## Ampere力
电流元$I\mathrm{d}\vec{l}$在外磁场$\vec{B}$的作用下受到的力为
$$\mathrm{d}\vec{F} =I\mathrm{d}\vec{l}\times \vec{B}$$
## 狭义Lorentz力
以*相对于磁场速度*$\vec{v}$运动的电荷$q$在外磁场$\vec{B}$所受到的力为
$$\vec{F}=q \vec{v}\times \vec{B}$$
这是狭义Lorentz力公式。
## Lorentz力
以相对于磁场速度$\vec{v}$运动的电荷$q$在电磁场$(\vec{E},\vec{B})$中受到的力为
$$\vec{F}=q(\vec{E}+\vec{v}\times \vec{B})$$
此为*Lorentz力公式*。
# 电与磁的对称性关系
![[电磁学公式.png]]