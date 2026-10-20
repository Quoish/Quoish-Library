---
title: Arduino常用函数
aliases:
  - Arduino函数速查
  - Arduino API速查
tags:
  - Arduino
  - 函数速查
  - 嵌入式开发
category:
  - 嵌入式开发
status:
created: 2026-10-19
updated: 2026-10-20
---
Arduino程序以C++为基础，Arduino Core在此基础上提供了统一的引脚、时间和通信接口。不同开发板使用的微控制器和Core不同，支持的引脚、分辨率、串口数量及部分函数参数也可能不同。

本文代码块中的函数形式用于说明常见调用方式。涉及硬件能力时，应同时查阅所用开发板的引脚图和Core文档。

# 基础结构
## setup()、loop()
```cpp
void setup()
{
  // 初始化代码
}

void loop()
{
  // 循环执行的代码
}
```
作用：
- `setup()`：上电、复位或重新上传程序后执行一次，通常用于初始化引脚和外设
- `loop()`：`setup()`执行完毕后反复运行，是Arduino程序的主循环

应避免在`loop()`中安排无法退出的长时间阻塞流程，否则其他周期任务和通信处理会得不到执行机会。

## 常用数据类型
```cpp
bool enabled = true;
byte value = 255;
char character = 'A';
int count = 0;
unsigned int length = 0;
long position = 0;
unsigned long tick = 0;
float voltage = 0.0F;
```
常见用途：
- `bool`：保存`true`或`false`
- `byte`、`uint8_t`：保存一个字节的无符号数据
- `int`、`unsigned int`：保存整数，位宽与开发板架构有关
- `long`、`unsigned long`：通常用于较大的整数和时间计数
- `float`：保存单精度浮点数

需要明确位宽的数据应优先使用`stdint.h`中的`uint8_t`、`int16_t`、`uint32_t`等类型。

# [[GPIO]]
## pinMode()
```cpp
void pinMode(uint8_t pin, uint8_t mode)
```
作用：配置数字引脚的工作模式
参数：
- `pin`：引脚编号或板级别名，如`2`、`LED_BUILTIN`
- `mode`：常用值为`INPUT`、`OUTPUT`或`INPUT_PULLUP`

`INPUT_PULLUP`会启用内部上拉电阻。按钮接在引脚与GND之间时，未按下通常读到`HIGH`，按下后读到`LOW`。

```cpp
pinMode(LED_BUILTIN, OUTPUT);
pinMode(2, INPUT_PULLUP);
```

## digitalWrite()
```cpp
void digitalWrite(uint8_t pin, uint8_t value)
```
作用：向数字输出引脚写入高低电平
参数：
- `pin`：数字引脚
- `value`：`HIGH`或`LOW`

当引脚仍处于输入模式时，`digitalWrite(pin, HIGH)`在部分Core中用于启用内部上拉，代码意图不如直接使用`pinMode(pin, INPUT_PULLUP)`清晰。

## digitalRead()
```cpp
int digitalRead(uint8_t pin)
```
作用：读取数字引脚当前的逻辑电平
参数：
- `pin`：数字引脚
- 返回值`int`：`HIGH`或`LOW`

悬空输入容易受到干扰而随机变化，应使用内部上拉、内部下拉或外部电阻确定默认电平。内部下拉并非所有开发板都支持。

```cpp
digitalWrite(LED_BUILTIN,
             digitalRead(2) == LOW ? HIGH : LOW);
```

# [[ADC]]
## analogRead()
```cpp
int analogRead(uint8_t pin)
```
作用：读取指定模拟输入引脚的ADC转换结果
参数：
- `pin`：模拟输入引脚，如`A0`
- 返回值`int`：ADC原始值

许多Arduino开发板为兼容传统接口，默认使用10位结果，即返回`0`到`1023`。实际ADC位数、输入范围和可用引脚取决于开发板。

已知参考电压$V_{ref}$和分辨率$N$时，可按下式估算输入电压：

$$V_{in}=\frac{\text{analogRead返回值}}{2^N-1}V_{ref}$$

```cpp
int raw = analogRead(A0);
float voltage = raw * 5.0F / 1023.0F;
```

## analogReadResolution()
```cpp
void analogReadResolution(int bits)
```
作用：设置`analogRead()`返回结果的分辨率
参数：
- `bits`：目标位数，如`10`、`12`

