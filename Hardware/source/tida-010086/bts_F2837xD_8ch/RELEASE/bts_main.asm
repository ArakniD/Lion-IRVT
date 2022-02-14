;***************************************************************
;* TMS320C2000 G3 C/C++ Codegen                               PC v20.2.4.LTS *
;* Date/Time created: Tue Mar  2 07:24:44 2021                 *
;***************************************************************
	.compiler_opts --abi=eabi --cla_support=cla1 --diag_wrap=off --float_support=fpu32 --hll_source=on --mem_model:code=flat --mem_model:data=large --object_format=elf --quiet --silicon_errata_fpu1_workaround=off --silicon_version=28 --symdebug:dwarf --symdebug:dwarf_version=4 --tmu_support=tmu0 --vcu_support=vcu2 
	.asg	XAR2, FP

$C$DW$CU	.dwtag  DW_TAG_compile_unit
	.dwattr $C$DW$CU, DW_AT_name("../bts_main.c")
	.dwattr $C$DW$CU, DW_AT_producer("TI TMS320C2000 G3 C/C++ Codegen PC v20.2.4.LTS Copyright (c) 1996-2018 Texas Instruments Incorporated")
	.dwattr $C$DW$CU, DW_AT_TI_version(0x01)
	.dwattr $C$DW$CU, DW_AT_comp_dir("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\release")

$C$DW$1	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$1, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$1, DW_AT_linkage_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$1, DW_AT_declaration
	.dwattr $C$DW$1, DW_AT_external
	.dwattr $C$DW$1, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$1, DW_AT_decl_line(0x50f)
	.dwattr $C$DW$1, DW_AT_decl_column(0x01)
$C$DW$2	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$2, DW_AT_type(*$C$DW$T$43)

$C$DW$3	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$3, DW_AT_type(*$C$DW$T$43)

	.dwendtag $C$DW$1


$C$DW$4	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$4, DW_AT_name("__SFRA_F32_collect")
	.dwattr $C$DW$4, DW_AT_linkage_name("__SFRA_F32_collect")
	.dwattr $C$DW$4, DW_AT_declaration
	.dwattr $C$DW$4, DW_AT_external
	.dwattr $C$DW$4, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$4, DW_AT_decl_line(0xa8)
	.dwattr $C$DW$4, DW_AT_decl_column(0x0d)
$C$DW$5	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$5, DW_AT_type(*$C$DW$T$102)

$C$DW$6	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$6, DW_AT_type(*$C$DW$T$102)

	.dwendtag $C$DW$4


$C$DW$7	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$7, DW_AT_name("BTS_HAL_setupDevice")
	.dwattr $C$DW$7, DW_AT_linkage_name("BTS_HAL_setupDevice")
	.dwattr $C$DW$7, DW_AT_declaration
	.dwattr $C$DW$7, DW_AT_external
	.dwattr $C$DW$7, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$7, DW_AT_decl_line(0x4c)
	.dwattr $C$DW$7, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$7


$C$DW$8	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$8, DW_AT_name("BTS_HAL_setupSyncBuckPinsGpio")
	.dwattr $C$DW$8, DW_AT_linkage_name("BTS_HAL_setupSyncBuckPinsGpio")
	.dwattr $C$DW$8, DW_AT_declaration
	.dwattr $C$DW$8, DW_AT_external
	.dwattr $C$DW$8, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$8, DW_AT_decl_line(0x53)
	.dwattr $C$DW$8, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$8


$C$DW$9	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$9, DW_AT_name("BTS_HAL_SetupI2C_GPIO")
	.dwattr $C$DW$9, DW_AT_linkage_name("BTS_HAL_SetupI2C_GPIO")
	.dwattr $C$DW$9, DW_AT_declaration
	.dwattr $C$DW$9, DW_AT_external
	.dwattr $C$DW$9, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$9, DW_AT_decl_line(0x65)
	.dwattr $C$DW$9, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$9


$C$DW$10	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$10, DW_AT_name("BTS_HAL_SetupI2C_Init")
	.dwattr $C$DW$10, DW_AT_linkage_name("BTS_HAL_SetupI2C_Init")
	.dwattr $C$DW$10, DW_AT_declaration
	.dwattr $C$DW$10, DW_AT_external
	.dwattr $C$DW$10, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$10, DW_AT_decl_line(0x66)
	.dwattr $C$DW$10, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$10


$C$DW$11	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$11, DW_AT_name("BTS_HAL_disableEpwmCounting")
	.dwattr $C$DW$11, DW_AT_linkage_name("BTS_HAL_disableEpwmCounting")
	.dwattr $C$DW$11, DW_AT_declaration
	.dwattr $C$DW$11, DW_AT_external
	.dwattr $C$DW$11, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$11, DW_AT_decl_line(0x58)
	.dwattr $C$DW$11, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$11


$C$DW$12	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$12, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$12, DW_AT_linkage_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$12, DW_AT_declaration
	.dwattr $C$DW$12, DW_AT_external
	.dwattr $C$DW$12, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$12, DW_AT_decl_line(0x55)
	.dwattr $C$DW$12, DW_AT_decl_column(0x06)
$C$DW$13	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$13, DW_AT_type(*$C$DW$T$43)

	.dwendtag $C$DW$12


$C$DW$14	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$14, DW_AT_name("BTS_HAL_setupAdcClock")
	.dwattr $C$DW$14, DW_AT_linkage_name("BTS_HAL_setupAdcClock")
	.dwattr $C$DW$14, DW_AT_declaration
	.dwattr $C$DW$14, DW_AT_external
	.dwattr $C$DW$14, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$14, DW_AT_decl_line(0x56)
	.dwattr $C$DW$14, DW_AT_decl_column(0x06)
$C$DW$15	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$15, DW_AT_type(*$C$DW$T$43)

	.dwendtag $C$DW$14


$C$DW$16	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$16, DW_AT_name("BTS_setupHrpwmMepScaleFactor")
	.dwattr $C$DW$16, DW_AT_linkage_name("BTS_setupHrpwmMepScaleFactor")
	.dwattr $C$DW$16, DW_AT_declaration
	.dwattr $C$DW$16, DW_AT_external
	.dwattr $C$DW$16, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$16, DW_AT_decl_line(0x15c)
	.dwattr $C$DW$16, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$16


$C$DW$17	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$17, DW_AT_name("BTS_HAL_enableEpwmCounting")
	.dwattr $C$DW$17, DW_AT_linkage_name("BTS_HAL_enableEpwmCounting")
	.dwattr $C$DW$17, DW_AT_declaration
	.dwattr $C$DW$17, DW_AT_external
	.dwattr $C$DW$17, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$17, DW_AT_decl_line(0x59)
	.dwattr $C$DW$17, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$17


$C$DW$18	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$18, DW_AT_name("BTS_HAL_SetupSpiPinsGpio_Adc1")
	.dwattr $C$DW$18, DW_AT_linkage_name("BTS_HAL_SetupSpiPinsGpio_Adc1")
	.dwattr $C$DW$18, DW_AT_declaration
	.dwattr $C$DW$18, DW_AT_external
	.dwattr $C$DW$18, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$18, DW_AT_decl_line(0x62)
	.dwattr $C$DW$18, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$18


$C$DW$19	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$19, DW_AT_name("BTS_HAL_SetupSpi")
	.dwattr $C$DW$19, DW_AT_linkage_name("BTS_HAL_SetupSpi")
	.dwattr $C$DW$19, DW_AT_declaration
	.dwattr $C$DW$19, DW_AT_external
	.dwattr $C$DW$19, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$19, DW_AT_decl_line(0x61)
	.dwattr $C$DW$19, DW_AT_decl_column(0x06)
$C$DW$20	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$20, DW_AT_type(*$C$DW$T$43)

	.dwendtag $C$DW$19


$C$DW$21	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$21, DW_AT_name("BTS_HAL_SetupSpiPinsGpio_Adc2")
	.dwattr $C$DW$21, DW_AT_linkage_name("BTS_HAL_SetupSpiPinsGpio_Adc2")
	.dwattr $C$DW$21, DW_AT_declaration
	.dwattr $C$DW$21, DW_AT_external
	.dwattr $C$DW$21, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$21, DW_AT_decl_line(0x63)
	.dwattr $C$DW$21, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$21


$C$DW$22	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$22, DW_AT_name("BTS_HAL_setupExAdcGpio_Adc1")
	.dwattr $C$DW$22, DW_AT_linkage_name("BTS_HAL_setupExAdcGpio_Adc1")
	.dwattr $C$DW$22, DW_AT_declaration
	.dwattr $C$DW$22, DW_AT_external
	.dwattr $C$DW$22, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$22, DW_AT_decl_line(0x50)
	.dwattr $C$DW$22, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$22


$C$DW$23	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$23, DW_AT_name("BTS_HAL_setupExAdc_ch1_4")
	.dwattr $C$DW$23, DW_AT_linkage_name("BTS_HAL_setupExAdc_ch1_4")
	.dwattr $C$DW$23, DW_AT_declaration
	.dwattr $C$DW$23, DW_AT_external
	.dwattr $C$DW$23, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$23, DW_AT_decl_line(0x4d)
	.dwattr $C$DW$23, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$23


$C$DW$24	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$24, DW_AT_name("BTS_HAL_setupExAdcGpio_Adc2")
	.dwattr $C$DW$24, DW_AT_linkage_name("BTS_HAL_setupExAdcGpio_Adc2")
	.dwattr $C$DW$24, DW_AT_declaration
	.dwattr $C$DW$24, DW_AT_external
	.dwattr $C$DW$24, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$24, DW_AT_decl_line(0x51)
	.dwattr $C$DW$24, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$24


$C$DW$25	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$25, DW_AT_name("BTS_HAL_setupExAdc_ch5_8")
	.dwattr $C$DW$25, DW_AT_linkage_name("BTS_HAL_setupExAdc_ch5_8")
	.dwattr $C$DW$25, DW_AT_declaration
	.dwattr $C$DW$25, DW_AT_external
	.dwattr $C$DW$25, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$25, DW_AT_decl_line(0x4e)
	.dwattr $C$DW$25, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$25


$C$DW$26	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$26, DW_AT_name("BTS_initUserVariables")
	.dwattr $C$DW$26, DW_AT_linkage_name("BTS_initUserVariables")
	.dwattr $C$DW$26, DW_AT_declaration
	.dwattr $C$DW$26, DW_AT_external
	.dwattr $C$DW$26, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$26, DW_AT_decl_line(0x15f)
	.dwattr $C$DW$26, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$26


$C$DW$27	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$27, DW_AT_name("BTS_initProgramVariables")
	.dwattr $C$DW$27, DW_AT_linkage_name("BTS_initProgramVariables")
	.dwattr $C$DW$27, DW_AT_declaration
	.dwattr $C$DW$27, DW_AT_external
	.dwattr $C$DW$27, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$27, DW_AT_decl_line(0x160)
	.dwattr $C$DW$27, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$27


$C$DW$28	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$28, DW_AT_name("BTS_initController")
	.dwattr $C$DW$28, DW_AT_linkage_name("BTS_initController")
	.dwattr $C$DW$28, DW_AT_declaration
	.dwattr $C$DW$28, DW_AT_external
	.dwattr $C$DW$28, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$28, DW_AT_decl_line(0x161)
	.dwattr $C$DW$28, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$28


$C$DW$29	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$29, DW_AT_name("BTS_setupSfra")
	.dwattr $C$DW$29, DW_AT_linkage_name("BTS_setupSfra")
	.dwattr $C$DW$29, DW_AT_declaration
	.dwattr $C$DW$29, DW_AT_external
	.dwattr $C$DW$29, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$29, DW_AT_decl_line(0x159)
	.dwattr $C$DW$29, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$29


$C$DW$30	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$30, DW_AT_name("BTS_setupSfraGui")
	.dwattr $C$DW$30, DW_AT_linkage_name("BTS_setupSfraGui")
	.dwattr $C$DW$30, DW_AT_declaration
	.dwattr $C$DW$30, DW_AT_external
	.dwattr $C$DW$30, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$30, DW_AT_decl_line(0x15a)
	.dwattr $C$DW$30, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$30


$C$DW$31	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$31, DW_AT_name("BTS_HAL_setupInterruptTrigger_Adc1")
	.dwattr $C$DW$31, DW_AT_linkage_name("BTS_HAL_setupInterruptTrigger_Adc1")
	.dwattr $C$DW$31, DW_AT_declaration
	.dwattr $C$DW$31, DW_AT_external
	.dwattr $C$DW$31, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$31, DW_AT_decl_line(0x5b)
	.dwattr $C$DW$31, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$31


$C$DW$32	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$32, DW_AT_name("BTS_HAL_setupInterruptTrigger_Adc2")
	.dwattr $C$DW$32, DW_AT_linkage_name("BTS_HAL_setupInterruptTrigger_Adc2")
	.dwattr $C$DW$32, DW_AT_declaration
	.dwattr $C$DW$32, DW_AT_external
	.dwattr $C$DW$32, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$32, DW_AT_decl_line(0x5c)
	.dwattr $C$DW$32, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$32


$C$DW$33	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$33, DW_AT_name("BTS_HAL_setupInterrupt_Adc1")
	.dwattr $C$DW$33, DW_AT_linkage_name("BTS_HAL_setupInterrupt_Adc1")
	.dwattr $C$DW$33, DW_AT_declaration
	.dwattr $C$DW$33, DW_AT_external
	.dwattr $C$DW$33, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$33, DW_AT_decl_line(0x5e)
	.dwattr $C$DW$33, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$33


$C$DW$34	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$34, DW_AT_name("BTS_HAL_setupInterrupt_Adc2")
	.dwattr $C$DW$34, DW_AT_linkage_name("BTS_HAL_setupInterrupt_Adc2")
	.dwattr $C$DW$34, DW_AT_declaration
	.dwattr $C$DW$34, DW_AT_external
	.dwattr $C$DW$34, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$34, DW_AT_decl_line(0x5f)
	.dwattr $C$DW$34, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$34


$C$DW$35	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$35, DW_AT_name("BTS_HAL_setupInterrupt")
	.dwattr $C$DW$35, DW_AT_linkage_name("BTS_HAL_setupInterrupt")
	.dwattr $C$DW$35, DW_AT_declaration
	.dwattr $C$DW$35, DW_AT_external
	.dwattr $C$DW$35, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$35, DW_AT_decl_line(0x5d)
	.dwattr $C$DW$35, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$35


$C$DW$36	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$36, DW_AT_name("BTS_HAL_setupSyncBuckPinsEpwm")
	.dwattr $C$DW$36, DW_AT_linkage_name("BTS_HAL_setupSyncBuckPinsEpwm")
	.dwattr $C$DW$36, DW_AT_declaration
	.dwattr $C$DW$36, DW_AT_external
	.dwattr $C$DW$36, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$36, DW_AT_decl_line(0x54)
	.dwattr $C$DW$36, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$36


$C$DW$37	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$37, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$37, DW_AT_linkage_name("BTS_updateReference")
	.dwattr $C$DW$37, DW_AT_declaration
	.dwattr $C$DW$37, DW_AT_external
	.dwattr $C$DW$37, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$37, DW_AT_decl_line(0x15e)
	.dwattr $C$DW$37, DW_AT_decl_column(0x06)
$C$DW$38	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$38, DW_AT_type(*$C$DW$T$71)

$C$DW$39	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$39, DW_AT_type(*$C$DW$T$74)

	.dwendtag $C$DW$37


$C$DW$40	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$40, DW_AT_name("SFRA_GUI_runSerialHostComms")
	.dwattr $C$DW$40, DW_AT_linkage_name("SFRA_GUI_runSerialHostComms")
	.dwattr $C$DW$40, DW_AT_declaration
	.dwattr $C$DW$40, DW_AT_external
	.dwattr $C$DW$40, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_gui_scicomms_driverlib.h")
	.dwattr $C$DW$40, DW_AT_decl_line(0x4e)
	.dwattr $C$DW$40, DW_AT_decl_column(0x06)
$C$DW$41	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$41, DW_AT_type(*$C$DW$T$68)

	.dwendtag $C$DW$40


$C$DW$42	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$42, DW_AT_name("SFRA_F32_runBackgroundTask")
	.dwattr $C$DW$42, DW_AT_linkage_name("SFRA_F32_runBackgroundTask")
	.dwattr $C$DW$42, DW_AT_declaration
	.dwattr $C$DW$42, DW_AT_external
	.dwattr $C$DW$42, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$42, DW_AT_decl_line(0xb0)
	.dwattr $C$DW$42, DW_AT_decl_column(0x0d)
$C$DW$43	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$43, DW_AT_type(*$C$DW$T$68)

	.dwendtag $C$DW$42


$C$DW$44	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$44, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$44, DW_AT_linkage_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$44, DW_AT_declaration
	.dwattr $C$DW$44, DW_AT_external
	.dwattr $C$DW$44, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$44, DW_AT_decl_line(0x162)
	.dwattr $C$DW$44, DW_AT_decl_column(0x06)
$C$DW$45	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$45, DW_AT_type(*$C$DW$T$77)

	.dwendtag $C$DW$44

$C$DW$46	.dwtag  DW_TAG_variable
	.dwattr $C$DW$46, DW_AT_name("BTS_ExAdcRxflag1")
	.dwattr $C$DW$46, DW_AT_linkage_name("BTS_ExAdcRxflag1")
	.dwattr $C$DW$46, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$46, DW_AT_declaration
	.dwattr $C$DW$46, DW_AT_external
	.dwattr $C$DW$46, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$46, DW_AT_decl_line(0x43)
	.dwattr $C$DW$46, DW_AT_decl_column(0x1a)

$C$DW$47	.dwtag  DW_TAG_variable
	.dwattr $C$DW$47, DW_AT_name("BTS_ExAdcRxflag2")
	.dwattr $C$DW$47, DW_AT_linkage_name("BTS_ExAdcRxflag2")
	.dwattr $C$DW$47, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$47, DW_AT_declaration
	.dwattr $C$DW$47, DW_AT_external
	.dwattr $C$DW$47, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$47, DW_AT_decl_line(0x44)
	.dwattr $C$DW$47, DW_AT_decl_column(0x1a)

$C$DW$48	.dwtag  DW_TAG_variable
	.dwattr $C$DW$48, DW_AT_name("BTS_sfoStatus")
	.dwattr $C$DW$48, DW_AT_linkage_name("BTS_sfoStatus")
	.dwattr $C$DW$48, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$48, DW_AT_declaration
	.dwattr $C$DW$48, DW_AT_external
	.dwattr $C$DW$48, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$48, DW_AT_decl_line(0x13a)
	.dwattr $C$DW$48, DW_AT_decl_column(0x13)


$C$DW$49	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$49, DW_AT_name("SFO")
	.dwattr $C$DW$49, DW_AT_linkage_name("SFO")
	.dwattr $C$DW$49, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$49, DW_AT_declaration
	.dwattr $C$DW$49, DW_AT_external
	.dwattr $C$DW$49, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/SFO/SFO_V8.h")
	.dwattr $C$DW$49, DW_AT_decl_line(0x40)
	.dwattr $C$DW$49, DW_AT_decl_column(0x05)
	.dwendtag $C$DW$49

$C$DW$50	.dwtag  DW_TAG_variable
	.dwattr $C$DW$50, DW_AT_name("MEP_ScaleFactor")
	.dwattr $C$DW$50, DW_AT_linkage_name("MEP_ScaleFactor")
	.dwattr $C$DW$50, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$50, DW_AT_declaration
	.dwattr $C$DW$50, DW_AT_external
	.dwattr $C$DW$50, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$50, DW_AT_decl_line(0x45)
	.dwattr $C$DW$50, DW_AT_decl_column(0x12)

	.global	||Alpha_State_Ptr||
	.bss	||Alpha_State_Ptr||,2,1,1
$C$DW$51	.dwtag  DW_TAG_variable
	.dwattr $C$DW$51, DW_AT_name("Alpha_State_Ptr")
	.dwattr $C$DW$51, DW_AT_linkage_name("Alpha_State_Ptr")
	.dwattr $C$DW$51, DW_AT_location[DW_OP_addr ||Alpha_State_Ptr||]
	.dwattr $C$DW$51, DW_AT_type(*$C$DW$T$84)
	.dwattr $C$DW$51, DW_AT_external
	.dwattr $C$DW$51, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$51, DW_AT_decl_line(0x25)
	.dwattr $C$DW$51, DW_AT_decl_column(0x08)

	.global	||A_Task_Ptr||
	.bss	||A_Task_Ptr||,2,1,1
$C$DW$52	.dwtag  DW_TAG_variable
	.dwattr $C$DW$52, DW_AT_name("A_Task_Ptr")
	.dwattr $C$DW$52, DW_AT_linkage_name("A_Task_Ptr")
	.dwattr $C$DW$52, DW_AT_location[DW_OP_addr ||A_Task_Ptr||]
	.dwattr $C$DW$52, DW_AT_type(*$C$DW$T$84)
	.dwattr $C$DW$52, DW_AT_external
	.dwattr $C$DW$52, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$52, DW_AT_decl_line(0x26)
	.dwattr $C$DW$52, DW_AT_decl_column(0x08)

	.global	||B_Task_Ptr||
	.bss	||B_Task_Ptr||,2,1,1
$C$DW$53	.dwtag  DW_TAG_variable
	.dwattr $C$DW$53, DW_AT_name("B_Task_Ptr")
	.dwattr $C$DW$53, DW_AT_linkage_name("B_Task_Ptr")
	.dwattr $C$DW$53, DW_AT_location[DW_OP_addr ||B_Task_Ptr||]
	.dwattr $C$DW$53, DW_AT_type(*$C$DW$T$84)
	.dwattr $C$DW$53, DW_AT_external
	.dwattr $C$DW$53, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$53, DW_AT_decl_line(0x27)
	.dwattr $C$DW$53, DW_AT_decl_column(0x08)

	.global	||C_Task_Ptr||
	.bss	||C_Task_Ptr||,2,1,1
$C$DW$54	.dwtag  DW_TAG_variable
	.dwattr $C$DW$54, DW_AT_name("C_Task_Ptr")
	.dwattr $C$DW$54, DW_AT_linkage_name("C_Task_Ptr")
	.dwattr $C$DW$54, DW_AT_location[DW_OP_addr ||C_Task_Ptr||]
	.dwattr $C$DW$54, DW_AT_type(*$C$DW$T$84)
	.dwattr $C$DW$54, DW_AT_external
	.dwattr $C$DW$54, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$54, DW_AT_decl_line(0x28)
	.dwattr $C$DW$54, DW_AT_decl_column(0x08)


$C$DW$55	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$55, DW_AT_name("__SFRA_F32_inject")
	.dwattr $C$DW$55, DW_AT_linkage_name("__SFRA_F32_inject")
	.dwattr $C$DW$55, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$55, DW_AT_declaration
	.dwattr $C$DW$55, DW_AT_external
	.dwattr $C$DW$55, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$55, DW_AT_decl_line(0x9c)
	.dwattr $C$DW$55, DW_AT_decl_column(0x0e)
$C$DW$56	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$56, DW_AT_type(*$C$DW$T$16)

	.dwendtag $C$DW$55


$C$DW$57	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$57, DW_AT_name("__eallow")
	.dwattr $C$DW$57, DW_AT_linkage_name("__eallow")
	.dwattr $C$DW$57, DW_AT_declaration
	.dwattr $C$DW$57, DW_AT_external
	.dwendtag $C$DW$57


$C$DW$58	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$58, DW_AT_name("__edis")
	.dwattr $C$DW$58, DW_AT_linkage_name("__edis")
	.dwattr $C$DW$58, DW_AT_declaration
	.dwattr $C$DW$58, DW_AT_external
	.dwendtag $C$DW$58

	.global	||vTimer0||
||vTimer0||:	.usect	".bss:vTimer0",4,0,0
$C$DW$59	.dwtag  DW_TAG_variable
	.dwattr $C$DW$59, DW_AT_name("vTimer0")
	.dwattr $C$DW$59, DW_AT_linkage_name("vTimer0")
	.dwattr $C$DW$59, DW_AT_location[DW_OP_addr ||vTimer0||]
	.dwattr $C$DW$59, DW_AT_type(*$C$DW$T$126)
	.dwattr $C$DW$59, DW_AT_external
	.dwattr $C$DW$59, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$59, DW_AT_decl_line(0x1e)
	.dwattr $C$DW$59, DW_AT_decl_column(0x0a)

	.global	||vTimer1||
||vTimer1||:	.usect	".bss:vTimer1",4,0,0
$C$DW$60	.dwtag  DW_TAG_variable
	.dwattr $C$DW$60, DW_AT_name("vTimer1")
	.dwattr $C$DW$60, DW_AT_linkage_name("vTimer1")
	.dwattr $C$DW$60, DW_AT_location[DW_OP_addr ||vTimer1||]
	.dwattr $C$DW$60, DW_AT_type(*$C$DW$T$126)
	.dwattr $C$DW$60, DW_AT_external
	.dwattr $C$DW$60, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$60, DW_AT_decl_line(0x1f)
	.dwattr $C$DW$60, DW_AT_decl_column(0x0a)

	.global	||vTimer2||
||vTimer2||:	.usect	".bss:vTimer2",4,0,0
$C$DW$61	.dwtag  DW_TAG_variable
	.dwattr $C$DW$61, DW_AT_name("vTimer2")
	.dwattr $C$DW$61, DW_AT_linkage_name("vTimer2")
	.dwattr $C$DW$61, DW_AT_location[DW_OP_addr ||vTimer2||]
	.dwattr $C$DW$61, DW_AT_type(*$C$DW$T$126)
	.dwattr $C$DW$61, DW_AT_external
	.dwattr $C$DW$61, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$61, DW_AT_decl_line(0x20)
	.dwattr $C$DW$61, DW_AT_decl_column(0x0a)

$C$DW$62	.dwtag  DW_TAG_variable
	.dwattr $C$DW$62, DW_AT_name("BTS_ADC1")
	.dwattr $C$DW$62, DW_AT_linkage_name("BTS_ADC1")
	.dwattr $C$DW$62, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$62, DW_AT_declaration
	.dwattr $C$DW$62, DW_AT_external
	.dwattr $C$DW$62, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$62, DW_AT_decl_line(0x41)
	.dwattr $C$DW$62, DW_AT_decl_column(0x12)

$C$DW$63	.dwtag  DW_TAG_variable
	.dwattr $C$DW$63, DW_AT_name("BTS_ADC2")
	.dwattr $C$DW$63, DW_AT_linkage_name("BTS_ADC2")
	.dwattr $C$DW$63, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$63, DW_AT_declaration
	.dwattr $C$DW$63, DW_AT_external
	.dwattr $C$DW$63, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$63, DW_AT_decl_line(0x42)
	.dwattr $C$DW$63, DW_AT_decl_column(0x12)

$C$DW$64	.dwtag  DW_TAG_variable
	.dwattr $C$DW$64, DW_AT_name("BTS_ctrl_cc_ch1")
	.dwattr $C$DW$64, DW_AT_linkage_name("BTS_ctrl_cc_ch1")
	.dwattr $C$DW$64, DW_AT_type(*$C$DW$T$99)
	.dwattr $C$DW$64, DW_AT_declaration
	.dwattr $C$DW$64, DW_AT_external
	.dwattr $C$DW$64, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$64, DW_AT_decl_line(0xbd)
	.dwattr $C$DW$64, DW_AT_decl_column(0x25)

$C$DW$65	.dwtag  DW_TAG_variable
	.dwattr $C$DW$65, DW_AT_name("BTS_ctrl_cv_ch1")
	.dwattr $C$DW$65, DW_AT_linkage_name("BTS_ctrl_cv_ch1")
	.dwattr $C$DW$65, DW_AT_type(*$C$DW$T$99)
	.dwattr $C$DW$65, DW_AT_declaration
	.dwattr $C$DW$65, DW_AT_external
	.dwattr $C$DW$65, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$65, DW_AT_decl_line(0xc6)
	.dwattr $C$DW$65, DW_AT_decl_column(0x25)

$C$DW$66	.dwtag  DW_TAG_variable
	.dwattr $C$DW$66, DW_AT_name("BTS_userInput_ch1")
	.dwattr $C$DW$66, DW_AT_linkage_name("BTS_userInput_ch1")
	.dwattr $C$DW$66, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$66, DW_AT_declaration
	.dwattr $C$DW$66, DW_AT_external
	.dwattr $C$DW$66, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$66, DW_AT_decl_line(0x8c)
	.dwattr $C$DW$66, DW_AT_decl_column(0x16)

$C$DW$67	.dwtag  DW_TAG_variable
	.dwattr $C$DW$67, DW_AT_name("BTS_userInput_ch2")
	.dwattr $C$DW$67, DW_AT_linkage_name("BTS_userInput_ch2")
	.dwattr $C$DW$67, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$67, DW_AT_declaration
	.dwattr $C$DW$67, DW_AT_external
	.dwattr $C$DW$67, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$67, DW_AT_decl_line(0x8d)
	.dwattr $C$DW$67, DW_AT_decl_column(0x16)

$C$DW$68	.dwtag  DW_TAG_variable
	.dwattr $C$DW$68, DW_AT_name("BTS_userInput_ch3")
	.dwattr $C$DW$68, DW_AT_linkage_name("BTS_userInput_ch3")
	.dwattr $C$DW$68, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$68, DW_AT_declaration
	.dwattr $C$DW$68, DW_AT_external
	.dwattr $C$DW$68, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$68, DW_AT_decl_line(0x8e)
	.dwattr $C$DW$68, DW_AT_decl_column(0x16)

$C$DW$69	.dwtag  DW_TAG_variable
	.dwattr $C$DW$69, DW_AT_name("BTS_userInput_ch4")
	.dwattr $C$DW$69, DW_AT_linkage_name("BTS_userInput_ch4")
	.dwattr $C$DW$69, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$69, DW_AT_declaration
	.dwattr $C$DW$69, DW_AT_external
	.dwattr $C$DW$69, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$69, DW_AT_decl_line(0x8f)
	.dwattr $C$DW$69, DW_AT_decl_column(0x16)

$C$DW$70	.dwtag  DW_TAG_variable
	.dwattr $C$DW$70, DW_AT_name("BTS_userInput_ch5")
	.dwattr $C$DW$70, DW_AT_linkage_name("BTS_userInput_ch5")
	.dwattr $C$DW$70, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$70, DW_AT_declaration
	.dwattr $C$DW$70, DW_AT_external
	.dwattr $C$DW$70, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$70, DW_AT_decl_line(0x90)
	.dwattr $C$DW$70, DW_AT_decl_column(0x16)

$C$DW$71	.dwtag  DW_TAG_variable
	.dwattr $C$DW$71, DW_AT_name("BTS_userInput_ch6")
	.dwattr $C$DW$71, DW_AT_linkage_name("BTS_userInput_ch6")
	.dwattr $C$DW$71, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$71, DW_AT_declaration
	.dwattr $C$DW$71, DW_AT_external
	.dwattr $C$DW$71, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$71, DW_AT_decl_line(0x91)
	.dwattr $C$DW$71, DW_AT_decl_column(0x16)

$C$DW$72	.dwtag  DW_TAG_variable
	.dwattr $C$DW$72, DW_AT_name("BTS_userInput_ch7")
	.dwattr $C$DW$72, DW_AT_linkage_name("BTS_userInput_ch7")
	.dwattr $C$DW$72, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$72, DW_AT_declaration
	.dwattr $C$DW$72, DW_AT_external
	.dwattr $C$DW$72, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$72, DW_AT_decl_line(0x92)
	.dwattr $C$DW$72, DW_AT_decl_column(0x16)

$C$DW$73	.dwtag  DW_TAG_variable
	.dwattr $C$DW$73, DW_AT_name("BTS_userInput_ch8")
	.dwattr $C$DW$73, DW_AT_linkage_name("BTS_userInput_ch8")
	.dwattr $C$DW$73, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$73, DW_AT_declaration
	.dwattr $C$DW$73, DW_AT_external
	.dwattr $C$DW$73, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$73, DW_AT_decl_line(0x93)
	.dwattr $C$DW$73, DW_AT_decl_column(0x16)

$C$DW$74	.dwtag  DW_TAG_variable
	.dwattr $C$DW$74, DW_AT_name("BTS_sfra")
	.dwattr $C$DW$74, DW_AT_linkage_name("BTS_sfra")
	.dwattr $C$DW$74, DW_AT_type(*$C$DW$T$67)
	.dwattr $C$DW$74, DW_AT_declaration
	.dwattr $C$DW$74, DW_AT_external
	.dwattr $C$DW$74, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$74, DW_AT_decl_line(0x142)
	.dwattr $C$DW$74, DW_AT_decl_column(0x15)

$C$DW$75	.dwtag  DW_TAG_variable
	.dwattr $C$DW$75, DW_AT_name("BTS_ctrlLoopVariable_ch1")
	.dwattr $C$DW$75, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch1")
	.dwattr $C$DW$75, DW_AT_type(*$C$DW$T$73)
	.dwattr $C$DW$75, DW_AT_declaration
	.dwattr $C$DW$75, DW_AT_external
	.dwattr $C$DW$75, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$75, DW_AT_decl_line(0xb3)
	.dwattr $C$DW$75, DW_AT_decl_column(0x1d)

$C$DW$76	.dwtag  DW_TAG_variable
	.dwattr $C$DW$76, DW_AT_name("BTS_ctrlLoopVariable_ch2")
	.dwattr $C$DW$76, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch2")
	.dwattr $C$DW$76, DW_AT_type(*$C$DW$T$73)
	.dwattr $C$DW$76, DW_AT_declaration
	.dwattr $C$DW$76, DW_AT_external
	.dwattr $C$DW$76, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$76, DW_AT_decl_line(0xb4)
	.dwattr $C$DW$76, DW_AT_decl_column(0x1d)

$C$DW$77	.dwtag  DW_TAG_variable
	.dwattr $C$DW$77, DW_AT_name("BTS_ctrlLoopVariable_ch3")
	.dwattr $C$DW$77, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch3")
	.dwattr $C$DW$77, DW_AT_type(*$C$DW$T$73)
	.dwattr $C$DW$77, DW_AT_declaration
	.dwattr $C$DW$77, DW_AT_external
	.dwattr $C$DW$77, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$77, DW_AT_decl_line(0xb5)
	.dwattr $C$DW$77, DW_AT_decl_column(0x1d)

