#场论 
# Nabla算子的二重性
Nabla原指一种希伯来竖琴。
Nabla算子定义为
$$\nabla := \hat{i}\frac{ \partial   }{ \partial  x} +\hat{j}\frac{ \partial   }{ \partial  y} +\hat{k}\frac{ \partial   }{ \partial  z} $$
其具有矢量和算符的二重性，既可以作为一个算符参与运算，也可以作为一个矢量参与运算，但它首先是个算子，例如不能像向量一样点乘交换对称、叉乘交换反对称：
$$
\begin{matrix}
\begin{align}
&\nabla \cdot \vec{A}\neq  \vec{A}\cdot \nabla
\\
&\nabla \times \vec{A}\neq  \vec{A}\times \nabla
\\
\end{align}
\end{matrix}
$$
同时作为一个算子，它可以享有微分特性。对$A$，$B$同时作用时，等于分别作用二者：
$$\begin{matrix}
\begin{align}
&\nabla \cdot (\vec{A}\cdot \vec{B})=\nabla_A \cdot (\vec{A}\cdot \vec{B})+\nabla_B \cdot (\vec{A}\cdot \vec{B})
\\
&\nabla \cdot (\vec{A}\times \vec{B})=\nabla_A \cdot (\vec{A}\times \vec{B})+\nabla_B \cdot (\vec{A}\times \vec{B})
\\
\end{align}
\end{matrix}$$
# 计算律
## 线性性
### 对常函数线性
$$\nabla (m u + nv)=
m\nabla u + n\nabla v$$
### 对矢量函数点乘线性
$$\nabla \cdot (m \vec{A} + n\vec{B})=
m\nabla \cdot \vec{A} + n\nabla \cdot \vec{B}$$
### 对矢量函数叉乘线性
$$\nabla \times (m \vec{A} + n\vec{B})=
m\nabla \times \vec{A} + n\nabla \times \vec{B}$$
## 乘法法则
这三种性质都可以将$\nabla$类比微分算子的“前导后不导+前不导后导”记忆。
### 直乘双常函数
$$\nabla (uv)=
v\nabla u + u\nabla v$$
### 点乘矢常函数
$$\nabla \cdot (u\vec{A})=
u(\nabla \cdot \vec{A}) +  (\nabla u) \cdot \vec{A}$$
### 叉乘矢常函数
$$\nabla \times (u\vec{A})=
u(\nabla \times \vec{A}) +  (\nabla u) \times \vec{A}$$
# 乘法法则Plus
较复杂
### 直乘内积
$$\nabla (\vec{A}\cdot \vec{B})=
\vec{B} \times (\nabla \times \vec{A})
+\vec{A} \times (\nabla \times \vec{B}) +(\vec{B} \cdot \nabla)  \vec{A} + 
(\vec{A} \cdot \nabla) \vec{B}$$
这个公式疑似把简单的东西还复杂化了。
### 点乘外积
$$\nabla \cdot (\vec{A} \times \vec{B})=
\vec{B} \cdot (\nabla \times \vec{A}) -
\vec{A} \cdot (\nabla \times \vec{B})$$
口诀：“后点前旋，前点后旋”
可以基于标量混合积公式理解：
$$\vec{a}\cdot (\vec{b}\times \vec{c})=\vec{b}\cdot(\vec{c}\times \vec{a})=\vec{c}\cdot(\vec{a}\times \vec{b})$$
由算子性：
$$\nabla \cdot (\vec{A} \times \vec{B})=\nabla_{A}\cdot(\vec{A}\times\vec{B})+\nabla_{B}\cdot(\vec{A}\times\vec{B})$$
因为$\nabla_{A}$只能放在$\vec{A}$前，$\nabla_{B}$只能放在$\vec{B}$前，故可以用上面的性质交换来得到：
$$\nabla_{A}\cdot(\vec{A}\times\vec{B})=\vec{B}\cdot(\nabla_{A}\times \vec{A})$$
$$\nabla_{B}\cdot(\vec{A}\times\vec{B})=\vec{A}\cdot(\vec{B}\times\nabla_{B})【非法!】=-\vec{A\cdot}(\nabla_{B}\times\vec{B})$$
综合即得。
### 叉乘外积
$$\nabla \times (\vec{A} \times \vec{B})=
(\vec{B}\cdot \nabla)\vec{A}-(\nabla \cdot\vec{A})\vec{B}+(\nabla \cdot \vec{B})\vec{A}-(\vec{A}\cdot \nabla)\vec{B}$$
口诀：“B导A减A散B，加B散A减A导B”
可以基于二重外积公式理解：
$$\vec{a}\times(\vec{b}\times\vec{c})=(\vec{a}\cdot\vec{c})\vec{b}-(\vec{a}\cdot\vec{b})\vec{c}$$
由算子性：
$$\nabla \times (\vec{A} \times \vec{B})=\nabla_{A}\times(\vec{A}\times\vec{B})+\nabla_{B}\times(\vec{A}\times\vec{B})$$
运用二重外积公式：
$$\nabla_{A}\times(\vec{A}\times\vec{B})=(\nabla_{A}\cdot\vec{B})\vec{A}【非法!】-(\nabla_{A}\cdot\vec{A})\vec{B}=(\vec{B}\cdot\nabla_{A})\vec{A}-(\nabla_{A}\cdot\vec{A})\vec{B}$$
$$\nabla_{B}\times(\vec{A}\times\vec{B})=(\nabla_{B}\cdot \vec{B})\vec{A}-(\nabla_{B}\cdot \vec{A})\vec{B}【非法!】=(\nabla_{B}\cdot \vec{B})\vec{A}-(\vec{A}\cdot\nabla_{B})\vec{B}$$
综合即得
#### 双Nabla叉乘
因为只有一个矢量函数，所以不能使用微分特性分别进行微分，而是直接使用二重外积公式
$$\nabla \times(\nabla \times \vec{A})=(\nabla \cdot \vec{A})\nabla【非法!】-(\nabla \cdot \nabla)\vec{A}=\nabla(\nabla \cdot \vec{A})-\nabla^2 \vec{A}$$
# 两个重要性质
## 梯度场无旋
$$\nabla\times(\nabla u)\equiv 0$$
利用[[Nabla算子#叉乘矢常函数]]可以证明
## 旋度场无源
$$\nabla \cdot (\nabla \times \vec{A})\equiv 0$$
利用混合积性质可以证明