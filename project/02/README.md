# 按键

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

```c
GPIO_PinState HAL_GPIO_ReadPin(GPIO_TypeDef *GPIOx, uint16_t GPIO_Pin);
```

通过`keyHasDown`消除多次连续按下

改动文件:

- main.c
