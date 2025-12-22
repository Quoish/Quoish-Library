#场论 
# Einstein求和约定
Einstein求和约定是一种符号速记法。
在场论和张量分析中我们会见到大量求和运算，例如三维矢量场表示为$$\vec{A}=A_{1}\hat{x}_{1}+A_{2}\hat{x}_{2}+A_{3}\hat{x}_{3}=\sum_{i=1}^3A_{i}\hat{x}_{i}$$并且我们在绝大多数同一个语境下谈论的场维数都是相同的，求和的次数也是固定的，重复书写这么多求和符号$\sum$给书写和表示都带来很大的不便。
因此我们省去$\sum$，认为只要两个指标重复出现就代表按照这个指标从1到3求和（在讨论四维时空时，就是从1到4求和），这被称为*Einstein求和记号*。
于是上面的矢量场可以表达为$$\vec{A}=A_{i}\hat{x}_{i}$$
重复出现的下标称为*哑指标*，而非重复出现的下标称为*自由指标*。
下面的式子展示了哑指标和自由指标混合出现的情况$$A_{i}B_{i}C_{j}D_{j}E_{k}=(A_{1}B_{1}+A_{2}B_{2}+A_{3}B_{3})(C_{1}D_{1}+C_{2}D_{2}+C_{3}D_{3})E_{k}$$
# Kronecker符号
Kronecker符号定义为$$\delta_{ij}=\begin{equation}
\left\{
\begin{aligned}
&1&当i=j时\\
&0&当i\neq j时
\end{aligned}
\right.
\end{equation}$$它刚好代表单位矩阵的矩阵元。
Kronecker符号关于它的两个下标对称$\delta_{ij}=\delta_{ji}$。
Kronecker符号具有收缩指标的作用，例如$\delta_{ik}A_{kj}=A_{ij},\delta_{ik}\delta_{kj}=\delta_{ij}$。
注意：$\delta_{ii}=\delta_{11}+\delta_{22}+\delta_{33}=3$。
# Levi-Civita符号
Levi-Civita符号定义为$$\varepsilon_{ijk}=\frac{(i-j)(j-k)(k-i)}{2}=\begin{equation}
\left\{
\begin{aligned}
&+1&当(ijk)是奇排列时\\
&-1&当(ijk)是偶排列时\\
&0&当两个以上指标相同时
\end{aligned}
\right.
\end{equation}$$显然$\varepsilon_{ijk}=\varepsilon_{jki}=\varepsilon_{kij}=-\varepsilon_{jik}=-\varepsilon_{kji}=-\varepsilon_{ikj}$。
# $\varepsilon-\delta$恒等式
Kronecker符号和Levi-Civita符号存在以下关系$$\varepsilon_{ijx}\varepsilon_{pqx}=\delta_{ip}-\delta_{jq}=\begin{vmatrix}
\delta_{ip} & \delta_{iq} \\
\delta_{jp} & \delta_{jq}
\end{vmatrix}$$
# 简记下的矢量公式
## 矢量点积
$$\vec{A}\cdot \vec{B}=A_{i}B_{i}$$
## 基矢量点积
$$\hat{x}_{i}\cdot \hat{x}_{j}=\delta_{ij}$$
## 矢量叉积
$$\vec{A}\times \vec{B}=\varepsilon_{ijk}A_{i}B_{j}\hat{x}_{k}=\begin{vmatrix}
A_{1} & A_{2} & A_{3} \\
B_{1} & B_{2} & B_{3} \\
\hat{x}_{1} & \hat{x}_{2} & \hat{x}_{3}
\end{vmatrix}$$
## 基矢量叉积
$$\hat{x}_{i}\times \hat{x}_{j}=\varepsilon_{ijk}\hat{x}_{k}$$
## 矢量混合积
$$\vec{A}\cdot (\vec{B}\times \vec{C})=\varepsilon_{ijk}A_{i}B_{j}C_{k}$$
## 矢量三重叉积
$$\vec{A}\times (\vec{B}\times \vec{C})=\varepsilon_{ilm}\varepsilon_{jkl}A_{i}B_{j}C_{k}\hat{x}_{m}$$