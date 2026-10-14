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
- **离散频域**：$k\Omega$，其中$k\in\mathbb{Z}$，$\Omega$为相邻频率样点的间隔；$\Omega$的具体取值由相应的周期决定。
- **$N$点离散变换**：总观测时长为$NT$，频率间隔为
  $$\Omega=\frac{2\pi}{NT}$$
- **周期函数**：在函数符号上加波浪号。$\tilde f$表示时域周期函数，$\tilde F$表示频域周期函数。
- **复数单位**：$j^2=-1$。
- **归一化正弦函数**：
  $$\operatorname{Sa}(x)=\frac{\sin x}{x},\quad \operatorname{Sa}(0)=1$$
- **相位约定**：连续时间的分析核取$e^{-j\omega t}$，合成核取$e^{j\omega t}$。这与电磁学、光学中采用的$e^{j(\omega t-\vec{k}\cdot\vec{r})}$相位约定一致。

## 变换算子
- **连续时间Fourier变换**：
  $$\mathcal{F}\{f(t)\}=F(j\omega),\quad \mathcal{F}^{-1}\{F(j\omega)\}=f(t)$$
- **离散时间Fourier变换**：
  $$\mathrm{DTFT}\{f(nT)\}=\tilde F(j\omega),\quad \mathrm{DTFT}^{-1}\{\tilde F(j\omega)\}=f(nT)$$
- **离散Fourier变换**：
  $$\mathrm{DFT}\{f(nT)\}=F(jk\Omega),\quad \mathrm{DFT}^{-1}\{F(jk\Omega)\}=f(nT)$$

## 五类Fourier表示
- **Fourier变换**：
  $$f(t)\longleftrightarrow F(j\omega)$$
  时域和频域都连续、非周期。
- **Fourier级数**：
  $$\tilde f(t)\longleftrightarrow F(jk\Omega)$$
  时域连续、周期，频域离散、非周期。
- **离散时间Fourier变换**：
  $$f(nT)\longleftrightarrow\tilde F(j\omega)$$
  时域离散、非周期，频域连续并以$2\pi/T$为周期。
- **离散Fourier级数**：
  $$\tilde f(nT)\longleftrightarrow\tilde F(jk\Omega)$$
  时域离散、周期，频域离散、周期。
- **离散Fourier变换**：
  $$f(nT)\longleftrightarrow F(jk\Omega)$$
  它把有限长序列限制在一个主值区间内表示；周期延拓后就是离散Fourier级数。

# Fourier级数
## 复指数形式
设$\tilde f(t)$的周期为$T_0$，并在本节记
$$\Omega=\frac{2\pi}{T_0}$$
其Fourier级数为
$$\boxed{\tilde f(t)=\sum_{k=-\infty}^{\infty}F(jk\Omega)e^{jk\Omega t}}$$
$$\boxed{F(jk\Omega)=\frac{1}{T_0}\int_{t_0}^{t_0+T_0}\tilde f(t)e^{-jk\Omega t}\,\mathrm{d}t}$$
积分区间可以取任意一个完整周期。

若$\tilde f(t)$为实函数，则
$$F(-jk\Omega)=F^*(jk\Omega)$$
因而幅度谱为偶函数，相位谱为奇函数：
$$|F(-jk\Omega)|=|F(jk\Omega)|,\quad \arg F(-jk\Omega)=-\arg F(jk\Omega)$$

## 三角形式
$$\tilde f(t)=\frac{a_0}{2}+\sum_{k=1}^{\infty}\left[a_k\cos(k\Omega t)+b_k\sin(k\Omega t)\right]$$
$$a_k=\frac{2}{T_0}\int_{t_0}^{t_0+T_0}\tilde f(t)\cos(k\Omega t)\,\mathrm{d}t$$
$$b_k=\frac{2}{T_0}\int_{t_0}^{t_0+T_0}\tilde f(t)\sin(k\Omega t)\,\mathrm{d}t$$

