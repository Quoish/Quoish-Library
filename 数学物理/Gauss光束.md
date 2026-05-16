#激光原理 #光学 
# Gauss光束行波场
## Gauss行波场表达式
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
对称共焦腔基模的相位因子为$$\exp\!\left[ -ikz - ik\frac{ r^2}{2R(z)}\right]\exp \left[ i(2p+l+1)\arctan\left( \frac{z}{f_{e}} \right) \right] $$第一项说明等相位面是球面波。第二项是附加相移，一次单程渡越造成$\dfrac{\pi}{2}$的相移，这个相移也表现了[[开式光腔#对称共焦腔的自再现模行波场#单程相移]]中决定的谐振频率。
总的来说，基模Gauss光束的等相位面是变心球面波，$z$处的曲率半径为$$R(z)=z+\frac{f^2_{e}}{z}$$
在$z$从0到$+\infty$变化时，球心从$-\infty$一直到0处移动，如下图所示。曲率半径在镜面处$z=f_{e}$取到最小值。![[共焦腔基模高斯光束等相位面分布.png]]