$C$DW$78	.dwtag  DW_TAG_variable
	.dwattr $C$DW$78, DW_AT_name("BTS_ctrlLoopVariable_ch4")
	.dwattr $C$DW$78, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch4")
	.dwattr $C$DW$78, DW_AT_type(*$C$DW$T$73)
	.dwattr $C$DW$78, DW_AT_declaration
	.dwattr $C$DW$78, DW_AT_external
	.dwattr $C$DW$78, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$78, DW_AT_decl_line(0xb6)
	.dwattr $C$DW$78, DW_AT_decl_column(0x1d)

$C$DW$79	.dwtag  DW_TAG_variable
	.dwattr $C$DW$79, DW_AT_name("BTS_ctrlLoopVariable_ch5")
	.dwattr $C$DW$79, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch5")
	.dwattr $C$DW$79, DW_AT_type(*$C$DW$T$73)
	.dwattr $C$DW$79, DW_AT_declaration
	.dwattr $C$DW$79, DW_AT_external
	.dwattr $C$DW$79, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$79, DW_AT_decl_line(0xb7)
	.dwattr $C$DW$79, DW_AT_decl_column(0x1d)

$C$DW$80	.dwtag  DW_TAG_variable
	.dwattr $C$DW$80, DW_AT_name("BTS_ctrlLoopVariable_ch6")
	.dwattr $C$DW$80, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch6")
	.dwattr $C$DW$80, DW_AT_type(*$C$DW$T$73)
	.dwattr $C$DW$80, DW_AT_declaration
	.dwattr $C$DW$80, DW_AT_external
	.dwattr $C$DW$80, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$80, DW_AT_decl_line(0xb8)
	.dwattr $C$DW$80, DW_AT_decl_column(0x1d)

$C$DW$81	.dwtag  DW_TAG_variable
	.dwattr $C$DW$81, DW_AT_name("BTS_ctrlLoopVariable_ch7")
	.dwattr $C$DW$81, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch7")
	.dwattr $C$DW$81, DW_AT_type(*$C$DW$T$73)
	.dwattr $C$DW$81, DW_AT_declaration
	.dwattr $C$DW$81, DW_AT_external
	.dwattr $C$DW$81, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$81, DW_AT_decl_line(0xb9)
	.dwattr $C$DW$81, DW_AT_decl_column(0x1d)

$C$DW$82	.dwtag  DW_TAG_variable
	.dwattr $C$DW$82, DW_AT_name("BTS_ctrlLoopVariable_ch8")
	.dwattr $C$DW$82, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch8")
	.dwattr $C$DW$82, DW_AT_type(*$C$DW$T$73)
	.dwattr $C$DW$82, DW_AT_declaration
	.dwattr $C$DW$82, DW_AT_external
	.dwattr $C$DW$82, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$82, DW_AT_decl_line(0xba)
	.dwattr $C$DW$82, DW_AT_decl_column(0x1d)

$C$DW$83	.dwtag  DW_TAG_variable
	.dwattr $C$DW$83, DW_AT_name("BTS_measValues_ch1")
	.dwattr $C$DW$83, DW_AT_linkage_name("BTS_measValues_ch1")
	.dwattr $C$DW$83, DW_AT_type(*$C$DW$T$76)
	.dwattr $C$DW$83, DW_AT_declaration
	.dwattr $C$DW$83, DW_AT_external
	.dwattr $C$DW$83, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$83, DW_AT_decl_line(0x6d)
	.dwattr $C$DW$83, DW_AT_decl_column(0x17)

$C$DW$84	.dwtag  DW_TAG_variable
	.dwattr $C$DW$84, DW_AT_name("BTS_measValues_ch2")
	.dwattr $C$DW$84, DW_AT_linkage_name("BTS_measValues_ch2")
	.dwattr $C$DW$84, DW_AT_type(*$C$DW$T$76)
	.dwattr $C$DW$84, DW_AT_declaration
	.dwattr $C$DW$84, DW_AT_external
	.dwattr $C$DW$84, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$84, DW_AT_decl_line(0x6e)
	.dwattr $C$DW$84, DW_AT_decl_column(0x17)

$C$DW$85	.dwtag  DW_TAG_variable
	.dwattr $C$DW$85, DW_AT_name("BTS_measValues_ch3")
	.dwattr $C$DW$85, DW_AT_linkage_name("BTS_measValues_ch3")
	.dwattr $C$DW$85, DW_AT_type(*$C$DW$T$76)
	.dwattr $C$DW$85, DW_AT_declaration
	.dwattr $C$DW$85, DW_AT_external
	.dwattr $C$DW$85, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$85, DW_AT_decl_line(0x6f)
	.dwattr $C$DW$85, DW_AT_decl_column(0x17)

$C$DW$86	.dwtag  DW_TAG_variable
	.dwattr $C$DW$86, DW_AT_name("BTS_measValues_ch4")
	.dwattr $C$DW$86, DW_AT_linkage_name("BTS_measValues_ch4")
	.dwattr $C$DW$86, DW_AT_type(*$C$DW$T$76)
	.dwattr $C$DW$86, DW_AT_declaration
	.dwattr $C$DW$86, DW_AT_external
	.dwattr $C$DW$86, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$86, DW_AT_decl_line(0x70)
	.dwattr $C$DW$86, DW_AT_decl_column(0x17)

$C$DW$87	.dwtag  DW_TAG_variable
	.dwattr $C$DW$87, DW_AT_name("BTS_measValues_ch5")
	.dwattr $C$DW$87, DW_AT_linkage_name("BTS_measValues_ch5")
	.dwattr $C$DW$87, DW_AT_type(*$C$DW$T$76)
	.dwattr $C$DW$87, DW_AT_declaration
	.dwattr $C$DW$87, DW_AT_external
	.dwattr $C$DW$87, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$87, DW_AT_decl_line(0x71)
	.dwattr $C$DW$87, DW_AT_decl_column(0x17)

$C$DW$88	.dwtag  DW_TAG_variable
	.dwattr $C$DW$88, DW_AT_name("BTS_measValues_ch6")
	.dwattr $C$DW$88, DW_AT_linkage_name("BTS_measValues_ch6")
	.dwattr $C$DW$88, DW_AT_type(*$C$DW$T$76)
	.dwattr $C$DW$88, DW_AT_declaration
	.dwattr $C$DW$88, DW_AT_external
	.dwattr $C$DW$88, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$88, DW_AT_decl_line(0x72)
	.dwattr $C$DW$88, DW_AT_decl_column(0x17)

$C$DW$89	.dwtag  DW_TAG_variable
	.dwattr $C$DW$89, DW_AT_name("BTS_measValues_ch7")
	.dwattr $C$DW$89, DW_AT_linkage_name("BTS_measValues_ch7")
	.dwattr $C$DW$89, DW_AT_type(*$C$DW$T$76)
	.dwattr $C$DW$89, DW_AT_declaration
	.dwattr $C$DW$89, DW_AT_external
	.dwattr $C$DW$89, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$89, DW_AT_decl_line(0x73)
	.dwattr $C$DW$89, DW_AT_decl_column(0x17)

$C$DW$90	.dwtag  DW_TAG_variable
	.dwattr $C$DW$90, DW_AT_name("BTS_measValues_ch8")
	.dwattr $C$DW$90, DW_AT_linkage_name("BTS_measValues_ch8")
	.dwattr $C$DW$90, DW_AT_type(*$C$DW$T$76)
	.dwattr $C$DW$90, DW_AT_declaration
	.dwattr $C$DW$90, DW_AT_external
	.dwattr $C$DW$90, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$90, DW_AT_decl_line(0x74)
	.dwattr $C$DW$90, DW_AT_decl_column(0x17)

	.sblock	".bss"
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\opt2000.exe C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{4B912775-DCDB-4FF7-B3E4-E9FFC4917DC0} C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{45AB3413-9035-4D8A-8205-56223DEE8445} 
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\acia2000.exe -@C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{07BED1F0-3A36-425F-8344-AE70BD37D92B} 
	.sect	".text"
	.clink
	.global	||C3||

$C$DW$91	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$91, DW_AT_name("C3")
	.dwattr $C$DW$91, DW_AT_low_pc(||C3||)
	.dwattr $C$DW$91, DW_AT_high_pc(0x00)
	.dwattr $C$DW$91, DW_AT_linkage_name("C3")
	.dwattr $C$DW$91, DW_AT_external
	.dwattr $C$DW$91, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$91, DW_AT_decl_line(0x1cc)
	.dwattr $C$DW$91, DW_AT_decl_column(0x06)
	.dwattr $C$DW$91, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 461,column 1,is_stmt,address ||C3||,isa 0

	.dwfde $C$DW$CIE, ||C3||

;***************************************************************
;* FNAME: C3                            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||C3||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../bts_main.c",line 467,column 5,is_stmt,isa 0
        MOVL      XAR4,#||C1||          ; [CPU_ARAU] |467| 
        MOVW      DP,#||C_Task_Ptr||    ; [CPU_ARAU] 
        MOVL      @||C_Task_Ptr||,XAR4  ; [CPU_ALU] |467| 
$C$DW$92	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$92, DW_AT_low_pc(0x00)
	.dwattr $C$DW$92, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$91, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$91, DW_AT_TI_end_line(0x1d4)
	.dwattr $C$DW$91, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$91

	.sect	".text"
	.clink
	.global	||C2||

$C$DW$93	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$93, DW_AT_name("C2")
	.dwattr $C$DW$93, DW_AT_low_pc(||C2||)
	.dwattr $C$DW$93, DW_AT_high_pc(0x00)
	.dwattr $C$DW$93, DW_AT_linkage_name("C2")
	.dwattr $C$DW$93, DW_AT_external
	.dwattr $C$DW$93, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$93, DW_AT_decl_line(0x1c2)
	.dwattr $C$DW$93, DW_AT_decl_column(0x06)
	.dwattr $C$DW$93, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 451,column 1,is_stmt,address ||C2||,isa 0

	.dwfde $C$DW$CIE, ||C2||

;***************************************************************
;* FNAME: C2                            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||C2||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../bts_main.c",line 457,column 5,is_stmt,isa 0
        MOVL      XAR4,#||C3||          ; [CPU_ARAU] |457| 
        MOVW      DP,#||C_Task_Ptr||    ; [CPU_ARAU] 
        MOVL      @||C_Task_Ptr||,XAR4  ; [CPU_ALU] |457| 
$C$DW$94	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$94, DW_AT_low_pc(0x00)
	.dwattr $C$DW$94, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$93, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$93, DW_AT_TI_end_line(0x1ca)
	.dwattr $C$DW$93, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$93

	.sect	".text"
	.clink
	.global	||B3||

$C$DW$95	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$95, DW_AT_name("B3")
	.dwattr $C$DW$95, DW_AT_low_pc(||B3||)
	.dwattr $C$DW$95, DW_AT_high_pc(0x00)
	.dwattr $C$DW$95, DW_AT_linkage_name("B3")
	.dwattr $C$DW$95, DW_AT_external
	.dwattr $C$DW$95, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$95, DW_AT_decl_line(0x19d)
	.dwattr $C$DW$95, DW_AT_decl_column(0x06)
	.dwattr $C$DW$95, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 414,column 1,is_stmt,address ||B3||,isa 0

	.dwfde $C$DW$CIE, ||B3||

;***************************************************************
;* FNAME: B3                            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||B3||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../bts_main.c",line 422,column 5,is_stmt,isa 0
        MOVL      XAR4,#||B1||          ; [CPU_ARAU] |422| 
        MOVW      DP,#||B_Task_Ptr||    ; [CPU_ARAU] 
        MOVL      @||B_Task_Ptr||,XAR4  ; [CPU_ALU] |422| 
$C$DW$96	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$96, DW_AT_low_pc(0x00)
	.dwattr $C$DW$96, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$95, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$95, DW_AT_TI_end_line(0x1a7)
	.dwattr $C$DW$95, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$95

	.sect	".text"
	.clink
	.global	||B2||

$C$DW$97	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$97, DW_AT_name("B2")
	.dwattr $C$DW$97, DW_AT_low_pc(||B2||)
	.dwattr $C$DW$97, DW_AT_high_pc(0x00)
	.dwattr $C$DW$97, DW_AT_linkage_name("B2")
	.dwattr $C$DW$97, DW_AT_external
	.dwattr $C$DW$97, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$97, DW_AT_decl_line(0x190)
	.dwattr $C$DW$97, DW_AT_decl_column(0x06)
	.dwattr $C$DW$97, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 401,column 1,is_stmt,address ||B2||,isa 0

	.dwfde $C$DW$CIE, ||B2||

