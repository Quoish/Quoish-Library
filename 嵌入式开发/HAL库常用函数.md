---
title: HAL库常用函数
aliases:
  - STM32 HAL函数速查
  - HAL库函数
tags:
  - STM32
  - HAL库
  - 函数速查
category:
  - 嵌入式开发
status:
created: 2025-11-16
updated: 2026-10-19
---
## 单片机编程的数据类型
```c
带符号整数：int8_t, int16_t, int32_t, int64_t
无符号整数：uint8_t, uint16_t, uint32_t, uint64_t
u stands for unsigned
```
# HAL基础
HAL函数常见的返回值类型为`HAL_StatusTypeDef`：

- `HAL_OK`：操作成功
- `HAL_ERROR`：参数、状态或硬件操作出错
- `HAL_BUSY`：外设或句柄正在执行其他操作
- `HAL_TIMEOUT`：等待事件超过指定时间

常见的函数后缀：

- 无后缀：通常为阻塞模式，函数返回前会等待操作完成或超时
- `_IT`：中断模式，启动后立即返回，完成时进入对应的回调函数
- `_DMA`：DMA模式，由DMA搬运数据，完成或传输过半时可进入回调函数

中断和DMA模式启动后，传入的缓冲区必须保持有效，直到对应的完成回调已经执行或传输被停止。

## HAL_Delay()
```c
void HAL_Delay(uint32_t Delay)
```
作用：阻塞当前程序指定的毫秒数，默认依赖HAL时基计数
参数：
- `Delay`：延时时间，单位ms

`HAL_Delay`会占用当前执行流程，不适合放在要求快速返回的中断服务程序中。

## HAL_GetTick()
```c
uint32_t HAL_GetTick(void)
```
作用：读取HAL启动以来累计的时基计数，默认每1ms增加一次，可用于编写非阻塞超时逻辑
返回值`uint32_t`：当前Tick计数，达到最大值后会自然回绕

判断经过时间时应使用无符号减法，以正确处理计数回绕：

```c
uint32_t tick_start = HAL_GetTick();

if ((uint32_t)(HAL_GetTick() - tick_start) >= 1000U) {
  tick_start = HAL_GetTick();
  // 每隔约1s执行一次
}
```

## HAL_SuspendTick()、HAL_ResumeTick()
```c
void HAL_SuspendTick(void)
void HAL_ResumeTick(void)
```
作用：暂停或恢复HAL时基中断。暂停期间`HAL_GetTick`不再递增，依赖Tick的超时判断和`HAL_Delay`也会受到影响

# [[GPIO]]
## HAL_GPIO_WritePin()
```c
void HAL_GPIO_WritePin(GPIO_TypeDef *GPIOx, 
                       uint16_t GPIO_Pin, 
                       GPIO_PinState PinState)
```
作用：向某一GPIO端口写入电平
参数：
- `GPIOx`：对应端口所属的GPIO组，以`GPIOx`的格式，x为字母，如`GPIOA`，或`自定义标签_GPIO_Port`
- `GPIO_Pin`：对应端口名，以`GPIO_PIN_n`的格式，n为数字，或`自定义标签_Pin`
- `PinState`：写入的端口电平，`GPIO_PIN_SET`为1，`GPIO_PIN_RESET`为0
## HAL_GPIO_ReadPin()
```c
GPIO_PinState HAL_GPIO_ReadPin(GPIO_TypeDef* GPIOx, 
                               uint16_t GPIO_Pin)
```
作用：获取某一GPIO端口的电平高低
参数：
- `GPIOx`：对应端口所属的GPIO组，以`GPIOx`的格式，x为字母，如`GPIOA`，或`自定义标签_GPIO_Port`
- `GPIO_Pin`：对应端口名，以`GPIO_PIN_n`的格式，n为数字，或`自定义标签_Pin`
- 返回值`GPIO_PinState`：读到的端口电平，`GPIO_PIN_SET`为1，`GPIO_PIN_RESET`为0
## HAL_GPIO_TogglePin()
```c
void HAL_GPIO_TogglePin(GPIO_TypeDef *GPIOx, 
                        uint16_t GPIO_Pin)
```
作用：翻转某一GPIO端口的电平
参数：
- `GPIOx`：对应端口所属的GPIO组，以`GPIOx`的格式，x为字母，如`GPIOA`，或`自定义标签_GPIO_Port`
- `GPIO_Pin`：对应端口名，以`GPIO_PIN_n`的格式，n为数字，或`自定义标签_Pin`
## HAL_GPIO_Init()
```c
void HAL_GPIO_Init(GPIO_TypeDef *GPIOx,
                   GPIO_InitTypeDef *GPIO_Init)
```
作用：按照`GPIO_InitTypeDef`结构体中的参数配置一个或多个GPIO引脚。使用前需要先启用对应GPIO端口的时钟
参数：
- `GPIOx`：GPIO组，如`GPIOA`、`GPIOB`
- `GPIO_Init`：GPIO配置结构体指针

常见配置成员：

- `Pin`：引脚掩码，可以使用`GPIO_PIN_0 | GPIO_PIN_1`一次配置多个引脚
- `Mode`：输入、输出、复用、模拟或外部中断模式
- `Pull`：无上下拉、上拉或下拉
- `Speed`：输出速度等级，只对输出和复用输出有效

```c
GPIO_InitTypeDef GPIO_InitStruct = {0};

__HAL_RCC_GPIOA_CLK_ENABLE();
GPIO_InitStruct.Pin = GPIO_PIN_0;
GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
GPIO_InitStruct.Pull = GPIO_NOPULL;
GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
```

## HAL_GPIO_DeInit()
```c
void HAL_GPIO_DeInit(GPIO_TypeDef *GPIOx,
                     uint32_t GPIO_Pin)
```
作用：将指定GPIO引脚恢复到复位状态，并解除对应的外部中断配置
参数：
- `GPIOx`：GPIO组
- `GPIO_Pin`：需要复位的引脚掩码

## HAL_GPIO_LockPin()
```c
HAL_StatusTypeDef HAL_GPIO_LockPin(GPIO_TypeDef *GPIOx,
                                   uint16_t GPIO_Pin)
```
作用：锁定指定GPIO的配置寄存器，锁定后在下一次芯片复位前不能修改对应引脚的配置
参数：
- `GPIOx`：GPIO组
- `GPIO_Pin`：需要锁定的引脚掩码
- 返回值`HAL_StatusTypeDef`：锁定成功返回`HAL_OK`，否则返回`HAL_ERROR`

## HAL_GPIO_EXTI_Callback()
```c
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
```
作用：GPIO外部中断回调函数。当配置为外部中断的引脚触发后，`HAL_GPIO_EXTI_IRQHandler`清除挂起标志并调用此函数
参数：
- `GPIO_Pin`：触发中断的引脚掩码，如`GPIO_PIN_0`

多个引脚共用一个回调函数时，可以根据`GPIO_Pin`判断来源：

