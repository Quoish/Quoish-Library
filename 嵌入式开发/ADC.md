# ADC
ADC(Analog to Digital Converter，数模转换器)用于将模拟信号转换为数字信号
## ADC的种类
![[ADC的类型.png]]
## ADC的结构
重介绍逐次逼近型（SAR, Successive Approximation Register）
![[ADC基本结构_逐次逼近型.png]]
上图是4位SAR ADC的结构简图。
设参考电压为3.3V，在电压发生器里用0000到1111给电压分成16份并分别编码。模拟信号输入以后，经过低通滤波，进入比较器参与比较。先在最高位置1，输出1000对应的电压与模拟信号相比较，进行二分查找，然后再下一位重复操作，以此逐次逼近模拟信号的电压。
![[ADC_12Bit_SAR原理图.png]]
同一个ADC可以被多个通道共享，其中在stm32f103c8t6中，ADC最多可以接入12个通道。其中10个是通过IO引脚输入的，2个是分别来自单片机内部的温度传感器（Temperature Sensor Channel）和参考电压（Vrefint Channel）。
## ADC的采样和转换
ADC输入的时钟通常频率不能过高，这是其内部电路特性决定的，否则可能会损坏。
一般采样时间和转换时间都会表示成ADC时钟周期的倍数，单位为cycle
![[ADC采样时间和转换时间.png]]
采样时间即模拟信号在输入和断开的时间，这段时间要给采样电容充电，时间越长，充电越充分，也就越接近目标信号。采样电容两端的电压和模拟信号电压的差值为采样误差，采样时间越长，采样误差越小。单片机规格书提供了最佳采样时间的计算公式
转换时间即采样电容采得的电压再经过二分比较转换为数字信号的时间，12位ADC因为要做12次二分查找，所以需要12.5cycle，其中0.5cycle用于缓冲
12位ADC的采样深度为12，量程为0~3.3V，则ADC的分辨率为3.3/(2^12-1)=0.8mV
## ADC的配置
INx：一个ADC对应的各IO口
Temperature Sensor Channel：温度传感器通道口
Vrefint Channel：内部参考电压通道口
EXTI Conversion Trigger：可选择使用外部中断触发转换
	*1*. Injected Trigger：使用外部中断触发插队转换序列
	*2*. Regular Trigger：使用外部中断触发常规转换序列
	*3*. Injected and Regular Trigger：同时使用两条外部中断线分别触发常规和插队转换序列
### 参数配置
ADCs Common Settings多ADC协同设置
1. Mode模式设置：
	*1.1.* Independent：独立模式，两个ADC相互独立，互不干扰
	*1.2.* Dual Regular Simultaneous：双ADC常规序列同步，ADC1 与 ADC2 同时启动Regular 采样
	*1.3.* Dual Injected Simultaneous：双ADC插队序列同步，ADC1 与 ADC2 同时启动Injected采样
	*1.4.* Dual Combined Regular + Injected Simultaneous Mode：双ADC常规和插队序列都同步
	*1.5.* Dual Interleaved：双 ADC 交错采样，ADC1/2 交替采样，实现更高采样率（两倍）
	*1.6.* Dual Alternate Trigger：交替触发，每次触发交替使用 ADC1 或 ADC2
2. DMA Access Mode多ADC DMA（仅多 ADC 有效）
	*2.1.* Mode1：两个采样交替进入 DMA 缓冲区
	*2.2.* Mode2：同时采样，16位打包为 32 位数据
3. Sampling Delay （Delay Between 2 Sampling Phases）
	*3.1.* Mode1：两个采样交替进入 DMA 缓冲区
	*3.2.* Mode2：同时采样，16位打包为 32 位数据
4. Sampling Delay （Delay Between 2 Sampling Phases）设置在 Dual 模式下，两个 ADC 启动之间的延迟，在双 ADC 工作时，添加延迟以避免互相干扰（如电源纹波）
### ADC Settings ADC设置
1. Clock Prescaler：时钟预分频器
2. Resolution：分辨率，12 bits (15ADC clock cycles)表示采集的数据是12位的，每次的转换时间需要花费15 cycle
3. Data Alignment：数据对齐方式
	*3.1.* Right：右对齐，如接收到12-bit的数据0xABC，储存在uint16_t里为0x0ABC
	*3.2.* Left：左对齐，如接收到12-bit的数据0xABC，储存在uint16_t里为0xABC0
4. Scan Conversion Mode：多通道扫描模式，启用时，ADC会按照常规组的顺序逐次扫描采样多个通道；若一个ADC启用了多个通道，但没有打开扫描模式，则它只会获取Rank 1通道的数据
5. Continuous Conversion Mode：连续转换模式，启用时，转换完一次ADC数据之后，会自动继续转换
6. Discontinuous Conversion Mode：断续转换模式，前提是启用了扫描模式，启用时，可以设置断续转换数x，每次ADC被触发时，ADC不会一次把所有通道扫描完，而是仅扫描完x个通道，下一次被触发时，就接着上次没扫描完的通道，继续扫描x个
7. DMA Continuous Requests：DMA连续请求，启用时，ADC每次转换完成后，就会发送一次DMA请求，需要与Continuous Conversion Mode、DMA的Circular Mode配套使用，才能实现对无限持续信息流的采样
8. End Of Conversion Selection：选择什么时候认为一次ADC采样完成（用于中断）
	*8.1.* EOC flag at the end of single channel conversion：每采一个通道就触发中断
	*8.2.* EOC flag at the end of all conversion：全部通道采完才触发一次中断
### ADC Regular Conversion 正规序列组
1. Number Of Conversion：转换数量，正规序列组里通道的数量
2. External Trigger Conversion Source：外部触发源
	*2.1.* Regular Conversion launched by software：以软件方式触发ADC转换，即直接通过ADC挂载的时钟线
	*2.2.* Timer x Capture Compare Event y：以定时器x的通道y产生的捕获/比较事件触发
	*2.3.* Timer x Trigger Out Event：以定时器x的TRGO事件触发
	*2.4.* EXTI Line x：当在Mode配置里启用了External Trigger for Regular Conversion时，可以用外部中断线触发
3.     External Trigger Conversion Edge：外部触发边沿，可选上升、下降、或双边沿
### ADC Injected Conversion 插队序列组
Injected序列要比Regular序列优先级更高，当二者同时触发时，总是会先打断Regular的采样，先去执行Injected的采样，等到完成以后再去执行Regular的采用
1. Number Of Conversion：转换数量，插队序列组里通道的数量
2. External Trigger Conversion Source：外部触发源
	*2.1.* Regular Conversion launched by software：以软件方式触发ADC转换，即直接通过ADC挂载的时钟线
	*2.2.* Timer x Capture Compare Event y：以定时器x的通道y产生的捕获/比较事件触发
	*2.3.* Timer x Trigger Out Event：以定时器x的TRGO事件触发
	*2.4.* EXTI Line x：当在Mode配置里启用了External Trigger for Regular Conversion时，可以用外部中断线触发
3. External Trigger Conversion Edge：外部触发边沿，可选上升、下降、或双边沿
### Watch Dog看门狗
用来监控 ADC 转换结果是否超出预设的电压范围
1. Enable Analog Watch Dog Mode：使能模拟看门狗
2. Watch Dog Mode：看门狗模式，可选择监管什么通道
3. Analog Watch Dog Channel：当选择单通道监管时，可以选择具体哪个通道
4. High Threshold：电压最高阈值
5. Low Threshold：电压最低阈值
6. Interrupt Mode：使能模拟看门狗中断