该函数只在部分开发板上可用。设置值高于硬件ADC分辨率时，增加的低位通常由零填充，不会提高实际测量精度。

## analogReference()
```cpp
void analogReference(uint8_t type)
```
作用：选择ADC参考电压
参数：
- `type`：参考电压类型，具体常量随开发板而变化，如`DEFAULT`、`INTERNAL`、`EXTERNAL`

使用外部参考电压前必须核对开发板允许的AREF范围和接线要求。错误地连接AREF可能造成参考源冲突甚至损坏硬件。切换参考源后的前几次读数可能不稳定。

# [[定时器]]与PWM
## analogWrite()
```cpp
void analogWrite(uint8_t pin, int value)
```
作用：在支持PWM的引脚上输出指定占空比的PWM波形；部分带DAC的开发板可能输出真实模拟电压
参数：
- `pin`：支持`analogWrite()`的引脚
- `value`：默认8位分辨率下为`0`到`255`，`0`对应持续低电平，`255`对应持续高电平

`analogWrite()`通常不需要先调用`pinMode()`。PWM频率、可用引脚及其占用的定时器资源取决于开发板Core。

```cpp
analogWrite(9, 128);  // 默认8位分辨率下约为50%占空比
```

## analogWriteResolution()
```cpp
void analogWriteResolution(int bits)
```
作用：设置`analogWrite()`使用的分辨率
参数：
- `bits`：目标位数

该函数只在部分开发板上可用。设置后满量程值为$2^{bits}-1$。

## tone()、noTone()
```cpp
void tone(uint8_t pin,
          unsigned int frequency,
          unsigned long duration = 0)
void noTone(uint8_t pin)
```
作用：
- `tone()`：在引脚上产生指定频率的方波
- `noTone()`：停止该引脚上的方波输出

参数：
- `pin`：输出引脚
- `frequency`：频率，单位Hz
- `duration`：持续时间，单位ms；省略或填`0`时持续输出，直到调用`noTone()`

`tone()`会占用定时器资源，可能影响部分引脚的PWM输出。不同Core对同时输出的音调数量和频率范围支持不同。

## timerBegin()（ESP32）
```cpp
hw_timer_t *timerBegin(uint8_t timer,
                       uint16_t divider,
                       bool countUp)
```
作用：初始化一个ESP32硬件定时器，并返回指向该定时器的`hw_timer_t`指针

参数：
- `timer`：硬件定时器编号
- `divider`：定时器时钟分频系数
- `countUp`：`true`表示向上计数，`false`表示向下计数
- 返回值`hw_timer_t *`：定时器句柄；初始化失败时应检查是否为`nullptr`

以80 MHz定时器源时钟为例，分频系数为80时，计数频率为1 MHz，每个计数周期为1 µs：

$$f_{timer}=\frac{80\,\mathrm{MHz}}{80}=1\,\mathrm{MHz}$$

```cpp
hw_timer_t *timer = timerBegin(0, 80, true);
```

该原型对应Arduino-ESP32 2.x。Arduino-ESP32 3.x调整了硬件定时器API，升级Core后应按照所安装版本的文档修改参数。

## timerAttachInterrupt()（ESP32）
```cpp
void timerAttachInterrupt(hw_timer_t *timer,
                          void (*fn)(void),
                          bool edge)
```
作用：把中断服务函数绑定到指定的ESP32硬件定时器

参数：
- `timer`：`timerBegin()`返回的定时器句柄
- `fn`：无参数、无返回值的中断服务函数
- `edge`：`true`使用边沿触发，`false`使用电平触发

```cpp
void IRAM_ATTR onTimer()
{
  // 只执行很短的操作，例如更新计数或设置标志
}

timerAttachInterrupt(timer, &onTimer, true);
```

ESP32中断服务函数通常使用`IRAM_ATTR`修饰，使中断代码放入内部RAM。中断服务函数应保持简短，不要在其中调用`Serial.print()`、`delay()`或其他可能阻塞的接口。

## timerAlarmWrite()、timerAlarmEnable()（ESP32）
```cpp
void timerAlarmWrite(hw_timer_t *timer,
                     uint64_t alarmValue,
                     bool autoreload)
void timerAlarmEnable(hw_timer_t *timer)
```
作用：
- `timerAlarmWrite()`：设置定时器到达哪个计数值时产生报警中断
- `timerAlarmEnable()`：启用已经配置好的定时器报警

