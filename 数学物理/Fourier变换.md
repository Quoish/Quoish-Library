#信号处理 #数理方法 
# Fourier级数
$$f(t)=\frac{1}{T}\sum_{k=-\infty}^{+\infty}F(jk\omega)Te^{ jk\Omega t }$$
$$F(jk\Omega)T=\int_{-\infty}^{+\infty}f(t)e^{ -jk\Omega t }\mathrm{d}t$$
# Fourier变换
$$f(t)=\int_{-\infty}^{+\infty}F(j\omega)e^{ j\omega t } \frac{\mathrm{d}\omega}{2\pi}$$$$F(j\omega)=\int_{-\infty}^{+\infty}f(t)e^{ -j\omega t }\mathrm{d}t$$
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
## 频谱采样的
![[加窗后序列的频谱及DFT.png]]