```c
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
  if (GPIO_Pin == Button_Pin) {
    button_event = 1;
  }
}
```

## __HAL_GPIO_EXTI_GET_IT()、__HAL_GPIO_EXTI_CLEAR_IT()
```c
__HAL_GPIO_EXTI_GET_IT(GPIO_Pin)
__HAL_GPIO_EXTI_CLEAR_IT(GPIO_Pin)
```
作用：读取或清除指定EXTI线的挂起标志。通常由`HAL_GPIO_EXTI_IRQHandler`自动处理，只有自行编写底层中断流程时才需要直接使用

# [[串口通信]]
## HAL_UART_Transmit()
```c
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *huart,
                                    const uint8_t *pData,
                                    uint16_t Size,
                                    uint32_t Timeout)
```
作用：向串口向外发送定长数据（阻塞模式blocking mode，阻塞指CPU一直等待程序无法向下执行的情况）
参数：
- `huart`：串口句柄指针
- `pData`：要发送的数据的指针
- `Size`：要发送的数据大小，以字节为单位，发送字符串时常用`strlen`计算
- `Timeout`：超时时间，单位ms
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_UART_Receive()
```c
HAL_StatusTypeDef HAL_UART_Receive(UART_HandleTypeDef *huart,
                                    uint8_t *pData,
                                    uint16_t Size,
                                    uint32_t Timeout);
```
作用：通过串口接收一定的数据量，用于接收定长数据
参数：
- `huart`：串口句柄指针
- `pData`：指向接收缓冲区的指针
- `Size`：期望接收的数据长度，以字节为单位；接收缓冲区容量不能小于该值
- `Timeout`：超时时间，单位ms
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_UARTEx_ReceiveToIdle()
```c
HAL_StatusTypeDef HAL_UARTEx_ReceiveToIdle(UART_HandleTypeDef *huart,
                                           uint8_t *pData,
                                           uint16_t Size,
                                           uint16_t *RxLen,
                                           uint32_t Timeout)
```
作用：以阻塞方式接收不定长数据，接收数量达到`Size`或检测到串口空闲事件时返回
参数：
- `huart`：串口句柄指针
- `pData`：指向接收缓冲区的指针
- `Size`：缓冲区最大容量，以字节为单位
- `RxLen`：用于返回本次实际接收到的数据长度
- `Timeout`：最大等待时间，单位ms
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_TIMEOUT`代表超时，其他返回值表示忙碌或错误

## HAL_UART_Transmit_IT()
```c
HAL_StatusTypeDef HAL_UART_Transmit_IT(UART_HandleTypeDef *huart, 
                                       const uint8_t *pData, 
                                       uint16_t Size)
```
作用：（需要打开对应的全局中断global interrupt）以非阻塞模式通过串口发送一定的数据量，当发送完成指定长度的数据时，触发回调函数`void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart)`，无需主程序轮询
参数：
- `huart`：串口句柄指针
- `pData`：要发送的数据的指针
- `Size`：要发送的数据大小，以字节为单位，发送字符串时常用`strlen`计算
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_UART_Receive_IT()
```c
HAL_StatusTypeDef HAL_UART_Receive_IT(UART_HandleTypeDef *huart, 
                                      uint8_t *pData, 
                                      uint16_t Size)
```
作用：（需要打开对应的全局中断global interrupt）以非阻塞模式通过串口接收一定的数据量，当接收到指定长度的数据时，触发回调函数`void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)`，无需主程序轮询
参数：
- `huart`：串口句柄指针
- `pData`：指向接收缓冲区的指针
- `Size`：期望接收的数据长度，以字节为单位；接收缓冲区容量不能小于该值
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_UART_Transmit_DMA()
```c
HAL_StatusTypeDef HAL_UART_Transmit_DMA(UART_HandleTypeDef *huart, 
                                        const uint8_t *pData, 
                                        uint16_t Size)
```
作用：（需要添加对应的DMA通道）以DMA模式通过串口发送一定的数据量，当发送完成指定长度的数据时，触发回调函数`void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart)`，无需主程序轮询
参数：
- `huart`：串口句柄指针
- `pData`：要发送的数据的指针
- `Size`：要发送的数据大小，以字节为单位，发送字符串时常用`strlen`计算
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_UART_Receive_DMA()
```c
HAL_StatusTypeDef HAL_UART_Receive_DMA(UART_HandleTypeDef *huart, 
                                       uint8_t *pData, 
                                       uint16_t Size)
```
作用：（需要添加对应的DMA通道）以DMA模式通过串口接收一定的数据量，当接收到指定长度的数据时，触发回调函数`void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)`，无需主程序轮询
参数：
- `huart`：串口句柄指针
- `pData`：指向接收缓冲区的指针
- `Size`：期望接收的数据长度，以字节为单位；接收缓冲区容量不能小于该值
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_UART_DMAPause()、HAL_UART_DMAResume()、HAL_UART_DMAStop()
```c
HAL_StatusTypeDef HAL_UART_DMAPause(UART_HandleTypeDef *huart)
HAL_StatusTypeDef HAL_UART_DMAResume(UART_HandleTypeDef *huart)
HAL_StatusTypeDef HAL_UART_DMAStop(UART_HandleTypeDef *huart)
```
作用：暂停、恢复或停止当前UART DMA传输
参数：
- `huart`：串口句柄指针
- 返回值`HAL_StatusTypeDef`：操作成功返回`HAL_OK`，失败返回对应错误状态

`HAL_UART_DMAPause`只暂停DMA请求，缓冲区和已传输位置仍由当前句柄保存；`HAL_UART_DMAStop`会终止本次DMA收发，之后需要重新调用DMA收发函数才能开始新的传输。

## HAL_UARTEx_ReceiveToIdle_IT()
```c
HAL_StatusTypeDef HAL_UARTEx_ReceiveToIdle_IT(UART_HandleTypeDef *huart, 
                                              uint8_t *pData, 
                                              uint16_t Size)
```
作用：（需要打开对应的全局中断global interrupt）用于接收不定长数据，当数据接收完成，总线进入空闲状态时，触发回调函数`HAL_UARTEx_RxEventCallback`，无需主程序轮询
参数：
- `huart`：串口句柄指针
- `pData`：指向接收缓冲区的指针
- `Size`：缓冲区的最大容量，以字节为单位
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_UARTEx_ReceiveToIdle_DMA()
```c
HAL_StatusTypeDef HAL_UARTEx_ReceiveToIdle_DMA(UART_HandleTypeDef *huart, 
                                               uint8_t *pData, 
                                               uint16_t Size)
```
作用：（需要添加对应的DMA通道）用于接收不定长数据，当数据接收完成，总线进入空闲状态时，触发回调函数`HAL_UARTEx_RxEventCallback`，无需主程序轮询
参数：
- `huart`：串口句柄指针
- `pData`：指向接收缓冲区的指针
- `Size`：缓冲区的最大容量，以字节为单位
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_UARTEx_RxEventCallback()
```c
void HAL_UARTEx_RxEventCallback(UART_HandleTypeDef *huart, 
                                uint16_t Size)
