---
title: Fourier变换
aliases:
  - 傅里叶变换
tags:
  - 信号处理
  - 数理方法
category:
  - 数学物理方法
  - 信息与信号
status:
created: 2025-11-16
updated: 2026-10-14
---
# 记号与整体结构
## 记号约定
- **连续时域**：$t$。
- **离散时域**：$nT$，其中$n\in\mathbb{Z}$，$T$为采样间隔。
- **连续频域**：$\omega$。
- **离散频域**：$k\Omega$，其中$k\in\mathbb{Z}$，$\Omega$为相邻频率样点的间隔。
- **连续周期信号**：周期记作$T_0$，基频为
  $$\Omega_0=\frac{2\pi}{T_0}$$
- **$N$点离散变换**：总观测时长为$NT$，频率间隔为
  $$\Omega=\frac{2\pi}{NT}$$
- **复数单位**：$j^2=-1$。
- **归一化正弦函数**：
  $$\operatorname{Sa}(x)=\frac{\sin x}{x},\quad \operatorname{Sa}(0)=1$$
- **相位约定**：连续时间的分析核取$e^{-j\omega t}$，合成核取$e^{j\omega t}$。这与电磁学、光学中采用的$e^{j(\omega t-\vec{k}\cdot\vec{r})}$相位约定一致。

## 四种基本时频结构
- **连续时间、周期信号**：时域连续，频域只出现在$k\Omega_0$处，用Fourier级数描述。
- **连续时间、非周期信号**：时域与频域都连续，用连续时间Fourier变换描述。
- **离散时间、非周期序列**：时域位于$nT$，频域$\omega$连续并以$2\pi/T$为周期，用离散时间Fourier变换描述。
- **离散时间、周期或有限长序列**：时域位于$nT$，频域位于$k\Omega$，用离散Fourier级数或离散Fourier变换描述。

# Fourier级数
## 复指数形式
设$x(t)$的周期为$T_0$，基频$\Omega_0=2\pi/T_0$。其Fourier级数为
$$\boxed{x(t)=\sum_{k=-\infty}^{\infty}C(k\Omega_0)e^{jk\Omega_0t}}$$
$$\boxed{C(k\Omega_0)=\frac{1}{T_0}\int_{t_0}^{t_0+T_0}x(t)e^{-jk\Omega_0t}\,\mathrm{d}t}$$
积分区间可以取任意一个完整周期。

若$x(t)$为实函数，则
$$C(-k\Omega_0)=C^*(k\Omega_0)$$
因而幅度谱为偶函数，相位谱为奇函数：
$$|C(-k\Omega_0)|=|C(k\Omega_0)|,\quad \arg C(-k\Omega_0)=-\arg C(k\Omega_0)$$

## 三角形式
$$x(t)=\frac{a_0}{2}+\sum_{k=1}^{\infty}\left[a_k\cos(k\Omega_0t)+b_k\sin(k\Omega_0t)\right]$$
$$a_k=\frac{2}{T_0}\int_{t_0}^{t_0+T_0}x(t)\cos(k\Omega_0t)\,\mathrm{d}t$$
$$b_k=\frac{2}{T_0}\int_{t_0}^{t_0+T_0}x(t)\sin(k\Omega_0t)\,\mathrm{d}t$$

两种形式之间满足
$$C(0)=\frac{a_0}{2}$$
$$C(k\Omega_0)=\frac{a_k-jb_k}{2},\quad C(-k\Omega_0)=\frac{a_k+jb_k}{2},\quad k>0$$
若写成
$$a_k\cos(k\Omega_0t)+b_k\sin(k\Omega_0t)=A_k\cos(k\Omega_0t+\varphi_k)$$
则
$$A_k=\sqrt{a_k^2+b_k^2}=2|C(k\Omega_0)|,\quad \varphi_k=\arg C(k\Omega_0)$$

## 对称性与谐波筛选
- **偶函数**：若$x(-t)=x(t)$，则$b_k=0$，只含余弦分量。
- **奇函数**：若$x(-t)=-x(t)$，则$a_k=0$，并且$a_0=0$，只含正弦分量。
- **半波反对称**：若$x(t+T_0/2)=-x(t)$，则只含奇次谐波。
- **半周期重复**：若$x(t+T_0/2)=x(t)$，则原先标作$T_0$的周期并非最小周期；按$\Omega_0$编号时只出现偶次谐波。
- **实信号**：正、负频率系数共轭对称。

