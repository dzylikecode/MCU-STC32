# file structure

## BSP

<docs-expose>

也叫板级支持包,用于适配 ST 官方对应的开发板的硬件驱动程序,每一种开发板对应一个文件夹.例如触摸屏,LCD,NOR FLASH 以及 EEPROM 等板载硬件资源等驱动.这些文件针只匹配特定的开发板使用,不同开发板可能不能直接使用.

</docs-expose>

## CMSIS

<docs-expose>

顾名思义就是符合 CMSIS 标准的软件抽象层组件相关文件.文件夹内部文件比较多.主要包括 DSP 库(DSP_LIB 文件夹),Cortex-M 内核及其设备文件(Include 文件夹),微控制器专用头文件/启动代码/专用系统文件等(Device 文件夹).在新建工程的时候,会使用到这个文件夹内部很多文件.

</docs-expose>

## STM32F4xx_HAL_Driver

<docs-expose>

这个文件夹非常重要,它包含了所有的 STM32F4xx 系列 HAL 库头文件和源文件,也就是所有底层硬件抽象层 API 声明和定义.它的作用是屏蔽了复杂的硬件寄存器操作,统一了外设的接口函数.该文件夹包含 Src 和 Inc 两个子文件夹,其中 Src 子文件夹存放的是.c 源文件,Inc 子文件夹存放的是与之对应的.h 头文件.每个.c 源文件对应一个.h 头文件.源文件名称基本遵循 stm32f4xx_hal_ppp.c 定义格式,头文件名称基本遵循 stm32f4xx_hal_ppp.h 定义格式.比如 gpio 相关的 API 的声明和定义在文件 stm32f4xx_hal_gpio.h 和 stm32f4xx_hal_gpio.c 中.

</docs-expose>

## STM32_USB_Device_Library

<docs-expose>

USB 从机设备支持包

</docs-expose>

## STM32_USB_Host_Library

<docs-expose>

USB 主机设备支持包

</docs-expose>

## STemWin

<docs-expose>

STemWin 工具包,由 Segger 提供

</docs-expose>

## FatFs

<docs-expose>

FAT 文件系统支持包.采用的 FATFS 文件系统

</docs-expose>

## FreeRTOS

<docs-expose>

FreeRTOS 实时系统支持包

</docs-expose>

## LibJPEG

<docs-expose>

基于 C 语言的 JPEG 图形解码支持包

</docs-expose>

## LwIP

<docs-expose>

LwIP 网络通信协议支持包

</docs-expose>

## Utilities

<docs-expose>

该文件夹是一些公用组件,也是主要为 ST 官方的 Demo 板提供的

</docs-expose>

## Core

<docs-expose>

CMSIS-Core(Cortex-M)相关文件的用户代码模板,在 ARM.CMSIS.pdsc 中引用

</docs-expose>

## Core_A

<docs-expose>

CMSIS-Core(Cortex-A)相关文件的用户代码模板,在 ARM.CMSIS.pdsc 中引用

</docs-expose>

## Device

<docs-expose>

CMSIS 驱动程序外设接口 API 的头文件

</docs-expose>

## DSP

<docs-expose>

CMSIS-DSP 软件库源代码

</docs-expose>

## NN

<docs-expose>

CMSIS-NN 软件库源代码

</docs-expose>

## Include

<docs-expose>

CMSIS-Core(Cortex-M)和 CMSIS-DSP 需要包括的头文件等

</docs-expose>

## Lib

<docs-expose>

包括 CMSIS 核心(Cortex-M)和 CMSIS-DSP 的文件

</docs-expose>

## RTOS

<docs-expose>

CMSIS-RTOS 版本 1 以及 RTX4 参考实现

</docs-expose>

## RTOS2

<docs-expose>

CMSIS-RTOS 版本 2 以及 RTX5 参考实现

</docs-expose>

## stm32f4xx-h

<docs-expose>

该文件内容看起来不多,却非常重要,是所有 STM32F4 系列的顶层头文件.使用 STM32F4 任何型号的芯片,都需要包含这个头文件.该文件包含了很多条件定义和常用的枚举变量类型,与宏定义配合,选择性包含某一特定的 STM32F4 系列芯片的头文件.这个文件使我们在使用 STM32F4 系列的不同型号芯片时,不需要每次都修改工程头文件,只需要修改宏定义并增加特定型号芯片的头文件即可快速选择使用不同类型的 F4 芯片

