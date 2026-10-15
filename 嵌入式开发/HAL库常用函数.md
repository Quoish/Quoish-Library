---

---
## 单片机编程的数据类型
```c
带符号整数：int8_t, int16_t, int32_t, int64_t
无符号整数：uint8_t, uint16_t, uint32_t, uint64_t
u stands for unsigned
```
# [[GPIO]]
```c
void HAL_GPIO_WritePin(GPIO_TypeDef *GPIOx, 
                       uint16_t GPIO_Pin, 
                       GPIO_PinState PinState)
```
作用：向某一GPIO端口写入电平
参数：
- `GPIOx`：对应端口所属的GPIO组，以`GPIO_x`的格式，x为字母，或`自定义标签_GPIO_Port`
- `GPIO_Pin`：对应端口名，以`GPIO_PIN_n`的格式，n为数字，或`自定义标签_Pin`
- `PinState`：写入的的端口电平，`GPIO_PIN_SET`为1，`GPIO_PIN_RESET`为0
```c
GPIO_PinState HAL_GPIO_ReadPin(GPIO_TypeDef* GPIOx, 
                               uint16_t GPIO_Pin)
```
作用：获取某一GPIO端口的电平高低
参数：
- `GPIOx`：对应端口所属的GPIO组，以`GPIO_x`的格式，x为字母，或`自定义标签_GPIO_Port`
- `GPIO_Pin`：对应端口名，以`GPIO_PIN_n`的格式，n为数字，或`自定义标签_Pin`
- 返回值`GPIO_PinState`：读到的端口电平，`GPIO_PIN_SET`为1，`GPIO_PIN_RESET`为0
```c
void HAL_GPIO_TogglePin(GPIO_TypeDef *GPIOx, 
                        uint16_t GPIO_Pin)
```
作用：翻转某一GPIO端口的电平
参数：
- `GPIOx`：对应端口所属的GPIO组，以`GPIO_x`的格式，x为字母，或`自定义标签_GPIO_Port`
- `GPIO_Pin`：对应端口名，以`GPIO_PIN_n`的格式，n为数字，或`自定义标签_Pin`
# [[串口通信]]
```c
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *huart, 
                                    uint8_t *pData, 
                                    uint16_t *Size, 
                                    uint32_t Timeout)
```
作用：向串口向外发送定长数据（阻塞模式blocking mode，阻塞指CPU一直等待程序无法向下执行的情况）
参数：
- `huart`：串口句柄指针
- `pData`：要发送的数据的指针
- `Size`：要发送的数据大小，以字节为单位，常用` strlen`计算
- `Timeout`：超时时间，单位ms
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_UART_Receive(UART_HandleTypeDef *huart, 
                                    uint8_t *pData, 
                                    uint16_t *Size, 
                                    uint32_t Timeout);
```
作用：通过串口接收一定的数据量，用于接收定长数据
参数：
- `huart`：串口句柄指针
- `pData`：指向接收缓冲区的指针
- `Size`：要接收的数据大小，以字节为单位，常用` strlen`计算
- `Timeout`：超时时间，单位ms
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_UART_Transmit_IT(UART_HandleTypeDef *huart, 
                                       const uint8_t *pData, 
                                       uint16_t Size)
```
作用：（需要打开对应的全局中断global interrupt）以非阻塞模式通过串口发送一定的数据量，当发送完成指定长度的数据时，触发回调函数`void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart)`，无需主程序轮询
参数：
- `huart`：串口句柄指针
- `pData`：要发送的数据的指针
- `Size`：要发送的数据大小，以字节为单位，常用` strlen`计算
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_UART_Receive_IT(UART_HandleTypeDef *huart, 
                                      uint8_t *pData, 
                                      uint16_t Size)