```
作用：`HAL_UARTEx_ReceiveToIdle_IT`或`HAL_UARTEx_ReceiveToIdle_DMA`的接收事件回调
参数：
- `huart`：串口句柄指针
- `Size`：本次事件发生时接收缓冲区中已有的数据长度，以字节为单位

对于`HAL_UARTEx_ReceiveToIdle_DMA`，回调可能由DMA半传输、传输完成或串口空闲事件触发，可以使用`HAL_UARTEx_GetRxEventType`判断本次回调来源。

## HAL_UARTEx_GetRxEventType()
```c
HAL_UART_RxEventTypeTypeDef HAL_UARTEx_GetRxEventType(
    UART_HandleTypeDef *huart)
```
作用：获取最近一次`HAL_UARTEx_RxEventCallback`的触发原因
返回值`HAL_UART_RxEventTypeTypeDef`：
- `HAL_UART_RXEVENT_HT`：DMA完成一半传输
- `HAL_UART_RXEVENT_TC`：DMA或中断接收达到设定长度
- `HAL_UART_RXEVENT_IDLE`：检测到串口空闲事件

## HAL_UART_TxCpltCallback()、HAL_UART_RxCpltCallback()、HAL_UART_RxHalfCpltCallback()、HAL_UART_ErrorCallback()
```c
void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart)
void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)
void HAL_UART_RxHalfCpltCallback(UART_HandleTypeDef *huart)
void HAL_UART_ErrorCallback(UART_HandleTypeDef *huart)
```
作用：分别在发送完成、接收完成、DMA接收过半和串口错误时被HAL调用。用户可以在工程中重新实现这些弱定义函数

## HAL_UART_GetState()、HAL_UART_GetError()
```c
HAL_UART_StateTypeDef HAL_UART_GetState(
    const UART_HandleTypeDef *huart)
uint32_t HAL_UART_GetError(
    const UART_HandleTypeDef *huart)
```
作用：读取UART当前状态或错误码
常见错误码：
- `HAL_UART_ERROR_PE`：奇偶校验错误
- `HAL_UART_ERROR_NE`：噪声错误
- `HAL_UART_ERROR_FE`：帧格式错误
- `HAL_UART_ERROR_ORE`：接收溢出
- `HAL_UART_ERROR_DMA`：DMA传输错误

## HAL_UART_Abort()、HAL_UART_AbortTransmit()、HAL_UART_AbortReceive()
```c
HAL_StatusTypeDef HAL_UART_Abort(UART_HandleTypeDef *huart)
HAL_StatusTypeDef HAL_UART_AbortTransmit(UART_HandleTypeDef *huart)
HAL_StatusTypeDef HAL_UART_AbortReceive(UART_HandleTypeDef *huart)
```
作用：同步终止UART全部传输、仅发送或仅接收过程，并把对应状态恢复为可再次启动传输的状态
参数：
- `huart`：串口句柄指针
- 返回值`HAL_StatusTypeDef`：终止成功返回`HAL_OK`

## UART_Print()
```c
// 自定义串口格式化输出函数，依赖stdio.h、string.h、stdarg.h
void UART_Print(const char *format, int uart_num, ...) {
  char buffer[256];
  va_list args;
  va_start(args, uart_num);
  int length = vsnprintf(buffer, sizeof(buffer), format, args);
  va_end(args);

  if (length < 0) {
    return;
  }

  UART_HandleTypeDef *huart = NULL;
  if (uart_num == 1) {
    huart = &huart1;
  }
  // else if (uart_num == 2) {
  //     huart = &huart2;
  // }
  if (huart != NULL) {
    uint16_t send_length = (length < (int)sizeof(buffer))
                         ? (uint16_t)length
                         : (uint16_t)(sizeof(buffer) - 1U);
    HAL_UART_Transmit(huart, (uint8_t *)buffer, send_length, HAL_MAX_DELAY);
  }
}
```
作用：格式化字符串并通过指定串口发送。使用`vsnprintf`限制写入长度，避免格式化结果超过数组容量
参数：
- `format`：格式字符串，用法与`printf`相同
- `uart_num`：选择发送的串口
# [[I2C通信]]
## HAL_I2C_Master_Transmit()
```c
HAL_StatusTypeDef HAL_I2C_Master_Transmit(I2C_HandleTypeDef *hi2c, 
                                          uint16_t DevAddress, 
                                          uint8_t *pData, 
                                          uint16_t Size, 
                                          uint32_t Timeout)
```
作用：让主机向从机发送一段数据
参数：
- `hi2c`：I2C句柄指针
- `DevAddress`：传输数据的目标从机地址（是主地址左移一位的8位地址，7位外的那个数填0）
- `pData`：要发送的数据的指针
- `Size`：发送的数据长度，以字节为单位
- `Timeout`：超时时间，单位ms
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_I2C_Master_Receive()
```c
HAL_StatusTypeDef HAL_I2C_Master_Receive(I2C_HandleTypeDef *hi2c, 
                                         uint16_t DevAddress, 
                                         uint8_t *pData, 
                                         uint16_t Size, 
                                         uint32_t Timeout)
```
作用：让主机从从机接收一段数据
参数：
- `hi2c`：I2C句柄指针
- `DevAddress`：传输数据的目标从机地址（是主地址左移一位的8位地址，7位外的那个数填0）（这里不需要改读写位）
- `pData`：指向接收缓冲区的指针
- `Size`：期望接收的数据长度，以字节为单位；接收缓冲区容量不能小于该值
- `Timeout`：超时时间，单位ms
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时

`DevAddress`传入HAL时通常使用左移一位后的地址。例如器件手册给出的7位地址为`0x3C`，则传入`0x3C << 1`。读写位由HAL函数自动处理，不需要手动写入最低位。

## HAL_I2C_IsDeviceReady()
```c
HAL_StatusTypeDef HAL_I2C_IsDeviceReady(I2C_HandleTypeDef *hi2c,
                                        uint16_t DevAddress,
                                        uint32_t Trials,
                                        uint32_t Timeout)
```
作用：主机反复发送设备地址，检查目标从机是否应答，常用于上电探测和等待EEPROM内部写入完成
参数：
- `hi2c`：I2C句柄指针
- `DevAddress`：左移一位后的从机地址
- `Trials`：最大尝试次数
- `Timeout`：每次尝试的超时时间，单位ms
- 返回值`HAL_StatusTypeDef`：检测到应答返回`HAL_OK`

## HAL_I2C_Mem_Write()
```c
HAL_StatusTypeDef HAL_I2C_Mem_Write(I2C_HandleTypeDef *hi2c,
                                    uint16_t DevAddress,
                                    uint16_t MemAddress,
                                    uint16_t MemAddSize,
                                    uint8_t *pData,
                                    uint16_t Size,
                                    uint32_t Timeout)
