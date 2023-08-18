# MCU-STM32

戒骄戒躁, 勤思敏行

- [意法半导体 STM32/STM8 技术社区 - 提供最新的 ST 资讯和技术交流](https://www.stmcu.org.cn/)
- [STMicroelectronics: Our technology starts with you](https://www.st.com/content/st_com/en.html)
- [正点原子资料下载中心 — 正点原子资料下载中心 1.0.0 文档](http://www.openedv.com/docs/index.html)

## env

- [Getting Started with PlatformIO | STM32-base project](https://stm32-base.org/guides/platformio.html)
- [What is PlatformIO? — PlatformIO latest documentation](https://docs.platformio.org/en/latest/what-is-platformio.html)
- [使用 VSCode+PlatformIO+HAL+CubeMX+正点原子库开发 STM32F407ZGT6_vscode 外星人插件\_Kenyon_Lv 的博客-CSDN 博客](https://blog.csdn.net/qq_36807337/article/details/123030937)
- [野火多功能调试助手上位机 — 野火产品资料下载中心 文档](https://doc.embedfire.com/products/link/zh/latest/deskapp/ebf_trace_tool.html)

## timeline

- 2023-03-11: 想着研究 stm32
- 2023-03-13: 下载 gcc 编译器
- 2023-08-12: 放弃 xmake, 采用 platformio

不要什么都自己改写, 学会利用别人的成果, 完成自己想要干的事情

## issue

注意运行程序的时候, B1, B0 为 0, 0, 否则会进入系统存储器启动, 无法运行程序

---

[Use platformio.ini values in #define macro - General Discussion - PlatformIO Community](https://community.platformio.org/t/use-platformio-ini-values-in-define-macro/10117)

[c - Unknown datatypes IRQn_Type, - Stack Overflow](https://stackoverflow.com/questions/56489064/unknown-datatypes-irqn-type)

把`sys.h`里面的`#include "core_cm4.h"`注释掉

## todo

采用之前的 ref 的形式, 压缩信息

先快速过一遍 pdf, 用笔写, 然后将 pdf 转化为 word,选取其中的内容进行编写, 加深自己的理解

[PDF to WORD | Convert PDF to Word online for free](https://www.ilovepdf.com/pdf_to_word)

[深入 C++ 回调 | BOT Man JL](https://bot-man-jl.github.io/articles/?post=2019/Inside-Cpp-Callback)
