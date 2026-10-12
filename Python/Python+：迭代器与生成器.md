---
tags:
  - Python
aliases:
  - Python Iterator and Generator
---

# Python 迭代器与生成器

> [!abstract] 本文目标
> 理解**可迭代对象（Iterable）**、**迭代器（Iterator）**和**生成器（Generator）**的区别；掌握 `iter()`、`next()`、`yield` 和生成器表达式；知道什么时候应该使用它们。

## 1. 为什么需要迭代器和生成器？

在处理列表、文件、网络数据和大量计算结果时，我们常常需要**依次获取元素**，而不是一次性拿到全部结果。

- **统一遍历接口**：`for` 可以遍历列表、字典、文件以及自定义对象。
- **按需获取**：需要下一个元素时才请求下一个元素，适合流式处理。
- **节省内存**：不必预先构建一个巨大的结果列表（但具体内存占用取决于实现）。
- **组合处理流程**：可以将筛选、转换等操作串联起来。

> [!important] 一句话区别
> **迭代器**定义“如何逐个取得下一个值”；**生成器**让我们用更简洁的写法创建迭代器。

## 2. 三个基础概念

| 概念 | 含义 | 常见例子 | 能否直接 `next()` |
| --- | --- | --- | --- |
| 可迭代对象（Iterable） | 能通过 `iter()` 提供迭代器的对象 | `list`、`tuple`、`str`、`dict`、`range` | 不一定 |
| 迭代器（Iterator） | 持有迭代状态，能逐个返回数据的对象 | `iter([1, 2])` 的结果 | 可以 |
| 生成器（Generator） | Python 自动实现迭代协议的一类特殊迭代器 | 含 `yield` 的函数调用结果、生成器表达式 | 可以 |

关系可概括为：**生成器 ⊂ 迭代器 ⊂ 可迭代对象**（概念关系，而非继承结构）。

### 2.1 `for` 循环背后发生了什么？

```python
numbers = [10, 20, 30]

for number in numbers:
    print(number)
```

上面的代码在逻辑上相当于：

```python
numbers = [10, 20, 30]
iterator = iter(numbers)  # 取得迭代器

while True:
    try:
        number = next(iterator)  # 请求下一个元素
    except StopIteration:        # 没有更多元素
        break
    print(number)
```

- `iter(obj)`：调用对象的迭代协议以取得迭代器。
- `next(iterator)`：获取下一个值；耗尽时抛出 `StopIteration`。
- `for`：自动处理上述迭代过程，不需要手写异常捕获。

## 3. 迭代器的使用

### 3.1 从已有容器获得迭代器

```python
numbers = [10, 20, 30]
it = iter(numbers)

print(next(it))  # 10
print(next(it))  # 20
print(next(it))  # 30
# print(next(it))  # StopIteration
```

`list` 是**可迭代对象**，但不是**迭代器**：

```python
numbers = [10, 20, 30]

# next(numbers)  # TypeError: 'list' object is not an iterator
print(next(iter(numbers)))  # 10
```

每次对列表调用 `iter()`，通常会得到独立的遍历状态：

```python
numbers = [10, 20, 30]
a = iter(numbers)
b = iter(numbers)

print(next(a))  # 10
print(next(a))  # 20
print(next(b))  # 10：b 不受 a 的进度影响
```

### 3.2 自己编写迭代器类

一个典型的迭代器要实现：

- `__iter__()`：返回迭代器自身。
- `__next__()`：返回下一个值，耗尽时抛出 `StopIteration`。

```python
class Counter:
    def __init__(self, limit):
        self.limit = limit
        self.current = 0

    def __iter__(self):
        return self

    def __next__(self):
        if self.current >= self.limit:
            raise StopIteration
        self.current += 1
        return self.current

counter = Counter(3)
for value in counter:
    print(value)
# 1
# 2
# 3
```

> [!warning] 迭代器通常是一次性消耗的
> 上面同一个 `counter` 再次进入 `for` 循环时，不会从 1 开始，因为 `current` 已经达到上限。若希望每次循环都从头开始，可以让一个**可迭代容器类**的 `__iter__()` 每次返回一个新的迭代器。

