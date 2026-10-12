---
title: Python 推导式
aliases:
  - Python Comprehensions
  - 列表推导式
  - 字典推导式
  - 集合推导式
tags:
  - Python
  - 推导式
  - Pythonic
  - Obsidian
category: Python/基础语法
status: 完成
created: 2026-10-13
updated: 2026-10-13
---

# Python 推导式

> [!abstract] 本文目标
> 系统掌握 Python 中的列表推导式、字典推导式、集合推导式和生成器表达式，理解表达式、循环与条件的执行顺序，并能在简洁性、可读性和内存占用之间作出合理选择。

## 目录

- [[#一、什么是推导式]]
- [[#二、列表推导式]]
- [[#三、条件过滤与条件表达式]]
- [[#四、嵌套推导式]]
- [[#五、字典推导式]]
- [[#六、集合推导式]]
- [[#七、生成器表达式]]
- [[#八、作用域与变量绑定]]
- [[#九、实际应用示例]]
- [[#十、性能与可读性]]
- [[#十一、常见误区]]
- [[#十二、速查表]]

---

## 一、什么是推导式

推导式是一种根据已有可迭代对象快速创建新容器的紧凑语法。它通常把以下操作写在一个表达式中：

1. 遍历数据；
2. 可选地筛选元素；
3. 对元素进行转换；
4. 生成新的列表、字典或集合。

例如，将一组数字的平方放进新列表：

```python
numbers = [1, 2, 3, 4, 5]

squares = [number ** 2 for number in numbers]

print(squares)  # [1, 4, 9, 16, 25]
```

它等价于下面的普通循环：

```python
numbers = [1, 2, 3, 4, 5]
squares = []

for number in numbers:
    squares.append(number ** 2)

print(squares)  # [1, 4, 9, 16, 25]
```

> [!important] 核心理解
> 推导式并不是一种新的循环机制，而是“创建容器的表达式语法”。它适合表达简单、直接的映射与筛选过程。

### 推导式家族

Python 常见的相关语法有四种：

| 类型 | 语法外观 | 结果 |
|---|---|---|
| 列表推导式 | `[表达式 for ...]` | 立即创建列表 |
| 字典推导式 | `{键: 值 for ...}` | 立即创建字典 |
| 集合推导式 | `{表达式 for ...}` | 立即创建集合并去重 |
| 生成器表达式 | `(表达式 for ...)` | 创建惰性生成器 |

严格来说，生成器表达式不是“生成器推导式”，但它与推导式结构高度相似，因此通常一起学习。

---

## 二、列表推导式

### 2.1 基本语法

列表推导式的基本结构为：

`[结果表达式 for 变量 in 可迭代对象]`

阅读时，可以先看 `for` 部分，理解数据从哪里来，再看最左侧表达式，理解每个元素会被转换成什么。

```python
names = ["alice", "bob", "charlie"]

upper_names = [name.upper() for name in names]

print(upper_names)  # ['ALICE', 'BOB', 'CHARLIE']
```

执行过程可以理解为：

```python
names = ["alice", "bob", "charlie"]
upper_names = []

for name in names:
    upper_names.append(name.upper())
```

### 2.2 数据转换

最左侧可以放任意合法表达式。

```python
prices = [10, 25.5, 8]

labels = [f"¥{price:.2f}" for price in prices]

print(labels)  # ['¥10.00', '¥25.50', '¥8.00']
```

也可以调用函数：

```python
def normalize_name(name):
    return name.strip().title()


raw_names = [" alice ", "BOB", " charlie"]
names = [normalize_name(name) for name in raw_names]

print(names)  # ['Alice', 'Bob', 'Charlie']
```

### 2.3 遍历不同类型的可迭代对象

推导式不只适用于列表，也可以遍历元组、集合、字符串、字典、文件对象和生成器等可迭代对象。

```python
text = "Python"
characters = [character.lower() for character in text]

print(characters)  # ['p', 'y', 't', 'h', 'o', 'n']
```

遍历字典时，默认得到键；使用 `items()` 可以同时得到键和值。

```python
scores = {"小林": 92, "小周": 85, "小陈": 88}

names = [name for name in scores]
records = [f"{name}: {score}" for name, score in scores.items()]

print(names)
print(records)
```

### 2.4 使用 `enumerate()` 获取索引

```python
fruits = ["苹果", "香蕉", "橙子"]

numbered = [f"{index}. {fruit}" for index, fruit in enumerate(fruits, start=1)]

print(numbered)
# ['1. 苹果', '2. 香蕉', '3. 橙子']
```

### 2.5 使用 `zip()` 并行遍历

```python
names = ["小林", "小周", "小陈"]
scores = [92, 85, 88]

records = [f"{name} 得分 {score}" for name, score in zip(names, scores)]

print(records)
```

> [!tip] 阅读技巧
> 遇到推导式时，先从 `for` 开始读：“对每一个……”，再读最左侧：“生成……”。有 `if` 时，最后读筛选条件。

---

## 三、条件过滤与条件表达式

推导式中的 `if` 有两种常见位置，它们含义不同：

- 写在末尾：用于**过滤**元素；
- 写在最左侧表达式中：用于为每个元素**二选一转换**。

### 3.1 末尾的 `if`：过滤元素

基本结构为：

`[表达式 for 变量 in 可迭代对象 if 条件]`

```python
numbers = range(1, 11)

even_squares = [number ** 2 for number in numbers if number % 2 == 0]

print(even_squares)  # [4, 16, 36, 64, 100]
```

等价的普通循环：

```python
even_squares = []

for number in range(1, 11):
    if number % 2 == 0:
        even_squares.append(number ** 2)
```

不满足条件的元素不会出现在结果中。

### 3.2 多个过滤条件

可以用逻辑运算符合并条件：

```python
numbers = range(1, 21)

result = [
    number
    for number in numbers
    if number % 2 == 0 and number % 3 == 0
]

print(result)  # [6, 12, 18]
```

也可以连续写多个 `if`，其效果类似于使用 `and`：

```python
numbers = range(1, 21)

result = [
    number
    for number in numbers
    if number % 2 == 0
    if number % 3 == 0
]

print(result)  # [6, 12, 18]
```

合并成一个条件通常更容易阅读；多个 `if` 在嵌套遍历中有时更自然。

### 3.3 左侧的 `if ... else`：条件表达式

如果每个输入元素都要保留，只是转换结果不同，应使用条件表达式：

`[值1 if 条件 else 值2 for 变量 in 可迭代对象]`

```python
numbers = [1, 2, 3, 4, 5]

parity = ["偶数" if number % 2 == 0 else "奇数" for number in numbers]

print(parity)  # ['奇数', '偶数', '奇数', '偶数', '奇数']
```

这里输入有 5 个元素，输出也有 5 个元素。

### 3.4 过滤与条件表达式同时使用

```python
numbers = range(-3, 6)

labels = [
    "偶数" if number % 2 == 0 else "奇数"
    for number in numbers
    if number > 0
]

print(labels)  # ['奇数', '偶数', '奇数', '偶数', '奇数']
```

执行顺序是：

1. 遍历 `numbers`；
2. 用末尾的 `if number > 0` 过滤；
3. 对保留下来的元素执行左侧条件表达式。

> [!warning] 不完整的条件表达式
> 左侧的条件表达式必须同时包含 `if` 和 `else`。末尾的过滤条件只写 `if`，不能写 `else`。两种位置不要混淆。

---

## 四、嵌套推导式

推导式可以包含多个 `for`，也可以处理嵌套数据。

### 4.1 多个 `for` 的执行顺序

```python
pairs = [(x, y) for x in [1, 2] for y in ["a", "b", "c"]]

print(pairs)
# [(1, 'a'), (1, 'b'), (1, 'c'),
#  (2, 'a'), (2, 'b'), (2, 'c')]
```

它与下面的循环顺序完全一致：

```python
pairs = []

for x in [1, 2]:
    for y in ["a", "b", "c"]:
        pairs.append((x, y))
```

> [!important] 顺序规则
> 推导式中的多个 `for`，按照从左到右的顺序执行，与普通嵌套循环从外到内的书写顺序一致。

### 4.2 展平二维列表

```python
matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
]

flattened = [number for row in matrix for number in row]

print(flattened)  # [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

对应的普通循环：

```python
flattened = []

for row in matrix:
    for number in row:
        flattened.append(number)
```

### 4.3 在嵌套循环中筛选

```python
matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
]

even_numbers = [
    number
    for row in matrix
    for number in row
    if number % 2 == 0
]

print(even_numbers)  # [2, 4, 6, 8]
```

### 4.4 创建二维列表

```python
rows = 3
columns = 4

matrix = [[0 for _ in range(columns)] for _ in range(rows)]

print(matrix)
# [[0, 0, 0, 0],
#  [0, 0, 0, 0],
#  [0, 0, 0, 0]]
```

每次执行内层推导式都会创建一个新列表，因此各行彼此独立。

```python
matrix[0][0] = 1
print(matrix)
# [[1, 0, 0, 0],
#  [0, 0, 0, 0],
#  [0, 0, 0, 0]]
```

### 4.5 矩阵转置

```python
matrix = [
    [1, 2, 3],
    [4, 5, 6],
]

transposed = [
    [row[column_index] for row in matrix]
    for column_index in range(len(matrix[0]))
]

print(transposed)  # [[1, 4], [2, 5], [3, 6]]
```

实际项目中也常用 `zip()`：

```python
matrix = [
    [1, 2, 3],
    [4, 5, 6],
]

transposed = [list(column) for column in zip(*matrix)]

print(transposed)  # [[1, 4], [2, 5], [3, 6]]
```

> [!warning] 避免过度嵌套
> 两层推导式尚可接受，但当循环、条件和转换逻辑继续增加时，普通循环通常更清楚。代码越短，不一定越容易维护。

---

## 五、字典推导式

### 5.1 基本语法

字典推导式同时生成键和值：

`{键表达式: 值表达式 for 变量 in 可迭代对象}`

```python
words = ["apple", "banana", "cherry"]

word_lengths = {word: len(word) for word in words}

print(word_lengths)
# {'apple': 5, 'banana': 6, 'cherry': 6}
```

### 5.2 交换字典的键和值

```python
user_by_id = {
    101: "小林",
    102: "小周",
    103: "小陈",
}

id_by_user = {name: user_id for user_id, name in user_by_id.items()}

print(id_by_user)
```

> [!warning] 键值交换可能丢失数据
> 字典的键必须唯一。如果原字典中有多个键对应同一个值，交换后相同的新键会发生覆盖。

```python
scores = {
    "小林": 90,
    "小周": 90,
    "小陈": 85,
}

names_by_score = {score: name for name, score in scores.items()}

print(names_by_score)
# 90 只能对应最后写入的一个名字
```

### 5.3 筛选字典

```python
scores = {
    "小林": 92,
    "小周": 75,
    "小陈": 88,
    "小王": 61,
}

passed = {name: score for name, score in scores.items() if score >= 80}

print(passed)  # {'小林': 92, '小陈': 88}
```

### 5.4 转换键和值

```python
raw_config = {
    " HOST ": " localhost ",
    " PORT ": " 8000 ",
}

config = {
    key.strip().lower(): value.strip()
    for key, value in raw_config.items()
}

print(config)  # {'host': 'localhost', 'port': '8000'}
```

### 5.5 从两个序列创建字典

```python
fields = ["name", "age", "city"]
values = ["小林", 20, "杭州"]

profile = {field: value for field, value in zip(fields, values)}

print(profile)
```

这种简单情况也可以直接使用 `dict(zip(fields, values))`：

```python
profile = dict(zip(fields, values))
```

---

## 六、集合推导式

### 6.1 基本语法

集合推导式与列表推导式相似，但使用花括号：

`{表达式 for 变量 in 可迭代对象}`

```python
numbers = [1, 2, 2, 3, 3, 3, 4]

squares = {number ** 2 for number in numbers}

print(squares)  # {1, 4, 9, 16}
```

集合会自动去除重复元素。

### 6.2 规范化并去重

```python
raw_tags = ["Python", " python ", "Data", "DATA", "AI"]

tags = {tag.strip().lower() for tag in raw_tags}

print(tags)  # {'python', 'data', 'ai'}，显示顺序不保证固定
```

### 6.3 带筛选条件的集合推导式

```python
text = "Hello, Python 3.12!"

letters = {character.lower() for character in text if character.isalpha()}

print(letters)
```

> [!note] 集合无固定顺序
> 不要依赖集合推导式结果的显示顺序。若需要保留顺序并去重，可以根据具体需求使用 `dict.fromkeys()` 等方式。

### 6.4 空集合不是 `{}`

```python
empty_dict = {}
empty_set = set()

print(type(empty_dict))  # <class 'dict'>
print(type(empty_set))   # <class 'set'>
```

花括号中带冒号的是字典推导式，不带冒号的是集合推导式。

---

## 七、生成器表达式

### 7.1 基本语法

生成器表达式使用圆括号：

`(表达式 for 变量 in 可迭代对象)`

```python
numbers = range(1, 6)

squares = (number ** 2 for number in numbers)

print(squares)        # 生成器对象
print(next(squares))  # 1
print(next(squares))  # 4
print(list(squares))  # [9, 16, 25]
```

它不会立即生成全部结果，而是在迭代过程中按需计算，因此称为**惰性求值**。

### 7.2 列表推导式与生成器表达式

```python
list_result = [number ** 2 for number in range(1_000_000)]
generator_result = (number ** 2 for number in range(1_000_000))
```

二者主要区别：

| 对比项 | 列表推导式 | 生成器表达式 |
|---|---|---|
| 计算方式 | 立即计算全部结果 | 按需计算 |
| 内存占用 | 与结果规模相关 | 通常较小 |
| 能否重复迭代 | 可以 | 通常只能消耗一次 |
| 能否索引 | 可以 | 不可以 |
| 是否能直接查看全部结果 | 可以 | 需要迭代或转换 |

### 7.3 与聚合函数配合

当结果只需被消费一次时，生成器表达式尤其合适。

```python
total = sum(number ** 2 for number in range(1, 101))

print(total)
```

作为函数的唯一参数时，生成器表达式外层的圆括号可以省略。

```python
names = ["Alice", "Bob", "Charlie"]

longest_length = max(len(name) for name in names)
all_non_empty = all(name.strip() for name in names)
has_bob = any(name == "Bob" for name in names)

print(longest_length)
print(all_non_empty)
print(has_bob)
```

`any()` 和 `all()` 具有短路行为：结果一旦确定，就不会继续消费后续元素。

### 7.4 生成器只能被逐步消耗

```python
generator = (number * 10 for number in range(3))

print(list(generator))  # [0, 10, 20]
print(list(generator))  # []，已经耗尽
```

如果需要多次遍历，应重新创建生成器，或在数据量可接受时使用列表。

> [!tip] 选择建议
> 需要保存、索引或重复使用全部结果时选择列表推导式；只需顺序消费一次，尤其是数据量很大时，优先考虑生成器表达式。

---

## 八、作用域与变量绑定

### 8.1 推导式变量不会泄漏到外部

在 Python 3 中，推导式拥有自己的局部作用域。

```python
number = 100

squares = [number ** 2 for number in range(3)]

print(squares)  # [0, 1, 4]
print(number)   # 100
```

推导式中的 `number` 不会覆盖外部同名变量。

### 8.2 推导式可以读取外部变量

```python
factor = 10

values = [number * factor for number in range(5)]

print(values)  # [0, 10, 20, 30, 40]
```

### 8.3 生成器表达式通常在迭代时取值

生成器是惰性的，外部变量可能在真正迭代前发生变化。

```python
factor = 10
values = (number * factor for number in range(3))

factor = 100

print(list(values))  # [0, 100, 200]
```

列表推导式则会立即求值：

```python
factor = 10
values = [number * factor for number in range(3)]

factor = 100

print(values)  # [0, 10, 20]
```

### 8.4 海象运算符 `:=`

Python 3.8 起，可以在表达式中使用赋值表达式避免重复计算。

```python
data = ["12", "", "7", "0", "25"]

positive_values = [
    value
    for item in data
    if item and (value := int(item)) > 0
]

print(positive_values)  # [12, 7, 25]
```

不过，海象运算符可能增加理解成本。若逻辑并不简单，普通循环往往更清楚。

> [!warning] 不要追求一行解决所有问题
> 推导式的目标是清晰地表达转换与筛选，而不是尽可能压缩行数。

---

## 九、实际应用示例

### 9.1 清洗文本数据

```python
raw_names = ["  Alice ", "", " BOB", "   ", "charlie "]

clean_names = [
    name.strip().title()
    for name in raw_names
    if name.strip()
]

print(clean_names)  # ['Alice', 'Bob', 'Charlie']
```

### 9.2 提取符合条件的记录

```python
users = [
    {"name": "小林", "age": 20, "active": True},
    {"name": "小周", "age": 17, "active": True},
    {"name": "小陈", "age": 25, "active": False},
    {"name": "小王", "age": 22, "active": True},
]

active_adult_names = [
    user["name"]
    for user in users
    if user["active"] and user["age"] >= 18
]

print(active_adult_names)  # ['小林', '小王']
```

### 9.3 按字段建立索引

```python
users = [
    {"id": 101, "name": "小林"},
    {"id": 102, "name": "小周"},
    {"id": 103, "name": "小陈"},
]

users_by_id = {user["id"]: user for user in users}

print(users_by_id[102])  # {'id': 102, 'name': '小周'}
```

### 9.4 统计词频前的规范化

```python
text = "Python is simple, and Python is powerful."

words = [
    word.strip(".,!?;:").lower()
    for word in text.split()
]

word_counts = {
    word: words.count(word)
    for word in set(words)
}

print(word_counts)
```

上例适合演示，但 `count()` 会反复遍历列表。真实项目处理大量数据时，`collections.Counter` 更高效：

```python
from collections import Counter


word_counts = Counter(words)
print(word_counts)
```

### 9.5 分组数据

复杂的分组逻辑不适合硬塞进推导式。可以把推导式用于预处理，再用普通循环分组。

```python
from collections import defaultdict


records = [
    ("北京", "小林"),
    ("上海", "小周"),
    ("北京", "小陈"),
]

normalized_records = [
    (city.strip(), name.strip())
    for city, name in records
]

users_by_city = defaultdict(list)

for city, name in normalized_records:
    users_by_city[city].append(name)

print(dict(users_by_city))
```

### 9.6 读取并筛选数据流

```python
def valid_numbers(lines):
    return (
        int(line)
        for line in lines
        if line.strip() and line.strip().lstrip("-").isdigit()
    )


lines = ["10", "", "abc", "-3", "25"]

print(sum(valid_numbers(lines)))  # 32
```

---

## 十、性能与可读性

### 10.1 推导式通常比手动追加更紧凑

对于简单映射或筛选，列表推导式通常比显式的 `for` 循环更简洁，也往往具有不错的执行效率。

```python
squares = [number ** 2 for number in range(10_000)]
```

但“可能更快”不应该成为使用复杂推导式的理由。可读性始终是首要标准。

### 10.2 大数据优先考虑惰性处理

```python
total = sum(number ** 2 for number in range(10_000_000))
```

这里无需创建包含一千万个元素的临时列表，生成器表达式更节省内存。

### 10.3 把复杂逻辑提取为函数

如果左侧表达式过长，可以把转换逻辑提取成命名函数。

```python
def build_user_label(user):
    status = "启用" if user["active"] else "停用"
    return f"{user['name']}（{status}）"


labels = [build_user_label(user) for user in users]
```

函数名能够说明意图，也便于独立测试。

### 10.4 适合改用普通循环的情况

遇到以下情况时，普通循环往往更合适：

- 推导式包含多层嵌套和多个条件；
- 循环体需要异常处理；
- 需要执行多条有副作用的语句；
- 需要 `break`、`continue` 或复杂的状态更新；
- 转换过程需要注释才能看懂；
- 一行过长，拆行后仍难理解。

```python
results = []

for raw_value in raw_values:
    try:
        value = int(raw_value)
    except ValueError:
        continue

    if value < 0:
        continue

    results.append(value ** 2)
```

这种包含异常处理和多个步骤的逻辑，用普通循环明显更清楚。

> [!quote] Pythonic 的真正含义
> Pythonic 不等于“尽量写成一行”，而是使用读者熟悉、意图清晰并且容易维护的表达方式。

---

## 十一、常见误区

### 误区 1：混淆过滤条件和条件表达式

过滤，只保留偶数：

```python
result = [number for number in range(6) if number % 2 == 0]

print(result)  # [0, 2, 4]
```

转换，所有元素都保留：

```python
result = [
    "偶数" if number % 2 == 0 else "奇数"
    for number in range(6)
]

print(result)  # ['偶数', '奇数', '偶数', '奇数', '偶数', '奇数']
```

### 误区 2：用推导式执行副作用

不推荐：

```python
names = ["小林", "小周", "小陈"]

printed_values = [print(name) for name in names]

print(printed_values)  # [None, None, None]
```

推导式的目的应该是生成结果容器，而不是利用它循环调用 `print()`、写文件或修改外部状态。应改用普通循环：

```python
for name in names:
    print(name)
```

### 误区 3：误以为圆括号会创建元组推导式

```python
values = (number ** 2 for number in range(5))

print(type(values))  # <class 'generator'>
```

Python 没有“元组推导式”。如果需要元组，应把生成器交给 `tuple()`：

```python
values = tuple(number ** 2 for number in range(5))

print(values)  # (0, 1, 4, 9, 16)
```

### 误区 4：重复使用已经耗尽的生成器

```python
values = (number for number in range(3))

print(sum(values))   # 3
print(list(values))  # []
```

生成器通常只能消费一次。如果后续还需要全部数据，使用列表，或重新创建生成器。

### 误区 5：创建二维列表时复制同一个内层列表

容易出错的写法：

```python
matrix = [[0] * 3] * 3
matrix[0][0] = 1

print(matrix)
# [[1, 0, 0], [1, 0, 0], [1, 0, 0]]
```

三行实际引用同一个列表。使用推导式可以创建彼此独立的行：

```python
matrix = [[0] * 3 for _ in range(3)]
matrix[0][0] = 1

print(matrix)
# [[1, 0, 0], [0, 0, 0], [0, 0, 0]]
```

### 误区 6：依赖集合结果顺序

```python
unique_values = {value for value in [3, 1, 2, 1, 3]}

print(unique_values)
```

集合强调成员唯一性，不提供可依赖的业务顺序。若需要排序，应显式调用 `sorted()`：

```python
sorted_unique_values = sorted(
    {value for value in [3, 1, 2, 1, 3]}
)

print(sorted_unique_values)  # [1, 2, 3]
```

### 误区 7：字典推导式出现重复键

```python
words = ["apple", "ant", "banana", "boat"]

by_first_letter = {word[0]: word for word in words}

print(by_first_letter)
# 相同首字母对应的旧值会被后写入的值覆盖
```

如果一个键需要对应多个值，应使用分组结构，如 `defaultdict(list)`。

### 误区 8：嵌套顺序写反

展平列表时：

```python
matrix = [[1, 2], [3, 4]]

flattened = [number for row in matrix for number in row]

print(flattened)  # [1, 2, 3, 4]
```

可以先写出等价循环，再按照完全相同的顺序搬进推导式：

```python
flattened = []

for row in matrix:
    for number in row:
        flattened.append(number)
```

### 误区 9：在推导式中重复执行昂贵计算

不理想的写法：

```python
def expensive_lookup(item):
    return item * 10


items = [1, 2, 3, 4]

result = [
    expensive_lookup(item)
    for item in items
    if expensive_lookup(item) > 20
]
```

每个通过筛选的元素会重复调用函数。逻辑简单时可谨慎使用赋值表达式：

```python
result = [
    value
    for item in items
    if (value := expensive_lookup(item)) > 20
]
```

若逻辑复杂，建议改用普通循环，以便清楚地保存中间结果。

---

## 十二、速查表

### 列表推导式

```python
result = [transform(item) for item in source]
```

### 带过滤的列表推导式

```python
result = [transform(item) for item in source if condition(item)]
```

### 带条件表达式的列表推导式

```python
result = [
    value_if_true if condition(item) else value_if_false
    for item in source
]
```

### 字典推导式

```python
result = {
    make_key(item): make_value(item)
    for item in source
    if condition(item)
}
```

### 集合推导式

```python
result = {transform(item) for item in source if condition(item)}
```

### 生成器表达式

```python
result = (transform(item) for item in source if condition(item))
```

### 嵌套遍历

```python
result = [
    transform(inner_item)
    for outer_item in outer_source
    for inner_item in outer_item
]
```

> [!summary] 一句话总结
> 推导式适合简洁地表达“遍历、筛选、转换并创建容器”；生成器表达式适合按需产生数据。逻辑一旦变得难读，就应回到普通循环。

## 延伸阅读方向

- [[Python 可迭代对象与迭代器]]
- [[Python 生成器]]
- [[Python lambda、map 与 filter]]
- [[Python 变量作用域]]
- [[Python 海象运算符]]

