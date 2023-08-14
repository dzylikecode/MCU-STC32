# STM32F407ZGT6

|    资源    |   参数    |    资源    | 参数 |    资源    |   参数   |
| :--------: | :-------: | :--------: | :--: | :--------: | :------: |
|    内核    | Cortex M4 | 基本定时器 |  2   | USART/UART |    6     |
|    主频    |  168Mhz   | 通用定时器 |  10  |    CAN     |    2     |
|   FLASH    |  1024KB   | 高级定时器 |  2   |    SDIO    |    1     |
|    SRAM    |   192KB   | 12 位 ADC  |  3   |    FSMC    |    1     |
|    封装    |  LQFP144  | ADC 通道数 |  18  |    DMA     |    2     |
|  IO 数量   |    114    | 12 位 DAC  |  2   |    RTC     |    1     |
|  工作电压  |   3.3V    |    SPI     |  3   |    IIC     |    3     |
| USB Device |     1     |  USB OTG   |  1   |  Ethernet  | 10/100 M |

## 最小系统

| 类型 | 引脚名称           | 说明                                                                                                               |
| ---- | ------------------ | ------------------------------------------------------------------------------------------------------------------ |
| 电源 | VDD/VSS            | 电源正(VDD)/负(VSS)引脚,给 STM32 供电                                                                              |
|      | VDDA/VSSA          | 模拟部分电源正/负引脚,给 STM32 内部模拟部分供电                                                                    |
|      | VREF+/VREF-        | 参考电压正/负引脚,给 STM32 内部 ADC/DAC 提供参考电压 100 脚及以上的 STM32F407 型号才有这两个脚                     |
|      | VBAT               | RTC&后备区域供电引脚,给 RTC 和后备区域供电.一般 VBAT 接电池,用于断电维持 RTC 工作,如不需要,直接将 VBAT 接 VDD 即可 |
| 复位 | NRST               | 复位引脚,用于复位 STM32,低电平复位                                                                                 |
| 启动 | BOOT0/BOOT1        | 启动选择引脚                                                                                                       |
| 晶振 | OSC_IN/OSC_OUT     | 外部 HSE 晶振引脚,用于给 STM32 提供高精度系统时钟. <br>如果使用内部 HSI 能满足使用需求,这两个脚可以不接晶振        |
|      | OSC32_IN/OSC32_OUT | 外部 LSE 晶振引脚,用于给 STM32 内部 RTC 提供时钟. <br>如果使用内部 LSI 能满足使用需求,这两个脚可以不接晶振         |
| 调试 | SWCLK/SWDIO        | SWD 调试引脚,用于调试 STM32 程序                                                                                   |

## IO 分配

先分配特定外设 IO,再分配通用 IO,最后微调的原则

| 分配     | 外设            | 说明                                                                                                                                    |
| -------- | --------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| 特定外设 | IIC             | IIC 一般用到 2 根线:IIC_SCL 和 IIC_SDA(ST 叫 I2C). 数据手册有相应复用功能的 GPIO 都可选用                                               |
|          | SPI             | SPI 用到 4 根线:SPI_CS/MOSI/MISO/SCK.一般 SPI_CS 我们使用通用 GPIO ,方便挂多个 SPI 器件.                                                |
|          | TIM             | 根据需要可选:TIM_CH1/2/3/4/ETR/1N/2N/3N/BKIN 等                                                                                         |
|          | USART <br> UART | USART 有 USART_TX/RX/CTS/RTS/CK 信号 <br> UART 仅有 UART_TX/RX 两个信号                                                                 |
|          | USB             | USB 用到 2 根线:USB_DP 和 USB_DM                                                                                                        |
|          | CAN             | CAN 用到 2 根线:CAN_RX 和 CAN_TX                                                                                                        |
|          | ADC             | ADC 根据需要可选:ADC_IN0 ~ ADC_IN15                                                                                                     |
|          | DAC             | DAC 根据需要可选:DAC_OUT1 / DAC_OUT2                                                                                                    |
|          | SDIO            | 根据需要可选:FSMC_D0~15/A0~25/ NBL0~1/NE1~4/NCE2~3/NOE/NWE/NWAIT/CLK 等                                                                 |
| 通用     | GPIO            | 在完成特定外设的 IO 分配以后,就可以进行 GPIO 分配了 <br> 比如将按键,LED,蜂鸣器等仅需要高低电平读取/输出的外设连接到空闲的普通 GPIO 即可 |
| 微调     | IO              | 微调主要包括两部分:<br> 1. 当 IO 不够用的时候,通用 GPIO 和特定外设可能要共用 IO 口 <br> 2.为了方便布线,可能要调整某些 IO 口的位置       |

