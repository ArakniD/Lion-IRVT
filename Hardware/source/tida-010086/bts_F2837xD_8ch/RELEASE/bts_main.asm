;***************************************************************
;* TMS320C2000 G3 C/C++ Codegen                               PC v20.2.4.LTS *
;* Date/Time created: Mon Jan 11 05:48:46 2021                 *
;***************************************************************
	.compiler_opts --abi=eabi --cla_support=cla1 --diag_wrap=off --float_support=fpu32 --hll_source=on --mem_model:code=flat --mem_model:data=large --object_format=elf --quiet --silicon_errata_fpu1_workaround=off --silicon_version=28 --symdebug:dwarf --symdebug:dwarf_version=4 --tmu_support=tmu0 --vcu_support=vcu2 
	.asg	XAR2, FP

$C$DW$CU	.dwtag  DW_TAG_compile_unit
	.dwattr $C$DW$CU, DW_AT_name("../bts_main.c")
	.dwattr $C$DW$CU, DW_AT_producer("TI TMS320C2000 G3 C/C++ Codegen PC v20.2.4.LTS Copyright (c) 1996-2018 Texas Instruments Incorporated")
	.dwattr $C$DW$CU, DW_AT_TI_version(0x01)
	.dwattr $C$DW$CU, DW_AT_comp_dir("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\RELEASE")

$C$DW$1	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$1, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$1, DW_AT_linkage_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$1, DW_AT_declaration
	.dwattr $C$DW$1, DW_AT_external
	.dwattr $C$DW$1, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/spi.h")
	.dwattr $C$DW$1, DW_AT_decl_line(0x50f)
	.dwattr $C$DW$1, DW_AT_decl_column(0x01)
$C$DW$2	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$2, DW_AT_type(*$C$DW$T$41)

$C$DW$3	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$3, DW_AT_type(*$C$DW$T$41)

	.dwendtag $C$DW$1


$C$DW$4	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$4, DW_AT_name("BTS_HAL_setupDevice")
	.dwattr $C$DW$4, DW_AT_linkage_name("BTS_HAL_setupDevice")
	.dwattr $C$DW$4, DW_AT_declaration
	.dwattr $C$DW$4, DW_AT_external
	.dwattr $C$DW$4, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$4, DW_AT_decl_line(0x49)
	.dwattr $C$DW$4, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$4


$C$DW$5	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$5, DW_AT_name("BTS_HAL_setupSyncBuckPinsGpio")
	.dwattr $C$DW$5, DW_AT_linkage_name("BTS_HAL_setupSyncBuckPinsGpio")
	.dwattr $C$DW$5, DW_AT_declaration
	.dwattr $C$DW$5, DW_AT_external
	.dwattr $C$DW$5, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$5, DW_AT_decl_line(0x4e)
	.dwattr $C$DW$5, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$5


$C$DW$6	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$6, DW_AT_name("BTS_HAL_disableEpwmCounting")
	.dwattr $C$DW$6, DW_AT_linkage_name("BTS_HAL_disableEpwmCounting")
	.dwattr $C$DW$6, DW_AT_declaration
	.dwattr $C$DW$6, DW_AT_external
	.dwattr $C$DW$6, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$6, DW_AT_decl_line(0x53)
	.dwattr $C$DW$6, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$6


$C$DW$7	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$7, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$7, DW_AT_linkage_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$7, DW_AT_declaration
	.dwattr $C$DW$7, DW_AT_external
	.dwattr $C$DW$7, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$7, DW_AT_decl_line(0x50)
	.dwattr $C$DW$7, DW_AT_decl_column(0x06)
$C$DW$8	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$8, DW_AT_type(*$C$DW$T$41)

	.dwendtag $C$DW$7


$C$DW$9	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$9, DW_AT_name("BTS_setupHrpwmMepScaleFactor")
	.dwattr $C$DW$9, DW_AT_linkage_name("BTS_setupHrpwmMepScaleFactor")
	.dwattr $C$DW$9, DW_AT_declaration
	.dwattr $C$DW$9, DW_AT_external
	.dwattr $C$DW$9, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$9, DW_AT_decl_line(0x120)
	.dwattr $C$DW$9, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$9


$C$DW$10	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$10, DW_AT_name("BTS_HAL_SetupSpiPinsGpio")
	.dwattr $C$DW$10, DW_AT_linkage_name("BTS_HAL_SetupSpiPinsGpio")
	.dwattr $C$DW$10, DW_AT_declaration
	.dwattr $C$DW$10, DW_AT_external
	.dwattr $C$DW$10, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$10, DW_AT_decl_line(0x5a)
	.dwattr $C$DW$10, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$10


$C$DW$11	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$11, DW_AT_name("BTS_HAL_SetupSpi")
	.dwattr $C$DW$11, DW_AT_linkage_name("BTS_HAL_SetupSpi")
	.dwattr $C$DW$11, DW_AT_declaration
	.dwattr $C$DW$11, DW_AT_external
	.dwattr $C$DW$11, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$11, DW_AT_decl_line(0x59)
	.dwattr $C$DW$11, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$11


$C$DW$12	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$12, DW_AT_name("BTS_HAL_setupExAdcGpio")
	.dwattr $C$DW$12, DW_AT_linkage_name("BTS_HAL_setupExAdcGpio")
	.dwattr $C$DW$12, DW_AT_declaration
	.dwattr $C$DW$12, DW_AT_external
	.dwattr $C$DW$12, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$12, DW_AT_decl_line(0x4c)
	.dwattr $C$DW$12, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$12


$C$DW$13	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$13, DW_AT_name("BTS_HAL_setupExAdc")
	.dwattr $C$DW$13, DW_AT_linkage_name("BTS_HAL_setupExAdc")
	.dwattr $C$DW$13, DW_AT_declaration
	.dwattr $C$DW$13, DW_AT_external
	.dwattr $C$DW$13, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$13, DW_AT_decl_line(0x4a)
	.dwattr $C$DW$13, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$13


$C$DW$14	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$14, DW_AT_name("BTS_initUserVariables")
	.dwattr $C$DW$14, DW_AT_linkage_name("BTS_initUserVariables")
	.dwattr $C$DW$14, DW_AT_declaration
	.dwattr $C$DW$14, DW_AT_external
	.dwattr $C$DW$14, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$14, DW_AT_decl_line(0x123)
	.dwattr $C$DW$14, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$14


$C$DW$15	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$15, DW_AT_name("BTS_initProgramVariables")
	.dwattr $C$DW$15, DW_AT_linkage_name("BTS_initProgramVariables")
	.dwattr $C$DW$15, DW_AT_declaration
	.dwattr $C$DW$15, DW_AT_external
	.dwattr $C$DW$15, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$15, DW_AT_decl_line(0x124)
	.dwattr $C$DW$15, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$15


$C$DW$16	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$16, DW_AT_name("BTS_initController")
	.dwattr $C$DW$16, DW_AT_linkage_name("BTS_initController")
	.dwattr $C$DW$16, DW_AT_declaration
	.dwattr $C$DW$16, DW_AT_external
	.dwattr $C$DW$16, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$16, DW_AT_decl_line(0x125)
	.dwattr $C$DW$16, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$16


$C$DW$17	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$17, DW_AT_name("BTS_setupSfra")
	.dwattr $C$DW$17, DW_AT_linkage_name("BTS_setupSfra")
	.dwattr $C$DW$17, DW_AT_declaration
	.dwattr $C$DW$17, DW_AT_external
	.dwattr $C$DW$17, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$17, DW_AT_decl_line(0x11d)
	.dwattr $C$DW$17, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$17


$C$DW$18	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$18, DW_AT_name("BTS_setupSfraGui")
	.dwattr $C$DW$18, DW_AT_linkage_name("BTS_setupSfraGui")
	.dwattr $C$DW$18, DW_AT_declaration
	.dwattr $C$DW$18, DW_AT_external
	.dwattr $C$DW$18, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$18, DW_AT_decl_line(0x11e)
	.dwattr $C$DW$18, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$18


$C$DW$19	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$19, DW_AT_name("BTS_HAL_setupInterruptTrigger")
	.dwattr $C$DW$19, DW_AT_linkage_name("BTS_HAL_setupInterruptTrigger")
	.dwattr $C$DW$19, DW_AT_declaration
	.dwattr $C$DW$19, DW_AT_external
	.dwattr $C$DW$19, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$19, DW_AT_decl_line(0x55)
	.dwattr $C$DW$19, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$19


$C$DW$20	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$20, DW_AT_name("BTS_HAL_setupInterrupt")
	.dwattr $C$DW$20, DW_AT_linkage_name("BTS_HAL_setupInterrupt")
	.dwattr $C$DW$20, DW_AT_declaration
	.dwattr $C$DW$20, DW_AT_external
	.dwattr $C$DW$20, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$20, DW_AT_decl_line(0x57)
	.dwattr $C$DW$20, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$20


$C$DW$21	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$21, DW_AT_name("BTS_HAL_enableEpwmCounting")
	.dwattr $C$DW$21, DW_AT_linkage_name("BTS_HAL_enableEpwmCounting")
	.dwattr $C$DW$21, DW_AT_declaration
	.dwattr $C$DW$21, DW_AT_external
	.dwattr $C$DW$21, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$21, DW_AT_decl_line(0x54)
	.dwattr $C$DW$21, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$21


$C$DW$22	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$22, DW_AT_name("BTS_HAL_setupSyncBuckPinsEpwm")
	.dwattr $C$DW$22, DW_AT_linkage_name("BTS_HAL_setupSyncBuckPinsEpwm")
	.dwattr $C$DW$22, DW_AT_declaration
	.dwattr $C$DW$22, DW_AT_external
	.dwattr $C$DW$22, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$22, DW_AT_decl_line(0x4f)
	.dwattr $C$DW$22, DW_AT_decl_column(0x06)
	.dwendtag $C$DW$22


$C$DW$23	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$23, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$23, DW_AT_linkage_name("BTS_updateReference")
	.dwattr $C$DW$23, DW_AT_declaration
	.dwattr $C$DW$23, DW_AT_external
	.dwattr $C$DW$23, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$23, DW_AT_decl_line(0x122)
	.dwattr $C$DW$23, DW_AT_decl_column(0x06)
$C$DW$24	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$24, DW_AT_type(*$C$DW$T$66)

$C$DW$25	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$25, DW_AT_type(*$C$DW$T$69)

	.dwendtag $C$DW$23


$C$DW$26	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$26, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$26, DW_AT_linkage_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$26, DW_AT_declaration
	.dwattr $C$DW$26, DW_AT_external
	.dwattr $C$DW$26, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$26, DW_AT_decl_line(0x126)
	.dwattr $C$DW$26, DW_AT_decl_column(0x06)
$C$DW$27	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$27, DW_AT_type(*$C$DW$T$72)

	.dwendtag $C$DW$26

$C$DW$28	.dwtag  DW_TAG_variable
	.dwattr $C$DW$28, DW_AT_name("BTS_ExAdcRxflag")
	.dwattr $C$DW$28, DW_AT_linkage_name("BTS_ExAdcRxflag")
	.dwattr $C$DW$28, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$28, DW_AT_declaration
	.dwattr $C$DW$28, DW_AT_external
	.dwattr $C$DW$28, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$28, DW_AT_decl_line(0x41)
	.dwattr $C$DW$28, DW_AT_decl_column(0x1a)

$C$DW$29	.dwtag  DW_TAG_variable
	.dwattr $C$DW$29, DW_AT_name("BTS_sfoStatus")
	.dwattr $C$DW$29, DW_AT_linkage_name("BTS_sfoStatus")
	.dwattr $C$DW$29, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$29, DW_AT_declaration
	.dwattr $C$DW$29, DW_AT_external
	.dwattr $C$DW$29, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$29, DW_AT_decl_line(0xfe)
	.dwattr $C$DW$29, DW_AT_decl_column(0x13)


$C$DW$30	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$30, DW_AT_name("SFO")
	.dwattr $C$DW$30, DW_AT_linkage_name("SFO")
	.dwattr $C$DW$30, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$30, DW_AT_declaration
	.dwattr $C$DW$30, DW_AT_external
	.dwattr $C$DW$30, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/SFO/SFO_V8.h")
	.dwattr $C$DW$30, DW_AT_decl_line(0x40)
	.dwattr $C$DW$30, DW_AT_decl_column(0x05)
	.dwendtag $C$DW$30

$C$DW$31	.dwtag  DW_TAG_variable
	.dwattr $C$DW$31, DW_AT_name("MEP_ScaleFactor")
	.dwattr $C$DW$31, DW_AT_linkage_name("MEP_ScaleFactor")
	.dwattr $C$DW$31, DW_AT_type(*$C$DW$T$41)
	.dwattr $C$DW$31, DW_AT_declaration
	.dwattr $C$DW$31, DW_AT_external
	.dwattr $C$DW$31, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$31, DW_AT_decl_line(0x42)
	.dwattr $C$DW$31, DW_AT_decl_column(0x12)

	.global	||Alpha_State_Ptr||
	.bss	||Alpha_State_Ptr||,2,1,1
$C$DW$32	.dwtag  DW_TAG_variable
	.dwattr $C$DW$32, DW_AT_name("Alpha_State_Ptr")
	.dwattr $C$DW$32, DW_AT_linkage_name("Alpha_State_Ptr")
	.dwattr $C$DW$32, DW_AT_location[DW_OP_addr ||Alpha_State_Ptr||]
	.dwattr $C$DW$32, DW_AT_type(*$C$DW$T$79)
	.dwattr $C$DW$32, DW_AT_external
	.dwattr $C$DW$32, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$32, DW_AT_decl_line(0x25)
	.dwattr $C$DW$32, DW_AT_decl_column(0x08)

	.global	||A_Task_Ptr||
	.bss	||A_Task_Ptr||,2,1,1
$C$DW$33	.dwtag  DW_TAG_variable
	.dwattr $C$DW$33, DW_AT_name("A_Task_Ptr")
	.dwattr $C$DW$33, DW_AT_linkage_name("A_Task_Ptr")
	.dwattr $C$DW$33, DW_AT_location[DW_OP_addr ||A_Task_Ptr||]
	.dwattr $C$DW$33, DW_AT_type(*$C$DW$T$79)
	.dwattr $C$DW$33, DW_AT_external
	.dwattr $C$DW$33, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$33, DW_AT_decl_line(0x26)
	.dwattr $C$DW$33, DW_AT_decl_column(0x08)

	.global	||B_Task_Ptr||
	.bss	||B_Task_Ptr||,2,1,1
$C$DW$34	.dwtag  DW_TAG_variable
	.dwattr $C$DW$34, DW_AT_name("B_Task_Ptr")
	.dwattr $C$DW$34, DW_AT_linkage_name("B_Task_Ptr")
	.dwattr $C$DW$34, DW_AT_location[DW_OP_addr ||B_Task_Ptr||]
	.dwattr $C$DW$34, DW_AT_type(*$C$DW$T$79)
	.dwattr $C$DW$34, DW_AT_external
	.dwattr $C$DW$34, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$34, DW_AT_decl_line(0x27)
	.dwattr $C$DW$34, DW_AT_decl_column(0x08)

	.global	||C_Task_Ptr||
	.bss	||C_Task_Ptr||,2,1,1
$C$DW$35	.dwtag  DW_TAG_variable
	.dwattr $C$DW$35, DW_AT_name("C_Task_Ptr")
	.dwattr $C$DW$35, DW_AT_linkage_name("C_Task_Ptr")
	.dwattr $C$DW$35, DW_AT_location[DW_OP_addr ||C_Task_Ptr||]
	.dwattr $C$DW$35, DW_AT_type(*$C$DW$T$79)
	.dwattr $C$DW$35, DW_AT_external
	.dwattr $C$DW$35, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$35, DW_AT_decl_line(0x28)
	.dwattr $C$DW$35, DW_AT_decl_column(0x08)


$C$DW$36	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$36, DW_AT_name("__eallow")
	.dwattr $C$DW$36, DW_AT_linkage_name("__eallow")
	.dwattr $C$DW$36, DW_AT_declaration
	.dwattr $C$DW$36, DW_AT_external
	.dwendtag $C$DW$36


$C$DW$37	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$37, DW_AT_name("__edis")
	.dwattr $C$DW$37, DW_AT_linkage_name("__edis")
	.dwattr $C$DW$37, DW_AT_declaration
	.dwattr $C$DW$37, DW_AT_external
	.dwendtag $C$DW$37

	.global	||vTimer0||
||vTimer0||:	.usect	".bss:vTimer0",4,0,0
$C$DW$38	.dwtag  DW_TAG_variable
	.dwattr $C$DW$38, DW_AT_name("vTimer0")
	.dwattr $C$DW$38, DW_AT_linkage_name("vTimer0")
	.dwattr $C$DW$38, DW_AT_location[DW_OP_addr ||vTimer0||]
	.dwattr $C$DW$38, DW_AT_type(*$C$DW$T$117)
	.dwattr $C$DW$38, DW_AT_external
	.dwattr $C$DW$38, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$38, DW_AT_decl_line(0x1e)
	.dwattr $C$DW$38, DW_AT_decl_column(0x0a)

	.global	||vTimer1||
||vTimer1||:	.usect	".bss:vTimer1",4,0,0
$C$DW$39	.dwtag  DW_TAG_variable
	.dwattr $C$DW$39, DW_AT_name("vTimer1")
	.dwattr $C$DW$39, DW_AT_linkage_name("vTimer1")
	.dwattr $C$DW$39, DW_AT_location[DW_OP_addr ||vTimer1||]
	.dwattr $C$DW$39, DW_AT_type(*$C$DW$T$117)
	.dwattr $C$DW$39, DW_AT_external
	.dwattr $C$DW$39, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$39, DW_AT_decl_line(0x1f)
	.dwattr $C$DW$39, DW_AT_decl_column(0x0a)

	.global	||vTimer2||
||vTimer2||:	.usect	".bss:vTimer2",4,0,0
$C$DW$40	.dwtag  DW_TAG_variable
	.dwattr $C$DW$40, DW_AT_name("vTimer2")
	.dwattr $C$DW$40, DW_AT_linkage_name("vTimer2")
	.dwattr $C$DW$40, DW_AT_location[DW_OP_addr ||vTimer2||]
	.dwattr $C$DW$40, DW_AT_type(*$C$DW$T$117)
	.dwattr $C$DW$40, DW_AT_external
	.dwattr $C$DW$40, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$40, DW_AT_decl_line(0x20)
	.dwattr $C$DW$40, DW_AT_decl_column(0x0a)

$C$DW$41	.dwtag  DW_TAG_variable
	.dwattr $C$DW$41, DW_AT_name("BTS_ADC1")
	.dwattr $C$DW$41, DW_AT_linkage_name("BTS_ADC1")
	.dwattr $C$DW$41, DW_AT_type(*$C$DW$T$63)
	.dwattr $C$DW$41, DW_AT_declaration
	.dwattr $C$DW$41, DW_AT_external
	.dwattr $C$DW$41, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$41, DW_AT_decl_line(0x40)
	.dwattr $C$DW$41, DW_AT_decl_column(0x12)

$C$DW$42	.dwtag  DW_TAG_variable
	.dwattr $C$DW$42, DW_AT_name("BTS_ctrl_cc_ch1")
	.dwattr $C$DW$42, DW_AT_linkage_name("BTS_ctrl_cc_ch1")
	.dwattr $C$DW$42, DW_AT_type(*$C$DW$T$94)
	.dwattr $C$DW$42, DW_AT_declaration
	.dwattr $C$DW$42, DW_AT_external
	.dwattr $C$DW$42, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$42, DW_AT_decl_line(0xb3)
	.dwattr $C$DW$42, DW_AT_decl_column(0x25)

$C$DW$43	.dwtag  DW_TAG_variable
	.dwattr $C$DW$43, DW_AT_name("BTS_ctrl_cc_ch2")
	.dwattr $C$DW$43, DW_AT_linkage_name("BTS_ctrl_cc_ch2")
	.dwattr $C$DW$43, DW_AT_type(*$C$DW$T$94)
	.dwattr $C$DW$43, DW_AT_declaration
	.dwattr $C$DW$43, DW_AT_external
	.dwattr $C$DW$43, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$43, DW_AT_decl_line(0xb4)
	.dwattr $C$DW$43, DW_AT_decl_column(0x25)

$C$DW$44	.dwtag  DW_TAG_variable
	.dwattr $C$DW$44, DW_AT_name("BTS_ctrl_cc_ch3")
	.dwattr $C$DW$44, DW_AT_linkage_name("BTS_ctrl_cc_ch3")
	.dwattr $C$DW$44, DW_AT_type(*$C$DW$T$94)
	.dwattr $C$DW$44, DW_AT_declaration
	.dwattr $C$DW$44, DW_AT_external
	.dwattr $C$DW$44, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$44, DW_AT_decl_line(0xb5)
	.dwattr $C$DW$44, DW_AT_decl_column(0x25)

$C$DW$45	.dwtag  DW_TAG_variable
	.dwattr $C$DW$45, DW_AT_name("BTS_ctrl_cc_ch4")
	.dwattr $C$DW$45, DW_AT_linkage_name("BTS_ctrl_cc_ch4")
	.dwattr $C$DW$45, DW_AT_type(*$C$DW$T$94)
	.dwattr $C$DW$45, DW_AT_declaration
	.dwattr $C$DW$45, DW_AT_external
	.dwattr $C$DW$45, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$45, DW_AT_decl_line(0xb6)
	.dwattr $C$DW$45, DW_AT_decl_column(0x25)

$C$DW$46	.dwtag  DW_TAG_variable
	.dwattr $C$DW$46, DW_AT_name("BTS_ctrl_cv_ch1")
	.dwattr $C$DW$46, DW_AT_linkage_name("BTS_ctrl_cv_ch1")
	.dwattr $C$DW$46, DW_AT_type(*$C$DW$T$94)
	.dwattr $C$DW$46, DW_AT_declaration
	.dwattr $C$DW$46, DW_AT_external
	.dwattr $C$DW$46, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$46, DW_AT_decl_line(0xb9)
	.dwattr $C$DW$46, DW_AT_decl_column(0x25)

$C$DW$47	.dwtag  DW_TAG_variable
	.dwattr $C$DW$47, DW_AT_name("BTS_ctrl_cv_ch2")
	.dwattr $C$DW$47, DW_AT_linkage_name("BTS_ctrl_cv_ch2")
	.dwattr $C$DW$47, DW_AT_type(*$C$DW$T$94)
	.dwattr $C$DW$47, DW_AT_declaration
	.dwattr $C$DW$47, DW_AT_external
	.dwattr $C$DW$47, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$47, DW_AT_decl_line(0xba)
	.dwattr $C$DW$47, DW_AT_decl_column(0x25)

$C$DW$48	.dwtag  DW_TAG_variable
	.dwattr $C$DW$48, DW_AT_name("BTS_ctrl_cv_ch3")
	.dwattr $C$DW$48, DW_AT_linkage_name("BTS_ctrl_cv_ch3")
	.dwattr $C$DW$48, DW_AT_type(*$C$DW$T$94)
	.dwattr $C$DW$48, DW_AT_declaration
	.dwattr $C$DW$48, DW_AT_external
	.dwattr $C$DW$48, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$48, DW_AT_decl_line(0xbb)
	.dwattr $C$DW$48, DW_AT_decl_column(0x25)

$C$DW$49	.dwtag  DW_TAG_variable
	.dwattr $C$DW$49, DW_AT_name("BTS_ctrl_cv_ch4")
	.dwattr $C$DW$49, DW_AT_linkage_name("BTS_ctrl_cv_ch4")
	.dwattr $C$DW$49, DW_AT_type(*$C$DW$T$94)
	.dwattr $C$DW$49, DW_AT_declaration
	.dwattr $C$DW$49, DW_AT_external
	.dwattr $C$DW$49, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$49, DW_AT_decl_line(0xbc)
	.dwattr $C$DW$49, DW_AT_decl_column(0x25)

$C$DW$50	.dwtag  DW_TAG_variable
	.dwattr $C$DW$50, DW_AT_name("BTS_userInput_ch1")
	.dwattr $C$DW$50, DW_AT_linkage_name("BTS_userInput_ch1")
	.dwattr $C$DW$50, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$50, DW_AT_declaration
	.dwattr $C$DW$50, DW_AT_external
	.dwattr $C$DW$50, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$50, DW_AT_decl_line(0x88)
	.dwattr $C$DW$50, DW_AT_decl_column(0x16)

$C$DW$51	.dwtag  DW_TAG_variable
	.dwattr $C$DW$51, DW_AT_name("BTS_userInput_ch2")
	.dwattr $C$DW$51, DW_AT_linkage_name("BTS_userInput_ch2")
	.dwattr $C$DW$51, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$51, DW_AT_declaration
	.dwattr $C$DW$51, DW_AT_external
	.dwattr $C$DW$51, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$51, DW_AT_decl_line(0x89)
	.dwattr $C$DW$51, DW_AT_decl_column(0x16)

$C$DW$52	.dwtag  DW_TAG_variable
	.dwattr $C$DW$52, DW_AT_name("BTS_userInput_ch3")
	.dwattr $C$DW$52, DW_AT_linkage_name("BTS_userInput_ch3")
	.dwattr $C$DW$52, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$52, DW_AT_declaration
	.dwattr $C$DW$52, DW_AT_external
	.dwattr $C$DW$52, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$52, DW_AT_decl_line(0x8a)
	.dwattr $C$DW$52, DW_AT_decl_column(0x16)

$C$DW$53	.dwtag  DW_TAG_variable
	.dwattr $C$DW$53, DW_AT_name("BTS_userInput_ch4")
	.dwattr $C$DW$53, DW_AT_linkage_name("BTS_userInput_ch4")
	.dwattr $C$DW$53, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$53, DW_AT_declaration
	.dwattr $C$DW$53, DW_AT_external
	.dwattr $C$DW$53, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$53, DW_AT_decl_line(0x8b)
	.dwattr $C$DW$53, DW_AT_decl_column(0x16)

$C$DW$54	.dwtag  DW_TAG_variable
	.dwattr $C$DW$54, DW_AT_name("BTS_ctrlLoopVariable_ch1")
	.dwattr $C$DW$54, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch1")
	.dwattr $C$DW$54, DW_AT_type(*$C$DW$T$68)
	.dwattr $C$DW$54, DW_AT_declaration
	.dwattr $C$DW$54, DW_AT_external
	.dwattr $C$DW$54, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$54, DW_AT_decl_line(0xac)
	.dwattr $C$DW$54, DW_AT_decl_column(0x1d)

$C$DW$55	.dwtag  DW_TAG_variable
	.dwattr $C$DW$55, DW_AT_name("BTS_ctrlLoopVariable_ch2")
	.dwattr $C$DW$55, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch2")
	.dwattr $C$DW$55, DW_AT_type(*$C$DW$T$68)
	.dwattr $C$DW$55, DW_AT_declaration
	.dwattr $C$DW$55, DW_AT_external
	.dwattr $C$DW$55, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$55, DW_AT_decl_line(0xad)
	.dwattr $C$DW$55, DW_AT_decl_column(0x1d)

$C$DW$56	.dwtag  DW_TAG_variable
	.dwattr $C$DW$56, DW_AT_name("BTS_ctrlLoopVariable_ch3")
	.dwattr $C$DW$56, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch3")
	.dwattr $C$DW$56, DW_AT_type(*$C$DW$T$68)
	.dwattr $C$DW$56, DW_AT_declaration
	.dwattr $C$DW$56, DW_AT_external
	.dwattr $C$DW$56, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$56, DW_AT_decl_line(0xae)
	.dwattr $C$DW$56, DW_AT_decl_column(0x1d)

$C$DW$57	.dwtag  DW_TAG_variable
	.dwattr $C$DW$57, DW_AT_name("BTS_ctrlLoopVariable_ch4")
	.dwattr $C$DW$57, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch4")
	.dwattr $C$DW$57, DW_AT_type(*$C$DW$T$68)
	.dwattr $C$DW$57, DW_AT_declaration
	.dwattr $C$DW$57, DW_AT_external
	.dwattr $C$DW$57, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$57, DW_AT_decl_line(0xaf)
	.dwattr $C$DW$57, DW_AT_decl_column(0x1d)

$C$DW$58	.dwtag  DW_TAG_variable
	.dwattr $C$DW$58, DW_AT_name("BTS_measValues_ch1")
	.dwattr $C$DW$58, DW_AT_linkage_name("BTS_measValues_ch1")
	.dwattr $C$DW$58, DW_AT_type(*$C$DW$T$71)
	.dwattr $C$DW$58, DW_AT_declaration
	.dwattr $C$DW$58, DW_AT_external
	.dwattr $C$DW$58, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$58, DW_AT_decl_line(0x6d)
	.dwattr $C$DW$58, DW_AT_decl_column(0x17)

$C$DW$59	.dwtag  DW_TAG_variable
	.dwattr $C$DW$59, DW_AT_name("BTS_measValues_ch2")
	.dwattr $C$DW$59, DW_AT_linkage_name("BTS_measValues_ch2")
	.dwattr $C$DW$59, DW_AT_type(*$C$DW$T$71)
	.dwattr $C$DW$59, DW_AT_declaration
	.dwattr $C$DW$59, DW_AT_external
	.dwattr $C$DW$59, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$59, DW_AT_decl_line(0x6e)
	.dwattr $C$DW$59, DW_AT_decl_column(0x17)

$C$DW$60	.dwtag  DW_TAG_variable
	.dwattr $C$DW$60, DW_AT_name("BTS_measValues_ch3")
	.dwattr $C$DW$60, DW_AT_linkage_name("BTS_measValues_ch3")
	.dwattr $C$DW$60, DW_AT_type(*$C$DW$T$71)
	.dwattr $C$DW$60, DW_AT_declaration
	.dwattr $C$DW$60, DW_AT_external
	.dwattr $C$DW$60, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$60, DW_AT_decl_line(0x6f)
	.dwattr $C$DW$60, DW_AT_decl_column(0x17)

$C$DW$61	.dwtag  DW_TAG_variable
	.dwattr $C$DW$61, DW_AT_name("BTS_measValues_ch4")
	.dwattr $C$DW$61, DW_AT_linkage_name("BTS_measValues_ch4")
	.dwattr $C$DW$61, DW_AT_type(*$C$DW$T$71)
	.dwattr $C$DW$61, DW_AT_declaration
	.dwattr $C$DW$61, DW_AT_external
	.dwattr $C$DW$61, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$61, DW_AT_decl_line(0x70)
	.dwattr $C$DW$61, DW_AT_decl_column(0x17)

	.sblock	".bss"
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\opt2000.exe C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{1C6094FB-8D32-404A-8FD3-A69AE0E1ADFE} C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{0BC15835-30A3-43D7-91A4-4B503A56BC40} 
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\acia2000.exe -@C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{E7D17754-AD75-4066-B5BC-2B5F456793FD} 
	.sect	".text"
	.clink
	.global	||C3||

$C$DW$62	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$62, DW_AT_name("C3")
	.dwattr $C$DW$62, DW_AT_low_pc(||C3||)
	.dwattr $C$DW$62, DW_AT_high_pc(0x00)
	.dwattr $C$DW$62, DW_AT_linkage_name("C3")
	.dwattr $C$DW$62, DW_AT_external
	.dwattr $C$DW$62, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$62, DW_AT_decl_line(0x182)
	.dwattr $C$DW$62, DW_AT_decl_column(0x06)
	.dwattr $C$DW$62, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 387,column 1,is_stmt,address ||C3||,isa 0

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
	.dwpsn	file "../bts_main.c",line 393,column 5,is_stmt,isa 0
        MOVL      XAR4,#||C1||          ; [CPU_ARAU] |393| 
        MOVW      DP,#||C_Task_Ptr||    ; [CPU_ARAU] 
        MOVL      @||C_Task_Ptr||,XAR4  ; [CPU_ALU] |393| 
$C$DW$63	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$63, DW_AT_low_pc(0x00)
	.dwattr $C$DW$63, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$62, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$62, DW_AT_TI_end_line(0x18a)
	.dwattr $C$DW$62, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$62

	.sect	".text"
	.clink
	.global	||C2||

$C$DW$64	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$64, DW_AT_name("C2")
	.dwattr $C$DW$64, DW_AT_low_pc(||C2||)
	.dwattr $C$DW$64, DW_AT_high_pc(0x00)
	.dwattr $C$DW$64, DW_AT_linkage_name("C2")
	.dwattr $C$DW$64, DW_AT_external
	.dwattr $C$DW$64, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$64, DW_AT_decl_line(0x178)
	.dwattr $C$DW$64, DW_AT_decl_column(0x06)
	.dwattr $C$DW$64, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 377,column 1,is_stmt,address ||C2||,isa 0

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
	.dwpsn	file "../bts_main.c",line 383,column 5,is_stmt,isa 0
        MOVL      XAR4,#||C3||          ; [CPU_ARAU] |383| 
        MOVW      DP,#||C_Task_Ptr||    ; [CPU_ARAU] 
        MOVL      @||C_Task_Ptr||,XAR4  ; [CPU_ALU] |383| 
$C$DW$65	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$65, DW_AT_low_pc(0x00)
	.dwattr $C$DW$65, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$64, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$64, DW_AT_TI_end_line(0x180)
	.dwattr $C$DW$64, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$64

	.sect	".text"
	.clink
	.global	||B3||

$C$DW$66	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$66, DW_AT_name("B3")
	.dwattr $C$DW$66, DW_AT_low_pc(||B3||)
	.dwattr $C$DW$66, DW_AT_high_pc(0x00)
	.dwattr $C$DW$66, DW_AT_linkage_name("B3")
	.dwattr $C$DW$66, DW_AT_external
	.dwattr $C$DW$66, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$66, DW_AT_decl_line(0x157)
	.dwattr $C$DW$66, DW_AT_decl_column(0x06)
	.dwattr $C$DW$66, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 344,column 1,is_stmt,address ||B3||,isa 0

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
	.dwpsn	file "../bts_main.c",line 352,column 5,is_stmt,isa 0
        MOVL      XAR4,#||B1||          ; [CPU_ARAU] |352| 
        MOVW      DP,#||B_Task_Ptr||    ; [CPU_ARAU] 
        MOVL      @||B_Task_Ptr||,XAR4  ; [CPU_ALU] |352| 
