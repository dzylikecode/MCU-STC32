# MCU-STM32

## development environment

You need to download three parts for everything to work:[^everything]

- [GCC compiler for ARM](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads) [^stack gcc] [^apache]

  ```bash
  sudo apt-get install gcc-arm-none-eabi
  ```

- [STM32 firmware files](https://www.st.com/en/embedded-software/stm32-standard-peripheral-library-expansion.html?querycriteria=productId=LN1734)
- [St-link utility](https://github.com/texane/stlink/releases/tag/v1.5.1)

  看硬件, 替换成相应硬件的驱动

  [ARMmbed/DAPLink](https://github.com/ARMmbed/DAPLink)

## sample

## References

1. [-everything] [Everything you need to start | STM32 development on Linux](https://www.instructables.com/Start-Developing-STM32-on-Linux/)
2. [stm32-development-in-linux](https://github.com/bus710/stm32-development-in-linux)
3. [Help Starting STM32 Development on Linux](https://www.reddit.com/r/embedded/comments/9y02yo/help_starting_stm32_development_on_linux/)
4. [STM32 EcoSystem (Development Environment) Setup](https://deepbluembedded.com/stm32-ecosystem-development-environment-setup/)
5. [-stack gcc] [qt - what is arm-linux-gcc and how to install this in ubuntu - Stack Overflow](https://stackoverflow.com/questions/11118051/what-is-arm-linux-gcc-and-how-to-install-this-in-ubuntu)
6. [-apache] [Installing the Cross Tools for ARM — Apache Mynewt latest documentation](https://mynewt.apache.org/latest/get_started/native_install/cross_tools.html#id3)
7. [-simple proj] [Embedded_videos/001_FirstSetup at master · prtzl/Embedded_videos · GitHub](https://github.com/prtzl/Embedded_videos/tree/master/001_FirstSetup)