```
作用：（需要打开对应的全局中断global interrupt）以非阻塞模式通过串口接收一定的数据量，当接收到指定长度的数据时，触发回调函数`void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)`，无需主程序轮询
参数：
- `huart`：串口句柄指针
- `pData`：指向接收缓冲区的指针
- `Size`：要接收的数据大小，以字节为单位，常用` strlen`计算
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_UART_Transmit_DMA(UART_HandleTypeDef *huart, 
                                        const uint8_t *pData, 
                                        uint16_t Size)
```
作用：（需要添加对应的DMA通道）以DMA模式通过串口发送一定的数据量，当发送完成指定长度的数据时，触发回调函数`void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart)`，无需主程序轮询
参数：
- `huart`：串口句柄指针
- `pData`：要发送的数据的指针
- `Size`：要发送的数据大小，以字节为单位，常用` strlen`计算
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_UART_Receive_DMA(UART_HandleTypeDef *huart, 
                                       uint8_t *pData, 
                                       uint16_t Size)
```
作用：（需要添加对应的DMA通道）以DMA模式通过串口接收一定的数据量，当接收到指定长度的数据时，触发回调函数`void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)`，无需主程序轮询
参数：
- `huart`：串口句柄指针
- `pData`：指向接收缓冲区的指针
- `Size`：要接收的数据大小，以字节为单位，常用` strlen`计算
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
参数：
- `huart`：串口句柄指针
```c
HAL_StatusTypeDef HAL_UARTEx_ReceiveToIdle_IT(UART_HandleTypeDef *huart, 
                                              uint8_t *pData, 
                                              uint16_t Size)
```
作用：（需要打开对应的全局中断global interrupt）用于接收不定长数据，当数据接收完成，总线进入空闲状态时，触发回调函数`HAL_UARTEx_RxEventCallback`，无需主程序轮询
参数：
- `huart`：串口句柄指针
- `pData`：指向接收缓冲区的指针
- `Size`：缓冲区的最大容量，以字节为单位，常用` strlen`计算
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_UARTEx_ReceiveToIdle_DMA(UART_HandleTypeDef *huart, 
                                               uint8_t *pData, 
                                               uint16_t Size)
```
作用：（需要添加对应的DMA通道）用于接收不定长数据，当数据接收完成，总线进入空闲状态时，触发回调函数`HAL_UARTEx_RxEventCallback`，无需主程序轮询
参数：
- `huart`：串口句柄指针
- `pData`：指向接收缓冲区的指针
- `Size`：缓冲区的最大容量，以字节为单位，常用` strlen`计算
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
void HAL_UARTEx_RxEventCallback(UART_HandleTypeDef *huart, 
                                uint16_t Size)