$C$DW$67	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$67, DW_AT_low_pc(0x00)
	.dwattr $C$DW$67, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$66, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$66, DW_AT_TI_end_line(0x161)
	.dwattr $C$DW$66, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$66

	.sect	".text"
	.clink
	.global	||B2||

$C$DW$68	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$68, DW_AT_name("B2")
	.dwattr $C$DW$68, DW_AT_low_pc(||B2||)
	.dwattr $C$DW$68, DW_AT_high_pc(0x00)
	.dwattr $C$DW$68, DW_AT_linkage_name("B2")
	.dwattr $C$DW$68, DW_AT_external
	.dwattr $C$DW$68, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$68, DW_AT_decl_line(0x14a)
	.dwattr $C$DW$68, DW_AT_decl_column(0x06)
	.dwattr $C$DW$68, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 331,column 1,is_stmt,address ||B2||,isa 0

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
	.dwpsn	file "../bts_main.c",line 340,column 5,is_stmt,isa 0
        MOVL      XAR4,#||B3||          ; [CPU_ARAU] |340| 
        MOVW      DP,#||B_Task_Ptr||    ; [CPU_ARAU] 
        MOVL      @||B_Task_Ptr||,XAR4  ; [CPU_ALU] |340| 
$C$DW$69	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$69, DW_AT_low_pc(0x00)
	.dwattr $C$DW$69, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$68, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$68, DW_AT_TI_end_line(0x155)
	.dwattr $C$DW$68, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$68

	.sect	".text"
	.clink
	.global	||A3||

