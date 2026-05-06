#信号处理 #数理方法 
# Fourier级数
## Fourier级数的三角形式
$$f(t)=\frac{a_{0}}{2}+\sum_{k=1}^{+\infty}[a_{k}\cos(k\Omega t)+b_{k}\sin(k\Omega t)]$$
$$a_{k}=\frac{2}{T}\int_{-T/2}^{+T/2}f(t)\cos(k\Omega t)\mathrm{d}t$$
$$b_{k}=\frac{2}{T}\int_{+T/2}^{-T/2}f(t)\sin(k\Omega t)\mathrm{d}t$$
>*Gibbs现象*：Fourier级数在n趋于无穷时在间断点依然会产生9%的偏差，但是在均方根意义上可以收敛到原函数。 
## Fourier级数的特殊形式
- 奇函数：只有正弦分量，没有余弦分量。所谓奇函数指的是$$f(t)=-f(t)$$
- 偶函数：只有余弦分量，没有正弦分量。所谓偶函数指的是$$f(t)=f(-t)$$
- 奇谐函数：只有奇次谐波，没有偶次谐波。所谓奇谐函数指的是$$f(t)=-f(t+\frac{T}{2})$$
- 偶谐函数：只有偶次谐波，没有奇次谐波。所谓偶谐函数指的是$$f(t)=f(t+\frac{T}{2})$$
## Fourier级数的复指数形式
$$f(t)=\frac{1}{T}\sum_{k=-\infty}^{+\infty}F(jk\omega)Te^{ jk\Omega t }$$$$F(jk\Omega)T=\int_{t_{0}}^{t_{0}+T}f(t)e^{ -jk\Omega t }\mathrm{d}t$$更一般的表达式为$$f(t)=\sum_{k=-\infty}^{+\infty}F(jk\omega)e^{ jk\Omega t }$$$$F(jk\Omega)=\frac{1}{T}\int_{t_{0}}^{t_{0}+T}f(t)e^{ -jk\Omega t }\mathrm{d}t$$
它与三角形式的关系为$$F_n=\frac{1}{2}A_n e^{j\varphi_n}=\frac{1}{2}(a_n-jb_n)$$其中$A_{n}$称为*幅频特性*，$\varphi_{n}$称为*相频特性*。
- 幅频特性的偶函数性$$|F_n|=|F_{-n}|$$
- 相频特性的奇函数性$$\varphi_n=-\varphi_{-n}$$
## Fourier级数的审敛法
关于Fourier级数的收敛性有以下定理：
- 设$f(x)$在$[-\pi,\pi]$上可积或绝对可积，只要满以下两个条件其中一个，则$f(x)$的Fourier级数在$x$点收敛于$\dfrac{f(x_+)+f(x_-)}{2}$。
- *Dirichlet-Jordan判别法*：$f(x)$在$x$的某个邻域$U(x,\delta)$上，是分段单调的有界函数，则其Fourier级数收敛。
- *Dini-Lipschitz判别法*：$f(x)$在点$x$的处满足，指数为$\alpha(0<\alpha\leq1)$的Hölder条件，则其Fourier级数收敛。
	- *Hölder条件*：设点$x$是$f(x)$的第一类间断点，并设$p,q$，对于一个充分小的$\delta$，有$x-\delta<p<x<q<x+\delta$，若存在常数$L$和$\alpha\in(0,1]$，使得成立$$|f(p)-f(q)|<L|p-q|^\alpha$$则称$f(x)$满足指数为$\alpha$的Hölder条件，当$\alpha=1$时,也称为*Lipschitz条件*。
	- 单侧导数存在强于Lipschitz条件。
