# 外部中断

## function

四个独立按键控制 LED 灯:KEY0 控制 LED0 翻转,KEY1 控制 LED1 翻
转,KEY2 控制 LED0,LED1 同时翻转,KEY_UP 控制蜂鸣器翻转

## hardware

- LED 灯
  - LED0 – PF9
  - LED1 – PF10
- 独立按键
  - KEY0 – PE4
  - KEY1 – PE3
  - KEY2 – PE2
  - KEY_UP– PA0(程序中的宏名:WK_UP)
- 蜂鸣器
  - BEEP – PF8

KEY_UP 则需要采样到高电平才为按键有效,并且按键外部没有上下拉电阻,所以需要在 STM32F407 内部设置上下拉

- LED 配置为输出
- KEY 配置为输入

## code

改动文件:

- main.c

不需要改动 `stm32f4xx_it.c`, 只需要写完成`HAL_GPIO_EXTI_Callback`函数

```c
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin);
```

## issue

一开始还是犯了错, 在中断里面用了`HAL_Delay`, 导致卡死

```c
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin) {
  // ! can't use HAL_Delay here for debounce
  // HAL_Delay(20);
  switch (GPIO_Pin) {
    case KEY_UP_Pin:
      if (IsDownKeyUP()) {
        ToggleBeep();
      }
      break;
    case KEY0_Pin:
      if (IsDownKey0()) {
        ToggleLED(0);
      }
      break;
    case KEY1_Pin:
      if (IsDownKey1()) {
        ToggleLED(1);
      }
      break;
    case KEY2_Pin:
      if (IsDownKey2()) {
        ToggleLED(0);
        ToggleLED(1);
      }
      break;
    default:
      break;
  }
  __HAL_GPIO_EXTI_CLEAR_IT(GPIO_Pin);  // clear interrupt flag in case of bounce
}
```

---

beep 按键不是很灵敏, 但是上个程序挺好的

> 原因是, KEY_UP 按下去是上升沿, 应该配置上升沿触发, 而之前配置了下降沿触发

还是需要对硬件的原理有些了解去配置
