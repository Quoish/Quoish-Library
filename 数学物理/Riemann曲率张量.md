#微分几何 
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