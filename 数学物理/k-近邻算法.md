#机器学习 #算法
k近邻法(k-nearest neighbor，k-NN)是一种基本分类与回归方法，属于[[数学物理/机器学习#监督学习|监督学习]]。
其基本思想是：计算实例对象与测试集合各个样本在特征数据空间中的距离，取最近的$k$个样本进行投票计数，从而判断实例所属的类别。
# 算法
- 输入：训练数据集
$$T=\{(\vec{x}_{1},y_{1}),(\vec{x}_{2},y_{2}),\dots,(\vec{x}_{N},y_{N})\}$$
其中，$\vec{x}_{i} \in \mathcal{X} \subseteq \mathbb{R}^n$为实例的特征数据向量，$y_{i}\in \mathcal{Y} =\{c_{1},c_{2},\dots,c_{K}\}$为实例的类别，$i=1,2,\dots,N$；待测特征数据向量$\vec{x}$
- 输出：待测特征数据向量$\vec{x}$对应的类$y$
- 步骤：
1. 根据给定的[[距离、范数、内积#距离|距离]]，计算在特征数据空间中所有训练集中的点$\vec{x}_{i}$和待测特征数据向量$\vec{x}$的距离；
2. 找到其中跟$\vec{x}$距离最近的$k$个点；
3. 使用多数表决规则，假设这$k$个点里属于类别$c$的点最多，就认定$y$
# 代码实现
```python
import numpy as np  
  
def k_NN(in_x, data_set, labels, k):  
    '''  
    :param in_x: 输入的n维待测特征数据向量, 是一个1行n列的np.array  
    :param data_set: 训练集, 是一个N行n列的np.array  
    :param labels: 标签集，存有K个待分类进的类别, 是一个1行K列的np.array  
    :param k: kNN算法中的精度参数  
    :return:  
    '''    data_size = np.shape(data_set)[0] # 计算训练集中的样本个数  
    diff = np.tile(in_x, (data_size, 1)) - data_set  
    sqdiff = diff ** 2  
    distances = np.sum(sqdiff, axis=1)  
    distances = distances ** 0.5 # 计算出与诸样本点的距离，储存在n行1列的数组distance中  
    sorted_dist_indices = np.argsort(distances) # 获取distances升序排列之后的索引值  
  
    vote_count = {} # 建立一个字典储存投票数据  
    for i in range(k):  
        voted_label = labels[sorted_dist_indices[i]] # 用排序后的索引找到欲投票的标签  
        vote_count[voted_label] = vote_count.get(voted_label,0) + 1  
        # 若字典中还没统计该标签，则添加该标签作为key值，并将item值设为0，然后+1  
    sorted_vote_count = sorted(vote_count.items(), key=lambda x: x[1], reverse=True)  
    # .items()返回一个键值对元组，key设置为x[1]说明排序使用的是元组的第二个数据（值），逆序排序  
    return sorted_vote_count[0][0]  
  
def autoNorm(data_set):  
    # 归一化过程：  
    # 1. 计算最值和范围  
    # 2. 减去最小值再除以范围  
    min_vals = np.min(data_set, axis=0)  
    max_vals = np.max(data_set, axis=0)  
    ranges = max_vals - min_vals  
  
    if data_set.ndim == 1:  
        m = 1 # 一维数组时，data_set.shape[0]只会返回列值，不会返回行值  
    else:  
        m = data_set.shape[0]  
  
    norm_set = data_set - np.tile(min_vals, (m, 1))  
    norm_set = norm_set / np.tile(ranges, (m, 1))  
  
    return norm_set  
  
test_data_set = np.array([[0.8, 400, 0.5],  
                          [12, 134000, 0.9],  
                          [0, 20000, 1.1],  
                          [67, 32000, 0.1]])  
test_labels = np.array(['disgust', 'charming', 'ordinary', 'ordinary'])  
test_sample = np.array([10, 10000, 0.5])  
  
print(k_NN(autoNorm(test_sample), autoNorm(test_data_set), test_labels, 3))
```
这里使用的距离是Euclidian距离                                                               