两种形式之间满足
$$F(0)=\frac{a_0}{2}$$
$$F(jk\Omega)=\frac{a_k-jb_k}{2},\quad F(-jk\Omega)=\frac{a_k+jb_k}{2},\quad k>0$$
若写成
$$a_k\cos(k\Omega t)+b_k\sin(k\Omega t)=A_k\cos(k\Omega t+\varphi_k)$$
则
$$A_k=\sqrt{a_k^2+b_k^2}=2|F(jk\Omega)|,\quad \varphi_k=\arg F(jk\Omega)$$

## 对称性与谐波筛选
- **偶函数**：若$\tilde f(-t)=\tilde f(t)$，则$b_k=0$，只含余弦分量。
- **奇函数**：若$\tilde f(-t)=-\tilde f(t)$，则$a_k=0$，并且$a_0=0$，只含正弦分量。
- **半波反对称**：若$\tilde f(t+T_0/2)=-\tilde f(t)$，则只含奇次谐波。
- **半周期重复**：若$\tilde f(t+T_0/2)=\tilde f(t)$，则原先标作$T_0$的周期并非最小周期；按$\Omega$编号时只出现偶次谐波。
- **实信号**：正、负频率系数共轭对称。

## 收敛与Gibbs现象
- 若$\tilde f(t)$在一个周期内分段光滑或具有有界变差，则其Fourier级数在$t$处收敛到
  $$\frac{\tilde f(t^+)+\tilde f(t^-)}{2}$$
- 在连续点处，上式就是$\tilde f(t)$；在跳跃间断点处，它是左右极限的平均值。
- 在跳跃点附近，部分和会出现振铃。阶数增加时，振铃区域变窄，但最大过冲趋近于跳变量的约$8.95\%$，这就是Gibbs现象。
- 对平方可积函数，Fourier部分和至少在均方意义下收敛。
- 对连续周期函数，Fejér平均一致收敛；普通Fourier部分和要获得一致收敛通常需要更强的光滑性条件。
- 常用的充分条件包括：
  - **Dirichlet–Jordan条件**：函数在一个周期内具有有界变差。
  - **Dini条件**：局部连续模满足相应的可积性条件。
  - **Hölder条件**：存在$L>0$和$0<\alpha\leq1$，使
    $$|\tilde f(t_1)-\tilde f(t_2)|\leq L|t_1-t_2|^\alpha$$

## Fourier级数的运算性质
设$\tilde f(t)$、$\tilde g(t)$的Fourier系数分别为$F(jk\Omega)$、$G(jk\Omega)$。

- **时移**：
  $$\tilde f(t-t_1)\longleftrightarrow e^{-jk\Omega t_1}F(jk\Omega)$$
- **时间反转**：
  $$\tilde f(-t)\longleftrightarrow F(-jk\Omega)$$
- **微分**：若逐项微分合法，则
  $$\frac{\mathrm{d}^m\tilde f}{\mathrm{d}t^m}\longleftrightarrow(jk\Omega)^mF(jk\Omega)$$
- **周期积分**：若$F(0)=0$，令$\tilde g(t)$为$\tilde f(t)$的周期原函数，则
  $$G(jk\Omega)=\frac{F(jk\Omega)}{jk\Omega},\quad k\neq0$$
- **时域乘积**：若$\tilde h(t)=\tilde f(t)\tilde g(t)$，则
  $$H(jk\Omega)=\sum_{m=-\infty}^{\infty}F(jm\Omega)G(j(k-m)\Omega)$$
- **周期卷积**：定义
  $$(\tilde f*_0\tilde g)(t)=\frac1{T_0}\int_{t_0}^{t_0+T_0}\tilde f(\tau)\tilde g(t-\tau)\,\mathrm{d}\tau$$
  则
  若$\tilde h=\tilde f*_0\tilde g$，则
  $$H(jk\Omega)=F(jk\Omega)G(jk\Omega)$$

## 正交投影、Bessel不等式与Parseval等式
取前$N$阶部分和
$$S_N(t)=\sum_{k=-N}^{N}F(jk\Omega)e^{jk\Omega t}$$
它是在相应有限维三角函数空间中对$\tilde f(t)$的最佳均方逼近。