$C$DW$70	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$70, DW_AT_name("A3")
	.dwattr $C$DW$70, DW_AT_low_pc(||A3||)
	.dwattr $C$DW$70, DW_AT_high_pc(0x00)
	.dwattr $C$DW$70, DW_AT_linkage_name("A3")
	.dwattr $C$DW$70, DW_AT_external
	.dwattr $C$DW$70, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$70, DW_AT_decl_line(0x12c)
	.dwattr $C$DW$70, DW_AT_decl_column(0x06)
	.dwattr $C$DW$70, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 301,column 1,is_stmt,address ||A3||,isa 0

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
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 307,column 9,is_stmt,isa 0
$C$DW$71	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$71, DW_AT_low_pc(0x00)
	.dwattr $C$DW$71, DW_AT_name("SFO")
	.dwattr $C$DW$71, DW_AT_TI_call

        LCR       #||SFO||              ; [CPU_ALU] |307| 
        ; call occurs [#||SFO||] ; [] |307| 
        MOVW      DP,#||A_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 310,column 5,is_stmt,isa 0
        MOVL      XAR4,#||A1||          ; [CPU_ARAU] |310| 
        MOVL      @||A_Task_Ptr||,XAR4  ; [CPU_ALU] |310| 
        MOVW      DP,#||BTS_sfoStatus|| ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 307,column 9,is_stmt,isa 0
        MOV       @||BTS_sfoStatus||,AL ; [CPU_ALU] |307| 
$C$DW$72	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$72, DW_AT_low_pc(0x00)
	.dwattr $C$DW$72, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$70, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$70, DW_AT_TI_end_line(0x137)
	.dwattr $C$DW$70, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$70

	.sect	".text"
	.clink
	.global	||A2||

$C$DW$73	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$73, DW_AT_name("A2")
	.dwattr $C$DW$73, DW_AT_low_pc(||A2||)
	.dwattr $C$DW$73, DW_AT_high_pc(0x00)
	.dwattr $C$DW$73, DW_AT_linkage_name("A2")
	.dwattr $C$DW$73, DW_AT_external
	.dwattr $C$DW$73, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$73, DW_AT_decl_line(0x11f)
	.dwattr $C$DW$73, DW_AT_decl_column(0x06)
	.dwattr $C$DW$73, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 288,column 1,is_stmt,address ||A2||,isa 0

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
	.dwpsn	file "../bts_main.c",line 297,column 5,is_stmt,isa 0
        MOVL      XAR4,#||A3||          ; [CPU_ARAU] |297| 
        MOVW      DP,#||A_Task_Ptr||    ; [CPU_ARAU] 
        MOVL      @||A_Task_Ptr||,XAR4  ; [CPU_ALU] |297| 
$C$DW$74	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$74, DW_AT_low_pc(0x00)
	.dwattr $C$DW$74, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$73, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$73, DW_AT_TI_end_line(0x12a)
	.dwattr $C$DW$73, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$73

	.sect	".text"
	.clink
	.global	||C1||

$C$DW$75	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$75, DW_AT_name("C1")
	.dwattr $C$DW$75, DW_AT_low_pc(||C1||)
	.dwattr $C$DW$75, DW_AT_high_pc(0x00)
	.dwattr $C$DW$75, DW_AT_linkage_name("C1")
	.dwattr $C$DW$75, DW_AT_external
	.dwattr $C$DW$75, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$75, DW_AT_decl_line(0x168)
	.dwattr $C$DW$75, DW_AT_decl_column(0x06)
	.dwattr $C$DW$75, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 361,column 1,is_stmt,address ||C1||,isa 0

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
	.dwpsn	file "../bts_main.c",line 364,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_measValues_ch1|| ; [CPU_ARAU] |364| 
$C$DW$76	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$76, DW_AT_low_pc(0x00)
	.dwattr $C$DW$76, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$76, DW_AT_TI_call

        LCR       #||BTS_monitor_Iout_Vout|| ; [CPU_ALU] |364| 
        ; call occurs [#||BTS_monitor_Iout_Vout||] ; [] |364| 
	.dwpsn	file "../bts_main.c",line 365,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_measValues_ch2|| ; [CPU_ARAU] |365| 
$C$DW$77	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$77, DW_AT_low_pc(0x00)
	.dwattr $C$DW$77, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$77, DW_AT_TI_call

        LCR       #||BTS_monitor_Iout_Vout|| ; [CPU_ALU] |365| 
        ; call occurs [#||BTS_monitor_Iout_Vout||] ; [] |365| 
	.dwpsn	file "../bts_main.c",line 366,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_measValues_ch3|| ; [CPU_ARAU] |366| 
$C$DW$78	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$78, DW_AT_low_pc(0x00)
	.dwattr $C$DW$78, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$78, DW_AT_TI_call

        LCR       #||BTS_monitor_Iout_Vout|| ; [CPU_ALU] |366| 
        ; call occurs [#||BTS_monitor_Iout_Vout||] ; [] |366| 
	.dwpsn	file "../bts_main.c",line 367,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_measValues_ch4|| ; [CPU_ARAU] |367| 
$C$DW$79	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$79, DW_AT_low_pc(0x00)
	.dwattr $C$DW$79, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$79, DW_AT_TI_call

        LCR       #||BTS_monitor_Iout_Vout|| ; [CPU_ALU] |367| 
        ; call occurs [#||BTS_monitor_Iout_Vout||] ; [] |367| 
        MOVW      DP,#||C_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 373,column 5,is_stmt,isa 0
        MOVL      XAR4,#||C2||          ; [CPU_ARAU] |373| 
        MOVL      @||C_Task_Ptr||,XAR4  ; [CPU_ALU] |373| 
$C$DW$80	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$80, DW_AT_low_pc(0x00)
	.dwattr $C$DW$80, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$75, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$75, DW_AT_TI_end_line(0x176)
	.dwattr $C$DW$75, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$75

	.sect	".text"
	.clink
	.global	||B1||

$C$DW$81	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$81, DW_AT_name("B1")
	.dwattr $C$DW$81, DW_AT_low_pc(||B1||)
	.dwattr $C$DW$81, DW_AT_high_pc(0x00)
	.dwattr $C$DW$81, DW_AT_linkage_name("B1")
	.dwattr $C$DW$81, DW_AT_external
	.dwattr $C$DW$81, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$81, DW_AT_decl_line(0x13e)
	.dwattr $C$DW$81, DW_AT_decl_column(0x06)
	.dwattr $C$DW$81, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 319,column 1,is_stmt,address ||B1||,isa 0

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
	.dwpsn	file "../bts_main.c",line 327,column 5,is_stmt,isa 0
        MOVL      XAR4,#||B2||          ; [CPU_ARAU] |327| 
        MOVW      DP,#||B_Task_Ptr||    ; [CPU_ARAU] 
        MOVL      @||B_Task_Ptr||,XAR4  ; [CPU_ALU] |327| 
$C$DW$82	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$82, DW_AT_low_pc(0x00)
	.dwattr $C$DW$82, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$81, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$81, DW_AT_TI_end_line(0x148)
	.dwattr $C$DW$81, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$81

	.sect	".text"
	.clink
	.global	||A1||

$C$DW$83	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$83, DW_AT_name("A1")
	.dwattr $C$DW$83, DW_AT_low_pc(||A1||)
	.dwattr $C$DW$83, DW_AT_high_pc(0x00)
	.dwattr $C$DW$83, DW_AT_linkage_name("A1")
	.dwattr $C$DW$83, DW_AT_external
	.dwattr $C$DW$83, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$83, DW_AT_decl_line(0x10d)
	.dwattr $C$DW$83, DW_AT_decl_column(0x06)
	.dwattr $C$DW$83, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 270,column 1,is_stmt,address ||A1||,isa 0

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
	.dwpsn	file "../bts_main.c",line 276,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_userInput_ch1|| ; [CPU_ARAU] |276| 
        MOVL      XAR5,#||BTS_ctrlLoopVariable_ch1|| ; [CPU_ARAU] |276| 
$C$DW$84	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$84, DW_AT_low_pc(0x00)
	.dwattr $C$DW$84, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$84, DW_AT_TI_call

        LCR       #||BTS_updateReference|| ; [CPU_ALU] |276| 
        ; call occurs [#||BTS_updateReference||] ; [] |276| 
	.dwpsn	file "../bts_main.c",line 277,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_userInput_ch2|| ; [CPU_ARAU] |277| 
        MOVL      XAR5,#||BTS_ctrlLoopVariable_ch2|| ; [CPU_ARAU] |277| 
$C$DW$85	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$85, DW_AT_low_pc(0x00)
	.dwattr $C$DW$85, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$85, DW_AT_TI_call

        LCR       #||BTS_updateReference|| ; [CPU_ALU] |277| 
        ; call occurs [#||BTS_updateReference||] ; [] |277| 
	.dwpsn	file "../bts_main.c",line 278,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_userInput_ch3|| ; [CPU_ARAU] |278| 
        MOVL      XAR5,#||BTS_ctrlLoopVariable_ch3|| ; [CPU_ARAU] |278| 
$C$DW$86	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$86, DW_AT_low_pc(0x00)
	.dwattr $C$DW$86, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$86, DW_AT_TI_call

        LCR       #||BTS_updateReference|| ; [CPU_ALU] |278| 
        ; call occurs [#||BTS_updateReference||] ; [] |278| 
	.dwpsn	file "../bts_main.c",line 279,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_userInput_ch4|| ; [CPU_ARAU] |279| 
        MOVL      XAR5,#||BTS_ctrlLoopVariable_ch4|| ; [CPU_ARAU] |279| 
$C$DW$87	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$87, DW_AT_low_pc(0x00)
	.dwattr $C$DW$87, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$87, DW_AT_TI_call

        LCR       #||BTS_updateReference|| ; [CPU_ALU] |279| 
        ; call occurs [#||BTS_updateReference||] ; [] |279| 
        MOVW      DP,#||A_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 284,column 5,is_stmt,isa 0
        MOVL      XAR4,#||A2||          ; [CPU_ARAU] |284| 
        MOVL      @||A_Task_Ptr||,XAR4  ; [CPU_ALU] |284| 
$C$DW$88	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$88, DW_AT_low_pc(0x00)
	.dwattr $C$DW$88, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$83, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$83, DW_AT_TI_end_line(0x11d)
	.dwattr $C$DW$83, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$83

	.sect	".text"
	.clink
	.global	||A0||

$C$DW$89	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$89, DW_AT_name("A0")
	.dwattr $C$DW$89, DW_AT_low_pc(||A0||)
	.dwattr $C$DW$89, DW_AT_high_pc(0x00)
	.dwattr $C$DW$89, DW_AT_linkage_name("A0")
	.dwattr $C$DW$89, DW_AT_external
	.dwattr $C$DW$89, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$89, DW_AT_decl_line(0xcd)
	.dwattr $C$DW$89, DW_AT_decl_column(0x06)
	.dwattr $C$DW$89, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 206,column 1,is_stmt,address ||A0||,isa 0

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
	.dwpsn	file "../bts_main.c",line 210,column 5,is_stmt,isa 0
        CMPB      AL,#1                 ; [CPU_ALU] |210| 
        B         ||$C$L1||,NEQ         ; [CPU_ALU] |210| 
        ; branchcc occurs ; [] |210| 
        MOVW      DP,#||A_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 169,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c04)        ; [CPU_ALU] |169| 
	.dwpsn	file "../bts_main.c",line 217,column 9,is_stmt,isa 0
        MOVL      XAR7,@||A_Task_Ptr||  ; [CPU_ALU] |217| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 169,column 5,is_stmt,isa 0
        OR        AL,#0x8000            ; [CPU_ALU] |169| 
        MOV       *(0:0x0c04),AL        ; [CPU_ALU] |169| 
	.dwpsn	file "../bts_main.c",line 217,column 9,is_stmt,isa 0
$C$DW$90	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$90, DW_AT_low_pc(0x00)
	.dwattr $C$DW$90, DW_AT_TI_call
	.dwattr $C$DW$90, DW_AT_TI_indirect

        LCR       *XAR7                 ; [CPU_ALU] |217| 
        ; call occurs [XAR7] ; [] |217| 
        MOVW      DP,#||vTimer0||       ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 219,column 9,is_stmt,isa 0
        INC       @||vTimer0||          ; [CPU_ALU] |219| 
||$C$L1||:    
	.dwpsn	file "../bts_main.c",line 221,column 5,is_stmt,isa 0
        MOVL      XAR4,#||B0||          ; [CPU_ARAU] |221| 
        MOVW      DP,#||Alpha_State_Ptr|| ; [CPU_ARAU] 
        MOVL      @||Alpha_State_Ptr||,XAR4 ; [CPU_ALU] |221| 
$C$DW$91	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$91, DW_AT_low_pc(0x00)
	.dwattr $C$DW$91, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$89, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$89, DW_AT_TI_end_line(0xde)
	.dwattr $C$DW$89, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$89

	.sect	".text"
	.clink
	.global	||B0||

$C$DW$92	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$92, DW_AT_name("B0")
	.dwattr $C$DW$92, DW_AT_low_pc(||B0||)
	.dwattr $C$DW$92, DW_AT_high_pc(0x00)
	.dwattr $C$DW$92, DW_AT_linkage_name("B0")
	.dwattr $C$DW$92, DW_AT_external
	.dwattr $C$DW$92, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$92, DW_AT_decl_line(0xe0)
	.dwattr $C$DW$92, DW_AT_decl_column(0x06)
	.dwattr $C$DW$92, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 225,column 1,is_stmt,address ||B0||,isa 0

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
	.dwpsn	file "../bts_main.c",line 229,column 5,is_stmt,isa 0
        CMPB      AL,#1                 ; [CPU_ALU] |229| 
        B         ||$C$L2||,NEQ         ; [CPU_ALU] |229| 
        ; branchcc occurs ; [] |229| 
        MOVW      DP,#||B_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 169,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c0c)        ; [CPU_ALU] |169| 
	.dwpsn	file "../bts_main.c",line 236,column 9,is_stmt,isa 0
        MOVL      XAR7,@||B_Task_Ptr||  ; [CPU_ALU] |236| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 169,column 5,is_stmt,isa 0
        OR        AL,#0x8000            ; [CPU_ALU] |169| 
        MOV       *(0:0x0c0c),AL        ; [CPU_ALU] |169| 
	.dwpsn	file "../bts_main.c",line 236,column 9,is_stmt,isa 0
$C$DW$93	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$93, DW_AT_low_pc(0x00)
	.dwattr $C$DW$93, DW_AT_TI_call
	.dwattr $C$DW$93, DW_AT_TI_indirect

        LCR       *XAR7                 ; [CPU_ALU] |236| 
        ; call occurs [XAR7] ; [] |236| 
        MOVW      DP,#||vTimer1||       ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 238,column 9,is_stmt,isa 0
        INC       @||vTimer1||          ; [CPU_ALU] |238| 
||$C$L2||:    
	.dwpsn	file "../bts_main.c",line 241,column 5,is_stmt,isa 0
        MOVL      XAR4,#||C0||          ; [CPU_ARAU] |241| 
        MOVW      DP,#||Alpha_State_Ptr|| ; [CPU_ARAU] 
        MOVL      @||Alpha_State_Ptr||,XAR4 ; [CPU_ALU] |241| 
$C$DW$94	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$94, DW_AT_low_pc(0x00)
	.dwattr $C$DW$94, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$92, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$92, DW_AT_TI_end_line(0xf2)
	.dwattr $C$DW$92, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$92

	.sect	".text"
	.clink
	.global	||C0||

$C$DW$95	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$95, DW_AT_name("C0")
	.dwattr $C$DW$95, DW_AT_low_pc(||C0||)
	.dwattr $C$DW$95, DW_AT_high_pc(0x00)
	.dwattr $C$DW$95, DW_AT_linkage_name("C0")
	.dwattr $C$DW$95, DW_AT_external
	.dwattr $C$DW$95, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$95, DW_AT_decl_line(0xf4)
	.dwattr $C$DW$95, DW_AT_decl_column(0x06)
	.dwattr $C$DW$95, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts_main.c",line 245,column 1,is_stmt,address ||C0||,isa 0

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
	.dwpsn	file "../bts_main.c",line 249,column 5,is_stmt,isa 0
        CMPB      AL,#1                 ; [CPU_ALU] |249| 
        B         ||$C$L3||,NEQ         ; [CPU_ALU] |249| 
        ; branchcc occurs ; [] |249| 
        MOVW      DP,#||C_Task_Ptr||    ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 169,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x0c14)        ; [CPU_ALU] |169| 
	.dwpsn	file "../bts_main.c",line 256,column 9,is_stmt,isa 0
        MOVL      XAR7,@||C_Task_Ptr||  ; [CPU_ALU] |256| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/cputimer.h",line 169,column 5,is_stmt,isa 0
        OR        AL,#0x8000            ; [CPU_ALU] |169| 
        MOV       *(0:0x0c14),AL        ; [CPU_ALU] |169| 
	.dwpsn	file "../bts_main.c",line 256,column 9,is_stmt,isa 0
$C$DW$96	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$96, DW_AT_low_pc(0x00)
	.dwattr $C$DW$96, DW_AT_TI_call
	.dwattr $C$DW$96, DW_AT_TI_indirect

        LCR       *XAR7                 ; [CPU_ALU] |256| 
        ; call occurs [XAR7] ; [] |256| 
        MOVW      DP,#||vTimer2||       ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 258,column 9,is_stmt,isa 0
        INC       @||vTimer2||          ; [CPU_ALU] |258| 
||$C$L3||:    
	.dwpsn	file "../bts_main.c",line 261,column 5,is_stmt,isa 0
        MOVL      XAR4,#||A0||          ; [CPU_ARAU] |261| 
        MOVW      DP,#||Alpha_State_Ptr|| ; [CPU_ARAU] 
        MOVL      @||Alpha_State_Ptr||,XAR4 ; [CPU_ALU] |261| 
$C$DW$97	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$97, DW_AT_low_pc(0x00)
	.dwattr $C$DW$97, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$95, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$95, DW_AT_TI_end_line(0x106)
	.dwattr $C$DW$95, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$95

	.sect	".text"
	.clink
	.global	||main||

$C$DW$98	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$98, DW_AT_name("main")
	.dwattr $C$DW$98, DW_AT_low_pc(||main||)
	.dwattr $C$DW$98, DW_AT_high_pc(0x00)
	.dwattr $C$DW$98, DW_AT_linkage_name("main")
	.dwattr $C$DW$98, DW_AT_external
	.dwattr $C$DW$98, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$98, DW_AT_decl_line(0x4b)
	.dwattr $C$DW$98, DW_AT_decl_column(0x06)
	.dwattr $C$DW$98, DW_AT_TI_max_frame_size(-2)
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
$C$DW$99	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$99, DW_AT_low_pc(0x00)
	.dwattr $C$DW$99, DW_AT_name("BTS_HAL_setupDevice")
	.dwattr $C$DW$99, DW_AT_TI_call

        LCR       #||BTS_HAL_setupDevice|| ; [CPU_ALU] |82| 
        ; call occurs [#||BTS_HAL_setupDevice||] ; [] |82| 
	.dwpsn	file "../bts_main.c",line 90,column 5,is_stmt,isa 0
$C$DW$100	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$100, DW_AT_low_pc(0x00)
	.dwattr $C$DW$100, DW_AT_name("BTS_HAL_setupSyncBuckPinsGpio")
	.dwattr $C$DW$100, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPinsGpio|| ; [CPU_ALU] |90| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPinsGpio||] ; [] |90| 
        MOVW      DP,#||Alpha_State_Ptr|| ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 95,column 5,is_stmt,isa 0
        MOVL      XAR7,#||A0||          ; [CPU_ARAU] |95| 
	.dwpsn	file "../bts_main.c",line 96,column 5,is_stmt,isa 0
        MOVL      XAR6,#||A1||          ; [CPU_ARAU] |96| 
	.dwpsn	file "../bts_main.c",line 97,column 5,is_stmt,isa 0
        MOVL      XAR5,#||B1||          ; [CPU_ARAU] |97| 
	.dwpsn	file "../bts_main.c",line 98,column 5,is_stmt,isa 0
        MOVL      XAR4,#||C1||          ; [CPU_ARAU] |98| 
	.dwpsn	file "../bts_main.c",line 95,column 5,is_stmt,isa 0
        MOVL      @||Alpha_State_Ptr||,XAR7 ; [CPU_ALU] |95| 
	.dwpsn	file "../bts_main.c",line 96,column 5,is_stmt,isa 0
        MOVL      @||A_Task_Ptr||,XAR6  ; [CPU_ALU] |96| 
	.dwpsn	file "../bts_main.c",line 97,column 5,is_stmt,isa 0
        MOVL      @||B_Task_Ptr||,XAR5  ; [CPU_ALU] |97| 
	.dwpsn	file "../bts_main.c",line 98,column 5,is_stmt,isa 0
        MOVL      @||C_Task_Ptr||,XAR4  ; [CPU_ALU] |98| 
	.dwpsn	file "../bts_main.c",line 103,column 5,is_stmt,isa 0
$C$DW$101	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$101, DW_AT_low_pc(0x00)
	.dwattr $C$DW$101, DW_AT_name("BTS_HAL_disableEpwmCounting")
	.dwattr $C$DW$101, DW_AT_TI_call

        LCR       #||BTS_HAL_disableEpwmCounting|| ; [CPU_ALU] |103| 
        ; call occurs [#||BTS_HAL_disableEpwmCounting||] ; [] |103| 
	.dwpsn	file "../bts_main.c",line 110,column 5,is_stmt,isa 0
        MOVL      XAR4,#16384           ; [CPU_ARAU] |110| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |110| 
$C$DW$102	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$102, DW_AT_low_pc(0x00)
	.dwattr $C$DW$102, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$102, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPwm|| ; [CPU_ALU] |110| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPwm||] ; [] |110| 
	.dwpsn	file "../bts_main.c",line 111,column 5,is_stmt,isa 0
        MOVL      XAR4,#16640           ; [CPU_ARAU] |111| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |111| 
$C$DW$103	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$103, DW_AT_low_pc(0x00)
	.dwattr $C$DW$103, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$103, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPwm|| ; [CPU_ALU] |111| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPwm||] ; [] |111| 
	.dwpsn	file "../bts_main.c",line 112,column 5,is_stmt,isa 0
        MOVL      XAR4,#16896           ; [CPU_ARAU] |112| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |112| 
$C$DW$104	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$104, DW_AT_low_pc(0x00)
	.dwattr $C$DW$104, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$104, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPwm|| ; [CPU_ALU] |112| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPwm||] ; [] |112| 
	.dwpsn	file "../bts_main.c",line 113,column 5,is_stmt,isa 0
        MOVL      XAR4,#17152           ; [CPU_ARAU] |113| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |113| 
$C$DW$105	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$105, DW_AT_low_pc(0x00)
	.dwattr $C$DW$105, DW_AT_name("BTS_HAL_setupSyncBuckPwm")
	.dwattr $C$DW$105, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPwm|| ; [CPU_ALU] |113| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPwm||] ; [] |113| 
	.dwpsn	file "../bts_main.c",line 114,column 5,is_stmt,isa 0
$C$DW$106	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$106, DW_AT_low_pc(0x00)
	.dwattr $C$DW$106, DW_AT_name("BTS_setupHrpwmMepScaleFactor")
	.dwattr $C$DW$106, DW_AT_TI_call

        LCR       #||BTS_setupHrpwmMepScaleFactor|| ; [CPU_ALU] |114| 
        ; call occurs [#||BTS_setupHrpwmMepScaleFactor||] ; [] |114| 
	.dwpsn	file "../bts_main.c",line 120,column 5,is_stmt,isa 0
$C$DW$107	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$107, DW_AT_low_pc(0x00)
	.dwattr $C$DW$107, DW_AT_name("BTS_HAL_SetupSpiPinsGpio")
	.dwattr $C$DW$107, DW_AT_TI_call

        LCR       #||BTS_HAL_SetupSpiPinsGpio|| ; [CPU_ALU] |120| 
        ; call occurs [#||BTS_HAL_SetupSpiPinsGpio||] ; [] |120| 
	.dwpsn	file "../bts_main.c",line 121,column 5,is_stmt,isa 0
$C$DW$108	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$108, DW_AT_low_pc(0x00)
	.dwattr $C$DW$108, DW_AT_name("BTS_HAL_SetupSpi")
	.dwattr $C$DW$108, DW_AT_TI_call

        LCR       #||BTS_HAL_SetupSpi|| ; [CPU_ALU] |121| 
        ; call occurs [#||BTS_HAL_SetupSpi||] ; [] |121| 
	.dwpsn	file "../bts_main.c",line 123,column 5,is_stmt,isa 0
$C$DW$109	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$109, DW_AT_low_pc(0x00)
	.dwattr $C$DW$109, DW_AT_name("BTS_HAL_setupExAdcGpio")
	.dwattr $C$DW$109, DW_AT_TI_call

        LCR       #||BTS_HAL_setupExAdcGpio|| ; [CPU_ALU] |123| 
        ; call occurs [#||BTS_HAL_setupExAdcGpio||] ; [] |123| 
	.dwpsn	file "../bts_main.c",line 124,column 5,is_stmt,isa 0
$C$DW$110	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$110, DW_AT_low_pc(0x00)
	.dwattr $C$DW$110, DW_AT_name("BTS_HAL_setupExAdc")
	.dwattr $C$DW$110, DW_AT_TI_call

        LCR       #||BTS_HAL_setupExAdc|| ; [CPU_ALU] |124| 
        ; call occurs [#||BTS_HAL_setupExAdc||] ; [] |124| 
	.dwpsn	file "../bts_main.c",line 131,column 5,is_stmt,isa 0
$C$DW$111	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$111, DW_AT_low_pc(0x00)
	.dwattr $C$DW$111, DW_AT_name("BTS_initUserVariables")
	.dwattr $C$DW$111, DW_AT_TI_call

        LCR       #||BTS_initUserVariables|| ; [CPU_ALU] |131| 
        ; call occurs [#||BTS_initUserVariables||] ; [] |131| 
	.dwpsn	file "../bts_main.c",line 132,column 5,is_stmt,isa 0
$C$DW$112	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$112, DW_AT_low_pc(0x00)
	.dwattr $C$DW$112, DW_AT_name("BTS_initProgramVariables")
	.dwattr $C$DW$112, DW_AT_TI_call

        LCR       #||BTS_initProgramVariables|| ; [CPU_ALU] |132| 
        ; call occurs [#||BTS_initProgramVariables||] ; [] |132| 
	.dwpsn	file "../bts_main.c",line 133,column 5,is_stmt,isa 0
$C$DW$113	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$113, DW_AT_low_pc(0x00)
	.dwattr $C$DW$113, DW_AT_name("BTS_initController")
	.dwattr $C$DW$113, DW_AT_TI_call

        LCR       #||BTS_initController|| ; [CPU_ALU] |133| 
        ; call occurs [#||BTS_initController||] ; [] |133| 
	.dwpsn	file "../bts_main.c",line 138,column 5,is_stmt,isa 0
$C$DW$114	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$114, DW_AT_low_pc(0x00)
	.dwattr $C$DW$114, DW_AT_name("BTS_setupSfra")
	.dwattr $C$DW$114, DW_AT_TI_call

        LCR       #||BTS_setupSfra||    ; [CPU_ALU] |138| 
        ; call occurs [#||BTS_setupSfra||] ; [] |138| 
	.dwpsn	file "../bts_main.c",line 139,column 5,is_stmt,isa 0
$C$DW$115	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$115, DW_AT_low_pc(0x00)
	.dwattr $C$DW$115, DW_AT_name("BTS_setupSfraGui")
	.dwattr $C$DW$115, DW_AT_TI_call

        LCR       #||BTS_setupSfraGui|| ; [CPU_ALU] |139| 
        ; call occurs [#||BTS_setupSfraGui||] ; [] |139| 
	.dwpsn	file "../bts_main.c",line 144,column 5,is_stmt,isa 0
$C$DW$116	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$116, DW_AT_low_pc(0x00)
	.dwattr $C$DW$116, DW_AT_name("BTS_HAL_setupInterruptTrigger")
	.dwattr $C$DW$116, DW_AT_TI_call

        LCR       #||BTS_HAL_setupInterruptTrigger|| ; [CPU_ALU] |144| 
        ; call occurs [#||BTS_HAL_setupInterruptTrigger||] ; [] |144| 
	.dwpsn	file "../bts_main.c",line 145,column 5,is_stmt,isa 0
$C$DW$117	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$117, DW_AT_low_pc(0x00)
	.dwattr $C$DW$117, DW_AT_name("BTS_HAL_setupInterrupt")
	.dwattr $C$DW$117, DW_AT_TI_call

        LCR       #||BTS_HAL_setupInterrupt|| ; [CPU_ALU] |145| 
        ; call occurs [#||BTS_HAL_setupInterrupt||] ; [] |145| 
	.dwpsn	file "../bts_main.c",line 150,column 5,is_stmt,isa 0
$C$DW$118	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$118, DW_AT_low_pc(0x00)
	.dwattr $C$DW$118, DW_AT_name("BTS_HAL_enableEpwmCounting")
	.dwattr $C$DW$118, DW_AT_TI_call

        LCR       #||BTS_HAL_enableEpwmCounting|| ; [CPU_ALU] |150| 
        ; call occurs [#||BTS_HAL_enableEpwmCounting||] ; [] |150| 
	.dwpsn	file "../bts_main.c",line 155,column 5,is_stmt,isa 0
$C$DW$119	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$119, DW_AT_low_pc(0x00)
	.dwattr $C$DW$119, DW_AT_name("BTS_HAL_setupSyncBuckPinsEpwm")
	.dwattr $C$DW$119, DW_AT_TI_call

        LCR       #||BTS_HAL_setupSyncBuckPinsEpwm|| ; [CPU_ALU] |155| 
        ; call occurs [#||BTS_HAL_setupSyncBuckPinsEpwm||] ; [] |155| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 115,column 5,is_stmt,isa 0
        MOV       ACC,#0                ; [CPU_ALU] |115| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 119,column 8,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |119| 
        MOVB      XAR7,#0               ; [CPU_ALU] |119| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 112,column 5,is_stmt,isa 0
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |112| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 115,column 5,is_stmt,isa 0
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |115| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 119,column 8,is_stmt,isa 0
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AR6       ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AR7       ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AR6       ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |119| 
||$C$L4||:    
        MOVW      DP,#||Alpha_State_Ptr|| ; [CPU_ARAU] 
	.dwpsn	file "../bts_main.c",line 168,column 9,is_stmt,isa 0
        MOVL      XAR7,@||Alpha_State_Ptr|| ; [CPU_ALU] |168| 
$C$DW$120	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$120, DW_AT_low_pc(0x00)
	.dwattr $C$DW$120, DW_AT_TI_call
	.dwattr $C$DW$120, DW_AT_TI_indirect

        LCR       *XAR7                 ; [CPU_ALU] |168| 
        ; call occurs [XAR7] ; [] |168| 
	.dwpsn	file "../bts_main.c",line 169,column 5,is_stmt,isa 0
        B         ||$C$L4||,UNC         ; [CPU_ALU] |169| 
        ; branch occurs ; [] |169| 
	.dwattr $C$DW$98, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$98, DW_AT_TI_end_line(0xaa)
	.dwattr $C$DW$98, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$98

	.sect	".text:__signbitl"
	.clink
	.global	||__signbitl||

$C$DW$121	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$121, DW_AT_name("__signbitl")
	.dwattr $C$DW$121, DW_AT_low_pc(||__signbitl||)
	.dwattr $C$DW$121, DW_AT_high_pc(0x00)
	.dwattr $C$DW$121, DW_AT_linkage_name("__signbitl")
	.dwattr $C$DW$121, DW_AT_external
	.dwattr $C$DW$121, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$121, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$121, DW_AT_decl_line(0x16f)
	.dwattr $C$DW$121, DW_AT_decl_column(0x25)
	.dwattr $C$DW$121, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 368,column 1,is_stmt,address ||__signbitl||,isa 0

	.dwfde $C$DW$CIE, ||__signbitl||
$C$DW$122	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$122, DW_AT_name("e")
	.dwattr $C$DW$122, DW_AT_type(*$C$DW$T$131)
	.dwattr $C$DW$122, DW_AT_location[DW_OP_reg12]


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
$C$DW$123	.dwtag  DW_TAG_variable
	.dwattr $C$DW$123, DW_AT_name("e")
	.dwattr $C$DW$123, DW_AT_type(*$C$DW$T$132)
	.dwattr $C$DW$123, DW_AT_location[DW_OP_reg12]

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
$C$DW$124	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$124, DW_AT_low_pc(0x00)
	.dwattr $C$DW$124, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$124, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |368| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |368| 
        MOVB      AH,#0                 ; [CPU_ALU] |368| 
        CMPB      AL,#0                 ; [CPU_ALU] |368| 
        MOVB      AH,#1,NEQ             ; [CPU_ALU] |368| 
        MOV       AL,AH                 ; [CPU_ALU] |368| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$125	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$125, DW_AT_low_pc(0x00)
	.dwattr $C$DW$125, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$121, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$121, DW_AT_TI_end_line(0x170)
	.dwattr $C$DW$121, DW_AT_TI_end_column(0x2b)
	.dwendentry
	.dwendtag $C$DW$121

	.sect	".text:__signbitf"
	.clink
	.global	||__signbitf||

$C$DW$126	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$126, DW_AT_name("__signbitf")
	.dwattr $C$DW$126, DW_AT_low_pc(||__signbitf||)
	.dwattr $C$DW$126, DW_AT_high_pc(0x00)
	.dwattr $C$DW$126, DW_AT_linkage_name("__signbitf")
	.dwattr $C$DW$126, DW_AT_external
	.dwattr $C$DW$126, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$126, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$126, DW_AT_decl_line(0x16d)
	.dwattr $C$DW$126, DW_AT_decl_column(0x25)
	.dwattr $C$DW$126, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 366,column 1,is_stmt,address ||__signbitf||,isa 0

	.dwfde $C$DW$CIE, ||__signbitf||
$C$DW$127	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$127, DW_AT_name("f")
	.dwattr $C$DW$127, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$127, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$128	.dwtag  DW_TAG_variable
	.dwattr $C$DW$128, DW_AT_name("f")
	.dwattr $C$DW$128, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$128, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$129	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$129, DW_AT_low_pc(0x00)
	.dwattr $C$DW$129, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$126, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$126, DW_AT_TI_end_line(0x16e)
	.dwattr $C$DW$126, DW_AT_TI_end_column(0x29)
	.dwendentry
	.dwendtag $C$DW$126

	.sect	".text:__signbit"
	.clink
	.global	||__signbit||

$C$DW$130	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$130, DW_AT_name("__signbit")
	.dwattr $C$DW$130, DW_AT_low_pc(||__signbit||)
	.dwattr $C$DW$130, DW_AT_high_pc(0x00)
	.dwattr $C$DW$130, DW_AT_linkage_name("__signbit")
	.dwattr $C$DW$130, DW_AT_external
	.dwattr $C$DW$130, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$130, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$130, DW_AT_decl_line(0x16b)
	.dwattr $C$DW$130, DW_AT_decl_column(0x25)
	.dwattr $C$DW$130, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 364,column 1,is_stmt,address ||__signbit||,isa 0

	.dwfde $C$DW$CIE, ||__signbit||
$C$DW$131	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$131, DW_AT_name("d")
	.dwattr $C$DW$131, DW_AT_type(*$C$DW$T$128)
	.dwattr $C$DW$131, DW_AT_location[DW_OP_reg12]


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
$C$DW$132	.dwtag  DW_TAG_variable
	.dwattr $C$DW$132, DW_AT_name("d")
	.dwattr $C$DW$132, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$132, DW_AT_location[DW_OP_reg12]

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
$C$DW$133	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$133, DW_AT_low_pc(0x00)
	.dwattr $C$DW$133, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$133, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |364| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |364| 
        MOVB      AH,#0                 ; [CPU_ALU] |364| 
        CMPB      AL,#0                 ; [CPU_ALU] |364| 
        MOVB      AH,#1,NEQ             ; [CPU_ALU] |364| 
        MOV       AL,AH                 ; [CPU_ALU] |364| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$134	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$134, DW_AT_low_pc(0x00)
	.dwattr $C$DW$134, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$130, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$130, DW_AT_TI_end_line(0x16c)
	.dwattr $C$DW$130, DW_AT_TI_end_column(0x2a)
	.dwendentry
	.dwendtag $C$DW$130

	.sect	".text:__relaxed_sqrtf"
	.clink
	.global	||__relaxed_sqrtf||

$C$DW$135	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$135, DW_AT_name("__relaxed_sqrtf")
	.dwattr $C$DW$135, DW_AT_low_pc(||__relaxed_sqrtf||)
	.dwattr $C$DW$135, DW_AT_high_pc(0x00)
	.dwattr $C$DW$135, DW_AT_linkage_name("__relaxed_sqrtf")
	.dwattr $C$DW$135, DW_AT_external
	.dwattr $C$DW$135, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$135, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$135, DW_AT_decl_line(0xe4)
	.dwattr $C$DW$135, DW_AT_decl_column(0x10)
	.dwattr $C$DW$135, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 229,column 1,is_stmt,address ||__relaxed_sqrtf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_sqrtf||
$C$DW$136	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$136, DW_AT_name("x")
	.dwattr $C$DW$136, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$136, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$137	.dwtag  DW_TAG_variable
	.dwattr $C$DW$137, DW_AT_name("x")
	.dwattr $C$DW$137, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$137, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 230,column 5,is_stmt,isa 0
        SQRTF32   R0H,R0H               ; [CPU_FPU] |230| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$138	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$138, DW_AT_low_pc(0x00)
	.dwattr $C$DW$138, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$135, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$135, DW_AT_TI_end_line(0xe7)
	.dwattr $C$DW$135, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$135

	.sect	".text:__relaxed_sinf"
	.clink
	.global	||__relaxed_sinf||

$C$DW$139	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$139, DW_AT_name("__relaxed_sinf")
	.dwattr $C$DW$139, DW_AT_low_pc(||__relaxed_sinf||)
	.dwattr $C$DW$139, DW_AT_high_pc(0x00)
	.dwattr $C$DW$139, DW_AT_linkage_name("__relaxed_sinf")
	.dwattr $C$DW$139, DW_AT_external
	.dwattr $C$DW$139, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$139, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$139, DW_AT_decl_line(0xe9)
	.dwattr $C$DW$139, DW_AT_decl_column(0x10)
	.dwattr $C$DW$139, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 234,column 1,is_stmt,address ||__relaxed_sinf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_sinf||
$C$DW$140	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$140, DW_AT_name("x")
	.dwattr $C$DW$140, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$140, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$141	.dwtag  DW_TAG_variable
	.dwattr $C$DW$141, DW_AT_name("x")
	.dwattr $C$DW$141, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$141, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 235,column 5,is_stmt,isa 0
        DIV2PIF32 R0H,R0H               ; [CPU_FPU] |235| 
        NOP       ; [CPU_ALU] 
        SINPUF32  R0H,R0H               ; [CPU_FPU] |235| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$142	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$142, DW_AT_low_pc(0x00)
	.dwattr $C$DW$142, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$139, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$139, DW_AT_TI_end_line(0xec)
	.dwattr $C$DW$139, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$139

	.sect	".text:__relaxed_cosf"
	.clink
	.global	||__relaxed_cosf||

$C$DW$143	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$143, DW_AT_name("__relaxed_cosf")
	.dwattr $C$DW$143, DW_AT_low_pc(||__relaxed_cosf||)
	.dwattr $C$DW$143, DW_AT_high_pc(0x00)
	.dwattr $C$DW$143, DW_AT_linkage_name("__relaxed_cosf")
	.dwattr $C$DW$143, DW_AT_external
	.dwattr $C$DW$143, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$143, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$143, DW_AT_decl_line(0xee)
	.dwattr $C$DW$143, DW_AT_decl_column(0x10)
	.dwattr $C$DW$143, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 239,column 1,is_stmt,address ||__relaxed_cosf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_cosf||
$C$DW$144	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$144, DW_AT_name("x")
	.dwattr $C$DW$144, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$144, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$145	.dwtag  DW_TAG_variable
	.dwattr $C$DW$145, DW_AT_name("x")
	.dwattr $C$DW$145, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$145, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 240,column 5,is_stmt,isa 0
        DIV2PIF32 R0H,R0H               ; [CPU_FPU] |240| 
        NOP       ; [CPU_ALU] 
        COSPUF32  R0H,R0H               ; [CPU_FPU] |240| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$146	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$146, DW_AT_low_pc(0x00)
	.dwattr $C$DW$146, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$143, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$143, DW_AT_TI_end_line(0xf1)
	.dwattr $C$DW$143, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$143

	.sect	".text:__relaxed_atanf"
	.clink
	.global	||__relaxed_atanf||

$C$DW$147	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$147, DW_AT_name("__relaxed_atanf")
	.dwattr $C$DW$147, DW_AT_low_pc(||__relaxed_atanf||)
	.dwattr $C$DW$147, DW_AT_high_pc(0x00)
	.dwattr $C$DW$147, DW_AT_linkage_name("__relaxed_atanf")
	.dwattr $C$DW$147, DW_AT_external
	.dwattr $C$DW$147, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$147, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$147, DW_AT_decl_line(0xf3)
	.dwattr $C$DW$147, DW_AT_decl_column(0x10)
	.dwattr $C$DW$147, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 244,column 1,is_stmt,address ||__relaxed_atanf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_atanf||
$C$DW$148	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$148, DW_AT_name("x")
	.dwattr $C$DW$148, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$148, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$149	.dwtag  DW_TAG_variable
	.dwattr $C$DW$149, DW_AT_name("x")
	.dwattr $C$DW$149, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$149, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$150	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$150, DW_AT_low_pc(0x00)
	.dwattr $C$DW$150, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$147, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$147, DW_AT_TI_end_line(0xf6)
	.dwattr $C$DW$147, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$147

	.sect	".text:__relaxed_atan2f"
	.clink
	.global	||__relaxed_atan2f||

$C$DW$151	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$151, DW_AT_name("__relaxed_atan2f")
	.dwattr $C$DW$151, DW_AT_low_pc(||__relaxed_atan2f||)
	.dwattr $C$DW$151, DW_AT_high_pc(0x00)
	.dwattr $C$DW$151, DW_AT_linkage_name("__relaxed_atan2f")
	.dwattr $C$DW$151, DW_AT_external
	.dwattr $C$DW$151, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$151, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$151, DW_AT_decl_line(0xf8)
	.dwattr $C$DW$151, DW_AT_decl_column(0x10)
	.dwattr $C$DW$151, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 249,column 1,is_stmt,address ||__relaxed_atan2f||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_atan2f||
$C$DW$152	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$152, DW_AT_name("y")
	.dwattr $C$DW$152, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$152, DW_AT_location[DW_OP_regx 0x2b]

$C$DW$153	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$153, DW_AT_name("x")
	.dwattr $C$DW$153, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$153, DW_AT_location[DW_OP_regx 0x2f]


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
$C$DW$154	.dwtag  DW_TAG_variable
	.dwattr $C$DW$154, DW_AT_name("y")
	.dwattr $C$DW$154, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$154, DW_AT_location[DW_OP_regx 0x2b]

;* R1    assigned to x
$C$DW$155	.dwtag  DW_TAG_variable
	.dwattr $C$DW$155, DW_AT_name("x")
	.dwattr $C$DW$155, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$155, DW_AT_location[DW_OP_regx 0x2f]

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
$C$DW$156	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$156, DW_AT_low_pc(0x00)
	.dwattr $C$DW$156, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$151, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$151, DW_AT_TI_end_line(0xfb)
	.dwattr $C$DW$151, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$151

	.sect	".text:__isnormall"
	.clink
	.global	||__isnormall||

$C$DW$157	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$157, DW_AT_name("__isnormall")
	.dwattr $C$DW$157, DW_AT_low_pc(||__isnormall||)
	.dwattr $C$DW$157, DW_AT_high_pc(0x00)
	.dwattr $C$DW$157, DW_AT_linkage_name("__isnormall")
	.dwattr $C$DW$157, DW_AT_external
	.dwattr $C$DW$157, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$157, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$157, DW_AT_decl_line(0x167)
	.dwattr $C$DW$157, DW_AT_decl_column(0x25)
	.dwattr $C$DW$157, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 360,column 1,is_stmt,address ||__isnormall||,isa 0

	.dwfde $C$DW$CIE, ||__isnormall||
$C$DW$158	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$158, DW_AT_name("e")
	.dwattr $C$DW$158, DW_AT_type(*$C$DW$T$131)
	.dwattr $C$DW$158, DW_AT_location[DW_OP_reg12]


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
$C$DW$159	.dwtag  DW_TAG_variable
	.dwattr $C$DW$159, DW_AT_name("e")
	.dwattr $C$DW$159, DW_AT_type(*$C$DW$T$132)
	.dwattr $C$DW$159, DW_AT_location[DW_OP_reg12]

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
$C$DW$160	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$160, DW_AT_low_pc(0x00)
	.dwattr $C$DW$160, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$160, DW_AT_TI_call

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
$C$DW$161	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$161, DW_AT_low_pc(0x00)
	.dwattr $C$DW$161, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$157, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$157, DW_AT_TI_end_line(0x169)
	.dwattr $C$DW$157, DW_AT_TI_end_column(0x31)
	.dwendentry
	.dwendtag $C$DW$157

	.sect	".text:__isnormalf"
	.clink
	.global	||__isnormalf||

$C$DW$162	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$162, DW_AT_name("__isnormalf")
	.dwattr $C$DW$162, DW_AT_low_pc(||__isnormalf||)
	.dwattr $C$DW$162, DW_AT_high_pc(0x00)
	.dwattr $C$DW$162, DW_AT_linkage_name("__isnormalf")
	.dwattr $C$DW$162, DW_AT_external
	.dwattr $C$DW$162, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$162, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$162, DW_AT_decl_line(0x163)
	.dwattr $C$DW$162, DW_AT_decl_column(0x25)
	.dwattr $C$DW$162, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 356,column 1,is_stmt,address ||__isnormalf||,isa 0

	.dwfde $C$DW$CIE, ||__isnormalf||
$C$DW$163	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$163, DW_AT_name("f")
	.dwattr $C$DW$163, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$163, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$164	.dwtag  DW_TAG_variable
	.dwattr $C$DW$164, DW_AT_name("f")
	.dwattr $C$DW$164, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$164, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$165	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$165, DW_AT_low_pc(0x00)
	.dwattr $C$DW$165, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$162, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$162, DW_AT_TI_end_line(0x165)
	.dwattr $C$DW$162, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$162

	.sect	".text:__isnormal"
	.clink
	.global	||__isnormal||

$C$DW$166	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$166, DW_AT_name("__isnormal")
	.dwattr $C$DW$166, DW_AT_low_pc(||__isnormal||)
	.dwattr $C$DW$166, DW_AT_high_pc(0x00)
	.dwattr $C$DW$166, DW_AT_linkage_name("__isnormal")
	.dwattr $C$DW$166, DW_AT_external
	.dwattr $C$DW$166, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$166, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$166, DW_AT_decl_line(0x15f)
	.dwattr $C$DW$166, DW_AT_decl_column(0x25)
	.dwattr $C$DW$166, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 352,column 1,is_stmt,address ||__isnormal||,isa 0

	.dwfde $C$DW$CIE, ||__isnormal||
$C$DW$167	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$167, DW_AT_name("d")
	.dwattr $C$DW$167, DW_AT_type(*$C$DW$T$128)
	.dwattr $C$DW$167, DW_AT_location[DW_OP_reg12]


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
$C$DW$168	.dwtag  DW_TAG_variable
	.dwattr $C$DW$168, DW_AT_name("d")
	.dwattr $C$DW$168, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$168, DW_AT_location[DW_OP_reg12]

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
$C$DW$169	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$169, DW_AT_low_pc(0x00)
	.dwattr $C$DW$169, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$169, DW_AT_TI_call

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
$C$DW$170	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$170, DW_AT_low_pc(0x00)
	.dwattr $C$DW$170, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$166, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$166, DW_AT_TI_end_line(0x161)
	.dwattr $C$DW$166, DW_AT_TI_end_column(0x30)
	.dwendentry
	.dwendtag $C$DW$166

	.sect	".text:__isnanl"
	.clink
	.global	||__isnanl||

$C$DW$171	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$171, DW_AT_name("__isnanl")
	.dwattr $C$DW$171, DW_AT_low_pc(||__isnanl||)
	.dwattr $C$DW$171, DW_AT_high_pc(0x00)
	.dwattr $C$DW$171, DW_AT_linkage_name("__isnanl")
	.dwattr $C$DW$171, DW_AT_external
	.dwattr $C$DW$171, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$171, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$171, DW_AT_decl_line(0x15b)
	.dwattr $C$DW$171, DW_AT_decl_column(0x25)
	.dwattr $C$DW$171, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 348,column 1,is_stmt,address ||__isnanl||,isa 0

	.dwfde $C$DW$CIE, ||__isnanl||
$C$DW$172	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$172, DW_AT_name("e")
	.dwattr $C$DW$172, DW_AT_type(*$C$DW$T$131)
	.dwattr $C$DW$172, DW_AT_location[DW_OP_reg12]


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
$C$DW$173	.dwtag  DW_TAG_variable
	.dwattr $C$DW$173, DW_AT_name("e")
	.dwattr $C$DW$173, DW_AT_type(*$C$DW$T$132)
	.dwattr $C$DW$173, DW_AT_location[DW_OP_reg12]

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
$C$DW$174	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$174, DW_AT_low_pc(0x00)
	.dwattr $C$DW$174, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$174, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |348| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |348| 
        CMPB      AL,#0                 ; [CPU_ALU] |348| 
        MOVB      XAR4,#1,NEQ           ; [CPU_ALU] |348| 
||$C$L8||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |348| 
$C$DW$175	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$175, DW_AT_low_pc(0x00)
	.dwattr $C$DW$175, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$171, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$171, DW_AT_TI_end_line(0x15d)
	.dwattr $C$DW$171, DW_AT_TI_end_column(0x30)
	.dwendentry
	.dwendtag $C$DW$171

	.sect	".text:__isnanf"
	.clink
	.global	||__isnanf||

$C$DW$176	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$176, DW_AT_name("__isnanf")
	.dwattr $C$DW$176, DW_AT_low_pc(||__isnanf||)
	.dwattr $C$DW$176, DW_AT_high_pc(0x00)
	.dwattr $C$DW$176, DW_AT_linkage_name("__isnanf")
	.dwattr $C$DW$176, DW_AT_external
	.dwattr $C$DW$176, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$176, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$176, DW_AT_decl_line(0x158)
	.dwattr $C$DW$176, DW_AT_decl_column(0x25)
	.dwattr $C$DW$176, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 345,column 1,is_stmt,address ||__isnanf||,isa 0

	.dwfde $C$DW$CIE, ||__isnanf||
$C$DW$177	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$177, DW_AT_name("f")
	.dwattr $C$DW$177, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$177, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$178	.dwtag  DW_TAG_variable
	.dwattr $C$DW$178, DW_AT_name("f")
	.dwattr $C$DW$178, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$178, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$179	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$179, DW_AT_low_pc(0x00)
	.dwattr $C$DW$179, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$176, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$176, DW_AT_TI_end_line(0x15a)
	.dwattr $C$DW$176, DW_AT_TI_end_column(0x2e)
	.dwendentry
	.dwendtag $C$DW$176

	.sect	".text:__isnan"
	.clink
	.global	||__isnan||

$C$DW$180	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$180, DW_AT_name("__isnan")
	.dwattr $C$DW$180, DW_AT_low_pc(||__isnan||)
	.dwattr $C$DW$180, DW_AT_high_pc(0x00)
	.dwattr $C$DW$180, DW_AT_linkage_name("__isnan")
	.dwattr $C$DW$180, DW_AT_external
	.dwattr $C$DW$180, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$180, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$180, DW_AT_decl_line(0x155)
	.dwattr $C$DW$180, DW_AT_decl_column(0x25)
	.dwattr $C$DW$180, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 342,column 1,is_stmt,address ||__isnan||,isa 0

	.dwfde $C$DW$CIE, ||__isnan||
$C$DW$181	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$181, DW_AT_name("d")
	.dwattr $C$DW$181, DW_AT_type(*$C$DW$T$128)
	.dwattr $C$DW$181, DW_AT_location[DW_OP_reg12]


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
$C$DW$182	.dwtag  DW_TAG_variable
	.dwattr $C$DW$182, DW_AT_name("d")
	.dwattr $C$DW$182, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$182, DW_AT_location[DW_OP_reg12]

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
$C$DW$183	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$183, DW_AT_low_pc(0x00)
	.dwattr $C$DW$183, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$183, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |342| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |342| 
        CMPB      AL,#0                 ; [CPU_ALU] |342| 
        MOVB      XAR4,#1,NEQ           ; [CPU_ALU] |342| 
||$C$L10||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |342| 
$C$DW$184	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$184, DW_AT_low_pc(0x00)
	.dwattr $C$DW$184, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$180, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$180, DW_AT_TI_end_line(0x157)
	.dwattr $C$DW$180, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$180

	.sect	".text:__isinfl"
	.clink
	.global	||__isinfl||

$C$DW$185	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$185, DW_AT_name("__isinfl")
	.dwattr $C$DW$185, DW_AT_low_pc(||__isinfl||)
	.dwattr $C$DW$185, DW_AT_high_pc(0x00)
	.dwattr $C$DW$185, DW_AT_linkage_name("__isinfl")
	.dwattr $C$DW$185, DW_AT_external
	.dwattr $C$DW$185, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$185, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$185, DW_AT_decl_line(0x17a)
	.dwattr $C$DW$185, DW_AT_decl_column(0x25)
	.dwattr $C$DW$185, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 379,column 1,is_stmt,address ||__isinfl||,isa 0

	.dwfde $C$DW$CIE, ||__isinfl||
$C$DW$186	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$186, DW_AT_name("e")
	.dwattr $C$DW$186, DW_AT_type(*$C$DW$T$131)
	.dwattr $C$DW$186, DW_AT_location[DW_OP_reg12]


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
$C$DW$187	.dwtag  DW_TAG_variable
	.dwattr $C$DW$187, DW_AT_name("e")
	.dwattr $C$DW$187, DW_AT_type(*$C$DW$T$132)
	.dwattr $C$DW$187, DW_AT_location[DW_OP_reg12]

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
$C$DW$188	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$188, DW_AT_low_pc(0x00)
	.dwattr $C$DW$188, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$188, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |379| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |379| 
        CMPB      AL,#0                 ; [CPU_ALU] |379| 
        MOVB      XAR4,#1,EQ            ; [CPU_ALU] |379| 
||$C$L11||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |379| 
$C$DW$189	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$189, DW_AT_low_pc(0x00)
	.dwattr $C$DW$189, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$185, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$185, DW_AT_TI_end_line(0x17b)
	.dwattr $C$DW$185, DW_AT_TI_end_column(0x4c)
	.dwendentry
	.dwendtag $C$DW$185

	.sect	".text:__isinff"
	.clink
	.global	||__isinff||

$C$DW$190	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$190, DW_AT_name("__isinff")
	.dwattr $C$DW$190, DW_AT_low_pc(||__isinff||)
	.dwattr $C$DW$190, DW_AT_high_pc(0x00)
	.dwattr $C$DW$190, DW_AT_linkage_name("__isinff")
	.dwattr $C$DW$190, DW_AT_external
	.dwattr $C$DW$190, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$190, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$190, DW_AT_decl_line(0x176)
	.dwattr $C$DW$190, DW_AT_decl_column(0x25)
	.dwattr $C$DW$190, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 375,column 1,is_stmt,address ||__isinff||,isa 0

	.dwfde $C$DW$CIE, ||__isinff||
$C$DW$191	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$191, DW_AT_name("f")
	.dwattr $C$DW$191, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$191, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$192	.dwtag  DW_TAG_variable
	.dwattr $C$DW$192, DW_AT_name("f")
	.dwattr $C$DW$192, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$192, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$193	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$193, DW_AT_low_pc(0x00)
	.dwattr $C$DW$193, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$190, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$190, DW_AT_TI_end_line(0x177)
	.dwattr $C$DW$190, DW_AT_TI_end_column(0x48)
	.dwendentry
	.dwendtag $C$DW$190

	.sect	".text:__isinf"
	.clink
	.global	||__isinf||

$C$DW$194	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$194, DW_AT_name("__isinf")
	.dwattr $C$DW$194, DW_AT_low_pc(||__isinf||)
	.dwattr $C$DW$194, DW_AT_high_pc(0x00)
	.dwattr $C$DW$194, DW_AT_linkage_name("__isinf")
	.dwattr $C$DW$194, DW_AT_external
	.dwattr $C$DW$194, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$194, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$194, DW_AT_decl_line(0x178)
	.dwattr $C$DW$194, DW_AT_decl_column(0x25)
	.dwattr $C$DW$194, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 377,column 1,is_stmt,address ||__isinf||,isa 0

	.dwfde $C$DW$CIE, ||__isinf||
$C$DW$195	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$195, DW_AT_name("d")
	.dwattr $C$DW$195, DW_AT_type(*$C$DW$T$128)
	.dwattr $C$DW$195, DW_AT_location[DW_OP_reg12]


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
$C$DW$196	.dwtag  DW_TAG_variable
	.dwattr $C$DW$196, DW_AT_name("d")
	.dwattr $C$DW$196, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$196, DW_AT_location[DW_OP_reg12]

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
$C$DW$197	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$197, DW_AT_low_pc(0x00)
	.dwattr $C$DW$197, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$197, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |377| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |377| 
        CMPB      AL,#0                 ; [CPU_ALU] |377| 
        MOVB      XAR4,#1,EQ            ; [CPU_ALU] |377| 
||$C$L13||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |377| 
$C$DW$198	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$198, DW_AT_low_pc(0x00)
	.dwattr $C$DW$198, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$194, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$194, DW_AT_TI_end_line(0x179)
	.dwattr $C$DW$194, DW_AT_TI_end_column(0x4a)
	.dwendentry
	.dwendtag $C$DW$194

	.sect	".text:__isfinitel"
	.clink
	.global	||__isfinitel||

$C$DW$199	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$199, DW_AT_name("__isfinitel")
	.dwattr $C$DW$199, DW_AT_low_pc(||__isfinitel||)
	.dwattr $C$DW$199, DW_AT_high_pc(0x00)
	.dwattr $C$DW$199, DW_AT_linkage_name("__isfinitel")
	.dwattr $C$DW$199, DW_AT_external
	.dwattr $C$DW$199, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$199, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$199, DW_AT_decl_line(0x152)
	.dwattr $C$DW$199, DW_AT_decl_column(0x25)
	.dwattr $C$DW$199, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 339,column 1,is_stmt,address ||__isfinitel||,isa 0

	.dwfde $C$DW$CIE, ||__isfinitel||
$C$DW$200	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$200, DW_AT_name("e")
	.dwattr $C$DW$200, DW_AT_type(*$C$DW$T$131)
	.dwattr $C$DW$200, DW_AT_location[DW_OP_reg12]


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
$C$DW$201	.dwtag  DW_TAG_variable
	.dwattr $C$DW$201, DW_AT_name("e")
	.dwattr $C$DW$201, DW_AT_type(*$C$DW$T$132)
	.dwattr $C$DW$201, DW_AT_location[DW_OP_reg12]

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
$C$DW$202	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$202, DW_AT_low_pc(0x00)
	.dwattr $C$DW$202, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$199, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$199, DW_AT_TI_end_line(0x153)
	.dwattr $C$DW$199, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$199

	.sect	".text:__isfinitef"
	.clink
	.global	||__isfinitef||

$C$DW$203	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$203, DW_AT_name("__isfinitef")
	.dwattr $C$DW$203, DW_AT_low_pc(||__isfinitef||)
	.dwattr $C$DW$203, DW_AT_high_pc(0x00)
	.dwattr $C$DW$203, DW_AT_linkage_name("__isfinitef")
	.dwattr $C$DW$203, DW_AT_external
	.dwattr $C$DW$203, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$203, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$203, DW_AT_decl_line(0x150)
	.dwattr $C$DW$203, DW_AT_decl_column(0x25)
	.dwattr $C$DW$203, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 337,column 1,is_stmt,address ||__isfinitef||,isa 0

	.dwfde $C$DW$CIE, ||__isfinitef||
$C$DW$204	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$204, DW_AT_name("f")
	.dwattr $C$DW$204, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$204, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$205	.dwtag  DW_TAG_variable
	.dwattr $C$DW$205, DW_AT_name("f")
	.dwattr $C$DW$205, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$205, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$206	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$206, DW_AT_low_pc(0x00)
	.dwattr $C$DW$206, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$203, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$203, DW_AT_TI_end_line(0x151)
	.dwattr $C$DW$203, DW_AT_TI_end_column(0x2d)
	.dwendentry
	.dwendtag $C$DW$203

	.sect	".text:__isfinite"
	.clink
	.global	||__isfinite||

$C$DW$207	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$207, DW_AT_name("__isfinite")
	.dwattr $C$DW$207, DW_AT_low_pc(||__isfinite||)
	.dwattr $C$DW$207, DW_AT_high_pc(0x00)
	.dwattr $C$DW$207, DW_AT_linkage_name("__isfinite")
	.dwattr $C$DW$207, DW_AT_external
	.dwattr $C$DW$207, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$207, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$207, DW_AT_decl_line(0x14e)
	.dwattr $C$DW$207, DW_AT_decl_column(0x25)
	.dwattr $C$DW$207, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 335,column 1,is_stmt,address ||__isfinite||,isa 0

	.dwfde $C$DW$CIE, ||__isfinite||
$C$DW$208	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$208, DW_AT_name("d")
	.dwattr $C$DW$208, DW_AT_type(*$C$DW$T$128)
	.dwattr $C$DW$208, DW_AT_location[DW_OP_reg12]


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
$C$DW$209	.dwtag  DW_TAG_variable
	.dwattr $C$DW$209, DW_AT_name("d")
	.dwattr $C$DW$209, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$209, DW_AT_location[DW_OP_reg12]

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
$C$DW$210	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$210, DW_AT_low_pc(0x00)
	.dwattr $C$DW$210, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$207, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$207, DW_AT_TI_end_line(0x14f)
	.dwattr $C$DW$207, DW_AT_TI_end_column(0x2e)
	.dwendentry
	.dwendtag $C$DW$207

	.sect	".text:__fpclassifyl"
	.clink
	.global	||__fpclassifyl||

$C$DW$211	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$211, DW_AT_name("__fpclassifyl")
	.dwattr $C$DW$211, DW_AT_low_pc(||__fpclassifyl||)
	.dwattr $C$DW$211, DW_AT_high_pc(0x00)
	.dwattr $C$DW$211, DW_AT_linkage_name("__fpclassifyl")
	.dwattr $C$DW$211, DW_AT_external
	.dwattr $C$DW$211, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$211, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$211, DW_AT_decl_line(0x1ae)
	.dwattr $C$DW$211, DW_AT_decl_column(0x25)
	.dwattr $C$DW$211, DW_AT_TI_max_frame_size(-10)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 431,column 1,is_stmt,address ||__fpclassifyl||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassifyl||
$C$DW$212	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$212, DW_AT_name("e")
	.dwattr $C$DW$212, DW_AT_type(*$C$DW$T$131)
	.dwattr $C$DW$212, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __fpclassifyl                 FR SIZE:   8           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  4 Auto,  0 SOE     *
;***************************************************************

||__fpclassifyl||:
$C$DW$213	.dwtag  DW_TAG_variable
	.dwattr $C$DW$213, DW_AT_name("e")
	.dwattr $C$DW$213, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$213, DW_AT_location[DW_OP_breg20 -8]

;* AR5   assigned to $O$C1
;* AR4   assigned to e
$C$DW$214	.dwtag  DW_TAG_variable
	.dwattr $C$DW$214, DW_AT_name("e")
	.dwattr $C$DW$214, DW_AT_type(*$C$DW$T$132)
	.dwattr $C$DW$214, DW_AT_location[DW_OP_reg12]

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
$C$DW$215	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$215, DW_AT_low_pc(0x00)
	.dwattr $C$DW$215, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$215, DW_AT_TI_call

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
$C$DW$216	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$216, DW_AT_low_pc(0x00)
	.dwattr $C$DW$216, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$216, DW_AT_TI_call

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
$C$DW$217	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$217, DW_AT_low_pc(0x00)
	.dwattr $C$DW$217, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$217, DW_AT_TI_call

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
$C$DW$218	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$218, DW_AT_low_pc(0x00)
	.dwattr $C$DW$218, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$211, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$211, DW_AT_TI_end_line(0x1bd)
	.dwattr $C$DW$211, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$211

	.sect	".text:__fpclassifyf"
	.clink
	.global	||__fpclassifyf||

$C$DW$219	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$219, DW_AT_name("__fpclassifyf")
	.dwattr $C$DW$219, DW_AT_low_pc(||__fpclassifyf||)
	.dwattr $C$DW$219, DW_AT_high_pc(0x00)
	.dwattr $C$DW$219, DW_AT_linkage_name("__fpclassifyf")
	.dwattr $C$DW$219, DW_AT_external
	.dwattr $C$DW$219, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$219, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$219, DW_AT_decl_line(0x18c)
	.dwattr $C$DW$219, DW_AT_decl_column(0x25)
	.dwattr $C$DW$219, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 397,column 1,is_stmt,address ||__fpclassifyf||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassifyf||
$C$DW$220	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$220, DW_AT_name("f")
	.dwattr $C$DW$220, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$220, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$221	.dwtag  DW_TAG_variable
	.dwattr $C$DW$221, DW_AT_name("f")
	.dwattr $C$DW$221, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$221, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$222	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$222, DW_AT_low_pc(0x00)
	.dwattr $C$DW$222, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L19||:    
	.dwcfi	remember_state
        MOVB      AL,#1                 ; [CPU_ALU] |402| 
$C$DW$223	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$223, DW_AT_low_pc(0x00)
	.dwattr $C$DW$223, DW_AT_TI_return

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
$C$DW$224	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$224, DW_AT_low_pc(0x00)
	.dwattr $C$DW$224, DW_AT_TI_return

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
$C$DW$225	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$225, DW_AT_low_pc(0x00)
	.dwattr $C$DW$225, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L22||:    
        MOVB      AL,#0                 ; [CPU_ALU] |402| 
$C$DW$226	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$226, DW_AT_low_pc(0x00)
	.dwattr $C$DW$226, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$219, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$219, DW_AT_TI_end_line(0x19b)
	.dwattr $C$DW$219, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$219

	.sect	".text:__fpclassify"
	.clink
	.global	||__fpclassify||

$C$DW$227	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$227, DW_AT_name("__fpclassify")
	.dwattr $C$DW$227, DW_AT_low_pc(||__fpclassify||)
	.dwattr $C$DW$227, DW_AT_high_pc(0x00)
	.dwattr $C$DW$227, DW_AT_linkage_name("__fpclassify")
	.dwattr $C$DW$227, DW_AT_external
	.dwattr $C$DW$227, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$227, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$227, DW_AT_decl_line(0x19d)
	.dwattr $C$DW$227, DW_AT_decl_column(0x25)
	.dwattr $C$DW$227, DW_AT_TI_max_frame_size(-10)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 414,column 1,is_stmt,address ||__fpclassify||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassify||
$C$DW$228	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$228, DW_AT_name("d")
	.dwattr $C$DW$228, DW_AT_type(*$C$DW$T$128)
	.dwattr $C$DW$228, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __fpclassify                  FR SIZE:   8           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  4 Auto,  0 SOE     *
;***************************************************************

||__fpclassify||:
$C$DW$229	.dwtag  DW_TAG_variable
	.dwattr $C$DW$229, DW_AT_name("d")
	.dwattr $C$DW$229, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$229, DW_AT_location[DW_OP_breg20 -8]

;* AR5   assigned to $O$C1
;* AR4   assigned to d
$C$DW$230	.dwtag  DW_TAG_variable
	.dwattr $C$DW$230, DW_AT_name("d")
	.dwattr $C$DW$230, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$230, DW_AT_location[DW_OP_reg12]

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
$C$DW$231	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$231, DW_AT_low_pc(0x00)
	.dwattr $C$DW$231, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$231, DW_AT_TI_call

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
$C$DW$232	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$232, DW_AT_low_pc(0x00)
	.dwattr $C$DW$232, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$232, DW_AT_TI_call

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
$C$DW$233	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$233, DW_AT_low_pc(0x00)
	.dwattr $C$DW$233, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$233, DW_AT_TI_call

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
$C$DW$234	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$234, DW_AT_low_pc(0x00)
	.dwattr $C$DW$234, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$227, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$227, DW_AT_TI_end_line(0x1ac)
	.dwattr $C$DW$227, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$227

	.sect	"isrcodefuncs:retain"
	.retain
	.retainrefs
	.global	||ISR2||

$C$DW$235	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$235, DW_AT_name("ISR2")
	.dwattr $C$DW$235, DW_AT_low_pc(||ISR2||)
	.dwattr $C$DW$235, DW_AT_high_pc(0x00)
	.dwattr $C$DW$235, DW_AT_linkage_name("ISR2")
	.dwattr $C$DW$235, DW_AT_external
	.dwattr $C$DW$235, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$235, DW_AT_decl_line(0xc0)
	.dwattr $C$DW$235, DW_AT_decl_column(0x10)
	.dwattr $C$DW$235, DW_AT_TI_interrupt
	.dwattr $C$DW$235, DW_AT_TI_max_frame_size(-18)
	.dwpsn	file "../bts_main.c",line 193,column 1,is_stmt,address ||ISR2||,isa 0

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
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 472,column 9,is_stmt,isa 0
        MOV       ACC,#1024 << 15       ; [CPU_ALU] |472| 
        MOVW      DP,#||BTS_ADC1||      ; [CPU_ARAU] 
        MOVL      XAR4,#32522           ; [CPU_ARAU] |472| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |472| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 129,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ADC1||),*(0:0x6107) ; [CPU_ALU] |129| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 131,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |131| 
        MOVU      ACC,AL                ; [CPU_ALU] |131| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+2,ACC ; [CPU_ALU] |131| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 132,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |132| 
        MOVU      ACC,AL                ; [CPU_ALU] |132| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+4,ACC ; [CPU_ALU] |132| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 133,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |133| 
        MOVU      ACC,AL                ; [CPU_ALU] |133| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+6,ACC ; [CPU_ALU] |133| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 134,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |134| 
        MOVU      ACC,AL                ; [CPU_ALU] |134| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+8,ACC ; [CPU_ALU] |134| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 135,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |135| 
        MOVU      ACC,AL                ; [CPU_ALU] |135| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+10,ACC ; [CPU_ALU] |135| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 136,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |136| 
        MOVU      ACC,AL                ; [CPU_ALU] |136| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+12,ACC ; [CPU_ALU] |136| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 137,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |137| 
        MOVU      ACC,AL                ; [CPU_ALU] |137| 
        MOVL      @$BLOCKED(||BTS_ADC1||)+14,ACC ; [CPU_ALU] |137| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 138,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x6107)        ; [CPU_ALU] |138| 
        MOVZ      AR6,AL                ; [CPU_ALU] |138| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 166,column 5,is_stmt,isa 0
        MOVL      XAR4,#24832           ; [CPU_ARAU] |166| 
        MOVB      ACC,#4                ; [CPU_ALU] |166| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |166| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 138,column 5,is_stmt,isa 0
        MOVL      @$BLOCKED(||BTS_ADC1||)+16,XAR6 ; [CPU_ALU] |138| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 166,column 5,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |166| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 139,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ADC1||)+1,*(0:0x6107) ; [CPU_ALU] |139| 
        MOVW      DP,#||BTS_ExAdcRxflag|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 163,column 5,is_stmt,isa 0
        MOVB      @||BTS_ExAdcRxflag||,#1,UNC ; [CPU_ALU] |163| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 166,column 5,is_stmt,isa 0
$C$DW$236	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$236, DW_AT_low_pc(0x00)
	.dwattr $C$DW$236, DW_AT_name("SPI_clearInterruptStatus")
	.dwattr $C$DW$236, DW_AT_TI_call

        LCR       #||SPI_clearInterruptStatus|| ; [CPU_ALU] |166| 
        ; call occurs [#||SPI_clearInterruptStatus||] ; [] |166| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 429,column 5,is_stmt,isa 0
        MOVB      AL,#32                ; [CPU_ALU] |429| 
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
$C$DW$237	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$237, DW_AT_low_pc(0x00)
	.dwattr $C$DW$237, DW_AT_TI_return

        IRET      ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$235, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$235, DW_AT_TI_end_line(0xc4)
	.dwattr $C$DW$235, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$235

	.sect	"isrcodefuncs:retain"
	.retain
	.retainrefs
	.global	||ISR1||

$C$DW$238	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$238, DW_AT_name("ISR1")
	.dwattr $C$DW$238, DW_AT_low_pc(||ISR1||)
	.dwattr $C$DW$238, DW_AT_high_pc(0x00)
	.dwattr $C$DW$238, DW_AT_linkage_name("ISR1")
	.dwattr $C$DW$238, DW_AT_external
	.dwattr $C$DW$238, DW_AT_decl_file("../bts_main.c")
	.dwattr $C$DW$238, DW_AT_decl_line(0xb1)
	.dwattr $C$DW$238, DW_AT_decl_column(0x10)
	.dwattr $C$DW$238, DW_AT_TI_interrupt
	.dwattr $C$DW$238, DW_AT_TI_max_frame_size(-24)
	.dwpsn	file "../bts_main.c",line 178,column 1,is_stmt,address ||ISR1||,isa 0

	.dwfde $C$DW$CIE, ||ISR1||

;***************************************************************
;* FNAME: ISR1                          FR SIZE:  22           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  6 Auto, 14 SOE     *
;***************************************************************

||ISR1||:
;* AL    assigned to $O$C18
;* AL    assigned to $O$C19
;* AL    assigned to $O$C20
;* AR6   assigned to $O$C21
;* R2    assigned to $O$C22
;* AR4   assigned to $O$C23
;* AR4   assigned to $O$C24
;* AL    assigned to $O$C26
;* AL    assigned to $O$C27
;* AL    assigned to $O$C28
;* AR6   assigned to $O$C29
;* R2    assigned to $O$C30
;* AR4   assigned to $O$C31
;* AR4   assigned to $O$C32
;* AL    assigned to $O$C34
;* AL    assigned to $O$C35
;* AL    assigned to $O$C36
;* AR6   assigned to $O$C37
;* R2    assigned to $O$C38
;* AR4   assigned to $O$C39
;* AR4   assigned to $O$C40
;* AL    assigned to $O$C42
;* AL    assigned to $O$C43
;* AL    assigned to $O$C44
;* AR6   assigned to $O$C45
;* R2    assigned to $O$C46
;* AR4   assigned to $O$C47
;* AR4   assigned to $O$C48
;* AL    assigned to compHR
$C$DW$239	.dwtag  DW_TAG_variable
	.dwattr $C$DW$239, DW_AT_name("compHR")
	.dwattr $C$DW$239, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$239, DW_AT_location[DW_OP_reg0]

;* AL    assigned to compHR
$C$DW$240	.dwtag  DW_TAG_variable
	.dwattr $C$DW$240, DW_AT_name("compHR")
	.dwattr $C$DW$240, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$240, DW_AT_location[DW_OP_reg0]

;* AL    assigned to compHR
$C$DW$241	.dwtag  DW_TAG_variable
	.dwattr $C$DW$241, DW_AT_name("compHR")
	.dwattr $C$DW$241, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$241, DW_AT_location[DW_OP_reg0]

;* AL    assigned to compHR
$C$DW$242	.dwtag  DW_TAG_variable
	.dwattr $C$DW$242, DW_AT_name("compHR")
	.dwattr $C$DW$242, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$242, DW_AT_location[DW_OP_reg0]

;* AL    assigned to compHR
$C$DW$243	.dwtag  DW_TAG_variable
	.dwattr $C$DW$243, DW_AT_name("compHR")
	.dwattr $C$DW$243, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$243, DW_AT_location[DW_OP_reg0]

;* AL    assigned to compHR
$C$DW$244	.dwtag  DW_TAG_variable
	.dwattr $C$DW$244, DW_AT_name("compHR")
	.dwattr $C$DW$244, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$244, DW_AT_location[DW_OP_reg0]

;* AL    assigned to compHR
$C$DW$245	.dwtag  DW_TAG_variable
	.dwattr $C$DW$245, DW_AT_name("compHR")
	.dwattr $C$DW$245, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$245, DW_AT_location[DW_OP_reg0]

;* AL    assigned to compHR
$C$DW$246	.dwtag  DW_TAG_variable
	.dwattr $C$DW$246, DW_AT_name("compHR")
	.dwattr $C$DW$246, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$246, DW_AT_location[DW_OP_reg0]

;* AL    assigned to compHR
$C$DW$247	.dwtag  DW_TAG_variable
	.dwattr $C$DW$247, DW_AT_name("compHR")
	.dwattr $C$DW$247, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$247, DW_AT_location[DW_OP_reg0]

;* AL    assigned to compHR
$C$DW$248	.dwtag  DW_TAG_variable
	.dwattr $C$DW$248, DW_AT_name("compHR")
	.dwattr $C$DW$248, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$248, DW_AT_location[DW_OP_reg0]

;* AL    assigned to compHR
$C$DW$249	.dwtag  DW_TAG_variable
	.dwattr $C$DW$249, DW_AT_name("compHR")
	.dwattr $C$DW$249, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$249, DW_AT_location[DW_OP_reg0]

;* AL    assigned to compHR
$C$DW$250	.dwtag  DW_TAG_variable
	.dwattr $C$DW$250, DW_AT_name("compHR")
	.dwattr $C$DW$250, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$250, DW_AT_location[DW_OP_reg0]

;* AR4   assigned to $O$K19
;* PL    assigned to $O$U21
;* AR4   assigned to $O$K203
;* PL    assigned to $O$U205
;* AR4   assigned to $O$K346
;* PL    assigned to $O$U348
;* AR4   assigned to $O$K491
;* PL    assigned to $O$U493
;* R1    assigned to $O$v52
;* R2    assigned to $O$v51
;* R5    assigned to $O$v50
;* R1    assigned to $O$v49
;* R2    assigned to $O$v48
;* R5    assigned to $O$v47
;* R1    assigned to $O$v46
;* R2    assigned to $O$v45
;* R5    assigned to $O$v44
;* R1    assigned to $O$v43
;* R2    assigned to $O$v42
;* R5    assigned to $O$v41
;* R0    assigned to $O$v38
;* R0    assigned to $O$v37
;* R1    assigned to $O$v36
;* R0    assigned to $O$v35
;* R3    assigned to $O$v33
;* R7    assigned to $O$v31
;* R0    assigned to $O$v28
;* R0    assigned to $O$v27
;* R1    assigned to $O$v26
;* R0    assigned to $O$v25
;* R3    assigned to $O$v23
;* R7    assigned to $O$v21
;* R0    assigned to $O$v18
;* R0    assigned to $O$v17
;* R1    assigned to $O$v16
;* R0    assigned to $O$v15
;* R3    assigned to $O$v13
;* R7    assigned to $O$v11
;* R0    assigned to $O$v8
;* R0    assigned to $O$v7
;* R1    assigned to $O$v6
;* R0    assigned to $O$v5
;* R3    assigned to $O$v3
;* R7    assigned to $O$v1
;* R4    assigned to $O$R1
;* R2    assigned to $O$R3
;* R4    assigned to $O$R5
;* R2    assigned to $O$R7
;* R4    assigned to $O$R9
;* R2    assigned to $O$R11
;* R4    assigned to $O$R13
;* R2    assigned to $O$R15
;* AR7   assigned to current_16b
$C$DW$251	.dwtag  DW_TAG_variable
	.dwattr $C$DW$251, DW_AT_name("current_16b")
	.dwattr $C$DW$251, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$251, DW_AT_location[DW_OP_reg18]

;* AR6   assigned to voltage_16b
$C$DW$252	.dwtag  DW_TAG_variable
	.dwattr $C$DW$252, DW_AT_name("voltage_16b")
	.dwattr $C$DW$252, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$252, DW_AT_location[DW_OP_reg16]

;* AR6   assigned to current_16b
$C$DW$253	.dwtag  DW_TAG_variable
	.dwattr $C$DW$253, DW_AT_name("current_16b")
	.dwattr $C$DW$253, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$253, DW_AT_location[DW_OP_reg16]

;* AR7   assigned to voltage_16b
$C$DW$254	.dwtag  DW_TAG_variable
	.dwattr $C$DW$254, DW_AT_name("voltage_16b")
	.dwattr $C$DW$254, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$254, DW_AT_location[DW_OP_reg18]

;* AL    assigned to $O$S2
;* R1    assigned to Umax
$C$DW$255	.dwtag  DW_TAG_variable
	.dwattr $C$DW$255, DW_AT_name("Umax")
	.dwattr $C$DW$255, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$255, DW_AT_location[DW_OP_regx 0x2f]

$C$DW$256	.dwtag  DW_TAG_variable
	.dwattr $C$DW$256, DW_AT_name("Umin")
	.dwattr $C$DW$256, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$256, DW_AT_location[DW_OP_breg20 -8]

;* AL    assigned to $O$S2
;* AR6   assigned to current_16b
$C$DW$257	.dwtag  DW_TAG_variable
	.dwattr $C$DW$257, DW_AT_name("current_16b")
	.dwattr $C$DW$257, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$257, DW_AT_location[DW_OP_reg16]

;* AR7   assigned to current_16b
$C$DW$258	.dwtag  DW_TAG_variable
	.dwattr $C$DW$258, DW_AT_name("current_16b")
	.dwattr $C$DW$258, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$258, DW_AT_location[DW_OP_reg18]

;* AR6   assigned to voltage_16b
$C$DW$259	.dwtag  DW_TAG_variable
	.dwattr $C$DW$259, DW_AT_name("voltage_16b")
	.dwattr $C$DW$259, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$259, DW_AT_location[DW_OP_reg16]

;* AR6   assigned to current_16b
$C$DW$260	.dwtag  DW_TAG_variable
	.dwattr $C$DW$260, DW_AT_name("current_16b")
	.dwattr $C$DW$260, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$260, DW_AT_location[DW_OP_reg16]

;* AR7   assigned to voltage_16b
$C$DW$261	.dwtag  DW_TAG_variable
	.dwattr $C$DW$261, DW_AT_name("voltage_16b")
	.dwattr $C$DW$261, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$261, DW_AT_location[DW_OP_reg18]

;* AL    assigned to $O$S2
;* R1    assigned to Umax
$C$DW$262	.dwtag  DW_TAG_variable
	.dwattr $C$DW$262, DW_AT_name("Umax")
	.dwattr $C$DW$262, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$262, DW_AT_location[DW_OP_regx 0x2f]

$C$DW$263	.dwtag  DW_TAG_variable
	.dwattr $C$DW$263, DW_AT_name("Umin")
	.dwattr $C$DW$263, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$263, DW_AT_location[DW_OP_breg20 -8]

;* AL    assigned to $O$S2
;* AR6   assigned to current_16b
$C$DW$264	.dwtag  DW_TAG_variable
	.dwattr $C$DW$264, DW_AT_name("current_16b")
	.dwattr $C$DW$264, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$264, DW_AT_location[DW_OP_reg16]

;* AR7   assigned to current_16b
$C$DW$265	.dwtag  DW_TAG_variable
	.dwattr $C$DW$265, DW_AT_name("current_16b")
	.dwattr $C$DW$265, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$265, DW_AT_location[DW_OP_reg18]

;* AR6   assigned to voltage_16b
$C$DW$266	.dwtag  DW_TAG_variable
	.dwattr $C$DW$266, DW_AT_name("voltage_16b")
	.dwattr $C$DW$266, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$266, DW_AT_location[DW_OP_reg16]

;* AR6   assigned to current_16b
$C$DW$267	.dwtag  DW_TAG_variable
	.dwattr $C$DW$267, DW_AT_name("current_16b")
	.dwattr $C$DW$267, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$267, DW_AT_location[DW_OP_reg16]

;* AR7   assigned to voltage_16b
$C$DW$268	.dwtag  DW_TAG_variable
	.dwattr $C$DW$268, DW_AT_name("voltage_16b")
	.dwattr $C$DW$268, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$268, DW_AT_location[DW_OP_reg18]

;* AL    assigned to $O$S2
;* R1    assigned to Umax
$C$DW$269	.dwtag  DW_TAG_variable
	.dwattr $C$DW$269, DW_AT_name("Umax")
	.dwattr $C$DW$269, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$269, DW_AT_location[DW_OP_regx 0x2f]

$C$DW$270	.dwtag  DW_TAG_variable
	.dwattr $C$DW$270, DW_AT_name("Umin")
	.dwattr $C$DW$270, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$270, DW_AT_location[DW_OP_breg20 -8]

;* AL    assigned to $O$S2
;* AR6   assigned to current_16b
$C$DW$271	.dwtag  DW_TAG_variable
	.dwattr $C$DW$271, DW_AT_name("current_16b")
	.dwattr $C$DW$271, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$271, DW_AT_location[DW_OP_reg16]

;* AR7   assigned to current_16b
$C$DW$272	.dwtag  DW_TAG_variable
	.dwattr $C$DW$272, DW_AT_name("current_16b")
	.dwattr $C$DW$272, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$272, DW_AT_location[DW_OP_reg18]

;* AR6   assigned to voltage_16b
$C$DW$273	.dwtag  DW_TAG_variable
	.dwattr $C$DW$273, DW_AT_name("voltage_16b")
	.dwattr $C$DW$273, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$273, DW_AT_location[DW_OP_reg16]

;* AR6   assigned to current_16b
$C$DW$274	.dwtag  DW_TAG_variable
	.dwattr $C$DW$274, DW_AT_name("current_16b")
	.dwattr $C$DW$274, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$274, DW_AT_location[DW_OP_reg16]

;* AR7   assigned to voltage_16b
$C$DW$275	.dwtag  DW_TAG_variable
	.dwattr $C$DW$275, DW_AT_name("voltage_16b")
	.dwattr $C$DW$275, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$275, DW_AT_location[DW_OP_reg18]

;* AL    assigned to $O$S2
;* R1    assigned to Umax
$C$DW$276	.dwtag  DW_TAG_variable
	.dwattr $C$DW$276, DW_AT_name("Umax")
	.dwattr $C$DW$276, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$276, DW_AT_location[DW_OP_regx 0x2f]

$C$DW$277	.dwtag  DW_TAG_variable
	.dwattr $C$DW$277, DW_AT_name("Umin")
	.dwattr $C$DW$277, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$277, DW_AT_location[DW_OP_breg20 -8]

;* AL    assigned to $O$S2
;* AR6   assigned to current_16b
$C$DW$278	.dwtag  DW_TAG_variable
	.dwattr $C$DW$278, DW_AT_name("current_16b")
	.dwattr $C$DW$278, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$278, DW_AT_location[DW_OP_reg16]

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
        ADDB      SP,#8                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -24
        CLRC      PAGE0,OVM             ; [CPU_ALU] 
        CLRC      AMODE                 ; [CPU_ALU] 
        MOVW      DP,#||BTS_ExAdcRxflag|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 147,column 5,is_stmt,isa 0
        MOV       AL,@||BTS_ExAdcRxflag|| ; [CPU_ALU] |147| 
        CMPB      AL,#1                 ; [CPU_ALU] |147| 
        B         ||$C$L28||,NEQ        ; [CPU_ALU] |147| 
        ; branchcc occurs ; [] |147| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOV       ACC,#1024 << 15       ; [CPU_ALU] |468| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 149,column 9,is_stmt,isa 0
        MOV       @||BTS_ExAdcRxflag||,#0 ; [CPU_ALU] |149| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      XAR4,#32524           ; [CPU_ARAU] |468| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 112,column 5,is_stmt,isa 0
        MOVB      XAR7,#0               ; [CPU_ALU] |112| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 115,column 5,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |115| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 468,column 9,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |468| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 119,column 8,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |119| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 112,column 5,is_stmt,isa 0
        MOV       *(0:0x6108),AR7       ; [CPU_ALU] |112| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 119,column 8,is_stmt,isa 0
        MOVB      AH,#0                 ; [CPU_ALU] |119| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 115,column 5,is_stmt,isa 0
        MOV       *(0:0x6108),AR6       ; [CPU_ALU] |115| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 119,column 8,is_stmt,isa 0
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AR6       ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AR7       ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AR6       ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AH        ; [CPU_ALU] |119| 
        MOV       *(0:0x6108),AL        ; [CPU_ALU] |119| 
||$C$L28||:    
        MOVW      DP,#||BTS_ADC1||+2    ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 349,column 5,is_stmt,isa 0
        MOVB      XAR0,#72              ; [CPU_ALU] |349| 
        MOVL      XAR4,#||BTS_measValues_ch1|| ; [CPU_ARAU] |349| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 348,column 105,is_stmt,isa 0
        MOVL      XAR7,@$BLOCKED(||BTS_ADC1||)+2 ; [CPU_ALU] |348| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 349,column 5,is_stmt,isa 0
        MOV       PL,*+XAR4[AR0]        ; [CPU_ALU] |349| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 348,column 105,is_stmt,isa 0
        MOV       AL,PL                 ; [CPU_ALU] |348| 
        MOVL      XAR6,@$BLOCKED(||BTS_ADC1||)+4 ; [CPU_ALU] |348| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 349,column 5,is_stmt,isa 0
        CMPB      AL,#32                ; [CPU_ALU] |349| 
        B         ||$C$L29||,LO         ; [CPU_ALU] |349| 
        ; branchcc occurs ; [] |349| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 355,column 9,is_stmt,isa 0
        MOVB      XAR0,#72              ; [CPU_ALU] |355| 
        MOV       *+XAR4[AR0],#0        ; [CPU_ALU] |355| 
        B         ||$C$L30||,UNC        ; [CPU_ALU] |355| 
        ; branch occurs ; [] |355| 
||$C$L29||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 350,column 9,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |350| 
        ADDU      ACC,PL                ; [CPU_ALU] |350| 
        MOVL      XAR5,ACC              ; [CPU_ALU] |350| 
        MOVW      DP,#||BTS_measValues_ch1||+72 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 351,column 9,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |351| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 350,column 9,is_stmt,isa 0
        MOV       *+XAR5[4],AR7         ; [CPU_ALU] |350| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 351,column 9,is_stmt,isa 0
        ADDU      ACC,@$BLOCKED(||BTS_measValues_ch1||)+72 ; [CPU_ALU] |351| 
        MOVL      XAR4,ACC              ; [CPU_ALU] |351| 
        MOVB      XAR0,#36              ; [CPU_ALU] |351| 
        MOV       *+XAR4[AR0],AR6       ; [CPU_ALU] |351| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 352,column 9,is_stmt,isa 0
        INC       @$BLOCKED(||BTS_measValues_ch1||)+72 ; [CPU_ALU] |352| 
||$C$L30||:    
        MOVW      DP,#||BTS_ADC1||+2    ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 400,column 189,is_stmt,isa 0
        MOVL      XAR6,@$BLOCKED(||BTS_ADC1||)+2 ; [CPU_ALU] |400| 
        MOVL      XAR7,@$BLOCKED(||BTS_ADC1||)+4 ; [CPU_ALU] |400| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1||+34 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 323,column 5,is_stmt,isa 0
        MOV       AH,@$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+34 ; [CPU_ALU] |323| 
        B         ||$C$L31||,NEQ        ; [CPU_ALU] |323| 
        ; branchcc occurs ; [] |323| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4492,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |4492| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4493,column 5,is_stmt,isa 0
        MOV       AH,*(0:0x4097)        ; [CPU_ALU] |4493| 
        ORB       AH,#0x04              ; [CPU_ALU] |4493| 
        MOV       *(0:0x4097),AH        ; [CPU_ALU] |4493| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4494,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |4494| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 340,column 9,is_stmt,isa 0
        B         ||$C$L32||,UNC        ; [CPU_ALU] |340| 
        ; branch occurs ; [] |340| 
||$C$L31||:    
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
        MOV       AL,#999               ; [CPU_ALU] |2406| 
        MOVB      AH,#0                 ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 334,column 9,is_stmt,isa 0
        ZERO      R1H                   ; [CPU_FPU] |334| 
        MOVW      DP,#||BTS_ctrl_cc_ch1||+10 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 335,column 9,is_stmt,isa 0
        ZERO      R0H                   ; [CPU_FPU] |335| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x406b),AH        ; [CPU_ALU] |2406| 
        MOV       *(0:0x406d),AL        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x406a),AH        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x406c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 334,column 9,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+10,R1H ; [CPU_FPU] |334| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 335,column 9,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+12,R0H ; [CPU_FPU] |335| 
||$C$L32||:    
        SETC      SXM                   ; [CPU_ALU] 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1||+4 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOV       ACC,AR6               ; [CPU_ALU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        MOV32     R1H,@$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+4 ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOV32     R2H,ACC               ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        MOV32     R6H,R1H               ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 418,column 5,is_stmt,isa 0
        MOV32     R7H,@$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+10 ; [CPU_FPU] |418| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 420,column 5,is_stmt,isa 0
        MOV32     R5H,@$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+24 ; [CPU_FPU] |420| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV       ACC,AR7               ; [CPU_ALU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        NEGF32    R6H,R6H               ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 421,column 5,is_stmt,isa 0
        MOVB      XAR0,#20              ; [CPU_ALU] |421| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_ctrlLoopVariable_ch1|| ; [CPU_ARAU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV32     R0H,ACC               ; [CPU_FPU] |409| 
        MOVW      DP,#||BTS_ctrl_cv_ch1|| ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        MOV32     *-SP[8],R6H           ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVB      XAR1,#20              ; [CPU_ALU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        I32TOF32  R2H,R2H               ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        I32TOF32  R0H,R0H               ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOV32     R6H,R1H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MPYF32    R0H,R0H,#14336        ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVB      AL,#1                 ; [CPU_ALU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 420,column 5,is_stmt,isa 0
        SUBF32    R3H,R7H,R0H           ; [CPU_FPU] |420| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MPYF32    R2H,R2H,#14336        ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0

        MPYF32    R3H,R5H,R3H           ; [CPU_FPU] |420| 
||      MOV32     *-SP[4],R0H           ; [CPU_FPU] |409| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0
        MOV32     R0H,@$BLOCKED(||BTS_ctrl_cv_ch1||) ; [CPU_FPU] |1447| 
        MPYF32    R0H,R3H,R0H           ; [CPU_FPU] |1447| 
        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cv_ch1||)+10 ; [CPU_FPU] |1447| 

        ADDF32    R4H,R4H,R0H           ; [CPU_FPU] |1447| 
||      MOV32     *-SP[6],R1H           ; [CPU_FPU] |1697| 

        MOV32     R0H,*-SP[8]           ; [CPU_FPU] |1447| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 421,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R4H       ; [CPU_FPU] |421| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MINF32    R6H,R4H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 418,column 5,is_stmt,isa 0
        MOVB      XAR0,#12              ; [CPU_ALU] |418| 
        MOV32     *+XAR4[AR0],R7H       ; [CPU_FPU] |418| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MAXF32    R0H,R6H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOVB      XAR0,#8               ; [CPU_ALU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV32     R6H,*-SP[4]           ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R2H       ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOVB      XAR0,#14              ; [CPU_ALU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR1],R0H       ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R6H       ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 420,column 5,is_stmt,isa 0
        MOVB      XAR0,#22              ; [CPU_ALU] |420| 
        MOV32     *+XAR4[AR0],R3H       ; [CPU_FPU] |420| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        CMPF32    R4H,R1H               ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L33||,GEQ        ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
        MOV32     R1H,*-SP[8]           ; [CPU_FPU] 
        CMPF32    R4H,R1H               ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L36||,GT         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
||$C$L33||:    
        CMPB      AL,#0                 ; [CPU_ALU] |1703| 
        B         ||$C$L36||,EQ         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 433,column 10,is_stmt,isa 0
        MOVIZ     R1H,#48955            ; [CPU_FPU] |433| 
        MOVXI     R1H,#46601            ; [CPU_FPU] |433| 
        CMPF32    R0H,R1H               ; [CPU_FPU] |433| 
        MOVST0    ZF, NF                ; [CPU_FPU] |433| 
        B         ||$C$L34||,LEQ        ; [CPU_ALU] |433| 
        ; branchcc occurs ; [] |433| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1||+6 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 437,column 14,is_stmt,isa 0
        MOVIZ     R4H,#16187            ; [CPU_FPU] |437| 
        MOV32     R1H,@$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+6 ; [CPU_FPU] 
        MOVXI     R4H,#50975            ; [CPU_FPU] |437| 
        CMPF32    R0H,R4H               ; [CPU_FPU] |437| 
        MOVST0    ZF, NF                ; [CPU_FPU] |437| 
        B         ||$C$L35||,GEQ        ; [CPU_ALU] |437| 
        ; branchcc occurs ; [] |437| 
        B         ||$C$L37||,UNC        ; [CPU_ALU] |437| 
        ; branch occurs ; [] |437| 
||$C$L34||:    
        MOVIZ     R1H,#16187            ; [CPU_FPU] |437| 
        MOVXI     R1H,#50975            ; [CPU_FPU] |437| 
        CMPF32    R0H,R1H               ; [CPU_FPU] |437| 
        MOVST0    ZF, NF                ; [CPU_FPU] |437| 
        B         ||$C$L35||,GEQ        ; [CPU_ALU] |437| 
        ; branchcc occurs ; [] |437| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 446,column 5,is_stmt,isa 0
        MOVIZ     R1H,#47747            ; [CPU_FPU] |446| 
        MOVIZ     R4H,#48955            ; [CPU_FPU] 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1||+6 ; [CPU_ARAU] 
        MOVXI     R1H,#4719             ; [CPU_FPU] |446| 
        MOVXI     R4H,#46601            ; [CPU_FPU] 
        CMPF32    R3H,R1H               ; [CPU_FPU] |446| 
        MOVST0    ZF, NF                ; [CPU_FPU] |446| 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+6,R4H ; [CPU_FPU] 
        B         ||$C$L39||,LT         ; [CPU_ALU] |446| 
        ; branchcc occurs ; [] |446| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 450,column 10,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |450| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |450| 
        CMPF32    R3H,R0H               ; [CPU_FPU] |450| 
        MOVST0    ZF, NF                ; [CPU_FPU] |450| 
        B         ||$C$L38||,GT         ; [CPU_ALU] |450| 
        ; branchcc occurs ; [] |450| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 435,column 14,is_stmt,isa 0
        MOVIZ     R1H,#48955            ; [CPU_FPU] |435| 
        MOVXI     R1H,#46601            ; [CPU_FPU] |435| 
        B         ||$C$L41||,UNC        ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L35||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 446,column 5,is_stmt,isa 0
        MOVIZ     R1H,#47747            ; [CPU_FPU] |446| 
        MOVXI     R1H,#4719             ; [CPU_FPU] |446| 
        CMPF32    R3H,R1H               ; [CPU_FPU] |446| 
        MOVST0    ZF, NF                ; [CPU_FPU] |446| 
        B         ||$C$L39||,LT         ; [CPU_ALU] |446| 
        ; branchcc occurs ; [] |446| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 450,column 10,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |450| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |450| 
        CMPF32    R3H,R0H               ; [CPU_FPU] |450| 
        MOVST0    ZF, NF                ; [CPU_FPU] |450| 
        B         ||$C$L38||,GT         ; [CPU_ALU] |450| 
        ; branchcc occurs ; [] |450| 
        MOVIZ     R0H,#16187            ; [CPU_FPU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 439,column 18,is_stmt,isa 0
        MOVIZ     R1H,#16187            ; [CPU_FPU] |439| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1||+6 ; [CPU_ARAU] 
        MOVXI     R0H,#50975            ; [CPU_FPU] 
        MOVXI     R1H,#50975            ; [CPU_FPU] |439| 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+6,R0H ; [CPU_FPU] 
        B         ||$C$L41||,UNC        ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L36||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1458,column 5,is_stmt,isa 0
        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cv_ch1||)+6 ; [CPU_FPU] |1458| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1||+6 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 426,column 9,is_stmt,isa 0
        MOV32     R1H,R0H               ; [CPU_FPU] |426| 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+6,R0H ; [CPU_FPU] |426| 
        MOVW      DP,#||BTS_ctrl_cv_ch1||+2 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1458,column 5,is_stmt,isa 0
        MOV32     R6H,@$BLOCKED(||BTS_ctrl_cv_ch1||)+2 ; [CPU_FPU] |1458| 
        MPYF32    R6H,R3H,R6H           ; [CPU_FPU] |1458| 

        MOV32     R7H,@$BLOCKED(||BTS_ctrl_cv_ch1||)+12 ; [CPU_FPU] |1458| 
||      MPYF32    R4H,R1H,R4H           ; [CPU_FPU] |1458| 

        ADDF32    R6H,R6H,R7H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        SUBF32    R4H,R6H,R4H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch1||)+10,R4H ; [CPU_FPU] |1458| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cv_ch1||)+8 ; [CPU_FPU] |1459| 

        MOV32     R6H,@$BLOCKED(||BTS_ctrl_cv_ch1||)+4 ; [CPU_FPU] |1459| 
||      MPYF32    R4H,R1H,R4H           ; [CPU_FPU] |1459| 

        MPYF32    R6H,R3H,R6H           ; [CPU_FPU] |1459| 
        NOP       ; [CPU_ALU] 
        SUBF32    R4H,R6H,R4H           ; [CPU_FPU] |1459| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch1||)+12,R4H ; [CPU_FPU] |1459| 
||$C$L37||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 446,column 5,is_stmt,isa 0
        MOVIZ     R4H,#47747            ; [CPU_FPU] |446| 
        MOVXI     R4H,#4719             ; [CPU_FPU] |446| 
        CMPF32    R3H,R4H               ; [CPU_FPU] |446| 
        MOVST0    ZF, NF                ; [CPU_FPU] |446| 
        B         ||$C$L39||,LT         ; [CPU_ALU] |446| 
        ; branchcc occurs ; [] |446| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 450,column 10,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |450| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |450| 
        CMPF32    R3H,R0H               ; [CPU_FPU] |450| 
        MOVST0    ZF, NF                ; [CPU_FPU] |450| 
        B         ||$C$L41||,LEQ        ; [CPU_ALU] |450| 
        ; branchcc occurs ; [] |450| 
||$C$L38||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1||+30 ; [CPU_ARAU] 
        MOV32     R0H,*-SP[6]           ; [CPU_FPU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 454,column 9,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+30,#0 ; [CPU_ALU] |454| 
        B         ||$C$L40||,UNC        ; [CPU_ALU] |454| 
        ; branch occurs ; [] |454| 
||$C$L39||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1||+30 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 448,column 9,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+30,#1,UNC ; [CPU_ALU] |448| 
||$C$L40||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 447,column 9,is_stmt,isa 0
        MPYF32    R1H,R0H,R5H           ; [CPU_FPU] |447| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+6,R1H ; [CPU_FPU] |447| 
||$C$L41||:    
        MOVW      DP,#||BTS_ctrl_cc_ch1|| ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 473,column 5,is_stmt,isa 0

        MOV32     R3H,@$BLOCKED(||BTS_ctrl_cc_ch1||) ; [CPU_FPU] |1447| 
||      SUBF32    R1H,R1H,R2H           ; [CPU_FPU] |473| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16140            ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 475,column 5,is_stmt,isa 0
        MOVB      XAR0,#16              ; [CPU_ALU] |475| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVB      XAR1,#16              ; [CPU_ALU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0

        MPYF32    R3H,R1H,R3H           ; [CPU_FPU] |1447| 
||      MOV32     R2H,@$BLOCKED(||BTS_ctrl_cc_ch1||)+10 ; [CPU_FPU] |1447| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVB      AL,#1                 ; [CPU_ALU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0
        ADDF32    R2H,R2H,R3H           ; [CPU_FPU] |1447| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 475,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R2H       ; [CPU_FPU] |475| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVIZ     R3H,#16140            ; [CPU_FPU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 473,column 5,is_stmt,isa 0
        MOVB      XAR0,#18              ; [CPU_ALU] |473| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MINF32    R0H,R2H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVXI     R3H,#52429            ; [CPU_FPU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MAXF32    R0H,#0                ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 473,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R1H       ; [CPU_FPU] |473| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR1],R0H       ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        CMPF32    R2H,R3H               ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L42||,GEQ        ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
        CMPF32    R2H,#0                ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L44||,GT         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
||$C$L42||:    
        CMPB      AL,#0                 ; [CPU_ALU] |1703| 
        B         ||$C$L44||,EQ         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 488,column 13,is_stmt,isa 0
        CMPF32    R0H,#0                ; [CPU_FPU] |488| 
        MOVST0    ZF, NF                ; [CPU_FPU] |488| 
        B         ||$C$L43||,GT         ; [CPU_ALU] |488| 
        ; branchcc occurs ; [] |488| 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        UI32TOF32 R1H,@||MEP_ScaleFactor|| ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        MPYF32    R1H,R1H,#0            ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        F32TOUI16 R1H,R1H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x406b),AR6       ; [CPU_ALU] |2406| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOV32     ACC,R1H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 492,column 17,is_stmt,isa 0
        ZERO      R1H                   ; [CPU_FPU] |492| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      AH,#0                 ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x406a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 492,column 17,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch1||),R1H ; [CPU_FPU] |492| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x406d),AH        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x406c),AL        ; [CPU_ALU] |1262| 
||$C$L43||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 494,column 13,is_stmt,isa 0
        MOVIZ     R1H,#16140            ; [CPU_FPU] |494| 
        MOVXI     R1H,#52429            ; [CPU_FPU] |494| 
        CMPF32    R0H,R1H               ; [CPU_FPU] |494| 
        MOVST0    ZF, NF                ; [CPU_FPU] |494| 
        B         ||$C$L51||,LT         ; [CPU_ALU] |494| 
        ; branchcc occurs ; [] |494| 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOVIZ     R0H,#16102            ; [CPU_FPU] |192| 
        UI32TOF32 R1H,@||MEP_ScaleFactor|| ; [CPU_FPU] |192| 
        MOVXI     R0H,#26624            ; [CPU_FPU] |192| 
        MPYF32    R0H,R0H,R1H           ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVL      XAR6,#549             ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        F32TOUI16 R0H,R0H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x406b),AR6       ; [CPU_ALU] |2406| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOV32     ACC,R0H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        MOVIZ     R0H,#16140            ; [CPU_FPU] |498| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       AH,#549               ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x406a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |498| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x406d),AH        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch1||),R0H ; [CPU_FPU] |498| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x406c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        B         ||$C$L51||,UNC        ; [CPU_ALU] |498| 
        ; branch occurs ; [] |498| 
||$C$L44||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1||+31 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 364,column 5,is_stmt,isa 0
        MOV       AL,@$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+31 ; [CPU_ALU] |364| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 479,column 13,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch1||),R0H ; [CPU_FPU] |479| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 364,column 5,is_stmt,isa 0
        B         ||$C$L46||,NEQ        ; [CPU_ALU] |364| 
        ; branchcc occurs ; [] |364| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 381,column 9,is_stmt,isa 0
        CMP       AR6,#28842            ; [CPU_ALU] |381| 
        B         ||$C$L45||,GEQ        ; [CPU_ALU] |381| 
        ; branchcc occurs ; [] |381| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3032,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4149)        ; [CPU_ALU] |3032| 
        AND       AL,#0xfffc            ; [CPU_ALU] |3032| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 389,column 13,is_stmt,isa 0
        B         ||$C$L47||,UNC        ; [CPU_ALU] |389| 
        ; branch occurs ; [] |389| 
||$C$L45||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3032,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4049)        ; [CPU_ALU] |3032| 
        AND       AL,AL,#0xfffc         ; [CPU_ALU] |3032| 
        ORB       AL,#0x01              ; [CPU_ALU] |3032| 
        B         ||$C$L49||,UNC        ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L46||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 367,column 9,is_stmt,isa 0
        CMP       AR6,#-28841           ; [CPU_ALU] |367| 
        B         ||$C$L48||,LT         ; [CPU_ALU] |367| 
        ; branchcc occurs ; [] |367| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3038,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4149)        ; [CPU_ALU] |3038| 
        AND       AL,#0xfff3            ; [CPU_ALU] |3038| 
||$C$L47||:    
        MOV       *(0:0x4149),AL        ; [CPU_ALU] |3038| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 375,column 13,is_stmt,isa 0
        B         ||$C$L50||,UNC        ; [CPU_ALU] |375| 
        ; branch occurs ; [] |375| 
||$C$L48||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3038,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4049)        ; [CPU_ALU] |3038| 
        AND       AL,AL,#0xfffb         ; [CPU_ALU] |3038| 
        ORB       AL,#0x08              ; [CPU_ALU] |3038| 
||$C$L49||:    
        MOV       *(0:0x4049),AL        ; [CPU_ALU] |3038| 
||$C$L50||:    
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOVIZ     R2H,#17529            ; [CPU_FPU] |192| 
        MOVXI     R2H,#49152            ; [CPU_FPU] |192| 
        MPYF32    R2H,R2H,R0H           ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        F32TOUI16 R3H,R2H               ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MOV32     XAR6,R3H              ; [CPU_FPU] |192| 
        MOVU      ACC,AR6               ; [CPU_ALU] |192| 
        MOV32     R3H,ACC               ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
        UI32TOF32 R3H,R3H               ; [CPU_FPU] |192| 
        UI32TOF32 R4H,@||MEP_ScaleFactor|| ; [CPU_FPU] |192| 
        SUBF32    R2H,R2H,R3H           ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        MPYF32    R2H,R4H,R2H           ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        F32TOUI16 R2H,R2H               ; [CPU_FPU] |192| 
        MOVW      DP,#||BTS_ctrl_cc_ch1||+6 ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x406b),AR6       ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOV32     ACC,R2H               ; [CPU_FPU] |192| 
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
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+10,R2H ; [CPU_FPU] |1458| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     R2H,@$BLOCKED(||BTS_ctrl_cc_ch1||)+8 ; [CPU_FPU] |1459| 

        MOV32     R3H,@$BLOCKED(||BTS_ctrl_cc_ch1||)+4 ; [CPU_FPU] |1459| 
||      MPYF32    R2H,R0H,R2H           ; [CPU_FPU] |1459| 

        MPYF32    R1H,R1H,R3H           ; [CPU_FPU] |1459| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1||+26 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 395,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+28,R0H ; [CPU_FPU] |395| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 394,column 5,is_stmt,isa 0

        SUBF32    R1H,R1H,R2H           ; [CPU_FPU] |1459| 
||      MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+26,R0H ; [CPU_FPU] |394| 

        MOVW      DP,#||BTS_ctrl_cc_ch1||+12 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+12,R1H ; [CPU_FPU] |1459| 
||$C$L51||:    
        MOVW      DP,#||BTS_ADC1||+6    ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 349,column 5,is_stmt,isa 0
        MOVB      XAR0,#72              ; [CPU_ALU] |349| 
        MOVL      XAR4,#||BTS_measValues_ch2|| ; [CPU_ARAU] |349| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 348,column 105,is_stmt,isa 0
        MOVL      XAR7,@$BLOCKED(||BTS_ADC1||)+6 ; [CPU_ALU] |348| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 349,column 5,is_stmt,isa 0
        MOV       PL,*+XAR4[AR0]        ; [CPU_ALU] |349| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 348,column 105,is_stmt,isa 0
        MOV       AL,PL                 ; [CPU_ALU] |348| 
        MOVL      XAR6,@$BLOCKED(||BTS_ADC1||)+8 ; [CPU_ALU] |348| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 349,column 5,is_stmt,isa 0
        CMPB      AL,#32                ; [CPU_ALU] |349| 
        B         ||$C$L52||,LO         ; [CPU_ALU] |349| 
        ; branchcc occurs ; [] |349| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 355,column 9,is_stmt,isa 0
        MOVB      XAR0,#72              ; [CPU_ALU] |355| 
        MOV       *+XAR4[AR0],#0        ; [CPU_ALU] |355| 
        B         ||$C$L53||,UNC        ; [CPU_ALU] |355| 
        ; branch occurs ; [] |355| 
||$C$L52||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 350,column 9,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |350| 
        ADDU      ACC,PL                ; [CPU_ALU] |350| 
        MOVL      XAR5,ACC              ; [CPU_ALU] |350| 
        MOVW      DP,#||BTS_measValues_ch2||+72 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 351,column 9,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |351| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 350,column 9,is_stmt,isa 0
        MOV       *+XAR5[4],AR7         ; [CPU_ALU] |350| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 351,column 9,is_stmt,isa 0
        ADDU      ACC,@$BLOCKED(||BTS_measValues_ch2||)+72 ; [CPU_ALU] |351| 
        MOVL      XAR4,ACC              ; [CPU_ALU] |351| 
        MOVB      XAR0,#36              ; [CPU_ALU] |351| 
        MOV       *+XAR4[AR0],AR6       ; [CPU_ALU] |351| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 352,column 9,is_stmt,isa 0
        INC       @$BLOCKED(||BTS_measValues_ch2||)+72 ; [CPU_ALU] |352| 
||$C$L53||:    
        MOVW      DP,#||BTS_ADC1||+6    ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 400,column 189,is_stmt,isa 0
        MOVL      XAR6,@$BLOCKED(||BTS_ADC1||)+6 ; [CPU_ALU] |400| 
        MOVL      XAR7,@$BLOCKED(||BTS_ADC1||)+8 ; [CPU_ALU] |400| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2||+34 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 323,column 5,is_stmt,isa 0
        MOV       AH,@$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+34 ; [CPU_ALU] |323| 
        B         ||$C$L54||,NEQ        ; [CPU_ALU] |323| 
        ; branchcc occurs ; [] |323| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4492,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |4492| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4493,column 5,is_stmt,isa 0
        MOV       AH,*(0:0x4197)        ; [CPU_ALU] |4493| 
        ORB       AH,#0x04              ; [CPU_ALU] |4493| 
        MOV       *(0:0x4197),AH        ; [CPU_ALU] |4493| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4494,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |4494| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 340,column 9,is_stmt,isa 0
        B         ||$C$L55||,UNC        ; [CPU_ALU] |340| 
        ; branch occurs ; [] |340| 
||$C$L54||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4606,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |4606| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4607,column 5,is_stmt,isa 0
        MOV       AH,*(0:0x419b)        ; [CPU_ALU] |4607| 
        ORB       AH,#0x04              ; [CPU_ALU] |4607| 
        MOV       *(0:0x419b),AH        ; [CPU_ALU] |4607| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4057,column 5,is_stmt,isa 0
        MOV       AH,*(0:0x4184)        ; [CPU_ALU] |4057| 
        AND       AH,AH,#0xfffe         ; [CPU_ALU] |4057| 
        ORB       AH,#0x02              ; [CPU_ALU] |4057| 
        MOV       *(0:0x4184),AH        ; [CPU_ALU] |4057| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4060,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |4060| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       AL,#999               ; [CPU_ALU] |2406| 
        MOVB      AH,#0                 ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 334,column 9,is_stmt,isa 0
        ZERO      R1H                   ; [CPU_FPU] |334| 
        MOVW      DP,#||BTS_ctrl_cc_ch2||+10 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 335,column 9,is_stmt,isa 0
        ZERO      R0H                   ; [CPU_FPU] |335| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x416b),AH        ; [CPU_ALU] |2406| 
        MOV       *(0:0x416d),AL        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x416a),AH        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x416c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 334,column 9,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||)+10,R1H ; [CPU_FPU] |334| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 335,column 9,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||)+12,R0H ; [CPU_FPU] |335| 
||$C$L55||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2||+4 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOV       ACC,AR6               ; [CPU_ALU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        MOV32     R1H,@$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+4 ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOV32     R2H,ACC               ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        MOV32     R6H,R1H               ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 418,column 5,is_stmt,isa 0
        MOV32     R7H,@$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+10 ; [CPU_FPU] |418| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 420,column 5,is_stmt,isa 0
        MOV32     R5H,@$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+24 ; [CPU_FPU] |420| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV       ACC,AR7               ; [CPU_ALU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        NEGF32    R6H,R6H               ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 421,column 5,is_stmt,isa 0
        MOVB      XAR0,#20              ; [CPU_ALU] |421| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_ctrlLoopVariable_ch2|| ; [CPU_ARAU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV32     R0H,ACC               ; [CPU_FPU] |409| 
        MOVW      DP,#||BTS_ctrl_cv_ch2|| ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        MOV32     *-SP[8],R6H           ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVB      XAR1,#20              ; [CPU_ALU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        I32TOF32  R2H,R2H               ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        I32TOF32  R0H,R0H               ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOV32     R6H,R1H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MPYF32    R0H,R0H,#14336        ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVB      AL,#1                 ; [CPU_ALU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 420,column 5,is_stmt,isa 0
        SUBF32    R3H,R7H,R0H           ; [CPU_FPU] |420| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MPYF32    R2H,R2H,#14336        ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0

        MPYF32    R3H,R5H,R3H           ; [CPU_FPU] |420| 
||      MOV32     *-SP[4],R0H           ; [CPU_FPU] |409| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0
        MOV32     R0H,@$BLOCKED(||BTS_ctrl_cv_ch2||) ; [CPU_FPU] |1447| 
        MPYF32    R0H,R3H,R0H           ; [CPU_FPU] |1447| 
        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cv_ch2||)+10 ; [CPU_FPU] |1447| 

        ADDF32    R4H,R4H,R0H           ; [CPU_FPU] |1447| 
||      MOV32     *-SP[6],R1H           ; [CPU_FPU] |1697| 

        MOV32     R0H,*-SP[8]           ; [CPU_FPU] |1447| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 421,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R4H       ; [CPU_FPU] |421| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MINF32    R6H,R4H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 418,column 5,is_stmt,isa 0
        MOVB      XAR0,#12              ; [CPU_ALU] |418| 
        MOV32     *+XAR4[AR0],R7H       ; [CPU_FPU] |418| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MAXF32    R0H,R6H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOVB      XAR0,#8               ; [CPU_ALU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV32     R6H,*-SP[4]           ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R2H       ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOVB      XAR0,#14              ; [CPU_ALU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR1],R0H       ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R6H       ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 420,column 5,is_stmt,isa 0
        MOVB      XAR0,#22              ; [CPU_ALU] |420| 
        MOV32     *+XAR4[AR0],R3H       ; [CPU_FPU] |420| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        CMPF32    R4H,R1H               ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L56||,GEQ        ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
        MOV32     R1H,*-SP[8]           ; [CPU_FPU] 
        CMPF32    R4H,R1H               ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L59||,GT         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
||$C$L56||:    
        CMPB      AL,#0                 ; [CPU_ALU] |1703| 
        B         ||$C$L59||,EQ         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 433,column 10,is_stmt,isa 0
        MOVIZ     R1H,#48955            ; [CPU_FPU] |433| 
        MOVXI     R1H,#46601            ; [CPU_FPU] |433| 
        CMPF32    R0H,R1H               ; [CPU_FPU] |433| 
        MOVST0    ZF, NF                ; [CPU_FPU] |433| 
        B         ||$C$L57||,LEQ        ; [CPU_ALU] |433| 
        ; branchcc occurs ; [] |433| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2||+6 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 437,column 14,is_stmt,isa 0
        MOVIZ     R4H,#16187            ; [CPU_FPU] |437| 
        MOV32     R1H,@$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+6 ; [CPU_FPU] 
        MOVXI     R4H,#50975            ; [CPU_FPU] |437| 
        CMPF32    R0H,R4H               ; [CPU_FPU] |437| 
        MOVST0    ZF, NF                ; [CPU_FPU] |437| 
        B         ||$C$L58||,GEQ        ; [CPU_ALU] |437| 
        ; branchcc occurs ; [] |437| 
        B         ||$C$L60||,UNC        ; [CPU_ALU] |437| 
        ; branch occurs ; [] |437| 
||$C$L57||:    
        MOVIZ     R1H,#16187            ; [CPU_FPU] |437| 
        MOVXI     R1H,#50975            ; [CPU_FPU] |437| 
        CMPF32    R0H,R1H               ; [CPU_FPU] |437| 
        MOVST0    ZF, NF                ; [CPU_FPU] |437| 
        B         ||$C$L58||,GEQ        ; [CPU_ALU] |437| 
        ; branchcc occurs ; [] |437| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 446,column 5,is_stmt,isa 0
        MOVIZ     R1H,#47747            ; [CPU_FPU] |446| 
        MOVIZ     R4H,#48955            ; [CPU_FPU] 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2||+6 ; [CPU_ARAU] 
        MOVXI     R1H,#4719             ; [CPU_FPU] |446| 
        MOVXI     R4H,#46601            ; [CPU_FPU] 
        CMPF32    R3H,R1H               ; [CPU_FPU] |446| 
        MOVST0    ZF, NF                ; [CPU_FPU] |446| 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+6,R4H ; [CPU_FPU] 
        B         ||$C$L62||,LT         ; [CPU_ALU] |446| 
        ; branchcc occurs ; [] |446| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 450,column 10,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |450| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |450| 
        CMPF32    R3H,R0H               ; [CPU_FPU] |450| 
        MOVST0    ZF, NF                ; [CPU_FPU] |450| 
        B         ||$C$L61||,GT         ; [CPU_ALU] |450| 
        ; branchcc occurs ; [] |450| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 435,column 14,is_stmt,isa 0
        MOVIZ     R1H,#48955            ; [CPU_FPU] |435| 
        MOVXI     R1H,#46601            ; [CPU_FPU] |435| 
        B         ||$C$L64||,UNC        ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L58||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 446,column 5,is_stmt,isa 0
        MOVIZ     R1H,#47747            ; [CPU_FPU] |446| 
        MOVXI     R1H,#4719             ; [CPU_FPU] |446| 
        CMPF32    R3H,R1H               ; [CPU_FPU] |446| 
        MOVST0    ZF, NF                ; [CPU_FPU] |446| 
        B         ||$C$L62||,LT         ; [CPU_ALU] |446| 
        ; branchcc occurs ; [] |446| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 450,column 10,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |450| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |450| 
        CMPF32    R3H,R0H               ; [CPU_FPU] |450| 
        MOVST0    ZF, NF                ; [CPU_FPU] |450| 
        B         ||$C$L61||,GT         ; [CPU_ALU] |450| 
        ; branchcc occurs ; [] |450| 
        MOVIZ     R0H,#16187            ; [CPU_FPU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 439,column 18,is_stmt,isa 0
        MOVIZ     R1H,#16187            ; [CPU_FPU] |439| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2||+6 ; [CPU_ARAU] 
        MOVXI     R0H,#50975            ; [CPU_FPU] 
        MOVXI     R1H,#50975            ; [CPU_FPU] |439| 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+6,R0H ; [CPU_FPU] 
        B         ||$C$L64||,UNC        ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L59||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1458,column 5,is_stmt,isa 0
        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cv_ch2||)+6 ; [CPU_FPU] |1458| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2||+6 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 426,column 9,is_stmt,isa 0
        MOV32     R1H,R0H               ; [CPU_FPU] |426| 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+6,R0H ; [CPU_FPU] |426| 
        MOVW      DP,#||BTS_ctrl_cv_ch2||+2 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1458,column 5,is_stmt,isa 0
        MOV32     R6H,@$BLOCKED(||BTS_ctrl_cv_ch2||)+2 ; [CPU_FPU] |1458| 
        MPYF32    R6H,R3H,R6H           ; [CPU_FPU] |1458| 

        MOV32     R7H,@$BLOCKED(||BTS_ctrl_cv_ch2||)+12 ; [CPU_FPU] |1458| 
||      MPYF32    R4H,R1H,R4H           ; [CPU_FPU] |1458| 

        ADDF32    R6H,R6H,R7H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        SUBF32    R4H,R6H,R4H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch2||)+10,R4H ; [CPU_FPU] |1458| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cv_ch2||)+8 ; [CPU_FPU] |1459| 

        MOV32     R6H,@$BLOCKED(||BTS_ctrl_cv_ch2||)+4 ; [CPU_FPU] |1459| 
||      MPYF32    R4H,R1H,R4H           ; [CPU_FPU] |1459| 

        MPYF32    R6H,R3H,R6H           ; [CPU_FPU] |1459| 
        NOP       ; [CPU_ALU] 
        SUBF32    R4H,R6H,R4H           ; [CPU_FPU] |1459| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch2||)+12,R4H ; [CPU_FPU] |1459| 
||$C$L60||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 446,column 5,is_stmt,isa 0
        MOVIZ     R4H,#47747            ; [CPU_FPU] |446| 
        MOVXI     R4H,#4719             ; [CPU_FPU] |446| 
        CMPF32    R3H,R4H               ; [CPU_FPU] |446| 
        MOVST0    ZF, NF                ; [CPU_FPU] |446| 
        B         ||$C$L62||,LT         ; [CPU_ALU] |446| 
        ; branchcc occurs ; [] |446| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 450,column 10,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |450| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |450| 
        CMPF32    R3H,R0H               ; [CPU_FPU] |450| 
        MOVST0    ZF, NF                ; [CPU_FPU] |450| 
        B         ||$C$L64||,LEQ        ; [CPU_ALU] |450| 
        ; branchcc occurs ; [] |450| 
||$C$L61||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2||+30 ; [CPU_ARAU] 
        MOV32     R0H,*-SP[6]           ; [CPU_FPU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 454,column 9,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+30,#0 ; [CPU_ALU] |454| 
        B         ||$C$L63||,UNC        ; [CPU_ALU] |454| 
        ; branch occurs ; [] |454| 
||$C$L62||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2||+30 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 448,column 9,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+30,#1,UNC ; [CPU_ALU] |448| 
||$C$L63||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 447,column 9,is_stmt,isa 0
        MPYF32    R1H,R0H,R5H           ; [CPU_FPU] |447| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+6,R1H ; [CPU_FPU] |447| 
||$C$L64||:    
        MOVW      DP,#||BTS_ctrl_cc_ch2|| ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 473,column 5,is_stmt,isa 0

        MOV32     R3H,@$BLOCKED(||BTS_ctrl_cc_ch2||) ; [CPU_FPU] |1447| 
||      SUBF32    R1H,R1H,R2H           ; [CPU_FPU] |473| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16140            ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 475,column 5,is_stmt,isa 0
        MOVB      XAR0,#16              ; [CPU_ALU] |475| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVB      XAR1,#16              ; [CPU_ALU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0

        MPYF32    R3H,R1H,R3H           ; [CPU_FPU] |1447| 
||      MOV32     R2H,@$BLOCKED(||BTS_ctrl_cc_ch2||)+10 ; [CPU_FPU] |1447| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVB      AL,#1                 ; [CPU_ALU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0
        ADDF32    R2H,R2H,R3H           ; [CPU_FPU] |1447| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 475,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R2H       ; [CPU_FPU] |475| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVIZ     R3H,#16140            ; [CPU_FPU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 473,column 5,is_stmt,isa 0
        MOVB      XAR0,#18              ; [CPU_ALU] |473| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MINF32    R0H,R2H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVXI     R3H,#52429            ; [CPU_FPU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MAXF32    R0H,#0                ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 473,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R1H       ; [CPU_FPU] |473| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR1],R0H       ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        CMPF32    R2H,R3H               ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L65||,GEQ        ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
        CMPF32    R2H,#0                ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L67||,GT         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
||$C$L65||:    
        CMPB      AL,#0                 ; [CPU_ALU] |1703| 
        B         ||$C$L67||,EQ         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 488,column 13,is_stmt,isa 0
        CMPF32    R0H,#0                ; [CPU_FPU] |488| 
        MOVST0    ZF, NF                ; [CPU_FPU] |488| 
        B         ||$C$L66||,GT         ; [CPU_ALU] |488| 
        ; branchcc occurs ; [] |488| 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        UI32TOF32 R1H,@||MEP_ScaleFactor|| ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        MPYF32    R1H,R1H,#0            ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        F32TOUI16 R1H,R1H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x416b),AR6       ; [CPU_ALU] |2406| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOV32     ACC,R1H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 492,column 17,is_stmt,isa 0
        ZERO      R1H                   ; [CPU_FPU] |492| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      AH,#0                 ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x416a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 492,column 17,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch2||),R1H ; [CPU_FPU] |492| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x416d),AH        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x416c),AL        ; [CPU_ALU] |1262| 
||$C$L66||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 494,column 13,is_stmt,isa 0
        MOVIZ     R1H,#16140            ; [CPU_FPU] |494| 
        MOVXI     R1H,#52429            ; [CPU_FPU] |494| 
        CMPF32    R0H,R1H               ; [CPU_FPU] |494| 
        MOVST0    ZF, NF                ; [CPU_FPU] |494| 
        B         ||$C$L72||,LT         ; [CPU_ALU] |494| 
        ; branchcc occurs ; [] |494| 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOVIZ     R0H,#16102            ; [CPU_FPU] |192| 
        UI32TOF32 R1H,@||MEP_ScaleFactor|| ; [CPU_FPU] |192| 
        MOVXI     R0H,#26624            ; [CPU_FPU] |192| 
        MPYF32    R0H,R0H,R1H           ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVL      XAR6,#549             ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        F32TOUI16 R0H,R0H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x416b),AR6       ; [CPU_ALU] |2406| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOV32     ACC,R0H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        MOVIZ     R0H,#16140            ; [CPU_FPU] |498| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       AH,#549               ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x416a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |498| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x416d),AH        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch2||),R0H ; [CPU_FPU] |498| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x416c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        B         ||$C$L72||,UNC        ; [CPU_ALU] |498| 
        ; branch occurs ; [] |498| 
||$C$L67||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2||+31 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 364,column 5,is_stmt,isa 0
        MOV       AL,@$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+31 ; [CPU_ALU] |364| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 479,column 13,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch2||),R0H ; [CPU_FPU] |479| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 364,column 5,is_stmt,isa 0
        B         ||$C$L69||,NEQ        ; [CPU_ALU] |364| 
        ; branchcc occurs ; [] |364| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 381,column 9,is_stmt,isa 0
        CMP       AR6,#28842            ; [CPU_ALU] |381| 
        B         ||$C$L68||,GEQ        ; [CPU_ALU] |381| 
        ; branchcc occurs ; [] |381| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3032,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4149)        ; [CPU_ALU] |3032| 
        AND       AL,#0xfffc            ; [CPU_ALU] |3032| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 389,column 13,is_stmt,isa 0
        B         ||$C$L71||,UNC        ; [CPU_ALU] |389| 
        ; branch occurs ; [] |389| 
||$C$L68||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3032,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4149)        ; [CPU_ALU] |3032| 
        AND       AL,AL,#0xfffc         ; [CPU_ALU] |3032| 
        ORB       AL,#0x01              ; [CPU_ALU] |3032| 
        B         ||$C$L71||,UNC        ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L69||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 367,column 9,is_stmt,isa 0
        CMP       AR6,#-28841           ; [CPU_ALU] |367| 
        B         ||$C$L70||,LT         ; [CPU_ALU] |367| 
        ; branchcc occurs ; [] |367| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3038,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4149)        ; [CPU_ALU] |3038| 
        AND       AL,#0xfff3            ; [CPU_ALU] |3038| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 375,column 13,is_stmt,isa 0
        B         ||$C$L71||,UNC        ; [CPU_ALU] |375| 
        ; branch occurs ; [] |375| 