```
作用：向带内部寄存器地址或存储地址的I2C设备写入数据，常用于传感器寄存器和EEPROM
参数：
- `hi2c`：I2C句柄指针
- `DevAddress`：左移一位后的从机地址
- `MemAddress`：目标设备内部的寄存器或存储地址
- `MemAddSize`：内部地址宽度，使用`I2C_MEMADD_SIZE_8BIT`或`I2C_MEMADD_SIZE_16BIT`
- `pData`：要写入的数据缓冲区
- `Size`：写入的数据长度，以字节为单位
- `Timeout`：超时时间，单位ms
- 返回值`HAL_StatusTypeDef`：HAL状态

## HAL_I2C_Mem_Read()
```c
HAL_StatusTypeDef HAL_I2C_Mem_Read(I2C_HandleTypeDef *hi2c,
                                   uint16_t DevAddress,
                                   uint16_t MemAddress,
                                   uint16_t MemAddSize,
                                   uint8_t *pData,
                                   uint16_t Size,
                                   uint32_t Timeout)
```
作用：从带内部寄存器地址或存储地址的I2C设备读取数据。HAL会先发送内部地址，再使用重复起始条件切换到读取过程
参数：
- `hi2c`：I2C句柄指针
- `DevAddress`：左移一位后的从机地址
- `MemAddress`：目标设备内部的寄存器或存储地址
- `MemAddSize`：内部地址宽度
- `pData`：指向接收缓冲区的指针
- `Size`：读取的数据长度，以字节为单位
- `Timeout`：超时时间，单位ms
- 返回值`HAL_StatusTypeDef`：HAL状态

## HAL_I2C_Master_Transmit_IT()、HAL_I2C_Master_Receive_IT()
```c
HAL_StatusTypeDef HAL_I2C_Master_Transmit_IT(
    I2C_HandleTypeDef *hi2c, uint16_t DevAddress,
    uint8_t *pData, uint16_t Size)
HAL_StatusTypeDef HAL_I2C_Master_Receive_IT(
    I2C_HandleTypeDef *hi2c, uint16_t DevAddress,
    uint8_t *pData, uint16_t Size)
```
作用：以中断模式启动I2C主机发送或接收，启动后立即返回
完成回调：
- `HAL_I2C_MasterTxCpltCallback`：主机发送完成
- `HAL_I2C_MasterRxCpltCallback`：主机接收完成

## HAL_I2C_Master_Transmit_DMA()、HAL_I2C_Master_Receive_DMA()
```c
HAL_StatusTypeDef HAL_I2C_Master_Transmit_DMA(
    I2C_HandleTypeDef *hi2c, uint16_t DevAddress,
    uint8_t *pData, uint16_t Size)
HAL_StatusTypeDef HAL_I2C_Master_Receive_DMA(
    I2C_HandleTypeDef *hi2c, uint16_t DevAddress,
    uint8_t *pData, uint16_t Size)
```
作用：以DMA模式启动I2C主机发送或接收，需要提前配置并关联对应的DMA通道
参数：
- `hi2c`：I2C句柄指针
- `DevAddress`：左移一位后的从机地址
- `pData`：发送或接收缓冲区
- `Size`：传输长度，以字节为单位
- 返回值`HAL_StatusTypeDef`：HAL状态

## HAL_I2C_Mem_Write_IT()、HAL_I2C_Mem_Read_IT()、HAL_I2C_Mem_Write_DMA()、HAL_I2C_Mem_Read_DMA()
```c
HAL_StatusTypeDef HAL_I2C_Mem_Write_IT(
    I2C_HandleTypeDef *hi2c, uint16_t DevAddress,
    uint16_t MemAddress, uint16_t MemAddSize,
    uint8_t *pData, uint16_t Size)
HAL_StatusTypeDef HAL_I2C_Mem_Read_IT(
    I2C_HandleTypeDef *hi2c, uint16_t DevAddress,
    uint16_t MemAddress, uint16_t MemAddSize,
    uint8_t *pData, uint16_t Size)
HAL_StatusTypeDef HAL_I2C_Mem_Write_DMA(
    I2C_HandleTypeDef *hi2c, uint16_t DevAddress,
    uint16_t MemAddress, uint16_t MemAddSize,
    uint8_t *pData, uint16_t Size)
HAL_StatusTypeDef HAL_I2C_Mem_Read_DMA(
    I2C_HandleTypeDef *hi2c, uint16_t DevAddress,
    uint16_t MemAddress, uint16_t MemAddSize,
    uint8_t *pData, uint16_t Size)
```
作用：`HAL_I2C_Mem_Write`和`HAL_I2C_Mem_Read`对应的中断、DMA版本，参数含义与阻塞版本相同，但没有`Timeout`
完成回调：
- `HAL_I2C_MemTxCpltCallback`：内部地址写入完成
- `HAL_I2C_MemRxCpltCallback`：内部地址读取完成

## HAL_I2C_Slave_Transmit()、HAL_I2C_Slave_Receive()
```c
HAL_StatusTypeDef HAL_I2C_Slave_Transmit(I2C_HandleTypeDef *hi2c,
                                         uint8_t *pData,
                                         uint16_t Size,
                                         uint32_t Timeout)
HAL_StatusTypeDef HAL_I2C_Slave_Receive(I2C_HandleTypeDef *hi2c,
                                        uint8_t *pData,
                                        uint16_t Size,
                                        uint32_t Timeout)
