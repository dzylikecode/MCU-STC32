# HAL

- require "HAL-file-structure"

Hardware Abstraction Layer

## CMSIS 标准

软件接口标准化的标准 CMSIS(Cortex Microcon troller Software Interface Standard)

![](assets/2023-08-14-16-13-18.png)

## file structure

- Drivers
  - @BSP
  - @CMSIS
    - @Core
    - @Core_A
    - @Device
      - @stm32f4xx-h
      - @stm32f407xx-h
      - @system_stm32f4xx-h / system_stm32f4xx-c
      - @startup_stm32f407xx-s
    - @DSP
    - @Include
    - @Lib
    - @NN
    - @RTOS
    - @RTOS2
  - @STM32F4xx_HAL_Driver
    - @stm32f4xx_hal-h / stm32f4xx_hal-c
    - @stm32f4xx_hal_conf-h
    - @stm32f4xx_hal_def-h
    - @stm32f4xx_hal_cortex-h / stm32f4xx_hal_cortex-c
    - @stm32f4xx_hal_ppp-h / stm32f4xx_hal_ppp-c
    - @stm32f4xx_hal_ppp_ex-h / stm32f4xx_hal_ppp_ex-c
    - @stm32f4xx_II_ppp-h / stm32f4xx_II_ppp-c
- Middlewares
  - ST
    - @STM32_USB_Device_Library
    - @STM32_USB_Host_Library
    - @STemWin
  - Third_Party
    - @FatFs
    - @FreeRTOS
    - @LibJPEG
    - @LwIP
- @Utilities

?> platformio 的 framework 有这些文件

## API

| 文件名           | stm32f4xx_hal_ppp (c/h)                            | stm32f4xx_hal_ppp_ex (c/h)                             |
| ---------------- | -------------------------------------------------- | ------------------------------------------------------ |
| 函数名           | HAL_PPP_Function <br> HAL_PPP_FeatureFunction_MODE | HAL_PPPEx_Function <br> HAL_PPPEx_FeatureFunction_MODE |
| 外设句柄         | PPP_HandleTypedef                                  | -                                                      |
| 初始化参数结构体 | PPP_InitTypeDef                                    | PPP_InitTypeDef                                        |
| 枚举类型         | HAL_PPP_StructnameTypeDef                          | -                                                      |

对于 HAL 的 API 函数,常见的有以下几种:

- 初始化/反初始化函数:HAL_PPP_Init(), HAL_PPP_DeInit()
- 外 设 读 写 函 数 :HAL_PPP_Read(),HAL_PPP_Write(),HAL_PPP_Transmit(), HAL_PPP_Receive()
- 控制函数:HAL_PPP_Set (), HAL_PPP_Get ().
- 状态和错误:HAL_PPP_GetState (), HAL_PPP_GetError ().

### 参数

- 配置和初始化用的结构体:

  一般为 PPP_InitTypeDef 或 PPP_ConfTypeDef 的结构体类型,根据外设的寄存器设计成易于理解和记忆的结构体成员.

- 特殊处理的结构体

  专为不同外设而设置的,带有"Process"的字样,实现一些特异化的中间处理操作等.

- 外设句柄结构体

  HAL 驱动的重要参数,可以同时定义多个句柄结构以支持多外设多模式.HAL 驱动的操作结果也可以通过这个句柄获得.

### 外设操作的宏定义

| Macro Definition                                      | Usage                                                     |
| ----------------------------------------------------- | --------------------------------------------------------- |
| `__HAL_PPP_ENABLE_IT(__HANDLE__, __INTERRUPT__)`      | Enables the specified peripheral interrupt.               |
| `__HAL_PPP_DISABLE_IT(__HANDLE__,__INTERRUPT__)`      | Disables the specified peripheral interrupt.              |
| `__HAL_PPP_GET_IT (__HANDLE__, __INTERRUPT__)`        | Gets the specified peripheral interrupt.                  |
| `__HAL_PPP_CLEAR_IT (__HANDLE__, __INTERRUPT__)`      | Clears the specified peripheral interrupt.                |
| `__HAL_PPP_GET_FLAG (__HANDLE__, __FLAG__)`           | Gets the specified peripheral flag.                       |
| `__HAL_PPP_CLEAR_FLAG (__HANDLE__, __FLAG__)`         | Clears the specified peripheral flag.                     |
| `__HAL_PPP_ENABLE(__HANDLE__)`                        | Enables the specified peripheral.                         |
| `__HAL_PPP_DISABLE(__HANDLE__)`                       | Disables the specified peripheral.                        |
| `__HAL_PPP_XXXX (__HANDLE__, __PARAM__)`              | Performs a special operation on the specified peripheral. |
| `__HAL_PPP_GET_IT_SOURCE (__HANDLE__, __INTERRUPT__)` | Checks the specified peripheral interrupt source.         |

对于 SYSTICK/NVIC/RCC/FLASH/GPIO 这些内核外设或共享资源,不使用
`PPP_HandleTypedef` 这类外设句柄进行控制,如:`HAL_GPIO_Init()`只需要初始化的 GPIO 编号和具体的初始化参数

### 回调函数

| 回调函数                          | 举例                                                                                                                                                 |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `HAL_PPP_MspInit()` / `_DeInit()` | 举例: `HAL_USART_MspInit()`<br>由 `HAL_PPP_Init()` 这个 API 调用，主要在这个函数中实现外设对应的 GPIO、时钟、DMA 和中断开启的配置和操作。            |
| `HAL_PPP_ProcessCpltCallback`     | 举例: `HAL_USART_TxCpltCallback`<br>由外设中断或 DMA 中断调用，调用时 API 内部已经实现中断标记的清除的操作，用户只需要专注于自己的软件功能实现即可。 |
| `HAL_PPP_ErrorCallback`           | 举例: `HAL_USART_ErrorCallback`<br>外设或 DMA 中断中发生的错误，用于作错误处理。                                                                     |

## 注意事项

1. 即使 HAL 库目前较以前已经相对更完善了, 要有怀疑精神,辩证地去使用好这个工具
2. 尽量使用开发学习时已经测试稳定的 HAL 库