### 3.3 可重复遍历的自定义可迭代对象

```python
class NumberSequence:
    def __init__(self, limit):
        self.limit = limit

    def __iter__(self):
        return iter(range(1, self.limit + 1))

sequence = NumberSequence(3)
print(list(sequence))  # [1, 2, 3]
print(list(sequence))  # [1, 2, 3]：可以重新遍历
```

## 4. 生成器的使用

### 4.1 使用 `yield` 定义生成器函数

```python
def count_to_three():
    print("开始")
    yield 1
    print("继续")
    yield 2
    yield 3

gen = count_to_three()  # 创建生成器对象，不立即运行函数体
print(next(gen))        # 输出“开始”，然后返回 1
print(next(gen))        # 输出“继续”，然后返回 2
print(next(gen))        # 返回 3
```

执行到 `yield` 时，函数会**产出一个值并暂停**；下一次调用 `next()`，从暂停位置恢复，局部变量和执行状态得以保留。

### 4.2 `yield` 与 `return` 的区别

| 比较 | `return` | `yield` |
| --- | --- | --- |
| 效果 | 结束当前函数调用并返回结果 | 产出一个值并暂停生成器 |
| 下次能否继续执行函数体 | 不能 | 可以，由 `next()` 等操作恢复 |
| 常见用途 | 普通函数返回结果 | 逐项生成数据 |

```python
def squares(limit):
    for x in range(limit):
        yield x * x

for value in squares(5):
    print(value)
# 0 1 4 9 16（每个值单独占一行）
```

> [!note] 关于 `return`
> 生成器可以用 `return` 提前结束。生成器中的 `return value` 会以 `StopIteration.value` 的形式提供结束值，但普通的 `for` 循环不会显示它。

### 4.3 生成器表达式

方括号创建列表，圆括号可以创建生成器表达式：

```python
list_result = [x * x for x in range(5)]
gen_result = (x * x for x in range(5))

print(list_result)        # [0, 1, 4, 9, 16]
print(next(gen_result))  # 0
print(next(gen_result))  # 1
print(list(gen_result))  # [4, 9, 16]：剩余值
```

生成器表达式很适合简短的惰性转换；需要复杂分支、状态管理或详细调试时，通常使用生成器函数更清楚。

### 4.4 判断生成器是不是迭代器

```python
def make_numbers():
    yield 1
    yield 2

gen = make_numbers()
print(iter(gen) is gen)  # True
print(list(gen))         # [1, 2]
print(list(gen))         # []：已经耗尽
```

## 5. 实际使用例子

### 例 1：逐行读取大型日志

文件对象本身支持迭代，下面的写法通常不需要把整个文件读入内存：

```python
with open("server.log", "r", encoding="utf-8") as file:
    for line in file:
        if "ERROR" in line:
            print(line.rstrip("\n"))
```

如果想封装为一个可复用的生成器：

```python
def error_lines(path):
    with open(path, "r", encoding="utf-8") as file:
        for line in file:
            if "ERROR" in line:
                yield line.rstrip("\n")

for error in error_lines("server.log"):
    print(error)
```

这适合日志分析、批量文本处理等场景。

### 例 2：使用生成器串联数据处理流水线

```python
def numbers():
    for x in range(10):
        yield x

def only_even(source):
    for x in source:
        if x % 2 == 0:
            yield x

def square(source):
    for x in source:
        yield x * x

pipeline = square(only_even(numbers()))
print(list(pipeline))  # [0, 4, 16, 36, 64]
```

数据按需经过各个处理阶段，不必先创建完整的筛选结果列表。

### 例 3：按批次处理数据

```python
def batches(items, batch_size):
    if batch_size <= 0:
        raise ValueError("batch_size 必须大于 0")

    batch = []
    for item in items:
        batch.append(item)
        if len(batch) == batch_size:
            yield batch
            batch = []
    if batch:
        yield batch

for batch in batches(range(10), 3):
    print(batch)
# [0, 1, 2]
# [3, 4, 5]
# [6, 7, 8]
# [9]
```

