#线性代数 
# 特征值和特征向量
>$\mathbf{A}$是域$F$上线性空间$V$的一个线性变换，若$V$中存在一个非零向量$\xi$，$F$中存在一个元素$\lambda_{0}$，使得$$\mathbf{A}\xi=\lambda_{0}\xi$$该方程称为*特征方程/本征方程/久期方程*，则称$\xi$是属于$\mathbf{A}$的*特征值/本征值*$\lambda_{0}$的一个*特征向量/本征向量*。

若$\mathbf{A}$在一组基下的矩阵是方阵$A$，则$$\mathbf{A}\xi=\lambda \xi \Leftrightarrow  A\xi=\lambda \xi$$
- 矩阵$A$的特征值是*特征多项式*$$|A-\lambda I|=0$$的根，矩阵$A$的特征向量是$$(A-\lambda I)x=0$$的非零解。
- 相似的矩阵必定有相同的特征多项式、特征值（重数也相同），但特征向量一般不相同。反过来特征多项式相同的矩阵不一定相似。
- 对易的矩阵必定有相同的特征向量，但特征值不一定相同。反过来有相同特征向量的矩阵一定对易。
>设$\mathbf{A}$是域$F$上线性空间$V$上的一个线性变换，$\lambda_0$是$\mathbf{A}$的一个特征值，令$$V_{\lambda_0}:=\{\alpha\in V|\mathbf{A}\alpha=\lambda_0\alpha\}$$易证是个子空间，称$V_{\lambda_0}$是属于$\lambda_0$的*特征子空间*。

>设$\lambda_{1}$是数域F上矩阵$A$的一个特征值，定义：
>属于$\lambda_{1}$的特征子空间的维数，也就是特征方程的解空间维数称为*几何重数*。
>$\lambda_{1}$作为特征多项式的根的重数称为*代数重数*。

- 代数重数$≥$几何重数。
# 线性空间的直和分解
>$V$是域$F$上的线性空间，$\mathbf{A}$是$V$上的一个线性变换，$V$的子空间$W$若满足任意$α∈W$，都有$Aα∈W$，则$W$是$\mathbf{A}$的一个*不变子空间*。

不变子空间是特征子空间的推广。线性映射可对角化时，线性空间可以分解为特征子空间的直和；线性映射不可对角化时，线性空间可以分解为不变子空间的直和。
- 零空间是不变子空间，被称为平凡不变子空间。
- $\mathrm{Ker}\mathbf{A},\mathrm{Im}\mathbf{A}$是$\mathbf{A}$的不变子空间。
- $\mathbf{A}$的特征子空间是$\mathbf{A}$的不变子空间。
- 设$F[x]$是数域$F$上的一元多项式环，$f \in F[x]$，则$\mathrm{Ker}f(\mathbf{A}),\mathrm{Im}f(\mathbf{A})$，$f(\mathbf{A})$的特征子空间都是$\mathbf{A}$的不变子空间。
- $\mathbf{A}$各不变子空间的交和并仍是不变子空间。

>设$f(x)\in F[x],f(x)=b_nx^n+\cdots+b_1x+b_0$，若$f(\mathbf{A})=\mathbf{0}$，则$f(x)$称作$\mathbf{A}$的*零化多项式*。
>其中$\mathbf{A}$的所有零化多项式中次数最低的首一零化多项式称为*最小多项式*。

- *Hamilton-Cayley定理*：设$A\in M_n(F)$，则$A$的特征多项式$f(\lambda)$是$A$的一个零化多项式。
- 根据唯一因式分解定理，特征多项式可以因式分解为$$0=f(\lambda)=p_{1}^{r_1}(\lambda)p_{2}^{r_2}(\lambda)\cdots p_{s}^{r_s}(\lambda)$$两边取$\mathrm{Ker}$得到$$\mathrm{Ker}\ \mathbf{0} = V =\mathrm{Ker}(p_{1}^{r_1}(\mathbf{A})) \oplus \mathrm{Ker}(p_{2}^{r_2}(\mathbf{A})) \oplus \cdots \oplus \mathrm{Ker}(p_{s}^{r_s}(\mathbf{A}))$$因此任意有限维线性空间$V$可以分解为$\mathbf{A}$的非平凡不变子空间的直和。
- 若特征多项式$f(λ)$可分解成若干的一次因式的积（代数基本定理保证了这在复数域一定做得到），则有下式$$V =\mathrm{Ker}((\mathbf{A}-\lambda I)^{r_1}) \oplus \mathrm{Ker}((\mathbf{A}-\lambda I)^{r_2}) \oplus \cdots \oplus \mathrm{Ker}((\mathbf{A}-\lambda I)^{r_s})(\mathbf{A}))$$其中各核是特殊的不变子空间，被称作$\mathbf{A}$的*根子空间*。
# 矩阵对角化
>设$A$是数域$F$下的一个$n$级**方阵**，即$A\in M_{n}(F)$，若$A$相似于一个对角矩阵，则称$A$可对角化。

