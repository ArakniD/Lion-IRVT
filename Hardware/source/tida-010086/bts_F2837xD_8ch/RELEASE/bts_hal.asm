;***************************************************************
;* TMS320C2000 G3 C/C++ Codegen                               PC v20.2.4.LTS *
;* Date/Time created: Mon Jan 11 05:48:46 2021                 *
;***************************************************************
	.compiler_opts --abi=eabi --cla_support=cla1 --diag_wrap=off --float_support=fpu32 --hll_source=on --mem_model:code=flat --mem_model:data=large --object_format=elf --quiet --silicon_errata_fpu1_workaround=off --silicon_version=28 --symdebug:dwarf --symdebug:dwarf_version=4 --tmu_support=tmu0 --vcu_support=vcu2 
	.asg	XAR2, FP

$C$DW$CU	.dwtag  DW_TAG_compile_unit
	.dwattr $C$DW$CU, DW_AT_name("../bts_hal.c")
	.dwattr $C$DW$CU, DW_AT_producer("TI TMS320C2000 G3 C/C++ Codegen PC v20.2.4.LTS Copyright (c) 1996-2018 Texas Instruments Incorporated")
	.dwattr $C$DW$CU, DW_AT_TI_version(0x01)
	.dwattr $C$DW$CU, DW_AT_comp_dir("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\RELEASE")

$C$DW$1	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$1, DW_AT_name("Device_init")
	.dwattr $C$DW$1, DW_AT_linkage_name("Device_init")
	.dwattr $C$DW$1, DW_AT_declaration
	.dwattr $C$DW$1, DW_AT_external
	.dwattr $C$DW$1, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/device/device.h")
	.dwattr $C$DW$1, DW_AT_decl_line(0xec)
	.dwattr $C$DW$1, DW_AT_decl_column(0x0d)
	.dwendtag $C$DW$1


$C$DW$2	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$2, DW_AT_name("Device_initGPIO")
	.dwattr $C$DW$2, DW_AT_linkage_name("Device_initGPIO")
	.dwattr $C$DW$2, DW_AT_declaration
	.dwattr $C$DW$2, DW_AT_external
	.dwattr $C$DW$2, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/device/device.h")
	.dwattr $C$DW$2, DW_AT_decl_line(0xee)
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
	.dwattr $C$DW$6, DW_AT_type(*$C$DW$T$83)

$C$DW$7	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$7, DW_AT_type(*$C$DW$T$31)

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
	.dwattr $C$DW$9, DW_AT_type(*$C$DW$T$83)

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
	.dwattr $C$DW$11, DW_AT_type(*$C$DW$T$83)

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
	.dwattr $C$DW$13, DW_AT_type(*$C$DW$T$83)

$C$DW$14	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$14, DW_AT_type(*$C$DW$T$65)

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
	.dwattr $C$DW$16, DW_AT_type(*$C$DW$T$83)

$C$DW$17	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$17, DW_AT_type(*$C$DW$T$67)

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
	.dwattr $C$DW$19, DW_AT_type(*$C$DW$T$83)

$C$DW$20	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$20, DW_AT_type(*$C$DW$T$61)

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
	.dwattr $C$DW$22, DW_AT_type(*$C$DW$T$83)

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
	.dwattr $C$DW$25, DW_AT_type(*$C$DW$T$83)

$C$DW$26	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$26, DW_AT_type(*$C$DW$T$83)

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
	.dwattr $C$DW$28, DW_AT_type(*$C$DW$T$83)

$C$DW$29	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$29, DW_AT_type(*$C$DW$T$59)

	.dwendtag $C$DW$27


$C$DW$30	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$30, DW_AT_name("Interrupt_enable")
	.dwattr $C$DW$30, DW_AT_linkage_name("Interrupt_enable")
	.dwattr $C$DW$30, DW_AT_declaration
	.dwattr $C$DW$30, DW_AT_external
	.dwattr $C$DW$30, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h")
	.dwattr $C$DW$30, DW_AT_decl_line(0x1fb)
	.dwattr $C$DW$30, DW_AT_decl_column(0x01)
$C$DW$31	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$31, DW_AT_type(*$C$DW$T$83)

	.dwendtag $C$DW$30


$C$DW$32	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$32, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$32, DW_AT_linkage_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$32, DW_AT_declaration
	.dwattr $C$DW$32, DW_AT_external
	.dwattr $C$DW$32, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$32, DW_AT_decl_line(0x50f)
	.dwattr $C$DW$32, DW_AT_decl_column(0x01)
$C$DW$33	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$33, DW_AT_type(*$C$DW$T$83)

$C$DW$34	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$34, DW_AT_type(*$C$DW$T$83)

	.dwendtag $C$DW$32


$C$DW$35	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$35, DW_AT_name("ISR1")
	.dwattr $C$DW$35, DW_AT_linkage_name("ISR1")
	.dwattr $C$DW$35, DW_AT_declaration
	.dwattr $C$DW$35, DW_AT_external
	.dwattr $C$DW$35, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$35, DW_AT_decl_line(0x8f)
	.dwattr $C$DW$35, DW_AT_decl_column(0x10)
	.dwendtag $C$DW$35


$C$DW$36	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$36, DW_AT_name("ISR2")
	.dwattr $C$DW$36, DW_AT_linkage_name("ISR2")
	.dwattr $C$DW$36, DW_AT_declaration
	.dwattr $C$DW$36, DW_AT_external
	.dwattr $C$DW$36, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$36, DW_AT_decl_line(0x90)
	.dwattr $C$DW$36, DW_AT_decl_column(0x10)
	.dwendtag $C$DW$36


$C$DW$37	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$37, DW_AT_name("SPI_setConfig")
	.dwattr $C$DW$37, DW_AT_linkage_name("SPI_setConfig")
	.dwattr $C$DW$37, DW_AT_declaration
	.dwattr $C$DW$37, DW_AT_external
	.dwattr $C$DW$37, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$37, DW_AT_decl_line(0x48a)
	.dwattr $C$DW$37, DW_AT_decl_column(0x01)
$C$DW$38	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$38, DW_AT_type(*$C$DW$T$83)

$C$DW$39	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$39, DW_AT_type(*$C$DW$T$83)

$C$DW$40	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$40, DW_AT_type(*$C$DW$T$91)

$C$DW$41	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$41, DW_AT_type(*$C$DW$T$93)

$C$DW$42	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$42, DW_AT_type(*$C$DW$T$83)

$C$DW$43	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$43, DW_AT_type(*$C$DW$T$20)

	.dwendtag $C$DW$37


$C$DW$44	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$44, DW_AT_name("SPI_enableInterrupt")
	.dwattr $C$DW$44, DW_AT_linkage_name("SPI_enableInterrupt")
	.dwattr $C$DW$44, DW_AT_declaration
	.dwattr $C$DW$44, DW_AT_external
	.dwattr $C$DW$44, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$44, DW_AT_decl_line(0x4c4)
	.dwattr $C$DW$44, DW_AT_decl_column(0x01)
$C$DW$45	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$45, DW_AT_type(*$C$DW$T$83)

$C$DW$46	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$46, DW_AT_type(*$C$DW$T$83)

	.dwendtag $C$DW$44

	.global	||BTS_ExAdcRxflag||
	.bss	||BTS_ExAdcRxflag||,1,1,0
$C$DW$47	.dwtag  DW_TAG_variable
	.dwattr $C$DW$47, DW_AT_name("BTS_ExAdcRxflag")
	.dwattr $C$DW$47, DW_AT_linkage_name("BTS_ExAdcRxflag")
	.dwattr $C$DW$47, DW_AT_location[DW_OP_addr ||BTS_ExAdcRxflag||]
	.dwattr $C$DW$47, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$47, DW_AT_external
	.dwattr $C$DW$47, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$47, DW_AT_decl_line(0x1d)
	.dwattr $C$DW$47, DW_AT_decl_column(0x13)


$C$DW$48	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$48, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$48, DW_AT_linkage_name("SysCtl_getClock")
	.dwattr $C$DW$48, DW_AT_type(*$C$DW$T$83)
	.dwattr $C$DW$48, DW_AT_declaration
	.dwattr $C$DW$48, DW_AT_external
	.dwattr $C$DW$48, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$48, DW_AT_decl_line(0xc13)
	.dwattr $C$DW$48, DW_AT_decl_column(0x01)
$C$DW$49	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$49, DW_AT_type(*$C$DW$T$83)

	.dwendtag $C$DW$48


$C$DW$50	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$50, DW_AT_name("__eallow")
	.dwattr $C$DW$50, DW_AT_linkage_name("__eallow")
	.dwattr $C$DW$50, DW_AT_declaration
	.dwattr $C$DW$50, DW_AT_external
	.dwendtag $C$DW$50


$C$DW$51	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$51, DW_AT_name("__edis")
	.dwattr $C$DW$51, DW_AT_linkage_name("__edis")
	.dwattr $C$DW$51, DW_AT_declaration
	.dwattr $C$DW$51, DW_AT_external
	.dwendtag $C$DW$51

	.global	||BTS_ADC1||
	.bss	||BTS_ADC1||,18,1,1
$C$DW$52	.dwtag  DW_TAG_variable
	.dwattr $C$DW$52, DW_AT_name("BTS_ADC1")
	.dwattr $C$DW$52, DW_AT_linkage_name("BTS_ADC1")
	.dwattr $C$DW$52, DW_AT_location[DW_OP_addr ||BTS_ADC1||]
	.dwattr $C$DW$52, DW_AT_type(*$C$DW$T$94)
	.dwattr $C$DW$52, DW_AT_external
	.dwattr $C$DW$52, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$52, DW_AT_decl_line(0x1c)
	.dwattr $C$DW$52, DW_AT_decl_column(0x0b)

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

$C$DW$53	.dwtag  DW_TAG_variable
	.dwattr $C$DW$53, DW_AT_name("ePWM")
	.dwattr $C$DW$53, DW_AT_linkage_name("ePWM")
	.dwattr $C$DW$53, DW_AT_location[DW_OP_addr ||ePWM||]
	.dwattr $C$DW$53, DW_AT_type(*$C$DW$T$153)
	.dwattr $C$DW$53, DW_AT_external
	.dwattr $C$DW$53, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$53, DW_AT_decl_line(0x26)
	.dwattr $C$DW$53, DW_AT_decl_column(0x17)

	.sblock	".bss"
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\opt2000.exe C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{EF2ED1B8-42DB-4E42-98C9-45EB72CE8B5E} C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{144AC080-37BA-403D-BB9E-DAB833DED1D3} 
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\acia2000.exe -@C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{3616290F-9798-474D-9909-2D7D33E35AEC} 
	.sect	".text"
	.clink
	.global	||delay_ms_2||

$C$DW$54	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$54, DW_AT_name("delay_ms_2")
	.dwattr $C$DW$54, DW_AT_low_pc(||delay_ms_2||)
	.dwattr $C$DW$54, DW_AT_high_pc(0x00)
	.dwattr $C$DW$54, DW_AT_linkage_name("delay_ms_2")
	.dwattr $C$DW$54, DW_AT_external
	.dwattr $C$DW$54, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$54, DW_AT_decl_line(0xe5)
	.dwattr $C$DW$54, DW_AT_decl_column(0x06)
	.dwattr $C$DW$54, DW_AT_TI_max_frame_size(-8)
	.dwpsn	file "../bts_hal.c",line 230,column 1,is_stmt,address ||delay_ms_2||,isa 0

	.dwfde $C$DW$CIE, ||delay_ms_2||
$C$DW$55	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$55, DW_AT_name("delay_time_ms")
	.dwattr $C$DW$55, DW_AT_type(*$C$DW$T$83)
	.dwattr $C$DW$55, DW_AT_location[DW_OP_reg0]


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
$C$DW$56	.dwtag  DW_TAG_variable
	.dwattr $C$DW$56, DW_AT_name("delay_time_ms")
	.dwattr $C$DW$56, DW_AT_type(*$C$DW$T$137)
	.dwattr $C$DW$56, DW_AT_location[DW_OP_reg21]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -8
        MOVL      XAR1,ACC              ; [CPU_ALU] |230| 
	.dwpsn	file "../bts_hal.c",line 234,column 5,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |234| 
        MOV       AH,#1525              ; [CPU_ALU] |234| 