```
作用：单片机作为I2C从机时，以阻塞模式发送或接收数据。对应的非阻塞版本为`HAL_I2C_Slave_Transmit_IT`、`HAL_I2C_Slave_Receive_IT`及DMA版本

## HAL_I2C_GetState()、HAL_I2C_GetMode()、HAL_I2C_GetError()
```c
HAL_I2C_StateTypeDef HAL_I2C_GetState(I2C_HandleTypeDef *hi2c)
HAL_I2C_ModeTypeDef HAL_I2C_GetMode(I2C_HandleTypeDef *hi2c)
uint32_t HAL_I2C_GetError(I2C_HandleTypeDef *hi2c)
```
作用：读取I2C当前状态、工作模式和错误码
常见错误码：
- `HAL_I2C_ERROR_BERR`：总线错误
- `HAL_I2C_ERROR_ARLO`：仲裁丢失
- `HAL_I2C_ERROR_AF`：没有收到应答NACK
- `HAL_I2C_ERROR_OVR`：上溢或下溢
- `HAL_I2C_ERROR_DMA`：DMA传输错误
- `HAL_I2C_ERROR_TIMEOUT`：超时

## HAL_I2C_ErrorCallback()
```c
void HAL_I2C_ErrorCallback(I2C_HandleTypeDef *hi2c)
```
作用：I2C中断或DMA传输出现错误时调用的回调函数，可以在其中读取`HAL_I2C_GetError`并记录故障

# [[定时器]]
## HAL_TIM_Base_Start()
```c
HAL_StatusTypeDef HAL_TIM_Base_Start(TIM_HandleTypeDef *htim)
```
作用：启用计时器计数
参数：
- `htim`：计时器句柄指针
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_TIM_Base_Stop()
```c
HAL_StatusTypeDef HAL_TIM_Base_Stop(TIM_HandleTypeDef *htim)
```
作用：停止计时器计数，避免占用资源
参数：
- `htim`：计时器句柄指针
- `HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_TIM_Base_Start_IT()
```c
HAL_StatusTypeDef HAL_TIM_Base_Start_IT(TIM_HandleTypeDef *htim)
```
作用：启用计时器计数，并且启用中断`HAL_TIM_PeriodElapsedCallback`，当计数器溢出时，就会触发该中断
参数：
- `htim`：计时器句柄指针
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_TIM_Base_Stop_IT()
```c
HAL_StatusTypeDef HAL_TIM_Base_Stop_IT(TIM_HandleTypeDef *htim)
```
作用：停止计时器计数，避免占用资源，禁用中断`HAL_TIM_PeriodElapsedCallback`，并清除中断标志
参数：
- `htim`：计时器句柄指针
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_TIM_Base_Start_DMA()、HAL_TIM_Base_Stop_DMA()
```c
HAL_StatusTypeDef HAL_TIM_Base_Start_DMA(TIM_HandleTypeDef *htim,
                                         const uint32_t *pData,
                                         uint16_t Length)
HAL_StatusTypeDef HAL_TIM_Base_Stop_DMA(TIM_HandleTypeDef *htim)
```
作用：以DMA模式启动或停止定时器基本计数。每次更新事件到来时，DMA按顺序把`pData`中的数写入ARR，可用于动态改变周期
参数：
- `htim`：计时器句柄指针
- `pData`：要依次写入自动重装载寄存器的数组
- `Length`：数组中的数据个数
- 返回值`HAL_StatusTypeDef`：HAL状态

DMA传输过半和完成时分别调用`HAL_TIM_PeriodElapsedHalfCpltCallback`和`HAL_TIM_PeriodElapsedCallback`。

## __HAL_TIM_SET_COUNTER()
```c
#define __HAL_TIM_SET_COUNTER(__HANDLE__, __COUNTER__)
```
作用：设置定时器的计数
参数：
- `__HANDLE__`：计时器句柄指针
- `__COUNTER__`：要设置的值
## __HAL_TIM_GET_COUNTER()
```C
#define __HAL_TIM_GET_COUNTER(__HANDLE__)
```
作用：获取当前计时器的计数
参数：
- `__HANDLE__`：计时器句柄指针
## __HAL_TIM_SET_PRESCALER()、__HAL_TIM_GET_PRESCALER()、__HAL_TIM_SET_AUTORELOAD()、__HAL_TIM_GET_AUTORELOAD()、__HAL_TIM_SET_COMPARE()、__HAL_TIM_GET_COMPARE()
类似的宏有
```c
//预分频器PSC
__HAL_TIM_SET_PRESCALER(__HANDLE__, __PRESC__)
__HAL_TIM_GET_PRESCALER(__HANDLE__)
//计数器CNT
__HAL_TIM_SET_COUNTER(__HANDLE__, __COUNTER__)
__HAL_TIM_GET_COUNTER(__HANDLE__)
//自动重装寄存器ARR
__HAL_TIM_SET_AUTORELOAD(__HANDLE__, __AUTORELOAD__)
__HAL_TIM_GET_AUTORELOAD(__HANDLE__)
//捕获比较寄存器CCR
__HAL_TIM_SET_COMPARE(__HANDLE__, __CHANNEL__, __COMPARE__)
__HAL_TIM_GET_COMPARE(__HANDLE__, __CHANNEL__)
```

不再一一介绍
## HAL_TIM_PWM_Start()
```c
HAL_StatusTypeDef HAL_TIM_PWM_Start(TIM_HandleTypeDef *htim, 
                                    uint32_t Channel)
```
作用：启用计时器PWM模式的正常输出
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_CHANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_TIMEx_PWMN_Start()
```c
HAL_StatusTypeDef HAL_TIMEx_PWMN_Start(TIM_HandleTypeDef *htim, 
                                       uint32_t Channel)
```
作用：启用高级定时器PWM模式的互补输出
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_CHANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_TIM_PWM_Start_IT()
```c
HAL_StatusTypeDef HAL_TIM_PWM_Start_IT(TIM_HandleTypeDef *htim, 
                                       uint32_t Channel)
```
作用：启用计时器PWM模式的正常输出，同时启用对应的捕获比较中断回调`HAL_TIM_PWM_PulseFinishedCallback`
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_CHANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_TIM_PWM_Stop()、HAL_TIM_PWM_Stop_IT()
```c
HAL_StatusTypeDef HAL_TIM_PWM_Stop(TIM_HandleTypeDef *htim,
                                   uint32_t Channel)
HAL_StatusTypeDef HAL_TIM_PWM_Stop_IT(TIM_HandleTypeDef *htim,
                                      uint32_t Channel)
```
作用：停止指定通道的PWM输出；`_IT`版本同时禁用对应的捕获比较中断
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号
- 返回值`HAL_StatusTypeDef`：HAL状态

## HAL_TIM_PWM_Start_DMA()、HAL_TIM_PWM_Stop_DMA()
```c
HAL_StatusTypeDef HAL_TIM_PWM_Start_DMA(TIM_HandleTypeDef *htim,
                                        uint32_t Channel,
                                        const uint32_t *pData,
                                        uint16_t Length)
HAL_StatusTypeDef HAL_TIM_PWM_Stop_DMA(TIM_HandleTypeDef *htim,
                                       uint32_t Channel)
```
作用：使用DMA按顺序更新指定通道的CCR，实现可变占空比波形、脉冲序列或查表输出
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号
- `pData`：要写入CCR的比较值数组
- `Length`：比较值个数
- 返回值`HAL_StatusTypeDef`：HAL状态

## HAL_TIM_OC_Start()、HAL_TIM_OC_Stop()、HAL_TIM_OC_Start_IT()、HAL_TIM_OC_Stop_IT()
```c
HAL_StatusTypeDef HAL_TIM_OC_Start(TIM_HandleTypeDef *htim,
                                   uint32_t Channel)
HAL_StatusTypeDef HAL_TIM_OC_Stop(TIM_HandleTypeDef *htim,
                                  uint32_t Channel)
HAL_StatusTypeDef HAL_TIM_OC_Start_IT(TIM_HandleTypeDef *htim,
                                      uint32_t Channel)
HAL_StatusTypeDef HAL_TIM_OC_Stop_IT(TIM_HandleTypeDef *htim,
                                     uint32_t Channel)
```
作用：启动或停止定时器输出比较通道。`_IT`版本在CNT与CCR匹配时产生中断，并调用`HAL_TIM_OC_DelayElapsedCallback`
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号
- 返回值`HAL_StatusTypeDef`：HAL状态