## 收敛与Gibbs现象
- 若$x(t)$在一个周期内分段光滑或具有有界变差，则其Fourier级数在$t$处收敛到
  $$\frac{x(t^+)+x(t^-)}{2}$$
- 在连续点处，上式就是$x(t)$；在跳跃间断点处，它是左右极限的平均值。
- 在跳跃点附近，部分和会出现振铃。阶数增加时，振铃区域变窄，但最大过冲趋近于跳变量的约$8.95\%$，这就是Gibbs现象。
- 对平方可积函数，Fourier部分和至少在均方意义下收敛。
- 对连续周期函数，Fejér平均一致收敛；普通Fourier部分和要获得一致收敛通常需要更强的光滑性条件。
- 常用的充分条件包括：
  - **Dirichlet–Jordan条件**：函数在一个周期内具有有界变差。
  - **Dini条件**：局部连续模满足相应的可积性条件。
  - **Hölder条件**：存在$L>0$和$0<\alpha\leq1$，使
    $$|x(t_1)-x(t_2)|\leq L|t_1-t_2|^\alpha$$

## 正交投影、Bessel不等式与Parseval等式
取前$N$阶部分和
$$S_N(t)=\sum_{k=-N}^{N}C(k\Omega_0)e^{jk\Omega_0t}$$
它是在相应有限维三角函数空间中对$x(t)$的最佳均方逼近。

- **Bessel不等式**：
  $$\sum_{k=-\infty}^{\infty}|C(k\Omega_0)|^2\leq\frac{1}{T_0}\int_{t_0}^{t_0+T_0}|x(t)|^2\,\mathrm{d}t$$
- **Parseval等式**：当Fourier函数系完备时，
  $$\boxed{\frac{1}{T_0}\int_{t_0}^{t_0+T_0}|x(t)|^2\,\mathrm{d}t=\sum_{k=-\infty}^{\infty}|C(k\Omega_0)|^2}$$
  对实信号也可写成
  $$\frac{1}{T_0}\int_{t_0}^{t_0+T_0}|x(t)|^2\,\mathrm{d}t=\frac{a_0^2}{4}+\frac12\sum_{k=1}^{\infty}(a_k^2+b_k^2)$$

## 周期信号的连续Fourier变换
周期信号通常不可绝对积分，但可在分布意义下作Fourier变换：
$$\boxed{X(\omega)=2\pi\sum_{k=-\infty}^{\infty}C(k\Omega_0)\delta(\omega-k\Omega_0)}$$
因此，Fourier级数系数就是连续频谱中各条谱线的权重。

# 连续时间Fourier变换
## 定义与适用范围
采用变换对
$$\boxed{X(\omega)=\int_{-\infty}^{\infty}x(t)e^{-j\omega t}\,\mathrm{d}t}$$
$$\boxed{x(t)=\frac{1}{2\pi}\int_{-\infty}^{\infty}X(\omega)e^{j\omega t}\,\mathrm{d}\omega}$$
简记为
$$x(t)\longleftrightarrow X(\omega)$$

