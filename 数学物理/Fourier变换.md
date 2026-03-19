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
- 