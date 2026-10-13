$ErrorActionPreference = 'Stop'

$path = '静态电磁场.md'
$text = Get-Content -LiteralPath $path -Raw

$directSection = @'
## 直接计算法
所谓直接计算法，就是从已知的场源分布或边界条件出发，直接运用Gauss定理、Ampere环路定理、势函数积分或分离变量法求解。它不额外引入等效源，基本思路就是先根据问题的对称性选取合适的方程，再利用边界条件确定积分常数或展开系数。
### 分布型问题：均匀带电球体
设半径为$R$的球体内均匀分布着体电荷，电荷体密度为$\rho$，球外是真空。由于电荷分布具有球对称性，电场只能沿径向分布，所以最方便的方法是使用Gauss定理。

当$r<R$时，半径$r$的Gauss面内包含的电荷为
$$q(r)=\frac{4\pi}{3}\rho r^3$$
于是
$$4\pi r^2E(r)=\frac{q(r)}{\varepsilon_{0}}$$
从而
$$E(r)=\frac{\rho r}{3\varepsilon_{0}},\qquad r<R$$
当$r>R$时，Gauss面包围球体的全部电荷
$$Q=\frac{4\pi}{3}\rho R^3$$
所以球外电场等效于位于球心的点电荷产生的电场：
$$E(r)=\frac{Q}{4\pi\varepsilon_{0}r^2},\qquad r>R$$
若取无穷远处电势为0，并要求电势在$r=R$处连续，则
$$arphi(r)=
\begin{cases}
\dfrac{\rho}{6\varepsilon_{0}}(3R^2-r^2),&r<R\\
\dfrac{Q}{4\pi\varepsilon_{0}r},&r>R
\end{cases}$$
这个例子展示了分布型问题的一般流程：先根据场源分布判断对称性，再直接使用积分公式或Gauss定理求场。如果场源没有足够的对称性，就应当改用电势积分
$$\varphi(\vec{r})=\frac{1}{4\pi\varepsilon_{0}}\iiint\frac{\rho(\vec{r}')}{|\vec{r}-\vec{r}'|}\mathrm{d}^3r'$$
最后再由$\vec{E}=-\nabla\varphi$得到电场。
### 边值型问题：矩形区域内的电势
考虑一个沿$z$方向无限延伸的矩形区域
$$0<x<a,\qquad 0<y<b$$
其内部没有电荷，$x=0$、$x=a$和$y=0$三条边接地，而$y=b$边保持电势$V_{0}$。区域内的电势满足Laplace方程
$$\nabla^2\varphi=0$$
和边界条件
$$arphi(0,y)=\varphi(a,y)=\varphi(x,0)=0,qquad \varphi(x,b)=V_{0}$$
根据[[位势方程#直角坐标系]]，令
$$\varphi(x,y)=X(x)Y(y)$$
并利用三个零电势边界，可选取本征函数
$$X_{n}(x)=\sin\frac{n\pi x}{a},\qquad Y_{n}(y)=\sinh\frac{n\pi y}{a}$$
再把上边界的常数电势$V_{0}$展开成正弦级数，就得到
$$\boxed{
\varphi(x,y)=\frac{4V_{0}}{\pi}
\sum_{n=1,3,5,\dots}\frac{1}{n}
\frac{\sinh(n\pi y/a)}{\sinh(n\pi b/a)}
\sin\frac{n\pi x}{a}
}$$
最后由$\vec{E}=-\nabla\varphi$即可得到区域内的电场。

这个例子展示了分离变量法处理边值问题的基本结构：根据区域形状选择坐标系，将位势写成若干单变量函数的乘积，用齐次边界条件确定本征函数，再将非齐次边界条件展开到这些本征函数上。具体的分离变量过程与各种坐标系下的通解见[[位势方程]]。
'@

$directMarker = '## 镜像法'
if (-not $text.Contains($directMarker)) {
    throw "Insertion marker not found: $directMarker"
}
if (-not $text.Contains('## 直接计算法')) {
    $text = $text.Replace($directMarker, $directSection.TrimEnd() + "`r`n" + $directMarker)
}

$quasistaticSection = @'
# 准静态电磁场
静态场要求场源和电磁场都不随时间变化，而*准静态电磁场*允许场源缓慢变化，只要求电磁作用在系统内部传播所需的时间远小于场源发生明显变化的时间。此时可以把每一个时刻的场分布近似看成由该时刻的场源“立即”建立起来，再根据问题保留必要的时间导数项。

因此，准静态并不等于静态。电荷、电流、电场和磁场仍然可以随时间变化，只是传播延迟和电磁辐射可以忽略。

## 准静态近似的判断
设系统的特征尺寸为$L$，介质中的电磁波传播速度为
$$v=\frac{1}{\sqrt{\mu\varepsilon}}$$
电磁作用穿过系统所需的时间约为
$$\tau_{\mathrm{em}}=\frac{L}{v}=L\sqrt{\mu\varepsilon}$$
若场源变化的特征时间为$T$，只要
$$\boxed{\frac{\tau_{\mathrm{em}}}{T}\ll1}$$
便可以忽略系统内部的传播延迟。

对于角频率为$\omega$的时谐场，可以取$T\sim1/\omega$，于是条件变为
$$\boxed{kL=\omega L\sqrt{\mu\varepsilon}\ll1}$$
其中$k=\omega\sqrt{\mu\varepsilon}$是波数。利用$k=2\pi/\lambda$，也可以写成
$$L\ll\frac{\lambda}{2\pi}$$
实际判断时常把它简略地说成“系统尺寸远小于波长”。

这个条件只保证可以忽略波的传播和辐射效应。接下来还需要根据体系在静态极限下主要储存电能还是磁能，判断采用电准静态近似还是磁准静态近似。

## 电准静态场
*电准静态近似*（Electroquasistatic Approximation，EQS）适用于以电荷和电场为主的体系。在这种情况下忽略Faraday电磁感应产生的涡旋电场，取
$$\nabla\times\vec{E}\approx0$$
因而每个时刻都可以定义瞬时电势
$$\vec{E}=-\nabla\varphi$$
但Ampere-Maxwell方程中的位移电流一般不能删去：
$$\nabla\times\vec{H}=\vec{J}+\frac{\partial\vec{D}}{\partial t}$$
所以电准静态场并不是普通静电场。电容器中的电荷可以变化，介质中也可以同时存在传导电流和位移电流，只是这些电流产生的磁感应反过来对电场的影响很小。

典型的电准静态体系包括电容器、静电传感器、静电执行器、缓慢变化的高阻抗电路和尺寸很小的半导体器件。

## 磁准静态场
*磁准静态近似*（Magnetoquasistatic Approximation，MQS）适用于以闭合电流和磁场为主的体系。在这种情况下忽略Ampere-Maxwell方程中的位移电流，取
$$\nabla\times\vec{H}\approx\vec{J}$$
但Faraday电磁感应定律必须保留：
$$\nabla\times\vec{E}=-\frac{\partial\vec{B}}{\partial t}$$
所以磁准静态场也不是普通静磁场。磁场可以随时间变化，并产生感应电场、电动势和涡流，只是位移电流以及由此形成的电磁波传播可以忽略。

在满足Ohm定律$\vec{J}=\sigma\vec{E}$的均匀导体内，传导电流和位移电流的数量级之比为
$$\frac{|\partial\vec{D}/\partial t|}{|\vec{J}|}\sim\frac{\omega\varepsilon}{\sigma}$$
若
$$\frac{\omega\varepsilon}{\sigma}\ll1$$
则导体内部通常可以忽略位移电流。线圈、变压器、电动机、电磁铁、涡流制动器和低频感应加热装置通常属于磁准静态问题。

## 实际例子
### 缓慢充放电的平行板电容器
设极板面积为$S$、间距为$d$的平行板电容器接在缓慢变化的电压$U(t)$上，且极板尺寸和引线长度都远小于相应波长。忽略边缘效应后，可以在每一个时刻直接套用静电场结论
$$E(t)\approx\frac{U(t)}{d}$$
于是
$$Q(t)=CU(t),\qquad C=\frac{\varepsilon S}{d}$$
电路中的电流为
$$I(t)=\frac{\mathrm{d}Q}{\mathrm{d}t}=C\frac{\mathrm{d}U}{\mathrm{d}t}$$
极板之间虽然没有传导电流，却存在位移电流
$$I_{d}=\iint_{S}\frac{\partial\vec{D}}{\partial t}\cdot\mathrm{d}\vec{S}=C\frac{\mathrm{d}U}{\mathrm{d}t}$$
这就是一个典型的电准静态问题：电势分布按静电场求解，时间变化则通过$U(t)$和位移电流进入。

例如，一个尺寸约$10\mathrm{\,cm}$、工作频率为$1\mathrm{\,kHz}$的电容器，在真空中的波长约为$300\mathrm{\,km}$，其尺寸远小于波长，可以很好地使用电准静态近似。

### 低频线圈和变压器
设长度为$l$、横截面积为$S$、总匝数为$N$的长螺线管中通有缓慢变化的电流$I(t)$。只要线圈尺寸远小于相应波长，就可以在每个时刻先按静磁场求解
$$B(t)\approx\mu\frac{N}{l}I(t)$$
再用Faraday定律计算感应电动势
$$\mathcal{E}=-N\frac{\mathrm{d}\Phi}{\mathrm{d}t}
=-\frac{\mu N^2S}{l}\frac{\mathrm{d}I}{\mathrm{d}t}
=-L_{s}\frac{\mathrm{d}I}{\mathrm{d}t}$$
其中
$$L_{s}=\frac{\mu N^2S}{l}$$
是线圈的自感。这个计算保留了磁感应，却没有求解从线圈向外传播的电磁波，所以属于磁准静态近似。工频变压器、电磁铁和低频电机通常都可以这样处理。

### 导体中的涡流和磁扩散
把一块金属板放在缓慢变化的磁场中，Faraday电磁感应会在板内产生涡旋电场，进而形成涡流。若忽略位移电流，并使用
$$\vec{J}=\sigma\vec{E},\qquad \vec{B}=\mu\vec{H}$$
可以由Faraday定律和Ampere定律推出磁扩散方程
$$\boxed{
\frac{\partial\vec{B}}{\partial t}
=\frac{1}{\mu\sigma}\nabla^2\vec{B}
}$$
相应的磁扩散时间尺度约为
$$\tau_{m}\sim\mu\sigma L^2$$
因此，金属板中的磁场并不是瞬间均匀建立的，而是逐渐向内部扩散。涡流制动、金属探测、低频感应加热和变压器铁芯中的涡流损耗都可以在磁准静态框架下分析。

对于时谐场，磁场在良导体中的典型穿透深度为
$$\delta=\sqrt{\frac{2}{\omega\mu\sigma}}$$
当导体厚度远小于$\delta$时，电流在截面上近似均匀；当厚度大于$\delta$时，就必须考虑[[趋肤效应]]或直接求解磁扩散方程。但即使存在趋肤效应，只要整个系统仍满足$kL\ll1$，问题仍然可以属于磁准静态问题。

### 低频集总电路
电路理论本质上就是一种准静态近似。只要整个电路的最大尺寸$L$远小于工作波长，电压和电流在各元件之间的传播时间就可以忽略，于是可以把电阻、电容和电感看成集总元件：
- 电容器主要是电准静态区域；
- 电感器和变压器主要是磁准静态区域；
- 电阻器主要表现为准恒定传导区域。

例如，尺寸为$1\mathrm{\,m}$的$50\mathrm{\,Hz}$电路，对应真空波长约为$6000\mathrm{\,km}$，显然可以采用集总电路模型。相反，尺寸为$10\mathrm{\,cm}$的$1\mathrm{\,GHz}$电路，对应波长只有约$30\mathrm{\,cm}$，此时$kL$已经不再远小于1，导线必须视为传输线，并考虑反射、驻波和辐射。

## 准静态近似失效的情况
出现以下情况时，不能再把问题当作准静态场：
- 系统尺寸与波长可比，传播延迟不可忽略；
- 导线或结构足够长，不同位置不能再认为具有同一瞬时电压或电流；
- 问题关注天线辐射、远场能流、反射、驻波或波阻抗；
- 电准静态问题中的磁感应修正，或磁准静态问题中的位移电流修正，已经与保留项同阶；
- 场源变化非常快，脉冲的上升时间与系统的电磁传播时间相当。

所以，判断一个问题能否使用准静态近似时，应当先比较$L$和$\lambda$，再判断体系是由电荷与电容效应主导，还是由闭合电流与电感效应主导。若二者都不可忽略，就必须回到[[时变电磁场]]中的完整Maxwell方程组。
'@

$text = [regex]::Replace(
    $text,
    '(?s)# 准静态电磁场.*\z',
    { param($match) $quasistaticSection.TrimEnd() + "`r`n" }
)

$text = [regex]::Replace($text, '(?m)^updated:\s*.*$', 'updated: 2026-10-13')
[System.IO.File]::WriteAllText((Join-Path (Get-Location) $path), $text, [System.Text.UTF8Encoding]::new($false))