## HAL_TIM_OnePulse_Start()、HAL_TIM_OnePulse_Stop()、HAL_TIM_OnePulse_Start_IT()、HAL_TIM_OnePulse_Stop_IT()
```c
HAL_StatusTypeDef HAL_TIM_OnePulse_Start(TIM_HandleTypeDef *htim,
                                         uint32_t OutputChannel)
HAL_StatusTypeDef HAL_TIM_OnePulse_Stop(TIM_HandleTypeDef *htim,
                                        uint32_t OutputChannel)
HAL_StatusTypeDef HAL_TIM_OnePulse_Start_IT(TIM_HandleTypeDef *htim,
                                            uint32_t OutputChannel)
HAL_StatusTypeDef HAL_TIM_OnePulse_Stop_IT(TIM_HandleTypeDef *htim,
                                           uint32_t OutputChannel)
```
作用：启动或停止单脉冲模式，触发后只输出一个设定好的脉冲周期
参数：
- `htim`：计时器句柄指针
- `OutputChannel`：输出通道，通常使用`TIM_CHANNEL_1`或`TIM_CHANNEL_2`，具体支持情况取决于定时器
- 返回值`HAL_StatusTypeDef`：HAL状态

## HAL_TIM_IC_Start()
```c
HAL_StatusTypeDef HAL_TIM_IC_Start(TIM_HandleTypeDef *htim, 
                                   uint32_t Channel)
```
作用：启用计时器的输入捕获
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_CHANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_TIM_IC_Stop()
```c
HAL_StatusTypeDef HAL_TIM_IC_Stop(TIM_HandleTypeDef *htim, 
                                   uint32_t Channel)
```
作用：禁用计时器的输入捕获
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_CHANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_TIM_IC_Start_IT()
```c
HAL_StatusTypeDef HAL_TIM_IC_Start_IT(TIM_HandleTypeDef *htim, 
                                   uint32_t Channel)
```
作用：启用计时器的输入捕获，同时启用对应的中断回调`void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim)`，当捕获到边沿信号时，就会触发该中断
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_CHANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_TIM_IC_Stop_IT()
```c
HAL_StatusTypeDef HAL_TIM_IC_Stop_IT(TIM_HandleTypeDef *htim, 
                                   uint32_t Channel)
```
作用：禁用计时器的输入捕获，同时禁用对应的中断回调`void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim)`，清除中断标志
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_CHANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_TIM_ReadCapturedValue()
```c
uint32_t HAL_TIM_ReadCapturedValue(const TIM_HandleTypeDef *htim, 
                                   uint32_t Channel)
```
作用：获取某输入捕获通道检测到边沿时对应的计数器值
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_CHANNEL_n`，`n`为数字
- 返回值`uint32_t`：返回检测到边沿时对应的计数器值
## __HAL_TIM_GET_FLAG()、__HAL_TIM_CLEAR_FLAG()
```c
#define __HAL_TIM_GET_FLAG(__HANDLE__, __FLAG__) 
#define __HAL_TIM_CLEAR_FLAG(__HANDLE__, __FLAG__)
```
作用：`__HAL_TIM_GET_FLAG`获取标志位，若要置零该标志，可以使用`__HAL_TIM_CLEAR_FLAG`，一般若要使用标志位作为程序逻辑，都要在使用后及时清零
当某定时器如`&htim1`的通道1捕获完成时，标志`TIM_FLAG_CC1`会置1，可以使用`__HAL_TIM_GET_FLAG(&htim1, TIM_FLAG_CC1)`读取，并使用`__HAL_TIM_CLEAR_FLAG(&htim1, TIM_FLAG_CC1)`清除
当某定时器触发自动重装载时，标志`TIM_FLAG_UPDATE`会置1（注意：函数MX_TIMx_INIT()在初始化定时器时，也会将这个标志置1）
当某定时器因为外部触发产生更新事件时，`TIM_FLAG_UPDATE`和`TIM_FLAG_TRIGGER`都可能置1
## HAL_TIM_Encoder_Start()
```c
HAL_StatusTypeDef HAL_TIM_Encoder_Start(TIM_HandleTypeDef *htim, 
                                        uint32_t Channel)
```
作用：启用计时器的编码器模式
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_CHANNEL_n`，`n`为数字；编码器是多通道混合模式，一般写`TIM_CHANNEL_ALL`
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
## HAL_TIM_Encoder_Stop()、HAL_TIM_Encoder_Start_IT()、HAL_TIM_Encoder_Stop_IT()
```c
HAL_StatusTypeDef HAL_TIM_Encoder_Stop(TIM_HandleTypeDef *htim,
                                       uint32_t Channel)
HAL_StatusTypeDef HAL_TIM_Encoder_Start_IT(TIM_HandleTypeDef *htim,
                                           uint32_t Channel)
HAL_StatusTypeDef HAL_TIM_Encoder_Stop_IT(TIM_HandleTypeDef *htim,
                                          uint32_t Channel)
```
作用：停止编码器接口，或以中断方式启动、停止编码器接口
参数：
- `htim`：计时器句柄指针
- `Channel`：通常使用`TIM_CHANNEL_ALL`同时管理编码器使用的两个输入通道
- 返回值`HAL_StatusTypeDef`：HAL状态

## HAL_TIM_PeriodElapsedCallback()、HAL_TIM_PeriodElapsedHalfCpltCallback()、HAL_TIM_IC_CaptureCallback()、HAL_TIM_OC_DelayElapsedCallback()、HAL_TIM_PWM_PulseFinishedCallback()、HAL_TIM_ErrorCallback()
```c
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
void HAL_TIM_PeriodElapsedHalfCpltCallback(TIM_HandleTypeDef *htim)
void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim)
void HAL_TIM_OC_DelayElapsedCallback(TIM_HandleTypeDef *htim)
void HAL_TIM_PWM_PulseFinishedCallback(TIM_HandleTypeDef *htim)
void HAL_TIM_ErrorCallback(TIM_HandleTypeDef *htim)
```
作用：分别处理更新完成、DMA更新过半、输入捕获、输出比较、PWM脉冲完成和定时器错误事件

多个定时器或通道共用同一回调时，可以通过`htim->Instance`和`htim->Channel`判断事件来源：

```c
void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim)
{
  if ((htim->Instance == TIM2) &&
      (htim->Channel == HAL_TIM_ACTIVE_CHANNEL_1)) {
    capture_value = HAL_TIM_ReadCapturedValue(htim, TIM_CHANNEL_1);
  }
}
```

