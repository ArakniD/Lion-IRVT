;***************************************************************
;* TMS320C2000 G3 C/C++ Codegen                               PC v20.2.4.LTS *
;* Date/Time created: Tue Mar  2 07:24:44 2021                 *
;***************************************************************
	.compiler_opts --abi=eabi --cla_support=cla1 --diag_wrap=off --float_support=fpu32 --hll_source=on --mem_model:code=flat --mem_model:data=large --object_format=elf --quiet --silicon_errata_fpu1_workaround=off --silicon_version=28 --symdebug:dwarf --symdebug:dwarf_version=4 --tmu_support=tmu0 --vcu_support=vcu2 
	.asg	XAR2, FP

$C$DW$CU	.dwtag  DW_TAG_compile_unit
	.dwattr $C$DW$CU, DW_AT_name("../bts_hal.c")
	.dwattr $C$DW$CU, DW_AT_producer("TI TMS320C2000 G3 C/C++ Codegen PC v20.2.4.LTS Copyright (c) 1996-2018 Texas Instruments Incorporated")
	.dwattr $C$DW$CU, DW_AT_TI_version(0x01)
	.dwattr $C$DW$CU, DW_AT_comp_dir("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\release")

$C$DW$1	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$1, DW_AT_name("Device_init")
	.dwattr $C$DW$1, DW_AT_linkage_name("Device_init")
	.dwattr $C$DW$1, DW_AT_declaration
	.dwattr $C$DW$1, DW_AT_external
	.dwattr $C$DW$1, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/device/device.h")
	.dwattr $C$DW$1, DW_AT_decl_line(0x103)
	.dwattr $C$DW$1, DW_AT_decl_column(0x0d)
	.dwendtag $C$DW$1


$C$DW$2	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$2, DW_AT_name("Device_initGPIO")
	.dwattr $C$DW$2, DW_AT_linkage_name("Device_initGPIO")
	.dwattr $C$DW$2, DW_AT_declaration
	.dwattr $C$DW$2, DW_AT_external
	.dwattr $C$DW$2, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/device/device.h")
	.dwattr $C$DW$2, DW_AT_decl_line(0x11a)
	.dwattr $C$DW$2, DW_AT_decl_column(0x0d)
	.dwendtag $C$DW$2


$C$DW$3	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$3, DW_AT_name("Interrupt_initModule")
	.dwattr $C$DW$3, DW_AT_linkage_name("Interrupt_initModule")
	.dwattr $C$DW$3, DW_AT_declaration
	.dwattr $C$DW$3, DW_AT_external
	.dwattr $C$DW$3, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h")
	.dwattr $C$DW$3, DW_AT_decl_line(0x1dd)
	.dwattr $C$DW$3, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$3


$C$DW$4	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$4, DW_AT_name("Interrupt_initVectorTable")
	.dwattr $C$DW$4, DW_AT_linkage_name("Interrupt_initVectorTable")
	.dwattr $C$DW$4, DW_AT_declaration
	.dwattr $C$DW$4, DW_AT_external
	.dwattr $C$DW$4, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h")
	.dwattr $C$DW$4, DW_AT_decl_line(0x1e8)
	.dwattr $C$DW$4, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$4


$C$DW$5	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$5, DW_AT_name("CPUTimer_setEmulationMode")
	.dwattr $C$DW$5, DW_AT_linkage_name("CPUTimer_setEmulationMode")
	.dwattr $C$DW$5, DW_AT_declaration
	.dwattr $C$DW$5, DW_AT_external
	.dwattr $C$DW$5, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h")
	.dwattr $C$DW$5, DW_AT_decl_line(0x1e0)
	.dwattr $C$DW$5, DW_AT_decl_column(0x0d)
$C$DW$6	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$6, DW_AT_type(*$C$DW$T$95)

$C$DW$7	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$7, DW_AT_type(*$C$DW$T$29)

	.dwendtag $C$DW$5


$C$DW$8	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$8, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$8, DW_AT_linkage_name("SysCtl_delay")
	.dwattr $C$DW$8, DW_AT_declaration
	.dwattr $C$DW$8, DW_AT_external
	.dwattr $C$DW$8, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$8, DW_AT_decl_line(0xc00)
	.dwattr $C$DW$8, DW_AT_decl_column(0x01)
$C$DW$9	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$9, DW_AT_type(*$C$DW$T$95)

	.dwendtag $C$DW$8


$C$DW$10	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$10, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$10, DW_AT_linkage_name("GPIO_setPinConfig")
	.dwattr $C$DW$10, DW_AT_declaration
	.dwattr $C$DW$10, DW_AT_external
	.dwattr $C$DW$10, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$10, DW_AT_decl_line(0x401)
	.dwattr $C$DW$10, DW_AT_decl_column(0x01)
$C$DW$11	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$11, DW_AT_type(*$C$DW$T$95)

	.dwendtag $C$DW$10


$C$DW$12	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$12, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$12, DW_AT_linkage_name("GPIO_setDirectionMode")
	.dwattr $C$DW$12, DW_AT_declaration
	.dwattr $C$DW$12, DW_AT_external
	.dwattr $C$DW$12, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$12, DW_AT_decl_line(0x325)
	.dwattr $C$DW$12, DW_AT_decl_column(0x01)
$C$DW$13	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$13, DW_AT_type(*$C$DW$T$95)

$C$DW$14	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$14, DW_AT_type(*$C$DW$T$63)

	.dwendtag $C$DW$12


$C$DW$15	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$15, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$15, DW_AT_linkage_name("GPIO_setQualificationMode")
	.dwattr $C$DW$15, DW_AT_declaration
	.dwattr $C$DW$15, DW_AT_external
	.dwattr $C$DW$15, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$15, DW_AT_decl_line(0x395)
	.dwattr $C$DW$15, DW_AT_decl_column(0x01)
$C$DW$16	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$16, DW_AT_type(*$C$DW$T$95)

$C$DW$17	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$17, DW_AT_type(*$C$DW$T$65)

	.dwendtag $C$DW$15


$C$DW$18	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$18, DW_AT_name("GPIO_setInterruptPin")
	.dwattr $C$DW$18, DW_AT_linkage_name("GPIO_setInterruptPin")
	.dwattr $C$DW$18, DW_AT_declaration
	.dwattr $C$DW$18, DW_AT_external
	.dwattr $C$DW$18, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$18, DW_AT_decl_line(0x353)
	.dwattr $C$DW$18, DW_AT_decl_column(0x01)
$C$DW$19	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$19, DW_AT_type(*$C$DW$T$95)

$C$DW$20	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$20, DW_AT_type(*$C$DW$T$59)

	.dwendtag $C$DW$18


$C$DW$21	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$21, DW_AT_name("GPIO_setAnalogMode")
	.dwattr $C$DW$21, DW_AT_linkage_name("GPIO_setAnalogMode")
	.dwattr $C$DW$21, DW_AT_declaration
	.dwattr $C$DW$21, DW_AT_external
	.dwattr $C$DW$21, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$21, DW_AT_decl_line(0x3ec)
	.dwattr $C$DW$21, DW_AT_decl_column(0x01)
$C$DW$22	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$22, DW_AT_type(*$C$DW$T$95)

$C$DW$23	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$23, DW_AT_type(*$C$DW$T$69)

	.dwendtag $C$DW$21


$C$DW$24	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$24, DW_AT_name("GPIO_setPadConfig")
	.dwattr $C$DW$24, DW_AT_linkage_name("GPIO_setPadConfig")
	.dwattr $C$DW$24, DW_AT_declaration
	.dwattr $C$DW$24, DW_AT_external
	.dwattr $C$DW$24, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$24, DW_AT_decl_line(0x36e)
	.dwattr $C$DW$24, DW_AT_decl_column(0x01)
$C$DW$25	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$25, DW_AT_type(*$C$DW$T$95)

$C$DW$26	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$26, DW_AT_type(*$C$DW$T$95)

	.dwendtag $C$DW$24


$C$DW$27	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$27, DW_AT_name("EPWM_setEmulationMode")
	.dwattr $C$DW$27, DW_AT_linkage_name("EPWM_setEmulationMode")
	.dwattr $C$DW$27, DW_AT_declaration
	.dwattr $C$DW$27, DW_AT_external
	.dwattr $C$DW$27, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$27, DW_AT_decl_line(0x1cb0)
	.dwattr $C$DW$27, DW_AT_decl_column(0x01)
$C$DW$28	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$28, DW_AT_type(*$C$DW$T$95)

$C$DW$29	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$29, DW_AT_type(*$C$DW$T$57)

	.dwendtag $C$DW$27


$C$DW$30	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$30, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$30, DW_AT_linkage_name("GPIO_setMasterCore")
	.dwattr $C$DW$30, DW_AT_declaration
	.dwattr $C$DW$30, DW_AT_external
	.dwattr $C$DW$30, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$30, DW_AT_decl_line(0x3d1)
	.dwattr $C$DW$30, DW_AT_decl_column(0x01)
$C$DW$31	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$31, DW_AT_type(*$C$DW$T$95)

$C$DW$32	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$32, DW_AT_type(*$C$DW$T$67)

	.dwendtag $C$DW$30


$C$DW$33	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$33, DW_AT_name("I2C_initMaster")
	.dwattr $C$DW$33, DW_AT_linkage_name("I2C_initMaster")
	.dwattr $C$DW$33, DW_AT_declaration
	.dwattr $C$DW$33, DW_AT_external
	.dwattr $C$DW$33, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$33, DW_AT_decl_line(0x47a)
	.dwattr $C$DW$33, DW_AT_decl_column(0x01)
$C$DW$34	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$34, DW_AT_type(*$C$DW$T$95)

$C$DW$35	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$35, DW_AT_type(*$C$DW$T$95)

$C$DW$36	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$36, DW_AT_type(*$C$DW$T$95)

$C$DW$37	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$37, DW_AT_type(*$C$DW$T$91)

	.dwendtag $C$DW$33


$C$DW$38	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$38, DW_AT_name("I2C_clearInterruptStatus")
	.dwattr $C$DW$38, DW_AT_linkage_name("I2C_clearInterruptStatus")
	.dwattr $C$DW$38, DW_AT_declaration
	.dwattr $C$DW$38, DW_AT_external
	.dwattr $C$DW$38, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$38, DW_AT_decl_line(0x4e5)
	.dwattr $C$DW$38, DW_AT_decl_column(0x01)
$C$DW$39	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$39, DW_AT_type(*$C$DW$T$95)

$C$DW$40	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$40, DW_AT_type(*$C$DW$T$95)

	.dwendtag $C$DW$38


$C$DW$41	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$41, DW_AT_name("I2C_enableInterrupt")
	.dwattr $C$DW$41, DW_AT_linkage_name("I2C_enableInterrupt")
	.dwattr $C$DW$41, DW_AT_declaration
	.dwattr $C$DW$41, DW_AT_external
	.dwattr $C$DW$41, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$41, DW_AT_decl_line(0x49b)
	.dwattr $C$DW$41, DW_AT_decl_column(0x01)
$C$DW$42	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$42, DW_AT_type(*$C$DW$T$95)

$C$DW$43	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$43, DW_AT_type(*$C$DW$T$95)

	.dwendtag $C$DW$41


$C$DW$44	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$44, DW_AT_name("Interrupt_enable")
	.dwattr $C$DW$44, DW_AT_linkage_name("Interrupt_enable")
	.dwattr $C$DW$44, DW_AT_declaration
	.dwattr $C$DW$44, DW_AT_external
	.dwattr $C$DW$44, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h")
	.dwattr $C$DW$44, DW_AT_decl_line(0x1fb)
	.dwattr $C$DW$44, DW_AT_decl_column(0x01)
$C$DW$45	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$45, DW_AT_type(*$C$DW$T$95)

	.dwendtag $C$DW$44


$C$DW$46	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$46, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$46, DW_AT_linkage_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$46, DW_AT_declaration
	.dwattr $C$DW$46, DW_AT_external
	.dwattr $C$DW$46, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$46, DW_AT_decl_line(0x50f)
	.dwattr $C$DW$46, DW_AT_decl_column(0x01)
$C$DW$47	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$47, DW_AT_type(*$C$DW$T$95)

$C$DW$48	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$48, DW_AT_type(*$C$DW$T$95)

	.dwendtag $C$DW$46


$C$DW$49	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$49, DW_AT_name("ISR1")
	.dwattr $C$DW$49, DW_AT_linkage_name("ISR1")
	.dwattr $C$DW$49, DW_AT_declaration
	.dwattr $C$DW$49, DW_AT_external
	.dwattr $C$DW$49, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$49, DW_AT_decl_line(0x68)
	.dwattr $C$DW$49, DW_AT_decl_column(0x12)
	.dwendtag $C$DW$49


$C$DW$50	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$50, DW_AT_name("ISR2")
	.dwattr $C$DW$50, DW_AT_linkage_name("ISR2")
	.dwattr $C$DW$50, DW_AT_declaration
	.dwattr $C$DW$50, DW_AT_external
	.dwattr $C$DW$50, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$50, DW_AT_decl_line(0x69)
	.dwattr $C$DW$50, DW_AT_decl_column(0x12)
	.dwendtag $C$DW$50


$C$DW$51	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$51, DW_AT_name("ISR3")
	.dwattr $C$DW$51, DW_AT_linkage_name("ISR3")
	.dwattr $C$DW$51, DW_AT_declaration
	.dwattr $C$DW$51, DW_AT_external
	.dwattr $C$DW$51, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$51, DW_AT_decl_line(0x6a)
	.dwattr $C$DW$51, DW_AT_decl_column(0x12)
	.dwendtag $C$DW$51


$C$DW$52	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$52, DW_AT_name("ISR4")
	.dwattr $C$DW$52, DW_AT_linkage_name("ISR4")
	.dwattr $C$DW$52, DW_AT_declaration
	.dwattr $C$DW$52, DW_AT_external
	.dwattr $C$DW$52, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$52, DW_AT_decl_line(0x6b)
	.dwattr $C$DW$52, DW_AT_decl_column(0x12)
	.dwendtag $C$DW$52


$C$DW$53	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$53, DW_AT_name("i2cAISR")
	.dwattr $C$DW$53, DW_AT_linkage_name("i2cAISR")
	.dwattr $C$DW$53, DW_AT_declaration
	.dwattr $C$DW$53, DW_AT_external
	.dwattr $C$DW$53, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$53, DW_AT_decl_line(0x71)
	.dwattr $C$DW$53, DW_AT_decl_column(0x12)
	.dwendtag $C$DW$53


$C$DW$54	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$54, DW_AT_name("i2cBISR")
	.dwattr $C$DW$54, DW_AT_linkage_name("i2cBISR")
	.dwattr $C$DW$54, DW_AT_declaration
	.dwattr $C$DW$54, DW_AT_external
	.dwattr $C$DW$54, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$54, DW_AT_decl_line(0x74)
	.dwattr $C$DW$54, DW_AT_decl_column(0x12)
	.dwendtag $C$DW$54


$C$DW$55	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$55, DW_AT_name("i2cAFIFOISR")
	.dwattr $C$DW$55, DW_AT_linkage_name("i2cAFIFOISR")
	.dwattr $C$DW$55, DW_AT_declaration
	.dwattr $C$DW$55, DW_AT_external
	.dwattr $C$DW$55, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$55, DW_AT_decl_line(0x72)
	.dwattr $C$DW$55, DW_AT_decl_column(0x12)
	.dwendtag $C$DW$55


$C$DW$56	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$56, DW_AT_name("i2cBFIFOISR")
	.dwattr $C$DW$56, DW_AT_linkage_name("i2cBFIFOISR")
	.dwattr $C$DW$56, DW_AT_declaration
	.dwattr $C$DW$56, DW_AT_external
	.dwattr $C$DW$56, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$56, DW_AT_decl_line(0x75)
	.dwattr $C$DW$56, DW_AT_decl_column(0x12)
	.dwendtag $C$DW$56


$C$DW$57	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$57, DW_AT_name("SPI_setConfig")
	.dwattr $C$DW$57, DW_AT_linkage_name("SPI_setConfig")
	.dwattr $C$DW$57, DW_AT_declaration
	.dwattr $C$DW$57, DW_AT_external
	.dwattr $C$DW$57, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$57, DW_AT_decl_line(0x48a)
	.dwattr $C$DW$57, DW_AT_decl_column(0x01)
$C$DW$58	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$58, DW_AT_type(*$C$DW$T$95)

$C$DW$59	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$59, DW_AT_type(*$C$DW$T$95)

$C$DW$60	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$60, DW_AT_type(*$C$DW$T$103)

$C$DW$61	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$61, DW_AT_type(*$C$DW$T$105)

$C$DW$62	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$62, DW_AT_type(*$C$DW$T$95)

$C$DW$63	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$63, DW_AT_type(*$C$DW$T$20)

	.dwendtag $C$DW$57


$C$DW$64	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$64, DW_AT_name("SPI_enableInterrupt")
	.dwattr $C$DW$64, DW_AT_linkage_name("SPI_enableInterrupt")
	.dwattr $C$DW$64, DW_AT_declaration
	.dwattr $C$DW$64, DW_AT_external
	.dwattr $C$DW$64, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$64, DW_AT_decl_line(0x4c4)
	.dwattr $C$DW$64, DW_AT_decl_column(0x01)
$C$DW$65	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$65, DW_AT_type(*$C$DW$T$95)

$C$DW$66	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$66, DW_AT_type(*$C$DW$T$95)

	.dwendtag $C$DW$64

	.global	||BTS_ExAdcRxflag1||
	.bss	||BTS_ExAdcRxflag1||,1,1,0
$C$DW$67	.dwtag  DW_TAG_variable
	.dwattr $C$DW$67, DW_AT_name("BTS_ExAdcRxflag1")
	.dwattr $C$DW$67, DW_AT_linkage_name("BTS_ExAdcRxflag1")
	.dwattr $C$DW$67, DW_AT_location[DW_OP_addr ||BTS_ExAdcRxflag1||]
	.dwattr $C$DW$67, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$67, DW_AT_external
	.dwattr $C$DW$67, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$67, DW_AT_decl_line(0x1e)
	.dwattr $C$DW$67, DW_AT_decl_column(0x13)

	.global	||BTS_ExAdcRxflag2||
	.bss	||BTS_ExAdcRxflag2||,1,1,0
$C$DW$68	.dwtag  DW_TAG_variable
	.dwattr $C$DW$68, DW_AT_name("BTS_ExAdcRxflag2")
	.dwattr $C$DW$68, DW_AT_linkage_name("BTS_ExAdcRxflag2")
	.dwattr $C$DW$68, DW_AT_location[DW_OP_addr ||BTS_ExAdcRxflag2||]
	.dwattr $C$DW$68, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$68, DW_AT_external
	.dwattr $C$DW$68, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$68, DW_AT_decl_line(0x1f)
	.dwattr $C$DW$68, DW_AT_decl_column(0x13)


$C$DW$69	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$69, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$69, DW_AT_linkage_name("SysCtl_getClock")
	.dwattr $C$DW$69, DW_AT_type(*$C$DW$T$95)
	.dwattr $C$DW$69, DW_AT_declaration
	.dwattr $C$DW$69, DW_AT_external
	.dwattr $C$DW$69, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$69, DW_AT_decl_line(0xc13)
	.dwattr $C$DW$69, DW_AT_decl_column(0x01)
$C$DW$70	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$70, DW_AT_type(*$C$DW$T$95)

	.dwendtag $C$DW$69


$C$DW$71	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$71, DW_AT_name("__eallow")
	.dwattr $C$DW$71, DW_AT_linkage_name("__eallow")
	.dwattr $C$DW$71, DW_AT_declaration
	.dwattr $C$DW$71, DW_AT_external
	.dwendtag $C$DW$71


$C$DW$72	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$72, DW_AT_name("__edis")
	.dwattr $C$DW$72, DW_AT_linkage_name("__edis")
	.dwattr $C$DW$72, DW_AT_declaration
	.dwattr $C$DW$72, DW_AT_external
	.dwendtag $C$DW$72

	.global	||BTS_ADC1||
	.bss	||BTS_ADC1||,18,1,1
$C$DW$73	.dwtag  DW_TAG_variable
	.dwattr $C$DW$73, DW_AT_name("BTS_ADC1")
	.dwattr $C$DW$73, DW_AT_linkage_name("BTS_ADC1")
	.dwattr $C$DW$73, DW_AT_location[DW_OP_addr ||BTS_ADC1||]
	.dwattr $C$DW$73, DW_AT_type(*$C$DW$T$106)
	.dwattr $C$DW$73, DW_AT_external
	.dwattr $C$DW$73, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$73, DW_AT_decl_line(0x1c)
	.dwattr $C$DW$73, DW_AT_decl_column(0x0b)

	.global	||BTS_ADC2||
	.bss	||BTS_ADC2||,18,1,1
$C$DW$74	.dwtag  DW_TAG_variable
	.dwattr $C$DW$74, DW_AT_name("BTS_ADC2")
	.dwattr $C$DW$74, DW_AT_linkage_name("BTS_ADC2")
	.dwattr $C$DW$74, DW_AT_location[DW_OP_addr ||BTS_ADC2||]
	.dwattr $C$DW$74, DW_AT_type(*$C$DW$T$106)
	.dwattr $C$DW$74, DW_AT_external
	.dwattr $C$DW$74, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$74, DW_AT_decl_line(0x1d)
	.dwattr $C$DW$74, DW_AT_decl_column(0x0b)

	.global	||ePWM||
	.sect	".data:ePWM", RW
	.align	2
	.elfsym	||ePWM||,SYM_SIZE(18)
||ePWM||:
	.bits		0,32
			; ePWM[0] @ 0
	.bits		0x4000,32
			; ePWM[1] @ 32
	.bits		0x4100,32
			; ePWM[2] @ 64
	.bits		0x4200,32
			; ePWM[3] @ 96
	.bits		0x4300,32
			; ePWM[4] @ 128
	.bits		0x4400,32
			; ePWM[5] @ 160
	.bits		0x4500,32
			; ePWM[6] @ 192
	.bits		0x4600,32
			; ePWM[7] @ 224
	.bits		0x4700,32
			; ePWM[8] @ 256

$C$DW$75	.dwtag  DW_TAG_variable
	.dwattr $C$DW$75, DW_AT_name("ePWM")
	.dwattr $C$DW$75, DW_AT_linkage_name("ePWM")
	.dwattr $C$DW$75, DW_AT_location[DW_OP_addr ||ePWM||]
	.dwattr $C$DW$75, DW_AT_type(*$C$DW$T$172)
	.dwattr $C$DW$75, DW_AT_external
	.dwattr $C$DW$75, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$75, DW_AT_decl_line(0x28)
	.dwattr $C$DW$75, DW_AT_decl_column(0x17)

	.sblock	".bss"
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\opt2000.exe C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{AE35D635-013B-417C-A4D7-50835FD4F574} C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{F56C5AC9-F943-4C71-B0D5-C49939E4FA21} 
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\acia2000.exe -@C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{F7C8BE68-8A58-4995-89F0-48044E79518A} 
	.sect	".text"
	.clink
	.global	||delay_ms_2||

$C$DW$76	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$76, DW_AT_name("delay_ms_2")
	.dwattr $C$DW$76, DW_AT_low_pc(||delay_ms_2||)
	.dwattr $C$DW$76, DW_AT_high_pc(0x00)
	.dwattr $C$DW$76, DW_AT_linkage_name("delay_ms_2")
	.dwattr $C$DW$76, DW_AT_external
	.dwattr $C$DW$76, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$76, DW_AT_decl_line(0x15b)
	.dwattr $C$DW$76, DW_AT_decl_column(0x06)
	.dwattr $C$DW$76, DW_AT_TI_max_frame_size(-8)
	.dwpsn	file "../bts_hal.c",line 348,column 1,is_stmt,address ||delay_ms_2||,isa 0

	.dwfde $C$DW$CIE, ||delay_ms_2||
$C$DW$77	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$77, DW_AT_name("delay_time_ms")
	.dwattr $C$DW$77, DW_AT_type(*$C$DW$T$95)
	.dwattr $C$DW$77, DW_AT_location[DW_OP_reg0]


;***************************************************************
;* FNAME: delay_ms_2                    FR SIZE:   6           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  0 Auto,  2 SOE     *
;***************************************************************

||delay_ms_2||:
;* XT    assigned to delay_time_ms
$C$DW$78	.dwtag  DW_TAG_variable
	.dwattr $C$DW$78, DW_AT_name("delay_time_ms")
	.dwattr $C$DW$78, DW_AT_type(*$C$DW$T$156)
	.dwattr $C$DW$78, DW_AT_location[DW_OP_reg21]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -8
        MOVL      XAR1,ACC              ; [CPU_ALU] |348| 
	.dwpsn	file "../bts_hal.c",line 351,column 4,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |351| 
        MOV       AH,#1525              ; [CPU_ALU] |351| 
$C$DW$79	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$79, DW_AT_low_pc(0x00)
	.dwattr $C$DW$79, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$79, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_getClock||] ; [] |351| 
        MOVL      XT,XAR1               ; [CPU_ALU] |351| 
        IMPYXUL   P,XT,ACC              ; [CPU_ALU] |351| 
        MOVL      XAR6,P                ; [CPU_ALU] |351| 
        MOV       AL,#6641              ; [CPU_ALU] |351| 
        MOV       AH,#1398              ; [CPU_ALU] |351| 
        MOVL      XT,ACC                ; [CPU_ALU] |351| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |351| 
        MOV       T,#38                 ; [CPU_FPU] |351| 
        LSR64     ACC:P,T               ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
$C$DW$80	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$80, DW_AT_low_pc(0x00)
	.dwattr $C$DW$80, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$80, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_delay||] ; [] |351| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
        MOVL      XAR1,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$81	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$81, DW_AT_low_pc(0x00)
	.dwattr $C$DW$81, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$76, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$76, DW_AT_TI_end_line(0x161)
	.dwattr $C$DW$76, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$76

	.sect	".text"
	.clink
	.global	||BTS_HAS_setupInterrupt_I2c||

$C$DW$82	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$82, DW_AT_name("BTS_HAS_setupInterrupt_I2c")
	.dwattr $C$DW$82, DW_AT_low_pc(||BTS_HAS_setupInterrupt_I2c||)
	.dwattr $C$DW$82, DW_AT_high_pc(0x00)
	.dwattr $C$DW$82, DW_AT_linkage_name("BTS_HAS_setupInterrupt_I2c")
	.dwattr $C$DW$82, DW_AT_external
	.dwattr $C$DW$82, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$82, DW_AT_decl_line(0x3ad)
	.dwattr $C$DW$82, DW_AT_decl_column(0x06)
	.dwattr $C$DW$82, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 942,column 1,is_stmt,address ||BTS_HAS_setupInterrupt_I2c||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAS_setupInterrupt_I2c||

;***************************************************************
;* FNAME: BTS_HAS_setupInterrupt_I2c    FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAS_setupInterrupt_I2c||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 308,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |308| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 309,column 5,is_stmt,isa 0
        MOVL      XAR4,#||i2cAISR||     ; [CPU_ARAU] |309| 
        MOVL      XAR5,#3504            ; [CPU_ARAU] |309| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |309| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 310,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |310| 
	.dwpsn	file "../bts_hal.c",line 948,column 5,is_stmt,isa 0
        MOV       AL,#2049              ; [CPU_ALU] |948| 
        MOV       AH,#88                ; [CPU_ALU] |948| 
