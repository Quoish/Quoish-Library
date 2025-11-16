#数理方法 
# 连带Legendre方程
$$
(1-x^2)y'' -2xy'+\left(\mu-\frac{m^2}{1-x^2} \right)y=0
$$
$$y=AP_l ^m(x)+BQ_l^m(x)$$
## 余弦代换
$$\frac{1}{\sin \theta}\frac{ \mathrm{d}   }{ \mathrm{d}  \theta} \left( \sin \theta \frac{ \mathrm{d}   \Theta}{ \mathrm{d}  \theta} \right)+\left( \lambda-\frac{m^2}{\sin^2 \theta} \right) \Theta =0$$
# Legendre多项式
$$P_l(x)=\sum_{k=0}^{[\frac{l}{2}]}(-1)^k \frac{(2l-2k)!}{2^l\cdot k!(l-k)!(l-2k)!}x^{l-2k},l=0,1,2,\cdots$$
# 连带关系
$$
P_l^m(x)=(1-x^2)^{\frac{m}{2}}\frac{\text{d}^m}{\text{d}x^m}P_l(x)
$$
# Rodrigues公式
$$
\begin{align}
&P_l(x)=\frac{1}{2^l l!}\frac{\text{d}^l}{\text{d}x^l}(x^2-1)^l\\
&P_l^m(x)=\frac{1}{2^ll!}(1-x^2)^\frac{m}{2}\frac{\mathrm{d}^{l+m}}{\mathrm{d} x^{l+m}} (x^2-1)^l\\
\end{align}
$$
# 正交性
$$
\int_{-1}^{1}P_{l'}(x)P_l(x)\text{d}x=\frac{2}{2l+1}\delta_{l'l}\\
\int_{-1}^{1}P_{l'}^m(x)P_l^m(x)\text{d}x=\frac{2}{2l+1} \frac{(l+m)!}{(l-m)!} \delta_{l'l} \\
$$
# 特殊点
$$\begin{equation}
        \left\{
	\begin{aligned}
		&P_{2n+1}(0)=0&P_l(1)=1,&\\
		&P_{2n}(0)=(-1)^n\cdot\frac{(2n)!}{2^{2n}(n!)^2},&P_l(-1)=(-1)^l&\\
	\end{aligned}
	\right.
\end{equation}$$
