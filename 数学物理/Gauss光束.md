#激光原理 #光学 
# Gauss光束行波场
在[[开式光腔#对称共焦腔的自再现模]]中我们已经知道了腔内的自再现模，使用Kirchhofer衍射公式就可以得到对称共焦腔内外任意一点的光场分布。
如果让自再现模从$z=-L/2$始向$z$正方向传播，那$u_{mn}(x,y,z=-L/2)=u_{mn}(x,y)$，根据衍射公式（纵方向走过$z+L$替换掉公式里的$L$）有$$u_{mn}(x,y,z)=\frac{ie^{ -ik(z+L/2) }}{\lambda(z+L/2)}\iint u_{mn}\left( x',y',-\frac{L}{2} \right)e^{ -ik[(x-x')^2+(y-y')^2]/2(z+L/2) }\mathrm{d}x'\mathrm{d}y'$$在Fresnel数很大时，因为$u_{mn}(x,y)$是本征矢，代入积分式中就是该本征矢乘上特征值。
Boyd和Gordon证明，可以经过一系列复杂的变量代换把最终的结果表示为
对于方形镜$$u_{mn}(x,y,z)=\frac{1}{2^{m+n}m!n!} \frac{2}{\sqrt{ \lambda L }} \frac{w_{0}}{w(z)}H_{m}\left( \frac{\sqrt{ 2 }}{w(z)}x \right)H_{n}\left( \frac{\sqrt{ 2 }}{w(z)}y \right)\exp\left(- \frac{x^2+y^2}{w^2(z)} -i(m+n+1)\psi(z)\right)$$对于圆形镜$$u_{mn}(\rho,\varphi,z)=\frac{1}{w(z)}\left( \frac{\sqrt{ 2 }r}{w(z)} \right)^n$$对于基模$\text{TEM}_{00}$，
其中：
- 束腰半径：$$$$