计算矩阵对角化时，需要找到一个可逆矩阵$P$，使得$$A=P\Lambda P^{-1}$$其中$\Lambda$是对角矩阵。
或者$$\Lambda=P^{-1}AP$$
## 矩阵对角化的充要条件
域$F$上$n$维线性空间$V$上的线性变换$\mathbf{A}$可对角化的六大充要条件：
1. $\mathbf{A}$有$n$个线性无关的特征向量$\xi_{1},\xi_{2},\cdots,\xi_{n}$，使得$\mathbf{A}$在这些向量构成的基下矩阵为对角矩阵。
2. $n$维线性空间$V$中有$\mathbf{A}$的特征向量构成的一个基。
3. $\mathbf{A}$的属于不同特征值的特征子空间$V_{\lambda_{i}}$的维数之和等于线性空间$V$的维数$n$，即$\dim V = \dim V_{\lambda_{1}}+\dim V_{\lambda_{2}}+\cdots+\dim V_{\lambda_{n}}$。
4. $n$维线性空间$V$可以分解为$\mathbf{A}$的特征子空间的直和$V=V_{\lambda_{1}}\oplus V_{\lambda_{2}} \oplus \cdots \oplus V_{\lambda_{s}}$。
5. $\mathbf{A}$的特征多项式$|A-\lambda I|$在$F$下可以分解为不同的一次因式的乘积，即$f(\lambda)=(\lambda-\lambda_{1})^{r_{1}}(\lambda-\lambda_{2})^{r_{2}}\cdots(\lambda-\lambda_{n})^{r_{n}}$，且**代数重数=几何重数**。
6. $\mathbf{A}$的最小多项式$m(λ)$可以在$F[λ]$中能分解成**不同的一次因式**的乘积。
# 矩阵对角化的计算
1. 求本征值。
求解关于$\lambda$的方程$$\det(A-\lambda I)=0$$得到$A$的$n$个本征值。

2. 构造对角矩阵。
将$\lambda_{i}$沿对角排列，即是$A$对角化后的矩阵$$\Lambda=\begin{pmatrix}
\lambda_{1} &  \\
 & \lambda_{2} &  \\
 &  &  \dots\\
 &  &  & \lambda_{n}
\end{pmatrix}$$

3. 求本征向量。
对于每一个特征值$\lambda_{i}$，代入下面的齐次线性方程组$$(A-\lambda_{i}I)x_{i}=0$$求解$x_{i}$，$x_{i}$即为$\lambda_{i}$对应的本征向量。

4. 构造过渡矩阵。
将各个本征向量按列排列，即是过渡矩阵$$P=\begin{pmatrix}
x_{1} & x_{2} & \dots & x_{n}
\end{pmatrix}$$注意：排列顺序应该和本征值一一对应。
## 重根的情况
可对角化的矩阵，其**代数重数一定等于几何重数**，即$\det(A-\lambda)=0$的所有根$\lambda_{i}$若是$r$重根（代数重数），则其本征子空间也就是$(A-\lambda I)x=0$的解空间维数（几何重数）也一定是$r$。
譬如$\lambda_{i}$是2重根的情况，那在对角矩阵中就需要把$\lambda_{i}$摆2次，该本征值对应的两个本征向量$\vec{x}_{i1},\vec{x}_{i 2}$需要在这两个位置对应的地方摆（顺序不唯一，只要摆在这个范围就行了）。
# 正交对角化的计算
1. 求解关于$\lambda$的方程$$|A-\lambda I|=0$$得到$A$的所有本征值。
2. 对每一个特征值$\lambda_i$，求线性方程组$$(A-\lambda_iI)X=0$$的基础解系$α_{i_1},α_{i_2},…,α_{i_n}$。
3. 将基向量Schmit正交化$$β_{i_1},β_{i_2},…,β_{i_n}$$
4. 单位化为标准正交基$$η_{i_1},η_{i_2},…,η_{i_n}$$
5. 构造过渡矩阵$$T=(η_{11},…,η_{1r_1},…,η_{s1},…,η_{sr_s})$$则$T$是正交矩阵，$$T^{-1}AT=
\mathrm{diag}\{\underbrace{\lambda_{1},\cdots,\lambda_{1}}_{r_1个},\cdots,\underbrace{\lambda_{s},\cdots,\lambda_{s}}_{r_s个}\}$$
# Schmitd正交化的计算
取线性空间$V$中的一个基$α_1,α_2,…,α_n$，令：$$\beta_1=\alpha_1$$$$\beta_2=\alpha_2-\frac{(\alpha_2,\beta_1)}{(\beta_1,\beta_1)}\beta_1$$$$\beta_3=\alpha_3-\frac{(\alpha_3,\beta_1)}{(\beta_1,\beta_1)}\beta_1-\frac{(\alpha_3,\beta_2)}{(\beta_2,\beta_2)}\beta_2$$
以此类推……
$$\beta_n=\alpha_n-\sum_{j=1}^{n-1}\frac{(\alpha_n,\beta_j)}{(\beta_j,\beta_j)}\beta_j$$
# 矩阵的谱分解
设$A$已对角化为$$A=Q\Lambda Q^{-1}$$其中$Q=(v_{1},v_{2},\dots,v_{n})$，本征值分别为$\lambda_{1},\lambda_{2},\dots,\lambda_{n}$。
则上面的式子也可以化为和式$$A=\lambda_{1}v_{1}v_{1}^T+\lambda_{2}v_{2}v_{2}^T+\dots+\lambda_{n}v_{n}v_{n}^T$$这被称为矩阵的谱分解。
记$v_{i}v_{i}^T=P_{i}$，$P_{i}$则被称为投影矩阵，该矩阵作用在任意向量$x$上后，得到$$P_{i}x=v_{i}v_{i}^Tx=(v_{i}^Tx)v_{i}$$得到$x$在$v_{i}$方向上的投影，$(v_{i}^Tx)$是内积。
上式可以表达为$$A=\sum_{i}\lambda_{i}P_{i}$$矩阵$A$作用在任意矢量$x$上表现为$$Ax=\sum_{i}\lambda_{i}(P_{i}x)$$即$x$先投影到$v_{i}$方向上，然后再缩放对应的倍数$\lambda_{i}$。

量子力学中，谱分解可以表示为$$\hat{A}=\sum_{i}\lambda_{i}\ket{\lambda_{i}} \bra{\lambda_{i}} $$谱连续的情况下$$\hat{A}=\int \lambda_{i}\ket{\lambda_{i}} \bra{\lambda_{i}} $$