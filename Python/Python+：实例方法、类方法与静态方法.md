---
title: Python 实例方法、类方法与静态方法
aliases:
  - Python 三类方法
  - instance method classmethod staticmethod
tags:
  - Python
  - 面向对象
  - 方法
  - Obsidian
category: Python/高级语法
status: 完成
created: 2026-10-13
updated: 2026-10-13
---

# Python 实例方法、类方法与静态方法

> [!abstract] 本文目标
> 系统理解 Python 中**实例方法**、**类方法**和**静态方法**的使用目的、声明语法、绑定行为、继承表现与典型应用，并能根据“方法需要访问什么”做出正确选择。

## 目录

- [[#一、先理解：函数如何变成方法]]
- [[#二、实例方法]]
- [[#三、类方法]]
- [[#四、静态方法]]
- [[#五、三类方法的核心区别]]
- [[#六、绑定行为详解]]
- [[#七、继承、重写与多态]]
- [[#八、综合实战示例]]
- [[#九、如何选择]]
- [[#十、常见误区]]
- [[#十一、速查总结]]

---

## 一、先理解：函数如何变成方法

在 Python 中，定义在类体内的函数会成为类的属性。普通函数通过实例访问时，会触发 Python 的**描述符协议**，形成一个绑定方法。

```python
class User:
    def greet(self, message):
        print(f"{self.name}: {message}")


user = User()
user.name = "小林"

print(User.__dict__["greet"])  # 类中保存的是函数对象
print(user.greet)              # 通过实例访问，得到绑定方法

user.greet("你好")
# 等价于：
User.greet(user, "你好")
```

调用 `user.greet("你好")` 时，Python 自动把 `user` 作为第一个参数传给 `greet`。按照惯例，这个参数命名为 `self`。

三类方法的本质区别，可以浓缩成一个问题：

> [!important] 核心问题
> 调用方法时，Python 会不会自动传入对象？如果会，传入的是**实例对象**，还是**类对象**？

- 实例方法：自动传入实例，惯例命名为 `self`。
- 类方法：自动传入类，惯例命名为 `cls`。
- 静态方法：不自动传入实例或类。

> [!note] 命名只是惯例
> `self` 和 `cls` 不是 Python 关键字，理论上可以换成其他名称。但遵守惯例能让代码更易读，也能避免编辑器和静态分析工具产生误判。

---

## 二、实例方法

### 2.1 使用目的

实例方法用于处理**某个具体对象的状态或行为**。它可以：

- 读取或修改实例属性；
- 访问类属性；
- 调用同一实例上的其他方法；
- 根据每个实例各自的数据产生不同结果。

### 2.2 基本语法

实例方法不需要装饰器，第一个形参通常写作 `self`。

```python
class BankAccount:
    interest_rate = 0.02

    def __init__(self, owner, balance=0):
        self.owner = owner
        self.balance = balance

    def deposit(self, amount):
        if amount <= 0:
            raise ValueError("存款金额必须大于 0")
        self.balance += amount

    def summary(self):
        return f"{self.owner} 的账户余额：{self.balance:.2f}"


account_a = BankAccount("小林", 1000)
account_b = BankAccount("小周", 500)

account_a.deposit(200)

print(account_a.summary())  # 小林 的账户余额：1200.00
print(account_b.summary())  # 小周 的账户余额：500.00
```

其中，`account_a` 和 `account_b` 保存着互不相同的实例状态。调用 `account_a.deposit(200)` 时，`self` 指向 `account_a`。

### 2.3 访问实例属性与类属性

实例方法既能访问实例属性，也能通过 `self` 查找类属性。

```python
class Product:
    tax_rate = 0.13

    def __init__(self, name, price):
        self.name = name
        self.price = price

    def price_with_tax(self):
        return self.price * (1 + self.tax_rate)


book = Product("Python 入门", 100)
print(book.price_with_tax())  # 112.99999999999999
```

查找 `self.tax_rate` 时，Python 会先检查实例自身；若实例中没有，再沿类及其父类查找。

> [!tip] 什么时候优先使用实例方法？
> 只要逻辑依赖某个具体对象的数据，实例方法通常就是最自然的选择。

---

## 三、类方法

### 3.1 使用目的

类方法用于处理**类本身相关的逻辑**。它最常见的用途是：

- 提供替代构造方法；
- 读取或修改类级别的状态；
- 实现能感知子类的工厂方法；
- 执行与“具体实例”无关、但与“当前类”有关的操作。

### 3.2 基本语法

类方法使用 `@classmethod` 装饰器，第一个形参通常写作 `cls`。

```python
class Employee:
    company = "星河科技"

    def __init__(self, name):
        self.name = name

    @classmethod
    def company_name(cls):
        return cls.company


print(Employee.company_name())  # 星河科技

employee = Employee("小林")
print(employee.company_name())  # 星河科技
```

无论通过类还是实例调用，Python 都会把相应的类对象绑定给 `cls`。不过，为了表达清晰，类方法通常通过类调用。

### 3.3 替代构造方法

Python 不支持像某些语言那样按参数列表重载构造方法。通常只保留一个 `__init__`，再用类方法提供不同的数据入口。

```python
from datetime import date


class Person:
    def __init__(self, name, birth_year):
        self.name = name
        self.birth_year = birth_year

    @classmethod
    def from_age(cls, name, age):
        birth_year = date.today().year - age
        return cls(name, birth_year)

    @classmethod
    def from_string(cls, text):
        name, birth_year = text.split(",")
        return cls(name.strip(), int(birth_year))


person_a = Person.from_age("小林", 20)
person_b = Person.from_string("小周, 1998")

print(person_a.name, person_a.birth_year)
print(person_b.name, person_b.birth_year)
```

这里使用 `cls(...)`，而不是把类名写死为 `Person(...)`。这样子类继承这些构造方法时，能创建正确的子类对象。

### 3.4 管理类级状态

```python
class Connection:
    created_count = 0

    def __init__(self, address):
        self.address = address
        type(self).created_count += 1

    @classmethod
    def count(cls):
        return cls.created_count

    @classmethod
    def reset_count(cls):
        cls.created_count = 0


Connection("127.0.0.1")
Connection("192.168.1.10")
print(Connection.count())  # 2

Connection.reset_count()
print(Connection.count())  # 0
```

> [!warning] 注意共享可变状态
> 类属性由所有实例共享。若类属性是列表、字典等可变对象，对它的原地修改会影响所有实例。除非这正是设计目的，否则实例数据应放在 `self` 上。

---

## 四、静态方法

### 4.1 使用目的

静态方法用于表达一种组织关系：某个函数在概念上属于这个类，但它既不需要实例状态，也不需要类状态。

常见用途包括：

- 参数校验；
- 格式转换；
- 与该类紧密相关的小型工具函数；
- 不需要 `self` 或 `cls` 的纯计算。

### 4.2 基本语法

静态方法使用 `@staticmethod` 装饰器。Python 不会自动为它传入实例或类。

```python
class Temperature:
    @staticmethod
    def celsius_to_fahrenheit(celsius):
        return celsius * 9 / 5 + 32

    @staticmethod
    def is_valid_celsius(celsius):
        return celsius >= -273.15


print(Temperature.celsius_to_fahrenheit(25))  # 77.0
print(Temperature.is_valid_celsius(-300))     # False
```

### 4.3 与模块级函数的选择

静态方法不是“更高级的普通函数”。如果一个工具函数并不专属于某个类，通常把它写成模块级函数更简单。

```python
def normalize_email(email):
    return email.strip().lower()


class User:
    def __init__(self, email):
        self.email = normalize_email(email)
```

若规范化邮箱的逻辑只服务于 `User` 的领域概念，也可以把它放进类中：

```python
class User:
    def __init__(self, email):
        self.email = self.normalize_email(email)

    @staticmethod
    def normalize_email(email):
        return email.strip().lower()
```

> [!question] 静态方法还是模块级函数？
> 判断标准主要是**内聚性**：如果函数是通用能力，优先放在模块中；如果它只在这个类的语境下有意义，静态方法可以让接口更集中。

---

## 五、三类方法的核心区别

| 对比项 | 实例方法 | 类方法 | 静态方法 |
|---|---|---|---|
| 装饰器 | 无 | `@classmethod` | `@staticmethod` |
| 惯例首参数 | `self` | `cls` | 无自动参数 |
| 自动绑定对象 | 实例 | 类 | 不绑定 |
| 访问实例属性 | 可以 | 不可直接访问 | 不可直接访问 |
| 访问类属性 | 可以 | 可以 | 只能显式写出类名 |
| 可感知实际子类 | 通过 `type(self)` | 可以，`cls` 即实际类 | 不会自动感知 |
| 常见用途 | 操作对象状态 | 替代构造、类级状态、工厂 | 校验、转换、辅助计算 |
| 推荐调用方式 | `instance.method()` | `Class.method()` | `Class.method()` |

一个紧凑的对比例子：

```python
class Example:
    category = "demo"

    def __init__(self, value):
        self.value = value

    def instance_method(self):
        return f"实例值：{self.value}，类别：{self.category}"

    @classmethod
    def class_method(cls):
        return f"当前类：{cls.__name__}，类别：{cls.category}"

    @staticmethod
    def static_method(x, y):
        return x + y


item = Example(10)

print(item.instance_method())
print(Example.class_method())
print(Example.static_method(3, 4))
```

---

## 六、绑定行为详解

### 6.1 实例方法的绑定

```python
class Demo:
    def show(self, value):
        return self, value


demo = Demo()

result_a = demo.show(10)
result_b = Demo.show(demo, 10)

print(result_a == result_b)  # True
print(demo.show.__self__ is demo)       # True
print(demo.show.__func__ is Demo.show)  # True
```

`demo.show` 是绑定方法，内部记录了：

- `__self__`：被绑定的实例 `demo`；
- `__func__`：类中原始的函数 `Demo.show`。

### 6.2 类方法的绑定

```python
class Demo:
    @classmethod
    def identify(cls):
        return cls


demo = Demo()

print(Demo.identify() is Demo)  # True
print(demo.identify() is Demo)  # True
print(Demo.identify.__self__ is Demo)  # True
```

类方法通过类或实例访问，绑定的都是类。对继承体系而言，它绑定的是访问入口所对应的实际类。

### 6.3 静态方法不绑定

```python
class Demo:
    @staticmethod
    def add(x, y):
        return x + y


demo = Demo()

print(Demo.add(2, 3))  # 5
print(demo.add(2, 3))  # 5
print(Demo.add is demo.add)  # True
```

静态方法通过实例调用在语法上是允许的，但容易让读者误以为它依赖实例，因此通常建议通过类调用。

### 6.4 直接查看类字典

通过类属性访问时，描述符已经参与处理。如果想观察类体中实际保存的对象，可以查看 `__dict__`。

```python
class Demo:
    def instance_method(self):
        pass

    @classmethod
    def class_method(cls):
        pass

    @staticmethod
    def static_method():
        pass


print(type(Demo.__dict__["instance_method"]))
print(type(Demo.__dict__["class_method"]))
print(type(Demo.__dict__["static_method"]))
```

你会看到：

- 实例方法在类字典中是普通函数；
- 类方法在类字典中是 `classmethod` 描述符对象；
- 静态方法在类字典中是 `staticmethod` 描述符对象。

---

## 七、继承、重写与多态

### 7.1 实例方法与动态分派

子类可以重写父类实例方法。运行时会根据实例的实际类型选择方法。

```python
class Animal:
    def speak(self):
        return "某种声音"


class Dog(Animal):
    def speak(self):
        return "汪"


class Cat(Animal):
    def speak(self):
        return "喵"


animals = [Dog(), Cat(), Animal()]

for animal in animals:
    print(animal.speak())
```

### 7.2 类方法会绑定实际子类

```python
class Document:
    extension = ".txt"

    def __init__(self, name):
        self.name = name

    @classmethod
    def create(cls, name):
        return cls(name)

    @classmethod
    def default_filename(cls):
        return f"untitled{cls.extension}"


class MarkdownDocument(Document):
    extension = ".md"


document = MarkdownDocument.create("Python 笔记")

print(type(document).__name__)                    # MarkdownDocument
print(MarkdownDocument.default_filename())        # untitled.md
print(Document.default_filename())                # untitled.txt
```

调用 `MarkdownDocument.create(...)` 时，`cls` 是 `MarkdownDocument`，所以 `cls(name)` 创建的是子类实例。这就是替代构造方法使用 `cls` 的核心价值。

### 7.3 把类名写死会破坏继承

```python
class Document:
    def __init__(self, name):
        self.name = name

    @classmethod
    def create_wrong(cls, name):
        return Document(name)

    @classmethod
    def create_right(cls, name):
        return cls(name)


class MarkdownDocument(Document):
    pass


wrong = MarkdownDocument.create_wrong("笔记")
right = MarkdownDocument.create_right("笔记")

print(type(wrong).__name__)  # Document
print(type(right).__name__)  # MarkdownDocument
```

> [!danger] 关键原则
> 在类方法中创建对象时，应优先使用 `cls(...)`。写死父类名称通常会让继承失效。

### 7.4 静态方法的继承与重写

静态方法也会被子类继承，也可以被重写，但它不会自动收到当前类。

```python
class TextFormatter:
    @staticmethod
    def format(text):
        return text.strip()


class LoudFormatter(TextFormatter):
    @staticmethod
    def format(text):
        return text.strip().upper()


print(TextFormatter.format("  hello  "))  # hello
print(LoudFormatter.format("  hello  "))  # HELLO
```

若方法需要根据子类属性自动改变行为，类方法通常比静态方法合适。

```python
class Parser:
    separator = ","

    @classmethod
    def parse(cls, text):
        return text.split(cls.separator)


class PipeParser(Parser):
    separator = "|"


print(Parser.parse("a,b,c"))      # ['a', 'b', 'c']
print(PipeParser.parse("a|b|c"))  # ['a', 'b', 'c']
```

### 7.5 在重写方法中使用 `super()`

```python
class Message:
    prefix = "消息"

    def render(self):
        return self.prefix

    @classmethod
    def describe(cls):
        return f"类型：{cls.__name__}"


class WarningMessage(Message):
    prefix = "警告"

    def render(self):
        return f"{super().render()}！请注意"

    @classmethod
    def describe(cls):
        parent_description = super().describe()
        return f"{parent_description}，级别：高"


warning = WarningMessage()
print(warning.render())
print(WarningMessage.describe())
```

在实例方法中，无参数 `super()` 会根据 `self` 和当前定义类工作；在类方法中，它会根据 `cls` 和当前定义类工作。

---

## 八、综合实战示例

下面用一个订单类展示三类方法如何协作。

```python
from __future__ import annotations

from dataclasses import dataclass
from decimal import Decimal


@dataclass
class Order:
    product: str
    quantity: int
    unit_price: Decimal

    tax_rate = Decimal("0.13")

    def subtotal(self):
        """实例方法：依赖当前订单的数量和单价。"""
        return self.quantity * self.unit_price

    def total(self):
        """实例方法：基于当前订单计算含税总价。"""
        return self.subtotal() * (Decimal("1") + self.tax_rate)

    @classmethod
    def from_string(cls, text):
        """类方法：从字符串创建订单，且支持子类继承。"""
        product, quantity, unit_price = text.split(",")
        return cls(
            product=product.strip(),
            quantity=int(quantity),
            unit_price=Decimal(unit_price),
        )

    @classmethod
    def set_tax_rate(cls, rate):
        """类方法：修改当前类的税率。"""
        decimal_rate = Decimal(str(rate))
        if not cls.is_valid_tax_rate(decimal_rate):
            raise ValueError("税率必须在 0 到 1 之间")
        cls.tax_rate = decimal_rate

    @staticmethod
    def is_valid_tax_rate(rate):
        """静态方法：校验规则不依赖实例或类状态。"""
        return Decimal("0") <= rate <= Decimal("1")


order = Order.from_string("机械键盘, 2, 399.00")

print(order.subtotal())  # 798.00
print(order.total())     # 901.7400

Order.set_tax_rate("0.10")
print(order.total())     # 877.8000
```

这个设计中：

- `subtotal()` 和 `total()` 需要订单实例的数据，因此是实例方法；
- `from_string()` 负责创建当前类的对象，因此是类方法；
- `set_tax_rate()` 管理类级配置，因此是类方法；
- `is_valid_tax_rate()` 只做输入校验，不依赖对象状态，因此是静态方法。

### 8.1 子类继承综合示例

```python
class DiscountOrder(Order):
    discount_rate = Decimal("0.20")

    def total(self):
        original_total = super().total()
        return original_total * (Decimal("1") - self.discount_rate)


discount_order = DiscountOrder.from_string("显示器, 1, 2000.00")

print(type(discount_order).__name__)  # DiscountOrder
print(discount_order.total())         # 根据当前税率及折扣率计算
```

父类的 `from_string()` 使用 `cls(...)`，所以由 `DiscountOrder` 调用时会正确构造 `DiscountOrder` 实例。

---

## 九、如何选择

可以按下面的顺序判断：

1. **需要读取或修改某个具体对象的数据吗？**
   - 需要：使用实例方法。
2. **需要访问类属性、创建当前类对象，或让逻辑自动适配子类吗？**
   - 需要：使用类方法。
3. **既不需要实例，也不需要类，但函数在概念上明显属于这个类吗？**
   - 是：可以使用静态方法。
4. **函数与某个类并没有强关联吗？**
   - 是：优先使用模块级函数。

> [!tip] 最短判断口诀
> 用对象状态，选实例方法；用类或替代构造，选类方法；两者都不用但逻辑属于类，选静态方法。

### 决策示例

| 需求 | 推荐类型 | 原因 |
|---|---|---|
| 修改某个用户的昵称 | 实例方法 | 操作具体用户的状态 |
| 从 JSON 创建对象 | 类方法 | 是替代构造入口，且应支持子类 |
| 获取当前子类的默认配置 | 类方法 | 需要通过 `cls` 感知子类 |
| 校验用户名格式 | 静态方法或模块函数 | 不依赖实例与类状态 |
| 计算某个圆对象的面积 | 实例方法 | 依赖该圆的半径 |
| 摄氏度转华氏度 | 静态方法或模块函数 | 是无状态转换 |

---

## 十、常见误区

### 误区 1：忘记写 `self`

```python
class User:
    def greet():
        return "你好"


user = User()
# user.greet()
# TypeError: User.greet() takes 0 positional arguments but 1 was given
```

通过实例调用普通方法时，Python 会自动传入实例。如果定义中没有接收它的形参，就会报参数数量错误。

正确写法：

```python
class User:
    def greet(self):
        return "你好"
```

如果方法确实不需要实例，应根据语义考虑 `@staticmethod` 或模块级函数。

### 误区 2：在类方法里直接访问实例属性

```python
class User:
    def __init__(self, name):
        self.name = name

    @classmethod
    def show_name(cls):
        # return cls.name
        # name 是实例属性，并不自动存在于类上
        return "类方法没有具体实例，无法知道要读取哪个用户的 name"
```

类方法收到的是类对象，不是具体实例。若逻辑需要 `self.name`，它应该是实例方法，或显式接收一个实例作为普通参数。

### 误区 3：为了少写 `self` 而使用静态方法

```python
class Cart:
    def __init__(self):
        self.items = []

    @staticmethod
    def add_item(cart, item):
        cart.items.append(item)
```

这段代码能运行，但接口不自然。`add_item` 明显是购物车实例的行为，应写成实例方法。

```python
class Cart:
    def __init__(self):
        self.items = []

    def add_item(self, item):
        self.items.append(item)
```

### 误区 4：在替代构造方法中写死类名

```python
class User:
    def __init__(self, name):
        self.name = name

    @classmethod
    def from_string(cls, text):
        return User(text.strip())  # 不利于继承
```

应改为：

```python
class User:
    def __init__(self, name):
        self.name = name

    @classmethod
    def from_string(cls, text):
        return cls(text.strip())
```

### 误区 5：把类方法当成构造方法本身

类方法通常只是**替代构造入口**。真正创建新实例的是 `cls(...)`，随后仍会执行相应的 `__new__` 和 `__init__`。

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    @classmethod
    def origin(cls):
        return cls(0, 0)
```

### 误区 6：以为静态方法不能通过实例调用

```python
class Calculator:
    @staticmethod
    def add(x, y):
        return x + y


calculator = Calculator()

print(Calculator.add(1, 2))  # 推荐，语义清楚
print(calculator.add(1, 2))  # 可以运行，但容易产生误解
```

语法允许并不意味着表达最佳。静态方法一般通过类调用。

### 误区 7：误以为 `self` 和 `cls` 是特殊关键字

```python
class Demo:
    def instance_method(any_name):
        return any_name

    @classmethod
    def class_method(any_name):
        return any_name
```

这段代码可以运行，但不推荐。`self` 和 `cls` 是全社区通用的惯例，应该遵守。

### 误区 8：随意通过实例修改类属性

```python
class User:
    role = "member"


user_a = User()
user_b = User()

user_a.role = "admin"

print(user_a.role)  # admin，来自 user_a 的实例属性
print(user_b.role)  # member，仍来自类属性
print(User.role)    # member
```

`user_a.role = "admin"` 通常不是修改类属性，而是在 `user_a` 上创建同名实例属性，将类属性遮蔽。若确实要修改类级状态，应通过类或设计明确的类方法操作。

### 误区 9：把所有辅助函数都塞成静态方法

过多静态方法可能意味着类承担了太多无关职责。若一个函数：

- 会被多个类共同使用；
- 在类之外也有独立意义；
- 不属于该类的领域概念；

那么模块级函数或独立模块往往更合适。

---

## 十一、速查总结

```python
class MethodExamples:
    class_value = "类级数据"

    def __init__(self, instance_value):
        self.instance_value = instance_value

    def instance_method(self):
        """自动接收实例 self，适合操作实例状态。"""
        return self.instance_value

    @classmethod
    def class_method(cls):
        """自动接收类 cls，适合类级逻辑和替代构造。"""
        return cls.class_value

    @staticmethod
    def static_method(value):
        """不自动接收实例或类，适合相关的无状态逻辑。"""
        return str(value).strip()
```

> [!summary] 一句话总结
> - 实例方法回答：“这个对象要做什么？”
> - 类方法回答：“这个类要做什么，或如何创建这个类的对象？”
> - 静态方法回答：“这个与类相关、但不依赖对象或类状态的操作是什么？”

## 延伸阅读方向

- [[Python 描述符协议]]：理解方法绑定背后的机制。
- [[Python 继承与多态]]：理解重写、动态分派和 `super()`。
- [[Python 魔术方法]]：理解 `__new__`、`__init__` 等对象生命周期方法。
- [[Python dataclass]]：减少数据类中的样板代码。