## Fourier级数的性质
- Fourier级数是$n$阶三角正交基下对$f(x)$的**最佳平方逼近**$$S_n(x)=\frac{a_0}{2}+\sum_{k=1}^{\infty}(a_k \cos kx+b_k\sin kx)$$逼近余项为$$||f(x)-S_n(x)||^2=\frac{1}{\pi}\int^\pi_{-\pi}f^2(x)\text{d}x-\left [ \frac{a_0^2}{2}+\sum_{k=1}^n(a_k^2+b_k^2) \right ]$$其中范数定义为$$(f,g)=\frac{1}{\pi}\int_{-\pi}^\pi f(x)g(x)\text{d}x,||f||=\sqrt{(f,f)}$$
- *Bassel不等式*：设$V$是一个内积空间，$\{e_n\}_{n=1}^{\infty}$是$V$中的一个正交归一基，则对任意向量$x \in V$，其Fourier系数$c_n = \langle x, e_n \rangle$ 满足：$$\sum_{n=1}^{\infty} |c_n|^2 \leq \|x\|^2$$
- *Parseval等式*：设$V$是一个**完备的**内积空间，$\{e_n\}_{n=1}^{\infty}$是$V$中的一个正交归一基，则对任意向量$x \in V$，其Fourier系数$c_n = \langle x, e_n \rangle$ 满足：$$\sum_{n=1}^{\infty} |c_n|^2 = \|x\|^2$$三角基的情况下，它表现为$$\frac{1}{\pi}\int^\pi_{-\pi}f^2(x)\text{d}x=\left [ \frac{a_0^2}{2}+\sum_{k=1}^{\infty}(a_k^2+b_k^2) \right ]$$
- *Weierstrass第二逼近定理*：对于周期为$2\pi$的任意一个连续函数$f(x)$都存在三角函数序列$$S_n(x)=\frac{a_0}{2}+\sum_{k=1}^{\infty}(a_k \cos kx+b_k\sin kx)$$使得$S_n(x)$**一致收敛**于$f(x)$。一致收敛意味着：
	- Fourier级数可逐项积分（积分与求和可换序）。
	- Fourier级数可逐项求导（导数与求和可换序）。
# Fourier变换
Fourier正变换$$f(t)=\int_{-\infty}^{+\infty}F(j\omega)e^{ j\omega t } \frac{\mathrm{d}\omega}{2\pi}$$Fourier逆变换
$$F(j\omega)=\int_{-\infty}^{+\infty}f(t)e^{ -j\omega t }\mathrm{d}t$$
## 常用Fourier变换公式
- 指数：
	- $$e^{-\alpha t}\varepsilon(t)\longrightarrow \frac{1}{\alpha+j\omega}$$
	- $$e^{-\alpha |t|}\varepsilon(t)\longrightarrow \frac{2\alpha}{\alpha^2+\omega^2}$$
- 门函数：
	- $$\text{gate}_{\tau}(t)\longrightarrow \tau\text{Sa}(\frac{\omega\tau}{2})$$
- 幂函数：
	- $$\delta(t)\longrightarrow 1$$
	- $$\delta'(t)\longrightarrow j\omega$$
	- $$\delta^{(n)}(t)\longrightarrow (j\omega)^n$$
	- $$1\longrightarrow 2\pi\delta(\omega)$$
	- $$t\longrightarrow 2\pi j\delta'(\omega)$$
	- $$t^n\longrightarrow 2\pi j^n\delta^{(n)}(\omega)$$
- 符号函数：
	- $$\text{sgn}(t)\longrightarrow \frac{2}{j\omega}$$
	- $$\varepsilon(t) \longrightarrow \pi\delta(\omega)+\frac{1}{j\omega}$$
	- $$|t|\longrightarrow -\frac{4\pi}{\omega^2}$$
- 周期函数：
	- $$e^{j\omega_0t}\longrightarrow 2\pi\delta(\omega-\omega_0)$$
	- $$\cos(\omega_0t)\longrightarrow \pi\left(\delta(\omega-\omega_0) + \delta(\omega+\omega_0)\right)$$
	- $$\sin(\omega_0t)\longrightarrow \frac{\pi}{j}\left(\delta(\omega-\omega_0) - \delta(\omega+\omega_0)\right)$$
- Dirac梳状函数：
	- $$\sum_{n=-\infty}^{+\infty}\delta(t-nT)\longrightarrow \Omega\cdot\sum_{k=-\infty}^{+\infty}\delta(\omega-k\Omega),$$其中$\Omega=\dfrac{2\pi}{T}$。
	- 重要恒等式：分布意义下$$\sum_{k=-\infty}^{+\infty} e^{j k \Omega t} = T\cdot \sum_{n=-\infty}^{+\infty} \delta\left(t - nT\right)$$$$\sum_{n=-\infty}^{+\infty}e^{ jk\omega T }=\Omega\cdot$$