参数：
- `timer`：`timerBegin()`返回的定时器句柄
- `alarmValue`：报警计数值，其实际时间由定时器计数频率决定
- `autoreload`：`true`表示触发后自动重新装载，适合周期定时；`false`表示单次触发

当每个计数周期为1 µs时，`1000000`对应1 s：

```cpp
timerAlarmWrite(timer, 1000000ULL, true);
timerAlarmEnable(timer);
```

推荐的配置顺序为：`timerBegin()`、`timerAttachInterrupt()`、`timerAlarmWrite()`、`timerAlarmEnable()`。

# 时间函数
## delay()、delayMicroseconds()
```cpp
void delay(unsigned long ms)
void delayMicroseconds(unsigned int us)
```
作用：阻塞当前流程指定的时间
参数：
- `ms`：毫秒数
- `us`：微秒数

阻塞期间主循环无法处理其他任务。需要同时完成按键扫描、通信和状态更新时，应优先使用`millis()`编写非阻塞逻辑。

## millis()、micros()
```cpp
unsigned long millis()
unsigned long micros()
```
作用：读取程序启动以来累计的毫秒数或微秒数
返回值`unsigned long`：累计时间计数，到达最大值后回绕

在`unsigned long`为32位的Core上，`millis()`约49.7天回绕一次。判断经过时间时应使用无符号减法：

```cpp
const unsigned long interval = 1000UL;
unsigned long previousMillis = 0;

void loop()
{
  unsigned long currentMillis = millis();

  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;
    digitalWrite(LED_BUILTIN,
                 !digitalRead(LED_BUILTIN));
  }
}
```

不要使用`millis() >= previousMillis + interval`判断超时，这种写法跨越计数回绕点时容易产生错误。

# 数学和数值处理
## min()、max()、abs()、constrain()
```cpp
min(x, y)
max(x, y)
abs(x)
constrain(x, low, high)
```
作用：
- `min()`：返回较小值
- `max()`：返回较大值
- `abs()`：返回绝对值
- `constrain()`：把数值限制在`low`到`high`之间

这些接口在部分Core中以宏实现。参数中应避免直接放入带有自增、函数调用等副作用的表达式。

## map()
```cpp
long map(long x,
         long in_min,
         long in_max,
         long out_min,
         long out_max)
```
作用：把整数从一个范围线性映射到另一个范围
参数：
- `x`：待映射的值
- `in_min`、`in_max`：输入范围
- `out_min`、`out_max`：输出范围
- 返回值`long`：映射后的整数

`map()`不会自动把输入限制在原范围内，需要时应配合`constrain()`。计算过程使用整数运算，小数部分会被舍弃。

```cpp
int pwm = map(analogRead(A0), 0, 1023, 0, 255);
pwm = constrain(pwm, 0, 255);
```

## pow()、sqrt()、sin()、cos()、tan()
```cpp
double pow(double base, double exponent)
double sqrt(double x)
double sin(double radians)
double cos(double radians)
double tan(double radians)
```
作用：完成幂、平方根和三角函数计算。三角函数参数使用弧度

## radians()、degrees()
```cpp
radians(degrees)
degrees(radians)
```
作用：在角度和弧度之间转换

## randomSeed()、random()
```cpp
void randomSeed(unsigned long seed)
long random(long max)
long random(long min, long max)
```
作用：设置伪随机数种子并生成随机整数
参数：
- `seed`：伪随机数种子
- `max`：结果上界，不包含该值
- `min`：结果下界，包含该值

固定种子会生成可重复的序列。需要每次启动得到不同序列时，可使用悬空模拟输入的读数作为简单种子，但这不能用于密码学或安全用途。

# 位与字节操作
## bit()、bitRead()、bitSet()、bitClear()、bitWrite()、highByte()、lowByte()
```cpp
bit(n)
bitRead(value, bit)
bitSet(value, bit)
bitClear(value, bit)
bitWrite(value, bit, bitValue)
highByte(value)
lowByte(value)
```
作用：
- `bit(n)`：生成第`n`位为1的掩码
- `bitRead()`：读取指定比特
- `bitSet()`、`bitClear()`：把指定比特置1或清零
- `bitWrite()`：按照`bitValue`写入指定比特
- `highByte()`、`lowByte()`：读取数值的高字节或低字节

比特编号从0开始。

