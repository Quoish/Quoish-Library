#微分几何 
# Riemann张量
我们之前根据$$\omega_{b}|_{p}=\omega'_{b}|_{p}\implies(\nabla_{a}-\tilde{\nabla}_{a})\omega_{b}|_{p}=(\nabla_{a}-\tilde{\nabla}_{a})\omega_{b}'|_{p}$$发现$(\nabla_{a}-\tilde{\nabla}_{a})$的作用只和$p$点有关，并且满足线性性，故引入了[[导数算符#Christoff符号]]。
称$\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a}$是$\nabla_{a}$的对易子，我们会发现它也有类似的性质。
- 设$f \in \mathscr{F}_{M},\omega_{a}\in \mathscr{F}_{M}(0,1)$，则$$(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})f\omega_{b}=f(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})\omega_{b}$$
- 设$\omega_{c},\omega'_{c} \in \mathscr{F}_{M}(0,1)$且$\omega_{c}|_{p}=\omega_{c}'|_{p}$，则$$(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})\omega_{c}|_{p}=(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})\omega'_{c}|_{p}$$

上面两条定理说明$(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})$对应一个$(1,3)$型张量$R_{abd}^d$，称为**Riemann曲率张量**。
>导数算符$\nabla_{a}$的*Riemann曲率张量*定义为$$(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})\omega_{c}=R_{abc}^d\omega_{d},\quad \forall \omega_{c}\in \mathscr{F}_{M}(0,1)$$

- Riemann曲率张量对矢量的作用为$$(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})v^{c}=-R_{abd}^dv^{c},\quad \forall v^{c}\in \mathscr{F}_{M}(1,0)$$
- Riemann曲率张量对$(k,l)$型张量为$$(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})T^{c_{1}\dots c_{k}}_{d_{1}\dots d_{l}}=-\sum_{i}R^{c_{i}}_{abe}T^{c_{1}\dots e\dots c_{k}}_{d_{1}\dots d_{l}}+\sum_{i}R^e_{abd_{i}}T^{c_{1}\dots c_{k}}_{d_{1}\dots e\dots d_{l}}$$
Riemann曲率张量反应了导数算符的非对易性，是描述$(M,\nabla_{a})$内禀性质的张量场。
对于配备了度规$g_{ab}$的流形，也可以说与度规相适配的导数算符诱导的Riemann曲率张量，因此也可以叫$g_{ab}$的Riemann曲率张量。
Riemann张量为0的度规称为*平直度规*（Flat Metric）。
- Euclidean空间$(\mathbb{R}^n,\delta_{ab})$和Minkowski空间$(\mathbb{R}^n,\eta_{ab})$的Riemann曲率张量为零。

若流形上有度规场$g_{ab}$，可定义$R_{abcd}=R_{abc}^eg_{ed}$，Riemann曲率张量满足以下性质：
1. 前两个指标反对称$R_{abc}^d=-R_{bac}^d$。
2. 后两个指标反对称$R_{abcd}=-R_{abdc}$。
3. 前两个指标和后两个指标对称$R_{abcd}=R_{cdab}$。
4. 循环恒等式$R_{[abc]}^c=0$。
5. Bianchi恒等式$\nabla_{[a}R_{bc]d}^e=0$。