```
作用：`HAL_UART_ReceiveToIdle_IT`或`HAL_UART_ReceiveToIdle_DMA`的中断回调
参数：
- `huart`：串口句柄指针
- `Size`：接收到的数据长度，以字节为单位
```c
//自定义串口发送字符串函数，依赖stdio.h，string.h，stdarg.h
void UART_Print(const char *format, int uart_num, ...) {
  char buffer[256];
  va_list args;
  va_start(args, uart_num);
  vsprintf(buffer, format, args);  // 格式化字符串
  va_end(args);
  UART_HandleTypeDef *huart = NULL;
  if (uart_num == 1) {
    huart = &huart1;
  }
  // else if (uart_num == 2) {
  //     huart = &huart2;
  // }
  if (huart != NULL) {
    HAL_UART_Transmit(huart, (uint8_t *)buffer, strlen(buffer), HAL_MAX_DELAY);
  }
}
```
作用：直接从串口发送字符串
参数：
- `msg`：要发送的字符串
- `uart_num`：选择发送的串口
# [[I2C通信]]
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
- `Size`：接收到的数据长度，以字节为单位
- `Timeout`：超时时间，单位ms
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_I2C_Master_Receive(I2C_HandleTypeDef *hi2c, 
                                         uint16_t DevAddress, 
                                         uint8_t *pData, 
                                         uint16_t Size, 
                                         uint32_t Timeout)
```
作用：让主机向从机接收一段数据
参数：
- `hi2c`：I2C句柄指针
- `DevAddress`：传输数据的目标从机地址（是主地址左移一位的8位地址，7位外的那个数填0）（这里不需要改读写位）
- `pData`：要发送的数据的指针
- `Size`：接收到的数据长度，以字节为单位
- `Timeout`：超时时间，单位ms
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
# [[定时器]]
```c
HAL_StatusTypeDef HAL_TIM_Base_Start(TIM_HandleTypeDef *htim)
```
作用：启用计时器计数
参数：
- `htim`：计时器句柄指针
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_TIM_Base_Stop(TIM_HandleTypeDef *htim)
```
作用：停止计时器计数，避免占用资源
参数：
- `htim`：计时器句柄指针
- `HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_TIM_Base_Start_IT(TIM_HandleTypeDef *htim)
```
作用：启用计时器计数，并且启用中断`HAL_TIM_PeriodElapsedCallback`，当计数器溢出时，就会触发该中断
参数：
- `htim`：计时器句柄指针
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_TIM_Base_Stop_IT(TIM_HandleTypeDef *htim)
```
作用：停止计时器计数，避免占用资源，禁用中断`HAL_TIM_PeriodElapsedCallback`，并清除中断标志
参数：
- `htim`：计时器句柄指针
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
#define __HAL_TIM_SET_COUNTER(__HANDLE__, __COUNTER__)
```
作用：设置定时器的计数
参数：
- `__HANDLE__`：计时器句柄指针
- `__COUNTER__`：要设置的值
```C
#define __HAL_TIM_GET_COUNTER(__HANDLE__)
```
作用：获取当前计时器的计数
参数：
- `__HANDLE__`：计时器句柄指针
类似的宏有
```c
//预分频器PSC
HAL_TIM_SET_PRESCALER(__HANDLE__, __PRESC__)
HAL_TIM_GET_PRESCALER(__HANDLE__)
//计数器CNT
HAL_TIM_SET_COUNTER(__HANDLE__, __COUNTER__)
HAL_TIM_GET_COUNTER(__HANDLE__)
//自动重装寄存器ARR
HAL_TIM_SET_AUTORELOAD(__HANDLE__, __AUTORELOAD__)
HAL_TIM_GET_AUTORELOAD(__HANDLE__)
//捕获比较寄存器CCR
HAL_TIM_SET_COMPARE（__HANDLE__, __CHANNEL__, __COMPARE__)
HAL_TIM_GET_COMPARE(__HANDLE__, __CHANNEL__)```

不再一一介绍
```c
HAL_StatusTypeDef HAL_TIM_PWM_Start(TIM_HandleTypeDef *htim, 
                                    uint32_t Channel)
```
作用：启用计时器输出比较PWN模式的正常输出
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_ChANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_TIMEx_PWMN_Start(TIM_HandleTypeDef *htim, 
                                       uint32_t Channel)
```
作用：启用计时器输出比较PWN模式的反向输出
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_ChANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_TIM_PWM_Start_IT(TIM_HandleTypeDef *htim, 
                                       uint32_t Channel)
```
作用：启用计时器输出比较PWN模式的正常输出，同时启用对应的中断回调`HAL_TIM_PWM_PulseFinishedCallback`，当发送的PWM脉冲完成了一个周期，就会触发该中断
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_ChANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_TIM_IC_Start(TIM_HandleTypeDef *htim, 
                                   uint32_t Channel)
```
作用：启用计时器的输入捕获
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_ChANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_TIM_IC_Stop(TIM_HandleTypeDef *htim, 
                                   uint32_t Channel)
```
作用：禁用计时器的输入捕获
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_ChANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_TIM_IC_Start_IT(TIM_HandleTypeDef *htim, 
                                   uint32_t Channel)
```
作用：启用计时器的输入捕获，同时启用对应的中断回调`void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim)`，当捕获到边沿信号时，就会触发该中断
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_ChANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_TIM_IC_Stop_IT(TIM_HandleTypeDef *htim, 
                                   uint32_t Channel)
```
作用：禁用计时器的输入捕获，同时禁用对应的中断回调`void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim)`，清除中断标志
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_ChANNEL_n`，`n`为数字
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
uint32_t HAL_TIM_ReadCapturedValue(const TIM_HandleTypeDef *htim, 
                                   uint32_t Channel)