```c
 /*
Time Base             : HAL_TIM_Base_Start(),     HAL_TIM_Base_Start_DMA(),    HAL_TIM_Base_Start_IT()
Input Capture         : HAL_TIM_IC_Start(),       HAL_TIM_IC_Start_DMA(),      HAL_TIM_IC_Start_IT()
Output Compare        : HAL_TIM_OC_Start(),       HAL_TIM_OC_Start_DMA(),      HAL_TIM_OC_Start_IT()
PWM generation        : HAL_TIM_PWM_Start(),      HAL_TIM_PWM_Start_DMA(),     HAL_TIM_PWM_Start_IT()
One-pulse mode output : HAL_TIM_OnePulse_Start(), HAL_TIM_OnePulse_Start_IT()
Encoder mode output : HAL_TIM_Encoder_Start(),    HAL_TIM_Encoder_Start_DMA(), HAL_TIM_Encoder_Start_IT()
*/
```
各种定时器启用函数概览
# [[ADC]]
## HAL_ADCEx_Calibration_Start()
```c
HAL_StatusTypeDef HAL_ADCEx_Calibration_Start(ADC_HandleTypeDef *hadc)
```
作用：执行ADC自校准，减小内部偏移误差。STM32F1通常在`HAL_ADC_Init`完成后、第一次启动转换前调用一次
参数：
- `hadc`：ADC句柄指针
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时

校准期间ADC必须处于未转换状态。其他系列的校准函数可能带有单端、差分等额外参数，应以对应系列HAL头文件为准。

## HAL_ADC_ConfigChannel()
```c
HAL_StatusTypeDef HAL_ADC_ConfigChannel(
    ADC_HandleTypeDef *hadc,
    ADC_ChannelConfTypeDef *sConfig)
```
作用：配置ADC常规组中的通道、转换顺序和采样时间
参数：
- `hadc`：ADC句柄指针
- `sConfig`：通道配置结构体指针
- 返回值`HAL_StatusTypeDef`：HAL状态

```c
ADC_ChannelConfTypeDef sConfig = {0};

sConfig.Channel = ADC_CHANNEL_0;
sConfig.Rank = ADC_REGULAR_RANK_1;
sConfig.SamplingTime = ADC_SAMPLETIME_55CYCLES_5;
HAL_ADC_ConfigChannel(&hadc1, &sConfig);
```

采样时间需要结合信号源阻抗选择。信号源阻抗较高时，应适当延长采样时间，使内部采样电容有足够时间充电。

## HAL_ADC_Start()、HAL_ADC_Stop()
```c
HAL_StatusTypeDef HAL_ADC_Start(ADC_HandleTypeDef *hadc)
HAL_StatusTypeDef HAL_ADC_Stop(ADC_HandleTypeDef *hadc)
```
作用：启动或停止ADC常规组转换。软件触发模式会在启动时开始转换；外部触发模式会使ADC进入等待状态，直到指定的触发事件到来
参数：
- `hadc`：ADC句柄指针
- 返回值`HAL_StatusTypeDef`：HAL状态

## HAL_ADC_PollForConversion()
```c
HAL_StatusTypeDef HAL_ADC_PollForConversion(ADC_HandleTypeDef *hadc,
                                            uint32_t Timeout)
```
作用：以轮询方式等待ADC常规组转换完成
参数：
- `hadc`：ADC句柄指针
- `Timeout`：超时时间，单位ms；可使用`HAL_MAX_DELAY`持续等待
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时

## HAL_ADC_GetValue()
```c
uint32_t HAL_ADC_GetValue(ADC_HandleTypeDef *hadc)
```
作用：读取ADC常规组最近一次转换的结果
参数：
- `hadc`：ADC句柄指针
- 返回值`uint32_t`：读取到的ADC值

单次轮询转换的常用顺序：

```c
HAL_ADC_Start(&hadc1);
if (HAL_ADC_PollForConversion(&hadc1, 10U) == HAL_OK) {
  adc_value = HAL_ADC_GetValue(&hadc1);
}
HAL_ADC_Stop(&hadc1);
```

## HAL_ADC_Start_IT()、HAL_ADC_Stop_IT()
```c
HAL_StatusTypeDef HAL_ADC_Start_IT(ADC_HandleTypeDef *hadc)
HAL_StatusTypeDef HAL_ADC_Stop_IT(ADC_HandleTypeDef *hadc)
```
作用：以中断模式启动或停止ADC常规组转换。转换完成后调用`HAL_ADC_ConvCpltCallback`
参数：
- `hadc`：ADC句柄指针
- 返回值`HAL_StatusTypeDef`：HAL状态

## HAL_ADC_Start_DMA()、HAL_ADC_Stop_DMA()
```c
HAL_StatusTypeDef HAL_ADC_Start_DMA(ADC_HandleTypeDef *hadc,
                                    uint32_t *pData,
                                    uint32_t Length)
HAL_StatusTypeDef HAL_ADC_Stop_DMA(ADC_HandleTypeDef *hadc)
```
作用：以DMA模式启动或停止ADC常规组转换。DMA传输过半、完成或出错时会进入对应回调函数
参数：
- `hadc`：ADC句柄指针
- `pData`：存放转换结果的数组指针
- `Length`：DMA传输的数据项数量
- 返回值`HAL_StatusTypeDef`：HAL状态

连续采样通常把ADC配置为连续转换，并把DMA配置为循环模式。DMA运行期间不能把局部数组作为接收缓冲区，也不要在主程序中同时改写该数组。

## HAL_ADC_ConvCpltCallback()、HAL_ADC_ConvHalfCpltCallback()、HAL_ADC_LevelOutOfWindowCallback()、HAL_ADC_ErrorCallback()
```c
void HAL_ADC_ConvCpltCallback(ADC_HandleTypeDef *hadc)
void HAL_ADC_ConvHalfCpltCallback(ADC_HandleTypeDef *hadc)
void HAL_ADC_LevelOutOfWindowCallback(ADC_HandleTypeDef *hadc)
void HAL_ADC_ErrorCallback(ADC_HandleTypeDef *hadc)
```
作用：分别处理转换完成、DMA传输过半、模拟看门狗越界和ADC错误事件。多个ADC共用回调时，可通过`hadc->Instance`判断来源

## HAL_ADC_GetState()、HAL_ADC_GetError()
```c
uint32_t HAL_ADC_GetState(ADC_HandleTypeDef *hadc)
uint32_t HAL_ADC_GetError(ADC_HandleTypeDef *hadc)
```
作用：读取ADC当前状态位或错误码。状态值可能由多个标志按位组合，判断时应使用按位与运算

```c
if ((HAL_ADC_GetState(&hadc1) & HAL_ADC_STATE_ERROR_INTERNAL) != 0U) {
  // 处理ADC内部错误
}
```