```cpp
uint8_t flags = 0;
bitSet(flags, 2);

if (bitRead(flags, 2) == 1) {
  bitClear(flags, 2);
}
```

# 高级IO
## pulseIn()、pulseInLong()
```cpp
unsigned long pulseIn(uint8_t pin,
                      uint8_t state,
                      unsigned long timeout = 1000000UL)
unsigned long pulseInLong(uint8_t pin,
                          uint8_t state,
                          unsigned long timeout = 1000000UL)
```
作用：等待指定电平的脉冲并测量持续时间
参数：
- `pin`：输入引脚
- `state`：要测量的电平，`HIGH`或`LOW`
- `timeout`：最大等待时间，单位µs
- 返回值`unsigned long`：脉冲宽度，单位µs；超时返回`0`

这两个函数在测量期间会等待脉冲，不适合需要持续处理其他实时任务的场景。`pulseInLong()`依赖中断和`micros()`，适合较长脉冲，但并非所有Core都支持。

## shiftOut()、shiftIn()
```cpp
void shiftOut(uint8_t dataPin,
              uint8_t clockPin,
              uint8_t bitOrder,
              uint8_t value)
uint8_t shiftIn(uint8_t dataPin,
                uint8_t clockPin,
                uint8_t bitOrder)
```
作用：使用普通GPIO按时钟逐位发送或接收一个字节
参数：
- `dataPin`：数据引脚
- `clockPin`：时钟引脚
- `bitOrder`：`MSBFIRST`或`LSBFIRST`
- `value`：要发送的字节
- `shiftIn()`返回值：接收到的字节

这些函数属于软件时序接口，速度和实时性低于硬件SPI。

# [[中断和DMA]]
## attachInterrupt()、detachInterrupt()、digitalPinToInterrupt()
```cpp
attachInterrupt(digitalPinToInterrupt(pin), ISR, mode)
detachInterrupt(digitalPinToInterrupt(pin))
```
作用：为外部中断引脚注册或解除中断服务函数
参数：
- `pin`：外部中断使用的数字引脚
- `ISR`：无参数、无返回值的中断服务函数
- `mode`：常用触发方式为`LOW`、`CHANGE`、`RISING`或`FALLING`；部分开发板还支持`HIGH`

应使用`digitalPinToInterrupt(pin)`转换板级引脚号，不要直接假设中断号与引脚号相同。

```cpp
volatile bool buttonEvent = false;

void onButtonFalling()
{
  buttonEvent = true;
}

void setup()
{
  pinMode(2, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(2),
                  onButtonFalling,
                  FALLING);
}
```

中断服务函数应尽量短，只保存数据或设置事件标志。不要在其中使用`delay()`、长时间串口输出或其他阻塞操作。被主程序和中断共同访问的变量通常需要声明为`volatile`；当变量读写不是原子操作时，还需要在临界区内访问。

## noInterrupts()、interrupts()
```cpp
void noInterrupts()
void interrupts()
```
作用：全局禁止或重新允许可屏蔽中断，常用于保护很短的临界区

```cpp
noInterrupts();
uint32_t snapshot = sharedValue;
interrupts();
```

关闭中断会影响时间计数、串口收发和其他依赖中断的功能，临界区应保持尽可能短。Arduino没有跨平台统一的DMA API，需要使用开发板Core或第三方库提供的接口。

## portENTER_CRITICAL()、portEXIT_CRITICAL()、portENTER_CRITICAL_ISR()、portEXIT_CRITICAL_ISR()（ESP32）
```cpp
portMUX_TYPE mux = portMUX_INITIALIZER_UNLOCKED;

portENTER_CRITICAL(&mux);
// 访问任务与中断共享的数据
portEXIT_CRITICAL(&mux);
```
作用：在ESP32的FreeRTOS环境中进入和退出临界区，保护任务与中断之间或不同任务之间共享的数据

参数：
- `mux`：`portMUX_TYPE`类型的自旋锁，通常使用`portMUX_INITIALIZER_UNLOCKED`初始化

中断服务函数中应使用对应的ISR版本：

```cpp
portENTER_CRITICAL_ISR(&mux);
// 更新共享数据
portEXIT_CRITICAL_ISR(&mux);
```

`volatile`用于提示编译器共享变量可能被异步修改，但不会自动保证复合操作的原子性。对于`++`、`--`以及多步读写，应根据访问场景使用临界区保护。临界区内不要执行串口输出或其他耗时操作。

