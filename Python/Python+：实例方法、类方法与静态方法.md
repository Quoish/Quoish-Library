# Python 面向对象：实例方法、类方法与静态方法
## 1. 三种方法概述

Python 类中定义的方法主要分为三种：

|方法类型|英文名称|装饰器|自动传入的参数|核心用途|
|---|---|---|---|---|
|实例方法|Instance Method|无|`self`|操作具体实例|
|类方法|Class Method|`@classmethod`|`cls`|操作类、创建实例|
|静态方法|Static Method|`@staticmethod`|无|组织与类相关的工具函数|

三者的本质区别在于：**从类或实例访问方法时，Python 如何绑定方法的第一个参数。**

---

## 2. 实例方法（Instance Method）

### 2.1 定义

实例方法是类中最常见的方法，定义时使用 `self` 作为第一个参数。

```
class Student:
    def __init__(self, name):
        self.name = name

    def introduce(self):
        print(f"我是{self.name}")
```

### 2.2 调用方式

```
s1 = Student("Alice")
s2 = Student("Bob")

s1.introduce()  # 我是Alice
s2.introduce()  # 我是Bob
```

其中，`self` 指向调用该方法的实例：

- `s1.introduce()` 中，`self` 为 `s1`。
    
- `s2.introduce()` 中，`self` 为 `s2`。
    

### 2.3 参数绑定机制

```
s1.introduce()
```

等价于：

```
Student.introduce(s1)
```

Python 自动将调用方法的实例作为第一个参数传入。

> [!NOTE]  
> `self` 并不是 Python 关键字，只是约定俗成的名称。实例方法能够通过 `self` 访问实例属性，也能够访问类属性。

### 2.4 适用场景

实例方法适用于需要读取或修改某个具体实例状态的操作，例如：

- 修改学生年龄。
    
- 查询某个对象的属性。
    
- 计算某个矩形实例的面积。
    
- 更新游戏角色的位置。
    

---

## 3. 类方法（Class Method）

### 3.1 定义

类方法使用 `@classmethod` 装饰器，约定使用 `cls` 作为第一个参数。

```
class Student:
    school = "清华大学"

    @classmethod
    def show_school(cls):
        print(cls.school)
```

### 3.2 调用方式

```
Student.show_school()
# 清华大学
```

也可以通过实例调用：

```
s1 = Student()
s1.show_school()
```

无论通过类还是实例调用，`cls` 都指向当前绑定的类，而不是某个具体实例。

### 3.3 参数绑定机制

```
Student.show_school()
```

Python 自动将 `Student` 类作为参数 `cls` 传入。

类方法可以通过 `cls`：

- 访问类属性。
    
- 调用其他类方法。
    
- 创建当前类的实例。
    
- 在继承关系中自动适应子类。
    

### 3.4 用途一：操作类属性

```
class Student:
    count = 0

    def __init__(self, name):
        self.name = name
        Student.count += 1

    @classmethod
    def show_count(cls):
        print(cls.count)


s1 = Student("Alice")
s2 = Student("Bob")

Student.show_count()  # 2
```

类方法适合处理不专属于某个实例的类级信息。

### 3.5 用途二：备用构造方法（Alternative Constructor）

可以使用类方法为对象提供不同的创建入口。

```
class Student:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    @classmethod
    def from_string(cls, data):
        name, age = data.split("-")
        return cls(name, int(age))
```

调用：

```
s1 = Student("Alice", 20)
s2 = Student.from_string("Bob-21")
```

其中：

```
return cls(name, int(age))
```

通过当前类创建实例，仍然会执行正常的对象创建与初始化流程。

因此，类方法并非真正替代 `__init__()`，而是提供额外的对象创建方式。

### 3.6 类方法与继承

```
class GraduateStudent(Student):
    pass

s = GraduateStudent.from_string("Alice-24")

print(type(s))
# <class '__main__.GraduateStudent'>
```

由于使用 `cls()` 而非固定的 `Student()`，继承后的类方法能够自动创建子类实例。

---

## 4. 静态方法（Static Method）

### 4.1 定义

静态方法使用 `@staticmethod` 装饰器，不会自动接收 `self` 或 `cls`。

```
class Student:
    @staticmethod
    def is_adult(age):
        return age >= 18
```

### 4.2 调用方式

```
Student.is_adult(20)  # True
Student.is_adult(16)  # False
```

也可以通过实例调用：

```
s1 = Student()
s1.is_adult(20)
```

### 4.3 参数绑定机制