||$C$L70||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3038,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4149)        ; [CPU_ALU] |3038| 
        AND       AL,AL,#0xfffb         ; [CPU_ALU] |3038| 
        ORB       AL,#0x08              ; [CPU_ALU] |3038| 
||$C$L71||:    
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOVIZ     R2H,#17529            ; [CPU_FPU] |192| 
        MOVXI     R2H,#49152            ; [CPU_FPU] |192| 
        MPYF32    R2H,R2H,R0H           ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        F32TOUI16 R3H,R2H               ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MOV32     XAR6,R3H              ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3038,column 9,is_stmt,isa 0
        MOV       *(0:0x4149),AL        ; [CPU_ALU] |3038| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOVU      ACC,AR6               ; [CPU_ALU] |192| 
        MOV32     R3H,ACC               ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
        UI32TOF32 R3H,R3H               ; [CPU_FPU] |192| 
        UI32TOF32 R4H,@||MEP_ScaleFactor|| ; [CPU_FPU] |192| 
        SUBF32    R2H,R2H,R3H           ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        MPYF32    R2H,R4H,R2H           ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        F32TOUI16 R2H,R2H               ; [CPU_FPU] |192| 
        MOVW      DP,#||BTS_ctrl_cc_ch2||+6 ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x416b),AR6       ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOV32     ACC,R2H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
        MOV       *(0:0x416a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x416d),AR6       ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x416c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1458,column 5,is_stmt,isa 0
        MOV32     R2H,@$BLOCKED(||BTS_ctrl_cc_ch2||)+6 ; [CPU_FPU] |1458| 
        MOV32     R3H,@$BLOCKED(||BTS_ctrl_cc_ch2||)+2 ; [CPU_FPU] |1458| 
        MPYF32    R3H,R1H,R3H           ; [CPU_FPU] |1458| 

        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cc_ch2||)+12 ; [CPU_FPU] |1458| 