## Boot

| BOOT0 | BOOT1 | 启动模式                                 | 说明                                                                       |
| ----- | ----- | ---------------------------------------- | -------------------------------------------------------------------------- |
| 0     | X     | 用户闪存存储器启动 <br> 地址:0X0800 0000 | 用户闪存储器存启动,也就是 FLASH 启动,正常运行我们自己的程序,就应该用此设置 |
| 1     | 0     | 系统存储器启动 <br> 地址:0X1FFF F000     | 系统存储器启动,用于串口下载程序                                            |
| 1     | 1     | SRAM 启动(不常用) <br> 地址:0X2000 0000  | SRAM 启动,一般没用                                                         |

由于从系统存储器启动,是不运行用户程序的,所以不管用户程序怎么写,此模式下都可以通过仿真器下载代码.所以,该模式可常用于异常关闭 JTAG/SWD 导致仿真器无法下载程序时的补救措施(在此模式下,下载一个不关闭 JTAG/SWD 接口的程序即可救活)

### 串口下载

确保 P4 端子的 RXD 和 PA9(STM32 的 TXD), TXD 和 PA10(STM32 的 RXD)通过跳线帽连接起来

B1, B0 为 0, 1 进行通过串口下载代码, 如果没有设置从 0X08000000 开始运行, 则代码不会立即运行,此时,你还需要把 B0 接回 GND,然后再按一次复位,才会开始运行下载的代码

## 寄存器

| 大类       | 小类           | 说明                                                                              |
| ---------- | -------------- | --------------------------------------------------------------------------------- |
| 内核寄存器 | 内核相关寄存器 | 包含 R0~R15,xPSR,特殊功能寄存器等                                                 |
|            | 中断控制寄存器 | 包含 NVIC 和 SCB 相关寄存器,NVIC 有:ISER,ICER,ISPR,IP 等;SCB 有:VTOR,AIRCR,SCR 等 |
|            | SysTick 寄存器 | 包含 CTRL,LOAD,VAL 和 CALIB 四个寄存器                                            |
|            | 内存保护寄存器 | 可选功能,STM32F407 没有                                                           |
|            | 调试系统寄存器 | ETM,ITM,DWT,IPIU 等相关寄存器                                                     |
| 外设寄存器 | -              | 包含 GPIO,UART,IIC,SPI,TIM,DMA,ADC,DAC,RTC,I/WWDG,PWR,CAN,USB 等各种外设寄存器    |

内核寄存器,一般只需要关心中断控制寄存器和 SysTick 寄存器即可

## 存储器映射

将寄存器, 内存等进行内存映射, 映射到 4GB 空间上

| 存储块  | 功能               | 地址范围                         |
| ------- | ------------------ | -------------------------------- |
| Block 0 | Code               | 0X0000 0000 ~ 0x1FFF FFFF(512MB) |
| Block 1 | SRAM               | 0X2000 0000 ~ 0x3FFF FFFF(512MB) |
| Block 2 | 外设               | 0X4000 0000 ~ 0x5FFF FFFF(512MB) |
| Block 3 | FSMC Bank1&2       | 0X6000 0000 ~ 0x7FFF FFFF(512MB) |
| Block 4 | FSMC Bank3&4       | 0X8000 0000 ~ 0x9FFF FFFF(512MB) |
| Block 5 | FSMC 寄存器        | 0XA000 0000 ~ 0xBFFF FFFF(512MB) |
| Block 6 | 没用到             | 0XC000 0000 ~ 0xDFFF FFFF(512MB) |
| Block 7 | Cortex M4 内部外设 | 0XE000 0000 ~ 0xFFFF FFFF(512MB) |

### block 0