适合数据库批处理、机器学习数据预处理等。这里每次最多只缓存一个批次的数据。

### 例 4：无限序列（一定要限制消费数量）

```python
from itertools import islice

def natural_numbers():
    n = 1
    while True:
        yield n
        n += 1

print(list(islice(natural_numbers(), 5)))
# [1, 2, 3, 4, 5]
```

> [!caution] 不要无限展开
> `list(natural_numbers())` 无法正常结束，还会持续消耗内存。处理无限迭代器时，应使用 `islice()`、`break` 或其他明确的终止条件。

## 6. 常见错误与注意事项

### 6.1 误以为生成器可以自动重新开始

```python
gen = (x for x in range(3))
print(list(gen))  # [0, 1, 2]
print(list(gen))  # []

# 需要重新创建生成器
new_gen = (x for x in range(3))
print(list(new_gen))  # [0, 1, 2]
```

### 6.2 迭代器耗尽后，`next()` 会抛出异常

可以使用 `next(iterator, default)` 提供默认值：

```python
it = iter([42])
print(next(it, None))  # 42
print(next(it, None))  # None，不抛异常
```

### 6.3 生成器不一定总比列表更快

生成器通常有利于**降低中间数据占用**，但每次产出元素也有执行开销。需要反复遍历、随机索引或多次使用相同结果时，列表可能更适合。

### 6.4 `yield from` 可以委托给其他可迭代对象

```python
def all_numbers():
    yield from [1, 2]
    yield from range(3, 5)

print(list(all_numbers()))  # [1, 2, 3, 4]
```

这里 `yield from iterable` 相当于逐个产出其中的元素；它还有委托 `send()`、异常和返回值等更深入的语义，可在掌握基础后再研究。

## 7. 什么时候选择哪一种？

| 需求 | 推荐方案 | 原因 |
| --- | --- | --- |
| 多次遍历、随机访问 | `list` / `tuple` | 数据已保存，可复用 |
| 遍历已有容器 | `for` | 最简洁，不必手动获取迭代器 |
| 需要手动逐项推进 | `iter()` + `next()` | 可以精确控制获取时机 |
| 需要自定义复杂迭代状态 | 自定义迭代器类 | 显式控制状态和协议 |
| 逐项产生计算结果 | `yield` 生成器函数 | 代码简洁、支持暂停恢复 |
| 简单映射、筛选且只消费一次 | 生成器表达式 | 惰性计算，减少中间列表 |
| 读取大文件、流式处理 | 文件迭代器或生成器 | 按需处理，避免整体加载 |

## 8. 自测练习

1. 为什么 `next([1, 2, 3])` 会报错，而 `next(iter([1, 2, 3]))` 可以运行？
2. 自定义一个迭代器，依次返回 `2, 4, 6, 8, 10`。
3. 用生成器函数实现同样功能，并比较代码复杂度。
4. 为什么对同一个生成器调用两次 `list(gen)`，第二次通常是空列表？
5. 将 `range(100)` 的奇数平方写为生成器表达式，再使用 `sum()` 求和。

<details>
<summary>参考答案提示（Obsidian 支持 HTML 折叠）</summary>

```python
# 练习 2
class EvenIterator:
    def __init__(self):
        self.current = 0

    def __iter__(self):
        return self

    def __next__(self):
        self.current += 2
        if self.current > 10:
            raise StopIteration
        return self.current

# 练习 3
def evens():
    for n in range(2, 11, 2):
        yield n

# 练习 5
answer = sum(x * x for x in range(100) if x % 2 == 1)
print(answer)
```

</details>

## 9. 总结

> [!summary] 核心记忆
> - **Iterable**：可以被 `for` 遍历，能够提供迭代器。
> - **Iterator**：实现 `__iter__()` 和 `__next__()`，逐个获取元素。
> - **Generator**：一种特殊的迭代器，常由 `yield` 或生成器表达式创建。
> - **`return`**：结束函数调用；**`yield`**：产出值并暂停，之后可以恢复执行。
> - **最大价值**：按需处理数据，把迭代逻辑与数据消费逻辑分离。