||      MPYF32    R2H,R0H,R2H           ; [CPU_FPU] |1458| 

        ADDF32    R3H,R3H,R4H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        SUBF32    R2H,R3H,R2H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||)+10,R2H ; [CPU_FPU] |1458| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     R2H,@$BLOCKED(||BTS_ctrl_cc_ch2||)+8 ; [CPU_FPU] |1459| 

        MOV32     R3H,@$BLOCKED(||BTS_ctrl_cc_ch2||)+4 ; [CPU_FPU] |1459| 
||      MPYF32    R2H,R0H,R2H           ; [CPU_FPU] |1459| 

        MPYF32    R1H,R1H,R3H           ; [CPU_FPU] |1459| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2||+26 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 395,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+28,R0H ; [CPU_FPU] |395| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 394,column 5,is_stmt,isa 0

        SUBF32    R1H,R1H,R2H           ; [CPU_FPU] |1459| 
||      MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+26,R0H ; [CPU_FPU] |394| 

        MOVW      DP,#||BTS_ctrl_cc_ch2||+12 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||)+12,R1H ; [CPU_FPU] |1459| 
||$C$L72||:    
        MOVW      DP,#||BTS_ADC1||+10   ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 349,column 5,is_stmt,isa 0
        MOVB      XAR0,#72              ; [CPU_ALU] |349| 
        MOVL      XAR4,#||BTS_measValues_ch3|| ; [CPU_ARAU] |349| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 348,column 105,is_stmt,isa 0
        MOVL      XAR7,@$BLOCKED(||BTS_ADC1||)+10 ; [CPU_ALU] |348| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 349,column 5,is_stmt,isa 0
        MOV       PL,*+XAR4[AR0]        ; [CPU_ALU] |349| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 348,column 105,is_stmt,isa 0
        MOV       AL,PL                 ; [CPU_ALU] |348| 
        MOVL      XAR6,@$BLOCKED(||BTS_ADC1||)+12 ; [CPU_ALU] |348| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 349,column 5,is_stmt,isa 0
        CMPB      AL,#32                ; [CPU_ALU] |349| 
        B         ||$C$L73||,LO         ; [CPU_ALU] |349| 
        ; branchcc occurs ; [] |349| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 355,column 9,is_stmt,isa 0
        MOVB      XAR0,#72              ; [CPU_ALU] |355| 
        MOV       *+XAR4[AR0],#0        ; [CPU_ALU] |355| 
        B         ||$C$L74||,UNC        ; [CPU_ALU] |355| 
        ; branch occurs ; [] |355| 
