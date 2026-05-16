#激光原理 #光学 
# 对称共焦腔的Gauss光束
## Gauss行波场
在[[开式光腔#对称共焦腔的自再现模]]中我们已经知道了腔内的自再现模，使用Kirchhofer衍射公式就可以得到对称共焦腔内外任意一点的光场分布。
如果让自再现模从$z=-L/2$始向$z$正方向传播，那$u_{mn}(x,y,z=-L/2)=u_{mn}(x,y)$，根据衍射公式（纵方向走过$z+L$替换掉公式里的$L$）有$$u_{mn}(x,y,z)=\frac{ie^{ -ik(z+L/2) }}{\lambda(z+L/2)}\iint u_{mn}\left( x',y',-\frac{L}{2} \right)e^{ -ik[(x-x')^2+(y-y')^2]/2(z+L/2) }\mathrm{d}x'\mathrm{d}y'$$在Fresnel数很大时，因为$u_{mn}(x,y)$是本征矢，代入积分式中就是该本征矢乘上特征值。
Boyd和Gordon证明，可以经过一系列复杂的变量代换把最终的结果表示为
对于方形镜$$
\begin{equation}
\left.
\begin{aligned}
u_{mn}(x,y,z)=
&\sqrt{\frac{2}{\pi w_0^2} \frac{1}{2^{m+n}m!n!}}  \frac{w_{0}}{w(z)}
&光斑半径\\
&\times H_{m}\left( \frac{\sqrt{ 2 }}{w(z)}x \right)H_{n}\left( \frac{\sqrt{ 2 }}{w(z)}y \right)\exp\left( -\frac{x^2+y^2}{w^2(z)} \right)&本征模\\
&\times \exp\!\left[ -ikz - ik\frac{ x^2+y^2}{2R(z)} + i(m+n+1)\psi(z) \right]&相位特性
\end{aligned}
\right.
\end{equation}$$对于圆形镜$$\begin{equation}
\left.
\begin{aligned}
u_{pl}(r,\phi,z) &=   \sqrt{\frac{2p!}{\pi(p+l)!}} \frac{w_0}{w(z)}&光斑半径\\
&\times\left( \frac{\sqrt{2}\,r}{w(z)} \right)^{\!l} L_p^{\,l}\!\left( \frac{2r^2}{w^2(z)} \right) e^{ il\phi }\exp\!\left( -\frac{r^2}{w^2(z)} \right)&本征模\\
&\times\exp\!\left[ -ikz - ik\frac{ r^2}{2R(z)} + i(2p+l+1)\psi(z) \right]&相位特性
\end{aligned}
\right.
\end{equation}$$
## 基模Gauss光束
我们着重考察基模$\text{TEM}_{00}$$$u_{00}(x,y,z)=\sqrt{ \frac{2}{\pi} } \frac{w_{0}}{w(z)}\exp\left( - ik \frac{x^2+y^2}{q(z)} \right)\exp\left[ -ikz+i\psi(z) \right]$$
其中：
1. Gauss光束共焦参数$f_{e}$：
	- 对称共焦反射镜焦距（也叫Rayleigh半径$z_{R}$）$$f_{e}=\frac{R}{2}=\frac{L}{2}=\frac{\pi w_{0}^2}{\lambda}$$
	- 基模Gauss光束束腰半径$$w_{0}=\sqrt{ \frac{\lambda f_{e}}{\pi} }=\sqrt{ \frac{\lambda L}{2\pi} }=\sqrt{ \frac{\lambda R}{2\pi} }$$
2. 光束复曲率$q(z)$：
	- 光斑尺寸$w(z)$：$$w(z)=w_{0} \sqrt{1+ \left( \frac{z}{f_{e}}  \right)^2}$$
	- 等相位面曲率半径$R(z)$：$$R(z)=z\left( 1+\frac{f_{e}^2}{z^2} \right)$$
	- 光束复曲率$q(z)$：$$\frac{1}{q(z)}=\frac{1}{R(z)}-i \frac{\lambda}{\pi w^2(z)}$$
3. Gouy相移$\psi(z)$：$$\psi(z)=\arctan\left( \frac{z}{f_{e}} \right)$$
### 振幅分布与光斑尺寸
对场函数取模就能得到振幅分布$$|u_{00}(x,y,z)|=u_{0} \frac{w_{0}}{w(z)}\exp\left[ - \frac{r^2}{2w^2(z)} \right]$$可见基模Gauss光束在横截面内（$z=\mathrm{Const}$）遵循Gauss分布。
定义光强衰减到$1/e$的地方为光斑半径，则光斑半径就是$w(z)$。
$w(z)$在$z=0$处取最小值$w(0)=w_{0}$，称为*束腰半径*。
基模Gauss光束的光斑半径按双曲线变化$$\frac{w^2(z)}{w_{0}^2}-\frac{z^2}{f^2_{e}}=1$$
![[对称共焦腔内基模高斯光束.png]]
高阶模的情况：
- Hermite-Gauss光束$$w_{m}=\sqrt{ 2m+1 }w_{0},\quad w_{n}=\sqrt{ 2n+1 }w_{0}$$
- Laguerre-Gauss光束$$w_{pl}=\sqrt{ m+2n+1 }w_{0}$$
### 等相位面分布
对称共焦腔基模的相位因子为$$\exp\!\left[ -ikz - ik\frac{ r^2}{2R(z)}\right]\exp \left[ i(2p+l+1)\arctan\left( \frac{z}{f_{e}} \right) \right] $$第一项说明等相位面是球面波，第二项是附加相移。
总的来说，基模Gauss光束的等相位面是变心球面波，$z$处的曲率半径为$$R(z)=z+\frac{f^2_{e}}{z}$$
在$z$从0到$+\infty$变化时，球心从$-\infty$一直到0处移动，如下图所示。曲率半径在镜面处$z=f_{e}$取到最小值。![[共焦腔基模高斯光束等相位面分布.png]]
### 谐振频率
相位因子中的第二项，也就是Gouy相移的部分，会让一次单程渡越造成$\dfrac{\pi}{2}$的相移。
这个相移也能决定[[开式光腔#对称共焦腔的自再现模行波场#单程相移]]中决定的谐振频率，由它可以推得一样的公式：
- 方形镜$$\nu_{mnq}=\frac{c}{2L}\left[ q+\frac{1}{2}(m+n+1) \right]$$
- 圆形镜$$\nu_{mnq}=\frac{c}{2L}\left[ q+\frac{1}{2}(m+2n+1) \right]$$

稍后我们将会推广它们。
### 模体积
定性地说，模体积就是某一模式在腔内所占的空间范围。![[共焦腔内模体积示意图.png]]
可以视为圆柱体进行估算。
- 基模：$$V_{00}=\frac{1}{2}\pi w_{0}^2L=\frac{\lambda L^2}{4}$$
- 方镜：$$V_{mn}=(2m+1)(2n+1)V_{00}$$
- 圆镜：$$V_{mn}=(2p+l+1)V_{00}$$

模体积越大，参与光放大的工作介质也就越多，输出的功率也就越大。
# 一般稳定腔的Gauss光束
## 一般稳定腔的对称共焦等效
对于一般的稳定腔来说，由于不再是对称的了，自再现条件就变成了$$\sigma u_{j+2}=u_{j}$$意思就是本征方程会变成两次积分，这会非常麻烦，显然是很难求解的。
但是如果我们能让一个对称共焦腔和一般稳定腔等价，那根据我们已有的知识就能解决了。
那么我们等价是要何种意义上的等价关系呢？答案是要**有相同的行波场**。
接下来先证明：**对于任意一个对称共焦腔，存在无穷个稳定球面腔组成的等价类，它们关于“相同行波场”这个等价关系与对称共焦腔等价**。
前面已经指出，对称共焦腔的两个腔镜面恰好是腔模的两个等相位面，倘若在其他的等相位面放一个反射镜去代替其中一个反射镜，那原本的腔模肯定不会发生改变，这就构成了一个新谐振腔，它与原来那个对称共焦谐振腔等效。
然后我们可以证明这样的光腔是稳定腔。因为腔镜必须在等相位面上，所以$$R_{1}(z_{1})=-\left( z_{1}+\frac{f_{e}}{z_{1}} \right),\quad R_{2}(z_{2})=z_{2}+\frac{f_{e}}{z_{2}},\quad L=z_{2}-z_{1}$$可以证明$0<g_{1}g_{2}<1$，它是稳定的。
然后证明：**任意一个稳定腔，都可以找到一个对称共焦腔，这个对称共焦腔与原来那个稳定腔等价**。
只需要联立求解$$\begin{equation}
\left\{
\begin{aligned}
&R_{1}(z_{1})=-\left( z_{1}+\frac{f_{e}}{z_{1}} \right),\\
&R_{2}(z_{2})=z_{2}+\frac{f_{e}}{z_{2}},\\
&L=z_{2}-z_{1}
\end{aligned}
\right.
\end{equation}$$解得$$\begin{equation}
\left\{
\begin{aligned}
&z_{1}=L\cdot \frac{(1-g_{1})g_{2}}{g_{1}+g_{2}-2g_{1}g_{2}}\\
&z_{2}=L\cdot \frac{(1-g_{2})g_{1}}{g_{1}+g_{2}-2g_{1}g_{2}}\\
&f_{e}^2=L^2 \cdot \frac{(1-g_{1}g_{2})g_{1}g_{2}}{(g_{1}+g_{2}-2g_{1}g_{2})^2}
\end{aligned}
\right.
\end{equation}$$