# [[中断和DMA]]
## HAL_NVIC_SetPriorityGrouping()、HAL_NVIC_SetPriority()
```c
void HAL_NVIC_SetPriorityGrouping(uint32_t PriorityGroup)
void HAL_NVIC_SetPriority(IRQn_Type IRQn,
                          uint32_t PreemptPriority,
                          uint32_t SubPriority)
```
作用：配置NVIC优先级分组，并设置指定中断的抢占优先级和响应优先级
参数：
- `PriorityGroup`：优先级分组，如`NVIC_PRIORITYGROUP_4`
- `IRQn`：中断号，如`USART1_IRQn`、`EXTI0_IRQn`
- `PreemptPriority`：抢占优先级
- `SubPriority`：响应优先级

优先级数值越小，优先级越高。只有抢占优先级更高的中断才能打断当前中断；响应优先级用于决定同一抢占优先级下的响应顺序。CubeMX通常会在初始化代码中统一完成优先级分组设置。

## HAL_NVIC_EnableIRQ()、HAL_NVIC_DisableIRQ()
```c
void HAL_NVIC_EnableIRQ(IRQn_Type IRQn)
void HAL_NVIC_DisableIRQ(IRQn_Type IRQn)
```
作用：在NVIC中启用或禁用指定外设中断
参数：
- `IRQn`：需要控制的中断号

外设自身的中断允许位和NVIC使能位需要同时打开，中断才能进入服务程序。禁用NVIC中断不会自动清除已经挂起的请求。

## HAL_NVIC_GetPendingIRQ()、HAL_NVIC_SetPendingIRQ()、HAL_NVIC_ClearPendingIRQ()、HAL_NVIC_GetActive()
```c
uint32_t HAL_NVIC_GetPendingIRQ(IRQn_Type IRQn)
void HAL_NVIC_SetPendingIRQ(IRQn_Type IRQn)
void HAL_NVIC_ClearPendingIRQ(IRQn_Type IRQn)
uint32_t HAL_NVIC_GetActive(IRQn_Type IRQn)
```
作用：读取、设置或清除中断挂起状态，以及查询中断是否正在执行

## HAL_NVIC_SystemReset()
```c
void HAL_NVIC_SystemReset(void)
```
作用：触发系统复位。调用后程序不会继续向下执行，适合故障恢复、升级完成后的软件复位等场景

中断服务程序通常只完成清除标志、保存数据和设置事件标志等短操作，耗时处理放到主循环或任务中执行。中断中应避免使用`HAL_Delay`以及可能长时间等待的阻塞式外设函数。

## HAL_DMA_Start()、HAL_DMA_Start_IT()
```c
HAL_StatusTypeDef HAL_DMA_Start(DMA_HandleTypeDef *hdma,
                                uint32_t SrcAddress,
                                uint32_t DstAddress,
                                uint32_t DataLength)
HAL_StatusTypeDef HAL_DMA_Start_IT(DMA_HandleTypeDef *hdma,
                                   uint32_t SrcAddress,
                                   uint32_t DstAddress,
                                   uint32_t DataLength)
```
作用：直接启动一次DMA传输；`_IT`版本会开启DMA中断
参数：
- `hdma`：DMA句柄指针
- `SrcAddress`：源地址
- `DstAddress`：目标地址
- `DataLength`：传输的数据项数量，其单位由DMA数据宽度配置决定
- 返回值`HAL_StatusTypeDef`：HAL状态

UART、ADC、I2C等外设一般优先使用各自的`_DMA`函数，它们会完成外设DMA请求和回调关联。直接调用`HAL_DMA_Start`适合内存到内存传输或自行管理外设DMA请求的场景。

## HAL_DMA_PollForTransfer()
```c
HAL_StatusTypeDef HAL_DMA_PollForTransfer(
    DMA_HandleTypeDef *hdma,
    uint32_t CompleteLevel,
    uint32_t Timeout)
```
作用：轮询等待DMA传输过半或全部完成
参数：
- `hdma`：DMA句柄指针
- `CompleteLevel`：`HAL_DMA_HALF_TRANSFER`或`HAL_DMA_FULL_TRANSFER`
- `Timeout`：超时时间，单位ms
- 返回值`HAL_StatusTypeDef`：HAL状态

循环模式下不应使用`HAL_DMA_PollForTransfer`等待全部完成，因为传输会自动重新开始。

## HAL_DMA_Abort()、HAL_DMA_Abort_IT()
```c
HAL_StatusTypeDef HAL_DMA_Abort(DMA_HandleTypeDef *hdma)
HAL_StatusTypeDef HAL_DMA_Abort_IT(DMA_HandleTypeDef *hdma)
```
作用：终止正在进行的DMA传输。`HAL_DMA_Abort_IT`完成终止后可调用DMA终止回调

## HAL_DMA_GetState()、HAL_DMA_GetError()、__HAL_DMA_GET_COUNTER()
```c
HAL_DMA_StateTypeDef HAL_DMA_GetState(DMA_HandleTypeDef *hdma)
uint32_t HAL_DMA_GetError(DMA_HandleTypeDef *hdma)
#define __HAL_DMA_GET_COUNTER(__HANDLE__)
```
作用：读取DMA状态、错误码或当前剩余的数据项数量

常用DMA回调保存在`DMA_HandleTypeDef`中：

- `XferHalfCpltCallback`：传输过半
- `XferCpltCallback`：传输完成
- `XferErrorCallback`：传输出错
- `XferAbortCallback`：中断方式终止完成

使用外设的`_DMA`函数时，HAL通常会自动设置这些底层回调，再转调对应的UART、ADC、I2C或定时器回调函数。

# [[时钟树]]
## HAL_RCC_GetSysClockFreq()、HAL_RCC_GetHCLKFreq()、HAL_RCC_GetPCLK1Freq()、HAL_RCC_GetPCLK2Freq()
```c
uint32_t HAL_RCC_GetSysClockFreq(void)
uint32_t HAL_RCC_GetHCLKFreq(void)
uint32_t HAL_RCC_GetPCLK1Freq(void)
uint32_t HAL_RCC_GetPCLK2Freq(void)
```
作用：分别读取系统时钟SYSCLK、AHB总线时钟HCLK、APB1总线时钟PCLK1和APB2总线时钟PCLK2的频率，返回值单位为Hz

这些函数适合核对时钟配置或计算通信波特率。定时器时钟还受APB预分频规则影响：当对应APB预分频器不为1时，定时器内核时钟通常为该APB时钟的2倍。

## __HAL_RCC_GPIOA_CLK_ENABLE()、__HAL_RCC_USART1_CLK_ENABLE()、__HAL_RCC_DMA1_CLK_ENABLE()、__HAL_RCC_GPIOA_CLK_DISABLE()
```c
__HAL_RCC_GPIOA_CLK_ENABLE();
__HAL_RCC_USART1_CLK_ENABLE();
__HAL_RCC_DMA1_CLK_ENABLE();

__HAL_RCC_GPIOA_CLK_DISABLE();
```
作用：启用或禁用外设时钟。访问外设寄存器或调用初始化函数前，应先启用对应时钟；宏名称中的外设实例需要按实际硬件替换