# [[串口通信]]
## Serial.begin()、Serial.end()
```cpp
Serial.begin(baud)
Serial.begin(baud, config)
Serial.begin(baud, config, rxPin, txPin)
Serial.end()
```
作用：初始化或关闭串口
参数：
- `baud`：波特率，如`9600`、`115200`
- `config`：数据位、校验位和停止位配置，如`SERIAL_8N1`；并非所有Core都支持相同配置
- `rxPin`、`txPin`：接收和发送引脚；该重载由ESP32等部分Core提供

```cpp
void setup()
{
  Serial.begin(115200, SERIAL_8N1, 44, 43);
}
```

ESP32允许在初始化硬件串口时指定RX和TX引脚。引脚能否映射到目标UART以及是否与板载电路冲突，应结合芯片和开发板原理图确认。

`Serial`可能对应硬件UART，也可能对应原生USB虚拟串口。使用原生USB的开发板可以用`while (!Serial)`等待电脑打开串口，但这会让脱机运行的程序停在初始化阶段，通常应增加超时。

```cpp
if (Serial) {
  Serial.println("Serial connected");
}
```

## Serial.available()、Serial.read()、Serial.peek()
```cpp
int Serial.available()
int Serial.read()
int Serial.peek()
```
作用：
- `available()`：返回接收缓冲区中可读取的字节数
- `read()`：读取并移除一个字节，无数据时返回`-1`
- `peek()`：查看但不移除下一个字节，无数据时返回`-1`

```cpp
if (Serial.available() > 0) {
  int received = Serial.read();
  Serial.write((uint8_t)received);
}
```

使用`int`接收`read()`的返回值，才能区分有效的`0xFF`与表示无数据的`-1`。

## Serial.write()
```cpp
size_t Serial.write(uint8_t value)
size_t Serial.write(const uint8_t *buffer, size_t size)
```
作用：发送原始字节或字节数组
返回值`size_t`：成功排入发送缓冲区的字节数

## Serial.print()、Serial.println()
```cpp
Serial.print(value)
Serial.print(value, format)
Serial.println(value)
Serial.println(value, format)
```
作用：把数值或字符串转换为可读文本后发送，`println()`会在末尾追加换行
参数：
- `value`：要输出的数据
- `format`：整数可使用`BIN`、`OCT`、`DEC`、`HEX`，浮点数可填小数位数

```cpp
Serial.print(255, HEX);    // FF
Serial.println(3.14159, 2); // 3.14
```

`Serial.write()`发送二进制原始数据，`Serial.print()`发送文本表示。例如`Serial.write(65)`发送一个字节`0x41`，`Serial.print(65)`发送字符`6`和`5`。

## Serial.availableForWrite()、Serial.flush()
```cpp
int Serial.availableForWrite()
void Serial.flush()
```
作用：
- `availableForWrite()`：返回发送缓冲区中可立即写入的字节数
- `flush()`：等待已经排入发送缓冲区的数据发送完毕

`flush()`不会清空接收缓冲区。需要丢弃已接收数据时，应循环调用`read()`直到`available()`为0。

## Serial.readBytes()、Serial.readBytesUntil()、Serial.setTimeout()
```cpp
size_t Serial.readBytes(char *buffer, size_t length)
size_t Serial.readBytesUntil(char terminator,
                             char *buffer,
                             size_t length)
void Serial.setTimeout(unsigned long timeout)
```
作用：
- `readBytes()`：读取指定数量的字节，达到长度或超时后返回
- `readBytesUntil()`：读取到终止符、达到长度或超时后返回
- `setTimeout()`：设置Stream类读取函数的超时时间，单位ms

返回值`size_t`为实际写入缓冲区的字节数。函数不会保证自动添加字符串结束符`'\0'`，把结果作为C字符串使用时应自行预留一个字节并补上结束符。

```cpp
char buffer[32];
size_t length = Serial.readBytesUntil('\n',
                                      buffer,
                                      sizeof(buffer) - 1U);
buffer[length] = '\0';
```

# [[I2C通信]]
使用Wire库前需要包含头文件：

```cpp
#include <Wire.h>
```

