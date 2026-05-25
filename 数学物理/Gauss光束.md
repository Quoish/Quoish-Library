#激光原理 #光学 
# 对称共焦腔的Gauss光束
## Gauss行波场
在[[开式光腔#对称共焦腔的自再现模]]中我们已经知道了腔内的自再现模，使用Kirchhoff衍射公式就可以得到对称共焦腔内外任意一点的光场分布。
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
	- 对称共焦反射镜焦距$$f_{e}=\frac{R}{2}=\frac{L}{2}=\frac{\pi w_{0}^2}{\lambda}$$
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
由此就能借$w_{0}=\sqrt{ \dfrac{\lambda f_{e}}{\pi} }$确定Gauss光束的所有光束。
## 一般稳定腔Gauss光束参数
### 镜面光斑尺寸

-  腔内光斑尺寸$$w(z)=w_{0} \sqrt{1+ \left( \frac{z}{f_{e}}  \right)^2}$$
- 镜$M_{1}$上的光斑半径$$w_{s1}=w(z_{1})=w_{0s}\sqrt[4]{ \frac{g_{2}}{g_{1}(1-g_{1}g_{2})} }$$
- 镜$M_{2}$上的光斑半径$$w_{s 2}=w(z_{2})=w_{0s}\sqrt[4]{ \frac{g_{1}}{g_{2}(1-g_{1}g_{2})} }$$
### 模体积
- 基模$$V_{00}=\frac{1}{2}L\pi\left( \frac{w_{s 1}+w_{s 2}}{2} \right)^2$$
- 方镜：$$V_{mn}=(2m+1)(2n+1)V_{00}$$
- 圆镜：$$V_{mn}=(2p+l+1)V_{00}$$

一般来说，在稳定图稳定区的内部，模体积跟对称共焦腔没太大差别。只有在靠近稳定区边界时，模体积会急剧增大。
### 等相位面
一般稳定腔的等相位面不能由$R$或$L$确定了，只能由$f_{e}$确定$$R(z)=z+\frac{f^2_{e}}{z}$$
### 谐振频率
一般稳定腔的谐振频率为Gouy相移所影响
- 方镜$$\nu_{mnq}=\frac{c}{2L}\left[ q+\frac{1}{\pi}\left(  m+n+1\right) \arccos \sqrt{ g_{1}g_{2} }\right]$$
- 圆镜$$\nu_{mnq}=\frac{c}{2L}\left[ q+\frac{1}{\pi}\left(  m+2n+1\right) \arccos \sqrt{ g_{1}g_{2} }\right]$$
### 平均单程损耗
在[[开式光腔#对称共焦腔自再现模的特性#单程损耗]]中我们已经知道，对称共焦腔中，单程损耗与Fresnel数$N_{F}$息息相关，Fresnel可以表示为$N_{F}=\dfrac{a^2}{\lambda L}=\dfrac{a^2}{\pi w_{0s}^2}$。
可以定义两个反射镜的*有效Fresnel数*为$$N_{F1\mathrm{eff}}=\frac{a^2}{\pi w_{s1}^2}=N_{F 0}\sqrt{ \frac{g_{1}}{g_{2}}(1-g_{1}g_{2}) }$$$$N_{F1\mathrm{eff}}=\frac{a^2}{\pi w_{s2}^2}=N_{F 0}\sqrt{ \frac{g_{2}}{g_{1}}(1-g_{1}g_{2}) }$$
这两个Fresnel数可以使用原来对称共焦腔的$N_{F}-\delta$对应表，查到对应的$\delta_{mn}^1$和$\delta_{mn}^2$，它们分别代表了在镜$M_{1}$和镜$M_{2}$的衍射损耗。
而一般稳定腔的单程平均损耗为$$\delta= \frac{1}{2}(\delta_{mn}^1+\delta_{mn}^2)$$
# Gauss光束的传输与变换
## 基模Gauss光束传输规律
### 远场发散角
前面的讨论表明，光斑尺寸按双曲线规律扩散。
那么远场发散角（全角）就是两渐近线的夹角$$2\theta_{00}=2\cdot \frac{\lambda}{\pi w_{0}}$$
### ABCD矩阵
- 腔内传输矩阵：它由复曲率参数$q$决定$$\frac{1}{q(z)}=\frac{D-A}{2B}+\frac{i}{B}\sqrt{ 1-\left( \frac{A+D}{2} \right)^2 }$$在束腰$z=0$处，$$q(0)=if_{e}$$
- 自由空间传输矩阵$$q(z)=\frac{Aq_{0}+B}{Cq_{0}+D}=if_{e}+z$$
### 能量传输孔径
光强分布$$I_{00}(r)=|u_{00}(r)|^2=u_{0}^2 \frac{w_{0}^2}{w^2(z)}\exp\left[ - \frac{2r^2}{w^2(z)} \right]$$
总功率$$P_{00}=\frac{1}{2}\pi u_{0}^2w_{0}^2$$在半径为$a$的区域内光场功率$$P_{00}(a)=P_{00}\left[ 1-\exp\left( - \frac{2a^2}{w^2(z)} \right) \right]$$
当$a=w(z)$时，通过86%的能量。
当$a=1.5w(z)$时，通过99%的能量。
所以一般都取孔径直径$d=2a=3w(z)$。
## Gauss光束透镜变换、会聚、准直
### Gauss光束薄透镜变换
我们研究高斯光束经过薄透镜的变换关系。
![[高斯光束薄透镜变换.png]]
设变换前的束腰半径为$w_{0}$，以前束腰为原点向右为正建立坐标系$z$，$z=l$处（取值为正）是透镜；变换后的束腰半径为$w_{0}'$，以后束腰为原点向右为正建立坐标系$z'$，$z'=l'$处（取值为负）是透镜。
以三阶段的方式描述整个变换过程：
1. 透镜前的空间（坐标系 $z$，原点在 $w_0$）：这时光束是在自由空间传播，遵从自由空间中的演化规律。
	- 复参数 $q(z)$：$$q(z) = z+ if_{e} = z + i\frac{\pi w_0^2}{\lambda}$$
	- 光斑半径 $w(z)$：$$w(z) = w_0 \sqrt{1 + \left( \frac{z}{f_e} \right)^2}$$
	- 曲率半径 $R(z)$：$$R(z) = z +  \frac{f^2_e}{z}  $$
2. 透镜界面（$z=l$、$z'=l'$处，$l>0,l'<0$）
薄透镜的$ABCD$传输矩阵为$$M=\begin{pmatrix}
1 &  0\\
-\dfrac{1}{F} & 1
\end{pmatrix}$$根据$ABCD$矩阵变换前后$q$参数的规律$$q'=\frac{Aq+B}{Cq+D}$$可以得到$$\boxed{\frac{1}{q(l)}- \frac{1}{q'(l')}=\frac{1}{F}}$$这与几何光学的薄透镜成像公式非常相似。几何光学中是球面波，所以参数$q$只有实部，这种情况下就退化成了薄透镜成像公式，体现了Gauss光学与几何光学的联系。
3. 透镜后的空间（坐标系 $z'$，原点在 $w'_0$）：这时光束以新的束腰 $w'_0$ 为基准进行自由传输。
	- 复参数 $q'(z')$：$$q'(z') = z' + if'_{e} = z' + i\frac{\pi w_0'^2}{\lambda}$$
	- 光斑半径 $w'(z')$：$$w'(z') = w_0' \sqrt{1 + \left( \frac{z'}{f'_e} \right)^2}$$
	- 曲率半径 $R'(z')$：$$R'(z') = z' +  \frac{f'^2_e}{z'}  $$

联立上面的方程，可以得到：
- 共焦参数与束腰半径变化率$$\frac{f_{e}'}{f_{e}}= \frac{w'^2_{0}}{w_{0}^2}= \frac{1}{\left( \dfrac{f_{e}}{F} \right)^2+\left( 1-\dfrac{l}{F} \right)^2}$$
- 束腰位置变换$$-l'=F+ \frac{(l-F)F^2}{(l-F)^2+f_{e}^2}$$
所以一个已知变换前Gauss光束特性，完整描述整个变换前后空间的流程应该是：
1. 计算变换前空间的束腰半径$w_0$，$f_{e}$，描述变换前空间的传输情况。
2. 根据方程$\dfrac{1}{q'(l')} = \dfrac{1}{q(l)} - \dfrac{1}{f}$，靠实部与虚部的匹配计算出$l'$和变换后束腰半径$w_0'$。
3. 计算变换后的$f_{e}'$，描述变换后空间的传输情况。
### Gauss光束会聚
这里只讨论单个薄透镜对Gauss光束的会聚作用。
上面已经讨论过，透镜变换前后束腰半径的关系为$$\frac{w_{0}'}{w_{0}}=\frac{F}{\sqrt{ f_{e}^2+(l-F)^2 }}$$
- $l=0$时，透镜起到会聚作用，$$\frac{w_{0}'}{w_{0}}<1,\quad -l'<F$$
- $0<l<F$时，$w_{0}'$随着$l$的增加而单调增大。
- $l=F$时，$w_{0}'$取最大值，且位于像方焦平面$$\frac{w_{0}'}{w_{0}}=\frac{F}{f_{e}},\quad -l'=F$$
- $l>F$时，$w_{0}'$随着$l$的增加而单调减小。
- $l=\infty$时，$$\frac{w_{0}'}{w_{0}}=0,\quad -l'=F$$
如下图所示：![[光斑尺寸随透镜距的变化.png]]

比较图中不同的$f_{e}/F$曲线可以发现，**短焦距透镜（$F$小）有更好的聚焦效果**，特别是当$F<f_{e}$时，透镜总是聚焦的。
### Gauss光束准直
上面的推导中我们已经知道束腰半径为$w_{0}$的物方Gauss光束发散角为$$\theta_{00}=\frac{\lambda}{\pi w_{0}}$$那么像方Gauss光束发散角就应该是$$\theta_{00}'=\frac{\lambda}{\pi w_{0}'}$$所以想让Gauss光束完全准直，就要像方发散角为0，那就只能让$\theta_{00}'\to \infty$，然而在$w_{0}'$有限的情况下，这根本做不到，所以利用光学系统把Gauss光束转换成$\theta_{00}=0$的平面波是不可能的。
那就退而求其次。因为$z=F$时$w_{0}'$取到极大值，像方发散角极小，这时$$\theta_{00}'=\frac{\lambda}{\pi w_{0}'}=\frac{w_{0}}{F}$$
因此在准直Gauss光束时通常会使用的思路是：
1. 先用一个透镜把束腰半径变小（$w_{0}$变小）。
2. 再让光经过一个长焦透镜（$F$要大）。

如下图倒置望远镜系统。
![[倒置望远镜系统对高斯光束的准直.png]]
## Gauss光束衍射倍率因子$M^2$
我们希望通过光学系统同时获得小的束腰半径和小的衍射角，然而小的束腰半径就意味着大的衍射角，二者是不能兼得的。但二者的乘积是一个定值，在光学系统中始终不变，**它是一个光学不变量**，我们将其定义为光束衍射倍率因子$M^2$$$w_{0}\cdot 2\theta_{00}=w_{0}'\cdot 2\theta_{00}'= \frac{2\lambda}{\pi}=M^2  \frac{2\lambda}{\pi}$$
它相当于是位置不确定量（$w_{0}$）和动量不确定量（$2\theta_{00}$）的乘积。
对于高阶模：
- Hermite-Gauss光束$$w_{m}\cdot 2\theta_{m}=(2m+1) \frac{2\lambda}{\pi},\quad w_{n}\cdot 2\theta_{n}=(2n+1) \frac{2\lambda}{\pi}$$$$M^2=2m+1,\quad M^2=2n+1$$
- Laguerre-Gauss光束$$w_{mn}\cdot 2\theta_{mn}=(m+2n+1) \frac{2\lambda}{\pi}$$$$M^2=m+2n+1$$

$M^2$因子被称为*Gauss光束衍射倍率因子*，它刻画的是实际Gauss光束与理想Gauss光束之间放大倍率的比值。
- $M^2=1$：代表理想Gauss基模光束，到达了物理定律允许的衍射极限。
- $M^2>1$：代表实际Gauss光束，掺杂了高阶横模、存在波前畸变。

同时$M^2$还反比于光源单色亮度，$M^2$越小，表明光源亮度越高、相干性越好。