$C$DW$83	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$83, DW_AT_low_pc(0x00)
	.dwattr $C$DW$83, DW_AT_name("Interrupt_enable")
	.dwattr $C$DW$83, DW_AT_TI_call

        LCR       #||Interrupt_enable|| ; [CPU_ALU] |948| 
        ; call occurs [#||Interrupt_enable||] ; [] |948| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 308,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |308| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 309,column 5,is_stmt,isa 0
        MOVL      XAR4,#||i2cBISR||     ; [CPU_ARAU] |309| 
        MOVL      XAR5,#3508            ; [CPU_ARAU] |309| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |309| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 310,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |310| 
	.dwpsn	file "../bts_hal.c",line 951,column 5,is_stmt,isa 0
        MOV       AL,#2051              ; [CPU_ALU] |951| 
        MOV       AH,#90                ; [CPU_ALU] |951| 
$C$DW$84	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$84, DW_AT_low_pc(0x00)
	.dwattr $C$DW$84, DW_AT_name("Interrupt_enable")
	.dwattr $C$DW$84, DW_AT_TI_call

        LCR       #||Interrupt_enable|| ; [CPU_ALU] |951| 
        ; call occurs [#||Interrupt_enable||] ; [] |951| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 308,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |308| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 309,column 5,is_stmt,isa 0
        MOVL      XAR4,#||i2cAFIFOISR|| ; [CPU_ARAU] |309| 
        MOVL      XAR5,#3506            ; [CPU_ARAU] |309| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |309| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 310,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |310| 
	.dwpsn	file "../bts_hal.c",line 954,column 5,is_stmt,isa 0
        MOV       AL,#2050              ; [CPU_ALU] |954| 
        MOV       AH,#89                ; [CPU_ALU] |954| 
$C$DW$85	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$85, DW_AT_low_pc(0x00)
	.dwattr $C$DW$85, DW_AT_name("Interrupt_enable")
	.dwattr $C$DW$85, DW_AT_TI_call

        LCR       #||Interrupt_enable|| ; [CPU_ALU] |954| 
        ; call occurs [#||Interrupt_enable||] ; [] |954| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 308,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |308| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 309,column 5,is_stmt,isa 0
        MOVL      XAR4,#||i2cBFIFOISR|| ; [CPU_ARAU] |309| 
        MOVL      XAR5,#3510            ; [CPU_ARAU] |309| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |309| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 310,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |310| 
	.dwpsn	file "../bts_hal.c",line 957,column 5,is_stmt,isa 0
        MOV       AL,#2052              ; [CPU_ALU] |957| 
        MOV       AH,#91                ; [CPU_ALU] |957| 
$C$DW$86	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$86, DW_AT_low_pc(0x00)
	.dwattr $C$DW$86, DW_AT_name("Interrupt_enable")
	.dwattr $C$DW$86, DW_AT_TI_call

        LCR       #||Interrupt_enable|| ; [CPU_ALU] |957| 
        ; call occurs [#||Interrupt_enable||] ; [] |957| 
$C$DW$87	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$87, DW_AT_low_pc(0x00)
	.dwattr $C$DW$87, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$82, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$82, DW_AT_TI_end_line(0x3be)
	.dwattr $C$DW$82, DW_AT_TI_end_column(0x05)
	.dwendentry
	.dwendtag $C$DW$82

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupSyncBuckPwm||

$C$DW$88	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$88, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$88, DW_AT_low_pc(||BTS_HAL_setupSyncBuckPwm||)
	.dwattr $C$DW$88, DW_AT_high_pc(0x00)
	.dwattr $C$DW$88, DW_AT_linkage_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$88, DW_AT_external
	.dwattr $C$DW$88, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$88, DW_AT_decl_line(0x21f)
	.dwattr $C$DW$88, DW_AT_decl_column(0x06)
	.dwattr $C$DW$88, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "../bts_hal.c",line 544,column 1,is_stmt,address ||BTS_HAL_setupSyncBuckPwm||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupSyncBuckPwm||
$C$DW$89	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$89, DW_AT_name("EPWM_BASE")
	.dwattr $C$DW$89, DW_AT_type(*$C$DW$T$95)
	.dwattr $C$DW$89, DW_AT_location[DW_OP_reg0]


;***************************************************************
;* FNAME: BTS_HAL_setupSyncBuckPwm      FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  4 SOE     *
;***************************************************************

||BTS_HAL_setupSyncBuckPwm||:
;* AR4   assigned to $O$C1
;* AR2   assigned to EPWM_BASE
$C$DW$90	.dwtag  DW_TAG_variable
	.dwattr $C$DW$90, DW_AT_name("EPWM_BASE")
	.dwattr $C$DW$90, DW_AT_type(*$C$DW$T$156)
	.dwattr $C$DW$90, DW_AT_location[DW_OP_reg8]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
        MOVL      *SP++,XAR2            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 9, 4
	.dwcfi	cfa_offset, -6
        MOVL      XAR2,ACC              ; [CPU_ALU] |544| 
	.dwpsn	file "../bts_hal.c",line 552,column 5,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |552| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1591,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xe07f     ; [CPU_ALU] |1591| 
	.dwpsn	file "../bts_hal.c",line 552,column 5,is_stmt,isa 0
$C$DW$91	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$91, DW_AT_low_pc(0x00)
	.dwattr $C$DW$91, DW_AT_name("EPWM_setEmulationMode")
	.dwattr $C$DW$91, DW_AT_TI_call

        LCR       #||EPWM_setEmulationMode|| ; [CPU_ALU] |552| 
        ; call occurs [#||EPWM_setEmulationMode||] ; [] |552| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1213,column 9,is_stmt,isa 0
        MOVB      XAR1,#108             ; [CPU_ALU] |1213| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2146,column 5,is_stmt,isa 0
        MOVB      XAR0,#99              ; [CPU_ALU] |2146| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1513,column 5,is_stmt,isa 0
        MOV       *+XAR2[4],#0          ; [CPU_ALU] |1513| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1206,column 9,is_stmt,isa 0
        MOVB      ACC,#0                ; [CPU_ALU] |1206| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1213,column 9,is_stmt,isa 0
        MOVL      XAR5,#256000          ; [CPU_ARAU] |1213| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2301,column 5,is_stmt,isa 0
        MOVL      XAR4,XAR2             ; [CPU_ALU] |2301| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2146,column 5,is_stmt,isa 0
        MOV       *+XAR2[AR0],#799      ; [CPU_ALU] |2146| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      XAR0,#107             ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1723,column 9,is_stmt,isa 0
        AND       *+XAR2[0],#0xfff7     ; [CPU_ALU] |1723| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2301,column 5,is_stmt,isa 0
        ADDB      XAR4,#8               ; [CPU_ALU] |2301| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1813,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xfffc     ; [CPU_ALU] |1813| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1782,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xfffb     ; [CPU_ALU] |1782| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *+XAR2[AR0],#0        ; [CPU_ALU] |2406| 
        MOVB      XAR0,#109             ; [CPU_ALU] |2406| 
        MOV       *+XAR2[AR0],#799      ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1206,column 9,is_stmt,isa 0
        MOVB      XAR0,#106             ; [CPU_ALU] |1206| 
        MOVL      *+XAR2[AR0],ACC       ; [CPU_ALU] |1206| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1213,column 9,is_stmt,isa 0
        MOVL      *+XAR2[AR1],XAR5      ; [CPU_FPU] |1213| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1813,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xfffc     ; [CPU_FPU] |1813| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1782,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xfffb     ; [CPU_FPU] |1782| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1591,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xe07f     ; [CPU_FPU] |1591| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2301,column 5,is_stmt,isa 0
        AND       AL,*+XAR4[0],#0xf3ec  ; [CPU_ALU] |2301| 
        ORB       AL,#0x01              ; [CPU_ALU] |2301| 
        MOV       *+XAR4[0],AL          ; [CPU_ALU] |2301| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 839,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |839| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 840,column 5,is_stmt,isa 0
        MOVB      XAR0,#32              ; [CPU_ALU] |840| 
        AND       AL,*+XAR2[AR0],#0xffef ; [CPU_ALU] |840| 
        MOVB      XAR0,#32              ; [CPU_ALU] |840| 
        ORB       AL,#0x08              ; [CPU_ALU] |840| 
        MOV       *+XAR2[AR0],AL        ; [CPU_ALU] |840| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 843,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |843| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2301,column 5,is_stmt,isa 0
        AND       AL,*+XAR4[0],#0xcfb7  ; [CPU_ALU] |2301| 
        ORB       AL,#0x04              ; [CPU_ALU] |2301| 
        MOV       *+XAR4[0],AL          ; [CPU_ALU] |2301| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 839,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |839| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 840,column 5,is_stmt,isa 0
        MOVB      XAR0,#32              ; [CPU_ALU] |840| 
        AND       AL,*+XAR2[AR0],#0xefff ; [CPU_ALU] |840| 
        MOVB      XAR0,#32              ; [CPU_ALU] |840| 
        OR        AL,#0x0800            ; [CPU_ALU] |840| 
        MOV       *+XAR2[AR0],AL        ; [CPU_ALU] |840| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 843,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |843| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2558,column 5,is_stmt,isa 0
        MOVB      XAR0,#16              ; [CPU_ALU] |2558| 
        MOVB      XAR1,#16              ; [CPU_ALU] |2558| 
        AND       AL,*+XAR2[AR0],#0xfcfc ; [CPU_ALU] |2558| 
        ORB       AL,#0x11              ; [CPU_ALU] |2558| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2758,column 9,is_stmt,isa 0
        MOVB      XAR0,#64              ; [CPU_ALU] |2758| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2558,column 5,is_stmt,isa 0
        MOV       *+XAR2[AR1],AL        ; [CPU_ALU] |2558| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2758,column 9,is_stmt,isa 0
        MOVB      XAR1,#64              ; [CPU_ALU] |2758| 
        AND       AL,*+XAR2[AR0],#0xfffe ; [CPU_ALU] |2758| 
        ORB       AL,#0x02              ; [CPU_ALU] |2758| 
        MOVB      XAR0,#64              ; [CPU_ALU] |2758| 
        MOV       *+XAR2[AR1],AL        ; [CPU_ALU] |2758| 
        MOVB      XAR1,#64              ; [CPU_ALU] |2758| 
        AND       AL,*+XAR2[AR0],#0xffdf ; [CPU_ALU] |2758| 
        ORB       AL,#0x10              ; [CPU_ALU] |2758| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2558,column 5,is_stmt,isa 0
        MOVB      XAR0,#16              ; [CPU_ALU] |2558| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2758,column 9,is_stmt,isa 0
        MOV       *+XAR2[AR1],AL        ; [CPU_ALU] |2758| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2558,column 5,is_stmt,isa 0
        MOVB      XAR1,#16              ; [CPU_ALU] |2558| 
        AND       AL,*+XAR2[AR0],#0xf3f7 ; [CPU_ALU] |2558| 
        ORB       AL,#0x44              ; [CPU_ALU] |2558| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2758,column 9,is_stmt,isa 0
        MOVB      XAR0,#66              ; [CPU_ALU] |2758| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2558,column 5,is_stmt,isa 0
        MOV       *+XAR2[AR1],AL        ; [CPU_ALU] |2558| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2758,column 9,is_stmt,isa 0
        MOVB      XAR1,#66              ; [CPU_ALU] |2758| 
        AND       AL,*+XAR2[AR0],#0xfffe ; [CPU_ALU] |2758| 
        ORB       AL,#0x02              ; [CPU_ALU] |2758| 
        MOVB      XAR0,#66              ; [CPU_ALU] |2758| 
        MOV       *+XAR2[AR1],AL        ; [CPU_ALU] |2758| 
        AND       AL,*+XAR2[AR0],#0xfdff ; [CPU_ALU] |2758| 
        MOVB      XAR0,#66              ; [CPU_ALU] |2758| 
        OR        AL,#0x0100            ; [CPU_ALU] |2758| 
        MOV       *+XAR2[AR0],AL        ; [CPU_ALU] |2758| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 753,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |753| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 754,column 5,is_stmt,isa 0
        MOVB      XAR0,#32              ; [CPU_ALU] |754| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 797,column 5,is_stmt,isa 0
        MOVB      XAR1,#32              ; [CPU_ALU] |797| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 754,column 5,is_stmt,isa 0
        AND       AL,*+XAR2[AR0],#0xfffe ; [CPU_ALU] |754| 
        MOVB      XAR0,#32              ; [CPU_ALU] |754| 
        ORB       AL,#0x02              ; [CPU_ALU] |754| 
        MOV       *+XAR2[AR0],AL        ; [CPU_ALU] |754| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 797,column 5,is_stmt,isa 0
        MOVB      XAR0,#32              ; [CPU_ALU] |797| 
        AND       AL,*+XAR2[AR0],#0xfffb ; [CPU_ALU] |797| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 754,column 5,is_stmt,isa 0
        MOVB      XAR0,#32              ; [CPU_ALU] |754| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 797,column 5,is_stmt,isa 0
        MOV       *+XAR2[AR1],AL        ; [CPU_ALU] |797| 
        MOVB      XAR1,#32              ; [CPU_ALU] |797| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 754,column 5,is_stmt,isa 0
        AND       AL,*+XAR2[AR0],#0xfdff ; [CPU_ALU] |754| 
        MOVB      XAR0,#32              ; [CPU_ALU] |754| 
        OR        AL,#0x0100            ; [CPU_ALU] |754| 
        MOV       *+XAR2[AR0],AL        ; [CPU_ALU] |754| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 797,column 5,is_stmt,isa 0
        MOVB      XAR0,#32              ; [CPU_ALU] |797| 
        AND       AL,*+XAR2[AR0],#0xfbff ; [CPU_ALU] |797| 
        MOV       *+XAR2[AR1],AL        ; [CPU_ALU] |797| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 800,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |800| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3359,column 9,is_stmt,isa 0
        MOVL      XAR4,XAR2             ; [CPU_ALU] |3359| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3227,column 10,is_stmt,isa 0
        MOVB      XAR0,#12              ; [CPU_ALU] |3227| 
        MOVB      XAR1,#12              ; [CPU_ALU] |3227| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3359,column 9,is_stmt,isa 0
        ADDB      XAR4,#12              ; [CPU_ALU] |3359| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3227,column 10,is_stmt,isa 0
        MOV       AL,*+XAR2[AR0]        ; [CPU_ALU] |3227| 
        ORB       AL,#0x02              ; [CPU_ALU] |3227| 
        MOVB      XAR0,#12              ; [CPU_ALU] |3227| 
        MOV       *+XAR2[AR1],AL        ; [CPU_FPU] |3227| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3311,column 5,is_stmt,isa 0
        MOVB      XAR1,#12              ; [CPU_FPU] |3311| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3227,column 10,is_stmt,isa 0
        MOV       AL,*+XAR2[AR0]        ; [CPU_FPU] |3227| 
        MOVB      XAR0,#12              ; [CPU_FPU] |3227| 
        ORB       AL,#0x01              ; [CPU_ALU] |3227| 
        MOV       *+XAR2[AR0],AL        ; [CPU_FPU] |3227| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3311,column 5,is_stmt,isa 0
        MOVB      XAR0,#12              ; [CPU_FPU] |3311| 
        AND       AL,*+XAR2[AR1],#0xffef ; [CPU_FPU] |3311| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3364,column 9,is_stmt,isa 0
        MOVB      XAR1,#12              ; [CPU_FPU] |3364| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3311,column 5,is_stmt,isa 0
        MOV       *+XAR2[AR0],AL        ; [CPU_FPU] |3311| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3276,column 5,is_stmt,isa 0
        MOVB      XAR0,#12              ; [CPU_FPU] |3276| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3359,column 9,is_stmt,isa 0
        AND       *+XAR4[0],#0xbfff     ; [CPU_ALU] |3359| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3364,column 9,is_stmt,isa 0
        MOV       AL,*+XAR2[AR1]        ; [CPU_ALU] |3364| 
        MOVB      XAR1,#12              ; [CPU_ALU] |3364| 
        ORB       AL,#0x20              ; [CPU_ALU] |3364| 
        MOV       *+XAR2[AR1],AL        ; [CPU_ALU] |3364| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3276,column 5,is_stmt,isa 0
        MOVB      XAR1,#12              ; [CPU_ALU] |3276| 
        MOV       AL,*+XAR2[AR0]        ; [CPU_ALU] |3276| 
        ORB       AL,#0x08              ; [CPU_ALU] |3276| 
        MOVB      XAR0,#12              ; [CPU_ALU] |3276| 
        MOV       *+XAR2[AR1],AL        ; [CPU_ALU] |3276| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3621,column 5,is_stmt,isa 0
        MOVB      XAR1,#81              ; [CPU_ALU] |3621| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3276,column 5,is_stmt,isa 0
        AND       AL,*+XAR2[AR0],#0xfffb ; [CPU_ALU] |3276| 
        MOVB      XAR0,#12              ; [CPU_ALU] |3276| 
        MOV       *+XAR2[AR0],AL        ; [CPU_ALU] |3276| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3649,column 5,is_stmt,isa 0
        MOVB      XAR0,#83              ; [CPU_ALU] |3649| 
        MOVB      *+XAR2[AR0],#12,UNC   ; [CPU_ALU] |3649| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3621,column 5,is_stmt,isa 0
        MOVB      XAR0,#81              ; [CPU_ALU] |3621| 
        MOVB      *+XAR2[AR0],#12,UNC   ; [CPU_ALU] |3621| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3649,column 5,is_stmt,isa 0
        MOVB      XAR0,#83              ; [CPU_ALU] |3649| 
        MOVB      *+XAR2[AR0],#12,UNC   ; [CPU_ALU] |3649| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3621,column 5,is_stmt,isa 0
        MOVB      *+XAR2[AR1],#12,UNC   ; [CPU_ALU] |3621| 
        MOVL      XAR2,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 9
        MOVL      XAR1,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$92	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$92, DW_AT_low_pc(0x00)
	.dwattr $C$DW$92, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$88, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$88, DW_AT_TI_end_line(0x2bd)
	.dwattr $C$DW$88, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$88

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupSyncBuckPinsGpio||

$C$DW$93	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$93, DW_AT_name("BTS_HAL_setupSyncBuckPinsGpio")
	.dwattr $C$DW$93, DW_AT_low_pc(||BTS_HAL_setupSyncBuckPinsGpio||)
	.dwattr $C$DW$93, DW_AT_high_pc(0x00)
	.dwattr $C$DW$93, DW_AT_linkage_name("BTS_HAL_setupSyncBuckPinsGpio")
	.dwattr $C$DW$93, DW_AT_external
	.dwattr $C$DW$93, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$93, DW_AT_decl_line(0x1a5)
	.dwattr $C$DW$93, DW_AT_decl_column(0x06)
	.dwattr $C$DW$93, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 422,column 1,is_stmt,address ||BTS_HAL_setupSyncBuckPinsGpio||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupSyncBuckPinsGpio||

;***************************************************************
;* FNAME: BTS_HAL_setupSyncBuckPinsGpio FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupSyncBuckPinsGpio||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#2                ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 424,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |424| 
        MOVB      ACC,#1                ; [CPU_ALU] |424| 
$C$DW$94	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$94, DW_AT_low_pc(0x00)
	.dwattr $C$DW$94, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$94, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |424| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |424| 
	.dwpsn	file "../bts_hal.c",line 425,column 5,is_stmt,isa 0
        MOVL      XAR4,#393216          ; [CPU_ARAU] |425| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |425| 
$C$DW$95	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$95, DW_AT_low_pc(0x00)
	.dwattr $C$DW$95, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$95, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |425| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |425| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#2                ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 428,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |428| 
        MOVB      ACC,#1                ; [CPU_ALU] |428| 
$C$DW$96	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$96, DW_AT_low_pc(0x00)
	.dwattr $C$DW$96, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$96, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |428| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |428| 
	.dwpsn	file "../bts_hal.c",line 429,column 5,is_stmt,isa 0
        MOVL      XAR4,#393728          ; [CPU_ARAU] |429| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |429| 
$C$DW$97	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$97, DW_AT_low_pc(0x00)
	.dwattr $C$DW$97, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$97, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |429| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |429| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#4                ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 432,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |432| 
        MOVB      ACC,#2                ; [CPU_ALU] |432| 
$C$DW$98	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$98, DW_AT_low_pc(0x00)
	.dwattr $C$DW$98, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$98, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |432| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |432| 
	.dwpsn	file "../bts_hal.c",line 433,column 5,is_stmt,isa 0
        MOVL      XAR4,#394240          ; [CPU_ARAU] |433| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |433| 
$C$DW$99	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$99, DW_AT_low_pc(0x00)
	.dwattr $C$DW$99, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$99, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |433| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |433| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#8                ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 436,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |436| 
        MOVB      ACC,#3                ; [CPU_ALU] |436| 
$C$DW$100	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$100, DW_AT_low_pc(0x00)
	.dwattr $C$DW$100, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$100, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |436| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |436| 
	.dwpsn	file "../bts_hal.c",line 437,column 5,is_stmt,isa 0
        MOVL      XAR4,#394752          ; [CPU_ARAU] |437| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |437| 
$C$DW$101	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$101, DW_AT_low_pc(0x00)
	.dwattr $C$DW$101, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$101, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |437| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |437| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#16               ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 440,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |440| 
        MOVB      ACC,#4                ; [CPU_ALU] |440| 
$C$DW$102	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$102, DW_AT_low_pc(0x00)
	.dwattr $C$DW$102, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$102, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |440| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |440| 
	.dwpsn	file "../bts_hal.c",line 441,column 5,is_stmt,isa 0
        MOVL      XAR4,#395264          ; [CPU_ARAU] |441| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |441| 
$C$DW$103	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$103, DW_AT_low_pc(0x00)
	.dwattr $C$DW$103, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$103, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |441| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |441| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#32               ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 444,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |444| 
        MOVB      ACC,#5                ; [CPU_ALU] |444| 
$C$DW$104	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$104, DW_AT_low_pc(0x00)
	.dwattr $C$DW$104, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$104, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |444| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |444| 
	.dwpsn	file "../bts_hal.c",line 445,column 5,is_stmt,isa 0
        MOVL      XAR4,#395776          ; [CPU_ARAU] |445| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |445| 
$C$DW$105	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$105, DW_AT_low_pc(0x00)
	.dwattr $C$DW$105, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$105, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |445| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |445| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#64               ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 448,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |448| 
        MOVB      ACC,#6                ; [CPU_ALU] |448| 
$C$DW$106	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$106, DW_AT_low_pc(0x00)
	.dwattr $C$DW$106, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$106, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |448| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |448| 
	.dwpsn	file "../bts_hal.c",line 449,column 5,is_stmt,isa 0
        MOVL      XAR4,#396288          ; [CPU_ARAU] |449| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |449| 
$C$DW$107	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$107, DW_AT_low_pc(0x00)
	.dwattr $C$DW$107, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$107, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |449| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |449| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#128              ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 452,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |452| 
        MOVB      ACC,#7                ; [CPU_ALU] |452| 
$C$DW$108	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$108, DW_AT_low_pc(0x00)
	.dwattr $C$DW$108, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$108, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |452| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |452| 
	.dwpsn	file "../bts_hal.c",line 453,column 5,is_stmt,isa 0
        MOVL      XAR4,#396800          ; [CPU_ARAU] |453| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |453| 
$C$DW$109	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$109, DW_AT_low_pc(0x00)
	.dwattr $C$DW$109, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$109, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |453| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |453| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#256             ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
	.dwpsn	file "../bts_hal.c",line 456,column 5,is_stmt,isa 0
        MOVB      ACC,#8                ; [CPU_ALU] |456| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 456,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |456| 
$C$DW$110	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$110, DW_AT_low_pc(0x00)
	.dwattr $C$DW$110, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$110, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |456| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |456| 
	.dwpsn	file "../bts_hal.c",line 457,column 5,is_stmt,isa 0
        MOVL      XAR4,#397312          ; [CPU_ARAU] |457| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |457| 
$C$DW$111	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$111, DW_AT_low_pc(0x00)
	.dwattr $C$DW$111, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$111, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |457| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |457| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#512             ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
	.dwpsn	file "../bts_hal.c",line 460,column 5,is_stmt,isa 0
        MOVB      ACC,#9                ; [CPU_ALU] |460| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 460,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |460| 
$C$DW$112	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$112, DW_AT_low_pc(0x00)
	.dwattr $C$DW$112, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$112, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |460| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |460| 
	.dwpsn	file "../bts_hal.c",line 461,column 5,is_stmt,isa 0
        MOVL      XAR4,#397824          ; [CPU_ARAU] |461| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |461| 
$C$DW$113	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$113, DW_AT_low_pc(0x00)
	.dwattr $C$DW$113, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$113, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |461| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |461| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#1024            ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
	.dwpsn	file "../bts_hal.c",line 464,column 5,is_stmt,isa 0
        MOVB      ACC,#10               ; [CPU_ALU] |464| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 464,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |464| 
$C$DW$114	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$114, DW_AT_low_pc(0x00)
	.dwattr $C$DW$114, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$114, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |464| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |464| 
	.dwpsn	file "../bts_hal.c",line 465,column 5,is_stmt,isa 0
        MOVL      XAR4,#398336          ; [CPU_ARAU] |465| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |465| 
$C$DW$115	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$115, DW_AT_low_pc(0x00)
	.dwattr $C$DW$115, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$115, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |465| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |465| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#2048            ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
	.dwpsn	file "../bts_hal.c",line 468,column 5,is_stmt,isa 0
        MOVB      ACC,#11               ; [CPU_ALU] |468| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 468,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |468| 
$C$DW$116	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$116, DW_AT_low_pc(0x00)
	.dwattr $C$DW$116, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$116, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |468| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |468| 
	.dwpsn	file "../bts_hal.c",line 469,column 5,is_stmt,isa 0
        MOVL      XAR4,#398848          ; [CPU_ARAU] |469| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |469| 
$C$DW$117	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$117, DW_AT_low_pc(0x00)
	.dwattr $C$DW$117, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$117, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |469| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |469| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#4096            ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
	.dwpsn	file "../bts_hal.c",line 472,column 5,is_stmt,isa 0
        MOVB      ACC,#12               ; [CPU_ALU] |472| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 472,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |472| 
$C$DW$118	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$118, DW_AT_low_pc(0x00)
	.dwattr $C$DW$118, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$118, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |472| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |472| 
	.dwpsn	file "../bts_hal.c",line 473,column 5,is_stmt,isa 0
        MOVL      XAR4,#399360          ; [CPU_ARAU] |473| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |473| 
$C$DW$119	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$119, DW_AT_low_pc(0x00)
	.dwattr $C$DW$119, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$119, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |473| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |473| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#8192            ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
	.dwpsn	file "../bts_hal.c",line 476,column 5,is_stmt,isa 0
        MOVB      ACC,#13               ; [CPU_ALU] |476| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 476,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |476| 
$C$DW$120	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$120, DW_AT_low_pc(0x00)
	.dwattr $C$DW$120, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$120, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |476| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |476| 
	.dwpsn	file "../bts_hal.c",line 477,column 5,is_stmt,isa 0
        MOVL      XAR4,#399872          ; [CPU_ARAU] |477| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |477| 
$C$DW$121	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$121, DW_AT_low_pc(0x00)
	.dwattr $C$DW$121, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$121, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |477| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |477| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#16384           ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
	.dwpsn	file "../bts_hal.c",line 480,column 5,is_stmt,isa 0
        MOVB      ACC,#14               ; [CPU_ALU] |480| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 480,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |480| 
$C$DW$122	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$122, DW_AT_low_pc(0x00)
	.dwattr $C$DW$122, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$122, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |480| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |480| 
	.dwpsn	file "../bts_hal.c",line 481,column 5,is_stmt,isa 0
        MOVL      XAR4,#400384          ; [CPU_ARAU] |481| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |481| 
$C$DW$123	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$123, DW_AT_low_pc(0x00)
	.dwattr $C$DW$123, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$123, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |481| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |481| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#32768           ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
	.dwpsn	file "../bts_hal.c",line 484,column 5,is_stmt,isa 0
        MOVB      ACC,#15               ; [CPU_ALU] |484| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 484,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |484| 
$C$DW$124	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$124, DW_AT_low_pc(0x00)
	.dwattr $C$DW$124, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$124, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |484| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |484| 
	.dwpsn	file "../bts_hal.c",line 485,column 5,is_stmt,isa 0
        MOVL      XAR4,#400896          ; [CPU_ARAU] |485| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |485| 
$C$DW$125	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$125, DW_AT_low_pc(0x00)
	.dwattr $C$DW$125, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$125, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |485| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#1048576         ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
	.dwpsn	file "../bts_hal.c",line 489,column 5,is_stmt,isa 0
        MOVB      ACC,#20               ; [CPU_ALU] |489| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 489,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |489| 
$C$DW$126	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$126, DW_AT_low_pc(0x00)
	.dwattr $C$DW$126, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$126, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |489| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |489| 
	.dwpsn	file "../bts_hal.c",line 490,column 5,is_stmt,isa 0
        MOVL      XAR4,#526336          ; [CPU_ARAU] |490| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |490| 
$C$DW$127	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$127, DW_AT_low_pc(0x00)
	.dwattr $C$DW$127, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$127, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |490| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |490| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |468| 
        MOV       AH,#64                ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 494,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |494| 
        MOVB      ACC,#22               ; [CPU_ALU] |494| 
$C$DW$128	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$128, DW_AT_low_pc(0x00)
	.dwattr $C$DW$128, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$128, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |494| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |494| 
	.dwpsn	file "../bts_hal.c",line 495,column 5,is_stmt,isa 0
        MOVL      XAR4,#527360          ; [CPU_ARAU] |495| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |495| 
$C$DW$129	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$129, DW_AT_low_pc(0x00)
	.dwattr $C$DW$129, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$129, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |495| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |495| 
$C$DW$130	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$130, DW_AT_low_pc(0x00)
	.dwattr $C$DW$130, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$93, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$93, DW_AT_TI_end_line(0x1f0)
	.dwattr $C$DW$93, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$93

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupSyncBuckPinsEpwm||

$C$DW$131	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$131, DW_AT_name("BTS_HAL_setupSyncBuckPinsEpwm")
	.dwattr $C$DW$131, DW_AT_low_pc(||BTS_HAL_setupSyncBuckPinsEpwm||)
	.dwattr $C$DW$131, DW_AT_high_pc(0x00)
	.dwattr $C$DW$131, DW_AT_linkage_name("BTS_HAL_setupSyncBuckPinsEpwm")
	.dwattr $C$DW$131, DW_AT_external
	.dwattr $C$DW$131, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$131, DW_AT_decl_line(0x1f9)
	.dwattr $C$DW$131, DW_AT_decl_column(0x06)
	.dwattr $C$DW$131, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 506,column 1,is_stmt,address ||BTS_HAL_setupSyncBuckPinsEpwm||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupSyncBuckPinsEpwm||

;***************************************************************
;* FNAME: BTS_HAL_setupSyncBuckPinsEpwm FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupSyncBuckPinsEpwm||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../bts_hal.c",line 507,column 5,is_stmt,isa 0
        MOVL      XAR4,#393217          ; [CPU_ARAU] |507| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |507| 
$C$DW$132	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$132, DW_AT_low_pc(0x00)
	.dwattr $C$DW$132, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$132, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |507| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |507| 
	.dwpsn	file "../bts_hal.c",line 508,column 5,is_stmt,isa 0
        MOVL      XAR4,#393729          ; [CPU_ARAU] |508| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |508| 
$C$DW$133	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$133, DW_AT_low_pc(0x00)
	.dwattr $C$DW$133, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$133, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |508| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |508| 
	.dwpsn	file "../bts_hal.c",line 510,column 5,is_stmt,isa 0
        MOVL      XAR4,#394241          ; [CPU_ARAU] |510| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |510| 
$C$DW$134	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$134, DW_AT_low_pc(0x00)
	.dwattr $C$DW$134, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$134, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |510| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |510| 
	.dwpsn	file "../bts_hal.c",line 511,column 5,is_stmt,isa 0
        MOVL      XAR4,#394753          ; [CPU_ARAU] |511| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |511| 
$C$DW$135	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$135, DW_AT_low_pc(0x00)
	.dwattr $C$DW$135, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$135, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |511| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |511| 
	.dwpsn	file "../bts_hal.c",line 513,column 5,is_stmt,isa 0
        MOVL      XAR4,#395265          ; [CPU_ARAU] |513| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |513| 
$C$DW$136	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$136, DW_AT_low_pc(0x00)
	.dwattr $C$DW$136, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$136, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |513| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |513| 
	.dwpsn	file "../bts_hal.c",line 514,column 5,is_stmt,isa 0
        MOVL      XAR4,#395777          ; [CPU_ARAU] |514| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |514| 
$C$DW$137	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$137, DW_AT_low_pc(0x00)
	.dwattr $C$DW$137, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$137, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |514| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |514| 
	.dwpsn	file "../bts_hal.c",line 516,column 5,is_stmt,isa 0
        MOVL      XAR4,#396289          ; [CPU_ARAU] |516| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |516| 
$C$DW$138	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$138, DW_AT_low_pc(0x00)
	.dwattr $C$DW$138, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$138, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |516| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |516| 
	.dwpsn	file "../bts_hal.c",line 517,column 5,is_stmt,isa 0
        MOVL      XAR4,#396801          ; [CPU_ARAU] |517| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |517| 
$C$DW$139	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$139, DW_AT_low_pc(0x00)
	.dwattr $C$DW$139, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$139, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |517| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |517| 
	.dwpsn	file "../bts_hal.c",line 519,column 5,is_stmt,isa 0
        MOVL      XAR4,#397313          ; [CPU_ARAU] |519| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |519| 
$C$DW$140	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$140, DW_AT_low_pc(0x00)
	.dwattr $C$DW$140, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$140, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |519| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |519| 
	.dwpsn	file "../bts_hal.c",line 520,column 5,is_stmt,isa 0
        MOVL      XAR4,#397825          ; [CPU_ARAU] |520| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |520| 
$C$DW$141	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$141, DW_AT_low_pc(0x00)
	.dwattr $C$DW$141, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$141, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |520| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |520| 
	.dwpsn	file "../bts_hal.c",line 522,column 5,is_stmt,isa 0
        MOVL      XAR4,#398337          ; [CPU_ARAU] |522| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |522| 
$C$DW$142	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$142, DW_AT_low_pc(0x00)
	.dwattr $C$DW$142, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$142, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |522| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |522| 
	.dwpsn	file "../bts_hal.c",line 523,column 5,is_stmt,isa 0
        MOVL      XAR4,#398849          ; [CPU_ARAU] |523| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |523| 
$C$DW$143	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$143, DW_AT_low_pc(0x00)
	.dwattr $C$DW$143, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$143, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |523| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |523| 
	.dwpsn	file "../bts_hal.c",line 525,column 5,is_stmt,isa 0
        MOVL      XAR4,#399361          ; [CPU_ARAU] |525| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |525| 
$C$DW$144	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$144, DW_AT_low_pc(0x00)
	.dwattr $C$DW$144, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$144, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |525| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |525| 
	.dwpsn	file "../bts_hal.c",line 526,column 5,is_stmt,isa 0
        MOVL      XAR4,#399873          ; [CPU_ARAU] |526| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |526| 
$C$DW$145	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$145, DW_AT_low_pc(0x00)
	.dwattr $C$DW$145, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$145, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |526| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |526| 
	.dwpsn	file "../bts_hal.c",line 528,column 5,is_stmt,isa 0
        MOVL      XAR4,#400385          ; [CPU_ARAU] |528| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |528| 
$C$DW$146	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$146, DW_AT_low_pc(0x00)
	.dwattr $C$DW$146, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$146, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |528| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |528| 
	.dwpsn	file "../bts_hal.c",line 529,column 5,is_stmt,isa 0
        MOVL      XAR4,#400897          ; [CPU_ARAU] |529| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |529| 
$C$DW$147	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$147, DW_AT_low_pc(0x00)
	.dwattr $C$DW$147, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$147, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |529| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |529| 
	.dwpsn	file "../bts_hal.c",line 532,column 5,is_stmt,isa 0
        MOVL      XAR4,#526341          ; [CPU_ARAU] |532| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |532| 
$C$DW$148	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$148, DW_AT_low_pc(0x00)
	.dwattr $C$DW$148, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$148, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |532| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |532| 
	.dwpsn	file "../bts_hal.c",line 535,column 5,is_stmt,isa 0
        MOVL      XAR4,#527365          ; [CPU_ARAU] |535| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |535| 
$C$DW$149	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$149, DW_AT_low_pc(0x00)
	.dwattr $C$DW$149, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$149, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |535| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |535| 
$C$DW$150	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$150, DW_AT_low_pc(0x00)
	.dwattr $C$DW$150, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$131, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$131, DW_AT_TI_end_line(0x218)
	.dwattr $C$DW$131, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$131

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupSfraClock||

$C$DW$151	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$151, DW_AT_name("BTS_HAL_setupSfraClock")
	.dwattr $C$DW$151, DW_AT_low_pc(||BTS_HAL_setupSfraClock||)
	.dwattr $C$DW$151, DW_AT_high_pc(0x00)
	.dwattr $C$DW$151, DW_AT_linkage_name("BTS_HAL_setupSfraClock")
	.dwattr $C$DW$151, DW_AT_external
	.dwattr $C$DW$151, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$151, DW_AT_decl_line(0x36d)
	.dwattr $C$DW$151, DW_AT_decl_column(0x06)
	.dwattr $C$DW$151, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 878,column 1,is_stmt,address ||BTS_HAL_setupSfraClock||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupSfraClock||
$C$DW$152	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$152, DW_AT_name("EPWM_BASE")
	.dwattr $C$DW$152, DW_AT_type(*$C$DW$T$95)
	.dwattr $C$DW$152, DW_AT_location[DW_OP_reg0]


;***************************************************************
;* FNAME: BTS_HAL_setupSfraClock        FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupSfraClock||:
;* AR4   assigned to EPWM_BASE
$C$DW$153	.dwtag  DW_TAG_variable
	.dwattr $C$DW$153, DW_AT_name("EPWM_BASE")
	.dwattr $C$DW$153, DW_AT_type(*$C$DW$T$156)
	.dwattr $C$DW$153, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      XAR4,ACC              ; [CPU_ALU] |878| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4737,column 5,is_stmt,isa 0
        MOVB      XAR0,#164             ; [CPU_ALU] |4737| 
        AND       AL,*+XAR4[AR0],#0xfff8 ; [CPU_ALU] |4737| 
        MOVB      XAR0,#164             ; [CPU_ALU] |4737| 
        ORB       AL,#0x01              ; [CPU_ALU] |4737| 
        MOV       *+XAR4[AR0],AL        ; [CPU_ALU] |4737| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4636,column 5,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |4636| 
        ADDB      ACC,#164              ; [CPU_ALU] |4636| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |4636| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4767,column 5,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |4767| 
        ADDB      ACC,#166              ; [CPU_ALU] |4767| 
        MOVL      XAR5,ACC              ; [CPU_ALU] |4767| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4636,column 5,is_stmt,isa 0
        OR        *+XAR6[0],#0x0008     ; [CPU_ALU] |4636| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4768,column 5,is_stmt,isa 0
        MOVB      XAR0,#174             ; [CPU_ALU] |4768| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4767,column 5,is_stmt,isa 0
        OR        *+XAR5[0],#0x0010     ; [CPU_ALU] |4767| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4768,column 5,is_stmt,isa 0
        AND       AL,*+XAR4[AR0],#0xfff0 ; [CPU_ALU] |4768| 
        MOVB      XAR0,#174             ; [CPU_ALU] |4768| 
        ORB       AL,#0x01              ; [CPU_ALU] |4768| 
        MOV       *+XAR4[AR0],AL        ; [CPU_ALU] |4768| 
$C$DW$154	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$154, DW_AT_low_pc(0x00)
	.dwattr $C$DW$154, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$151, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$151, DW_AT_TI_end_line(0x373)
	.dwattr $C$DW$151, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$151

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupInterrupt_Adc2||

$C$DW$155	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$155, DW_AT_name("BTS_HAL_setupInterrupt_Adc2")
	.dwattr $C$DW$155, DW_AT_low_pc(||BTS_HAL_setupInterrupt_Adc2||)
	.dwattr $C$DW$155, DW_AT_high_pc(0x00)
	.dwattr $C$DW$155, DW_AT_linkage_name("BTS_HAL_setupInterrupt_Adc2")
	.dwattr $C$DW$155, DW_AT_external
	.dwattr $C$DW$155, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$155, DW_AT_decl_line(0x39a)
	.dwattr $C$DW$155, DW_AT_decl_column(0x06)
	.dwattr $C$DW$155, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts_hal.c",line 923,column 1,is_stmt,address ||BTS_HAL_setupInterrupt_Adc2||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupInterrupt_Adc2||

;***************************************************************
;* FNAME: BTS_HAL_setupInterrupt_Adc2   FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupInterrupt_Adc2||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts_hal.c",line 924,column 5,is_stmt,isa 0
        MOVB      ACC,#4                ; [CPU_ALU] |924| 
        MOVL      XAR4,#24864           ; [CPU_ARAU] |924| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |924| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |924| 
$C$DW$156	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$156, DW_AT_low_pc(0x00)
	.dwattr $C$DW$156, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$156, DW_AT_TI_call

        LCR       #||SPI_clearInterruptStatus|| ; [CPU_ALU] |924| 
        ; call occurs [#||SPI_clearInterruptStatus||] ; [] |924| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 308,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |308| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 309,column 5,is_stmt,isa 0
        MOVL      XAR4,#||ISR3||        ; [CPU_ARAU] |309| 
        MOVL      XAR5,#3400            ; [CPU_ARAU] |309| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |309| 
        MOVL      XAR4,#||ISR4||        ; [CPU_ARAU] |309| 
        MOVL      XAR5,#3664            ; [CPU_ARAU] |309| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |309| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 310,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |310| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$157	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$157, DW_AT_low_pc(0x00)
	.dwattr $C$DW$157, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$155, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$155, DW_AT_TI_end_line(0x39f)
	.dwattr $C$DW$155, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$155

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupInterrupt_Adc1||

$C$DW$158	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$158, DW_AT_name("BTS_HAL_setupInterrupt_Adc1")
	.dwattr $C$DW$158, DW_AT_low_pc(||BTS_HAL_setupInterrupt_Adc1||)
	.dwattr $C$DW$158, DW_AT_high_pc(0x00)
	.dwattr $C$DW$158, DW_AT_linkage_name("BTS_HAL_setupInterrupt_Adc1")
	.dwattr $C$DW$158, DW_AT_external
	.dwattr $C$DW$158, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$158, DW_AT_decl_line(0x393)
	.dwattr $C$DW$158, DW_AT_decl_column(0x06)
	.dwattr $C$DW$158, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts_hal.c",line 916,column 1,is_stmt,address ||BTS_HAL_setupInterrupt_Adc1||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupInterrupt_Adc1||

;***************************************************************
;* FNAME: BTS_HAL_setupInterrupt_Adc1   FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupInterrupt_Adc1||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts_hal.c",line 917,column 5,is_stmt,isa 0
        MOVB      ACC,#4                ; [CPU_ALU] |917| 
        MOVL      XAR4,#24832           ; [CPU_ARAU] |917| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |917| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |917| 
$C$DW$159	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$159, DW_AT_low_pc(0x00)
	.dwattr $C$DW$159, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$159, DW_AT_TI_call

        LCR       #||SPI_clearInterruptStatus|| ; [CPU_ALU] |917| 
        ; call occurs [#||SPI_clearInterruptStatus||] ; [] |917| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 308,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |308| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 309,column 5,is_stmt,isa 0
        MOVL      XAR4,#||ISR1||        ; [CPU_ARAU] |309| 
        MOVL      XAR5,#3398            ; [CPU_ARAU] |309| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |309| 
        MOVL      XAR4,#||ISR2||        ; [CPU_ARAU] |309| 
        MOVL      XAR5,#3472            ; [CPU_ARAU] |309| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |309| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 310,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |310| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$160	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$160, DW_AT_low_pc(0x00)
	.dwattr $C$DW$160, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$158, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$158, DW_AT_TI_end_line(0x398)
	.dwattr $C$DW$158, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$158

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupInterruptTrigger_Adc2||

$C$DW$161	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$161, DW_AT_name("BTS_HAL_setupInterruptTrigger_Adc2")
	.dwattr $C$DW$161, DW_AT_low_pc(||BTS_HAL_setupInterruptTrigger_Adc2||)
	.dwattr $C$DW$161, DW_AT_high_pc(0x00)
	.dwattr $C$DW$161, DW_AT_linkage_name("BTS_HAL_setupInterruptTrigger_Adc2")
	.dwattr $C$DW$161, DW_AT_external
	.dwattr $C$DW$161, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$161, DW_AT_decl_line(0x389)
	.dwattr $C$DW$161, DW_AT_decl_column(0x06)
	.dwattr $C$DW$161, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts_hal.c",line 906,column 1,is_stmt,address ||BTS_HAL_setupInterruptTrigger_Adc2||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupInterruptTrigger_Adc2||

;***************************************************************
;* FNAME: BTS_HAL_setupInterruptTrigger_Adc2 FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupInterruptTrigger_Adc2||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts_hal.c",line 907,column 5,is_stmt,isa 0
        MOVL      XAR4,#2359557         ; [CPU_ARAU] |907| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |907| 
$C$DW$162	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$162, DW_AT_low_pc(0x00)
	.dwattr $C$DW$162, DW_AT_name("Interrupt_enable")
	.dwattr $C$DW$162, DW_AT_TI_call

        LCR       #||Interrupt_enable|| ; [CPU_ALU] |907| 
        ; call occurs [#||Interrupt_enable||] ; [] |907| 
	.dwpsn	file "../bts_hal.c",line 908,column 5,is_stmt,isa 0
        MOVB      ACC,#4                ; [CPU_ALU] |908| 
        MOVL      XAR4,#24864           ; [CPU_ARAU] |908| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |908| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |908| 
$C$DW$163	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$163, DW_AT_low_pc(0x00)
	.dwattr $C$DW$163, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$163, DW_AT_TI_call

        LCR       #||SPI_clearInterruptStatus|| ; [CPU_ALU] |908| 
        ; call occurs [#||SPI_clearInterruptStatus||] ; [] |908| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 384,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612b)        ; [CPU_ALU] |384| 
        AND       AL,#0xdfff            ; [CPU_ALU] |384| 
	.dwpsn	file "../bts_hal.c",line 911,column 5,is_stmt,isa 0
        MOV       AH,#168               ; [CPU_FPU] |911| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 384,column 5,is_stmt,isa 0
        MOV       *(0:0x612b),AL        ; [CPU_ALU] |384| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 385,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612b)        ; [CPU_ALU] |385| 
        OR        AL,#0x2000            ; [CPU_ALU] |385| 
        MOV       *(0:0x612b),AL        ; [CPU_ALU] |385| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 357,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612a)        ; [CPU_ALU] |357| 
        AND       AL,#0xdfff            ; [CPU_ALU] |357| 
        MOV       *(0:0x612a),AL        ; [CPU_ALU] |357| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 358,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612a)        ; [CPU_ALU] |358| 
        OR        AL,#0x2000            ; [CPU_ALU] |358| 
        MOV       *(0:0x612a),AL        ; [CPU_ALU] |358| 
	.dwpsn	file "../bts_hal.c",line 911,column 5,is_stmt,isa 0
        MOV       AL,#1545              ; [CPU_ALU] |911| 
$C$DW$164	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$164, DW_AT_low_pc(0x00)
	.dwattr $C$DW$164, DW_AT_name("Interrupt_enable")
	.dwattr $C$DW$164, DW_AT_TI_call

        LCR       #||Interrupt_enable|| ; [CPU_ALU] |911| 
        ; call occurs [#||Interrupt_enable||] ; [] |911| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$165	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$165, DW_AT_low_pc(0x00)
	.dwattr $C$DW$165, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$161, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$161, DW_AT_TI_end_line(0x391)
	.dwattr $C$DW$161, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$161

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupInterruptTrigger_Adc1||

$C$DW$166	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$166, DW_AT_name("BTS_HAL_setupInterruptTrigger_Adc1")
	.dwattr $C$DW$166, DW_AT_low_pc(||BTS_HAL_setupInterruptTrigger_Adc1||)
	.dwattr $C$DW$166, DW_AT_high_pc(0x00)
	.dwattr $C$DW$166, DW_AT_linkage_name("BTS_HAL_setupInterruptTrigger_Adc1")
	.dwattr $C$DW$166, DW_AT_external
	.dwattr $C$DW$166, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$166, DW_AT_decl_line(0x37f)
	.dwattr $C$DW$166, DW_AT_decl_column(0x06)
	.dwattr $C$DW$166, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts_hal.c",line 896,column 1,is_stmt,address ||BTS_HAL_setupInterruptTrigger_Adc1||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupInterruptTrigger_Adc1||

;***************************************************************
;* FNAME: BTS_HAL_setupInterruptTrigger_Adc1 FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupInterruptTrigger_Adc1||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts_hal.c",line 897,column 5,is_stmt,isa 0
        MOVL      XAR4,#2294020         ; [CPU_ARAU] |897| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |897| 
$C$DW$167	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$167, DW_AT_low_pc(0x00)
	.dwattr $C$DW$167, DW_AT_name("Interrupt_enable")
	.dwattr $C$DW$167, DW_AT_TI_call

        LCR       #||Interrupt_enable|| ; [CPU_ALU] |897| 
        ; call occurs [#||Interrupt_enable||] ; [] |897| 
	.dwpsn	file "../bts_hal.c",line 898,column 5,is_stmt,isa 0
        MOVB      ACC,#4                ; [CPU_ALU] |898| 
        MOVL      XAR4,#24832           ; [CPU_ARAU] |898| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |898| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |898| 
$C$DW$168	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$168, DW_AT_low_pc(0x00)
	.dwattr $C$DW$168, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$168, DW_AT_TI_call

        LCR       #||SPI_clearInterruptStatus|| ; [CPU_ALU] |898| 
        ; call occurs [#||SPI_clearInterruptStatus||] ; [] |898| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 384,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |384| 
        AND       AL,#0xdfff            ; [CPU_ALU] |384| 
	.dwpsn	file "../bts_hal.c",line 901,column 5,is_stmt,isa 0
        MOV       AH,#72                ; [CPU_FPU] |901| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 384,column 5,is_stmt,isa 0
        MOV       *(0:0x610b),AL        ; [CPU_ALU] |384| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 385,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |385| 
        OR        AL,#0x2000            ; [CPU_ALU] |385| 
        MOV       *(0:0x610b),AL        ; [CPU_ALU] |385| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 357,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |357| 
        AND       AL,#0xdfff            ; [CPU_ALU] |357| 
        MOV       *(0:0x610a),AL        ; [CPU_ALU] |357| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 358,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |358| 
        OR        AL,#0x2000            ; [CPU_ALU] |358| 
        MOV       *(0:0x610a),AL        ; [CPU_ALU] |358| 
	.dwpsn	file "../bts_hal.c",line 901,column 5,is_stmt,isa 0
        MOV       AL,#1537              ; [CPU_ALU] |901| 
$C$DW$169	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$169, DW_AT_low_pc(0x00)
	.dwattr $C$DW$169, DW_AT_name("Interrupt_enable")
	.dwattr $C$DW$169, DW_AT_TI_call

        LCR       #||Interrupt_enable|| ; [CPU_ALU] |901| 
        ; call occurs [#||Interrupt_enable||] ; [] |901| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$170	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$170, DW_AT_low_pc(0x00)
	.dwattr $C$DW$170, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$166, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$166, DW_AT_TI_end_line(0x387)
	.dwattr $C$DW$166, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$166

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupInterrupt||

$C$DW$171	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$171, DW_AT_name("BTS_HAL_setupInterrupt")
	.dwattr $C$DW$171, DW_AT_low_pc(||BTS_HAL_setupInterrupt||)
	.dwattr $C$DW$171, DW_AT_high_pc(0x00)
	.dwattr $C$DW$171, DW_AT_linkage_name("BTS_HAL_setupInterrupt")
	.dwattr $C$DW$171, DW_AT_external
	.dwattr $C$DW$171, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$171, DW_AT_decl_line(0x3a1)
	.dwattr $C$DW$171, DW_AT_decl_column(0x06)
	.dwattr $C$DW$171, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 930,column 1,is_stmt,address ||BTS_HAL_setupInterrupt||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupInterrupt||

;***************************************************************
;* FNAME: BTS_HAL_setupInterrupt        FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupInterrupt||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../bts_hal.c",line 935,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |935| 
 clrc INTM
 clrc DBGM
	.dwpsn	file "../bts_hal.c",line 938,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |938| 
        SPM       #0                    ; [CPU_ALU] 
$C$DW$172	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$172, DW_AT_low_pc(0x00)
	.dwattr $C$DW$172, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$171, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$171, DW_AT_TI_end_line(0x3ab)
	.dwattr $C$DW$171, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$171

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupExAdc_ch5_8||

$C$DW$173	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$173, DW_AT_name("BTS_HAL_setupExAdc_ch5_8")
	.dwattr $C$DW$173, DW_AT_low_pc(||BTS_HAL_setupExAdc_ch5_8||)
	.dwattr $C$DW$173, DW_AT_high_pc(0x00)
	.dwattr $C$DW$173, DW_AT_linkage_name("BTS_HAL_setupExAdc_ch5_8")
	.dwattr $C$DW$173, DW_AT_external
	.dwattr $C$DW$173, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$173, DW_AT_decl_line(0xf7)
	.dwattr $C$DW$173, DW_AT_decl_column(0x06)
	.dwattr $C$DW$173, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "../bts_hal.c",line 248,column 1,is_stmt,address ||BTS_HAL_setupExAdc_ch5_8||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupExAdc_ch5_8||

;***************************************************************
;* FNAME: BTS_HAL_setupExAdc_ch5_8      FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupExAdc_ch5_8||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "../bts_hal.c",line 351,column 4,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |351| 
        MOV       AH,#1525              ; [CPU_ALU] |351| 
$C$DW$174	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$174, DW_AT_low_pc(0x00)
	.dwattr $C$DW$174, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$174, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_getClock||] ; [] |351| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |351| 
        MOVB      ACC,#50               ; [CPU_ALU] |351| 
        MOVL      XT,ACC                ; [CPU_ALU] |351| 
        IMPYXUL   P,XT,XAR6             ; [CPU_ALU] |351| 
        MOVL      XAR6,P                ; [CPU_ALU] |351| 
        MOV       AL,#6641              ; [CPU_ALU] |351| 
        MOV       AH,#1398              ; [CPU_ALU] |351| 
        MOVL      XT,ACC                ; [CPU_ALU] |351| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |351| 
        MOV       T,#38                 ; [CPU_FPU] |351| 
        LSR64     ACC:P,T               ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
$C$DW$175	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$175, DW_AT_low_pc(0x00)
	.dwattr $C$DW$175, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$175, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_delay||] ; [] |351| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR4,#65536           ; [CPU_ARAU] |472| 
        MOVL      XAR5,#32522           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 351,column 4,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |351| 
        MOV       AH,#1525              ; [CPU_ALU] |351| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 351,column 4,is_stmt,isa 0
$C$DW$176	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$176, DW_AT_low_pc(0x00)
	.dwattr $C$DW$176, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$176, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_getClock||] ; [] |351| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |351| 
        MOV       AL,#6641              ; [CPU_ALU] |351| 
        MOV       AH,#1398              ; [CPU_ALU] |351| 
        MOVL      XT,ACC                ; [CPU_ALU] |351| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |351| 
        MOV       T,#38                 ; [CPU_FPU] |351| 
        LSR64     ACC:P,T               ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
$C$DW$177	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$177, DW_AT_low_pc(0x00)
	.dwattr $C$DW$177, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$177, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_delay||] ; [] |351| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#65536           ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32524           ; [CPU_ARAU] |468| 
	.dwpsn	file "../bts_hal.c",line 351,column 4,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |351| 
        MOV       AH,#1525              ; [CPU_ALU] |351| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 351,column 4,is_stmt,isa 0
$C$DW$178	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$178, DW_AT_low_pc(0x00)
	.dwattr $C$DW$178, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$178, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_getClock||] ; [] |351| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |351| 
        MOV       AL,#6641              ; [CPU_ALU] |351| 
        MOV       AH,#1398              ; [CPU_ALU] |351| 
        MOVL      XT,ACC                ; [CPU_ALU] |351| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |351| 
        MOV       T,#38                 ; [CPU_FPU] |351| 
        LSR64     ACC:P,T               ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
$C$DW$179	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$179, DW_AT_low_pc(0x00)
	.dwattr $C$DW$179, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$179, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_delay||] ; [] |351| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR4,#65536           ; [CPU_ARAU] |472| 
        MOVL      XAR5,#32522           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 351,column 4,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |351| 
        MOV       AH,#1525              ; [CPU_ALU] |351| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 351,column 4,is_stmt,isa 0
$C$DW$180	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$180, DW_AT_low_pc(0x00)
	.dwattr $C$DW$180, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$180, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_getClock||] ; [] |351| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |351| 
        MOV       AL,#6641              ; [CPU_ALU] |351| 
        MOV       AH,#1398              ; [CPU_ALU] |351| 
        MOVL      XT,ACC                ; [CPU_ALU] |351| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |351| 
        MOV       T,#38                 ; [CPU_FPU] |351| 
        LSR64     ACC:P,T               ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
$C$DW$181	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$181, DW_AT_low_pc(0x00)
	.dwattr $C$DW$181, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$181, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_delay||] ; [] |351| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#2097152         ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32524           ; [CPU_ARAU] |468| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
||$C$L1||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L1||,EQ          ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#24832             ; [CPU_ALU] |648| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |648| 
||$C$L2||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L2||,EQ          ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |687| 
||$C$L3||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L3||,EQ          ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOVB      AL,#5                 ; [CPU_ALU] |648| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |648| 
||$C$L4||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L4||,EQ          ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |687| 
||$C$L5||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L5||,EQ          ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#256               ; [CPU_ALU] |648| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |648| 
||$C$L6||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L6||,EQ          ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |687| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR5,#32522           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 302,column 5,is_stmt,isa 0
        MOVL      XAR6,#10000           ; [CPU_ARAU] |302| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 302,column 5,is_stmt,isa 0
        MOVL      ACC,XAR6              ; [CPU_ALU] |302| 
$C$DW$182	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$182, DW_AT_low_pc(0x00)
	.dwattr $C$DW$182, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$182, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |302| 
        ; call occurs [#||SysCtl_delay||] ; [] |302| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#2097152         ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32524           ; [CPU_ARAU] |468| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
||$C$L7||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L7||,EQ          ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#24832             ; [CPU_ALU] |648| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |648| 
||$C$L8||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L8||,EQ          ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |687| 
||$C$L9||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L9||,EQ          ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |648| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |648| 
||$C$L10||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L10||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |687| 
||$C$L11||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L11||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#256               ; [CPU_ALU] |648| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |648| 
||$C$L12||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L12||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |687| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR5,#32522           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 321,column 5,is_stmt,isa 0
        MOVL      XAR6,#100000          ; [CPU_ARAU] |321| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 321,column 5,is_stmt,isa 0
        MOVL      ACC,XAR6              ; [CPU_ALU] |321| 
$C$DW$183	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$183, DW_AT_low_pc(0x00)
	.dwattr $C$DW$183, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$183, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |321| 
        ; call occurs [#||SysCtl_delay||] ; [] |321| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#2097152         ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32524           ; [CPU_ARAU] |468| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
||$C$L13||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L13||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#24960             ; [CPU_ALU] |648| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |648| 
||$C$L14||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L14||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |687| 
||$C$L15||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L15||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#65347             ; [CPU_ALU] |648| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |648| 
||$C$L16||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L16||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |687| 
||$C$L17||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L17||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |648| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |648| 
||$C$L18||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x612b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L18||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |687| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR5,#32522           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 340,column 5,is_stmt,isa 0
        MOVL      XAR6,#10000           ; [CPU_ARAU] |340| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 340,column 5,is_stmt,isa 0
        MOVL      ACC,XAR6              ; [CPU_ALU] |340| 
$C$DW$184	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$184, DW_AT_low_pc(0x00)
	.dwattr $C$DW$184, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$184, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |340| 
        ; call occurs [#||SysCtl_delay||] ; [] |340| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$185	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$185, DW_AT_low_pc(0x00)
	.dwattr $C$DW$185, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$173, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$173, DW_AT_TI_end_line(0x158)
	.dwattr $C$DW$173, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$173

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupExAdc_ch1_4||

$C$DW$186	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$186, DW_AT_name("BTS_HAL_setupExAdc_ch1_4")
	.dwattr $C$DW$186, DW_AT_low_pc(||BTS_HAL_setupExAdc_ch1_4||)
	.dwattr $C$DW$186, DW_AT_high_pc(0x00)
	.dwattr $C$DW$186, DW_AT_linkage_name("BTS_HAL_setupExAdc_ch1_4")
	.dwattr $C$DW$186, DW_AT_external
	.dwattr $C$DW$186, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$186, DW_AT_decl_line(0x83)
	.dwattr $C$DW$186, DW_AT_decl_column(0x06)
	.dwattr $C$DW$186, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "../bts_hal.c",line 132,column 1,is_stmt,address ||BTS_HAL_setupExAdc_ch1_4||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupExAdc_ch1_4||

;***************************************************************
;* FNAME: BTS_HAL_setupExAdc_ch1_4      FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupExAdc_ch1_4||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "../bts_hal.c",line 351,column 4,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |351| 
        MOV       AH,#1525              ; [CPU_ALU] |351| 
$C$DW$187	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$187, DW_AT_low_pc(0x00)
	.dwattr $C$DW$187, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$187, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_getClock||] ; [] |351| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |351| 
        MOVB      ACC,#50               ; [CPU_ALU] |351| 
        MOVL      XT,ACC                ; [CPU_ALU] |351| 
        IMPYXUL   P,XT,XAR6             ; [CPU_ALU] |351| 
        MOVL      XAR6,P                ; [CPU_ALU] |351| 
        MOV       AL,#6641              ; [CPU_ALU] |351| 
        MOV       AH,#1398              ; [CPU_ALU] |351| 
        MOVL      XT,ACC                ; [CPU_ALU] |351| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |351| 
        MOV       T,#38                 ; [CPU_FPU] |351| 
        LSR64     ACC:P,T               ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
$C$DW$188	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$188, DW_AT_low_pc(0x00)
	.dwattr $C$DW$188, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$188, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_delay||] ; [] |351| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOV       ACC,#512 << 15        ; [CPU_ALU] |472| 
        MOVL      XAR4,#32514           ; [CPU_ARAU] |472| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 351,column 4,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |351| 
        MOV       AH,#1525              ; [CPU_ALU] |351| 
$C$DW$189	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$189, DW_AT_low_pc(0x00)
	.dwattr $C$DW$189, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$189, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_getClock||] ; [] |351| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |351| 
        MOV       AL,#6641              ; [CPU_ALU] |351| 
        MOV       AH,#1398              ; [CPU_ALU] |351| 
        MOVL      XT,ACC                ; [CPU_ALU] |351| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |351| 
        MOV       T,#38                 ; [CPU_FPU] |351| 
        LSR64     ACC:P,T               ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
$C$DW$190	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$190, DW_AT_low_pc(0x00)
	.dwattr $C$DW$190, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$190, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_delay||] ; [] |351| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOV       ACC,#512 << 15        ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 351,column 4,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |351| 
        MOV       AH,#1525              ; [CPU_ALU] |351| 
$C$DW$191	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$191, DW_AT_low_pc(0x00)
	.dwattr $C$DW$191, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$191, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_getClock||] ; [] |351| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |351| 
        MOV       AL,#6641              ; [CPU_ALU] |351| 
        MOV       AH,#1398              ; [CPU_ALU] |351| 
        MOVL      XT,ACC                ; [CPU_ALU] |351| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |351| 
        MOV       T,#38                 ; [CPU_FPU] |351| 
        LSR64     ACC:P,T               ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