$C$DW$57	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$57, DW_AT_low_pc(0x00)
	.dwattr $C$DW$57, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$57, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |234| 
        ; call occurs [#||SysCtl_getClock||] ; [] |234| 
        MOVL      XT,XAR1               ; [CPU_ALU] |234| 
        IMPYXUL   P,XT,ACC              ; [CPU_ALU] |234| 
        MOVL      XAR6,P                ; [CPU_ALU] |234| 
        MOV       AL,#6641              ; [CPU_ALU] |234| 
        MOV       AH,#1398              ; [CPU_ALU] |234| 
        MOVL      XT,ACC                ; [CPU_ALU] |234| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |234| 
        MOVL      ACC,P                 ; [CPU_ALU] |234| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |234| 
        MOV       T,#38                 ; [CPU_FPU] |234| 
        LSR64     ACC:P,T               ; [CPU_ALU] |234| 
        MOVL      ACC,P                 ; [CPU_ALU] |234| 
$C$DW$58	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$58, DW_AT_low_pc(0x00)
	.dwattr $C$DW$58, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$58, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |234| 
        ; call occurs [#||SysCtl_delay||] ; [] |234| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
        MOVL      XAR1,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$59	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$59, DW_AT_low_pc(0x00)
	.dwattr $C$DW$59, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$54, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$54, DW_AT_TI_end_line(0xec)
	.dwattr $C$DW$54, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$54

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupSyncBuckPwm||

$C$DW$60	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$60, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$60, DW_AT_low_pc(||BTS_HAL_setupSyncBuckPwm||)
	.dwattr $C$DW$60, DW_AT_high_pc(0x00)
	.dwattr $C$DW$60, DW_AT_linkage_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$60, DW_AT_external
	.dwattr $C$DW$60, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$60, DW_AT_decl_line(0x156)
	.dwattr $C$DW$60, DW_AT_decl_column(0x06)
	.dwattr $C$DW$60, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "../bts_hal.c",line 343,column 1,is_stmt,address ||BTS_HAL_setupSyncBuckPwm||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupSyncBuckPwm||
$C$DW$61	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$61, DW_AT_name("EPWM_BASE")
	.dwattr $C$DW$61, DW_AT_type(*$C$DW$T$83)
	.dwattr $C$DW$61, DW_AT_location[DW_OP_reg0]


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
$C$DW$62	.dwtag  DW_TAG_variable
	.dwattr $C$DW$62, DW_AT_name("EPWM_BASE")
	.dwattr $C$DW$62, DW_AT_type(*$C$DW$T$137)
	.dwattr $C$DW$62, DW_AT_location[DW_OP_reg8]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
        MOVL      *SP++,XAR2            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 9, 4
	.dwcfi	cfa_offset, -6
        MOVL      XAR2,ACC              ; [CPU_ALU] |343| 
	.dwpsn	file "../bts_hal.c",line 351,column 5,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |351| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 1591,column 5,is_stmt,isa 0
        AND       *+XAR2[0],#0xe07f     ; [CPU_ALU] |1591| 
	.dwpsn	file "../bts_hal.c",line 351,column 5,is_stmt,isa 0
$C$DW$63	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$63, DW_AT_low_pc(0x00)
	.dwattr $C$DW$63, DW_AT_name("EPWM_setEmulationMode")
	.dwattr $C$DW$63, DW_AT_TI_call

        LCR       #||EPWM_setEmulationMode|| ; [CPU_ALU] |351| 
        ; call occurs [#||EPWM_setEmulationMode||] ; [] |351| 
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
        MOV       *+XAR2[AR0],#999      ; [CPU_ALU] |2146| 
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
        MOV       *+XAR2[AR0],#999      ; [CPU_ALU] |2406| 
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
        MOVB      *+XAR2[AR0],#15,UNC   ; [CPU_ALU] |3649| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3621,column 5,is_stmt,isa 0
        MOVB      XAR0,#81              ; [CPU_ALU] |3621| 
        MOVB      *+XAR2[AR0],#15,UNC   ; [CPU_ALU] |3621| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3649,column 5,is_stmt,isa 0
        MOVB      XAR0,#83              ; [CPU_ALU] |3649| 
        MOVB      *+XAR2[AR0],#15,UNC   ; [CPU_ALU] |3649| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3621,column 5,is_stmt,isa 0
        MOVB      *+XAR2[AR1],#15,UNC   ; [CPU_ALU] |3621| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 887,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |887| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 892,column 5,is_stmt,isa 0
        MOVB      ACC,#2                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381734          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 894,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |894| 
        MOVL      XAR2,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 9
        MOVL      XAR1,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$64	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$64, DW_AT_low_pc(0x00)
	.dwattr $C$DW$64, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$60, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$60, DW_AT_TI_end_line(0x1f4)
	.dwattr $C$DW$60, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$60

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupSyncBuckPinsGpio||

$C$DW$65	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$65, DW_AT_name("BTS_HAL_setupSyncBuckPinsGpio")
	.dwattr $C$DW$65, DW_AT_low_pc(||BTS_HAL_setupSyncBuckPinsGpio||)
	.dwattr $C$DW$65, DW_AT_high_pc(0x00)
	.dwattr $C$DW$65, DW_AT_linkage_name("BTS_HAL_setupSyncBuckPinsGpio")
	.dwattr $C$DW$65, DW_AT_external
	.dwattr $C$DW$65, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$65, DW_AT_decl_line(0x115)
	.dwattr $C$DW$65, DW_AT_decl_column(0x06)
	.dwattr $C$DW$65, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 278,column 1,is_stmt,address ||BTS_HAL_setupSyncBuckPinsGpio||,isa 0

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
	.dwpsn	file "../bts_hal.c",line 280,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |280| 
        MOVB      ACC,#1                ; [CPU_ALU] |280| 
$C$DW$66	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$66, DW_AT_low_pc(0x00)
	.dwattr $C$DW$66, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$66, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |280| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |280| 
	.dwpsn	file "../bts_hal.c",line 281,column 5,is_stmt,isa 0
        MOVL      XAR4,#393216          ; [CPU_ARAU] |281| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |281| 
$C$DW$67	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$67, DW_AT_low_pc(0x00)
	.dwattr $C$DW$67, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$67, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |281| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |281| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#2                ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 284,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |284| 
        MOVB      ACC,#1                ; [CPU_ALU] |284| 
$C$DW$68	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$68, DW_AT_low_pc(0x00)
	.dwattr $C$DW$68, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$68, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |284| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |284| 
	.dwpsn	file "../bts_hal.c",line 285,column 5,is_stmt,isa 0
        MOVL      XAR4,#393728          ; [CPU_ARAU] |285| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |285| 
$C$DW$69	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$69, DW_AT_low_pc(0x00)
	.dwattr $C$DW$69, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$69, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |285| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |285| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#4                ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 289,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |289| 
        MOVB      ACC,#2                ; [CPU_ALU] |289| 
$C$DW$70	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$70, DW_AT_low_pc(0x00)
	.dwattr $C$DW$70, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$70, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |289| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |289| 
	.dwpsn	file "../bts_hal.c",line 290,column 5,is_stmt,isa 0
        MOVL      XAR4,#394240          ; [CPU_ARAU] |290| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |290| 
$C$DW$71	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$71, DW_AT_low_pc(0x00)
	.dwattr $C$DW$71, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$71, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |290| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |290| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#8                ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 293,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |293| 
        MOVB      ACC,#3                ; [CPU_ALU] |293| 
$C$DW$72	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$72, DW_AT_low_pc(0x00)
	.dwattr $C$DW$72, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$72, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |293| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |293| 
	.dwpsn	file "../bts_hal.c",line 294,column 5,is_stmt,isa 0
        MOVL      XAR4,#394752          ; [CPU_ARAU] |294| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |294| 
$C$DW$73	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$73, DW_AT_low_pc(0x00)
	.dwattr $C$DW$73, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$73, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |294| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |294| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#16               ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 298,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |298| 
        MOVB      ACC,#4                ; [CPU_ALU] |298| 
$C$DW$74	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$74, DW_AT_low_pc(0x00)
	.dwattr $C$DW$74, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$74, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |298| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |298| 
	.dwpsn	file "../bts_hal.c",line 299,column 5,is_stmt,isa 0
        MOVL      XAR4,#395264          ; [CPU_ARAU] |299| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |299| 
$C$DW$75	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$75, DW_AT_low_pc(0x00)
	.dwattr $C$DW$75, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$75, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |299| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |299| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#32               ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 302,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |302| 
        MOVB      ACC,#5                ; [CPU_ALU] |302| 
$C$DW$76	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$76, DW_AT_low_pc(0x00)
	.dwattr $C$DW$76, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$76, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |302| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |302| 
	.dwpsn	file "../bts_hal.c",line 303,column 5,is_stmt,isa 0
        MOVL      XAR4,#395776          ; [CPU_ARAU] |303| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |303| 
$C$DW$77	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$77, DW_AT_low_pc(0x00)
	.dwattr $C$DW$77, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$77, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |303| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |303| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#64               ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 307,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |307| 
        MOVB      ACC,#6                ; [CPU_ALU] |307| 
$C$DW$78	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$78, DW_AT_low_pc(0x00)
	.dwattr $C$DW$78, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$78, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |307| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |307| 
	.dwpsn	file "../bts_hal.c",line 308,column 5,is_stmt,isa 0
        MOVL      XAR4,#396288          ; [CPU_ARAU] |308| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |308| 
$C$DW$79	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$79, DW_AT_low_pc(0x00)
	.dwattr $C$DW$79, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$79, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |308| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |308| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      ACC,#128              ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 311,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |311| 
        MOVB      ACC,#7                ; [CPU_ALU] |311| 
$C$DW$80	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$80, DW_AT_low_pc(0x00)
	.dwattr $C$DW$80, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$80, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |311| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |311| 
	.dwpsn	file "../bts_hal.c",line 312,column 5,is_stmt,isa 0
        MOVL      XAR4,#396800          ; [CPU_ARAU] |312| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |312| 
$C$DW$81	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$81, DW_AT_low_pc(0x00)
	.dwattr $C$DW$81, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$81, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |312| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |312| 
$C$DW$82	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$82, DW_AT_low_pc(0x00)
	.dwattr $C$DW$82, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$65, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$65, DW_AT_TI_end_line(0x139)
	.dwattr $C$DW$65, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$65

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupSyncBuckPinsEpwm||

$C$DW$83	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$83, DW_AT_name("BTS_HAL_setupSyncBuckPinsEpwm")
	.dwattr $C$DW$83, DW_AT_low_pc(||BTS_HAL_setupSyncBuckPinsEpwm||)
	.dwattr $C$DW$83, DW_AT_high_pc(0x00)
	.dwattr $C$DW$83, DW_AT_linkage_name("BTS_HAL_setupSyncBuckPinsEpwm")
	.dwattr $C$DW$83, DW_AT_external
	.dwattr $C$DW$83, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$83, DW_AT_decl_line(0x142)
	.dwattr $C$DW$83, DW_AT_decl_column(0x06)
	.dwattr $C$DW$83, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 323,column 1,is_stmt,address ||BTS_HAL_setupSyncBuckPinsEpwm||,isa 0

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
	.dwpsn	file "../bts_hal.c",line 324,column 5,is_stmt,isa 0
        MOVL      XAR4,#393217          ; [CPU_ARAU] |324| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |324| 
$C$DW$84	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$84, DW_AT_low_pc(0x00)
	.dwattr $C$DW$84, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$84, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |324| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |324| 
	.dwpsn	file "../bts_hal.c",line 325,column 5,is_stmt,isa 0
        MOVL      XAR4,#393729          ; [CPU_ARAU] |325| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |325| 
$C$DW$85	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$85, DW_AT_low_pc(0x00)
	.dwattr $C$DW$85, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$85, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |325| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |325| 
	.dwpsn	file "../bts_hal.c",line 327,column 5,is_stmt,isa 0
        MOVL      XAR4,#394241          ; [CPU_ARAU] |327| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |327| 
$C$DW$86	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$86, DW_AT_low_pc(0x00)
	.dwattr $C$DW$86, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$86, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |327| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |327| 
	.dwpsn	file "../bts_hal.c",line 328,column 5,is_stmt,isa 0
        MOVL      XAR4,#394753          ; [CPU_ARAU] |328| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |328| 
$C$DW$87	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$87, DW_AT_low_pc(0x00)
	.dwattr $C$DW$87, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$87, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |328| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |328| 
	.dwpsn	file "../bts_hal.c",line 330,column 5,is_stmt,isa 0
        MOVL      XAR4,#395265          ; [CPU_ARAU] |330| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |330| 
$C$DW$88	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$88, DW_AT_low_pc(0x00)
	.dwattr $C$DW$88, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$88, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |330| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |330| 
	.dwpsn	file "../bts_hal.c",line 331,column 5,is_stmt,isa 0
        MOVL      XAR4,#395777          ; [CPU_ARAU] |331| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |331| 
$C$DW$89	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$89, DW_AT_low_pc(0x00)
	.dwattr $C$DW$89, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$89, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |331| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |331| 
	.dwpsn	file "../bts_hal.c",line 333,column 5,is_stmt,isa 0
        MOVL      XAR4,#396289          ; [CPU_ARAU] |333| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |333| 
$C$DW$90	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$90, DW_AT_low_pc(0x00)
	.dwattr $C$DW$90, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$90, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |333| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |333| 
	.dwpsn	file "../bts_hal.c",line 334,column 5,is_stmt,isa 0
        MOVL      XAR4,#396801          ; [CPU_ARAU] |334| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |334| 
$C$DW$91	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$91, DW_AT_low_pc(0x00)
	.dwattr $C$DW$91, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$91, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |334| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |334| 
$C$DW$92	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$92, DW_AT_low_pc(0x00)
	.dwattr $C$DW$92, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$83, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$83, DW_AT_TI_end_line(0x14f)
	.dwattr $C$DW$83, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$83

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupInterruptTrigger||

$C$DW$93	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$93, DW_AT_name("BTS_HAL_setupInterruptTrigger")
	.dwattr $C$DW$93, DW_AT_low_pc(||BTS_HAL_setupInterruptTrigger||)
	.dwattr $C$DW$93, DW_AT_high_pc(0x00)
	.dwattr $C$DW$93, DW_AT_linkage_name("BTS_HAL_setupInterruptTrigger")
	.dwattr $C$DW$93, DW_AT_external
	.dwattr $C$DW$93, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$93, DW_AT_decl_line(0x202)
	.dwattr $C$DW$93, DW_AT_decl_column(0x06)
	.dwattr $C$DW$93, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts_hal.c",line 515,column 1,is_stmt,address ||BTS_HAL_setupInterruptTrigger||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupInterruptTrigger||

;***************************************************************
;* FNAME: BTS_HAL_setupInterruptTrigger FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupInterruptTrigger||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts_hal.c",line 516,column 5,is_stmt,isa 0
        MOVL      XAR4,#2294020         ; [CPU_ARAU] |516| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |516| 
$C$DW$94	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$94, DW_AT_low_pc(0x00)
	.dwattr $C$DW$94, DW_AT_name("Interrupt_enable")
	.dwattr $C$DW$94, DW_AT_TI_call

        LCR       #||Interrupt_enable|| ; [CPU_ALU] |516| 
        ; call occurs [#||Interrupt_enable||] ; [] |516| 
	.dwpsn	file "../bts_hal.c",line 517,column 5,is_stmt,isa 0
        MOVB      ACC,#4                ; [CPU_ALU] |517| 
        MOVL      XAR4,#24832           ; [CPU_ARAU] |517| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |517| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |517| 
$C$DW$95	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$95, DW_AT_low_pc(0x00)
	.dwattr $C$DW$95, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$95, DW_AT_TI_call

        LCR       #||SPI_clearInterruptStatus|| ; [CPU_ALU] |517| 
        ; call occurs [#||SPI_clearInterruptStatus||] ; [] |517| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 384,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |384| 
        AND       AL,#0xdfff            ; [CPU_ALU] |384| 
	.dwpsn	file "../bts_hal.c",line 520,column 5,is_stmt,isa 0
        MOV       AH,#72                ; [CPU_FPU] |520| 
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
	.dwpsn	file "../bts_hal.c",line 520,column 5,is_stmt,isa 0
        MOV       AL,#1537              ; [CPU_ALU] |520| 
$C$DW$96	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$96, DW_AT_low_pc(0x00)
	.dwattr $C$DW$96, DW_AT_name("Interrupt_enable")
	.dwattr $C$DW$96, DW_AT_TI_call

        LCR       #||Interrupt_enable|| ; [CPU_ALU] |520| 
        ; call occurs [#||Interrupt_enable||] ; [] |520| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$97	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$97, DW_AT_low_pc(0x00)
	.dwattr $C$DW$97, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$93, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$93, DW_AT_TI_end_line(0x20a)
	.dwattr $C$DW$93, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$93

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupInterrupt||

$C$DW$98	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$98, DW_AT_name("BTS_HAL_setupInterrupt")
	.dwattr $C$DW$98, DW_AT_low_pc(||BTS_HAL_setupInterrupt||)
	.dwattr $C$DW$98, DW_AT_high_pc(0x00)
	.dwattr $C$DW$98, DW_AT_linkage_name("BTS_HAL_setupInterrupt")
	.dwattr $C$DW$98, DW_AT_external
	.dwattr $C$DW$98, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$98, DW_AT_decl_line(0x20d)
	.dwattr $C$DW$98, DW_AT_decl_column(0x06)
	.dwattr $C$DW$98, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts_hal.c",line 526,column 1,is_stmt,address ||BTS_HAL_setupInterrupt||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupInterrupt||

;***************************************************************
;* FNAME: BTS_HAL_setupInterrupt        FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupInterrupt||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts_hal.c",line 527,column 5,is_stmt,isa 0
        MOVB      ACC,#4                ; [CPU_ALU] |527| 
        MOVL      XAR4,#24832           ; [CPU_ARAU] |527| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |527| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |527| 
$C$DW$99	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$99, DW_AT_low_pc(0x00)
	.dwattr $C$DW$99, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$99, DW_AT_TI_call

        LCR       #||SPI_clearInterruptStatus|| ; [CPU_ALU] |527| 
        ; call occurs [#||SPI_clearInterruptStatus||] ; [] |527| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 308,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |308| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 309,column 5,is_stmt,isa 0
        MOVL      XAR4,#||ISR1||        ; [CPU_ARAU] |309| 
        MOVL      XAR5,#3398            ; [CPU_ARAU] |309| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |309| 
        MOVL      XAR4,#||ISR2||        ; [CPU_ARAU] |309| 
        MOVL      XAR5,#3472            ; [CPU_ARAU] |309| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |309| 
 clrc INTM
 clrc DBGM
	.dwpsn	file "../bts_hal.c",line 534,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |534| 
        SPM       #0                    ; [CPU_ALU] 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$100	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$100, DW_AT_low_pc(0x00)
	.dwattr $C$DW$100, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$98, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$98, DW_AT_TI_end_line(0x217)
	.dwattr $C$DW$98, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$98

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupExAdcGpio||

$C$DW$101	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$101, DW_AT_name("BTS_HAL_setupExAdcGpio")
	.dwattr $C$DW$101, DW_AT_low_pc(||BTS_HAL_setupExAdcGpio||)
	.dwattr $C$DW$101, DW_AT_high_pc(0x00)
	.dwattr $C$DW$101, DW_AT_linkage_name("BTS_HAL_setupExAdcGpio")
	.dwattr $C$DW$101, DW_AT_external
	.dwattr $C$DW$101, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$101, DW_AT_decl_line(0xf0)
	.dwattr $C$DW$101, DW_AT_decl_column(0x06)
	.dwattr $C$DW$101, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts_hal.c",line 241,column 1,is_stmt,address ||BTS_HAL_setupExAdcGpio||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupExAdcGpio||

;***************************************************************
;* FNAME: BTS_HAL_setupExAdcGpio        FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupExAdcGpio||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts_hal.c",line 246,column 5,is_stmt,isa 0
        MOV       ACC,#1121 << 12       ; [CPU_ALU] |246| 
$C$DW$102	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$102, DW_AT_low_pc(0x00)
	.dwattr $C$DW$102, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$102, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |246| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |246| 
	.dwpsn	file "../bts_hal.c",line 247,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |247| 
        MOVB      ACC,#40               ; [CPU_ALU] |247| 
$C$DW$103	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$103, DW_AT_low_pc(0x00)
	.dwattr $C$DW$103, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$103, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |247| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |247| 
	.dwpsn	file "../bts_hal.c",line 248,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |248| 
        MOVB      ACC,#40               ; [CPU_ALU] |248| 
$C$DW$104	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$104, DW_AT_low_pc(0x00)
	.dwattr $C$DW$104, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$104, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |248| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |248| 
	.dwpsn	file "../bts_hal.c",line 252,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |252| 
        MOVB      ACC,#40               ; [CPU_ALU] |252| 
$C$DW$105	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$105, DW_AT_low_pc(0x00)
	.dwattr $C$DW$105, DW_AT_name("GPIO_setInterruptPin")
	.dwattr $C$DW$105, DW_AT_TI_call

        LCR       #||GPIO_setInterruptPin|| ; [CPU_ALU] |252| 
        ; call occurs [#||GPIO_setInterruptPin||] ; [] |252| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 274,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7070)        ; [CPU_ALU] |274| 
        AND       AL,#0xfff3            ; [CPU_ALU] |274| 
	.dwpsn	file "../bts_hal.c",line 266,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_FPU] |266| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 274,column 5,is_stmt,isa 0
        MOV       *(0:0x7070),AL        ; [CPU_ALU] |274| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 339,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7070)        ; [CPU_ALU] |339| 
        ORB       AL,#0x01              ; [CPU_ALU] |339| 
        MOV       *(0:0x7070),AL        ; [CPU_ALU] |339| 
	.dwpsn	file "../bts_hal.c",line 266,column 5,is_stmt,isa 0
        MOVB      ACC,#22               ; [CPU_ALU] |266| 
$C$DW$106	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$106, DW_AT_low_pc(0x00)
	.dwattr $C$DW$106, DW_AT_name("GPIO_setAnalogMode")
	.dwattr $C$DW$106, DW_AT_TI_call

        LCR       #||GPIO_setAnalogMode|| ; [CPU_ALU] |266| 
        ; call occurs [#||GPIO_setAnalogMode||] ; [] |266| 
	.dwpsn	file "../bts_hal.c",line 268,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |268| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |268| 
        MOVB      ACC,#22               ; [CPU_ALU] |268| 
$C$DW$107	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$107, DW_AT_low_pc(0x00)
	.dwattr $C$DW$107, DW_AT_name("GPIO_setPadConfig")
	.dwattr $C$DW$107, DW_AT_TI_call

        LCR       #||GPIO_setPadConfig|| ; [CPU_ALU] |268| 
        ; call occurs [#||GPIO_setPadConfig||] ; [] |268| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |472| 
        MOV       AH,#64                ; [CPU_ALU] |472| 
        MOVL      XAR4,#32514           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 270,column 5,is_stmt,isa 0
        MOVL      XAR5,#527360          ; [CPU_ARAU] |270| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 270,column 5,is_stmt,isa 0
        MOVL      ACC,XAR5              ; [CPU_ALU] |270| 
$C$DW$108	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$108, DW_AT_low_pc(0x00)
	.dwattr $C$DW$108, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$108, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |270| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |270| 
	.dwpsn	file "../bts_hal.c",line 272,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |272| 
        MOVB      ACC,#22               ; [CPU_ALU] |272| 
$C$DW$109	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$109, DW_AT_low_pc(0x00)
	.dwattr $C$DW$109, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$109, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |272| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |272| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$110	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$110, DW_AT_low_pc(0x00)
	.dwattr $C$DW$110, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$101, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$101, DW_AT_TI_end_line(0x111)
	.dwattr $C$DW$101, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$101

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupExAdc||

$C$DW$111	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$111, DW_AT_name("BTS_HAL_setupExAdc")
	.dwattr $C$DW$111, DW_AT_low_pc(||BTS_HAL_setupExAdc||)
	.dwattr $C$DW$111, DW_AT_high_pc(0x00)
	.dwattr $C$DW$111, DW_AT_linkage_name("BTS_HAL_setupExAdc")
	.dwattr $C$DW$111, DW_AT_external
	.dwattr $C$DW$111, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$111, DW_AT_decl_line(0x81)
	.dwattr $C$DW$111, DW_AT_decl_column(0x06)
	.dwattr $C$DW$111, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "../bts_hal.c",line 130,column 1,is_stmt,address ||BTS_HAL_setupExAdc||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_setupExAdc||

;***************************************************************
;* FNAME: BTS_HAL_setupExAdc            FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_setupExAdc||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "../bts_hal.c",line 234,column 5,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |234| 
        MOV       AH,#1525              ; [CPU_ALU] |234| 
$C$DW$112	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$112, DW_AT_low_pc(0x00)
	.dwattr $C$DW$112, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$112, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |234| 
        ; call occurs [#||SysCtl_getClock||] ; [] |234| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |234| 
        MOVB      ACC,#50               ; [CPU_ALU] |234| 
        MOVL      XT,ACC                ; [CPU_ALU] |234| 
        IMPYXUL   P,XT,XAR6             ; [CPU_ALU] |234| 
        MOVL      XAR6,P                ; [CPU_ALU] |234| 
        MOV       AL,#6641              ; [CPU_ALU] |234| 
        MOV       AH,#1398              ; [CPU_ALU] |234| 
        MOVL      XT,ACC                ; [CPU_ALU] |234| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |234| 
        MOVL      ACC,P                 ; [CPU_ALU] |234| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |234| 
        MOV       T,#38                 ; [CPU_FPU] |234| 
        LSR64     ACC:P,T               ; [CPU_ALU] |234| 
        MOVL      ACC,P                 ; [CPU_ALU] |234| 
$C$DW$113	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$113, DW_AT_low_pc(0x00)
	.dwattr $C$DW$113, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$113, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |234| 
        ; call occurs [#||SysCtl_delay||] ; [] |234| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |472| 
        MOV       AH,#64                ; [CPU_ALU] |472| 
        MOVL      XAR4,#32514           ; [CPU_ARAU] |472| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 234,column 5,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |234| 
        MOV       AH,#1525              ; [CPU_ALU] |234| 
$C$DW$114	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$114, DW_AT_low_pc(0x00)
	.dwattr $C$DW$114, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$114, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |234| 
        ; call occurs [#||SysCtl_getClock||] ; [] |234| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |234| 
        MOV       AL,#6641              ; [CPU_ALU] |234| 
        MOV       AH,#1398              ; [CPU_ALU] |234| 
        MOVL      XT,ACC                ; [CPU_ALU] |234| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |234| 
        MOVL      ACC,P                 ; [CPU_ALU] |234| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |234| 
        MOV       T,#38                 ; [CPU_FPU] |234| 
        LSR64     ACC:P,T               ; [CPU_ALU] |234| 
        MOVL      ACC,P                 ; [CPU_ALU] |234| 
$C$DW$115	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$115, DW_AT_low_pc(0x00)
	.dwattr $C$DW$115, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$115, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |234| 
        ; call occurs [#||SysCtl_delay||] ; [] |234| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |468| 
        MOV       AH,#64                ; [CPU_ALU] |468| 
        MOVL      XAR4,#32516           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "../bts_hal.c",line 234,column 5,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |234| 
        MOV       AH,#1525              ; [CPU_ALU] |234| 
$C$DW$116	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$116, DW_AT_low_pc(0x00)
	.dwattr $C$DW$116, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$116, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |234| 
        ; call occurs [#||SysCtl_getClock||] ; [] |234| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |234| 
        MOV       AL,#6641              ; [CPU_ALU] |234| 
        MOV       AH,#1398              ; [CPU_ALU] |234| 
        MOVL      XT,ACC                ; [CPU_ALU] |234| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |234| 
        MOVL      ACC,P                 ; [CPU_ALU] |234| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |234| 
        MOV       T,#38                 ; [CPU_FPU] |234| 
        LSR64     ACC:P,T               ; [CPU_ALU] |234| 
        MOVL      ACC,P                 ; [CPU_ALU] |234| 
$C$DW$117	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$117, DW_AT_low_pc(0x00)
	.dwattr $C$DW$117, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$117, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |234| 
        ; call occurs [#||SysCtl_delay||] ; [] |234| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |472| 
        MOV       AH,#64                ; [CPU_ALU] |472| 
        MOVL      XAR4,#32514           ; [CPU_ARAU] |472| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 234,column 5,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |234| 
        MOV       AH,#1525              ; [CPU_ALU] |234| 
$C$DW$118	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$118, DW_AT_low_pc(0x00)
	.dwattr $C$DW$118, DW_AT_name("SysCtl_getClock")
	.dwattr $C$DW$118, DW_AT_TI_call

        LCR       #||SysCtl_getClock||  ; [CPU_ALU] |234| 
        ; call occurs [#||SysCtl_getClock||] ; [] |234| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |234| 
        MOV       AL,#6641              ; [CPU_ALU] |234| 
        MOV       AH,#1398              ; [CPU_ALU] |234| 
        MOVL      XT,ACC                ; [CPU_ALU] |234| 
        QMPYXUL   P,XT,XAR6             ; [CPU_ALU] |234| 
        MOVL      ACC,P                 ; [CPU_ALU] |234| 
        IMPYL     P,XT,XAR6             ; [CPU_ALU] |234| 
        MOV       T,#38                 ; [CPU_FPU] |234| 
        LSR64     ACC:P,T               ; [CPU_ALU] |234| 
        MOVL      ACC,P                 ; [CPU_ALU] |234| 
$C$DW$119	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$119, DW_AT_low_pc(0x00)
	.dwattr $C$DW$119, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$119, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |234| 
        ; call occurs [#||SysCtl_delay||] ; [] |234| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 430,column 5,is_stmt,isa 0
        MOVL      XAR4,#32520           ; [CPU_ARAU] |430| 
||$C$L1||:    
        TBIT      *+XAR4[0],#8          ; [CPU_ALU] |430| 
        B         ||$C$L1||,NTC         ; [CPU_ALU] |430| 
        ; branchcc occurs ; [] |430| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOV       ACC,#1024 << 15       ; [CPU_ALU] |468| 
        MOVL      XAR4,#32524           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
||$C$L2||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L2||,EQ          ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#24832             ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L3||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L3||,EQ          ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
||$C$L4||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L4||,EQ          ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOVB      AL,#5                 ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L5||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L5||,EQ          ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
||$C$L6||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L6||,EQ          ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#256               ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L7||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L7||,EQ          ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOV       ACC,#1024 << 15       ; [CPU_ALU] |472| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AR6,*(0:0x6107)       ; [CPU_ALU] |687| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR4,#32522           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 184,column 5,is_stmt,isa 0
        MOVL      XAR5,#10000           ; [CPU_ARAU] |184| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 184,column 5,is_stmt,isa 0
        MOVL      ACC,XAR5              ; [CPU_ALU] |184| 
$C$DW$120	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$120, DW_AT_low_pc(0x00)
	.dwattr $C$DW$120, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$120, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |184| 
        ; call occurs [#||SysCtl_delay||] ; [] |184| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOV       ACC,#1024 << 15       ; [CPU_ALU] |468| 
        MOVL      XAR4,#32524           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
||$C$L8||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L8||,EQ          ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#24832             ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L9||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L9||,EQ          ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
||$C$L10||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L10||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L11||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L11||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
||$C$L12||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L12||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#256               ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L13||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L13||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOV       ACC,#1024 << 15       ; [CPU_ALU] |472| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AR6,*(0:0x6107)       ; [CPU_ALU] |687| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR4,#32522           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 203,column 5,is_stmt,isa 0
        MOVL      XAR5,#100000          ; [CPU_ARAU] |203| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 203,column 5,is_stmt,isa 0
        MOVL      ACC,XAR5              ; [CPU_ALU] |203| 
$C$DW$121	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$121, DW_AT_low_pc(0x00)
	.dwattr $C$DW$121, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$121, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |203| 
        ; call occurs [#||SysCtl_delay||] ; [] |203| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOV       ACC,#1024 << 15       ; [CPU_ALU] |468| 
        MOVL      XAR4,#32524           ; [CPU_ARAU] |468| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
||$C$L14||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L14||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#24960             ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L15||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L15||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
||$C$L16||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L16||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOV       AL,#65351             ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L17||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L17||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |687| 
||$C$L18||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 485,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |485| 
        LSR       AL,8                  ; [CPU_ALU] |485| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |485| 
        CMPB      AL,#16                ; [CPU_ALU] |485| 
        B         ||$C$L18||,EQ         ; [CPU_ALU] |485| 
        ; branchcc occurs ; [] |485| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 648,column 5,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |648| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |648| 
||$C$L19||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 514,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |514| 
        LSR       AL,8                  ; [CPU_ALU] |514| 
        ANDB      AL,#0x1f              ; [CPU_ALU] |514| 
        B         ||$C$L19||,EQ         ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOV       ACC,#1024 << 15       ; [CPU_ALU] |472| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 687,column 5,is_stmt,isa 0
        MOV       AR6,*(0:0x6107)       ; [CPU_ALU] |687| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR4,#32522           ; [CPU_ARAU] |472| 
	.dwpsn	file "../bts_hal.c",line 221,column 5,is_stmt,isa 0
        MOVL      XAR5,#10000           ; [CPU_ARAU] |221| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 221,column 5,is_stmt,isa 0
        MOVL      ACC,XAR5              ; [CPU_ALU] |221| 
$C$DW$122	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$122, DW_AT_low_pc(0x00)
	.dwattr $C$DW$122, DW_AT_name("SysCtl_delay")
	.dwattr $C$DW$122, DW_AT_TI_call

        LCR       #||SysCtl_delay||     ; [CPU_ALU] |221| 
        ; call occurs [#||SysCtl_delay||] ; [] |221| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$123	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$123, DW_AT_low_pc(0x00)
	.dwattr $C$DW$123, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$111, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$111, DW_AT_TI_end_line(0xe2)
	.dwattr $C$DW$111, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$111

	.sect	".text"
	.clink
	.global	||BTS_HAL_setupDevice||

$C$DW$124	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$124, DW_AT_name("BTS_HAL_setupDevice")
	.dwattr $C$DW$124, DW_AT_low_pc(||BTS_HAL_setupDevice||)
	.dwattr $C$DW$124, DW_AT_high_pc(0x00)
	.dwattr $C$DW$124, DW_AT_linkage_name("BTS_HAL_setupDevice")
	.dwattr $C$DW$124, DW_AT_external
	.dwattr $C$DW$124, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$124, DW_AT_decl_line(0x31)
	.dwattr $C$DW$124, DW_AT_decl_column(0x06)
	.dwattr $C$DW$124, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 50,column 1,is_stmt,address ||BTS_HAL_setupDevice||,isa 0

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
	.dwpsn	file "../bts_hal.c",line 54,column 5,is_stmt,isa 0
$C$DW$125	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$125, DW_AT_low_pc(0x00)
	.dwattr $C$DW$125, DW_AT_name("Device_init")
	.dwattr $C$DW$125, DW_AT_TI_call

        LCR       #||Device_init||      ; [CPU_ALU] |54| 
        ; call occurs [#||Device_init||] ; [] |54| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1077,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |1077| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1078,column 5,is_stmt,isa 0
        MOVL      XAR4,#381484          ; [CPU_ARAU] |1078| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |1078| 
        AND       AL,#65528             ; [CPU_ALU] |1078| 
        ANDB      AH,#0                 ; [CPU_ALU] |1078| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |1078| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1081,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |1081| 
	.dwpsn	file "../bts_hal.c",line 59,column 5,is_stmt,isa 0
$C$DW$126	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$126, DW_AT_low_pc(0x00)
	.dwattr $C$DW$126, DW_AT_name("Device_initGPIO")
	.dwattr $C$DW$126, DW_AT_TI_call

        LCR       #||Device_initGPIO||  ; [CPU_ALU] |59| 
        ; call occurs [#||Device_initGPIO||] ; [] |59| 
	.dwpsn	file "../bts_hal.c",line 64,column 5,is_stmt,isa 0
$C$DW$127	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$127, DW_AT_low_pc(0x00)
	.dwattr $C$DW$127, DW_AT_name("Interrupt_initModule")
	.dwattr $C$DW$127, DW_AT_TI_call

        LCR       #||Interrupt_initModule|| ; [CPU_ALU] |64| 
        ; call occurs [#||Interrupt_initModule||] ; [] |64| 
	.dwpsn	file "../bts_hal.c",line 70,column 5,is_stmt,isa 0
$C$DW$128	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$128, DW_AT_low_pc(0x00)
	.dwattr $C$DW$128, DW_AT_name("Interrupt_initVectorTable")
	.dwattr $C$DW$128, DW_AT_TI_call

        LCR       #||Interrupt_initVectorTable|| ; [CPU_ALU] |70| 
        ; call occurs [#||Interrupt_initVectorTable||] ; [] |70| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 327,column 5,is_stmt,isa 0
        MOVL      XAR6,#200000          ; [CPU_ARAU] |327| 
        MOVL      XAR7,#3074            ; [CPU_ARAU] |327| 
        MOV       AL,#11520             ; [CPU_ALU] |327| 
        MOV       AH,#305               ; [CPU_ALU] |327| 
        MOVL      XAR4,#2000000         ; [CPU_ARAU] |327| 
        MOVL      XAR5,#3082            ; [CPU_ARAU] |327| 
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
	.dwpsn	file "../bts_hal.c",line 112,column 5,is_stmt,isa 0
        MOVL      XAR5,#3072            ; [CPU_ARAU] |112| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 371,column 5,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |371| 
	.dwpsn	file "../bts_hal.c",line 112,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |112| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 372,column 5,is_stmt,isa 0
        MOVB      AH,#0                 ; [CPU_ALU] |372| 
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
	.dwpsn	file "../bts_hal.c",line 112,column 5,is_stmt,isa 0
        MOVL      ACC,XAR5              ; [CPU_ALU] |112| 
$C$DW$129	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$129, DW_AT_low_pc(0x00)
	.dwattr $C$DW$129, DW_AT_name("CPUTimer_setEmulationMode")
	.dwattr $C$DW$129, DW_AT_TI_call

        LCR       #||CPUTimer_setEmulationMode|| ; [CPU_ALU] |112| 
        ; call occurs [#||CPUTimer_setEmulationMode||] ; [] |112| 
	.dwpsn	file "../bts_hal.c",line 114,column 5,is_stmt,isa 0
        MOVL      XAR5,#3080            ; [CPU_ARAU] |114| 
        MOVB      XAR4,#0               ; [CPU_ALU] |114| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |114| 
$C$DW$130	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$130, DW_AT_low_pc(0x00)
	.dwattr $C$DW$130, DW_AT_name("CPUTimer_setEmulationMode")
	.dwattr $C$DW$130, DW_AT_TI_call

        LCR       #||CPUTimer_setEmulationMode|| ; [CPU_ALU] |114| 
        ; call occurs [#||CPUTimer_setEmulationMode||] ; [] |114| 
	.dwpsn	file "../bts_hal.c",line 116,column 5,is_stmt,isa 0
        MOVL      XAR5,#3088            ; [CPU_ARAU] |116| 
        MOVB      XAR4,#0               ; [CPU_ALU] |116| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |116| 
$C$DW$131	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$131, DW_AT_low_pc(0x00)
	.dwattr $C$DW$131, DW_AT_name("CPUTimer_setEmulationMode")
	.dwattr $C$DW$131, DW_AT_TI_call

        LCR       #||CPUTimer_setEmulationMode|| ; [CPU_ALU] |116| 
        ; call occurs [#||CPUTimer_setEmulationMode||] ; [] |116| 
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
$C$DW$132	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$132, DW_AT_low_pc(0x00)
	.dwattr $C$DW$132, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$124, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$124, DW_AT_TI_end_line(0x7d)
	.dwattr $C$DW$124, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$124

	.sect	".text"
	.clink
	.global	||BTS_HAL_enableEpwmCounting||

$C$DW$133	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$133, DW_AT_name("BTS_HAL_enableEpwmCounting")
	.dwattr $C$DW$133, DW_AT_low_pc(||BTS_HAL_enableEpwmCounting||)
	.dwattr $C$DW$133, DW_AT_high_pc(0x00)
	.dwattr $C$DW$133, DW_AT_linkage_name("BTS_HAL_enableEpwmCounting")
	.dwattr $C$DW$133, DW_AT_external
	.dwattr $C$DW$133, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$133, DW_AT_decl_line(0x1f7)
	.dwattr $C$DW$133, DW_AT_decl_column(0x06)
	.dwattr $C$DW$133, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 504,column 1,is_stmt,address ||BTS_HAL_enableEpwmCounting||,isa 0

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
$C$DW$134	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$134, DW_AT_low_pc(0x00)
	.dwattr $C$DW$134, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$133, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$133, DW_AT_TI_end_line(0x1fa)
	.dwattr $C$DW$133, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$133

	.sect	".text"
	.clink
	.global	||BTS_HAL_disableEpwmCounting||

$C$DW$135	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$135, DW_AT_name("BTS_HAL_disableEpwmCounting")
	.dwattr $C$DW$135, DW_AT_low_pc(||BTS_HAL_disableEpwmCounting||)
	.dwattr $C$DW$135, DW_AT_high_pc(0x00)
	.dwattr $C$DW$135, DW_AT_linkage_name("BTS_HAL_disableEpwmCounting")
	.dwattr $C$DW$135, DW_AT_external
	.dwattr $C$DW$135, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$135, DW_AT_decl_line(0x1fc)
	.dwattr $C$DW$135, DW_AT_decl_column(0x06)
	.dwattr $C$DW$135, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_hal.c",line 508,column 39,is_stmt,address ||BTS_HAL_disableEpwmCounting||,isa 0

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
$C$DW$136	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$136, DW_AT_low_pc(0x00)
	.dwattr $C$DW$136, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$135, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$135, DW_AT_TI_end_line(0x1ff)
	.dwattr $C$DW$135, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$135

	.sect	".text"
	.clink
	.global	||BTS_HAL_SetupSpiPinsGpio||

$C$DW$137	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$137, DW_AT_name("BTS_HAL_SetupSpiPinsGpio")
	.dwattr $C$DW$137, DW_AT_low_pc(||BTS_HAL_SetupSpiPinsGpio||)
	.dwattr $C$DW$137, DW_AT_high_pc(0x00)
	.dwattr $C$DW$137, DW_AT_linkage_name("BTS_HAL_SetupSpiPinsGpio")
	.dwattr $C$DW$137, DW_AT_external
	.dwattr $C$DW$137, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$137, DW_AT_decl_line(0x23b)
	.dwattr $C$DW$137, DW_AT_decl_column(0x06)
	.dwattr $C$DW$137, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts_hal.c",line 571,column 36,is_stmt,address ||BTS_HAL_SetupSpiPinsGpio||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_SetupSpiPinsGpio||

;***************************************************************
;* FNAME: BTS_HAL_SetupSpiPinsGpio      FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_SetupSpiPinsGpio||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts_hal.c",line 574,column 5,is_stmt,isa 0
        MOVB      ACC,#16               ; [CPU_ALU] |574| 
        MOVB      XAR4,#3               ; [CPU_ALU] |574| 
$C$DW$138	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$138, DW_AT_low_pc(0x00)
	.dwattr $C$DW$138, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$138, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |574| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |574| 
	.dwpsn	file "../bts_hal.c",line 575,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |575| 
        MOVB      ACC,#17               ; [CPU_ALU] |575| 
$C$DW$139	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$139, DW_AT_low_pc(0x00)
	.dwattr $C$DW$139, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$139, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |575| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |575| 
	.dwpsn	file "../bts_hal.c",line 576,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |576| 
        MOVB      ACC,#56               ; [CPU_ALU] |576| 
$C$DW$140	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$140, DW_AT_low_pc(0x00)
	.dwattr $C$DW$140, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$140, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |576| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |576| 
	.dwpsn	file "../bts_hal.c",line 577,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |577| 
        MOVB      ACC,#19               ; [CPU_ALU] |577| 
$C$DW$141	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$141, DW_AT_low_pc(0x00)
	.dwattr $C$DW$141, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$141, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |577| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |577| 
	.dwpsn	file "../bts_hal.c",line 578,column 5,is_stmt,isa 0
        MOVL      XAR4,#524289          ; [CPU_ARAU] |578| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |578| 
$C$DW$142	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$142, DW_AT_low_pc(0x00)
	.dwattr $C$DW$142, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$142, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |578| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |578| 
	.dwpsn	file "../bts_hal.c",line 579,column 5,is_stmt,isa 0
        MOVL      XAR4,#524801          ; [CPU_ARAU] |579| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |579| 
$C$DW$143	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$143, DW_AT_low_pc(0x00)
	.dwattr $C$DW$143, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$143, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |579| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |579| 
	.dwpsn	file "../bts_hal.c",line 580,column 5,is_stmt,isa 0
        MOV       AL,#4097              ; [CPU_ALU] |580| 
        MOV       AH,#72                ; [CPU_ALU] |580| 
$C$DW$144	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$144, DW_AT_low_pc(0x00)
	.dwattr $C$DW$144, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$144, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |580| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |580| 
	.dwpsn	file "../bts_hal.c",line 583,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |583| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |583| 
        MOVB      ACC,#57               ; [CPU_ALU] |583| 
$C$DW$145	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$145, DW_AT_low_pc(0x00)
	.dwattr $C$DW$145, DW_AT_name("GPIO_setPadConfig")
	.dwattr $C$DW$145, DW_AT_TI_call

        LCR       #||GPIO_setPadConfig|| ; [CPU_ALU] |583| 
        ; call occurs [#||GPIO_setPadConfig||] ; [] |583| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOV       ACC,#1024 << 15       ; [CPU_ALU] |472| 
        MOVL      XAR4,#32522           ; [CPU_ARAU] |472| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |472| 
	.dwpsn	file "../bts_hal.c",line 585,column 5,is_stmt,isa 0
        MOV       ACC,#9225 << 9        ; [CPU_ALU] |585| 
$C$DW$146	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$146, DW_AT_low_pc(0x00)
	.dwattr $C$DW$146, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$146, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |585| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |585| 
	.dwpsn	file "../bts_hal.c",line 586,column 5,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |586| 
        MOVB      ACC,#57               ; [CPU_ALU] |586| 
$C$DW$147	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$147, DW_AT_low_pc(0x00)
	.dwattr $C$DW$147, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$147, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |586| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |586| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$148	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$148, DW_AT_low_pc(0x00)
	.dwattr $C$DW$148, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$137, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$137, DW_AT_TI_end_line(0x24c)
	.dwattr $C$DW$137, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$137

	.sect	".text"
	.clink
	.global	||BTS_HAL_SetupSpi||

$C$DW$149	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$149, DW_AT_name("BTS_HAL_SetupSpi")
	.dwattr $C$DW$149, DW_AT_low_pc(||BTS_HAL_SetupSpi||)
	.dwattr $C$DW$149, DW_AT_high_pc(0x00)
	.dwattr $C$DW$149, DW_AT_linkage_name("BTS_HAL_SetupSpi")
	.dwattr $C$DW$149, DW_AT_external
	.dwattr $C$DW$149, DW_AT_decl_file("../bts_hal.c")
	.dwattr $C$DW$149, DW_AT_decl_line(0x219)
	.dwattr $C$DW$149, DW_AT_decl_column(0x06)
	.dwattr $C$DW$149, DW_AT_TI_max_frame_size(-8)
	.dwpsn	file "../bts_hal.c",line 538,column 1,is_stmt,address ||BTS_HAL_SetupSpi||,isa 0

	.dwfde $C$DW$CIE, ||BTS_HAL_SetupSpi||

;***************************************************************
;* FNAME: BTS_HAL_SetupSpi              FR SIZE:   6           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            5 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_HAL_SetupSpi||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#6                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -8
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 279,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6100)        ; [CPU_ALU] |279| 
        AND       AL,#0xff7f            ; [CPU_ALU] |279| 
	.dwpsn	file "../bts_hal.c",line 547,column 5,is_stmt,isa 0
        MOV       AH,#1525              ; [CPU_FPU] |547| 
        MOVL      XAR6,#24832           ; [CPU_ARAU] |547| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 279,column 5,is_stmt,isa 0
        MOV       *(0:0x6100),AL        ; [CPU_ALU] |279| 
	.dwpsn	file "../bts_hal.c",line 547,column 5,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |547| 
        MOVB      XAR5,#6               ; [CPU_ALU] |547| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 929,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6100)        ; [CPU_ALU] |929| 
        ORB       AL,#0x20              ; [CPU_ALU] |929| 
        MOV       *(0:0x6100),AL        ; [CPU_ALU] |929| 
	.dwpsn	file "../bts_hal.c",line 547,column 5,is_stmt,isa 0
        MOV       AL,#57600             ; [CPU_ALU] |547| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |547| 
        MOV       AL,#64402             ; [CPU_ALU] |547| 
        MOV       AH,#217               ; [CPU_ALU] |547| 
        MOVL      *-SP[4],ACC           ; [CPU_ALU] |547| 
        MOVB      *-SP[5],#16,UNC       ; [CPU_ALU] |547| 
        MOVL      ACC,XAR6              ; [CPU_ALU] |547| 
$C$DW$150	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$150, DW_AT_low_pc(0x00)
	.dwattr $C$DW$150, DW_AT_name("SPI_setConfig")
	.dwattr $C$DW$150, DW_AT_TI_call

        LCR       #||SPI_setConfig||    ; [CPU_ALU] |547| 
        ; call occurs [#||SPI_setConfig||] ; [] |547| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 991,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610f)        ; [CPU_ALU] |991| 
        AND       AL,#0xffcf            ; [CPU_ALU] |991| 
        MOV       *(0:0x610f),AL        ; [CPU_ALU] |991| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 304,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |304| 
        OR        AL,#0x6000            ; [CPU_ALU] |304| 
        MOV       *(0:0x610a),AL        ; [CPU_ALU] |304| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 305,column 5,is_stmt,isa 0
        MOV       AR6,*(0:0x610b)       ; [CPU_ALU] |305| 
	.dwpsn	file "../bts_hal.c",line 555,column 5,is_stmt,isa 0
        MOVB      ACC,#14               ; [CPU_ALU] |555| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 305,column 5,is_stmt,isa 0
        OR        AR6,#0x2000           ; [CPU_ALU] |305| 
	.dwpsn	file "../bts_hal.c",line 555,column 5,is_stmt,isa 0
        MOVL      XAR4,#24832           ; [CPU_ARAU] |555| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |555| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |555| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 305,column 5,is_stmt,isa 0
        MOV       *(0:0x610b),AR6       ; [CPU_ALU] |305| 
	.dwpsn	file "../bts_hal.c",line 555,column 5,is_stmt,isa 0
$C$DW$151	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$151, DW_AT_low_pc(0x00)
	.dwattr $C$DW$151, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$151, DW_AT_TI_call

        LCR       #||SPI_clearInterruptStatus|| ; [CPU_ALU] |555| 
        ; call occurs [#||SPI_clearInterruptStatus||] ; [] |555| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 418,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610a)        ; [CPU_ALU] |418| 
	.dwpsn	file "../bts_hal.c",line 559,column 5,is_stmt,isa 0
        MOVB      XAR6,#12              ; [CPU_ALU] |559| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 418,column 5,is_stmt,isa 0
        AND       AL,#0xffe0            ; [CPU_ALU] |418| 
	.dwpsn	file "../bts_hal.c",line 559,column 5,is_stmt,isa 0
        MOVL      XAR4,#24832           ; [CPU_ARAU] |559| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 418,column 5,is_stmt,isa 0
        MOV       *(0:0x610a),AL        ; [CPU_ALU] |418| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 420,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x610b)        ; [CPU_ALU] |420| 
	.dwpsn	file "../bts_hal.c",line 559,column 5,is_stmt,isa 0
        MOVL      *-SP[2],XAR6          ; [CPU_ALU] |559| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 420,column 5,is_stmt,isa 0
        AND       AL,AL,#0xffe0         ; [CPU_ALU] |420| 
        ORB       AL,#0x0a              ; [CPU_ALU] |420| 
        MOV       *(0:0x610b),AL        ; [CPU_ALU] |420| 
	.dwpsn	file "../bts_hal.c",line 559,column 5,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |559| 
$C$DW$152	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$152, DW_AT_low_pc(0x00)
	.dwattr $C$DW$152, DW_AT_name("SPI_enableInterrupt")
	.dwattr $C$DW$152, DW_AT_TI_call

        LCR       #||SPI_enableInterrupt|| ; [CPU_ALU] |559| 
        ; call occurs [#||SPI_enableInterrupt||] ; [] |559| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h",line 256,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6100)        ; [CPU_ALU] |256| 
        ORB       AL,#0x80              ; [CPU_ALU] |256| 
        MOV       *(0:0x6100),AL        ; [CPU_ALU] |256| 
        SUBB      SP,#6                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$153	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$153, DW_AT_low_pc(0x00)
	.dwattr $C$DW$153, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$149, DW_AT_TI_end_file("../bts_hal.c")
	.dwattr $C$DW$149, DW_AT_TI_end_line(0x239)
	.dwattr $C$DW$149, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$149

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
	.global	||Interrupt_enable||
	.global	||SPI_clearInterruptStatus||
	.global	||ISR1||
	.global	||ISR2||
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
$C$DW$154	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$154, DW_AT_name("SYSCTL_PERIPH_CLK_CLA1")
	.dwattr $C$DW$154, DW_AT_const_value(0x00)
	.dwattr $C$DW$154, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$154, DW_AT_decl_line(0x152)
	.dwattr $C$DW$154, DW_AT_decl_column(0x05)

$C$DW$155	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$155, DW_AT_name("SYSCTL_PERIPH_CLK_DMA")
	.dwattr $C$DW$155, DW_AT_const_value(0x200)
	.dwattr $C$DW$155, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$155, DW_AT_decl_line(0x153)
	.dwattr $C$DW$155, DW_AT_decl_column(0x05)

$C$DW$156	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$156, DW_AT_name("SYSCTL_PERIPH_CLK_TIMER0")
	.dwattr $C$DW$156, DW_AT_const_value(0x300)
	.dwattr $C$DW$156, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$156, DW_AT_decl_line(0x154)
	.dwattr $C$DW$156, DW_AT_decl_column(0x05)

$C$DW$157	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$157, DW_AT_name("SYSCTL_PERIPH_CLK_TIMER1")
	.dwattr $C$DW$157, DW_AT_const_value(0x400)
	.dwattr $C$DW$157, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$157, DW_AT_decl_line(0x155)
	.dwattr $C$DW$157, DW_AT_decl_column(0x05)

$C$DW$158	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$158, DW_AT_name("SYSCTL_PERIPH_CLK_TIMER2")
	.dwattr $C$DW$158, DW_AT_const_value(0x500)
	.dwattr $C$DW$158, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$158, DW_AT_decl_line(0x156)
	.dwattr $C$DW$158, DW_AT_decl_column(0x05)

$C$DW$159	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$159, DW_AT_name("SYSCTL_PERIPH_CLK_HRPWM")
	.dwattr $C$DW$159, DW_AT_const_value(0x1000)
	.dwattr $C$DW$159, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$159, DW_AT_decl_line(0x157)
	.dwattr $C$DW$159, DW_AT_decl_column(0x05)

$C$DW$160	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$160, DW_AT_name("SYSCTL_PERIPH_CLK_TBCLKSYNC")
	.dwattr $C$DW$160, DW_AT_const_value(0x1200)
	.dwattr $C$DW$160, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$160, DW_AT_decl_line(0x158)
	.dwattr $C$DW$160, DW_AT_decl_column(0x05)

$C$DW$161	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$161, DW_AT_name("SYSCTL_PERIPH_CLK_GTBCLKSYNC")
	.dwattr $C$DW$161, DW_AT_const_value(0x1300)
	.dwattr $C$DW$161, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$161, DW_AT_decl_line(0x159)
	.dwattr $C$DW$161, DW_AT_decl_column(0x05)

$C$DW$162	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$162, DW_AT_name("SYSCTL_PERIPH_CLK_EMIF1")
	.dwattr $C$DW$162, DW_AT_const_value(0x01)
	.dwattr $C$DW$162, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$162, DW_AT_decl_line(0x15a)
	.dwattr $C$DW$162, DW_AT_decl_column(0x05)

$C$DW$163	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$163, DW_AT_name("SYSCTL_PERIPH_CLK_EMIF2")
	.dwattr $C$DW$163, DW_AT_const_value(0x101)
	.dwattr $C$DW$163, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$163, DW_AT_decl_line(0x15b)
	.dwattr $C$DW$163, DW_AT_decl_column(0x05)

$C$DW$164	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$164, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM1")
	.dwattr $C$DW$164, DW_AT_const_value(0x02)
	.dwattr $C$DW$164, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$164, DW_AT_decl_line(0x15c)
	.dwattr $C$DW$164, DW_AT_decl_column(0x05)

$C$DW$165	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$165, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM2")
	.dwattr $C$DW$165, DW_AT_const_value(0x102)
	.dwattr $C$DW$165, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$165, DW_AT_decl_line(0x15d)
	.dwattr $C$DW$165, DW_AT_decl_column(0x05)

$C$DW$166	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$166, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM3")
	.dwattr $C$DW$166, DW_AT_const_value(0x202)
	.dwattr $C$DW$166, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$166, DW_AT_decl_line(0x15e)
	.dwattr $C$DW$166, DW_AT_decl_column(0x05)

$C$DW$167	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$167, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM4")
	.dwattr $C$DW$167, DW_AT_const_value(0x302)
	.dwattr $C$DW$167, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$167, DW_AT_decl_line(0x15f)
	.dwattr $C$DW$167, DW_AT_decl_column(0x05)

$C$DW$168	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$168, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM5")
	.dwattr $C$DW$168, DW_AT_const_value(0x402)
	.dwattr $C$DW$168, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$168, DW_AT_decl_line(0x160)
	.dwattr $C$DW$168, DW_AT_decl_column(0x05)

$C$DW$169	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$169, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM6")
	.dwattr $C$DW$169, DW_AT_const_value(0x502)
	.dwattr $C$DW$169, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$169, DW_AT_decl_line(0x161)
	.dwattr $C$DW$169, DW_AT_decl_column(0x05)

$C$DW$170	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$170, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM7")
	.dwattr $C$DW$170, DW_AT_const_value(0x602)
	.dwattr $C$DW$170, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$170, DW_AT_decl_line(0x162)
	.dwattr $C$DW$170, DW_AT_decl_column(0x05)

$C$DW$171	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$171, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM8")
	.dwattr $C$DW$171, DW_AT_const_value(0x702)
	.dwattr $C$DW$171, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$171, DW_AT_decl_line(0x163)
	.dwattr $C$DW$171, DW_AT_decl_column(0x05)

$C$DW$172	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$172, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM9")
	.dwattr $C$DW$172, DW_AT_const_value(0x802)
	.dwattr $C$DW$172, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$172, DW_AT_decl_line(0x164)
	.dwattr $C$DW$172, DW_AT_decl_column(0x05)

$C$DW$173	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$173, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM10")
	.dwattr $C$DW$173, DW_AT_const_value(0x902)
	.dwattr $C$DW$173, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$173, DW_AT_decl_line(0x165)
	.dwattr $C$DW$173, DW_AT_decl_column(0x05)

$C$DW$174	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$174, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM11")
	.dwattr $C$DW$174, DW_AT_const_value(0xa02)
	.dwattr $C$DW$174, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$174, DW_AT_decl_line(0x166)
	.dwattr $C$DW$174, DW_AT_decl_column(0x05)

$C$DW$175	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$175, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM12")
	.dwattr $C$DW$175, DW_AT_const_value(0xb02)
	.dwattr $C$DW$175, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$175, DW_AT_decl_line(0x167)
	.dwattr $C$DW$175, DW_AT_decl_column(0x05)

$C$DW$176	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$176, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP1")
	.dwattr $C$DW$176, DW_AT_const_value(0x03)
	.dwattr $C$DW$176, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$176, DW_AT_decl_line(0x168)
	.dwattr $C$DW$176, DW_AT_decl_column(0x05)

$C$DW$177	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$177, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP2")
	.dwattr $C$DW$177, DW_AT_const_value(0x103)
	.dwattr $C$DW$177, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$177, DW_AT_decl_line(0x169)
	.dwattr $C$DW$177, DW_AT_decl_column(0x05)

$C$DW$178	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$178, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP3")
	.dwattr $C$DW$178, DW_AT_const_value(0x203)
	.dwattr $C$DW$178, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$178, DW_AT_decl_line(0x16a)
	.dwattr $C$DW$178, DW_AT_decl_column(0x05)

$C$DW$179	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$179, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP4")
	.dwattr $C$DW$179, DW_AT_const_value(0x303)
	.dwattr $C$DW$179, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$179, DW_AT_decl_line(0x16b)
	.dwattr $C$DW$179, DW_AT_decl_column(0x05)

$C$DW$180	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$180, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP5")
	.dwattr $C$DW$180, DW_AT_const_value(0x403)
	.dwattr $C$DW$180, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$180, DW_AT_decl_line(0x16c)
	.dwattr $C$DW$180, DW_AT_decl_column(0x05)

$C$DW$181	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$181, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP6")
	.dwattr $C$DW$181, DW_AT_const_value(0x503)
	.dwattr $C$DW$181, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$181, DW_AT_decl_line(0x16d)
	.dwattr $C$DW$181, DW_AT_decl_column(0x05)

$C$DW$182	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$182, DW_AT_name("SYSCTL_PERIPH_CLK_EQEP1")
	.dwattr $C$DW$182, DW_AT_const_value(0x04)
	.dwattr $C$DW$182, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$182, DW_AT_decl_line(0x16e)
	.dwattr $C$DW$182, DW_AT_decl_column(0x05)

$C$DW$183	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$183, DW_AT_name("SYSCTL_PERIPH_CLK_EQEP2")
	.dwattr $C$DW$183, DW_AT_const_value(0x104)
	.dwattr $C$DW$183, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$183, DW_AT_decl_line(0x16f)
	.dwattr $C$DW$183, DW_AT_decl_column(0x05)

$C$DW$184	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$184, DW_AT_name("SYSCTL_PERIPH_CLK_EQEP3")
	.dwattr $C$DW$184, DW_AT_const_value(0x204)
	.dwattr $C$DW$184, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$184, DW_AT_decl_line(0x170)
	.dwattr $C$DW$184, DW_AT_decl_column(0x05)

$C$DW$185	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$185, DW_AT_name("SYSCTL_PERIPH_CLK_SD1")
	.dwattr $C$DW$185, DW_AT_const_value(0x06)
	.dwattr $C$DW$185, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$185, DW_AT_decl_line(0x171)
	.dwattr $C$DW$185, DW_AT_decl_column(0x05)

$C$DW$186	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$186, DW_AT_name("SYSCTL_PERIPH_CLK_SD2")
	.dwattr $C$DW$186, DW_AT_const_value(0x106)
	.dwattr $C$DW$186, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$186, DW_AT_decl_line(0x172)
	.dwattr $C$DW$186, DW_AT_decl_column(0x05)

$C$DW$187	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$187, DW_AT_name("SYSCTL_PERIPH_CLK_SCIA")
	.dwattr $C$DW$187, DW_AT_const_value(0x07)
	.dwattr $C$DW$187, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$187, DW_AT_decl_line(0x173)
	.dwattr $C$DW$187, DW_AT_decl_column(0x05)

$C$DW$188	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$188, DW_AT_name("SYSCTL_PERIPH_CLK_SCIB")
	.dwattr $C$DW$188, DW_AT_const_value(0x107)
	.dwattr $C$DW$188, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$188, DW_AT_decl_line(0x174)
	.dwattr $C$DW$188, DW_AT_decl_column(0x05)

$C$DW$189	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$189, DW_AT_name("SYSCTL_PERIPH_CLK_SCIC")
	.dwattr $C$DW$189, DW_AT_const_value(0x207)
	.dwattr $C$DW$189, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$189, DW_AT_decl_line(0x175)
	.dwattr $C$DW$189, DW_AT_decl_column(0x05)

$C$DW$190	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$190, DW_AT_name("SYSCTL_PERIPH_CLK_SCID")
	.dwattr $C$DW$190, DW_AT_const_value(0x307)
	.dwattr $C$DW$190, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$190, DW_AT_decl_line(0x176)
	.dwattr $C$DW$190, DW_AT_decl_column(0x05)

$C$DW$191	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$191, DW_AT_name("SYSCTL_PERIPH_CLK_SPIA")
	.dwattr $C$DW$191, DW_AT_const_value(0x08)
	.dwattr $C$DW$191, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$191, DW_AT_decl_line(0x177)
	.dwattr $C$DW$191, DW_AT_decl_column(0x05)

$C$DW$192	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$192, DW_AT_name("SYSCTL_PERIPH_CLK_SPIB")
	.dwattr $C$DW$192, DW_AT_const_value(0x108)
	.dwattr $C$DW$192, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$192, DW_AT_decl_line(0x178)
	.dwattr $C$DW$192, DW_AT_decl_column(0x05)

$C$DW$193	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$193, DW_AT_name("SYSCTL_PERIPH_CLK_SPIC")
	.dwattr $C$DW$193, DW_AT_const_value(0x208)
	.dwattr $C$DW$193, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$193, DW_AT_decl_line(0x179)
	.dwattr $C$DW$193, DW_AT_decl_column(0x05)

$C$DW$194	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$194, DW_AT_name("SYSCTL_PERIPH_CLK_I2CA")
	.dwattr $C$DW$194, DW_AT_const_value(0x09)
	.dwattr $C$DW$194, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$194, DW_AT_decl_line(0x17a)
	.dwattr $C$DW$194, DW_AT_decl_column(0x05)

$C$DW$195	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$195, DW_AT_name("SYSCTL_PERIPH_CLK_I2CB")
	.dwattr $C$DW$195, DW_AT_const_value(0x109)
	.dwattr $C$DW$195, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$195, DW_AT_decl_line(0x17b)
	.dwattr $C$DW$195, DW_AT_decl_column(0x05)

$C$DW$196	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$196, DW_AT_name("SYSCTL_PERIPH_CLK_CANA")
	.dwattr $C$DW$196, DW_AT_const_value(0x0a)
	.dwattr $C$DW$196, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$196, DW_AT_decl_line(0x17c)
	.dwattr $C$DW$196, DW_AT_decl_column(0x05)

$C$DW$197	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$197, DW_AT_name("SYSCTL_PERIPH_CLK_CANB")
	.dwattr $C$DW$197, DW_AT_const_value(0x10a)
	.dwattr $C$DW$197, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$197, DW_AT_decl_line(0x17d)
	.dwattr $C$DW$197, DW_AT_decl_column(0x05)

$C$DW$198	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$198, DW_AT_name("SYSCTL_PERIPH_CLK_MCBSPA")
	.dwattr $C$DW$198, DW_AT_const_value(0x0b)
	.dwattr $C$DW$198, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$198, DW_AT_decl_line(0x17e)
	.dwattr $C$DW$198, DW_AT_decl_column(0x05)

$C$DW$199	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$199, DW_AT_name("SYSCTL_PERIPH_CLK_MCBSPB")
	.dwattr $C$DW$199, DW_AT_const_value(0x10b)
	.dwattr $C$DW$199, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$199, DW_AT_decl_line(0x17f)
	.dwattr $C$DW$199, DW_AT_decl_column(0x05)

$C$DW$200	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$200, DW_AT_name("SYSCTL_PERIPH_CLK_USBA")
	.dwattr $C$DW$200, DW_AT_const_value(0x100b)
	.dwattr $C$DW$200, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$200, DW_AT_decl_line(0x180)
	.dwattr $C$DW$200, DW_AT_decl_column(0x05)

$C$DW$201	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$201, DW_AT_name("SYSCTL_PERIPH_CLK_UPPA")
	.dwattr $C$DW$201, DW_AT_const_value(0x0c)
	.dwattr $C$DW$201, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$201, DW_AT_decl_line(0x181)
	.dwattr $C$DW$201, DW_AT_decl_column(0x05)

$C$DW$202	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$202, DW_AT_name("SYSCTL_PERIPH_CLK_ADCA")
	.dwattr $C$DW$202, DW_AT_const_value(0x0d)
	.dwattr $C$DW$202, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$202, DW_AT_decl_line(0x182)
	.dwattr $C$DW$202, DW_AT_decl_column(0x05)

$C$DW$203	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$203, DW_AT_name("SYSCTL_PERIPH_CLK_ADCB")
	.dwattr $C$DW$203, DW_AT_const_value(0x10d)
	.dwattr $C$DW$203, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$203, DW_AT_decl_line(0x183)
	.dwattr $C$DW$203, DW_AT_decl_column(0x05)

$C$DW$204	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$204, DW_AT_name("SYSCTL_PERIPH_CLK_ADCC")
	.dwattr $C$DW$204, DW_AT_const_value(0x20d)
	.dwattr $C$DW$204, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$204, DW_AT_decl_line(0x184)
	.dwattr $C$DW$204, DW_AT_decl_column(0x05)

$C$DW$205	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$205, DW_AT_name("SYSCTL_PERIPH_CLK_ADCD")
	.dwattr $C$DW$205, DW_AT_const_value(0x30d)
	.dwattr $C$DW$205, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$205, DW_AT_decl_line(0x185)
	.dwattr $C$DW$205, DW_AT_decl_column(0x05)

$C$DW$206	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$206, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS1")
	.dwattr $C$DW$206, DW_AT_const_value(0x0e)
	.dwattr $C$DW$206, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$206, DW_AT_decl_line(0x186)
	.dwattr $C$DW$206, DW_AT_decl_column(0x05)

$C$DW$207	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$207, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS2")
	.dwattr $C$DW$207, DW_AT_const_value(0x10e)
	.dwattr $C$DW$207, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$207, DW_AT_decl_line(0x187)
	.dwattr $C$DW$207, DW_AT_decl_column(0x05)

$C$DW$208	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$208, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS3")
	.dwattr $C$DW$208, DW_AT_const_value(0x20e)
	.dwattr $C$DW$208, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$208, DW_AT_decl_line(0x188)
	.dwattr $C$DW$208, DW_AT_decl_column(0x05)

$C$DW$209	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$209, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS4")
	.dwattr $C$DW$209, DW_AT_const_value(0x30e)
	.dwattr $C$DW$209, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$209, DW_AT_decl_line(0x189)
	.dwattr $C$DW$209, DW_AT_decl_column(0x05)

$C$DW$210	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$210, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS5")
	.dwattr $C$DW$210, DW_AT_const_value(0x40e)
	.dwattr $C$DW$210, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$210, DW_AT_decl_line(0x18a)
	.dwattr $C$DW$210, DW_AT_decl_column(0x05)

$C$DW$211	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$211, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS6")
	.dwattr $C$DW$211, DW_AT_const_value(0x50e)
	.dwattr $C$DW$211, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$211, DW_AT_decl_line(0x18b)
	.dwattr $C$DW$211, DW_AT_decl_column(0x05)

$C$DW$212	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$212, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS7")
	.dwattr $C$DW$212, DW_AT_const_value(0x60e)
	.dwattr $C$DW$212, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$212, DW_AT_decl_line(0x18c)
	.dwattr $C$DW$212, DW_AT_decl_column(0x05)

$C$DW$213	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$213, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS8")
	.dwattr $C$DW$213, DW_AT_const_value(0x70e)
	.dwattr $C$DW$213, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$213, DW_AT_decl_line(0x18d)
	.dwattr $C$DW$213, DW_AT_decl_column(0x05)

$C$DW$214	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$214, DW_AT_name("SYSCTL_PERIPH_CLK_DACA")
	.dwattr $C$DW$214, DW_AT_const_value(0x1010)
	.dwattr $C$DW$214, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$214, DW_AT_decl_line(0x18e)
	.dwattr $C$DW$214, DW_AT_decl_column(0x05)

$C$DW$215	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$215, DW_AT_name("SYSCTL_PERIPH_CLK_DACB")
	.dwattr $C$DW$215, DW_AT_const_value(0x1110)
	.dwattr $C$DW$215, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$215, DW_AT_decl_line(0x18f)
	.dwattr $C$DW$215, DW_AT_decl_column(0x05)

$C$DW$216	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$216, DW_AT_name("SYSCTL_PERIPH_CLK_DACC")
	.dwattr $C$DW$216, DW_AT_const_value(0x1210)
	.dwattr $C$DW$216, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$216, DW_AT_decl_line(0x190)
	.dwattr $C$DW$216, DW_AT_decl_column(0x05)

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
$C$DW$217	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$217, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_1")
	.dwattr $C$DW$217, DW_AT_const_value(0x00)
	.dwattr $C$DW$217, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$217, DW_AT_decl_line(0x22b)
	.dwattr $C$DW$217, DW_AT_decl_column(0x05)

$C$DW$218	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$218, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_2")
	.dwattr $C$DW$218, DW_AT_const_value(0x01)
	.dwattr $C$DW$218, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$218, DW_AT_decl_line(0x22c)
	.dwattr $C$DW$218, DW_AT_decl_column(0x05)

$C$DW$219	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$219, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_4")
	.dwattr $C$DW$219, DW_AT_const_value(0x02)
	.dwattr $C$DW$219, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$219, DW_AT_decl_line(0x22d)
	.dwattr $C$DW$219, DW_AT_decl_column(0x05)

$C$DW$220	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$220, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_6")
	.dwattr $C$DW$220, DW_AT_const_value(0x03)
	.dwattr $C$DW$220, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$220, DW_AT_decl_line(0x22e)
	.dwattr $C$DW$220, DW_AT_decl_column(0x05)

$C$DW$221	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$221, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_8")
	.dwattr $C$DW$221, DW_AT_const_value(0x04)
	.dwattr $C$DW$221, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$221, DW_AT_decl_line(0x22f)
	.dwattr $C$DW$221, DW_AT_decl_column(0x05)

$C$DW$222	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$222, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_10")
	.dwattr $C$DW$222, DW_AT_const_value(0x05)
	.dwattr $C$DW$222, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$222, DW_AT_decl_line(0x230)
	.dwattr $C$DW$222, DW_AT_decl_column(0x05)

$C$DW$223	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$223, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_12")
	.dwattr $C$DW$223, DW_AT_const_value(0x06)
	.dwattr $C$DW$223, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$223, DW_AT_decl_line(0x231)
	.dwattr $C$DW$223, DW_AT_decl_column(0x05)

$C$DW$224	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$224, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_14")
	.dwattr $C$DW$224, DW_AT_const_value(0x07)
	.dwattr $C$DW$224, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$224, DW_AT_decl_line(0x232)
	.dwattr $C$DW$224, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$28, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$28, DW_AT_decl_line(0x22a)
	.dwattr $C$DW$T$28, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$28

	.dwendtag $C$DW$TU$28


$C$DW$TU$29	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$29
$C$DW$T$29	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$29, DW_AT_name("SysCtl_LSPCLKPrescaler")
	.dwattr $C$DW$T$29, DW_AT_type(*$C$DW$T$28)
	.dwattr $C$DW$T$29, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$29, DW_AT_decl_line(0x233)
	.dwattr $C$DW$T$29, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$29


$C$DW$TU$30	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$30

$C$DW$T$30	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$30, DW_AT_byte_size(0x01)
$C$DW$225	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$225, DW_AT_name("CPUTIMER_EMULATIONMODE_STOPAFTERNEXTDECREMENT")
	.dwattr $C$DW$225, DW_AT_const_value(0x00)
	.dwattr $C$DW$225, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h")
	.dwattr $C$DW$225, DW_AT_decl_line(0x58)
	.dwattr $C$DW$225, DW_AT_decl_column(0x03)

$C$DW$226	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$226, DW_AT_name("CPUTIMER_EMULATIONMODE_STOPATZERO")
	.dwattr $C$DW$226, DW_AT_const_value(0x400)
	.dwattr $C$DW$226, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h")
	.dwattr $C$DW$226, DW_AT_decl_line(0x5a)
	.dwattr $C$DW$226, DW_AT_decl_column(0x03)

$C$DW$227	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$227, DW_AT_name("CPUTIMER_EMULATIONMODE_RUNFREE")
	.dwattr $C$DW$227, DW_AT_const_value(0x800)
	.dwattr $C$DW$227, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h")
	.dwattr $C$DW$227, DW_AT_decl_line(0x5c)
	.dwattr $C$DW$227, DW_AT_decl_column(0x03)

	.dwattr $C$DW$T$30, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h")
	.dwattr $C$DW$T$30, DW_AT_decl_line(0x56)
	.dwattr $C$DW$T$30, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$30

	.dwendtag $C$DW$TU$30


$C$DW$TU$31	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$31
$C$DW$T$31	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$31, DW_AT_name("CPUTimer_EmulationMode")
	.dwattr $C$DW$T$31, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$T$31, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h")
	.dwattr $C$DW$T$31, DW_AT_decl_line(0x5d)
	.dwattr $C$DW$T$31, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$31


$C$DW$TU$32	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$32

$C$DW$T$32	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$32, DW_AT_byte_size(0x01)
$C$DW$228	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$228, DW_AT_name("EPWM_CLOCK_DIVIDER_1")
	.dwattr $C$DW$228, DW_AT_const_value(0x00)
	.dwattr $C$DW$228, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$228, DW_AT_decl_line(0x6f)
	.dwattr $C$DW$228, DW_AT_decl_column(0x05)

$C$DW$229	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$229, DW_AT_name("EPWM_CLOCK_DIVIDER_2")
	.dwattr $C$DW$229, DW_AT_const_value(0x01)
	.dwattr $C$DW$229, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$229, DW_AT_decl_line(0x70)
	.dwattr $C$DW$229, DW_AT_decl_column(0x05)

$C$DW$230	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$230, DW_AT_name("EPWM_CLOCK_DIVIDER_4")
	.dwattr $C$DW$230, DW_AT_const_value(0x02)
	.dwattr $C$DW$230, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$230, DW_AT_decl_line(0x71)
	.dwattr $C$DW$230, DW_AT_decl_column(0x05)

$C$DW$231	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$231, DW_AT_name("EPWM_CLOCK_DIVIDER_8")
	.dwattr $C$DW$231, DW_AT_const_value(0x03)
	.dwattr $C$DW$231, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$231, DW_AT_decl_line(0x72)
	.dwattr $C$DW$231, DW_AT_decl_column(0x05)

$C$DW$232	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$232, DW_AT_name("EPWM_CLOCK_DIVIDER_16")
	.dwattr $C$DW$232, DW_AT_const_value(0x04)
	.dwattr $C$DW$232, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$232, DW_AT_decl_line(0x73)
	.dwattr $C$DW$232, DW_AT_decl_column(0x05)

$C$DW$233	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$233, DW_AT_name("EPWM_CLOCK_DIVIDER_32")
	.dwattr $C$DW$233, DW_AT_const_value(0x05)
	.dwattr $C$DW$233, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$233, DW_AT_decl_line(0x74)
	.dwattr $C$DW$233, DW_AT_decl_column(0x05)

$C$DW$234	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$234, DW_AT_name("EPWM_CLOCK_DIVIDER_64")
	.dwattr $C$DW$234, DW_AT_const_value(0x06)
	.dwattr $C$DW$234, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$234, DW_AT_decl_line(0x75)
	.dwattr $C$DW$234, DW_AT_decl_column(0x05)

$C$DW$235	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$235, DW_AT_name("EPWM_CLOCK_DIVIDER_128")
	.dwattr $C$DW$235, DW_AT_const_value(0x07)
	.dwattr $C$DW$235, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$235, DW_AT_decl_line(0x76)
	.dwattr $C$DW$235, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$32, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$32, DW_AT_decl_line(0x6e)
	.dwattr $C$DW$T$32, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$32

	.dwendtag $C$DW$TU$32


$C$DW$TU$33	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$33
$C$DW$T$33	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$33, DW_AT_name("EPWM_ClockDivider")
	.dwattr $C$DW$T$33, DW_AT_type(*$C$DW$T$32)
	.dwattr $C$DW$T$33, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$33, DW_AT_decl_line(0x77)
	.dwattr $C$DW$T$33, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$33


$C$DW$TU$34	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$34

$C$DW$T$34	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$34, DW_AT_byte_size(0x01)
$C$DW$236	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$236, DW_AT_name("EPWM_HSCLOCK_DIVIDER_1")
	.dwattr $C$DW$236, DW_AT_const_value(0x00)
	.dwattr $C$DW$236, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$236, DW_AT_decl_line(0x81)
	.dwattr $C$DW$236, DW_AT_decl_column(0x05)

$C$DW$237	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$237, DW_AT_name("EPWM_HSCLOCK_DIVIDER_2")
	.dwattr $C$DW$237, DW_AT_const_value(0x01)
	.dwattr $C$DW$237, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$237, DW_AT_decl_line(0x82)
	.dwattr $C$DW$237, DW_AT_decl_column(0x05)

$C$DW$238	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$238, DW_AT_name("EPWM_HSCLOCK_DIVIDER_4")
	.dwattr $C$DW$238, DW_AT_const_value(0x02)
	.dwattr $C$DW$238, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$238, DW_AT_decl_line(0x83)
	.dwattr $C$DW$238, DW_AT_decl_column(0x05)

$C$DW$239	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$239, DW_AT_name("EPWM_HSCLOCK_DIVIDER_6")
	.dwattr $C$DW$239, DW_AT_const_value(0x03)
	.dwattr $C$DW$239, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$239, DW_AT_decl_line(0x84)
	.dwattr $C$DW$239, DW_AT_decl_column(0x05)

$C$DW$240	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$240, DW_AT_name("EPWM_HSCLOCK_DIVIDER_8")
	.dwattr $C$DW$240, DW_AT_const_value(0x04)
	.dwattr $C$DW$240, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$240, DW_AT_decl_line(0x85)
	.dwattr $C$DW$240, DW_AT_decl_column(0x05)

$C$DW$241	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$241, DW_AT_name("EPWM_HSCLOCK_DIVIDER_10")
	.dwattr $C$DW$241, DW_AT_const_value(0x05)
	.dwattr $C$DW$241, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$241, DW_AT_decl_line(0x86)
	.dwattr $C$DW$241, DW_AT_decl_column(0x05)

$C$DW$242	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$242, DW_AT_name("EPWM_HSCLOCK_DIVIDER_12")
	.dwattr $C$DW$242, DW_AT_const_value(0x06)
	.dwattr $C$DW$242, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$242, DW_AT_decl_line(0x87)
	.dwattr $C$DW$242, DW_AT_decl_column(0x05)

$C$DW$243	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$243, DW_AT_name("EPWM_HSCLOCK_DIVIDER_14")
	.dwattr $C$DW$243, DW_AT_const_value(0x07)
	.dwattr $C$DW$243, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$243, DW_AT_decl_line(0x88)
	.dwattr $C$DW$243, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$34, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$34, DW_AT_decl_line(0x80)
	.dwattr $C$DW$T$34, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$34

	.dwendtag $C$DW$TU$34


$C$DW$TU$35	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$35
$C$DW$T$35	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$35, DW_AT_name("EPWM_HSClockDivider")
	.dwattr $C$DW$T$35, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$T$35, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$35, DW_AT_decl_line(0x89)
	.dwattr $C$DW$T$35, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$35


$C$DW$TU$36	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$36

$C$DW$T$36	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$36, DW_AT_byte_size(0x01)
$C$DW$244	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$244, DW_AT_name("EPWM_PERIOD_SHADOW_LOAD")
	.dwattr $C$DW$244, DW_AT_const_value(0x00)
	.dwattr $C$DW$244, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$244, DW_AT_decl_line(0xac)
	.dwattr $C$DW$244, DW_AT_decl_column(0x05)

$C$DW$245	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$245, DW_AT_name("EPWM_PERIOD_DIRECT_LOAD")
	.dwattr $C$DW$245, DW_AT_const_value(0x01)
	.dwattr $C$DW$245, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$245, DW_AT_decl_line(0xae)
	.dwattr $C$DW$245, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$36, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$36, DW_AT_decl_line(0xaa)
	.dwattr $C$DW$T$36, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$36

	.dwendtag $C$DW$TU$36


$C$DW$TU$37	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$37
$C$DW$T$37	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$37, DW_AT_name("EPWM_PeriodLoadMode")
	.dwattr $C$DW$T$37, DW_AT_type(*$C$DW$T$36)
	.dwattr $C$DW$T$37, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$37, DW_AT_decl_line(0xaf)
	.dwattr $C$DW$T$37, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$37


$C$DW$TU$38	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$38

$C$DW$T$38	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$38, DW_AT_byte_size(0x01)
$C$DW$246	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$246, DW_AT_name("EPWM_COUNTER_MODE_UP")
	.dwattr $C$DW$246, DW_AT_const_value(0x00)
	.dwattr $C$DW$246, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$246, DW_AT_decl_line(0xb9)
	.dwattr $C$DW$246, DW_AT_decl_column(0x05)

$C$DW$247	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$247, DW_AT_name("EPWM_COUNTER_MODE_DOWN")
	.dwattr $C$DW$247, DW_AT_const_value(0x01)
	.dwattr $C$DW$247, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$247, DW_AT_decl_line(0xba)
	.dwattr $C$DW$247, DW_AT_decl_column(0x05)

$C$DW$248	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$248, DW_AT_name("EPWM_COUNTER_MODE_UP_DOWN")
	.dwattr $C$DW$248, DW_AT_const_value(0x02)
	.dwattr $C$DW$248, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$248, DW_AT_decl_line(0xbb)
	.dwattr $C$DW$248, DW_AT_decl_column(0x05)

$C$DW$249	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$249, DW_AT_name("EPWM_COUNTER_MODE_STOP_FREEZE")
	.dwattr $C$DW$249, DW_AT_const_value(0x03)
	.dwattr $C$DW$249, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$249, DW_AT_decl_line(0xbc)
	.dwattr $C$DW$249, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$38, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$38, DW_AT_decl_line(0xb8)
	.dwattr $C$DW$T$38, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$38

	.dwendtag $C$DW$TU$38


$C$DW$TU$39	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$39
$C$DW$T$39	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$39, DW_AT_name("EPWM_TimeBaseCountMode")
	.dwattr $C$DW$T$39, DW_AT_type(*$C$DW$T$38)
	.dwattr $C$DW$T$39, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$39, DW_AT_decl_line(0xbd)
	.dwattr $C$DW$T$39, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$39


$C$DW$TU$40	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$40

$C$DW$T$40	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$40, DW_AT_byte_size(0x01)
$C$DW$250	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$250, DW_AT_name("EPWM_COUNTER_COMPARE_A")
	.dwattr $C$DW$250, DW_AT_const_value(0x00)
	.dwattr $C$DW$250, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$250, DW_AT_decl_line(0x10f)
	.dwattr $C$DW$250, DW_AT_decl_column(0x05)

$C$DW$251	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$251, DW_AT_name("EPWM_COUNTER_COMPARE_B")
	.dwattr $C$DW$251, DW_AT_const_value(0x02)
	.dwattr $C$DW$251, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$251, DW_AT_decl_line(0x110)
	.dwattr $C$DW$251, DW_AT_decl_column(0x05)

$C$DW$252	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$252, DW_AT_name("EPWM_COUNTER_COMPARE_C")
	.dwattr $C$DW$252, DW_AT_const_value(0x05)
	.dwattr $C$DW$252, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$252, DW_AT_decl_line(0x111)
	.dwattr $C$DW$252, DW_AT_decl_column(0x05)

$C$DW$253	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$253, DW_AT_name("EPWM_COUNTER_COMPARE_D")
	.dwattr $C$DW$253, DW_AT_const_value(0x07)
	.dwattr $C$DW$253, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$253, DW_AT_decl_line(0x112)
	.dwattr $C$DW$253, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$40, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$40, DW_AT_decl_line(0x10e)
	.dwattr $C$DW$T$40, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$40

	.dwendtag $C$DW$TU$40


$C$DW$TU$41	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$41
$C$DW$T$41	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$41, DW_AT_name("EPWM_CounterCompareModule")
	.dwattr $C$DW$T$41, DW_AT_type(*$C$DW$T$40)
	.dwattr $C$DW$T$41, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$41, DW_AT_decl_line(0x113)
	.dwattr $C$DW$T$41, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$41


$C$DW$TU$42	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$42

$C$DW$T$42	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$42, DW_AT_byte_size(0x01)
$C$DW$254	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$254, DW_AT_name("EPWM_COMP_LOAD_ON_CNTR_ZERO")
	.dwattr $C$DW$254, DW_AT_const_value(0x00)
	.dwattr $C$DW$254, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$254, DW_AT_decl_line(0x11e)
	.dwattr $C$DW$254, DW_AT_decl_column(0x05)

$C$DW$255	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$255, DW_AT_name("EPWM_COMP_LOAD_ON_CNTR_PERIOD")
	.dwattr $C$DW$255, DW_AT_const_value(0x01)
	.dwattr $C$DW$255, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$255, DW_AT_decl_line(0x120)
	.dwattr $C$DW$255, DW_AT_decl_column(0x05)

$C$DW$256	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$256, DW_AT_name("EPWM_COMP_LOAD_ON_CNTR_ZERO_PERIOD")
	.dwattr $C$DW$256, DW_AT_const_value(0x02)
	.dwattr $C$DW$256, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$256, DW_AT_decl_line(0x122)
	.dwattr $C$DW$256, DW_AT_decl_column(0x05)

$C$DW$257	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$257, DW_AT_name("EPWM_COMP_LOAD_FREEZE")
	.dwattr $C$DW$257, DW_AT_const_value(0x03)
	.dwattr $C$DW$257, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$257, DW_AT_decl_line(0x124)
	.dwattr $C$DW$257, DW_AT_decl_column(0x05)

$C$DW$258	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$258, DW_AT_name("EPWM_COMP_LOAD_ON_SYNC_CNTR_ZERO")
	.dwattr $C$DW$258, DW_AT_const_value(0x04)
	.dwattr $C$DW$258, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$258, DW_AT_decl_line(0x126)
	.dwattr $C$DW$258, DW_AT_decl_column(0x05)

$C$DW$259	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$259, DW_AT_name("EPWM_COMP_LOAD_ON_SYNC_CNTR_PERIOD")
	.dwattr $C$DW$259, DW_AT_const_value(0x05)
	.dwattr $C$DW$259, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$259, DW_AT_decl_line(0x128)
	.dwattr $C$DW$259, DW_AT_decl_column(0x05)

$C$DW$260	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$260, DW_AT_name("EPWM_COMP_LOAD_ON_SYNC_CNTR_ZERO_PERIOD")
	.dwattr $C$DW$260, DW_AT_const_value(0x06)
	.dwattr $C$DW$260, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$260, DW_AT_decl_line(0x12a)
	.dwattr $C$DW$260, DW_AT_decl_column(0x05)

$C$DW$261	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$261, DW_AT_name("EPWM_COMP_LOAD_ON_SYNC_ONLY")
	.dwattr $C$DW$261, DW_AT_const_value(0x08)
	.dwattr $C$DW$261, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$261, DW_AT_decl_line(0x12c)
	.dwattr $C$DW$261, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$42, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$42, DW_AT_decl_line(0x11c)
	.dwattr $C$DW$T$42, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$42

	.dwendtag $C$DW$TU$42


$C$DW$TU$43	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$43
$C$DW$T$43	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$43, DW_AT_name("EPWM_CounterCompareLoadMode")
	.dwattr $C$DW$T$43, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$T$43, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$43, DW_AT_decl_line(0x12d)
	.dwattr $C$DW$T$43, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$43


$C$DW$TU$44	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$44

$C$DW$T$44	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$44, DW_AT_byte_size(0x01)
$C$DW$262	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$262, DW_AT_name("EPWM_ACTION_QUALIFIER_A")
	.dwattr $C$DW$262, DW_AT_const_value(0x00)
	.dwattr $C$DW$262, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$262, DW_AT_decl_line(0x13a)
	.dwattr $C$DW$262, DW_AT_decl_column(0x05)

$C$DW$263	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$263, DW_AT_name("EPWM_ACTION_QUALIFIER_B")
	.dwattr $C$DW$263, DW_AT_const_value(0x02)
	.dwattr $C$DW$263, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$263, DW_AT_decl_line(0x13b)
	.dwattr $C$DW$263, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$44, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$44, DW_AT_decl_line(0x139)
	.dwattr $C$DW$T$44, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$44

	.dwendtag $C$DW$TU$44


$C$DW$TU$45	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$45
$C$DW$T$45	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$45, DW_AT_name("EPWM_ActionQualifierModule")
	.dwattr $C$DW$T$45, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$T$45, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$45, DW_AT_decl_line(0x13c)
	.dwattr $C$DW$T$45, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$45


$C$DW$TU$46	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$46

$C$DW$T$46	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$46, DW_AT_byte_size(0x01)
$C$DW$264	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$264, DW_AT_name("EPWM_AQ_LOAD_ON_CNTR_ZERO")
	.dwattr $C$DW$264, DW_AT_const_value(0x00)
	.dwattr $C$DW$264, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$264, DW_AT_decl_line(0x147)
	.dwattr $C$DW$264, DW_AT_decl_column(0x05)

$C$DW$265	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$265, DW_AT_name("EPWM_AQ_LOAD_ON_CNTR_PERIOD")
	.dwattr $C$DW$265, DW_AT_const_value(0x01)
	.dwattr $C$DW$265, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$265, DW_AT_decl_line(0x149)
	.dwattr $C$DW$265, DW_AT_decl_column(0x05)

$C$DW$266	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$266, DW_AT_name("EPWM_AQ_LOAD_ON_CNTR_ZERO_PERIOD")
	.dwattr $C$DW$266, DW_AT_const_value(0x02)
	.dwattr $C$DW$266, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$266, DW_AT_decl_line(0x14b)
	.dwattr $C$DW$266, DW_AT_decl_column(0x05)

$C$DW$267	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$267, DW_AT_name("EPWM_AQ_LOAD_FREEZE")
	.dwattr $C$DW$267, DW_AT_const_value(0x03)
	.dwattr $C$DW$267, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$267, DW_AT_decl_line(0x14d)
	.dwattr $C$DW$267, DW_AT_decl_column(0x05)

$C$DW$268	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$268, DW_AT_name("EPWM_AQ_LOAD_ON_SYNC_CNTR_ZERO")
	.dwattr $C$DW$268, DW_AT_const_value(0x04)
	.dwattr $C$DW$268, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$268, DW_AT_decl_line(0x14f)
	.dwattr $C$DW$268, DW_AT_decl_column(0x05)

$C$DW$269	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$269, DW_AT_name("EPWM_AQ_LOAD_ON_SYNC_CNTR_PERIOD")
	.dwattr $C$DW$269, DW_AT_const_value(0x05)
	.dwattr $C$DW$269, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$269, DW_AT_decl_line(0x151)
	.dwattr $C$DW$269, DW_AT_decl_column(0x05)

$C$DW$270	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$270, DW_AT_name("EPWM_AQ_LOAD_ON_SYNC_CNTR_ZERO_PERIOD")
	.dwattr $C$DW$270, DW_AT_const_value(0x06)
	.dwattr $C$DW$270, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$270, DW_AT_decl_line(0x153)
	.dwattr $C$DW$270, DW_AT_decl_column(0x05)

$C$DW$271	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$271, DW_AT_name("EPWM_AQ_LOAD_ON_SYNC_ONLY")
	.dwattr $C$DW$271, DW_AT_const_value(0x08)
	.dwattr $C$DW$271, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$271, DW_AT_decl_line(0x155)
	.dwattr $C$DW$271, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$46, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$46, DW_AT_decl_line(0x145)
	.dwattr $C$DW$T$46, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$46

	.dwendtag $C$DW$TU$46


$C$DW$TU$47	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$47
$C$DW$T$47	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$47, DW_AT_name("EPWM_ActionQualifierLoadMode")
	.dwattr $C$DW$T$47, DW_AT_type(*$C$DW$T$46)
	.dwattr $C$DW$T$47, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$47, DW_AT_decl_line(0x156)
	.dwattr $C$DW$T$47, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$47


$C$DW$TU$48	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$48

$C$DW$T$48	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$48, DW_AT_byte_size(0x01)
$C$DW$272	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$272, DW_AT_name("EPWM_AQ_OUTPUT_A")
	.dwattr $C$DW$272, DW_AT_const_value(0x00)
	.dwattr $C$DW$272, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$272, DW_AT_decl_line(0x211)
	.dwattr $C$DW$272, DW_AT_decl_column(0x05)

$C$DW$273	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$273, DW_AT_name("EPWM_AQ_OUTPUT_B")
	.dwattr $C$DW$273, DW_AT_const_value(0x02)
	.dwattr $C$DW$273, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$273, DW_AT_decl_line(0x212)
	.dwattr $C$DW$273, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$48, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$48, DW_AT_decl_line(0x210)
	.dwattr $C$DW$T$48, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$48

	.dwendtag $C$DW$TU$48


$C$DW$TU$49	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$49
$C$DW$T$49	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$49, DW_AT_name("EPWM_ActionQualifierOutputModule")
	.dwattr $C$DW$T$49, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$T$49, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$49, DW_AT_decl_line(0x213)
	.dwattr $C$DW$T$49, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$49


$C$DW$TU$50	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$50

$C$DW$T$50	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$50, DW_AT_byte_size(0x01)
$C$DW$274	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$274, DW_AT_name("EPWM_AQ_OUTPUT_NO_CHANGE")
	.dwattr $C$DW$274, DW_AT_const_value(0x00)
	.dwattr $C$DW$274, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$274, DW_AT_decl_line(0x190)
	.dwattr $C$DW$274, DW_AT_decl_column(0x05)

$C$DW$275	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$275, DW_AT_name("EPWM_AQ_OUTPUT_LOW")
	.dwattr $C$DW$275, DW_AT_const_value(0x01)
	.dwattr $C$DW$275, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$275, DW_AT_decl_line(0x191)
	.dwattr $C$DW$275, DW_AT_decl_column(0x05)

$C$DW$276	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$276, DW_AT_name("EPWM_AQ_OUTPUT_HIGH")
	.dwattr $C$DW$276, DW_AT_const_value(0x02)
	.dwattr $C$DW$276, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$276, DW_AT_decl_line(0x192)
	.dwattr $C$DW$276, DW_AT_decl_column(0x05)

$C$DW$277	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$277, DW_AT_name("EPWM_AQ_OUTPUT_TOGGLE")
	.dwattr $C$DW$277, DW_AT_const_value(0x03)
	.dwattr $C$DW$277, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$277, DW_AT_decl_line(0x193)
	.dwattr $C$DW$277, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$50, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$50, DW_AT_decl_line(0x18f)
	.dwattr $C$DW$T$50, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$50

	.dwendtag $C$DW$TU$50


$C$DW$TU$51	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$51
$C$DW$T$51	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$51, DW_AT_name("EPWM_ActionQualifierOutput")
	.dwattr $C$DW$T$51, DW_AT_type(*$C$DW$T$50)
	.dwattr $C$DW$T$51, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$51, DW_AT_decl_line(0x194)
	.dwattr $C$DW$T$51, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$51


$C$DW$TU$52	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$52

$C$DW$T$52	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$52, DW_AT_byte_size(0x01)
$C$DW$278	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$278, DW_AT_name("EPWM_AQ_OUTPUT_ON_TIMEBASE_ZERO")
	.dwattr $C$DW$278, DW_AT_const_value(0x00)
	.dwattr $C$DW$278, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$278, DW_AT_decl_line(0x173)
	.dwattr $C$DW$278, DW_AT_decl_column(0x05)

$C$DW$279	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$279, DW_AT_name("EPWM_AQ_OUTPUT_ON_TIMEBASE_PERIOD")
	.dwattr $C$DW$279, DW_AT_const_value(0x02)
	.dwattr $C$DW$279, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$279, DW_AT_decl_line(0x175)
	.dwattr $C$DW$279, DW_AT_decl_column(0x05)

$C$DW$280	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$280, DW_AT_name("EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPA")
	.dwattr $C$DW$280, DW_AT_const_value(0x04)
	.dwattr $C$DW$280, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$280, DW_AT_decl_line(0x177)
	.dwattr $C$DW$280, DW_AT_decl_column(0x05)

$C$DW$281	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$281, DW_AT_name("EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPA")
	.dwattr $C$DW$281, DW_AT_const_value(0x06)
	.dwattr $C$DW$281, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$281, DW_AT_decl_line(0x179)
	.dwattr $C$DW$281, DW_AT_decl_column(0x05)

$C$DW$282	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$282, DW_AT_name("EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPB")
	.dwattr $C$DW$282, DW_AT_const_value(0x08)
	.dwattr $C$DW$282, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$282, DW_AT_decl_line(0x17b)
	.dwattr $C$DW$282, DW_AT_decl_column(0x05)

$C$DW$283	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$283, DW_AT_name("EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPB")
	.dwattr $C$DW$283, DW_AT_const_value(0x0a)
	.dwattr $C$DW$283, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$283, DW_AT_decl_line(0x17d)
	.dwattr $C$DW$283, DW_AT_decl_column(0x05)

$C$DW$284	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$284, DW_AT_name("EPWM_AQ_OUTPUT_ON_T1_COUNT_UP")
	.dwattr $C$DW$284, DW_AT_const_value(0x01)
	.dwattr $C$DW$284, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$284, DW_AT_decl_line(0x17f)
	.dwattr $C$DW$284, DW_AT_decl_column(0x05)

$C$DW$285	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$285, DW_AT_name("EPWM_AQ_OUTPUT_ON_T1_COUNT_DOWN")
	.dwattr $C$DW$285, DW_AT_const_value(0x03)
	.dwattr $C$DW$285, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$285, DW_AT_decl_line(0x181)
	.dwattr $C$DW$285, DW_AT_decl_column(0x05)

$C$DW$286	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$286, DW_AT_name("EPWM_AQ_OUTPUT_ON_T2_COUNT_UP")
	.dwattr $C$DW$286, DW_AT_const_value(0x05)
	.dwattr $C$DW$286, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$286, DW_AT_decl_line(0x183)
	.dwattr $C$DW$286, DW_AT_decl_column(0x05)

$C$DW$287	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$287, DW_AT_name("EPWM_AQ_OUTPUT_ON_T2_COUNT_DOWN")
	.dwattr $C$DW$287, DW_AT_const_value(0x07)
	.dwattr $C$DW$287, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$287, DW_AT_decl_line(0x185)
	.dwattr $C$DW$287, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$52, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$52, DW_AT_decl_line(0x171)
	.dwattr $C$DW$T$52, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$52

	.dwendtag $C$DW$TU$52


$C$DW$TU$53	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$53
$C$DW$T$53	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$53, DW_AT_name("EPWM_ActionQualifierOutputEvent")
	.dwattr $C$DW$T$53, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$T$53, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$53, DW_AT_decl_line(0x186)
	.dwattr $C$DW$T$53, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$53


$C$DW$TU$54	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$54

$C$DW$T$54	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$54, DW_AT_byte_size(0x01)
$C$DW$288	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$288, DW_AT_name("EPWM_DB_RED")
	.dwattr $C$DW$288, DW_AT_const_value(0x01)
	.dwattr $C$DW$288, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$288, DW_AT_decl_line(0x23b)
	.dwattr $C$DW$288, DW_AT_decl_column(0x05)

$C$DW$289	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$289, DW_AT_name("EPWM_DB_FED")
	.dwattr $C$DW$289, DW_AT_const_value(0x00)
	.dwattr $C$DW$289, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$289, DW_AT_decl_line(0x23c)
	.dwattr $C$DW$289, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$54, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$54, DW_AT_decl_line(0x23a)
	.dwattr $C$DW$T$54, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$54

	.dwendtag $C$DW$TU$54


$C$DW$TU$55	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$55
$C$DW$T$55	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$55, DW_AT_name("EPWM_DeadBandDelayMode")
	.dwattr $C$DW$T$55, DW_AT_type(*$C$DW$T$54)
	.dwattr $C$DW$T$55, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$55, DW_AT_decl_line(0x23d)
	.dwattr $C$DW$T$55, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$55


$C$DW$TU$56	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$56

$C$DW$T$56	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$56, DW_AT_byte_size(0x01)
$C$DW$290	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$290, DW_AT_name("EPWM_DB_POLARITY_ACTIVE_HIGH")
	.dwattr $C$DW$290, DW_AT_const_value(0x00)
	.dwattr $C$DW$290, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$290, DW_AT_decl_line(0x247)
	.dwattr $C$DW$290, DW_AT_decl_column(0x05)

$C$DW$291	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$291, DW_AT_name("EPWM_DB_POLARITY_ACTIVE_LOW")
	.dwattr $C$DW$291, DW_AT_const_value(0x01)
	.dwattr $C$DW$291, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$291, DW_AT_decl_line(0x248)
	.dwattr $C$DW$291, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$56, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$56, DW_AT_decl_line(0x246)
	.dwattr $C$DW$T$56, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$56

	.dwendtag $C$DW$TU$56


$C$DW$TU$57	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$57
$C$DW$T$57	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$57, DW_AT_name("EPWM_DeadBandPolarity")
	.dwattr $C$DW$T$57, DW_AT_type(*$C$DW$T$56)
	.dwattr $C$DW$T$57, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$57, DW_AT_decl_line(0x249)
	.dwattr $C$DW$T$57, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$57


$C$DW$TU$58	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$58

$C$DW$T$58	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$58, DW_AT_byte_size(0x01)
$C$DW$292	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$292, DW_AT_name("EPWM_EMULATION_STOP_AFTER_NEXT_TB")
	.dwattr $C$DW$292, DW_AT_const_value(0x00)
	.dwattr $C$DW$292, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$292, DW_AT_decl_line(0x54)
	.dwattr $C$DW$292, DW_AT_decl_column(0x04)

$C$DW$293	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$293, DW_AT_name("EPWM_EMULATION_STOP_AFTER_FULL_CYCLE")
	.dwattr $C$DW$293, DW_AT_const_value(0x01)
	.dwattr $C$DW$293, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$293, DW_AT_decl_line(0x56)
	.dwattr $C$DW$293, DW_AT_decl_column(0x04)

$C$DW$294	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$294, DW_AT_name("EPWM_EMULATION_FREE_RUN")
	.dwattr $C$DW$294, DW_AT_const_value(0x02)
	.dwattr $C$DW$294, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$294, DW_AT_decl_line(0x58)
	.dwattr $C$DW$294, DW_AT_decl_column(0x04)

	.dwattr $C$DW$T$58, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$58, DW_AT_decl_line(0x52)
	.dwattr $C$DW$T$58, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$58

	.dwendtag $C$DW$TU$58


$C$DW$TU$59	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$59
$C$DW$T$59	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$59, DW_AT_name("EPWM_EmulationMode")
	.dwattr $C$DW$T$59, DW_AT_type(*$C$DW$T$58)
	.dwattr $C$DW$T$59, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$59, DW_AT_decl_line(0x59)
	.dwattr $C$DW$T$59, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$59


$C$DW$TU$60	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$60

$C$DW$T$60	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$60, DW_AT_byte_size(0x01)
$C$DW$295	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$295, DW_AT_name("GPIO_INT_XINT1")
	.dwattr $C$DW$295, DW_AT_const_value(0x00)
	.dwattr $C$DW$295, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$295, DW_AT_decl_line(0xce)
	.dwattr $C$DW$295, DW_AT_decl_column(0x05)

$C$DW$296	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$296, DW_AT_name("GPIO_INT_XINT2")
	.dwattr $C$DW$296, DW_AT_const_value(0x01)
	.dwattr $C$DW$296, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$296, DW_AT_decl_line(0xcf)
	.dwattr $C$DW$296, DW_AT_decl_column(0x05)

$C$DW$297	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$297, DW_AT_name("GPIO_INT_XINT3")
	.dwattr $C$DW$297, DW_AT_const_value(0x02)
	.dwattr $C$DW$297, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$297, DW_AT_decl_line(0xd0)
	.dwattr $C$DW$297, DW_AT_decl_column(0x05)

$C$DW$298	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$298, DW_AT_name("GPIO_INT_XINT4")
	.dwattr $C$DW$298, DW_AT_const_value(0x03)
	.dwattr $C$DW$298, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$298, DW_AT_decl_line(0xd1)
	.dwattr $C$DW$298, DW_AT_decl_column(0x05)

$C$DW$299	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$299, DW_AT_name("GPIO_INT_XINT5")
	.dwattr $C$DW$299, DW_AT_const_value(0x04)
	.dwattr $C$DW$299, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$299, DW_AT_decl_line(0xd2)
	.dwattr $C$DW$299, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$60, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$60, DW_AT_decl_line(0xcd)
	.dwattr $C$DW$T$60, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$60

	.dwendtag $C$DW$TU$60


$C$DW$TU$61	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$61
$C$DW$T$61	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$61, DW_AT_name("GPIO_ExternalIntNum")
	.dwattr $C$DW$T$61, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$T$61, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$61, DW_AT_decl_line(0xd3)
	.dwattr $C$DW$T$61, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$61


$C$DW$TU$62	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$62

$C$DW$T$62	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$62, DW_AT_byte_size(0x01)
$C$DW$300	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$300, DW_AT_name("GPIO_INT_TYPE_FALLING_EDGE")
	.dwattr $C$DW$300, DW_AT_const_value(0x00)
	.dwattr $C$DW$300, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$300, DW_AT_decl_line(0x8a)
	.dwattr $C$DW$300, DW_AT_decl_column(0x05)

$C$DW$301	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$301, DW_AT_name("GPIO_INT_TYPE_RISING_EDGE")
	.dwattr $C$DW$301, DW_AT_const_value(0x04)
	.dwattr $C$DW$301, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$301, DW_AT_decl_line(0x8b)
	.dwattr $C$DW$301, DW_AT_decl_column(0x05)

$C$DW$302	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$302, DW_AT_name("GPIO_INT_TYPE_BOTH_EDGES")
	.dwattr $C$DW$302, DW_AT_const_value(0x0c)
	.dwattr $C$DW$302, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$302, DW_AT_decl_line(0x8c)
	.dwattr $C$DW$302, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$62, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$62, DW_AT_decl_line(0x89)
	.dwattr $C$DW$T$62, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$62

	.dwendtag $C$DW$TU$62


$C$DW$TU$63	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$63
$C$DW$T$63	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$63, DW_AT_name("GPIO_IntType")
	.dwattr $C$DW$T$63, DW_AT_type(*$C$DW$T$62)
	.dwattr $C$DW$T$63, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$63, DW_AT_decl_line(0x8d)
	.dwattr $C$DW$T$63, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$63


$C$DW$TU$64	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$64

$C$DW$T$64	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$64, DW_AT_byte_size(0x01)
$C$DW$303	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$303, DW_AT_name("GPIO_DIR_MODE_IN")
	.dwattr $C$DW$303, DW_AT_const_value(0x00)
	.dwattr $C$DW$303, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$303, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$303, DW_AT_decl_column(0x05)

$C$DW$304	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$304, DW_AT_name("GPIO_DIR_MODE_OUT")
	.dwattr $C$DW$304, DW_AT_const_value(0x01)
	.dwattr $C$DW$304, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$304, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$304, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$64, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$64, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$T$64, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$64

	.dwendtag $C$DW$TU$64


$C$DW$TU$65	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$65
$C$DW$T$65	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$65, DW_AT_name("GPIO_Direction")
	.dwattr $C$DW$T$65, DW_AT_type(*$C$DW$T$64)
	.dwattr $C$DW$T$65, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$65, DW_AT_decl_line(0x80)
	.dwattr $C$DW$T$65, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$65


$C$DW$TU$66	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$66

$C$DW$T$66	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$66, DW_AT_byte_size(0x01)
$C$DW$305	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$305, DW_AT_name("GPIO_QUAL_SYNC")
	.dwattr $C$DW$305, DW_AT_const_value(0x00)
	.dwattr $C$DW$305, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$305, DW_AT_decl_line(0x97)
	.dwattr $C$DW$305, DW_AT_decl_column(0x05)

$C$DW$306	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$306, DW_AT_name("GPIO_QUAL_3SAMPLE")
	.dwattr $C$DW$306, DW_AT_const_value(0x01)
	.dwattr $C$DW$306, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$306, DW_AT_decl_line(0x98)
	.dwattr $C$DW$306, DW_AT_decl_column(0x05)

$C$DW$307	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$307, DW_AT_name("GPIO_QUAL_6SAMPLE")
	.dwattr $C$DW$307, DW_AT_const_value(0x02)
	.dwattr $C$DW$307, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$307, DW_AT_decl_line(0x99)
	.dwattr $C$DW$307, DW_AT_decl_column(0x05)

$C$DW$308	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$308, DW_AT_name("GPIO_QUAL_ASYNC")
	.dwattr $C$DW$308, DW_AT_const_value(0x03)
	.dwattr $C$DW$308, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$308, DW_AT_decl_line(0x9a)
	.dwattr $C$DW$308, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$66, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$66, DW_AT_decl_line(0x96)
	.dwattr $C$DW$T$66, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$66

	.dwendtag $C$DW$TU$66


$C$DW$TU$67	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$67
$C$DW$T$67	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$67, DW_AT_name("GPIO_QualificationMode")
	.dwattr $C$DW$T$67, DW_AT_type(*$C$DW$T$66)
	.dwattr $C$DW$T$67, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$67, DW_AT_decl_line(0x9b)
	.dwattr $C$DW$T$67, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$67


$C$DW$TU$68	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$68

$C$DW$T$68	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$68, DW_AT_byte_size(0x01)
$C$DW$309	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$309, DW_AT_name("GPIO_ANALOG_DISABLED")
	.dwattr $C$DW$309, DW_AT_const_value(0x00)
	.dwattr $C$DW$309, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$309, DW_AT_decl_line(0xa4)
	.dwattr $C$DW$309, DW_AT_decl_column(0x05)

$C$DW$310	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$310, DW_AT_name("GPIO_ANALOG_ENABLED")
	.dwattr $C$DW$310, DW_AT_const_value(0x01)
	.dwattr $C$DW$310, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$310, DW_AT_decl_line(0xa5)
	.dwattr $C$DW$310, DW_AT_decl_column(0x05)

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
$C$DW$311	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$311, DW_AT_name("HRPWM_CHANNEL_A")
	.dwattr $C$DW$311, DW_AT_const_value(0x00)
	.dwattr $C$DW$311, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$311, DW_AT_decl_line(0x53)
	.dwattr $C$DW$311, DW_AT_decl_column(0x05)

$C$DW$312	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$312, DW_AT_name("HRPWM_CHANNEL_B")
	.dwattr $C$DW$312, DW_AT_const_value(0x08)
	.dwattr $C$DW$312, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$312, DW_AT_decl_line(0x54)
	.dwattr $C$DW$312, DW_AT_decl_column(0x05)

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
$C$DW$313	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$313, DW_AT_name("HRPWM_MEP_CTRL_DISABLE")
	.dwattr $C$DW$313, DW_AT_const_value(0x00)
	.dwattr $C$DW$313, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$313, DW_AT_decl_line(0x60)
	.dwattr $C$DW$313, DW_AT_decl_column(0x05)

$C$DW$314	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$314, DW_AT_name("HRPWM_MEP_CTRL_RISING_EDGE")
	.dwattr $C$DW$314, DW_AT_const_value(0x01)
	.dwattr $C$DW$314, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$314, DW_AT_decl_line(0x62)
	.dwattr $C$DW$314, DW_AT_decl_column(0x05)

$C$DW$315	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$315, DW_AT_name("HRPWM_MEP_CTRL_FALLING_EDGE")
	.dwattr $C$DW$315, DW_AT_const_value(0x02)
	.dwattr $C$DW$315, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$315, DW_AT_decl_line(0x64)
	.dwattr $C$DW$315, DW_AT_decl_column(0x05)

$C$DW$316	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$316, DW_AT_name("HRPWM_MEP_CTRL_RISING_AND_FALLING_EDGE")
	.dwattr $C$DW$316, DW_AT_const_value(0x03)
	.dwattr $C$DW$316, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$316, DW_AT_decl_line(0x66)
	.dwattr $C$DW$316, DW_AT_decl_column(0x05)

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
$C$DW$317	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$317, DW_AT_name("HRPWM_MEP_DUTY_PERIOD_CTRL")
	.dwattr $C$DW$317, DW_AT_const_value(0x00)
	.dwattr $C$DW$317, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$317, DW_AT_decl_line(0x72)
	.dwattr $C$DW$317, DW_AT_decl_column(0x05)

$C$DW$318	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$318, DW_AT_name("HRPWM_MEP_PHASE_CTRL")
	.dwattr $C$DW$318, DW_AT_const_value(0x01)
	.dwattr $C$DW$318, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$318, DW_AT_decl_line(0x74)
	.dwattr $C$DW$318, DW_AT_decl_column(0x05)

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
$C$DW$319	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$319, DW_AT_name("HRPWM_LOAD_ON_CNTR_ZERO")
	.dwattr $C$DW$319, DW_AT_const_value(0x00)
	.dwattr $C$DW$319, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$319, DW_AT_decl_line(0x81)
	.dwattr $C$DW$319, DW_AT_decl_column(0x05)

$C$DW$320	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$320, DW_AT_name("HRPWM_LOAD_ON_CNTR_PERIOD")
	.dwattr $C$DW$320, DW_AT_const_value(0x01)
	.dwattr $C$DW$320, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$320, DW_AT_decl_line(0x83)
	.dwattr $C$DW$320, DW_AT_decl_column(0x05)

$C$DW$321	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$321, DW_AT_name("HRPWM_LOAD_ON_CNTR_ZERO_PERIOD")
	.dwattr $C$DW$321, DW_AT_const_value(0x02)
	.dwattr $C$DW$321, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$321, DW_AT_decl_line(0x85)
	.dwattr $C$DW$321, DW_AT_decl_column(0x05)

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
$C$DW$322	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$322, DW_AT_name("HRPWM_COUNTER_COMPARE_A")
	.dwattr $C$DW$322, DW_AT_const_value(0x00)
	.dwattr $C$DW$322, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$322, DW_AT_decl_line(0xb3)
	.dwattr $C$DW$322, DW_AT_decl_column(0x05)

$C$DW$323	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$323, DW_AT_name("HRPWM_COUNTER_COMPARE_B")
	.dwattr $C$DW$323, DW_AT_const_value(0x04)
	.dwattr $C$DW$323, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$323, DW_AT_decl_line(0xb4)
	.dwattr $C$DW$323, DW_AT_decl_column(0x05)

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
$C$DW$324	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$324, DW_AT_name("SPI_FIFO_TXEMPTY")
	.dwattr $C$DW$324, DW_AT_const_value(0x00)
	.dwattr $C$DW$324, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$324, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$324, DW_AT_decl_column(0x05)

$C$DW$325	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$325, DW_AT_name("SPI_FIFO_TX0")
	.dwattr $C$DW$325, DW_AT_const_value(0x00)
	.dwattr $C$DW$325, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$325, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$325, DW_AT_decl_column(0x05)

$C$DW$326	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$326, DW_AT_name("SPI_FIFO_TX1")
	.dwattr $C$DW$326, DW_AT_const_value(0x01)
	.dwattr $C$DW$326, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$326, DW_AT_decl_line(0x80)
	.dwattr $C$DW$326, DW_AT_decl_column(0x05)

$C$DW$327	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$327, DW_AT_name("SPI_FIFO_TX2")
	.dwattr $C$DW$327, DW_AT_const_value(0x02)
	.dwattr $C$DW$327, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$327, DW_AT_decl_line(0x81)
	.dwattr $C$DW$327, DW_AT_decl_column(0x05)

$C$DW$328	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$328, DW_AT_name("SPI_FIFO_TX3")
	.dwattr $C$DW$328, DW_AT_const_value(0x03)
	.dwattr $C$DW$328, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$328, DW_AT_decl_line(0x82)
	.dwattr $C$DW$328, DW_AT_decl_column(0x05)

$C$DW$329	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$329, DW_AT_name("SPI_FIFO_TX4")
	.dwattr $C$DW$329, DW_AT_const_value(0x04)
	.dwattr $C$DW$329, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$329, DW_AT_decl_line(0x83)
	.dwattr $C$DW$329, DW_AT_decl_column(0x05)

$C$DW$330	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$330, DW_AT_name("SPI_FIFO_TX5")
	.dwattr $C$DW$330, DW_AT_const_value(0x05)
	.dwattr $C$DW$330, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$330, DW_AT_decl_line(0x84)
	.dwattr $C$DW$330, DW_AT_decl_column(0x05)

$C$DW$331	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$331, DW_AT_name("SPI_FIFO_TX6")
	.dwattr $C$DW$331, DW_AT_const_value(0x06)
	.dwattr $C$DW$331, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$331, DW_AT_decl_line(0x85)
	.dwattr $C$DW$331, DW_AT_decl_column(0x05)

$C$DW$332	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$332, DW_AT_name("SPI_FIFO_TX7")
	.dwattr $C$DW$332, DW_AT_const_value(0x07)
	.dwattr $C$DW$332, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$332, DW_AT_decl_line(0x86)
	.dwattr $C$DW$332, DW_AT_decl_column(0x05)

$C$DW$333	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$333, DW_AT_name("SPI_FIFO_TX8")
	.dwattr $C$DW$333, DW_AT_const_value(0x08)
	.dwattr $C$DW$333, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$333, DW_AT_decl_line(0x87)
	.dwattr $C$DW$333, DW_AT_decl_column(0x05)

$C$DW$334	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$334, DW_AT_name("SPI_FIFO_TX9")
	.dwattr $C$DW$334, DW_AT_const_value(0x09)
	.dwattr $C$DW$334, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$334, DW_AT_decl_line(0x88)
	.dwattr $C$DW$334, DW_AT_decl_column(0x05)

$C$DW$335	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$335, DW_AT_name("SPI_FIFO_TX10")
	.dwattr $C$DW$335, DW_AT_const_value(0x0a)
	.dwattr $C$DW$335, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$335, DW_AT_decl_line(0x89)
	.dwattr $C$DW$335, DW_AT_decl_column(0x05)

$C$DW$336	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$336, DW_AT_name("SPI_FIFO_TX11")
	.dwattr $C$DW$336, DW_AT_const_value(0x0b)
	.dwattr $C$DW$336, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$336, DW_AT_decl_line(0x8a)
	.dwattr $C$DW$336, DW_AT_decl_column(0x05)

$C$DW$337	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$337, DW_AT_name("SPI_FIFO_TX12")
	.dwattr $C$DW$337, DW_AT_const_value(0x0c)
	.dwattr $C$DW$337, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$337, DW_AT_decl_line(0x8b)
	.dwattr $C$DW$337, DW_AT_decl_column(0x05)

$C$DW$338	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$338, DW_AT_name("SPI_FIFO_TX13")
	.dwattr $C$DW$338, DW_AT_const_value(0x0d)
	.dwattr $C$DW$338, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$338, DW_AT_decl_line(0x8c)
	.dwattr $C$DW$338, DW_AT_decl_column(0x05)

$C$DW$339	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$339, DW_AT_name("SPI_FIFO_TX14")
	.dwattr $C$DW$339, DW_AT_const_value(0x0e)
	.dwattr $C$DW$339, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$339, DW_AT_decl_line(0x8d)
	.dwattr $C$DW$339, DW_AT_decl_column(0x05)

$C$DW$340	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$340, DW_AT_name("SPI_FIFO_TX15")
	.dwattr $C$DW$340, DW_AT_const_value(0x0f)
	.dwattr $C$DW$340, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$340, DW_AT_decl_line(0x8e)
	.dwattr $C$DW$340, DW_AT_decl_column(0x05)

$C$DW$341	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$341, DW_AT_name("SPI_FIFO_TX16")
	.dwattr $C$DW$341, DW_AT_const_value(0x10)
	.dwattr $C$DW$341, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$341, DW_AT_decl_line(0x8f)
	.dwattr $C$DW$341, DW_AT_decl_column(0x05)

$C$DW$342	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$342, DW_AT_name("SPI_FIFO_TXFULL")
	.dwattr $C$DW$342, DW_AT_const_value(0x10)
	.dwattr $C$DW$342, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$342, DW_AT_decl_line(0x90)
	.dwattr $C$DW$342, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$80, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$80, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$T$80, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$80

	.dwendtag $C$DW$TU$80


$C$DW$TU$81	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$81
$C$DW$T$81	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$81, DW_AT_name("SPI_TxFIFOLevel")
	.dwattr $C$DW$T$81, DW_AT_type(*$C$DW$T$80)
	.dwattr $C$DW$T$81, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$81, DW_AT_decl_line(0x91)
	.dwattr $C$DW$T$81, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$81


$C$DW$TU$85	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$85

$C$DW$T$85	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$85, DW_AT_byte_size(0x01)
$C$DW$343	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$343, DW_AT_name("SPI_FIFO_RXEMPTY")
	.dwattr $C$DW$343, DW_AT_const_value(0x00)
	.dwattr $C$DW$343, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$343, DW_AT_decl_line(0x9c)
	.dwattr $C$DW$343, DW_AT_decl_column(0x05)

$C$DW$344	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$344, DW_AT_name("SPI_FIFO_RX0")
	.dwattr $C$DW$344, DW_AT_const_value(0x00)
	.dwattr $C$DW$344, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$344, DW_AT_decl_line(0x9d)
	.dwattr $C$DW$344, DW_AT_decl_column(0x05)

$C$DW$345	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$345, DW_AT_name("SPI_FIFO_RX1")
	.dwattr $C$DW$345, DW_AT_const_value(0x01)
	.dwattr $C$DW$345, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$345, DW_AT_decl_line(0x9e)
	.dwattr $C$DW$345, DW_AT_decl_column(0x05)

$C$DW$346	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$346, DW_AT_name("SPI_FIFO_RX2")
	.dwattr $C$DW$346, DW_AT_const_value(0x02)
	.dwattr $C$DW$346, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$346, DW_AT_decl_line(0x9f)
	.dwattr $C$DW$346, DW_AT_decl_column(0x05)

$C$DW$347	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$347, DW_AT_name("SPI_FIFO_RX3")
	.dwattr $C$DW$347, DW_AT_const_value(0x03)
	.dwattr $C$DW$347, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$347, DW_AT_decl_line(0xa0)
	.dwattr $C$DW$347, DW_AT_decl_column(0x05)

$C$DW$348	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$348, DW_AT_name("SPI_FIFO_RX4")
	.dwattr $C$DW$348, DW_AT_const_value(0x04)
	.dwattr $C$DW$348, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$348, DW_AT_decl_line(0xa1)
	.dwattr $C$DW$348, DW_AT_decl_column(0x05)

$C$DW$349	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$349, DW_AT_name("SPI_FIFO_RX5")
	.dwattr $C$DW$349, DW_AT_const_value(0x05)
	.dwattr $C$DW$349, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$349, DW_AT_decl_line(0xa2)
	.dwattr $C$DW$349, DW_AT_decl_column(0x05)

$C$DW$350	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$350, DW_AT_name("SPI_FIFO_RX6")
	.dwattr $C$DW$350, DW_AT_const_value(0x06)
	.dwattr $C$DW$350, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$350, DW_AT_decl_line(0xa3)
	.dwattr $C$DW$350, DW_AT_decl_column(0x05)

$C$DW$351	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$351, DW_AT_name("SPI_FIFO_RX7")
	.dwattr $C$DW$351, DW_AT_const_value(0x07)
	.dwattr $C$DW$351, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$351, DW_AT_decl_line(0xa4)
	.dwattr $C$DW$351, DW_AT_decl_column(0x05)

$C$DW$352	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$352, DW_AT_name("SPI_FIFO_RX8")
	.dwattr $C$DW$352, DW_AT_const_value(0x08)
	.dwattr $C$DW$352, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$352, DW_AT_decl_line(0xa5)
	.dwattr $C$DW$352, DW_AT_decl_column(0x05)

$C$DW$353	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$353, DW_AT_name("SPI_FIFO_RX9")
	.dwattr $C$DW$353, DW_AT_const_value(0x09)
	.dwattr $C$DW$353, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$353, DW_AT_decl_line(0xa6)
	.dwattr $C$DW$353, DW_AT_decl_column(0x05)

$C$DW$354	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$354, DW_AT_name("SPI_FIFO_RX10")
	.dwattr $C$DW$354, DW_AT_const_value(0x0a)
	.dwattr $C$DW$354, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$354, DW_AT_decl_line(0xa7)
	.dwattr $C$DW$354, DW_AT_decl_column(0x05)

$C$DW$355	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$355, DW_AT_name("SPI_FIFO_RX11")
	.dwattr $C$DW$355, DW_AT_const_value(0x0b)
	.dwattr $C$DW$355, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$355, DW_AT_decl_line(0xa8)
	.dwattr $C$DW$355, DW_AT_decl_column(0x05)

$C$DW$356	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$356, DW_AT_name("SPI_FIFO_RX12")
	.dwattr $C$DW$356, DW_AT_const_value(0x0c)
	.dwattr $C$DW$356, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$356, DW_AT_decl_line(0xa9)
	.dwattr $C$DW$356, DW_AT_decl_column(0x05)

$C$DW$357	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$357, DW_AT_name("SPI_FIFO_RX13")
	.dwattr $C$DW$357, DW_AT_const_value(0x0d)
	.dwattr $C$DW$357, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$357, DW_AT_decl_line(0xaa)
	.dwattr $C$DW$357, DW_AT_decl_column(0x05)

$C$DW$358	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$358, DW_AT_name("SPI_FIFO_RX14")
	.dwattr $C$DW$358, DW_AT_const_value(0x0e)
	.dwattr $C$DW$358, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$358, DW_AT_decl_line(0xab)
	.dwattr $C$DW$358, DW_AT_decl_column(0x05)

$C$DW$359	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$359, DW_AT_name("SPI_FIFO_RX15")
	.dwattr $C$DW$359, DW_AT_const_value(0x0f)
	.dwattr $C$DW$359, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$359, DW_AT_decl_line(0xac)
	.dwattr $C$DW$359, DW_AT_decl_column(0x05)

$C$DW$360	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$360, DW_AT_name("SPI_FIFO_RX16")
	.dwattr $C$DW$360, DW_AT_const_value(0x10)
	.dwattr $C$DW$360, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$360, DW_AT_decl_line(0xad)
	.dwattr $C$DW$360, DW_AT_decl_column(0x05)

$C$DW$361	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$361, DW_AT_name("SPI_FIFO_RXFULL")
	.dwattr $C$DW$361, DW_AT_const_value(0x10)
	.dwattr $C$DW$361, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$361, DW_AT_decl_line(0xae)
	.dwattr $C$DW$361, DW_AT_decl_column(0x05)

$C$DW$362	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$362, DW_AT_name("SPI_FIFO_RXDEFAULT")
	.dwattr $C$DW$362, DW_AT_const_value(0x1f)
	.dwattr $C$DW$362, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$362, DW_AT_decl_line(0xaf)
	.dwattr $C$DW$362, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$85, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$85, DW_AT_decl_line(0x9b)
	.dwattr $C$DW$T$85, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$85

	.dwendtag $C$DW$TU$85


$C$DW$TU$86	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$86
$C$DW$T$86	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$86, DW_AT_name("SPI_RxFIFOLevel")
	.dwattr $C$DW$T$86, DW_AT_type(*$C$DW$T$85)
	.dwattr $C$DW$T$86, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$86, DW_AT_decl_line(0xb0)
	.dwattr $C$DW$T$86, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$86


$C$DW$TU$88	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$88

$C$DW$T$88	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$88, DW_AT_byte_size(0x01)
$C$DW$363	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$363, DW_AT_name("SPI_EMULATION_STOP_MIDWAY")
	.dwattr $C$DW$363, DW_AT_const_value(0x00)
	.dwattr $C$DW$363, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$363, DW_AT_decl_line(0xbb)
	.dwattr $C$DW$363, DW_AT_decl_column(0x05)

$C$DW$364	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$364, DW_AT_name("SPI_EMULATION_FREE_RUN")
	.dwattr $C$DW$364, DW_AT_const_value(0x10)
	.dwattr $C$DW$364, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$364, DW_AT_decl_line(0xbd)
	.dwattr $C$DW$364, DW_AT_decl_column(0x05)

$C$DW$365	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$365, DW_AT_name("SPI_EMULATION_STOP_AFTER_TRANSMIT")
	.dwattr $C$DW$365, DW_AT_const_value(0x20)
	.dwattr $C$DW$365, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$365, DW_AT_decl_line(0xbf)
	.dwattr $C$DW$365, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$88, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$88, DW_AT_decl_line(0xb9)
	.dwattr $C$DW$T$88, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$88

	.dwendtag $C$DW$TU$88


$C$DW$TU$89	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$89
$C$DW$T$89	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$89, DW_AT_name("SPI_EmulationMode")
	.dwattr $C$DW$T$89, DW_AT_type(*$C$DW$T$88)
	.dwattr $C$DW$T$89, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$89, DW_AT_decl_line(0xc0)
	.dwattr $C$DW$T$89, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$89


$C$DW$TU$90	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$90

$C$DW$T$90	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$90, DW_AT_byte_size(0x01)
$C$DW$366	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$366, DW_AT_name("SPI_PROT_POL0PHA0")
	.dwattr $C$DW$366, DW_AT_const_value(0x00)
	.dwattr $C$DW$366, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$366, DW_AT_decl_line(0x5f)
	.dwattr $C$DW$366, DW_AT_decl_column(0x05)

$C$DW$367	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$367, DW_AT_name("SPI_PROT_POL0PHA1")
	.dwattr $C$DW$367, DW_AT_const_value(0x02)
	.dwattr $C$DW$367, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$367, DW_AT_decl_line(0x61)
	.dwattr $C$DW$367, DW_AT_decl_column(0x05)

$C$DW$368	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$368, DW_AT_name("SPI_PROT_POL1PHA0")
	.dwattr $C$DW$368, DW_AT_const_value(0x01)
	.dwattr $C$DW$368, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$368, DW_AT_decl_line(0x63)
	.dwattr $C$DW$368, DW_AT_decl_column(0x05)

$C$DW$369	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$369, DW_AT_name("SPI_PROT_POL1PHA1")
	.dwattr $C$DW$369, DW_AT_const_value(0x03)
	.dwattr $C$DW$369, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$369, DW_AT_decl_line(0x65)
	.dwattr $C$DW$369, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$90, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$90, DW_AT_decl_line(0x5d)
	.dwattr $C$DW$T$90, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$90

	.dwendtag $C$DW$TU$90


$C$DW$TU$91	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$91
$C$DW$T$91	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$91, DW_AT_name("SPI_TransferProtocol")
	.dwattr $C$DW$T$91, DW_AT_type(*$C$DW$T$90)
	.dwattr $C$DW$T$91, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$91, DW_AT_decl_line(0x66)
	.dwattr $C$DW$T$91, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$91


$C$DW$TU$92	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$92

$C$DW$T$92	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$92, DW_AT_byte_size(0x01)
$C$DW$370	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$370, DW_AT_name("SPI_MODE_SLAVE")
	.dwattr $C$DW$370, DW_AT_const_value(0x02)
	.dwattr $C$DW$370, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$370, DW_AT_decl_line(0x6f)
	.dwattr $C$DW$370, DW_AT_decl_column(0x05)

$C$DW$371	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$371, DW_AT_name("SPI_MODE_MASTER")
	.dwattr $C$DW$371, DW_AT_const_value(0x06)
	.dwattr $C$DW$371, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$371, DW_AT_decl_line(0x70)
	.dwattr $C$DW$371, DW_AT_decl_column(0x05)

$C$DW$372	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$372, DW_AT_name("SPI_MODE_SLAVE_OD")
	.dwattr $C$DW$372, DW_AT_const_value(0x00)
	.dwattr $C$DW$372, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$372, DW_AT_decl_line(0x71)
	.dwattr $C$DW$372, DW_AT_decl_column(0x05)

$C$DW$373	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$373, DW_AT_name("SPI_MODE_MASTER_OD")
	.dwattr $C$DW$373, DW_AT_const_value(0x04)
	.dwattr $C$DW$373, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$373, DW_AT_decl_line(0x72)
	.dwattr $C$DW$373, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$92, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$92, DW_AT_decl_line(0x6e)
	.dwattr $C$DW$T$92, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$92

	.dwendtag $C$DW$TU$92


$C$DW$TU$93	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$93
$C$DW$T$93	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$93, DW_AT_name("SPI_Mode")
	.dwattr $C$DW$T$93, DW_AT_type(*$C$DW$T$92)
	.dwattr $C$DW$T$93, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$T$93, DW_AT_decl_line(0x73)
	.dwattr $C$DW$T$93, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$93


$C$DW$TU$25	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$25

$C$DW$T$25	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$25, DW_AT_byte_size(0x12)
$C$DW$374	.dwtag  DW_TAG_member
	.dwattr $C$DW$374, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$374, DW_AT_name("response")
	.dwattr $C$DW$374, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$374, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$374, DW_AT_decl_line(0x34)
	.dwattr $C$DW$374, DW_AT_decl_column(0x17)

$C$DW$375	.dwtag  DW_TAG_member
	.dwattr $C$DW$375, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$375, DW_AT_name("crc")
	.dwattr $C$DW$375, DW_AT_data_member_location[DW_OP_plus_uconst 0x1]
	.dwattr $C$DW$375, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$375, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$375, DW_AT_decl_line(0x35)
	.dwattr $C$DW$375, DW_AT_decl_column(0x17)

$C$DW$376	.dwtag  DW_TAG_member
	.dwattr $C$DW$376, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$376, DW_AT_name("channel0")
	.dwattr $C$DW$376, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$376, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$376, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$376, DW_AT_decl_line(0x36)
	.dwattr $C$DW$376, DW_AT_decl_column(0x16)

$C$DW$377	.dwtag  DW_TAG_member
	.dwattr $C$DW$377, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$377, DW_AT_name("channel1")
	.dwattr $C$DW$377, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$377, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$377, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$377, DW_AT_decl_line(0x37)
	.dwattr $C$DW$377, DW_AT_decl_column(0x16)

$C$DW$378	.dwtag  DW_TAG_member
	.dwattr $C$DW$378, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$378, DW_AT_name("channel2")
	.dwattr $C$DW$378, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$378, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$378, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$378, DW_AT_decl_line(0x38)
	.dwattr $C$DW$378, DW_AT_decl_column(0x16)

$C$DW$379	.dwtag  DW_TAG_member
	.dwattr $C$DW$379, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$379, DW_AT_name("channel3")
	.dwattr $C$DW$379, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$379, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$379, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$379, DW_AT_decl_line(0x39)
	.dwattr $C$DW$379, DW_AT_decl_column(0x16)

$C$DW$380	.dwtag  DW_TAG_member
	.dwattr $C$DW$380, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$380, DW_AT_name("channel4")
	.dwattr $C$DW$380, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$380, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$380, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$380, DW_AT_decl_line(0x3a)
	.dwattr $C$DW$380, DW_AT_decl_column(0x16)

$C$DW$381	.dwtag  DW_TAG_member
	.dwattr $C$DW$381, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$381, DW_AT_name("channel5")
	.dwattr $C$DW$381, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$381, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$381, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$381, DW_AT_decl_line(0x3b)
	.dwattr $C$DW$381, DW_AT_decl_column(0x16)

$C$DW$382	.dwtag  DW_TAG_member
	.dwattr $C$DW$382, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$382, DW_AT_name("channel6")
	.dwattr $C$DW$382, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$382, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$382, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$382, DW_AT_decl_line(0x3c)
	.dwattr $C$DW$382, DW_AT_decl_column(0x16)

$C$DW$383	.dwtag  DW_TAG_member
	.dwattr $C$DW$383, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$383, DW_AT_name("channel7")
	.dwattr $C$DW$383, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$383, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$383, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$383, DW_AT_decl_line(0x3d)
	.dwattr $C$DW$383, DW_AT_decl_column(0x16)

	.dwattr $C$DW$T$25, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$T$25, DW_AT_decl_line(0x33)
	.dwattr $C$DW$T$25, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$25

	.dwendtag $C$DW$TU$25


$C$DW$TU$94	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$94
$C$DW$T$94	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$94, DW_AT_name("adc_data")
	.dwattr $C$DW$T$94, DW_AT_type(*$C$DW$T$25)
	.dwattr $C$DW$T$94, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts_hal.h")
	.dwattr $C$DW$T$94, DW_AT_decl_line(0x3e)
	.dwattr $C$DW$T$94, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$94


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
$C$DW$384	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$384, DW_AT_type(*$C$DW$T$20)

$C$DW$T$21	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$21, DW_AT_type(*$C$DW$384)

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
$C$DW$385	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$385, DW_AT_type(*$C$DW$T$23)

$C$DW$T$24	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$24, DW_AT_type(*$C$DW$385)

	.dwendtag $C$DW$TU$24


$C$DW$TU$13	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$13
$C$DW$T$13	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$13, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$13, DW_AT_name("unsigned long")
	.dwattr $C$DW$T$13, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$13


$C$DW$TU$82	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$82
$C$DW$T$82	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$82, DW_AT_name("__uint32_t")
	.dwattr $C$DW$T$82, DW_AT_type(*$C$DW$T$13)
	.dwattr $C$DW$T$82, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$82, DW_AT_decl_line(0x43)
	.dwattr $C$DW$T$82, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$82


$C$DW$TU$149	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$149
$C$DW$T$149	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$149, DW_AT_name("__uintptr_t")
	.dwattr $C$DW$T$149, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$T$149, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$149, DW_AT_decl_line(0x78)
	.dwattr $C$DW$T$149, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$149


$C$DW$TU$150	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$150
$C$DW$T$150	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$150, DW_AT_name("uintptr_t")
	.dwattr $C$DW$T$150, DW_AT_type(*$C$DW$T$149)
	.dwattr $C$DW$T$150, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$150, DW_AT_decl_line(0x54)
	.dwattr $C$DW$T$150, DW_AT_decl_column(0x16)

	.dwendtag $C$DW$TU$150


$C$DW$TU$83	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$83
$C$DW$T$83	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$83, DW_AT_name("uint32_t")
	.dwattr $C$DW$T$83, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$T$83, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$83, DW_AT_decl_line(0x46)
	.dwattr $C$DW$T$83, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$83


$C$DW$TU$137	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$137
$C$DW$386	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$386, DW_AT_type(*$C$DW$T$83)

$C$DW$T$137	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$137, DW_AT_type(*$C$DW$386)

	.dwendtag $C$DW$TU$137


$C$DW$TU$152	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$152
$C$DW$387	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$387, DW_AT_type(*$C$DW$T$83)

$C$DW$T$152	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$152, DW_AT_type(*$C$DW$387)

	.dwendtag $C$DW$TU$152


$C$DW$TU$153	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$153

$C$DW$T$153	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$153, DW_AT_type(*$C$DW$T$152)
	.dwattr $C$DW$T$153, DW_AT_byte_size(0x12)
$C$DW$388	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$388, DW_AT_upper_bound(0x08)

	.dwendtag $C$DW$T$153

	.dwendtag $C$DW$TU$153


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


$C$DW$TU$114	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$114
$C$DW$T$114	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$114, DW_AT_encoding(DW_ATE_unsigned_char)
	.dwattr $C$DW$T$114, DW_AT_name("unsigned char")
	.dwattr $C$DW$T$114, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$114