静态方法不会自动传入实例或类对象。

```
Student.is_adult(20)
```

其中的 `20` 是显式传入的参数，不涉及 `self` 或 `cls` 的自动绑定。

静态方法的行为与普通函数很相似。

### 4.4 为什么使用静态方法？

静态方法主要用于代码组织。

```
class Student:
    @staticmethod
    def validate_age(age):
        return 0 <= age <= 150

    @staticmethod
    def normalize_name(name):
        return name.strip().title()
```

这些函数逻辑上属于学生管理业务，但不依赖某个学生实例，也不依赖类的状态。

> [!IMPORTANT]  
> 静态方法不是必须使用的。对于独立、通用的工具函数，定义在模块顶层通常更加合理。

---

## 5. 三种方法的完整对比

```
class Student:
    school = "清华大学"

    def __init__(self, name, age):
        self.name = name
        self.age = age

    # 实例方法
    def introduce(self):
        print(f"我是{self.name}，今年{self.age}岁")

    # 类方法
    @classmethod
    def show_school(cls):
        print(f"学校：{cls.school}")

    # 静态方法
    @staticmethod
    def is_adult(age):
        return age >= 18


s1 = Student("Alice", 20)

s1.introduce()
Student.show_school()
print(Student.is_adult(20))
```

|比较项目|实例方法|类方法|静态方法|
|---|---|---|---|
|定义装饰器|无|`@classmethod`|`@staticmethod`|
|首个自动参数|`self`|`cls`|无|
|通过实例调用|可以|可以|可以|
|通过类调用|可以，但需显式传入实例|可以|可以|
|直接访问实例状态|可以|不可以|不可以|
|直接访问当前类|可通过 `type(self)`|可以，通过 `cls`|无自动引用|
|典型用途|操作具体对象|类级操作、备用构造|工具函数|

这里的“直接访问”指方法是否自动获得了所需对象的引用，并不表示其他方法绝对无法访问相关属性。

---

## 6. 方法的底层绑定机制

Python 的方法绑定与**描述符协议（Descriptor Protocol）**有关。

### 6.1 实例方法

```
obj.method()
```

在一般情况下，等价于：

```
Class.method(obj)
```

从实例访问实例方法时，Python 会创建绑定方法，将 `obj` 绑定为 `self`。

### 6.2 类方法

```
Class.method()
```

类方法会将当前类自动绑定为 `cls`。

### 6.3 静态方法

```
Class.method()
```

静态方法不会自动绑定类或实例，只传入调用者显式提供的参数。

---

## 7. 如何选择方法类型？

判断顺序：

1. **需要操作具体实例的属性或状态吗？**
    
    - 是：使用实例方法 `self`。
        
2. **需要访问当前类、处理类级状态或通过当前类创建实例吗？**
    
    - 是：使用类方法 `cls`。
        
3. **与这个类存在逻辑关联，但不依赖实例和类的状态吗？**
    
    - 是：可以使用静态方法。
        
4. **函数本身独立且具有通用性吗？**
    
    - 是：优先考虑模块级普通函数。
        

---

## 8. 常见误区

### 误区一：`self` 和 `cls` 是 Python 关键字

错误。

它们只是 Python 社区普遍遵守的命名约定。

### 误区二：类方法只能通过类调用

错误。

类方法也能通过实例调用，但传入的仍然是类。

### 误区三：静态方法不能访问类属性

不准确。

静态方法不会自动获得类引用，但仍然可以显式使用类名访问类属性。

### 误区四：类方法会取代 `__init__()`

错误。

备用构造方法通常是在数据转换后使用 `cls(...)` 创建实例，正常的初始化流程仍然存在。

### 误区五：三种方法是按照“谁有权限访问哪些属性”来区分的

不准确。

Python 的三种方法主要区别在于参数的自动绑定方式，而不是访问控制权限。

---

## 9. 总结

三种方法的核心可以概括为：

- **实例方法：** 我需要知道正在操作的是哪一个对象，因此使用 `self`。
    
- **类方法：** 我需要知道当前操作的是哪一个类，因此使用 `cls`。
    
- **静态方法：** 我不需要实例或类的自动引用，只需要传入的普通参数。
    

**记忆公式：**

`self` → 实例

`cls` → 类

`@staticmethod` → 不自动绑定任何对象

**关键结论：Python 实例方法、类方法与静态方法的主要区别，不在于函数能实现什么功能，而在于 Python 调用它们时采用什么绑定机制。**