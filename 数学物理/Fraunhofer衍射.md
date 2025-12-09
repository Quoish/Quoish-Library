#光学 
在[[光的衍射#Fraunhofer近似]]中我们已经提到，Fraunhofer衍射的观测屏必须要距离衍射屏很远的位置。
实际上要实现这么远的距离会很麻烦，我们可以考虑用透镜代替这个情况。
平行的光束从衍射孔按不同角度出来时，会到无穷远点交汇；而加了透镜之后，平行的光束从衍射孔按不同的角度出来时，经过透镜会到焦平面上交汇；相当于我们用焦平面代替了无穷远处的平面，只不过是空间范围缩小，能量更加集中罢了。
所以我们研究Fraunhofer衍射时，往往是在焦平面上讨论的。

![[夫琅禾费衍射装置.png]]

上面的Fraunhofer衍射装置中，可以在透镜后的焦平面上观察到衍射图样。
现在假设开孔处光场均匀分布，即$\tilde{E}(x_{1},y_{1})=A$，因为透镜紧贴开孔，可以认为$z_{1}\approx f$。所以焦平面上
$$\tilde{E}(x,y)=- \frac{iA}{\lambda f} e^{ ik\left( f+\frac{x^2+y^2}{2f} \right) }\iint_{\Sigma} e^{ -ik(x_{1}x+y_{1}y)/f }\mathrm{d}x_{1}\mathrm{d}y_{1}=C\iint_{\Sigma} e^{ -ik(x_{1}x+y_{1}y)/f }\mathrm{d}x_{1}\mathrm{d}y_{1}$$
# Fraunhofer矩形孔衍射

![[夫琅禾费矩形孔衍射图样.png]]

对上图的矩形孔积分以后，可以得到
$$\boxed{\tilde{E}(x,y)=\tilde{E}_{0} \frac{\sin \alpha}{\alpha}\cdot \frac{\sin \beta}{\beta}}$$
其中$\tilde{E}_{0}=\tilde{E}(0,0)=Cab$，是观察屏中心处的光场复振幅。
而$\alpha,\beta$分别为
$$\begin{equation}
\left\{
\begin{aligned}
&\alpha=\frac{k}{2f} \cdot ax=a\frac{\pi}{\lambda }\cdot \frac{x}{f}\approx a \frac{\pi}{\lambda} \sin\theta_{1}\\
&\beta=\frac{k}{2f}\cdot by=b\frac{\pi}{\lambda }\cdot \frac{y}{f}\approx b \frac{\pi}{\lambda}\sin\theta_{2}
\end{aligned}
\right.
\end{equation}$$

其中$\theta_{1},\theta_{2}$是衍射方向和光轴的夹角，称为衍射角（这里利用了$\tan \theta\approx\sin \theta$，选用。
光强分布为
$$I(x,y)=I_{0} \left( \frac{\sin \alpha}{\alpha}\right)^2\cdot \left( \frac{\sin \beta}{\beta} \right)^2
$$
其中$I_{0}$是中心点$P_{0}$的光强。
## 衍射光强分布
对于沿$x$轴方向，有
$$I(x,0)=I_{0}\left( \frac{\sin \alpha}{\alpha}\right)^2$$
求导得到光强取极值的条件为
$$\tan \alpha=\alpha$$
可以得到光强分布如图：
![[夫琅禾费矩形孔衍射光强分布.png]]

称$\alpha=0$时为主极大，其他的极大值为次极大，剩下那些为0的就是极小。
$y$轴的情况一样。
## 中央亮斑
衍射图样的光能量主要集中在中心，其边缘就是$\alpha,\beta=\pi$的时候，也就是
$$x=\pm \frac{f\lambda}{a},\quad y=\pm \frac{f\lambda}{b}$$
的时候。
中央亮斑的面积为
$$S_{0}= \frac{4f^2\lambda^2}{ab}$$
可见，衍射孔越小，中央亮斑越大。
但是中心点的光强
$$I_{0}=\left| Cab \right| ^2=\frac{A^2 a^2b^2}{f^2\lambda^2}$$可见，衍射孔越小，中心点的能量越小。
# Fraunhofer单缝衍射
如果Fraunhofer矩形孔衍射中$a\gg b$，就变成了单缝衍射。
容易得到
$$\tilde{E}(x)=\tilde{E}_{0} \frac{\sin\alpha}{\alpha}$$
$$I(x)=I_{0} \left( \frac{\sin \alpha}{\alpha} \right)^2$$
称$\left( \frac{\sin \alpha}{\alpha} \right)^2$为单缝衍射因子。所以可以认为矩形孔衍射是两个单缝衍射因子的乘积。
## 图样特性
- 暗纹条件：取极小值的条件为$\alpha=m\pi$，也就是
$$\sin\theta=m \frac{\lambda}{a},\quad m= \pm 1, \pm 2,\dots$$
- 次级主极大/次极大：角宽度为（小角度近似）
$$\Delta \theta = \frac{\lambda}{a}$$
- 中央主极大：角宽度为（小角度近似）
$$\Delta \theta_{0}= 2\frac{\lambda}{a}$$

在小角度近似下，**所有次级大的角宽度都近似相等，且等于中央主极大半角宽度**。
## 白光照射
白光照明时，衍射条纹呈现彩色，中央是白色，向外依次是由紫到红变化。
# Fraunhofer多缝衍射

![[夫琅禾费多缝衍射装置.png]]

Fraunhofer多缝衍射实验装置如图所示。
在一块不透光的屏上，刻有$N$条等间距、等宽度的狭缝，其每条狭缝均平行于$y$方向，沿$x$方向的缝宽为$a$，相邻狭缝的间距为$d$。
平行光照射多缝时，最终在透镜后焦平面上形成的图样相当于各个单缝衍射图样的叠加，因此同时带有干涉和衍射的性质。
注意缝后透镜$L_{2}$的作用：
假如没有$L_{2}$，从不同缝出来的平行光在远处会落在不同的点，所以每个缝的单缝衍射图样的位置都不一样，会平移一段距离，叠加起来就会带有这种平移的影响。
但由于$L_{2}$的存在，从不同缝出来的平行光必定会在焦平面上交于同一个点，这就消灭了缝位置的影响，每一个缝产生的单缝衍射图样主极大中心都会在$P_{0}$点。
我们对整个多缝计算Fraunhofer衍射的积分，其中运用到了复指数的等比数列求和
$$\begin{align}
\tilde{E}(x)&=C\int_{l} e^{ -ikx_{1}x /f}\mathrm{d}x_{1}\\ \\
&=C\left( \int_{-a/2}^{a/2} e^{ -ikx_{1}x /f}\mathrm{d}x_{1} + \int_{d-a/2}^{d+a/2} e^{ -ikx_{1}x /f}\mathrm{d}x_{1}+\int_{2d-a/2}^{2d+a/2} e^{ -ikx_{1}x /f}\mathrm{d}x_{1}+\dots\int_{(N-1)d-a/2}^{(N-1)d+a/2} e^{ -ikx_{1}x /f}\mathrm{d}x_{1}\right) \\
&=C[1+e^{ -i\varphi }+e^{ -i 2\varphi }+\dots+e^{ -i (N-1)\varphi }]\int_{-a/2}^{a/2} e^{ -ikx_{1}x /f}\mathrm{d}x_{1} \\
&=C\cdot e^{ -i(N-1) \frac{\varphi}{2} } \frac{\sin \frac{N\varphi}{2}}{\sin \frac{\varphi}{2}}\cdot a \frac{\sin \alpha}{\alpha}
\end{align}$$
其中$\varphi=\frac{2\pi}{\lambda}d\sin \theta$，这是从两个相距为$d$的狭缝出来的光它们之间的相位差。
光强分布为
$$I(x)=I_{0} \left( \frac{\sin \alpha}{\alpha} \right)^2 \left( \frac{\sin \frac{N\varphi}{2}}{\sin \frac{\varphi}{2}} \right)^2
$$
其中$I_{0}$是中心点$P_{0}$的光强。
这里的$\left( \dfrac{\sin \alpha}{\alpha} \right)^2$是衍射的影响，$\left( \dfrac{\sin \frac{N\varphi}{2}}{\sin \frac{\varphi}{2}} \right)^2$是干涉的影响，可以看作是等振幅等相位差的多光束干涉受到单缝衍射的调制。
为了方便表示，我们改写为
$$\begin{equation}
\left\{
\begin{aligned}
&I(x)=I_{0} \left( \frac{\sin \alpha}{\alpha} \right)^2 \left( \frac{\sin N\beta}{\sin \beta} \right)^2\\
&\alpha=\frac{\pi}{\lambda}a\sin\theta\\
&\beta= \frac{\pi}{\lambda}d\sin\theta = \frac{\varphi}{2}
\end{aligned}
\right.
\end{equation}$$

![[多缝衍射光强分布.png]]

## 衍射光强的分布
### 极值
- 衍射：
	- 中央明纹/中央峰（Central Maximum）：$$\alpha=0 \implies \sin\theta=0$$
	- 极小（Minima）：$$\alpha=m\pi \implies a\sin\theta=m\lambda,\quad m=\pm 1,\pm 2,\dots,\quad 且m\neq 0$$
	- 次极大（Secondary Maxima）：$$\frac{d}{d\alpha}\left(\frac{\sin\alpha}{\alpha}\right)^2=0 \implies \tan\alpha=\alpha$$
- 干涉：
	- 相消：暗纹（Dark Fringes）$$N\beta=k\pi,\ \beta\neq k'\pi \implies d\sin\theta=\frac{k}{N}\lambda,\ k\neq Nk'$$
	- 相长：主极大（Principal Maxima）$$\beta=k\pi \implies d\sin\theta=k\lambda,\quad k=0,\pm 1,\pm 2,\dots$$
### 缺级
当干涉相长遇上了衍射极小，则原本会有一个主极大的地方会呈现暗纹，这个现象称作缺级。
$$\begin{equation}
\left\{
\begin{aligned}
&a\sin\theta=m\lambda\\
&d\sin\theta=k\lambda
\end{aligned}
\right.
\end{equation}\implies
\frac{d}{a}=\frac{k}{m},\quad k,m \in \mathbb{Z}/\{0\}$$
### 图样特性
- 中央峰/衍射中央亮斑角宽度$$\Delta \theta_{中央峰}=\frac{2\lambda}{a}$$
- 中央主极大角宽度$$\Delta \theta_{中央主极大}=\frac{2\lambda}{Nd}$$
- $m$级主极大角宽度$$\Delta \theta_{m级主极大}=\frac{2\lambda}{Nd\cos \theta_{m}}$$
- 若没有缺级现象，相邻主极大间的暗纹有$N-1$个，分别由$$d\sin \theta=\left( \frac{1}{N}+m \right)\lambda,d\sin \theta=\left( \frac{2}{N}+m \right)\lambda, \dots,d\sin \theta=\left( \frac{N-1}{N}+m \right)\lambda$$确定。
- 半角宽度是角宽度的一半。
## 狭缝数的影响
随着狭缝数目的增加，衍射图样有两个显著变化：
1. 光的能量向主极大位置集中（为单缝衍射的$N^2$倍）
2. 亮条纹变得细而亮（约为双光束干涉线宽的$1/N$倍）
# Fraunhofer圆孔衍射
![[夫琅禾费圆孔衍射.png]]
设光经过一个半径为$a$的圆孔发生Fraunhofer衍射，紧贴衍射孔的透镜焦距为$f$。
将积分公式作柱坐标变换得到$$\tilde{E}(\rho,\varphi)=C\int_{0}^{a}\int_{0}^{2\pi}e^{ -ik\rho_{1}\cos(\varphi_{1}-\varphi) }\rho_{1}\mathrm{d}\rho_{1}\mathrm{d}\varphi_{1}$$其中$\theta=\rho/f$（利用了$\theta\approx \tan \theta$），是衍射方向和光轴的夹角，称为衍射角。
根据[[Bassel函数#积分表达式]]的零阶情况$$J_{0}(x)=\frac{1}{2\pi}\int_{-\pi}^{\pi}e^{ -ix\sin \theta }\mathrm{d}\theta=\frac{1}{2\pi}\int_{0}^{2\pi}e^{ -ix \cos \theta}$$再利用[[Bassel函数#微分递推公式]]可以得到$$\boxed{\tilde{E}(\rho,\varphi)=\frac{2\pi a^2}{ka\theta}CJ_{1}(ka\theta)=SC\left[ \frac{2J_{1}(\Phi)}{\Phi} \right]}$$光强分布为$$\boxed{I(\rho,\varphi)=I_{0}\left[ \frac{2J_{1}(\Phi)}{\Phi} \right]^2}$$其中$I_{0}=S^2(A/\lambda f)^2$是中心点$P_{0}$点的光强，$S=\pi a^2$是圆孔面积，$\Phi=ka\theta$是圆孔边缘中心点与在同一$\theta$方向上光线之间的相位差。
## 衍射光强分布
由于$\Phi=ka\theta$，说明光强分布仅和衍射角$\theta$有关，而与方位角$\varphi$无关，这说明衍射图样为圆形。
求导得到光强取机制的条件为$$\frac{ \mathrm{d}   }{ \mathrm{d}  \Phi} \left[ \frac{J_{1}(\Phi)}{\Phi} \right]=-\frac{J_{2}(\Phi)}{\Phi}=0$$称$\Phi=0$时为主极大，其他的极大值为次极大，剩下那些为0的就是极小。
![[夫琅禾费圆孔衍射光强分布.png]]
## Airy斑
第一暗纹在$\Phi\approx 1.22\pi\approx 3.832$时取到，此之内的中央亮斑的能量占了全部能量的$83.78\%$，这个亮斑称为*Airy斑*。
Airy斑半径为$$\rho_{0}=0.61f \frac{\lambda}{a}=1.22 f\frac{\lambda}{D}$$Airy斑半角半径为$$\theta_{0}=0.61 \frac{\lambda}{a}=1.22 \frac{\lambda}{D}$$其中$D=2a$是衍射孔的直径。
由此可知Airy斑的面积为$$S_{0}=\frac{(0.61\pi f\lambda)^2}{S}$$其中$S=\pi a^2$为圆孔面积。
可见，*圆孔面积越小，Airy斑面积越大，衍射现象越明显*。当$S=0.61\pi f\lambda$时，$S_{0}=S$。
# 光学系统分辨本领
光学成像系统的分辨本领（分辨率）是指能分辨开两个靠近的点物或物体细节的能力，是光学成像系统的重要性能指标。
从几何光学的观点看，每个像点应该是一个几何点，因此，对于一个无像差的理想光学成像系统，其分辨本领应当是无限的，两个点物无论靠得多近，像点总可分辨开。
但实际上，光在通过光学系统时，总会因光学孔径产生衍射，这就限制了光学成像系统的分辨本领。
通常光学系统会有光阑、透镜外框等圆形孔径，因而讨论它们的分辨本领时，都是以Fraunhofer圆孔衍射为理论基础。
## Rayleigh判据
![[两个点物的衍射像的分辨.png]]
设有$S_{1}$和$S_{2}$两个非相干点光源，间距为$\varepsilon$，它们到直径为$D$的圆孔距离为$R$，则$S_{1}$和$S_{2}$对圆孔的张角$\alpha$为$\alpha=\varepsilon/R$（利用了$\alpha\approx \tan \alpha$的近似）。
它们的Airy斑角半径分别为$$\theta_{0}=1.22 \frac{\lambda}{D}$$John William Strutt（第三代Rayleigh男爵）提出：
>两个物点的衍射图样，如果其中一个的主极大位置刚好落在另一个的第一极小位置，就称这两个物点的像是可以被分辨的。

这被称作*Rayleigh判据*。
根据Rayleigh判据，所以：
- 当$\alpha\geq\theta_{0}$，两个物点的衍射图样可以区分；
- 当$\alpha<\theta_{0}$，两个物点的衍射图样不能区分。

于是$\theta_{0}$就被称作*角分辨率*。
## 人眼的分辨率
人眼的瞳孔直径通常为$1.5\mathrm{mm}\sim 6\mathrm{mm}$。
当瞳孔直径为$D_{e}=2\mathrm{mm}$时，对于最敏感的光波波长$\lambda_{e}=0.55\mathrm{mm}$，人眼的角分辨率为$$\alpha_{e}=1.22 \frac{\lambda_{e}}{D_{e}}\approx 3.3\times 10^{-4}\mathrm{rad}$$
## 望远镜的分辨率
两个物点发出波长$\lambda$的光波，对于直径$D$的望远镜，分辨率为$$\alpha=1.22 \frac{\lambda}{D}$$所以直径越大，望远镜的分辨能力越强，并且像的光强也增加了。所以天文望远镜通常做的很大。
通常在设计望远镜时，应该使望远镜的放大率保证物镜的最小分辨率放大之后等于眼镜的最小分辨率。