```
作用：获取某输入捕获通道检测到边沿时对应的计数器值
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_ChANNEL_n`，`n`为数字
- 返回值`uint32_t`：返回检测到边沿时对应的计数器值
```c
#define __HAL_TIM_GET_FLAG(__HANDLE__, __FLAG__) 
#define __HAL_TIM_CLEAR_FLAG(__HANDLE__, __FLAG__)
```
作用：`__HAL_TIM_GET_FLAG`获取标志位，若要置零该标志，可以使用`__HAL_TIM_CLEAR_FLAG`，一般若要使用标志位作为程序逻辑，都要在使用后及时清零
当某定时器如`&htim1`的某通道捕获完成时，标志`TIM_FLAG_CC1`为会置1，入参可以填入`__HAL_TIM_GET_FLAG(&htim1, TIM_FLAG_CC1)`和`__HAL_TIM_CLEAR_FLAG(&htim1, TIM_FLAG_CC1)`
当某定时器触发自动重装载时，标志`TIM_FLAG_UPDATE`会置1（注意：函数MX_TIMx_INIT()在初始化定时器时，也会将这个标志置1）
当某定时器因为外部触发自动重装载时，不`仅TIM_FLAG_UPDATE`会置1，`TIM_FLAG_TRIGGER`也会置1
```c
HAL_StatusTypeDef HAL_TIM_Encoder_Start(TIM_HandleTypeDef *htim, 
                                        uint32_t Channel)
```
作用：启用计时器的编码器模式
参数：
- `htim`：计时器句柄指针
- `Channel`：计时器通道编号，格式为`TIM_ChANNEL_n`，`n`为数字，因为编码器是多通道混合模式，一般写`TIM_CHANNEL_ALL`
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
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
```c
HAL_StatusTypeDef HAL_ADC_Start(ADC_HandleTypeDef* hadc)
```
作用：启动ADC常规序列，用于一次转换一个值，若使用软件触发ADC，则也会同时启用软件ADC时钟
参数：
- `hadc`：ADC句柄指针
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_ADC_Stop(ADC_HandleTypeDef* hadc)
```
作用：停用ADC常规序列
参数：
- `hadc`：ADC句柄指针
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_ADC_PollForConversion(ADC_HandleTypeDef* hadc, 
                                            uint32_t Timeout)
```
作用：在普通模式下以轮询标志位的方式等待ADC转换完成
参数：
- `hadc`：ADC句柄指针
- `Timeout`：超时时间
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
uint32_t HAL_ADC_GetValue(ADC_HandleTypeDef* hadc)
```
作用：读取ADC转换的数值
参数：
- `hadc`：ADC句柄指针
- 返回值`uint32_t`：读取到的ADC值
```c
HAL_StatusTypeDef HAL_ADC_Start_IT(ADC_HandleTypeDef* hadc)
```

作用：启动ADC常规序列，用于一次转换一个值，同时启用中断回调`void HAL_ADC_ConvCpltCallback(ADC_HandleTypeDef* hadc)`
参数：
- `hadc`：ADC句柄指针
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时
```c
HAL_StatusTypeDef HAL_ADC_Start_DMA(ADC_HandleTypeDef* hadc, 
                                    uint32_t* pData, 
                                    uint32_t Length)
```
作用：以DMA模式启动ADC常规序列，用于一次转换多个值，同时启用两个中断回调函数`void HAL_ADC_ConvHalfCpltCallback(ADC_HandleTypeDef* hadc)`和`void HAL_ADC_ConvCpltCallback(ADC_HandleTypeDef* hadc)`
参数：
- `hadc`：ADC句柄指针
- `pData`：ADC数据所存放的数组的指针
- `Length`：数组长度
- 返回值`HAL_StatusTypeDef`：`HAL_OK`代表成功，`HAL_ERROR`代表出错，`HAL_BUSY`代表繁忙，`HAL_TIMEOUT`代表超时