||$C$L73||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 350,column 9,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |350| 
        ADDU      ACC,PL                ; [CPU_ALU] |350| 
        MOVL      XAR5,ACC              ; [CPU_ALU] |350| 
        MOVW      DP,#||BTS_measValues_ch3||+72 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 351,column 9,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |351| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 350,column 9,is_stmt,isa 0
        MOV       *+XAR5[4],AR7         ; [CPU_ALU] |350| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 351,column 9,is_stmt,isa 0
        ADDU      ACC,@$BLOCKED(||BTS_measValues_ch3||)+72 ; [CPU_ALU] |351| 
        MOVL      XAR4,ACC              ; [CPU_ALU] |351| 
        MOVB      XAR0,#36              ; [CPU_ALU] |351| 
        MOV       *+XAR4[AR0],AR6       ; [CPU_ALU] |351| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 352,column 9,is_stmt,isa 0
        INC       @$BLOCKED(||BTS_measValues_ch3||)+72 ; [CPU_ALU] |352| 
||$C$L74||:    
        MOVW      DP,#||BTS_ADC1||+10   ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 400,column 189,is_stmt,isa 0
        MOVL      XAR6,@$BLOCKED(||BTS_ADC1||)+10 ; [CPU_ALU] |400| 
        MOVL      XAR7,@$BLOCKED(||BTS_ADC1||)+12 ; [CPU_ALU] |400| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3||+34 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 323,column 5,is_stmt,isa 0
        MOV       AH,@$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+34 ; [CPU_ALU] |323| 
        B         ||$C$L75||,NEQ        ; [CPU_ALU] |323| 
        ; branchcc occurs ; [] |323| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4492,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |4492| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4493,column 5,is_stmt,isa 0
        MOV       AH,*(0:0x4297)        ; [CPU_ALU] |4493| 
        ORB       AH,#0x04              ; [CPU_ALU] |4493| 
        MOV       *(0:0x4297),AH        ; [CPU_ALU] |4493| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4494,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |4494| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 340,column 9,is_stmt,isa 0
        B         ||$C$L76||,UNC        ; [CPU_ALU] |340| 
        ; branch occurs ; [] |340| 
||$C$L75||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4606,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |4606| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4607,column 5,is_stmt,isa 0
        MOV       AH,*(0:0x429b)        ; [CPU_ALU] |4607| 
        ORB       AH,#0x04              ; [CPU_ALU] |4607| 
        MOV       *(0:0x429b),AH        ; [CPU_ALU] |4607| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4057,column 5,is_stmt,isa 0
        MOV       AH,*(0:0x4284)        ; [CPU_ALU] |4057| 
        AND       AH,AH,#0xfffe         ; [CPU_ALU] |4057| 
        ORB       AH,#0x02              ; [CPU_ALU] |4057| 
        MOV       *(0:0x4284),AH        ; [CPU_ALU] |4057| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4060,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |4060| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       AL,#999               ; [CPU_ALU] |2406| 
        MOVB      AH,#0                 ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 334,column 9,is_stmt,isa 0
        ZERO      R1H                   ; [CPU_FPU] |334| 
        MOVW      DP,#||BTS_ctrl_cc_ch3||+10 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 335,column 9,is_stmt,isa 0
        ZERO      R0H                   ; [CPU_FPU] |335| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x426b),AH        ; [CPU_ALU] |2406| 
        MOV       *(0:0x426d),AL        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x426a),AH        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x426c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 334,column 9,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||)+10,R1H ; [CPU_FPU] |334| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 335,column 9,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||)+12,R0H ; [CPU_FPU] |335| 
||$C$L76||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3||+4 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOV       ACC,AR6               ; [CPU_ALU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        MOV32     R1H,@$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+4 ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOV32     R2H,ACC               ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        MOV32     R6H,R1H               ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 418,column 5,is_stmt,isa 0
        MOV32     R7H,@$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+10 ; [CPU_FPU] |418| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 420,column 5,is_stmt,isa 0
        MOV32     R5H,@$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+24 ; [CPU_FPU] |420| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV       ACC,AR7               ; [CPU_ALU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        NEGF32    R6H,R6H               ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 421,column 5,is_stmt,isa 0
        MOVB      XAR0,#20              ; [CPU_ALU] |421| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_ctrlLoopVariable_ch3|| ; [CPU_ARAU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV32     R0H,ACC               ; [CPU_FPU] |409| 
        MOVW      DP,#||BTS_ctrl_cv_ch3|| ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        MOV32     *-SP[8],R6H           ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVB      XAR1,#20              ; [CPU_ALU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        I32TOF32  R2H,R2H               ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        I32TOF32  R0H,R0H               ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOV32     R6H,R1H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MPYF32    R0H,R0H,#14336        ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVB      AL,#1                 ; [CPU_ALU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 420,column 5,is_stmt,isa 0
        SUBF32    R3H,R7H,R0H           ; [CPU_FPU] |420| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MPYF32    R2H,R2H,#14336        ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0

        MPYF32    R3H,R5H,R3H           ; [CPU_FPU] |420| 
||      MOV32     *-SP[4],R0H           ; [CPU_FPU] |409| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0
        MOV32     R0H,@$BLOCKED(||BTS_ctrl_cv_ch3||) ; [CPU_FPU] |1447| 
        MPYF32    R0H,R3H,R0H           ; [CPU_FPU] |1447| 
        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cv_ch3||)+10 ; [CPU_FPU] |1447| 

        ADDF32    R4H,R4H,R0H           ; [CPU_FPU] |1447| 
||      MOV32     *-SP[6],R1H           ; [CPU_FPU] |1697| 

        MOV32     R0H,*-SP[8]           ; [CPU_FPU] |1447| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 421,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R4H       ; [CPU_FPU] |421| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MINF32    R6H,R4H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 418,column 5,is_stmt,isa 0
        MOVB      XAR0,#12              ; [CPU_ALU] |418| 
        MOV32     *+XAR4[AR0],R7H       ; [CPU_FPU] |418| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MAXF32    R0H,R6H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOVB      XAR0,#8               ; [CPU_ALU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV32     R6H,*-SP[4]           ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R2H       ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOVB      XAR0,#14              ; [CPU_ALU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR1],R0H       ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R6H       ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 420,column 5,is_stmt,isa 0
        MOVB      XAR0,#22              ; [CPU_ALU] |420| 
        MOV32     *+XAR4[AR0],R3H       ; [CPU_FPU] |420| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        CMPF32    R4H,R1H               ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L77||,GEQ        ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
        MOV32     R1H,*-SP[8]           ; [CPU_FPU] 
        CMPF32    R4H,R1H               ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L80||,GT         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
||$C$L77||:    
        CMPB      AL,#0                 ; [CPU_ALU] |1703| 
        B         ||$C$L80||,EQ         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 433,column 10,is_stmt,isa 0
        MOVIZ     R1H,#48955            ; [CPU_FPU] |433| 
        MOVXI     R1H,#46601            ; [CPU_FPU] |433| 
        CMPF32    R0H,R1H               ; [CPU_FPU] |433| 
        MOVST0    ZF, NF                ; [CPU_FPU] |433| 
        B         ||$C$L78||,LEQ        ; [CPU_ALU] |433| 
        ; branchcc occurs ; [] |433| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3||+6 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 437,column 14,is_stmt,isa 0
        MOVIZ     R4H,#16187            ; [CPU_FPU] |437| 
        MOV32     R1H,@$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+6 ; [CPU_FPU] 
        MOVXI     R4H,#50975            ; [CPU_FPU] |437| 
        CMPF32    R0H,R4H               ; [CPU_FPU] |437| 
        MOVST0    ZF, NF                ; [CPU_FPU] |437| 
        B         ||$C$L79||,GEQ        ; [CPU_ALU] |437| 
        ; branchcc occurs ; [] |437| 
        B         ||$C$L81||,UNC        ; [CPU_ALU] |437| 
        ; branch occurs ; [] |437| 
||$C$L78||:    
        MOVIZ     R1H,#16187            ; [CPU_FPU] |437| 
        MOVXI     R1H,#50975            ; [CPU_FPU] |437| 
        CMPF32    R0H,R1H               ; [CPU_FPU] |437| 
        MOVST0    ZF, NF                ; [CPU_FPU] |437| 
        B         ||$C$L79||,GEQ        ; [CPU_ALU] |437| 
        ; branchcc occurs ; [] |437| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 446,column 5,is_stmt,isa 0
        MOVIZ     R1H,#47747            ; [CPU_FPU] |446| 
        MOVIZ     R4H,#48955            ; [CPU_FPU] 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3||+6 ; [CPU_ARAU] 
        MOVXI     R1H,#4719             ; [CPU_FPU] |446| 
        MOVXI     R4H,#46601            ; [CPU_FPU] 
        CMPF32    R3H,R1H               ; [CPU_FPU] |446| 
        MOVST0    ZF, NF                ; [CPU_FPU] |446| 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+6,R4H ; [CPU_FPU] 
        B         ||$C$L83||,LT         ; [CPU_ALU] |446| 
        ; branchcc occurs ; [] |446| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 450,column 10,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |450| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |450| 
        CMPF32    R3H,R0H               ; [CPU_FPU] |450| 
        MOVST0    ZF, NF                ; [CPU_FPU] |450| 
        B         ||$C$L82||,GT         ; [CPU_ALU] |450| 
        ; branchcc occurs ; [] |450| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 435,column 14,is_stmt,isa 0
        MOVIZ     R1H,#48955            ; [CPU_FPU] |435| 
        MOVXI     R1H,#46601            ; [CPU_FPU] |435| 
        B         ||$C$L85||,UNC        ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L79||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 446,column 5,is_stmt,isa 0
        MOVIZ     R1H,#47747            ; [CPU_FPU] |446| 
        MOVXI     R1H,#4719             ; [CPU_FPU] |446| 
        CMPF32    R3H,R1H               ; [CPU_FPU] |446| 
        MOVST0    ZF, NF                ; [CPU_FPU] |446| 
        B         ||$C$L83||,LT         ; [CPU_ALU] |446| 
        ; branchcc occurs ; [] |446| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 450,column 10,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |450| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |450| 
        CMPF32    R3H,R0H               ; [CPU_FPU] |450| 
        MOVST0    ZF, NF                ; [CPU_FPU] |450| 
        B         ||$C$L82||,GT         ; [CPU_ALU] |450| 
        ; branchcc occurs ; [] |450| 
        MOVIZ     R0H,#16187            ; [CPU_FPU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 439,column 18,is_stmt,isa 0
        MOVIZ     R1H,#16187            ; [CPU_FPU] |439| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3||+6 ; [CPU_ARAU] 
        MOVXI     R0H,#50975            ; [CPU_FPU] 
        MOVXI     R1H,#50975            ; [CPU_FPU] |439| 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+6,R0H ; [CPU_FPU] 
        B         ||$C$L85||,UNC        ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L80||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1458,column 5,is_stmt,isa 0
        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cv_ch3||)+6 ; [CPU_FPU] |1458| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3||+6 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 426,column 9,is_stmt,isa 0
        MOV32     R1H,R0H               ; [CPU_FPU] |426| 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+6,R0H ; [CPU_FPU] |426| 
        MOVW      DP,#||BTS_ctrl_cv_ch3||+2 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1458,column 5,is_stmt,isa 0
        MOV32     R6H,@$BLOCKED(||BTS_ctrl_cv_ch3||)+2 ; [CPU_FPU] |1458| 
        MPYF32    R6H,R3H,R6H           ; [CPU_FPU] |1458| 

        MOV32     R7H,@$BLOCKED(||BTS_ctrl_cv_ch3||)+12 ; [CPU_FPU] |1458| 
||      MPYF32    R4H,R1H,R4H           ; [CPU_FPU] |1458| 

        ADDF32    R6H,R6H,R7H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        SUBF32    R4H,R6H,R4H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch3||)+10,R4H ; [CPU_FPU] |1458| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cv_ch3||)+8 ; [CPU_FPU] |1459| 

        MOV32     R6H,@$BLOCKED(||BTS_ctrl_cv_ch3||)+4 ; [CPU_FPU] |1459| 
||      MPYF32    R4H,R1H,R4H           ; [CPU_FPU] |1459| 

        MPYF32    R6H,R3H,R6H           ; [CPU_FPU] |1459| 
        NOP       ; [CPU_ALU] 
        SUBF32    R4H,R6H,R4H           ; [CPU_FPU] |1459| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch3||)+12,R4H ; [CPU_FPU] |1459| 
||$C$L81||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 446,column 5,is_stmt,isa 0
        MOVIZ     R4H,#47747            ; [CPU_FPU] |446| 
        MOVXI     R4H,#4719             ; [CPU_FPU] |446| 
        CMPF32    R3H,R4H               ; [CPU_FPU] |446| 
        MOVST0    ZF, NF                ; [CPU_FPU] |446| 
        B         ||$C$L83||,LT         ; [CPU_ALU] |446| 
        ; branchcc occurs ; [] |446| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 450,column 10,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |450| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |450| 
        CMPF32    R3H,R0H               ; [CPU_FPU] |450| 
        MOVST0    ZF, NF                ; [CPU_FPU] |450| 
        B         ||$C$L85||,LEQ        ; [CPU_ALU] |450| 
        ; branchcc occurs ; [] |450| 
||$C$L82||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3||+30 ; [CPU_ARAU] 
        MOV32     R0H,*-SP[6]           ; [CPU_FPU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 454,column 9,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+30,#0 ; [CPU_ALU] |454| 
        B         ||$C$L84||,UNC        ; [CPU_ALU] |454| 
        ; branch occurs ; [] |454| 
||$C$L83||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3||+30 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 448,column 9,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+30,#1,UNC ; [CPU_ALU] |448| 
||$C$L84||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 447,column 9,is_stmt,isa 0
        MPYF32    R1H,R0H,R5H           ; [CPU_FPU] |447| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+6,R1H ; [CPU_FPU] |447| 
||$C$L85||:    
        MOVW      DP,#||BTS_ctrl_cc_ch3|| ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 473,column 5,is_stmt,isa 0

        MOV32     R3H,@$BLOCKED(||BTS_ctrl_cc_ch3||) ; [CPU_FPU] |1447| 
||      SUBF32    R1H,R1H,R2H           ; [CPU_FPU] |473| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16140            ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 475,column 5,is_stmt,isa 0
        MOVB      XAR0,#16              ; [CPU_ALU] |475| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVB      XAR1,#16              ; [CPU_ALU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0

        MPYF32    R3H,R1H,R3H           ; [CPU_FPU] |1447| 
||      MOV32     R2H,@$BLOCKED(||BTS_ctrl_cc_ch3||)+10 ; [CPU_FPU] |1447| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVB      AL,#1                 ; [CPU_ALU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0
        ADDF32    R2H,R2H,R3H           ; [CPU_FPU] |1447| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 475,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R2H       ; [CPU_FPU] |475| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVIZ     R3H,#16140            ; [CPU_FPU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 473,column 5,is_stmt,isa 0
        MOVB      XAR0,#18              ; [CPU_ALU] |473| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MINF32    R0H,R2H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVXI     R3H,#52429            ; [CPU_FPU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MAXF32    R0H,#0                ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 473,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R1H       ; [CPU_FPU] |473| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR1],R0H       ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        CMPF32    R2H,R3H               ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L86||,GEQ        ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
        CMPF32    R2H,#0                ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L88||,GT         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
||$C$L86||:    
        CMPB      AL,#0                 ; [CPU_ALU] |1703| 
        B         ||$C$L88||,EQ         ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 488,column 13,is_stmt,isa 0
        CMPF32    R0H,#0                ; [CPU_FPU] |488| 
        MOVST0    ZF, NF                ; [CPU_FPU] |488| 
        B         ||$C$L87||,GT         ; [CPU_ALU] |488| 
        ; branchcc occurs ; [] |488| 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        UI32TOF32 R1H,@||MEP_ScaleFactor|| ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        MPYF32    R1H,R1H,#0            ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        F32TOUI16 R1H,R1H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x426b),AR6       ; [CPU_ALU] |2406| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOV32     ACC,R1H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 492,column 17,is_stmt,isa 0
        ZERO      R1H                   ; [CPU_FPU] |492| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      AH,#0                 ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x426a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 492,column 17,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch3||),R1H ; [CPU_FPU] |492| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x426d),AH        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x426c),AL        ; [CPU_ALU] |1262| 
||$C$L87||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 494,column 13,is_stmt,isa 0
        MOVIZ     R1H,#16140            ; [CPU_FPU] |494| 
        MOVXI     R1H,#52429            ; [CPU_FPU] |494| 
        CMPF32    R0H,R1H               ; [CPU_FPU] |494| 
        MOVST0    ZF, NF                ; [CPU_FPU] |494| 
        B         ||$C$L95||,LT         ; [CPU_ALU] |494| 
        ; branchcc occurs ; [] |494| 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOVIZ     R0H,#16102            ; [CPU_FPU] |192| 
        UI32TOF32 R1H,@||MEP_ScaleFactor|| ; [CPU_FPU] |192| 
        MOVXI     R0H,#26624            ; [CPU_FPU] |192| 
        MPYF32    R0H,R0H,R1H           ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVL      XAR6,#549             ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        F32TOUI16 R0H,R0H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x426b),AR6       ; [CPU_ALU] |2406| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOV32     ACC,R0H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        MOVIZ     R0H,#16140            ; [CPU_FPU] |498| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       AH,#549               ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x426a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |498| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x426d),AH        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch3||),R0H ; [CPU_FPU] |498| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x426c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        B         ||$C$L95||,UNC        ; [CPU_ALU] |498| 
        ; branch occurs ; [] |498| 
||$C$L88||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3||+31 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 364,column 5,is_stmt,isa 0
        MOV       AL,@$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+31 ; [CPU_ALU] |364| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 479,column 13,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch3||),R0H ; [CPU_FPU] |479| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 364,column 5,is_stmt,isa 0
        B         ||$C$L90||,NEQ        ; [CPU_ALU] |364| 
        ; branchcc occurs ; [] |364| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 381,column 9,is_stmt,isa 0
        CMP       AR6,#28842            ; [CPU_ALU] |381| 
        B         ||$C$L89||,GEQ        ; [CPU_ALU] |381| 
        ; branchcc occurs ; [] |381| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3032,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4149)        ; [CPU_ALU] |3032| 
        AND       AL,#0xfffc            ; [CPU_ALU] |3032| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 389,column 13,is_stmt,isa 0
        B         ||$C$L91||,UNC        ; [CPU_ALU] |389| 
        ; branch occurs ; [] |389| 
||$C$L89||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3032,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4249)        ; [CPU_ALU] |3032| 
        AND       AL,AL,#0xfffc         ; [CPU_ALU] |3032| 
        ORB       AL,#0x01              ; [CPU_ALU] |3032| 
        B         ||$C$L93||,UNC        ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L90||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 367,column 9,is_stmt,isa 0
        CMP       AR6,#-28841           ; [CPU_ALU] |367| 
        B         ||$C$L92||,LT         ; [CPU_ALU] |367| 
        ; branchcc occurs ; [] |367| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3038,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4149)        ; [CPU_ALU] |3038| 
        AND       AL,#0xfff3            ; [CPU_ALU] |3038| 
||$C$L91||:    
        MOV       *(0:0x4149),AL        ; [CPU_ALU] |3038| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 375,column 13,is_stmt,isa 0
        B         ||$C$L94||,UNC        ; [CPU_ALU] |375| 
        ; branch occurs ; [] |375| 
||$C$L92||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3038,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4249)        ; [CPU_ALU] |3038| 
        AND       AL,AL,#0xfffb         ; [CPU_ALU] |3038| 
        ORB       AL,#0x08              ; [CPU_ALU] |3038| 
||$C$L93||:    
        MOV       *(0:0x4249),AL        ; [CPU_ALU] |3038| 
||$C$L94||:    
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOVIZ     R2H,#17529            ; [CPU_FPU] |192| 
        MOVXI     R2H,#49152            ; [CPU_FPU] |192| 
        MPYF32    R2H,R2H,R0H           ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        F32TOUI16 R3H,R2H               ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MOV32     XAR6,R3H              ; [CPU_FPU] |192| 
        MOVU      ACC,AR6               ; [CPU_ALU] |192| 
        MOV32     R3H,ACC               ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
        UI32TOF32 R3H,R3H               ; [CPU_FPU] |192| 
        UI32TOF32 R4H,@||MEP_ScaleFactor|| ; [CPU_FPU] |192| 
        SUBF32    R2H,R2H,R3H           ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        MPYF32    R2H,R4H,R2H           ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        F32TOUI16 R2H,R2H               ; [CPU_FPU] |192| 
        MOVW      DP,#||BTS_ctrl_cc_ch3||+6 ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x426b),AR6       ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOV32     ACC,R2H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
        MOV       *(0:0x426a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x426d),AR6       ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x426c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1458,column 5,is_stmt,isa 0
        MOV32     R2H,@$BLOCKED(||BTS_ctrl_cc_ch3||)+6 ; [CPU_FPU] |1458| 
        MOV32     R3H,@$BLOCKED(||BTS_ctrl_cc_ch3||)+2 ; [CPU_FPU] |1458| 
        MPYF32    R3H,R1H,R3H           ; [CPU_FPU] |1458| 

        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cc_ch3||)+12 ; [CPU_FPU] |1458| 
||      MPYF32    R2H,R0H,R2H           ; [CPU_FPU] |1458| 

        ADDF32    R3H,R3H,R4H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        SUBF32    R2H,R3H,R2H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||)+10,R2H ; [CPU_FPU] |1458| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     R2H,@$BLOCKED(||BTS_ctrl_cc_ch3||)+8 ; [CPU_FPU] |1459| 

        MOV32     R3H,@$BLOCKED(||BTS_ctrl_cc_ch3||)+4 ; [CPU_FPU] |1459| 
||      MPYF32    R2H,R0H,R2H           ; [CPU_FPU] |1459| 

        MPYF32    R1H,R1H,R3H           ; [CPU_FPU] |1459| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3||+26 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 395,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+28,R0H ; [CPU_FPU] |395| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 394,column 5,is_stmt,isa 0

        SUBF32    R1H,R1H,R2H           ; [CPU_FPU] |1459| 
||      MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+26,R0H ; [CPU_FPU] |394| 

        MOVW      DP,#||BTS_ctrl_cc_ch3||+12 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||)+12,R1H ; [CPU_FPU] |1459| 
||$C$L95||:    
        MOVW      DP,#||BTS_ADC1||+14   ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 349,column 5,is_stmt,isa 0
        MOVB      XAR0,#72              ; [CPU_ALU] |349| 
        MOVL      XAR4,#||BTS_measValues_ch4|| ; [CPU_ARAU] |349| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 348,column 105,is_stmt,isa 0
        MOVL      XAR7,@$BLOCKED(||BTS_ADC1||)+14 ; [CPU_ALU] |348| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 349,column 5,is_stmt,isa 0
        MOV       PL,*+XAR4[AR0]        ; [CPU_ALU] |349| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 348,column 105,is_stmt,isa 0
        MOV       AL,PL                 ; [CPU_ALU] |348| 
        MOVL      XAR6,@$BLOCKED(||BTS_ADC1||)+16 ; [CPU_ALU] |348| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 349,column 5,is_stmt,isa 0
        CMPB      AL,#32                ; [CPU_ALU] |349| 
        B         ||$C$L96||,LO         ; [CPU_ALU] |349| 
        ; branchcc occurs ; [] |349| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 355,column 9,is_stmt,isa 0
        MOVB      XAR0,#72              ; [CPU_ALU] |355| 
        MOV       *+XAR4[AR0],#0        ; [CPU_ALU] |355| 
        B         ||$C$L97||,UNC        ; [CPU_ALU] |355| 
        ; branch occurs ; [] |355| 
||$C$L96||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 350,column 9,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |350| 
        ADDU      ACC,PL                ; [CPU_ALU] |350| 
        MOVL      XAR5,ACC              ; [CPU_ALU] |350| 
        MOVW      DP,#||BTS_measValues_ch4||+72 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 351,column 9,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |351| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 350,column 9,is_stmt,isa 0
        MOV       *+XAR5[4],AR7         ; [CPU_ALU] |350| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 351,column 9,is_stmt,isa 0
        ADDU      ACC,@$BLOCKED(||BTS_measValues_ch4||)+72 ; [CPU_ALU] |351| 
        MOVL      XAR4,ACC              ; [CPU_ALU] |351| 
        MOVB      XAR0,#36              ; [CPU_ALU] |351| 
        MOV       *+XAR4[AR0],AR6       ; [CPU_ALU] |351| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 352,column 9,is_stmt,isa 0
        INC       @$BLOCKED(||BTS_measValues_ch4||)+72 ; [CPU_ALU] |352| 
||$C$L97||:    
        MOVW      DP,#||BTS_ADC1||+14   ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 400,column 189,is_stmt,isa 0
        MOVL      XAR6,@$BLOCKED(||BTS_ADC1||)+14 ; [CPU_ALU] |400| 
        MOVL      XAR7,@$BLOCKED(||BTS_ADC1||)+16 ; [CPU_ALU] |400| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4||+34 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 323,column 5,is_stmt,isa 0
        MOV       AH,@$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+34 ; [CPU_ALU] |323| 
        B         ||$C$L98||,NEQ        ; [CPU_ALU] |323| 
        ; branchcc occurs ; [] |323| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4492,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |4492| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4493,column 5,is_stmt,isa 0
        MOV       AH,*(0:0x4397)        ; [CPU_ALU] |4493| 
        ORB       AH,#0x04              ; [CPU_ALU] |4493| 
        MOV       *(0:0x4397),AH        ; [CPU_ALU] |4493| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4494,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |4494| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 340,column 9,is_stmt,isa 0
        B         ||$C$L99||,UNC        ; [CPU_ALU] |340| 
        ; branch occurs ; [] |340| 
||$C$L98||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4606,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |4606| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4607,column 5,is_stmt,isa 0
        MOV       AH,*(0:0x439b)        ; [CPU_ALU] |4607| 
        ORB       AH,#0x04              ; [CPU_ALU] |4607| 
        MOV       *(0:0x439b),AH        ; [CPU_ALU] |4607| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4057,column 5,is_stmt,isa 0
        MOV       AH,*(0:0x4384)        ; [CPU_ALU] |4057| 
        AND       AH,AH,#0xfffe         ; [CPU_ALU] |4057| 
        ORB       AH,#0x02              ; [CPU_ALU] |4057| 
        MOV       *(0:0x4384),AH        ; [CPU_ALU] |4057| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 4060,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |4060| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       AL,#999               ; [CPU_ALU] |2406| 
        MOVB      AH,#0                 ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 334,column 9,is_stmt,isa 0
        ZERO      R1H                   ; [CPU_FPU] |334| 
        MOVW      DP,#||BTS_ctrl_cc_ch4||+10 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 335,column 9,is_stmt,isa 0
        ZERO      R0H                   ; [CPU_FPU] |335| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x436b),AH        ; [CPU_ALU] |2406| 
        MOV       *(0:0x436d),AL        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x436a),AH        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x436c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 334,column 9,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||)+10,R1H ; [CPU_FPU] |334| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 335,column 9,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||)+12,R0H ; [CPU_FPU] |335| 
||$C$L99||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4||+4 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOV       ACC,AR6               ; [CPU_ALU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        MOV32     R1H,@$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+4 ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOV32     R2H,ACC               ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        MOV32     R6H,R1H               ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 418,column 5,is_stmt,isa 0
        MOV32     R7H,@$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+10 ; [CPU_FPU] |418| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 420,column 5,is_stmt,isa 0
        MOV32     R5H,@$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+24 ; [CPU_FPU] |420| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV       ACC,AR7               ; [CPU_ALU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        NEGF32    R6H,R6H               ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 421,column 5,is_stmt,isa 0
        MOVB      XAR0,#20              ; [CPU_ALU] |421| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOVL      XAR4,#||BTS_ctrlLoopVariable_ch4|| ; [CPU_ARAU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV32     R0H,ACC               ; [CPU_FPU] |409| 
        MOVW      DP,#||BTS_ctrl_cv_ch4|| ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1697,column 1,is_stmt,isa 0
        MOV32     *-SP[8],R6H           ; [CPU_FPU] |1697| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVB      XAR1,#20              ; [CPU_ALU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        I32TOF32  R2H,R2H               ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        I32TOF32  R0H,R0H               ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOV32     R6H,R1H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MPYF32    R0H,R0H,#14336        ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVB      AL,#1                 ; [CPU_ALU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 420,column 5,is_stmt,isa 0
        SUBF32    R3H,R7H,R0H           ; [CPU_FPU] |420| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MPYF32    R2H,R2H,#14336        ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0

        MPYF32    R3H,R5H,R3H           ; [CPU_FPU] |420| 
||      MOV32     *-SP[4],R0H           ; [CPU_FPU] |409| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0
        MOV32     R0H,@$BLOCKED(||BTS_ctrl_cv_ch4||) ; [CPU_FPU] |1447| 
        MPYF32    R0H,R3H,R0H           ; [CPU_FPU] |1447| 
        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cv_ch4||)+10 ; [CPU_FPU] |1447| 

        ADDF32    R4H,R4H,R0H           ; [CPU_FPU] |1447| 
||      MOV32     *-SP[6],R1H           ; [CPU_FPU] |1697| 

        MOV32     R0H,*-SP[8]           ; [CPU_FPU] |1447| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 421,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R4H       ; [CPU_FPU] |421| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MINF32    R6H,R4H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 418,column 5,is_stmt,isa 0
        MOVB      XAR0,#12              ; [CPU_ALU] |418| 
        MOV32     *+XAR4[AR0],R7H       ; [CPU_FPU] |418| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MAXF32    R0H,R6H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOVB      XAR0,#8               ; [CPU_ALU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV32     R6H,*-SP[4]           ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 408,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R2H       ; [CPU_FPU] |408| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOVB      XAR0,#14              ; [CPU_ALU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR1],R0H       ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 409,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R6H       ; [CPU_FPU] |409| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 420,column 5,is_stmt,isa 0
        MOVB      XAR0,#22              ; [CPU_ALU] |420| 
        MOV32     *+XAR4[AR0],R3H       ; [CPU_FPU] |420| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        CMPF32    R4H,R1H               ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L100||,GEQ       ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
        MOV32     R1H,*-SP[8]           ; [CPU_FPU] 
        CMPF32    R4H,R1H               ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L103||,GT        ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
||$C$L100||:    
        CMPB      AL,#0                 ; [CPU_ALU] |1703| 
        B         ||$C$L103||,EQ        ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 433,column 10,is_stmt,isa 0
        MOVIZ     R1H,#48955            ; [CPU_FPU] |433| 
        MOVXI     R1H,#46601            ; [CPU_FPU] |433| 
        CMPF32    R0H,R1H               ; [CPU_FPU] |433| 
        MOVST0    ZF, NF                ; [CPU_FPU] |433| 
        B         ||$C$L101||,LEQ       ; [CPU_ALU] |433| 
        ; branchcc occurs ; [] |433| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4||+6 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 437,column 14,is_stmt,isa 0
        MOVIZ     R4H,#16187            ; [CPU_FPU] |437| 
        MOV32     R1H,@$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+6 ; [CPU_FPU] 
        MOVXI     R4H,#50975            ; [CPU_FPU] |437| 
        CMPF32    R0H,R4H               ; [CPU_FPU] |437| 
        MOVST0    ZF, NF                ; [CPU_FPU] |437| 
        B         ||$C$L102||,GEQ       ; [CPU_ALU] |437| 
        ; branchcc occurs ; [] |437| 
        B         ||$C$L104||,UNC       ; [CPU_ALU] |437| 
        ; branch occurs ; [] |437| 
||$C$L101||:    
        MOVIZ     R1H,#16187            ; [CPU_FPU] |437| 
        MOVXI     R1H,#50975            ; [CPU_FPU] |437| 
        CMPF32    R0H,R1H               ; [CPU_FPU] |437| 
        MOVST0    ZF, NF                ; [CPU_FPU] |437| 
        B         ||$C$L102||,GEQ       ; [CPU_ALU] |437| 
        ; branchcc occurs ; [] |437| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 446,column 5,is_stmt,isa 0
        MOVIZ     R1H,#47747            ; [CPU_FPU] |446| 
        MOVIZ     R4H,#48955            ; [CPU_FPU] 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4||+6 ; [CPU_ARAU] 
        MOVXI     R1H,#4719             ; [CPU_FPU] |446| 
        MOVXI     R4H,#46601            ; [CPU_FPU] 
        CMPF32    R3H,R1H               ; [CPU_FPU] |446| 
        MOVST0    ZF, NF                ; [CPU_FPU] |446| 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+6,R4H ; [CPU_FPU] 
        B         ||$C$L106||,LT        ; [CPU_ALU] |446| 
        ; branchcc occurs ; [] |446| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 450,column 10,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |450| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |450| 
        CMPF32    R3H,R0H               ; [CPU_FPU] |450| 
        MOVST0    ZF, NF                ; [CPU_FPU] |450| 
        B         ||$C$L105||,GT        ; [CPU_ALU] |450| 
        ; branchcc occurs ; [] |450| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 435,column 14,is_stmt,isa 0
        MOVIZ     R1H,#48955            ; [CPU_FPU] |435| 
        MOVXI     R1H,#46601            ; [CPU_FPU] |435| 
        B         ||$C$L108||,UNC       ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L102||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 446,column 5,is_stmt,isa 0
        MOVIZ     R1H,#47747            ; [CPU_FPU] |446| 
        MOVXI     R1H,#4719             ; [CPU_FPU] |446| 
        CMPF32    R3H,R1H               ; [CPU_FPU] |446| 
        MOVST0    ZF, NF                ; [CPU_FPU] |446| 
        B         ||$C$L106||,LT        ; [CPU_ALU] |446| 
        ; branchcc occurs ; [] |446| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 450,column 10,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |450| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |450| 
        CMPF32    R3H,R0H               ; [CPU_FPU] |450| 
        MOVST0    ZF, NF                ; [CPU_FPU] |450| 
        B         ||$C$L105||,GT        ; [CPU_ALU] |450| 
        ; branchcc occurs ; [] |450| 
        MOVIZ     R0H,#16187            ; [CPU_FPU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 439,column 18,is_stmt,isa 0
        MOVIZ     R1H,#16187            ; [CPU_FPU] |439| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4||+6 ; [CPU_ARAU] 
        MOVXI     R0H,#50975            ; [CPU_FPU] 
        MOVXI     R1H,#50975            ; [CPU_FPU] |439| 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+6,R0H ; [CPU_FPU] 
        B         ||$C$L108||,UNC       ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L103||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1458,column 5,is_stmt,isa 0
        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cv_ch4||)+6 ; [CPU_FPU] |1458| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4||+6 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 426,column 9,is_stmt,isa 0
        MOV32     R1H,R0H               ; [CPU_FPU] |426| 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+6,R0H ; [CPU_FPU] |426| 
        MOVW      DP,#||BTS_ctrl_cv_ch4||+2 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1458,column 5,is_stmt,isa 0
        MOV32     R6H,@$BLOCKED(||BTS_ctrl_cv_ch4||)+2 ; [CPU_FPU] |1458| 
        MPYF32    R6H,R3H,R6H           ; [CPU_FPU] |1458| 

        MOV32     R7H,@$BLOCKED(||BTS_ctrl_cv_ch4||)+12 ; [CPU_FPU] |1458| 
