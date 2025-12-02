#场论 
Voigt记号（也称为Voigt标记法）是连续介质力学、固体力学和材料科学中一种广泛应用的方法，用于简化对称高阶张量的表示和计算，特别是二阶对称张量（如应力和应变）和四阶张量（如刚度或柔度张量）。
基本思想是：利用对称性进行降维。
# 二阶张量
二阶张量$T_{ij}$原本有$3\times 3=9$个分量。
但当二阶张量具有对称性$T_{ij}=T_{ji}$时，**独立的分量从9个变成6个**。
我们约定
$$        \begin{aligned}
        ij & \rightarrow \alpha \\
        11 & \rightarrow 1 \\
        22 & \rightarrow 2 \\
        33 & \rightarrow 3 \\
        23 \text{ 或 } 32 & \rightarrow 4 \\
        13 \text{ 或 } 31 & \rightarrow 5 \\
        12 \text{ 或 } 21 & \rightarrow 6
        \end{aligned}$$
由此将两个指标$ij$化为一个指标$\alpha$。
在物理学中，这样的对称二阶张量的实例有应力$\sigma_{ij}=\sigma_{\alpha}$，应变$\varepsilon_{ij}=\varepsilon_{\alpha}$。
## 因子2问题
在文献中Voigt记号通常存在两种约定。
学术中更多采用包含因子2的约定，即$$\begin{pmatrix}
\varepsilon_{11} \\
\varepsilon_{22} \\
\varepsilon_{33} \\
2\varepsilon_{23} \\
2\varepsilon_{31} \\
2\varepsilon_{12}
\end{pmatrix}=
\begin{pmatrix}
\varepsilon_{1} \\
\varepsilon_{2} \\
\varepsilon_{3} \\
\varepsilon_{4} \\
\varepsilon_{5} \\
\varepsilon_{6}
\end{pmatrix}$$
而工程上更多采用不含因子2的约定，即$$\begin{pmatrix}
\varepsilon_{11} \\
\varepsilon_{22} \\
\varepsilon_{33} \\
\varepsilon_{23} \\
\varepsilon_{31} \\
\varepsilon_{12}
\end{pmatrix}=
\begin{pmatrix}
\varepsilon_{1} \\
\varepsilon_{2} \\
\varepsilon_{3} \\
\varepsilon_{4} \\
\varepsilon_{5} \\
\varepsilon_{6}
\end{pmatrix}$$
# 三阶张量
三阶张量$P_{ijk}$原本有$3\times3\times 3=27$个分量。
但当三阶张量的其中两个具有指标对称性$P_{ijk}=P_{ikj}$时，**独立的分量从27个变成18个**。
我们约定
$$        \begin{aligned}
        jk & \rightarrow \beta \\
        11 & \rightarrow 1 \\
        22 & \rightarrow 2 \\
        33 & \rightarrow 3 \\
        23 \text{ 或 } 32 & \rightarrow 4 \\
        13 \text{ 或 } 31 & \rightarrow 5 \\
        12 \text{ 或 } 21 & \rightarrow 6
        \end{aligned}$$
由此将三个指标$ijk$化为两个指标$i\beta$。
在物理学中，这样的对称二阶张量的实例有压电常数$d_{ijk}=d_{i\beta}$。
# 四阶张量
四阶张量$E_{ijkl}$原本有$3\times3\times 3\times 3=81$个分量。
四阶在使用Voigt记号简化时，需要满足以下对称性之一。
## 亚对称性
当只有其中两个指标满足对称性$E_{ijkl}=E_{jikl}$时，独立的变量从81个变成54个。
按和二阶张量一样的规则，由此将四个指标$ijkl$化为三个指标$\alpha kl$。
## 小对称性
当其中两对指标满足对称性$E_{ijkl}=E_{jikl}=E_{ijlk}$时，独立的变量从81个变成36个。
把前两个指标$ij$按照Voigt规则映射为$\alpha$，把后两个指标$kl$按照Voigt规则映射为$\beta$。
由此将四个指标$ijkl$化为两个指标$\alpha \beta$。
在物理学中，这样的小对称四阶张量的实例有弹性刚度张量$C_{ijkl}=C_{\alpha \beta}$。
## 大对称性
当其中两对指标满足对称性$E_{ijkl}=E_{jikl}=E_{ijlk}$时，且第一对指标和第二对指标也对称时$E_{ijkl}=E_{klij}$，**独立的变量从81个变成21个**。
这意味着在利用小对称性将四阶张量$E_{ijkl}$化为二阶张量$E_{\alpha \beta}$时，二阶张量$E_{\alpha \beta}$也是个二阶对称张量，它可以继续利用Voigt规则化为有21个分量的一阶张量$E_{\mathcal{A}}$。
在物理学中，这样的小对称四阶张量的实例有超弹性刚度张量$C_{ijkl}=C_{\alpha \beta}=C_{\mathcal{A}}$。