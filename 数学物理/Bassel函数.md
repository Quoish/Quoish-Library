#数理方法 
# 含参Bassel方程
$$
x^2y''+xy'+(\lambda x^2-\nu^2)y=0\\
$$
其解为
$$y=AJ_{\nu}(\sqrt{\lambda}x)+BY_\nu(\sqrt{\lambda}x)$$

# Bassel函数
## 级数表达式
$$
J_{\nu}(x)=\sum_{k=0}^{\infty}\frac{(-1)^k\left(\frac{x}{2}\right)^{\nu+2k}}{\Gamma(k+1)\Gamma(\nu+k+1)}
$$
## 积分表达式
$$J_\nu(x) = \frac{1}{\pi} \int_0^{\pi} \cos(\nu \theta - x \sin \theta) \mathrm{d}\theta$$
或者复指数形式
$$J_\nu(x) = \frac{1}{2\pi} \int_{-\pi}^{\pi} e^{i(\nu \theta - x \sin \theta)}\mathrm{d}\theta$$
# 平面波对圆波的展开式
向x轴方向传播的平面波为$$e^{ ikx }=e^{ ikr\cos \theta }$$平面波也是二维Helmholtz方程的解，因而可以写成$J_{n}(kr)e^{ im\theta }$的线性叠加（$e^{ im\theta }$是分离变量出来的）$$e^{ ikr\cos \theta }=\sum_{m=-\infty}^{+\infty}i^m J_{m}(kr)e^{ im\theta }$$这个展开式将平面波视作无数个圆波的叠加。
# 线性相关性
当$\nu$不为整数时，$J_\nu$和$J_{-\nu}$线性无关
当$\nu$为整数时，$J_\nu$和$J_{-\nu}$线性相关
# 奇偶性
$$
\begin{equation}
        \left\{
	\begin{aligned}
		&J_{n}(-x)=(-1)^nJ_n(x)\\
		&Y_{n}(-x)=(-1)^nY_n(x)\\
	\end{aligned}
	\right.
\end{equation}
$$

# 有界性
$$
|J_n(x)|\leq1
$$

# 特殊零点
$$
J_n(0)=\begin{equation}
        \left\{
	\begin{aligned}
		&1&当n=0时\\
		&0&当n\geq1时\\
	\end{aligned}
	\right.
\end{equation}
$$

# 微分递推公式
$$
\frac{\mathrm{d}}{\mathrm{d}x}[x^nJ_n(x)]=x^nJ_{n-1}(x)\\
\frac{\mathrm{d}}{\mathrm{d}x}[x^{-n}J_n(x)]=-x^{-n}J_{n+1}(x)\\
$$
由微分递推公式求导求出来并且相加减得到的递推公式：
$$
J_{n-1}(x)+J_{n+1}(x)=\frac{2}{x}nJ_n(x)\\
J_{n-1}(x)-J_{n+1}(x)=2J_n'(x)\\
$$

# 正交性
（关于函数系$\left \{ J_n\left ( \frac{\mu_m^{(n)}}{R}r \right )  \right \} ,m=1,2,\cdots$）
$$
\int_0^R J_n\left ( \frac{\mu_i^{(n)}}{R}r \right )J_n\left ( \frac{\mu_j^{(n)}}{R}r \right )r\mathrm{d}r= \frac{R^2}{2}J_{n-1}^2(\mu_i^{(n)})\delta_{ij}=\frac{R^2}{2}J_{n+1}^2(\mu_i^{(n)})\delta_{ij}
$$
# 渐进公式
当$x\to\infty$时
$$J_n(x)\to\sqrt{\frac{2}{\pi x}}\cos\left(x-\frac{\nu\pi}{2}-\frac{\pi}{4}\right)+O(x^{-\frac{3}{2}})$$
$$Y_n(x)\to\sqrt{\frac{2}{\pi x}}\sin\left(x-\frac{\nu\pi}{2}-\frac{\pi}{4}\right)+O(x^{-\frac{3}{2}})$$
# 生成函数
$$e^{\frac{x}{2}\left(t-\frac{1}{t}\right)}=\sum_{n=-\infty}^{+\infty}J_n(x)t^n(0<|t|<\infty)$$
# 合流超几何函数
$$J_\nu(x)=\left(\frac{x}{2}\right)^\nu \frac{e^{-ix}}{\Gamma(\nu+1)}F(\nu+\frac{1}{2},2\nu+1,2ix)$$