||      MPYF32    R4H,R1H,R4H           ; [CPU_FPU] |1458| 

        ADDF32    R6H,R6H,R7H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        SUBF32    R4H,R6H,R4H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch4||)+10,R4H ; [CPU_FPU] |1458| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cv_ch4||)+8 ; [CPU_FPU] |1459| 

        MOV32     R6H,@$BLOCKED(||BTS_ctrl_cv_ch4||)+4 ; [CPU_FPU] |1459| 
||      MPYF32    R4H,R1H,R4H           ; [CPU_FPU] |1459| 

        MPYF32    R6H,R3H,R6H           ; [CPU_FPU] |1459| 
        NOP       ; [CPU_ALU] 
        SUBF32    R4H,R6H,R4H           ; [CPU_FPU] |1459| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch4||)+12,R4H ; [CPU_FPU] |1459| 
||$C$L104||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 446,column 5,is_stmt,isa 0
        MOVIZ     R4H,#47747            ; [CPU_FPU] |446| 
        MOVXI     R4H,#4719             ; [CPU_FPU] |446| 
        CMPF32    R3H,R4H               ; [CPU_FPU] |446| 
        MOVST0    ZF, NF                ; [CPU_FPU] |446| 
        B         ||$C$L106||,LT        ; [CPU_ALU] |446| 
        ; branchcc occurs ; [] |446| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 450,column 10,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |450| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |450| 
        CMPF32    R3H,R0H               ; [CPU_FPU] |450| 
        MOVST0    ZF, NF                ; [CPU_FPU] |450| 
        B         ||$C$L108||,LEQ       ; [CPU_ALU] |450| 
        ; branchcc occurs ; [] |450| 
||$C$L105||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4||+30 ; [CPU_ARAU] 
        MOV32     R0H,*-SP[6]           ; [CPU_FPU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 454,column 9,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+30,#0 ; [CPU_ALU] |454| 
        B         ||$C$L107||,UNC       ; [CPU_ALU] |454| 
        ; branch occurs ; [] |454| 
||$C$L106||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4||+30 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 448,column 9,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+30,#1,UNC ; [CPU_ALU] |448| 
||$C$L107||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 447,column 9,is_stmt,isa 0
        MPYF32    R1H,R0H,R5H           ; [CPU_FPU] |447| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+6,R1H ; [CPU_FPU] |447| 
||$C$L108||:    
        MOVW      DP,#||BTS_ctrl_cc_ch4|| ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 473,column 5,is_stmt,isa 0

        MOV32     R3H,@$BLOCKED(||BTS_ctrl_cc_ch4||) ; [CPU_FPU] |1447| 
||      SUBF32    R1H,R1H,R2H           ; [CPU_FPU] |473| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16140            ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 475,column 5,is_stmt,isa 0
        MOVB      XAR0,#16              ; [CPU_ALU] |475| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVB      XAR1,#16              ; [CPU_ALU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0

        MPYF32    R3H,R1H,R3H           ; [CPU_FPU] |1447| 
||      MOV32     R2H,@$BLOCKED(||BTS_ctrl_cc_ch4||)+10 ; [CPU_FPU] |1447| 

	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVB      AL,#1                 ; [CPU_ALU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1447,column 5,is_stmt,isa 0
        ADDF32    R2H,R2H,R3H           ; [CPU_FPU] |1447| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 475,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R2H       ; [CPU_FPU] |475| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVIZ     R3H,#16140            ; [CPU_FPU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 473,column 5,is_stmt,isa 0
        MOVB      XAR0,#18              ; [CPU_ALU] |473| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MINF32    R0H,R2H               ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        MOVXI     R3H,#52429            ; [CPU_FPU] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MAXF32    R0H,#0                ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 473,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR0],R1H       ; [CPU_FPU] |473| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1700,column 5,is_stmt,isa 0
        MOV32     *+XAR4[AR1],R0H       ; [CPU_FPU] |1700| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1703,column 5,is_stmt,isa 0
        CMPF32    R2H,R3H               ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L109||,GEQ       ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
        CMPF32    R2H,#0                ; [CPU_FPU] |1703| 
        MOVST0    ZF, NF                ; [CPU_FPU] |1703| 
        B         ||$C$L111||,GT        ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
||$C$L109||:    
        CMPB      AL,#0                 ; [CPU_ALU] |1703| 
        B         ||$C$L111||,EQ        ; [CPU_ALU] |1703| 
        ; branchcc occurs ; [] |1703| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 488,column 13,is_stmt,isa 0
        CMPF32    R0H,#0                ; [CPU_FPU] |488| 
        MOVST0    ZF, NF                ; [CPU_FPU] |488| 
        B         ||$C$L110||,GT        ; [CPU_ALU] |488| 
        ; branchcc occurs ; [] |488| 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        UI32TOF32 R1H,@||MEP_ScaleFactor|| ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        MPYF32    R1H,R1H,#0            ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        F32TOUI16 R1H,R1H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x436b),AR6       ; [CPU_ALU] |2406| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOV32     ACC,R1H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 492,column 17,is_stmt,isa 0
        ZERO      R1H                   ; [CPU_FPU] |492| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVB      AH,#0                 ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x436a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 492,column 17,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch4||),R1H ; [CPU_FPU] |492| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x436d),AH        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x436c),AL        ; [CPU_ALU] |1262| 
||$C$L110||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 494,column 13,is_stmt,isa 0
        MOVIZ     R1H,#16140            ; [CPU_FPU] |494| 
        MOVXI     R1H,#52429            ; [CPU_FPU] |494| 
        CMPF32    R0H,R1H               ; [CPU_FPU] |494| 
        MOVST0    ZF, NF                ; [CPU_FPU] |494| 
        B         ||$C$L118||,LT        ; [CPU_ALU] |494| 
        ; branchcc occurs ; [] |494| 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOVIZ     R0H,#16102            ; [CPU_FPU] |192| 
        UI32TOF32 R1H,@||MEP_ScaleFactor|| ; [CPU_FPU] |192| 
        MOVXI     R0H,#26624            ; [CPU_FPU] |192| 
        MPYF32    R0H,R0H,R1H           ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOVL      XAR6,#549             ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        F32TOUI16 R0H,R0H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x436b),AR6       ; [CPU_ALU] |2406| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4|| ; [CPU_ARAU] 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOV32     ACC,R0H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        MOVIZ     R0H,#16140            ; [CPU_FPU] |498| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       AH,#549               ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       *(0:0x436a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |498| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x436d),AH        ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch4||),R0H ; [CPU_FPU] |498| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x436c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 498,column 17,is_stmt,isa 0
        B         ||$C$L118||,UNC       ; [CPU_ALU] |498| 
        ; branch occurs ; [] |498| 
||$C$L111||:    
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4||+31 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 364,column 5,is_stmt,isa 0
        MOV       AL,@$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+31 ; [CPU_ALU] |364| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 479,column 13,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch4||),R0H ; [CPU_FPU] |479| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 364,column 5,is_stmt,isa 0
        B         ||$C$L113||,NEQ       ; [CPU_ALU] |364| 
        ; branchcc occurs ; [] |364| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 381,column 9,is_stmt,isa 0
        CMP       AR6,#28842            ; [CPU_ALU] |381| 
        B         ||$C$L112||,GEQ       ; [CPU_ALU] |381| 
        ; branchcc occurs ; [] |381| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3032,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4149)        ; [CPU_ALU] |3032| 
        AND       AL,#0xfffc            ; [CPU_ALU] |3032| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 389,column 13,is_stmt,isa 0
        B         ||$C$L114||,UNC       ; [CPU_ALU] |389| 
        ; branch occurs ; [] |389| 
||$C$L112||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3032,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4349)        ; [CPU_ALU] |3032| 
        AND       AL,AL,#0xfffc         ; [CPU_ALU] |3032| 
        ORB       AL,#0x01              ; [CPU_ALU] |3032| 
        B         ||$C$L116||,UNC       ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L113||:    
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 367,column 9,is_stmt,isa 0
        CMP       AR6,#-28841           ; [CPU_ALU] |367| 
        B         ||$C$L115||,LT        ; [CPU_ALU] |367| 
        ; branchcc occurs ; [] |367| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3038,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4149)        ; [CPU_ALU] |3038| 
        AND       AL,#0xfff3            ; [CPU_ALU] |3038| 
||$C$L114||:    
        MOV       *(0:0x4149),AL        ; [CPU_ALU] |3038| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 375,column 13,is_stmt,isa 0
        B         ||$C$L117||,UNC       ; [CPU_ALU] |375| 
        ; branch occurs ; [] |375| 
||$C$L115||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 3038,column 9,is_stmt,isa 0
        MOV       AL,*(0:0x4349)        ; [CPU_ALU] |3038| 
        AND       AL,AL,#0xfffb         ; [CPU_ALU] |3038| 
        ORB       AL,#0x08              ; [CPU_ALU] |3038| 
||$C$L116||:    
        MOV       *(0:0x4349),AL        ; [CPU_ALU] |3038| 
||$C$L117||:    
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOVIZ     R2H,#17529            ; [CPU_FPU] |192| 
        MOVXI     R2H,#49152            ; [CPU_FPU] |192| 
        MPYF32    R2H,R2H,R0H           ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        F32TOUI16 R3H,R2H               ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MOV32     XAR6,R3H              ; [CPU_FPU] |192| 
        MOVU      ACC,AR6               ; [CPU_ALU] |192| 
        MOV32     R3H,ACC               ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MOVW      DP,#||MEP_ScaleFactor|| ; [CPU_ARAU] 
        UI32TOF32 R3H,R3H               ; [CPU_FPU] |192| 
        UI32TOF32 R4H,@||MEP_ScaleFactor|| ; [CPU_FPU] |192| 
        SUBF32    R2H,R2H,R3H           ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        MPYF32    R2H,R4H,R2H           ; [CPU_FPU] |192| 
        NOP       ; [CPU_ALU] 
        F32TOUI16 R2H,R2H               ; [CPU_FPU] |192| 
        MOVW      DP,#||BTS_ctrl_cc_ch4||+6 ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x436b),AR6       ; [CPU_ALU] |2406| 
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 192,column 21,is_stmt,isa 0
        MOV32     ACC,R2H               ; [CPU_FPU] |192| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1255,column 9,is_stmt,isa 0
        MOV       ACC,AL << #8          ; [CPU_ALU] |1255| 
        MOV       *(0:0x436a),AL        ; [CPU_ALU] |1255| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h",line 2406,column 9,is_stmt,isa 0
        MOV       *(0:0x436d),AR6       ; [CPU_ALU] |2406| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h",line 1262,column 9,is_stmt,isa 0
        MOV       *(0:0x436c),AL        ; [CPU_ALU] |1262| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1458,column 5,is_stmt,isa 0
        MOV32     R2H,@$BLOCKED(||BTS_ctrl_cc_ch4||)+6 ; [CPU_FPU] |1458| 
        MOV32     R3H,@$BLOCKED(||BTS_ctrl_cc_ch4||)+2 ; [CPU_FPU] |1458| 
        MPYF32    R3H,R1H,R3H           ; [CPU_FPU] |1458| 

        MOV32     R4H,@$BLOCKED(||BTS_ctrl_cc_ch4||)+12 ; [CPU_FPU] |1458| 
||      MPYF32    R2H,R0H,R2H           ; [CPU_FPU] |1458| 

        ADDF32    R3H,R3H,R4H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        SUBF32    R2H,R3H,R2H           ; [CPU_FPU] |1458| 
        NOP       ; [CPU_ALU] 
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||)+10,R2H ; [CPU_FPU] |1458| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     R2H,@$BLOCKED(||BTS_ctrl_cc_ch4||)+8 ; [CPU_FPU] |1459| 

        MOV32     R3H,@$BLOCKED(||BTS_ctrl_cc_ch4||)+4 ; [CPU_FPU] |1459| 
||      MPYF32    R2H,R0H,R2H           ; [CPU_FPU] |1459| 

        MPYF32    R1H,R1H,R3H           ; [CPU_FPU] |1459| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4||+26 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 395,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+28,R0H ; [CPU_FPU] |395| 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h",line 394,column 5,is_stmt,isa 0

        SUBF32    R1H,R1H,R2H           ; [CPU_FPU] |1459| 
||      MOV32     @$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+26,R0H ; [CPU_FPU] |394| 

        MOVW      DP,#||BTS_ctrl_cc_ch4||+12 ; [CPU_ARAU] 
	.dwpsn	file "C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h",line 1459,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||)+12,R1H ; [CPU_FPU] |1459| 
||$C$L118||:    
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 429,column 5,is_stmt,isa 0
        MOVB      AL,#1                 ; [CPU_ALU] |429| 
        MOV       *(0:0x0ce1),AL        ; [CPU_ALU] |429| 
        SUBB      SP,#8                 ; [CPU_ARAU] 
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
$C$DW$279	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$279, DW_AT_low_pc(0x00)
	.dwattr $C$DW$279, DW_AT_TI_return

        IRET      ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$238, DW_AT_TI_end_file("../bts_main.c")
	.dwattr $C$DW$238, DW_AT_TI_end_line(0xbc)
	.dwattr $C$DW$238, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$238

;**************************************************************
;* UNDEFINED EXTERNAL REFERENCES                              *
;**************************************************************
	.global	||SPI_clearInterruptStatus||
	.global	||BTS_HAL_setupDevice||
	.global	||BTS_HAL_setupSyncBuckPinsGpio||
	.global	||BTS_HAL_disableEpwmCounting||
	.global	||BTS_HAL_setupSyncBuckPwm||
	.global	||BTS_setupHrpwmMepScaleFactor||
	.global	||BTS_HAL_SetupSpiPinsGpio||
	.global	||BTS_HAL_SetupSpi||
	.global	||BTS_HAL_setupExAdcGpio||
	.global	||BTS_HAL_setupExAdc||
	.global	||BTS_initUserVariables||
	.global	||BTS_initProgramVariables||
	.global	||BTS_initController||
	.global	||BTS_setupSfra||
	.global	||BTS_setupSfraGui||
	.global	||BTS_HAL_setupInterruptTrigger||
	.global	||BTS_HAL_setupInterrupt||
	.global	||BTS_HAL_enableEpwmCounting||
	.global	||BTS_HAL_setupSyncBuckPinsEpwm||
	.global	||BTS_updateReference||
	.global	||BTS_monitor_Iout_Vout||
	.global	||BTS_ExAdcRxflag||
	.global	||BTS_sfoStatus||
	.global	||SFO||
	.global	||MEP_ScaleFactor||
	.global	||BTS_ADC1||
	.global	||BTS_ctrl_cc_ch1||
	.global	||BTS_ctrl_cc_ch2||
	.global	||BTS_ctrl_cc_ch3||
	.global	||BTS_ctrl_cc_ch4||
	.global	||BTS_ctrl_cv_ch1||
	.global	||BTS_ctrl_cv_ch2||
	.global	||BTS_ctrl_cv_ch3||
	.global	||BTS_ctrl_cv_ch4||
	.global	||BTS_userInput_ch1||
	.global	||BTS_userInput_ch2||
	.global	||BTS_userInput_ch3||
	.global	||BTS_userInput_ch4||
	.global	||BTS_ctrlLoopVariable_ch1||
	.global	||BTS_ctrlLoopVariable_ch2||
	.global	||BTS_ctrlLoopVariable_ch3||
	.global	||BTS_ctrlLoopVariable_ch4||
	.global	||BTS_measValues_ch1||
	.global	||BTS_measValues_ch2||
	.global	||BTS_measValues_ch3||
	.global	||BTS_measValues_ch4||
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

$C$DW$TU$51	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$51

$C$DW$T$51	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$51, DW_AT_byte_size(0x01)
$C$DW$280	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$280, DW_AT_name("EPWM_COUNTER_COMPARE_A")
	.dwattr $C$DW$280, DW_AT_const_value(0x00)
	.dwattr $C$DW$280, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$280, DW_AT_decl_line(0x10f)
	.dwattr $C$DW$280, DW_AT_decl_column(0x05)

$C$DW$281	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$281, DW_AT_name("EPWM_COUNTER_COMPARE_B")
	.dwattr $C$DW$281, DW_AT_const_value(0x02)
	.dwattr $C$DW$281, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$281, DW_AT_decl_line(0x110)
	.dwattr $C$DW$281, DW_AT_decl_column(0x05)

$C$DW$282	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$282, DW_AT_name("EPWM_COUNTER_COMPARE_C")
	.dwattr $C$DW$282, DW_AT_const_value(0x05)
	.dwattr $C$DW$282, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$282, DW_AT_decl_line(0x111)
	.dwattr $C$DW$282, DW_AT_decl_column(0x05)

$C$DW$283	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$283, DW_AT_name("EPWM_COUNTER_COMPARE_D")
	.dwattr $C$DW$283, DW_AT_const_value(0x07)
	.dwattr $C$DW$283, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$283, DW_AT_decl_line(0x112)
	.dwattr $C$DW$283, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$51, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$51, DW_AT_decl_line(0x10e)
	.dwattr $C$DW$T$51, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$51

	.dwendtag $C$DW$TU$51


$C$DW$TU$52	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$52
$C$DW$T$52	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$52, DW_AT_name("EPWM_CounterCompareModule")
	.dwattr $C$DW$T$52, DW_AT_type(*$C$DW$T$51)
	.dwattr $C$DW$T$52, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$52, DW_AT_decl_line(0x113)
	.dwattr $C$DW$T$52, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$52


$C$DW$TU$53	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$53

$C$DW$T$53	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$53, DW_AT_byte_size(0x01)
$C$DW$284	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$284, DW_AT_name("EPWM_AQ_OUTPUT_A")
	.dwattr $C$DW$284, DW_AT_const_value(0x00)
	.dwattr $C$DW$284, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$284, DW_AT_decl_line(0x211)
	.dwattr $C$DW$284, DW_AT_decl_column(0x05)

$C$DW$285	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$285, DW_AT_name("EPWM_AQ_OUTPUT_B")
	.dwattr $C$DW$285, DW_AT_const_value(0x02)
	.dwattr $C$DW$285, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$285, DW_AT_decl_line(0x212)
	.dwattr $C$DW$285, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$53, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$53, DW_AT_decl_line(0x210)
	.dwattr $C$DW$T$53, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$53

	.dwendtag $C$DW$TU$53


$C$DW$TU$54	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$54
$C$DW$T$54	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$54, DW_AT_name("EPWM_ActionQualifierOutputModule")
	.dwattr $C$DW$T$54, DW_AT_type(*$C$DW$T$53)
	.dwattr $C$DW$T$54, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$54, DW_AT_decl_line(0x213)
	.dwattr $C$DW$T$54, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$54


$C$DW$TU$55	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$55

$C$DW$T$55	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$55, DW_AT_byte_size(0x01)
$C$DW$286	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$286, DW_AT_name("EPWM_AQ_SW_DISABLED")
	.dwattr $C$DW$286, DW_AT_const_value(0x00)
	.dwattr $C$DW$286, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$286, DW_AT_decl_line(0x19e)
	.dwattr $C$DW$286, DW_AT_decl_column(0x05)

$C$DW$287	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$287, DW_AT_name("EPWM_AQ_SW_OUTPUT_LOW")
	.dwattr $C$DW$287, DW_AT_const_value(0x01)
	.dwattr $C$DW$287, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$287, DW_AT_decl_line(0x19f)
	.dwattr $C$DW$287, DW_AT_decl_column(0x05)

$C$DW$288	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$288, DW_AT_name("EPWM_AQ_SW_OUTPUT_HIGH")
	.dwattr $C$DW$288, DW_AT_const_value(0x02)
	.dwattr $C$DW$288, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$288, DW_AT_decl_line(0x1a0)
	.dwattr $C$DW$288, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$55, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$55, DW_AT_decl_line(0x19d)
	.dwattr $C$DW$T$55, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$55

	.dwendtag $C$DW$TU$55


$C$DW$TU$56	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$56
$C$DW$T$56	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$56, DW_AT_name("EPWM_ActionQualifierSWOutput")
	.dwattr $C$DW$T$56, DW_AT_type(*$C$DW$T$55)
	.dwattr $C$DW$T$56, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$56, DW_AT_decl_line(0x1a1)
	.dwattr $C$DW$T$56, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$56


$C$DW$TU$57	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$57

$C$DW$T$57	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$57, DW_AT_byte_size(0x01)
$C$DW$289	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$289, DW_AT_name("EPWM_TZ_ACTION_EVENT_TZA")
	.dwattr $C$DW$289, DW_AT_const_value(0x00)
	.dwattr $C$DW$289, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$289, DW_AT_decl_line(0x2ff)
	.dwattr $C$DW$289, DW_AT_decl_column(0x05)

$C$DW$290	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$290, DW_AT_name("EPWM_TZ_ACTION_EVENT_TZB")
	.dwattr $C$DW$290, DW_AT_const_value(0x02)
	.dwattr $C$DW$290, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$290, DW_AT_decl_line(0x300)
	.dwattr $C$DW$290, DW_AT_decl_column(0x05)

$C$DW$291	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$291, DW_AT_name("EPWM_TZ_ACTION_EVENT_DCAEVT1")
	.dwattr $C$DW$291, DW_AT_const_value(0x04)
	.dwattr $C$DW$291, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$291, DW_AT_decl_line(0x301)
	.dwattr $C$DW$291, DW_AT_decl_column(0x05)

$C$DW$292	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$292, DW_AT_name("EPWM_TZ_ACTION_EVENT_DCAEVT2")
	.dwattr $C$DW$292, DW_AT_const_value(0x06)
	.dwattr $C$DW$292, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$292, DW_AT_decl_line(0x302)
	.dwattr $C$DW$292, DW_AT_decl_column(0x05)

$C$DW$293	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$293, DW_AT_name("EPWM_TZ_ACTION_EVENT_DCBEVT1")
	.dwattr $C$DW$293, DW_AT_const_value(0x08)
	.dwattr $C$DW$293, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$293, DW_AT_decl_line(0x303)
	.dwattr $C$DW$293, DW_AT_decl_column(0x05)

$C$DW$294	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$294, DW_AT_name("EPWM_TZ_ACTION_EVENT_DCBEVT2")
	.dwattr $C$DW$294, DW_AT_const_value(0x0a)
	.dwattr $C$DW$294, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$294, DW_AT_decl_line(0x304)
	.dwattr $C$DW$294, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$57, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$57, DW_AT_decl_line(0x2fe)
	.dwattr $C$DW$T$57, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$57

	.dwendtag $C$DW$TU$57


$C$DW$TU$58	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$58
$C$DW$T$58	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$58, DW_AT_name("EPWM_TripZoneEvent")
	.dwattr $C$DW$T$58, DW_AT_type(*$C$DW$T$57)
	.dwattr $C$DW$T$58, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$58, DW_AT_decl_line(0x305)
	.dwattr $C$DW$T$58, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$58


$C$DW$TU$59	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$59

$C$DW$T$59	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$59, DW_AT_byte_size(0x01)
$C$DW$295	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$295, DW_AT_name("EPWM_TZ_ACTION_HIGH_Z")
	.dwattr $C$DW$295, DW_AT_const_value(0x00)
	.dwattr $C$DW$295, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$295, DW_AT_decl_line(0x30f)
	.dwattr $C$DW$295, DW_AT_decl_column(0x05)

$C$DW$296	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$296, DW_AT_name("EPWM_TZ_ACTION_HIGH")
	.dwattr $C$DW$296, DW_AT_const_value(0x01)
	.dwattr $C$DW$296, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$296, DW_AT_decl_line(0x310)
	.dwattr $C$DW$296, DW_AT_decl_column(0x05)

$C$DW$297	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$297, DW_AT_name("EPWM_TZ_ACTION_LOW")
	.dwattr $C$DW$297, DW_AT_const_value(0x02)
	.dwattr $C$DW$297, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$297, DW_AT_decl_line(0x311)
	.dwattr $C$DW$297, DW_AT_decl_column(0x05)

$C$DW$298	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$298, DW_AT_name("EPWM_TZ_ACTION_DISABLE")
	.dwattr $C$DW$298, DW_AT_const_value(0x03)
	.dwattr $C$DW$298, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$298, DW_AT_decl_line(0x312)
	.dwattr $C$DW$298, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$59, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$59, DW_AT_decl_line(0x30e)
	.dwattr $C$DW$T$59, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$59

	.dwendtag $C$DW$TU$59


$C$DW$TU$60	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$60
$C$DW$T$60	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$60, DW_AT_name("EPWM_TripZoneAction")
	.dwattr $C$DW$T$60, DW_AT_type(*$C$DW$T$59)
	.dwattr $C$DW$T$60, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/epwm.h")
	.dwattr $C$DW$T$60, DW_AT_decl_line(0x313)
	.dwattr $C$DW$T$60, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$60


$C$DW$TU$61	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$61

$C$DW$T$61	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$61, DW_AT_byte_size(0x01)
$C$DW$299	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$299, DW_AT_name("HRPWM_COUNTER_COMPARE_A")
	.dwattr $C$DW$299, DW_AT_const_value(0x00)
	.dwattr $C$DW$299, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$299, DW_AT_decl_line(0xb3)
	.dwattr $C$DW$299, DW_AT_decl_column(0x05)

$C$DW$300	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$300, DW_AT_name("HRPWM_COUNTER_COMPARE_B")
	.dwattr $C$DW$300, DW_AT_const_value(0x04)
	.dwattr $C$DW$300, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$300, DW_AT_decl_line(0xb4)
	.dwattr $C$DW$300, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$61, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$61, DW_AT_decl_line(0xb2)
	.dwattr $C$DW$T$61, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$61

	.dwendtag $C$DW$TU$61


$C$DW$TU$62	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$62
$C$DW$T$62	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$62, DW_AT_name("HRPWM_CounterCompareModule")
	.dwattr $C$DW$T$62, DW_AT_type(*$C$DW$T$61)
	.dwattr $C$DW$T$62, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/hrpwm.h")
	.dwattr $C$DW$T$62, DW_AT_decl_line(0xb5)
	.dwattr $C$DW$T$62, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$62


$C$DW$TU$25	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$25

$C$DW$T$25	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$25, DW_AT_byte_size(0x12)
$C$DW$301	.dwtag  DW_TAG_member
	.dwattr $C$DW$301, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$301, DW_AT_name("response")
	.dwattr $C$DW$301, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$301, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$301, DW_AT_decl_line(0x34)
	.dwattr $C$DW$301, DW_AT_decl_column(0x17)

$C$DW$302	.dwtag  DW_TAG_member
	.dwattr $C$DW$302, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$302, DW_AT_name("crc")
	.dwattr $C$DW$302, DW_AT_data_member_location[DW_OP_plus_uconst 0x1]
	.dwattr $C$DW$302, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$302, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$302, DW_AT_decl_line(0x35)
	.dwattr $C$DW$302, DW_AT_decl_column(0x17)

$C$DW$303	.dwtag  DW_TAG_member
	.dwattr $C$DW$303, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$303, DW_AT_name("channel0")
	.dwattr $C$DW$303, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$303, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$303, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$303, DW_AT_decl_line(0x36)
	.dwattr $C$DW$303, DW_AT_decl_column(0x16)

$C$DW$304	.dwtag  DW_TAG_member
	.dwattr $C$DW$304, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$304, DW_AT_name("channel1")
	.dwattr $C$DW$304, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$304, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$304, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$304, DW_AT_decl_line(0x37)
	.dwattr $C$DW$304, DW_AT_decl_column(0x16)

$C$DW$305	.dwtag  DW_TAG_member
	.dwattr $C$DW$305, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$305, DW_AT_name("channel2")
	.dwattr $C$DW$305, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$305, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$305, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$305, DW_AT_decl_line(0x38)
	.dwattr $C$DW$305, DW_AT_decl_column(0x16)

$C$DW$306	.dwtag  DW_TAG_member
	.dwattr $C$DW$306, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$306, DW_AT_name("channel3")
	.dwattr $C$DW$306, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$306, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$306, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$306, DW_AT_decl_line(0x39)
	.dwattr $C$DW$306, DW_AT_decl_column(0x16)

$C$DW$307	.dwtag  DW_TAG_member
	.dwattr $C$DW$307, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$307, DW_AT_name("channel4")
	.dwattr $C$DW$307, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$307, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$307, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$307, DW_AT_decl_line(0x3a)
	.dwattr $C$DW$307, DW_AT_decl_column(0x16)

$C$DW$308	.dwtag  DW_TAG_member
	.dwattr $C$DW$308, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$308, DW_AT_name("channel5")
	.dwattr $C$DW$308, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$308, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$308, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$308, DW_AT_decl_line(0x3b)
	.dwattr $C$DW$308, DW_AT_decl_column(0x16)

$C$DW$309	.dwtag  DW_TAG_member
	.dwattr $C$DW$309, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$309, DW_AT_name("channel6")
	.dwattr $C$DW$309, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$309, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$309, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$309, DW_AT_decl_line(0x3c)
	.dwattr $C$DW$309, DW_AT_decl_column(0x16)

$C$DW$310	.dwtag  DW_TAG_member
	.dwattr $C$DW$310, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$310, DW_AT_name("channel7")
	.dwattr $C$DW$310, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$310, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$310, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$310, DW_AT_decl_line(0x3d)
	.dwattr $C$DW$310, DW_AT_decl_column(0x16)

	.dwattr $C$DW$T$25, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$T$25, DW_AT_decl_line(0x33)
	.dwattr $C$DW$T$25, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$25

	.dwendtag $C$DW$TU$25


$C$DW$TU$63	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$63
$C$DW$T$63	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$63, DW_AT_name("adc_data")
	.dwattr $C$DW$T$63, DW_AT_type(*$C$DW$T$25)
	.dwattr $C$DW$T$63, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$T$63, DW_AT_decl_line(0x3e)
	.dwattr $C$DW$T$63, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$63


$C$DW$TU$28	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$28

$C$DW$T$28	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$28, DW_AT_byte_size(0x1e)
$C$DW$311	.dwtag  DW_TAG_member
	.dwattr $C$DW$311, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$311, DW_AT_name("iref_A")
	.dwattr $C$DW$311, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$311, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$311, DW_AT_decl_line(0x74)
	.dwattr $C$DW$311, DW_AT_decl_column(0x18)

$C$DW$312	.dwtag  DW_TAG_member
	.dwattr $C$DW$312, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$312, DW_AT_name("vref_charge_V")
	.dwattr $C$DW$312, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$312, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$312, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$312, DW_AT_decl_line(0x75)
	.dwattr $C$DW$312, DW_AT_decl_column(0x18)

$C$DW$313	.dwtag  DW_TAG_member
	.dwattr $C$DW$313, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$313, DW_AT_name("vref_discharge_V")
	.dwattr $C$DW$313, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$313, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$313, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$313, DW_AT_decl_line(0x76)
	.dwattr $C$DW$313, DW_AT_decl_column(0x18)

$C$DW$314	.dwtag  DW_TAG_member
	.dwattr $C$DW$314, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$314, DW_AT_name("direction_logic")
	.dwattr $C$DW$314, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$314, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$314, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$314, DW_AT_decl_line(0x77)
	.dwattr $C$DW$314, DW_AT_decl_column(0x17)

$C$DW$315	.dwtag  DW_TAG_member
	.dwattr $C$DW$315, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$315, DW_AT_name("enable_logic")
	.dwattr $C$DW$315, DW_AT_data_member_location[DW_OP_plus_uconst 0x7]
	.dwattr $C$DW$315, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$315, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$315, DW_AT_decl_line(0x78)
	.dwattr $C$DW$315, DW_AT_decl_column(0x17)

$C$DW$316	.dwtag  DW_TAG_member
	.dwattr $C$DW$316, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$316, DW_AT_name("dutyRef_pu")
	.dwattr $C$DW$316, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$316, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$316, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$316, DW_AT_decl_line(0x79)
	.dwattr $C$DW$316, DW_AT_decl_column(0x18)

$C$DW$317	.dwtag  DW_TAG_member
	.dwattr $C$DW$317, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$317, DW_AT_name("ioutCal_pu")
	.dwattr $C$DW$317, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$317, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$317, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$317, DW_AT_decl_line(0x7a)
	.dwattr $C$DW$317, DW_AT_decl_column(0x18)

$C$DW$318	.dwtag  DW_TAG_member
	.dwattr $C$DW$318, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$318, DW_AT_name("voutCal_pu")
	.dwattr $C$DW$318, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$318, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$318, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$318, DW_AT_decl_line(0x7b)
	.dwattr $C$DW$318, DW_AT_decl_column(0x18)