- **Bessel不等式**：
  $$\sum_{k=-\infty}^{\infty}|F(jk\Omega)|^2\leq\frac{1}{T_0}\int_{t_0}^{t_0+T_0}|\tilde f(t)|^2\,\mathrm{d}t$$
- **Parseval等式**：当Fourier函数系完备时，
  $$\boxed{\frac{1}{T_0}\int_{t_0}^{t_0+T_0}|\tilde f(t)|^2\,\mathrm{d}t=\sum_{k=-\infty}^{\infty}|F(jk\Omega)|^2}$$
  对实信号也可写成
  $$\frac{1}{T_0}\int_{t_0}^{t_0+T_0}|\tilde f(t)|^2\,\mathrm{d}t=\frac{a_0^2}{4}+\frac12\sum_{k=1}^{\infty}(a_k^2+b_k^2)$$

## 周期信号的连续Fourier变换
周期信号通常不可绝对积分，但可在分布意义下作Fourier变换：
$$\boxed{\mathcal{F}\{\tilde f(t)\}=F(j\omega)=2\pi\sum_{k=-\infty}^{\infty}F(jk\Omega)\delta(\omega-k\Omega)}$$
因此，Fourier级数系数就是连续频谱中各条谱线的权重。

# 连续时间Fourier变换
## 定义与适用范围
采用变换对
$$\boxed{F(j\omega)=\mathcal{F}\{f(t)\}=\int_{-\infty}^{\infty}f(t)e^{-j\omega t}\,\mathrm{d}t}$$
$$\boxed{f(t)=\mathcal{F}^{-1}\{F(j\omega)\}=\frac{1}{2\pi}\int_{-\infty}^{\infty}F(j\omega)e^{j\omega t}\,\mathrm{d}\omega}$$
简记为
$$f(t)\longleftrightarrow F(j\omega)$$

- 若$f\in L^1(\mathbb{R})$，积分按通常意义存在，$F(j\omega)$连续并在$|\omega|\to\infty$时趋于零。
- 若$f\in L^2(\mathbb{R})$，Fourier变换可按均方极限定义，并保持能量。
- 常数、周期函数、阶跃函数等不属于$L^1$，但可在缓增分布意义下变换；此时会自然出现Dirac函数和主值分布。相关定义见[[广义函数]]。

## 频谱的含义
写成
$$F(j\omega)=|F(j\omega)|e^{j\varphi(\omega)}$$
其中$|F(j\omega)|$为幅度谱，$\varphi(\omega)$为相位谱。若$f(t)$为实函数，则
$$F(-j\omega)=F^*(j\omega)$$
从而
$$|F(-j\omega)|=|F(j\omega)|,\quad \varphi(-\omega)=-\varphi(\omega)$$

## 基本性质
- **线性**：
  $$af(t)+bg(t)\longleftrightarrow aF(j\omega)+bG(j\omega)$$
- **时移**：
  $$f(t-t_0)\longleftrightarrow e^{-j\omega t_0}F(j\omega)$$
- **频移**：
  $$e^{j\omega_0t}f(t)\longleftrightarrow F(j(\omega-\omega_0))$$
  因而实正弦调制满足
  $$f(t)\cos(\omega_0t)\longleftrightarrow\frac12\left[F(j(\omega-\omega_0))+F(j(\omega+\omega_0))\right]$$
  $$f(t)\sin(\omega_0t)\longleftrightarrow\frac{1}{2j}\left[F(j(\omega-\omega_0))-F(j(\omega+\omega_0))\right]$$
- **尺度变换**：对实数$a\neq0$，
  $$f(at)\longleftrightarrow\frac{1}{|a|}F\left(\frac{j\omega}{a}\right)$$
- **时间反转**：
  $$f(-t)\longleftrightarrow F(-j\omega)$$
- **复共轭**：
  $$f^*(t)\longleftrightarrow F^*(-j\omega)$$
- **时域微分**：若边界项消失，
  $$\frac{\mathrm{d}^mf}{\mathrm{d}t^m}\longleftrightarrow(j\omega)^mF(j\omega)$$
