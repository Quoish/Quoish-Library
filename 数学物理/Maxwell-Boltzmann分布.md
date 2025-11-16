#统计物理 
Maxwell-Boltzmann分布（又称Boltzmann分布），是经典粒子系统的[[统计物理的方法#最可几分布|最可几分布]]
表达式可以通过对[[三种粒子系统分布的微观状态数#经典系统的微观状态数|经典系统的微观状态数]]求最值得到。
# Boltzmann分布
已知$$W=\frac{N!}{\prod_l N_l!}\prod_l g_l^{N_l}$$
为方便，两边取对数
$$\ln W=\ln N! +\sum_{l}N_{l}\ln g_{l}-\sum_{l}\ln N_{l}!$$
使用Stirling公式近似处理阶乘项，并利用$N=\sum_{l}N_{l}$，化为
$$\ln W=N\ln N-\sum_{l}N_{l}\ln N_{l}+\sum_{l}N_{l}\ln g_{l}$$
接下来在这两个约束$N=\sum_{l}N_{l}$，$E=\sum_{l}\varepsilon_{l}N_{l}$下求最值，需要用到Lagrange乘子法，设
$$\mathcal{L} = \ln W +(\alpha-1)\left( N-\sum_{l}N_{l} \right) +\beta\left( E-\sum_{l}\varepsilon_{l}N_{l} \right)$$
其中两个乘子被设为$\alpha-1$和$\beta$是为了方便后续的处理
这个函数需要满足$$\left.\frac{ \partial  \mathcal{L} }{ \partial  N_{l}}\right|_{N_{l}=N_{l}^0} =\ln g_{l}-\ln N_{l}-1-(\alpha-1)-\beta\varepsilon_{l}=0,\quad l=0,1,2,\dots$$
于是$$N_{l}^0 =\frac{g_{l}}{e^{\alpha+\beta \varepsilon_{l}}},\quad l=0,1,2,\dots$$
这就是Maxwell-Boltzmann分布的表达式，其中常数$\alpha$和$\beta$由
$$\begin{cases}
N=\sum_{l}g_{l}e^{-\alpha -\beta\varepsilon_{l}} \\
E=\sum_{l}g_{l}\varepsilon_{l}e^{-\alpha-\beta\varepsilon_{l}}
\end{cases}$$
确定。
# 热力学公式
## 配分函数
定义Boltzmann分布的配分函数$Z$为$$Z=\sum_{l} g_{l}e^{-\beta \varepsilon_{l}}$$
配分函数也称作状态函数，它的含义是系统所有状态的总和，由配分函数可以得到系统处于任一状态的概率$$P(E=\varepsilon_{i})= \frac{g_{i}e^{-\beta \varepsilon_{i}}}{\sum_{l}g_{l}e^{ -\beta\varepsilon_{l} }}=\frac{g_{i}e^{ -\beta \varepsilon_{i} }}{Z}$$
只要求出了配分函数，就可以得出各种状态量。
## 粒子总数
$$\boxed{N=e^{-\alpha}Z}$$
## 内能
$$\begin{align}
U&=\sum_{l}\varepsilon_{l}g_{l}e^{-\beta\varepsilon_{l}} \\ \\
&=e^{-\alpha}\left( -\frac{ \partial   }{ \partial  \beta} \sum_{l}g_{l}e^{-\beta\varepsilon_{l}} \right) \\
&=-e^{-\alpha}\frac{ \partial  Z }{ \partial  \beta}  \\
&=-\frac{N}{Z}\frac{ \partial  Z }{ \partial  \beta} =-N\frac{ \partial  \ln Z }{ \partial  \beta} 
\end{align}
$$
即
$$\boxed{U=-N\frac{ \partial  \ln Z }{ \partial  \beta}}$$
## 广义力
当广义坐标发生变化时，处于能级$\varepsilon_{l}$上的子系能量改变$\mathrm{d}\varepsilon_{l}$为
$$\begin{align}
\mathrm{d}\varepsilon_{l}=\frac{ \partial  \varepsilon_{l} }{ \partial  y} \mathrm{d}y
\end{align}$$
由此产生的内能改变量可看作广义力的做功为
$$\mathrm{d}U=\sum_{l}N_{l}\mathrm{d}\varepsilon_{l}=\sum_{l}N_{l}\frac{ \partial  \varepsilon_{l} }{ \partial  y} \mathrm{d}y=Y\mathrm{d}y$$
由此广义力为
$$Y=\sum_{l}N_{l}\frac{ \partial  \varepsilon_{l} }{ \partial  y} $$
代入Boltzmann分布
$$Y=e^{-\alpha}\left( -\frac{1}{\beta}\frac{ \partial   }{ \partial  y} \sum_{l}g_{l}e^{-\beta \varepsilon_{l}} \right)=\frac{N}{Z}\left( -\frac{1}{\beta}\frac{ \partial  Z }{ \partial  y}  \right)=-\frac{N}{\beta}\frac{ \partial  \ln Z }{ \partial  y} $$
其中的特例是$y=V,Y=-P$时
$$\boxed{P=\frac{N}{\beta}\frac{ \partial  \ln Z }{ \partial  V} }$$
## 热量
对内能$U=\sum_{l}N_{l}\varepsilon_{l}$做全微分，再比较热力学第一定律
$$\mathrm{d}U=Y\mathrm{d}y+\mathrm{d}Q$$
$$\mathrm{d}U=\sum_{l}N_{l}\mathrm{d}\varepsilon_{l}+\sum_{l}\varepsilon_{l}\mathrm{d}N_{l}$$
可知，*外界对体系做功使得子系能级发生变化，但不影响分布；传热改变体系分布，但不改变能级*。
## 熵
由热力学第一定律得
$$\mathrm{d}Q=\mathrm{d}U+P\mathrm{d}V=-N\mathrm{d}\left( \frac{ \partial  \ln Z }{ \partial  \beta}\right) +\frac{N}{\beta}\frac{ \partial  \ln Z }{ \partial  V} \mathrm{d}V $$
两端乘以$\beta$得到
$$\beta\mathrm{d}Q=-N\beta\mathrm{d}\left( \frac{ \partial  \ln Z }{ \partial  \beta}\right) +N\frac{ \partial  \ln Z }{ \partial  V} \mathrm{d}V $$
注意到
$$\mathrm{d}\ln Z=\frac{ \partial  \ln Z }{ \partial  \beta} \mathrm{d}\beta + \frac{ \partial  \ln Z }{ \partial  V} \mathrm{d}V$$
$$\mathrm{d}\left( \beta \frac{ \partial  \ln Z }{ \partial  \beta}  \right)=\beta \mathrm{d}\left( \frac{ \partial  \ln Z }{ \partial  \beta}  \right)+\frac{ \partial  \ln Z }{ \partial  \beta} \mathrm{d}\beta$$
利用这两个式子，原式可变为
$$\beta \mathrm{d}Q=N\mathrm{d}\left( \ln Z-\beta \frac{ \partial  \ln Z }{ \partial  \beta}  \right)$$
于是发现，$\beta$乘以$\mathrm{d}Q$可以变为一个状态量的全微分。由热力学知，只有$$\frac{1}{T}\mathrm{d}Q=\mathrm{d}S$$能做到，$\beta$和$\frac{1}{T}$必然成比例。
所以$$\beta=\frac{1}{k_{B}T}$$
其中$k_{B}$称为Boltzmann常数。
进而可以看出
$$\mathrm{d}S=Nk_{B}\mathrm{d}\left( \ln Z-\beta \frac{ \partial  \ln Z }{ \partial  \beta}  \right)$$
得到
$$\boxed{S=Nk_{B}\left( \ln Z-\beta \frac{ \partial  \ln Z }{ \partial  \beta}  \right)}$$
继续变形，
把$\ln Z=\alpha +\ln N$、$U=-N\frac{ \partial  \ln Z }{ \partial  \beta}$代入，再利用$N=\sum_{l}N_{l}^0$、$E=\sum_{l}\varepsilon_{l}N_{l}^0$
$$
\begin{align}
S&=Nk_{B}\left( \ln Z-\beta \frac{ \partial  \ln Z }{ \partial  \beta}  \right) \\ 
&=k_{B}\left( N\ln Z-\beta N\frac{ \partial  \ln Z }{ \partial  \beta}  \right) \\
&=k_{B}(N\ln N+\alpha N+\beta U) \\
&=k_{B}\left[ N\ln N+\sum_{l}(\alpha+\beta\varepsilon_{l})N_{l}^0 \right]
\end{align}$$
由$N_{l}^0 =\frac{g_{l}}{e^{\alpha+\beta \varepsilon_{l}}}$得到的$\alpha+\beta\varepsilon_{l}=\ln g_{l}-\ln N_{l}^0$代入上式可得
$$S=k_{B}\left[ N\ln N+\sum_{l}N_{l}^0\ln g_{l}-\sum_{l}N_{l}^0\ln N_{l} \right]$$
对比经过Stirling公式近似之后得到的
$$\ln W=N\ln N-\sum_{l}N_{l}\ln N_{l}+\sum_{l}N_{l}\ln g_{l}$$
可以发现
$$S=k_{B}\ln W^0$$
不过在宏观系统下，最可几分布的微观状态数$W^0$几乎就完全等于所有可能的微观状态数$W$，所以可以直接认为
$$\boxed{S=k_{B}\ln W}$$
这就是*Boltzmann关系*。
## Helmholtz自由能
由上面推导的内能、熵和配分函数的关系，再根据$F=U-TS$可以得到$$\boxed{F=-Nk_{B}T\ln Z}$$
# 经典近似
配分函数的计算是一个求和过程，这样的计算有的时候非常复杂
为了简化计算，我们可以考虑子系能级很密集的情况，即当
$$\Delta \varepsilon \ll k_{B}T$$时，求和变积分，我们有
$$\sum_{l}g_{l}\approx \int\dots \int \frac{\mathrm{d}q_{1}\dots\mathrm{d}q_{r}\mathrm{d}p_{1}\dots \mathrm{d}p_{r}}{h^r}$$所以配分函数可以由下面的公式计算$$Z\approx \int\dots \int e^{ -\beta\varepsilon }\frac{\mathrm{d}q_{1}\dots\mathrm{d}q_{r}\mathrm{d}p_{1}\dots \mathrm{d}p_{r}}{h^r}$$
# Maxwell速度分布率
根据经典近似下Boltzmann分布，可以得到粒子总数可以为$$N=\frac{e^{ -\alpha }}{h^3}\int\dots \int e^{ -(p_{x}^2+p_{y}^2+p_{z}^2)\beta/2m }\mathrm{d}x\mathrm{d}y\mathrm{d}z\mathrm{d}p_{x}\mathrm{d}p_{y}\mathrm{d}p_{z}=\frac{e^{ -\alpha }V}{h^3}\iiint e^{ -(p_{x}^2+p_{y}^2+p_{z}^2)\beta/2m }\mathrm{d}p_{x}\mathrm{d}p_{y}\mathrm{d}p_{z}$$利用$\vec{p}=m\vec{v}$，$$N=\frac{e^{ -\alpha }Vm^3}{h^3}\iiint_{-\infty}^{+\infty} e^{ -(v_{x}^2+v_{y}^2+v_{z}^2)\frac{m}{2kT} }\mathrm{d}v_{x}\mathrm{d}v_{y}\mathrm{d}v_{z}$$将积分计算出来（Gauss积分）可以得到$$e^{ -\alpha }=\frac{N}{V}\left( \frac{h^3}{2\pi mkT} \right)^{3/2}$$于是上面那个式子变为$$N=\frac{Nm^3}{h^3}\left( \frac{h^3}{2\pi mkT} \right)^{3/2}\iiint_{-\infty}^{+\infty} e^{ -(v_{x}^2+v_{y}^2+v_{z}^2)\frac{m}{2kT} }\mathrm{d}v_{x}\mathrm{d}v_{y}\mathrm{d}v_{z}$$称$$f(v_{x},v_{y},v_{z})=\frac{Nm^3}{h^3}\left( \frac{h^3}{2\pi mkT} \right)^{3/2}e^{ -(v_{x}^2+v_{y}^2+v_{z}^2)\frac{m}{2kT} }$$为*Maxwell速度分布率*。
# 非简并性条件
若$\alpha\gg 1$时，[[Bose-Einstein分布]]、[[Fermi-Dirac分布]]都可以近似为Maxwell-Boltzmann分布，即
$$\frac{g_{l}}{e^{\alpha+\beta \varepsilon_{l}}+1}\approx\frac{g_{l}}{e^{\alpha+\beta \varepsilon_{l}}-1}\approx\frac{g_{l}}{e^{\alpha+\beta \varepsilon_{l}}}$$
