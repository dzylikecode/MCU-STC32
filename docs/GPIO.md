# GPIO

按组分配存在,每组最多 16 个 IO 口

STM32F407ZGT6 芯片是 144 脚的芯片,分为 7 组,分别是:GPIOA,GPIOB,GPIOC,GPIOD,GPIOE,GPIOF 和 GPIOG,其中共有 112 个 IO

!> 数据手册: 如果引脚设置的是模拟输入模式,则不能接 5V; 凡是不带 FT 标志的,就建议不要接 5V

## 功能模式

1. @输入浮空
2. @输入上拉
3. @输入下拉
4. @模拟
5. @开漏输出
6. @推挽输出
7. @开漏式复用功能
8. @推挽式复用功能

## 寄存器

通用 GPIO 口有 7 个 32 位寄存器控制:

- 4 个 32 位配置寄存器(@MODER,@OTYPER,@OSPEEDR 和 @PUPDR)
- 2 个 32 位数据寄存器(@IDR 和 @ODR)
- 1 个 32 位置位/复位寄存器 (@BSRR)
- 1 个 32 位锁定寄存器 (LCKR)
- 2 个 32 位复用功能选择寄存器(AFRH 和 AFRL)

## local

### 输入浮空

<docs-expose>

IO 口的电平完全是由外部电路决定

</docs-expose>

### 输入上拉

<docs-expose>

不适合做电流型驱动

</docs-expose>

### 输入下拉

<docs-expose>

不适合做电流型驱动

</docs-expose>

### 模拟

<docs-expose>

用于 ADC 采集或者 DAC 输出,或者低功耗下省电

</docs-expose>

### 开漏输出

<docs-expose>

开漏输出模式是数字电路输出的一种,从结果上看它只能输出低电平 Vss 或者高阻态

</docs-expose>

### 推挽输出

<docs-expose>

会输出低电平 VSS 或者高电平 VDD

</docs-expose>

### 开漏式复用功能

<docs-expose>

STM32F4 有很多的内置外设, 比如 USART,SPI,bxCAN 等等,这些外设的外部引脚都是与 GPIO 复用的.也就是说,一个 GPIO 如果可以复用为内置外设的功能引脚,那么当这个 GPIO 作为内置外设使用的时候,就叫做复用.

所谓"复用功能",是指单片机的引脚既可以做普通 GPIO 使用,也可以作为内部外设控制器的引脚来使用.

一个 IO 口可以是通用的 IO 口功能,还可以是其他外设的特殊功能引脚,这就是 IO 口的复用功能.一个 IO 口可以是多个外设的功能引脚,我们需要选择作为其中一个外设的功能引脚.当选择复用功能时,引脚的状态是由对应的外设控制,而不是输出数据寄存器.

虽然复用模式的控制信号来自内置外设控制器,但是单片机(CPU)依然可以读取相应的数据.

</docs-expose>

### 推挽式复用功能

<docs-expose>

同上

</docs-expose>

### MODER

<docs-expose>

GPIO 端口模式寄存器 (GPIOx_MODER)

GPIO 口模式控制寄存器,用于控制 GPIOx 的工作模式

</docs-expose>

### OTYPER

<docs-expose>

GPIO 端口输出类型寄存器 (GPIOx_OTYPER)

用于控制 GPIOx 的输出类型

</docs-expose>

### OSPEEDR

<docs-expose>

GPIO 端口输出速度寄存器 (GPIOx_OSPEEDR)

该寄存器用于控制 GPIOx 的输出速度

</docs-expose>

### PUPDR

<docs-expose>

GPIO 端口上拉/下拉寄存器 (GPIOx_PUPDR)

该寄存器用于控制 GPIOx 的上拉/下拉

</docs-expose>

### IDR

<docs-expose>

端口输入数据寄存器(IDR)

该寄存器用于获取 GPIOx 的输入高低电平

</docs-expose>

### ODR

<docs-expose>

端口输出数据寄存器(ODR)

该寄存器用于控制 GPIOx 的输出高电平或者低电平

</docs-expose>

### BSRR

<docs-expose>

端口置位/复位寄存器(BSRR)

该寄存器也用于控制 GPIOx 的输出高电平或者低电平

</docs-expose>

## References

- [如何理解 STM32 单片机引脚的复用功能? - 知乎](https://zhuanlan.zhihu.com/p/32346166)