- **时域乘幂**：
  $$t^mf(t)\longleftrightarrow j^m\frac{\mathrm{d}^mF(j\omega)}{\mathrm{d}\omega^m}$$
- **频域微分**：
  $$-jt\,f(t)\longleftrightarrow\frac{\mathrm{d}F(j\omega)}{\mathrm{d}\omega}$$
- **卷积**：
  $$f(t)*g(t)\longleftrightarrow F(j\omega)G(j\omega)$$
- **乘积**：
  $$f(t)g(t)\longleftrightarrow\frac{1}{2\pi}\left[F(j\omega)*G(j\omega)\right]$$
- **对偶性**：若$f(t)\longleftrightarrow F(j\omega)$，再令$g(t)=F(jt)$，则
  $$G(j\omega)=2\pi f(-\omega)$$
- **Parseval–Plancherel等式**：
  $$\int_{-\infty}^{\infty}f(t)g^*(t)\,\mathrm{d}t=\frac{1}{2\pi}\int_{-\infty}^{\infty}F(j\omega)G^*(j\omega)\,\mathrm{d}\omega$$
  特别地，
  $$\int_{-\infty}^{\infty}|f(t)|^2\,\mathrm{d}t=\frac{1}{2\pi}\int_{-\infty}^{\infty}|F(j\omega)|^2\,\mathrm{d}\omega$$
- **相关定理**：若
  $$R_{fg}(\tau)=\int_{-\infty}^{\infty}f^*(t)g(t+\tau)\,\mathrm{d}t$$
  则
  $$R_{fg}(\tau)\longleftrightarrow F^*(j\omega)G(j\omega)$$
  自相关函数的Fourier变换为能量谱密度$|F(j\omega)|^2$。
- **Hilbert变换**：若
  $$\mathcal{H}\{f\}(t)=f(t)*\operatorname{PV}\frac{1}{\pi t}$$
  则
  $$\mathcal{H}\{f\}(t)\longleftrightarrow-j\operatorname{sgn}(\omega)F(j\omega)$$

## 积分特性与主值分布
若
$$g(t)=\int_{-\infty}^{t}f(\tau)\,\mathrm{d}\tau$$
则在分布意义下
$$G(j\omega)=\operatorname{PV}\frac{F(j\omega)}{j\omega}+\pi F(0)\delta(\omega)$$
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
设连续信号$f(t)$的Fourier变换为$F(j\omega)$，以间隔$T$采样。采样后的冲激串为
$$g(t)=\sum_{n=-\infty}^{\infty}f(nT)\delta(t-nT)$$
其频谱为
$$\boxed{G(j\omega)=\frac{1}{T}\sum_{k=-\infty}^{\infty}F(j(\omega-k\Omega_s))},\quad \Omega_s=\frac{2\pi}{T}$$
另一方面，直接对$g(t)$作连续时间Fourier变换得到
$$G(j\omega)=\sum_{n=-\infty}^{\infty}f(nT)e^{-j\omega nT}=\tilde F(j\omega)$$
于是得到Poisson求和公式
$$\boxed{\sum_{n=-\infty}^{\infty}f(nT)e^{-j\omega nT}=\frac{1}{T}\sum_{k=-\infty}^{\infty}F(j(\omega-k\Omega_s))}$$
它同时说明：时域离散化会在频域产生周期复本。采样定理、混叠和理想重构见[[连续时间信号的采样]]。

# 离散时间Fourier变换
## 定义与周期性
离散序列记为$f(nT)$。其频谱为周期函数，所以记作$\tilde F(j\omega)$：
$$\boxed{\tilde F(j\omega)=\mathrm{DTFT}\{f(nT)\}=\sum_{n=-\infty}^{\infty}f(nT)e^{-j\omega nT}}$$
逆变换可在任意长度为$2\pi/T$的频率区间上进行：
$$\boxed{f(nT)=\mathrm{DTFT}^{-1}\{\tilde F(j\omega)\}=\frac{T}{2\pi}\int_{\omega_0}^{\omega_0+2\pi/T}\tilde F(j\omega)e^{j\omega nT}\,\mathrm{d}\omega}$$
由于
$$e^{-j(\omega+2\pi/T)nT}=e^{-j\omega nT}$$
所以
$$\tilde F\left(j\left(\omega+\frac{2\pi}{T}\right)\right)=\tilde F(j\omega)$$
离散时间频谱在连续频率$\omega$上定义，但具有周期性。

