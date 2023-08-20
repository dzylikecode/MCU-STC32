# 跑马灯

## 功能

LED 灯:LED0 和 LED1 每过 500ms 一次交替闪烁,实现类似跑马灯的效果

## 硬件

- LED0 – PF9
- LED1 – PF10

> 硬件到软件的映射

## code

```c
void HAL_GPIO_WritePin(GPIO_TypeDef *GPIOx, uint16_t GPIO_Pin, GPIO_PinState PinState);
void HAL_GPIO_TogglePin(GPIO_TypeDef *GPIOx, uint16_t GPIO_Pin);
```

优雅:

```c
#define TurnOnLED(x) \
  HAL_GPIO_WritePin(LED##x##_GPIO_Port, LED##x##_Pin, GPIO_PIN_SET)
#define TurnOffLED(x) \
  HAL_GPIO_WritePin(LED##x##_GPIO_Port, LED##x##_Pin, GPIO_PIN_RESET)
#define ToggleLED(x) HAL_GPIO_TogglePin(LED##x##_GPIO_Port, LED##x##_Pin)
```

改动文件:

- main.c