;***************************************************************
;* FNAME: B2                            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||B2||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../bts_main.c",line 405,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_sfra||    ; [CPU_ARAU] |405| 
$C$DW$98	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$98, DW_AT_low_pc(0x00)
	.dwattr $C$DW$98, DW_AT_name("SFRA_F32_runBackgroundTask")
	.dwattr $C$DW$98, DW_AT_TI_call

        LCR       #||SFRA_F32_runBackgroundTask|| ; [CPU_ALU] |405| 
        ; call occurs [#||SFRA_F32_runBackgroundTask||] ; [] |405| 
        MOVW      DP,#||B_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 410,column 5,is_stmt,isa 0
        MOVL      XAR4,#||B3||          ; [CPU_ARAU] |410| 
        MOVL      @||B_Task_Ptr||,XAR4  ; [CPU_ALU] |410| 
$C$DW$99	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$99, DW_AT_low_pc(0x00)
	.dwattr $C$DW$99, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$97, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$97, DW_AT_TI_end_line(0x19b)
	.dwattr $C$DW$97, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$97

	.sect	".text"
	.clink
	.global	||A3||

$C$DW$100	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$100, DW_AT_name("A3")
	.dwattr $C$DW$100, DW_AT_low_pc(||A3||)
	.dwattr $C$DW$100, DW_AT_high_pc(0x00)
	.dwattr $C$DW$100, DW_AT_linkage_name("A3")
	.dwattr $C$DW$100, DW_AT_external
	.dwattr $C$DW$100, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$100, DW_AT_decl_line(0x172)
	.dwattr $C$DW$100, DW_AT_decl_column(0x06)
	.dwattr $C$DW$100, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 371,column 1,is_stmt,address ||A3||,isa 0

	.dwfde $C$DW$CIE, ||A3||

;***************************************************************
;* FNAME: A3                            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||A3||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 367,column 9,is_stmt,isa 0
$C$DW$101	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$101, DW_AT_low_pc(0x00)
	.dwattr $C$DW$101, DW_AT_name("SFO")
	.dwattr $C$DW$101, DW_AT_TI_call

        LCR       #||SFO||              ; [CPU_ALU] |367| 
        ; call occurs [#||SFO||] ; [] |367| 
        MOVW      DP,#||A_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 380,column 5,is_stmt,isa 0
        MOVL      XAR4,#||A1||          ; [CPU_ARAU] |380| 
        MOVL      @||A_Task_Ptr||,XAR4  ; [CPU_ALU] |380| 
        MOVW      DP,#||BTS_sfoStatus|| ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 367,column 9,is_stmt,isa 0
        MOV       @||BTS_sfoStatus||,AL ; [CPU_ALU] |367| 
$C$DW$102	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$102, DW_AT_low_pc(0x00)
	.dwattr $C$DW$102, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$100, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$100, DW_AT_TI_end_line(0x17d)
	.dwattr $C$DW$100, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$100

	.sect	".text"
	.clink
	.global	||A2||

$C$DW$103	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$103, DW_AT_name("A2")
	.dwattr $C$DW$103, DW_AT_low_pc(||A2||)
	.dwattr $C$DW$103, DW_AT_high_pc(0x00)
	.dwattr $C$DW$103, DW_AT_linkage_name("A2")
	.dwattr $C$DW$103, DW_AT_external
	.dwattr $C$DW$103, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$103, DW_AT_decl_line(0x165)
	.dwattr $C$DW$103, DW_AT_decl_column(0x06)
	.dwattr $C$DW$103, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 358,column 1,is_stmt,address ||A2||,isa 0

	.dwfde $C$DW$CIE, ||A2||

;***************************************************************
;* FNAME: A2                            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||A2||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../bts_main.c",line 362,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_sfra||    ; [CPU_ARAU] |362| 
$C$DW$104	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$104, DW_AT_low_pc(0x00)
	.dwattr $C$DW$104, DW_AT_name("SFRA_GUI_runSerialHostComms")
	.dwattr $C$DW$104, DW_AT_TI_call

        LCR       #||SFRA_GUI_runSerialHostComms|| ; [CPU_ALU] |362| 
        ; call occurs [#||SFRA_GUI_runSerialHostComms||] ; [] |362| 
        MOVW      DP,#||A_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 367,column 5,is_stmt,isa 0
        MOVL      XAR4,#||A3||          ; [CPU_ARAU] |367| 
        MOVL      @||A_Task_Ptr||,XAR4  ; [CPU_ALU] |367| 
$C$DW$105	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$105, DW_AT_low_pc(0x00)
	.dwattr $C$DW$105, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$103, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$103, DW_AT_TI_end_line(0x170)
	.dwattr $C$DW$103, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$103

	.sect	".text"
	.clink
	.global	||C1||

$C$DW$106	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$106, DW_AT_name("C1")
	.dwattr $C$DW$106, DW_AT_low_pc(||C1||)
	.dwattr $C$DW$106, DW_AT_high_pc(0x00)
	.dwattr $C$DW$106, DW_AT_linkage_name("C1")
	.dwattr $C$DW$106, DW_AT_external
	.dwattr $C$DW$106, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$106, DW_AT_decl_line(0x1ae)
	.dwattr $C$DW$106, DW_AT_decl_column(0x06)
	.dwattr $C$DW$106, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 431,column 1,is_stmt,address ||C1||,isa 0

	.dwfde $C$DW$CIE, ||C1||

;***************************************************************
;* FNAME: C1                            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||C1||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../bts_main.c",line 434,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_measValues_ch1|| ; [CPU_ARAU] |434| 
$C$DW$107	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$107, DW_AT_low_pc(0x00)
	.dwattr $C$DW$107, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$107, DW_AT_TI_call

        LCR       #||BTS_monitor_Iout_Vout|| ; [CPU_ALU] |434| 
        ; call occurs [#||BTS_monitor_Iout_Vout||] ; [] |434| 
	.dwpsn	file "../bts_main.c",line 435,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_measValues_ch2|| ; [CPU_ARAU] |435| 
$C$DW$108	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$108, DW_AT_low_pc(0x00)
	.dwattr $C$DW$108, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$108, DW_AT_TI_call

        LCR       #||BTS_monitor_Iout_Vout|| ; [CPU_ALU] |435| 
        ; call occurs [#||BTS_monitor_Iout_Vout||] ; [] |435| 
	.dwpsn	file "../bts_main.c",line 436,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_measValues_ch3|| ; [CPU_ARAU] |436| 
$C$DW$109	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$109, DW_AT_low_pc(0x00)
	.dwattr $C$DW$109, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$109, DW_AT_TI_call

        LCR       #||BTS_monitor_Iout_Vout|| ; [CPU_ALU] |436| 
        ; call occurs [#||BTS_monitor_Iout_Vout||] ; [] |436| 
	.dwpsn	file "../bts_main.c",line 437,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_measValues_ch4|| ; [CPU_ARAU] |437| 
$C$DW$110	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$110, DW_AT_low_pc(0x00)
	.dwattr $C$DW$110, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$110, DW_AT_TI_call

        LCR       #||BTS_monitor_Iout_Vout|| ; [CPU_ALU] |437| 
        ; call occurs [#||BTS_monitor_Iout_Vout||] ; [] |437| 
	.dwpsn	file "../bts_main.c",line 438,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_measValues_ch5|| ; [CPU_ARAU] |438| 
$C$DW$111	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$111, DW_AT_low_pc(0x00)
	.dwattr $C$DW$111, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$111, DW_AT_TI_call

        LCR       #||BTS_monitor_Iout_Vout|| ; [CPU_ALU] |438| 
        ; call occurs [#||BTS_monitor_Iout_Vout||] ; [] |438| 
	.dwpsn	file "../bts_main.c",line 439,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_measValues_ch6|| ; [CPU_ARAU] |439| 
$C$DW$112	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$112, DW_AT_low_pc(0x00)
	.dwattr $C$DW$112, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$112, DW_AT_TI_call

        LCR       #||BTS_monitor_Iout_Vout|| ; [CPU_ALU] |439| 
        ; call occurs [#||BTS_monitor_Iout_Vout||] ; [] |439| 
	.dwpsn	file "../bts_main.c",line 440,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_measValues_ch7|| ; [CPU_ARAU] |440| 
$C$DW$113	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$113, DW_AT_low_pc(0x00)
	.dwattr $C$DW$113, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$113, DW_AT_TI_call

        LCR       #||BTS_monitor_Iout_Vout|| ; [CPU_ALU] |440| 
        ; call occurs [#||BTS_monitor_Iout_Vout||] ; [] |440| 
	.dwpsn	file "../bts_main.c",line 441,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_measValues_ch8|| ; [CPU_ARAU] |441| 
$C$DW$114	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$114, DW_AT_low_pc(0x00)
	.dwattr $C$DW$114, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$114, DW_AT_TI_call

        LCR       #||BTS_monitor_Iout_Vout|| ; [CPU_ALU] |441| 
        ; call occurs [#||BTS_monitor_Iout_Vout||] ; [] |441| 
        MOVW      DP,#||C_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 447,column 5,is_stmt,isa 0
        MOVL      XAR4,#||C2||          ; [CPU_ARAU] |447| 
        MOVL      @||C_Task_Ptr||,XAR4  ; [CPU_ALU] |447| 
$C$DW$115	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$115, DW_AT_low_pc(0x00)
	.dwattr $C$DW$115, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$106, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$106, DW_AT_TI_end_line(0x1c0)
	.dwattr $C$DW$106, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$106

	.sect	".text"
	.clink
	.global	||B1||

$C$DW$116	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$116, DW_AT_name("B1")
	.dwattr $C$DW$116, DW_AT_low_pc(||B1||)
	.dwattr $C$DW$116, DW_AT_high_pc(0x00)
	.dwattr $C$DW$116, DW_AT_linkage_name("B1")
	.dwattr $C$DW$116, DW_AT_external
	.dwattr $C$DW$116, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$116, DW_AT_decl_line(0x184)
	.dwattr $C$DW$116, DW_AT_decl_column(0x06)
	.dwattr $C$DW$116, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 389,column 1,is_stmt,address ||B1||,isa 0

	.dwfde $C$DW$CIE, ||B1||

;***************************************************************
;* FNAME: B1                            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||B1||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../bts_main.c",line 397,column 5,is_stmt,isa 0
        MOVL      XAR4,#||B2||          ; [CPU_ARAU] |397| 
        MOVW      DP,#||B_Task_Ptr||    ; [CPU_ARAU] 
        MOVL      @||B_Task_Ptr||,XAR4  ; [CPU_ALU] |397| 
$C$DW$117	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$117, DW_AT_low_pc(0x00)
	.dwattr $C$DW$117, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$116, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$116, DW_AT_TI_end_line(0x18e)
	.dwattr $C$DW$116, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$116

	.sect	".text"
	.clink
	.global	||A1||

$C$DW$118	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$118, DW_AT_name("A1")
	.dwattr $C$DW$118, DW_AT_low_pc(||A1||)
	.dwattr $C$DW$118, DW_AT_high_pc(0x00)
	.dwattr $C$DW$118, DW_AT_linkage_name("A1")
	.dwattr $C$DW$118, DW_AT_external
	.dwattr $C$DW$118, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$118, DW_AT_decl_line(0x14f)
	.dwattr $C$DW$118, DW_AT_decl_column(0x06)
	.dwattr $C$DW$118, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 336,column 1,is_stmt,address ||A1||,isa 0

	.dwfde $C$DW$CIE, ||A1||

;***************************************************************
;* FNAME: A1                            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||A1||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../bts_main.c",line 342,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_userInput_ch1|| ; [CPU_ARAU] |342| 
        MOVL      XAR5,#||BTS_ctrlLoopVariable_ch1|| ; [CPU_ARAU] |342| 
$C$DW$119	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$119, DW_AT_low_pc(0x00)
	.dwattr $C$DW$119, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$119, DW_AT_TI_call

        LCR       #||BTS_updateReference|| ; [CPU_ALU] |342| 
        ; call occurs [#||BTS_updateReference||] ; [] |342| 
	.dwpsn	file "../bts_main.c",line 343,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_userInput_ch2|| ; [CPU_ARAU] |343| 
        MOVL      XAR5,#||BTS_ctrlLoopVariable_ch2|| ; [CPU_ARAU] |343| 
$C$DW$120	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$120, DW_AT_low_pc(0x00)
	.dwattr $C$DW$120, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$120, DW_AT_TI_call

        LCR       #||BTS_updateReference|| ; [CPU_ALU] |343| 
        ; call occurs [#||BTS_updateReference||] ; [] |343| 
	.dwpsn	file "../bts_main.c",line 344,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_userInput_ch3|| ; [CPU_ARAU] |344| 
        MOVL      XAR5,#||BTS_ctrlLoopVariable_ch3|| ; [CPU_ARAU] |344| 
$C$DW$121	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$121, DW_AT_low_pc(0x00)
	.dwattr $C$DW$121, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$121, DW_AT_TI_call

        LCR       #||BTS_updateReference|| ; [CPU_ALU] |344| 
        ; call occurs [#||BTS_updateReference||] ; [] |344| 
	.dwpsn	file "../bts_main.c",line 345,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_userInput_ch4|| ; [CPU_ARAU] |345| 
        MOVL      XAR5,#||BTS_ctrlLoopVariable_ch4|| ; [CPU_ARAU] |345| 
$C$DW$122	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$122, DW_AT_low_pc(0x00)
	.dwattr $C$DW$122, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$122, DW_AT_TI_call

        LCR       #||BTS_updateReference|| ; [CPU_ALU] |345| 
        ; call occurs [#||BTS_updateReference||] ; [] |345| 
	.dwpsn	file "../bts_main.c",line 346,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_userInput_ch5|| ; [CPU_ARAU] |346| 
        MOVL      XAR5,#||BTS_ctrlLoopVariable_ch5|| ; [CPU_ARAU] |346| 
$C$DW$123	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$123, DW_AT_low_pc(0x00)
	.dwattr $C$DW$123, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$123, DW_AT_TI_call

        LCR       #||BTS_updateReference|| ; [CPU_ALU] |346| 
        ; call occurs [#||BTS_updateReference||] ; [] |346| 
	.dwpsn	file "../bts_main.c",line 347,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_userInput_ch6|| ; [CPU_ARAU] |347| 
        MOVL      XAR5,#||BTS_ctrlLoopVariable_ch6|| ; [CPU_ARAU] |347| 
$C$DW$124	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$124, DW_AT_low_pc(0x00)
	.dwattr $C$DW$124, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$124, DW_AT_TI_call

        LCR       #||BTS_updateReference|| ; [CPU_ALU] |347| 
        ; call occurs [#||BTS_updateReference||] ; [] |347| 
	.dwpsn	file "../bts_main.c",line 348,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_userInput_ch7|| ; [CPU_ARAU] |348| 
        MOVL      XAR5,#||BTS_ctrlLoopVariable_ch7|| ; [CPU_ARAU] |348| 
$C$DW$125	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$125, DW_AT_low_pc(0x00)
	.dwattr $C$DW$125, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$125, DW_AT_TI_call

        LCR       #||BTS_updateReference|| ; [CPU_ALU] |348| 
        ; call occurs [#||BTS_updateReference||] ; [] |348| 
	.dwpsn	file "../bts_main.c",line 349,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_userInput_ch8|| ; [CPU_ARAU] |349| 
        MOVL      XAR5,#||BTS_ctrlLoopVariable_ch8|| ; [CPU_ARAU] |349| 
$C$DW$126	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$126, DW_AT_low_pc(0x00)
	.dwattr $C$DW$126, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$126, DW_AT_TI_call

        LCR       #||BTS_updateReference|| ; [CPU_ALU] |349| 
        ; call occurs [#||BTS_updateReference||] ; [] |349| 
        MOVW      DP,#||A_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 354,column 5,is_stmt,isa 0
        MOVL      XAR4,#||A2||          ; [CPU_ARAU] |354| 
        MOVL      @||A_Task_Ptr||,XAR4  ; [CPU_ALU] |354| 
$C$DW$127	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$127, DW_AT_low_pc(0x00)
	.dwattr $C$DW$127, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$118, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$118, DW_AT_TI_end_line(0x163)
	.dwattr $C$DW$118, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$118

	.sect	".text"
	.clink
	.global	||A0||

$C$DW$128	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$128, DW_AT_name("A0")
	.dwattr $C$DW$128, DW_AT_low_pc(||A0||)
	.dwattr $C$DW$128, DW_AT_high_pc(0x00)
	.dwattr $C$DW$128, DW_AT_linkage_name("A0")
	.dwattr $C$DW$128, DW_AT_external
	.dwattr $C$DW$128, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$128, DW_AT_decl_line(0x10f)
	.dwattr $C$DW$128, DW_AT_decl_column(0x06)
	.dwattr $C$DW$128, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 272,column 1,is_stmt,address ||A0||,isa 0

	.dwfde $C$DW$CIE, ||A0||

;***************************************************************
;* FNAME: A0                            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||A0||:
;* AL    assigned to $O$R1
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 393,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c04)        ; [CPU_ALU] |393| 
        LSR       AL,15                 ; [CPU_ALU] |393| 
	.dwpsn	file "../bts_main.c",line 276,column 5,is_stmt,isa 0
        CMPB      AL,#1                 ; [CPU_ALU] |276| 
        B         ||$C$L1||,NEQ         ; [CPU_ALU] |276| 
        ; branchcc occurs ; [] |276| 
        MOVW      DP,#||A_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 169,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c04)        ; [CPU_ALU] |169| 
	.dwpsn	file "../bts_main.c",line 283,column 9,is_stmt,isa 0
        MOVL      XAR7,@||A_Task_Ptr||  ; [CPU_ALU] |283| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 169,column 5,is_stmt,isa 0
        OR        AL,#0x8000            ; [CPU_ALU] |169| 
        MOV       *(0:0x0c04),AL        ; [CPU_ALU] |169| 
	.dwpsn	file "../bts_main.c",line 283,column 9,is_stmt,isa 0
$C$DW$129	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$129, DW_AT_low_pc(0x00)
	.dwattr $C$DW$129, DW_AT_TI_call
	.dwattr $C$DW$129, DW_AT_TI_indirect

        LCR       *XAR7                 ; [CPU_ALU] |283| 
        ; call occurs [XAR7] ; [] |283| 
        MOVW      DP,#||vTimer0||       ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 285,column 9,is_stmt,isa 0
        INC       @||vTimer0||          ; [CPU_ALU] |285| 
||$C$L1||:    
	.dwpsn	file "../bts_main.c",line 287,column 5,is_stmt,isa 0
        MOVL      XAR4,#||B0||          ; [CPU_ARAU] |287| 
        MOVW      DP,#||Alpha_State_Ptr|| ; [CPU_ARAU] 
        MOVL      @||Alpha_State_Ptr||,XAR4 ; [CPU_ALU] |287| 
$C$DW$130	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$130, DW_AT_low_pc(0x00)
	.dwattr $C$DW$130, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$128, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$128, DW_AT_TI_end_line(0x120)
	.dwattr $C$DW$128, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$128

	.sect	".text"
	.clink
	.global	||B0||

$C$DW$131	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$131, DW_AT_name("B0")
	.dwattr $C$DW$131, DW_AT_low_pc(||B0||)
	.dwattr $C$DW$131, DW_AT_high_pc(0x00)
	.dwattr $C$DW$131, DW_AT_linkage_name("B0")
	.dwattr $C$DW$131, DW_AT_external
	.dwattr $C$DW$131, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$131, DW_AT_decl_line(0x122)
	.dwattr $C$DW$131, DW_AT_decl_column(0x06)
	.dwattr $C$DW$131, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 291,column 1,is_stmt,address ||B0||,isa 0

	.dwfde $C$DW$CIE, ||B0||

;***************************************************************
;* FNAME: B0                            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||B0||:
;* AL    assigned to $O$R1
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 393,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c0c)        ; [CPU_ALU] |393| 
        LSR       AL,15                 ; [CPU_ALU] |393| 
	.dwpsn	file "../bts_main.c",line 295,column 5,is_stmt,isa 0
        CMPB      AL,#1                 ; [CPU_ALU] |295| 
        B         ||$C$L2||,NEQ         ; [CPU_ALU] |295| 
        ; branchcc occurs ; [] |295| 
        MOVW      DP,#||B_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 169,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c0c)        ; [CPU_ALU] |169| 
	.dwpsn	file "../bts_main.c",line 302,column 9,is_stmt,isa 0
        MOVL      XAR7,@||B_Task_Ptr||  ; [CPU_ALU] |302| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 169,column 5,is_stmt,isa 0
        OR        AL,#0x8000            ; [CPU_ALU] |169| 
        MOV       *(0:0x0c0c),AL        ; [CPU_ALU] |169| 
	.dwpsn	file "../bts_main.c",line 302,column 9,is_stmt,isa 0
$C$DW$132	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$132, DW_AT_low_pc(0x00)
	.dwattr $C$DW$132, DW_AT_TI_call
	.dwattr $C$DW$132, DW_AT_TI_indirect

        LCR       *XAR7                 ; [CPU_ALU] |302| 
        ; call occurs [XAR7] ; [] |302| 
        MOVW      DP,#||vTimer1||       ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 304,column 9,is_stmt,isa 0
        INC       @||vTimer1||          ; [CPU_ALU] |304| 
||$C$L2||:    
	.dwpsn	file "../bts_main.c",line 307,column 5,is_stmt,isa 0
        MOVL      XAR4,#||C0||          ; [CPU_ARAU] |307| 
        MOVW      DP,#||Alpha_State_Ptr|| ; [CPU_ARAU] 
        MOVL      @||Alpha_State_Ptr||,XAR4 ; [CPU_ALU] |307| 
$C$DW$133	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$133, DW_AT_low_pc(0x00)
	.dwattr $C$DW$133, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$131, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$131, DW_AT_TI_end_line(0x134)
	.dwattr $C$DW$131, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$131

	.sect	".text"
	.clink
	.global	||C0||

$C$DW$134	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$134, DW_AT_name("C0")
	.dwattr $C$DW$134, DW_AT_low_pc(||C0||)
	.dwattr $C$DW$134, DW_AT_high_pc(0x00)
	.dwattr $C$DW$134, DW_AT_linkage_name("C0")
	.dwattr $C$DW$134, DW_AT_external
	.dwattr $C$DW$134, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$134, DW_AT_decl_line(0x136)
	.dwattr $C$DW$134, DW_AT_decl_column(0x06)
	.dwattr $C$DW$134, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 311,column 1,is_stmt,address ||C0||,isa 0

	.dwfde $C$DW$CIE, ||C0||

;***************************************************************
;* FNAME: C0                            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||C0||:
;* AL    assigned to $O$R1
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 393,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c14)        ; [CPU_ALU] |393| 
        LSR       AL,15                 ; [CPU_ALU] |393| 
	.dwpsn	file "../bts_main.c",line 315,column 5,is_stmt,isa 0
        CMPB      AL,#1                 ; [CPU_ALU] |315| 
        B         ||$C$L3||,NEQ         ; [CPU_ALU] |315| 
        ; branchcc occurs ; [] |315| 
        MOVW      DP,#||C_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 169,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c14)        ; [CPU_ALU] |169| 
	.dwpsn	file "../bts_main.c",line 322,column 9,is_stmt,isa 0
        MOVL      XAR7,@||C_Task_Ptr||  ; [CPU_ALU] |322| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 169,column 5,is_stmt,isa 0
        OR        AL,#0x8000            ; [CPU_ALU] |169| 
        MOV       *(0:0x0c14),AL        ; [CPU_ALU] |169| 
	.dwpsn	file "../bts_main.c",line 322,column 9,is_stmt,isa 0
$C$DW$135	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$135, DW_AT_low_pc(0x00)
	.dwattr $C$DW$135, DW_AT_TI_call
	.dwattr $C$DW$135, DW_AT_TI_indirect

        LCR       *XAR7                 ; [CPU_ALU] |322| 
        ; call occurs [XAR7] ; [] |322| 
        MOVW      DP,#||vTimer2||       ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 324,column 9,is_stmt,isa 0
        INC       @||vTimer2||          ; [CPU_ALU] |324| 
||$C$L3||:    
	.dwpsn	file "../bts_main.c",line 327,column 5,is_stmt,isa 0
        MOVL      XAR4,#||A0||          ; [CPU_ARAU] |327| 
        MOVW      DP,#||Alpha_State_Ptr|| ; [CPU_ARAU] 
        MOVL      @||Alpha_State_Ptr||,XAR4 ; [CPU_ALU] |327| 
$C$DW$136	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$136, DW_AT_low_pc(0x00)
	.dwattr $C$DW$136, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$134, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$134, DW_AT_TI_end_line(0x148)
	.dwattr $C$DW$134, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$134

	.sect	".text"
	.clink
	.global	||main||

$C$DW$137	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$137, DW_AT_name("main")
	.dwattr $C$DW$137, DW_AT_low_pc(||main||)
	.dwattr $C$DW$137, DW_AT_high_pc(0x00)
	.dwattr $C$DW$137, DW_AT_linkage_name("main")
	.dwattr $C$DW$137, DW_AT_external
	.dwattr $C$DW$137, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$137, DW_AT_decl_line(0x4b)
	.dwattr $C$DW$137, DW_AT_decl_column(0x06)
	.dwattr $C$DW$137, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 76,column 1,is_stmt,address ||main||,isa 0

	.dwfde $C$DW$CIE, ||main||

;***************************************************************
;* FNAME: main                          FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||main||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../bts_main.c",line 82,column 5,is_stmt,isa 0
$C$DW$138	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$138, DW_AT_low_pc(0x00)
	.dwattr $C$DW$138, DW_AT_name("BTS_HAL_setupDevice")
	.dwattr $C$DW$138, DW_AT_TI_call

        LCR       #||BTS_HAL_setupDevice|| ; [CPU_ALU] |82| 
        ; call occurs [#||BTS_HAL_setupDevice||] ; [] |82| 
	.dwpsn	file "../bts_main.c",line 90,column 5,is_stmt,isa 0
$C$DW$139	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$139, DW_AT_low_pc(0x00)
	.dwattr $C$DW$139, DW_AT_name("BTS_HAL_setupSyncBuckPinsGpio")
	.dwattr $C$DW$139, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPinsGpio|| ; [CPU_ALU] |90| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPinsGpio||] ; [] |90| 
	.dwpsn	file "../bts_main.c",line 92,column 5,is_stmt,isa 0
$C$DW$140	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$140, DW_AT_low_pc(0x00)
	.dwattr $C$DW$140, DW_AT_name("BTS_HAL_SetupI2C_GPIO")
	.dwattr $C$DW$140, DW_AT_TI_call

        LCR       #||BTS_HAL_SetupI2C_GPIO|| ; [CPU_ALU] |92| 
        ; call occurs [#||BTS_HAL_SetupI2C_GPIO||] ; [] |92| 
	.dwpsn	file "../bts_main.c",line 94,column 5,is_stmt,isa 0
$C$DW$141	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$141, DW_AT_low_pc(0x00)
	.dwattr $C$DW$141, DW_AT_name("BTS_HAL_SetupI2C_Init")
	.dwattr $C$DW$141, DW_AT_TI_call

        LCR       #||BTS_HAL_SetupI2C_Init|| ; [CPU_ALU] |94| 
        ; call occurs [#||BTS_HAL_SetupI2C_Init||] ; [] |94| 
        MOVW      DP,#||Alpha_State_Ptr|| ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 99,column 5,is_stmt,isa 0
        MOVL      XAR7,#||A0||          ; [CPU_ARAU] |99| 
	.dwpsn	file "../bts_main.c",line 100,column 5,is_stmt,isa 0
        MOVL      XAR6,#||A1||          ; [CPU_ARAU] |100| 
	.dwpsn	file "../bts_main.c",line 101,column 5,is_stmt,isa 0
        MOVL      XAR5,#||B1||          ; [CPU_ARAU] |101| 
	.dwpsn	file "../bts_main.c",line 102,column 5,is_stmt,isa 0
        MOVL      XAR4,#||C1||          ; [CPU_ARAU] |102| 
	.dwpsn	file "../bts_main.c",line 99,column 5,is_stmt,isa 0
        MOVL      @||Alpha_State_Ptr||,XAR7 ; [CPU_ALU] |99| 
	.dwpsn	file "../bts_main.c",line 100,column 5,is_stmt,isa 0
        MOVL      @||A_Task_Ptr||,XAR6  ; [CPU_ALU] |100| 
	.dwpsn	file "../bts_main.c",line 101,column 5,is_stmt,isa 0
        MOVL      @||B_Task_Ptr||,XAR5  ; [CPU_ALU] |101| 
	.dwpsn	file "../bts_main.c",line 102,column 5,is_stmt,isa 0
        MOVL      @||C_Task_Ptr||,XAR4  ; [CPU_ALU] |102| 
	.dwpsn	file "../bts_main.c",line 107,column 5,is_stmt,isa 0
$C$DW$142	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$142, DW_AT_low_pc(0x00)
	.dwattr $C$DW$142, DW_AT_name("BTS_HAL_disableEpwmCounting")
	.dwattr $C$DW$142, DW_AT_TI_call

        LCR       #||BTS_HAL_disableEpwmCounting|| ; [CPU_ALU] |107| 
        ; call occurs [#||BTS_HAL_disableEpwmCounting||] ; [] |107| 
	.dwpsn	file "../bts_main.c",line 114,column 5,is_stmt,isa 0
        MOVL      XAR4,#16384           ; [CPU_ARAU] |114| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |114| 
$C$DW$143	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$143, DW_AT_low_pc(0x00)
	.dwattr $C$DW$143, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$143, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPwm|| ; [CPU_ALU] |114| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPwm||] ; [] |114| 
	.dwpsn	file "../bts_main.c",line 115,column 5,is_stmt,isa 0
        MOVL      XAR4,#16640           ; [CPU_ARAU] |115| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |115| 
$C$DW$144	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$144, DW_AT_low_pc(0x00)
	.dwattr $C$DW$144, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$144, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPwm|| ; [CPU_ALU] |115| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPwm||] ; [] |115| 
	.dwpsn	file "../bts_main.c",line 116,column 5,is_stmt,isa 0
        MOVL      XAR4,#16896           ; [CPU_ARAU] |116| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |116| 
$C$DW$145	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$145, DW_AT_low_pc(0x00)
	.dwattr $C$DW$145, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$145, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPwm|| ; [CPU_ALU] |116| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPwm||] ; [] |116| 
	.dwpsn	file "../bts_main.c",line 117,column 5,is_stmt,isa 0
        MOVL      XAR4,#17152           ; [CPU_ARAU] |117| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |117| 
$C$DW$146	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$146, DW_AT_low_pc(0x00)
	.dwattr $C$DW$146, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$146, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPwm|| ; [CPU_ALU] |117| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPwm||] ; [] |117| 
	.dwpsn	file "../bts_main.c",line 118,column 5,is_stmt,isa 0
        MOVL      XAR4,#17408           ; [CPU_ARAU] |118| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |118| 
$C$DW$147	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$147, DW_AT_low_pc(0x00)
	.dwattr $C$DW$147, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$147, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPwm|| ; [CPU_ALU] |118| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPwm||] ; [] |118| 
	.dwpsn	file "../bts_main.c",line 119,column 5,is_stmt,isa 0
        MOVL      XAR4,#17664           ; [CPU_ARAU] |119| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |119| 
$C$DW$148	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$148, DW_AT_low_pc(0x00)
	.dwattr $C$DW$148, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$148, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPwm|| ; [CPU_ALU] |119| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPwm||] ; [] |119| 
	.dwpsn	file "../bts_main.c",line 120,column 5,is_stmt,isa 0
        MOVL      XAR4,#17920           ; [CPU_ARAU] |120| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |120| 
$C$DW$149	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$149, DW_AT_low_pc(0x00)
	.dwattr $C$DW$149, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$149, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPwm|| ; [CPU_ALU] |120| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPwm||] ; [] |120| 
	.dwpsn	file "../bts_main.c",line 121,column 5,is_stmt,isa 0
        MOVL      XAR4,#18176           ; [CPU_ARAU] |121| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |121| 
$C$DW$150	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$150, DW_AT_low_pc(0x00)
	.dwattr $C$DW$150, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$150, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPwm|| ; [CPU_ALU] |121| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPwm||] ; [] |121| 
	.dwpsn	file "../bts_main.c",line 123,column 5,is_stmt,isa 0
        MOVL      XAR4,#18944           ; [CPU_ARAU] |123| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |123| 
$C$DW$151	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$151, DW_AT_low_pc(0x00)
	.dwattr $C$DW$151, DW_AT_name("BTS_HAL_setupAdcClock")
	.dwattr $C$DW$151, DW_AT_TI_call

        LCR       #||BTS_HAL_setupAdcClock|| ; [CPU_ALU] |123| 
        ; call occurs [#||BTS_HAL_setupAdcClock||] ; [] |123| 
	.dwpsn	file "../bts_main.c",line 124,column 5,is_stmt,isa 0
        MOVL      XAR4,#19200           ; [CPU_ARAU] |124| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |124| 
$C$DW$152	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$152, DW_AT_low_pc(0x00)
	.dwattr $C$DW$152, DW_AT_name("BTS_HAL_setupAdcClock")
	.dwattr $C$DW$152, DW_AT_TI_call

        LCR       #||BTS_HAL_setupAdcClock|| ; [CPU_ALU] |124| 
        ; call occurs [#||BTS_HAL_setupAdcClock||] ; [] |124| 
	.dwpsn	file "../bts_main.c",line 132,column 5,is_stmt,isa 0
$C$DW$153	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$153, DW_AT_low_pc(0x00)
	.dwattr $C$DW$153, DW_AT_name("BTS_setupHrpwmMepScaleFactor")
	.dwattr $C$DW$153, DW_AT_TI_call

        LCR       #||BTS_setupHrpwmMepScaleFactor|| ; [CPU_ALU] |132| 
        ; call occurs [#||BTS_setupHrpwmMepScaleFactor||] ; [] |132| 
	.dwpsn	file "../bts_main.c",line 137,column 5,is_stmt,isa 0
$C$DW$154	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$154, DW_AT_low_pc(0x00)
	.dwattr $C$DW$154, DW_AT_name("BTS_HAL_enableEpwmCounting")
	.dwattr $C$DW$154, DW_AT_TI_call

        LCR       #||BTS_HAL_enableEpwmCounting|| ; [CPU_ALU] |137| 
        ; call occurs [#||BTS_HAL_enableEpwmCounting||] ; [] |137| 
	.dwpsn	file "../bts_main.c",line 143,column 5,is_stmt,isa 0
$C$DW$155	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$155, DW_AT_low_pc(0x00)
	.dwattr $C$DW$155, DW_AT_name("BTS_HAL_SetupSpiPinsGpio_Adc1")
	.dwattr $C$DW$155, DW_AT_TI_call

        LCR       #||BTS_HAL_SetupSpiPinsGpio_Adc1|| ; [CPU_ALU] |143| 
        ; call occurs [#||BTS_HAL_SetupSpiPinsGpio_Adc1||] ; [] |143| 
	.dwpsn	file "../bts_main.c",line 144,column 5,is_stmt,isa 0
        MOVL      XAR4,#24832           ; [CPU_ARAU] |144| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |144| 
$C$DW$156	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$156, DW_AT_low_pc(0x00)
	.dwattr $C$DW$156, DW_AT_name("BTS_HAL_SetupSpi")
	.dwattr $C$DW$156, DW_AT_TI_call

        LCR       #||BTS_HAL_SetupSpi|| ; [CPU_ALU] |144| 
        ; call occurs [#||BTS_HAL_SetupSpi||] ; [] |144| 
	.dwpsn	file "../bts_main.c",line 146,column 5,is_stmt,isa 0
$C$DW$157	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$157, DW_AT_low_pc(0x00)
	.dwattr $C$DW$157, DW_AT_name("BTS_HAL_SetupSpiPinsGpio_Adc2")
	.dwattr $C$DW$157, DW_AT_TI_call

        LCR       #||BTS_HAL_SetupSpiPinsGpio_Adc2|| ; [CPU_ALU] |146| 
        ; call occurs [#||BTS_HAL_SetupSpiPinsGpio_Adc2||] ; [] |146| 
	.dwpsn	file "../bts_main.c",line 147,column 5,is_stmt,isa 0
        MOVL      XAR4,#24864           ; [CPU_ARAU] |147| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |147| 
$C$DW$158	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$158, DW_AT_low_pc(0x00)
	.dwattr $C$DW$158, DW_AT_name("BTS_HAL_SetupSpi")
	.dwattr $C$DW$158, DW_AT_TI_call

        LCR       #||BTS_HAL_SetupSpi|| ; [CPU_ALU] |147| 
        ; call occurs [#||BTS_HAL_SetupSpi||] ; [] |147| 
	.dwpsn	file "../bts_main.c",line 149,column 5,is_stmt,isa 0
$C$DW$159	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$159, DW_AT_low_pc(0x00)
	.dwattr $C$DW$159, DW_AT_name("BTS_HAL_setupExAdcGpio_Adc1")
	.dwattr $C$DW$159, DW_AT_TI_call

        LCR       #||BTS_HAL_setupExAdcGpio_Adc1|| ; [CPU_ALU] |149| 
        ; call occurs [#||BTS_HAL_setupExAdcGpio_Adc1||] ; [] |149| 
	.dwpsn	file "../bts_main.c",line 150,column 5,is_stmt,isa 0
$C$DW$160	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$160, DW_AT_low_pc(0x00)
	.dwattr $C$DW$160, DW_AT_name("BTS_HAL_setupExAdc_ch1_4")
	.dwattr $C$DW$160, DW_AT_TI_call

        LCR       #||BTS_HAL_setupExAdc_ch1_4|| ; [CPU_ALU] |150| 
        ; call occurs [#||BTS_HAL_setupExAdc_ch1_4||] ; [] |150| 
	.dwpsn	file "../bts_main.c",line 152,column 5,is_stmt,isa 0
$C$DW$161	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$161, DW_AT_low_pc(0x00)
	.dwattr $C$DW$161, DW_AT_name("BTS_HAL_setupExAdcGpio_Adc2")
	.dwattr $C$DW$161, DW_AT_TI_call

        LCR       #||BTS_HAL_setupExAdcGpio_Adc2|| ; [CPU_ALU] |152| 
        ; call occurs [#||BTS_HAL_setupExAdcGpio_Adc2||] ; [] |152| 
	.dwpsn	file "../bts_main.c",line 153,column 5,is_stmt,isa 0
$C$DW$162	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$162, DW_AT_low_pc(0x00)
	.dwattr $C$DW$162, DW_AT_name("BTS_HAL_setupExAdc_ch5_8")
	.dwattr $C$DW$162, DW_AT_TI_call

        LCR       #||BTS_HAL_setupExAdc_ch5_8|| ; [CPU_ALU] |153| 
        ; call occurs [#||BTS_HAL_setupExAdc_ch5_8||] ; [] |153| 
	.dwpsn	file "../bts_main.c",line 158,column 5,is_stmt,isa 0
$C$DW$163	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$163, DW_AT_low_pc(0x00)
	.dwattr $C$DW$163, DW_AT_name("BTS_initUserVariables")
	.dwattr $C$DW$163, DW_AT_TI_call

        LCR       #||BTS_initUserVariables|| ; [CPU_ALU] |158| 
        ; call occurs [#||BTS_initUserVariables||] ; [] |158| 
	.dwpsn	file "../bts_main.c",line 159,column 5,is_stmt,isa 0
$C$DW$164	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$164, DW_AT_low_pc(0x00)
	.dwattr $C$DW$164, DW_AT_name("BTS_initProgramVariables")
	.dwattr $C$DW$164, DW_AT_TI_call

        LCR       #||BTS_initProgramVariables|| ; [CPU_ALU] |159| 
        ; call occurs [#||BTS_initProgramVariables||] ; [] |159| 
	.dwpsn	file "../bts_main.c",line 160,column 5,is_stmt,isa 0
$C$DW$165	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$165, DW_AT_low_pc(0x00)
	.dwattr $C$DW$165, DW_AT_name("BTS_initController")
	.dwattr $C$DW$165, DW_AT_TI_call

        LCR       #||BTS_initController|| ; [CPU_ALU] |160| 
        ; call occurs [#||BTS_initController||] ; [] |160| 
	.dwpsn	file "../bts_main.c",line 165,column 5,is_stmt,isa 0
$C$DW$166	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$166, DW_AT_low_pc(0x00)
	.dwattr $C$DW$166, DW_AT_name("BTS_setupSfra")
	.dwattr $C$DW$166, DW_AT_TI_call

        LCR       #||BTS_setupSfra||    ; [CPU_ALU] |165| 
        ; call occurs [#||BTS_setupSfra||] ; [] |165| 
	.dwpsn	file "../bts_main.c",line 166,column 5,is_stmt,isa 0
$C$DW$167	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$167, DW_AT_low_pc(0x00)
	.dwattr $C$DW$167, DW_AT_name("BTS_setupSfraGui")
	.dwattr $C$DW$167, DW_AT_TI_call

        LCR       #||BTS_setupSfraGui|| ; [CPU_ALU] |166| 
        ; call occurs [#||BTS_setupSfraGui||] ; [] |166| 
	.dwpsn	file "../bts_main.c",line 171,column 5,is_stmt,isa 0
$C$DW$168	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$168, DW_AT_low_pc(0x00)
	.dwattr $C$DW$168, DW_AT_name("BTS_HAL_setupInterruptTrigger_Adc1")
	.dwattr $C$DW$168, DW_AT_TI_call

        LCR       #||BTS_HAL_setupInterruptTrigger_Adc1|| ; [CPU_ALU] |171| 
        ; call occurs [#||BTS_HAL_setupInterruptTrigger_Adc1||] ; [] |171| 
	.dwpsn	file "../bts_main.c",line 172,column 5,is_stmt,isa 0
$C$DW$169	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$169, DW_AT_low_pc(0x00)
	.dwattr $C$DW$169, DW_AT_name("BTS_HAL_setupInterruptTrigger_Adc2")
	.dwattr $C$DW$169, DW_AT_TI_call

        LCR       #||BTS_HAL_setupInterruptTrigger_Adc2|| ; [CPU_ALU] |172| 
        ; call occurs [#||BTS_HAL_setupInterruptTrigger_Adc2||] ; [] |172| 
	.dwpsn	file "../bts_main.c",line 174,column 5,is_stmt,isa 0
$C$DW$170	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$170, DW_AT_low_pc(0x00)
	.dwattr $C$DW$170, DW_AT_name("BTS_HAL_setupInterrupt_Adc1")
	.dwattr $C$DW$170, DW_AT_TI_call

        LCR       #||BTS_HAL_setupInterrupt_Adc1|| ; [CPU_ALU] |174| 
        ; call occurs [#||BTS_HAL_setupInterrupt_Adc1||] ; [] |174| 
	.dwpsn	file "../bts_main.c",line 175,column 5,is_stmt,isa 0
$C$DW$171	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$171, DW_AT_low_pc(0x00)
	.dwattr $C$DW$171, DW_AT_name("BTS_HAL_setupInterrupt_Adc2")
	.dwattr $C$DW$171, DW_AT_TI_call

        LCR       #||BTS_HAL_setupInterrupt_Adc2|| ; [CPU_ALU] |175| 
        ; call occurs [#||BTS_HAL_setupInterrupt_Adc2||] ; [] |175| 
	.dwpsn	file "../bts_main.c",line 177,column 5,is_stmt,isa 0
$C$DW$172	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$172, DW_AT_low_pc(0x00)
	.dwattr $C$DW$172, DW_AT_name("BTS_HAL_setupInterrupt")
	.dwattr $C$DW$172, DW_AT_TI_call

        LCR       #||BTS_HAL_setupInterrupt|| ; [CPU_ALU] |177| 
        ; call occurs [#||BTS_HAL_setupInterrupt||] ; [] |177| 
	.dwpsn	file "../bts_main.c",line 184,column 5,is_stmt,isa 0
$C$DW$173	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$173, DW_AT_low_pc(0x00)
	.dwattr $C$DW$173, DW_AT_name("BTS_HAL_setupSyncBuckPinsEpwm")
	.dwattr $C$DW$173, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPinsEpwm|| ; [CPU_ALU] |184| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPinsEpwm||] ; [] |184| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 139,column 5,is_stmt,isa 0
        MOVB      AH,#0                 ; [CPU_ALU] |139| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 142,column 5,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |142| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 146,column 8,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |146| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 139,column 5,is_stmt,isa 0
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |139| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 142,column 5,is_stmt,isa 0
        MOV       *(0:0x6108),AR6       ; [CPU_ALU] |142| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 146,column 8,is_stmt,isa 0
        MOVB      XAR7,#0               ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AR6       ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AR6       ; [CPU_ALU] |146| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 139,column 5,is_stmt,isa 0
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |139| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 142,column 5,is_stmt,isa 0
        MOV       *(0:0x6128),AH        ; [CPU_ALU] |142| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 146,column 8,is_stmt,isa 0
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AR6       ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AR7       ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AR6       ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |146| 
||$C$L4||:    
        MOVW      DP,#||Alpha_State_Ptr|| ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 199,column 9,is_stmt,isa 0
        MOVL      XAR7,@||Alpha_State_Ptr|| ; [CPU_ALU] |199| 
$C$DW$174	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$174, DW_AT_low_pc(0x00)
	.dwattr $C$DW$174, DW_AT_TI_call
	.dwattr $C$DW$174, DW_AT_TI_indirect

        LCR       *XAR7                 ; [CPU_ALU] |199| 
        ; call occurs [XAR7] ; [] |199| 
	.dwpsn	file "../bts_main.c",line 200,column 5,is_stmt,isa 0
        B         ||$C$L4||,UNC         ; [CPU_ALU] |200| 
        ; branch occurs ; [] |200| 
	.dwattr $C$DW$137, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$137, DW_AT_TI_end_line(0xc9)
	.dwattr $C$DW$137, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$137

	.sect	".text:__signbitl"
	.clink
	.global	||__signbitl||

$C$DW$175	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$175, DW_AT_name("__signbitl")
	.dwattr $C$DW$175, DW_AT_low_pc(||__signbitl||)
	.dwattr $C$DW$175, DW_AT_high_pc(0x00)
	.dwattr $C$DW$175, DW_AT_linkage_name("__signbitl")
	.dwattr $C$DW$175, DW_AT_external
	.dwattr $C$DW$175, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$175, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$175, DW_AT_decl_line(0x16f)
	.dwattr $C$DW$175, DW_AT_decl_column(0x25)
	.dwattr $C$DW$175, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 368,column 1,is_stmt,address ||__signbitl||,isa 0

	.dwfde $C$DW$CIE, ||__signbitl||
$C$DW$176	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$176, DW_AT_name("e")
	.dwattr $C$DW$176, DW_AT_type(*$C$DW$T$142)
	.dwattr $C$DW$176, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __signbitl                    FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__signbitl||:
;* AR4   assigned to e
$C$DW$177	.dwtag  DW_TAG_variable
	.dwattr $C$DW$177, DW_AT_name("e")
	.dwattr $C$DW$177, DW_AT_type(*$C$DW$T$143)
	.dwattr $C$DW$177, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 368,column 3,is_stmt,isa 0
        MOVB      ACC,#0                ; [CPU_ALU] |368| 
        MOVL      *-SP[4],ACC           ; [CPU_ALU] |368| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |368| 
        MOV       *-SP[1],#0            ; [CPU_ALU] |368| 
        MOVL      P,*+XAR4[0]           ; [CPU_ALU] |368| 
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |368| 
        AND       PL,#0                 ; [CPU_ALU] |368| 
        AND       PH,#0                 ; [CPU_ALU] |368| 
        ANDB      AL,#0                 ; [CPU_ALU] |368| 
        AND       AH,#32768             ; [CPU_ALU] |368| 
$C$DW$178	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$178, DW_AT_low_pc(0x00)
	.dwattr $C$DW$178, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$178, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |368| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |368| 
        MOVB      AH,#0                 ; [CPU_ALU] |368| 
        CMPB      AL,#0                 ; [CPU_ALU] |368| 
        MOVB      AH,#1,NEQ             ; [CPU_ALU] |368| 
        MOV       AL,AH                 ; [CPU_ALU] |368| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$179	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$179, DW_AT_low_pc(0x00)
	.dwattr $C$DW$179, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$175, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$175, DW_AT_TI_end_line(0x170)
	.dwattr $C$DW$175, DW_AT_TI_end_column(0x2b)
	.dwendentry
	.dwendtag $C$DW$175

	.sect	".text:__signbitf"
	.clink
	.global	||__signbitf||

$C$DW$180	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$180, DW_AT_name("__signbitf")
	.dwattr $C$DW$180, DW_AT_low_pc(||__signbitf||)
	.dwattr $C$DW$180, DW_AT_high_pc(0x00)
	.dwattr $C$DW$180, DW_AT_linkage_name("__signbitf")
	.dwattr $C$DW$180, DW_AT_external
	.dwattr $C$DW$180, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$180, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$180, DW_AT_decl_line(0x16d)
	.dwattr $C$DW$180, DW_AT_decl_column(0x25)
	.dwattr $C$DW$180, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 366,column 1,is_stmt,address ||__signbitf||,isa 0

	.dwfde $C$DW$CIE, ||__signbitf||
$C$DW$181	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$181, DW_AT_name("f")
	.dwattr $C$DW$181, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$181, DW_AT_location[DW_OP_regx 0x2b]


;***************************************************************
;* FNAME: __signbitf                    FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__signbitf||:
;* R0    assigned to f
$C$DW$182	.dwtag  DW_TAG_variable
	.dwattr $C$DW$182, DW_AT_name("f")
	.dwattr $C$DW$182, DW_AT_type(*$C$DW$T$136)
	.dwattr $C$DW$182, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 366,column 3,is_stmt,isa 0
        MOV32     ACC,R0H               ; [CPU_FPU] |366| 
        MOVB      XAR6,#0               ; [CPU_ALU] |366| 
        ANDB      AL,#0                 ; [CPU_ALU] |366| 
        AND       AH,#32768             ; [CPU_ALU] |366| 
        TEST      ACC                   ; [CPU_ALU] |366| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |366| 
        MOV       AL,AR6                ; [CPU_ALU] |366| 
$C$DW$183	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$183, DW_AT_low_pc(0x00)
	.dwattr $C$DW$183, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$180, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$180, DW_AT_TI_end_line(0x16e)
	.dwattr $C$DW$180, DW_AT_TI_end_column(0x29)
	.dwendentry
	.dwendtag $C$DW$180

	.sect	".text:__signbit"
	.clink
	.global	||__signbit||

$C$DW$184	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$184, DW_AT_name("__signbit")
	.dwattr $C$DW$184, DW_AT_low_pc(||__signbit||)
	.dwattr $C$DW$184, DW_AT_high_pc(0x00)
	.dwattr $C$DW$184, DW_AT_linkage_name("__signbit")
	.dwattr $C$DW$184, DW_AT_external
	.dwattr $C$DW$184, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$184, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$184, DW_AT_decl_line(0x16b)
	.dwattr $C$DW$184, DW_AT_decl_column(0x25)
	.dwattr $C$DW$184, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 364,column 1,is_stmt,address ||__signbit||,isa 0

	.dwfde $C$DW$CIE, ||__signbit||
$C$DW$185	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$185, DW_AT_name("d")
	.dwattr $C$DW$185, DW_AT_type(*$C$DW$T$139)
	.dwattr $C$DW$185, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __signbit                     FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__signbit||:
;* AR4   assigned to d
$C$DW$186	.dwtag  DW_TAG_variable
	.dwattr $C$DW$186, DW_AT_name("d")
	.dwattr $C$DW$186, DW_AT_type(*$C$DW$T$140)
	.dwattr $C$DW$186, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 364,column 3,is_stmt,isa 0
        MOVB      ACC,#0                ; [CPU_ALU] |364| 
        MOVL      *-SP[4],ACC           ; [CPU_ALU] |364| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |364| 
        MOV       *-SP[1],#0            ; [CPU_ALU] |364| 
        MOVL      P,*+XAR4[0]           ; [CPU_ALU] |364| 
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |364| 
        AND       PL,#0                 ; [CPU_ALU] |364| 
        AND       PH,#0                 ; [CPU_ALU] |364| 
        ANDB      AL,#0                 ; [CPU_ALU] |364| 
        AND       AH,#32768             ; [CPU_ALU] |364| 
$C$DW$187	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$187, DW_AT_low_pc(0x00)
	.dwattr $C$DW$187, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$187, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |364| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |364| 
        MOVB      AH,#0                 ; [CPU_ALU] |364| 
        CMPB      AL,#0                 ; [CPU_ALU] |364| 
        MOVB      AH,#1,NEQ             ; [CPU_ALU] |364| 
        MOV       AL,AH                 ; [CPU_ALU] |364| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$188	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$188, DW_AT_low_pc(0x00)
	.dwattr $C$DW$188, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$184, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$184, DW_AT_TI_end_line(0x16c)
	.dwattr $C$DW$184, DW_AT_TI_end_column(0x2a)
	.dwendentry
	.dwendtag $C$DW$184

	.sect	".text:__relaxed_sqrtf"
	.clink
	.global	||__relaxed_sqrtf||

$C$DW$189	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$189, DW_AT_name("__relaxed_sqrtf")
	.dwattr $C$DW$189, DW_AT_low_pc(||__relaxed_sqrtf||)
	.dwattr $C$DW$189, DW_AT_high_pc(0x00)
	.dwattr $C$DW$189, DW_AT_linkage_name("__relaxed_sqrtf")
	.dwattr $C$DW$189, DW_AT_external
	.dwattr $C$DW$189, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$189, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$189, DW_AT_decl_line(0xe4)
	.dwattr $C$DW$189, DW_AT_decl_column(0x10)
	.dwattr $C$DW$189, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 229,column 1,is_stmt,address ||__relaxed_sqrtf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_sqrtf||
$C$DW$190	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$190, DW_AT_name("x")
	.dwattr $C$DW$190, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$190, DW_AT_location[DW_OP_regx 0x2b]


;***************************************************************
;* FNAME: __relaxed_sqrtf               FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__relaxed_sqrtf||:
;* R0    assigned to x
$C$DW$191	.dwtag  DW_TAG_variable
	.dwattr $C$DW$191, DW_AT_name("x")
	.dwattr $C$DW$191, DW_AT_type(*$C$DW$T$136)
	.dwattr $C$DW$191, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 230,column 5,is_stmt,isa 0
        SQRTF32   R0H,R0H               ; [CPU_FPU] |230| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$192	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$192, DW_AT_low_pc(0x00)
	.dwattr $C$DW$192, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$189, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$189, DW_AT_TI_end_line(0xe7)
	.dwattr $C$DW$189, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$189

	.sect	".text:__relaxed_sinf"
	.clink
	.global	||__relaxed_sinf||

$C$DW$193	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$193, DW_AT_name("__relaxed_sinf")
	.dwattr $C$DW$193, DW_AT_low_pc(||__relaxed_sinf||)
	.dwattr $C$DW$193, DW_AT_high_pc(0x00)
	.dwattr $C$DW$193, DW_AT_linkage_name("__relaxed_sinf")
	.dwattr $C$DW$193, DW_AT_external
	.dwattr $C$DW$193, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$193, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$193, DW_AT_decl_line(0xe9)
	.dwattr $C$DW$193, DW_AT_decl_column(0x10)
	.dwattr $C$DW$193, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 234,column 1,is_stmt,address ||__relaxed_sinf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_sinf||
$C$DW$194	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$194, DW_AT_name("x")
	.dwattr $C$DW$194, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$194, DW_AT_location[DW_OP_regx 0x2b]


;***************************************************************
;* FNAME: __relaxed_sinf                FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__relaxed_sinf||:
;* R0    assigned to x
$C$DW$195	.dwtag  DW_TAG_variable
	.dwattr $C$DW$195, DW_AT_name("x")
	.dwattr $C$DW$195, DW_AT_type(*$C$DW$T$136)
	.dwattr $C$DW$195, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 235,column 5,is_stmt,isa 0
        DIV2PIF32 R0H,R0H               ; [CPU_FPU] |235| 
        NOP       ; [CPU_ALU] 
        SINPUF32  R0H,R0H               ; [CPU_FPU] |235| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$196	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$196, DW_AT_low_pc(0x00)
	.dwattr $C$DW$196, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$193, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$193, DW_AT_TI_end_line(0xec)
	.dwattr $C$DW$193, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$193

	.sect	".text:__relaxed_cosf"
	.clink
	.global	||__relaxed_cosf||

$C$DW$197	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$197, DW_AT_name("__relaxed_cosf")
	.dwattr $C$DW$197, DW_AT_low_pc(||__relaxed_cosf||)
	.dwattr $C$DW$197, DW_AT_high_pc(0x00)
	.dwattr $C$DW$197, DW_AT_linkage_name("__relaxed_cosf")
	.dwattr $C$DW$197, DW_AT_external
	.dwattr $C$DW$197, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$197, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$197, DW_AT_decl_line(0xee)
	.dwattr $C$DW$197, DW_AT_decl_column(0x10)
	.dwattr $C$DW$197, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 239,column 1,is_stmt,address ||__relaxed_cosf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_cosf||
$C$DW$198	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$198, DW_AT_name("x")
	.dwattr $C$DW$198, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$198, DW_AT_location[DW_OP_regx 0x2b]


;***************************************************************
;* FNAME: __relaxed_cosf                FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__relaxed_cosf||:
;* R0    assigned to x
$C$DW$199	.dwtag  DW_TAG_variable
	.dwattr $C$DW$199, DW_AT_name("x")
	.dwattr $C$DW$199, DW_AT_type(*$C$DW$T$136)
	.dwattr $C$DW$199, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 240,column 5,is_stmt,isa 0
        DIV2PIF32 R0H,R0H               ; [CPU_FPU] |240| 
        NOP       ; [CPU_ALU] 
        COSPUF32  R0H,R0H               ; [CPU_FPU] |240| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$200	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$200, DW_AT_low_pc(0x00)
	.dwattr $C$DW$200, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$197, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$197, DW_AT_TI_end_line(0xf1)
	.dwattr $C$DW$197, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$197

	.sect	".text:__relaxed_atanf"
	.clink
	.global	||__relaxed_atanf||

$C$DW$201	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$201, DW_AT_name("__relaxed_atanf")
	.dwattr $C$DW$201, DW_AT_low_pc(||__relaxed_atanf||)
	.dwattr $C$DW$201, DW_AT_high_pc(0x00)
	.dwattr $C$DW$201, DW_AT_linkage_name("__relaxed_atanf")
	.dwattr $C$DW$201, DW_AT_external
	.dwattr $C$DW$201, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$201, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$201, DW_AT_decl_line(0xf3)
	.dwattr $C$DW$201, DW_AT_decl_column(0x10)
	.dwattr $C$DW$201, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 244,column 1,is_stmt,address ||__relaxed_atanf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_atanf||
$C$DW$202	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$202, DW_AT_name("x")
	.dwattr $C$DW$202, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$202, DW_AT_location[DW_OP_regx 0x2b]


;***************************************************************
;* FNAME: __relaxed_atanf               FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__relaxed_atanf||:
;* R0    assigned to x
$C$DW$203	.dwtag  DW_TAG_variable
	.dwattr $C$DW$203, DW_AT_name("x")
	.dwattr $C$DW$203, DW_AT_type(*$C$DW$T$136)
	.dwattr $C$DW$203, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 245,column 3,is_stmt,isa 0
        MOVIZ     R1H,#16256            ; [CPU_FPU] |245| 
        QUADF32   R1H,R0H,R0H,R1H       ; [CPU_FPU] |245| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        ATANPUF32 R0H,R0H               ; [CPU_FPU] |245| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        ADDF32    R0H,R0H,R1H           ; [CPU_FPU] |245| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MPY2PIF32 R0H,R0H               ; [CPU_FPU] |245| 
        NOP       ; [CPU_ALU] 
$C$DW$204	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$204, DW_AT_low_pc(0x00)
	.dwattr $C$DW$204, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$201, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$201, DW_AT_TI_end_line(0xf6)
	.dwattr $C$DW$201, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$201

	.sect	".text:__relaxed_atan2f"
	.clink
	.global	||__relaxed_atan2f||

$C$DW$205	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$205, DW_AT_name("__relaxed_atan2f")
	.dwattr $C$DW$205, DW_AT_low_pc(||__relaxed_atan2f||)
	.dwattr $C$DW$205, DW_AT_high_pc(0x00)
	.dwattr $C$DW$205, DW_AT_linkage_name("__relaxed_atan2f")
	.dwattr $C$DW$205, DW_AT_external
	.dwattr $C$DW$205, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$205, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$205, DW_AT_decl_line(0xf8)
	.dwattr $C$DW$205, DW_AT_decl_column(0x10)
	.dwattr $C$DW$205, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 249,column 1,is_stmt,address ||__relaxed_atan2f||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_atan2f||
$C$DW$206	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$206, DW_AT_name("y")
	.dwattr $C$DW$206, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$206, DW_AT_location[DW_OP_regx 0x2b]

$C$DW$207	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$207, DW_AT_name("x")
	.dwattr $C$DW$207, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$207, DW_AT_location[DW_OP_regx 0x2f]


;***************************************************************
;* FNAME: __relaxed_atan2f              FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__relaxed_atan2f||:
;* R0    assigned to y
$C$DW$208	.dwtag  DW_TAG_variable
	.dwattr $C$DW$208, DW_AT_name("y")
	.dwattr $C$DW$208, DW_AT_type(*$C$DW$T$136)
	.dwattr $C$DW$208, DW_AT_location[DW_OP_regx 0x2b]

;* R1    assigned to x
$C$DW$209	.dwtag  DW_TAG_variable
	.dwattr $C$DW$209, DW_AT_name("x")
	.dwattr $C$DW$209, DW_AT_type(*$C$DW$T$136)
	.dwattr $C$DW$209, DW_AT_location[DW_OP_regx 0x2f]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 250,column 3,is_stmt,isa 0
        QUADF32   R1H,R0H,R0H,R1H       ; [CPU_FPU] |250| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        ATANPUF32 R0H,R0H               ; [CPU_FPU] |250| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        ADDF32    R0H,R0H,R1H           ; [CPU_FPU] |250| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MPY2PIF32 R0H,R0H               ; [CPU_FPU] |250| 
        NOP       ; [CPU_ALU] 
$C$DW$210	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$210, DW_AT_low_pc(0x00)
	.dwattr $C$DW$210, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$205, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$205, DW_AT_TI_end_line(0xfb)
	.dwattr $C$DW$205, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$205

	.sect	".text:__isnormall"
	.clink
	.global	||__isnormall||

$C$DW$211	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$211, DW_AT_name("__isnormall")
	.dwattr $C$DW$211, DW_AT_low_pc(||__isnormall||)
	.dwattr $C$DW$211, DW_AT_high_pc(0x00)
	.dwattr $C$DW$211, DW_AT_linkage_name("__isnormall")
	.dwattr $C$DW$211, DW_AT_external
	.dwattr $C$DW$211, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$211, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$211, DW_AT_decl_line(0x167)
	.dwattr $C$DW$211, DW_AT_decl_column(0x25)
	.dwattr $C$DW$211, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 360,column 1,is_stmt,address ||__isnormall||,isa 0

	.dwfde $C$DW$CIE, ||__isnormall||
$C$DW$212	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$212, DW_AT_name("e")
	.dwattr $C$DW$212, DW_AT_type(*$C$DW$T$142)
	.dwattr $C$DW$212, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __isnormall                   FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__isnormall||:
;* AR5   assigned to $O$C2
;* AR6   assigned to $O$S1
;* AR4   assigned to e
$C$DW$213	.dwtag  DW_TAG_variable
	.dwattr $C$DW$213, DW_AT_name("e")
	.dwattr $C$DW$213, DW_AT_type(*$C$DW$T$143)
	.dwattr $C$DW$213, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 360,column 3,is_stmt,isa 0
        MOVL      XAR5,*+XAR4[0]        ; [CPU_ALU] |360| 
        MOVL      XAR4,*+XAR4[2]        ; [CPU_ALU] |360| 
        MOVB      XAR6,#0               ; [CPU_ALU] |360| 
        MOV       T,#52                 ; [CPU_ALU] |360| 
        MOVL      P,XAR5                ; [CPU_ALU] |360| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |360| 
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |360| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |360| 
        LSR64     ACC:P,T               ; [CPU_ALU] |360| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |360| 
        ANDB      AL,#0                 ; [CPU_ALU] |360| 
        ANDB      AH,#0                 ; [CPU_ALU] |360| 
        AND       PL,#2047              ; [CPU_ALU] |360| 
        AND       PH,#0                 ; [CPU_ALU] |360| 
$C$DW$214	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$214, DW_AT_low_pc(0x00)
	.dwattr $C$DW$214, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$214, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |360| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |360| 
        MOVB      XAR6,#0               ; [CPU_ALU] |360| 
        CMPB      AL,#0                 ; [CPU_ALU] |360| 
        B         ||$C$L5||,EQ          ; [CPU_ALU] |360| 
        ; branchcc occurs ; [] |360| 
        MOVL      P,XAR5                ; [CPU_ALU] |360| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |360| 
        MOV       T,#48                 ; [CPU_ALU] |360| 
        LSR64     ACC:P,T               ; [CPU_ALU] |360| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |360| 
        MOVZ      AR7,PL                ; [CPU_ALU] |360| 
        MOVL      XAR4,#32752           ; [CPU_ARAU] |360| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |360| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |360| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |360| 
||$C$L5||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR6                ; [CPU_ALU] |360| 
$C$DW$215	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$215, DW_AT_low_pc(0x00)
	.dwattr $C$DW$215, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$211, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$211, DW_AT_TI_end_line(0x169)
	.dwattr $C$DW$211, DW_AT_TI_end_column(0x31)
	.dwendentry
	.dwendtag $C$DW$211

	.sect	".text:__isnormalf"
	.clink
	.global	||__isnormalf||

$C$DW$216	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$216, DW_AT_name("__isnormalf")
	.dwattr $C$DW$216, DW_AT_low_pc(||__isnormalf||)
	.dwattr $C$DW$216, DW_AT_high_pc(0x00)
	.dwattr $C$DW$216, DW_AT_linkage_name("__isnormalf")
	.dwattr $C$DW$216, DW_AT_external
	.dwattr $C$DW$216, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$216, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$216, DW_AT_decl_line(0x163)
	.dwattr $C$DW$216, DW_AT_decl_column(0x25)
	.dwattr $C$DW$216, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 356,column 1,is_stmt,address ||__isnormalf||,isa 0

	.dwfde $C$DW$CIE, ||__isnormalf||
$C$DW$217	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$217, DW_AT_name("f")
	.dwattr $C$DW$217, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$217, DW_AT_location[DW_OP_regx 0x2b]


;***************************************************************
;* FNAME: __isnormalf                   FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__isnormalf||:
;* PL    assigned to $O$K3
;* AR6   assigned to $O$S1
;* R0    assigned to f
$C$DW$218	.dwtag  DW_TAG_variable
	.dwattr $C$DW$218, DW_AT_name("f")
	.dwattr $C$DW$218, DW_AT_type(*$C$DW$T$136)
	.dwattr $C$DW$218, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 356,column 3,is_stmt,isa 0
        MOV32     P,R0H                 ; [CPU_FPU] |356| 
        MOV       T,#23                 ; [CPU_ALU] |356| 
        MOVL      ACC,P                 ; [CPU_ALU] |356| 
        MOVB      XAR6,#0               ; [CPU_ALU] |356| 
        LSRL      ACC,T                 ; [CPU_ALU] |356| 
        ANDB      AL,#0xff              ; [CPU_ALU] |356| 
        B         ||$C$L6||,EQ          ; [CPU_ALU] |356| 
        ; branchcc occurs ; [] |356| 
        AND       AL,PH,#0x7f80         ; [CPU_ALU] |356| 
        MOVZ      AR7,AL                ; [CPU_ALU] |356| 
        MOVL      XAR4,#32640           ; [CPU_ARAU] |356| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |356| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |356| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |356| 
||$C$L6||:    
        MOV       AL,AR6                ; [CPU_ALU] |356| 
$C$DW$219	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$219, DW_AT_low_pc(0x00)
	.dwattr $C$DW$219, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$216, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$216, DW_AT_TI_end_line(0x165)
	.dwattr $C$DW$216, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$216

	.sect	".text:__isnormal"
	.clink
	.global	||__isnormal||

$C$DW$220	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$220, DW_AT_name("__isnormal")
	.dwattr $C$DW$220, DW_AT_low_pc(||__isnormal||)
	.dwattr $C$DW$220, DW_AT_high_pc(0x00)
	.dwattr $C$DW$220, DW_AT_linkage_name("__isnormal")
	.dwattr $C$DW$220, DW_AT_external
	.dwattr $C$DW$220, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$220, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$220, DW_AT_decl_line(0x15f)
	.dwattr $C$DW$220, DW_AT_decl_column(0x25)
	.dwattr $C$DW$220, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 352,column 1,is_stmt,address ||__isnormal||,isa 0

	.dwfde $C$DW$CIE, ||__isnormal||
$C$DW$221	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$221, DW_AT_name("d")
	.dwattr $C$DW$221, DW_AT_type(*$C$DW$T$139)
	.dwattr $C$DW$221, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __isnormal                    FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__isnormal||:
;* AR5   assigned to $O$C2
;* AR6   assigned to $O$S1
;* AR4   assigned to d
$C$DW$222	.dwtag  DW_TAG_variable
	.dwattr $C$DW$222, DW_AT_name("d")
	.dwattr $C$DW$222, DW_AT_type(*$C$DW$T$140)
	.dwattr $C$DW$222, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 352,column 3,is_stmt,isa 0
        MOVL      XAR5,*+XAR4[0]        ; [CPU_ALU] |352| 
        MOVL      XAR4,*+XAR4[2]        ; [CPU_ALU] |352| 
        MOVB      XAR6,#0               ; [CPU_ALU] |352| 
        MOV       T,#52                 ; [CPU_ALU] |352| 
        MOVL      P,XAR5                ; [CPU_ALU] |352| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |352| 
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |352| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |352| 
        LSR64     ACC:P,T               ; [CPU_ALU] |352| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |352| 
        ANDB      AL,#0                 ; [CPU_ALU] |352| 
        ANDB      AH,#0                 ; [CPU_ALU] |352| 
        AND       PL,#2047              ; [CPU_ALU] |352| 
        AND       PH,#0                 ; [CPU_ALU] |352| 
$C$DW$223	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$223, DW_AT_low_pc(0x00)
	.dwattr $C$DW$223, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$223, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |352| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |352| 
        MOVB      XAR6,#0               ; [CPU_ALU] |352| 
        CMPB      AL,#0                 ; [CPU_ALU] |352| 
        B         ||$C$L7||,EQ          ; [CPU_ALU] |352| 
        ; branchcc occurs ; [] |352| 
        MOVL      P,XAR5                ; [CPU_ALU] |352| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |352| 
        MOV       T,#48                 ; [CPU_ALU] |352| 
        LSR64     ACC:P,T               ; [CPU_ALU] |352| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |352| 
        MOVZ      AR7,PL                ; [CPU_ALU] |352| 
        MOVL      XAR4,#32752           ; [CPU_ARAU] |352| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |352| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |352| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |352| 
||$C$L7||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR6                ; [CPU_ALU] |352| 
$C$DW$224	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$224, DW_AT_low_pc(0x00)
	.dwattr $C$DW$224, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$220, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$220, DW_AT_TI_end_line(0x161)
	.dwattr $C$DW$220, DW_AT_TI_end_column(0x30)
	.dwendentry
	.dwendtag $C$DW$220

	.sect	".text:__isnanl"
	.clink
	.global	||__isnanl||

$C$DW$225	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$225, DW_AT_name("__isnanl")
	.dwattr $C$DW$225, DW_AT_low_pc(||__isnanl||)
	.dwattr $C$DW$225, DW_AT_high_pc(0x00)
	.dwattr $C$DW$225, DW_AT_linkage_name("__isnanl")
	.dwattr $C$DW$225, DW_AT_external
	.dwattr $C$DW$225, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$225, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$225, DW_AT_decl_line(0x15b)
	.dwattr $C$DW$225, DW_AT_decl_column(0x25)
	.dwattr $C$DW$225, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 348,column 1,is_stmt,address ||__isnanl||,isa 0

	.dwfde $C$DW$CIE, ||__isnanl||
$C$DW$226	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$226, DW_AT_name("e")
	.dwattr $C$DW$226, DW_AT_type(*$C$DW$T$142)
	.dwattr $C$DW$226, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __isnanl                      FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__isnanl||:
;* AR7   assigned to $O$C2
;* AR4   assigned to $O$S1
;* AR4   assigned to e
$C$DW$227	.dwtag  DW_TAG_variable
	.dwattr $C$DW$227, DW_AT_name("e")
	.dwattr $C$DW$227, DW_AT_type(*$C$DW$T$143)
	.dwattr $C$DW$227, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 348,column 3,is_stmt,isa 0
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |348| 
        MOVL      XAR7,*+XAR4[0]        ; [CPU_ALU] |348| 
        MOV       T,#48                 ; [CPU_ALU] |348| 
        MOVL      XAR5,#32752           ; [CPU_ARAU] |348| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |348| 
        MOVL      P,XAR7                ; [CPU_ALU] |348| 
        MOVB      XAR4,#0               ; [CPU_ALU] |348| 
        LSR64     ACC:P,T               ; [CPU_ALU] |348| 
        MOV       PH,#0                 ; [CPU_ALU] |348| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |348| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |348| 
        CMPL      ACC,P                 ; [CPU_ALU] |348| 
        B         ||$C$L8||,NEQ         ; [CPU_ALU] |348| 
        ; branchcc occurs ; [] |348| 
        MOVL      ACC,XAR6              ; [CPU_ALU] |348| 
        MOVL      P,XAR7                ; [CPU_ALU] |348| 
        MOVB      XAR6,#0               ; [CPU_ALU] |348| 
        AND       AL,#65535             ; [CPU_ALU] |348| 
        ANDB      AH,#15                ; [CPU_ALU] |348| 
        AND       PL,#65535             ; [CPU_ALU] |348| 
        AND       PH,#65535             ; [CPU_ALU] |348| 
        MOVL      *-SP[4],XAR6          ; [CPU_FPU] |348| 
        MOV       *-SP[2],#0            ; [CPU_FPU] |348| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |348| 
$C$DW$228	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$228, DW_AT_low_pc(0x00)
	.dwattr $C$DW$228, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$228, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |348| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |348| 
        CMPB      AL,#0                 ; [CPU_ALU] |348| 
        MOVB      XAR4,#1,NEQ           ; [CPU_ALU] |348| 
||$C$L8||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |348| 
$C$DW$229	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$229, DW_AT_low_pc(0x00)
	.dwattr $C$DW$229, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$225, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$225, DW_AT_TI_end_line(0x15d)
	.dwattr $C$DW$225, DW_AT_TI_end_column(0x30)
	.dwendentry
	.dwendtag $C$DW$225

	.sect	".text:__isnanf"
	.clink
	.global	||__isnanf||

$C$DW$230	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$230, DW_AT_name("__isnanf")
	.dwattr $C$DW$230, DW_AT_low_pc(||__isnanf||)
	.dwattr $C$DW$230, DW_AT_high_pc(0x00)
	.dwattr $C$DW$230, DW_AT_linkage_name("__isnanf")
	.dwattr $C$DW$230, DW_AT_external
	.dwattr $C$DW$230, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$230, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$230, DW_AT_decl_line(0x158)
	.dwattr $C$DW$230, DW_AT_decl_column(0x25)
	.dwattr $C$DW$230, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 345,column 1,is_stmt,address ||__isnanf||,isa 0

	.dwfde $C$DW$CIE, ||__isnanf||
$C$DW$231	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$231, DW_AT_name("f")
	.dwattr $C$DW$231, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$231, DW_AT_location[DW_OP_regx 0x2b]


;***************************************************************
;* FNAME: __isnanf                      FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__isnanf||:
;* PL    assigned to $O$K3
;* AR6   assigned to $O$S1
;* R0    assigned to f
$C$DW$232	.dwtag  DW_TAG_variable
	.dwattr $C$DW$232, DW_AT_name("f")
	.dwattr $C$DW$232, DW_AT_type(*$C$DW$T$136)
	.dwattr $C$DW$232, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 345,column 3,is_stmt,isa 0
        MOV32     P,R0H                 ; [CPU_FPU] |345| 
        AND       AL,PH,#0x7f80         ; [CPU_ALU] |345| 
        MOVZ      AR7,AL                ; [CPU_ALU] |345| 
        MOVL      XAR4,#32640           ; [CPU_ARAU] |345| 
        MOVB      XAR6,#0               ; [CPU_ALU] |345| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |345| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |345| 
        B         ||$C$L9||,NEQ         ; [CPU_ALU] |345| 
        ; branchcc occurs ; [] |345| 
        MOVL      ACC,P                 ; [CPU_ALU] |345| 
        ANDB      AH,#127               ; [CPU_ALU] |345| 
        TEST      ACC                   ; [CPU_ALU] |345| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |345| 
||$C$L9||:    
        MOV       AL,AR6                ; [CPU_ALU] |345| 
$C$DW$233	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$233, DW_AT_low_pc(0x00)
	.dwattr $C$DW$233, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$230, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$230, DW_AT_TI_end_line(0x15a)
	.dwattr $C$DW$230, DW_AT_TI_end_column(0x2e)
	.dwendentry
	.dwendtag $C$DW$230

	.sect	".text:__isnan"
	.clink
	.global	||__isnan||

$C$DW$234	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$234, DW_AT_name("__isnan")
	.dwattr $C$DW$234, DW_AT_low_pc(||__isnan||)
	.dwattr $C$DW$234, DW_AT_high_pc(0x00)
	.dwattr $C$DW$234, DW_AT_linkage_name("__isnan")
	.dwattr $C$DW$234, DW_AT_external
	.dwattr $C$DW$234, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$234, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$234, DW_AT_decl_line(0x155)
	.dwattr $C$DW$234, DW_AT_decl_column(0x25)
	.dwattr $C$DW$234, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 342,column 1,is_stmt,address ||__isnan||,isa 0

	.dwfde $C$DW$CIE, ||__isnan||
$C$DW$235	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$235, DW_AT_name("d")
	.dwattr $C$DW$235, DW_AT_type(*$C$DW$T$139)
	.dwattr $C$DW$235, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __isnan                       FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__isnan||:
;* AR7   assigned to $O$C2
;* AR4   assigned to $O$S1
;* AR4   assigned to d
$C$DW$236	.dwtag  DW_TAG_variable
	.dwattr $C$DW$236, DW_AT_name("d")
	.dwattr $C$DW$236, DW_AT_type(*$C$DW$T$140)
	.dwattr $C$DW$236, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 342,column 3,is_stmt,isa 0
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |342| 
        MOVL      XAR7,*+XAR4[0]        ; [CPU_ALU] |342| 
        MOV       T,#48                 ; [CPU_ALU] |342| 
        MOVL      XAR5,#32752           ; [CPU_ARAU] |342| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |342| 
        MOVL      P,XAR7                ; [CPU_ALU] |342| 
        MOVB      XAR4,#0               ; [CPU_ALU] |342| 
        LSR64     ACC:P,T               ; [CPU_ALU] |342| 
        MOV       PH,#0                 ; [CPU_ALU] |342| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |342| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |342| 
        CMPL      ACC,P                 ; [CPU_ALU] |342| 
        B         ||$C$L10||,NEQ        ; [CPU_ALU] |342| 
        ; branchcc occurs ; [] |342| 
        MOVL      ACC,XAR6              ; [CPU_ALU] |342| 
        MOVL      P,XAR7                ; [CPU_ALU] |342| 
        MOVB      XAR6,#0               ; [CPU_ALU] |342| 
        AND       AL,#65535             ; [CPU_ALU] |342| 
        ANDB      AH,#15                ; [CPU_ALU] |342| 
        AND       PL,#65535             ; [CPU_ALU] |342| 
        AND       PH,#65535             ; [CPU_ALU] |342| 
        MOVL      *-SP[4],XAR6          ; [CPU_FPU] |342| 
        MOV       *-SP[2],#0            ; [CPU_FPU] |342| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |342| 
$C$DW$237	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$237, DW_AT_low_pc(0x00)
	.dwattr $C$DW$237, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$237, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |342| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |342| 
        CMPB      AL,#0                 ; [CPU_ALU] |342| 
        MOVB      XAR4,#1,NEQ           ; [CPU_ALU] |342| 
||$C$L10||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |342| 
$C$DW$238	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$238, DW_AT_low_pc(0x00)
	.dwattr $C$DW$238, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$234, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$234, DW_AT_TI_end_line(0x157)
	.dwattr $C$DW$234, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$234

	.sect	".text:__isinfl"
	.clink
	.global	||__isinfl||

$C$DW$239	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$239, DW_AT_name("__isinfl")
	.dwattr $C$DW$239, DW_AT_low_pc(||__isinfl||)
	.dwattr $C$DW$239, DW_AT_high_pc(0x00)
	.dwattr $C$DW$239, DW_AT_linkage_name("__isinfl")
	.dwattr $C$DW$239, DW_AT_external
	.dwattr $C$DW$239, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$239, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$239, DW_AT_decl_line(0x17a)
	.dwattr $C$DW$239, DW_AT_decl_column(0x25)
	.dwattr $C$DW$239, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 379,column 1,is_stmt,address ||__isinfl||,isa 0

	.dwfde $C$DW$CIE, ||__isinfl||
$C$DW$240	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$240, DW_AT_name("e")
	.dwattr $C$DW$240, DW_AT_type(*$C$DW$T$142)
	.dwattr $C$DW$240, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __isinfl                      FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__isinfl||:
;* AR7   assigned to $O$C2
;* AR4   assigned to $O$S1
;* AR4   assigned to e
$C$DW$241	.dwtag  DW_TAG_variable
	.dwattr $C$DW$241, DW_AT_name("e")
	.dwattr $C$DW$241, DW_AT_type(*$C$DW$T$143)
	.dwattr $C$DW$241, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 379,column 3,is_stmt,isa 0
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |379| 
        MOVL      XAR7,*+XAR4[0]        ; [CPU_ALU] |379| 
        MOV       T,#48                 ; [CPU_ALU] |379| 
        MOVL      XAR5,#32752           ; [CPU_ARAU] |379| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |379| 
        MOVL      P,XAR7                ; [CPU_ALU] |379| 
        MOVB      XAR4,#0               ; [CPU_ALU] |379| 
        LSR64     ACC:P,T               ; [CPU_ALU] |379| 
        MOV       PH,#0                 ; [CPU_ALU] |379| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |379| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |379| 
        CMPL      ACC,P                 ; [CPU_ALU] |379| 
        B         ||$C$L11||,NEQ        ; [CPU_ALU] |379| 
        ; branchcc occurs ; [] |379| 
        MOVL      ACC,XAR6              ; [CPU_ALU] |379| 
        MOVL      P,XAR7                ; [CPU_ALU] |379| 
        MOVB      XAR6,#0               ; [CPU_ALU] |379| 
        AND       AL,#65535             ; [CPU_ALU] |379| 
        ANDB      AH,#15                ; [CPU_ALU] |379| 
        AND       PL,#65535             ; [CPU_ALU] |379| 
        AND       PH,#65535             ; [CPU_ALU] |379| 
        MOVL      *-SP[4],XAR6          ; [CPU_FPU] |379| 
        MOV       *-SP[2],#0            ; [CPU_FPU] |379| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |379| 
$C$DW$242	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$242, DW_AT_low_pc(0x00)
	.dwattr $C$DW$242, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$242, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |379| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |379| 
        CMPB      AL,#0                 ; [CPU_ALU] |379| 
        MOVB      XAR4,#1,EQ            ; [CPU_ALU] |379| 
||$C$L11||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |379| 
$C$DW$243	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$243, DW_AT_low_pc(0x00)
	.dwattr $C$DW$243, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$239, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$239, DW_AT_TI_end_line(0x17b)
	.dwattr $C$DW$239, DW_AT_TI_end_column(0x4c)
	.dwendentry
	.dwendtag $C$DW$239

	.sect	".text:__isinff"
	.clink
	.global	||__isinff||

$C$DW$244	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$244, DW_AT_name("__isinff")
	.dwattr $C$DW$244, DW_AT_low_pc(||__isinff||)
	.dwattr $C$DW$244, DW_AT_high_pc(0x00)
	.dwattr $C$DW$244, DW_AT_linkage_name("__isinff")
	.dwattr $C$DW$244, DW_AT_external
	.dwattr $C$DW$244, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$244, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$244, DW_AT_decl_line(0x176)
	.dwattr $C$DW$244, DW_AT_decl_column(0x25)
	.dwattr $C$DW$244, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 375,column 1,is_stmt,address ||__isinff||,isa 0

	.dwfde $C$DW$CIE, ||__isinff||
$C$DW$245	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$245, DW_AT_name("f")
	.dwattr $C$DW$245, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$245, DW_AT_location[DW_OP_regx 0x2b]


;***************************************************************
;* FNAME: __isinff                      FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__isinff||:
;* PL    assigned to $O$K3
;* AR6   assigned to $O$S1
;* R0    assigned to f
$C$DW$246	.dwtag  DW_TAG_variable
	.dwattr $C$DW$246, DW_AT_name("f")
	.dwattr $C$DW$246, DW_AT_type(*$C$DW$T$136)
	.dwattr $C$DW$246, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 375,column 3,is_stmt,isa 0
        MOV32     P,R0H                 ; [CPU_FPU] |375| 
        AND       AL,PH,#0x7f80         ; [CPU_ALU] |375| 
        MOVZ      AR7,AL                ; [CPU_ALU] |375| 
        MOVL      XAR4,#32640           ; [CPU_ARAU] |375| 
        MOVB      XAR6,#0               ; [CPU_ALU] |375| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |375| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |375| 
        B         ||$C$L12||,NEQ        ; [CPU_ALU] |375| 
        ; branchcc occurs ; [] |375| 
        MOVL      ACC,P                 ; [CPU_ALU] |375| 
        ANDB      AH,#127               ; [CPU_ALU] |375| 
        TEST      ACC                   ; [CPU_ALU] |375| 
        MOVB      XAR6,#1,EQ            ; [CPU_ALU] |375| 
||$C$L12||:    
        MOV       AL,AR6                ; [CPU_ALU] |375| 
$C$DW$247	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$247, DW_AT_low_pc(0x00)
	.dwattr $C$DW$247, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$244, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$244, DW_AT_TI_end_line(0x177)
	.dwattr $C$DW$244, DW_AT_TI_end_column(0x48)
	.dwendentry
	.dwendtag $C$DW$244

	.sect	".text:__isinf"
	.clink
	.global	||__isinf||

$C$DW$248	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$248, DW_AT_name("__isinf")
	.dwattr $C$DW$248, DW_AT_low_pc(||__isinf||)
	.dwattr $C$DW$248, DW_AT_high_pc(0x00)
	.dwattr $C$DW$248, DW_AT_linkage_name("__isinf")
	.dwattr $C$DW$248, DW_AT_external
	.dwattr $C$DW$248, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$248, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$248, DW_AT_decl_line(0x178)
	.dwattr $C$DW$248, DW_AT_decl_column(0x25)
	.dwattr $C$DW$248, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 377,column 1,is_stmt,address ||__isinf||,isa 0

	.dwfde $C$DW$CIE, ||__isinf||
$C$DW$249	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$249, DW_AT_name("d")
	.dwattr $C$DW$249, DW_AT_type(*$C$DW$T$139)
	.dwattr $C$DW$249, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __isinf                       FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__isinf||:
;* AR7   assigned to $O$C2
;* AR4   assigned to $O$S1
;* AR4   assigned to d
$C$DW$250	.dwtag  DW_TAG_variable
	.dwattr $C$DW$250, DW_AT_name("d")
	.dwattr $C$DW$250, DW_AT_type(*$C$DW$T$140)
	.dwattr $C$DW$250, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 377,column 3,is_stmt,isa 0
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |377| 
        MOVL      XAR7,*+XAR4[0]        ; [CPU_ALU] |377| 
        MOV       T,#48                 ; [CPU_ALU] |377| 
        MOVL      XAR5,#32752           ; [CPU_ARAU] |377| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |377| 
        MOVL      P,XAR7                ; [CPU_ALU] |377| 
        MOVB      XAR4,#0               ; [CPU_ALU] |377| 
        LSR64     ACC:P,T               ; [CPU_ALU] |377| 
        MOV       PH,#0                 ; [CPU_ALU] |377| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |377| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |377| 
        CMPL      ACC,P                 ; [CPU_ALU] |377| 
        B         ||$C$L13||,NEQ        ; [CPU_ALU] |377| 
        ; branchcc occurs ; [] |377| 
        MOVL      ACC,XAR6              ; [CPU_ALU] |377| 
        MOVL      P,XAR7                ; [CPU_ALU] |377| 
        MOVB      XAR6,#0               ; [CPU_ALU] |377| 
        AND       AL,#65535             ; [CPU_ALU] |377| 
        ANDB      AH,#15                ; [CPU_ALU] |377| 
        AND       PL,#65535             ; [CPU_ALU] |377| 
        AND       PH,#65535             ; [CPU_ALU] |377| 
        MOVL      *-SP[4],XAR6          ; [CPU_FPU] |377| 
        MOV       *-SP[2],#0            ; [CPU_FPU] |377| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |377| 
$C$DW$251	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$251, DW_AT_low_pc(0x00)
	.dwattr $C$DW$251, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$251, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |377| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |377| 
        CMPB      AL,#0                 ; [CPU_ALU] |377| 
        MOVB      XAR4,#1,EQ            ; [CPU_ALU] |377| 
||$C$L13||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |377| 
$C$DW$252	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$252, DW_AT_low_pc(0x00)
	.dwattr $C$DW$252, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$248, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$248, DW_AT_TI_end_line(0x179)
	.dwattr $C$DW$248, DW_AT_TI_end_column(0x4a)
	.dwendentry
	.dwendtag $C$DW$248

	.sect	".text:__isfinitel"
	.clink
	.global	||__isfinitel||

$C$DW$253	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$253, DW_AT_name("__isfinitel")
	.dwattr $C$DW$253, DW_AT_low_pc(||__isfinitel||)
	.dwattr $C$DW$253, DW_AT_high_pc(0x00)
	.dwattr $C$DW$253, DW_AT_linkage_name("__isfinitel")
	.dwattr $C$DW$253, DW_AT_external
	.dwattr $C$DW$253, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$253, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$253, DW_AT_decl_line(0x152)
	.dwattr $C$DW$253, DW_AT_decl_column(0x25)
	.dwattr $C$DW$253, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 339,column 1,is_stmt,address ||__isfinitel||,isa 0

	.dwfde $C$DW$CIE, ||__isfinitel||
$C$DW$254	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$254, DW_AT_name("e")
	.dwattr $C$DW$254, DW_AT_type(*$C$DW$T$142)
	.dwattr $C$DW$254, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __isfinitel                   FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__isfinitel||:
;* AR4   assigned to e
$C$DW$255	.dwtag  DW_TAG_variable
	.dwattr $C$DW$255, DW_AT_name("e")
	.dwattr $C$DW$255, DW_AT_type(*$C$DW$T$143)
	.dwattr $C$DW$255, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 339,column 3,is_stmt,isa 0
        MOVL      P,*+XAR4[0]           ; [CPU_ALU] |339| 
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |339| 
        MOV       T,#48                 ; [CPU_ALU] |339| 
        LSR64     ACC:P,T               ; [CPU_ALU] |339| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |339| 
        MOVZ      AR7,PL                ; [CPU_ALU] |339| 
        MOVL      XAR4,#32752           ; [CPU_ARAU] |339| 
        MOVB      XAR6,#0               ; [CPU_ALU] |339| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |339| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |339| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |339| 
        MOV       AL,AR6                ; [CPU_ALU] |339| 
$C$DW$256	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$256, DW_AT_low_pc(0x00)
	.dwattr $C$DW$256, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$253, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$253, DW_AT_TI_end_line(0x153)
	.dwattr $C$DW$253, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$253

	.sect	".text:__isfinitef"
	.clink
	.global	||__isfinitef||

$C$DW$257	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$257, DW_AT_name("__isfinitef")
	.dwattr $C$DW$257, DW_AT_low_pc(||__isfinitef||)
	.dwattr $C$DW$257, DW_AT_high_pc(0x00)
	.dwattr $C$DW$257, DW_AT_linkage_name("__isfinitef")
	.dwattr $C$DW$257, DW_AT_external
	.dwattr $C$DW$257, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$257, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$257, DW_AT_decl_line(0x150)
	.dwattr $C$DW$257, DW_AT_decl_column(0x25)
	.dwattr $C$DW$257, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 337,column 1,is_stmt,address ||__isfinitef||,isa 0

	.dwfde $C$DW$CIE, ||__isfinitef||
$C$DW$258	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$258, DW_AT_name("f")
	.dwattr $C$DW$258, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$258, DW_AT_location[DW_OP_regx 0x2b]


;***************************************************************
;* FNAME: __isfinitef                   FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__isfinitef||:
;* R0    assigned to f
$C$DW$259	.dwtag  DW_TAG_variable
	.dwattr $C$DW$259, DW_AT_name("f")
	.dwattr $C$DW$259, DW_AT_type(*$C$DW$T$136)
	.dwattr $C$DW$259, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 337,column 3,is_stmt,isa 0
        MOV32     ACC,R0H               ; [CPU_FPU] |337| 
        AND       AH,#0x7f80            ; [CPU_ALU] |337| 
        MOVZ      AR7,AH                ; [CPU_ALU] |337| 
        MOVL      XAR4,#32640           ; [CPU_ARAU] |337| 
        MOVB      XAR6,#0               ; [CPU_ALU] |337| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |337| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |337| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |337| 
        MOV       AL,AR6                ; [CPU_ALU] |337| 
$C$DW$260	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$260, DW_AT_low_pc(0x00)
	.dwattr $C$DW$260, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$257, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$257, DW_AT_TI_end_line(0x151)
	.dwattr $C$DW$257, DW_AT_TI_end_column(0x2d)
	.dwendentry
	.dwendtag $C$DW$257

	.sect	".text:__isfinite"
	.clink
	.global	||__isfinite||

$C$DW$261	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$261, DW_AT_name("__isfinite")
	.dwattr $C$DW$261, DW_AT_low_pc(||__isfinite||)
	.dwattr $C$DW$261, DW_AT_high_pc(0x00)
	.dwattr $C$DW$261, DW_AT_linkage_name("__isfinite")
	.dwattr $C$DW$261, DW_AT_external
	.dwattr $C$DW$261, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$261, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$261, DW_AT_decl_line(0x14e)
	.dwattr $C$DW$261, DW_AT_decl_column(0x25)
	.dwattr $C$DW$261, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 335,column 1,is_stmt,address ||__isfinite||,isa 0

	.dwfde $C$DW$CIE, ||__isfinite||
$C$DW$262	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$262, DW_AT_name("d")
	.dwattr $C$DW$262, DW_AT_type(*$C$DW$T$139)
	.dwattr $C$DW$262, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __isfinite                    FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__isfinite||:
;* AR4   assigned to d
$C$DW$263	.dwtag  DW_TAG_variable
	.dwattr $C$DW$263, DW_AT_name("d")
	.dwattr $C$DW$263, DW_AT_type(*$C$DW$T$140)
	.dwattr $C$DW$263, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 335,column 3,is_stmt,isa 0
        MOVL      P,*+XAR4[0]           ; [CPU_ALU] |335| 
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |335| 
        MOV       T,#48                 ; [CPU_ALU] |335| 
        LSR64     ACC:P,T               ; [CPU_ALU] |335| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |335| 
        MOVZ      AR7,PL                ; [CPU_ALU] |335| 
        MOVL      XAR4,#32752           ; [CPU_ARAU] |335| 
        MOVB      XAR6,#0               ; [CPU_ALU] |335| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |335| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |335| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |335| 
        MOV       AL,AR6                ; [CPU_ALU] |335| 
$C$DW$264	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$264, DW_AT_low_pc(0x00)
	.dwattr $C$DW$264, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$261, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$261, DW_AT_TI_end_line(0x14f)
	.dwattr $C$DW$261, DW_AT_TI_end_column(0x2e)
	.dwendentry
	.dwendtag $C$DW$261

	.sect	".text:__fpclassifyl"
	.clink
	.global	||__fpclassifyl||

$C$DW$265	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$265, DW_AT_name("__fpclassifyl")
	.dwattr $C$DW$265, DW_AT_low_pc(||__fpclassifyl||)
	.dwattr $C$DW$265, DW_AT_high_pc(0x00)
	.dwattr $C$DW$265, DW_AT_linkage_name("__fpclassifyl")
	.dwattr $C$DW$265, DW_AT_external
	.dwattr $C$DW$265, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$265, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$265, DW_AT_decl_line(0x1ae)
	.dwattr $C$DW$265, DW_AT_decl_column(0x25)
	.dwattr $C$DW$265, DW_AT_TI_max_frame_size(-10)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 431,column 1,is_stmt,address ||__fpclassifyl||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassifyl||
$C$DW$266	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$266, DW_AT_name("e")
	.dwattr $C$DW$266, DW_AT_type(*$C$DW$T$142)
	.dwattr $C$DW$266, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __fpclassifyl                 FR SIZE:   8           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  4 Auto,  0 SOE     *
;***************************************************************

||__fpclassifyl||:
$C$DW$267	.dwtag  DW_TAG_variable
	.dwattr $C$DW$267, DW_AT_name("e")
	.dwattr $C$DW$267, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$267, DW_AT_location[DW_OP_breg20 -8]

;* AR5   assigned to $O$C1
;* AR4   assigned to e
$C$DW$268	.dwtag  DW_TAG_variable
	.dwattr $C$DW$268, DW_AT_name("e")
	.dwattr $C$DW$268, DW_AT_type(*$C$DW$T$143)
	.dwattr $C$DW$268, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#8                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -10
        MOVL      XAR6,*+XAR4[2]        ; [CPU_ALU] |431| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |431| 
        MOVL      *-SP[8],ACC           ; [CPU_ALU] |431| 
        MOVL      *-SP[6],XAR6          ; [CPU_ALU] |431| 
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 432,column 5,is_stmt,isa 0
        MOVL      XAR5,*-SP[8]          ; [CPU_ALU] |432| 
        MOVL      XAR4,*-SP[6]          ; [CPU_ALU] |432| 
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 436,column 14,is_stmt,isa 0
        MOV       T,#48                 ; [CPU_ALU] |436| 
        MOVL      P,XAR5                ; [CPU_ALU] |436| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |436| 
        LSR64     ACC:P,T               ; [CPU_ALU] |436| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |436| 
        MOVZ      AR7,PL                ; [CPU_ALU] |436| 
        MOVL      XAR6,#32752           ; [CPU_ARAU] |436| 
        MOVL      ACC,XAR6              ; [CPU_ALU] |436| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |436| 
        B         ||$C$L15||,NEQ        ; [CPU_ALU] |436| 
        ; branchcc occurs ; [] |436| 
        MOVB      ACC,#0                ; [CPU_ALU] |436| 
        MOVL      *-SP[4],ACC           ; [CPU_ALU] |436| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |436| 
        MOV       *-SP[1],#0            ; [CPU_ALU] |436| 
        MOVL      P,*-SP[8]             ; [CPU_ALU] |436| 
        MOVL      ACC,*-SP[6]           ; [CPU_ALU] |436| 
        AND       PL,#65535             ; [CPU_ALU] |436| 
        AND       PH,#65535             ; [CPU_ALU] |436| 
        AND       AL,#65535             ; [CPU_ALU] |436| 
        ANDB      AH,#15                ; [CPU_ALU] |436| 
$C$DW$269	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$269, DW_AT_low_pc(0x00)
	.dwattr $C$DW$269, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$269, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |436| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |436| 
        CMPB      AL,#0                 ; [CPU_ALU] |436| 
        B         ||$C$L14||,EQ         ; [CPU_ALU] |436| 
        ; branchcc occurs ; [] |436| 
        MOVB      AL,#2                 ; [CPU_ALU] |436| 
        B         ||$C$L18||,UNC        ; [CPU_ALU] |436| 
        ; branch occurs ; [] |436| 
||$C$L14||:    
        MOVB      AL,#1                 ; [CPU_ALU] |436| 
        B         ||$C$L18||,UNC        ; [CPU_ALU] |436| 
        ; branch occurs ; [] |436| 
||$C$L15||:    
        MOVB      XAR6,#0               ; [CPU_ALU] |436| 
        MOVL      P,XAR5                ; [CPU_ALU] |436| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |436| 
        MOV       T,#52                 ; [CPU_ALU] |436| 
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |436| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |436| 
        LSR64     ACC:P,T               ; [CPU_ALU] |436| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |436| 
        ANDB      AL,#0                 ; [CPU_ALU] |436| 
        ANDB      AH,#0                 ; [CPU_ALU] |436| 
        AND       PL,#2047              ; [CPU_ALU] |436| 
        AND       PH,#0                 ; [CPU_ALU] |436| 
$C$DW$270	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$270, DW_AT_low_pc(0x00)
	.dwattr $C$DW$270, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$270, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |436| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |436| 
        CMPB      AL,#0                 ; [CPU_ALU] |436| 
        B         ||$C$L16||,EQ         ; [CPU_ALU] |436| 
        ; branchcc occurs ; [] |436| 
        MOV       AL,#-1                ; [CPU_ALU] |436| 
        B         ||$C$L18||,UNC        ; [CPU_ALU] |436| 
        ; branch occurs ; [] |436| 
||$C$L16||:    
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |436| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |436| 
        MOVL      P,XAR5                ; [CPU_ALU] |436| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |436| 
        AND       AL,#65535             ; [CPU_ALU] |436| 
        ANDB      AH,#15                ; [CPU_ALU] |436| 
        AND       PL,#65535             ; [CPU_ALU] |436| 
        AND       PH,#65535             ; [CPU_ALU] |436| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |436| 
$C$DW$271	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$271, DW_AT_low_pc(0x00)
	.dwattr $C$DW$271, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$271, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |436| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |436| 
        CMPB      AL,#0                 ; [CPU_ALU] |436| 
        B         ||$C$L17||,EQ         ; [CPU_ALU] |436| 
        ; branchcc occurs ; [] |436| 
        MOV       AL,#-2                ; [CPU_ALU] |436| 
        B         ||$C$L18||,UNC        ; [CPU_ALU] |436| 
        ; branch occurs ; [] |436| 
||$C$L17||:    
        MOVB      AL,#0                 ; [CPU_ALU] |436| 
||$C$L18||:    
        SUBB      SP,#8                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$272	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$272, DW_AT_low_pc(0x00)
	.dwattr $C$DW$272, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$265, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$265, DW_AT_TI_end_line(0x1bd)
	.dwattr $C$DW$265, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$265

	.sect	".text:__fpclassifyf"
	.clink
	.global	||__fpclassifyf||

$C$DW$273	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$273, DW_AT_name("__fpclassifyf")
	.dwattr $C$DW$273, DW_AT_low_pc(||__fpclassifyf||)
	.dwattr $C$DW$273, DW_AT_high_pc(0x00)
	.dwattr $C$DW$273, DW_AT_linkage_name("__fpclassifyf")
	.dwattr $C$DW$273, DW_AT_external
	.dwattr $C$DW$273, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$273, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$273, DW_AT_decl_line(0x18c)
	.dwattr $C$DW$273, DW_AT_decl_column(0x25)
	.dwattr $C$DW$273, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 397,column 1,is_stmt,address ||__fpclassifyf||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassifyf||
$C$DW$274	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$274, DW_AT_name("f")
	.dwattr $C$DW$274, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$274, DW_AT_location[DW_OP_regx 0x2b]


;***************************************************************
;* FNAME: __fpclassifyf                 FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__fpclassifyf||:
;* PL    assigned to $O$K1
;* R0    assigned to f
$C$DW$275	.dwtag  DW_TAG_variable
	.dwattr $C$DW$275, DW_AT_name("f")
	.dwattr $C$DW$275, DW_AT_type(*$C$DW$T$136)
	.dwattr $C$DW$275, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 398,column 5,is_stmt,isa 0
        MOV32     P,R0H                 ; [CPU_FPU] |398| 
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 402,column 14,is_stmt,isa 0
        AND       AL,PH,#0x7f80         ; [CPU_ALU] |402| 
        MOVZ      AR6,AL                ; [CPU_ALU] |402| 
        MOVL      XAR4,#32640           ; [CPU_ARAU] |402| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |402| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |402| 
        B         ||$C$L20||,NEQ        ; [CPU_ALU] |402| 
        ; branchcc occurs ; [] |402| 
        MOVL      ACC,P                 ; [CPU_ALU] |402| 
        ANDB      AH,#127               ; [CPU_ALU] |402| 
        TEST      ACC                   ; [CPU_ALU] |402| 
        B         ||$C$L19||,EQ         ; [CPU_ALU] |402| 
        ; branchcc occurs ; [] |402| 
	.dwcfi	remember_state
        MOVB      AL,#2                 ; [CPU_ALU] |402| 
$C$DW$276	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$276, DW_AT_low_pc(0x00)
	.dwattr $C$DW$276, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L19||:    
	.dwcfi	remember_state
        MOVB      AL,#1                 ; [CPU_ALU] |402| 
$C$DW$277	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$277, DW_AT_low_pc(0x00)
	.dwattr $C$DW$277, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L20||:    
        MOVL      ACC,P                 ; [CPU_ALU] |402| 
        MOV       T,#23                 ; [CPU_ALU] |402| 
        LSRL      ACC,T                 ; [CPU_ALU] |402| 
        ANDB      AL,#0xff              ; [CPU_ALU] |402| 
        B         ||$C$L21||,EQ         ; [CPU_ALU] |402| 
        ; branchcc occurs ; [] |402| 
	.dwcfi	remember_state
        MOV       AL,#-1                ; [CPU_ALU] |402| 
$C$DW$278	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$278, DW_AT_low_pc(0x00)
	.dwattr $C$DW$278, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L21||:    
        MOVL      ACC,P                 ; [CPU_ALU] |402| 
        ANDB      AH,#127               ; [CPU_ALU] |402| 
        TEST      ACC                   ; [CPU_ALU] |402| 
        B         ||$C$L22||,EQ         ; [CPU_ALU] |402| 
        ; branchcc occurs ; [] |402| 
	.dwcfi	remember_state
        MOV       AL,#-2                ; [CPU_ALU] |402| 
$C$DW$279	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$279, DW_AT_low_pc(0x00)
	.dwattr $C$DW$279, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L22||:    
        MOVB      AL,#0                 ; [CPU_ALU] |402| 
$C$DW$280	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$280, DW_AT_low_pc(0x00)
	.dwattr $C$DW$280, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$273, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$273, DW_AT_TI_end_line(0x19b)
	.dwattr $C$DW$273, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$273

	.sect	".text:__fpclassify"
	.clink
	.global	||__fpclassify||

$C$DW$281	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$281, DW_AT_name("__fpclassify")
	.dwattr $C$DW$281, DW_AT_low_pc(||__fpclassify||)
	.dwattr $C$DW$281, DW_AT_high_pc(0x00)
	.dwattr $C$DW$281, DW_AT_linkage_name("__fpclassify")
	.dwattr $C$DW$281, DW_AT_external
	.dwattr $C$DW$281, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$281, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$281, DW_AT_decl_line(0x19d)
	.dwattr $C$DW$281, DW_AT_decl_column(0x25)
	.dwattr $C$DW$281, DW_AT_TI_max_frame_size(-10)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 414,column 1,is_stmt,address ||__fpclassify||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassify||
$C$DW$282	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$282, DW_AT_name("d")
	.dwattr $C$DW$282, DW_AT_type(*$C$DW$T$139)
	.dwattr $C$DW$282, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __fpclassify                  FR SIZE:   8           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  4 Auto,  0 SOE     *
;***************************************************************

||__fpclassify||:
$C$DW$283	.dwtag  DW_TAG_variable
	.dwattr $C$DW$283, DW_AT_name("d")
	.dwattr $C$DW$283, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$283, DW_AT_location[DW_OP_breg20 -8]

;* AR5   assigned to $O$C1
;* AR4   assigned to d
$C$DW$284	.dwtag  DW_TAG_variable
	.dwattr $C$DW$284, DW_AT_name("d")
	.dwattr $C$DW$284, DW_AT_type(*$C$DW$T$140)
	.dwattr $C$DW$284, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#8                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -10
        MOVL      XAR6,*+XAR4[2]        ; [CPU_ALU] |414| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |414| 
        MOVL      *-SP[8],ACC           ; [CPU_ALU] |414| 
        MOVL      *-SP[6],XAR6          ; [CPU_ALU] |414| 
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 415,column 5,is_stmt,isa 0
        MOVL      XAR5,*-SP[8]          ; [CPU_ALU] |415| 
        MOVL      XAR4,*-SP[6]          ; [CPU_ALU] |415| 
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 419,column 14,is_stmt,isa 0
        MOV       T,#48                 ; [CPU_ALU] |419| 
        MOVL      P,XAR5                ; [CPU_ALU] |419| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |419| 
        LSR64     ACC:P,T               ; [CPU_ALU] |419| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |419| 
        MOVZ      AR7,PL                ; [CPU_ALU] |419| 
        MOVL      XAR6,#32752           ; [CPU_ARAU] |419| 
        MOVL      ACC,XAR6              ; [CPU_ALU] |419| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |419| 
        B         ||$C$L24||,NEQ        ; [CPU_ALU] |419| 
        ; branchcc occurs ; [] |419| 
        MOVB      ACC,#0                ; [CPU_ALU] |419| 
        MOVL      *-SP[4],ACC           ; [CPU_ALU] |419| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |419| 
        MOV       *-SP[1],#0            ; [CPU_ALU] |419| 
        MOVL      P,*-SP[8]             ; [CPU_ALU] |419| 
        MOVL      ACC,*-SP[6]           ; [CPU_ALU] |419| 
        AND       PL,#65535             ; [CPU_ALU] |419| 
        AND       PH,#65535             ; [CPU_ALU] |419| 
        AND       AL,#65535             ; [CPU_ALU] |419| 
        ANDB      AH,#15                ; [CPU_ALU] |419| 
$C$DW$285	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$285, DW_AT_low_pc(0x00)
	.dwattr $C$DW$285, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$285, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |419| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |419| 
        CMPB      AL,#0                 ; [CPU_ALU] |419| 
        B         ||$C$L23||,EQ         ; [CPU_ALU] |419| 
        ; branchcc occurs ; [] |419| 
        MOVB      AL,#2                 ; [CPU_ALU] |419| 
        B         ||$C$L27||,UNC        ; [CPU_ALU] |419| 
        ; branch occurs ; [] |419| 
||$C$L23||:    
        MOVB      AL,#1                 ; [CPU_ALU] |419| 
        B         ||$C$L27||,UNC        ; [CPU_ALU] |419| 
        ; branch occurs ; [] |419| 
||$C$L24||:    
        MOVB      XAR6,#0               ; [CPU_ALU] |419| 
        MOVL      P,XAR5                ; [CPU_ALU] |419| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |419| 
        MOV       T,#52                 ; [CPU_ALU] |419| 
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |419| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |419| 
        LSR64     ACC:P,T               ; [CPU_ALU] |419| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |419| 
        ANDB      AL,#0                 ; [CPU_ALU] |419| 
        ANDB      AH,#0                 ; [CPU_ALU] |419| 
        AND       PL,#2047              ; [CPU_ALU] |419| 
        AND       PH,#0                 ; [CPU_ALU] |419| 
$C$DW$286	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$286, DW_AT_low_pc(0x00)
	.dwattr $C$DW$286, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$286, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |419| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |419| 
        CMPB      AL,#0                 ; [CPU_ALU] |419| 
        B         ||$C$L25||,EQ         ; [CPU_ALU] |419| 
        ; branchcc occurs ; [] |419| 
        MOV       AL,#-1                ; [CPU_ALU] |419| 
        B         ||$C$L27||,UNC        ; [CPU_ALU] |419| 
        ; branch occurs ; [] |419| 
||$C$L25||:    
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |419| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |419| 
        MOVL      P,XAR5                ; [CPU_ALU] |419| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |419| 
        AND       AL,#65535             ; [CPU_ALU] |419| 
        ANDB      AH,#15                ; [CPU_ALU] |419| 
        AND       PL,#65535             ; [CPU_ALU] |419| 
        AND       PH,#65535             ; [CPU_ALU] |419| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |419| 
$C$DW$287	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$287, DW_AT_low_pc(0x00)
	.dwattr $C$DW$287, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$287, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |419| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |419| 
        CMPB      AL,#0                 ; [CPU_ALU] |419| 
        B         ||$C$L26||,EQ         ; [CPU_ALU] |419| 
        ; branchcc occurs ; [] |419| 
        MOV       AL,#-2                ; [CPU_ALU] |419| 
        B         ||$C$L27||,UNC        ; [CPU_ALU] |419| 
        ; branch occurs ; [] |419| 
||$C$L26||:    
        MOVB      AL,#0                 ; [CPU_ALU] |419| 
||$C$L27||:    
        SUBB      SP,#8                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$288	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$288, DW_AT_low_pc(0x00)
	.dwattr $C$DW$288, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$281, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$281, DW_AT_TI_end_line(0x1ac)
	.dwattr $C$DW$281, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$281

	.sect	"isrcodefuncs:retain"
	.retain
	.retainrefs
	.global	||ISR4||

$C$DW$289	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$289, DW_AT_name("ISR4")
	.dwattr $C$DW$289, DW_AT_low_pc(||ISR4||)
	.dwattr $C$DW$289, DW_AT_high_pc(0x00)
	.dwattr $C$DW$289, DW_AT_linkage_name("ISR4")
	.dwattr $C$DW$289, DW_AT_external
	.dwattr $C$DW$289, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$289, DW_AT_decl_line(0xf5)
	.dwattr $C$DW$289, DW_AT_decl_column(0x10)
	.dwattr $C$DW$289, DW_AT_TI_interrupt
	.dwattr $C$DW$289, DW_AT_TI_max_frame_size(-18)
	.dwpsn	file "../bts_main.c",line 246,column 1,is_stmt,address ||ISR4||,isa 0

	.dwfde $C$DW$CIE, ||ISR4||

;***************************************************************
;* FNAME: ISR4                          FR SIZE:  16           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto, 14 SOE     *
;***************************************************************

||ISR4||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ASP       ; [CPU_ALU] 
        PUSH      AR1H:AR0H             ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 5, 2
	.dwcfi	save_reg_to_mem, 7, 3
	.dwcfi	cfa_offset, -4
        MOVL      *SP++,XT              ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 21, 4
	.dwcfi	save_reg_to_mem, 22, 5
	.dwcfi	cfa_offset, -6
        MOVL      *SP++,XAR4            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 12, 6
	.dwcfi	save_reg_to_mem, 13, 7
	.dwcfi	cfa_offset, -8
        MOVL      *SP++,XAR5            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 14, 8
	.dwcfi	save_reg_to_mem, 15, 9
	.dwcfi	cfa_offset, -10
        MOVL      *SP++,XAR6            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 16, 10
	.dwcfi	save_reg_to_mem, 17, 11
	.dwcfi	cfa_offset, -12
        MOVL      *SP++,XAR7            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 18, 12
	.dwcfi	save_reg_to_mem, 19, 13
	.dwcfi	cfa_offset, -14
        PUSH      RB                    ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 74, 16
	.dwcfi	cfa_offset, -16
        SAVE      RNDF32=1, RNDF64=1    ; [CPU_FPU] 
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -18
        SPM       0                     ; [CPU_ALU] 
        CLRC      PAGE0,OVM             ; [CPU_ALU] 
        CLRC      AMODE                 ; [CPU_ALU] 
        MOVW      DP,#||BTS_ADC2||      ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR4,#2097152         ; [CPU_ARAU] |472| 
        MOVL      XAR5,#32522           ; [CPU_ARAU] |472| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |472| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 156,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ADC2||),*(0:0x6127) ; [CPU_ALU] |156| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 158,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |158| 
        MOVU      ACC,AL                ; [CPU_ALU] |158| 
        MOVL      @$BLOCKED(||BTS_ADC2||)+2,ACC ; [CPU_ALU] |158| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 159,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |159| 
        MOVU      ACC,AL                ; [CPU_ALU] |159| 
        MOVL      @$BLOCKED(||BTS_ADC2||)+4,ACC ; [CPU_ALU] |159| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 160,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |160| 
        MOVU      ACC,AL                ; [CPU_ALU] |160| 
        MOVL      @$BLOCKED(||BTS_ADC2||)+6,ACC ; [CPU_ALU] |160| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 161,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |161| 
        MOVU      ACC,AL                ; [CPU_ALU] |161| 
        MOVL      @$BLOCKED(||BTS_ADC2||)+8,ACC ; [CPU_ALU] |161| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 162,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |162| 
        MOVU      ACC,AL                ; [CPU_ALU] |162| 
        MOVL      @$BLOCKED(||BTS_ADC2||)+10,ACC ; [CPU_ALU] |162| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 163,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |163| 
        MOVU      ACC,AL                ; [CPU_ALU] |163| 
        MOVL      @$BLOCKED(||BTS_ADC2||)+12,ACC ; [CPU_ALU] |163| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 164,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |164| 
        MOVU      ACC,AL                ; [CPU_ALU] |164| 
        MOVL      @$BLOCKED(||BTS_ADC2||)+14,ACC ; [CPU_ALU] |164| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 165,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6127)        ; [CPU_ALU] |165| 
        MOVZ      AR6,AL                ; [CPU_ALU] |165| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 218,column 5,is_stmt,isa 0
        MOVL      XAR4,#24864           ; [CPU_ARAU] |218| 
        MOVB      ACC,#4                ; [CPU_ALU] |218| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |218| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 165,column 5,is_stmt,isa 0
        MOVL      @$BLOCKED(||BTS_ADC2||)+16,XAR6 ; [CPU_ALU] |165| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 218,column 5,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |218| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 166,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ADC2||)+1,*(0:0x6127) ; [CPU_ALU] |166| 
        MOVW      DP,#||BTS_ExAdcRxflag2|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 215,column 5,is_stmt,isa 0
        MOVB      @||BTS_ExAdcRxflag2||,#1,UNC ; [CPU_ALU] |215| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 218,column 5,is_stmt,isa 0
$C$DW$290	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$290, DW_AT_low_pc(0x00)
	.dwattr $C$DW$290, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$290, DW_AT_TI_call

        LCR       #||SPI_clearInterruptStatus|| ; [CPU_ALU] |218| 
        ; call occurs [#||SPI_clearInterruptStatus||] ; [] |218| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 429,column 5,is_stmt,isa 0
        MOVB      AL,#32                ; [CPU_ALU] |429| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 430,column 5,is_stmt,isa 0
        MOVL      XAR4,#32520           ; [CPU_ARAU] |430| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 429,column 5,is_stmt,isa 0
        MOV       *(0:0x0ce1),AL        ; [CPU_ALU] |429| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 430,column 5,is_stmt,isa 0
        TBIT      *+XAR4[1],#1          ; [CPU_ALU] |430| 
        B         ||$C$L28||,TC         ; [CPU_ALU] |430| 
        ; branchcc occurs ; [] |430| 
        MOVW      DP,#||BTS_ExAdcRxflag2|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 184,column 5,is_stmt,isa 0
        MOV       AL,@||BTS_ExAdcRxflag2|| ; [CPU_ALU] |184| 
        CMPB      AL,#1                 ; [CPU_ALU] |184| 
        B         ||$C$L28||,NEQ        ; [CPU_ALU] |184| 
        ; branchcc occurs ; [] |184| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 186,column 9,is_stmt,isa 0
        MOV       @||BTS_ExAdcRxflag2||,#0 ; [CPU_ALU] |186| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#2097152         ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32524           ; [CPU_ARAU] |468| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 139,column 5,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |139| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 142,column 5,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |142| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 146,column 8,is_stmt,isa 0
        MOVB      AH,#0                 ; [CPU_ALU] |146| 
        MOV       PH,#0                 ; [CPU_ALU] |146| 
        MOV       PL,#0                 ; [CPU_ALU] |146| 
        MOVB      XAR7,#0               ; [CPU_ALU] |146| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 139,column 5,is_stmt,isa 0
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |139| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 142,column 5,is_stmt,isa 0
        MOV       *(0:0x6128),AR6       ; [CPU_ALU] |142| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 146,column 8,is_stmt,isa 0
        MOV       *(0:0x6128),AH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),PH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),PL        ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AR7       ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AR6       ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |146| 
||$C$L28||:    
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -16
        RESTORE   ; [CPU_FPU] 
        POP       RB                    ; [CPU_FPU] 
	.dwcfi	cfa_offset, -14
	.dwcfi	restore_reg, 74
        MOVL      XAR7,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -12
	.dwcfi	restore_reg, 18
        MOVL      XAR6,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -10
	.dwcfi	restore_reg, 16
        MOVL      XAR5,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -8
	.dwcfi	restore_reg, 14
        MOVL      XAR4,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -6
	.dwcfi	restore_reg, 12
        MOVL      XT,*--SP              ; [CPU_ALU] 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 22
	.dwcfi	restore_reg, 21
        POP       AR1H:AR0H             ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 5
	.dwcfi	restore_reg, 7
        NASP      ; [CPU_ALU] 
$C$DW$291	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$291, DW_AT_low_pc(0x00)
	.dwattr $C$DW$291, DW_AT_TI_return

        IRET      ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$289, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$289, DW_AT_TI_end_line(0xf9)
	.dwattr $C$DW$289, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$289

	.sect	"isrcodefuncs:retain"
	.retain
	.retainrefs
	.global	||ISR3||

$C$DW$292	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$292, DW_AT_name("ISR3")
	.dwattr $C$DW$292, DW_AT_low_pc(||ISR3||)
	.dwattr $C$DW$292, DW_AT_high_pc(0x00)
	.dwattr $C$DW$292, DW_AT_linkage_name("ISR3")
	.dwattr $C$DW$292, DW_AT_external
	.dwattr $C$DW$292, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$292, DW_AT_decl_line(0xdf)
	.dwattr $C$DW$292, DW_AT_decl_column(0x10)
	.dwattr $C$DW$292, DW_AT_TI_interrupt
	.dwattr $C$DW$292, DW_AT_TI_max_frame_size(-14)
	.dwpsn	file "../bts_main.c",line 224,column 1,is_stmt,address ||ISR3||,isa 0

	.dwfde $C$DW$CIE, ||ISR3||

;***************************************************************
;* FNAME: ISR3                          FR SIZE:  12           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto, 12 SOE     *
;***************************************************************

||ISR3||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ASP       ; [CPU_ALU] 
        MOVL      *SP++,XT              ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 21, 2
	.dwcfi	save_reg_to_mem, 22, 3
	.dwcfi	cfa_offset, -4
        MOVL      *SP++,XAR4            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 12, 4
	.dwcfi	save_reg_to_mem, 13, 5
	.dwcfi	cfa_offset, -6
        MOVL      *SP++,XAR5            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 14, 6
	.dwcfi	save_reg_to_mem, 15, 7
	.dwcfi	cfa_offset, -8
        MOVL      *SP++,XAR6            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 16, 8
	.dwcfi	save_reg_to_mem, 17, 9
	.dwcfi	cfa_offset, -10
        MOVL      *SP++,XAR7            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 18, 10
	.dwcfi	save_reg_to_mem, 19, 11
	.dwcfi	cfa_offset, -12
        PUSH      RB                    ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 74, 14
	.dwcfi	cfa_offset, -14
        SAVE      RNDF32=1, RNDF64=1    ; [CPU_FPU] 
        CLRC      PAGE0,OVM             ; [CPU_ALU] 
        CLRC      AMODE                 ; [CPU_ALU] 
        MOVW      DP,#||BTS_ExAdcRxflag2|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 184,column 5,is_stmt,isa 0
        MOV       AL,@||BTS_ExAdcRxflag2|| ; [CPU_ALU] |184| 
        CMPB      AL,#1                 ; [CPU_ALU] |184| 
        B         ||$C$L29||,NEQ        ; [CPU_ALU] |184| 
        ; branchcc occurs ; [] |184| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 186,column 9,is_stmt,isa 0
        MOV       @||BTS_ExAdcRxflag2||,#0 ; [CPU_ALU] |186| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#2097152         ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32524           ; [CPU_ARAU] |468| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 142,column 5,is_stmt,isa 0
        MOV       ACC,#0                ; [CPU_ALU] |142| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 146,column 8,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |146| 
        MOVB      XAR7,#0               ; [CPU_ALU] |146| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 139,column 5,is_stmt,isa 0
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |139| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 142,column 5,is_stmt,isa 0
        MOV       *(0:0x6128),AH        ; [CPU_ALU] |142| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 146,column 8,is_stmt,isa 0
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AR6       ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AR7       ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AR6       ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6128),AL        ; [CPU_ALU] |146| 
||$C$L29||:    
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 429,column 5,is_stmt,isa 0
        MOVB      AL,#1                 ; [CPU_ALU] |429| 
        MOV       *(0:0x0ce1),AL        ; [CPU_ALU] |429| 
        RESTORE   ; [CPU_FPU] 
        POP       RB                    ; [CPU_FPU] 
	.dwcfi	cfa_offset, -12
	.dwcfi	restore_reg, 74
        MOVL      XAR7,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -10
	.dwcfi	restore_reg, 18
        MOVL      XAR6,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -8
	.dwcfi	restore_reg, 16
        MOVL      XAR5,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -6
	.dwcfi	restore_reg, 14
        MOVL      XAR4,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 12
        MOVL      XT,*--SP              ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 22
	.dwcfi	restore_reg, 21
        NASP      ; [CPU_ALU] 
$C$DW$293	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$293, DW_AT_low_pc(0x00)
	.dwattr $C$DW$293, DW_AT_TI_return

        IRET      ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$292, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$292, DW_AT_TI_end_line(0xea)
	.dwattr $C$DW$292, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$292

	.sect	"isrcodefuncs:retain"
	.retain
	.retainrefs
	.global	||ISR2||

$C$DW$294	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$294, DW_AT_name("ISR2")
	.dwattr $C$DW$294, DW_AT_low_pc(||ISR2||)
	.dwattr $C$DW$294, DW_AT_high_pc(0x00)
	.dwattr $C$DW$294, DW_AT_linkage_name("ISR2")
	.dwattr $C$DW$294, DW_AT_external
	.dwattr $C$DW$294, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$294, DW_AT_decl_line(0xee)
	.dwattr $C$DW$294, DW_AT_decl_column(0x10)
	.dwattr $C$DW$294, DW_AT_TI_interrupt
	.dwattr $C$DW$294, DW_AT_TI_max_frame_size(-18)
	.dwpsn	file "../bts_main.c",line 239,column 1,is_stmt,address ||ISR2||,isa 0

	.dwfde $C$DW$CIE, ||ISR2||

;***************************************************************
;* FNAME: ISR2                          FR SIZE:  16           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto, 14 SOE     *
;***************************************************************

||ISR2||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ASP       ; [CPU_ALU] 
        PUSH      AR1H:AR0H             ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 5, 2
	.dwcfi	save_reg_to_mem, 7, 3
	.dwcfi	cfa_offset, -4
        MOVL      *SP++,XT              ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 21, 4
	.dwcfi	save_reg_to_mem, 22, 5
	.dwcfi	cfa_offset, -6
        MOVL      *SP++,XAR4            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 12, 6
	.dwcfi	save_reg_to_mem, 13, 7
	.dwcfi	cfa_offset, -8
        MOVL      *SP++,XAR5            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 14, 8
	.dwcfi	save_reg_to_mem, 15, 9
	.dwcfi	cfa_offset, -10
        MOVL      *SP++,XAR6            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 16, 10
	.dwcfi	save_reg_to_mem, 17, 11
	.dwcfi	cfa_offset, -12
        MOVL      *SP++,XAR7            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 18, 12
	.dwcfi	save_reg_to_mem, 19, 13
	.dwcfi	cfa_offset, -14
        PUSH      RB                    ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 74, 16
	.dwcfi	cfa_offset, -16
        SAVE      RNDF32=1, RNDF64=1    ; [CPU_FPU] 
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -18
        SPM       0                     ; [CPU_ALU] 
        CLRC      PAGE0,OVM             ; [CPU_ALU] 
        CLRC      AMODE                 ; [CPU_ALU] 
        MOVW      DP,#||BTS_ADC1||      ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOVL      XAR4,#524288          ; [CPU_ARAU] |472| 
        MOVL      XAR5,#32514           ; [CPU_ARAU] |472| 
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |472| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 156,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ADC1||),*(0:0x6107) ; [CPU_ALU] |156| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 158,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |158| 
        MOVU      ACC,AL                ; [CPU_ALU] |158| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+2,ACC ; [CPU_ALU] |158| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 159,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |159| 
        MOVU      ACC,AL                ; [CPU_ALU] |159| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+4,ACC ; [CPU_ALU] |159| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 160,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |160| 
        MOVU      ACC,AL                ; [CPU_ALU] |160| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+6,ACC ; [CPU_ALU] |160| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 161,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |161| 
        MOVU      ACC,AL                ; [CPU_ALU] |161| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+8,ACC ; [CPU_ALU] |161| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 162,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |162| 
        MOVU      ACC,AL                ; [CPU_ALU] |162| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+10,ACC ; [CPU_ALU] |162| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 163,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |163| 
        MOVU      ACC,AL                ; [CPU_ALU] |163| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+12,ACC ; [CPU_ALU] |163| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 164,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |164| 
        MOVU      ACC,AL                ; [CPU_ALU] |164| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+14,ACC ; [CPU_ALU] |164| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 165,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |165| 
        MOVZ      AR6,AL                ; [CPU_ALU] |165| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 203,column 5,is_stmt,isa 0
        MOVL      XAR4,#24832           ; [CPU_ARAU] |203| 
        MOVB      ACC,#4                ; [CPU_ALU] |203| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |203| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 165,column 5,is_stmt,isa 0
        MOVL      @$BLOCKED(||BTS_ADC1||)+16,XAR6 ; [CPU_ALU] |165| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 203,column 5,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |203| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 166,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ADC1||)+1,*(0:0x6107) ; [CPU_ALU] |166| 
        MOVW      DP,#||BTS_ExAdcRxflag1|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 200,column 5,is_stmt,isa 0
        MOVB      @||BTS_ExAdcRxflag1||,#1,UNC ; [CPU_ALU] |200| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 203,column 5,is_stmt,isa 0
$C$DW$295	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$295, DW_AT_low_pc(0x00)
	.dwattr $C$DW$295, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$295, DW_AT_TI_call

        LCR       #||SPI_clearInterruptStatus|| ; [CPU_ALU] |203| 
        ; call occurs [#||SPI_clearInterruptStatus||] ; [] |203| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 429,column 5,is_stmt,isa 0
        MOVB      AL,#32                ; [CPU_ALU] |429| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 430,column 5,is_stmt,isa 0
        MOVL      XAR4,#32512           ; [CPU_ARAU] |430| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 429,column 5,is_stmt,isa 0
        MOV       *(0:0x0ce1),AL        ; [CPU_ALU] |429| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 430,column 5,is_stmt,isa 0
        TBIT      *+XAR4[1],#9          ; [CPU_ALU] |430| 
        B         ||$C$L30||,TC         ; [CPU_ALU] |430| 
        ; branchcc occurs ; [] |430| 
        MOVW      DP,#||BTS_ExAdcRxflag1|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 171,column 5,is_stmt,isa 0
        MOV       AL,@||BTS_ExAdcRxflag1|| ; [CPU_ALU] |171| 
        CMPB      AL,#1                 ; [CPU_ALU] |171| 
        B         ||$C$L30||,NEQ        ; [CPU_ALU] |171| 
        ; branchcc occurs ; [] |171| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 173,column 9,is_stmt,isa 0
        MOV       @||BTS_ExAdcRxflag1||,#0 ; [CPU_ALU] |173| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#524288          ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 139,column 5,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |139| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 142,column 5,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |142| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 146,column 8,is_stmt,isa 0
        MOVB      AH,#0                 ; [CPU_ALU] |146| 
        MOV       PH,#0                 ; [CPU_ALU] |146| 
        MOV       PL,#0                 ; [CPU_ALU] |146| 
        MOVB      XAR7,#0               ; [CPU_ALU] |146| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 139,column 5,is_stmt,isa 0
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |139| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 142,column 5,is_stmt,isa 0
        MOV       *(0:0x6108),AR6       ; [CPU_ALU] |142| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 146,column 8,is_stmt,isa 0
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),PH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),PL        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AR7       ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AR6       ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |146| 
||$C$L30||:    
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -16
        RESTORE   ; [CPU_FPU] 
        POP       RB                    ; [CPU_FPU] 
	.dwcfi	cfa_offset, -14
	.dwcfi	restore_reg, 74
        MOVL      XAR7,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -12
	.dwcfi	restore_reg, 18
        MOVL      XAR6,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -10
	.dwcfi	restore_reg, 16
        MOVL      XAR5,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -8
	.dwcfi	restore_reg, 14
        MOVL      XAR4,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -6
	.dwcfi	restore_reg, 12
        MOVL      XT,*--SP              ; [CPU_ALU] 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 22
	.dwcfi	restore_reg, 21
        POP       AR1H:AR0H             ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 5
	.dwcfi	restore_reg, 7
        NASP      ; [CPU_ALU] 
$C$DW$296	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$296, DW_AT_low_pc(0x00)
	.dwattr $C$DW$296, DW_AT_TI_return

        IRET      ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$294, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$294, DW_AT_TI_end_line(0xf2)
	.dwattr $C$DW$294, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$294

	.sect	"isrcodefuncs:retain"
	.retain
	.retainrefs
	.global	||ISR1||

$C$DW$297	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$297, DW_AT_name("ISR1")
	.dwattr $C$DW$297, DW_AT_low_pc(||ISR1||)
	.dwattr $C$DW$297, DW_AT_high_pc(0x00)
	.dwattr $C$DW$297, DW_AT_linkage_name("ISR1")
	.dwattr $C$DW$297, DW_AT_external
	.dwattr $C$DW$297, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$297, DW_AT_decl_line(0xd1)
	.dwattr $C$DW$297, DW_AT_decl_column(0x10)
	.dwattr $C$DW$297, DW_AT_TI_interrupt
	.dwattr $C$DW$297, DW_AT_TI_max_frame_size(-18)
	.dwpsn	file "../bts_main.c",line 210,column 1,is_stmt,address ||ISR1||,isa 0

	.dwfde $C$DW$CIE, ||ISR1||

;***************************************************************
;* FNAME: ISR1                          FR SIZE:  16           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto, 14 SOE     *
;***************************************************************

||ISR1||:
;* AL    assigned to $O$C4
;* AL    assigned to $O$C5
;* AL    assigned to $O$C6
;* AR6   assigned to $O$C7
;* R2    assigned to $O$C8
;* AR5   assigned to $O$C9
;* R4    assigned to $O$C10
;* AR1   assigned to $O$C11
;* AR5   assigned to $O$K14
;* AR4   assigned to $O$K14
;* AR4   assigned to $O$K14
;* AL    assigned to compHR
$C$DW$298	.dwtag  DW_TAG_variable
	.dwattr $C$DW$298, DW_AT_name("compHR")
	.dwattr $C$DW$298, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$298, DW_AT_location[DW_OP_reg0]

;* AL    assigned to compHR
$C$DW$299	.dwtag  DW_TAG_variable
	.dwattr $C$DW$299, DW_AT_name("compHR")
	.dwattr $C$DW$299, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$299, DW_AT_location[DW_OP_reg0]

;* AL    assigned to compHR
$C$DW$300	.dwtag  DW_TAG_variable
	.dwattr $C$DW$300, DW_AT_name("compHR")
	.dwattr $C$DW$300, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$300, DW_AT_location[DW_OP_reg0]

;* AR4   assigned to $O$K24
;* PL    assigned to $O$U26
;* R0    assigned to $O$v4
;* R0    assigned to $O$v3
;* R1    assigned to $O$v2
;* R2    assigned to $O$R1
;* AR7   assigned to current_16b
$C$DW$301	.dwtag  DW_TAG_variable
	.dwattr $C$DW$301, DW_AT_name("current_16b")
	.dwattr $C$DW$301, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$301, DW_AT_location[DW_OP_reg18]

;* AR6   assigned to voltage_16b
$C$DW$302	.dwtag  DW_TAG_variable
	.dwattr $C$DW$302, DW_AT_name("voltage_16b")
	.dwattr $C$DW$302, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$302, DW_AT_location[DW_OP_reg16]

;* AR6   assigned to current_16b
$C$DW$303	.dwtag  DW_TAG_variable
	.dwattr $C$DW$303, DW_AT_name("current_16b")
	.dwattr $C$DW$303, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$303, DW_AT_location[DW_OP_reg16]

;* AR7   assigned to voltage_16b
$C$DW$304	.dwtag  DW_TAG_variable
	.dwattr $C$DW$304, DW_AT_name("voltage_16b")
	.dwattr $C$DW$304, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$304, DW_AT_location[DW_OP_reg18]

;* AL    assigned to $O$S2
;* AR6   assigned to current_16b
$C$DW$305	.dwtag  DW_TAG_variable
	.dwattr $C$DW$305, DW_AT_name("current_16b")
	.dwattr $C$DW$305, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$305, DW_AT_location[DW_OP_reg16]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ASP       ; [CPU_ALU] 
        PUSH      AR1H:AR0H             ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 5, 2
	.dwcfi	save_reg_to_mem, 7, 3
	.dwcfi	cfa_offset, -4
        MOVL      *SP++,XT              ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 21, 4
	.dwcfi	save_reg_to_mem, 22, 5
	.dwcfi	cfa_offset, -6
        MOVL      *SP++,XAR4            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 12, 6
	.dwcfi	save_reg_to_mem, 13, 7
	.dwcfi	cfa_offset, -8
        MOVL      *SP++,XAR5            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 14, 8
	.dwcfi	save_reg_to_mem, 15, 9
	.dwcfi	cfa_offset, -10
        MOVL      *SP++,XAR6            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 16, 10
	.dwcfi	save_reg_to_mem, 17, 11
	.dwcfi	cfa_offset, -12
        MOVL      *SP++,XAR7            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 18, 12
	.dwcfi	save_reg_to_mem, 19, 13
	.dwcfi	cfa_offset, -14
        PUSH      RB                    ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 74, 16
	.dwcfi	cfa_offset, -16
        SAVE      RNDF32=1, RNDF64=1    ; [CPU_FPU] 
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -18
        SPM       0                     ; [CPU_ALU] 
        CLRC      PAGE0,OVM             ; [CPU_ALU] 
        CLRC      AMODE                 ; [CPU_ALU] 
        MOVW      DP,#||BTS_ExAdcRxflag1|| ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 642,column 5,is_stmt,isa 0
        MOV       AL,@||BTS_ExAdcRxflag1|| ; [CPU_ALU] |642| 
        CMPB      AL,#1                 ; [CPU_ALU] |642| 
        B         ||$C$L44||,NEQ        ; [CPU_ALU] |642| 
        ; branchcc occurs ; [] |642| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 171,column 5,is_stmt,isa 0
        MOV       AL,@||BTS_ExAdcRxflag1|| ; [CPU_ALU] |171| 
        CMPB      AL,#1                 ; [CPU_ALU] |171| 
        B         ||$C$L31||,NEQ        ; [CPU_ALU] |171| 
        ; branchcc occurs ; [] |171| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 173,column 9,is_stmt,isa 0
        MOV       @||BTS_ExAdcRxflag1||,#0 ; [CPU_ALU] |173| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#524288          ; [CPU_ARAU] |468| 
        MOVL      XAR5,#32516           ; [CPU_ARAU] |468| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 142,column 5,is_stmt,isa 0
        MOV       ACC,#0                ; [CPU_ALU] |142| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 146,column 8,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |146| 
        MOVB      XAR7,#0               ; [CPU_ALU] |146| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |468| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 139,column 5,is_stmt,isa 0
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |139| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 142,column 5,is_stmt,isa 0
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |142| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 146,column 8,is_stmt,isa 0
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AR6       ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AR7       ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AR6       ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |146| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |146| 
||$C$L31||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 612,column 5,is_stmt,isa 0
        MOVL      XAR1,#||BTS_ctrlLoopVariable_ch1|| ; [CPU_ARAU] |612| 
        MOV32     R0H,*+XAR1[4]         ; [CPU_FPU] |612| 
$C$DW$306	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$306, DW_AT_low_pc(0x00)
	.dwattr $C$DW$306, DW_AT_name("__SFRA_F32_inject")
	.dwattr $C$DW$306, DW_AT_TI_call

        LCR       #||__SFRA_F32_inject|| ; [CPU_ALU] |612| 
        ; call occurs [#||__SFRA_F32_inject||] ; [] |612| 
        MOVW      DP,#||BTS_ADC1||+2    ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOVB      XAR0,#72              ; [CPU_ALU] |409| 
        MOVL      XAR4,#||BTS_measValues_ch1|| ; [CPU_ARAU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 105,is_stmt,isa 0
        MOVL      XAR7,@$BLOCKED(||BTS_ADC1||)+2 ; [CPU_ALU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV       PL,*+XAR4[AR0]        ; [CPU_ALU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 612,column 5,is_stmt,isa 0
        MOV32     *+XAR1[6],R0H         ; [CPU_FPU] |612| 
        MOV       AL,PL                 ; [CPU_ALU] |612| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 105,is_stmt,isa 0
        MOVL      XAR6,@$BLOCKED(||BTS_ADC1||)+4 ; [CPU_ALU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        CMPB      AL,#32                ; [CPU_ALU] |409| 
        B         ||$C$L32||,LO         ; [CPU_ALU] |409| 
        ; branchcc occurs ; [] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 415,column 9,is_stmt,isa 0
        MOVB      XAR0,#72              ; [CPU_ALU] |415| 
        MOV       *+XAR4[AR0],#0        ; [CPU_ALU] |415| 
        B         ||$C$L33||,UNC        ; [CPU_ALU] |415| 
        ; branch occurs ; [] |415| 
||$C$L32||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 410,column 9,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |410| 
        ADDU      ACC,PL                ; [CPU_ALU] |410| 
        MOVL      XAR5,ACC              ; [CPU_ALU] |410| 
        MOVW      DP,#||BTS_measValues_ch1||+72 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 411,column 9,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |411| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 410,column 9,is_stmt,isa 0
        MOV       *+XAR5[4],AR7         ; [CPU_ALU] |410| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 411,column 9,is_stmt,isa 0
        ADDU      ACC,@$BLOCKED(||BTS_measValues_ch1||)+72 ; [CPU_ALU] |411| 
        MOVL      XAR4,ACC              ; [CPU_ALU] |411| 
        MOVB      XAR0,#36              ; [CPU_ALU] |411| 
        MOV       *+XAR4[AR0],AR6       ; [CPU_ALU] |411| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 412,column 9,is_stmt,isa 0
        INC       @$BLOCKED(||BTS_measValues_ch1||)+72 ; [CPU_ALU] |412| 
||$C$L33||:    
        MOVW      DP,#||BTS_ADC1||+2    ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 460,column 189,is_stmt,isa 0
        MOVL      XAR6,@$BLOCKED(||BTS_ADC1||)+2 ; [CPU_ALU] |460| 
        MOVL      XAR7,@$BLOCKED(||BTS_ADC1||)+4 ; [CPU_ALU] |460| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1||+34 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 383,column 5,is_stmt,isa 0
        MOV       AH,@$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+34 ; [CPU_ALU] |383| 
        B         ||$C$L34||,NEQ        ; [CPU_ALU] |383| 
        ; branchcc occurs ; [] |383| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4492,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |4492| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4493,column 5,is_stmt,isa 0
        MOV       AH,*(0:0x4097)        ; [CPU_ALU] |4493| 
        ORB       AH,#0x04              ; [CPU_ALU] |4493| 
        MOV       *(0:0x4097),AH        ; [CPU_ALU] |4493| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4494,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |4494| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 400,column 9,is_stmt,isa 0
        B         ||$C$L35||,UNC        ; [CPU_ALU] |400| 
        ; branch occurs ; [] |400| 
||$C$L34||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4606,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |4606| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4607,column 5,is_stmt,isa 0
        MOV       AH,*(0:0x409b)        ; [CPU_ALU] |4607| 
        ORB       AH,#0x04              ; [CPU_ALU] |4607| 
        MOV       *(0:0x409b),AH        ; [CPU_ALU] |4607| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4057,column 5,is_stmt,isa 0
        MOV       AH,*(0:0x4084)        ; [CPU_ALU] |4057| 
        AND       AH,AH,#0xfffe         ; [CPU_ALU] |4057| 
        ORB       AH,#0x02              ; [CPU_ALU] |4057| 
        MOV       *(0:0x4084),AH        ; [CPU_ALU] |4057| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4060,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |4060| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       AL,#799               ; [CPU_ALU] |2406| 
        MOVB      AH,#0                 ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 394,column 9,is_stmt,isa 0
        ZERO      R1H                   ; [CPU_FPU] |394| 
        MOVW      DP,#||BTS_ctrl_cc_ch1||+10 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 395,column 9,is_stmt,isa 0
        ZERO      R0H                   ; [CPU_FPU] |395| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x406b),AH        ; [CPU_ALU] |2406| 
        MOV       *(0:0x406d),AL        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x406a),AH        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x406c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 394,column 9,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+10,R1H ; [CPU_FPU] |394| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 395,column 9,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+12,R0H ; [CPU_FPU] |395| 
||$C$L35||:    
        SETC      SXM                   ; [CPU_ALU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 468,column 5,is_stmt,isa 0
        MOV       ACC,AR6               ; [CPU_ALU] |468| 
        MOVL      XAR5,#||BTS_ctrlLoopVariable_ch1|| ; [CPU_ARAU] |468| 
        MOV32     R0H,ACC               ; [CPU_FPU] |468| 
        MOVW      DP,#||BTS_ctrl_cc_ch1|| ; [CPU_ARAU] 
        MOVL      XAR4,XAR5             ; [CPU_ALU] |468| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 469,column 5,is_stmt,isa 0
        MOV       ACC,AR7               ; [CPU_ALU] |469| 
        MOV32     R3H,ACC               ; [CPU_FPU] |469| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 535,column 5,is_stmt,isa 0
        MOVB      XAR0,#16              ; [CPU_ALU] |535| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 468,column 5,is_stmt,isa 0
        I32TOF32  R1H,R0H               ; [CPU_FPU] |468| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVB      XAR1,#16              ; [CPU_ALU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 468,column 5,is_stmt,isa 0
        MPYF32    R4H,R1H,#14336        ; [CPU_FPU] |468| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 469,column 5,is_stmt,isa 0
        I32TOF32  R6H,R3H               ; [CPU_FPU] |469| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 533,column 5,is_stmt,isa 0
        MOV32     R1H,*+XAR4[6]         ; [CPU_FPU] |533| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVB      AL,#1                 ; [CPU_ALU] |1703| 
        MOVIZ     R3H,#16140            ; [CPU_FPU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 533,column 5,is_stmt,isa 0

        SUBF32    R1H,R1H,R4H           ; [CPU_FPU] |533| 
||      MOV32     R0H,@$BLOCKED(||BTS_ctrl_cc_ch1||) ; [CPU_FPU] |1447| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 469,column 5,is_stmt,isa 0
        MPYF32    R6H,R6H,#14336        ; [CPU_FPU] |469| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0

        MPYF32    R2H,R1H,R0H           ; [CPU_FPU] |1447| 
||      MOV32     R5H,@$BLOCKED(||BTS_ctrl_cc_ch1||)+10 ; [CPU_FPU] |1447| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVXI     R3H,#52429            ; [CPU_FPU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16140            ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0
        ADDF32    R2H,R2H,R5H           ; [CPU_FPU] |1447| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 535,column 5,is_stmt,isa 0
        MOV32     *+XAR5[AR0],R2H       ; [CPU_FPU] |535| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 533,column 5,is_stmt,isa 0
        MOV32     R5H,*+XAR5[6]         ; [CPU_FPU] |533| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MINF32    R0H,R2H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 526,column 5,is_stmt,isa 0
        MOVB      XAR0,#30              ; [CPU_ALU] |526| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MAXF32    R0H,#0                ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 526,column 5,is_stmt,isa 0
        MOV       *+XAR4[AR0],#0        ; [CPU_ALU] |526| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 468,column 5,is_stmt,isa 0
        MOVB      XAR0,#8               ; [CPU_ALU] |468| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOV32     *+XAR5[AR1],R0H       ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 468,column 5,is_stmt,isa 0

        MOV32     *+XAR4[AR0],R4H       ; [CPU_FPU] |468| 
||      SUBF32    R5H,R5H,R4H           ; [CPU_FPU] |533| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 533,column 5,is_stmt,isa 0
        MOVB      XAR0,#18              ; [CPU_ALU] |533| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        CMPF32    R2H,R3H               ; [CPU_FPU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 533,column 5,is_stmt,isa 0
        MOV32     *+XAR5[AR0],R5H       ; [CPU_FPU] |533| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 469,column 5,is_stmt,isa 0
        MOVB      XAR0,#14              ; [CPU_ALU] |469| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 469,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R6H       ; [CPU_FPU] |469| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        B         ||$C$L36||,GEQ        ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
        CMPF32    R2H,#0                ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L38||,GT         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
||$C$L36||:    
        CMPB      AL,#0                 ; [CPU_ALU] |1703| 
        B         ||$C$L38||,EQ         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 548,column 13,is_stmt,isa 0
        CMPF32    R0H,#0                ; [CPU_FPU] |548| 
        MOVST0    ZF, NF                ; [CPU_FPU] |548| 
        B         ||$C$L37||,GT         ; [CPU_ALU] |548| 
        ; branchcc occurs ; [] |548| 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 247,column 21,is_stmt,isa 0
        UI32TOF32 R1H,@||MEP_ScaleFactor|| ; [CPU_FPU] |247| 
        NOP       ; [CPU_ALU] 
        MPYF32    R1H,R1H,#0            ; [CPU_FPU] |247| 
        NOP       ; [CPU_ALU] 
        F32TOUI16 R1H,R1H               ; [CPU_FPU] |247| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |2406| 
        MOV       *(0:0x406b),AR6       ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 247,column 21,is_stmt,isa 0
        MOV32     ACC,R1H               ; [CPU_FPU] |247| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 552,column 17,is_stmt,isa 0
        ZERO      R1H                   ; [CPU_FPU] |552| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      AH,#0                 ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x406a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 552,column 17,is_stmt,isa 0
        MOV32     *+XAR5[0],R1H         ; [CPU_FPU] |552| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x406d),AH        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x406c),AL        ; [CPU_ALU] |1262| 
||$C$L37||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 554,column 13,is_stmt,isa 0
        MOVIZ     R1H,#16140            ; [CPU_FPU] |554| 
        MOVXI     R1H,#52429            ; [CPU_FPU] |554| 
        CMPF32    R0H,R1H               ; [CPU_FPU] |554| 
        MOVST0    ZF, NF                ; [CPU_FPU] |554| 
        B         ||$C$L43||,LT         ; [CPU_ALU] |554| 
        ; branchcc occurs ; [] |554| 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 247,column 21,is_stmt,isa 0
        MOVIZ     R0H,#16102            ; [CPU_FPU] |247| 
        UI32TOF32 R1H,@||MEP_ScaleFactor|| ; [CPU_FPU] |247| 
        MOVXI     R0H,#26624            ; [CPU_FPU] |247| 
        MPYF32    R0H,R0H,R1H           ; [CPU_FPU] |247| 
        NOP       ; [CPU_ALU] 
        F32TOUI16 R0H,R0H               ; [CPU_FPU] |247| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVL      XAR6,#439             ; [CPU_ALU] |2406| 
        MOV       *(0:0x406b),AR6       ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 247,column 21,is_stmt,isa 0
        MOV32     ACC,R0H               ; [CPU_FPU] |247| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 558,column 17,is_stmt,isa 0
        MOVIZ     R0H,#16140            ; [CPU_FPU] |558| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       AH,#439               ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x406a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 558,column 17,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |558| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x406d),AH        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 558,column 17,is_stmt,isa 0
        MOV32     *+XAR5[0],R0H         ; [CPU_FPU] |558| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x406c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 558,column 17,is_stmt,isa 0
        B         ||$C$L43||,UNC        ; [CPU_ALU] |558| 
        ; branch occurs ; [] |558| 
||$C$L38||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 424,column 5,is_stmt,isa 0
        MOVB      XAR0,#31              ; [CPU_ALU] |424| 
        MOV       AL,*+XAR4[AR0]        ; [CPU_ALU] |424| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 539,column 13,is_stmt,isa 0
        MOV32     *+XAR4[0],R0H         ; [CPU_FPU] |539| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 424,column 5,is_stmt,isa 0
        B         ||$C$L40||,NEQ        ; [CPU_ALU] |424| 
        ; branchcc occurs ; [] |424| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 441,column 9,is_stmt,isa 0
        CMP       AR6,#26306            ; [CPU_ALU] |441| 
        B         ||$C$L39||,GEQ        ; [CPU_ALU] |441| 
        ; branchcc occurs ; [] |441| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3032,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4049)        ; [CPU_ALU] |3032| 
        AND       AL,#0xfffc            ; [CPU_ALU] |3032| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 449,column 13,is_stmt,isa 0
        B         ||$C$L42||,UNC        ; [CPU_ALU] |449| 
        ; branch occurs ; [] |449| 
||$C$L39||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3032,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4049)        ; [CPU_ALU] |3032| 
        AND       AL,AL,#0xfffc         ; [CPU_ALU] |3032| 
        ORB       AL,#0x01              ; [CPU_ALU] |3032| 
        B         ||$C$L42||,UNC        ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L40||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 427,column 9,is_stmt,isa 0
        CMP       AR6,#-26305           ; [CPU_ALU] |427| 
        B         ||$C$L41||,LT         ; [CPU_ALU] |427| 
        ; branchcc occurs ; [] |427| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3038,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4049)        ; [CPU_ALU] |3038| 
        AND       AL,#0xfff3            ; [CPU_ALU] |3038| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 435,column 13,is_stmt,isa 0
        B         ||$C$L42||,UNC        ; [CPU_ALU] |435| 
        ; branch occurs ; [] |435| 
||$C$L41||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3038,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4049)        ; [CPU_ALU] |3038| 
        AND       AL,AL,#0xfffb         ; [CPU_ALU] |3038| 
        ORB       AL,#0x08              ; [CPU_ALU] |3038| 
||$C$L42||:    
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 247,column 21,is_stmt,isa 0
        MOVIZ     R2H,#17479            ; [CPU_FPU] |247| 
        MOVXI     R2H,#49152            ; [CPU_FPU] |247| 
        MPYF32    R2H,R2H,R0H           ; [CPU_FPU] |247| 
        NOP       ; [CPU_ALU] 
        F32TOUI16 R3H,R2H               ; [CPU_FPU] |247| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MOV32     XAR6,R3H              ; [CPU_FPU] |247| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3038,column 9,is_stmt,isa 0
        MOV       *(0:0x4049),AL        ; [CPU_ALU] |3038| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 247,column 21,is_stmt,isa 0
        MOVU      ACC,AR6               ; [CPU_ALU] |247| 
        MOV32     R3H,ACC               ; [CPU_FPU] |247| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
        UI32TOF32 R3H,R3H               ; [CPU_FPU] |247| 
        UI32TOF32 R4H,@||MEP_ScaleFactor|| ; [CPU_FPU] |247| 
        SUBF32    R2H,R2H,R3H           ; [CPU_FPU] |247| 
        NOP       ; [CPU_ALU] 
        MPYF32    R2H,R4H,R2H           ; [CPU_FPU] |247| 
        NOP       ; [CPU_ALU] 
        F32TOUI16 R2H,R2H               ; [CPU_FPU] |247| 
        MOVW      DP,#||BTS_ctrl_cc_ch1||+6 ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x406b),AR6       ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 247,column 21,is_stmt,isa 0
        MOV32     ACC,R2H               ; [CPU_FPU] |247| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
        MOV       *(0:0x406a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x406d),AR6       ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x406c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1458,column 5,is_stmt,isa 0
        MOV32     R2H,@$BLOCKED(||BTS_ctrl_cc_ch1||)+6 ; [CPU_FPU] |1458| 
        MOV32     R3H,@$BLOCKED(||BTS_ctrl_cc_ch1||)+2 ; [CPU_FPU] |1458| 
        MPYF32    R3H,R1H,R3H           ; [CPU_FPU] |1458| 

        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cc_ch1||)+12 ; [CPU_FPU] |1458| 
||      MPYF32    R2H,R0H,R2H           ; [CPU_FPU] |1458| 

        ADDF32    R3H,R3H,R4H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        SUBF32    R2H,R3H,R2H           ; [CPU_FPU] |1458| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 454,column 5,is_stmt,isa 0
        MOVB      XAR1,#26              ; [CPU_ALU] |454| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1458,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+10,R2H ; [CPU_FPU] |1458| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     R2H,@$BLOCKED(||BTS_ctrl_cc_ch1||)+8 ; [CPU_FPU] |1459| 

        MOV32     R3H,@$BLOCKED(||BTS_ctrl_cc_ch1||)+4 ; [CPU_FPU] |1459| 
||      MPYF32    R2H,R0H,R2H           ; [CPU_FPU] |1459| 

        MPYF32    R1H,R1H,R3H           ; [CPU_FPU] |1459| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 455,column 5,is_stmt,isa 0
        MOVB      XAR0,#28              ; [CPU_ALU] |455| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 454,column 5,is_stmt,isa 0

        SUBF32    R1H,R1H,R2H           ; [CPU_FPU] |1459| 
||      MOV32     *+XAR5[AR1],R0H       ; [CPU_FPU] |454| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 455,column 5,is_stmt,isa 0
        MOV32     *+XAR5[AR0],R0H       ; [CPU_FPU] |455| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+12,R1H ; [CPU_FPU] |1459| 
||$C$L43||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 629,column 5,is_stmt,isa 0
        MOVL      ACC,XAR5              ; [CPU_ALU] |629| 
        ADDB      XAR5,#6               ; [CPU_ALU] |629| 
        MOVL      XAR4,XAR5             ; [CPU_ALU] |629| 
        ADDB      ACC,#8                ; [CPU_ALU] |629| 
        MOVL      XAR5,ACC              ; [CPU_ALU] |629| 
$C$DW$307	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$307, DW_AT_low_pc(0x00)
	.dwattr $C$DW$307, DW_AT_name("__SFRA_F32_collect")
	.dwattr $C$DW$307, DW_AT_TI_call

        LCR       #||__SFRA_F32_collect|| ; [CPU_ALU] |629| 
        ; call occurs [#||__SFRA_F32_collect||] ; [] |629| 
||$C$L44||:    
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 429,column 5,is_stmt,isa 0
        MOVB      AL,#1                 ; [CPU_ALU] |429| 
        MOV       *(0:0x0ce1),AL        ; [CPU_ALU] |429| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -16
        RESTORE   ; [CPU_FPU] 
        POP       RB                    ; [CPU_FPU] 
	.dwcfi	cfa_offset, -14
	.dwcfi	restore_reg, 74
        MOVL      XAR7,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -12
	.dwcfi	restore_reg, 18
        MOVL      XAR6,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -10
	.dwcfi	restore_reg, 16
        MOVL      XAR5,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -8
	.dwcfi	restore_reg, 14
        MOVL      XAR4,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -6
	.dwcfi	restore_reg, 12
        MOVL      XT,*--SP              ; [CPU_ALU] 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 22
	.dwcfi	restore_reg, 21
        POP       AR1H:AR0H             ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 5
	.dwcfi	restore_reg, 7
        NASP      ; [CPU_ALU] 
$C$DW$308	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$308, DW_AT_low_pc(0x00)
	.dwattr $C$DW$308, DW_AT_TI_return

        IRET      ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$297, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$297, DW_AT_TI_end_line(0xdc)
	.dwattr $C$DW$297, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$297

;**************************************************************
;* UNDEFINED EXTERNAL REFERENCES                              *
;**************************************************************
	.global	||SPI_clearInterruptStatus||
	.global	||__SFRA_F32_collect||
	.global	||BTS_HAL_setupDevice||
	.global	||BTS_HAL_setupSyncBuckPinsGpio||
	.global	||BTS_HAL_SetupI2C_GPIO||
	.global	||BTS_HAL_SetupI2C_Init||
	.global	||BTS_HAL_disableEpwmCounting||
	.global	||BTS_HAL_setupSyncBuckPwm||
	.global	||BTS_HAL_setupAdcClock||
	.global	||BTS_setupHrpwmMepScaleFactor||
	.global	||BTS_HAL_enableEpwmCounting||
	.global	||BTS_HAL_SetupSpiPinsGpio_Adc1||
	.global	||BTS_HAL_SetupSpi||
	.global	||BTS_HAL_SetupSpiPinsGpio_Adc2||
	.global	||BTS_HAL_setupExAdcGpio_Adc1||
	.global	||BTS_HAL_setupExAdc_ch1_4||
	.global	||BTS_HAL_setupExAdcGpio_Adc2||
	.global	||BTS_HAL_setupExAdc_ch5_8||
	.global	||BTS_initUserVariables||
	.global	||BTS_initProgramVariables||
	.global	||BTS_initController||
	.global	||BTS_setupSfra||
	.global	||BTS_setupSfraGui||
	.global	||BTS_HAL_setupInterruptTrigger_Adc1||
	.global	||BTS_HAL_setupInterruptTrigger_Adc2||
	.global	||BTS_HAL_setupInterrupt_Adc1||
	.global	||BTS_HAL_setupInterrupt_Adc2||
	.global	||BTS_HAL_setupInterrupt||
	.global	||BTS_HAL_setupSyncBuckPinsEpwm||
	.global	||BTS_updateReference||
	.global	||SFRA_GUI_runSerialHostComms||
	.global	||SFRA_F32_runBackgroundTask||
	.global	||BTS_monitor_Iout_Vout||
	.global	||BTS_ExAdcRxflag1||
	.global	||BTS_ExAdcRxflag2||
	.global	||BTS_sfoStatus||
	.global	||SFO||
	.global	||MEP_ScaleFactor||
	.global	||__SFRA_F32_inject||
	.global	||BTS_ADC1||
	.global	||BTS_ADC2||
	.global	||BTS_ctrl_cc_ch1||
	.global	||BTS_userInput_ch1||
	.global	||BTS_userInput_ch2||
	.global	||BTS_userInput_ch3||
	.global	||BTS_userInput_ch4||
	.global	||BTS_userInput_ch5||
	.global	||BTS_userInput_ch6||
	.global	||BTS_userInput_ch7||
	.global	||BTS_userInput_ch8||
	.global	||BTS_sfra||
	.global	||BTS_ctrlLoopVariable_ch1||
	.global	||BTS_ctrlLoopVariable_ch2||
	.global	||BTS_ctrlLoopVariable_ch3||
	.global	||BTS_ctrlLoopVariable_ch4||
	.global	||BTS_ctrlLoopVariable_ch5||
	.global	||BTS_ctrlLoopVariable_ch6||
	.global	||BTS_ctrlLoopVariable_ch7||
	.global	||BTS_ctrlLoopVariable_ch8||
	.global	||BTS_measValues_ch1||
	.global	||BTS_measValues_ch2||
	.global	||BTS_measValues_ch3||
	.global	||BTS_measValues_ch4||
	.global	||BTS_measValues_ch5||
	.global	||BTS_measValues_ch6||
	.global	||BTS_measValues_ch7||
	.global	||BTS_measValues_ch8||
	.global	||__c28xabi_cmpull||
;**************************************************************
;* SECTION GROUPS                                             *
;**************************************************************
	.group    "__fpclassify", 1
	.gmember  ".text:__fpclassify"
	.endgroup
	.group    "__fpclassifyf", 1
	.gmember  ".text:__fpclassifyf"
	.endgroup
	.group    "__fpclassifyl", 1
	.gmember  ".text:__fpclassifyl"
	.endgroup
	.group    "__isfinite", 1
	.gmember  ".text:__isfinite"
	.endgroup
	.group    "__isfinitef", 1
	.gmember  ".text:__isfinitef"
	.endgroup
	.group    "__isfinitel", 1
	.gmember  ".text:__isfinitel"
	.endgroup
	.group    "__isinf", 1
	.gmember  ".text:__isinf"
	.endgroup
	.group    "__isinff", 1
	.gmember  ".text:__isinff"
	.endgroup
	.group    "__isinfl", 1
	.gmember  ".text:__isinfl"
	.endgroup
	.group    "__isnan", 1
	.gmember  ".text:__isnan"
	.endgroup
	.group    "__isnanf", 1
	.gmember  ".text:__isnanf"
	.endgroup
	.group    "__isnanl", 1
	.gmember  ".text:__isnanl"
	.endgroup
	.group    "__isnormal", 1
	.gmember  ".text:__isnormal"
	.endgroup
	.group    "__isnormalf", 1
	.gmember  ".text:__isnormalf"
	.endgroup
	.group    "__isnormall", 1
	.gmember  ".text:__isnormall"
	.endgroup
	.group    "__relaxed_atan2f", 1
	.gmember  ".text:__relaxed_atan2f"
	.endgroup
	.group    "__relaxed_atanf", 1
	.gmember  ".text:__relaxed_atanf"
	.endgroup
	.group    "__relaxed_cosf", 1
	.gmember  ".text:__relaxed_cosf"
	.endgroup
	.group    "__relaxed_sinf", 1
	.gmember  ".text:__relaxed_sinf"
	.endgroup
	.group    "__relaxed_sqrtf", 1
	.gmember  ".text:__relaxed_sqrtf"
	.endgroup
	.group    "__signbit", 1
	.gmember  ".text:__signbit"
	.endgroup
	.group    "__signbitf", 1
	.gmember  ".text:__signbitf"
	.endgroup
	.group    "__signbitl", 1
	.gmember  ".text:__signbitl"
	.endgroup


;***************************************************************
;* BUILD ATTRIBUTES                                            *
;***************************************************************
	.battr "c28xabi", Tag_File, 1, Tag_float_args(1)
	.battr "c28xabi", Tag_File, 1, Tag_double_args(1)
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

$C$DW$TU$53	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$53

$C$DW$T$53	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$53, DW_AT_byte_size(0x01)
$C$DW$309	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$309, DW_AT_name("EPWM_COUNTER_COMPARE_A")
	.dwattr $C$DW$309, DW_AT_const_value(0x00)
	.dwattr $C$DW$309, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$309, DW_AT_decl_line(0x10f)
	.dwattr $C$DW$309, DW_AT_decl_column(0x05)

$C$DW$310	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$310, DW_AT_name("EPWM_COUNTER_COMPARE_B")
	.dwattr $C$DW$310, DW_AT_const_value(0x02)
	.dwattr $C$DW$310, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$310, DW_AT_decl_line(0x110)
	.dwattr $C$DW$310, DW_AT_decl_column(0x05)

$C$DW$311	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$311, DW_AT_name("EPWM_COUNTER_COMPARE_C")
	.dwattr $C$DW$311, DW_AT_const_value(0x05)
	.dwattr $C$DW$311, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$311, DW_AT_decl_line(0x111)
	.dwattr $C$DW$311, DW_AT_decl_column(0x05)

$C$DW$312	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$312, DW_AT_name("EPWM_COUNTER_COMPARE_D")
	.dwattr $C$DW$312, DW_AT_const_value(0x07)
	.dwattr $C$DW$312, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$312, DW_AT_decl_line(0x112)
	.dwattr $C$DW$312, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$53, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$53, DW_AT_decl_line(0x10e)
	.dwattr $C$DW$T$53, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$53

	.dwendtag $C$DW$TU$53


$C$DW$TU$54	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$54
$C$DW$T$54	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$54, DW_AT_name("EPWM_CounterCompareModule")
	.dwattr $C$DW$T$54, DW_AT_type(*$C$DW$T$53)
	.dwattr $C$DW$T$54, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$54, DW_AT_decl_line(0x113)
	.dwattr $C$DW$T$54, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$54


$C$DW$TU$55	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$55

$C$DW$T$55	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$55, DW_AT_byte_size(0x01)
$C$DW$313	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$313, DW_AT_name("EPWM_AQ_OUTPUT_A")
	.dwattr $C$DW$313, DW_AT_const_value(0x00)
	.dwattr $C$DW$313, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$313, DW_AT_decl_line(0x211)
	.dwattr $C$DW$313, DW_AT_decl_column(0x05)

$C$DW$314	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$314, DW_AT_name("EPWM_AQ_OUTPUT_B")
	.dwattr $C$DW$314, DW_AT_const_value(0x02)
	.dwattr $C$DW$314, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$314, DW_AT_decl_line(0x212)
	.dwattr $C$DW$314, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$55, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$55, DW_AT_decl_line(0x210)
	.dwattr $C$DW$T$55, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$55

	.dwendtag $C$DW$TU$55


$C$DW$TU$56	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$56
$C$DW$T$56	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$56, DW_AT_name("EPWM_ActionQualifierOutputModule")
	.dwattr $C$DW$T$56, DW_AT_type(*$C$DW$T$55)
	.dwattr $C$DW$T$56, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$56, DW_AT_decl_line(0x213)
	.dwattr $C$DW$T$56, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$56


$C$DW$TU$57	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$57

$C$DW$T$57	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$57, DW_AT_byte_size(0x01)
$C$DW$315	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$315, DW_AT_name("EPWM_AQ_SW_DISABLED")
	.dwattr $C$DW$315, DW_AT_const_value(0x00)
	.dwattr $C$DW$315, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$315, DW_AT_decl_line(0x19e)
	.dwattr $C$DW$315, DW_AT_decl_column(0x05)

$C$DW$316	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$316, DW_AT_name("EPWM_AQ_SW_OUTPUT_LOW")
	.dwattr $C$DW$316, DW_AT_const_value(0x01)
	.dwattr $C$DW$316, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$316, DW_AT_decl_line(0x19f)
	.dwattr $C$DW$316, DW_AT_decl_column(0x05)

$C$DW$317	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$317, DW_AT_name("EPWM_AQ_SW_OUTPUT_HIGH")
	.dwattr $C$DW$317, DW_AT_const_value(0x02)
	.dwattr $C$DW$317, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$317, DW_AT_decl_line(0x1a0)
	.dwattr $C$DW$317, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$57, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$57, DW_AT_decl_line(0x19d)
	.dwattr $C$DW$T$57, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$57

	.dwendtag $C$DW$TU$57


$C$DW$TU$58	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$58
$C$DW$T$58	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$58, DW_AT_name("EPWM_ActionQualifierSWOutput")
	.dwattr $C$DW$T$58, DW_AT_type(*$C$DW$T$57)
	.dwattr $C$DW$T$58, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$58, DW_AT_decl_line(0x1a1)
	.dwattr $C$DW$T$58, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$58


$C$DW$TU$59	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$59

$C$DW$T$59	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$59, DW_AT_byte_size(0x01)
$C$DW$318	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$318, DW_AT_name("EPWM_TZ_ACTION_EVENT_TZA")
	.dwattr $C$DW$318, DW_AT_const_value(0x00)
	.dwattr $C$DW$318, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$318, DW_AT_decl_line(0x2ff)
	.dwattr $C$DW$318, DW_AT_decl_column(0x05)

$C$DW$319	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$319, DW_AT_name("EPWM_TZ_ACTION_EVENT_TZB")
	.dwattr $C$DW$319, DW_AT_const_value(0x02)
	.dwattr $C$DW$319, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$319, DW_AT_decl_line(0x300)
	.dwattr $C$DW$319, DW_AT_decl_column(0x05)

$C$DW$320	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$320, DW_AT_name("EPWM_TZ_ACTION_EVENT_DCAEVT1")
	.dwattr $C$DW$320, DW_AT_const_value(0x04)
	.dwattr $C$DW$320, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$320, DW_AT_decl_line(0x301)
	.dwattr $C$DW$320, DW_AT_decl_column(0x05)

$C$DW$321	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$321, DW_AT_name("EPWM_TZ_ACTION_EVENT_DCAEVT2")
	.dwattr $C$DW$321, DW_AT_const_value(0x06)
	.dwattr $C$DW$321, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$321, DW_AT_decl_line(0x302)
	.dwattr $C$DW$321, DW_AT_decl_column(0x05)

$C$DW$322	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$322, DW_AT_name("EPWM_TZ_ACTION_EVENT_DCBEVT1")
	.dwattr $C$DW$322, DW_AT_const_value(0x08)
	.dwattr $C$DW$322, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$322, DW_AT_decl_line(0x303)
	.dwattr $C$DW$322, DW_AT_decl_column(0x05)

$C$DW$323	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$323, DW_AT_name("EPWM_TZ_ACTION_EVENT_DCBEVT2")
	.dwattr $C$DW$323, DW_AT_const_value(0x0a)
	.dwattr $C$DW$323, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$323, DW_AT_decl_line(0x304)
	.dwattr $C$DW$323, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$59, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$59, DW_AT_decl_line(0x2fe)
	.dwattr $C$DW$T$59, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$59

	.dwendtag $C$DW$TU$59


$C$DW$TU$60	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$60
$C$DW$T$60	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$60, DW_AT_name("EPWM_TripZoneEvent")
	.dwattr $C$DW$T$60, DW_AT_type(*$C$DW$T$59)
	.dwattr $C$DW$T$60, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$60, DW_AT_decl_line(0x305)
	.dwattr $C$DW$T$60, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$60


$C$DW$TU$61	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$61

$C$DW$T$61	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$61, DW_AT_byte_size(0x01)
$C$DW$324	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$324, DW_AT_name("EPWM_TZ_ACTION_HIGH_Z")
	.dwattr $C$DW$324, DW_AT_const_value(0x00)
	.dwattr $C$DW$324, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$324, DW_AT_decl_line(0x30f)
	.dwattr $C$DW$324, DW_AT_decl_column(0x05)

$C$DW$325	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$325, DW_AT_name("EPWM_TZ_ACTION_HIGH")
	.dwattr $C$DW$325, DW_AT_const_value(0x01)
	.dwattr $C$DW$325, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$325, DW_AT_decl_line(0x310)
	.dwattr $C$DW$325, DW_AT_decl_column(0x05)

$C$DW$326	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$326, DW_AT_name("EPWM_TZ_ACTION_LOW")
	.dwattr $C$DW$326, DW_AT_const_value(0x02)
	.dwattr $C$DW$326, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$326, DW_AT_decl_line(0x311)
	.dwattr $C$DW$326, DW_AT_decl_column(0x05)

$C$DW$327	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$327, DW_AT_name("EPWM_TZ_ACTION_DISABLE")
	.dwattr $C$DW$327, DW_AT_const_value(0x03)
	.dwattr $C$DW$327, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$327, DW_AT_decl_line(0x312)
	.dwattr $C$DW$327, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$61, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$61, DW_AT_decl_line(0x30e)
	.dwattr $C$DW$T$61, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$61

	.dwendtag $C$DW$TU$61


$C$DW$TU$62	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$62
$C$DW$T$62	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$62, DW_AT_name("EPWM_TripZoneAction")
	.dwattr $C$DW$T$62, DW_AT_type(*$C$DW$T$61)
	.dwattr $C$DW$T$62, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$62, DW_AT_decl_line(0x313)
	.dwattr $C$DW$T$62, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$62


$C$DW$TU$63	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$63

$C$DW$T$63	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$63, DW_AT_byte_size(0x01)
$C$DW$328	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$328, DW_AT_name("HRPWM_COUNTER_COMPARE_A")
	.dwattr $C$DW$328, DW_AT_const_value(0x00)
	.dwattr $C$DW$328, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$328, DW_AT_decl_line(0xb3)
	.dwattr $C$DW$328, DW_AT_decl_column(0x05)

$C$DW$329	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$329, DW_AT_name("HRPWM_COUNTER_COMPARE_B")
	.dwattr $C$DW$329, DW_AT_const_value(0x04)
	.dwattr $C$DW$329, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$329, DW_AT_decl_line(0xb4)
	.dwattr $C$DW$329, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$63, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$63, DW_AT_decl_line(0xb2)
	.dwattr $C$DW$T$63, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$63

	.dwendtag $C$DW$TU$63


$C$DW$TU$64	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$64
$C$DW$T$64	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$64, DW_AT_name("HRPWM_CounterCompareModule")
	.dwattr $C$DW$T$64, DW_AT_type(*$C$DW$T$63)
	.dwattr $C$DW$T$64, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$64, DW_AT_decl_line(0xb5)
	.dwattr $C$DW$T$64, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$64


$C$DW$TU$25	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$25

$C$DW$T$25	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$25, DW_AT_byte_size(0x12)
$C$DW$330	.dwtag  DW_TAG_member
	.dwattr $C$DW$330, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$330, DW_AT_name("response")
	.dwattr $C$DW$330, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$330, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$330, DW_AT_decl_line(0x35)
	.dwattr $C$DW$330, DW_AT_decl_column(0x17)

$C$DW$331	.dwtag  DW_TAG_member
	.dwattr $C$DW$331, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$331, DW_AT_name("crc")
	.dwattr $C$DW$331, DW_AT_data_member_location[DW_OP_plus_uconst 0x1]
	.dwattr $C$DW$331, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$331, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$331, DW_AT_decl_line(0x36)
	.dwattr $C$DW$331, DW_AT_decl_column(0x17)

$C$DW$332	.dwtag  DW_TAG_member
	.dwattr $C$DW$332, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$332, DW_AT_name("channel0")
	.dwattr $C$DW$332, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$332, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$332, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$332, DW_AT_decl_line(0x37)
	.dwattr $C$DW$332, DW_AT_decl_column(0x16)

$C$DW$333	.dwtag  DW_TAG_member
	.dwattr $C$DW$333, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$333, DW_AT_name("channel1")
	.dwattr $C$DW$333, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$333, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$333, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$333, DW_AT_decl_line(0x38)
	.dwattr $C$DW$333, DW_AT_decl_column(0x16)

$C$DW$334	.dwtag  DW_TAG_member
	.dwattr $C$DW$334, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$334, DW_AT_name("channel2")
	.dwattr $C$DW$334, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$334, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$334, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$334, DW_AT_decl_line(0x39)
	.dwattr $C$DW$334, DW_AT_decl_column(0x16)

$C$DW$335	.dwtag  DW_TAG_member
	.dwattr $C$DW$335, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$335, DW_AT_name("channel3")
	.dwattr $C$DW$335, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$335, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$335, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$335, DW_AT_decl_line(0x3a)
	.dwattr $C$DW$335, DW_AT_decl_column(0x16)

$C$DW$336	.dwtag  DW_TAG_member
	.dwattr $C$DW$336, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$336, DW_AT_name("channel4")
	.dwattr $C$DW$336, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$336, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$336, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$336, DW_AT_decl_line(0x3b)
	.dwattr $C$DW$336, DW_AT_decl_column(0x16)

$C$DW$337	.dwtag  DW_TAG_member
	.dwattr $C$DW$337, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$337, DW_AT_name("channel5")
	.dwattr $C$DW$337, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$337, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$337, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$337, DW_AT_decl_line(0x3c)
	.dwattr $C$DW$337, DW_AT_decl_column(0x16)

$C$DW$338	.dwtag  DW_TAG_member
	.dwattr $C$DW$338, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$338, DW_AT_name("channel6")
	.dwattr $C$DW$338, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$338, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$338, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$338, DW_AT_decl_line(0x3d)
	.dwattr $C$DW$338, DW_AT_decl_column(0x16)

$C$DW$339	.dwtag  DW_TAG_member
	.dwattr $C$DW$339, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$339, DW_AT_name("channel7")
	.dwattr $C$DW$339, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$339, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$339, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$339, DW_AT_decl_line(0x3e)
	.dwattr $C$DW$339, DW_AT_decl_column(0x16)

	.dwattr $C$DW$T$25, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$T$25, DW_AT_decl_line(0x34)
	.dwattr $C$DW$T$25, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$25

	.dwendtag $C$DW$TU$25


$C$DW$TU$65	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$65
$C$DW$T$65	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$65, DW_AT_name("adc_data")
	.dwattr $C$DW$T$65, DW_AT_type(*$C$DW$T$25)
	.dwattr $C$DW$T$65, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$T$65, DW_AT_decl_line(0x3f)
	.dwattr $C$DW$T$65, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$65


$C$DW$TU$30	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$30

$C$DW$T$30	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$30, DW_AT_byte_size(0x20)
$C$DW$340	.dwtag  DW_TAG_member
	.dwattr $C$DW$340, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$340, DW_AT_name("h_magVect")
	.dwattr $C$DW$340, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$340, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$340, DW_AT_decl_line(0x40)
	.dwattr $C$DW$340, DW_AT_decl_column(0x10)

$C$DW$341	.dwtag  DW_TAG_member
	.dwattr $C$DW$341, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$341, DW_AT_name("h_phaseVect")
	.dwattr $C$DW$341, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$341, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$341, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$341, DW_AT_decl_line(0x41)
	.dwattr $C$DW$341, DW_AT_decl_column(0x10)

$C$DW$342	.dwtag  DW_TAG_member
	.dwattr $C$DW$342, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$342, DW_AT_name("gh_magVect")
	.dwattr $C$DW$342, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$342, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$342, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$342, DW_AT_decl_line(0x42)
	.dwattr $C$DW$342, DW_AT_decl_column(0x10)

$C$DW$343	.dwtag  DW_TAG_member
	.dwattr $C$DW$343, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$343, DW_AT_name("gh_phaseVect")
	.dwattr $C$DW$343, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$343, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$343, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$343, DW_AT_decl_line(0x43)
	.dwattr $C$DW$343, DW_AT_decl_column(0x10)

$C$DW$344	.dwtag  DW_TAG_member
	.dwattr $C$DW$344, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$344, DW_AT_name("cl_magVect")
	.dwattr $C$DW$344, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$344, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$344, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$344, DW_AT_decl_line(0x44)
	.dwattr $C$DW$344, DW_AT_decl_column(0x10)

$C$DW$345	.dwtag  DW_TAG_member
	.dwattr $C$DW$345, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$345, DW_AT_name("cl_phaseVect")
	.dwattr $C$DW$345, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$345, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$345, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$345, DW_AT_decl_line(0x45)
	.dwattr $C$DW$345, DW_AT_decl_column(0x10)

$C$DW$346	.dwtag  DW_TAG_member
	.dwattr $C$DW$346, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$346, DW_AT_name("freqVect")
	.dwattr $C$DW$346, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$346, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$346, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$346, DW_AT_decl_line(0x46)
	.dwattr $C$DW$346, DW_AT_decl_column(0x10)

$C$DW$347	.dwtag  DW_TAG_member
	.dwattr $C$DW$347, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$347, DW_AT_name("amplitude")
	.dwattr $C$DW$347, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$347, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$347, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$347, DW_AT_decl_line(0x47)
	.dwattr $C$DW$347, DW_AT_decl_column(0x0f)

$C$DW$348	.dwtag  DW_TAG_member
	.dwattr $C$DW$348, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$348, DW_AT_name("isrFreq")
	.dwattr $C$DW$348, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$348, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$348, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$348, DW_AT_decl_line(0x48)
	.dwattr $C$DW$348, DW_AT_decl_column(0x0f)

$C$DW$349	.dwtag  DW_TAG_member
	.dwattr $C$DW$349, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$349, DW_AT_name("freqStart")
	.dwattr $C$DW$349, DW_AT_data_member_location[DW_OP_plus_uconst 0x12]
	.dwattr $C$DW$349, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$349, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$349, DW_AT_decl_line(0x49)
	.dwattr $C$DW$349, DW_AT_decl_column(0x0f)

$C$DW$350	.dwtag  DW_TAG_member
	.dwattr $C$DW$350, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$350, DW_AT_name("freqStep")
	.dwattr $C$DW$350, DW_AT_data_member_location[DW_OP_plus_uconst 0x14]
	.dwattr $C$DW$350, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$350, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$350, DW_AT_decl_line(0x4a)
	.dwattr $C$DW$350, DW_AT_decl_column(0x0f)

$C$DW$351	.dwtag  DW_TAG_member
	.dwattr $C$DW$351, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$351, DW_AT_name("start")
	.dwattr $C$DW$351, DW_AT_data_member_location[DW_OP_plus_uconst 0x16]
	.dwattr $C$DW$351, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$351, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$351, DW_AT_decl_line(0x4b)
	.dwattr $C$DW$351, DW_AT_decl_column(0x0d)

$C$DW$352	.dwtag  DW_TAG_member
	.dwattr $C$DW$352, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$352, DW_AT_name("state")
	.dwattr $C$DW$352, DW_AT_data_member_location[DW_OP_plus_uconst 0x17]
	.dwattr $C$DW$352, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$352, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$352, DW_AT_decl_line(0x4c)
	.dwattr $C$DW$352, DW_AT_decl_column(0x0d)

$C$DW$353	.dwtag  DW_TAG_member
	.dwattr $C$DW$353, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$353, DW_AT_name("status")
	.dwattr $C$DW$353, DW_AT_data_member_location[DW_OP_plus_uconst 0x18]
	.dwattr $C$DW$353, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$353, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$353, DW_AT_decl_line(0x4d)
	.dwattr $C$DW$353, DW_AT_decl_column(0x0d)

$C$DW$354	.dwtag  DW_TAG_member
	.dwattr $C$DW$354, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$354, DW_AT_name("vecLength")
	.dwattr $C$DW$354, DW_AT_data_member_location[DW_OP_plus_uconst 0x19]
	.dwattr $C$DW$354, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$354, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$354, DW_AT_decl_line(0x4e)
	.dwattr $C$DW$354, DW_AT_decl_column(0x0d)

$C$DW$355	.dwtag  DW_TAG_member
	.dwattr $C$DW$355, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$355, DW_AT_name("freqIndex")
	.dwattr $C$DW$355, DW_AT_data_member_location[DW_OP_plus_uconst 0x1a]
	.dwattr $C$DW$355, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$355, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$355, DW_AT_decl_line(0x4f)
	.dwattr $C$DW$355, DW_AT_decl_column(0x0d)

$C$DW$356	.dwtag  DW_TAG_member
	.dwattr $C$DW$356, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$356, DW_AT_name("storeH")
	.dwattr $C$DW$356, DW_AT_data_member_location[DW_OP_plus_uconst 0x1b]
	.dwattr $C$DW$356, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$356, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$356, DW_AT_decl_line(0x50)
	.dwattr $C$DW$356, DW_AT_decl_column(0x0d)

$C$DW$357	.dwtag  DW_TAG_member
	.dwattr $C$DW$357, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$357, DW_AT_name("storeGH")
	.dwattr $C$DW$357, DW_AT_data_member_location[DW_OP_plus_uconst 0x1c]
	.dwattr $C$DW$357, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$357, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$357, DW_AT_decl_line(0x51)
	.dwattr $C$DW$357, DW_AT_decl_column(0x0d)

$C$DW$358	.dwtag  DW_TAG_member
	.dwattr $C$DW$358, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$358, DW_AT_name("storeCL")
	.dwattr $C$DW$358, DW_AT_data_member_location[DW_OP_plus_uconst 0x1d]
	.dwattr $C$DW$358, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$358, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$358, DW_AT_decl_line(0x52)
	.dwattr $C$DW$358, DW_AT_decl_column(0x0d)

$C$DW$359	.dwtag  DW_TAG_member
	.dwattr $C$DW$359, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$359, DW_AT_name("speed")
	.dwattr $C$DW$359, DW_AT_data_member_location[DW_OP_plus_uconst 0x1e]
	.dwattr $C$DW$359, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$359, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$359, DW_AT_decl_line(0x53)
	.dwattr $C$DW$359, DW_AT_decl_column(0x0d)

	.dwattr $C$DW$T$30, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$T$30, DW_AT_decl_line(0x3f)
	.dwattr $C$DW$T$30, DW_AT_decl_column(0x0f)
	.dwendtag $C$DW$T$30

	.dwendtag $C$DW$TU$30


$C$DW$TU$67	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$67
$C$DW$T$67	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$67, DW_AT_name("SFRA_F32")
	.dwattr $C$DW$T$67, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$T$67, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$T$67, DW_AT_decl_line(0x54)
	.dwattr $C$DW$T$67, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$67


$C$DW$TU$68	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$68
$C$DW$T$68	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$68, DW_AT_type(*$C$DW$T$67)
	.dwattr $C$DW$T$68, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$68


$C$DW$TU$32	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$32

$C$DW$T$32	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$32, DW_AT_byte_size(0x1e)
$C$DW$360	.dwtag  DW_TAG_member
	.dwattr $C$DW$360, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$360, DW_AT_name("iref_A")
	.dwattr $C$DW$360, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$360, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$360, DW_AT_decl_line(0x78)
	.dwattr $C$DW$360, DW_AT_decl_column(0x18)

$C$DW$361	.dwtag  DW_TAG_member
	.dwattr $C$DW$361, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$361, DW_AT_name("vref_charge_V")
	.dwattr $C$DW$361, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$361, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$361, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$361, DW_AT_decl_line(0x79)
	.dwattr $C$DW$361, DW_AT_decl_column(0x18)

$C$DW$362	.dwtag  DW_TAG_member
	.dwattr $C$DW$362, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$362, DW_AT_name("vref_discharge_V")
	.dwattr $C$DW$362, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$362, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$362, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$362, DW_AT_decl_line(0x7a)
	.dwattr $C$DW$362, DW_AT_decl_column(0x18)

$C$DW$363	.dwtag  DW_TAG_member
	.dwattr $C$DW$363, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$363, DW_AT_name("direction_logic")
	.dwattr $C$DW$363, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$363, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$363, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$363, DW_AT_decl_line(0x7b)
	.dwattr $C$DW$363, DW_AT_decl_column(0x17)

$C$DW$364	.dwtag  DW_TAG_member
	.dwattr $C$DW$364, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$364, DW_AT_name("enable_logic")
	.dwattr $C$DW$364, DW_AT_data_member_location[DW_OP_plus_uconst 0x7]
	.dwattr $C$DW$364, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$364, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$364, DW_AT_decl_line(0x7c)
	.dwattr $C$DW$364, DW_AT_decl_column(0x17)

$C$DW$365	.dwtag  DW_TAG_member
	.dwattr $C$DW$365, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$365, DW_AT_name("dutyRef_pu")
	.dwattr $C$DW$365, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$365, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$365, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$365, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$365, DW_AT_decl_column(0x18)

$C$DW$366	.dwtag  DW_TAG_member
	.dwattr $C$DW$366, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$366, DW_AT_name("ioutCal_pu")
	.dwattr $C$DW$366, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$366, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$366, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$366, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$366, DW_AT_decl_column(0x18)

$C$DW$367	.dwtag  DW_TAG_member
	.dwattr $C$DW$367, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$367, DW_AT_name("voutCal_pu")
	.dwattr $C$DW$367, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$367, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$367, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$367, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$367, DW_AT_decl_column(0x18)

$C$DW$368	.dwtag  DW_TAG_member
	.dwattr $C$DW$368, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$368, DW_AT_name("IoutGain_pu")
	.dwattr $C$DW$368, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$368, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$368, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$368, DW_AT_decl_line(0x81)
	.dwattr $C$DW$368, DW_AT_decl_column(0x0f)

$C$DW$369	.dwtag  DW_TAG_member
	.dwattr $C$DW$369, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$369, DW_AT_name("IoutOffset_pu")
	.dwattr $C$DW$369, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$369, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$369, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$369, DW_AT_decl_line(0x82)
	.dwattr $C$DW$369, DW_AT_decl_column(0x0f)

$C$DW$370	.dwtag  DW_TAG_member
	.dwattr $C$DW$370, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$370, DW_AT_name("IoutGain_A")
	.dwattr $C$DW$370, DW_AT_data_member_location[DW_OP_plus_uconst 0x12]
	.dwattr $C$DW$370, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$370, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$370, DW_AT_decl_line(0x83)
	.dwattr $C$DW$370, DW_AT_decl_column(0x0f)

$C$DW$371	.dwtag  DW_TAG_member
	.dwattr $C$DW$371, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$371, DW_AT_name("IoutOffset_A")
	.dwattr $C$DW$371, DW_AT_data_member_location[DW_OP_plus_uconst 0x14]
	.dwattr $C$DW$371, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$371, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$371, DW_AT_decl_line(0x84)
	.dwattr $C$DW$371, DW_AT_decl_column(0x0f)

$C$DW$372	.dwtag  DW_TAG_member
	.dwattr $C$DW$372, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$372, DW_AT_name("VoutGain_pu")
	.dwattr $C$DW$372, DW_AT_data_member_location[DW_OP_plus_uconst 0x16]
	.dwattr $C$DW$372, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$372, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$372, DW_AT_decl_line(0x86)
	.dwattr $C$DW$372, DW_AT_decl_column(0x0f)

$C$DW$373	.dwtag  DW_TAG_member
	.dwattr $C$DW$373, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$373, DW_AT_name("VoutOffset_pu")
	.dwattr $C$DW$373, DW_AT_data_member_location[DW_OP_plus_uconst 0x18]
	.dwattr $C$DW$373, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$373, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$373, DW_AT_decl_line(0x87)
	.dwattr $C$DW$373, DW_AT_decl_column(0x0f)

$C$DW$374	.dwtag  DW_TAG_member
	.dwattr $C$DW$374, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$374, DW_AT_name("VoutGain_V")
	.dwattr $C$DW$374, DW_AT_data_member_location[DW_OP_plus_uconst 0x1a]
	.dwattr $C$DW$374, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$374, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$374, DW_AT_decl_line(0x88)
	.dwattr $C$DW$374, DW_AT_decl_column(0x0f)

$C$DW$375	.dwtag  DW_TAG_member
	.dwattr $C$DW$375, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$375, DW_AT_name("VoutOffset_V")
	.dwattr $C$DW$375, DW_AT_data_member_location[DW_OP_plus_uconst 0x1c]
	.dwattr $C$DW$375, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$375, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$375, DW_AT_decl_line(0x89)
	.dwattr $C$DW$375, DW_AT_decl_column(0x0f)

	.dwattr $C$DW$T$32, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$32, DW_AT_decl_line(0x77)
	.dwattr $C$DW$T$32, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$32

	.dwendtag $C$DW$TU$32


$C$DW$TU$70	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$70
$C$DW$T$70	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$70, DW_AT_name("BTS_userInput")
	.dwattr $C$DW$T$70, DW_AT_type(*$C$DW$T$32)
	.dwattr $C$DW$T$70, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$70, DW_AT_decl_line(0x8b)
	.dwattr $C$DW$T$70, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$70


$C$DW$TU$71	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$71
$C$DW$T$71	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$71, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$T$71, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$71


$C$DW$TU$33	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$33

$C$DW$T$33	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$33, DW_AT_byte_size(0x24)
$C$DW$376	.dwtag  DW_TAG_member
	.dwattr $C$DW$376, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$376, DW_AT_name("dutySet_pu")
	.dwattr $C$DW$376, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$376, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$376, DW_AT_decl_line(0x97)
	.dwattr $C$DW$376, DW_AT_decl_column(0x0f)

$C$DW$377	.dwtag  DW_TAG_member
	.dwattr $C$DW$377, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$377, DW_AT_name("dutySetRef_pu")
	.dwattr $C$DW$377, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$377, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$377, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$377, DW_AT_decl_line(0x98)
	.dwattr $C$DW$377, DW_AT_decl_column(0x0f)

$C$DW$378	.dwtag  DW_TAG_member
	.dwattr $C$DW$378, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$378, DW_AT_name("ioutRef_pu")
	.dwattr $C$DW$378, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$378, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$378, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$378, DW_AT_decl_line(0x9a)
	.dwattr $C$DW$378, DW_AT_decl_column(0x0f)

$C$DW$379	.dwtag  DW_TAG_member
	.dwattr $C$DW$379, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$379, DW_AT_name("ioutSet_pu")
	.dwattr $C$DW$379, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$379, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$379, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$379, DW_AT_decl_line(0x9b)
	.dwattr $C$DW$379, DW_AT_decl_column(0x0f)

$C$DW$380	.dwtag  DW_TAG_member
	.dwattr $C$DW$380, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$380, DW_AT_name("ioutSense_pu")
	.dwattr $C$DW$380, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$380, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$380, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$380, DW_AT_decl_line(0x9c)
	.dwattr $C$DW$380, DW_AT_decl_column(0x0f)

$C$DW$381	.dwtag  DW_TAG_member
	.dwattr $C$DW$381, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$381, DW_AT_name("voutRef_pu")
	.dwattr $C$DW$381, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$381, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$381, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$381, DW_AT_decl_line(0x9e)
	.dwattr $C$DW$381, DW_AT_decl_column(0x0f)

$C$DW$382	.dwtag  DW_TAG_member
	.dwattr $C$DW$382, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$382, DW_AT_name("voutSet_pu")
	.dwattr $C$DW$382, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$382, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$382, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$382, DW_AT_decl_line(0x9f)
	.dwattr $C$DW$382, DW_AT_decl_column(0x0f)

$C$DW$383	.dwtag  DW_TAG_member
	.dwattr $C$DW$383, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$383, DW_AT_name("voutSense_pu")
	.dwattr $C$DW$383, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$383, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$383, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$383, DW_AT_decl_line(0xa0)
	.dwattr $C$DW$383, DW_AT_decl_column(0x0f)

$C$DW$384	.dwtag  DW_TAG_member
	.dwattr $C$DW$384, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$384, DW_AT_name("uk_cc_pu")
	.dwattr $C$DW$384, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$384, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$384, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$384, DW_AT_decl_line(0xa2)
	.dwattr $C$DW$384, DW_AT_decl_column(0x0f)

$C$DW$385	.dwtag  DW_TAG_member
	.dwattr $C$DW$385, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$385, DW_AT_name("ek_cc_pu")
	.dwattr $C$DW$385, DW_AT_data_member_location[DW_OP_plus_uconst 0x12]
	.dwattr $C$DW$385, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$385, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$385, DW_AT_decl_line(0xa3)
	.dwattr $C$DW$385, DW_AT_decl_column(0x0f)

$C$DW$386	.dwtag  DW_TAG_member
	.dwattr $C$DW$386, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$386, DW_AT_name("uk_cv_pu")
	.dwattr $C$DW$386, DW_AT_data_member_location[DW_OP_plus_uconst 0x14]
	.dwattr $C$DW$386, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$386, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$386, DW_AT_decl_line(0xa4)
	.dwattr $C$DW$386, DW_AT_decl_column(0x0f)

$C$DW$387	.dwtag  DW_TAG_member
	.dwattr $C$DW$387, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$387, DW_AT_name("ek_cv_pu")
	.dwattr $C$DW$387, DW_AT_data_member_location[DW_OP_plus_uconst 0x16]
	.dwattr $C$DW$387, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$387, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$387, DW_AT_decl_line(0xa5)
	.dwattr $C$DW$387, DW_AT_decl_column(0x0f)

$C$DW$388	.dwtag  DW_TAG_member
	.dwattr $C$DW$388, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$388, DW_AT_name("direction_coeff")
	.dwattr $C$DW$388, DW_AT_data_member_location[DW_OP_plus_uconst 0x18]
	.dwattr $C$DW$388, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$388, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$388, DW_AT_decl_line(0xa6)
	.dwattr $C$DW$388, DW_AT_decl_column(0x0f)

$C$DW$389	.dwtag  DW_TAG_member
	.dwattr $C$DW$389, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$389, DW_AT_name("dutyH_pu")
	.dwattr $C$DW$389, DW_AT_data_member_location[DW_OP_plus_uconst 0x1a]
	.dwattr $C$DW$389, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$389, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$389, DW_AT_decl_line(0xa8)
	.dwattr $C$DW$389, DW_AT_decl_column(0x0f)

$C$DW$390	.dwtag  DW_TAG_member
	.dwattr $C$DW$390, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$390, DW_AT_name("dutyL_pu")
	.dwattr $C$DW$390, DW_AT_data_member_location[DW_OP_plus_uconst 0x1c]
	.dwattr $C$DW$390, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$390, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$390, DW_AT_decl_line(0xa9)
	.dwattr $C$DW$390, DW_AT_decl_column(0x0f)

$C$DW$391	.dwtag  DW_TAG_member
	.dwattr $C$DW$391, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$391, DW_AT_name("ctrlMode_logic")
	.dwattr $C$DW$391, DW_AT_data_member_location[DW_OP_plus_uconst 0x1e]
	.dwattr $C$DW$391, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$391, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$391, DW_AT_decl_line(0xab)
	.dwattr $C$DW$391, DW_AT_decl_column(0x0e)

$C$DW$392	.dwtag  DW_TAG_member
	.dwattr $C$DW$392, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$392, DW_AT_name("direction_logic")
	.dwattr $C$DW$392, DW_AT_data_member_location[DW_OP_plus_uconst 0x1f]
	.dwattr $C$DW$392, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$392, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$392, DW_AT_decl_line(0xac)
	.dwattr $C$DW$392, DW_AT_decl_column(0x0e)

$C$DW$393	.dwtag  DW_TAG_member
	.dwattr $C$DW$393, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$393, DW_AT_name("ioutTrip_16b")
	.dwattr $C$DW$393, DW_AT_data_member_location[DW_OP_plus_uconst 0x20]
	.dwattr $C$DW$393, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$393, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$393, DW_AT_decl_line(0xae)
	.dwattr $C$DW$393, DW_AT_decl_column(0x0d)

$C$DW$394	.dwtag  DW_TAG_member
	.dwattr $C$DW$394, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$394, DW_AT_name("ioutTrip_n_16b")
	.dwattr $C$DW$394, DW_AT_data_member_location[DW_OP_plus_uconst 0x21]
	.dwattr $C$DW$394, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$394, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$394, DW_AT_decl_line(0xaf)
	.dwattr $C$DW$394, DW_AT_decl_column(0x0d)

$C$DW$395	.dwtag  DW_TAG_member
	.dwattr $C$DW$395, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$395, DW_AT_name("tripFlag")
	.dwattr $C$DW$395, DW_AT_data_member_location[DW_OP_plus_uconst 0x22]
	.dwattr $C$DW$395, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$395, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$395, DW_AT_decl_line(0xb0)
	.dwattr $C$DW$395, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$33, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$33, DW_AT_decl_line(0x96)
	.dwattr $C$DW$T$33, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$33

	.dwendtag $C$DW$TU$33


$C$DW$TU$73	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$73
$C$DW$T$73	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$73, DW_AT_name("BTS_ctrlLoopVariable")
	.dwattr $C$DW$T$73, DW_AT_type(*$C$DW$T$33)
	.dwattr $C$DW$T$73, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$73, DW_AT_decl_line(0xb2)
	.dwattr $C$DW$T$73, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$73


$C$DW$TU$74	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$74
$C$DW$T$74	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$74, DW_AT_type(*$C$DW$T$73)
	.dwattr $C$DW$T$74, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$74


$C$DW$TU$35	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$35

$C$DW$T$35	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$35, DW_AT_byte_size(0x52)
$C$DW$396	.dwtag  DW_TAG_member
	.dwattr $C$DW$396, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$396, DW_AT_name("Isense_A")
	.dwattr $C$DW$396, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$396, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$396, DW_AT_decl_line(0x5f)
	.dwattr $C$DW$396, DW_AT_decl_column(0x0f)

$C$DW$397	.dwtag  DW_TAG_member
	.dwattr $C$DW$397, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$397, DW_AT_name("Vsense_V")
	.dwattr $C$DW$397, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$397, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$397, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$397, DW_AT_decl_line(0x60)
	.dwattr $C$DW$397, DW_AT_decl_column(0x0f)

$C$DW$398	.dwtag  DW_TAG_member
	.dwattr $C$DW$398, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$398, DW_AT_name("Isense_16b")
	.dwattr $C$DW$398, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$398, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$398, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$398, DW_AT_decl_line(0x61)
	.dwattr $C$DW$398, DW_AT_decl_column(0x0d)

$C$DW$399	.dwtag  DW_TAG_member
	.dwattr $C$DW$399, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$399, DW_AT_name("Vsense_16b")
	.dwattr $C$DW$399, DW_AT_data_member_location[DW_OP_plus_uconst 0x24]
	.dwattr $C$DW$399, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$399, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$399, DW_AT_decl_line(0x62)
	.dwattr $C$DW$399, DW_AT_decl_column(0x0d)

$C$DW$400	.dwtag  DW_TAG_member
	.dwattr $C$DW$400, DW_AT_type(*$C$DW$T$23)
	.dwattr $C$DW$400, DW_AT_name("Sum_I")
	.dwattr $C$DW$400, DW_AT_data_member_location[DW_OP_plus_uconst 0x44]
	.dwattr $C$DW$400, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$400, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$400, DW_AT_decl_line(0x63)
	.dwattr $C$DW$400, DW_AT_decl_column(0x0d)

$C$DW$401	.dwtag  DW_TAG_member
	.dwattr $C$DW$401, DW_AT_type(*$C$DW$T$23)
	.dwattr $C$DW$401, DW_AT_name("Sum_V")
	.dwattr $C$DW$401, DW_AT_data_member_location[DW_OP_plus_uconst 0x46]
	.dwattr $C$DW$401, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$401, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$401, DW_AT_decl_line(0x64)
	.dwattr $C$DW$401, DW_AT_decl_column(0x0d)

$C$DW$402	.dwtag  DW_TAG_member
	.dwattr $C$DW$402, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$402, DW_AT_name("Index")
	.dwattr $C$DW$402, DW_AT_data_member_location[DW_OP_plus_uconst 0x48]
	.dwattr $C$DW$402, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$402, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$402, DW_AT_decl_line(0x65)
	.dwattr $C$DW$402, DW_AT_decl_column(0x0e)

$C$DW$403	.dwtag  DW_TAG_member
	.dwattr $C$DW$403, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$403, DW_AT_name("IoutGain_A")
	.dwattr $C$DW$403, DW_AT_data_member_location[DW_OP_plus_uconst 0x4a]
	.dwattr $C$DW$403, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$403, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$403, DW_AT_decl_line(0x66)
	.dwattr $C$DW$403, DW_AT_decl_column(0x0f)

$C$DW$404	.dwtag  DW_TAG_member
	.dwattr $C$DW$404, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$404, DW_AT_name("IoutOffset_A")
	.dwattr $C$DW$404, DW_AT_data_member_location[DW_OP_plus_uconst 0x4c]
	.dwattr $C$DW$404, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$404, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$404, DW_AT_decl_line(0x67)
	.dwattr $C$DW$404, DW_AT_decl_column(0x0f)

$C$DW$405	.dwtag  DW_TAG_member
	.dwattr $C$DW$405, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$405, DW_AT_name("VoutGain_V")
	.dwattr $C$DW$405, DW_AT_data_member_location[DW_OP_plus_uconst 0x4e]
	.dwattr $C$DW$405, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$405, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$405, DW_AT_decl_line(0x68)
	.dwattr $C$DW$405, DW_AT_decl_column(0x0f)

$C$DW$406	.dwtag  DW_TAG_member
	.dwattr $C$DW$406, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$406, DW_AT_name("VoutOffset_V")
	.dwattr $C$DW$406, DW_AT_data_member_location[DW_OP_plus_uconst 0x50]
	.dwattr $C$DW$406, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$406, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$406, DW_AT_decl_line(0x69)
	.dwattr $C$DW$406, DW_AT_decl_column(0x0f)

	.dwattr $C$DW$T$35, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$35, DW_AT_decl_line(0x5e)
	.dwattr $C$DW$T$35, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$35

	.dwendtag $C$DW$TU$35


$C$DW$TU$76	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$76
$C$DW$T$76	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$76, DW_AT_name("BTS_measValues")
	.dwattr $C$DW$T$76, DW_AT_type(*$C$DW$T$35)
	.dwattr $C$DW$T$76, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$76, DW_AT_decl_line(0x6b)
	.dwattr $C$DW$T$76, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$76


$C$DW$TU$77	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$77
$C$DW$T$77	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$77, DW_AT_type(*$C$DW$T$76)
	.dwattr $C$DW$T$77, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$77


$C$DW$TU$37	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$37

$C$DW$T$37	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$37, DW_AT_name("_Complex_double")
	.dwattr $C$DW$T$37, DW_AT_byte_size(0x08)
$C$DW$407	.dwtag  DW_TAG_member
	.dwattr $C$DW$407, DW_AT_type(*$C$DW$T$36)
	.dwattr $C$DW$407, DW_AT_name("_Vals")
	.dwattr $C$DW$407, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$407, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$407, DW_AT_decl_line(0xf4)
	.dwattr $C$DW$407, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$T$37

	.dwendtag $C$DW$TU$37


$C$DW$TU$79	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$79
$C$DW$T$79	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$79, DW_AT_name("_Complex_double")
	.dwattr $C$DW$T$79, DW_AT_type(*$C$DW$T$37)
	.dwattr $C$DW$T$79, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$T$79, DW_AT_decl_line(0xf4)
	.dwattr $C$DW$T$79, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$79


$C$DW$TU$39	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$39

$C$DW$T$39	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$39, DW_AT_name("_Complex_float")
	.dwattr $C$DW$T$39, DW_AT_byte_size(0x04)
$C$DW$408	.dwtag  DW_TAG_member
	.dwattr $C$DW$408, DW_AT_type(*$C$DW$T$38)
	.dwattr $C$DW$408, DW_AT_name("_Vals")
	.dwattr $C$DW$408, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$408, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$408, DW_AT_decl_line(0xf4)
	.dwattr $C$DW$408, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$T$39

	.dwendtag $C$DW$TU$39


$C$DW$TU$80	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$80
$C$DW$T$80	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$80, DW_AT_name("_Complex_float")
	.dwattr $C$DW$T$80, DW_AT_type(*$C$DW$T$39)
	.dwattr $C$DW$T$80, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$T$80, DW_AT_decl_line(0xf4)
	.dwattr $C$DW$T$80, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$80


$C$DW$TU$41	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$41

$C$DW$T$41	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$41, DW_AT_name("_Complex_long_double")
	.dwattr $C$DW$T$41, DW_AT_byte_size(0x08)
$C$DW$409	.dwtag  DW_TAG_member
	.dwattr $C$DW$409, DW_AT_type(*$C$DW$T$40)
	.dwattr $C$DW$409, DW_AT_name("_Vals")
	.dwattr $C$DW$409, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$409, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$409, DW_AT_decl_line(0xf4)
	.dwattr $C$DW$409, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$T$41

	.dwendtag $C$DW$TU$41


$C$DW$TU$82	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$82
$C$DW$T$82	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$82, DW_AT_name("_Complex_long_double")
	.dwattr $C$DW$T$82, DW_AT_type(*$C$DW$T$41)
	.dwattr $C$DW$T$82, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$T$82, DW_AT_decl_line(0xf4)
	.dwattr $C$DW$T$82, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$82


$C$DW$TU$2	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$2
$C$DW$T$2	.dwtag  DW_TAG_unspecified_type
	.dwattr $C$DW$T$2, DW_AT_name("void")

	.dwendtag $C$DW$TU$2


$C$DW$TU$83	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$83

$C$DW$T$83	.dwtag  DW_TAG_subroutine_type
	.dwendtag $C$DW$T$83

	.dwendtag $C$DW$TU$83


$C$DW$TU$84	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$84
$C$DW$T$84	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$84, DW_AT_type(*$C$DW$T$83)
	.dwattr $C$DW$T$84, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$84


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


$C$DW$TU$28	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$28
$C$DW$T$28	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$28, DW_AT_name("__int16_t")
	.dwattr $C$DW$T$28, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$28, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$28, DW_AT_decl_line(0x40)
	.dwattr $C$DW$T$28, DW_AT_decl_column(0x1d)

	.dwendtag $C$DW$TU$28


$C$DW$TU$29	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$29
$C$DW$T$29	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$29, DW_AT_name("int16_t")
	.dwattr $C$DW$T$29, DW_AT_type(*$C$DW$T$28)
	.dwattr $C$DW$T$29, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$29, DW_AT_decl_line(0x2b)
	.dwattr $C$DW$T$29, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$29


$C$DW$TU$34	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$34

$C$DW$T$34	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$34, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$T$34, DW_AT_byte_size(0x20)
$C$DW$410	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$410, DW_AT_upper_bound(0x1f)

	.dwendtag $C$DW$T$34

	.dwendtag $C$DW$TU$34


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


$C$DW$TU$126	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$126

$C$DW$T$126	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$126, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$T$126, DW_AT_byte_size(0x04)
$C$DW$411	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$411, DW_AT_upper_bound(0x03)

	.dwendtag $C$DW$T$126

	.dwendtag $C$DW$TU$126


$C$DW$TU$21	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$21
$C$DW$412	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$412, DW_AT_type(*$C$DW$T$20)

$C$DW$T$21	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$21, DW_AT_type(*$C$DW$412)

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
$C$DW$413	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$413, DW_AT_type(*$C$DW$T$23)

$C$DW$T$24	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$24, DW_AT_type(*$C$DW$413)

	.dwendtag $C$DW$TU$24


$C$DW$TU$13	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$13
$C$DW$T$13	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$13, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$13, DW_AT_name("unsigned long")
	.dwattr $C$DW$T$13, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$13


$C$DW$TU$42	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$42
$C$DW$T$42	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$42, DW_AT_name("__uint32_t")
	.dwattr $C$DW$T$42, DW_AT_type(*$C$DW$T$13)
	.dwattr $C$DW$T$42, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$42, DW_AT_decl_line(0x43)
	.dwattr $C$DW$T$42, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$42


$C$DW$TU$43	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$43
$C$DW$T$43	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$43, DW_AT_name("uint32_t")
	.dwattr $C$DW$T$43, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$T$43, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$43, DW_AT_decl_line(0x46)
	.dwattr $C$DW$T$43, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$43


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


$C$DW$TU$38	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$38

$C$DW$T$38	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$38, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$T$38, DW_AT_byte_size(0x04)
$C$DW$414	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$414, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$38

	.dwendtag $C$DW$TU$38


$C$DW$TU$102	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$102
$C$DW$T$102	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$102, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$T$102, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$102


$C$DW$TU$136	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$136
$C$DW$415	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$415, DW_AT_type(*$C$DW$T$16)

$C$DW$T$136	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$136, DW_AT_type(*$C$DW$415)

	.dwendtag $C$DW$TU$136


$C$DW$TU$26	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$26
$C$DW$T$26	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$26, DW_AT_name("float32_t")
	.dwattr $C$DW$T$26, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$T$26, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\inc/hw_types.h")
	.dwattr $C$DW$T$26, DW_AT_decl_line(0x5e)
	.dwattr $C$DW$T$26, DW_AT_decl_column(0x17)

	.dwendtag $C$DW$TU$26


$C$DW$TU$27	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$27
$C$DW$T$27	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$27, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$T$27, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$27


$C$DW$TU$31	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$31
$C$DW$416	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$416, DW_AT_type(*$C$DW$T$26)

$C$DW$T$31	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$31, DW_AT_type(*$C$DW$416)

	.dwendtag $C$DW$TU$31


$C$DW$TU$17	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$17
$C$DW$T$17	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$17, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$17, DW_AT_name("double")
	.dwattr $C$DW$T$17, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$17


$C$DW$TU$36	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$36

$C$DW$T$36	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$36, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$T$36, DW_AT_byte_size(0x08)
$C$DW$417	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$417, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$36

	.dwendtag $C$DW$TU$36


$C$DW$TU$139	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$139
$C$DW$T$139	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$139, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$T$139, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$139


$C$DW$TU$140	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$140
$C$DW$418	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$418, DW_AT_type(*$C$DW$T$139)

$C$DW$T$140	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$140, DW_AT_type(*$C$DW$418)

	.dwendtag $C$DW$TU$140


$C$DW$TU$18	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$18
$C$DW$T$18	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$18, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$18, DW_AT_name("long double")
	.dwattr $C$DW$T$18, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$18


$C$DW$TU$40	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$40

$C$DW$T$40	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$40, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$40, DW_AT_byte_size(0x08)
$C$DW$419	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$419, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$40

	.dwendtag $C$DW$TU$40


$C$DW$TU$142	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$142
$C$DW$T$142	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$142, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$142, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$142


$C$DW$TU$143	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$143
$C$DW$420	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$420, DW_AT_type(*$C$DW$T$142)

$C$DW$T$143	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$143, DW_AT_type(*$C$DW$420)

	.dwendtag $C$DW$TU$143


$C$DW$TU$145	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$145
$C$DW$T$145	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$145, DW_AT_encoding(DW_ATE_unsigned_char)
	.dwattr $C$DW$T$145, DW_AT_name("unsigned char")
	.dwattr $C$DW$T$145, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$145


$C$DW$TU$44	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$44

$C$DW$T$44	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$44, DW_AT_name("dcl_css")
	.dwattr $C$DW$T$44, DW_AT_byte_size(0x0a)
$C$DW$421	.dwtag  DW_TAG_member
	.dwattr $C$DW$421, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$421, DW_AT_name("tpt")
	.dwattr $C$DW$421, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$421, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$421, DW_AT_decl_line(0x91)
	.dwattr $C$DW$421, DW_AT_decl_column(0x0f)

$C$DW$422	.dwtag  DW_TAG_member
	.dwattr $C$DW$422, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$422, DW_AT_name("T")
	.dwattr $C$DW$422, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$422, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$422, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$422, DW_AT_decl_line(0x92)
	.dwattr $C$DW$422, DW_AT_decl_column(0x0f)

$C$DW$423	.dwtag  DW_TAG_member
	.dwattr $C$DW$423, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$423, DW_AT_name("sts")
	.dwattr $C$DW$423, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$423, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$423, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$423, DW_AT_decl_line(0x93)
	.dwattr $C$DW$423, DW_AT_decl_column(0x0e)

$C$DW$424	.dwtag  DW_TAG_member
	.dwattr $C$DW$424, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$424, DW_AT_name("err")
	.dwattr $C$DW$424, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$424, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$424, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$424, DW_AT_decl_line(0x94)
	.dwattr $C$DW$424, DW_AT_decl_column(0x0e)

$C$DW$425	.dwtag  DW_TAG_member
	.dwattr $C$DW$425, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$425, DW_AT_name("loc")
	.dwattr $C$DW$425, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$425, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$425, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$425, DW_AT_decl_line(0x95)
	.dwattr $C$DW$425, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$44, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$T$44, DW_AT_decl_line(0x90)
	.dwattr $C$DW$T$44, DW_AT_decl_column(0x19)
	.dwendtag $C$DW$T$44

	.dwendtag $C$DW$TU$44


$C$DW$TU$48	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$48
$C$DW$426	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$426, DW_AT_type(*$C$DW$T$44)

$C$DW$T$48	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$48, DW_AT_type(*$C$DW$426)

	.dwendtag $C$DW$TU$48


$C$DW$TU$49	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$49
$C$DW$T$49	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$49, DW_AT_name("DCL_CSS")
	.dwattr $C$DW$T$49, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$T$49, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$T$49, DW_AT_decl_line(0x96)
	.dwattr $C$DW$T$49, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$49


$C$DW$TU$50	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$50
$C$DW$T$50	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$50, DW_AT_type(*$C$DW$T$49)
	.dwattr $C$DW$T$50, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$50


$C$DW$TU$51	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$51

$C$DW$T$51	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$51, DW_AT_name("dcl_df22")
	.dwattr $C$DW$T$51, DW_AT_byte_size(0x12)
$C$DW$427	.dwtag  DW_TAG_member
	.dwattr $C$DW$427, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$427, DW_AT_name("b0")
	.dwattr $C$DW$427, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$427, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$427, DW_AT_decl_line(0x4ab)
	.dwattr $C$DW$427, DW_AT_decl_column(0x0f)

$C$DW$428	.dwtag  DW_TAG_member
	.dwattr $C$DW$428, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$428, DW_AT_name("b1")
	.dwattr $C$DW$428, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$428, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$428, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$428, DW_AT_decl_line(0x4ac)
	.dwattr $C$DW$428, DW_AT_decl_column(0x0f)

$C$DW$429	.dwtag  DW_TAG_member
	.dwattr $C$DW$429, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$429, DW_AT_name("b2")
	.dwattr $C$DW$429, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$429, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$429, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$429, DW_AT_decl_line(0x4ad)
	.dwattr $C$DW$429, DW_AT_decl_column(0x0f)

$C$DW$430	.dwtag  DW_TAG_member
	.dwattr $C$DW$430, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$430, DW_AT_name("a1")
	.dwattr $C$DW$430, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$430, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$430, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$430, DW_AT_decl_line(0x4ae)
	.dwattr $C$DW$430, DW_AT_decl_column(0x0f)

$C$DW$431	.dwtag  DW_TAG_member
	.dwattr $C$DW$431, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$431, DW_AT_name("a2")
	.dwattr $C$DW$431, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$431, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$431, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$431, DW_AT_decl_line(0x4af)
	.dwattr $C$DW$431, DW_AT_decl_column(0x0f)

$C$DW$432	.dwtag  DW_TAG_member
	.dwattr $C$DW$432, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$432, DW_AT_name("x1")
	.dwattr $C$DW$432, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$432, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$432, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$432, DW_AT_decl_line(0x4b0)
	.dwattr $C$DW$432, DW_AT_decl_column(0x0f)

$C$DW$433	.dwtag  DW_TAG_member
	.dwattr $C$DW$433, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$433, DW_AT_name("x2")
	.dwattr $C$DW$433, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$433, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$433, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$433, DW_AT_decl_line(0x4b1)
	.dwattr $C$DW$433, DW_AT_decl_column(0x0f)

$C$DW$434	.dwtag  DW_TAG_member
	.dwattr $C$DW$434, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$434, DW_AT_name("sps")
	.dwattr $C$DW$434, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$434, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$434, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$434, DW_AT_decl_line(0x4b2)
	.dwattr $C$DW$434, DW_AT_decl_column(0x13)

$C$DW$435	.dwtag  DW_TAG_member
	.dwattr $C$DW$435, DW_AT_type(*$C$DW$T$50)
	.dwattr $C$DW$435, DW_AT_name("css")
	.dwattr $C$DW$435, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$435, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$435, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$435, DW_AT_decl_line(0x4b3)
	.dwattr $C$DW$435, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$51, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$51, DW_AT_decl_line(0x4aa)
	.dwattr $C$DW$T$51, DW_AT_decl_column(0x19)
	.dwendtag $C$DW$T$51

	.dwendtag $C$DW$TU$51


$C$DW$TU$98	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$98
$C$DW$436	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$436, DW_AT_type(*$C$DW$T$51)

$C$DW$T$98	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$98, DW_AT_type(*$C$DW$436)

	.dwendtag $C$DW$TU$98


$C$DW$TU$99	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$99
$C$DW$T$99	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$99, DW_AT_name("DCL_DF22")
	.dwattr $C$DW$T$99, DW_AT_type(*$C$DW$T$98)
	.dwattr $C$DW$T$99, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$99, DW_AT_decl_line(0x4b4)
	.dwattr $C$DW$T$99, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$99


$C$DW$TU$52	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$52

$C$DW$T$52	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$52, DW_AT_name("dcl_df22_sps")
	.dwattr $C$DW$T$52, DW_AT_byte_size(0x0a)
$C$DW$437	.dwtag  DW_TAG_member
	.dwattr $C$DW$437, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$437, DW_AT_name("b0")
	.dwattr $C$DW$437, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$437, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$437, DW_AT_decl_line(0x49f)
	.dwattr $C$DW$437, DW_AT_decl_column(0x0f)

$C$DW$438	.dwtag  DW_TAG_member
	.dwattr $C$DW$438, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$438, DW_AT_name("b1")
	.dwattr $C$DW$438, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$438, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$438, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$438, DW_AT_decl_line(0x4a0)
	.dwattr $C$DW$438, DW_AT_decl_column(0x0f)

$C$DW$439	.dwtag  DW_TAG_member
	.dwattr $C$DW$439, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$439, DW_AT_name("b2")
	.dwattr $C$DW$439, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$439, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$439, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$439, DW_AT_decl_line(0x4a1)
	.dwattr $C$DW$439, DW_AT_decl_column(0x0f)

$C$DW$440	.dwtag  DW_TAG_member
	.dwattr $C$DW$440, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$440, DW_AT_name("a1")
	.dwattr $C$DW$440, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$440, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$440, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$440, DW_AT_decl_line(0x4a2)
	.dwattr $C$DW$440, DW_AT_decl_column(0x0f)

$C$DW$441	.dwtag  DW_TAG_member
	.dwattr $C$DW$441, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$441, DW_AT_name("a2")
	.dwattr $C$DW$441, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$441, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$441, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$441, DW_AT_decl_line(0x4a3)
	.dwattr $C$DW$441, DW_AT_decl_column(0x0f)

	.dwattr $C$DW$T$52, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$52, DW_AT_decl_line(0x49e)
	.dwattr $C$DW$T$52, DW_AT_decl_column(0x19)
	.dwendtag $C$DW$T$52

	.dwendtag $C$DW$TU$52


$C$DW$TU$45	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$45
$C$DW$442	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$442, DW_AT_type(*$C$DW$T$52)

$C$DW$T$45	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$45, DW_AT_type(*$C$DW$442)

	.dwendtag $C$DW$TU$45


$C$DW$TU$46	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$46
$C$DW$T$46	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$46, DW_AT_name("DCL_DF22_SPS")
	.dwattr $C$DW$T$46, DW_AT_type(*$C$DW$T$45)
	.dwattr $C$DW$T$46, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$46, DW_AT_decl_line(0x4a4)
	.dwattr $C$DW$T$46, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$46


$C$DW$TU$47	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$47
$C$DW$T$47	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$47, DW_AT_type(*$C$DW$T$46)
	.dwattr $C$DW$T$47, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$47