## Wire.begin()、Wire.end()、Wire.setClock()
```cpp
Wire.begin()
Wire.begin(address)
Wire.end()
Wire.setClock(clockFrequency)
```
作用：
- `begin()`：以控制器模式初始化I2C总线
- `begin(address)`：以外设模式初始化，并设置本机7位地址
- `end()`：关闭Wire接口，部分Core不支持
- `setClock()`：设置I2C时钟频率，常用`100000UL`或`400000UL`

Wire使用7位I2C地址。例如器件手册给出7位地址`0x3C`时，应直接传入`0x3C`，不需要像部分底层驱动那样左移一位。

## Wire.beginTransmission()、Wire.write()、Wire.endTransmission()
```cpp
Wire.beginTransmission(address)
Wire.write(value)
Wire.write(buffer, length)
uint8_t result = Wire.endTransmission(stop)
```
作用：向指定I2C外设发送数据
参数：
- `address`：7位I2C地址
- `value`：要发送的一个字节
- `buffer`、`length`：发送缓冲区和长度
- `stop`：`true`发送停止条件；`false`保留总线并产生重复起始条件
- `result`：传输结果，`0`表示成功，其他值表示缓冲区过长、NACK、总线错误或超时

```cpp
Wire.beginTransmission(0x3C);
Wire.write(0x00);
Wire.write(0xAF);
uint8_t error = Wire.endTransmission();
```

`beginTransmission()`和`write()`只是把数据放入发送缓冲区，`endTransmission()`才真正发起总线传输。

## Wire.requestFrom()、Wire.available()、Wire.read()
```cpp
size_t Wire.requestFrom(address, quantity)
int Wire.available()
int Wire.read()
```
作用：从指定I2C外设请求并读取数据
参数：
- `address`：7位I2C地址
- `quantity`：请求的字节数
- `requestFrom()`返回值：实际收到的字节数
- `available()`返回值：接收缓冲区中剩余的字节数
- `read()`返回值：读到的字节，无数据时返回`-1`

```cpp
Wire.requestFrom(0x3C, 2);

while (Wire.available() > 0) {
  uint8_t value = (uint8_t)Wire.read();
}
```

读取带内部寄存器地址的设备时，常使用重复起始条件：

```cpp
Wire.beginTransmission(0x68);
Wire.write(0x75);

if (Wire.endTransmission(false) == 0) {
  Wire.requestFrom(0x68, 1);
  if (Wire.available() == 1) {
    uint8_t value = (uint8_t)Wire.read();
  }
}
```

## Wire.onReceive()、Wire.onRequest()
```cpp
Wire.onReceive(receiveHandler)
Wire.onRequest(requestHandler)
```
作用：在I2C外设模式下注册接收和请求回调函数

```cpp
void receiveHandler(int count)
{
  while (Wire.available() > 0) {
    uint8_t value = (uint8_t)Wire.read();
  }
}

void requestHandler()
{
  Wire.write(0x42);
}
```

Wire缓冲区容量由Core决定，AVR Core常见为32字节。单次发送或请求的数据量不应超过当前Core的缓冲区容量。SDA和SCL需要合适的上拉电阻。

# SPI通信
使用SPI库前需要包含头文件：

```cpp
#include <SPI.h>
```

## SPI.begin()、SPI.end()
```cpp
SPI.begin()
SPI.end()
```
作用：初始化或关闭默认SPI接口

## SPISettings、SPI.beginTransaction()、SPI.endTransaction()
```cpp
SPISettings settings(clock,
                     bitOrder,
                     dataMode)
SPI.beginTransaction(settings)
SPI.endTransaction()
```
作用：为一次SPI事务配置时钟、位序和模式，并在结束后释放总线
参数：
- `clock`：目标SPI时钟频率，单位Hz
- `bitOrder`：`MSBFIRST`或`LSBFIRST`
- `dataMode`：`SPI_MODE0`到`SPI_MODE3`

同一总线上连接多个SPI设备时，每次与设备通信前都应使用对应的`SPISettings`开始事务。

## SPI.transfer()、SPI.transfer16()
```cpp
uint8_t SPI.transfer(uint8_t data)
uint16_t SPI.transfer16(uint16_t data)
SPI.transfer(void *buffer, size_t size)
```
作用：进行全双工SPI传输，写出数据的同时返回接收到的数据
参数：
- `data`：要发送的8位或16位数据
- `buffer`、`size`：原位发送并接收的缓冲区及长度；支持情况随Core而变化

片选CS通常由程序使用GPIO控制：