$C$DW$319	.dwtag  DW_TAG_member
	.dwattr $C$DW$319, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$319, DW_AT_name("IoutGain_pu")
	.dwattr $C$DW$319, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$319, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$319, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$319, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$319, DW_AT_decl_column(0x0f)

$C$DW$320	.dwtag  DW_TAG_member
	.dwattr $C$DW$320, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$320, DW_AT_name("IoutOffset_pu")
	.dwattr $C$DW$320, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$320, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$320, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$320, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$320, DW_AT_decl_column(0x0f)

$C$DW$321	.dwtag  DW_TAG_member
	.dwattr $C$DW$321, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$321, DW_AT_name("IoutGain_A")
	.dwattr $C$DW$321, DW_AT_data_member_location[DW_OP_plus_uconst 0x12]
	.dwattr $C$DW$321, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$321, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$321, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$321, DW_AT_decl_column(0x0f)

$C$DW$322	.dwtag  DW_TAG_member
	.dwattr $C$DW$322, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$322, DW_AT_name("IoutOffset_A")
	.dwattr $C$DW$322, DW_AT_data_member_location[DW_OP_plus_uconst 0x14]
	.dwattr $C$DW$322, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$322, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$322, DW_AT_decl_line(0x80)
	.dwattr $C$DW$322, DW_AT_decl_column(0x0f)

$C$DW$323	.dwtag  DW_TAG_member
	.dwattr $C$DW$323, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$323, DW_AT_name("VoutGain_pu")
	.dwattr $C$DW$323, DW_AT_data_member_location[DW_OP_plus_uconst 0x16]
	.dwattr $C$DW$323, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$323, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$323, DW_AT_decl_line(0x82)
	.dwattr $C$DW$323, DW_AT_decl_column(0x0f)

$C$DW$324	.dwtag  DW_TAG_member
	.dwattr $C$DW$324, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$324, DW_AT_name("VoutOffset_pu")
	.dwattr $C$DW$324, DW_AT_data_member_location[DW_OP_plus_uconst 0x18]
	.dwattr $C$DW$324, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$324, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$324, DW_AT_decl_line(0x83)
	.dwattr $C$DW$324, DW_AT_decl_column(0x0f)

$C$DW$325	.dwtag  DW_TAG_member
	.dwattr $C$DW$325, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$325, DW_AT_name("VoutGain_V")
	.dwattr $C$DW$325, DW_AT_data_member_location[DW_OP_plus_uconst 0x1a]
	.dwattr $C$DW$325, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$325, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$325, DW_AT_decl_line(0x84)
	.dwattr $C$DW$325, DW_AT_decl_column(0x0f)

$C$DW$326	.dwtag  DW_TAG_member
	.dwattr $C$DW$326, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$326, DW_AT_name("VoutOffset_V")
	.dwattr $C$DW$326, DW_AT_data_member_location[DW_OP_plus_uconst 0x1c]
	.dwattr $C$DW$326, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$326, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$326, DW_AT_decl_line(0x85)
	.dwattr $C$DW$326, DW_AT_decl_column(0x0f)

	.dwattr $C$DW$T$28, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$28, DW_AT_decl_line(0x73)
	.dwattr $C$DW$T$28, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$28

	.dwendtag $C$DW$TU$28


$C$DW$TU$65	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$65
$C$DW$T$65	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$65, DW_AT_name("BTS_userInput")
	.dwattr $C$DW$T$65, DW_AT_type(*$C$DW$T$28)
	.dwattr $C$DW$T$65, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$65, DW_AT_decl_line(0x87)
	.dwattr $C$DW$T$65, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$65


$C$DW$TU$66	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$66
$C$DW$T$66	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$66, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$T$66, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$66


$C$DW$TU$31	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$31

$C$DW$T$31	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$31, DW_AT_byte_size(0x24)
$C$DW$327	.dwtag  DW_TAG_member
	.dwattr $C$DW$327, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$327, DW_AT_name("dutySet_pu")
	.dwattr $C$DW$327, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$327, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$327, DW_AT_decl_line(0x90)
	.dwattr $C$DW$327, DW_AT_decl_column(0x0f)

$C$DW$328	.dwtag  DW_TAG_member
	.dwattr $C$DW$328, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$328, DW_AT_name("dutySetRef_pu")
	.dwattr $C$DW$328, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$328, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$328, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$328, DW_AT_decl_line(0x91)
	.dwattr $C$DW$328, DW_AT_decl_column(0x0f)

$C$DW$329	.dwtag  DW_TAG_member
	.dwattr $C$DW$329, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$329, DW_AT_name("ioutRef_pu")
	.dwattr $C$DW$329, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$329, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$329, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$329, DW_AT_decl_line(0x93)
	.dwattr $C$DW$329, DW_AT_decl_column(0x0f)

$C$DW$330	.dwtag  DW_TAG_member
	.dwattr $C$DW$330, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$330, DW_AT_name("ioutSet_pu")
	.dwattr $C$DW$330, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$330, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$330, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$330, DW_AT_decl_line(0x94)
	.dwattr $C$DW$330, DW_AT_decl_column(0x0f)

$C$DW$331	.dwtag  DW_TAG_member
	.dwattr $C$DW$331, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$331, DW_AT_name("ioutSense_pu")
	.dwattr $C$DW$331, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$331, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$331, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$331, DW_AT_decl_line(0x95)
	.dwattr $C$DW$331, DW_AT_decl_column(0x0f)

$C$DW$332	.dwtag  DW_TAG_member
	.dwattr $C$DW$332, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$332, DW_AT_name("voutRef_pu")
	.dwattr $C$DW$332, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$332, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$332, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$332, DW_AT_decl_line(0x97)
	.dwattr $C$DW$332, DW_AT_decl_column(0x0f)

$C$DW$333	.dwtag  DW_TAG_member
	.dwattr $C$DW$333, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$333, DW_AT_name("voutSet_pu")
	.dwattr $C$DW$333, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$333, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$333, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$333, DW_AT_decl_line(0x98)
	.dwattr $C$DW$333, DW_AT_decl_column(0x0f)

$C$DW$334	.dwtag  DW_TAG_member
	.dwattr $C$DW$334, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$334, DW_AT_name("voutSense_pu")
	.dwattr $C$DW$334, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$334, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$334, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$334, DW_AT_decl_line(0x99)
	.dwattr $C$DW$334, DW_AT_decl_column(0x0f)

$C$DW$335	.dwtag  DW_TAG_member
	.dwattr $C$DW$335, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$335, DW_AT_name("uk_cc_pu")
	.dwattr $C$DW$335, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$335, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$335, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$335, DW_AT_decl_line(0x9b)
	.dwattr $C$DW$335, DW_AT_decl_column(0x0f)

$C$DW$336	.dwtag  DW_TAG_member
	.dwattr $C$DW$336, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$336, DW_AT_name("ek_cc_pu")
	.dwattr $C$DW$336, DW_AT_data_member_location[DW_OP_plus_uconst 0x12]
	.dwattr $C$DW$336, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$336, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$336, DW_AT_decl_line(0x9c)
	.dwattr $C$DW$336, DW_AT_decl_column(0x0f)

$C$DW$337	.dwtag  DW_TAG_member
	.dwattr $C$DW$337, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$337, DW_AT_name("uk_cv_pu")
	.dwattr $C$DW$337, DW_AT_data_member_location[DW_OP_plus_uconst 0x14]
	.dwattr $C$DW$337, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$337, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$337, DW_AT_decl_line(0x9d)
	.dwattr $C$DW$337, DW_AT_decl_column(0x0f)

$C$DW$338	.dwtag  DW_TAG_member
	.dwattr $C$DW$338, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$338, DW_AT_name("ek_cv_pu")
	.dwattr $C$DW$338, DW_AT_data_member_location[DW_OP_plus_uconst 0x16]
	.dwattr $C$DW$338, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$338, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$338, DW_AT_decl_line(0x9e)
	.dwattr $C$DW$338, DW_AT_decl_column(0x0f)

$C$DW$339	.dwtag  DW_TAG_member
	.dwattr $C$DW$339, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$339, DW_AT_name("direction_coeff")
	.dwattr $C$DW$339, DW_AT_data_member_location[DW_OP_plus_uconst 0x18]
	.dwattr $C$DW$339, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$339, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$339, DW_AT_decl_line(0x9f)
	.dwattr $C$DW$339, DW_AT_decl_column(0x0f)

$C$DW$340	.dwtag  DW_TAG_member
	.dwattr $C$DW$340, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$340, DW_AT_name("dutyH_pu")
	.dwattr $C$DW$340, DW_AT_data_member_location[DW_OP_plus_uconst 0x1a]
	.dwattr $C$DW$340, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$340, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$340, DW_AT_decl_line(0xa1)
	.dwattr $C$DW$340, DW_AT_decl_column(0x0f)

$C$DW$341	.dwtag  DW_TAG_member
	.dwattr $C$DW$341, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$341, DW_AT_name("dutyL_pu")
	.dwattr $C$DW$341, DW_AT_data_member_location[DW_OP_plus_uconst 0x1c]
	.dwattr $C$DW$341, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$341, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$341, DW_AT_decl_line(0xa2)
	.dwattr $C$DW$341, DW_AT_decl_column(0x0f)

$C$DW$342	.dwtag  DW_TAG_member
	.dwattr $C$DW$342, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$342, DW_AT_name("ctrlMode_logic")
	.dwattr $C$DW$342, DW_AT_data_member_location[DW_OP_plus_uconst 0x1e]
	.dwattr $C$DW$342, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$342, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$342, DW_AT_decl_line(0xa4)
	.dwattr $C$DW$342, DW_AT_decl_column(0x0e)

$C$DW$343	.dwtag  DW_TAG_member
	.dwattr $C$DW$343, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$343, DW_AT_name("direction_logic")
	.dwattr $C$DW$343, DW_AT_data_member_location[DW_OP_plus_uconst 0x1f]
	.dwattr $C$DW$343, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$343, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$343, DW_AT_decl_line(0xa5)
	.dwattr $C$DW$343, DW_AT_decl_column(0x0e)

$C$DW$344	.dwtag  DW_TAG_member
	.dwattr $C$DW$344, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$344, DW_AT_name("ioutTrip_16b")
	.dwattr $C$DW$344, DW_AT_data_member_location[DW_OP_plus_uconst 0x20]
	.dwattr $C$DW$344, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$344, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$344, DW_AT_decl_line(0xa7)
	.dwattr $C$DW$344, DW_AT_decl_column(0x0d)

$C$DW$345	.dwtag  DW_TAG_member
	.dwattr $C$DW$345, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$345, DW_AT_name("ioutTrip_n_16b")
	.dwattr $C$DW$345, DW_AT_data_member_location[DW_OP_plus_uconst 0x21]
	.dwattr $C$DW$345, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$345, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$345, DW_AT_decl_line(0xa8)
	.dwattr $C$DW$345, DW_AT_decl_column(0x0d)

$C$DW$346	.dwtag  DW_TAG_member
	.dwattr $C$DW$346, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$346, DW_AT_name("tripFlag")
	.dwattr $C$DW$346, DW_AT_data_member_location[DW_OP_plus_uconst 0x22]
	.dwattr $C$DW$346, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$346, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$346, DW_AT_decl_line(0xa9)
	.dwattr $C$DW$346, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$31, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$31, DW_AT_decl_line(0x8f)
	.dwattr $C$DW$T$31, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$31

	.dwendtag $C$DW$TU$31


$C$DW$TU$68	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$68
$C$DW$T$68	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$68, DW_AT_name("BTS_ctrlLoopVariable")
	.dwattr $C$DW$T$68, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$T$68, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$68, DW_AT_decl_line(0xab)
	.dwattr $C$DW$T$68, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$68


$C$DW$TU$69	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$69
$C$DW$T$69	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$69, DW_AT_type(*$C$DW$T$68)
	.dwattr $C$DW$T$69, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$69


$C$DW$TU$33	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$33

$C$DW$T$33	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$33, DW_AT_byte_size(0x52)
$C$DW$347	.dwtag  DW_TAG_member
	.dwattr $C$DW$347, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$347, DW_AT_name("Isense_A")
	.dwattr $C$DW$347, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$347, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$347, DW_AT_decl_line(0x5f)
	.dwattr $C$DW$347, DW_AT_decl_column(0x0f)

$C$DW$348	.dwtag  DW_TAG_member
	.dwattr $C$DW$348, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$348, DW_AT_name("Vsense_V")
	.dwattr $C$DW$348, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$348, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$348, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$348, DW_AT_decl_line(0x60)
	.dwattr $C$DW$348, DW_AT_decl_column(0x0f)

$C$DW$349	.dwtag  DW_TAG_member
	.dwattr $C$DW$349, DW_AT_type(*$C$DW$T$32)
	.dwattr $C$DW$349, DW_AT_name("Isense_16b")
	.dwattr $C$DW$349, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$349, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$349, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$349, DW_AT_decl_line(0x61)
	.dwattr $C$DW$349, DW_AT_decl_column(0x0d)

$C$DW$350	.dwtag  DW_TAG_member
	.dwattr $C$DW$350, DW_AT_type(*$C$DW$T$32)
	.dwattr $C$DW$350, DW_AT_name("Vsense_16b")
	.dwattr $C$DW$350, DW_AT_data_member_location[DW_OP_plus_uconst 0x24]
	.dwattr $C$DW$350, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$350, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$350, DW_AT_decl_line(0x62)
	.dwattr $C$DW$350, DW_AT_decl_column(0x0d)

$C$DW$351	.dwtag  DW_TAG_member
	.dwattr $C$DW$351, DW_AT_type(*$C$DW$T$23)
	.dwattr $C$DW$351, DW_AT_name("Sum_I")
	.dwattr $C$DW$351, DW_AT_data_member_location[DW_OP_plus_uconst 0x44]
	.dwattr $C$DW$351, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$351, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$351, DW_AT_decl_line(0x63)
	.dwattr $C$DW$351, DW_AT_decl_column(0x0d)

$C$DW$352	.dwtag  DW_TAG_member
	.dwattr $C$DW$352, DW_AT_type(*$C$DW$T$23)
	.dwattr $C$DW$352, DW_AT_name("Sum_V")
	.dwattr $C$DW$352, DW_AT_data_member_location[DW_OP_plus_uconst 0x46]
	.dwattr $C$DW$352, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$352, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$352, DW_AT_decl_line(0x64)
	.dwattr $C$DW$352, DW_AT_decl_column(0x0d)

$C$DW$353	.dwtag  DW_TAG_member
	.dwattr $C$DW$353, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$353, DW_AT_name("Index")
	.dwattr $C$DW$353, DW_AT_data_member_location[DW_OP_plus_uconst 0x48]
	.dwattr $C$DW$353, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$353, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$353, DW_AT_decl_line(0x65)
	.dwattr $C$DW$353, DW_AT_decl_column(0x0e)

$C$DW$354	.dwtag  DW_TAG_member
	.dwattr $C$DW$354, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$354, DW_AT_name("IoutGain_A")
	.dwattr $C$DW$354, DW_AT_data_member_location[DW_OP_plus_uconst 0x4a]
	.dwattr $C$DW$354, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$354, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$354, DW_AT_decl_line(0x66)
	.dwattr $C$DW$354, DW_AT_decl_column(0x0f)

$C$DW$355	.dwtag  DW_TAG_member
	.dwattr $C$DW$355, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$355, DW_AT_name("IoutOffset_A")
	.dwattr $C$DW$355, DW_AT_data_member_location[DW_OP_plus_uconst 0x4c]
	.dwattr $C$DW$355, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$355, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$355, DW_AT_decl_line(0x67)
	.dwattr $C$DW$355, DW_AT_decl_column(0x0f)

$C$DW$356	.dwtag  DW_TAG_member
	.dwattr $C$DW$356, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$356, DW_AT_name("VoutGain_V")
	.dwattr $C$DW$356, DW_AT_data_member_location[DW_OP_plus_uconst 0x4e]
	.dwattr $C$DW$356, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$356, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$356, DW_AT_decl_line(0x68)
	.dwattr $C$DW$356, DW_AT_decl_column(0x0f)

$C$DW$357	.dwtag  DW_TAG_member
	.dwattr $C$DW$357, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$357, DW_AT_name("VoutOffset_V")
	.dwattr $C$DW$357, DW_AT_data_member_location[DW_OP_plus_uconst 0x50]
	.dwattr $C$DW$357, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$357, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$357, DW_AT_decl_line(0x69)
	.dwattr $C$DW$357, DW_AT_decl_column(0x0f)

	.dwattr $C$DW$T$33, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$33, DW_AT_decl_line(0x5e)
	.dwattr $C$DW$T$33, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$33

	.dwendtag $C$DW$TU$33


$C$DW$TU$71	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$71
$C$DW$T$71	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$71, DW_AT_name("BTS_measValues")
	.dwattr $C$DW$T$71, DW_AT_type(*$C$DW$T$33)
	.dwattr $C$DW$T$71, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$71, DW_AT_decl_line(0x6b)
	.dwattr $C$DW$T$71, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$71


$C$DW$TU$72	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$72
$C$DW$T$72	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$72, DW_AT_type(*$C$DW$T$71)
	.dwattr $C$DW$T$72, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$72


$C$DW$TU$35	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$35

$C$DW$T$35	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$35, DW_AT_name("_Complex_double")
	.dwattr $C$DW$T$35, DW_AT_byte_size(0x08)
$C$DW$358	.dwtag  DW_TAG_member
	.dwattr $C$DW$358, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$358, DW_AT_name("_Vals")
	.dwattr $C$DW$358, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$358, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$358, DW_AT_decl_line(0xbd)
	.dwattr $C$DW$358, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$T$35

	.dwendtag $C$DW$TU$35


$C$DW$TU$74	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$74
$C$DW$T$74	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$74, DW_AT_name("_Complex_double")
	.dwattr $C$DW$T$74, DW_AT_type(*$C$DW$T$35)
	.dwattr $C$DW$T$74, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$T$74, DW_AT_decl_line(0xbd)
	.dwattr $C$DW$T$74, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$74


$C$DW$TU$37	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$37

$C$DW$T$37	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$37, DW_AT_name("_Complex_float")
	.dwattr $C$DW$T$37, DW_AT_byte_size(0x04)
$C$DW$359	.dwtag  DW_TAG_member
	.dwattr $C$DW$359, DW_AT_type(*$C$DW$T$36)
	.dwattr $C$DW$359, DW_AT_name("_Vals")
	.dwattr $C$DW$359, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$359, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$359, DW_AT_decl_line(0xbd)
	.dwattr $C$DW$359, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$T$37

	.dwendtag $C$DW$TU$37


$C$DW$TU$75	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$75
$C$DW$T$75	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$75, DW_AT_name("_Complex_float")
	.dwattr $C$DW$T$75, DW_AT_type(*$C$DW$T$37)
	.dwattr $C$DW$T$75, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$T$75, DW_AT_decl_line(0xbd)
	.dwattr $C$DW$T$75, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$75


$C$DW$TU$39	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$39

$C$DW$T$39	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$39, DW_AT_name("_Complex_long_double")
	.dwattr $C$DW$T$39, DW_AT_byte_size(0x08)
$C$DW$360	.dwtag  DW_TAG_member
	.dwattr $C$DW$360, DW_AT_type(*$C$DW$T$38)
	.dwattr $C$DW$360, DW_AT_name("_Vals")
	.dwattr $C$DW$360, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$360, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$360, DW_AT_decl_line(0xbd)
	.dwattr $C$DW$360, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$T$39

	.dwendtag $C$DW$TU$39


$C$DW$TU$77	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$77
$C$DW$T$77	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$77, DW_AT_name("_Complex_long_double")
	.dwattr $C$DW$T$77, DW_AT_type(*$C$DW$T$39)
	.dwattr $C$DW$T$77, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$T$77, DW_AT_decl_line(0xbd)
	.dwattr $C$DW$T$77, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$77


$C$DW$TU$2	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$2
$C$DW$T$2	.dwtag  DW_TAG_unspecified_type
	.dwattr $C$DW$T$2, DW_AT_name("void")

	.dwendtag $C$DW$TU$2


$C$DW$TU$78	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$78

$C$DW$T$78	.dwtag  DW_TAG_subroutine_type
	.dwendtag $C$DW$T$78

	.dwendtag $C$DW$TU$78


$C$DW$TU$79	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$79
$C$DW$T$79	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$79, DW_AT_type(*$C$DW$T$78)
	.dwattr $C$DW$T$79, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$79


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


$C$DW$TU$29	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$29
$C$DW$T$29	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$29, DW_AT_name("__int16_t")
	.dwattr $C$DW$T$29, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$29, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$29, DW_AT_decl_line(0x40)
	.dwattr $C$DW$T$29, DW_AT_decl_column(0x1d)

	.dwendtag $C$DW$TU$29


$C$DW$TU$30	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$30
$C$DW$T$30	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$30, DW_AT_name("int16_t")
	.dwattr $C$DW$T$30, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$T$30, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$30, DW_AT_decl_line(0x2b)
	.dwattr $C$DW$T$30, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$30


$C$DW$TU$32	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$32

$C$DW$T$32	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$32, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$T$32, DW_AT_byte_size(0x20)
$C$DW$361	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$361, DW_AT_upper_bound(0x1f)

	.dwendtag $C$DW$T$32

	.dwendtag $C$DW$TU$32


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


$C$DW$TU$117	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$117

$C$DW$T$117	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$117, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$T$117, DW_AT_byte_size(0x04)
$C$DW$362	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$362, DW_AT_upper_bound(0x03)

	.dwendtag $C$DW$T$117

	.dwendtag $C$DW$TU$117


$C$DW$TU$21	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$21
$C$DW$363	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$363, DW_AT_type(*$C$DW$T$20)

$C$DW$T$21	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$21, DW_AT_type(*$C$DW$363)

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
$C$DW$364	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$364, DW_AT_type(*$C$DW$T$23)

$C$DW$T$24	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$24, DW_AT_type(*$C$DW$364)

	.dwendtag $C$DW$TU$24


$C$DW$TU$13	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$13
$C$DW$T$13	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$13, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$13, DW_AT_name("unsigned long")
	.dwattr $C$DW$T$13, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$13


$C$DW$TU$40	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$40
$C$DW$T$40	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$40, DW_AT_name("__uint32_t")
	.dwattr $C$DW$T$40, DW_AT_type(*$C$DW$T$13)
	.dwattr $C$DW$T$40, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$40, DW_AT_decl_line(0x43)
	.dwattr $C$DW$T$40, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$40


$C$DW$TU$41	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$41
$C$DW$T$41	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$41, DW_AT_name("uint32_t")
	.dwattr $C$DW$T$41, DW_AT_type(*$C$DW$T$40)
	.dwattr $C$DW$T$41, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$41, DW_AT_decl_line(0x46)
	.dwattr $C$DW$T$41, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$41


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


$C$DW$TU$36	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$36

$C$DW$T$36	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$36, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$T$36, DW_AT_byte_size(0x04)
$C$DW$365	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$365, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$36

	.dwendtag $C$DW$TU$36


$C$DW$TU$125	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$125
$C$DW$366	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$366, DW_AT_type(*$C$DW$T$16)

$C$DW$T$125	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$125, DW_AT_type(*$C$DW$366)

	.dwendtag $C$DW$TU$125


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
$C$DW$367	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$367, DW_AT_type(*$C$DW$T$26)

$C$DW$T$27	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$27, DW_AT_type(*$C$DW$367)

	.dwendtag $C$DW$TU$27


$C$DW$TU$17	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$17
$C$DW$T$17	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$17, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$17, DW_AT_name("double")
	.dwattr $C$DW$T$17, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$17


$C$DW$TU$34	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$34

$C$DW$T$34	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$34, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$T$34, DW_AT_byte_size(0x08)
$C$DW$368	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$368, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$34

	.dwendtag $C$DW$TU$34


$C$DW$TU$128	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$128
$C$DW$T$128	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$128, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$T$128, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$128


$C$DW$TU$129	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$129
$C$DW$369	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$369, DW_AT_type(*$C$DW$T$128)

$C$DW$T$129	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$129, DW_AT_type(*$C$DW$369)

	.dwendtag $C$DW$TU$129


$C$DW$TU$18	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$18
$C$DW$T$18	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$18, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$18, DW_AT_name("long double")
	.dwattr $C$DW$T$18, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$18


$C$DW$TU$38	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$38

$C$DW$T$38	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$38, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$38, DW_AT_byte_size(0x08)
$C$DW$370	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$370, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$38

	.dwendtag $C$DW$TU$38


$C$DW$TU$131	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$131
$C$DW$T$131	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$131, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$131, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$131


$C$DW$TU$132	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$132
$C$DW$371	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$371, DW_AT_type(*$C$DW$T$131)

$C$DW$T$132	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$132, DW_AT_type(*$C$DW$371)

	.dwendtag $C$DW$TU$132


$C$DW$TU$134	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$134
$C$DW$T$134	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$134, DW_AT_encoding(DW_ATE_unsigned_char)
	.dwattr $C$DW$T$134, DW_AT_name("unsigned char")
	.dwattr $C$DW$T$134, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$134


$C$DW$TU$42	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$42

$C$DW$T$42	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$42, DW_AT_name("dcl_css")
	.dwattr $C$DW$T$42, DW_AT_byte_size(0x0a)
$C$DW$372	.dwtag  DW_TAG_member
	.dwattr $C$DW$372, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$372, DW_AT_name("tpt")
	.dwattr $C$DW$372, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$372, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$372, DW_AT_decl_line(0x91)
	.dwattr $C$DW$372, DW_AT_decl_column(0x0f)

$C$DW$373	.dwtag  DW_TAG_member
	.dwattr $C$DW$373, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$373, DW_AT_name("T")
	.dwattr $C$DW$373, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$373, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$373, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$373, DW_AT_decl_line(0x92)
	.dwattr $C$DW$373, DW_AT_decl_column(0x0f)

$C$DW$374	.dwtag  DW_TAG_member
	.dwattr $C$DW$374, DW_AT_type(*$C$DW$T$41)
	.dwattr $C$DW$374, DW_AT_name("sts")
	.dwattr $C$DW$374, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$374, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$374, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$374, DW_AT_decl_line(0x93)
	.dwattr $C$DW$374, DW_AT_decl_column(0x0e)

$C$DW$375	.dwtag  DW_TAG_member
	.dwattr $C$DW$375, DW_AT_type(*$C$DW$T$41)
	.dwattr $C$DW$375, DW_AT_name("err")
	.dwattr $C$DW$375, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$375, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$375, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$375, DW_AT_decl_line(0x94)
	.dwattr $C$DW$375, DW_AT_decl_column(0x0e)

$C$DW$376	.dwtag  DW_TAG_member
	.dwattr $C$DW$376, DW_AT_type(*$C$DW$T$41)
	.dwattr $C$DW$376, DW_AT_name("loc")
	.dwattr $C$DW$376, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$376, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$376, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$376, DW_AT_decl_line(0x95)
	.dwattr $C$DW$376, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$42, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$T$42, DW_AT_decl_line(0x90)
	.dwattr $C$DW$T$42, DW_AT_decl_column(0x19)
	.dwendtag $C$DW$T$42

	.dwendtag $C$DW$TU$42


$C$DW$TU$46	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$46
$C$DW$377	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$377, DW_AT_type(*$C$DW$T$42)

$C$DW$T$46	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$46, DW_AT_type(*$C$DW$377)

	.dwendtag $C$DW$TU$46


$C$DW$TU$47	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$47
$C$DW$T$47	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$47, DW_AT_name("DCL_CSS")
	.dwattr $C$DW$T$47, DW_AT_type(*$C$DW$T$46)
	.dwattr $C$DW$T$47, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$T$47, DW_AT_decl_line(0x96)
	.dwattr $C$DW$T$47, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$47


$C$DW$TU$48	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$48
$C$DW$T$48	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$48, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$T$48, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$48


$C$DW$TU$49	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$49

$C$DW$T$49	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$49, DW_AT_name("dcl_df22")
	.dwattr $C$DW$T$49, DW_AT_byte_size(0x12)
$C$DW$378	.dwtag  DW_TAG_member
	.dwattr $C$DW$378, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$378, DW_AT_name("b0")
	.dwattr $C$DW$378, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$378, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$378, DW_AT_decl_line(0x4ab)
	.dwattr $C$DW$378, DW_AT_decl_column(0x0f)

$C$DW$379	.dwtag  DW_TAG_member
	.dwattr $C$DW$379, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$379, DW_AT_name("b1")
	.dwattr $C$DW$379, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$379, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$379, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$379, DW_AT_decl_line(0x4ac)
	.dwattr $C$DW$379, DW_AT_decl_column(0x0f)

$C$DW$380	.dwtag  DW_TAG_member
	.dwattr $C$DW$380, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$380, DW_AT_name("b2")
	.dwattr $C$DW$380, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$380, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$380, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$380, DW_AT_decl_line(0x4ad)
	.dwattr $C$DW$380, DW_AT_decl_column(0x0f)

$C$DW$381	.dwtag  DW_TAG_member
	.dwattr $C$DW$381, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$381, DW_AT_name("a1")
	.dwattr $C$DW$381, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$381, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$381, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$381, DW_AT_decl_line(0x4ae)
	.dwattr $C$DW$381, DW_AT_decl_column(0x0f)

$C$DW$382	.dwtag  DW_TAG_member
	.dwattr $C$DW$382, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$382, DW_AT_name("a2")
	.dwattr $C$DW$382, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$382, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$382, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$382, DW_AT_decl_line(0x4af)
	.dwattr $C$DW$382, DW_AT_decl_column(0x0f)

$C$DW$383	.dwtag  DW_TAG_member
	.dwattr $C$DW$383, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$383, DW_AT_name("x1")
	.dwattr $C$DW$383, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$383, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$383, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$383, DW_AT_decl_line(0x4b0)
	.dwattr $C$DW$383, DW_AT_decl_column(0x0f)

$C$DW$384	.dwtag  DW_TAG_member
	.dwattr $C$DW$384, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$384, DW_AT_name("x2")
	.dwattr $C$DW$384, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$384, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$384, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$384, DW_AT_decl_line(0x4b1)
	.dwattr $C$DW$384, DW_AT_decl_column(0x0f)

$C$DW$385	.dwtag  DW_TAG_member
	.dwattr $C$DW$385, DW_AT_type(*$C$DW$T$45)
	.dwattr $C$DW$385, DW_AT_name("sps")
	.dwattr $C$DW$385, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$385, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$385, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$385, DW_AT_decl_line(0x4b2)
	.dwattr $C$DW$385, DW_AT_decl_column(0x13)

$C$DW$386	.dwtag  DW_TAG_member
	.dwattr $C$DW$386, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$386, DW_AT_name("css")
	.dwattr $C$DW$386, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$386, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$386, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$386, DW_AT_decl_line(0x4b3)
	.dwattr $C$DW$386, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$49, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$49, DW_AT_decl_line(0x4aa)
	.dwattr $C$DW$T$49, DW_AT_decl_column(0x19)
	.dwendtag $C$DW$T$49

	.dwendtag $C$DW$TU$49


$C$DW$TU$93	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$93
$C$DW$387	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$387, DW_AT_type(*$C$DW$T$49)

$C$DW$T$93	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$93, DW_AT_type(*$C$DW$387)

	.dwendtag $C$DW$TU$93


$C$DW$TU$94	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$94
$C$DW$T$94	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$94, DW_AT_name("DCL_DF22")
	.dwattr $C$DW$T$94, DW_AT_type(*$C$DW$T$93)
	.dwattr $C$DW$T$94, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$94, DW_AT_decl_line(0x4b4)
	.dwattr $C$DW$T$94, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$94


$C$DW$TU$50	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$50

$C$DW$T$50	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$50, DW_AT_name("dcl_df22_sps")
	.dwattr $C$DW$T$50, DW_AT_byte_size(0x0a)
$C$DW$388	.dwtag  DW_TAG_member
	.dwattr $C$DW$388, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$388, DW_AT_name("b0")
	.dwattr $C$DW$388, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$388, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$388, DW_AT_decl_line(0x49f)
	.dwattr $C$DW$388, DW_AT_decl_column(0x0f)

$C$DW$389	.dwtag  DW_TAG_member
	.dwattr $C$DW$389, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$389, DW_AT_name("b1")
	.dwattr $C$DW$389, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$389, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$389, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$389, DW_AT_decl_line(0x4a0)
	.dwattr $C$DW$389, DW_AT_decl_column(0x0f)

$C$DW$390	.dwtag  DW_TAG_member
	.dwattr $C$DW$390, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$390, DW_AT_name("b2")
	.dwattr $C$DW$390, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$390, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$390, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$390, DW_AT_decl_line(0x4a1)
	.dwattr $C$DW$390, DW_AT_decl_column(0x0f)

$C$DW$391	.dwtag  DW_TAG_member
	.dwattr $C$DW$391, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$391, DW_AT_name("a1")
	.dwattr $C$DW$391, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$391, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$391, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$391, DW_AT_decl_line(0x4a2)
	.dwattr $C$DW$391, DW_AT_decl_column(0x0f)

$C$DW$392	.dwtag  DW_TAG_member
	.dwattr $C$DW$392, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$392, DW_AT_name("a2")
	.dwattr $C$DW$392, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$392, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$392, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$392, DW_AT_decl_line(0x4a3)
	.dwattr $C$DW$392, DW_AT_decl_column(0x0f)

	.dwattr $C$DW$T$50, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$50, DW_AT_decl_line(0x49e)
	.dwattr $C$DW$T$50, DW_AT_decl_column(0x19)
	.dwendtag $C$DW$T$50

	.dwendtag $C$DW$TU$50


$C$DW$TU$43	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$43
$C$DW$393	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$393, DW_AT_type(*$C$DW$T$50)

$C$DW$T$43	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$43, DW_AT_type(*$C$DW$393)

	.dwendtag $C$DW$TU$43


$C$DW$TU$44	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$44
$C$DW$T$44	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$44, DW_AT_name("DCL_DF22_SPS")
	.dwattr $C$DW$T$44, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$T$44, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$44, DW_AT_decl_line(0x4a4)
	.dwattr $C$DW$T$44, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$44


$C$DW$TU$45	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$45
$C$DW$T$45	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$45, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$T$45, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$45

