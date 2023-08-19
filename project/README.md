# project

## set up

1. StmCubeMx 生成配置代码, 保留`*.ioc`文件
2. PlatformIO 创建基本项目, 保留`platformio.ini`文件

其他诸如`.vscode/`等可以加入 ignore 规则, 在自己利用 PlatformIO 生成配置

保留核心的:

- `platformio.ini`
- `*.ioc`
- `*.c`/`*.h`

ini 文件配置

```ini
[env:black_f407zg]
platform = ststm32
board = black_f407zg
framework = stm32cube
```

需要仿真器调试的 ini 配置

```ini
; PlatformIO Project Configuration File
;
;   Build options: build flags, source filter
;   Upload options: custom upload port, speed and extra flags
;   Library options: dependencies, extra library storages
;   Advanced options: extra scripting
;
; Please visit documentation for the other options and examples
; https://docs.platformio.org/page/projectconf.html

[env:black_f407zg]
platform = ststm32
board = black_f407zg
framework = stm32cube
upload_protocol = stlink
debug_tool  = stlink
```

?> 写代码尽量在注释的 begin 与 end 中间, 这些部分的代码不会被 cubeMX 重新生成的时候擦除
