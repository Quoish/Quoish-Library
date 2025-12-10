#统计物理 
# Fermi分布
根据[[三种粒子系统分布的微观状态数#费米系统的微观状态数]]，两边取对数
$$\ln W=\sum_{l}\{ \ln g_{l}!-\ln N_{l}!-\ln(g_{l}-N_{l})! \}$$
假设$g_{l}\gg 1$，$N_{l}\gg 1$，$g_{l}-N_{l}\gg 1$，并利用Stirling公式。
$$\ln W=\sum_{l}\{ g_{l}\ln g_{l}-N_{l}\ln N_{l}-(g_{l}-N_{l})\ln(g_{l}-N_{l}) \}$$
设Lagrange函数
$$\mathcal{L}=\ln W+\alpha\left( N-\sum_{l}N_{l} \right)+\beta\left( \sum_{l}N_{l}\varepsilon_{l}-E \right)$$
满足$$\left.\frac{ \partial  \mathcal{L} }{ \partial  N_{l}}  \right|_{N_{l}=N_{l}^0}=0  $$
于是$$N_{l}^0 =\frac{g_{l}}{e^{\alpha+\beta \varepsilon_{l}}+1},\quad l=0,1,2,\dots$$
这就是Fermi系统的最可几分布，称为Fermi-Dirac分布。
# 热力学公式
## 巨配分函数
$$\tilde{Z}=\prod_{l}(1+e^{-\alpha - \beta \varepsilon_{l}})$$
这个公式的由来见[[系综理论#理想Fermi气体的巨分配函数]]。
## 粒子总数
$$N=-\frac{ \partial  \ln \tilde{Z} }{ \partial  \alpha} $$
## 内能
$$U=-\frac{ \partial  \ln \tilde{Z} }{ \partial  \beta} $$
## 广义力
$$Y=-\frac{1}{\beta}\frac{ \partial  \ln \tilde{Z} }{ \partial  y} $$
## 熵
$$S=k_{B}\left( \ln \tilde{Z}-\alpha \frac{ \partial  \ln \tilde{Z} }{ \partial  \alpha} -\beta \frac{ \partial  \ln \tilde{Z} }{ \partial  \beta}  \right)$$
## 参数
$$\alpha = -\frac{\mu}{k_{B}T},\quad \beta=\frac{1}{k_{B}T}$$
# Fermi海
我们可以用Fermi-Dirac分布来描述自由电子气，即是[[固体能带论#Sommerfeld自由电子气模型]]中的自由电子。
根据Fermi分布，温度为$T$时，能量为$\varepsilon$的一个量子态上的平均粒子数为
$$n(\varepsilon)=\frac{N_{l}}{g_{l}}=\frac{1}{e^{\frac{\varepsilon-\mu}{k_{B}T}}+1}$$
根据[[相空间#能量态密度]]，在体积$V$内，在能量范围$\varepsilon$~$\varepsilon+\mathrm{d}\varepsilon$范围内的量子态数目为
$$2\cdot g(\varepsilon)\mathrm{d}\varepsilon=2\cdot \frac{2\pi V}{h^3}(2m)^{3/2}\varepsilon^{1/2}\mathrm{d}\varepsilon$$
乘了一个2是考虑到电子有两个自旋方向。于是可以计算
$$N=\frac{4\pi V}{h^3}(2m)^{3/2}\int_{0}^{\infty}\frac{\varepsilon^{1/2}}{e^{\frac{\varepsilon-\mu}{k_{B}T}}+1}\mathrm{d}\varepsilon$$
$$U=\frac{4\pi V}{h^3}(2m)^{3/2}\int_{0}^{\infty}\frac{\varepsilon^{3/2}}{e^{\frac{\varepsilon-\mu}{k_{B}T}}+1}\mathrm{d}\varepsilon$$
可知，在给定$V,N,T$时，可以确定$\mu$
## Fermi能级
先讨论$T=0$时
易知此时有$$n(\varepsilon)=
\begin{cases}
1,\quad \varepsilon<\mu_{F}^0 \\
0,\quad \varepsilon>\mu_{F}^0
\end{cases}$$
其中$\mu_{F}^0$是$T=0$时的化学势，称为*Fermi能级*。
所以就可以简化
$$N=\frac{4\pi V}{h^3}(2m)^{3/2}\int_{0}^{\mu_{F}^0}\varepsilon^{1/2}\mathrm{d}\varepsilon$$
解出可得
$$\boxed{\mu_{F}^0=\frac{h^2}{2m}\left( \frac{3N}{8\pi V} \right)^{2/3}=\frac{\hbar^2}{2m}\left( \frac{3\pi^2N}{V} \right)^{2/3}}$$
这是一个非常大的量$\mu_{F}^0 \gg k_{B}T$
电子总能量为$$U=\frac{3}{5}N\mu_{F}^0$$
电子的平均能量为
$$\bar{\varepsilon}=\frac{3}{5}\mu_{F}^0$$
可见，自由电子气即使在绝对零度时，由于泡利不相容原理，仍然有相当大的能量。
这时体系中各种状态的电子堆积在各个能级中，这样的状态被称作Fermi海。
$T=0$时体系的内能称为系统的零能点，具有零能点是Fermi子的通性。

---
现在谈论$T>0$时的情况
这个时候，$n(\varepsilon)$从阶跃函数变成Logistic曲线![[费米分布函数.png]]
我们同样定义Fermi能级：以$\mu_{F}$为界，小于和大于Fermi能级的电子数各占$1/2$。
注意：此时Fermi能级不再是像绝对零度时一样，是“电子海的海平面”，而是电子出现的概率为1/2的分界线。
相比绝对零度的情形，此时只有$\mu_{F}$附近以$k_{B}T$为数量级的范围内电子会发生变化，能从Fermi海跃迁到上面更高的能级。而绝大多数的电子被困在海深处，永世不得翻身，上方没有位置给他们跃迁，除非它们能克服Fermi能$\mu_{F}$那么多的能量，但这个概率很小。
![[费米海.jpg]]
## Sommerfeld展开
接下来我们要确定$T>0$时Fermi能级的大小。
同样从粒子数的积分出发$$N=\int_{0}^{+\infty}2g(\varepsilon)\bar{n}(\varepsilon,\mu_{F})\mathrm{d}\varepsilon$$现在引入一个辅助函数$$Q(\varepsilon)=\int_{0}^{\varepsilon}2g(\varepsilon)\mathrm{d}\varepsilon$$表示$2g(\varepsilon)$的原函数，然后分部积分$$N=\bar{n}(\varepsilon,\mu_{F})Q(\varepsilon)\left.  \right|_{0} ^{+\infty}+\int_{0}^{+\infty}Q(\varepsilon)\left( -\frac{ \partial  \bar{n} }{ \partial  \varepsilon}  \right)_{\mu_{F}}\mathrm{d}\varepsilon$$第一项等于0，因为$\varepsilon\to 0$时$Q(\varepsilon)$显然为0，而$\varepsilon\to \infty$时$\bar{n}(\varepsilon,\mu_{F})$会趋向0。所以$$N=\int_{0}^{+\infty}Q(\varepsilon)\left( -\frac{ \partial  \bar{n} }{ \partial  \varepsilon}  \right)_{\mu_{F}}\mathrm{d}\varepsilon$$
这里的$\left( \frac{ \partial  \bar{n} }{ \partial  \varepsilon} \right)_{\mu_{F}}$的性质如图，它只在$\mu_{F}$附近处有取值，而其他大部分位置全部是0，而且是关于$\varepsilon-\mu_{F}$的偶函数，这意味着它相当于有类似Dirac $\delta$函数的性质，可以记为$$D(\varepsilon-\mu_{F})=\frac{1}{k_{B}T} \frac{1}{(e^{ (\varepsilon-\mu_{F})/k_{B}T }+1)(e^{ -(\varepsilon-\mu_{F})/k_{B}T }+1)}$$![[费米分布相关函数.png]]所以我们可以把上面的积分下限写成$-\infty$而不影响积分值。
另一方面把$Q(\varepsilon)$以$\mu_{F}$为原点Taylor展开，取到二次项$$N=Q(\mu_{F})\int_{-\infty}^{+\infty}D(\varepsilon-\mu_{F})\mathrm{d}\varepsilon+Q'(\mu_{F})\int_{-\infty}^{+\infty}(\varepsilon-\mu_{F})D(\varepsilon-\mu_{F})\mathrm{d}\varepsilon+\frac{1}{2!}Q''(\mu_{F})\int_{-\infty}^{+\infty}(\varepsilon-\mu_{F})^2D(\varepsilon-\mu_{F})\mathrm{d}\varepsilon$$第一项是$Q(\mu_{F})$,，第二项是0，第三项设变量$\xi=\frac{\varepsilon-\mu_{F}}{k_{B}T}$，能得到$$\frac{(k_{B}T)^2}{2}Q''(\mu_{F})\int_{-\infty}^{+\infty} \frac{\xi^2\mathrm{d}\xi}{(e^{ \xi }+1)(e^{ -\xi }+1)}=\frac{(k_{B}T)^2}{2}Q''(\mu_{F})\cdot \frac{\pi^2}{3}$$最终$$N=Q(\mu_{F})+\frac{\pi^2}{6}Q''(\mu_{F})(k_{B}T)^2$$
从这个式子可以看出当$T\to 0$时，$$N=\lim_{ T \to 0 }Q(\mu_{F})=Q(\mu_{F}^0)\implies \lim_{ T \to 0 }\mu_{F}=\mu_{F}^0$$这说明我们的推断是正确的。
进一步，我们将$Q(\mu_{F})$以$\mu_{F}^0$为原点Taylor展开，取一阶项，$Q(\mu_{F})$也展开，只取零阶项$$N=Q(\mu_{F}^0)+Q'(\mu_{F}^0)(\mu_{F}-\mu_{F}^0)+\frac{\pi^2}{6}Q''(\mu_{F}^0)(k_{B}T)^2=N+Q'(\mu_{F}^0)(\mu_{F}-\mu_{F}^0)+\frac{\pi^2}{6}Q''(\mu_{F}^0)(k_{B}T)^2$$
我们记$$2g(\varepsilon)=C\varepsilon^{1/2},\quad Q(\varepsilon)=\frac{2}{3}C\varepsilon^{3/2},\quad Q'(\varepsilon)=C\varepsilon^{1/2},\quad Q''(\varepsilon)=\frac{1}{2}C\varepsilon^{-1/2}$$所以$$0=C(\mu_{F}^0)^{1/2}(\mu_{F}-\mu_{F}^0)+\frac{\pi^2}{6}\cdot \frac{1}{2}C(\mu_{F}^0)^{-1/2}(k_{B}T)^2$$
最终可以得到$$\boxed{\mu_{F}=\mu_{F}^0\left[ 1-\frac{\pi^2}{12}\left( \frac{k_{B}T}{\mu_{F}^0} \right)^2 \right]}$$这被称作Fermi能级的*Sommerfeld展开*。
一般意义上的Sommerfeld展开可以表示为$$\int_{0}^{+\infty}\phi(\varepsilon)\bar{n}(\varepsilon)\mathrm{d}\varepsilon=\int_{0}^{\mu_{F}}\phi(\varepsilon)\mathrm{d}\varepsilon+\frac{\pi^2}{6}(k_{B}T)^2\phi'(\mu_{F})+O(T^4)$$
## Fermi面
假定$N$个无相互作用的自由电子被限制在边长为$L$，体积为$V=L^3$的三维无限深势阱中。无相互作用意味着可以分离出单个电子的Schrödinger方程$$-\frac{\hbar^2}{2m}\nabla^2\psi(\vec{r})=E\psi(\vec{r})$$根据我们讨论[[一维无限深势阱]]得到的结论，可以得到波函数和能级$$\psi(\vec{r})=\frac{1}{\sqrt{ V }}e^{ i\vec{k}\cdot \vec{r} },\quad E(\vec{k})=\frac{\hbar^2k^2}{2m}$$
在之前我们已经揭示了绝对零度下自由电子气的图景：所有电子都处于Fermi能级之下，从基态开始向上堆积成一个Fermi海。当$T>0$时，只有少数电子能受到$k_{B}T$级别的能量激发从海平面跳出来，转移到比Fermi能级更高的能级，所以自由电子的能量状态的变化范围大约在$\mu_{F}$上下几个$k_{B}T$的能量范围内。
自由电子的能量可以直接用波矢$\vec{k}$来表示，即在$\vec{k}$空间中的一个点。其中$\varepsilon=\mu_{F}$的面具有特殊的意义，称为*Fermi面*（就是Fermi海的海平面）。当$T=0$时，所有电子都在Fermi面之内；而当$T>0$时，电子在$\mu_{F}$上下几个$k_{B}T$跳动。
Fermi面的半径就是*Fermi波矢*，绝对零度时的Fermi波矢为$$\vec{k}_{F}^0=\left(3\pi^2 \frac{N}{V} \right)^{1/3}$$Fermi面上电子的动量、速度称为Fermi动量和Fermi速度，还有所谓Fermi温度，也就是Fermi能级除以Boltzmann常数。
![[费米面与热激发.png]]
## 电子热容
根据电子的能量分布可以直接写出电子的总能量$$U=\int_{0}^{+\infty}\varepsilon \cdot2g(\varepsilon)\bar{n}(\varepsilon,\mu_{F})\mathrm{d}\varepsilon$$
我们用和上一节完全相同的方式计算上面的积分。同样记$R(\varepsilon)$是$2g(\varepsilon)$的原函数，应用Sommerfeld展开：$$U=R(\mu_{F})+\frac{\pi^2}{6}R''(\mu_{F})(k_{B}T)^2$$同样展开$$U=R(\mu_{F}^0)+R'(\mu_{F}^0)(\mu_{F}-\mu_{F}^0)+\frac{\pi^2}{6}R''(\mu_{F}^0)(k_{B}T)^2$$将上面得到的$\mu_{F}$计算式代入$$U=R(\mu_{F}^0)-\frac{\pi^2}{12}\left( \frac{k_{B}T}{\mu_{F}^0} \right)^2\mu_{F}^0R'(\mu_{F}^0)+\frac{\pi^2}{6}\left( \frac{k_{B}T}{\mu_{F}^0} \right)^2(\mu_{F}^0)^2R''(\mu_{F}^0)$$其中$$R(\varepsilon)=\frac{2}{5}C\varepsilon^{5/2},\quad R'(\varepsilon)=C\varepsilon^{3/2},\quad R''(\varepsilon)=\frac{3}{2}C\varepsilon^{1/2}$$所以得到下式，利用$R(\mu_{r}^0)=\frac{3}{5}N\mu_{r}^0$，$$U=R(\mu_{F}^0)\left[ 1+\frac{5\pi^2}{12}\left( \frac{k_{B}T}{\mu_{F}^0} \right)^2 \right]=\frac{3}{5}N\mu_{r}^0\left[ 1+\frac{5\pi^2}{12}\left( \frac{k_{B}T}{\mu_{F}^0} \right)^2 \right] $$
自由电子气的定容热容当为$$C_{V}=\left( \frac{ \partial  U }{ \partial  T}  \right)_{V}=\frac{\pi^2}{2}N\cdot \frac{k_{B}^2T}{\mu_{F}^0} =\frac{\pi^2}{2}Nk_{B} \frac{T}{T_{F}^0}=\gamma T$$其中$k_{B}T_{F}^0=\mu_{F}^0$为Fermi温度，$\gamma$被称为*Sommerfeld系数*。
可见，自由电子气的热容与$T$成线性关系。一般来说，$T_{F}^0$的大小约为$10^4\sim10^5\mathrm{K}$的量级，所以，常温下电子气对热容的贡献极小。主要原因在于，尽管金属中有大量的自由电子，但只有费米面附近T范围的电子才能受热激发而跃迁至较高的能级，所以电子气的热容很小。