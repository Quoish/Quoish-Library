#统计物理 
根据[[三种粒子系统分布的微观状态数#玻色系统的微观状态数]]，两边取对数
$$\ln W=\sum_{l}\{ \ln(g_{l}+N_{l}-1)!-\ln N_{l}!-\ln(g_{l}-1)! \}$$
假设$N_{l}\gg 1, g_{l} \gg 1$，再用Stirling公式：
$$\ln W=\sum_{l}\{ (g_{l}+N_{l})\ln(g_{l}+N_{l})-N_{l}\ln N_{l}-g_{l}\ln g_{l} \}$$
设Lagrange函数
$$\mathcal{L}=\ln W+\alpha\left( N-\sum_{l}N_{l} \right)+\beta\left( \sum_{l}N_{l}\varepsilon_{l}-E \right)$$
满足$$\left.\frac{ \partial  \mathcal{L} }{ \partial  N_{l}}  \right|_{N_{l}=N_{l}^0}=0  $$
于是$$N_{l}^0 =\frac{g_{l}}{e^{\alpha+\beta \varepsilon_{l}}-1},\quad l=0,1,2,\dots$$
这就是玻色系统的最可几分布，称为Bose-Einstein分布。
# 热力学公式
## 巨配分函数
$$\tilde{Z}=\prod_{l}(1-e^{-\alpha - \beta \varepsilon_{l}})$$这个公式的由来见[[系综理论#理想Bose气体的巨分配函数]]。
## 粒子总数
$$N=-\frac{ \partial  \ln \tilde{Z} }{ \partial  \alpha} $$
## 内能
$$U=-\frac{ \partial  \ln \tilde{Z} }{ \partial  \beta} $$
## 广义力
$$Y=-\frac{1}{\beta}\frac{ \partial  \ln \tilde{Z} }{ \partial  y} $$
## 熵
$$S=k_{B}\left( \ln \tilde{Z}-\alpha \frac{ \partial  \ln \tilde{Z} }{ \partial  \alpha} -\beta \frac{ \partial  \ln \tilde{Z} }{ \partial  \beta}  \right)$$
## 参数
$$\alpha = -\frac{\mu}{k_{B}T},\quad \beta=\frac{1}{k_{B}T}$$
# 临界温度
当温度升高到一定程度时，最低能级的粒子变成0了，所有粒子都不再是未激发的状态，此时的温度称作临界温度
# Einstein凝结
当温度趋于绝对零度时，系统的粒子全部填充到了最低能级上，这时杂乱无章的分子都变得步调一致了，这个现象称作Einstein凝结。
# 光子气体