| 功能                                                                      | 地址范围                        |
| ------------------------------------------------------------------------- | ------------------------------- |
| FLASH 或系统存储器别名区,取决于 BOOT 脚的设置                             | 0x0000 0000 ~ 0x000F FFFF(1MB)  |
| 保留                                                                      | 0x0010 0000 ~ 0x07FF FFFF       |
| 用户 FLASH,用于存储用户代码                                               | 0x0800 0000 ~ 0x080F FFFF(1MB)  |
| 保留                                                                      | 0x0810 0000 ~ 0x0FFF FFFF       |
| CCM 的 RAM 数据(64KB 的 SRAM 内存)                                        | 0x1000 0000 ~ 0x1000 FFFF(64KB) |
| 保留                                                                      | 0x1001 0000 ~ 0x1FFE FFFF       |
| 系统存储器,用于存储 STM32 出厂固化的 Bootloader 程序,比如用于串口下载代码 | 0x1FFF 0000 ~ 0x1FFF 7A0F(31KB) |
| 保留                                                                      | 0x1FFF 7A10 ~ 0x1FFF 7FFF       |
| 选项字节,用于配置读保护,设置看门狗等                                      | 0x1FFF C000 ~ 0x1FFF C007(7B)   |
| 保留                                                                      | 0x1FFF C008 ~ 0x1FFF FFFF       |

> 可以看到 b0, b1 设置的开始地址

## block 1

| 功能  | 地址范围                         |
| ----- | -------------------------------- |
| SRAM1 | 0X2000 0000 ~ 0x2001 BFFF(112KB) |
| SRAM2 | 0X2001 C000 ~ 0x2001 FFFF(16KB)  |
| 保留  | 0X2002 0000 ~ 0x3FFF FFFF        |

## block 2

| 功能               | 地址范围                  |
| ------------------ | ------------------------- |
| APB1 总线外设      | 0x4000 0000 ~ 0x4000 77FF |
| 保留               | 0x4000 7800 ~ 0x4000 FFFF |
| APB2 总线外设      | 0x4001 0000 ~ 0x4000 33FF |
| 保留               | 0x4001 3400 ~ 0x4001 37FF |
| SYSCFG             | 0x4001 3800 ~ 0x4000 3BFF |
| EXTI               | 0x4001 3C00 ~ 0x4000 3FFF |
| APB2 总线外设      | 0x4001 4000 ~ 0x4000 4BFF |
| 保留               | 0X4001 4000 ~ 0x4001 7FFF |
| AHB1 总线外设      | 0X4002 0000 ~ 0x4002 23FF |
| 保留               | 0X4002 2400 ~ 0x4002 2FFF |
| CRC                | 0X4002 3000 ~ 0x4002 33FF |
| 保留               | 0X4002 3400 ~ 0x4002 37FF |
| 复位时钟控制器 RCC | 0X4002 3800 ~ 0x4002 3BFF |
| AHB1 总线外设      | 0X4002 3C00 ~ 0x4007 FFFF |
| 保留               | 0X4002 9400 ~ 0x4FFF FFFF |
| AHB2 总线外设      | 0X5000 0000 ~ 0x5006 0FFF |
| 保留               | 0X5006 0C00 ~ 0x5FFF FFFF |
| AHB3 总线外设      | 0X6000 0000 ~ 0XA000 0FFF |
| 保留               | 0XA000 1000 ~ 0XBFFF FFFF |

## 寄存器映射

1. 寄存器名字
2. 寄存器偏移量及复位值
3. 寄存器位表
4. 位功能描述

| 组件                     | 说明                                                                                                    |
| ------------------------ | ------------------------------------------------------------------------------------------------------- |
| 中断编号定义             | 定义 IRQn_Type 枚举类型,包含 STM32F407 内部所有中断编号(中断号)                                         |
| 外设寄存器结构体类型定义 | 以外设为基本单位,使用结构体类型定义对每个外设的所有寄存器进行封装                                       |
| 寄存器映射               | 1,定义总线地址和外设基地址 <br> 2,使用外设结构体类型定义将外设基地址强制转换成结构体指针,完成寄存器映射 |
| 寄存器位定义             | 定义外设寄存器每个功能位的位置及掩码                                                                    |
| 外设判定                 | 判断某个外设是否合法(即是否存在该外设)                                                                  |

3 个步骤:

1. 外设寄存器结构体类型定义

   ```c
   typedef struct {
   __IO uint32_t MODER; /* GPIO_MODER 寄存器,相对外设基地址偏移量:0X00 */
   __IO uint32_t OTYPER; /* GPIO_OTYPER 寄存器,相对外设基地址偏移量:0X04 */
   __IO uint32_t OSPEEDR; /* GPIO_OSPEEDR 寄存器,相对外设基地址偏移量:0X08 */
   __IO uint32_t PUPDR; /* GPIO_PUPDR 寄存器,相对外设基地址偏移量:0X0C */
   __IO uint32_t IDR; /* GPIO_IDR 寄存器,相对外设基地址偏移量:0X10 */
   __IO uint32_t ODR; /* GPIO_ODR 寄存器,相对外设基地址偏移量:0X14 */
   __IO uint32_t BSRR; /* GPIO_BSRR 寄存器,相对外设基地址偏移量:0X18 */
   __IO uint32_t LCKR; /* GPIO_LCKR 寄存器,相对外设基地址偏移量:0X1C */
   __IO uint32_t AFR[2]; /* GPIO_ARF[2]寄存器,相对外设基地址偏移量:0X20 */
   } GPIO_TypeDef;
   ```

2. 外设基地址定义

   ```c
   #define PERIPH_BASE 0x40000000UL /* 外设基地址 */
   #define APB1PERIPH_BASE PERIPH_BASE /* APB1 总线基地址 */
   #define APB2PERIPH_BASE (PERIPH_BASE + 0x00010000UL) /* APB2 总线基地址 */
   #define AHB1PERIPH_BASE (PERIPH_BASE + 0x00020000UL) /* AHB1 总线基地址 */
   #define AHB2PERIPH_BASE (PERIPH_BASE + 0x10000000UL) /* AHB2 总线基地址 */
   #define GPIOA_BASE (AHB1PERIPH_BASE + 0x0000UL) /* GPIOA 基地址 */
   #define GPIOB_BASE (AHB1PERIPH_BASE + 0x0400UL) /* GPIOB 基地址 */
   #define GPIOC_BASE (AHB1PERIPH_BASE + 0x0800UL) /* GPIOC 基地址 */
   #define GPIOD_BASE (AHB1PERIPH_BASE + 0x0C00UL) /* GPIOD 基地址 */
   #define GPIOE_BASE (AHB1PERIPH_BASE + 0x1000UL) /* GPIOE 基地址 */
   #define GPIOF_BASE (AHB1PERIPH_BASE + 0x1400UL) /* GPIOF 基地址 */
   #define GPIOG_BASE (AHB1PERIPH_BASE + 0x1800UL) /* GPIOG 基地址 */
   #define GPIOH_BASE (AHB1PERIPH_BASE + 0x1C00UL) /* GPIOH 基地址 */
   #define GPIOI_BASE (AHB1PERIPH_BASE + 0x2000UL) /* GPIOI 基地址 */
   ```

3. 寄存器映射(通过将外设基地址强制转换为外设结构体类型指针即可)

   ```c
   #define GPIOA ((GPIO_TypeDef *) GPIOA_BASE) /* GPIOA 寄存器地址映射 */
   #define GPIOB ((GPIO_TypeDef *) GPIOB_BASE) /* GPIOB 寄存器地址映射 */
   #define GPIOC ((GPIO_TypeDef *) GPIOC_BASE) /* GPIOC 寄存器地址映射 */
   #define GPIOD ((GPIO_TypeDef *) GPIOD_BASE) /* GPIOD 寄存器地址映射 */
   #define GPIOE ((GPIO_TypeDef *) GPIOE_BASE) /* GPIOE 寄存器地址映射 */
   #define GPIOF ((GPIO_TypeDef *) GPIOF_BASE) /* GPIOF 寄存器地址映射 */
   #define GPIOG ((GPIO_TypeDef *) GPIOG_BASE) /* GPIOG 寄存器地址映射 */
   #define GPIOH ((GPIO_TypeDef *) GPIOH_BASE) /* GPIOH 寄存器地址映射 */
   #define GPIOI ((GPIO_TypeDef *) GPIOI_BASE) /* GPIOI 寄存器地址映射 */
   ```

$$\text{GPIOB\_ODR 地址} = \text{AHB1 总线基地址} + \text{GPIOB 外设偏移量} + \text{寄存器偏移量}$$