</docs-expose>

## stm32f407xx-h

<docs-expose>

STM32F407 系列芯片通用的片上外设访问层头文件.只要我们使用 STM32F407 系列芯片,都需要包括这个头文件.这个文件的主要作用是定义声明寄存器以及封装内存操作,以结构体和宏定义标识符的形式

</docs-expose>

## system_stm32f4xx-h

<docs-expose>

声明和定义了系统初始化函数 SystemInit 以及系统时钟更新函数 SystemCoreClockUpdate.SystemInit 函数的作用是进行时钟系统的一些初始化操作以及中断向量表偏移地址设置,但它并没有设置具体的时钟值,这是与标准库的最大区别,在使用标准库的时候,SystemInit 函数会帮我们配置好系统时钟配置相关的各个寄存器.SystemCoreClockUpdate 函数是在系统时钟配置进行修改后,调用这个函数来更新全局变量 SystemCoreClock 的值,变量 SystemCoreClock 是一个全局变量,开放这个变量可以方便我们在用户代码中直接使用这个变量来进行一些时钟运算

</docs-expose>

## startup_stm32f407xx-s

<docs-expose>

STM32F407 系列芯片的启动文件,进行堆栈的初始化,中断向量表以及中断函数定义等.启动文件的一个很重要的作用就是系统复位后引导进入 main 函数.每个系列都有与之对应的启动文件

</docs-expose>

## stm32f4xx_hal-h

<docs-expose>

初始化 HAL 库,(比如 HAL_Init,HAL_DeInit, HAL_Delay 等),主要实现 HAL 库的初始化,系统滴答,HAL 库延时函数,IO 重映射和 DBGMCU 功能等

</docs-expose>

## stm32f4xx_hal_conf-h

<docs-expose>

HAL 的用户配置文件,用来对 HAL 库进行裁剪.通过预编译的条件宏来决定是否使用 HAL 库的功能,无需修改库函数的源码,通过使能/不使能一些宏来实现库函数的裁剪

HAL 库中本身没有这个文件,可以自行定义,也可以直接使用 `Inc` 文 件 夹 下 stm32f4xx_hal_conf_template.h 的内容作为参考模版

</docs-expose>

## stm32f4xx_hal_def-h

<docs-expose>

通用 HAL 库资源定义,包含 HAL 的通用数据类型定义,声明,枚举,结构体和宏定义.如 HAL 函数操作结果返回值类型 HAL_StatusTypeDef 就是在这个文件中定义的

</docs-expose>

## stm32f4xx_hal_cortex-h

<docs-expose>

它是一些 Cortex 内核通用函数声明和定义,例如中断优先级 NVIC 配置,系统软复位以及 Systick 配置等,与前面 core_cm4.h 的功能类似

</docs-expose>

## stm32f4xx_hal_ppp-h

<docs-expose>

外设驱动函数.对于所有的 STM32 该驱动名称都相同,ppp 代表一类外设,包含该外设的操作 API 函数.例如:当 ppp 为 adc 时,那么这个文件就是 stm32f4xx_hal_adc.c/h,可以分别在 Src/Inc 目录下找到.其中 stm32f4xx_hal_cortex.c/.h 比较特殊,它是一些 Cortex 内核通用函数声明和定义,例如中断优先级 NVIC 配置,MPU,系统软复位以及 Systick 配置等

</docs-expose>

## stm32f4xx_hal_ppp_ex-h

<docs-expose>

外设特殊功能的 API 文件,作为标准外设驱动的功能补充和扩展.针对部分型号才有的特殊外设作功能扩展,或外设的实现功能与标准方式完全不同的情况下作重新初始化的备用接口.ppp 的含义同标准外设驱动

</docs-expose>

## stm32f4xx_II_ppp-h

<docs-expose>

LL 库文件,在一些复杂外设中实现底层功能,在部分 stm32f4xx_hal_ppp.c 中被调用

</docs-expose>