## 基本性质
- **线性**：
  $$af(nT)+bg(nT)\longleftrightarrow a\tilde F(j\omega)+b\tilde G(j\omega)$$
- **离散时移**：
  $$f((n-m)T)\longleftrightarrow e^{-j\omega mT}\tilde F(j\omega)$$
- **频移**：
  $$e^{j\omega_0nT}f(nT)\longleftrightarrow\tilde F(j(\omega-\omega_0))$$
- **时间反转**：
  $$f(-nT)\longleftrightarrow\tilde F(-j\omega)$$
- **序列卷积**：若
  $$(f*g)(nT)=\sum_{m=-\infty}^{\infty}f(mT)g((n-m)T)$$
  则
  $$(f*g)(nT)\longleftrightarrow\tilde F(j\omega)\tilde G(j\omega)$$
- **序列乘积**：
  $$f(nT)g(nT)\longleftrightarrow\frac{T}{2\pi}\int_{\omega_0}^{\omega_0+2\pi/T}\tilde F(j\nu)\tilde G(j(\omega-\nu))\,\mathrm{d}\nu$$
  频域卷积按周期$2\pi/T$理解。
- **Parseval等式**：
  $$\sum_{n=-\infty}^{\infty}|f(nT)|^2=\frac{T}{2\pi}\int_{\omega_0}^{\omega_0+2\pi/T}|\tilde F(j\omega)|^2\,\mathrm{d}\omega$$
- **一阶差分**：
  $$f(nT)-f((n-1)T)\longleftrightarrow(1-e^{-j\omega T})\tilde F(j\omega)$$

## 常用离散时间变换公式
- **单位样值序列**：令$\delta_n=1$仅在$n=0$成立，则
  - $$\delta_n\longleftrightarrow1$$
  - $$\delta_{n-m}\longleftrightarrow e^{-j\omega mT}$$
- **单边指数序列**：令$u_n=1$对$n\geq0$成立。当$|a|<1$时，
  $$a^nu_n\longleftrightarrow\frac{1}{1-ae^{-j\omega T}}$$
- **有限长常数序列**：若$f(nT)=1$仅在$0\leq n\leq N-1$成立，则
  $$\tilde F(j\omega)=e^{-j\omega T(N-1)/2}\frac{\sin(N\omega T/2)}{\sin(\omega T/2)}$$
  其中比值按连续延拓解释。
- **离散单频序列**：
  $$e^{j\omega_0nT}\longleftrightarrow\Omega_s\sum_{k=-\infty}^{\infty}\delta(\omega-\omega_0-k\Omega_s),\quad \Omega_s=\frac{2\pi}{T}$$

# 离散Fourier级数
设$\tilde f(nT)$关于$n$以$N$为周期，即$\tilde f((n+N)T)=\tilde f(nT)$。总时间周期为$NT$，频率间隔为
$$\Omega=\frac{2\pi}{NT}$$
离散Fourier级数的时域和频域都是周期函数：
$$\boxed{\tilde f(nT)=\frac1N\sum_{k=0}^{N-1}\tilde F(jk\Omega)e^{jk\Omega nT}}$$
$$\boxed{\tilde F(jk\Omega)=\sum_{n=0}^{N-1}\tilde f(nT)e^{-jk\Omega nT}}$$
时域和频域指标都以$N$为周期：
$$\tilde f((n+N)T)=\tilde f(nT),\quad \tilde F(j(k+N)\Omega)=\tilde F(jk\Omega)$$