```cpp
const uint8_t chipSelect = 10;
SPISettings settings(1000000UL, MSBFIRST, SPI_MODE0);

void setup()
{
  pinMode(chipSelect, OUTPUT);
  digitalWrite(chipSelect, HIGH);
  SPI.begin();
}

uint8_t readRegister(uint8_t address)
{
  SPI.beginTransaction(settings);
  digitalWrite(chipSelect, LOW);
  SPI.transfer(address | 0x80U);
  uint8_t value = SPI.transfer(0x00U);
  digitalWrite(chipSelect, HIGH);
  SPI.endTransaction();
  return value;
}
```

不同开发板的SPI引脚位置可能不同，应优先使用板上标注的SPI或ICSP接口，不要直接套用UNO的引脚编号。

# EEPROM
使用EEPROM库前需要包含头文件：

```cpp
#include <EEPROM.h>
```

## EEPROM.read()、EEPROM.write()、EEPROM.update()、EEPROM.length()
```cpp
uint8_t EEPROM.read(int address)
void EEPROM.write(int address, uint8_t value)
void EEPROM.update(int address, uint8_t value)
int EEPROM.length()
```
作用：
- `read()`：读取一个字节
- `write()`：写入一个字节
- `update()`：仅在值发生变化时写入，减少擦写次数
- `length()`：返回可用EEPROM字节数

参数：
- `address`：从0开始的存储地址
- `value`：要写入的字节

## EEPROM.get()、EEPROM.put()
```cpp
template<typename T>
T &EEPROM.get(int address, T &data)

template<typename T>
const T &EEPROM.put(int address, const T &data)
```
作用：读取或写入整数、浮点数、结构体等完整对象。`put()`通常使用类似`update()`的方式避免重复写入相同值

```cpp
struct Settings {
  uint16_t threshold;
  bool enabled;
};

Settings settings;
EEPROM.get(0, settings);

settings.threshold = 500;
settings.enabled = true;
EEPROM.put(0, settings);
```

EEPROM具有有限擦写寿命，不应在每次`loop()`循环中反复写入。部分开发板没有独立EEPROM，Core可能使用Flash模拟并要求额外的初始化或提交操作，应查阅所用开发板的EEPROM实现。

# 字符串与Flash存储
## String.length()、String.charAt()、String.substring()、String.indexOf()、String.toInt()、String.c_str()
```cpp
String text = "value=";
text += 123;

text.length()
text.charAt(index)
text.substring(from, to)
text.indexOf(value)
text.toInt()
text.c_str()
```
作用：使用Arduino `String`类完成字符串拼接、查找、截取和转换

在SRAM较小的开发板上频繁创建和拼接临时`String`可能造成内存碎片。长期运行的程序可使用固定长度的`char`数组，并用`snprintf()`限制写入长度。

## snprintf()
```cpp
char buffer[32];
snprintf(buffer, sizeof(buffer), "value=%d", 123);
Serial.println(buffer);
```

## F()
```cpp
Serial.println(F("constant text"));
```
作用：在AVR平台上使用`F()`宏让只读字符串保存在Flash中，避免启动时复制到SRAM。其他架构通常会以不同方式处理只读常量，但保留该写法一般有利于兼容。

## PROGMEM
```cpp
const uint8_t table[] PROGMEM = {1, 2, 3, 4};
```
作用：在AVR平台上把较大的常量数据保存在程序存储器中。读取方法与普通SRAM数组不同，需要配合`pgm_read_*`函数。非AVR平台通常只需要使用`const`，具体行为取决于Core。

# 常见选择
- 控制单个数字引脚：`pinMode()`、`digitalWrite()`、`digitalRead()`
- 读取模拟量：`analogRead()`
- 输出PWM：`analogWrite()`
- 周期执行任务：`millis()`配合无符号减法
- 接收不定长串口数据：`available()`和`read()`逐字节解析
- 发送可读调试信息：`print()`、`println()`
- 发送二进制协议：`write()`
- 访问I2C寄存器设备：`Wire.beginTransmission()`、`Wire.write()`、`Wire.endTransmission(false)`、`Wire.requestFrom()`
- 访问SPI设备：`SPI.beginTransaction()`、手动控制CS、`SPI.transfer()`、`SPI.endTransaction()`
- 保存少量掉电数据：`EEPROM.update()`、`EEPROM.get()`、`EEPROM.put()`
