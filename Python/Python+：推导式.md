# Python 推导式（Comprehension）

# 1. 什么是推导式

推导式（Comprehension）是 Python 提供的一种简洁语法，用于根据已有的可迭代对象构造新的数据容器。

主要有三种：

- 列表推导式（List Comprehension）
    
- 字典推导式（Dictionary Comprehension）
    
- 集合推导式（Set Comprehension）
    

注意：Python 没有元组推导式，使用圆括号构造的类似表达式是**生成器表达式**。

# 2. 使用目的

推导式主要用于：

1. **简化代码**：将简单的 `for` 循环压缩为一个表达式。
    
2. **批量转换数据**：对可迭代对象中的每个元素执行运算。
    
3. **筛选数据**：根据条件选择符合要求的元素。
    
4. **构建数据结构**：直接生成列表、字典或集合。
    

推导式适合逻辑简单的数据处理，但不适合包含复杂控制流程的操作。

# 3. 列表推导式

## 3.1 基本语法

```
[expression for item in iterable if condition]
```

各部分含义：

- `expression`：对每个元素进行计算或转换。
    
- `item`：循环变量。
    
- `iterable`：可迭代对象。
    
- `condition`：可选的筛选条件。
    

## 3.2 基本示例

普通循环：

```python
squares = []

for x in range(5):
    squares.append(x ** 2)

print(squares)
```

使用列表推导式：

```
squares = [x ** 2 for x in range(5)]

print(squares)
# [0, 1, 4, 9, 16]
```

## 3.3 使用 if 筛选

```
numbers = range(10)

evens = [x for x in numbers if x % 2 == 0]

print(evens)
# [0, 2, 4, 6, 8]
```

执行顺序：

1. 从 `numbers` 中获取元素。
    
2. 判断 `x % 2 == 0`。
    
3. 如果条件成立，将 `x` 加入新列表。
    

## 3.4 使用 if-else 转换

```
numbers = [1, 2, 3, 4, 5]

result = ["偶数" if x % 2 == 0 else "奇数" for x in numbers]

print(result)
# ['奇数', '偶数', '奇数', '偶数', '奇数']
```

注意区分：

- `[expression for x in data if condition]`：筛选元素。
    
- `[a if condition else b for x in data]`：根据条件选择表达式的结果。
    

## 3.5 多层循环

```
pairs = [(x, y) for x in range(3) for y in range(2)]

print(pairs)
# [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1)]
```

等价于：

```
pairs = []

for x in range(3):
    for y in range(2):
        pairs.append((x, y))
```

# 4. 字典推导式

## 4.1 基本语法

```
{key_expression: value_expression for item in iterable}
```

## 4.2 示例：数字与平方映射

```
squares = {x: x ** 2 for x in range(5)}

print(squares)
# {0: 0, 1: 1, 2: 4, 3: 9, 4: 16}
```

## 4.3 示例：交换字典的键和值

```
data = {"Alice": 20, "Bob": 21}

reversed_data = {age: name for name, age in data.items()}

print(reversed_data)
# {20: 'Alice', 21: 'Bob'}
```

注意：如果原字典中存在重复的值，交换键和值时可能发生覆盖。

# 5. 集合推导式

## 5.1 基本语法

```
{expression for item in iterable}
```

## 5.2 示例：去除重复结果

```
numbers = [1, 2, 2, 3, 3, 4]

result = {x ** 2 for x in numbers}

print(result)
# {1, 4, 9, 16}，集合不保证输出顺序
```

集合推导式得到的是 `set` 对象，因此自动去重。

# 6. 推导式与普通循环的区别

|特性|普通 for 循环|推导式|
|---|---|---|
|代码量|较多|较少|
|可读性|复杂逻辑更清晰|简单逻辑更清晰|
|条件判断|支持|支持|
|多层逻辑|容易组织|容易变得难读|
|适用范围|通用循环|构造新容器|

# 7. 注意事项

1. 列表推导式会立即构造完整列表，数据量大时可能占用较多内存。
    
2. 不建议在推导式中编写有副作用的操作，例如大量修改外部状态。
    
3. 多层嵌套推导式可能影响可读性。
    
4. 推导式主要用于构造新容器，而不是单纯执行一系列操作。
    
5. 生成器表达式与推导式语法相似，但使用惰性求值。
    

# 8. 总结

推导式的核心思想是：

**通过遍历、筛选和转换，以简洁的语法构造新的数据容器。**

典型用法：

```
# 列表
[x ** 2 for x in range(10)]

# 字典
{x: x ** 2 for x in range(10)}

# 集合
{x % 3 for x in range(10)}

# 筛选
[x for x in range(10) if x % 2 == 0]
```