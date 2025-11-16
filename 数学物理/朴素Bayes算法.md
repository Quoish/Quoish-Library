#机器学习 #算法
朴素贝叶斯（naïve Bayes）法是基于贝叶斯定理与特征条件独立假设的分类方法。
其基本思想是：将待测实例分频到后验概率最大的类中。
具体地，训练数据集
$$T=\{(\vec{x}_{1},y_{1}),(\vec{x}_{2},y_{2}),\dots,(\vec{x}_{N},y_{N})\}$$
其中，$\vec{x}_{i} \in \mathcal{X} \subseteq \mathbb{R}^n$为实例的特征数据向量，$y_{i}\in \mathcal{Y} =\{c_{1},c_{2},\dots,c_{K}\}$为实例的类别，$i=1,2,\dots,N$；待测特征数据向量$\vec{x}$。
已知先验概率分布，这可以用训练数据集做最大似然估计得到
$$P(Y=c_{k})= \frac{\sum_{i=1}^N I(y_{i}=c_{k})}{N},\quad k=1,2,\dots,K$$
为了方便计算，假定$\vec{x}$的诸分量全部相互独立，这是一个相当强的假设，这也是其名称“朴素”的由来。
于是条件概率分布为
$$
\begin{align}
P(X=\vec{x}|Y=c_{k})&=P(X_{1}=x_{1},X_{2}=x_{2},\dots,X_{n}=x_{n}|Y=c_{k}) \\
&=\prod_{j=1}^n P(X_{j}=x_{j}|Y=c_{k})
\end{align}
$$
后验概率$P(Y=c_{k}|X=x)$可以用[[条件概率#Bayes公式]]计算：
$$
\begin{align}
P(Y=c_{k}|X=\vec{x})&= \frac{P(X=\vec{x}|Y=c_{k})P(Y=c_{k})}{P(X=\vec{x})} \\
&=\frac{P(X=\vec{x}|Y=c_{k})P(Y=c_{k})}{\sum_{k} P(X=\vec{x}|Y=c_{k})P(Y=c_{k})}  \\
&=\frac{P(Y=c_{k})\prod_{j=1}^n P(X_{j}=x_{j}|Y=c_{k})}{\sum_{k} P(X=\vec{x}|Y=c_{k})P(Y=c_{k})}
\end{align}
$$
这里运用了[[条件概率#全概率公式]]。我们只需要找到这个式子在哪个$c_{k}$取最大值就行，由于分母对于不管哪个$c_{k}$都是一样的，所以可以不用管分母。
于是，朴素Bayes分类器可以表示为
$$y=\arg\max_{c_{k}}{P(Y=c_{k})\prod_{j=1}^n P(X_{j}=x_{j}|Y=c_{k})}$$
事实上，后验概率最大化等价于期望风险最小化。
# 算法
- 输入：训练数据集
$$T=\{(\vec{x}_{1},y_{1}),(\vec{x}_{2},y_{2}),\dots,(\vec{x}_{N},y_{N})\}$$
其中，$\vec{x}_{i}=(x_{i1},x_{i2},\dots,x_{in}) \in \mathcal{X} \subseteq \mathbb{R}^n$为实例的特征数据向量，$y_{i}\in \mathcal{Y} =\{c_{1},c_{2},\dots,c_{K}\}$为实例的类别，$i=1,2,\dots,N$；待测特征数据向量$\vec{x}$
- 输出：待测特征数据向量$\vec{x}$对应的类$y$
- 步骤：
1. 根据训练集数据，计算Y的先验概率分布
$$P(Y=c_{k})= \frac{\sum_{i=1}^N I(y_{i}=c_{k})}{N},\quad k=1,2,\dots,K$$
2. 对测试集的$\vec{x}_{j},j=1,2,\dots,N$，计算诸分量的条件概率分布
$$P(X=x_{jl}|Y=c_{k})= \frac{\sum_{i=1}^N I(x_{i}=x_{jl}, y_{i}=c_{k})}{\sum_{i=1}^N I(y_{i}=c_{k})},\quad l=1,2,\dots,n$$
$$P(X=\vec{x}_{j}|Y=c_{k})=\prod_{l=1}^n P(X=x_{jl}|Y=c_{k})$$
3. 对给定的待测实例$\vec{x}$，计算
$$
\begin{align}
P(Y=c_{k}|X=\vec{x}) &\propto P(Y=c_{k})P(X=\vec{x}|Y=c_{k}) \\
&\propto P(Y=c_{k})\prod_{l=1}^n P(X=x_{l}|Y=c_{k})
\end{align}
$$
4. 找到取最大值时的$c_{k}$
$$
y=\arg \max_{c_{k}} P(Y=c_{k})\prod_{l=1}^n P(X=x_{l}|Y=c_{k})
$$
# 实现