## 微分特性
# 离散时间Fourier变换
$$f(n)=\int_{-\infty}^{+\infty}\tilde{F}(j\omega)e^{ j\omega n } \frac{\mathrm{d}\omega}{2\pi}$$
$$\tilde{F}(j\omega)=\sum_{n=-\infty}^{+\infty}f(n)e^{ -j\omega n }$$
# 离散Fourier级数
$$\tilde{f}(n)= \frac{1}{N}\sum_{k=0}^{N-1}F(jk\Omega)e^{ jk\Omega n }$$$$\tilde{F}(jk\Omega)=\sum_{n=0}^{N-1}f(n)e^{ -jk\Omega n }$$
# 离散Fourier变换
$$f(n)= \frac{1}{N}\sum_{k=0}^{N-1}F(jk\Omega)e^{ jk\Omega n }$$$$F(jk\Omega)=\sum_{n=0}^{N-1}f(n)e^{ -jk\Omega n }$$
# 快速Fourier变换

# 短时Fourier变换
DFT要求待分析或处理的信号是有限长序列，但在很多应用场合，信号往往是无限长或不定长的。尽管理论上我们可以存储全部信号，再实施一个很大点数的DFT，但通常计算这样一个DFT是不现实的，因为对存储空间的占用太大，处理延迟太长。
这就需要将信号切成一块块的切片，分别作DFT的方式来解决。
定义信号$x(n)$的短时Fourier变换为$$X(n,k\Omega)=\sum_{m=0}^{M-1}x(n+m)w(n)e^{ -j\omega m }$$其中$w(n)$是窗函数，在$0\leq n\leq M$以外的区域全部为0，是一个有限窗序列，用来给信号切片。
常用的窗序列有：
- 矩形窗：$$w(n)=\begin{equation}
\left\{
\begin{aligned}
&1,&0\leq n\leq M\\
&0,&其他
\end{aligned}
\right.
\end{equation}$$
- Bartlett窗（三角窗）：$$w(n)=\begin{equation}
\left\{
\begin{aligned}
& \frac{2n}{M},&0\leq n\leq \frac{M}{2}\\
& 2- \frac{2n}{M},& \frac{M}{2}\leq n\leq \frac{M}{2}\\
&0,&其他
\end{aligned}
\right.
\end{equation}$$
- Hanning窗（汉宁窗）：$$w(n)=\begin{equation}
\left\{
\begin{aligned}
&0.5-0.5\cos\left( \frac{2\pi n}{M} \right),&0\leq n \leq M\\
&0,&其他
\end{aligned}
\right.
\end{equation}$$
- Hamming窗（汉明窗）：$$w(n)=\begin{equation}
\left\{
\begin{aligned}
&0.54-0.46\cos\left( \frac{2\pi n}{M} \right),&0\leq n\leq M\\
&0,&其他
\end{aligned}
\right.
\end{equation}$$
- Blackman窗：$$w(n)=\begin{equation}
\left\{
\begin{aligned}
&0.42 -0.5\cos\left( \frac{2\pi n}{M} \right)+0.08 \cos\left( \frac{4\pi n}{M} \right),&0\leq n\leq M\\
&0,&其他
\end{aligned}
\right.
\end{equation}$$

除了Battlet窗，其他的都被叫做Blackman窗族，下面是它们的时域形状：![[布莱克曼窗族和巴特利特窗.png]]
短时Fourier变换是关于$n$和$k\Omega$的二维函数，因此它是随时间变化的，它可以分析频谱随时间的变化情况。
例如线性调频信号$x(n)=\cos(2\pi \times 7.5\times 10^{-6}\times n^2)$，其短时Fourier变换如图所示。![[线性调频信号的短时傅里叶变换.png]]
## 时域加窗的影响
设加窗前的序列为$x(n)=A_{0}\cos(\omega_{0}n+\theta_{0})+A_{1}\cos(\omega_{1}n+\theta_{1})$，以此为例展示加窗对DTFT频谱的影响：
![[加窗前后序列的频谱.png]]
加窗前后的频谱有两个主要的区别：
1. 宽度为零的谱线展宽成了有一定宽度的主瓣；
2. 产生了旁瓣。

主瓣的宽度以及旁瓣对主瓣的相对衰减均与W（e"）的主瓣宽度以及旁瓣相对衰减相同。
在加窗后的频谱中还可以分辨出有两个频率成分，并且可以大致估计出峰值的位置。
当$\omega_{0}$和$\omega_{1}$很靠近，以至于两个主瓣有重叠时，它们的幅度会因为互相影响而产生变化，称为*频谱泄漏*。
当主瓣重叠到一定程度，就不能分辨出两个频率成分了。
所以谱线的展宽导致无法准确判断谱线的位置和幅度，并且**导致频率分辨率降低**；而旁瓣的产生会**导致虚假频率成分的出现，并且可能淹没小幅度的频率成分**。
我们定义当$\Delta \omega=|\omega_{0}-\omega_{1}|$大于等于窗函数频谱$\tilde{W}(j\omega)$的主瓣宽$\Delta_{ml}$时两个频率成分是可以分辨的，即能分辨的最小频率间隔$\Delta \omega$等于$\tilde{W}(j\omega)$的主瓣宽$$\Delta \omega=\Delta_{ml}$$所以$\Delta_{ml}$越小，频谱分辨率越高。
![[常用窗函数主瓣宽度和旁瓣相对幅度.png]]
可以看出，主瓣宽度与窗形状及窗长有关。增加窗长，能减小主瓣宽度，从而提高频率分辨率。同样的窗长，矩形窗的主瓣宽最小，即频率分辨率最高，但其旁瓣衰减也最小。另外，窗越长则时间分辨率越低。所以**在选择窗长时需要在频率分辨率和时间分辨率之间折中**。
另外，旁瓣相对幅度与窗长无关，而只与窗形状有关，所以应该依据对旁瓣干扰的要求来选择合适的窗形状。如果要求旁瓣干扰小，则考虑Blackman窗而不是矩形窗，此时需加大窗长才能达到与采用矩形窗同样的频率分辨率。
## 频谱采样的影响
下面讨论$V(jk\Omega)$与$\tilde{V}(j\omega)$的关系。
![[加窗后序列的频谱及DFT.png]]
$V(jk\Omega)$是$\tilde{V}(j\omega)$在一个周期内的$N$等分取样，频域的取样可能导致对$\tilde{V}(j\omega)$的错误的估计，这种影响称之为*栅栏效应*。
两个频率分别为$\omega_{0}=\dfrac{2\pi}{14}$和$\omega_{1}=\dfrac{4\pi}{15}$时，其64点DFT幅度$|V(jk\Omega)|$如图(b)所示，它没有取到$\tilde{V}(j\omega)$的峰值幅度。
当两个频率分别为$\omega_{0}=\dfrac{2\pi}{16}$和$\omega_{1}=\dfrac{4\pi}{16}$时，其64点DFT幅度$|V(jk\Omega)|$如图(c)所示，它只取到了$\tilde{V}(j\omega)$的峰值和零值。
这两种情况都使采用$V(jk\Omega)$估计$\tilde{V}(j\omega)$存在很大偏差。
增加DFT的点数$N$能够取样到$\tilde{V}(j\omega)$更多的细节，因此常常使用时域补零的方法对傅里叶变换充分地过采样，以便将一些重要的频域细节表现出来。
当DFT点数足够大时，通过对$V(jk\Omega)$的线性内插就能得到对$\tilde{V}(j\omega)$相当精确的估计。所以，一般来说，**DFT点数$N$大于等于前面讨论的时域窗长$(M+1)$**。
为了得到傅里叶变换的精细取样，DFT点数越大越好，但点数大运算量也大，所以**DFT点数的选择也应在精度和运算量之间折中**。
需要注意的是，**频率分辨率不受DFT点数的影响**。