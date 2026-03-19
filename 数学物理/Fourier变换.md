#信号处理 #数理方法 
# Fourier级数

# Fourier变换
## 微分特性
# 离散时间Fourier变换
$$f(n)=\int_{-\infty}^{+\infty}\tilde{F}(j\omega)$$
$$\tilde{F}(j\omega)=\sum_{n=-\infty}^{+\infty}f(n)e^{ -j\omega n }$$
# 离散Fourier级数
$$\tilde{f}(n)= \frac{1}{N}\sum_{k=0}^{N-1}F(jk\Omega)e^{ jk\Omega n }$$$$\tilde{F}(jk\Omega)=\sum_{n=0}^{N-1}f(n)e^{ -jk\Omega n }$$
# 离散Fourier变换
$$f(n)= \frac{1}{N}\sum_{k=0}^{N-1}F(jk\Omega)e^{ jk\Omega n }$$$$F(jk\Omega)=\sum_{n=0}^{N-1}f(n)e^{ -jk\Omega n }$$
# 快速Fourier变换

# 短时Fourier变换
DFT要求待分析或处理的信号是有限长序列，但在很多应用场合，信号往往是无限长或不定长的。尽管理论上我们可以存储全部信号，再实施一个很大点数的DFT，但通常计算这样一个DFT是不现实的，因为对存储空间的占用太大，处理延迟太长。
这就需要将信号切成一块块的切片，分别作DFT的方式来解决。
定义信号$x(n)$的短时Fourier变换为$$X(n,k\Omega)=$$