这里只证明循环恒等式：
因为$R_{[abc]}^d\omega_{d}=\nabla_{[a}\nabla_{b}\omega_{c]}-\nabla_{[b}\nabla_{a}\omega_{c]}=2\nabla_{[a}\nabla_{b}\omega_{c]}$，所以我们只需要看$$
\begin{align}
\nabla_{a}(\nabla_{b}\omega_{c})&=\partial_{a}(\nabla_{a}\omega_{c})-\Gamma_{ab}^{d}\nabla_{d}\omega_{c}-\Gamma_{ac}^{d}\nabla_{b}\omega_{d} \\
&=\partial_{a}\partial_{b}\omega_{c}-\Gamma^e_{bc}\partial_{a}\omega_{e}-\omega_{e}\partial_{a}\Gamma_{bc}^e-\Gamma_{ab}^{d}\nabla_{d}\omega_{c}-\Gamma_{ac}^{d}\nabla_{b}\omega_{d}
\end{align}$$故$$\begin{align}
\nabla_{[a}\nabla_{b}\omega_{c]}&=\partial_{[a}\partial_{b]}\omega_{c}-\Gamma^e_{[bc}\partial_{a]}\omega_{e}-\omega_{e}\partial_{[a}\Gamma_{bc]}^e-\Gamma_{[ab}^{d}\nabla_{|d|}\omega_{c]}-\Gamma_{[ac}^{d}\nabla_{b]}\omega_{d} \\
&=\partial_{[(a}\partial_{b)]}\omega_{c}-\Gamma^e_{[(bc)}\partial_{a]}\omega_{e}-\omega_{e}\partial_{[a}\Gamma_{(bc)]}^e-\Gamma_{[(ab)}^{d}\nabla_{|d|}\omega_{c]}-\Gamma_{[(ac)}^{d}\nabla_{b]}\omega_{d} \\
&=0
\end{align}$$这是根据括号内带异种括号的性质。
- 设$\dim M=n$，则$R_{abc}^d$的分量应该有$n^4$的，但是根据上面的对称性，其中独立的分量只有$N=n^2(n^2-1)/12$个。
# 其他曲率张量
## Ricci张量
和矩阵一样，我们想关注Riemann张量中可交换、与坐标无关的量，这就是迹。
让Riemann张量$R_{abc}^d$用度规$g_{ab}$升降指标，得到$(0,4)$型张量$R_{abcd}$，可以通过缩并得到6种迹：$$g^{ab}R_{abcd},g^{ac}R_{abcd},g^{ad}R_{abcd},g^{bc}R_{abcd},g^{bd}R_{abcd},g^{cd}R_{abcd}$$每一种都是一个$(0,2)$型张量。但根据对称括号的性质，所以$g^{(ab)}R_{[ab]cd},g^{(cd)}R_{ab[cd]}$为0，$g^{ac}R_{abcd}$和$g^{bd}R_{abcd}$、$g^{ad}R_{abcd}$和$g^{bc}R_{abcd}$是同一回事，这两对之间又是负号关系，所以这六个缩并中只有一个独立。
例如可以记$g^{bd}R_{abcd}=R_{abc}^{b}$为$R_{ac}$，称为*Ricci张量*。
Ricci张量$R_{ac}$还能利用度规求迹，记$R=g^{ac}R_{ac}$，称为*标量曲率*（Scalar Curvature）。
注意：Ricci张量不需要依赖度规也可以靠定义Riemann张量的缩并定义，而标量曲率必须依赖度规定义。
## Weyl张量
Riemann张量的无迹部分称为Weyl张量，其定义如下：
>对$\dim M\geq 3$的广义Riemann空间，Weyl张量$C_{abcd}$定义为$$C_{abcd}:=R_{abcd}- \frac{2}{n-2}(g_{a[c}R_{d]b}-g_{b[c}R_{d]a})+\frac{2}{(n-1)(n-2)}Rg_{a[c}g_{d]b}$$

其具有以下性质：
- $C_{abcd}=-C_{bacd}=-C_{abdc}=C_{cdab}$。
- $C_{[abc]d}=0$。
- $C_{abcd}$的各种迹都为0。
## Einstein张量
>广义Riemann空间的Einstein张量定义为$$G_{ab}:=R_{ab}-\frac{1}{2}Rg_{ab}$$

- $\nabla^aG_{bc}=0$。
# 用度规计算Riemann张量
由Riemann张量定义有$\nabla_{a}(\nabla_{b}\omega_{c})=R_{abc}^d\omega_{d}=2\nabla_{[a}\nabla_{b]}\omega_{c}$，根据$$\nabla_{a}(\nabla_{b}\omega_{c})=\partial_{a}\partial_{b}\omega_{c}-\Gamma^e_{bc}\partial_{a}\omega_{e}-\omega_{e}\partial_{a}\Gamma_{bc}^e-\Gamma_{ab}^{d}\nabla_{d}\omega_{c}-\Gamma_{ac}^{d}\nabla_{b}\omega_{d}$$继续展开$\nabla_{b}$，用一样的对称性括号性质可以得到$$R_{abc}^d=-2\partial_{[a}\Gamma^d_{b]c}+2\Gamma_{c[a}^e\Gamma_{b]e}^{d}$$其坐标分量为$$R_{\mu \nu \sigma}^{\rho}=-\partial_{\mu}\Gamma_{\nu \sigma}^{\rho}+\partial_{\nu}\Gamma_{\mu \sigma}^\rho +\Gamma_{\sigma \mu}^{\lambda}\Gamma_{\nu \lambda}^\rho-\Gamma_{\sigma \nu}^{\lambda}\Gamma_{\mu \lambda}^{\rho}$$