# 离散Fourier变换
## 定义
对长度为$N$的有限序列$f(nT)$，$n=0,1,\ldots,N-1$，定义
$$\boxed{F(jk\Omega)=\mathrm{DFT}\{f(nT)\}=\sum_{n=0}^{N-1}f(nT)e^{-jk\Omega nT}}$$
$$\boxed{f(nT)=\mathrm{DFT}^{-1}\{F(jk\Omega)\}=\frac{1}{N}\sum_{k=0}^{N-1}F(jk\Omega)e^{jk\Omega nT}}$$
其中
$$\Omega=\frac{2\pi}{NT},\quad k=0,1,\ldots,N-1$$

DFT有两种等价理解：

- 它是有限序列的DTFT $\tilde F(j\omega)$在$\omega=k\Omega$处的$N$个等间隔样值。
- 它把离散Fourier级数的一个时域主值区间与一个频域主值区间对应起来。把两端作$N$点周期延拓后，就得到$\tilde f(nT)$与$\tilde F(jk\Omega)$。

## 常用性质
- **圆周时移**：若$g(nT)=f(\langle n-m\rangle_NT)$，其中$\langle\cdot\rangle_N$表示模$N$取值，则
  $$G(jk\Omega)=e^{-jk\Omega mT}F(jk\Omega)$$
- **频率移位**：
  $$e^{jk_0\Omega nT}f(nT)\longleftrightarrow F(j\langle k-k_0\rangle_N\Omega)$$
- **圆卷积**：
  $$f(nT)\circledast_Ng(nT)\longleftrightarrow F(jk\Omega)G(jk\Omega)$$
- **时域乘积**：
  $$f(nT)g(nT)\longleftrightarrow\frac1N\left[F(jk\Omega)\circledast_NG(jk\Omega)\right]$$
- **Parseval等式**：
  $$\sum_{n=0}^{N-1}|f(nT)|^2=\frac1N\sum_{k=0}^{N-1}|F(jk\Omega)|^2$$
- **实序列的共轭对称性**：
  $$F(j(N-k)\Omega)=F^*(jk\Omega)$$
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
对偶数$N$，把偶数样值序列和奇数样值序列分别记作$g$和$h$，其$N/2$点DFT分别记作$G(jk\Omega)$和$H(jk\Omega)$，则
$$F(jk\Omega)=G(jk\Omega)+W_N^kH(jk\Omega)$$
$$F(j(k+N/2)\Omega)=G(jk\Omega)-W_N^kH(jk\Omega)$$
递归分解后，运算复杂度由直接计算的$O(N^2)$降为$O(N\log N)$。基2 FFT通常要求$N=2^m$；混合基和Bluestein算法可处理其他长度。

# 短时Fourier变换
## 定义
Fourier变换给出整个信号的总体频谱，但不保留某个频率在何时出现的信息。短时Fourier变换用移动窗截取局部片段，对每一片分别作Fourier变换。

连续频率形式可写成
$$F(\tau,j\omega)=\sum_{n=-\infty}^{\infty}f(nT)w(nT-\tau)e^{-j\omega nT}$$
实际计算通常取长度为$M$的窗、帧移为$H$个样值，并作$N$点DFT：
$$\boxed{F(rHT,jk\Omega)=\sum_{m=0}^{M-1}f((rH+m)T)w(mT)e^{-jk\Omega mT}}$$
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
$$F(\vec{k})=\int_{\mathbb{R}^d}f(\vec{r})e^{j\vec{k}\cdot\vec{r}}\,\mathrm{d}^d\vec{r}$$
$$f(\vec{r})=\int_{\mathbb{R}^d}F(\vec{k})e^{-j\vec{k}\cdot\vec{r}}\frac{\mathrm{d}^d\vec{k}}{(2\pi)^d}$$
于是

- **梯度**：
  $$\nabla f\longleftrightarrow-j\vec{k}F(\vec{k})$$
- **Laplacian**：
  $$\nabla^2f\longleftrightarrow-|\vec{k}|^2F(\vec{k})$$
- **卷积**：
  $$(f*g)(\vec{r})\longleftrightarrow F(\vec{k})G(\vec{k})$$

这使常系数线性偏微分方程在频域中化为代数方程，具体应用见[[位势方程#Fourier变换法|位势方程的Fourier变换法]]。
