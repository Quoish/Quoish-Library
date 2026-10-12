**Python 生成器（Generator）**

# 1. 什么是生成器

生成器（Generator）是一种特殊的迭代器，用于按需生成数据。

普通列表通常一次性计算并保存全部元素，而生成器采用**惰性求值（Lazy Evaluation）**，只有在请求下一个元素时才继续计算。

创建生成器主要有两种方式：

1. 生成器表达式（Generator Expression）
    
2. 使用 `yield` 的生成器函数（Generator Function）
    

# 2. 使用目的

生成器主要用于：

1. **节省内存**：不必一次性保存全部数据。
    
2. **按需计算**：只在需要结果时执行计算。
    
3. **流式处理**：逐步处理文件、网络数据、数据库记录等。
    
4. **构造无限序列**：理论上可以不断生成新元素。
    
5. **保留执行状态**：在 `yield` 处暂停，之后恢复执行。
    

# 3. 生成器表达式

## 3.1 基本语法

```
(expression for item in iterable if condition)
```

与列表推导式的主要区别是：

- `[]`：生成列表。
    
- `()`：生成生成器对象。
    

## 3.2 示例

```
numbers = (x ** 2 for x in range(5))

print(numbers)
# <generator object ...>
```

这里不会直接输出所有平方值，因为 `numbers` 是生成器对象。

可以通过 `next()` 获取数据：

```
print(next(numbers))  # 0
print(next(numbers))  # 1
print(next(numbers))  # 4
```

也可以使用循环：

```
numbers = (x ** 2 for x in range(5))

for x in numbers:
    print(x)
```

输出：

```
0
1
4
9
16
```

# 4. 使用 yield 定义生成器函数

## 4.1 基本语法

```
def generator():
    yield value1
    yield value2
```

当函数体中包含 `yield` 表达式时，该函数通常成为生成器函数。

调用生成器函数会返回生成器对象，而不会立即执行函数体。

## 4.2 示例

```
def counter():
    print("开始执行")

    yield 1

    print("继续执行")

    yield 2

    print("结束执行")


gen = counter()

print(next(gen))
print(next(gen))
```

输出：

```
开始执行
1
继续执行
2
```

执行过程：

1. `counter()` 返回生成器对象。
    
2. 第一次 `next()` 开始执行函数。
    
3. 遇到 `yield 1`，返回数值 1 并暂停。
    
4. 第二次 `next()` 从暂停位置继续执行。
    
5. 遇到 `yield 2`，返回数值 2 并再次暂停。
    

再调用一次 `next(gen)`，函数会打印“结束执行”，随后抛出 `StopIteration`。

# 5. yield 与 return 的区别

|特性|return|yield|
|---|---|---|
|作用|返回结果并结束函数|产生结果并暂停执行|
|保存执行状态|否|是|
|能否继续执行|通常不能|可以|
|常见使用位置|普通函数|生成器函数|
|多次产出结果|需要重新调用|可以持续迭代|

注意：生成器函数也可以使用 `return` 来结束生成过程。

# 6. 生成器与迭代器

可迭代对象（Iterable）是能够提供迭代器的对象。

迭代器（Iterator）是能够通过 `next()` 不断获取下一个元素的对象。

生成器是迭代器的一种。

因此：

- 所有生成器都是迭代器。
    
- 所有迭代器都是可迭代对象。
    
- 并非所有可迭代对象都是迭代器。
    
- 并非所有迭代器都是生成器。
    

示例：

```
numbers = [1, 2, 3]

iterator = iter(numbers)

print(next(iterator))  # 1
print(next(iterator))  # 2
print(next(iterator))  # 3
```

列表本身是可迭代对象，但不能直接调用 `next(numbers)`。

可以通过 `iter(numbers)` 得到迭代器。

# 7. 实际应用示例

## 7.1 无限自然数序列

```
def natural_numbers():
    n = 1

    while True:
        yield n
        n += 1


gen = natural_numbers()

for _ in range(5):
    print(next(gen))
```

输出：

```
1
2
3
4
5
```

## 7.2 逐行读取文件

```
def read_lines(filename):
    with open(filename, "r", encoding="utf-8") as file:
        for line in file:
            yield line.strip()


for line in read_lines("data.txt"):
    print(line)
```

这种方式无需将整个文件读入内存。

实际上，Python 文件对象自身也支持逐行迭代，因此简单场景可以直接：

```
with open("data.txt", encoding="utf-8") as file:
    for line in file:
        print(line.strip())
```

## 7.3 使用 yield from

`yield from` 可以将另一个可迭代对象中的元素依次产出。

```
def numbers():
    yield from range(5)


for x in numbers():
    print(x)
```

输出：

```
0
1
2
3
4
```

其作用不止于循环转发，还支持生成器之间的委托，但初学阶段可以先理解为简化元素转发。

# 8. 生成器与列表的对比

|特性|列表|生成器|
|---|---|---|
|数据生成|立即计算|按需计算|
|内存占用|通常随数据量增长|通常较低|
|随机索引|支持|不支持|
|多次遍历|支持|通常只能消费一次|
|长度获取|通常支持 `len()`|通常不支持|
|无限序列|不适合|适合|

# 9. 注意事项

1. 生成器通常只能单向迭代，耗尽后不能自动复位。
    
2. `next()` 在生成器耗尽时抛出 `StopIteration`。
    
3. 生成器表达式的创建通常不会执行内部的元素计算，但最左侧可迭代对象的求值会立即发生。
    
4. 生成器可以节省内存，但不一定比列表运算速度更快。
    
5. 惰性求值意味着计算错误可能直到实际迭代时才出现。
    

# 10. 总结

生成器的核心思想是：

**将一次性计算转换为按需、逐步执行的计算。**

典型语法：

```
# 生成器表达式
gen = (x ** 2 for x in range(10))

# 生成器函数
def counter():
    yield 1
    yield 2

# 获取结果
next(gen)

# 遍历
for x in gen:
    print(x)
```