$C$DW$192	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$192, DW_AT_low_pc(0x00)
	.dwattr $C$DW$192, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$192, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_delay||] ; [] |351| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOV       ACC,#512 << 15        ; [CPU_ALU] |472| 
        MOVL      XAR4,#32514           ; [CPU_ARAU] |472| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 351,column 4,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |351| 
        MOV       AH,#1525              ; [CPU_ALU] |351| 
$C$DW$193	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$193, DW_AT_low_pc(0x00)
	.dwattr $C$DW$193, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$193, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_getClock||] ; [] |351| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |351| 
        MOV       AL,#6641              ; [CPU_ALU] |351| 
        MOV       AH,#1398              ; [CPU_ALU] |351| 
        MOVL      XT,ACC                ; [CPU_ALU] |351| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |351| 
        MOV       T,#38                 ; [CPU_FPU] |351| 
        LSR64     ACC:P,T               ; [CPU_ALU] |351| 
        MOVL      ACC,P                 ; [CPU_ALU] |351| 
$C$DW$194	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$194, DW_AT_low_pc(0x00)
	.dwattr $C$DW$194, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$194, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |351| 
        ; call occurs [#||SysCtl_delay||] ; [] |351| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#524288          ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
||$C$L19||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L19||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#24832             ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L20||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L20||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
||$C$L21||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L21||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOVB      AL,#5                 ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L22||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L22||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
||$C$L23||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L23||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#256               ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L24||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L24||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR5,#32514           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 186,column 5,is_stmt,isa 0
        MOVL      XAR6,#10000           ; [CPU_ARAU] |186| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 186,column 5,is_stmt,isa 0
        MOVL      ACC,XAR6              ; [CPU_ALU] |186| 
$C$DW$195	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$195, DW_AT_low_pc(0x00)
	.dwattr $C$DW$195, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$195, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |186| 
        ; call occurs [#||SysCtl_delay||] ; [] |186| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#524288          ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
||$C$L25||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L25||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#24832             ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L26||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L26||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
||$C$L27||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L27||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L28||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L28||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
||$C$L29||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L29||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#256               ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L30||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L30||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR5,#32514           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 205,column 5,is_stmt,isa 0
        MOVL      XAR6,#100000          ; [CPU_ARAU] |205| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 205,column 5,is_stmt,isa 0
        MOVL      ACC,XAR6              ; [CPU_ALU] |205| 
$C$DW$196	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$196, DW_AT_low_pc(0x00)
	.dwattr $C$DW$196, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$196, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |205| 
        ; call occurs [#||SysCtl_delay||] ; [] |205| 
	.dwpsn	file "../bts_hal.c",line 224,column 5,is_stmt,isa 0
        MOVL      XAR4,#100000          ; [CPU_ARAU] |224| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |224| 
$C$DW$197	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$197, DW_AT_low_pc(0x00)
	.dwattr $C$DW$197, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$197, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |224| 
        ; call occurs [#||SysCtl_delay||] ; [] |224| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#524288          ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
||$C$L31||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L31||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#24960             ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L32||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L32||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
||$C$L33||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L33||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#65347             ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L34||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L34||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR5,#32514           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 241,column 5,is_stmt,isa 0
        MOVL      XAR6,#10000           ; [CPU_ARAU] |241| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 241,column 5,is_stmt,isa 0
        MOVL      ACC,XAR6              ; [CPU_ALU] |241| 
$C$DW$198	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$198, DW_AT_low_pc(0x00)
	.dwattr $C$DW$198, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$198, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |241| 
        ; call occurs [#||SysCtl_delay||] ; [] |241| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$199	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$199, DW_AT_low_pc(0x00)
	.dwattr $C$DW$199, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$186, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$186, DW_AT_TI_end_line(0xf5)
	.dwattr $C$DW$186, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$186

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupExAdcGpio_Adc2||

$C$DW$200	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$200, DW_AT_name("BTS_HAL_setupExAdcGpio_Adc2")
	.dwattr $C$DW$200, DW_AT_low_pc(||BTS_HAL_setupExAdcGpio_Adc2||)
	.dwattr $C$DW$200, DW_AT_high_pc(0x00)
	.dwattr $C$DW$200, DW_AT_linkage_name("BTS_HAL_setupExAdcGpio_Adc2")
	.dwattr $C$DW$200, DW_AT_external
	.dwattr $C$DW$200, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$200, DW_AT_decl_line(0x184)
	.dwattr $C$DW$200, DW_AT_decl_column(0x06)
	.dwattr $C$DW$200, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts_hal.c",line 389,column 1,is_stmt,address ||BTS_HAL_setupExAdcGpio_Adc2||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupExAdcGpio_Adc2||

;***************************************************************
;* FNAME: BTS_HAL_setupExAdcGpio_Adc2   FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupExAdcGpio_Adc2||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts_hal.c",line 391,column 5,is_stmt,isa 0
        MOV       ACC,#9217 << 9        ; [CPU_ALU] |391| 
$C$DW$201	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$201, DW_AT_low_pc(0x00)
	.dwattr $C$DW$201, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$201, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |391| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |391| 
	.dwpsn	file "../bts_hal.c",line 392,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |392| 
        MOVB      ACC,#49               ; [CPU_ALU] |392| 
$C$DW$202	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$202, DW_AT_low_pc(0x00)
	.dwattr $C$DW$202, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$202, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |392| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |392| 
	.dwpsn	file "../bts_hal.c",line 393,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |393| 
        MOVB      ACC,#49               ; [CPU_ALU] |393| 
$C$DW$203	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$203, DW_AT_low_pc(0x00)
	.dwattr $C$DW$203, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$203, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |393| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |393| 
	.dwpsn	file "../bts_hal.c",line 397,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |397| 
        MOVB      ACC,#49               ; [CPU_ALU] |397| 
$C$DW$204	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$204, DW_AT_low_pc(0x00)
	.dwattr $C$DW$204, DW_AT_name("GPIO_setInterruptPin")
	.dwattr $C$DW$204, DW_AT_TI_call

        LCR       #||GPIO_setInterruptPin|| ; [CPU_ALU] |397| 
        ; call occurs [#||GPIO_setInterruptPin||] ; [] |397| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 274,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7071)        ; [CPU_ALU] |274| 
        AND       AL,#0xfff3            ; [CPU_ALU] |274| 
	.dwpsn	file "../bts_hal.c",line 411,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_FPU] |411| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 274,column 5,is_stmt,isa 0
        MOV       *(0:0x7071),AL        ; [CPU_ALU] |274| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 339,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7071)        ; [CPU_ALU] |339| 
        ORB       AL,#0x01              ; [CPU_ALU] |339| 
        MOV       *(0:0x7071),AL        ; [CPU_ALU] |339| 
	.dwpsn	file "../bts_hal.c",line 411,column 5,is_stmt,isa 0
        MOVB      ACC,#48               ; [CPU_ALU] |411| 
$C$DW$205	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$205, DW_AT_low_pc(0x00)
	.dwattr $C$DW$205, DW_AT_name("GPIO_setAnalogMode")
	.dwattr $C$DW$205, DW_AT_TI_call

        LCR       #||GPIO_setAnalogMode|| ; [CPU_ALU] |411| 
        ; call occurs [#||GPIO_setAnalogMode||] ; [] |411| 
	.dwpsn	file "../bts_hal.c",line 413,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |413| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |413| 
        MOVB      ACC,#48               ; [CPU_ALU] |413| 
$C$DW$206	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$206, DW_AT_low_pc(0x00)
	.dwattr $C$DW$206, DW_AT_name("GPIO_setPadConfig")
	.dwattr $C$DW$206, DW_AT_TI_call

        LCR       #||GPIO_setPadConfig|| ; [CPU_ALU] |413| 
        ; call occurs [#||GPIO_setPadConfig||] ; [] |413| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR4,#65536           ; [CPU_ARAU] |472| 
        MOVL      XAR5,#32522           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 415,column 5,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |415| 
        MOV       AH,#72                ; [CPU_ALU] |415| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 415,column 5,is_stmt,isa 0
$C$DW$207	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$207, DW_AT_low_pc(0x00)
	.dwattr $C$DW$207, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$207, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |415| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |415| 
	.dwpsn	file "../bts_hal.c",line 416,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |416| 
        MOVB      ACC,#48               ; [CPU_ALU] |416| 
$C$DW$208	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$208, DW_AT_low_pc(0x00)
	.dwattr $C$DW$208, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$208, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |416| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |416| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$209	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$209, DW_AT_low_pc(0x00)
	.dwattr $C$DW$209, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$200, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$200, DW_AT_TI_end_line(0x1a1)
	.dwattr $C$DW$200, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$200

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupExAdcGpio_Adc1||

$C$DW$210	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$210, DW_AT_name("BTS_HAL_setupExAdcGpio_Adc1")
	.dwattr $C$DW$210, DW_AT_low_pc(||BTS_HAL_setupExAdcGpio_Adc1||)
	.dwattr $C$DW$210, DW_AT_high_pc(0x00)
	.dwattr $C$DW$210, DW_AT_linkage_name("BTS_HAL_setupExAdcGpio_Adc1")
	.dwattr $C$DW$210, DW_AT_external
	.dwattr $C$DW$210, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$210, DW_AT_decl_line(0x165)
	.dwattr $C$DW$210, DW_AT_decl_column(0x06)
	.dwattr $C$DW$210, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts_hal.c",line 358,column 1,is_stmt,address ||BTS_HAL_setupExAdcGpio_Adc1||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupExAdcGpio_Adc1||

;***************************************************************
;* FNAME: BTS_HAL_setupExAdcGpio_Adc1   FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupExAdcGpio_Adc1||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts_hal.c",line 360,column 5,is_stmt,isa 0
        MOVL      XAR4,#528896          ; [CPU_ARAU] |360| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |360| 
$C$DW$211	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$211, DW_AT_low_pc(0x00)
	.dwattr $C$DW$211, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$211, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |360| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |360| 
	.dwpsn	file "../bts_hal.c",line 361,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |361| 
        MOVB      ACC,#25               ; [CPU_ALU] |361| 
$C$DW$212	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$212, DW_AT_low_pc(0x00)
	.dwattr $C$DW$212, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$212, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |361| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |361| 
	.dwpsn	file "../bts_hal.c",line 362,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |362| 
        MOVB      ACC,#25               ; [CPU_ALU] |362| 
$C$DW$213	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$213, DW_AT_low_pc(0x00)
	.dwattr $C$DW$213, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$213, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |362| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |362| 
	.dwpsn	file "../bts_hal.c",line 366,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |366| 
        MOVB      ACC,#25               ; [CPU_ALU] |366| 
$C$DW$214	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$214, DW_AT_low_pc(0x00)
	.dwattr $C$DW$214, DW_AT_name("GPIO_setInterruptPin")
	.dwattr $C$DW$214, DW_AT_TI_call

        LCR       #||GPIO_setInterruptPin|| ; [CPU_ALU] |366| 
        ; call occurs [#||GPIO_setInterruptPin||] ; [] |366| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 274,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7070)        ; [CPU_ALU] |274| 
        AND       AL,#0xfff3            ; [CPU_ALU] |274| 
	.dwpsn	file "../bts_hal.c",line 380,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_FPU] |380| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 274,column 5,is_stmt,isa 0
        MOV       *(0:0x7070),AL        ; [CPU_ALU] |274| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 339,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7070)        ; [CPU_ALU] |339| 
        ORB       AL,#0x01              ; [CPU_ALU] |339| 
        MOV       *(0:0x7070),AL        ; [CPU_ALU] |339| 
	.dwpsn	file "../bts_hal.c",line 380,column 5,is_stmt,isa 0
        MOVB      ACC,#24               ; [CPU_ALU] |380| 
$C$DW$215	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$215, DW_AT_low_pc(0x00)
	.dwattr $C$DW$215, DW_AT_name("GPIO_setAnalogMode")
	.dwattr $C$DW$215, DW_AT_TI_call

        LCR       #||GPIO_setAnalogMode|| ; [CPU_ALU] |380| 
        ; call occurs [#||GPIO_setAnalogMode||] ; [] |380| 
	.dwpsn	file "../bts_hal.c",line 382,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |382| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |382| 
        MOVB      ACC,#24               ; [CPU_ALU] |382| 
$C$DW$216	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$216, DW_AT_low_pc(0x00)
	.dwattr $C$DW$216, DW_AT_name("GPIO_setPadConfig")
	.dwattr $C$DW$216, DW_AT_TI_call

        LCR       #||GPIO_setPadConfig|| ; [CPU_ALU] |382| 
        ; call occurs [#||GPIO_setPadConfig||] ; [] |382| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOV       ACC,#512 << 15        ; [CPU_ALU] |472| 
        MOVL      XAR4,#32514           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 384,column 5,is_stmt,isa 0
        MOVL      XAR5,#528384          ; [CPU_ARAU] |384| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 384,column 5,is_stmt,isa 0
        MOVL      ACC,XAR5              ; [CPU_ALU] |384| 
$C$DW$217	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$217, DW_AT_low_pc(0x00)
	.dwattr $C$DW$217, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$217, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |384| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |384| 
	.dwpsn	file "../bts_hal.c",line 385,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |385| 
        MOVB      ACC,#24               ; [CPU_ALU] |385| 
$C$DW$218	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$218, DW_AT_low_pc(0x00)
	.dwattr $C$DW$218, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$218, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |385| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |385| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$219	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$219, DW_AT_low_pc(0x00)
	.dwattr $C$DW$219, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$210, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$210, DW_AT_TI_end_line(0x182)
	.dwattr $C$DW$210, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$210

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupDevice||

$C$DW$220	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$220, DW_AT_name("BTS_HAL_setupDevice")
	.dwattr $C$DW$220, DW_AT_low_pc(||BTS_HAL_setupDevice||)
	.dwattr $C$DW$220, DW_AT_high_pc(0x00)
	.dwattr $C$DW$220, DW_AT_linkage_name("BTS_HAL_setupDevice")
	.dwattr $C$DW$220, DW_AT_external
	.dwattr $C$DW$220, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$220, DW_AT_decl_line(0x33)
	.dwattr $C$DW$220, DW_AT_decl_column(0x06)
	.dwattr $C$DW$220, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 52,column 1,is_stmt,address ||BTS_HAL_setupDevice||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupDevice||

;***************************************************************
;* FNAME: BTS_HAL_setupDevice           FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupDevice||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../bts_hal.c",line 56,column 5,is_stmt,isa 0
$C$DW$221	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$221, DW_AT_low_pc(0x00)
	.dwattr $C$DW$221, DW_AT_name("Device_init")
	.dwattr $C$DW$221, DW_AT_TI_call

        LCR       #||Device_init||      ; [CPU_ALU] |56| 
        ; call occurs [#||Device_init||] ; [] |56| 
	.dwpsn	file "../bts_hal.c",line 61,column 5,is_stmt,isa 0
$C$DW$222	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$222, DW_AT_low_pc(0x00)
	.dwattr $C$DW$222, DW_AT_name("Device_initGPIO")
	.dwattr $C$DW$222, DW_AT_TI_call

        LCR       #||Device_initGPIO||  ; [CPU_ALU] |61| 
        ; call occurs [#||Device_initGPIO||] ; [] |61| 
	.dwpsn	file "../bts_hal.c",line 66,column 5,is_stmt,isa 0
$C$DW$223	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$223, DW_AT_low_pc(0x00)
	.dwattr $C$DW$223, DW_AT_name("Interrupt_initModule")
	.dwattr $C$DW$223, DW_AT_TI_call

        LCR       #||Interrupt_initModule|| ; [CPU_ALU] |66| 
        ; call occurs [#||Interrupt_initModule||] ; [] |66| 
	.dwpsn	file "../bts_hal.c",line 72,column 5,is_stmt,isa 0
$C$DW$224	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$224, DW_AT_low_pc(0x00)
	.dwattr $C$DW$224, DW_AT_name("Interrupt_initVectorTable")
	.dwattr $C$DW$224, DW_AT_TI_call

        LCR       #||Interrupt_initVectorTable|| ; [CPU_ALU] |72| 
        ; call occurs [#||Interrupt_initVectorTable||] ; [] |72| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 327,column 5,is_stmt,isa 0
        MOVL      XAR6,#160000          ; [CPU_ARAU] |327| 
        MOVL      XAR7,#3074            ; [CPU_ARAU] |327| 
        MOVL      XAR4,#800000          ; [CPU_ARAU] |327| 
        MOVL      XAR5,#3082            ; [CPU_ARAU] |327| 
        MOV       ACC,#15625 << 9       ; [CPU_ALU] |327| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 372,column 5,is_stmt,isa 0
        MOV       PL,#0                 ; [CPU_ALU] |372| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 327,column 5,is_stmt,isa 0
        MOVL      *+XAR7[0],XAR6        ; [CPU_ALU] |327| 
        MOVL      XAR6,#3090            ; [CPU_ARAU] |327| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 371,column 5,is_stmt,isa 0
        MOVB      XAR7,#0               ; [CPU_ALU] |371| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 327,column 5,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |327| 
        MOVL      *+XAR6[0],ACC         ; [CPU_ALU] |327| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 371,column 5,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |371| 
        MOVB      XAR6,#0               ; [CPU_ALU] |371| 
	.dwpsn	file "../bts_hal.c",line 114,column 5,is_stmt,isa 0
        MOVL      XAR5,#3072            ; [CPU_ARAU] |114| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 372,column 5,is_stmt,isa 0
        MOVB      AH,#0                 ; [CPU_ALU] |372| 
	.dwpsn	file "../bts_hal.c",line 114,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |114| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 371,column 5,is_stmt,isa 0
        MOV       *(0:0x0c07),AR7       ; [CPU_ALU] |371| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 372,column 5,is_stmt,isa 0
        MOV       *(0:0x0c06),PL        ; [CPU_ALU] |372| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 371,column 5,is_stmt,isa 0
        MOV       *(0:0x0c0f),AL        ; [CPU_ALU] |371| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 372,column 5,is_stmt,isa 0
        MOV       *(0:0x0c0e),AR7       ; [CPU_ALU] |372| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 371,column 5,is_stmt,isa 0
        MOV       *(0:0x0c17),AR6       ; [CPU_ALU] |371| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 372,column 5,is_stmt,isa 0
        MOV       *(0:0x0c16),AH        ; [CPU_ALU] |372| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 254,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c04)        ; [CPU_ALU] |254| 
        ORB       AL,#0x10              ; [CPU_ALU] |254| 
        MOV       *(0:0x0c04),AL        ; [CPU_ALU] |254| 
        MOV       AL,*(0:0x0c0c)        ; [CPU_ALU] |254| 
        ORB       AL,#0x10              ; [CPU_ALU] |254| 
        MOV       *(0:0x0c0c),AL        ; [CPU_ALU] |254| 
        MOV       AL,*(0:0x0c14)        ; [CPU_ALU] |254| 
        ORB       AL,#0x10              ; [CPU_ALU] |254| 
        MOV       *(0:0x0c14),AL        ; [CPU_ALU] |254| 
	.dwpsn	file "../bts_hal.c",line 114,column 5,is_stmt,isa 0
        MOVL      ACC,XAR5              ; [CPU_ALU] |114| 
$C$DW$225	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$225, DW_AT_low_pc(0x00)
	.dwattr $C$DW$225, DW_AT_name("CPUTimer_setEmulationMode")
	.dwattr $C$DW$225, DW_AT_TI_call

        LCR       #||CPUTimer_setEmulationMode|| ; [CPU_ALU] |114| 
        ; call occurs [#||CPUTimer_setEmulationMode||] ; [] |114| 
	.dwpsn	file "../bts_hal.c",line 116,column 5,is_stmt,isa 0
        MOVL      XAR5,#3080            ; [CPU_ARAU] |116| 
        MOVB      XAR4,#0               ; [CPU_ALU] |116| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |116| 
$C$DW$226	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$226, DW_AT_low_pc(0x00)
	.dwattr $C$DW$226, DW_AT_name("CPUTimer_setEmulationMode")
	.dwattr $C$DW$226, DW_AT_TI_call

        LCR       #||CPUTimer_setEmulationMode|| ; [CPU_ALU] |116| 
        ; call occurs [#||CPUTimer_setEmulationMode||] ; [] |116| 
	.dwpsn	file "../bts_hal.c",line 118,column 5,is_stmt,isa 0
        MOVL      XAR5,#3088            ; [CPU_ARAU] |118| 
        MOVB      XAR4,#0               ; [CPU_ALU] |118| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |118| 
$C$DW$227	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$227, DW_AT_low_pc(0x00)
	.dwattr $C$DW$227, DW_AT_name("CPUTimer_setEmulationMode")
	.dwattr $C$DW$227, DW_AT_TI_call

        LCR       #||CPUTimer_setEmulationMode|| ; [CPU_ALU] |118| 
        ; call occurs [#||CPUTimer_setEmulationMode||] ; [] |118| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 300,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c04)        ; [CPU_ALU] |300| 
        ORB       AL,#0x20              ; [CPU_ALU] |300| 
        MOV       *(0:0x0c04),AL        ; [CPU_ALU] |300| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 305,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c04)        ; [CPU_ALU] |305| 
        AND       AL,#0xffef            ; [CPU_ALU] |305| 
        MOV       *(0:0x0c04),AL        ; [CPU_ALU] |305| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 300,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c0c)        ; [CPU_ALU] |300| 
        ORB       AL,#0x20              ; [CPU_ALU] |300| 
        MOV       *(0:0x0c0c),AL        ; [CPU_ALU] |300| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 305,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c0c)        ; [CPU_ALU] |305| 
        AND       AL,#0xffef            ; [CPU_ALU] |305| 
        MOV       *(0:0x0c0c),AL        ; [CPU_ALU] |305| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 300,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c14)        ; [CPU_ALU] |300| 
        ORB       AL,#0x20              ; [CPU_ALU] |300| 
        MOV       *(0:0x0c14),AL        ; [CPU_ALU] |300| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 305,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c14)        ; [CPU_ALU] |305| 
        AND       AL,#0xffef            ; [CPU_ALU] |305| 
        MOV       *(0:0x0c14),AL        ; [CPU_ALU] |305| 
$C$DW$228	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$228, DW_AT_low_pc(0x00)
	.dwattr $C$DW$228, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$220, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$220, DW_AT_TI_end_line(0x7f)
	.dwattr $C$DW$220, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$220

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupCanBus||

$C$DW$229	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$229, DW_AT_name("BTS_HAL_setupCanBus")
	.dwattr $C$DW$229, DW_AT_low_pc(||BTS_HAL_setupCanBus||)
	.dwattr $C$DW$229, DW_AT_high_pc(0x00)
	.dwattr $C$DW$229, DW_AT_linkage_name("BTS_HAL_setupCanBus")
	.dwattr $C$DW$229, DW_AT_external
	.dwattr $C$DW$229, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$229, DW_AT_decl_line(0x368)
	.dwattr $C$DW$229, DW_AT_decl_column(0x06)
	.dwattr $C$DW$229, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 873,column 1,is_stmt,address ||BTS_HAL_setupCanBus||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupCanBus||
$C$DW$230	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$230, DW_AT_name("I2C_BASE")
	.dwattr $C$DW$230, DW_AT_type(*$C$DW$T$95)
	.dwattr $C$DW$230, DW_AT_location[DW_OP_reg0]


;***************************************************************
;* FNAME: BTS_HAL_setupCanBus           FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupCanBus||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
$C$DW$231	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$231, DW_AT_low_pc(0x00)
	.dwattr $C$DW$231, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$229, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$229, DW_AT_TI_end_line(0x36b)
	.dwattr $C$DW$229, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$229

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupAdcClock||

$C$DW$232	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$232, DW_AT_name("BTS_HAL_setupAdcClock")
	.dwattr $C$DW$232, DW_AT_low_pc(||BTS_HAL_setupAdcClock||)
	.dwattr $C$DW$232, DW_AT_high_pc(0x00)
	.dwattr $C$DW$232, DW_AT_linkage_name("BTS_HAL_setupAdcClock")
	.dwattr $C$DW$232, DW_AT_external
	.dwattr $C$DW$232, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$232, DW_AT_decl_line(0x2c3)
	.dwattr $C$DW$232, DW_AT_decl_column(0x06)
	.dwattr $C$DW$232, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "../bts_hal.c",line 708,column 1,is_stmt,address ||BTS_HAL_setupAdcClock||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupAdcClock||
$C$DW$233	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$233, DW_AT_name("EPWM_BASE")
	.dwattr $C$DW$233, DW_AT_type(*$C$DW$T$95)
	.dwattr $C$DW$233, DW_AT_location[DW_OP_reg0]


;***************************************************************
;* FNAME: BTS_HAL_setupAdcClock         FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  4 SOE     *
;***************************************************************

||BTS_HAL_setupAdcClock||:
;* AR4   assigned to $O$C1
;* AR2   assigned to EPWM_BASE
$C$DW$234	.dwtag  DW_TAG_variable
	.dwattr $C$DW$234, DW_AT_name("EPWM_BASE")
	.dwattr $C$DW$234, DW_AT_type(*$C$DW$T$156)
	.dwattr $C$DW$234, DW_AT_location[DW_OP_reg8]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
        MOVL      *SP++,XAR2            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 9, 4
	.dwcfi	cfa_offset, -6
        MOVL      XAR2,ACC              ; [CPU_ALU] |708| 
	.dwpsn	file "../bts_hal.c",line 716,column 5,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |716| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1591,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xe07f     ; [CPU_ALU] |1591| 
	.dwpsn	file "../bts_hal.c",line 716,column 5,is_stmt,isa 0
$C$DW$235	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$235, DW_AT_low_pc(0x00)
	.dwattr $C$DW$235, DW_AT_name("EPWM_setEmulationMode")
	.dwattr $C$DW$235, DW_AT_TI_call

        LCR       #||EPWM_setEmulationMode|| ; [CPU_ALU] |716| 
        ; call occurs [#||EPWM_setEmulationMode||] ; [] |716| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2146,column 5,is_stmt,isa 0
        MOVB      XAR0,#99              ; [CPU_ALU] |2146| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1513,column 5,is_stmt,isa 0
        MOV       *+XAR2[4],#0          ; [CPU_ALU] |1513| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2301,column 5,is_stmt,isa 0
        MOVL      XAR4,XAR2             ; [CPU_ALU] |2301| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      XAR1,#109             ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2146,column 5,is_stmt,isa 0
        MOVB      *+XAR2[AR0],#9,UNC    ; [CPU_ALU] |2146| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      XAR0,#107             ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2301,column 5,is_stmt,isa 0
        ADDB      XAR4,#8               ; [CPU_ALU] |2301| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1723,column 9,is_stmt,isa 0
        AND       *+XAR2[0],#0xfff7     ; [CPU_ALU] |1723| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1813,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xfffc     ; [CPU_ALU] |1813| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1782,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xfffb     ; [CPU_ALU] |1782| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      *+XAR2[AR0],#4,UNC    ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2558,column 5,is_stmt,isa 0
        MOVB      XAR0,#16              ; [CPU_ALU] |2558| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      *+XAR2[AR1],#5,UNC    ; [CPU_FPU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2558,column 5,is_stmt,isa 0
        MOVB      XAR1,#16              ; [CPU_FPU] |2558| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1813,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xfffc     ; [CPU_FPU] |1813| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1782,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xfffb     ; [CPU_FPU] |1782| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1591,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xe07f     ; [CPU_FPU] |1591| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2301,column 5,is_stmt,isa 0
        AND       AL,*+XAR4[0],#0xf3ec  ; [CPU_ALU] |2301| 
        ORB       AL,#0x01              ; [CPU_ALU] |2301| 
        MOV       *+XAR4[0],AL          ; [CPU_ALU] |2301| 
        AND       AL,*+XAR4[0],#0xcfb7  ; [CPU_ALU] |2301| 
        ORB       AL,#0x04              ; [CPU_ALU] |2301| 
        MOV       *+XAR4[0],AL          ; [CPU_ALU] |2301| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2558,column 5,is_stmt,isa 0
        AND       AL,*+XAR2[AR0],#0xfcfc ; [CPU_ALU] |2558| 
        ORB       AL,#0x11              ; [CPU_ALU] |2558| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2758,column 9,is_stmt,isa 0
        MOVB      XAR0,#64              ; [CPU_ALU] |2758| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2558,column 5,is_stmt,isa 0
        MOV       *+XAR2[AR1],AL        ; [CPU_ALU] |2558| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2758,column 9,is_stmt,isa 0
        MOVB      XAR1,#64              ; [CPU_ALU] |2758| 
        MOV       AL,*+XAR2[AR0]        ; [CPU_ALU] |2758| 
        ORB       AL,#0x03              ; [CPU_ALU] |2758| 
        MOVB      XAR0,#64              ; [CPU_ALU] |2758| 
        MOV       *+XAR2[AR1],AL        ; [CPU_ALU] |2758| 
        MOV       AL,*+XAR2[AR0]        ; [CPU_ALU] |2758| 
        MOVB      XAR0,#64              ; [CPU_ALU] |2758| 
        ORB       AL,#0x30              ; [CPU_ALU] |2758| 
        MOV       *+XAR2[AR0],AL        ; [CPU_ALU] |2758| 
        MOVL      XAR2,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 9
        MOVL      XAR1,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$236	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$236, DW_AT_low_pc(0x00)
	.dwattr $C$DW$236, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$232, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$232, DW_AT_TI_end_line(0x321)
	.dwattr $C$DW$232, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$232

	.sect	".text"
	.clink
	.global	||BTS_HAL_enableEpwmCounting||

$C$DW$237	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$237, DW_AT_name("BTS_HAL_enableEpwmCounting")
	.dwattr $C$DW$237, DW_AT_low_pc(||BTS_HAL_enableEpwmCounting||)
	.dwattr $C$DW$237, DW_AT_high_pc(0x00)
	.dwattr $C$DW$237, DW_AT_linkage_name("BTS_HAL_enableEpwmCounting")
	.dwattr $C$DW$237, DW_AT_external
	.dwattr $C$DW$237, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$237, DW_AT_decl_line(0x375)
	.dwattr $C$DW$237, DW_AT_decl_column(0x06)
	.dwattr $C$DW$237, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 886,column 1,is_stmt,address ||BTS_HAL_enableEpwmCounting||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_enableEpwmCounting||

;***************************************************************
;* FNAME: BTS_HAL_enableEpwmCounting    FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_enableEpwmCounting||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 887,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |887| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 892,column 5,is_stmt,isa 0
        MOVL      XAR4,#381730          ; [CPU_ARAU] |892| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |892| 
        OR        AH,#4                 ; [CPU_ALU] |892| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |892| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 894,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |894| 
$C$DW$238	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$238, DW_AT_low_pc(0x00)
	.dwattr $C$DW$238, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$237, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$237, DW_AT_TI_end_line(0x378)
	.dwattr $C$DW$237, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$237

	.sect	".text"
	.clink
	.global	||BTS_HAL_disableEpwmCounting||

$C$DW$239	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$239, DW_AT_name("BTS_HAL_disableEpwmCounting")
	.dwattr $C$DW$239, DW_AT_low_pc(||BTS_HAL_disableEpwmCounting||)
	.dwattr $C$DW$239, DW_AT_high_pc(0x00)
	.dwattr $C$DW$239, DW_AT_linkage_name("BTS_HAL_disableEpwmCounting")
	.dwattr $C$DW$239, DW_AT_external
	.dwattr $C$DW$239, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$239, DW_AT_decl_line(0x37a)
	.dwattr $C$DW$239, DW_AT_decl_column(0x06)
	.dwattr $C$DW$239, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 890,column 39,is_stmt,address ||BTS_HAL_disableEpwmCounting||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_disableEpwmCounting||

;***************************************************************
;* FNAME: BTS_HAL_disableEpwmCounting   FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_disableEpwmCounting||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 923,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |923| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 928,column 5,is_stmt,isa 0
        MOVL      XAR4,#381730          ; [CPU_ARAU] |928| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |928| 
        AND       AH,#65531             ; [CPU_ALU] |928| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |928| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 930,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |930| 
$C$DW$240	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$240, DW_AT_low_pc(0x00)
	.dwattr $C$DW$240, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$239, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$239, DW_AT_TI_end_line(0x37d)
	.dwattr $C$DW$239, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$239

	.sect	".text"
	.clink
	.global	||BTS_HAL_SetupSpiPinsGpio_Adc2||

$C$DW$241	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$241, DW_AT_name("BTS_HAL_SetupSpiPinsGpio_Adc2")
	.dwattr $C$DW$241, DW_AT_low_pc(||BTS_HAL_SetupSpiPinsGpio_Adc2||)
	.dwattr $C$DW$241, DW_AT_high_pc(0x00)
	.dwattr $C$DW$241, DW_AT_linkage_name("BTS_HAL_SetupSpiPinsGpio_Adc2")
	.dwattr $C$DW$241, DW_AT_external
	.dwattr $C$DW$241, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$241, DW_AT_decl_line(0x3f4)
	.dwattr $C$DW$241, DW_AT_decl_column(0x06)
	.dwattr $C$DW$241, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts_hal.c",line 1012,column 41,is_stmt,address ||BTS_HAL_SetupSpiPinsGpio_Adc2||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_SetupSpiPinsGpio_Adc2||

;***************************************************************
;* FNAME: BTS_HAL_SetupSpiPinsGpio_Adc2 FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_SetupSpiPinsGpio_Adc2||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts_hal.c",line 1015,column 5,is_stmt,isa 0
        MOVB      ACC,#50               ; [CPU_ALU] |1015| 
        MOVB      XAR4,#3               ; [CPU_ALU] |1015| 
$C$DW$242	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$242, DW_AT_low_pc(0x00)
	.dwattr $C$DW$242, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$242, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |1015| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |1015| 
	.dwpsn	file "../bts_hal.c",line 1016,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |1016| 
        MOVB      ACC,#51               ; [CPU_ALU] |1016| 
$C$DW$243	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$243, DW_AT_low_pc(0x00)
	.dwattr $C$DW$243, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$243, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |1016| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |1016| 
	.dwpsn	file "../bts_hal.c",line 1017,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |1017| 
        MOVB      ACC,#48               ; [CPU_ALU] |1017| 
$C$DW$244	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$244, DW_AT_low_pc(0x00)
	.dwattr $C$DW$244, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$244, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |1017| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |1017| 
	.dwpsn	file "../bts_hal.c",line 1018,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |1018| 
        MOVB      ACC,#52               ; [CPU_ALU] |1018| 
$C$DW$245	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$245, DW_AT_low_pc(0x00)
	.dwattr $C$DW$245, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$245, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |1018| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |1018| 
	.dwpsn	file "../bts_hal.c",line 1019,column 5,is_stmt,isa 0
        MOV       AL,#1030              ; [CPU_ALU] |1019| 
        MOV       AH,#72                ; [CPU_ALU] |1019| 
$C$DW$246	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$246, DW_AT_low_pc(0x00)
	.dwattr $C$DW$246, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$246, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |1019| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |1019| 
	.dwpsn	file "../bts_hal.c",line 1020,column 5,is_stmt,isa 0
        MOV       AL,#1542              ; [CPU_ALU] |1020| 
        MOV       AH,#72                ; [CPU_ALU] |1020| 
$C$DW$247	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$247, DW_AT_low_pc(0x00)
	.dwattr $C$DW$247, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$247, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |1020| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |1020| 
	.dwpsn	file "../bts_hal.c",line 1021,column 5,is_stmt,isa 0
        MOV       AL,#2054              ; [CPU_ALU] |1021| 
        MOV       AH,#72                ; [CPU_ALU] |1021| 
$C$DW$248	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$248, DW_AT_low_pc(0x00)
	.dwattr $C$DW$248, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$248, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |1021| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |1021| 
	.dwpsn	file "../bts_hal.c",line 1024,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |1024| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |1024| 
        MOVB      ACC,#53               ; [CPU_ALU] |1024| 
$C$DW$249	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$249, DW_AT_low_pc(0x00)
	.dwattr $C$DW$249, DW_AT_name("GPIO_setPadConfig")
	.dwattr $C$DW$249, DW_AT_TI_call

        LCR       #||GPIO_setPadConfig|| ; [CPU_ALU] |1024| 
        ; call occurs [#||GPIO_setPadConfig||] ; [] |1024| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR4,#2097152         ; [CPU_ARAU] |472| 
        MOVL      XAR5,#32522           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 1026,column 5,is_stmt,isa 0
        MOV       ACC,#9221 << 9        ; [CPU_ALU] |1026| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 1026,column 5,is_stmt,isa 0
$C$DW$250	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$250, DW_AT_low_pc(0x00)
	.dwattr $C$DW$250, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$250, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |1026| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |1026| 
	.dwpsn	file "../bts_hal.c",line 1027,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |1027| 
        MOVB      ACC,#53               ; [CPU_ALU] |1027| 
$C$DW$251	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$251, DW_AT_low_pc(0x00)
	.dwattr $C$DW$251, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$251, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |1027| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |1027| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$252	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$252, DW_AT_low_pc(0x00)
	.dwattr $C$DW$252, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$241, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$241, DW_AT_TI_end_line(0x404)
	.dwattr $C$DW$241, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$241

	.sect	".text"
	.clink
	.global	||BTS_HAL_SetupSpiPinsGpio_Adc1||

$C$DW$253	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$253, DW_AT_name("BTS_HAL_SetupSpiPinsGpio_Adc1")
	.dwattr $C$DW$253, DW_AT_low_pc(||BTS_HAL_SetupSpiPinsGpio_Adc1||)
	.dwattr $C$DW$253, DW_AT_high_pc(0x00)
	.dwattr $C$DW$253, DW_AT_linkage_name("BTS_HAL_SetupSpiPinsGpio_Adc1")
	.dwattr $C$DW$253, DW_AT_external
	.dwattr $C$DW$253, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$253, DW_AT_decl_line(0x3e2)
	.dwattr $C$DW$253, DW_AT_decl_column(0x06)
	.dwattr $C$DW$253, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts_hal.c",line 994,column 41,is_stmt,address ||BTS_HAL_SetupSpiPinsGpio_Adc1||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_SetupSpiPinsGpio_Adc1||

;***************************************************************
;* FNAME: BTS_HAL_SetupSpiPinsGpio_Adc1 FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_SetupSpiPinsGpio_Adc1||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts_hal.c",line 997,column 5,is_stmt,isa 0
        MOVB      ACC,#16               ; [CPU_ALU] |997| 
        MOVB      XAR4,#3               ; [CPU_ALU] |997| 
$C$DW$254	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$254, DW_AT_low_pc(0x00)
	.dwattr $C$DW$254, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$254, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |997| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |997| 
	.dwpsn	file "../bts_hal.c",line 998,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |998| 
        MOVB      ACC,#17               ; [CPU_ALU] |998| 
$C$DW$255	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$255, DW_AT_low_pc(0x00)
	.dwattr $C$DW$255, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$255, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |998| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |998| 
	.dwpsn	file "../bts_hal.c",line 999,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |999| 
        MOVB      ACC,#24               ; [CPU_ALU] |999| 
$C$DW$256	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$256, DW_AT_low_pc(0x00)
	.dwattr $C$DW$256, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$256, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |999| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |999| 
	.dwpsn	file "../bts_hal.c",line 1000,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |1000| 
        MOVB      ACC,#18               ; [CPU_ALU] |1000| 
$C$DW$257	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$257, DW_AT_low_pc(0x00)
	.dwattr $C$DW$257, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$257, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |1000| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |1000| 
	.dwpsn	file "../bts_hal.c",line 1001,column 5,is_stmt,isa 0
        MOVL      XAR4,#524289          ; [CPU_ARAU] |1001| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |1001| 
$C$DW$258	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$258, DW_AT_low_pc(0x00)
	.dwattr $C$DW$258, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$258, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |1001| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |1001| 
	.dwpsn	file "../bts_hal.c",line 1002,column 5,is_stmt,isa 0
        MOVL      XAR4,#524801          ; [CPU_ARAU] |1002| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |1002| 
$C$DW$259	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$259, DW_AT_low_pc(0x00)
	.dwattr $C$DW$259, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$259, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |1002| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |1002| 
	.dwpsn	file "../bts_hal.c",line 1003,column 5,is_stmt,isa 0
        MOVL      XAR4,#525313          ; [CPU_ARAU] |1003| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |1003| 
$C$DW$260	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$260, DW_AT_low_pc(0x00)
	.dwattr $C$DW$260, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$260, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |1003| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |1003| 
	.dwpsn	file "../bts_hal.c",line 1006,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |1006| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |1006| 
        MOVB      ACC,#19               ; [CPU_ALU] |1006| 
$C$DW$261	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$261, DW_AT_low_pc(0x00)
	.dwattr $C$DW$261, DW_AT_name("GPIO_setPadConfig")
	.dwattr $C$DW$261, DW_AT_TI_call

        LCR       #||GPIO_setPadConfig|| ; [CPU_ALU] |1006| 
        ; call occurs [#||GPIO_setPadConfig||] ; [] |1006| 
	.dwpsn	file "../bts_hal.c",line 1008,column 5,is_stmt,isa 0
        MOVL      XAR6,#525824          ; [CPU_ARAU] |1008| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR4,#524288          ; [CPU_ARAU] |472| 
        MOVL      XAR5,#32514           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 1008,column 5,is_stmt,isa 0
        MOVL      ACC,XAR6              ; [CPU_ALU] |1008| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 1008,column 5,is_stmt,isa 0
$C$DW$262	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$262, DW_AT_low_pc(0x00)
	.dwattr $C$DW$262, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$262, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |1008| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |1008| 
	.dwpsn	file "../bts_hal.c",line 1009,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |1009| 
        MOVB      ACC,#19               ; [CPU_ALU] |1009| 
$C$DW$263	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$263, DW_AT_low_pc(0x00)
	.dwattr $C$DW$263, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$263, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |1009| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |1009| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$264	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$264, DW_AT_low_pc(0x00)
	.dwattr $C$DW$264, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$253, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$253, DW_AT_TI_end_line(0x3f2)
	.dwattr $C$DW$253, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$253

	.sect	".text"
	.clink
	.global	||BTS_HAL_SetupSpi||

$C$DW$265	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$265, DW_AT_name("BTS_HAL_SetupSpi")
	.dwattr $C$DW$265, DW_AT_low_pc(||BTS_HAL_SetupSpi||)
	.dwattr $C$DW$265, DW_AT_high_pc(0x00)
	.dwattr $C$DW$265, DW_AT_linkage_name("BTS_HAL_SetupSpi")
	.dwattr $C$DW$265, DW_AT_external
	.dwattr $C$DW$265, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$265, DW_AT_decl_line(0x3c0)
	.dwattr $C$DW$265, DW_AT_decl_column(0x06)
	.dwattr $C$DW$265, DW_AT_TI_max_frame_size(-12)
	.dwpsn	file "../bts_hal.c",line 961,column 1,is_stmt,address ||BTS_HAL_SetupSpi||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_SetupSpi||
$C$DW$266	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$266, DW_AT_name("spiBase")
	.dwattr $C$DW$266, DW_AT_type(*$C$DW$T$95)
	.dwattr $C$DW$266, DW_AT_location[DW_OP_reg0]


;***************************************************************
;* FNAME: BTS_HAL_SetupSpi              FR SIZE:  10           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            5 Parameter,  0 Auto,  4 SOE     *
;***************************************************************

||BTS_HAL_SetupSpi||:
;* AR2   assigned to spiBase
$C$DW$267	.dwtag  DW_TAG_variable
	.dwattr $C$DW$267, DW_AT_name("spiBase")
	.dwattr $C$DW$267, DW_AT_type(*$C$DW$T$156)
	.dwattr $C$DW$267, DW_AT_location[DW_OP_reg8]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
        MOVL      *SP++,XAR2            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 9, 4
	.dwcfi	cfa_offset, -6
        ADDB      SP,#6                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -12
        MOVL      XAR2,ACC              ; [CPU_ALU] |961| 
	.dwpsn	file "../bts_hal.c",line 970,column 5,is_stmt,isa 0
        MOV       AL,#23040             ; [CPU_ALU] |970| 
        MOV       AH,#610               ; [CPU_ALU] |970| 
        MOVB      XAR4,#0               ; [CPU_ALU] |970| 
        MOVB      XAR5,#6               ; [CPU_ALU] |970| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 279,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xff7f     ; [CPU_ALU] |279| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 929,column 5,is_stmt,isa 0
        OR        *+XAR2[0],#0x0020     ; [CPU_ALU] |929| 
	.dwpsn	file "../bts_hal.c",line 970,column 5,is_stmt,isa 0
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |970| 
        MOV       AL,#38528             ; [CPU_ALU] |970| 
        MOV       AH,#152               ; [CPU_ALU] |970| 
        MOVL      *-SP[4],ACC           ; [CPU_ALU] |970| 
        MOVB      *-SP[5],#16,UNC       ; [CPU_ALU] |970| 
        MOVL      ACC,XAR2              ; [CPU_ALU] |970| 
$C$DW$268	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$268, DW_AT_low_pc(0x00)
	.dwattr $C$DW$268, DW_AT_name("SPI_setConfig")
	.dwattr $C$DW$268, DW_AT_TI_call

        LCR       #||SPI_setConfig||    ; [CPU_ALU] |970| 
        ; call occurs [#||SPI_setConfig||] ; [] |970| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 991,column 5,is_stmt,isa 0
        MOVB      XAR1,#15              ; [CPU_ALU] |991| 
        MOVB      XAR0,#15              ; [CPU_ALU] |991| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 304,column 5,is_stmt,isa 0
        MOVL      XAR5,XAR2             ; [CPU_ALU] |304| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 305,column 5,is_stmt,isa 0
        MOVL      XAR4,XAR2             ; [CPU_ALU] |305| 
	.dwpsn	file "../bts_hal.c",line 978,column 5,is_stmt,isa 0
        MOVB      XAR6,#14              ; [CPU_ALU] |978| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 991,column 5,is_stmt,isa 0
        AND       AL,*+XAR2[AR0],#0xffcf ; [CPU_ALU] |991| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 304,column 5,is_stmt,isa 0
        ADDB      XAR5,#10              ; [CPU_ALU] |304| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 305,column 5,is_stmt,isa 0
        ADDB      XAR4,#11              ; [CPU_ALU] |305| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 991,column 5,is_stmt,isa 0
        MOV       *+XAR2[AR1],AL        ; [CPU_ALU] |991| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 304,column 5,is_stmt,isa 0
        OR        *+XAR5[0],#0x6000     ; [CPU_FPU] |304| 
	.dwpsn	file "../bts_hal.c",line 978,column 5,is_stmt,isa 0
        MOVL      ACC,XAR2              ; [CPU_FPU] |978| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 305,column 5,is_stmt,isa 0
        OR        *+XAR4[0],#0x2000     ; [CPU_ALU] |305| 
	.dwpsn	file "../bts_hal.c",line 978,column 5,is_stmt,isa 0
        MOVL      *-SP[2],XAR6          ; [CPU_ALU] |978| 
$C$DW$269	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$269, DW_AT_low_pc(0x00)
	.dwattr $C$DW$269, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$269, DW_AT_TI_call

        LCR       #||SPI_clearInterruptStatus|| ; [CPU_ALU] |978| 
        ; call occurs [#||SPI_clearInterruptStatus||] ; [] |978| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 418,column 5,is_stmt,isa 0
        MOVB      XAR1,#10              ; [CPU_ALU] |418| 
        MOVB      XAR0,#10              ; [CPU_ALU] |418| 
	.dwpsn	file "../bts_hal.c",line 982,column 5,is_stmt,isa 0
        MOVB      XAR6,#12              ; [CPU_ALU] |982| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 418,column 5,is_stmt,isa 0
        AND       AL,*+XAR2[AR0],#0xffe0 ; [CPU_ALU] |418| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 420,column 5,is_stmt,isa 0
        MOVB      XAR0,#11              ; [CPU_ALU] |420| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 418,column 5,is_stmt,isa 0
        MOV       *+XAR2[AR1],AL        ; [CPU_ALU] |418| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 420,column 5,is_stmt,isa 0
        AND       AL,*+XAR2[AR0],#0xffe0 ; [CPU_ALU] |420| 
        MOVB      XAR0,#11              ; [CPU_ALU] |420| 
        ORB       AL,#0x0a              ; [CPU_ALU] |420| 
        MOV       *+XAR2[AR0],AL        ; [CPU_ALU] |420| 
	.dwpsn	file "../bts_hal.c",line 982,column 5,is_stmt,isa 0
        MOVL      ACC,XAR2              ; [CPU_ALU] |982| 
        MOVL      *-SP[2],XAR6          ; [CPU_ALU] |982| 
$C$DW$270	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$270, DW_AT_low_pc(0x00)
	.dwattr $C$DW$270, DW_AT_name("SPI_enableInterrupt")
	.dwattr $C$DW$270, DW_AT_TI_call

        LCR       #||SPI_enableInterrupt|| ; [CPU_ALU] |982| 
        ; call occurs [#||SPI_enableInterrupt||] ; [] |982| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 256,column 5,is_stmt,isa 0
        OR        *+XAR2[0],#0x0080     ; [CPU_ALU] |256| 
        SUBB      SP,#6                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
        MOVL      XAR2,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 9
        MOVL      XAR1,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$271	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$271, DW_AT_low_pc(0x00)
	.dwattr $C$DW$271, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$265, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$265, DW_AT_TI_end_line(0x3e0)
	.dwattr $C$DW$265, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$265

	.sect	".text"
	.clink
	.global	||BTS_HAL_SetupI2C_Init||

$C$DW$272	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$272, DW_AT_name("BTS_HAL_SetupI2C_Init")
	.dwattr $C$DW$272, DW_AT_low_pc(||BTS_HAL_SetupI2C_Init||)
	.dwattr $C$DW$272, DW_AT_high_pc(0x00)
	.dwattr $C$DW$272, DW_AT_linkage_name("BTS_HAL_SetupI2C_Init")
	.dwattr $C$DW$272, DW_AT_external
	.dwattr $C$DW$272, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$272, DW_AT_decl_line(0x342)
	.dwattr $C$DW$272, DW_AT_decl_column(0x06)
	.dwattr $C$DW$272, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "../bts_hal.c",line 835,column 1,is_stmt,address ||BTS_HAL_SetupI2C_Init||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_SetupI2C_Init||

;***************************************************************
;* FNAME: BTS_HAL_SetupI2C_Init         FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_SetupI2C_Init||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 342,column 5,is_stmt,isa 0
        MOV       AR6,*(0:0x7309)       ; [CPU_ALU] |342| 
	.dwpsn	file "../bts_hal.c",line 838,column 5,is_stmt,isa 0
        MOV       AL,#26624             ; [CPU_ALU] |838| 
        MOV       AH,#2441              ; [CPU_ALU] |838| 
        MOVL      XAR4,#100000          ; [CPU_ARAU] |838| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 342,column 5,is_stmt,isa 0
        AND       AR6,#0xffdf           ; [CPU_ALU] |342| 
	.dwpsn	file "../bts_hal.c",line 838,column 5,is_stmt,isa 0
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |838| 
        MOVL      XAR5,#29440           ; [CPU_ARAU] |838| 
        MOVL      *-SP[4],XAR4          ; [CPU_ALU] |838| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 342,column 5,is_stmt,isa 0
        MOV       *(0:0x7309),AR6       ; [CPU_ALU] |342| 
	.dwpsn	file "../bts_hal.c",line 838,column 5,is_stmt,isa 0
        MOVL      ACC,XAR5              ; [CPU_ALU] |838| 
        MOVB      XAR4,#1               ; [CPU_ALU] |838| 
$C$DW$273	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$273, DW_AT_low_pc(0x00)
	.dwattr $C$DW$273, DW_AT_name("I2C_initMaster")
	.dwattr $C$DW$273, DW_AT_TI_call

        LCR       #||I2C_initMaster||   ; [CPU_ALU] |838| 
        ; call occurs [#||I2C_initMaster||] ; [] |838| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 729,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7309)        ; [CPU_ALU] |729| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 563,column 5,is_stmt,isa 0
        MOVB      XAR6,#80              ; [CPU_ALU] |563| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 590,column 5,is_stmt,isa 0
        MOVB      AH,#96                ; [CPU_ALU] |590| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 729,column 5,is_stmt,isa 0
        AND       AL,#0xff67            ; [CPU_ALU] |729| 
        OR        AL,#0x0600            ; [CPU_ALU] |729| 
        MOV       *(0:0x7309),AL        ; [CPU_ALU] |729| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 563,column 5,is_stmt,isa 0
        MOV       *(0:0x7307),AR6       ; [CPU_ALU] |563| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 590,column 5,is_stmt,isa 0
        MOV       *(0:0x7300),AH        ; [CPU_ALU] |590| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 948,column 5,is_stmt,isa 0
        MOVB      AH,#2                 ; [CPU_ALU] |948| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 1065,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7309)        ; [CPU_ALU] |1065| 
        AND       AL,#0xffbf            ; [CPU_ALU] |1065| 
        MOV       *(0:0x7309),AL        ; [CPU_ALU] |1065| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 758,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7309)        ; [CPU_ALU] |758| 
        AND       AL,#0xfff8            ; [CPU_ALU] |758| 
        MOV       *(0:0x7309),AL        ; [CPU_ALU] |758| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 948,column 5,is_stmt,isa 0
        MOV       *(0:0x7305),AH        ; [CPU_ALU] |948| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 977,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7309)        ; [CPU_ALU] |977| 
        AND       AL,#0xfeff            ; [CPU_ALU] |977| 
        MOV       *(0:0x7309),AL        ; [CPU_ALU] |977| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 367,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7320)        ; [CPU_ALU] |367| 
        OR        AL,#0x6000            ; [CPU_ALU] |367| 
        MOV       *(0:0x7320),AL        ; [CPU_ALU] |367| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 368,column 5,is_stmt,isa 0
        MOV       AR6,*(0:0x7321)       ; [CPU_ALU] |368| 
	.dwpsn	file "../bts_hal.c",line 847,column 5,is_stmt,isa 0
        MOVB      ACC,#3                ; [CPU_ALU] |847| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 368,column 5,is_stmt,isa 0
        OR        AR6,#0x2000           ; [CPU_ALU] |368| 
	.dwpsn	file "../bts_hal.c",line 847,column 5,is_stmt,isa 0
        MOVL      XAR4,#29440           ; [CPU_ARAU] |847| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |847| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |847| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 368,column 5,is_stmt,isa 0
        MOV       *(0:0x7321),AR6       ; [CPU_ALU] |368| 
	.dwpsn	file "../bts_hal.c",line 847,column 5,is_stmt,isa 0
$C$DW$274	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$274, DW_AT_low_pc(0x00)
	.dwattr $C$DW$274, DW_AT_name("I2C_clearInterruptStatus")
	.dwattr $C$DW$274, DW_AT_TI_call

        LCR       #||I2C_clearInterruptStatus|| ; [CPU_ALU] |847| 
        ; call occurs [#||I2C_clearInterruptStatus||] ; [] |847| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 430,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7320)        ; [CPU_ALU] |430| 
	.dwpsn	file "../bts_hal.c",line 849,column 5,is_stmt,isa 0
        MOVL      XAR4,#547             ; [CPU_ARAU] |849| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 430,column 5,is_stmt,isa 0
        AND       AL,#0xffe0            ; [CPU_ALU] |430| 
	.dwpsn	file "../bts_hal.c",line 849,column 5,is_stmt,isa 0
        MOVL      XAR5,#29440           ; [CPU_ARAU] |849| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 430,column 5,is_stmt,isa 0
        MOV       *(0:0x7320),AL        ; [CPU_ALU] |430| 
	.dwpsn	file "../bts_hal.c",line 849,column 5,is_stmt,isa 0
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |849| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 432,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7321)        ; [CPU_ALU] |432| 
        AND       AL,AL,#0xffe0         ; [CPU_ALU] |432| 
        ORB       AL,#0x02              ; [CPU_ALU] |432| 
        MOV       *(0:0x7321),AL        ; [CPU_ALU] |432| 
	.dwpsn	file "../bts_hal.c",line 849,column 5,is_stmt,isa 0
        MOVL      ACC,XAR5              ; [CPU_ALU] |849| 
$C$DW$275	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$275, DW_AT_low_pc(0x00)
	.dwattr $C$DW$275, DW_AT_name("I2C_enableInterrupt")
	.dwattr $C$DW$275, DW_AT_TI_call

        LCR       #||I2C_enableInterrupt|| ; [CPU_ALU] |849| 
        ; call occurs [#||I2C_enableInterrupt||] ; [] |849| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 1011,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7309)        ; [CPU_ALU] |1011| 
        OR        AL,#0x4000            ; [CPU_ALU] |1011| 
	.dwpsn	file "../bts_hal.c",line 855,column 5,is_stmt,isa 0
        MOV       AH,#2441              ; [CPU_FPU] |855| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 1011,column 5,is_stmt,isa 0
        MOV       *(0:0x7309),AL        ; [CPU_ALU] |1011| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 320,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7309)        ; [CPU_ALU] |320| 
        ORB       AL,#0x20              ; [CPU_ALU] |320| 
        MOV       *(0:0x7309),AL        ; [CPU_ALU] |320| 
	.dwpsn	file "../bts_hal.c",line 855,column 5,is_stmt,isa 0
        MOV       AL,#26624             ; [CPU_ALU] |855| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 342,column 5,is_stmt,isa 0
        MOV       AR6,*(0:0x7349)       ; [CPU_ALU] |342| 
	.dwpsn	file "../bts_hal.c",line 855,column 5,is_stmt,isa 0
        MOVL      XAR4,#400000          ; [CPU_ARAU] |855| 
        MOVL      XAR5,#29504           ; [CPU_ARAU] |855| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |855| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 342,column 5,is_stmt,isa 0
        AND       AR6,#0xffdf           ; [CPU_ALU] |342| 
	.dwpsn	file "../bts_hal.c",line 855,column 5,is_stmt,isa 0
        MOVL      *-SP[4],XAR4          ; [CPU_ALU] |855| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |855| 
        MOVB      XAR4,#1               ; [CPU_ALU] |855| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 342,column 5,is_stmt,isa 0
        MOV       *(0:0x7349),AR6       ; [CPU_ALU] |342| 
	.dwpsn	file "../bts_hal.c",line 855,column 5,is_stmt,isa 0
$C$DW$276	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$276, DW_AT_low_pc(0x00)
	.dwattr $C$DW$276, DW_AT_name("I2C_initMaster")
	.dwattr $C$DW$276, DW_AT_TI_call

        LCR       #||I2C_initMaster||   ; [CPU_ALU] |855| 
        ; call occurs [#||I2C_initMaster||] ; [] |855| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 729,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7349)        ; [CPU_ALU] |729| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 563,column 5,is_stmt,isa 0
        MOVB      XAR6,#80              ; [CPU_ALU] |563| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 590,column 5,is_stmt,isa 0
        MOVB      AH,#96                ; [CPU_ALU] |590| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 729,column 5,is_stmt,isa 0
        AND       AL,#0xff67            ; [CPU_ALU] |729| 
        OR        AL,#0x0600            ; [CPU_ALU] |729| 
        MOV       *(0:0x7349),AL        ; [CPU_ALU] |729| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 563,column 5,is_stmt,isa 0
        MOV       *(0:0x7347),AR6       ; [CPU_ALU] |563| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 590,column 5,is_stmt,isa 0
        MOV       *(0:0x7340),AH        ; [CPU_ALU] |590| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 948,column 5,is_stmt,isa 0
        MOVB      AH,#2                 ; [CPU_ALU] |948| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 1065,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7349)        ; [CPU_ALU] |1065| 
        AND       AL,#0xffbf            ; [CPU_ALU] |1065| 
        MOV       *(0:0x7349),AL        ; [CPU_ALU] |1065| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 758,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7349)        ; [CPU_ALU] |758| 
        AND       AL,#0xfff8            ; [CPU_ALU] |758| 
        MOV       *(0:0x7349),AL        ; [CPU_ALU] |758| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 948,column 5,is_stmt,isa 0
        MOV       *(0:0x7345),AH        ; [CPU_ALU] |948| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 977,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7349)        ; [CPU_ALU] |977| 
        AND       AL,#0xfeff            ; [CPU_ALU] |977| 
        MOV       *(0:0x7349),AL        ; [CPU_ALU] |977| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 367,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7360)        ; [CPU_ALU] |367| 
        OR        AL,#0x6000            ; [CPU_ALU] |367| 
        MOV       *(0:0x7360),AL        ; [CPU_ALU] |367| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 368,column 5,is_stmt,isa 0
        MOV       AR6,*(0:0x7361)       ; [CPU_ALU] |368| 
	.dwpsn	file "../bts_hal.c",line 864,column 5,is_stmt,isa 0
        MOVB      ACC,#3                ; [CPU_ALU] |864| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 368,column 5,is_stmt,isa 0
        OR        AR6,#0x2000           ; [CPU_ALU] |368| 
	.dwpsn	file "../bts_hal.c",line 864,column 5,is_stmt,isa 0
        MOVL      XAR4,#29504           ; [CPU_ARAU] |864| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |864| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |864| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 368,column 5,is_stmt,isa 0
        MOV       *(0:0x7361),AR6       ; [CPU_ALU] |368| 
	.dwpsn	file "../bts_hal.c",line 864,column 5,is_stmt,isa 0
$C$DW$277	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$277, DW_AT_low_pc(0x00)
	.dwattr $C$DW$277, DW_AT_name("I2C_clearInterruptStatus")
	.dwattr $C$DW$277, DW_AT_TI_call

        LCR       #||I2C_clearInterruptStatus|| ; [CPU_ALU] |864| 
        ; call occurs [#||I2C_clearInterruptStatus||] ; [] |864| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 430,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7360)        ; [CPU_ALU] |430| 
	.dwpsn	file "../bts_hal.c",line 866,column 5,is_stmt,isa 0
        MOVL      XAR4,#547             ; [CPU_ARAU] |866| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 430,column 5,is_stmt,isa 0
        AND       AL,#0xffe0            ; [CPU_ALU] |430| 
	.dwpsn	file "../bts_hal.c",line 866,column 5,is_stmt,isa 0
        MOVL      XAR5,#29504           ; [CPU_ARAU] |866| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 430,column 5,is_stmt,isa 0
        MOV       *(0:0x7360),AL        ; [CPU_ALU] |430| 
	.dwpsn	file "../bts_hal.c",line 866,column 5,is_stmt,isa 0
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |866| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 432,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7361)        ; [CPU_ALU] |432| 
        AND       AL,AL,#0xffe0         ; [CPU_ALU] |432| 
        ORB       AL,#0x02              ; [CPU_ALU] |432| 
        MOV       *(0:0x7361),AL        ; [CPU_ALU] |432| 
	.dwpsn	file "../bts_hal.c",line 866,column 5,is_stmt,isa 0
        MOVL      ACC,XAR5              ; [CPU_ALU] |866| 
$C$DW$278	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$278, DW_AT_low_pc(0x00)
	.dwattr $C$DW$278, DW_AT_name("I2C_enableInterrupt")
	.dwattr $C$DW$278, DW_AT_TI_call

        LCR       #||I2C_enableInterrupt|| ; [CPU_ALU] |866| 
        ; call occurs [#||I2C_enableInterrupt||] ; [] |866| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 1011,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7349)        ; [CPU_ALU] |1011| 
        OR        AL,#0x4000            ; [CPU_ALU] |1011| 
        MOV       *(0:0x7349),AL        ; [CPU_ALU] |1011| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 320,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7349)        ; [CPU_ALU] |320| 
        ORB       AL,#0x20              ; [CPU_ALU] |320| 
        MOV       *(0:0x7349),AL        ; [CPU_ALU] |320| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$279	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$279, DW_AT_low_pc(0x00)
	.dwattr $C$DW$279, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$272, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$272, DW_AT_TI_end_line(0x365)
	.dwattr $C$DW$272, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$272

	.sect	".text"
	.clink
	.global	||BTS_HAL_SetupI2C_GPIO||

$C$DW$280	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$280, DW_AT_name("BTS_HAL_SetupI2C_GPIO")
	.dwattr $C$DW$280, DW_AT_low_pc(||BTS_HAL_SetupI2C_GPIO||)
	.dwattr $C$DW$280, DW_AT_high_pc(0x00)
	.dwattr $C$DW$280, DW_AT_linkage_name("BTS_HAL_SetupI2C_GPIO")
	.dwattr $C$DW$280, DW_AT_external
	.dwattr $C$DW$280, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$280, DW_AT_decl_line(0x323)
	.dwattr $C$DW$280, DW_AT_decl_column(0x06)
	.dwattr $C$DW$280, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts_hal.c",line 804,column 1,is_stmt,address ||BTS_HAL_SetupI2C_GPIO||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_SetupI2C_GPIO||

;***************************************************************
;* FNAME: BTS_HAL_SetupI2C_GPIO         FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_SetupI2C_GPIO||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts_hal.c",line 806,column 5,is_stmt,isa 0
        MOVB      ACC,#32               ; [CPU_ALU] |806| 
        MOVB      XAR4,#0               ; [CPU_ALU] |806| 
$C$DW$281	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$281, DW_AT_low_pc(0x00)
	.dwattr $C$DW$281, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$281, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |806| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |806| 
	.dwpsn	file "../bts_hal.c",line 807,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |807| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |807| 
        MOVB      ACC,#32               ; [CPU_ALU] |807| 
$C$DW$282	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$282, DW_AT_low_pc(0x00)
	.dwattr $C$DW$282, DW_AT_name("GPIO_setPadConfig")
	.dwattr $C$DW$282, DW_AT_TI_call

        LCR       #||GPIO_setPadConfig|| ; [CPU_ALU] |807| 
        ; call occurs [#||GPIO_setPadConfig||] ; [] |807| 
	.dwpsn	file "../bts_hal.c",line 808,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |808| 
        MOVB      ACC,#32               ; [CPU_ALU] |808| 
$C$DW$283	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$283, DW_AT_low_pc(0x00)
	.dwattr $C$DW$283, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$283, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |808| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |808| 
	.dwpsn	file "../bts_hal.c",line 809,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |809| 
        MOVB      ACC,#32               ; [CPU_ALU] |809| 
$C$DW$284	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$284, DW_AT_low_pc(0x00)
	.dwattr $C$DW$284, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$284, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |809| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |809| 
	.dwpsn	file "../bts_hal.c",line 811,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |811| 
        MOVB      ACC,#33               ; [CPU_ALU] |811| 
$C$DW$285	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$285, DW_AT_low_pc(0x00)
	.dwattr $C$DW$285, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$285, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |811| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |811| 
	.dwpsn	file "../bts_hal.c",line 812,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |812| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |812| 
        MOVB      ACC,#33               ; [CPU_ALU] |812| 
$C$DW$286	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$286, DW_AT_low_pc(0x00)
	.dwattr $C$DW$286, DW_AT_name("GPIO_setPadConfig")
	.dwattr $C$DW$286, DW_AT_TI_call

        LCR       #||GPIO_setPadConfig|| ; [CPU_ALU] |812| 
        ; call occurs [#||GPIO_setPadConfig||] ; [] |812| 
	.dwpsn	file "../bts_hal.c",line 813,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |813| 
        MOVB      ACC,#33               ; [CPU_ALU] |813| 
$C$DW$287	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$287, DW_AT_low_pc(0x00)
	.dwattr $C$DW$287, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$287, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |813| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |813| 
	.dwpsn	file "../bts_hal.c",line 814,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |814| 
        MOVB      ACC,#33               ; [CPU_ALU] |814| 
$C$DW$288	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$288, DW_AT_low_pc(0x00)
	.dwattr $C$DW$288, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$288, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |814| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |814| 
	.dwpsn	file "../bts_hal.c",line 816,column 5,is_stmt,isa 0
        MOV       AL,#1                 ; [CPU_ALU] |816| 
        MOV       AH,#70                ; [CPU_ALU] |816| 
$C$DW$289	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$289, DW_AT_low_pc(0x00)
	.dwattr $C$DW$289, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$289, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |816| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |816| 
	.dwpsn	file "../bts_hal.c",line 817,column 5,is_stmt,isa 0
        MOV       AL,#513               ; [CPU_ALU] |817| 
        MOV       AH,#70                ; [CPU_ALU] |817| 
$C$DW$290	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$290, DW_AT_low_pc(0x00)
	.dwattr $C$DW$290, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$290, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |817| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |817| 
	.dwpsn	file "../bts_hal.c",line 820,column 5,is_stmt,isa 0
        MOVB      ACC,#40               ; [CPU_ALU] |820| 
        MOVB      XAR4,#0               ; [CPU_ALU] |820| 
$C$DW$291	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$291, DW_AT_low_pc(0x00)
	.dwattr $C$DW$291, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$291, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |820| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |820| 
	.dwpsn	file "../bts_hal.c",line 821,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |821| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |821| 
        MOVB      ACC,#40               ; [CPU_ALU] |821| 
$C$DW$292	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$292, DW_AT_low_pc(0x00)
	.dwattr $C$DW$292, DW_AT_name("GPIO_setPadConfig")
	.dwattr $C$DW$292, DW_AT_TI_call

        LCR       #||GPIO_setPadConfig|| ; [CPU_ALU] |821| 
        ; call occurs [#||GPIO_setPadConfig||] ; [] |821| 
	.dwpsn	file "../bts_hal.c",line 822,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |822| 
        MOVB      ACC,#40               ; [CPU_ALU] |822| 
$C$DW$293	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$293, DW_AT_low_pc(0x00)
	.dwattr $C$DW$293, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$293, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |822| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |822| 
	.dwpsn	file "../bts_hal.c",line 823,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |823| 
        MOVB      ACC,#40               ; [CPU_ALU] |823| 
$C$DW$294	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$294, DW_AT_low_pc(0x00)
	.dwattr $C$DW$294, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$294, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |823| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |823| 
	.dwpsn	file "../bts_hal.c",line 825,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |825| 
        MOVB      ACC,#41               ; [CPU_ALU] |825| 
$C$DW$295	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$295, DW_AT_low_pc(0x00)
	.dwattr $C$DW$295, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$295, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |825| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |825| 
	.dwpsn	file "../bts_hal.c",line 826,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |826| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |826| 
        MOVB      ACC,#41               ; [CPU_ALU] |826| 
$C$DW$296	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$296, DW_AT_low_pc(0x00)
	.dwattr $C$DW$296, DW_AT_name("GPIO_setPadConfig")
	.dwattr $C$DW$296, DW_AT_TI_call

        LCR       #||GPIO_setPadConfig|| ; [CPU_ALU] |826| 
        ; call occurs [#||GPIO_setPadConfig||] ; [] |826| 
	.dwpsn	file "../bts_hal.c",line 827,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |827| 
        MOVB      ACC,#41               ; [CPU_ALU] |827| 
$C$DW$297	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$297, DW_AT_low_pc(0x00)
	.dwattr $C$DW$297, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$297, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |827| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |827| 
	.dwpsn	file "../bts_hal.c",line 828,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |828| 
        MOVB      ACC,#41               ; [CPU_ALU] |828| 
$C$DW$298	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$298, DW_AT_low_pc(0x00)
	.dwattr $C$DW$298, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$298, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |828| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |828| 
	.dwpsn	file "../bts_hal.c",line 830,column 5,is_stmt,isa 0
        MOV       AL,#4102              ; [CPU_ALU] |830| 
        MOV       AH,#70                ; [CPU_ALU] |830| 
$C$DW$299	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$299, DW_AT_low_pc(0x00)
	.dwattr $C$DW$299, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$299, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |830| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |830| 
	.dwpsn	file "../bts_hal.c",line 831,column 5,is_stmt,isa 0
        MOV       AL,#4614              ; [CPU_ALU] |831| 
        MOV       AH,#70                ; [CPU_ALU] |831| 
$C$DW$300	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$300, DW_AT_low_pc(0x00)
	.dwattr $C$DW$300, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$300, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |831| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |831| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$301	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$301, DW_AT_low_pc(0x00)
	.dwattr $C$DW$301, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$280, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$280, DW_AT_TI_end_line(0x340)
	.dwattr $C$DW$280, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$280

;**************************************************************
;* UNDEFINED EXTERNAL REFERENCES                              *
;**************************************************************
	.global	||Device_init||
	.global	||Device_initGPIO||
	.global	||Interrupt_initModule||
	.global	||Interrupt_initVectorTable||
	.global	||CPUTimer_setEmulationMode||
	.global	||SysCtl_delay||
	.global	||GPIO_setPinConfig||
	.global	||GPIO_setDirectionMode||
	.global	||GPIO_setQualificationMode||
	.global	||GPIO_setInterruptPin||
	.global	||GPIO_setAnalogMode||
	.global	||GPIO_setPadConfig||
	.global	||EPWM_setEmulationMode||
	.global	||GPIO_setMasterCore||
	.global	||I2C_initMaster||
	.global	||I2C_clearInterruptStatus||
	.global	||I2C_enableInterrupt||
	.global	||Interrupt_enable||
	.global	||SPI_clearInterruptStatus||
	.global	||ISR1||
	.global	||ISR2||
	.global	||ISR3||
	.global	||ISR4||
	.global	||i2cAISR||
	.global	||i2cBISR||
	.global	||i2cAFIFOISR||
	.global	||i2cBFIFOISR||
	.global	||SPI_setConfig||
	.global	||SPI_enableInterrupt||
	.global	||SysCtl_getClock||

;***************************************************************
;* BUILD ATTRIBUTES                                            *
;***************************************************************
	.battr "c28xabi", Tag_File, 1, Tag_float_args(0)
	.battr "c28xabi", Tag_File, 1, Tag_double_args(0)
	.dwattr $C$DW$CU, DW_AT_language(DW_LANG_C)

;***************************************************************
;* DWARF CIE ENTRIES                                           *
;***************************************************************

$C$DW$CIE	.dwcie 26
	.dwcfi	cfa_register, 20
	.dwcfi	cfa_offset, 0
	.dwcfi	same_value, 28
	.dwcfi	same_value, 6
	.dwcfi	same_value, 7
	.dwcfi	same_value, 8
	.dwcfi	same_value, 9
	.dwcfi	same_value, 10
	.dwcfi	same_value, 11
	.dwcfi	same_value, 59
	.dwcfi	same_value, 63
	.dwcfi	same_value, 67
	.dwcfi	same_value, 71
	.dwendentry
	.dwendtag $C$DW$CU


;***************************************************************
;* TYPE INFORMATION                                            *
;***************************************************************

$C$DW$TU$26	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$26

$C$DW$T$26	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$26, DW_AT_byte_size(0x01)
$C$DW$302	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$302, DW_AT_name("SYSCTL_PERIPH_CLK_CLA1")
	.dwattr $C$DW$302, DW_AT_const_value(0x00)
	.dwattr $C$DW$302, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$302, DW_AT_decl_line(0x152)
	.dwattr $C$DW$302, DW_AT_decl_column(0x05)

$C$DW$303	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$303, DW_AT_name("SYSCTL_PERIPH_CLK_DMA")
	.dwattr $C$DW$303, DW_AT_const_value(0x200)
	.dwattr $C$DW$303, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$303, DW_AT_decl_line(0x153)
	.dwattr $C$DW$303, DW_AT_decl_column(0x05)

$C$DW$304	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$304, DW_AT_name("SYSCTL_PERIPH_CLK_TIMER0")
	.dwattr $C$DW$304, DW_AT_const_value(0x300)
	.dwattr $C$DW$304, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$304, DW_AT_decl_line(0x154)
	.dwattr $C$DW$304, DW_AT_decl_column(0x05)

$C$DW$305	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$305, DW_AT_name("SYSCTL_PERIPH_CLK_TIMER1")
	.dwattr $C$DW$305, DW_AT_const_value(0x400)
	.dwattr $C$DW$305, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$305, DW_AT_decl_line(0x155)
	.dwattr $C$DW$305, DW_AT_decl_column(0x05)

$C$DW$306	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$306, DW_AT_name("SYSCTL_PERIPH_CLK_TIMER2")
	.dwattr $C$DW$306, DW_AT_const_value(0x500)
	.dwattr $C$DW$306, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$306, DW_AT_decl_line(0x156)
	.dwattr $C$DW$306, DW_AT_decl_column(0x05)

$C$DW$307	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$307, DW_AT_name("SYSCTL_PERIPH_CLK_HRPWM")
	.dwattr $C$DW$307, DW_AT_const_value(0x1000)
	.dwattr $C$DW$307, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$307, DW_AT_decl_line(0x157)
	.dwattr $C$DW$307, DW_AT_decl_column(0x05)

$C$DW$308	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$308, DW_AT_name("SYSCTL_PERIPH_CLK_TBCLKSYNC")
	.dwattr $C$DW$308, DW_AT_const_value(0x1200)
	.dwattr $C$DW$308, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$308, DW_AT_decl_line(0x158)
	.dwattr $C$DW$308, DW_AT_decl_column(0x05)

$C$DW$309	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$309, DW_AT_name("SYSCTL_PERIPH_CLK_GTBCLKSYNC")
	.dwattr $C$DW$309, DW_AT_const_value(0x1300)
	.dwattr $C$DW$309, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$309, DW_AT_decl_line(0x159)
	.dwattr $C$DW$309, DW_AT_decl_column(0x05)

$C$DW$310	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$310, DW_AT_name("SYSCTL_PERIPH_CLK_EMIF1")
	.dwattr $C$DW$310, DW_AT_const_value(0x01)
	.dwattr $C$DW$310, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$310, DW_AT_decl_line(0x15a)
	.dwattr $C$DW$310, DW_AT_decl_column(0x05)

$C$DW$311	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$311, DW_AT_name("SYSCTL_PERIPH_CLK_EMIF2")
	.dwattr $C$DW$311, DW_AT_const_value(0x101)
	.dwattr $C$DW$311, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$311, DW_AT_decl_line(0x15b)
	.dwattr $C$DW$311, DW_AT_decl_column(0x05)

$C$DW$312	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$312, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM1")
	.dwattr $C$DW$312, DW_AT_const_value(0x02)
	.dwattr $C$DW$312, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$312, DW_AT_decl_line(0x15c)
	.dwattr $C$DW$312, DW_AT_decl_column(0x05)

$C$DW$313	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$313, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM2")
	.dwattr $C$DW$313, DW_AT_const_value(0x102)
	.dwattr $C$DW$313, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$313, DW_AT_decl_line(0x15d)
	.dwattr $C$DW$313, DW_AT_decl_column(0x05)

$C$DW$314	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$314, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM3")
	.dwattr $C$DW$314, DW_AT_const_value(0x202)
	.dwattr $C$DW$314, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$314, DW_AT_decl_line(0x15e)
	.dwattr $C$DW$314, DW_AT_decl_column(0x05)

$C$DW$315	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$315, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM4")
	.dwattr $C$DW$315, DW_AT_const_value(0x302)
	.dwattr $C$DW$315, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$315, DW_AT_decl_line(0x15f)
	.dwattr $C$DW$315, DW_AT_decl_column(0x05)

$C$DW$316	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$316, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM5")
	.dwattr $C$DW$316, DW_AT_const_value(0x402)
	.dwattr $C$DW$316, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$316, DW_AT_decl_line(0x160)
	.dwattr $C$DW$316, DW_AT_decl_column(0x05)

$C$DW$317	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$317, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM6")
	.dwattr $C$DW$317, DW_AT_const_value(0x502)
	.dwattr $C$DW$317, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$317, DW_AT_decl_line(0x161)
	.dwattr $C$DW$317, DW_AT_decl_column(0x05)

$C$DW$318	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$318, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM7")
	.dwattr $C$DW$318, DW_AT_const_value(0x602)
	.dwattr $C$DW$318, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$318, DW_AT_decl_line(0x162)
	.dwattr $C$DW$318, DW_AT_decl_column(0x05)

$C$DW$319	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$319, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM8")
	.dwattr $C$DW$319, DW_AT_const_value(0x702)
	.dwattr $C$DW$319, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$319, DW_AT_decl_line(0x163)
	.dwattr $C$DW$319, DW_AT_decl_column(0x05)

$C$DW$320	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$320, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM9")
	.dwattr $C$DW$320, DW_AT_const_value(0x802)
	.dwattr $C$DW$320, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$320, DW_AT_decl_line(0x164)
	.dwattr $C$DW$320, DW_AT_decl_column(0x05)

$C$DW$321	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$321, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM10")
	.dwattr $C$DW$321, DW_AT_const_value(0x902)
	.dwattr $C$DW$321, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$321, DW_AT_decl_line(0x165)
	.dwattr $C$DW$321, DW_AT_decl_column(0x05)

$C$DW$322	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$322, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM11")
	.dwattr $C$DW$322, DW_AT_const_value(0xa02)
	.dwattr $C$DW$322, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$322, DW_AT_decl_line(0x166)
	.dwattr $C$DW$322, DW_AT_decl_column(0x05)

$C$DW$323	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$323, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM12")
	.dwattr $C$DW$323, DW_AT_const_value(0xb02)
	.dwattr $C$DW$323, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$323, DW_AT_decl_line(0x167)
	.dwattr $C$DW$323, DW_AT_decl_column(0x05)

$C$DW$324	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$324, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP1")
	.dwattr $C$DW$324, DW_AT_const_value(0x03)
	.dwattr $C$DW$324, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$324, DW_AT_decl_line(0x168)
	.dwattr $C$DW$324, DW_AT_decl_column(0x05)

$C$DW$325	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$325, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP2")
	.dwattr $C$DW$325, DW_AT_const_value(0x103)
	.dwattr $C$DW$325, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$325, DW_AT_decl_line(0x169)
	.dwattr $C$DW$325, DW_AT_decl_column(0x05)

$C$DW$326	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$326, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP3")
	.dwattr $C$DW$326, DW_AT_const_value(0x203)
	.dwattr $C$DW$326, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$326, DW_AT_decl_line(0x16a)
	.dwattr $C$DW$326, DW_AT_decl_column(0x05)

$C$DW$327	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$327, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP4")
	.dwattr $C$DW$327, DW_AT_const_value(0x303)
	.dwattr $C$DW$327, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$327, DW_AT_decl_line(0x16b)
	.dwattr $C$DW$327, DW_AT_decl_column(0x05)

$C$DW$328	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$328, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP5")
	.dwattr $C$DW$328, DW_AT_const_value(0x403)
	.dwattr $C$DW$328, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$328, DW_AT_decl_line(0x16c)
	.dwattr $C$DW$328, DW_AT_decl_column(0x05)

$C$DW$329	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$329, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP6")
	.dwattr $C$DW$329, DW_AT_const_value(0x503)
	.dwattr $C$DW$329, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$329, DW_AT_decl_line(0x16d)
	.dwattr $C$DW$329, DW_AT_decl_column(0x05)

$C$DW$330	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$330, DW_AT_name("SYSCTL_PERIPH_CLK_EQEP1")
	.dwattr $C$DW$330, DW_AT_const_value(0x04)
	.dwattr $C$DW$330, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$330, DW_AT_decl_line(0x16e)
	.dwattr $C$DW$330, DW_AT_decl_column(0x05)

$C$DW$331	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$331, DW_AT_name("SYSCTL_PERIPH_CLK_EQEP2")
	.dwattr $C$DW$331, DW_AT_const_value(0x104)
	.dwattr $C$DW$331, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$331, DW_AT_decl_line(0x16f)
	.dwattr $C$DW$331, DW_AT_decl_column(0x05)

$C$DW$332	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$332, DW_AT_name("SYSCTL_PERIPH_CLK_EQEP3")
	.dwattr $C$DW$332, DW_AT_const_value(0x204)
	.dwattr $C$DW$332, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$332, DW_AT_decl_line(0x170)
	.dwattr $C$DW$332, DW_AT_decl_column(0x05)

$C$DW$333	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$333, DW_AT_name("SYSCTL_PERIPH_CLK_SD1")
	.dwattr $C$DW$333, DW_AT_const_value(0x06)
	.dwattr $C$DW$333, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$333, DW_AT_decl_line(0x171)
	.dwattr $C$DW$333, DW_AT_decl_column(0x05)

$C$DW$334	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$334, DW_AT_name("SYSCTL_PERIPH_CLK_SD2")
	.dwattr $C$DW$334, DW_AT_const_value(0x106)
	.dwattr $C$DW$334, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$334, DW_AT_decl_line(0x172)
	.dwattr $C$DW$334, DW_AT_decl_column(0x05)

$C$DW$335	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$335, DW_AT_name("SYSCTL_PERIPH_CLK_SCIA")
	.dwattr $C$DW$335, DW_AT_const_value(0x07)
	.dwattr $C$DW$335, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$335, DW_AT_decl_line(0x173)
	.dwattr $C$DW$335, DW_AT_decl_column(0x05)

$C$DW$336	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$336, DW_AT_name("SYSCTL_PERIPH_CLK_SCIB")
	.dwattr $C$DW$336, DW_AT_const_value(0x107)
	.dwattr $C$DW$336, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$336, DW_AT_decl_line(0x174)
	.dwattr $C$DW$336, DW_AT_decl_column(0x05)

$C$DW$337	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$337, DW_AT_name("SYSCTL_PERIPH_CLK_SCIC")
	.dwattr $C$DW$337, DW_AT_const_value(0x207)
	.dwattr $C$DW$337, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$337, DW_AT_decl_line(0x175)
	.dwattr $C$DW$337, DW_AT_decl_column(0x05)

$C$DW$338	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$338, DW_AT_name("SYSCTL_PERIPH_CLK_SCID")
	.dwattr $C$DW$338, DW_AT_const_value(0x307)
	.dwattr $C$DW$338, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$338, DW_AT_decl_line(0x176)
	.dwattr $C$DW$338, DW_AT_decl_column(0x05)

$C$DW$339	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$339, DW_AT_name("SYSCTL_PERIPH_CLK_SPIA")
	.dwattr $C$DW$339, DW_AT_const_value(0x08)
	.dwattr $C$DW$339, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$339, DW_AT_decl_line(0x177)
	.dwattr $C$DW$339, DW_AT_decl_column(0x05)

$C$DW$340	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$340, DW_AT_name("SYSCTL_PERIPH_CLK_SPIB")
	.dwattr $C$DW$340, DW_AT_const_value(0x108)
	.dwattr $C$DW$340, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$340, DW_AT_decl_line(0x178)
	.dwattr $C$DW$340, DW_AT_decl_column(0x05)

$C$DW$341	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$341, DW_AT_name("SYSCTL_PERIPH_CLK_SPIC")
	.dwattr $C$DW$341, DW_AT_const_value(0x208)
	.dwattr $C$DW$341, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$341, DW_AT_decl_line(0x179)
	.dwattr $C$DW$341, DW_AT_decl_column(0x05)

$C$DW$342	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$342, DW_AT_name("SYSCTL_PERIPH_CLK_I2CA")
	.dwattr $C$DW$342, DW_AT_const_value(0x09)
	.dwattr $C$DW$342, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$342, DW_AT_decl_line(0x17a)
	.dwattr $C$DW$342, DW_AT_decl_column(0x05)

$C$DW$343	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$343, DW_AT_name("SYSCTL_PERIPH_CLK_I2CB")
	.dwattr $C$DW$343, DW_AT_const_value(0x109)
	.dwattr $C$DW$343, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$343, DW_AT_decl_line(0x17b)
	.dwattr $C$DW$343, DW_AT_decl_column(0x05)

$C$DW$344	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$344, DW_AT_name("SYSCTL_PERIPH_CLK_CANA")
	.dwattr $C$DW$344, DW_AT_const_value(0x0a)
	.dwattr $C$DW$344, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$344, DW_AT_decl_line(0x17c)
	.dwattr $C$DW$344, DW_AT_decl_column(0x05)

$C$DW$345	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$345, DW_AT_name("SYSCTL_PERIPH_CLK_CANB")
	.dwattr $C$DW$345, DW_AT_const_value(0x10a)
	.dwattr $C$DW$345, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$345, DW_AT_decl_line(0x17d)
	.dwattr $C$DW$345, DW_AT_decl_column(0x05)

$C$DW$346	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$346, DW_AT_name("SYSCTL_PERIPH_CLK_MCBSPA")
	.dwattr $C$DW$346, DW_AT_const_value(0x0b)
	.dwattr $C$DW$346, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$346, DW_AT_decl_line(0x17e)
	.dwattr $C$DW$346, DW_AT_decl_column(0x05)

$C$DW$347	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$347, DW_AT_name("SYSCTL_PERIPH_CLK_MCBSPB")
	.dwattr $C$DW$347, DW_AT_const_value(0x10b)
	.dwattr $C$DW$347, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$347, DW_AT_decl_line(0x17f)
	.dwattr $C$DW$347, DW_AT_decl_column(0x05)

$C$DW$348	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$348, DW_AT_name("SYSCTL_PERIPH_CLK_USBA")
	.dwattr $C$DW$348, DW_AT_const_value(0x100b)
	.dwattr $C$DW$348, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$348, DW_AT_decl_line(0x180)
	.dwattr $C$DW$348, DW_AT_decl_column(0x05)

$C$DW$349	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$349, DW_AT_name("SYSCTL_PERIPH_CLK_UPPA")
	.dwattr $C$DW$349, DW_AT_const_value(0x0c)
	.dwattr $C$DW$349, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$349, DW_AT_decl_line(0x181)
	.dwattr $C$DW$349, DW_AT_decl_column(0x05)

$C$DW$350	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$350, DW_AT_name("SYSCTL_PERIPH_CLK_ADCA")
	.dwattr $C$DW$350, DW_AT_const_value(0x0d)
	.dwattr $C$DW$350, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$350, DW_AT_decl_line(0x182)
	.dwattr $C$DW$350, DW_AT_decl_column(0x05)

$C$DW$351	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$351, DW_AT_name("SYSCTL_PERIPH_CLK_ADCB")
	.dwattr $C$DW$351, DW_AT_const_value(0x10d)
	.dwattr $C$DW$351, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$351, DW_AT_decl_line(0x183)
	.dwattr $C$DW$351, DW_AT_decl_column(0x05)

$C$DW$352	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$352, DW_AT_name("SYSCTL_PERIPH_CLK_ADCC")
	.dwattr $C$DW$352, DW_AT_const_value(0x20d)
	.dwattr $C$DW$352, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$352, DW_AT_decl_line(0x184)
	.dwattr $C$DW$352, DW_AT_decl_column(0x05)

$C$DW$353	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$353, DW_AT_name("SYSCTL_PERIPH_CLK_ADCD")
	.dwattr $C$DW$353, DW_AT_const_value(0x30d)
	.dwattr $C$DW$353, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$353, DW_AT_decl_line(0x185)
	.dwattr $C$DW$353, DW_AT_decl_column(0x05)

$C$DW$354	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$354, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS1")
	.dwattr $C$DW$354, DW_AT_const_value(0x0e)
	.dwattr $C$DW$354, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$354, DW_AT_decl_line(0x186)
	.dwattr $C$DW$354, DW_AT_decl_column(0x05)

$C$DW$355	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$355, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS2")
	.dwattr $C$DW$355, DW_AT_const_value(0x10e)
	.dwattr $C$DW$355, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$355, DW_AT_decl_line(0x187)
	.dwattr $C$DW$355, DW_AT_decl_column(0x05)

$C$DW$356	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$356, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS3")
	.dwattr $C$DW$356, DW_AT_const_value(0x20e)
	.dwattr $C$DW$356, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$356, DW_AT_decl_line(0x188)
	.dwattr $C$DW$356, DW_AT_decl_column(0x05)

$C$DW$357	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$357, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS4")
	.dwattr $C$DW$357, DW_AT_const_value(0x30e)
	.dwattr $C$DW$357, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$357, DW_AT_decl_line(0x189)
	.dwattr $C$DW$357, DW_AT_decl_column(0x05)

$C$DW$358	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$358, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS5")
	.dwattr $C$DW$358, DW_AT_const_value(0x40e)
	.dwattr $C$DW$358, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$358, DW_AT_decl_line(0x18a)
	.dwattr $C$DW$358, DW_AT_decl_column(0x05)

$C$DW$359	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$359, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS6")
	.dwattr $C$DW$359, DW_AT_const_value(0x50e)
	.dwattr $C$DW$359, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$359, DW_AT_decl_line(0x18b)
	.dwattr $C$DW$359, DW_AT_decl_column(0x05)

$C$DW$360	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$360, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS7")
	.dwattr $C$DW$360, DW_AT_const_value(0x60e)
	.dwattr $C$DW$360, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$360, DW_AT_decl_line(0x18c)
	.dwattr $C$DW$360, DW_AT_decl_column(0x05)

$C$DW$361	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$361, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS8")
	.dwattr $C$DW$361, DW_AT_const_value(0x70e)
	.dwattr $C$DW$361, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$361, DW_AT_decl_line(0x18d)
	.dwattr $C$DW$361, DW_AT_decl_column(0x05)

$C$DW$362	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$362, DW_AT_name("SYSCTL_PERIPH_CLK_DACA")
	.dwattr $C$DW$362, DW_AT_const_value(0x1010)
	.dwattr $C$DW$362, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$362, DW_AT_decl_line(0x18e)
	.dwattr $C$DW$362, DW_AT_decl_column(0x05)

$C$DW$363	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$363, DW_AT_name("SYSCTL_PERIPH_CLK_DACB")
	.dwattr $C$DW$363, DW_AT_const_value(0x1110)
	.dwattr $C$DW$363, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$363, DW_AT_decl_line(0x18f)
	.dwattr $C$DW$363, DW_AT_decl_column(0x05)

$C$DW$364	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$364, DW_AT_name("SYSCTL_PERIPH_CLK_DACC")
	.dwattr $C$DW$364, DW_AT_const_value(0x1210)
	.dwattr $C$DW$364, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$364, DW_AT_decl_line(0x190)
	.dwattr $C$DW$364, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$26, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$26, DW_AT_decl_line(0x151)
	.dwattr $C$DW$T$26, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$26

	.dwendtag $C$DW$TU$26


$C$DW$TU$27	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$27
$C$DW$T$27	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$27, DW_AT_name("SysCtl_PeripheralPCLOCKCR")
	.dwattr $C$DW$T$27, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$T$27, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$27, DW_AT_decl_line(0x191)
	.dwattr $C$DW$T$27, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$27


$C$DW$TU$28	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$28

$C$DW$T$28	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$28, DW_AT_byte_size(0x01)
$C$DW$365	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$365, DW_AT_name("CPUTIMER_EMULATIONMODE_STOPAFTERNEXTDECREMENT")
	.dwattr $C$DW$365, DW_AT_const_value(0x00)
	.dwattr $C$DW$365, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h")
	.dwattr $C$DW$365, DW_AT_decl_line(0x58)
	.dwattr $C$DW$365, DW_AT_decl_column(0x03)

$C$DW$366	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$366, DW_AT_name("CPUTIMER_EMULATIONMODE_STOPATZERO")
	.dwattr $C$DW$366, DW_AT_const_value(0x400)
	.dwattr $C$DW$366, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h")
	.dwattr $C$DW$366, DW_AT_decl_line(0x5a)
	.dwattr $C$DW$366, DW_AT_decl_column(0x03)

$C$DW$367	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$367, DW_AT_name("CPUTIMER_EMULATIONMODE_RUNFREE")
	.dwattr $C$DW$367, DW_AT_const_value(0x800)
	.dwattr $C$DW$367, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h")
	.dwattr $C$DW$367, DW_AT_decl_line(0x5c)
	.dwattr $C$DW$367, DW_AT_decl_column(0x03)

	.dwattr $C$DW$T$28, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h")
	.dwattr $C$DW$T$28, DW_AT_decl_line(0x56)
	.dwattr $C$DW$T$28, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$28

	.dwendtag $C$DW$TU$28


$C$DW$TU$29	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$29
$C$DW$T$29	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$29, DW_AT_name("CPUTimer_EmulationMode")
	.dwattr $C$DW$T$29, DW_AT_type(*$C$DW$T$28)
	.dwattr $C$DW$T$29, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h")
	.dwattr $C$DW$T$29, DW_AT_decl_line(0x5d)
	.dwattr $C$DW$T$29, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$29


$C$DW$TU$30	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$30

$C$DW$T$30	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$30, DW_AT_byte_size(0x01)
$C$DW$368	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$368, DW_AT_name("EPWM_CLOCK_DIVIDER_1")
	.dwattr $C$DW$368, DW_AT_const_value(0x00)
	.dwattr $C$DW$368, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$368, DW_AT_decl_line(0x6f)
	.dwattr $C$DW$368, DW_AT_decl_column(0x05)

$C$DW$369	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$369, DW_AT_name("EPWM_CLOCK_DIVIDER_2")
	.dwattr $C$DW$369, DW_AT_const_value(0x01)
	.dwattr $C$DW$369, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$369, DW_AT_decl_line(0x70)
	.dwattr $C$DW$369, DW_AT_decl_column(0x05)

$C$DW$370	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$370, DW_AT_name("EPWM_CLOCK_DIVIDER_4")
	.dwattr $C$DW$370, DW_AT_const_value(0x02)
	.dwattr $C$DW$370, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$370, DW_AT_decl_line(0x71)
	.dwattr $C$DW$370, DW_AT_decl_column(0x05)

$C$DW$371	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$371, DW_AT_name("EPWM_CLOCK_DIVIDER_8")
	.dwattr $C$DW$371, DW_AT_const_value(0x03)
	.dwattr $C$DW$371, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$371, DW_AT_decl_line(0x72)
	.dwattr $C$DW$371, DW_AT_decl_column(0x05)

$C$DW$372	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$372, DW_AT_name("EPWM_CLOCK_DIVIDER_16")
	.dwattr $C$DW$372, DW_AT_const_value(0x04)
	.dwattr $C$DW$372, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$372, DW_AT_decl_line(0x73)
	.dwattr $C$DW$372, DW_AT_decl_column(0x05)

$C$DW$373	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$373, DW_AT_name("EPWM_CLOCK_DIVIDER_32")
	.dwattr $C$DW$373, DW_AT_const_value(0x05)
	.dwattr $C$DW$373, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$373, DW_AT_decl_line(0x74)
	.dwattr $C$DW$373, DW_AT_decl_column(0x05)

$C$DW$374	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$374, DW_AT_name("EPWM_CLOCK_DIVIDER_64")
	.dwattr $C$DW$374, DW_AT_const_value(0x06)
	.dwattr $C$DW$374, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$374, DW_AT_decl_line(0x75)
	.dwattr $C$DW$374, DW_AT_decl_column(0x05)

$C$DW$375	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$375, DW_AT_name("EPWM_CLOCK_DIVIDER_128")
	.dwattr $C$DW$375, DW_AT_const_value(0x07)
	.dwattr $C$DW$375, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$375, DW_AT_decl_line(0x76)
	.dwattr $C$DW$375, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$30, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$30, DW_AT_decl_line(0x6e)
	.dwattr $C$DW$T$30, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$30

	.dwendtag $C$DW$TU$30


$C$DW$TU$31	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$31
$C$DW$T$31	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$31, DW_AT_name("EPWM_ClockDivider")
	.dwattr $C$DW$T$31, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$T$31, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$31, DW_AT_decl_line(0x77)
	.dwattr $C$DW$T$31, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$31


$C$DW$TU$32	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$32

$C$DW$T$32	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$32, DW_AT_byte_size(0x01)
$C$DW$376	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$376, DW_AT_name("EPWM_HSCLOCK_DIVIDER_1")
	.dwattr $C$DW$376, DW_AT_const_value(0x00)
	.dwattr $C$DW$376, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$376, DW_AT_decl_line(0x81)
	.dwattr $C$DW$376, DW_AT_decl_column(0x05)

$C$DW$377	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$377, DW_AT_name("EPWM_HSCLOCK_DIVIDER_2")
	.dwattr $C$DW$377, DW_AT_const_value(0x01)
	.dwattr $C$DW$377, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$377, DW_AT_decl_line(0x82)
	.dwattr $C$DW$377, DW_AT_decl_column(0x05)

$C$DW$378	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$378, DW_AT_name("EPWM_HSCLOCK_DIVIDER_4")
	.dwattr $C$DW$378, DW_AT_const_value(0x02)
	.dwattr $C$DW$378, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$378, DW_AT_decl_line(0x83)
	.dwattr $C$DW$378, DW_AT_decl_column(0x05)

$C$DW$379	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$379, DW_AT_name("EPWM_HSCLOCK_DIVIDER_6")
	.dwattr $C$DW$379, DW_AT_const_value(0x03)
	.dwattr $C$DW$379, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$379, DW_AT_decl_line(0x84)
	.dwattr $C$DW$379, DW_AT_decl_column(0x05)

$C$DW$380	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$380, DW_AT_name("EPWM_HSCLOCK_DIVIDER_8")
	.dwattr $C$DW$380, DW_AT_const_value(0x04)
	.dwattr $C$DW$380, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$380, DW_AT_decl_line(0x85)
	.dwattr $C$DW$380, DW_AT_decl_column(0x05)

$C$DW$381	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$381, DW_AT_name("EPWM_HSCLOCK_DIVIDER_10")
	.dwattr $C$DW$381, DW_AT_const_value(0x05)
	.dwattr $C$DW$381, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$381, DW_AT_decl_line(0x86)
	.dwattr $C$DW$381, DW_AT_decl_column(0x05)

$C$DW$382	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$382, DW_AT_name("EPWM_HSCLOCK_DIVIDER_12")
	.dwattr $C$DW$382, DW_AT_const_value(0x06)
	.dwattr $C$DW$382, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$382, DW_AT_decl_line(0x87)
	.dwattr $C$DW$382, DW_AT_decl_column(0x05)

$C$DW$383	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$383, DW_AT_name("EPWM_HSCLOCK_DIVIDER_14")
	.dwattr $C$DW$383, DW_AT_const_value(0x07)
	.dwattr $C$DW$383, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$383, DW_AT_decl_line(0x88)
	.dwattr $C$DW$383, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$32, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$32, DW_AT_decl_line(0x80)
	.dwattr $C$DW$T$32, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$32

	.dwendtag $C$DW$TU$32


$C$DW$TU$33	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$33
$C$DW$T$33	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$33, DW_AT_name("EPWM_HSClockDivider")
	.dwattr $C$DW$T$33, DW_AT_type(*$C$DW$T$32)
	.dwattr $C$DW$T$33, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$33, DW_AT_decl_line(0x89)
	.dwattr $C$DW$T$33, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$33


$C$DW$TU$34	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$34

$C$DW$T$34	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$34, DW_AT_byte_size(0x01)
$C$DW$384	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$384, DW_AT_name("EPWM_PERIOD_SHADOW_LOAD")
	.dwattr $C$DW$384, DW_AT_const_value(0x00)
	.dwattr $C$DW$384, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$384, DW_AT_decl_line(0xac)
	.dwattr $C$DW$384, DW_AT_decl_column(0x05)

$C$DW$385	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$385, DW_AT_name("EPWM_PERIOD_DIRECT_LOAD")
	.dwattr $C$DW$385, DW_AT_const_value(0x01)
	.dwattr $C$DW$385, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$385, DW_AT_decl_line(0xae)
	.dwattr $C$DW$385, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$34, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$34, DW_AT_decl_line(0xaa)
	.dwattr $C$DW$T$34, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$34

	.dwendtag $C$DW$TU$34


$C$DW$TU$35	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$35
$C$DW$T$35	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$35, DW_AT_name("EPWM_PeriodLoadMode")
	.dwattr $C$DW$T$35, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$T$35, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$35, DW_AT_decl_line(0xaf)
	.dwattr $C$DW$T$35, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$35


$C$DW$TU$36	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$36

$C$DW$T$36	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$36, DW_AT_byte_size(0x01)
$C$DW$386	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$386, DW_AT_name("EPWM_COUNTER_MODE_UP")
	.dwattr $C$DW$386, DW_AT_const_value(0x00)
	.dwattr $C$DW$386, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$386, DW_AT_decl_line(0xb9)
	.dwattr $C$DW$386, DW_AT_decl_column(0x05)

$C$DW$387	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$387, DW_AT_name("EPWM_COUNTER_MODE_DOWN")
	.dwattr $C$DW$387, DW_AT_const_value(0x01)
	.dwattr $C$DW$387, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$387, DW_AT_decl_line(0xba)
	.dwattr $C$DW$387, DW_AT_decl_column(0x05)

$C$DW$388	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$388, DW_AT_name("EPWM_COUNTER_MODE_UP_DOWN")
	.dwattr $C$DW$388, DW_AT_const_value(0x02)
	.dwattr $C$DW$388, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$388, DW_AT_decl_line(0xbb)
	.dwattr $C$DW$388, DW_AT_decl_column(0x05)

$C$DW$389	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$389, DW_AT_name("EPWM_COUNTER_MODE_STOP_FREEZE")
	.dwattr $C$DW$389, DW_AT_const_value(0x03)
	.dwattr $C$DW$389, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$389, DW_AT_decl_line(0xbc)
	.dwattr $C$DW$389, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$36, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$36, DW_AT_decl_line(0xb8)
	.dwattr $C$DW$T$36, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$36

	.dwendtag $C$DW$TU$36


$C$DW$TU$37	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$37
$C$DW$T$37	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$37, DW_AT_name("EPWM_TimeBaseCountMode")
	.dwattr $C$DW$T$37, DW_AT_type(*$C$DW$T$36)
	.dwattr $C$DW$T$37, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$37, DW_AT_decl_line(0xbd)
	.dwattr $C$DW$T$37, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$37


$C$DW$TU$38	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$38

$C$DW$T$38	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$38, DW_AT_byte_size(0x01)
$C$DW$390	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$390, DW_AT_name("EPWM_COUNTER_COMPARE_A")
	.dwattr $C$DW$390, DW_AT_const_value(0x00)
	.dwattr $C$DW$390, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$390, DW_AT_decl_line(0x10f)
	.dwattr $C$DW$390, DW_AT_decl_column(0x05)

$C$DW$391	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$391, DW_AT_name("EPWM_COUNTER_COMPARE_B")
	.dwattr $C$DW$391, DW_AT_const_value(0x02)
	.dwattr $C$DW$391, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$391, DW_AT_decl_line(0x110)
	.dwattr $C$DW$391, DW_AT_decl_column(0x05)

$C$DW$392	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$392, DW_AT_name("EPWM_COUNTER_COMPARE_C")
	.dwattr $C$DW$392, DW_AT_const_value(0x05)
	.dwattr $C$DW$392, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$392, DW_AT_decl_line(0x111)
	.dwattr $C$DW$392, DW_AT_decl_column(0x05)

$C$DW$393	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$393, DW_AT_name("EPWM_COUNTER_COMPARE_D")
	.dwattr $C$DW$393, DW_AT_const_value(0x07)
	.dwattr $C$DW$393, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$393, DW_AT_decl_line(0x112)
	.dwattr $C$DW$393, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$38, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$38, DW_AT_decl_line(0x10e)
	.dwattr $C$DW$T$38, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$38

	.dwendtag $C$DW$TU$38


$C$DW$TU$39	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$39
$C$DW$T$39	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$39, DW_AT_name("EPWM_CounterCompareModule")
	.dwattr $C$DW$T$39, DW_AT_type(*$C$DW$T$38)
	.dwattr $C$DW$T$39, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$39, DW_AT_decl_line(0x113)
	.dwattr $C$DW$T$39, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$39


$C$DW$TU$40	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$40

$C$DW$T$40	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$40, DW_AT_byte_size(0x01)
$C$DW$394	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$394, DW_AT_name("EPWM_COMP_LOAD_ON_CNTR_ZERO")
	.dwattr $C$DW$394, DW_AT_const_value(0x00)
	.dwattr $C$DW$394, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$394, DW_AT_decl_line(0x11e)
	.dwattr $C$DW$394, DW_AT_decl_column(0x05)

$C$DW$395	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$395, DW_AT_name("EPWM_COMP_LOAD_ON_CNTR_PERIOD")
	.dwattr $C$DW$395, DW_AT_const_value(0x01)
	.dwattr $C$DW$395, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$395, DW_AT_decl_line(0x120)
	.dwattr $C$DW$395, DW_AT_decl_column(0x05)

$C$DW$396	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$396, DW_AT_name("EPWM_COMP_LOAD_ON_CNTR_ZERO_PERIOD")
	.dwattr $C$DW$396, DW_AT_const_value(0x02)
	.dwattr $C$DW$396, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$396, DW_AT_decl_line(0x122)
	.dwattr $C$DW$396, DW_AT_decl_column(0x05)

$C$DW$397	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$397, DW_AT_name("EPWM_COMP_LOAD_FREEZE")
	.dwattr $C$DW$397, DW_AT_const_value(0x03)
	.dwattr $C$DW$397, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$397, DW_AT_decl_line(0x124)
	.dwattr $C$DW$397, DW_AT_decl_column(0x05)

$C$DW$398	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$398, DW_AT_name("EPWM_COMP_LOAD_ON_SYNC_CNTR_ZERO")
	.dwattr $C$DW$398, DW_AT_const_value(0x04)
	.dwattr $C$DW$398, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$398, DW_AT_decl_line(0x126)
	.dwattr $C$DW$398, DW_AT_decl_column(0x05)

$C$DW$399	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$399, DW_AT_name("EPWM_COMP_LOAD_ON_SYNC_CNTR_PERIOD")
	.dwattr $C$DW$399, DW_AT_const_value(0x05)
	.dwattr $C$DW$399, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$399, DW_AT_decl_line(0x128)
	.dwattr $C$DW$399, DW_AT_decl_column(0x05)

$C$DW$400	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$400, DW_AT_name("EPWM_COMP_LOAD_ON_SYNC_CNTR_ZERO_PERIOD")
	.dwattr $C$DW$400, DW_AT_const_value(0x06)
	.dwattr $C$DW$400, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$400, DW_AT_decl_line(0x12a)
	.dwattr $C$DW$400, DW_AT_decl_column(0x05)

$C$DW$401	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$401, DW_AT_name("EPWM_COMP_LOAD_ON_SYNC_ONLY")
	.dwattr $C$DW$401, DW_AT_const_value(0x08)
	.dwattr $C$DW$401, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$401, DW_AT_decl_line(0x12c)
	.dwattr $C$DW$401, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$40, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$40, DW_AT_decl_line(0x11c)
	.dwattr $C$DW$T$40, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$40

	.dwendtag $C$DW$TU$40


$C$DW$TU$41	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$41
$C$DW$T$41	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$41, DW_AT_name("EPWM_CounterCompareLoadMode")
	.dwattr $C$DW$T$41, DW_AT_type(*$C$DW$T$40)
	.dwattr $C$DW$T$41, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$41, DW_AT_decl_line(0x12d)
	.dwattr $C$DW$T$41, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$41


$C$DW$TU$42	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$42

$C$DW$T$42	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$42, DW_AT_byte_size(0x01)
$C$DW$402	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$402, DW_AT_name("EPWM_ACTION_QUALIFIER_A")
	.dwattr $C$DW$402, DW_AT_const_value(0x00)
	.dwattr $C$DW$402, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$402, DW_AT_decl_line(0x13a)
	.dwattr $C$DW$402, DW_AT_decl_column(0x05)

$C$DW$403	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$403, DW_AT_name("EPWM_ACTION_QUALIFIER_B")
	.dwattr $C$DW$403, DW_AT_const_value(0x02)
	.dwattr $C$DW$403, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$403, DW_AT_decl_line(0x13b)
	.dwattr $C$DW$403, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$42, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$42, DW_AT_decl_line(0x139)
	.dwattr $C$DW$T$42, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$42

	.dwendtag $C$DW$TU$42


$C$DW$TU$43	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$43
$C$DW$T$43	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$43, DW_AT_name("EPWM_ActionQualifierModule")
	.dwattr $C$DW$T$43, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$T$43, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$43, DW_AT_decl_line(0x13c)
	.dwattr $C$DW$T$43, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$43


$C$DW$TU$44	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$44

$C$DW$T$44	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$44, DW_AT_byte_size(0x01)
$C$DW$404	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$404, DW_AT_name("EPWM_AQ_LOAD_ON_CNTR_ZERO")
	.dwattr $C$DW$404, DW_AT_const_value(0x00)
	.dwattr $C$DW$404, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$404, DW_AT_decl_line(0x147)
	.dwattr $C$DW$404, DW_AT_decl_column(0x05)

$C$DW$405	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$405, DW_AT_name("EPWM_AQ_LOAD_ON_CNTR_PERIOD")
	.dwattr $C$DW$405, DW_AT_const_value(0x01)
	.dwattr $C$DW$405, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$405, DW_AT_decl_line(0x149)
	.dwattr $C$DW$405, DW_AT_decl_column(0x05)

$C$DW$406	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$406, DW_AT_name("EPWM_AQ_LOAD_ON_CNTR_ZERO_PERIOD")
	.dwattr $C$DW$406, DW_AT_const_value(0x02)
	.dwattr $C$DW$406, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$406, DW_AT_decl_line(0x14b)
	.dwattr $C$DW$406, DW_AT_decl_column(0x05)

$C$DW$407	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$407, DW_AT_name("EPWM_AQ_LOAD_FREEZE")
	.dwattr $C$DW$407, DW_AT_const_value(0x03)
	.dwattr $C$DW$407, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$407, DW_AT_decl_line(0x14d)
	.dwattr $C$DW$407, DW_AT_decl_column(0x05)

$C$DW$408	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$408, DW_AT_name("EPWM_AQ_LOAD_ON_SYNC_CNTR_ZERO")
	.dwattr $C$DW$408, DW_AT_const_value(0x04)
	.dwattr $C$DW$408, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$408, DW_AT_decl_line(0x14f)
	.dwattr $C$DW$408, DW_AT_decl_column(0x05)

$C$DW$409	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$409, DW_AT_name("EPWM_AQ_LOAD_ON_SYNC_CNTR_PERIOD")
	.dwattr $C$DW$409, DW_AT_const_value(0x05)
	.dwattr $C$DW$409, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$409, DW_AT_decl_line(0x151)
	.dwattr $C$DW$409, DW_AT_decl_column(0x05)

$C$DW$410	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$410, DW_AT_name("EPWM_AQ_LOAD_ON_SYNC_CNTR_ZERO_PERIOD")
	.dwattr $C$DW$410, DW_AT_const_value(0x06)
	.dwattr $C$DW$410, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$410, DW_AT_decl_line(0x153)
	.dwattr $C$DW$410, DW_AT_decl_column(0x05)

$C$DW$411	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$411, DW_AT_name("EPWM_AQ_LOAD_ON_SYNC_ONLY")
	.dwattr $C$DW$411, DW_AT_const_value(0x08)
	.dwattr $C$DW$411, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$411, DW_AT_decl_line(0x155)
	.dwattr $C$DW$411, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$44, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$44, DW_AT_decl_line(0x145)
	.dwattr $C$DW$T$44, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$44

	.dwendtag $C$DW$TU$44


$C$DW$TU$45	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$45
$C$DW$T$45	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$45, DW_AT_name("EPWM_ActionQualifierLoadMode")
	.dwattr $C$DW$T$45, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$T$45, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$45, DW_AT_decl_line(0x156)
	.dwattr $C$DW$T$45, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$45


$C$DW$TU$46	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$46

$C$DW$T$46	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$46, DW_AT_byte_size(0x01)
$C$DW$412	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$412, DW_AT_name("EPWM_AQ_OUTPUT_A")
	.dwattr $C$DW$412, DW_AT_const_value(0x00)
	.dwattr $C$DW$412, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$412, DW_AT_decl_line(0x211)
	.dwattr $C$DW$412, DW_AT_decl_column(0x05)

$C$DW$413	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$413, DW_AT_name("EPWM_AQ_OUTPUT_B")
	.dwattr $C$DW$413, DW_AT_const_value(0x02)
	.dwattr $C$DW$413, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$413, DW_AT_decl_line(0x212)
	.dwattr $C$DW$413, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$46, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$46, DW_AT_decl_line(0x210)
	.dwattr $C$DW$T$46, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$46

	.dwendtag $C$DW$TU$46


$C$DW$TU$47	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$47
$C$DW$T$47	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$47, DW_AT_name("EPWM_ActionQualifierOutputModule")
	.dwattr $C$DW$T$47, DW_AT_type(*$C$DW$T$46)
	.dwattr $C$DW$T$47, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$47, DW_AT_decl_line(0x213)
	.dwattr $C$DW$T$47, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$47


$C$DW$TU$48	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$48

$C$DW$T$48	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$48, DW_AT_byte_size(0x01)
$C$DW$414	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$414, DW_AT_name("EPWM_AQ_OUTPUT_NO_CHANGE")
	.dwattr $C$DW$414, DW_AT_const_value(0x00)
	.dwattr $C$DW$414, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$414, DW_AT_decl_line(0x190)
	.dwattr $C$DW$414, DW_AT_decl_column(0x05)

$C$DW$415	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$415, DW_AT_name("EPWM_AQ_OUTPUT_LOW")
	.dwattr $C$DW$415, DW_AT_const_value(0x01)
	.dwattr $C$DW$415, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$415, DW_AT_decl_line(0x191)
	.dwattr $C$DW$415, DW_AT_decl_column(0x05)

$C$DW$416	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$416, DW_AT_name("EPWM_AQ_OUTPUT_HIGH")
	.dwattr $C$DW$416, DW_AT_const_value(0x02)
	.dwattr $C$DW$416, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$416, DW_AT_decl_line(0x192)
	.dwattr $C$DW$416, DW_AT_decl_column(0x05)

$C$DW$417	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$417, DW_AT_name("EPWM_AQ_OUTPUT_TOGGLE")
	.dwattr $C$DW$417, DW_AT_const_value(0x03)
	.dwattr $C$DW$417, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$417, DW_AT_decl_line(0x193)
	.dwattr $C$DW$417, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$48, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$48, DW_AT_decl_line(0x18f)
	.dwattr $C$DW$T$48, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$48

	.dwendtag $C$DW$TU$48


$C$DW$TU$49	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$49
$C$DW$T$49	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$49, DW_AT_name("EPWM_ActionQualifierOutput")
	.dwattr $C$DW$T$49, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$T$49, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$49, DW_AT_decl_line(0x194)
	.dwattr $C$DW$T$49, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$49


$C$DW$TU$50	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$50

$C$DW$T$50	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$50, DW_AT_byte_size(0x01)
$C$DW$418	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$418, DW_AT_name("EPWM_AQ_OUTPUT_ON_TIMEBASE_ZERO")
	.dwattr $C$DW$418, DW_AT_const_value(0x00)
	.dwattr $C$DW$418, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$418, DW_AT_decl_line(0x173)
	.dwattr $C$DW$418, DW_AT_decl_column(0x05)

$C$DW$419	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$419, DW_AT_name("EPWM_AQ_OUTPUT_ON_TIMEBASE_PERIOD")
	.dwattr $C$DW$419, DW_AT_const_value(0x02)
	.dwattr $C$DW$419, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$419, DW_AT_decl_line(0x175)
	.dwattr $C$DW$419, DW_AT_decl_column(0x05)

$C$DW$420	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$420, DW_AT_name("EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPA")
	.dwattr $C$DW$420, DW_AT_const_value(0x04)
	.dwattr $C$DW$420, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$420, DW_AT_decl_line(0x177)
	.dwattr $C$DW$420, DW_AT_decl_column(0x05)

$C$DW$421	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$421, DW_AT_name("EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPA")
	.dwattr $C$DW$421, DW_AT_const_value(0x06)
	.dwattr $C$DW$421, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$421, DW_AT_decl_line(0x179)
	.dwattr $C$DW$421, DW_AT_decl_column(0x05)

$C$DW$422	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$422, DW_AT_name("EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPB")
	.dwattr $C$DW$422, DW_AT_const_value(0x08)
	.dwattr $C$DW$422, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$422, DW_AT_decl_line(0x17b)
	.dwattr $C$DW$422, DW_AT_decl_column(0x05)

$C$DW$423	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$423, DW_AT_name("EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPB")
	.dwattr $C$DW$423, DW_AT_const_value(0x0a)
	.dwattr $C$DW$423, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$423, DW_AT_decl_line(0x17d)
	.dwattr $C$DW$423, DW_AT_decl_column(0x05)

$C$DW$424	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$424, DW_AT_name("EPWM_AQ_OUTPUT_ON_T1_COUNT_UP")
	.dwattr $C$DW$424, DW_AT_const_value(0x01)
	.dwattr $C$DW$424, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$424, DW_AT_decl_line(0x17f)
	.dwattr $C$DW$424, DW_AT_decl_column(0x05)

$C$DW$425	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$425, DW_AT_name("EPWM_AQ_OUTPUT_ON_T1_COUNT_DOWN")
	.dwattr $C$DW$425, DW_AT_const_value(0x03)
	.dwattr $C$DW$425, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$425, DW_AT_decl_line(0x181)
	.dwattr $C$DW$425, DW_AT_decl_column(0x05)

$C$DW$426	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$426, DW_AT_name("EPWM_AQ_OUTPUT_ON_T2_COUNT_UP")
	.dwattr $C$DW$426, DW_AT_const_value(0x05)
	.dwattr $C$DW$426, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$426, DW_AT_decl_line(0x183)
	.dwattr $C$DW$426, DW_AT_decl_column(0x05)

$C$DW$427	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$427, DW_AT_name("EPWM_AQ_OUTPUT_ON_T2_COUNT_DOWN")
	.dwattr $C$DW$427, DW_AT_const_value(0x07)
	.dwattr $C$DW$427, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$427, DW_AT_decl_line(0x185)
	.dwattr $C$DW$427, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$50, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$50, DW_AT_decl_line(0x171)
	.dwattr $C$DW$T$50, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$50

	.dwendtag $C$DW$TU$50


$C$DW$TU$51	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$51
$C$DW$T$51	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$51, DW_AT_name("EPWM_ActionQualifierOutputEvent")
	.dwattr $C$DW$T$51, DW_AT_type(*$C$DW$T$50)
	.dwattr $C$DW$T$51, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$51, DW_AT_decl_line(0x186)
	.dwattr $C$DW$T$51, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$51


$C$DW$TU$52	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$52

$C$DW$T$52	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$52, DW_AT_byte_size(0x01)
$C$DW$428	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$428, DW_AT_name("EPWM_DB_RED")
	.dwattr $C$DW$428, DW_AT_const_value(0x01)
	.dwattr $C$DW$428, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$428, DW_AT_decl_line(0x23b)
	.dwattr $C$DW$428, DW_AT_decl_column(0x05)

$C$DW$429	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$429, DW_AT_name("EPWM_DB_FED")
	.dwattr $C$DW$429, DW_AT_const_value(0x00)
	.dwattr $C$DW$429, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$429, DW_AT_decl_line(0x23c)
	.dwattr $C$DW$429, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$52, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$52, DW_AT_decl_line(0x23a)
	.dwattr $C$DW$T$52, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$52

	.dwendtag $C$DW$TU$52


$C$DW$TU$53	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$53
$C$DW$T$53	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$53, DW_AT_name("EPWM_DeadBandDelayMode")
	.dwattr $C$DW$T$53, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$T$53, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$53, DW_AT_decl_line(0x23d)
	.dwattr $C$DW$T$53, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$53


$C$DW$TU$54	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$54

$C$DW$T$54	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$54, DW_AT_byte_size(0x01)
$C$DW$430	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$430, DW_AT_name("EPWM_DB_POLARITY_ACTIVE_HIGH")
	.dwattr $C$DW$430, DW_AT_const_value(0x00)
	.dwattr $C$DW$430, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$430, DW_AT_decl_line(0x247)
	.dwattr $C$DW$430, DW_AT_decl_column(0x05)

$C$DW$431	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$431, DW_AT_name("EPWM_DB_POLARITY_ACTIVE_LOW")
	.dwattr $C$DW$431, DW_AT_const_value(0x01)
	.dwattr $C$DW$431, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$431, DW_AT_decl_line(0x248)
	.dwattr $C$DW$431, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$54, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$54, DW_AT_decl_line(0x246)
	.dwattr $C$DW$T$54, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$54

	.dwendtag $C$DW$TU$54


$C$DW$TU$55	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$55
$C$DW$T$55	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$55, DW_AT_name("EPWM_DeadBandPolarity")
	.dwattr $C$DW$T$55, DW_AT_type(*$C$DW$T$54)
	.dwattr $C$DW$T$55, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$55, DW_AT_decl_line(0x249)
	.dwattr $C$DW$T$55, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$55


$C$DW$TU$56	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$56

$C$DW$T$56	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$56, DW_AT_byte_size(0x01)
$C$DW$432	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$432, DW_AT_name("EPWM_EMULATION_STOP_AFTER_NEXT_TB")
	.dwattr $C$DW$432, DW_AT_const_value(0x00)
	.dwattr $C$DW$432, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$432, DW_AT_decl_line(0x54)
	.dwattr $C$DW$432, DW_AT_decl_column(0x04)

$C$DW$433	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$433, DW_AT_name("EPWM_EMULATION_STOP_AFTER_FULL_CYCLE")
	.dwattr $C$DW$433, DW_AT_const_value(0x01)
	.dwattr $C$DW$433, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$433, DW_AT_decl_line(0x56)
	.dwattr $C$DW$433, DW_AT_decl_column(0x04)

$C$DW$434	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$434, DW_AT_name("EPWM_EMULATION_FREE_RUN")
	.dwattr $C$DW$434, DW_AT_const_value(0x02)
	.dwattr $C$DW$434, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$434, DW_AT_decl_line(0x58)
	.dwattr $C$DW$434, DW_AT_decl_column(0x04)

	.dwattr $C$DW$T$56, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$56, DW_AT_decl_line(0x52)
	.dwattr $C$DW$T$56, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$56

	.dwendtag $C$DW$TU$56


$C$DW$TU$57	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$57
$C$DW$T$57	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$57, DW_AT_name("EPWM_EmulationMode")
	.dwattr $C$DW$T$57, DW_AT_type(*$C$DW$T$56)
	.dwattr $C$DW$T$57, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$57, DW_AT_decl_line(0x59)
	.dwattr $C$DW$T$57, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$57


$C$DW$TU$58	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$58

$C$DW$T$58	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$58, DW_AT_byte_size(0x01)
$C$DW$435	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$435, DW_AT_name("GPIO_INT_XINT1")
	.dwattr $C$DW$435, DW_AT_const_value(0x00)
	.dwattr $C$DW$435, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$435, DW_AT_decl_line(0xce)
	.dwattr $C$DW$435, DW_AT_decl_column(0x05)

$C$DW$436	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$436, DW_AT_name("GPIO_INT_XINT2")
	.dwattr $C$DW$436, DW_AT_const_value(0x01)
	.dwattr $C$DW$436, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$436, DW_AT_decl_line(0xcf)
	.dwattr $C$DW$436, DW_AT_decl_column(0x05)

$C$DW$437	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$437, DW_AT_name("GPIO_INT_XINT3")
	.dwattr $C$DW$437, DW_AT_const_value(0x02)
	.dwattr $C$DW$437, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$437, DW_AT_decl_line(0xd0)
	.dwattr $C$DW$437, DW_AT_decl_column(0x05)

$C$DW$438	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$438, DW_AT_name("GPIO_INT_XINT4")
	.dwattr $C$DW$438, DW_AT_const_value(0x03)
	.dwattr $C$DW$438, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$438, DW_AT_decl_line(0xd1)
	.dwattr $C$DW$438, DW_AT_decl_column(0x05)

$C$DW$439	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$439, DW_AT_name("GPIO_INT_XINT5")
	.dwattr $C$DW$439, DW_AT_const_value(0x04)
	.dwattr $C$DW$439, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$439, DW_AT_decl_line(0xd2)
	.dwattr $C$DW$439, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$58, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$58, DW_AT_decl_line(0xcd)
	.dwattr $C$DW$T$58, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$58

	.dwendtag $C$DW$TU$58


$C$DW$TU$59	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$59
$C$DW$T$59	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$59, DW_AT_name("GPIO_ExternalIntNum")
	.dwattr $C$DW$T$59, DW_AT_type(*$C$DW$T$58)
	.dwattr $C$DW$T$59, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$59, DW_AT_decl_line(0xd3)
	.dwattr $C$DW$T$59, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$59


$C$DW$TU$60	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$60

$C$DW$T$60	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$60, DW_AT_byte_size(0x01)
$C$DW$440	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$440, DW_AT_name("GPIO_INT_TYPE_FALLING_EDGE")
	.dwattr $C$DW$440, DW_AT_const_value(0x00)
	.dwattr $C$DW$440, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$440, DW_AT_decl_line(0x8a)
	.dwattr $C$DW$440, DW_AT_decl_column(0x05)

$C$DW$441	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$441, DW_AT_name("GPIO_INT_TYPE_RISING_EDGE")
	.dwattr $C$DW$441, DW_AT_const_value(0x04)
	.dwattr $C$DW$441, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$441, DW_AT_decl_line(0x8b)
	.dwattr $C$DW$441, DW_AT_decl_column(0x05)

$C$DW$442	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$442, DW_AT_name("GPIO_INT_TYPE_BOTH_EDGES")
	.dwattr $C$DW$442, DW_AT_const_value(0x0c)
	.dwattr $C$DW$442, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$442, DW_AT_decl_line(0x8c)
	.dwattr $C$DW$442, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$60, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$60, DW_AT_decl_line(0x89)
	.dwattr $C$DW$T$60, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$60

	.dwendtag $C$DW$TU$60


$C$DW$TU$61	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$61
$C$DW$T$61	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$61, DW_AT_name("GPIO_IntType")
	.dwattr $C$DW$T$61, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$T$61, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$61, DW_AT_decl_line(0x8d)
	.dwattr $C$DW$T$61, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$61


$C$DW$TU$62	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$62

$C$DW$T$62	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$62, DW_AT_byte_size(0x01)
$C$DW$443	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$443, DW_AT_name("GPIO_DIR_MODE_IN")
	.dwattr $C$DW$443, DW_AT_const_value(0x00)
	.dwattr $C$DW$443, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$443, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$443, DW_AT_decl_column(0x05)

$C$DW$444	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$444, DW_AT_name("GPIO_DIR_MODE_OUT")
	.dwattr $C$DW$444, DW_AT_const_value(0x01)
	.dwattr $C$DW$444, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$444, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$444, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$62, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$62, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$T$62, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$62

	.dwendtag $C$DW$TU$62


$C$DW$TU$63	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$63
$C$DW$T$63	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$63, DW_AT_name("GPIO_Direction")
	.dwattr $C$DW$T$63, DW_AT_type(*$C$DW$T$62)
	.dwattr $C$DW$T$63, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$63, DW_AT_decl_line(0x80)
	.dwattr $C$DW$T$63, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$63


$C$DW$TU$64	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$64

$C$DW$T$64	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$64, DW_AT_byte_size(0x01)
$C$DW$445	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$445, DW_AT_name("GPIO_QUAL_SYNC")
	.dwattr $C$DW$445, DW_AT_const_value(0x00)
	.dwattr $C$DW$445, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$445, DW_AT_decl_line(0x97)
	.dwattr $C$DW$445, DW_AT_decl_column(0x05)

$C$DW$446	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$446, DW_AT_name("GPIO_QUAL_3SAMPLE")
	.dwattr $C$DW$446, DW_AT_const_value(0x01)
	.dwattr $C$DW$446, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$446, DW_AT_decl_line(0x98)
	.dwattr $C$DW$446, DW_AT_decl_column(0x05)

$C$DW$447	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$447, DW_AT_name("GPIO_QUAL_6SAMPLE")
	.dwattr $C$DW$447, DW_AT_const_value(0x02)
	.dwattr $C$DW$447, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$447, DW_AT_decl_line(0x99)
	.dwattr $C$DW$447, DW_AT_decl_column(0x05)

$C$DW$448	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$448, DW_AT_name("GPIO_QUAL_ASYNC")
	.dwattr $C$DW$448, DW_AT_const_value(0x03)
	.dwattr $C$DW$448, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$448, DW_AT_decl_line(0x9a)
	.dwattr $C$DW$448, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$64, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$64, DW_AT_decl_line(0x96)
	.dwattr $C$DW$T$64, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$64

	.dwendtag $C$DW$TU$64


$C$DW$TU$65	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$65
$C$DW$T$65	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$65, DW_AT_name("GPIO_QualificationMode")
	.dwattr $C$DW$T$65, DW_AT_type(*$C$DW$T$64)
	.dwattr $C$DW$T$65, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$65, DW_AT_decl_line(0x9b)
	.dwattr $C$DW$T$65, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$65


$C$DW$TU$66	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$66

$C$DW$T$66	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$66, DW_AT_byte_size(0x01)
$C$DW$449	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$449, DW_AT_name("GPIO_CORE_CPU1")
	.dwattr $C$DW$449, DW_AT_const_value(0x00)
	.dwattr $C$DW$449, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$449, DW_AT_decl_line(0xaf)
	.dwattr $C$DW$449, DW_AT_decl_column(0x05)

$C$DW$450	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$450, DW_AT_name("GPIO_CORE_CPU1_CLA1")
	.dwattr $C$DW$450, DW_AT_const_value(0x01)
	.dwattr $C$DW$450, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$450, DW_AT_decl_line(0xb0)
	.dwattr $C$DW$450, DW_AT_decl_column(0x05)

$C$DW$451	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$451, DW_AT_name("GPIO_CORE_CPU2")
	.dwattr $C$DW$451, DW_AT_const_value(0x02)
	.dwattr $C$DW$451, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$451, DW_AT_decl_line(0xb1)
	.dwattr $C$DW$451, DW_AT_decl_column(0x05)

$C$DW$452	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$452, DW_AT_name("GPIO_CORE_CPU2_CLA1")
	.dwattr $C$DW$452, DW_AT_const_value(0x03)
	.dwattr $C$DW$452, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$452, DW_AT_decl_line(0xb2)
	.dwattr $C$DW$452, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$66, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$66, DW_AT_decl_line(0xae)
	.dwattr $C$DW$T$66, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$66

	.dwendtag $C$DW$TU$66


$C$DW$TU$67	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$67
$C$DW$T$67	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$67, DW_AT_name("GPIO_CoreSelect")
	.dwattr $C$DW$T$67, DW_AT_type(*$C$DW$T$66)
	.dwattr $C$DW$T$67, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$67, DW_AT_decl_line(0xb3)
	.dwattr $C$DW$T$67, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$67


$C$DW$TU$68	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$68

$C$DW$T$68	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$68, DW_AT_byte_size(0x01)
$C$DW$453	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$453, DW_AT_name("GPIO_ANALOG_DISABLED")
	.dwattr $C$DW$453, DW_AT_const_value(0x00)
	.dwattr $C$DW$453, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$453, DW_AT_decl_line(0xa4)
	.dwattr $C$DW$453, DW_AT_decl_column(0x05)

$C$DW$454	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$454, DW_AT_name("GPIO_ANALOG_ENABLED")
	.dwattr $C$DW$454, DW_AT_const_value(0x01)
	.dwattr $C$DW$454, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$454, DW_AT_decl_line(0xa5)
	.dwattr $C$DW$454, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$68, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$68, DW_AT_decl_line(0xa3)
	.dwattr $C$DW$T$68, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$68

	.dwendtag $C$DW$TU$68


$C$DW$TU$69	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$69
$C$DW$T$69	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$69, DW_AT_name("GPIO_AnalogMode")
	.dwattr $C$DW$T$69, DW_AT_type(*$C$DW$T$68)
	.dwattr $C$DW$T$69, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$69, DW_AT_decl_line(0xa6)
	.dwattr $C$DW$T$69, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$69


$C$DW$TU$70	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$70

$C$DW$T$70	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$70, DW_AT_byte_size(0x01)
$C$DW$455	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$455, DW_AT_name("HRPWM_CHANNEL_A")
	.dwattr $C$DW$455, DW_AT_const_value(0x00)
	.dwattr $C$DW$455, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$455, DW_AT_decl_line(0x53)
	.dwattr $C$DW$455, DW_AT_decl_column(0x05)

$C$DW$456	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$456, DW_AT_name("HRPWM_CHANNEL_B")
	.dwattr $C$DW$456, DW_AT_const_value(0x08)
	.dwattr $C$DW$456, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$456, DW_AT_decl_line(0x54)
	.dwattr $C$DW$456, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$70, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$70, DW_AT_decl_line(0x52)
	.dwattr $C$DW$T$70, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$70

	.dwendtag $C$DW$TU$70


$C$DW$TU$71	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$71
$C$DW$T$71	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$71, DW_AT_name("HRPWM_Channel")
	.dwattr $C$DW$T$71, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$T$71, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$71, DW_AT_decl_line(0x55)
	.dwattr $C$DW$T$71, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$71


$C$DW$TU$72	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$72

$C$DW$T$72	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$72, DW_AT_byte_size(0x01)
$C$DW$457	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$457, DW_AT_name("HRPWM_MEP_CTRL_DISABLE")
	.dwattr $C$DW$457, DW_AT_const_value(0x00)
	.dwattr $C$DW$457, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$457, DW_AT_decl_line(0x60)
	.dwattr $C$DW$457, DW_AT_decl_column(0x05)

$C$DW$458	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$458, DW_AT_name("HRPWM_MEP_CTRL_RISING_EDGE")
	.dwattr $C$DW$458, DW_AT_const_value(0x01)
	.dwattr $C$DW$458, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$458, DW_AT_decl_line(0x62)
	.dwattr $C$DW$458, DW_AT_decl_column(0x05)

$C$DW$459	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$459, DW_AT_name("HRPWM_MEP_CTRL_FALLING_EDGE")
	.dwattr $C$DW$459, DW_AT_const_value(0x02)
	.dwattr $C$DW$459, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$459, DW_AT_decl_line(0x64)
	.dwattr $C$DW$459, DW_AT_decl_column(0x05)

$C$DW$460	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$460, DW_AT_name("HRPWM_MEP_CTRL_RISING_AND_FALLING_EDGE")
	.dwattr $C$DW$460, DW_AT_const_value(0x03)
	.dwattr $C$DW$460, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$460, DW_AT_decl_line(0x66)
	.dwattr $C$DW$460, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$72, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$72, DW_AT_decl_line(0x5e)
	.dwattr $C$DW$T$72, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$72

	.dwendtag $C$DW$TU$72


$C$DW$TU$73	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$73
$C$DW$T$73	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$73, DW_AT_name("HRPWM_MEPEdgeMode")
	.dwattr $C$DW$T$73, DW_AT_type(*$C$DW$T$72)
	.dwattr $C$DW$T$73, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$73, DW_AT_decl_line(0x67)
	.dwattr $C$DW$T$73, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$73


$C$DW$TU$74	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$74

$C$DW$T$74	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$74, DW_AT_byte_size(0x01)
$C$DW$461	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$461, DW_AT_name("HRPWM_MEP_DUTY_PERIOD_CTRL")
	.dwattr $C$DW$461, DW_AT_const_value(0x00)
	.dwattr $C$DW$461, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$461, DW_AT_decl_line(0x72)
	.dwattr $C$DW$461, DW_AT_decl_column(0x05)

$C$DW$462	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$462, DW_AT_name("HRPWM_MEP_PHASE_CTRL")
	.dwattr $C$DW$462, DW_AT_const_value(0x01)
	.dwattr $C$DW$462, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$462, DW_AT_decl_line(0x74)
	.dwattr $C$DW$462, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$74, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$74, DW_AT_decl_line(0x70)
	.dwattr $C$DW$T$74, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$74

	.dwendtag $C$DW$TU$74


$C$DW$TU$75	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$75
$C$DW$T$75	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$75, DW_AT_name("HRPWM_MEPCtrlMode")
	.dwattr $C$DW$T$75, DW_AT_type(*$C$DW$T$74)
	.dwattr $C$DW$T$75, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$75, DW_AT_decl_line(0x75)
	.dwattr $C$DW$T$75, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$75


$C$DW$TU$76	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$76

$C$DW$T$76	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$76, DW_AT_byte_size(0x01)
$C$DW$463	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$463, DW_AT_name("HRPWM_LOAD_ON_CNTR_ZERO")
	.dwattr $C$DW$463, DW_AT_const_value(0x00)
	.dwattr $C$DW$463, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$463, DW_AT_decl_line(0x81)
	.dwattr $C$DW$463, DW_AT_decl_column(0x05)

$C$DW$464	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$464, DW_AT_name("HRPWM_LOAD_ON_CNTR_PERIOD")
	.dwattr $C$DW$464, DW_AT_const_value(0x01)
	.dwattr $C$DW$464, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$464, DW_AT_decl_line(0x83)
	.dwattr $C$DW$464, DW_AT_decl_column(0x05)

$C$DW$465	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$465, DW_AT_name("HRPWM_LOAD_ON_CNTR_ZERO_PERIOD")
	.dwattr $C$DW$465, DW_AT_const_value(0x02)
	.dwattr $C$DW$465, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$465, DW_AT_decl_line(0x85)
	.dwattr $C$DW$465, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$76, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$76, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$T$76, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$76

	.dwendtag $C$DW$TU$76


$C$DW$TU$77	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$77
$C$DW$T$77	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$77, DW_AT_name("HRPWM_LoadMode")
	.dwattr $C$DW$T$77, DW_AT_type(*$C$DW$T$76)
	.dwattr $C$DW$T$77, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$77, DW_AT_decl_line(0x86)
	.dwattr $C$DW$T$77, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$77


$C$DW$TU$78	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$78

$C$DW$T$78	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$78, DW_AT_byte_size(0x01)
$C$DW$466	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$466, DW_AT_name("HRPWM_COUNTER_COMPARE_A")
	.dwattr $C$DW$466, DW_AT_const_value(0x00)
	.dwattr $C$DW$466, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$466, DW_AT_decl_line(0xb3)
	.dwattr $C$DW$466, DW_AT_decl_column(0x05)

$C$DW$467	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$467, DW_AT_name("HRPWM_COUNTER_COMPARE_B")
	.dwattr $C$DW$467, DW_AT_const_value(0x04)
	.dwattr $C$DW$467, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$467, DW_AT_decl_line(0xb4)
	.dwattr $C$DW$467, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$78, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$78, DW_AT_decl_line(0xb2)
	.dwattr $C$DW$T$78, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$78

	.dwendtag $C$DW$TU$78


$C$DW$TU$79	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$79
$C$DW$T$79	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$79, DW_AT_name("HRPWM_CounterCompareModule")
	.dwattr $C$DW$T$79, DW_AT_type(*$C$DW$T$78)
	.dwattr $C$DW$T$79, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$79, DW_AT_decl_line(0xb5)
	.dwattr $C$DW$T$79, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$79


$C$DW$TU$80	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$80

$C$DW$T$80	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$80, DW_AT_byte_size(0x01)
$C$DW$468	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$468, DW_AT_name("I2C_FIFO_TXEMPTY")
	.dwattr $C$DW$468, DW_AT_const_value(0x00)
	.dwattr $C$DW$468, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$468, DW_AT_decl_line(0xa7)
	.dwattr $C$DW$468, DW_AT_decl_column(0x05)

$C$DW$469	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$469, DW_AT_name("I2C_FIFO_TX0")
	.dwattr $C$DW$469, DW_AT_const_value(0x00)
	.dwattr $C$DW$469, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$469, DW_AT_decl_line(0xa8)
	.dwattr $C$DW$469, DW_AT_decl_column(0x05)

$C$DW$470	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$470, DW_AT_name("I2C_FIFO_TX1")
	.dwattr $C$DW$470, DW_AT_const_value(0x01)
	.dwattr $C$DW$470, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$470, DW_AT_decl_line(0xa9)
	.dwattr $C$DW$470, DW_AT_decl_column(0x05)

$C$DW$471	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$471, DW_AT_name("I2C_FIFO_TX2")
	.dwattr $C$DW$471, DW_AT_const_value(0x02)
	.dwattr $C$DW$471, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$471, DW_AT_decl_line(0xaa)
	.dwattr $C$DW$471, DW_AT_decl_column(0x05)

$C$DW$472	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$472, DW_AT_name("I2C_FIFO_TX3")
	.dwattr $C$DW$472, DW_AT_const_value(0x03)
	.dwattr $C$DW$472, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$472, DW_AT_decl_line(0xab)
	.dwattr $C$DW$472, DW_AT_decl_column(0x05)

$C$DW$473	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$473, DW_AT_name("I2C_FIFO_TX4")
	.dwattr $C$DW$473, DW_AT_const_value(0x04)
	.dwattr $C$DW$473, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$473, DW_AT_decl_line(0xac)
	.dwattr $C$DW$473, DW_AT_decl_column(0x05)

$C$DW$474	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$474, DW_AT_name("I2C_FIFO_TX5")
	.dwattr $C$DW$474, DW_AT_const_value(0x05)
	.dwattr $C$DW$474, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$474, DW_AT_decl_line(0xad)
	.dwattr $C$DW$474, DW_AT_decl_column(0x05)

$C$DW$475	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$475, DW_AT_name("I2C_FIFO_TX6")
	.dwattr $C$DW$475, DW_AT_const_value(0x06)
	.dwattr $C$DW$475, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$475, DW_AT_decl_line(0xae)
	.dwattr $C$DW$475, DW_AT_decl_column(0x05)

$C$DW$476	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$476, DW_AT_name("I2C_FIFO_TX7")
	.dwattr $C$DW$476, DW_AT_const_value(0x07)
	.dwattr $C$DW$476, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$476, DW_AT_decl_line(0xaf)
	.dwattr $C$DW$476, DW_AT_decl_column(0x05)

$C$DW$477	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$477, DW_AT_name("I2C_FIFO_TX8")
	.dwattr $C$DW$477, DW_AT_const_value(0x08)
	.dwattr $C$DW$477, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$477, DW_AT_decl_line(0xb0)
	.dwattr $C$DW$477, DW_AT_decl_column(0x05)

$C$DW$478	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$478, DW_AT_name("I2C_FIFO_TX9")
	.dwattr $C$DW$478, DW_AT_const_value(0x09)
	.dwattr $C$DW$478, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$478, DW_AT_decl_line(0xb1)
	.dwattr $C$DW$478, DW_AT_decl_column(0x05)

$C$DW$479	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$479, DW_AT_name("I2C_FIFO_TX10")
	.dwattr $C$DW$479, DW_AT_const_value(0x0a)
	.dwattr $C$DW$479, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$479, DW_AT_decl_line(0xb2)
	.dwattr $C$DW$479, DW_AT_decl_column(0x05)

$C$DW$480	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$480, DW_AT_name("I2C_FIFO_TX11")
	.dwattr $C$DW$480, DW_AT_const_value(0x0b)
	.dwattr $C$DW$480, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$480, DW_AT_decl_line(0xb3)
	.dwattr $C$DW$480, DW_AT_decl_column(0x05)

$C$DW$481	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$481, DW_AT_name("I2C_FIFO_TX12")
	.dwattr $C$DW$481, DW_AT_const_value(0x0c)
	.dwattr $C$DW$481, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$481, DW_AT_decl_line(0xb4)
	.dwattr $C$DW$481, DW_AT_decl_column(0x05)

$C$DW$482	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$482, DW_AT_name("I2C_FIFO_TX13")
	.dwattr $C$DW$482, DW_AT_const_value(0x0d)
	.dwattr $C$DW$482, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$482, DW_AT_decl_line(0xb5)
	.dwattr $C$DW$482, DW_AT_decl_column(0x05)

$C$DW$483	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$483, DW_AT_name("I2C_FIFO_TX14")
	.dwattr $C$DW$483, DW_AT_const_value(0x0e)
	.dwattr $C$DW$483, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$483, DW_AT_decl_line(0xb6)
	.dwattr $C$DW$483, DW_AT_decl_column(0x05)

$C$DW$484	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$484, DW_AT_name("I2C_FIFO_TX15")
	.dwattr $C$DW$484, DW_AT_const_value(0x0f)
	.dwattr $C$DW$484, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$484, DW_AT_decl_line(0xb7)
	.dwattr $C$DW$484, DW_AT_decl_column(0x05)

$C$DW$485	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$485, DW_AT_name("I2C_FIFO_TX16")
	.dwattr $C$DW$485, DW_AT_const_value(0x10)
	.dwattr $C$DW$485, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$485, DW_AT_decl_line(0xb8)
	.dwattr $C$DW$485, DW_AT_decl_column(0x05)

$C$DW$486	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$486, DW_AT_name("I2C_FIFO_TXFULL")
	.dwattr $C$DW$486, DW_AT_const_value(0x10)
	.dwattr $C$DW$486, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$486, DW_AT_decl_line(0xb9)
	.dwattr $C$DW$486, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$80, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$T$80, DW_AT_decl_line(0xa6)
	.dwattr $C$DW$T$80, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$80

	.dwendtag $C$DW$TU$80


$C$DW$TU$81	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$81
$C$DW$T$81	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$81, DW_AT_name("I2C_TxFIFOLevel")
	.dwattr $C$DW$T$81, DW_AT_type(*$C$DW$T$80)
	.dwattr $C$DW$T$81, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$T$81, DW_AT_decl_line(0xba)
	.dwattr $C$DW$T$81, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$81


$C$DW$TU$82	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$82

$C$DW$T$82	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$82, DW_AT_byte_size(0x01)
$C$DW$487	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$487, DW_AT_name("I2C_FIFO_RXEMPTY")
	.dwattr $C$DW$487, DW_AT_const_value(0x00)
	.dwattr $C$DW$487, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$487, DW_AT_decl_line(0xc5)
	.dwattr $C$DW$487, DW_AT_decl_column(0x05)

$C$DW$488	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$488, DW_AT_name("I2C_FIFO_RX0")
	.dwattr $C$DW$488, DW_AT_const_value(0x00)
	.dwattr $C$DW$488, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$488, DW_AT_decl_line(0xc6)
	.dwattr $C$DW$488, DW_AT_decl_column(0x05)

$C$DW$489	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$489, DW_AT_name("I2C_FIFO_RX1")
	.dwattr $C$DW$489, DW_AT_const_value(0x01)
	.dwattr $C$DW$489, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$489, DW_AT_decl_line(0xc7)
	.dwattr $C$DW$489, DW_AT_decl_column(0x05)

$C$DW$490	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$490, DW_AT_name("I2C_FIFO_RX2")
	.dwattr $C$DW$490, DW_AT_const_value(0x02)
	.dwattr $C$DW$490, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$490, DW_AT_decl_line(0xc8)
	.dwattr $C$DW$490, DW_AT_decl_column(0x05)

$C$DW$491	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$491, DW_AT_name("I2C_FIFO_RX3")
	.dwattr $C$DW$491, DW_AT_const_value(0x03)
	.dwattr $C$DW$491, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$491, DW_AT_decl_line(0xc9)
	.dwattr $C$DW$491, DW_AT_decl_column(0x05)

$C$DW$492	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$492, DW_AT_name("I2C_FIFO_RX4")
	.dwattr $C$DW$492, DW_AT_const_value(0x04)
	.dwattr $C$DW$492, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$492, DW_AT_decl_line(0xca)
	.dwattr $C$DW$492, DW_AT_decl_column(0x05)

$C$DW$493	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$493, DW_AT_name("I2C_FIFO_RX5")
	.dwattr $C$DW$493, DW_AT_const_value(0x05)
	.dwattr $C$DW$493, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$493, DW_AT_decl_line(0xcb)
	.dwattr $C$DW$493, DW_AT_decl_column(0x05)

$C$DW$494	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$494, DW_AT_name("I2C_FIFO_RX6")
	.dwattr $C$DW$494, DW_AT_const_value(0x06)
	.dwattr $C$DW$494, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$494, DW_AT_decl_line(0xcc)
	.dwattr $C$DW$494, DW_AT_decl_column(0x05)

$C$DW$495	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$495, DW_AT_name("I2C_FIFO_RX7")
	.dwattr $C$DW$495, DW_AT_const_value(0x07)
	.dwattr $C$DW$495, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$495, DW_AT_decl_line(0xcd)
	.dwattr $C$DW$495, DW_AT_decl_column(0x05)

$C$DW$496	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$496, DW_AT_name("I2C_FIFO_RX8")
	.dwattr $C$DW$496, DW_AT_const_value(0x08)
	.dwattr $C$DW$496, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$496, DW_AT_decl_line(0xce)
	.dwattr $C$DW$496, DW_AT_decl_column(0x05)

$C$DW$497	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$497, DW_AT_name("I2C_FIFO_RX9")
	.dwattr $C$DW$497, DW_AT_const_value(0x09)
	.dwattr $C$DW$497, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$497, DW_AT_decl_line(0xcf)
	.dwattr $C$DW$497, DW_AT_decl_column(0x05)

$C$DW$498	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$498, DW_AT_name("I2C_FIFO_RX10")
	.dwattr $C$DW$498, DW_AT_const_value(0x0a)
	.dwattr $C$DW$498, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$498, DW_AT_decl_line(0xd0)
	.dwattr $C$DW$498, DW_AT_decl_column(0x05)

$C$DW$499	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$499, DW_AT_name("I2C_FIFO_RX11")
	.dwattr $C$DW$499, DW_AT_const_value(0x0b)
	.dwattr $C$DW$499, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$499, DW_AT_decl_line(0xd1)
	.dwattr $C$DW$499, DW_AT_decl_column(0x05)

$C$DW$500	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$500, DW_AT_name("I2C_FIFO_RX12")
	.dwattr $C$DW$500, DW_AT_const_value(0x0c)
	.dwattr $C$DW$500, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$500, DW_AT_decl_line(0xd2)
	.dwattr $C$DW$500, DW_AT_decl_column(0x05)

$C$DW$501	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$501, DW_AT_name("I2C_FIFO_RX13")
	.dwattr $C$DW$501, DW_AT_const_value(0x0d)
	.dwattr $C$DW$501, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$501, DW_AT_decl_line(0xd3)
	.dwattr $C$DW$501, DW_AT_decl_column(0x05)

$C$DW$502	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$502, DW_AT_name("I2C_FIFO_RX14")
	.dwattr $C$DW$502, DW_AT_const_value(0x0e)
	.dwattr $C$DW$502, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$502, DW_AT_decl_line(0xd4)
	.dwattr $C$DW$502, DW_AT_decl_column(0x05)

$C$DW$503	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$503, DW_AT_name("I2C_FIFO_RX15")
	.dwattr $C$DW$503, DW_AT_const_value(0x0f)
	.dwattr $C$DW$503, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$503, DW_AT_decl_line(0xd5)
	.dwattr $C$DW$503, DW_AT_decl_column(0x05)

$C$DW$504	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$504, DW_AT_name("I2C_FIFO_RX16")
	.dwattr $C$DW$504, DW_AT_const_value(0x10)
	.dwattr $C$DW$504, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$504, DW_AT_decl_line(0xd6)
	.dwattr $C$DW$504, DW_AT_decl_column(0x05)

$C$DW$505	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$505, DW_AT_name("I2C_FIFO_RXFULL")
	.dwattr $C$DW$505, DW_AT_const_value(0x10)
	.dwattr $C$DW$505, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$505, DW_AT_decl_line(0xd7)
	.dwattr $C$DW$505, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$82, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$T$82, DW_AT_decl_line(0xc4)
	.dwattr $C$DW$T$82, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$82

	.dwendtag $C$DW$TU$82


$C$DW$TU$83	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$83
$C$DW$T$83	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$83, DW_AT_name("I2C_RxFIFOLevel")
	.dwattr $C$DW$T$83, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$T$83, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$T$83, DW_AT_decl_line(0xd8)
	.dwattr $C$DW$T$83, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$83


$C$DW$TU$84	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$84

$C$DW$T$84	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$84, DW_AT_byte_size(0x01)
$C$DW$506	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$506, DW_AT_name("I2C_BITCOUNT_1")
	.dwattr $C$DW$506, DW_AT_const_value(0x01)
	.dwattr $C$DW$506, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$506, DW_AT_decl_line(0xe1)
	.dwattr $C$DW$506, DW_AT_decl_column(0x05)

$C$DW$507	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$507, DW_AT_name("I2C_BITCOUNT_2")
	.dwattr $C$DW$507, DW_AT_const_value(0x02)
	.dwattr $C$DW$507, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$507, DW_AT_decl_line(0xe2)
	.dwattr $C$DW$507, DW_AT_decl_column(0x05)

$C$DW$508	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$508, DW_AT_name("I2C_BITCOUNT_3")
	.dwattr $C$DW$508, DW_AT_const_value(0x03)
	.dwattr $C$DW$508, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$508, DW_AT_decl_line(0xe3)
	.dwattr $C$DW$508, DW_AT_decl_column(0x05)

$C$DW$509	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$509, DW_AT_name("I2C_BITCOUNT_4")
	.dwattr $C$DW$509, DW_AT_const_value(0x04)
	.dwattr $C$DW$509, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$509, DW_AT_decl_line(0xe4)
	.dwattr $C$DW$509, DW_AT_decl_column(0x05)

$C$DW$510	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$510, DW_AT_name("I2C_BITCOUNT_5")
	.dwattr $C$DW$510, DW_AT_const_value(0x05)
	.dwattr $C$DW$510, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$510, DW_AT_decl_line(0xe5)
	.dwattr $C$DW$510, DW_AT_decl_column(0x05)

$C$DW$511	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$511, DW_AT_name("I2C_BITCOUNT_6")
	.dwattr $C$DW$511, DW_AT_const_value(0x06)
	.dwattr $C$DW$511, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$511, DW_AT_decl_line(0xe6)
	.dwattr $C$DW$511, DW_AT_decl_column(0x05)

$C$DW$512	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$512, DW_AT_name("I2C_BITCOUNT_7")
	.dwattr $C$DW$512, DW_AT_const_value(0x07)
	.dwattr $C$DW$512, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$512, DW_AT_decl_line(0xe7)
	.dwattr $C$DW$512, DW_AT_decl_column(0x05)

$C$DW$513	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$513, DW_AT_name("I2C_BITCOUNT_8")
	.dwattr $C$DW$513, DW_AT_const_value(0x00)
	.dwattr $C$DW$513, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$513, DW_AT_decl_line(0xe8)
	.dwattr $C$DW$513, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$84, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$T$84, DW_AT_decl_line(0xe0)
	.dwattr $C$DW$T$84, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$84

	.dwendtag $C$DW$TU$84


$C$DW$TU$85	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$85
$C$DW$T$85	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$85, DW_AT_name("I2C_BitCount")
	.dwattr $C$DW$T$85, DW_AT_type(*$C$DW$T$84)
	.dwattr $C$DW$T$85, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$T$85, DW_AT_decl_line(0xe9)
	.dwattr $C$DW$T$85, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$85


$C$DW$TU$86	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$86

$C$DW$T$86	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$86, DW_AT_byte_size(0x01)
$C$DW$514	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$514, DW_AT_name("I2C_ADDR_MODE_7BITS")
	.dwattr $C$DW$514, DW_AT_const_value(0x00)
	.dwattr $C$DW$514, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$514, DW_AT_decl_line(0xf2)
	.dwattr $C$DW$514, DW_AT_decl_column(0x05)

$C$DW$515	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$515, DW_AT_name("I2C_ADDR_MODE_10BITS")
	.dwattr $C$DW$515, DW_AT_const_value(0x100)
	.dwattr $C$DW$515, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$515, DW_AT_decl_line(0xf3)
	.dwattr $C$DW$515, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$86, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$T$86, DW_AT_decl_line(0xf1)
	.dwattr $C$DW$T$86, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$86

	.dwendtag $C$DW$TU$86


$C$DW$TU$87	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$87
$C$DW$T$87	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$87, DW_AT_name("I2C_AddressMode")
	.dwattr $C$DW$T$87, DW_AT_type(*$C$DW$T$86)
	.dwattr $C$DW$T$87, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$T$87, DW_AT_decl_line(0xf4)
	.dwattr $C$DW$T$87, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$87


$C$DW$TU$88	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$88

$C$DW$T$88	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$88, DW_AT_byte_size(0x01)
$C$DW$516	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$516, DW_AT_name("I2C_EMULATION_STOP_SCL_LOW")
	.dwattr $C$DW$516, DW_AT_const_value(0x00)
	.dwattr $C$DW$516, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$516, DW_AT_decl_line(0xff)
	.dwattr $C$DW$516, DW_AT_decl_column(0x05)

$C$DW$517	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$517, DW_AT_name("I2C_EMULATION_FREE_RUN")
	.dwattr $C$DW$517, DW_AT_const_value(0x4000)
	.dwattr $C$DW$517, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$517, DW_AT_decl_line(0x101)
	.dwattr $C$DW$517, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$88, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$T$88, DW_AT_decl_line(0xfd)
	.dwattr $C$DW$T$88, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$88

	.dwendtag $C$DW$TU$88


$C$DW$TU$89	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$89
$C$DW$T$89	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$89, DW_AT_name("I2C_EmulationMode")
	.dwattr $C$DW$T$89, DW_AT_type(*$C$DW$T$88)
	.dwattr $C$DW$T$89, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$T$89, DW_AT_decl_line(0x102)
	.dwattr $C$DW$T$89, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$89


$C$DW$TU$90	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$90

$C$DW$T$90	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$90, DW_AT_byte_size(0x01)
$C$DW$518	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$518, DW_AT_name("I2C_DUTYCYCLE_33")
	.dwattr $C$DW$518, DW_AT_const_value(0x00)
	.dwattr $C$DW$518, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$518, DW_AT_decl_line(0x10c)
	.dwattr $C$DW$518, DW_AT_decl_column(0x05)

$C$DW$519	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$519, DW_AT_name("I2C_DUTYCYCLE_50")
	.dwattr $C$DW$519, DW_AT_const_value(0x01)
	.dwattr $C$DW$519, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$519, DW_AT_decl_line(0x10d)
	.dwattr $C$DW$519, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$90, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$T$90, DW_AT_decl_line(0x10b)
	.dwattr $C$DW$T$90, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$90

	.dwendtag $C$DW$TU$90


$C$DW$TU$91	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$91
$C$DW$T$91	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$91, DW_AT_name("I2C_DutyCycle")
	.dwattr $C$DW$T$91, DW_AT_type(*$C$DW$T$90)
	.dwattr $C$DW$T$91, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$T$91, DW_AT_decl_line(0x10e)
	.dwattr $C$DW$T$91, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$91


$C$DW$TU$92	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$92

$C$DW$T$92	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$92, DW_AT_byte_size(0x01)
$C$DW$520	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$520, DW_AT_name("SPI_FIFO_TXEMPTY")
	.dwattr $C$DW$520, DW_AT_const_value(0x00)
	.dwattr $C$DW$520, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$520, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$520, DW_AT_decl_column(0x05)

$C$DW$521	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$521, DW_AT_name("SPI_FIFO_TX0")
	.dwattr $C$DW$521, DW_AT_const_value(0x00)
	.dwattr $C$DW$521, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$521, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$521, DW_AT_decl_column(0x05)

$C$DW$522	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$522, DW_AT_name("SPI_FIFO_TX1")
	.dwattr $C$DW$522, DW_AT_const_value(0x01)
	.dwattr $C$DW$522, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$522, DW_AT_decl_line(0x80)
	.dwattr $C$DW$522, DW_AT_decl_column(0x05)

$C$DW$523	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$523, DW_AT_name("SPI_FIFO_TX2")
	.dwattr $C$DW$523, DW_AT_const_value(0x02)
	.dwattr $C$DW$523, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$523, DW_AT_decl_line(0x81)
	.dwattr $C$DW$523, DW_AT_decl_column(0x05)

$C$DW$524	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$524, DW_AT_name("SPI_FIFO_TX3")
	.dwattr $C$DW$524, DW_AT_const_value(0x03)
	.dwattr $C$DW$524, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$524, DW_AT_decl_line(0x82)
	.dwattr $C$DW$524, DW_AT_decl_column(0x05)

$C$DW$525	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$525, DW_AT_name("SPI_FIFO_TX4")
	.dwattr $C$DW$525, DW_AT_const_value(0x04)
	.dwattr $C$DW$525, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$525, DW_AT_decl_line(0x83)
	.dwattr $C$DW$525, DW_AT_decl_column(0x05)

$C$DW$526	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$526, DW_AT_name("SPI_FIFO_TX5")
	.dwattr $C$DW$526, DW_AT_const_value(0x05)
	.dwattr $C$DW$526, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$526, DW_AT_decl_line(0x84)
	.dwattr $C$DW$526, DW_AT_decl_column(0x05)

$C$DW$527	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$527, DW_AT_name("SPI_FIFO_TX6")
	.dwattr $C$DW$527, DW_AT_const_value(0x06)
	.dwattr $C$DW$527, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$527, DW_AT_decl_line(0x85)
	.dwattr $C$DW$527, DW_AT_decl_column(0x05)

$C$DW$528	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$528, DW_AT_name("SPI_FIFO_TX7")
	.dwattr $C$DW$528, DW_AT_const_value(0x07)
	.dwattr $C$DW$528, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$528, DW_AT_decl_line(0x86)
	.dwattr $C$DW$528, DW_AT_decl_column(0x05)

$C$DW$529	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$529, DW_AT_name("SPI_FIFO_TX8")
	.dwattr $C$DW$529, DW_AT_const_value(0x08)
	.dwattr $C$DW$529, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$529, DW_AT_decl_line(0x87)
	.dwattr $C$DW$529, DW_AT_decl_column(0x05)

$C$DW$530	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$530, DW_AT_name("SPI_FIFO_TX9")
	.dwattr $C$DW$530, DW_AT_const_value(0x09)
	.dwattr $C$DW$530, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$530, DW_AT_decl_line(0x88)
	.dwattr $C$DW$530, DW_AT_decl_column(0x05)

$C$DW$531	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$531, DW_AT_name("SPI_FIFO_TX10")
	.dwattr $C$DW$531, DW_AT_const_value(0x0a)
	.dwattr $C$DW$531, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$531, DW_AT_decl_line(0x89)
	.dwattr $C$DW$531, DW_AT_decl_column(0x05)

$C$DW$532	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$532, DW_AT_name("SPI_FIFO_TX11")
	.dwattr $C$DW$532, DW_AT_const_value(0x0b)
	.dwattr $C$DW$532, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$532, DW_AT_decl_line(0x8a)
	.dwattr $C$DW$532, DW_AT_decl_column(0x05)

$C$DW$533	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$533, DW_AT_name("SPI_FIFO_TX12")
	.dwattr $C$DW$533, DW_AT_const_value(0x0c)
	.dwattr $C$DW$533, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$533, DW_AT_decl_line(0x8b)
	.dwattr $C$DW$533, DW_AT_decl_column(0x05)

$C$DW$534	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$534, DW_AT_name("SPI_FIFO_TX13")
	.dwattr $C$DW$534, DW_AT_const_value(0x0d)
	.dwattr $C$DW$534, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$534, DW_AT_decl_line(0x8c)
	.dwattr $C$DW$534, DW_AT_decl_column(0x05)

$C$DW$535	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$535, DW_AT_name("SPI_FIFO_TX14")
	.dwattr $C$DW$535, DW_AT_const_value(0x0e)
	.dwattr $C$DW$535, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$535, DW_AT_decl_line(0x8d)
	.dwattr $C$DW$535, DW_AT_decl_column(0x05)

$C$DW$536	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$536, DW_AT_name("SPI_FIFO_TX15")
	.dwattr $C$DW$536, DW_AT_const_value(0x0f)
	.dwattr $C$DW$536, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$536, DW_AT_decl_line(0x8e)
	.dwattr $C$DW$536, DW_AT_decl_column(0x05)

$C$DW$537	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$537, DW_AT_name("SPI_FIFO_TX16")
	.dwattr $C$DW$537, DW_AT_const_value(0x10)
	.dwattr $C$DW$537, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$537, DW_AT_decl_line(0x8f)
	.dwattr $C$DW$537, DW_AT_decl_column(0x05)

$C$DW$538	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$538, DW_AT_name("SPI_FIFO_TXFULL")
	.dwattr $C$DW$538, DW_AT_const_value(0x10)
	.dwattr $C$DW$538, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$538, DW_AT_decl_line(0x90)
	.dwattr $C$DW$538, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$92, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$92, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$T$92, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$92

	.dwendtag $C$DW$TU$92


$C$DW$TU$93	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$93
$C$DW$T$93	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$93, DW_AT_name("SPI_TxFIFOLevel")
	.dwattr $C$DW$T$93, DW_AT_type(*$C$DW$T$92)
	.dwattr $C$DW$T$93, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$93, DW_AT_decl_line(0x91)
	.dwattr $C$DW$T$93, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$93


$C$DW$TU$97	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$97

$C$DW$T$97	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$97, DW_AT_byte_size(0x01)
$C$DW$539	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$539, DW_AT_name("SPI_FIFO_RXEMPTY")
	.dwattr $C$DW$539, DW_AT_const_value(0x00)
	.dwattr $C$DW$539, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$539, DW_AT_decl_line(0x9c)
	.dwattr $C$DW$539, DW_AT_decl_column(0x05)

$C$DW$540	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$540, DW_AT_name("SPI_FIFO_RX0")
	.dwattr $C$DW$540, DW_AT_const_value(0x00)
	.dwattr $C$DW$540, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$540, DW_AT_decl_line(0x9d)
	.dwattr $C$DW$540, DW_AT_decl_column(0x05)

$C$DW$541	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$541, DW_AT_name("SPI_FIFO_RX1")
	.dwattr $C$DW$541, DW_AT_const_value(0x01)
	.dwattr $C$DW$541, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$541, DW_AT_decl_line(0x9e)
	.dwattr $C$DW$541, DW_AT_decl_column(0x05)

$C$DW$542	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$542, DW_AT_name("SPI_FIFO_RX2")
	.dwattr $C$DW$542, DW_AT_const_value(0x02)
	.dwattr $C$DW$542, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$542, DW_AT_decl_line(0x9f)
	.dwattr $C$DW$542, DW_AT_decl_column(0x05)

$C$DW$543	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$543, DW_AT_name("SPI_FIFO_RX3")
	.dwattr $C$DW$543, DW_AT_const_value(0x03)
	.dwattr $C$DW$543, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$543, DW_AT_decl_line(0xa0)
	.dwattr $C$DW$543, DW_AT_decl_column(0x05)

$C$DW$544	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$544, DW_AT_name("SPI_FIFO_RX4")
	.dwattr $C$DW$544, DW_AT_const_value(0x04)
	.dwattr $C$DW$544, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$544, DW_AT_decl_line(0xa1)
	.dwattr $C$DW$544, DW_AT_decl_column(0x05)

$C$DW$545	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$545, DW_AT_name("SPI_FIFO_RX5")
	.dwattr $C$DW$545, DW_AT_const_value(0x05)
	.dwattr $C$DW$545, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$545, DW_AT_decl_line(0xa2)
	.dwattr $C$DW$545, DW_AT_decl_column(0x05)

$C$DW$546	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$546, DW_AT_name("SPI_FIFO_RX6")
	.dwattr $C$DW$546, DW_AT_const_value(0x06)
	.dwattr $C$DW$546, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$546, DW_AT_decl_line(0xa3)
	.dwattr $C$DW$546, DW_AT_decl_column(0x05)

$C$DW$547	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$547, DW_AT_name("SPI_FIFO_RX7")
	.dwattr $C$DW$547, DW_AT_const_value(0x07)
	.dwattr $C$DW$547, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$547, DW_AT_decl_line(0xa4)
	.dwattr $C$DW$547, DW_AT_decl_column(0x05)

$C$DW$548	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$548, DW_AT_name("SPI_FIFO_RX8")
	.dwattr $C$DW$548, DW_AT_const_value(0x08)
	.dwattr $C$DW$548, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$548, DW_AT_decl_line(0xa5)
	.dwattr $C$DW$548, DW_AT_decl_column(0x05)

$C$DW$549	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$549, DW_AT_name("SPI_FIFO_RX9")
	.dwattr $C$DW$549, DW_AT_const_value(0x09)
	.dwattr $C$DW$549, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$549, DW_AT_decl_line(0xa6)
	.dwattr $C$DW$549, DW_AT_decl_column(0x05)

$C$DW$550	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$550, DW_AT_name("SPI_FIFO_RX10")
	.dwattr $C$DW$550, DW_AT_const_value(0x0a)
	.dwattr $C$DW$550, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$550, DW_AT_decl_line(0xa7)
	.dwattr $C$DW$550, DW_AT_decl_column(0x05)

$C$DW$551	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$551, DW_AT_name("SPI_FIFO_RX11")
	.dwattr $C$DW$551, DW_AT_const_value(0x0b)
	.dwattr $C$DW$551, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$551, DW_AT_decl_line(0xa8)
	.dwattr $C$DW$551, DW_AT_decl_column(0x05)

$C$DW$552	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$552, DW_AT_name("SPI_FIFO_RX12")
	.dwattr $C$DW$552, DW_AT_const_value(0x0c)
	.dwattr $C$DW$552, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$552, DW_AT_decl_line(0xa9)
	.dwattr $C$DW$552, DW_AT_decl_column(0x05)

$C$DW$553	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$553, DW_AT_name("SPI_FIFO_RX13")
	.dwattr $C$DW$553, DW_AT_const_value(0x0d)
	.dwattr $C$DW$553, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$553, DW_AT_decl_line(0xaa)
	.dwattr $C$DW$553, DW_AT_decl_column(0x05)

$C$DW$554	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$554, DW_AT_name("SPI_FIFO_RX14")
	.dwattr $C$DW$554, DW_AT_const_value(0x0e)
	.dwattr $C$DW$554, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$554, DW_AT_decl_line(0xab)
	.dwattr $C$DW$554, DW_AT_decl_column(0x05)

$C$DW$555	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$555, DW_AT_name("SPI_FIFO_RX15")
	.dwattr $C$DW$555, DW_AT_const_value(0x0f)
	.dwattr $C$DW$555, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$555, DW_AT_decl_line(0xac)
	.dwattr $C$DW$555, DW_AT_decl_column(0x05)

$C$DW$556	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$556, DW_AT_name("SPI_FIFO_RX16")
	.dwattr $C$DW$556, DW_AT_const_value(0x10)
	.dwattr $C$DW$556, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$556, DW_AT_decl_line(0xad)
	.dwattr $C$DW$556, DW_AT_decl_column(0x05)

$C$DW$557	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$557, DW_AT_name("SPI_FIFO_RXFULL")
	.dwattr $C$DW$557, DW_AT_const_value(0x10)
	.dwattr $C$DW$557, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$557, DW_AT_decl_line(0xae)
	.dwattr $C$DW$557, DW_AT_decl_column(0x05)

$C$DW$558	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$558, DW_AT_name("SPI_FIFO_RXDEFAULT")
	.dwattr $C$DW$558, DW_AT_const_value(0x1f)
	.dwattr $C$DW$558, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$558, DW_AT_decl_line(0xaf)
	.dwattr $C$DW$558, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$97, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$97, DW_AT_decl_line(0x9b)
	.dwattr $C$DW$T$97, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$97

	.dwendtag $C$DW$TU$97


$C$DW$TU$98	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$98
$C$DW$T$98	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$98, DW_AT_name("SPI_RxFIFOLevel")
	.dwattr $C$DW$T$98, DW_AT_type(*$C$DW$T$97)
	.dwattr $C$DW$T$98, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$98, DW_AT_decl_line(0xb0)
	.dwattr $C$DW$T$98, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$98


$C$DW$TU$100	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$100

$C$DW$T$100	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$100, DW_AT_byte_size(0x01)
$C$DW$559	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$559, DW_AT_name("SPI_EMULATION_STOP_MIDWAY")
	.dwattr $C$DW$559, DW_AT_const_value(0x00)
	.dwattr $C$DW$559, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$559, DW_AT_decl_line(0xbb)
	.dwattr $C$DW$559, DW_AT_decl_column(0x05)

$C$DW$560	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$560, DW_AT_name("SPI_EMULATION_FREE_RUN")
	.dwattr $C$DW$560, DW_AT_const_value(0x10)
	.dwattr $C$DW$560, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$560, DW_AT_decl_line(0xbd)
	.dwattr $C$DW$560, DW_AT_decl_column(0x05)

$C$DW$561	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$561, DW_AT_name("SPI_EMULATION_STOP_AFTER_TRANSMIT")
	.dwattr $C$DW$561, DW_AT_const_value(0x20)
	.dwattr $C$DW$561, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$561, DW_AT_decl_line(0xbf)
	.dwattr $C$DW$561, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$100, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$100, DW_AT_decl_line(0xb9)
	.dwattr $C$DW$T$100, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$100

	.dwendtag $C$DW$TU$100


$C$DW$TU$101	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$101
$C$DW$T$101	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$101, DW_AT_name("SPI_EmulationMode")
	.dwattr $C$DW$T$101, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$T$101, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$101, DW_AT_decl_line(0xc0)
	.dwattr $C$DW$T$101, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$101


$C$DW$TU$102	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$102

$C$DW$T$102	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$102, DW_AT_byte_size(0x01)
$C$DW$562	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$562, DW_AT_name("SPI_PROT_POL0PHA0")
	.dwattr $C$DW$562, DW_AT_const_value(0x00)
	.dwattr $C$DW$562, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$562, DW_AT_decl_line(0x5f)
	.dwattr $C$DW$562, DW_AT_decl_column(0x05)

$C$DW$563	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$563, DW_AT_name("SPI_PROT_POL0PHA1")
	.dwattr $C$DW$563, DW_AT_const_value(0x02)
	.dwattr $C$DW$563, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$563, DW_AT_decl_line(0x61)
	.dwattr $C$DW$563, DW_AT_decl_column(0x05)

$C$DW$564	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$564, DW_AT_name("SPI_PROT_POL1PHA0")
	.dwattr $C$DW$564, DW_AT_const_value(0x01)
	.dwattr $C$DW$564, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$564, DW_AT_decl_line(0x63)
	.dwattr $C$DW$564, DW_AT_decl_column(0x05)

$C$DW$565	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$565, DW_AT_name("SPI_PROT_POL1PHA1")
	.dwattr $C$DW$565, DW_AT_const_value(0x03)
	.dwattr $C$DW$565, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$565, DW_AT_decl_line(0x65)
	.dwattr $C$DW$565, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$102, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$102, DW_AT_decl_line(0x5d)
	.dwattr $C$DW$T$102, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$102

	.dwendtag $C$DW$TU$102


$C$DW$TU$103	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$103
$C$DW$T$103	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$103, DW_AT_name("SPI_TransferProtocol")
	.dwattr $C$DW$T$103, DW_AT_type(*$C$DW$T$102)
	.dwattr $C$DW$T$103, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$103, DW_AT_decl_line(0x66)
	.dwattr $C$DW$T$103, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$103


$C$DW$TU$104	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$104

$C$DW$T$104	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$104, DW_AT_byte_size(0x01)
$C$DW$566	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$566, DW_AT_name("SPI_MODE_SLAVE")
	.dwattr $C$DW$566, DW_AT_const_value(0x02)
	.dwattr $C$DW$566, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$566, DW_AT_decl_line(0x6f)
	.dwattr $C$DW$566, DW_AT_decl_column(0x05)

$C$DW$567	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$567, DW_AT_name("SPI_MODE_MASTER")
	.dwattr $C$DW$567, DW_AT_const_value(0x06)
	.dwattr $C$DW$567, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$567, DW_AT_decl_line(0x70)
	.dwattr $C$DW$567, DW_AT_decl_column(0x05)

$C$DW$568	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$568, DW_AT_name("SPI_MODE_SLAVE_OD")
	.dwattr $C$DW$568, DW_AT_const_value(0x00)
	.dwattr $C$DW$568, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$568, DW_AT_decl_line(0x71)
	.dwattr $C$DW$568, DW_AT_decl_column(0x05)

$C$DW$569	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$569, DW_AT_name("SPI_MODE_MASTER_OD")
	.dwattr $C$DW$569, DW_AT_const_value(0x04)
	.dwattr $C$DW$569, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$569, DW_AT_decl_line(0x72)
	.dwattr $C$DW$569, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$104, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$104, DW_AT_decl_line(0x6e)
	.dwattr $C$DW$T$104, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$104

	.dwendtag $C$DW$TU$104


$C$DW$TU$105	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$105
$C$DW$T$105	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$105, DW_AT_name("SPI_Mode")
	.dwattr $C$DW$T$105, DW_AT_type(*$C$DW$T$104)
	.dwattr $C$DW$T$105, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$105, DW_AT_decl_line(0x73)
	.dwattr $C$DW$T$105, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$105


$C$DW$TU$25	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$25

$C$DW$T$25	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$25, DW_AT_byte_size(0x12)
$C$DW$570	.dwtag  DW_TAG_member
	.dwattr $C$DW$570, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$570, DW_AT_name("response")
	.dwattr $C$DW$570, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$570, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$570, DW_AT_decl_line(0x35)
	.dwattr $C$DW$570, DW_AT_decl_column(0x17)

$C$DW$571	.dwtag  DW_TAG_member
	.dwattr $C$DW$571, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$571, DW_AT_name("crc")
	.dwattr $C$DW$571, DW_AT_data_member_location[DW_OP_plus_uconst 0x1]
	.dwattr $C$DW$571, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$571, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$571, DW_AT_decl_line(0x36)
	.dwattr $C$DW$571, DW_AT_decl_column(0x17)

$C$DW$572	.dwtag  DW_TAG_member
	.dwattr $C$DW$572, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$572, DW_AT_name("channel0")
	.dwattr $C$DW$572, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$572, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$572, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$572, DW_AT_decl_line(0x37)
	.dwattr $C$DW$572, DW_AT_decl_column(0x16)

$C$DW$573	.dwtag  DW_TAG_member
	.dwattr $C$DW$573, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$573, DW_AT_name("channel1")
	.dwattr $C$DW$573, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$573, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$573, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$573, DW_AT_decl_line(0x38)
	.dwattr $C$DW$573, DW_AT_decl_column(0x16)

$C$DW$574	.dwtag  DW_TAG_member
	.dwattr $C$DW$574, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$574, DW_AT_name("channel2")
	.dwattr $C$DW$574, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$574, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$574, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$574, DW_AT_decl_line(0x39)
	.dwattr $C$DW$574, DW_AT_decl_column(0x16)

$C$DW$575	.dwtag  DW_TAG_member
	.dwattr $C$DW$575, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$575, DW_AT_name("channel3")
	.dwattr $C$DW$575, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$575, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$575, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$575, DW_AT_decl_line(0x3a)
	.dwattr $C$DW$575, DW_AT_decl_column(0x16)

$C$DW$576	.dwtag  DW_TAG_member
	.dwattr $C$DW$576, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$576, DW_AT_name("channel4")
	.dwattr $C$DW$576, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$576, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$576, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$576, DW_AT_decl_line(0x3b)
	.dwattr $C$DW$576, DW_AT_decl_column(0x16)

$C$DW$577	.dwtag  DW_TAG_member
	.dwattr $C$DW$577, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$577, DW_AT_name("channel5")
	.dwattr $C$DW$577, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$577, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$577, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$577, DW_AT_decl_line(0x3c)
	.dwattr $C$DW$577, DW_AT_decl_column(0x16)

$C$DW$578	.dwtag  DW_TAG_member
	.dwattr $C$DW$578, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$578, DW_AT_name("channel6")
	.dwattr $C$DW$578, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$578, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$578, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$578, DW_AT_decl_line(0x3d)
	.dwattr $C$DW$578, DW_AT_decl_column(0x16)

$C$DW$579	.dwtag  DW_TAG_member
	.dwattr $C$DW$579, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$579, DW_AT_name("channel7")
	.dwattr $C$DW$579, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$579, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$579, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$579, DW_AT_decl_line(0x3e)
	.dwattr $C$DW$579, DW_AT_decl_column(0x16)

	.dwattr $C$DW$T$25, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$T$25, DW_AT_decl_line(0x34)
	.dwattr $C$DW$T$25, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$25

	.dwendtag $C$DW$TU$25


$C$DW$TU$106	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$106
$C$DW$T$106	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$106, DW_AT_name("adc_data")
	.dwattr $C$DW$T$106, DW_AT_type(*$C$DW$T$25)
	.dwattr $C$DW$T$106, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$T$106, DW_AT_decl_line(0x3f)
	.dwattr $C$DW$T$106, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$106


$C$DW$TU$2	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$2
$C$DW$T$2	.dwtag  DW_TAG_unspecified_type
	.dwattr $C$DW$T$2, DW_AT_name("void")

	.dwendtag $C$DW$TU$2


$C$DW$TU$4	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$4
$C$DW$T$4	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$4, DW_AT_encoding(DW_ATE_boolean)
	.dwattr $C$DW$T$4, DW_AT_name("bool")
	.dwattr $C$DW$T$4, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$4


$C$DW$TU$5	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$5
$C$DW$T$5	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$5, DW_AT_encoding(DW_ATE_signed_char)
	.dwattr $C$DW$T$5, DW_AT_name("signed char")
	.dwattr $C$DW$T$5, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$5


$C$DW$TU$6	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$6
$C$DW$T$6	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$6, DW_AT_encoding(DW_ATE_unsigned_char)
	.dwattr $C$DW$T$6, DW_AT_name("unsigned char")
	.dwattr $C$DW$T$6, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$6


$C$DW$TU$7	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$7
$C$DW$T$7	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$7, DW_AT_encoding(DW_ATE_signed_char)
	.dwattr $C$DW$T$7, DW_AT_name("wchar_t")
	.dwattr $C$DW$T$7, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$7


$C$DW$TU$8	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$8
$C$DW$T$8	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$8, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$8, DW_AT_name("short")
	.dwattr $C$DW$T$8, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$8


$C$DW$TU$9	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$9
$C$DW$T$9	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$9, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$9, DW_AT_name("unsigned short")
	.dwattr $C$DW$T$9, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$9


$C$DW$TU$10	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$10
$C$DW$T$10	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$10, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$10, DW_AT_name("int")
	.dwattr $C$DW$T$10, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$10


$C$DW$TU$11	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$11
$C$DW$T$11	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$11, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$11, DW_AT_name("unsigned int")
	.dwattr $C$DW$T$11, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$11


$C$DW$TU$19	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$19
$C$DW$T$19	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$19, DW_AT_name("__uint16_t")
	.dwattr $C$DW$T$19, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$T$19, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$19, DW_AT_decl_line(0x41)
	.dwattr $C$DW$T$19, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$19


$C$DW$TU$20	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$20
$C$DW$T$20	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$20, DW_AT_name("uint16_t")
	.dwattr $C$DW$T$20, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$T$20, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$20, DW_AT_decl_line(0x41)
	.dwattr $C$DW$T$20, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$20


$C$DW$TU$21	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$21
$C$DW$580	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$580, DW_AT_type(*$C$DW$T$20)

$C$DW$T$21	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$21, DW_AT_type(*$C$DW$580)

	.dwendtag $C$DW$TU$21


$C$DW$TU$12	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$12
$C$DW$T$12	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$12, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$12, DW_AT_name("long")
	.dwattr $C$DW$T$12, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$12


$C$DW$TU$22	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$22
$C$DW$T$22	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$22, DW_AT_name("__int32_t")
	.dwattr $C$DW$T$22, DW_AT_type(*$C$DW$T$12)
	.dwattr $C$DW$T$22, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$22, DW_AT_decl_line(0x42)
	.dwattr $C$DW$T$22, DW_AT_decl_column(0x1d)

	.dwendtag $C$DW$TU$22


$C$DW$TU$23	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$23
$C$DW$T$23	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$23, DW_AT_name("int32_t")
	.dwattr $C$DW$T$23, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$T$23, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$23, DW_AT_decl_line(0x30)
	.dwattr $C$DW$T$23, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$23


$C$DW$TU$24	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$24
$C$DW$581	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$581, DW_AT_type(*$C$DW$T$23)

$C$DW$T$24	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$24, DW_AT_type(*$C$DW$581)

	.dwendtag $C$DW$TU$24


$C$DW$TU$13	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$13
$C$DW$T$13	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$13, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$13, DW_AT_name("unsigned long")
	.dwattr $C$DW$T$13, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$13


$C$DW$TU$94	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$94
$C$DW$T$94	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$94, DW_AT_name("__uint32_t")
	.dwattr $C$DW$T$94, DW_AT_type(*$C$DW$T$13)
	.dwattr $C$DW$T$94, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$94, DW_AT_decl_line(0x43)
	.dwattr $C$DW$T$94, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$94


$C$DW$TU$168	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$168
$C$DW$T$168	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$168, DW_AT_name("__uintptr_t")
	.dwattr $C$DW$T$168, DW_AT_type(*$C$DW$T$94)
	.dwattr $C$DW$T$168, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$168, DW_AT_decl_line(0x78)
	.dwattr $C$DW$T$168, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$168


$C$DW$TU$169	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$169
$C$DW$T$169	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$169, DW_AT_name("uintptr_t")
	.dwattr $C$DW$T$169, DW_AT_type(*$C$DW$T$168)
	.dwattr $C$DW$T$169, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$169, DW_AT_decl_line(0x54)
	.dwattr $C$DW$T$169, DW_AT_decl_column(0x16)

	.dwendtag $C$DW$TU$169


$C$DW$TU$95	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$95
$C$DW$T$95	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$95, DW_AT_name("uint32_t")
	.dwattr $C$DW$T$95, DW_AT_type(*$C$DW$T$94)
	.dwattr $C$DW$T$95, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$95, DW_AT_decl_line(0x46)
	.dwattr $C$DW$T$95, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$95


$C$DW$TU$156	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$156
$C$DW$582	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$582, DW_AT_type(*$C$DW$T$95)

$C$DW$T$156	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$156, DW_AT_type(*$C$DW$582)

	.dwendtag $C$DW$TU$156


$C$DW$TU$171	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$171
$C$DW$583	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$583, DW_AT_type(*$C$DW$T$95)

$C$DW$T$171	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$171, DW_AT_type(*$C$DW$583)

	.dwendtag $C$DW$TU$171


$C$DW$TU$172	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$172

$C$DW$T$172	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$172, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$172, DW_AT_byte_size(0x12)
$C$DW$584	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$584, DW_AT_upper_bound(0x08)

	.dwendtag $C$DW$T$172

	.dwendtag $C$DW$TU$172


$C$DW$TU$14	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$14
$C$DW$T$14	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$14, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$14, DW_AT_name("long long")
	.dwattr $C$DW$T$14, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$14


$C$DW$TU$15	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$15
$C$DW$T$15	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$15, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$15, DW_AT_name("unsigned long long")
	.dwattr $C$DW$T$15, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$15


$C$DW$TU$16	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$16
$C$DW$T$16	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$16, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$16, DW_AT_name("float")
	.dwattr $C$DW$T$16, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$16


$C$DW$TU$17	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$17
$C$DW$T$17	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$17, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$17, DW_AT_name("double")
	.dwattr $C$DW$T$17, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$17


$C$DW$TU$18	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$18
$C$DW$T$18	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$18, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$18, DW_AT_name("long double")
	.dwattr $C$DW$T$18, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$18


$C$DW$TU$125	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$125
$C$DW$T$125	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$125, DW_AT_encoding(DW_ATE_unsigned_char)
	.dwattr $C$DW$T$125, DW_AT_name("unsigned char")
	.dwattr $C$DW$T$125, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$125

