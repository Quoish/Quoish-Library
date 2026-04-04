#微分几何 
我们之前根据$$\omega_{b}|_{p}=\omega'_{b}|_{p}\implies(\nabla_{a}-\tilde{\nabla}_{a})\omega_{b}|_{p}=(\nabla_{a}-\tilde{\nabla}_{a})\omega_{b}'|_{p}$$发现$(\nabla_{a}-\tilde{\nabla}_{a})$的作用只和$p$点有关，并且满足线性性，故引入了[[导数算符#Christoff符号]]。
称$\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a}$是$\nabla_{a}$的对易子，我们会发现它也有类似的性质。
- 设$f \in \mathscr{F}_{M},\omega_{a}\in \mathscr{F}_{M}(0,1)$，则$$(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})f\omega_{b}=f(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})\omega_{b}$$
- 设$\omega_{c},\omega'_{c} \in \mathscr{F}_{M}(0,1)$且$\omega_{c}|_{p}=\omega_{c}'|_{p}$，则$$(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})\omega_{c}|_{p}=(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})\omega'_{c}|_{p}$$

上面两条定理说明$(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})$对应一个$(1,3)$型张量$R_{abd}^d$，称为**Riemann曲率张量**。
>导数算符$\nabla_{a}$的Riemann曲率张量定义为$$(\nabla_{a}\nabla_{b}-\nabla_{b}\nabla_{a})\omega_{c}=R_{abc}^d\omega_{d},\quad \forall \omega_{c}\in \mathscr{F}_{M}(0,1)$$

