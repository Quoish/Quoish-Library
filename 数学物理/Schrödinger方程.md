#量子力学 
# Schrödinger方程
对于一个质量为$m$的非相对论自由粒子，当其具有确定的能量$E=\hbar \omega$和动量$\vec{p}=\hbar \vec{k}$时，波函数为
$$\Psi(\vec{r},t)=(2\pi \hbar)^{-3/2}e^{i(\vec{p}\cdot \vec{r}-Et)/\hbar}$$
其中满足$E=\dfrac{p^2}{2m}$
两边对时间$t$求偏导有$$i\hbar \frac{ \partial   }{ \partial  t} \Psi(\vec{r},t)=E\Psi(\vec{r},t)$$
两边再同时求调和量有
$$-\frac{\hbar^2}{2m}\nabla^2\Psi(\vec{r},t)=\frac{p^2}{2m}\Psi(\vec{r},t)$$
于是我们发现
$$-\frac{\hbar^2}{2m}\nabla^2\Psi(\vec{r},t)=i\hbar \frac{ \partial   }{ \partial  t} \Psi(\vec{r},t)$$
同时，这个方程对于更一般的、动量不确定的自由粒子也同样成立，因为如果考虑更一般的自由粒子波函数以动量本征态为基底展开时
$$\Psi(\vec{r},t)=(2\pi \hbar)^{-3/2}\int \varphi(\vec{p})e^{i(\vec{p}\cdot \vec{r}-Et)/\hbar}\mathrm{d}\vec{p}$$
进行同样的操作
$$i\hbar \frac{ \partial   }{ \partial  t} \Psi(\vec{r},t)=(2\pi \hbar)^{-3/2}\int E\varphi(\vec{p})e^{i(\vec{p}\cdot \vec{r}-Et)/\hbar}\mathrm{d}\vec{p}$$
$$-\frac{\hbar^2}{2m}\nabla^2\Psi(\vec{r},t)=(2\pi \hbar)^{-3/2}\int \frac{p^2}{2m} \varphi(\vec{p})e^{i(\vec{p}\cdot \vec{r}-Et)/\hbar}\mathrm{d}\vec{p}$$
依然能有$$-\frac{\hbar^2}{2m}\nabla^2\Psi(\vec{r},t)=i\hbar \frac{ \partial   }{ \partial  t} \Psi(\vec{r},t)$$
于是我们假设，更一般的情况，即使不再是自由粒子，而是在势场$V(\vec{r},t)$中的粒子，粒子依然能满足
$$\left( -\frac{\hbar^2}{2m}\nabla^2+V(\vec{r},t) \right) \Psi(\vec{r},t)=i\hbar \frac{ \partial   }{ \partial  t} \Psi(\vec{r},t)$$
这是量子力学的基本假设，假定微观世界粒子的运动规律都遵从这个方程，这个方程就被称作Schrödinger方程。
注意到$\hat{H}=-\frac{\hbar^2}{2m}\nabla^2+V(\vec{r},t)$，所以Schrödinger方程可以被改写为
$$\hat{H}\Psi(\vec{r},t)=i\hbar \frac{ \partial   }{ \partial  t} \Psi(\vec{r},t)$$
采样Dirac符号推广到一般表象则表示为
$$\hat{H}\ket{\Psi(t)} =i\hbar \frac{ \partial   }{ \partial  t} \ket{\Psi(t)} $$
# 定态Schrödinger方程
首先考虑Hamilton量不含时的体系，即$V(\vec{r})$不含时间$t$，体系满足
$$\left( -\frac{\hbar^2}{2m}\nabla^2+V(\vec{r},t) \right) \Psi(\vec{r},t)=i\hbar \frac{ \partial   }{ \partial  t} \Psi(\vec{r},t)$$
此时可以设
$$\Psi(\vec{r},t)=\psi(\vec{r})f(t)$$
然后引入常数$E$，分离变量$t$得到
$$\frac{i\hbar}{f(t)} \frac{ \mathrm{d}  f(t) }{ \mathrm{d}  t} =E$$
可以解出$$\Psi(\vec{r},t)=\psi(\vec{r})e^{-iEt/\hbar}$$这是Hamilton不含时体系的时间演化。
这个体系的状态是能量保持不变的能量本征态的叠加，所以也被称作定态。
此时分离出来的关于位矢$\vec{r}$的方程$$\left [ -\frac{\hbar^2}{2m}\nabla^2 + V(\vec r)  \right ] \psi(\vec r)=E\psi(\vec r)$$被称作定态Schrödinger方程。
求解Hamilton不含时体系的波函数由此转换成了能量本征值问题的求解过程
$$\hat{H}\psi=E\psi$$
## 定态问题的一般性质
1. 设$\psi$是定态Schrödinger方程的一个解,则$\psi^*$也是
2. 对应于某个能量本征值$E$，总可以找到定态Schrödinger方程的一组完备的实解,即凡是属于E的任何解，均可表示为这一组实解的线性叠加
3. 设$V(x)$具有空间反射不变性，$V(-x)=V(x)$。如$ψ(x)$为定态Schrödinger方程的一个解(属于$E$)，则$ψ(-x)$也是方程的一个解，也属于$E$
4. 设$V(-x)=V(x)$,则对应于任何一个能量本征值E，总可以找到方程的一组完备的解，它们中每一个都具有确定的宇称(奇偶性)。(注意:每一个解的宇称并不一定相同)
5. 对于一维运动粒子,设$ψ_{1}(x)$与$ψ_{2}(x)$是方程的属于能量本征值$E$的两个解,则$\psi_1\psi_2'-\psi_2\psi_1'=\text{Const}$
6. 设$V(x)$是规则势场,如存在束缚态,则必定是不简 并的