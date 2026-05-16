#激光原理 #光学 
# Gauss光束行波场
在[[开式光腔#对称共焦腔的自再现模]]中我们已经知道了腔内的自再现模，使用Kirchhofer衍射公式就可以得到对称共焦腔内外任意一点的光场分布。
如果让自再现模从$z=-L/2$始向$z$正方向传播，那$u_{mn}(x,y,z=-L/2)=u_{mn}(x,y)$，根据衍射公式（纵方向走过$z+L$替换掉公式里的$L$）有$$u_{mn}(x,y,z)=\frac{ie^{ -ik(z+L/2) }}{\lambda(z+L/2)}\iint u_{mn}\left( x',y',-\frac{L}{2} \right)e^{ -ik[(x-x')^2+(y-y')^2]/2(z+L/2) }\mathrm{d}x'\mathrm{d}y'$$在Fresnel数很大时，因为$u_{mn}(x,y)$是本征矢，代入积分式中就是该本征矢乘上特征值。
Boyd和Gordon证明，可以经过一系列复杂的变量代换把最终的结果表示为
对于方形镜$$
\begin{equation}
\left.
\begin{aligned}
u_{mn}(x,y,z)=
&\sqrt{\frac{2}{\pi w_0^2} \frac{1}{2^{m+n}m!n!}}  \frac{w_{0}}{w(z)}
&光斑变化\\
&\times H_{m}\left( \frac{\sqrt{ 2 }}{w(z)}x \right)H_{n}\left( \frac{\sqrt{ 2 }}{w(z)}y \right)\exp\left( -\frac{x^2+y^2}{w^2(z)} \right)&本征模\\
&\times \exp\!\left[ -ikz - ik\frac{ x^2+y^2}{2R(z)} + i(m+n+1)\psi(z) \right]&传播特性
\end{aligned}
\right.
\end{equation}$$对于圆形镜$$\begin{equation}
\left.
\begin{aligned}
u_{pl}(r,\phi,z) &=   \sqrt{\frac{2p!}{\pi(p+l)!}} \frac{w_0}{w(z)}&光斑变化\\
&\times\left( \frac{\sqrt{2}\,r}{w(z)} \right)^{\!l} L_p^{\,l}\!\left( \frac{2r^2}{w^2(z)} \right) e^{ il\phi }\exp\!\left( -\frac{r^2}{w^2(z)} \right)&本征模\\
&\times\exp\!\left[ -ikz - ik\frac{ r^2}{2R(z)} + i(2p+l+1)\psi(z) \right]&传播特性
\end{aligned}
\right.
\end{equation}$$对于基模$\text{TEM}_{00}$$$u_{00}(x,y,z)=\sqrt{ \frac{2}{\pi} } \frac{w_{0}}{w(z)}\exp\left( - \frac{x^2+y^2}{w^2(z)} \right)\exp\left[ -ikz- ik \frac{x^2+y^2}{q(z)}+i\psi(z) \right]$$
其中：
- 光束复曲率：$$\frac{1}{q(z)}=\frac{1}{R(z)}-i \frac{\lambda}{\pi w^2(z)}$$
- 共焦参数/Rayleigh半径$z_{R}$或$f_{e}$：$$f_{e}=z_{R}=$$
