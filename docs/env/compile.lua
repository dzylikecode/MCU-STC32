ProjectName = "TestProject"
-- 设置工具链
toolchain("arm-none-eabi")
    set_kind("standalone")
    set_sdkdir("D:/gcc-arm-none-eabi-10.3")
toolchain_end()

-- 设置编译目标
target(ProjectName)
    -- 设置生成的文件名称
    set_filename(ProjectName ..".elf")
    -- 设置编译链
    set_toolchains("arm-none-eabi")
    -- 生成二进制文件
    set_kind("binary")
    -- 启用所有警告
    set_warnings("all")
    -- 禁用优化
    set_optimize("none")
    -- 设置编译文件的目录
    set_targetdir("build")
    -- 设置源文件位置
    add_files(
        "./Core/Src/*.c",
        "./startup_stm32f407xx.s",
        "./Drivers/STM32F4xx_HAL_Driver/Src/*.c"
    )
    -- 移除模板文件
    remove_files(
        "./Drivers/STM32F4xx_HAL_Driver/Src/*_template.c"
    )
    -- 设置头文件搜索路径
    add_includedirs(
        "./Core/Inc",
        "./Drivers/CMSIS/Include",
        "./Drivers/CMSIS/Device/ST/STM32F4xx/Include",
        "./Drivers/STM32F4xx_HAL_Driver/Inc",
        "./Drivers/STM32F4xx_HAL_Driver/Inc/Legacy"
    )
    -- 添加宏定义
    add_defines(
        "USE_HAL_DRIVER",
        "STM32F407xx"
    )
    -- 设置C编译参数
    add_cflags(
        "-mcpu=cortex-m4",
        "-mthumb",
        "-mfloat-abi=hard -mfpu=fpv4-sp-d16",
        "-fdata-sections -ffunction-sections",
        "-g -gdwarf-2",
        { force = true }
    )
    -- 设置汇编编译参数
    add_asflags(
        "-mcpu=cortex-m4",
        "-mthumb",
        "-mfloat-abi=hard -mfpu=fpv4-sp-d16",
        "-fdata-sections -ffunction-sections",
        { force = true }
    )
    -- 设置链接参数
    local MapCMD = "-Wl,-Map=" .. ProjectName .. ".map,--cref"
    add_ldflags(
        "-mcpu=cortex-m4",
        "-mthumb",
        "-mfloat-abi=hard -mfpu=fpv4-sp-d16",
        "-specs=nano.specs",
        "-TSTM32F407VGTx_FLASH.ld",
        "-Wl,--gc-sections",
        MapCMD,
        { force = true }
    )
target_end()

after_build(function(target)
    os.exec("arm-none-eabi-objcopy -O ihex ./build//TestProject.elf ./build//TestProject.hex")
    os.exec("arm-none-eabi-objcopy -O binary ./build//TestProject.elf ./build//TestProject.bin")
    print("生成已完成!")
    print("********************储存空间占用情况*****************************")
    os.exec("arm-none-eabi-size -Bd ./build/TestProject.elf")
    print("****************************************************************")
end)

task("flash")
    on_run(function ()
        os.exec("openocd -f jlink.cfg -f stm32f4x.cfg -c 'program Build/TestProject.hex verify reset exit'")
    end)
    -- 设置插件的命令行选项
    set_menu {
        -- 设置菜单用法
        usage = "xmake flash",

        -- 设置菜单描述
         description = "Download the flash",

        -- 设置菜单选项，如果没有选项，可以设置为{}
           options ={}
    }
task_end()