- 若$x\in L^1(\mathbb{R})$，积分按通常意义存在，$X(\omega)$连续并在$|\omega|\to\infty$时趋于零。
- 若$x\in L^2(\mathbb{R})$，Fourier变换可按均方极限定义，并保持能量。
- 常数、周期函数、阶跃函数等不属于$L^1$，但可在缓增分布意义下变换；此时会自然出现Dirac函数和主值分布。相关函数空间见[[信号与系统#从普通函数推广到广义函数|广义函数框架]]。

## 频谱的含义
写成
$$X(\omega)=|X(\omega)|e^{j\varphi(\omega)}$$
其中$|X(\omega)|$为幅度谱，$\varphi(\omega)$为相位谱。若$x(t)$为实函数，则
$$X(-\omega)=X^*(\omega)$$
从而
$$|X(-\omega)|=|X(\omega)|,\quad \varphi(-\omega)=-\varphi(\omega)$$

## 基本性质
- **线性**：
  $$ax(t)+by(t)\longleftrightarrow aX(\omega)+bY(\omega)$$
- **时移**：
  $$x(t-t_0)\longleftrightarrow e^{-j\omega t_0}X(\omega)$$
- **频移**：
  $$e^{j\omega_0t}x(t)\longleftrightarrow X(\omega-\omega_0)$$
- **尺度变换**：对实数$a\neq0$，
  $$x(at)\longleftrightarrow\frac{1}{|a|}X\left(\frac{\omega}{a}\right)$$
- **时间反转**：
  $$x(-t)\longleftrightarrow X(-\omega)$$
- **复共轭**：
  $$x^*(t)\longleftrightarrow X^*(-\omega)$$
- **时域微分**：若边界项消失，
  $$\frac{\mathrm{d}^mx}{\mathrm{d}t^m}\longleftrightarrow(j\omega)^mX(\omega)$$
- **时域乘幂**：
  $$t^mx(t)\longleftrightarrow j^m\frac{\mathrm{d}^mX}{\mathrm{d}\omega^m}$$
- **频域微分**：
  $$-jt\,x(t)\longleftrightarrow\frac{\mathrm{d}X}{\mathrm{d}\omega}$$
- **卷积**：
  $$x(t)*y(t)\longleftrightarrow X(\omega)Y(\omega)$$
- **乘积**：
  $$x(t)y(t)\longleftrightarrow\frac{1}{2\pi}\left[X(\omega)*Y(\omega)\right]$$
- **对偶性**：若$x(t)\longleftrightarrow X(\omega)$，则
  $$X(t)\longleftrightarrow2\pi x(-\omega)$$
- **Parseval–Plancherel等式**：
  $$\int_{-\infty}^{\infty}x(t)y^*(t)\,\mathrm{d}t=\frac{1}{2\pi}\int_{-\infty}^{\infty}X(\omega)Y^*(\omega)\,\mathrm{d}\omega$$
  特别地，
  $$\int_{-\infty}^{\infty}|x(t)|^2\,\mathrm{d}t=\frac{1}{2\pi}\int_{-\infty}^{\infty}|X(\omega)|^2\,\mathrm{d}\omega$$
- **相关定理**：若
  $$R_{xy}(\tau)=\int_{-\infty}^{\infty}x^*(t)y(t+\tau)\,\mathrm{d}t$$
  则
  $$R_{xy}(\tau)\longleftrightarrow X^*(\omega)Y(\omega)$$
  自相关函数的Fourier变换为能量谱密度$|X(\omega)|^2$。

## 积分特性与主值分布
若
$$y(t)=\int_{-\infty}^{t}x(\tau)\,\mathrm{d}\tau$$
则在分布意义下
$$Y(\omega)=\operatorname{PV}\frac{X(\omega)}{j\omega}+\pi X(0)\delta(\omega)$$
其中$\operatorname{PV}$表示Cauchy主值。$\delta$项记录积分结果中可能保留下来的直流分量。

从Laplace变换逼近虚轴时，常用Sokhotski–Plemelj公式
$$\boxed{\lim_{\sigma\to0^+}\frac{1}{\sigma+j(\omega-\omega_0)}=\pi\delta(\omega-\omega_0)+\operatorname{PV}\frac{1}{j(\omega-\omega_0)}}$$
因此，不能在$e^{-\alpha t}\varepsilon(t)$的变换中直接令$\alpha=0$而忽略Dirac函数项。

## 常用Fourier变换公式
- **Dirac函数与多项式**：
  - $$\delta(t)\longleftrightarrow1$$
  - $$\delta(t-t_0)\longleftrightarrow e^{-j\omega t_0}$$
  - $$\delta^{(m)}(t)\longleftrightarrow(j\omega)^m$$
  - $$1\longleftrightarrow2\pi\delta(\omega)$$
  - $$t^m\longleftrightarrow2\pi j^m\delta^{(m)}(\omega)$$
- **指数衰减与Gaussian函数**：
  - 对$\operatorname{Re}\alpha>0$，
    $$e^{-\alpha t}\varepsilon(t)\longleftrightarrow\frac{1}{\alpha+j\omega}$$
  - 对$\alpha>0$，
    $$e^{-\alpha|t|}\longleftrightarrow\frac{2\alpha}{\alpha^2+\omega^2}$$
  - 对$\operatorname{Re}\alpha>0$，
    $$e^{-\alpha t^2}\longleftrightarrow\sqrt{\frac{\pi}{\alpha}}e^{-\omega^2/(4\alpha)}$$
- **矩形、三角形与Sa函数**：
  - 定义宽度为$\tau$的门函数
    $$\operatorname{gate}_\tau(t)=\begin{cases}1,&|t|<\tau/2\\0,&|t|>\tau/2\end{cases}$$
    则
    $$\operatorname{gate}_\tau(t)\longleftrightarrow\tau\operatorname{Sa}\left(\frac{\omega\tau}{2}\right)$$
  - 定义
    $$\Lambda_\tau(t)=\begin{cases}1-|t|/\tau,&|t|<\tau\\0,&|t|>\tau\end{cases}$$
    则
    $$\Lambda_\tau(t)\longleftrightarrow\tau\operatorname{Sa}^2\left(\frac{\omega\tau}{2}\right)$$
  - 对$B>0$，
    $$\operatorname{Sa}(Bt)\longleftrightarrow\frac{\pi}{B}\operatorname{gate}_{2B}(\omega)$$
    其中频域门函数在$|\omega|<B$内为$1$。
- **符号函数与阶跃函数**：
  - $$\operatorname{sgn}(t)\longleftrightarrow2\operatorname{PV}\frac{1}{j\omega}$$
  - $$\varepsilon(t)\longleftrightarrow\pi\delta(\omega)+\operatorname{PV}\frac{1}{j\omega}$$
  - 采用使常数项为零的有限部约定时，
    $$|t|\longleftrightarrow-2\operatorname{Pf}\frac{1}{\omega^2}$$
    其中$\operatorname{Pf}$表示Hadamard有限部。
- **单频信号**：
  - $$e^{j\omega_0t}\longleftrightarrow2\pi\delta(\omega-\omega_0)$$
  - $$\cos(\omega_0t)\longleftrightarrow\pi\left[\delta(\omega-\omega_0)+\delta(\omega+\omega_0)\right]$$
  - $$\sin(\omega_0t)\longleftrightarrow\frac{\pi}{j}\left[\delta(\omega-\omega_0)-\delta(\omega+\omega_0)\right]$$
- **Dirac梳状函数**：令$\Omega_s=2\pi/T$，则
  - $$\sum_{n=-\infty}^{\infty}\delta(t-nT)\longleftrightarrow\Omega_s\sum_{k=-\infty}^{\infty}\delta(\omega-k\Omega_s)$$
  - 等价地，
    $$\sum_{k=-\infty}^{\infty}e^{jk\Omega_st}=T\sum_{n=-\infty}^{\infty}\delta(t-nT)$$
  - 以及
    $$\sum_{n=-\infty}^{\infty}e^{-j\omega nT}=\Omega_s\sum_{k=-\infty}^{\infty}\delta(\omega-k\Omega_s)$$

## 计算思路
- 从少量基本变换对出发，优先使用时移、频移、尺度、微分和卷积性质。
- 先利用奇偶性、实信号共轭对称性判断频谱结构，可以减少一半计算。
- 对单边信号，可用
  $$\varepsilon(t)=\frac{1+\operatorname{sgn}(t)}{2}$$
  分解。例如
  $$\cos(\omega_0t)\varepsilon(t)=\frac12\cos(\omega_0t)+\frac12\cos(\omega_0t)\operatorname{sgn}(t)$$
- 对衰减信号，可先求Laplace变换，再在收敛域允许的情况下令$s\to j\omega$。
- 遇到常数、阶跃、周期信号或无衰减振荡时，应使用分布公式并检查是否遗漏$\delta$项。

# 采样与Poisson求和
设连续信号$x(t)$的Fourier变换为$X(\omega)$，以间隔$T$采样。采样后的冲激串为
$$x_s(t)=\sum_{n=-\infty}^{\infty}x(nT)\delta(t-nT)$$
其频谱为
$$\boxed{X_s(\omega)=\frac{1}{T}\sum_{k=-\infty}^{\infty}X(\omega-k\Omega_s)},\quad \Omega_s=\frac{2\pi}{T}$$
另一方面，直接对$x_s(t)$变换得到
$$X_s(\omega)=\sum_{n=-\infty}^{\infty}x(nT)e^{-j\omega nT}$$
于是得到Poisson求和公式
$$\boxed{\sum_{n=-\infty}^{\infty}x(nT)e^{-j\omega nT}=\frac{1}{T}\sum_{k=-\infty}^{\infty}X(\omega-k\Omega_s)}$$
它同时说明：时域离散化会在频域产生周期复本。采样定理、混叠和理想重构见[[连续时间信号的采样]]。

# 离散时间Fourier变换
## 定义与周期性
离散序列记为$x(nT)$。其离散时间Fourier变换为
$$\boxed{X_{\mathrm{DT}}(\omega)=\sum_{n=-\infty}^{\infty}x(nT)e^{-j\omega nT}}$$
逆变换可在任意长度为$2\pi/T$的频率区间上进行：
$$\boxed{x(nT)=\frac{T}{2\pi}\int_{\omega_0}^{\omega_0+2\pi/T}X_{\mathrm{DT}}(\omega)e^{j\omega nT}\,\mathrm{d}\omega}$$
由于
$$e^{-j(\omega+2\pi/T)nT}=e^{-j\omega nT}$$
所以
$$X_{\mathrm{DT}}\left(\omega+\frac{2\pi}{T}\right)=X_{\mathrm{DT}}(\omega)$$
离散时间频谱在连续频率$\omega$上定义，但具有周期性。

## 基本性质
- **线性**：
  $$ax(nT)+by(nT)\longleftrightarrow aX_{\mathrm{DT}}(\omega)+bY_{\mathrm{DT}}(\omega)$$
- **离散时移**：
  $$x((n-m)T)\longleftrightarrow e^{-j\omega mT}X_{\mathrm{DT}}(\omega)$$
- **频移**：
  $$e^{j\omega_0nT}x(nT)\longleftrightarrow X_{\mathrm{DT}}(\omega-\omega_0)$$
- **时间反转**：
  $$x(-nT)\longleftrightarrow X_{\mathrm{DT}}(-\omega)$$
- **序列卷积**：若
  $$(x*y)(nT)=\sum_{m=-\infty}^{\infty}x(mT)y((n-m)T)$$
  则
  $$(x*y)(nT)\longleftrightarrow X_{\mathrm{DT}}(\omega)Y_{\mathrm{DT}}(\omega)$$
- **序列乘积**：
  $$x(nT)y(nT)\longleftrightarrow\frac{T}{2\pi}\int_{\omega_0}^{\omega_0+2\pi/T}X_{\mathrm{DT}}(\nu)Y_{\mathrm{DT}}(\omega-\nu)\,\mathrm{d}\nu$$
  频域卷积按周期$2\pi/T$理解。
- **Parseval等式**：
  $$\sum_{n=-\infty}^{\infty}|x(nT)|^2=\frac{T}{2\pi}\int_{\omega_0}^{\omega_0+2\pi/T}|X_{\mathrm{DT}}(\omega)|^2\,\mathrm{d}\omega$$
- **一阶差分**：
  $$x(nT)-x((n-1)T)\longleftrightarrow(1-e^{-j\omega T})X_{\mathrm{DT}}(\omega)$$

## 常用离散时间变换公式
- **单位样值序列**：令$\delta_n=1$仅在$n=0$成立，则
  - $$\delta_n\longleftrightarrow1$$
  - $$\delta_{n-m}\longleftrightarrow e^{-j\omega mT}$$
- **单边指数序列**：令$u_n=1$对$n\geq0$成立。当$|a|<1$时，
  $$a^nu_n\longleftrightarrow\frac{1}{1-ae^{-j\omega T}}$$
- **有限长常数序列**：若$x(nT)=1$仅在$0\leq n\leq N-1$成立，则
  $$X_{\mathrm{DT}}(\omega)=e^{-j\omega T(N-1)/2}\frac{\sin(N\omega T/2)}{\sin(\omega T/2)}$$
  其中比值按连续延拓解释。
- **离散单频序列**：
  $$e^{j\omega_0nT}\longleftrightarrow\Omega_s\sum_{k=-\infty}^{\infty}\delta(\omega-\omega_0-k\Omega_s),\quad \Omega_s=\frac{2\pi}{T}$$

# 离散Fourier级数
设$x(nT)$关于$n$以$N$为周期，即$x((n+N)T)=x(nT)$。总时间周期为$NT$，频率间隔为
$$\Omega=\frac{2\pi}{NT}$$
离散Fourier级数为
$$\boxed{x(nT)=\sum_{k=0}^{N-1}C(k\Omega)e^{jk\Omega nT}}$$
$$\boxed{C(k\Omega)=\frac{1}{N}\sum_{n=0}^{N-1}x(nT)e^{-jk\Omega nT}}$$
时域和频域指标都以$N$为周期：
$$x((n+N)T)=x(nT),\quad C((k+N)\Omega)=C(k\Omega)$$

# 离散Fourier变换
## 定义
对长度为$N$的有限序列$x(nT)$，$n=0,1,\ldots,N-1$，定义
$$\boxed{X(k\Omega)=\sum_{n=0}^{N-1}x(nT)e^{-jk\Omega nT}}$$
$$\boxed{x(nT)=\frac{1}{N}\sum_{k=0}^{N-1}X(k\Omega)e^{jk\Omega nT}}$$
其中
$$\Omega=\frac{2\pi}{NT},\quad k=0,1,\ldots,N-1$$

DFT有两种等价理解：

- 它是有限序列的DTFT在$\omega=k\Omega$处的$N$个等间隔样值。
- 它是把有限序列作$N$点周期延拓后得到的离散Fourier级数，只是系数的归一化位置不同。

## 常用性质
- **圆周时移**：若$y(nT)=x(((n-m))_NT)$，则
  $$Y(k\Omega)=e^{-jk\Omega mT}X(k\Omega)$$
- **频率移位**：
  $$e^{jk_0\Omega nT}x(nT)\longleftrightarrow X(((k-k_0))_N\Omega)$$
- **圆卷积**：
  $$x(nT)\circledast_Ny(nT)\longleftrightarrow X(k\Omega)Y(k\Omega)$$
- **时域乘积**：
  $$x(nT)y(nT)\longleftrightarrow\frac1N\left[X(k\Omega)\circledast_NY(k\Omega)\right]$$
- **Parseval等式**：
  $$\sum_{n=0}^{N-1}|x(nT)|^2=\frac1N\sum_{k=0}^{N-1}|X(k\Omega)|^2$$
- **实序列的共轭对称性**：
  $$X((N-k)\Omega)=X^*(k\Omega)$$
- **用圆卷积计算线卷积**：若两序列长度分别为$N_1,N_2$，至少补零到
  $$N\geq N_1+N_2-1$$
  则$N$点圆卷积与线卷积一致。卷积本身的定义和图解法见[[卷积]]。

## 频率编号与负频率
DFT结果通常按$k=0,1,\ldots,N-1$存放。对应的物理频率可解释为

- $0\leq k\leq\lfloor N/2\rfloor$：$\omega_k=k\Omega$。
- $\lfloor N/2\rfloor<k\leq N-1$：$\omega_k=(k-N)\Omega$，对应负频率。
- 若$N$为偶数，$k=N/2$对应Nyquist频率$\pi/T$，其正、负频率表示重合。

# 快速Fourier变换
FFT是计算DFT的算法。它不改变DFT的定义和结果，只利用复指数的周期性与对称性减少运算量。

令
$$W_N=e^{-j2\pi/N}$$
对偶数$N$，把序列拆成偶数样值与奇数样值，可得
$$X(k\Omega)=E(k\Omega)+W_N^kO(k\Omega)$$
$$X((k+N/2)\Omega)=E(k\Omega)-W_N^kO(k\Omega)$$
其中$E,O$分别是两个$N/2$点DFT。递归分解后，运算复杂度由直接计算的$O(N^2)$降为$O(N\log N)$。基2 FFT通常要求$N=2^m$；混合基和Bluestein算法可处理其他长度。

# 短时Fourier变换
## 定义
Fourier变换给出整个信号的总体频谱，但不保留某个频率在何时出现的信息。短时Fourier变换用移动窗截取局部片段，对每一片分别作Fourier变换。

连续频率形式可写成
$$X_{\mathrm{ST}}(\tau,\omega)=\sum_{n=-\infty}^{\infty}x(nT)w(nT-\tau)e^{-j\omega nT}$$
实际计算通常取长度为$M$的窗、帧移为$H$个样值，并作$N$点DFT：
$$\boxed{X_r(k\Omega)=\sum_{m=0}^{M-1}x((rH+m)T)w(mT)e^{-jk\Omega mT}}$$
$$\Omega=\frac{2\pi}{NT},\quad N\geq M$$
其中$rHT$是帧的时间位置，$k\Omega$是离散频率。若$N>M$，其余位置补零。

## 常用窗函数
以下均取$n=0,1,\ldots,M-1$。

- **矩形窗**：
  $$w(nT)=1$$
- **Bartlett窗**：
  $$w(nT)=1-\left|\frac{n-(M-1)/2}{(M-1)/2}\right|$$
- **Hann窗**：
  $$w(nT)=0.5-0.5\cos\left(\frac{2\pi n}{M-1}\right)$$
- **Hamming窗**：
  $$w(nT)=0.54-0.46\cos\left(\frac{2\pi n}{M-1}\right)$$
- **Blackman窗**：
  $$w(nT)=0.42-0.5\cos\left(\frac{2\pi n}{M-1}\right)+0.08\cos\left(\frac{4\pi n}{M-1}\right)$$

Hann、Hamming和Blackman窗都属于余弦和窗。它们与Bartlett窗的形状可见：
![[布莱克曼窗族和巴特利特窗.png]]

## 加窗造成的频谱变化
时域相乘对应频域卷积，因此窗函数会把理想谱线卷积成具有主瓣和旁瓣的形状。

- **主瓣宽度**决定相近频率能否分开。窗越长，主瓣通常越窄，频率分辨能力越高。
- **旁瓣高度**决定强频率成分对远处弱分量的污染程度。低旁瓣窗有利于观察弱分量。
- **频谱泄漏**来自有限时间截断。当信号频率没有恰好落在$k\Omega$上时，能量会分散到相邻频率样点。
- **栅栏效应**来自只观察离散频率$k\Omega$。真实谱峰可能位于两个频率样点之间，使测得峰值偏低。
- **补零**可以减小$\Omega$，让DTFT曲线被采得更密，便于估计峰值位置；它不会缩窄由实际窗长决定的主瓣，因此不会提高真正的频率分辨率。
- **时间—频率折中**：长窗有较好的频率分辨能力，短窗有较好的时间定位能力。

加窗前后的典型变化见：
![[加窗前后序列的频谱.png]]

常用窗的主瓣宽度和旁瓣幅度见：
![[常用窗函数主瓣宽度和旁瓣相对幅度.png]]

线性调频信号的频率随时间变化，适合用短时Fourier变换表示：
![[线性调频信号的短时傅里叶变换.png]]

# 多维Fourier变换
在偏微分方程和场论中，常对空间变量作Fourier变换。为了与
$$e^{j(\omega t-\vec{k}\cdot\vec{r})}$$
的相位约定一致，空间变换取
$$\hat{f}(\vec{k})=\int_{\mathbb{R}^d}f(\vec{r})e^{j\vec{k}\cdot\vec{r}}\,\mathrm{d}^d\vec{r}$$
$$f(\vec{r})=\int_{\mathbb{R}^d}\hat{f}(\vec{k})e^{-j\vec{k}\cdot\vec{r}}\frac{\mathrm{d}^d\vec{k}}{(2\pi)^d}$$
于是

- **梯度**：
  $$\nabla f\longleftrightarrow-j\vec{k}\hat{f}$$
- **Laplacian**：
  $$\nabla^2f\longleftrightarrow-|\vec{k}|^2\hat{f}$$
- **卷积**：
  $$(f*g)(\vec{r})\longleftrightarrow\hat{f}(\vec{k})\hat{g}(\vec{k})$$

这使常系数线性偏微分方程在频域中化为代数方程，具体应用见[[位势方程#Fourier变换法|位势方程的Fourier变换法]]。
