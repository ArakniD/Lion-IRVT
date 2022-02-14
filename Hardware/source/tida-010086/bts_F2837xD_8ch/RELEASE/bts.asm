;***************************************************************
;* TMS320C2000 G3 C/C++ Codegen                               PC v20.2.4.LTS *
;* Date/Time created: Tue Mar  2 07:24:44 2021                 *
;***************************************************************
	.compiler_opts --abi=eabi --cla_support=cla1 --diag_wrap=off --float_support=fpu32 --hll_source=on --mem_model:code=flat --mem_model:data=large --object_format=elf --quiet --silicon_errata_fpu1_workaround=off --silicon_version=28 --symdebug:dwarf --symdebug:dwarf_version=4 --tmu_support=tmu0 --vcu_support=vcu2 
	.asg	XAR2, FP

$C$DW$CU	.dwtag  DW_TAG_compile_unit
	.dwattr $C$DW$CU, DW_AT_name("../bts.c")
	.dwattr $C$DW$CU, DW_AT_producer("TI TMS320C2000 G3 C/C++ Codegen PC v20.2.4.LTS Copyright (c) 1996-2018 Texas Instruments Incorporated")
	.dwattr $C$DW$CU, DW_AT_TI_version(0x01)
	.dwattr $C$DW$CU, DW_AT_comp_dir("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\release")

$C$DW$1	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$1, DW_AT_name("SFRA_F32_reset")
	.dwattr $C$DW$1, DW_AT_linkage_name("SFRA_F32_reset")
	.dwattr $C$DW$1, DW_AT_declaration
	.dwattr $C$DW$1, DW_AT_external
	.dwattr $C$DW$1, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$1, DW_AT_decl_line(0x5a)
	.dwattr $C$DW$1, DW_AT_decl_column(0x0d)
$C$DW$2	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$2, DW_AT_type(*$C$DW$T$58)

	.dwendtag $C$DW$1


$C$DW$3	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$3, DW_AT_name("SFRA_F32_config")
	.dwattr $C$DW$3, DW_AT_linkage_name("SFRA_F32_config")
	.dwattr $C$DW$3, DW_AT_declaration
	.dwattr $C$DW$3, DW_AT_external
	.dwattr $C$DW$3, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$3, DW_AT_decl_line(0x6e)
	.dwattr $C$DW$3, DW_AT_decl_column(0x0d)
$C$DW$4	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$4, DW_AT_type(*$C$DW$T$58)

$C$DW$5	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$5, DW_AT_type(*$C$DW$T$19)

$C$DW$6	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$6, DW_AT_type(*$C$DW$T$19)

$C$DW$7	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$7, DW_AT_type(*$C$DW$T$22)

$C$DW$8	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$8, DW_AT_type(*$C$DW$T$19)

$C$DW$9	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$9, DW_AT_type(*$C$DW$T$19)

$C$DW$10	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$10, DW_AT_type(*$C$DW$T$20)

$C$DW$11	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$11, DW_AT_type(*$C$DW$T$20)

$C$DW$12	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$12, DW_AT_type(*$C$DW$T$20)

$C$DW$13	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$13, DW_AT_type(*$C$DW$T$20)

$C$DW$14	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$14, DW_AT_type(*$C$DW$T$20)

$C$DW$15	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$15, DW_AT_type(*$C$DW$T$20)

$C$DW$16	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$16, DW_AT_type(*$C$DW$T$20)

$C$DW$17	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$17, DW_AT_type(*$C$DW$T$22)

	.dwendtag $C$DW$3


$C$DW$18	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$18, DW_AT_name("SFRA_F32_resetFreqRespArray")
	.dwattr $C$DW$18, DW_AT_linkage_name("SFRA_F32_resetFreqRespArray")
	.dwattr $C$DW$18, DW_AT_declaration
	.dwattr $C$DW$18, DW_AT_external
	.dwattr $C$DW$18, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$18, DW_AT_decl_line(0x8c)
	.dwattr $C$DW$18, DW_AT_decl_column(0x0d)
$C$DW$19	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$19, DW_AT_type(*$C$DW$T$58)

	.dwendtag $C$DW$18


$C$DW$20	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$20, DW_AT_name("SFRA_F32_initFreqArrayWithLogSteps")
	.dwattr $C$DW$20, DW_AT_linkage_name("SFRA_F32_initFreqArrayWithLogSteps")
	.dwattr $C$DW$20, DW_AT_declaration
	.dwattr $C$DW$20, DW_AT_external
	.dwattr $C$DW$20, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$20, DW_AT_decl_line(0x83)
	.dwattr $C$DW$20, DW_AT_decl_column(0x0d)
$C$DW$21	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$21, DW_AT_type(*$C$DW$T$58)

$C$DW$22	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$22, DW_AT_type(*$C$DW$T$19)

$C$DW$23	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$23, DW_AT_type(*$C$DW$T$19)

	.dwendtag $C$DW$20


$C$DW$24	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$24, DW_AT_name("SFRA_GUI_config")
	.dwattr $C$DW$24, DW_AT_linkage_name("SFRA_GUI_config")
	.dwattr $C$DW$24, DW_AT_declaration
	.dwattr $C$DW$24, DW_AT_external
	.dwattr $C$DW$24, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_gui_scicomms_driverlib.h")
	.dwattr $C$DW$24, DW_AT_decl_line(0x3b)
	.dwattr $C$DW$24, DW_AT_decl_column(0x06)
$C$DW$25	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$25, DW_AT_type(*$C$DW$T$92)

$C$DW$26	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$26, DW_AT_type(*$C$DW$T$37)

$C$DW$27	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$27, DW_AT_type(*$C$DW$T$37)

$C$DW$28	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$28, DW_AT_type(*$C$DW$T$26)

$C$DW$29	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$29, DW_AT_type(*$C$DW$T$37)

$C$DW$30	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$30, DW_AT_type(*$C$DW$T$26)

$C$DW$31	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$31, DW_AT_type(*$C$DW$T$37)

$C$DW$32	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$32, DW_AT_type(*$C$DW$T$26)

$C$DW$33	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$33, DW_AT_type(*$C$DW$T$26)

$C$DW$34	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$34, DW_AT_type(*$C$DW$T$37)

$C$DW$35	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$35, DW_AT_type(*$C$DW$T$58)

$C$DW$36	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$36, DW_AT_type(*$C$DW$T$26)

	.dwendtag $C$DW$24


$C$DW$37	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$37, DW_AT_name("I2C_disableInterrupt")
	.dwattr $C$DW$37, DW_AT_linkage_name("I2C_disableInterrupt")
	.dwattr $C$DW$37, DW_AT_declaration
	.dwattr $C$DW$37, DW_AT_external
	.dwattr $C$DW$37, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$37, DW_AT_decl_line(0x4af)
	.dwattr $C$DW$37, DW_AT_decl_column(0x01)
$C$DW$38	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$38, DW_AT_type(*$C$DW$T$37)

$C$DW$39	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$39, DW_AT_type(*$C$DW$T$37)

	.dwendtag $C$DW$37


$C$DW$40	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$40, DW_AT_name("handleI2C_ErrorCondition")
	.dwattr $C$DW$40, DW_AT_linkage_name("handleI2C_ErrorCondition")
	.dwattr $C$DW$40, DW_AT_declaration
	.dwattr $C$DW$40, DW_AT_external
	.dwattr $C$DW$40, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\i2cLib_FIFO_master_slave_interrupt.h")
	.dwattr $C$DW$40, DW_AT_decl_line(0x61)
	.dwattr $C$DW$40, DW_AT_decl_column(0x0d)
$C$DW$41	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$41, DW_AT_type(*$C$DW$T$40)

	.dwendtag $C$DW$40


$C$DW$42	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$42, DW_AT_name("Write_Read_TX_RX_FIFO")
	.dwattr $C$DW$42, DW_AT_linkage_name("Write_Read_TX_RX_FIFO")
	.dwattr $C$DW$42, DW_AT_declaration
	.dwattr $C$DW$42, DW_AT_external
	.dwattr $C$DW$42, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\i2cLib_FIFO_master_slave_interrupt.h")
	.dwattr $C$DW$42, DW_AT_decl_line(0x62)
	.dwattr $C$DW$42, DW_AT_decl_column(0x0d)
$C$DW$43	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$43, DW_AT_type(*$C$DW$T$40)

	.dwendtag $C$DW$42


$C$DW$44	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$44, DW_AT_name("I2C_enableInterrupt")
	.dwattr $C$DW$44, DW_AT_linkage_name("I2C_enableInterrupt")
	.dwattr $C$DW$44, DW_AT_declaration
	.dwattr $C$DW$44, DW_AT_external
	.dwattr $C$DW$44, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$44, DW_AT_decl_line(0x49b)
	.dwattr $C$DW$44, DW_AT_decl_column(0x01)
$C$DW$45	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$45, DW_AT_type(*$C$DW$T$37)

$C$DW$46	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$46, DW_AT_type(*$C$DW$T$37)

	.dwendtag $C$DW$44


$C$DW$47	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$47, DW_AT_name("I2C_clearInterruptStatus")
	.dwattr $C$DW$47, DW_AT_linkage_name("I2C_clearInterruptStatus")
	.dwattr $C$DW$47, DW_AT_declaration
	.dwattr $C$DW$47, DW_AT_external
	.dwattr $C$DW$47, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h")
	.dwattr $C$DW$47, DW_AT_decl_line(0x4e5)
	.dwattr $C$DW$47, DW_AT_decl_column(0x01)
$C$DW$48	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$48, DW_AT_type(*$C$DW$T$37)

$C$DW$49	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$49, DW_AT_type(*$C$DW$T$37)

	.dwendtag $C$DW$47

	.global	||BUCK_sfoStatus||
	.bss	||BUCK_sfoStatus||,1,1,0
$C$DW$50	.dwtag  DW_TAG_variable
	.dwattr $C$DW$50, DW_AT_name("BUCK_sfoStatus")
	.dwattr $C$DW$50, DW_AT_linkage_name("BUCK_sfoStatus")
	.dwattr $C$DW$50, DW_AT_location[DW_OP_addr ||BUCK_sfoStatus||]
	.dwattr $C$DW$50, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$50, DW_AT_external
	.dwattr $C$DW$50, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$50, DW_AT_decl_line(0x58)
	.dwattr $C$DW$50, DW_AT_decl_column(0x16)

	.global	||BTS_sfoStatus||
	.bss	||BTS_sfoStatus||,1,1,0
$C$DW$51	.dwtag  DW_TAG_variable
	.dwattr $C$DW$51, DW_AT_name("BTS_sfoStatus")
	.dwattr $C$DW$51, DW_AT_linkage_name("BTS_sfoStatus")
	.dwattr $C$DW$51, DW_AT_location[DW_OP_addr ||BTS_sfoStatus||]
	.dwattr $C$DW$51, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$51, DW_AT_external
	.dwattr $C$DW$51, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$51, DW_AT_decl_line(0x59)
	.dwattr $C$DW$51, DW_AT_decl_column(0x16)

	.global	||status||
	.bss	||status||,1,1,0
$C$DW$52	.dwtag  DW_TAG_variable
	.dwattr $C$DW$52, DW_AT_name("status")
	.dwattr $C$DW$52, DW_AT_linkage_name("status")
	.dwattr $C$DW$52, DW_AT_location[DW_OP_addr ||status||]
	.dwattr $C$DW$52, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$52, DW_AT_external
	.dwattr $C$DW$52, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$52, DW_AT_decl_line(0x240)
	.dwattr $C$DW$52, DW_AT_decl_column(0x0a)


$C$DW$53	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$53, DW_AT_name("SFO")
	.dwattr $C$DW$53, DW_AT_linkage_name("SFO")
	.dwattr $C$DW$53, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$53, DW_AT_declaration
	.dwattr $C$DW$53, DW_AT_external
	.dwattr $C$DW$53, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/SFO/SFO_V8.h")
	.dwattr $C$DW$53, DW_AT_decl_line(0x40)
	.dwattr $C$DW$53, DW_AT_decl_column(0x05)
	.dwendtag $C$DW$53

	.global	||MEP_ScaleFactor||
	.bss	||MEP_ScaleFactor||,2,1,1
$C$DW$54	.dwtag  DW_TAG_variable
	.dwattr $C$DW$54, DW_AT_name("MEP_ScaleFactor")
	.dwattr $C$DW$54, DW_AT_linkage_name("MEP_ScaleFactor")
	.dwattr $C$DW$54, DW_AT_location[DW_OP_addr ||MEP_ScaleFactor||]
	.dwattr $C$DW$54, DW_AT_type(*$C$DW$T$37)
	.dwattr $C$DW$54, DW_AT_external
	.dwattr $C$DW$54, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$54, DW_AT_decl_line(0x57)
	.dwattr $C$DW$54, DW_AT_decl_column(0x16)

	.global	||i2c_int_crnt_responderPtr||
	.bss	||i2c_int_crnt_responderPtr||,2,1,1
$C$DW$55	.dwtag  DW_TAG_variable
	.dwattr $C$DW$55, DW_AT_name("i2c_int_crnt_responderPtr")
	.dwattr $C$DW$55, DW_AT_linkage_name("i2c_int_crnt_responderPtr")
	.dwattr $C$DW$55, DW_AT_location[DW_OP_addr ||i2c_int_crnt_responderPtr||]
	.dwattr $C$DW$55, DW_AT_type(*$C$DW$T$40)
	.dwattr $C$DW$55, DW_AT_external
	.dwattr $C$DW$55, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$55, DW_AT_decl_line(0x234)
	.dwattr $C$DW$55, DW_AT_decl_column(0x13)

	.global	||I2CA_ControlAddr||
	.bss	||I2CA_ControlAddr||,2,1,1
$C$DW$56	.dwtag  DW_TAG_variable
	.dwattr $C$DW$56, DW_AT_name("I2CA_ControlAddr")
	.dwattr $C$DW$56, DW_AT_linkage_name("I2CA_ControlAddr")
	.dwattr $C$DW$56, DW_AT_location[DW_OP_addr ||I2CA_ControlAddr||]
	.dwattr $C$DW$56, DW_AT_type(*$C$DW$T$37)
	.dwattr $C$DW$56, DW_AT_external
	.dwattr $C$DW$56, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$56, DW_AT_decl_line(0x23e)
	.dwattr $C$DW$56, DW_AT_decl_column(0x0a)

	.global	||I2CB_ControlAddr||
	.bss	||I2CB_ControlAddr||,2,1,1
$C$DW$57	.dwtag  DW_TAG_variable
	.dwattr $C$DW$57, DW_AT_name("I2CB_ControlAddr")
	.dwattr $C$DW$57, DW_AT_linkage_name("I2CB_ControlAddr")
	.dwattr $C$DW$57, DW_AT_location[DW_OP_addr ||I2CB_ControlAddr||]
	.dwattr $C$DW$57, DW_AT_type(*$C$DW$T$37)
	.dwattr $C$DW$57, DW_AT_external
	.dwattr $C$DW$57, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$57, DW_AT_decl_line(0x23f)
	.dwattr $C$DW$57, DW_AT_decl_column(0x0a)


$C$DW$58	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$58, DW_AT_name("SysCtl_getLowSpeedClock")
	.dwattr $C$DW$58, DW_AT_linkage_name("SysCtl_getLowSpeedClock")
	.dwattr $C$DW$58, DW_AT_type(*$C$DW$T$37)
	.dwattr $C$DW$58, DW_AT_declaration
	.dwattr $C$DW$58, DW_AT_external
	.dwattr $C$DW$58, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$58, DW_AT_decl_line(0xc8a)
	.dwattr $C$DW$58, DW_AT_decl_column(0x01)
$C$DW$59	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$59, DW_AT_type(*$C$DW$T$37)

	.dwendtag $C$DW$58

	.global	||BTS_ctrl_cc_ch1||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cc_ch1||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cc_ch1||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cc_ch1.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch1.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch1.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch1.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch1.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch1.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch1.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cc_ch1.sps @ 224
	.bits		0,32
			; BTS_ctrl_cc_ch1.css @ 256

$C$DW$60	.dwtag  DW_TAG_variable
	.dwattr $C$DW$60, DW_AT_name("BTS_ctrl_cc_ch1")
	.dwattr $C$DW$60, DW_AT_linkage_name("BTS_ctrl_cc_ch1")
	.dwattr $C$DW$60, DW_AT_location[DW_OP_addr ||BTS_ctrl_cc_ch1||]
	.dwattr $C$DW$60, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$60, DW_AT_external
	.dwattr $C$DW$60, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$60, DW_AT_decl_line(0x31)
	.dwattr $C$DW$60, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cc_ch2||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cc_ch2||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cc_ch2||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cc_ch2.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch2.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch2.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch2.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch2.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch2.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch2.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cc_ch2.sps @ 224
	.bits		0,32
			; BTS_ctrl_cc_ch2.css @ 256

$C$DW$61	.dwtag  DW_TAG_variable
	.dwattr $C$DW$61, DW_AT_name("BTS_ctrl_cc_ch2")
	.dwattr $C$DW$61, DW_AT_linkage_name("BTS_ctrl_cc_ch2")
	.dwattr $C$DW$61, DW_AT_location[DW_OP_addr ||BTS_ctrl_cc_ch2||]
	.dwattr $C$DW$61, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$61, DW_AT_external
	.dwattr $C$DW$61, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$61, DW_AT_decl_line(0x32)
	.dwattr $C$DW$61, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cc_ch3||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cc_ch3||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cc_ch3||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cc_ch3.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch3.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch3.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch3.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch3.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch3.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch3.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cc_ch3.sps @ 224
	.bits		0,32
			; BTS_ctrl_cc_ch3.css @ 256

$C$DW$62	.dwtag  DW_TAG_variable
	.dwattr $C$DW$62, DW_AT_name("BTS_ctrl_cc_ch3")
	.dwattr $C$DW$62, DW_AT_linkage_name("BTS_ctrl_cc_ch3")
	.dwattr $C$DW$62, DW_AT_location[DW_OP_addr ||BTS_ctrl_cc_ch3||]
	.dwattr $C$DW$62, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$62, DW_AT_external
	.dwattr $C$DW$62, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$62, DW_AT_decl_line(0x33)
	.dwattr $C$DW$62, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cc_ch4||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cc_ch4||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cc_ch4||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cc_ch4.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch4.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch4.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch4.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch4.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch4.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch4.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cc_ch4.sps @ 224
	.bits		0,32
			; BTS_ctrl_cc_ch4.css @ 256

$C$DW$63	.dwtag  DW_TAG_variable
	.dwattr $C$DW$63, DW_AT_name("BTS_ctrl_cc_ch4")
	.dwattr $C$DW$63, DW_AT_linkage_name("BTS_ctrl_cc_ch4")
	.dwattr $C$DW$63, DW_AT_location[DW_OP_addr ||BTS_ctrl_cc_ch4||]
	.dwattr $C$DW$63, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$63, DW_AT_external
	.dwattr $C$DW$63, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$63, DW_AT_decl_line(0x34)
	.dwattr $C$DW$63, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cc_ch5||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cc_ch5||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cc_ch5||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cc_ch5.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch5.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch5.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch5.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch5.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch5.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch5.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cc_ch5.sps @ 224
	.bits		0,32
			; BTS_ctrl_cc_ch5.css @ 256

$C$DW$64	.dwtag  DW_TAG_variable
	.dwattr $C$DW$64, DW_AT_name("BTS_ctrl_cc_ch5")
	.dwattr $C$DW$64, DW_AT_linkage_name("BTS_ctrl_cc_ch5")
	.dwattr $C$DW$64, DW_AT_location[DW_OP_addr ||BTS_ctrl_cc_ch5||]
	.dwattr $C$DW$64, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$64, DW_AT_external
	.dwattr $C$DW$64, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$64, DW_AT_decl_line(0x35)
	.dwattr $C$DW$64, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cc_ch6||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cc_ch6||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cc_ch6||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cc_ch6.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch6.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch6.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch6.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch6.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch6.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch6.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cc_ch6.sps @ 224
	.bits		0,32
			; BTS_ctrl_cc_ch6.css @ 256

$C$DW$65	.dwtag  DW_TAG_variable
	.dwattr $C$DW$65, DW_AT_name("BTS_ctrl_cc_ch6")
	.dwattr $C$DW$65, DW_AT_linkage_name("BTS_ctrl_cc_ch6")
	.dwattr $C$DW$65, DW_AT_location[DW_OP_addr ||BTS_ctrl_cc_ch6||]
	.dwattr $C$DW$65, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$65, DW_AT_external
	.dwattr $C$DW$65, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$65, DW_AT_decl_line(0x36)
	.dwattr $C$DW$65, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cc_ch7||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cc_ch7||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cc_ch7||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cc_ch7.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch7.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch7.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch7.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch7.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch7.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch7.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cc_ch7.sps @ 224
	.bits		0,32
			; BTS_ctrl_cc_ch7.css @ 256

$C$DW$66	.dwtag  DW_TAG_variable
	.dwattr $C$DW$66, DW_AT_name("BTS_ctrl_cc_ch7")
	.dwattr $C$DW$66, DW_AT_linkage_name("BTS_ctrl_cc_ch7")
	.dwattr $C$DW$66, DW_AT_location[DW_OP_addr ||BTS_ctrl_cc_ch7||]
	.dwattr $C$DW$66, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$66, DW_AT_external
	.dwattr $C$DW$66, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$66, DW_AT_decl_line(0x37)
	.dwattr $C$DW$66, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cc_ch8||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cc_ch8||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cc_ch8||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cc_ch8.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch8.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch8.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch8.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch8.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch8.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cc_ch8.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cc_ch8.sps @ 224
	.bits		0,32
			; BTS_ctrl_cc_ch8.css @ 256

$C$DW$67	.dwtag  DW_TAG_variable
	.dwattr $C$DW$67, DW_AT_name("BTS_ctrl_cc_ch8")
	.dwattr $C$DW$67, DW_AT_linkage_name("BTS_ctrl_cc_ch8")
	.dwattr $C$DW$67, DW_AT_location[DW_OP_addr ||BTS_ctrl_cc_ch8||]
	.dwattr $C$DW$67, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$67, DW_AT_external
	.dwattr $C$DW$67, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$67, DW_AT_decl_line(0x38)
	.dwattr $C$DW$67, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cv_ch1||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cv_ch1||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cv_ch1||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cv_ch1.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch1.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch1.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch1.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch1.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch1.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch1.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cv_ch1.sps @ 224
	.bits		0,32
			; BTS_ctrl_cv_ch1.css @ 256

$C$DW$68	.dwtag  DW_TAG_variable
	.dwattr $C$DW$68, DW_AT_name("BTS_ctrl_cv_ch1")
	.dwattr $C$DW$68, DW_AT_linkage_name("BTS_ctrl_cv_ch1")
	.dwattr $C$DW$68, DW_AT_location[DW_OP_addr ||BTS_ctrl_cv_ch1||]
	.dwattr $C$DW$68, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$68, DW_AT_external
	.dwattr $C$DW$68, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$68, DW_AT_decl_line(0x3a)
	.dwattr $C$DW$68, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cv_ch2||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cv_ch2||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cv_ch2||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cv_ch2.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch2.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch2.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch2.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch2.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch2.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch2.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cv_ch2.sps @ 224
	.bits		0,32
			; BTS_ctrl_cv_ch2.css @ 256

$C$DW$69	.dwtag  DW_TAG_variable
	.dwattr $C$DW$69, DW_AT_name("BTS_ctrl_cv_ch2")
	.dwattr $C$DW$69, DW_AT_linkage_name("BTS_ctrl_cv_ch2")
	.dwattr $C$DW$69, DW_AT_location[DW_OP_addr ||BTS_ctrl_cv_ch2||]
	.dwattr $C$DW$69, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$69, DW_AT_external
	.dwattr $C$DW$69, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$69, DW_AT_decl_line(0x3b)
	.dwattr $C$DW$69, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cv_ch3||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cv_ch3||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cv_ch3||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cv_ch3.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch3.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch3.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch3.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch3.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch3.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch3.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cv_ch3.sps @ 224
	.bits		0,32
			; BTS_ctrl_cv_ch3.css @ 256

$C$DW$70	.dwtag  DW_TAG_variable
	.dwattr $C$DW$70, DW_AT_name("BTS_ctrl_cv_ch3")
	.dwattr $C$DW$70, DW_AT_linkage_name("BTS_ctrl_cv_ch3")
	.dwattr $C$DW$70, DW_AT_location[DW_OP_addr ||BTS_ctrl_cv_ch3||]
	.dwattr $C$DW$70, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$70, DW_AT_external
	.dwattr $C$DW$70, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$70, DW_AT_decl_line(0x3c)
	.dwattr $C$DW$70, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cv_ch4||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cv_ch4||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cv_ch4||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cv_ch4.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch4.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch4.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch4.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch4.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch4.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch4.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cv_ch4.sps @ 224
	.bits		0,32
			; BTS_ctrl_cv_ch4.css @ 256

$C$DW$71	.dwtag  DW_TAG_variable
	.dwattr $C$DW$71, DW_AT_name("BTS_ctrl_cv_ch4")
	.dwattr $C$DW$71, DW_AT_linkage_name("BTS_ctrl_cv_ch4")
	.dwattr $C$DW$71, DW_AT_location[DW_OP_addr ||BTS_ctrl_cv_ch4||]
	.dwattr $C$DW$71, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$71, DW_AT_external
	.dwattr $C$DW$71, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$71, DW_AT_decl_line(0x3d)
	.dwattr $C$DW$71, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cv_ch5||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cv_ch5||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cv_ch5||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cv_ch5.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch5.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch5.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch5.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch5.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch5.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch5.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cv_ch5.sps @ 224
	.bits		0,32
			; BTS_ctrl_cv_ch5.css @ 256

$C$DW$72	.dwtag  DW_TAG_variable
	.dwattr $C$DW$72, DW_AT_name("BTS_ctrl_cv_ch5")
	.dwattr $C$DW$72, DW_AT_linkage_name("BTS_ctrl_cv_ch5")
	.dwattr $C$DW$72, DW_AT_location[DW_OP_addr ||BTS_ctrl_cv_ch5||]
	.dwattr $C$DW$72, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$72, DW_AT_external
	.dwattr $C$DW$72, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$72, DW_AT_decl_line(0x3e)
	.dwattr $C$DW$72, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cv_ch6||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cv_ch6||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cv_ch6||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cv_ch6.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch6.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch6.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch6.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch6.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch6.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch6.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cv_ch6.sps @ 224
	.bits		0,32
			; BTS_ctrl_cv_ch6.css @ 256

$C$DW$73	.dwtag  DW_TAG_variable
	.dwattr $C$DW$73, DW_AT_name("BTS_ctrl_cv_ch6")
	.dwattr $C$DW$73, DW_AT_linkage_name("BTS_ctrl_cv_ch6")
	.dwattr $C$DW$73, DW_AT_location[DW_OP_addr ||BTS_ctrl_cv_ch6||]
	.dwattr $C$DW$73, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$73, DW_AT_external
	.dwattr $C$DW$73, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$73, DW_AT_decl_line(0x3f)
	.dwattr $C$DW$73, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cv_ch7||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cv_ch7||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cv_ch7||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cv_ch7.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch7.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch7.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch7.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch7.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch7.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch7.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cv_ch7.sps @ 224
	.bits		0,32
			; BTS_ctrl_cv_ch7.css @ 256

$C$DW$74	.dwtag  DW_TAG_variable
	.dwattr $C$DW$74, DW_AT_name("BTS_ctrl_cv_ch7")
	.dwattr $C$DW$74, DW_AT_linkage_name("BTS_ctrl_cv_ch7")
	.dwattr $C$DW$74, DW_AT_location[DW_OP_addr ||BTS_ctrl_cv_ch7||]
	.dwattr $C$DW$74, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$74, DW_AT_external
	.dwattr $C$DW$74, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$74, DW_AT_decl_line(0x40)
	.dwattr $C$DW$74, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_cv_ch8||
	.data
	.align	2
	.elfsym	||BTS_ctrl_cv_ch8||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_cv_ch8||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_cv_ch8.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch8.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch8.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch8.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch8.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch8.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_cv_ch8.x2 @ 192
	.bits		0,32
			; BTS_ctrl_cv_ch8.sps @ 224
	.bits		0,32
			; BTS_ctrl_cv_ch8.css @ 256

$C$DW$75	.dwtag  DW_TAG_variable
	.dwattr $C$DW$75, DW_AT_name("BTS_ctrl_cv_ch8")
	.dwattr $C$DW$75, DW_AT_linkage_name("BTS_ctrl_cv_ch8")
	.dwattr $C$DW$75, DW_AT_location[DW_OP_addr ||BTS_ctrl_cv_ch8||]
	.dwattr $C$DW$75, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$75, DW_AT_external
	.dwattr $C$DW$75, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$75, DW_AT_decl_line(0x41)
	.dwattr $C$DW$75, DW_AT_decl_column(0x15)

	.global	||BTS_ctrl_ch1||
	.data
	.align	2
	.elfsym	||BTS_ctrl_ch1||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_ch1||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_ch1.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch1.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch1.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch1.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch1.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch1.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch1.x2 @ 192
	.bits		0,32
			; BTS_ctrl_ch1.sps @ 224
	.bits		0,32
			; BTS_ctrl_ch1.css @ 256

$C$DW$76	.dwtag  DW_TAG_variable
	.dwattr $C$DW$76, DW_AT_name("BTS_ctrl_ch1")
	.dwattr $C$DW$76, DW_AT_linkage_name("BTS_ctrl_ch1")
	.dwattr $C$DW$76, DW_AT_location[DW_OP_addr ||BTS_ctrl_ch1||]
	.dwattr $C$DW$76, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$76, DW_AT_external
	.dwattr $C$DW$76, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$76, DW_AT_decl_line(0x6b)
	.dwattr $C$DW$76, DW_AT_decl_column(0x1e)

	.global	||BTS_ctrl_ch2||
	.data
	.align	2
	.elfsym	||BTS_ctrl_ch2||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_ch2||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_ch2.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch2.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch2.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch2.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch2.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch2.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch2.x2 @ 192
	.bits		0,32
			; BTS_ctrl_ch2.sps @ 224
	.bits		0,32
			; BTS_ctrl_ch2.css @ 256

$C$DW$77	.dwtag  DW_TAG_variable
	.dwattr $C$DW$77, DW_AT_name("BTS_ctrl_ch2")
	.dwattr $C$DW$77, DW_AT_linkage_name("BTS_ctrl_ch2")
	.dwattr $C$DW$77, DW_AT_location[DW_OP_addr ||BTS_ctrl_ch2||]
	.dwattr $C$DW$77, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$77, DW_AT_external
	.dwattr $C$DW$77, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$77, DW_AT_decl_line(0x6c)
	.dwattr $C$DW$77, DW_AT_decl_column(0x1e)

	.global	||BTS_ctrl_ch3||
	.data
	.align	2
	.elfsym	||BTS_ctrl_ch3||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_ch3||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_ch3.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch3.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch3.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch3.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch3.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch3.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch3.x2 @ 192
	.bits		0,32
			; BTS_ctrl_ch3.sps @ 224
	.bits		0,32
			; BTS_ctrl_ch3.css @ 256

$C$DW$78	.dwtag  DW_TAG_variable
	.dwattr $C$DW$78, DW_AT_name("BTS_ctrl_ch3")
	.dwattr $C$DW$78, DW_AT_linkage_name("BTS_ctrl_ch3")
	.dwattr $C$DW$78, DW_AT_location[DW_OP_addr ||BTS_ctrl_ch3||]
	.dwattr $C$DW$78, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$78, DW_AT_external
	.dwattr $C$DW$78, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$78, DW_AT_decl_line(0x6d)
	.dwattr $C$DW$78, DW_AT_decl_column(0x1e)

	.global	||BTS_ctrl_ch4||
	.data
	.align	2
	.elfsym	||BTS_ctrl_ch4||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_ch4||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_ch4.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch4.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch4.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch4.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch4.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch4.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch4.x2 @ 192
	.bits		0,32
			; BTS_ctrl_ch4.sps @ 224
	.bits		0,32
			; BTS_ctrl_ch4.css @ 256

$C$DW$79	.dwtag  DW_TAG_variable
	.dwattr $C$DW$79, DW_AT_name("BTS_ctrl_ch4")
	.dwattr $C$DW$79, DW_AT_linkage_name("BTS_ctrl_ch4")
	.dwattr $C$DW$79, DW_AT_location[DW_OP_addr ||BTS_ctrl_ch4||]
	.dwattr $C$DW$79, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$79, DW_AT_external
	.dwattr $C$DW$79, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$79, DW_AT_decl_line(0x6e)
	.dwattr $C$DW$79, DW_AT_decl_column(0x1e)

	.global	||BTS_ctrl_ch5||
	.data
	.align	2
	.elfsym	||BTS_ctrl_ch5||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_ch5||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_ch5.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch5.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch5.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch5.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch5.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch5.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch5.x2 @ 192
	.bits		0,32
			; BTS_ctrl_ch5.sps @ 224
	.bits		0,32
			; BTS_ctrl_ch5.css @ 256

$C$DW$80	.dwtag  DW_TAG_variable
	.dwattr $C$DW$80, DW_AT_name("BTS_ctrl_ch5")
	.dwattr $C$DW$80, DW_AT_linkage_name("BTS_ctrl_ch5")
	.dwattr $C$DW$80, DW_AT_location[DW_OP_addr ||BTS_ctrl_ch5||]
	.dwattr $C$DW$80, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$80, DW_AT_external
	.dwattr $C$DW$80, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$80, DW_AT_decl_line(0x6f)
	.dwattr $C$DW$80, DW_AT_decl_column(0x1e)

	.global	||BTS_ctrl_ch6||
	.data
	.align	2
	.elfsym	||BTS_ctrl_ch6||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_ch6||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_ch6.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch6.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch6.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch6.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch6.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch6.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch6.x2 @ 192
	.bits		0,32
			; BTS_ctrl_ch6.sps @ 224
	.bits		0,32
			; BTS_ctrl_ch6.css @ 256

$C$DW$81	.dwtag  DW_TAG_variable
	.dwattr $C$DW$81, DW_AT_name("BTS_ctrl_ch6")
	.dwattr $C$DW$81, DW_AT_linkage_name("BTS_ctrl_ch6")
	.dwattr $C$DW$81, DW_AT_location[DW_OP_addr ||BTS_ctrl_ch6||]
	.dwattr $C$DW$81, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$81, DW_AT_external
	.dwattr $C$DW$81, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$81, DW_AT_decl_line(0x70)
	.dwattr $C$DW$81, DW_AT_decl_column(0x1e)

	.global	||BTS_ctrl_ch7||
	.data
	.align	2
	.elfsym	||BTS_ctrl_ch7||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_ch7||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_ch7.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch7.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch7.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch7.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch7.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch7.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch7.x2 @ 192
	.bits		0,32
			; BTS_ctrl_ch7.sps @ 224
	.bits		0,32
			; BTS_ctrl_ch7.css @ 256

$C$DW$82	.dwtag  DW_TAG_variable
	.dwattr $C$DW$82, DW_AT_name("BTS_ctrl_ch7")
	.dwattr $C$DW$82, DW_AT_linkage_name("BTS_ctrl_ch7")
	.dwattr $C$DW$82, DW_AT_location[DW_OP_addr ||BTS_ctrl_ch7||]
	.dwattr $C$DW$82, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$82, DW_AT_external
	.dwattr $C$DW$82, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$82, DW_AT_decl_line(0x71)
	.dwattr $C$DW$82, DW_AT_decl_column(0x1e)

	.global	||BTS_ctrl_ch8||
	.data
	.align	2
	.elfsym	||BTS_ctrl_ch8||,SYM_SIZE(18),SYM_BLOCKED(1)
||BTS_ctrl_ch8||:
	.xfloat	$strtod("0x1p+0")		; BTS_ctrl_ch8.b0 @ 0
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch8.b1 @ 32
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch8.b2 @ 64
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch8.a1 @ 96
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch8.a2 @ 128
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch8.x1 @ 160
	.xfloat	$strtod("0x0p+0")		; BTS_ctrl_ch8.x2 @ 192
	.bits		0,32
			; BTS_ctrl_ch8.sps @ 224
	.bits		0,32
			; BTS_ctrl_ch8.css @ 256

$C$DW$83	.dwtag  DW_TAG_variable
	.dwattr $C$DW$83, DW_AT_name("BTS_ctrl_ch8")
	.dwattr $C$DW$83, DW_AT_linkage_name("BTS_ctrl_ch8")
	.dwattr $C$DW$83, DW_AT_location[DW_OP_addr ||BTS_ctrl_ch8||]
	.dwattr $C$DW$83, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$83, DW_AT_external
	.dwattr $C$DW$83, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$83, DW_AT_decl_line(0x72)
	.dwattr $C$DW$83, DW_AT_decl_column(0x1e)

	.global	||I2CA||
	.bss	||I2CA||,18,1,1
$C$DW$84	.dwtag  DW_TAG_variable
	.dwattr $C$DW$84, DW_AT_name("I2CA")
	.dwattr $C$DW$84, DW_AT_linkage_name("I2CA")
	.dwattr $C$DW$84, DW_AT_location[DW_OP_addr ||I2CA||]
	.dwattr $C$DW$84, DW_AT_type(*$C$DW$T$41)
	.dwattr $C$DW$84, DW_AT_external
	.dwattr $C$DW$84, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$84, DW_AT_decl_line(0x228)
	.dwattr $C$DW$84, DW_AT_decl_column(0x12)

	.global	||I2CB||
	.bss	||I2CB||,18,1,1
$C$DW$85	.dwtag  DW_TAG_variable
	.dwattr $C$DW$85, DW_AT_name("I2CB")
	.dwattr $C$DW$85, DW_AT_linkage_name("I2CB")
	.dwattr $C$DW$85, DW_AT_location[DW_OP_addr ||I2CB||]
	.dwattr $C$DW$85, DW_AT_type(*$C$DW$T$41)
	.dwattr $C$DW$85, DW_AT_external
	.dwattr $C$DW$85, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$85, DW_AT_decl_line(0x229)
	.dwattr $C$DW$85, DW_AT_decl_column(0x12)

	.global	||AvailableI2C_slaves||
||AvailableI2C_slaves||:	.usect	".bss:AvailableI2C_slaves",20,0,0
$C$DW$86	.dwtag  DW_TAG_variable
	.dwattr $C$DW$86, DW_AT_name("AvailableI2C_slaves")
	.dwattr $C$DW$86, DW_AT_linkage_name("AvailableI2C_slaves")
	.dwattr $C$DW$86, DW_AT_location[DW_OP_addr ||AvailableI2C_slaves||]
	.dwattr $C$DW$86, DW_AT_type(*$C$DW$T$109)
	.dwattr $C$DW$86, DW_AT_external
	.dwattr $C$DW$86, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$86, DW_AT_decl_line(0x236)
	.dwattr $C$DW$86, DW_AT_decl_column(0x0a)

	.global	||BTS_userInput_ch1||
	.bss	||BTS_userInput_ch1||,30,1,1
$C$DW$87	.dwtag  DW_TAG_variable
	.dwattr $C$DW$87, DW_AT_name("BTS_userInput_ch1")
	.dwattr $C$DW$87, DW_AT_linkage_name("BTS_userInput_ch1")
	.dwattr $C$DW$87, DW_AT_location[DW_OP_addr ||BTS_userInput_ch1||]
	.dwattr $C$DW$87, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$87, DW_AT_external
	.dwattr $C$DW$87, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$87, DW_AT_decl_line(0x28)
	.dwattr $C$DW$87, DW_AT_decl_column(0x0f)

	.global	||BTS_userInput_ch2||
	.bss	||BTS_userInput_ch2||,30,1,1
$C$DW$88	.dwtag  DW_TAG_variable
	.dwattr $C$DW$88, DW_AT_name("BTS_userInput_ch2")
	.dwattr $C$DW$88, DW_AT_linkage_name("BTS_userInput_ch2")
	.dwattr $C$DW$88, DW_AT_location[DW_OP_addr ||BTS_userInput_ch2||]
	.dwattr $C$DW$88, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$88, DW_AT_external
	.dwattr $C$DW$88, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$88, DW_AT_decl_line(0x29)
	.dwattr $C$DW$88, DW_AT_decl_column(0x0f)

	.global	||BTS_userInput_ch3||
	.bss	||BTS_userInput_ch3||,30,1,1
$C$DW$89	.dwtag  DW_TAG_variable
	.dwattr $C$DW$89, DW_AT_name("BTS_userInput_ch3")
	.dwattr $C$DW$89, DW_AT_linkage_name("BTS_userInput_ch3")
	.dwattr $C$DW$89, DW_AT_location[DW_OP_addr ||BTS_userInput_ch3||]
	.dwattr $C$DW$89, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$89, DW_AT_external
	.dwattr $C$DW$89, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$89, DW_AT_decl_line(0x2a)
	.dwattr $C$DW$89, DW_AT_decl_column(0x0f)

	.global	||BTS_userInput_ch4||
	.bss	||BTS_userInput_ch4||,30,1,1
$C$DW$90	.dwtag  DW_TAG_variable
	.dwattr $C$DW$90, DW_AT_name("BTS_userInput_ch4")
	.dwattr $C$DW$90, DW_AT_linkage_name("BTS_userInput_ch4")
	.dwattr $C$DW$90, DW_AT_location[DW_OP_addr ||BTS_userInput_ch4||]
	.dwattr $C$DW$90, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$90, DW_AT_external
	.dwattr $C$DW$90, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$90, DW_AT_decl_line(0x2b)
	.dwattr $C$DW$90, DW_AT_decl_column(0x0f)

	.global	||BTS_userInput_ch5||
	.bss	||BTS_userInput_ch5||,30,1,1
$C$DW$91	.dwtag  DW_TAG_variable
	.dwattr $C$DW$91, DW_AT_name("BTS_userInput_ch5")
	.dwattr $C$DW$91, DW_AT_linkage_name("BTS_userInput_ch5")
	.dwattr $C$DW$91, DW_AT_location[DW_OP_addr ||BTS_userInput_ch5||]
	.dwattr $C$DW$91, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$91, DW_AT_external
	.dwattr $C$DW$91, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$91, DW_AT_decl_line(0x2c)
	.dwattr $C$DW$91, DW_AT_decl_column(0x0f)

	.global	||BTS_userInput_ch6||
	.bss	||BTS_userInput_ch6||,30,1,1
$C$DW$92	.dwtag  DW_TAG_variable
	.dwattr $C$DW$92, DW_AT_name("BTS_userInput_ch6")
	.dwattr $C$DW$92, DW_AT_linkage_name("BTS_userInput_ch6")
	.dwattr $C$DW$92, DW_AT_location[DW_OP_addr ||BTS_userInput_ch6||]
	.dwattr $C$DW$92, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$92, DW_AT_external
	.dwattr $C$DW$92, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$92, DW_AT_decl_line(0x2d)
	.dwattr $C$DW$92, DW_AT_decl_column(0x0f)

	.global	||BTS_userInput_ch7||
	.bss	||BTS_userInput_ch7||,30,1,1
$C$DW$93	.dwtag  DW_TAG_variable
	.dwattr $C$DW$93, DW_AT_name("BTS_userInput_ch7")
	.dwattr $C$DW$93, DW_AT_linkage_name("BTS_userInput_ch7")
	.dwattr $C$DW$93, DW_AT_location[DW_OP_addr ||BTS_userInput_ch7||]
	.dwattr $C$DW$93, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$93, DW_AT_external
	.dwattr $C$DW$93, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$93, DW_AT_decl_line(0x2e)
	.dwattr $C$DW$93, DW_AT_decl_column(0x0f)

	.global	||BTS_userInput_ch8||
	.bss	||BTS_userInput_ch8||,30,1,1
$C$DW$94	.dwtag  DW_TAG_variable
	.dwattr $C$DW$94, DW_AT_name("BTS_userInput_ch8")
	.dwattr $C$DW$94, DW_AT_linkage_name("BTS_userInput_ch8")
	.dwattr $C$DW$94, DW_AT_location[DW_OP_addr ||BTS_userInput_ch8||]
	.dwattr $C$DW$94, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$94, DW_AT_external
	.dwattr $C$DW$94, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$94, DW_AT_decl_line(0x2f)
	.dwattr $C$DW$94, DW_AT_decl_column(0x0f)

	.global	||BTS_sfra||
	.bss	||BTS_sfra||,32,1,1
$C$DW$95	.dwtag  DW_TAG_variable
	.dwattr $C$DW$95, DW_AT_name("BTS_sfra")
	.dwattr $C$DW$95, DW_AT_linkage_name("BTS_sfra")
	.dwattr $C$DW$95, DW_AT_location[DW_OP_addr ||BTS_sfra||]
	.dwattr $C$DW$95, DW_AT_type(*$C$DW$T$57)
	.dwattr $C$DW$95, DW_AT_external
	.dwattr $C$DW$95, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$95, DW_AT_decl_line(0x8f)
	.dwattr $C$DW$95, DW_AT_decl_column(0x16)

	.global	||BTS_ctrlLoopVariable_ch1||
	.bss	||BTS_ctrlLoopVariable_ch1||,36,1,1
$C$DW$96	.dwtag  DW_TAG_variable
	.dwattr $C$DW$96, DW_AT_name("BTS_ctrlLoopVariable_ch1")
	.dwattr $C$DW$96, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch1")
	.dwattr $C$DW$96, DW_AT_location[DW_OP_addr ||BTS_ctrlLoopVariable_ch1||]
	.dwattr $C$DW$96, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$96, DW_AT_external
	.dwattr $C$DW$96, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$96, DW_AT_decl_line(0x79)
	.dwattr $C$DW$96, DW_AT_decl_column(0x16)

	.global	||BTS_ctrlLoopVariable_ch2||
	.bss	||BTS_ctrlLoopVariable_ch2||,36,1,1
$C$DW$97	.dwtag  DW_TAG_variable
	.dwattr $C$DW$97, DW_AT_name("BTS_ctrlLoopVariable_ch2")
	.dwattr $C$DW$97, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch2")
	.dwattr $C$DW$97, DW_AT_location[DW_OP_addr ||BTS_ctrlLoopVariable_ch2||]
	.dwattr $C$DW$97, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$97, DW_AT_external
	.dwattr $C$DW$97, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$97, DW_AT_decl_line(0x7a)
	.dwattr $C$DW$97, DW_AT_decl_column(0x16)

	.global	||BTS_ctrlLoopVariable_ch3||
	.bss	||BTS_ctrlLoopVariable_ch3||,36,1,1
$C$DW$98	.dwtag  DW_TAG_variable
	.dwattr $C$DW$98, DW_AT_name("BTS_ctrlLoopVariable_ch3")
	.dwattr $C$DW$98, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch3")
	.dwattr $C$DW$98, DW_AT_location[DW_OP_addr ||BTS_ctrlLoopVariable_ch3||]
	.dwattr $C$DW$98, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$98, DW_AT_external
	.dwattr $C$DW$98, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$98, DW_AT_decl_line(0x7b)
	.dwattr $C$DW$98, DW_AT_decl_column(0x16)

	.global	||BTS_ctrlLoopVariable_ch4||
	.bss	||BTS_ctrlLoopVariable_ch4||,36,1,1
$C$DW$99	.dwtag  DW_TAG_variable
	.dwattr $C$DW$99, DW_AT_name("BTS_ctrlLoopVariable_ch4")
	.dwattr $C$DW$99, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch4")
	.dwattr $C$DW$99, DW_AT_location[DW_OP_addr ||BTS_ctrlLoopVariable_ch4||]
	.dwattr $C$DW$99, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$99, DW_AT_external
	.dwattr $C$DW$99, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$99, DW_AT_decl_line(0x7c)
	.dwattr $C$DW$99, DW_AT_decl_column(0x16)

	.global	||BTS_ctrlLoopVariable_ch5||
	.bss	||BTS_ctrlLoopVariable_ch5||,36,1,1
$C$DW$100	.dwtag  DW_TAG_variable
	.dwattr $C$DW$100, DW_AT_name("BTS_ctrlLoopVariable_ch5")
	.dwattr $C$DW$100, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch5")
	.dwattr $C$DW$100, DW_AT_location[DW_OP_addr ||BTS_ctrlLoopVariable_ch5||]
	.dwattr $C$DW$100, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$100, DW_AT_external
	.dwattr $C$DW$100, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$100, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$100, DW_AT_decl_column(0x16)

	.global	||BTS_ctrlLoopVariable_ch6||
	.bss	||BTS_ctrlLoopVariable_ch6||,36,1,1
$C$DW$101	.dwtag  DW_TAG_variable
	.dwattr $C$DW$101, DW_AT_name("BTS_ctrlLoopVariable_ch6")
	.dwattr $C$DW$101, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch6")
	.dwattr $C$DW$101, DW_AT_location[DW_OP_addr ||BTS_ctrlLoopVariable_ch6||]
	.dwattr $C$DW$101, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$101, DW_AT_external
	.dwattr $C$DW$101, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$101, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$101, DW_AT_decl_column(0x16)

	.global	||BTS_ctrlLoopVariable_ch7||
	.bss	||BTS_ctrlLoopVariable_ch7||,36,1,1
$C$DW$102	.dwtag  DW_TAG_variable
	.dwattr $C$DW$102, DW_AT_name("BTS_ctrlLoopVariable_ch7")
	.dwattr $C$DW$102, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch7")
	.dwattr $C$DW$102, DW_AT_location[DW_OP_addr ||BTS_ctrlLoopVariable_ch7||]
	.dwattr $C$DW$102, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$102, DW_AT_external
	.dwattr $C$DW$102, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$102, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$102, DW_AT_decl_column(0x16)

	.global	||BTS_ctrlLoopVariable_ch8||
	.bss	||BTS_ctrlLoopVariable_ch8||,36,1,1
$C$DW$103	.dwtag  DW_TAG_variable
	.dwattr $C$DW$103, DW_AT_name("BTS_ctrlLoopVariable_ch8")
	.dwattr $C$DW$103, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch8")
	.dwattr $C$DW$103, DW_AT_location[DW_OP_addr ||BTS_ctrlLoopVariable_ch8||]
	.dwattr $C$DW$103, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$103, DW_AT_external
	.dwattr $C$DW$103, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$103, DW_AT_decl_line(0x80)
	.dwattr $C$DW$103, DW_AT_decl_column(0x16)

	.global	||I2CA_TXdata||
||I2CA_TXdata||:	.usect	".bss:I2CA_TXdata",64,0,0
$C$DW$104	.dwtag  DW_TAG_variable
	.dwattr $C$DW$104, DW_AT_name("I2CA_TXdata")
	.dwattr $C$DW$104, DW_AT_linkage_name("I2CA_TXdata")
	.dwattr $C$DW$104, DW_AT_location[DW_OP_addr ||I2CA_TXdata||]
	.dwattr $C$DW$104, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$104, DW_AT_external
	.dwattr $C$DW$104, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$104, DW_AT_decl_line(0x238)
	.dwattr $C$DW$104, DW_AT_decl_column(0x0a)

	.global	||I2CB_TXdata||
||I2CB_TXdata||:	.usect	".bss:I2CB_TXdata",64,0,0
$C$DW$105	.dwtag  DW_TAG_variable
	.dwattr $C$DW$105, DW_AT_name("I2CB_TXdata")
	.dwattr $C$DW$105, DW_AT_linkage_name("I2CB_TXdata")
	.dwattr $C$DW$105, DW_AT_location[DW_OP_addr ||I2CB_TXdata||]
	.dwattr $C$DW$105, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$105, DW_AT_external
	.dwattr $C$DW$105, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$105, DW_AT_decl_line(0x239)
	.dwattr $C$DW$105, DW_AT_decl_column(0x0a)

	.global	||I2CA_RXdata||
||I2CA_RXdata||:	.usect	".bss:I2CA_RXdata",64,0,0
$C$DW$106	.dwtag  DW_TAG_variable
	.dwattr $C$DW$106, DW_AT_name("I2CA_RXdata")
	.dwattr $C$DW$106, DW_AT_linkage_name("I2CA_RXdata")
	.dwattr $C$DW$106, DW_AT_location[DW_OP_addr ||I2CA_RXdata||]
	.dwattr $C$DW$106, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$106, DW_AT_external
	.dwattr $C$DW$106, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$106, DW_AT_decl_line(0x23b)
	.dwattr $C$DW$106, DW_AT_decl_column(0x0a)

	.global	||I2CB_RXdata||
||I2CB_RXdata||:	.usect	".bss:I2CB_RXdata",64,0,0
$C$DW$107	.dwtag  DW_TAG_variable
	.dwattr $C$DW$107, DW_AT_name("I2CB_RXdata")
	.dwattr $C$DW$107, DW_AT_linkage_name("I2CB_RXdata")
	.dwattr $C$DW$107, DW_AT_location[DW_OP_addr ||I2CB_RXdata||]
	.dwattr $C$DW$107, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$107, DW_AT_external
	.dwattr $C$DW$107, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$107, DW_AT_decl_line(0x23c)
	.dwattr $C$DW$107, DW_AT_decl_column(0x0a)

	.global	||BTS_measValues_ch1||
	.bss	||BTS_measValues_ch1||,82,1,1
$C$DW$108	.dwtag  DW_TAG_variable
	.dwattr $C$DW$108, DW_AT_name("BTS_measValues_ch1")
	.dwattr $C$DW$108, DW_AT_linkage_name("BTS_measValues_ch1")
	.dwattr $C$DW$108, DW_AT_location[DW_OP_addr ||BTS_measValues_ch1||]
	.dwattr $C$DW$108, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$108, DW_AT_external
	.dwattr $C$DW$108, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$108, DW_AT_decl_line(0x1f)
	.dwattr $C$DW$108, DW_AT_decl_column(0x10)

	.global	||BTS_measValues_ch2||
	.bss	||BTS_measValues_ch2||,82,1,1
$C$DW$109	.dwtag  DW_TAG_variable
	.dwattr $C$DW$109, DW_AT_name("BTS_measValues_ch2")
	.dwattr $C$DW$109, DW_AT_linkage_name("BTS_measValues_ch2")
	.dwattr $C$DW$109, DW_AT_location[DW_OP_addr ||BTS_measValues_ch2||]
	.dwattr $C$DW$109, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$109, DW_AT_external
	.dwattr $C$DW$109, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$109, DW_AT_decl_line(0x20)
	.dwattr $C$DW$109, DW_AT_decl_column(0x10)

	.global	||BTS_measValues_ch3||
	.bss	||BTS_measValues_ch3||,82,1,1
$C$DW$110	.dwtag  DW_TAG_variable
	.dwattr $C$DW$110, DW_AT_name("BTS_measValues_ch3")
	.dwattr $C$DW$110, DW_AT_linkage_name("BTS_measValues_ch3")
	.dwattr $C$DW$110, DW_AT_location[DW_OP_addr ||BTS_measValues_ch3||]
	.dwattr $C$DW$110, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$110, DW_AT_external
	.dwattr $C$DW$110, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$110, DW_AT_decl_line(0x21)
	.dwattr $C$DW$110, DW_AT_decl_column(0x10)

	.global	||BTS_measValues_ch4||
	.bss	||BTS_measValues_ch4||,82,1,1
$C$DW$111	.dwtag  DW_TAG_variable
	.dwattr $C$DW$111, DW_AT_name("BTS_measValues_ch4")
	.dwattr $C$DW$111, DW_AT_linkage_name("BTS_measValues_ch4")
	.dwattr $C$DW$111, DW_AT_location[DW_OP_addr ||BTS_measValues_ch4||]
	.dwattr $C$DW$111, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$111, DW_AT_external
	.dwattr $C$DW$111, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$111, DW_AT_decl_line(0x22)
	.dwattr $C$DW$111, DW_AT_decl_column(0x10)

	.global	||BTS_measValues_ch5||
	.bss	||BTS_measValues_ch5||,82,1,1
$C$DW$112	.dwtag  DW_TAG_variable
	.dwattr $C$DW$112, DW_AT_name("BTS_measValues_ch5")
	.dwattr $C$DW$112, DW_AT_linkage_name("BTS_measValues_ch5")
	.dwattr $C$DW$112, DW_AT_location[DW_OP_addr ||BTS_measValues_ch5||]
	.dwattr $C$DW$112, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$112, DW_AT_external
	.dwattr $C$DW$112, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$112, DW_AT_decl_line(0x23)
	.dwattr $C$DW$112, DW_AT_decl_column(0x10)

	.global	||BTS_measValues_ch6||
	.bss	||BTS_measValues_ch6||,82,1,1
$C$DW$113	.dwtag  DW_TAG_variable
	.dwattr $C$DW$113, DW_AT_name("BTS_measValues_ch6")
	.dwattr $C$DW$113, DW_AT_linkage_name("BTS_measValues_ch6")
	.dwattr $C$DW$113, DW_AT_location[DW_OP_addr ||BTS_measValues_ch6||]
	.dwattr $C$DW$113, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$113, DW_AT_external
	.dwattr $C$DW$113, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$113, DW_AT_decl_line(0x24)
	.dwattr $C$DW$113, DW_AT_decl_column(0x10)

	.global	||BTS_measValues_ch7||
	.bss	||BTS_measValues_ch7||,82,1,1
$C$DW$114	.dwtag  DW_TAG_variable
	.dwattr $C$DW$114, DW_AT_name("BTS_measValues_ch7")
	.dwattr $C$DW$114, DW_AT_linkage_name("BTS_measValues_ch7")
	.dwattr $C$DW$114, DW_AT_location[DW_OP_addr ||BTS_measValues_ch7||]
	.dwattr $C$DW$114, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$114, DW_AT_external
	.dwattr $C$DW$114, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$114, DW_AT_decl_line(0x25)
	.dwattr $C$DW$114, DW_AT_decl_column(0x10)

	.global	||BTS_measValues_ch8||
	.bss	||BTS_measValues_ch8||,82,1,1
$C$DW$115	.dwtag  DW_TAG_variable
	.dwattr $C$DW$115, DW_AT_name("BTS_measValues_ch8")
	.dwattr $C$DW$115, DW_AT_linkage_name("BTS_measValues_ch8")
	.dwattr $C$DW$115, DW_AT_location[DW_OP_addr ||BTS_measValues_ch8||]
	.dwattr $C$DW$115, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$115, DW_AT_external
	.dwattr $C$DW$115, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$115, DW_AT_decl_line(0x26)
	.dwattr $C$DW$115, DW_AT_decl_column(0x10)

	.global	||BTS_sfraData||
	.bss	||BTS_sfraData||,1030,1,1
$C$DW$116	.dwtag  DW_TAG_variable
	.dwattr $C$DW$116, DW_AT_name("BTS_sfraData")
	.dwattr $C$DW$116, DW_AT_linkage_name("BTS_sfraData")
	.dwattr $C$DW$116, DW_AT_location[DW_OP_addr ||BTS_sfraData||]
	.dwattr $C$DW$116, DW_AT_type(*$C$DW$T$75)
	.dwattr $C$DW$116, DW_AT_external
	.dwattr $C$DW$116, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$116, DW_AT_decl_line(0x90)
	.dwattr $C$DW$116, DW_AT_decl_column(0x15)

	.sblock	".bss"
	.sblock	".data"
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\opt2000.exe C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{168CA723-0823-4132-8582-A3FB4ACFE376} C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{D3884379-A65C-4E20-8F03-FB2545140B93} 
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\acia2000.exe -@C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{6F0621B9-9F31-44BE-96B5-666C2A8F9F11} 
	.sect	"isrcodefuncs:retain"
	.retain
	.retainrefs
	.global	||i2cBISR||

$C$DW$117	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$117, DW_AT_name("i2cBISR")
	.dwattr $C$DW$117, DW_AT_low_pc(||i2cBISR||)
	.dwattr $C$DW$117, DW_AT_high_pc(0x00)
	.dwattr $C$DW$117, DW_AT_linkage_name("i2cBISR")
	.dwattr $C$DW$117, DW_AT_external
	.dwattr $C$DW$117, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$117, DW_AT_decl_line(0x248)
	.dwattr $C$DW$117, DW_AT_decl_column(0x12)
	.dwattr $C$DW$117, DW_AT_TI_interrupt
	.dwattr $C$DW$117, DW_AT_TI_max_frame_size(-18)
	.dwpsn	file "../bts.c",line 585,column 1,is_stmt,address ||i2cBISR||,isa 0

	.dwfde $C$DW$CIE, ||i2cBISR||

;***************************************************************
;* FNAME: i2cBISR                       FR SIZE:  16           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto, 14 SOE     *
;***************************************************************

||i2cBISR||:
;* AR1   assigned to $O$K1
;* AL    assigned to $O$R1
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
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 653,column 5,is_stmt,isa 0
        MOVL      XAR1,#||I2CB||        ; [CPU_ARAU] |653| 
        MOVL      XAR4,*+XAR1[0]        ; [CPU_ALU] |653| 
        MOV       AL,*+XAR4[2]          ; [CPU_ALU] |653| 
	.dwpsn	file "../bts.c",line 588,column 4,is_stmt,isa 0
        TBIT      AL,#9                 ; [CPU_ALU] |588| 
        B         ||$C$L1||,NTC         ; [CPU_ALU] |588| 
        ; branchcc occurs ; [] |588| 
        MOVW      DP,#||I2CA||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 592,column 8,is_stmt,isa 0
        MOVL      XAR4,#131072          ; [CPU_ARAU] |592| 
        MOVL      ACC,@$BLOCKED(||I2CA||) ; [CPU_ALU] |592| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |592| 
$C$DW$118	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$118, DW_AT_low_pc(0x00)
	.dwattr $C$DW$118, DW_AT_name("I2C_disableInterrupt")
	.dwattr $C$DW$118, DW_AT_TI_call

        LCR       #||I2C_disableInterrupt|| ; [CPU_ALU] |592| 
        ; call occurs [#||I2C_disableInterrupt||] ; [] |592| 
||$C$L1||:    
	.dwpsn	file "../bts.c",line 596,column 4,is_stmt,isa 0
        MOVL      XAR4,XAR1             ; [CPU_ALU] |596| 
$C$DW$119	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$119, DW_AT_low_pc(0x00)
	.dwattr $C$DW$119, DW_AT_name("handleI2C_ErrorCondition")
	.dwattr $C$DW$119, DW_AT_TI_call

        LCR       #||handleI2C_ErrorCondition|| ; [CPU_ALU] |596| 
        ; call occurs [#||handleI2C_ErrorCondition||] ; [] |596| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 429,column 5,is_stmt,isa 0
        MOVB      AL,#128               ; [CPU_ALU] |429| 
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
$C$DW$120	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$120, DW_AT_low_pc(0x00)
	.dwattr $C$DW$120, DW_AT_TI_return

        IRET      ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$117, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$117, DW_AT_TI_end_line(0x257)
	.dwattr $C$DW$117, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$117

	.sect	"isrcodefuncs:retain"
	.retain
	.retainrefs
	.global	||i2cBFIFOISR||

$C$DW$121	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$121, DW_AT_name("i2cBFIFOISR")
	.dwattr $C$DW$121, DW_AT_low_pc(||i2cBFIFOISR||)
	.dwattr $C$DW$121, DW_AT_high_pc(0x00)
	.dwattr $C$DW$121, DW_AT_linkage_name("i2cBFIFOISR")
	.dwattr $C$DW$121, DW_AT_external
	.dwattr $C$DW$121, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$121, DW_AT_decl_line(0x25e)
	.dwattr $C$DW$121, DW_AT_decl_column(0x12)
	.dwattr $C$DW$121, DW_AT_TI_interrupt
	.dwattr $C$DW$121, DW_AT_TI_max_frame_size(-18)
	.dwpsn	file "../bts.c",line 607,column 1,is_stmt,address ||i2cBFIFOISR||,isa 0

	.dwfde $C$DW$CIE, ||i2cBFIFOISR||

;***************************************************************
;* FNAME: i2cBFIFOISR                   FR SIZE:  16           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto, 14 SOE     *
;***************************************************************

||i2cBFIFOISR||:
;* AR4   assigned to $O$C1
;* AR4   assigned to $O$v2
;* AR4   assigned to $O$v1
;* AL    assigned to MasterSlave
$C$DW$122	.dwtag  DW_TAG_variable
	.dwattr $C$DW$122, DW_AT_name("MasterSlave")
	.dwattr $C$DW$122, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$122, DW_AT_location[DW_OP_reg0]

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
	.dwpsn	file "../bts.c",line 608,column 5,is_stmt,isa 0
        MOVL      XAR4,#||I2CB||        ; [CPU_ARAU] |608| 
$C$DW$123	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$123, DW_AT_low_pc(0x00)
	.dwattr $C$DW$123, DW_AT_name("Write_Read_TX_RX_FIFO")
	.dwattr $C$DW$123, DW_AT_TI_call

        LCR       #||Write_Read_TX_RX_FIFO|| ; [CPU_ALU] |608| 
        ; call occurs [#||Write_Read_TX_RX_FIFO||] ; [] |608| 
        MOVW      DP,#||I2CB||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 610,column 26,is_stmt,isa 0
        MOVL      XAR4,@$BLOCKED(||I2CB||) ; [CPU_ALU] |610| 
        MOVB      XAR0,#9               ; [CPU_ALU] |610| 
        MOV       AL,*+XAR4[AR0]        ; [CPU_ALU] |610| 
	.dwpsn	file "../bts.c",line 612,column 5,is_stmt,isa 0
        TBIT      AL,#10                ; [CPU_ALU] |612| 
        B         ||$C$L4||,TC          ; [CPU_ALU] |612| 
        ; branchcc occurs ; [] |612| 
	.dwpsn	file "../bts.c",line 630,column 8,is_stmt,isa 0
        TBIT      AL,#9                 ; [CPU_ALU] |630| 
        B         ||$C$L3||,TC          ; [CPU_ALU] |630| 
        ; branchcc occurs ; [] |630| 
	.dwpsn	file "../bts.c",line 644,column 12,is_stmt,isa 0
        MOVL      XAR4,@$BLOCKED(||I2CA||) ; [CPU_ALU] |644| 
        MOVZ      AR6,*+XAR4[5]         ; [CPU_ALU] |644| 
        MOVU      ACC,@$BLOCKED(||I2CA||)+6 ; [CPU_ALU] |644| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |644| 
        B         ||$C$L2||,EQ          ; [CPU_ALU] |644| 
        ; branchcc occurs ; [] |644| 
	.dwpsn	file "../bts.c",line 658,column 16,is_stmt,isa 0
        MOVL      XAR5,#131072          ; [CPU_ARAU] |658| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |658| 
        MOVL      *-SP[2],XAR5          ; [CPU_ALU] |658| 
$C$DW$124	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$124, DW_AT_low_pc(0x00)
	.dwattr $C$DW$124, DW_AT_name("I2C_enableInterrupt")
	.dwattr $C$DW$124, DW_AT_TI_call

        LCR       #||I2C_enableInterrupt|| ; [CPU_ALU] |658| 
        ; call occurs [#||I2C_enableInterrupt||] ; [] |658| 
        MOVW      DP,#||I2CA||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 659,column 16,is_stmt,isa 0
        MOVL      XAR4,#65536           ; [CPU_ARAU] |659| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |659| 
        MOVL      ACC,@$BLOCKED(||I2CA||) ; [CPU_ALU] |659| 
$C$DW$125	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$125, DW_AT_low_pc(0x00)
	.dwattr $C$DW$125, DW_AT_name("I2C_disableInterrupt")
	.dwattr $C$DW$125, DW_AT_TI_call

        LCR       #||I2C_disableInterrupt|| ; [CPU_ALU] |659| 
        ; call occurs [#||I2C_disableInterrupt||] ; [] |659| 
        MOVW      DP,#||I2CA||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 660,column 16,is_stmt,isa 0
        MOVL      XAR4,#196608          ; [CPU_ARAU] |660| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |660| 
        MOVL      ACC,@$BLOCKED(||I2CA||) ; [CPU_ALU] |660| 
$C$DW$126	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$126, DW_AT_low_pc(0x00)
	.dwattr $C$DW$126, DW_AT_name("I2C_clearInterruptStatus")
	.dwattr $C$DW$126, DW_AT_TI_call

        LCR       #||I2C_clearInterruptStatus|| ; [CPU_ALU] |660| 
        ; call occurs [#||I2C_clearInterruptStatus||] ; [] |660| 
        MOVW      DP,#||I2CB||+10       ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 661,column 16,is_stmt,isa 0
        MOVL      ACC,@$BLOCKED(||I2CB||)+10 ; [CPU_ALU] |661| 
        B         ||$C$L7||,NEQ         ; [CPU_ALU] |661| 
        ; branchcc occurs ; [] |661| 
	.dwpsn	file "../bts.c",line 664,column 20,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |664| 
	.dwpsn	file "../bts.c",line 663,column 20,is_stmt,isa 0
        MOVL      ACC,@$BLOCKED(||I2CB||)+4 ; [CPU_ALU] |663| 
        ANDB      AH,#255               ; [CPU_ALU] |663| 
        MOVL      @$BLOCKED(||I2CB||)+10,ACC ; [CPU_ALU] |663| 
	.dwpsn	file "../bts.c",line 664,column 20,is_stmt,isa 0
        MOVL      @$BLOCKED(||I2CB||)+8,XAR6 ; [CPU_ALU] |664| 
        B         ||$C$L7||,UNC         ; [CPU_ALU] |664| 
        ; branch occurs ; [] |664| 
||$C$L2||:    
	.dwpsn	file "../bts.c",line 648,column 16,is_stmt,isa 0
        MOVB      ACC,#4                ; [CPU_ALU] |648| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |648| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |648| 
$C$DW$127	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$127, DW_AT_low_pc(0x00)
	.dwattr $C$DW$127, DW_AT_name("I2C_enableInterrupt")
	.dwattr $C$DW$127, DW_AT_TI_call

        LCR       #||I2C_enableInterrupt|| ; [CPU_ALU] |648| 
        ; call occurs [#||I2C_enableInterrupt||] ; [] |648| 
        MOVW      DP,#||I2CB||+8        ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 649,column 16,is_stmt,isa 0
        MOVL      ACC,@$BLOCKED(||I2CB||)+8 ; [CPU_ALU] |649| 
        B         ||$C$L7||,NEQ         ; [CPU_ALU] |649| 
        ; branchcc occurs ; [] |649| 
	.dwpsn	file "../bts.c",line 652,column 21,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |652| 
	.dwpsn	file "../bts.c",line 651,column 21,is_stmt,isa 0
        MOVL      ACC,@$BLOCKED(||I2CB||)+4 ; [CPU_ALU] |651| 
        ANDB      AH,#255               ; [CPU_ALU] |651| 
        MOVL      @$BLOCKED(||I2CB||)+8,ACC ; [CPU_ALU] |651| 
	.dwpsn	file "../bts.c",line 652,column 21,is_stmt,isa 0
        MOVL      @$BLOCKED(||I2CB||)+10,XAR6 ; [CPU_ALU] |652| 
        B         ||$C$L7||,UNC         ; [CPU_ALU] |652| 
        ; branch occurs ; [] |652| 
||$C$L3||:    
	.dwpsn	file "../bts.c",line 635,column 12,is_stmt,isa 0
        MOVL      XAR4,#65536           ; [CPU_ARAU] |635| 
        MOVL      ACC,@$BLOCKED(||I2CA||) ; [CPU_ALU] |635| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |635| 
$C$DW$128	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$128, DW_AT_low_pc(0x00)
	.dwattr $C$DW$128, DW_AT_name("I2C_enableInterrupt")
	.dwattr $C$DW$128, DW_AT_TI_call

        LCR       #||I2C_enableInterrupt|| ; [CPU_ALU] |635| 
        ; call occurs [#||I2C_enableInterrupt||] ; [] |635| 
        MOVW      DP,#||I2CA||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 636,column 12,is_stmt,isa 0
        MOVL      XAR4,#131072          ; [CPU_ARAU] |636| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |636| 
        MOVL      ACC,@$BLOCKED(||I2CA||) ; [CPU_ALU] |636| 
$C$DW$129	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$129, DW_AT_low_pc(0x00)
	.dwattr $C$DW$129, DW_AT_name("I2C_disableInterrupt")
	.dwattr $C$DW$129, DW_AT_TI_call

        LCR       #||I2C_disableInterrupt|| ; [CPU_ALU] |636| 
        ; call occurs [#||I2C_disableInterrupt||] ; [] |636| 
        MOVW      DP,#||I2CA||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 637,column 12,is_stmt,isa 0
        MOVL      XAR4,#65536           ; [CPU_ARAU] |637| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |637| 
        MOVL      ACC,@$BLOCKED(||I2CA||) ; [CPU_ALU] |637| 
$C$DW$130	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$130, DW_AT_low_pc(0x00)
	.dwattr $C$DW$130, DW_AT_name("I2C_clearInterruptStatus")
	.dwattr $C$DW$130, DW_AT_TI_call

        LCR       #||I2C_clearInterruptStatus|| ; [CPU_ALU] |637| 
        ; call occurs [#||I2C_clearInterruptStatus||] ; [] |637| 
        MOVW      DP,#||I2CB||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 639,column 12,is_stmt,isa 0
        MOVL      XAR4,#131072          ; [CPU_ARAU] |639| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |639| 
        MOVL      ACC,@$BLOCKED(||I2CB||) ; [CPU_ALU] |639| 
        B         ||$C$L6||,UNC         ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L4||:    
	.dwpsn	file "../bts.c",line 615,column 9,is_stmt,isa 0
        TBIT      AL,#9                 ; [CPU_ALU] |615| 
        B         ||$C$L5||,TC          ; [CPU_ALU] |615| 
        ; branchcc occurs ; [] |615| 
	.dwpsn	file "../bts.c",line 623,column 12,is_stmt,isa 0
        MOVL      XAR4,#131072          ; [CPU_ARAU] |623| 
        MOVL      ACC,@$BLOCKED(||I2CA||) ; [CPU_ALU] |623| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |623| 
$C$DW$131	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$131, DW_AT_low_pc(0x00)
	.dwattr $C$DW$131, DW_AT_name("I2C_enableInterrupt")
	.dwattr $C$DW$131, DW_AT_TI_call

        LCR       #||I2C_enableInterrupt|| ; [CPU_ALU] |623| 
        ; call occurs [#||I2C_enableInterrupt||] ; [] |623| 
        MOVW      DP,#||I2CA||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 624,column 12,is_stmt,isa 0
        MOVL      XAR4,#131072          ; [CPU_ARAU] |624| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |624| 
        MOVL      ACC,@$BLOCKED(||I2CA||) ; [CPU_ALU] |624| 
$C$DW$132	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$132, DW_AT_low_pc(0x00)
	.dwattr $C$DW$132, DW_AT_name("I2C_clearInterruptStatus")
	.dwattr $C$DW$132, DW_AT_TI_call

        LCR       #||I2C_clearInterruptStatus|| ; [CPU_ALU] |624| 
        ; call occurs [#||I2C_clearInterruptStatus||] ; [] |624| 
        B         ||$C$L7||,UNC         ; [CPU_ALU] |624| 
        ; branch occurs ; [] |624| 
||$C$L5||:    
	.dwpsn	file "../bts.c",line 618,column 12,is_stmt,isa 0
        MOVL      XAR5,#131072          ; [CPU_ARAU] |618| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |618| 
        MOVL      *-SP[2],XAR5          ; [CPU_ALU] |618| 
||$C$L6||:    
$C$DW$133	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$133, DW_AT_low_pc(0x00)
	.dwattr $C$DW$133, DW_AT_name("I2C_disableInterrupt")
	.dwattr $C$DW$133, DW_AT_TI_call

        LCR       #||I2C_disableInterrupt|| ; [CPU_ALU] |618| 
        ; call occurs [#||I2C_disableInterrupt||] ; [] |618| 
||$C$L7||:    
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 429,column 5,is_stmt,isa 0
        MOVB      AL,#128               ; [CPU_ALU] |429| 
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
$C$DW$134	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$134, DW_AT_low_pc(0x00)
	.dwattr $C$DW$134, DW_AT_TI_return

        IRET      ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$121, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$121, DW_AT_TI_end_line(0x29f)
	.dwattr $C$DW$121, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$121

	.sect	"isrcodefuncs:retain"
	.retain
	.retainrefs
	.global	||i2cAISR||

$C$DW$135	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$135, DW_AT_name("i2cAISR")
	.dwattr $C$DW$135, DW_AT_low_pc(||i2cAISR||)
	.dwattr $C$DW$135, DW_AT_high_pc(0x00)
	.dwattr $C$DW$135, DW_AT_linkage_name("i2cAISR")
	.dwattr $C$DW$135, DW_AT_external
	.dwattr $C$DW$135, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$135, DW_AT_decl_line(0x2a6)
	.dwattr $C$DW$135, DW_AT_decl_column(0x12)
	.dwattr $C$DW$135, DW_AT_TI_interrupt
	.dwattr $C$DW$135, DW_AT_TI_max_frame_size(-18)
	.dwpsn	file "../bts.c",line 679,column 1,is_stmt,address ||i2cAISR||,isa 0

	.dwfde $C$DW$CIE, ||i2cAISR||

;***************************************************************
;* FNAME: i2cAISR                       FR SIZE:  16           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto, 14 SOE     *
;***************************************************************

||i2cAISR||:
;* AR1   assigned to $O$K1
;* AL    assigned to $O$R1
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
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/i2c.h",line 653,column 5,is_stmt,isa 0
        MOVL      XAR1,#||I2CA||        ; [CPU_ARAU] |653| 
        MOVL      XAR4,*+XAR1[0]        ; [CPU_ALU] |653| 
        MOV       AL,*+XAR4[2]          ; [CPU_ALU] |653| 
	.dwpsn	file "../bts.c",line 682,column 5,is_stmt,isa 0
        TBIT      AL,#9                 ; [CPU_ALU] |682| 
        B         ||$C$L8||,NTC         ; [CPU_ALU] |682| 
        ; branchcc occurs ; [] |682| 
        MOVW      DP,#||I2CB||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 686,column 9,is_stmt,isa 0
        MOVL      XAR4,#131072          ; [CPU_ARAU] |686| 
        MOVL      ACC,@$BLOCKED(||I2CB||) ; [CPU_ALU] |686| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |686| 
$C$DW$136	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$136, DW_AT_low_pc(0x00)
	.dwattr $C$DW$136, DW_AT_name("I2C_disableInterrupt")
	.dwattr $C$DW$136, DW_AT_TI_call

        LCR       #||I2C_disableInterrupt|| ; [CPU_ALU] |686| 
        ; call occurs [#||I2C_disableInterrupt||] ; [] |686| 
||$C$L8||:    
	.dwpsn	file "../bts.c",line 689,column 5,is_stmt,isa 0
        MOVL      XAR4,XAR1             ; [CPU_ALU] |689| 
$C$DW$137	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$137, DW_AT_low_pc(0x00)
	.dwattr $C$DW$137, DW_AT_name("handleI2C_ErrorCondition")
	.dwattr $C$DW$137, DW_AT_TI_call

        LCR       #||handleI2C_ErrorCondition|| ; [CPU_ALU] |689| 
        ; call occurs [#||handleI2C_ErrorCondition||] ; [] |689| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 429,column 5,is_stmt,isa 0
        MOVB      AL,#128               ; [CPU_ALU] |429| 
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
$C$DW$138	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$138, DW_AT_low_pc(0x00)
	.dwattr $C$DW$138, DW_AT_TI_return

        IRET      ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$135, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$135, DW_AT_TI_end_line(0x2b3)
	.dwattr $C$DW$135, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$135

	.sect	"isrcodefuncs:retain"
	.retain
	.retainrefs
	.global	||i2cAFIFOISR||

$C$DW$139	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$139, DW_AT_name("i2cAFIFOISR")
	.dwattr $C$DW$139, DW_AT_low_pc(||i2cAFIFOISR||)
	.dwattr $C$DW$139, DW_AT_high_pc(0x00)
	.dwattr $C$DW$139, DW_AT_linkage_name("i2cAFIFOISR")
	.dwattr $C$DW$139, DW_AT_external
	.dwattr $C$DW$139, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$139, DW_AT_decl_line(0x2ba)
	.dwattr $C$DW$139, DW_AT_decl_column(0x12)
	.dwattr $C$DW$139, DW_AT_TI_interrupt
	.dwattr $C$DW$139, DW_AT_TI_max_frame_size(-18)
	.dwpsn	file "../bts.c",line 699,column 1,is_stmt,address ||i2cAFIFOISR||,isa 0

	.dwfde $C$DW$CIE, ||i2cAFIFOISR||

;***************************************************************
;* FNAME: i2cAFIFOISR                   FR SIZE:  16           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto, 14 SOE     *
;***************************************************************

||i2cAFIFOISR||:
;* AR4   assigned to $O$C1
;* AR4   assigned to $O$v2
;* AR4   assigned to $O$v1
;* AL    assigned to MasterSlave
$C$DW$140	.dwtag  DW_TAG_variable
	.dwattr $C$DW$140, DW_AT_name("MasterSlave")
	.dwattr $C$DW$140, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$140, DW_AT_location[DW_OP_reg0]

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
	.dwpsn	file "../bts.c",line 700,column 5,is_stmt,isa 0
        MOVL      XAR4,#||I2CA||        ; [CPU_ARAU] |700| 
$C$DW$141	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$141, DW_AT_low_pc(0x00)
	.dwattr $C$DW$141, DW_AT_name("Write_Read_TX_RX_FIFO")
	.dwattr $C$DW$141, DW_AT_TI_call

        LCR       #||Write_Read_TX_RX_FIFO|| ; [CPU_ALU] |700| 
        ; call occurs [#||Write_Read_TX_RX_FIFO||] ; [] |700| 
        MOVW      DP,#||I2CA||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 702,column 26,is_stmt,isa 0
        MOVL      XAR4,@$BLOCKED(||I2CA||) ; [CPU_ALU] |702| 
        MOVB      XAR0,#9               ; [CPU_ALU] |702| 
        MOV       AL,*+XAR4[AR0]        ; [CPU_ALU] |702| 
	.dwpsn	file "../bts.c",line 704,column 5,is_stmt,isa 0
        TBIT      AL,#10                ; [CPU_ALU] |704| 
        B         ||$C$L11||,TC         ; [CPU_ALU] |704| 
        ; branchcc occurs ; [] |704| 
	.dwpsn	file "../bts.c",line 722,column 9,is_stmt,isa 0
        TBIT      AL,#9                 ; [CPU_ALU] |722| 
        B         ||$C$L10||,TC         ; [CPU_ALU] |722| 
        ; branchcc occurs ; [] |722| 
	.dwpsn	file "../bts.c",line 736,column 12,is_stmt,isa 0
        MOVL      XAR4,@$BLOCKED(||I2CB||) ; [CPU_ALU] |736| 
        MOVZ      AR6,*+XAR4[5]         ; [CPU_ALU] |736| 
        MOVU      ACC,@$BLOCKED(||I2CB||)+6 ; [CPU_ALU] |736| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |736| 
        B         ||$C$L9||,EQ          ; [CPU_ALU] |736| 
        ; branchcc occurs ; [] |736| 
	.dwpsn	file "../bts.c",line 750,column 16,is_stmt,isa 0
        MOVL      XAR5,#131072          ; [CPU_ARAU] |750| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |750| 
        MOVL      *-SP[2],XAR5          ; [CPU_ALU] |750| 
$C$DW$142	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$142, DW_AT_low_pc(0x00)
	.dwattr $C$DW$142, DW_AT_name("I2C_enableInterrupt")
	.dwattr $C$DW$142, DW_AT_TI_call

        LCR       #||I2C_enableInterrupt|| ; [CPU_ALU] |750| 
        ; call occurs [#||I2C_enableInterrupt||] ; [] |750| 
        MOVW      DP,#||I2CB||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 751,column 16,is_stmt,isa 0
        MOVL      XAR4,#65536           ; [CPU_ARAU] |751| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |751| 
        MOVL      ACC,@$BLOCKED(||I2CB||) ; [CPU_ALU] |751| 
$C$DW$143	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$143, DW_AT_low_pc(0x00)
	.dwattr $C$DW$143, DW_AT_name("I2C_disableInterrupt")
	.dwattr $C$DW$143, DW_AT_TI_call

        LCR       #||I2C_disableInterrupt|| ; [CPU_ALU] |751| 
        ; call occurs [#||I2C_disableInterrupt||] ; [] |751| 
        MOVW      DP,#||I2CB||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 752,column 16,is_stmt,isa 0
        MOVL      XAR4,#196608          ; [CPU_ARAU] |752| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |752| 
        MOVL      ACC,@$BLOCKED(||I2CB||) ; [CPU_ALU] |752| 
$C$DW$144	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$144, DW_AT_low_pc(0x00)
	.dwattr $C$DW$144, DW_AT_name("I2C_clearInterruptStatus")
	.dwattr $C$DW$144, DW_AT_TI_call

        LCR       #||I2C_clearInterruptStatus|| ; [CPU_ALU] |752| 
        ; call occurs [#||I2C_clearInterruptStatus||] ; [] |752| 
        MOVW      DP,#||I2CA||+10       ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 753,column 16,is_stmt,isa 0
        MOVL      ACC,@$BLOCKED(||I2CA||)+10 ; [CPU_ALU] |753| 
        B         ||$C$L14||,NEQ        ; [CPU_ALU] |753| 
        ; branchcc occurs ; [] |753| 
	.dwpsn	file "../bts.c",line 756,column 20,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |756| 
	.dwpsn	file "../bts.c",line 755,column 20,is_stmt,isa 0
        MOVL      ACC,@$BLOCKED(||I2CA||)+4 ; [CPU_ALU] |755| 
        ANDB      AH,#255               ; [CPU_ALU] |755| 
        MOVL      @$BLOCKED(||I2CA||)+10,ACC ; [CPU_ALU] |755| 
	.dwpsn	file "../bts.c",line 756,column 20,is_stmt,isa 0
        MOVL      @$BLOCKED(||I2CA||)+8,XAR6 ; [CPU_ALU] |756| 
        B         ||$C$L14||,UNC        ; [CPU_ALU] |756| 
        ; branch occurs ; [] |756| 
||$C$L9||:    
	.dwpsn	file "../bts.c",line 740,column 16,is_stmt,isa 0
        MOVB      ACC,#4                ; [CPU_ALU] |740| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |740| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |740| 
$C$DW$145	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$145, DW_AT_low_pc(0x00)
	.dwattr $C$DW$145, DW_AT_name("I2C_enableInterrupt")
	.dwattr $C$DW$145, DW_AT_TI_call

        LCR       #||I2C_enableInterrupt|| ; [CPU_ALU] |740| 
        ; call occurs [#||I2C_enableInterrupt||] ; [] |740| 
        MOVW      DP,#||I2CA||+8        ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 741,column 16,is_stmt,isa 0
        MOVL      ACC,@$BLOCKED(||I2CA||)+8 ; [CPU_ALU] |741| 
        B         ||$C$L14||,NEQ        ; [CPU_ALU] |741| 
        ; branchcc occurs ; [] |741| 
	.dwpsn	file "../bts.c",line 744,column 21,is_stmt,isa 0
        MOVB      XAR6,#0               ; [CPU_ALU] |744| 
	.dwpsn	file "../bts.c",line 743,column 21,is_stmt,isa 0
        MOVL      ACC,@$BLOCKED(||I2CA||)+4 ; [CPU_ALU] |743| 
        ANDB      AH,#255               ; [CPU_ALU] |743| 
        MOVL      @$BLOCKED(||I2CA||)+8,ACC ; [CPU_ALU] |743| 
	.dwpsn	file "../bts.c",line 744,column 21,is_stmt,isa 0
        MOVL      @$BLOCKED(||I2CA||)+10,XAR6 ; [CPU_ALU] |744| 
        B         ||$C$L14||,UNC        ; [CPU_ALU] |744| 
        ; branch occurs ; [] |744| 
||$C$L10||:    
	.dwpsn	file "../bts.c",line 727,column 13,is_stmt,isa 0
        MOVL      XAR4,#65536           ; [CPU_ARAU] |727| 
        MOVL      ACC,@$BLOCKED(||I2CB||) ; [CPU_ALU] |727| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |727| 
$C$DW$146	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$146, DW_AT_low_pc(0x00)
	.dwattr $C$DW$146, DW_AT_name("I2C_enableInterrupt")
	.dwattr $C$DW$146, DW_AT_TI_call

        LCR       #||I2C_enableInterrupt|| ; [CPU_ALU] |727| 
        ; call occurs [#||I2C_enableInterrupt||] ; [] |727| 
        MOVW      DP,#||I2CB||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 728,column 13,is_stmt,isa 0
        MOVL      XAR4,#131072          ; [CPU_ARAU] |728| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |728| 
        MOVL      ACC,@$BLOCKED(||I2CB||) ; [CPU_ALU] |728| 
$C$DW$147	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$147, DW_AT_low_pc(0x00)
	.dwattr $C$DW$147, DW_AT_name("I2C_disableInterrupt")
	.dwattr $C$DW$147, DW_AT_TI_call

        LCR       #||I2C_disableInterrupt|| ; [CPU_ALU] |728| 
        ; call occurs [#||I2C_disableInterrupt||] ; [] |728| 
        MOVW      DP,#||I2CB||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 729,column 13,is_stmt,isa 0
        MOVL      XAR4,#65536           ; [CPU_ARAU] |729| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |729| 
        MOVL      ACC,@$BLOCKED(||I2CB||) ; [CPU_ALU] |729| 
$C$DW$148	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$148, DW_AT_low_pc(0x00)
	.dwattr $C$DW$148, DW_AT_name("I2C_clearInterruptStatus")
	.dwattr $C$DW$148, DW_AT_TI_call

        LCR       #||I2C_clearInterruptStatus|| ; [CPU_ALU] |729| 
        ; call occurs [#||I2C_clearInterruptStatus||] ; [] |729| 
        MOVW      DP,#||I2CA||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 731,column 13,is_stmt,isa 0
        MOVL      XAR4,#131072          ; [CPU_ARAU] |731| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |731| 
        MOVL      ACC,@$BLOCKED(||I2CA||) ; [CPU_ALU] |731| 
        B         ||$C$L13||,UNC        ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L11||:    
	.dwpsn	file "../bts.c",line 707,column 9,is_stmt,isa 0
        TBIT      AL,#9                 ; [CPU_ALU] |707| 
        B         ||$C$L12||,TC         ; [CPU_ALU] |707| 
        ; branchcc occurs ; [] |707| 
	.dwpsn	file "../bts.c",line 715,column 11,is_stmt,isa 0
        MOVL      XAR4,#131072          ; [CPU_ARAU] |715| 
        MOVL      ACC,@$BLOCKED(||I2CB||) ; [CPU_ALU] |715| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |715| 
$C$DW$149	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$149, DW_AT_low_pc(0x00)
	.dwattr $C$DW$149, DW_AT_name("I2C_enableInterrupt")
	.dwattr $C$DW$149, DW_AT_TI_call

        LCR       #||I2C_enableInterrupt|| ; [CPU_ALU] |715| 
        ; call occurs [#||I2C_enableInterrupt||] ; [] |715| 
        MOVW      DP,#||I2CB||          ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 716,column 11,is_stmt,isa 0
        MOVL      XAR4,#131072          ; [CPU_ARAU] |716| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |716| 
        MOVL      ACC,@$BLOCKED(||I2CB||) ; [CPU_ALU] |716| 
$C$DW$150	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$150, DW_AT_low_pc(0x00)
	.dwattr $C$DW$150, DW_AT_name("I2C_clearInterruptStatus")
	.dwattr $C$DW$150, DW_AT_TI_call

        LCR       #||I2C_clearInterruptStatus|| ; [CPU_ALU] |716| 
        ; call occurs [#||I2C_clearInterruptStatus||] ; [] |716| 
        B         ||$C$L14||,UNC        ; [CPU_ALU] |716| 
        ; branch occurs ; [] |716| 
||$C$L12||:    
	.dwpsn	file "../bts.c",line 710,column 11,is_stmt,isa 0
        MOVL      XAR5,#131072          ; [CPU_ARAU] |710| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |710| 
        MOVL      *-SP[2],XAR5          ; [CPU_ALU] |710| 
||$C$L13||:    
$C$DW$151	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$151, DW_AT_low_pc(0x00)
	.dwattr $C$DW$151, DW_AT_name("I2C_disableInterrupt")
	.dwattr $C$DW$151, DW_AT_TI_call

        LCR       #||I2C_disableInterrupt|| ; [CPU_ALU] |710| 
        ; call occurs [#||I2C_disableInterrupt||] ; [] |710| 
||$C$L14||:    
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\interrupt.h",line 429,column 5,is_stmt,isa 0
        MOVB      AL,#128               ; [CPU_ALU] |429| 
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
$C$DW$152	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$152, DW_AT_low_pc(0x00)
	.dwattr $C$DW$152, DW_AT_TI_return

        IRET      ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$139, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$139, DW_AT_TI_end_line(0x2fb)
	.dwattr $C$DW$139, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$139

	.sect	".text:__signbitl"
	.clink
	.global	||__signbitl||

$C$DW$153	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$153, DW_AT_name("__signbitl")
	.dwattr $C$DW$153, DW_AT_low_pc(||__signbitl||)
	.dwattr $C$DW$153, DW_AT_high_pc(0x00)
	.dwattr $C$DW$153, DW_AT_linkage_name("__signbitl")
	.dwattr $C$DW$153, DW_AT_external
	.dwattr $C$DW$153, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$153, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$153, DW_AT_decl_line(0x16f)
	.dwattr $C$DW$153, DW_AT_decl_column(0x25)
	.dwattr $C$DW$153, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 368,column 1,is_stmt,address ||__signbitl||,isa 0

	.dwfde $C$DW$CIE, ||__signbitl||
$C$DW$154	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$154, DW_AT_name("e")
	.dwattr $C$DW$154, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$154, DW_AT_location[DW_OP_reg12]


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
$C$DW$155	.dwtag  DW_TAG_variable
	.dwattr $C$DW$155, DW_AT_name("e")
	.dwattr $C$DW$155, DW_AT_type(*$C$DW$T$126)
	.dwattr $C$DW$155, DW_AT_location[DW_OP_reg12]

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
$C$DW$156	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$156, DW_AT_low_pc(0x00)
	.dwattr $C$DW$156, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$156, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |368| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |368| 
        MOVB      AH,#0                 ; [CPU_ALU] |368| 
        CMPB      AL,#0                 ; [CPU_ALU] |368| 
        MOVB      AH,#1,NEQ             ; [CPU_ALU] |368| 
        MOV       AL,AH                 ; [CPU_ALU] |368| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$157	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$157, DW_AT_low_pc(0x00)
	.dwattr $C$DW$157, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$153, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$153, DW_AT_TI_end_line(0x170)
	.dwattr $C$DW$153, DW_AT_TI_end_column(0x2b)
	.dwendentry
	.dwendtag $C$DW$153

	.sect	".text:__signbitf"
	.clink
	.global	||__signbitf||

$C$DW$158	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$158, DW_AT_name("__signbitf")
	.dwattr $C$DW$158, DW_AT_low_pc(||__signbitf||)
	.dwattr $C$DW$158, DW_AT_high_pc(0x00)
	.dwattr $C$DW$158, DW_AT_linkage_name("__signbitf")
	.dwattr $C$DW$158, DW_AT_external
	.dwattr $C$DW$158, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$158, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$158, DW_AT_decl_line(0x16d)
	.dwattr $C$DW$158, DW_AT_decl_column(0x25)
	.dwattr $C$DW$158, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 366,column 1,is_stmt,address ||__signbitf||,isa 0

	.dwfde $C$DW$CIE, ||__signbitf||
$C$DW$159	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$159, DW_AT_name("f")
	.dwattr $C$DW$159, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$159, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$160	.dwtag  DW_TAG_variable
	.dwattr $C$DW$160, DW_AT_name("f")
	.dwattr $C$DW$160, DW_AT_type(*$C$DW$T$120)
	.dwattr $C$DW$160, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$161	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$161, DW_AT_low_pc(0x00)
	.dwattr $C$DW$161, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$158, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$158, DW_AT_TI_end_line(0x16e)
	.dwattr $C$DW$158, DW_AT_TI_end_column(0x29)
	.dwendentry
	.dwendtag $C$DW$158

	.sect	".text:__signbit"
	.clink
	.global	||__signbit||

$C$DW$162	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$162, DW_AT_name("__signbit")
	.dwattr $C$DW$162, DW_AT_low_pc(||__signbit||)
	.dwattr $C$DW$162, DW_AT_high_pc(0x00)
	.dwattr $C$DW$162, DW_AT_linkage_name("__signbit")
	.dwattr $C$DW$162, DW_AT_external
	.dwattr $C$DW$162, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$162, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$162, DW_AT_decl_line(0x16b)
	.dwattr $C$DW$162, DW_AT_decl_column(0x25)
	.dwattr $C$DW$162, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 364,column 1,is_stmt,address ||__signbit||,isa 0

	.dwfde $C$DW$CIE, ||__signbit||
$C$DW$163	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$163, DW_AT_name("d")
	.dwattr $C$DW$163, DW_AT_type(*$C$DW$T$122)
	.dwattr $C$DW$163, DW_AT_location[DW_OP_reg12]


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
$C$DW$164	.dwtag  DW_TAG_variable
	.dwattr $C$DW$164, DW_AT_name("d")
	.dwattr $C$DW$164, DW_AT_type(*$C$DW$T$123)
	.dwattr $C$DW$164, DW_AT_location[DW_OP_reg12]

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
$C$DW$165	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$165, DW_AT_low_pc(0x00)
	.dwattr $C$DW$165, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$165, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |364| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |364| 
        MOVB      AH,#0                 ; [CPU_ALU] |364| 
        CMPB      AL,#0                 ; [CPU_ALU] |364| 
        MOVB      AH,#1,NEQ             ; [CPU_ALU] |364| 
        MOV       AL,AH                 ; [CPU_ALU] |364| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$166	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$166, DW_AT_low_pc(0x00)
	.dwattr $C$DW$166, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$162, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$162, DW_AT_TI_end_line(0x16c)
	.dwattr $C$DW$162, DW_AT_TI_end_column(0x2a)
	.dwendentry
	.dwendtag $C$DW$162

	.sect	".text:__relaxed_sqrtf"
	.clink
	.global	||__relaxed_sqrtf||

$C$DW$167	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$167, DW_AT_name("__relaxed_sqrtf")
	.dwattr $C$DW$167, DW_AT_low_pc(||__relaxed_sqrtf||)
	.dwattr $C$DW$167, DW_AT_high_pc(0x00)
	.dwattr $C$DW$167, DW_AT_linkage_name("__relaxed_sqrtf")
	.dwattr $C$DW$167, DW_AT_external
	.dwattr $C$DW$167, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$167, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$167, DW_AT_decl_line(0xe4)
	.dwattr $C$DW$167, DW_AT_decl_column(0x10)
	.dwattr $C$DW$167, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 229,column 1,is_stmt,address ||__relaxed_sqrtf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_sqrtf||
$C$DW$168	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$168, DW_AT_name("x")
	.dwattr $C$DW$168, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$168, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$169	.dwtag  DW_TAG_variable
	.dwattr $C$DW$169, DW_AT_name("x")
	.dwattr $C$DW$169, DW_AT_type(*$C$DW$T$120)
	.dwattr $C$DW$169, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 230,column 5,is_stmt,isa 0
        SQRTF32   R0H,R0H               ; [CPU_FPU] |230| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$170	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$170, DW_AT_low_pc(0x00)
	.dwattr $C$DW$170, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$167, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$167, DW_AT_TI_end_line(0xe7)
	.dwattr $C$DW$167, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$167

	.sect	".text:__relaxed_sinf"
	.clink
	.global	||__relaxed_sinf||

$C$DW$171	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$171, DW_AT_name("__relaxed_sinf")
	.dwattr $C$DW$171, DW_AT_low_pc(||__relaxed_sinf||)
	.dwattr $C$DW$171, DW_AT_high_pc(0x00)
	.dwattr $C$DW$171, DW_AT_linkage_name("__relaxed_sinf")
	.dwattr $C$DW$171, DW_AT_external
	.dwattr $C$DW$171, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$171, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$171, DW_AT_decl_line(0xe9)
	.dwattr $C$DW$171, DW_AT_decl_column(0x10)
	.dwattr $C$DW$171, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 234,column 1,is_stmt,address ||__relaxed_sinf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_sinf||
$C$DW$172	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$172, DW_AT_name("x")
	.dwattr $C$DW$172, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$172, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$173	.dwtag  DW_TAG_variable
	.dwattr $C$DW$173, DW_AT_name("x")
	.dwattr $C$DW$173, DW_AT_type(*$C$DW$T$120)
	.dwattr $C$DW$173, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 235,column 5,is_stmt,isa 0
        DIV2PIF32 R0H,R0H               ; [CPU_FPU] |235| 
        NOP       ; [CPU_ALU] 
        SINPUF32  R0H,R0H               ; [CPU_FPU] |235| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$174	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$174, DW_AT_low_pc(0x00)
	.dwattr $C$DW$174, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$171, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$171, DW_AT_TI_end_line(0xec)
	.dwattr $C$DW$171, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$171

	.sect	".text:__relaxed_cosf"
	.clink
	.global	||__relaxed_cosf||

$C$DW$175	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$175, DW_AT_name("__relaxed_cosf")
	.dwattr $C$DW$175, DW_AT_low_pc(||__relaxed_cosf||)
	.dwattr $C$DW$175, DW_AT_high_pc(0x00)
	.dwattr $C$DW$175, DW_AT_linkage_name("__relaxed_cosf")
	.dwattr $C$DW$175, DW_AT_external
	.dwattr $C$DW$175, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$175, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$175, DW_AT_decl_line(0xee)
	.dwattr $C$DW$175, DW_AT_decl_column(0x10)
	.dwattr $C$DW$175, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 239,column 1,is_stmt,address ||__relaxed_cosf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_cosf||
$C$DW$176	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$176, DW_AT_name("x")
	.dwattr $C$DW$176, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$176, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$177	.dwtag  DW_TAG_variable
	.dwattr $C$DW$177, DW_AT_name("x")
	.dwattr $C$DW$177, DW_AT_type(*$C$DW$T$120)
	.dwattr $C$DW$177, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 240,column 5,is_stmt,isa 0
        DIV2PIF32 R0H,R0H               ; [CPU_FPU] |240| 
        NOP       ; [CPU_ALU] 
        COSPUF32  R0H,R0H               ; [CPU_FPU] |240| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$178	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$178, DW_AT_low_pc(0x00)
	.dwattr $C$DW$178, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$175, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$175, DW_AT_TI_end_line(0xf1)
	.dwattr $C$DW$175, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$175

	.sect	".text:__relaxed_atanf"
	.clink
	.global	||__relaxed_atanf||

$C$DW$179	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$179, DW_AT_name("__relaxed_atanf")
	.dwattr $C$DW$179, DW_AT_low_pc(||__relaxed_atanf||)
	.dwattr $C$DW$179, DW_AT_high_pc(0x00)
	.dwattr $C$DW$179, DW_AT_linkage_name("__relaxed_atanf")
	.dwattr $C$DW$179, DW_AT_external
	.dwattr $C$DW$179, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$179, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$179, DW_AT_decl_line(0xf3)
	.dwattr $C$DW$179, DW_AT_decl_column(0x10)
	.dwattr $C$DW$179, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 244,column 1,is_stmt,address ||__relaxed_atanf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_atanf||
$C$DW$180	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$180, DW_AT_name("x")
	.dwattr $C$DW$180, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$180, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$181	.dwtag  DW_TAG_variable
	.dwattr $C$DW$181, DW_AT_name("x")
	.dwattr $C$DW$181, DW_AT_type(*$C$DW$T$120)
	.dwattr $C$DW$181, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$182	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$182, DW_AT_low_pc(0x00)
	.dwattr $C$DW$182, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$179, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$179, DW_AT_TI_end_line(0xf6)
	.dwattr $C$DW$179, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$179

	.sect	".text:__relaxed_atan2f"
	.clink
	.global	||__relaxed_atan2f||

$C$DW$183	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$183, DW_AT_name("__relaxed_atan2f")
	.dwattr $C$DW$183, DW_AT_low_pc(||__relaxed_atan2f||)
	.dwattr $C$DW$183, DW_AT_high_pc(0x00)
	.dwattr $C$DW$183, DW_AT_linkage_name("__relaxed_atan2f")
	.dwattr $C$DW$183, DW_AT_external
	.dwattr $C$DW$183, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$183, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$183, DW_AT_decl_line(0xf8)
	.dwattr $C$DW$183, DW_AT_decl_column(0x10)
	.dwattr $C$DW$183, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 249,column 1,is_stmt,address ||__relaxed_atan2f||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_atan2f||
$C$DW$184	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$184, DW_AT_name("y")
	.dwattr $C$DW$184, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$184, DW_AT_location[DW_OP_regx 0x2b]

$C$DW$185	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$185, DW_AT_name("x")
	.dwattr $C$DW$185, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$185, DW_AT_location[DW_OP_regx 0x2f]


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
$C$DW$186	.dwtag  DW_TAG_variable
	.dwattr $C$DW$186, DW_AT_name("y")
	.dwattr $C$DW$186, DW_AT_type(*$C$DW$T$120)
	.dwattr $C$DW$186, DW_AT_location[DW_OP_regx 0x2b]

;* R1    assigned to x
$C$DW$187	.dwtag  DW_TAG_variable
	.dwattr $C$DW$187, DW_AT_name("x")
	.dwattr $C$DW$187, DW_AT_type(*$C$DW$T$120)
	.dwattr $C$DW$187, DW_AT_location[DW_OP_regx 0x2f]

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
$C$DW$188	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$188, DW_AT_low_pc(0x00)
	.dwattr $C$DW$188, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$183, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$183, DW_AT_TI_end_line(0xfb)
	.dwattr $C$DW$183, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$183

	.sect	".text:__isnormall"
	.clink
	.global	||__isnormall||

$C$DW$189	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$189, DW_AT_name("__isnormall")
	.dwattr $C$DW$189, DW_AT_low_pc(||__isnormall||)
	.dwattr $C$DW$189, DW_AT_high_pc(0x00)
	.dwattr $C$DW$189, DW_AT_linkage_name("__isnormall")
	.dwattr $C$DW$189, DW_AT_external
	.dwattr $C$DW$189, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$189, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$189, DW_AT_decl_line(0x167)
	.dwattr $C$DW$189, DW_AT_decl_column(0x25)
	.dwattr $C$DW$189, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 360,column 1,is_stmt,address ||__isnormall||,isa 0

	.dwfde $C$DW$CIE, ||__isnormall||
$C$DW$190	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$190, DW_AT_name("e")
	.dwattr $C$DW$190, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$190, DW_AT_location[DW_OP_reg12]


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
$C$DW$191	.dwtag  DW_TAG_variable
	.dwattr $C$DW$191, DW_AT_name("e")
	.dwattr $C$DW$191, DW_AT_type(*$C$DW$T$126)
	.dwattr $C$DW$191, DW_AT_location[DW_OP_reg12]

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
$C$DW$192	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$192, DW_AT_low_pc(0x00)
	.dwattr $C$DW$192, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$192, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |360| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |360| 
        MOVB      XAR6,#0               ; [CPU_ALU] |360| 
        CMPB      AL,#0                 ; [CPU_ALU] |360| 
        B         ||$C$L15||,EQ         ; [CPU_ALU] |360| 
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
||$C$L15||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR6                ; [CPU_ALU] |360| 
$C$DW$193	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$193, DW_AT_low_pc(0x00)
	.dwattr $C$DW$193, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$189, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$189, DW_AT_TI_end_line(0x169)
	.dwattr $C$DW$189, DW_AT_TI_end_column(0x31)
	.dwendentry
	.dwendtag $C$DW$189

	.sect	".text:__isnormalf"
	.clink
	.global	||__isnormalf||

$C$DW$194	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$194, DW_AT_name("__isnormalf")
	.dwattr $C$DW$194, DW_AT_low_pc(||__isnormalf||)
	.dwattr $C$DW$194, DW_AT_high_pc(0x00)
	.dwattr $C$DW$194, DW_AT_linkage_name("__isnormalf")
	.dwattr $C$DW$194, DW_AT_external
	.dwattr $C$DW$194, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$194, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$194, DW_AT_decl_line(0x163)
	.dwattr $C$DW$194, DW_AT_decl_column(0x25)
	.dwattr $C$DW$194, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 356,column 1,is_stmt,address ||__isnormalf||,isa 0

	.dwfde $C$DW$CIE, ||__isnormalf||
$C$DW$195	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$195, DW_AT_name("f")
	.dwattr $C$DW$195, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$195, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$196	.dwtag  DW_TAG_variable
	.dwattr $C$DW$196, DW_AT_name("f")
	.dwattr $C$DW$196, DW_AT_type(*$C$DW$T$120)
	.dwattr $C$DW$196, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 356,column 3,is_stmt,isa 0
        MOV32     P,R0H                 ; [CPU_FPU] |356| 
        MOV       T,#23                 ; [CPU_ALU] |356| 
        MOVL      ACC,P                 ; [CPU_ALU] |356| 
        MOVB      XAR6,#0               ; [CPU_ALU] |356| 
        LSRL      ACC,T                 ; [CPU_ALU] |356| 
        ANDB      AL,#0xff              ; [CPU_ALU] |356| 
        B         ||$C$L16||,EQ         ; [CPU_ALU] |356| 
        ; branchcc occurs ; [] |356| 
        AND       AL,PH,#0x7f80         ; [CPU_ALU] |356| 
        MOVZ      AR7,AL                ; [CPU_ALU] |356| 
        MOVL      XAR4,#32640           ; [CPU_ARAU] |356| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |356| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |356| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |356| 
||$C$L16||:    
        MOV       AL,AR6                ; [CPU_ALU] |356| 
$C$DW$197	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$197, DW_AT_low_pc(0x00)
	.dwattr $C$DW$197, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$194, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$194, DW_AT_TI_end_line(0x165)
	.dwattr $C$DW$194, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$194

	.sect	".text:__isnormal"
	.clink
	.global	||__isnormal||

$C$DW$198	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$198, DW_AT_name("__isnormal")
	.dwattr $C$DW$198, DW_AT_low_pc(||__isnormal||)
	.dwattr $C$DW$198, DW_AT_high_pc(0x00)
	.dwattr $C$DW$198, DW_AT_linkage_name("__isnormal")
	.dwattr $C$DW$198, DW_AT_external
	.dwattr $C$DW$198, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$198, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$198, DW_AT_decl_line(0x15f)
	.dwattr $C$DW$198, DW_AT_decl_column(0x25)
	.dwattr $C$DW$198, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 352,column 1,is_stmt,address ||__isnormal||,isa 0

	.dwfde $C$DW$CIE, ||__isnormal||
$C$DW$199	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$199, DW_AT_name("d")
	.dwattr $C$DW$199, DW_AT_type(*$C$DW$T$122)
	.dwattr $C$DW$199, DW_AT_location[DW_OP_reg12]


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
$C$DW$200	.dwtag  DW_TAG_variable
	.dwattr $C$DW$200, DW_AT_name("d")
	.dwattr $C$DW$200, DW_AT_type(*$C$DW$T$123)
	.dwattr $C$DW$200, DW_AT_location[DW_OP_reg12]

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
$C$DW$201	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$201, DW_AT_low_pc(0x00)
	.dwattr $C$DW$201, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$201, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |352| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |352| 
        MOVB      XAR6,#0               ; [CPU_ALU] |352| 
        CMPB      AL,#0                 ; [CPU_ALU] |352| 
        B         ||$C$L17||,EQ         ; [CPU_ALU] |352| 
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
||$C$L17||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR6                ; [CPU_ALU] |352| 
$C$DW$202	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$202, DW_AT_low_pc(0x00)
	.dwattr $C$DW$202, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$198, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$198, DW_AT_TI_end_line(0x161)
	.dwattr $C$DW$198, DW_AT_TI_end_column(0x30)
	.dwendentry
	.dwendtag $C$DW$198

	.sect	".text:__isnanl"
	.clink
	.global	||__isnanl||

$C$DW$203	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$203, DW_AT_name("__isnanl")
	.dwattr $C$DW$203, DW_AT_low_pc(||__isnanl||)
	.dwattr $C$DW$203, DW_AT_high_pc(0x00)
	.dwattr $C$DW$203, DW_AT_linkage_name("__isnanl")
	.dwattr $C$DW$203, DW_AT_external
	.dwattr $C$DW$203, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$203, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$203, DW_AT_decl_line(0x15b)
	.dwattr $C$DW$203, DW_AT_decl_column(0x25)
	.dwattr $C$DW$203, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 348,column 1,is_stmt,address ||__isnanl||,isa 0

	.dwfde $C$DW$CIE, ||__isnanl||
$C$DW$204	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$204, DW_AT_name("e")
	.dwattr $C$DW$204, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$204, DW_AT_location[DW_OP_reg12]


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
$C$DW$205	.dwtag  DW_TAG_variable
	.dwattr $C$DW$205, DW_AT_name("e")
	.dwattr $C$DW$205, DW_AT_type(*$C$DW$T$126)
	.dwattr $C$DW$205, DW_AT_location[DW_OP_reg12]

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
        B         ||$C$L18||,NEQ        ; [CPU_ALU] |348| 
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
$C$DW$206	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$206, DW_AT_low_pc(0x00)
	.dwattr $C$DW$206, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$206, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |348| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |348| 
        CMPB      AL,#0                 ; [CPU_ALU] |348| 
        MOVB      XAR4,#1,NEQ           ; [CPU_ALU] |348| 
||$C$L18||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |348| 
$C$DW$207	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$207, DW_AT_low_pc(0x00)
	.dwattr $C$DW$207, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$203, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$203, DW_AT_TI_end_line(0x15d)
	.dwattr $C$DW$203, DW_AT_TI_end_column(0x30)
	.dwendentry
	.dwendtag $C$DW$203

	.sect	".text:__isnanf"
	.clink
	.global	||__isnanf||

$C$DW$208	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$208, DW_AT_name("__isnanf")
	.dwattr $C$DW$208, DW_AT_low_pc(||__isnanf||)
	.dwattr $C$DW$208, DW_AT_high_pc(0x00)
	.dwattr $C$DW$208, DW_AT_linkage_name("__isnanf")
	.dwattr $C$DW$208, DW_AT_external
	.dwattr $C$DW$208, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$208, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$208, DW_AT_decl_line(0x158)
	.dwattr $C$DW$208, DW_AT_decl_column(0x25)
	.dwattr $C$DW$208, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 345,column 1,is_stmt,address ||__isnanf||,isa 0

	.dwfde $C$DW$CIE, ||__isnanf||
$C$DW$209	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$209, DW_AT_name("f")
	.dwattr $C$DW$209, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$209, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$210	.dwtag  DW_TAG_variable
	.dwattr $C$DW$210, DW_AT_name("f")
	.dwattr $C$DW$210, DW_AT_type(*$C$DW$T$120)
	.dwattr $C$DW$210, DW_AT_location[DW_OP_regx 0x2b]

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
        B         ||$C$L19||,NEQ        ; [CPU_ALU] |345| 
        ; branchcc occurs ; [] |345| 
        MOVL      ACC,P                 ; [CPU_ALU] |345| 
        ANDB      AH,#127               ; [CPU_ALU] |345| 
        TEST      ACC                   ; [CPU_ALU] |345| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |345| 
||$C$L19||:    
        MOV       AL,AR6                ; [CPU_ALU] |345| 
$C$DW$211	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$211, DW_AT_low_pc(0x00)
	.dwattr $C$DW$211, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$208, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$208, DW_AT_TI_end_line(0x15a)
	.dwattr $C$DW$208, DW_AT_TI_end_column(0x2e)
	.dwendentry
	.dwendtag $C$DW$208

	.sect	".text:__isnan"
	.clink
	.global	||__isnan||

$C$DW$212	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$212, DW_AT_name("__isnan")
	.dwattr $C$DW$212, DW_AT_low_pc(||__isnan||)
	.dwattr $C$DW$212, DW_AT_high_pc(0x00)
	.dwattr $C$DW$212, DW_AT_linkage_name("__isnan")
	.dwattr $C$DW$212, DW_AT_external
	.dwattr $C$DW$212, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$212, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$212, DW_AT_decl_line(0x155)
	.dwattr $C$DW$212, DW_AT_decl_column(0x25)
	.dwattr $C$DW$212, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 342,column 1,is_stmt,address ||__isnan||,isa 0

	.dwfde $C$DW$CIE, ||__isnan||
$C$DW$213	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$213, DW_AT_name("d")
	.dwattr $C$DW$213, DW_AT_type(*$C$DW$T$122)
	.dwattr $C$DW$213, DW_AT_location[DW_OP_reg12]


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
$C$DW$214	.dwtag  DW_TAG_variable
	.dwattr $C$DW$214, DW_AT_name("d")
	.dwattr $C$DW$214, DW_AT_type(*$C$DW$T$123)
	.dwattr $C$DW$214, DW_AT_location[DW_OP_reg12]

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
        B         ||$C$L20||,NEQ        ; [CPU_ALU] |342| 
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
$C$DW$215	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$215, DW_AT_low_pc(0x00)
	.dwattr $C$DW$215, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$215, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |342| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |342| 
        CMPB      AL,#0                 ; [CPU_ALU] |342| 
        MOVB      XAR4,#1,NEQ           ; [CPU_ALU] |342| 
||$C$L20||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |342| 
$C$DW$216	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$216, DW_AT_low_pc(0x00)
	.dwattr $C$DW$216, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$212, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$212, DW_AT_TI_end_line(0x157)
	.dwattr $C$DW$212, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$212

	.sect	".text:__isinfl"
	.clink
	.global	||__isinfl||

$C$DW$217	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$217, DW_AT_name("__isinfl")
	.dwattr $C$DW$217, DW_AT_low_pc(||__isinfl||)
	.dwattr $C$DW$217, DW_AT_high_pc(0x00)
	.dwattr $C$DW$217, DW_AT_linkage_name("__isinfl")
	.dwattr $C$DW$217, DW_AT_external
	.dwattr $C$DW$217, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$217, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$217, DW_AT_decl_line(0x17a)
	.dwattr $C$DW$217, DW_AT_decl_column(0x25)
	.dwattr $C$DW$217, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 379,column 1,is_stmt,address ||__isinfl||,isa 0

	.dwfde $C$DW$CIE, ||__isinfl||
$C$DW$218	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$218, DW_AT_name("e")
	.dwattr $C$DW$218, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$218, DW_AT_location[DW_OP_reg12]


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
$C$DW$219	.dwtag  DW_TAG_variable
	.dwattr $C$DW$219, DW_AT_name("e")
	.dwattr $C$DW$219, DW_AT_type(*$C$DW$T$126)
	.dwattr $C$DW$219, DW_AT_location[DW_OP_reg12]

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
        B         ||$C$L21||,NEQ        ; [CPU_ALU] |379| 
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
$C$DW$220	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$220, DW_AT_low_pc(0x00)
	.dwattr $C$DW$220, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$220, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |379| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |379| 
        CMPB      AL,#0                 ; [CPU_ALU] |379| 
        MOVB      XAR4,#1,EQ            ; [CPU_ALU] |379| 
||$C$L21||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |379| 
$C$DW$221	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$221, DW_AT_low_pc(0x00)
	.dwattr $C$DW$221, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$217, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$217, DW_AT_TI_end_line(0x17b)
	.dwattr $C$DW$217, DW_AT_TI_end_column(0x4c)
	.dwendentry
	.dwendtag $C$DW$217

	.sect	".text:__isinff"
	.clink
	.global	||__isinff||

$C$DW$222	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$222, DW_AT_name("__isinff")
	.dwattr $C$DW$222, DW_AT_low_pc(||__isinff||)
	.dwattr $C$DW$222, DW_AT_high_pc(0x00)
	.dwattr $C$DW$222, DW_AT_linkage_name("__isinff")
	.dwattr $C$DW$222, DW_AT_external
	.dwattr $C$DW$222, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$222, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$222, DW_AT_decl_line(0x176)
	.dwattr $C$DW$222, DW_AT_decl_column(0x25)
	.dwattr $C$DW$222, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 375,column 1,is_stmt,address ||__isinff||,isa 0

	.dwfde $C$DW$CIE, ||__isinff||
$C$DW$223	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$223, DW_AT_name("f")
	.dwattr $C$DW$223, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$223, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$224	.dwtag  DW_TAG_variable
	.dwattr $C$DW$224, DW_AT_name("f")
	.dwattr $C$DW$224, DW_AT_type(*$C$DW$T$120)
	.dwattr $C$DW$224, DW_AT_location[DW_OP_regx 0x2b]

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
        B         ||$C$L22||,NEQ        ; [CPU_ALU] |375| 
        ; branchcc occurs ; [] |375| 
        MOVL      ACC,P                 ; [CPU_ALU] |375| 
        ANDB      AH,#127               ; [CPU_ALU] |375| 
        TEST      ACC                   ; [CPU_ALU] |375| 
        MOVB      XAR6,#1,EQ            ; [CPU_ALU] |375| 
||$C$L22||:    
        MOV       AL,AR6                ; [CPU_ALU] |375| 
$C$DW$225	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$225, DW_AT_low_pc(0x00)
	.dwattr $C$DW$225, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$222, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$222, DW_AT_TI_end_line(0x177)
	.dwattr $C$DW$222, DW_AT_TI_end_column(0x48)
	.dwendentry
	.dwendtag $C$DW$222

	.sect	".text:__isinf"
	.clink
	.global	||__isinf||

$C$DW$226	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$226, DW_AT_name("__isinf")
	.dwattr $C$DW$226, DW_AT_low_pc(||__isinf||)
	.dwattr $C$DW$226, DW_AT_high_pc(0x00)
	.dwattr $C$DW$226, DW_AT_linkage_name("__isinf")
	.dwattr $C$DW$226, DW_AT_external
	.dwattr $C$DW$226, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$226, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$226, DW_AT_decl_line(0x178)
	.dwattr $C$DW$226, DW_AT_decl_column(0x25)
	.dwattr $C$DW$226, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 377,column 1,is_stmt,address ||__isinf||,isa 0

	.dwfde $C$DW$CIE, ||__isinf||
$C$DW$227	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$227, DW_AT_name("d")
	.dwattr $C$DW$227, DW_AT_type(*$C$DW$T$122)
	.dwattr $C$DW$227, DW_AT_location[DW_OP_reg12]


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
$C$DW$228	.dwtag  DW_TAG_variable
	.dwattr $C$DW$228, DW_AT_name("d")
	.dwattr $C$DW$228, DW_AT_type(*$C$DW$T$123)
	.dwattr $C$DW$228, DW_AT_location[DW_OP_reg12]

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
        B         ||$C$L23||,NEQ        ; [CPU_ALU] |377| 
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
$C$DW$229	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$229, DW_AT_low_pc(0x00)
	.dwattr $C$DW$229, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$229, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |377| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |377| 
        CMPB      AL,#0                 ; [CPU_ALU] |377| 
        MOVB      XAR4,#1,EQ            ; [CPU_ALU] |377| 
||$C$L23||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |377| 
$C$DW$230	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$230, DW_AT_low_pc(0x00)
	.dwattr $C$DW$230, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$226, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$226, DW_AT_TI_end_line(0x179)
	.dwattr $C$DW$226, DW_AT_TI_end_column(0x4a)
	.dwendentry
	.dwendtag $C$DW$226

	.sect	".text:__isfinitel"
	.clink
	.global	||__isfinitel||

$C$DW$231	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$231, DW_AT_name("__isfinitel")
	.dwattr $C$DW$231, DW_AT_low_pc(||__isfinitel||)
	.dwattr $C$DW$231, DW_AT_high_pc(0x00)
	.dwattr $C$DW$231, DW_AT_linkage_name("__isfinitel")
	.dwattr $C$DW$231, DW_AT_external
	.dwattr $C$DW$231, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$231, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$231, DW_AT_decl_line(0x152)
	.dwattr $C$DW$231, DW_AT_decl_column(0x25)
	.dwattr $C$DW$231, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 339,column 1,is_stmt,address ||__isfinitel||,isa 0

	.dwfde $C$DW$CIE, ||__isfinitel||
$C$DW$232	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$232, DW_AT_name("e")
	.dwattr $C$DW$232, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$232, DW_AT_location[DW_OP_reg12]


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
$C$DW$233	.dwtag  DW_TAG_variable
	.dwattr $C$DW$233, DW_AT_name("e")
	.dwattr $C$DW$233, DW_AT_type(*$C$DW$T$126)
	.dwattr $C$DW$233, DW_AT_location[DW_OP_reg12]

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
$C$DW$234	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$234, DW_AT_low_pc(0x00)
	.dwattr $C$DW$234, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$231, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$231, DW_AT_TI_end_line(0x153)
	.dwattr $C$DW$231, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$231

	.sect	".text:__isfinitef"
	.clink
	.global	||__isfinitef||

$C$DW$235	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$235, DW_AT_name("__isfinitef")
	.dwattr $C$DW$235, DW_AT_low_pc(||__isfinitef||)
	.dwattr $C$DW$235, DW_AT_high_pc(0x00)
	.dwattr $C$DW$235, DW_AT_linkage_name("__isfinitef")
	.dwattr $C$DW$235, DW_AT_external
	.dwattr $C$DW$235, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$235, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$235, DW_AT_decl_line(0x150)
	.dwattr $C$DW$235, DW_AT_decl_column(0x25)
	.dwattr $C$DW$235, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 337,column 1,is_stmt,address ||__isfinitef||,isa 0

	.dwfde $C$DW$CIE, ||__isfinitef||
$C$DW$236	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$236, DW_AT_name("f")
	.dwattr $C$DW$236, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$236, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$237	.dwtag  DW_TAG_variable
	.dwattr $C$DW$237, DW_AT_name("f")
	.dwattr $C$DW$237, DW_AT_type(*$C$DW$T$120)
	.dwattr $C$DW$237, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$238	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$238, DW_AT_low_pc(0x00)
	.dwattr $C$DW$238, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$235, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$235, DW_AT_TI_end_line(0x151)
	.dwattr $C$DW$235, DW_AT_TI_end_column(0x2d)
	.dwendentry
	.dwendtag $C$DW$235

	.sect	".text:__isfinite"
	.clink
	.global	||__isfinite||

$C$DW$239	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$239, DW_AT_name("__isfinite")
	.dwattr $C$DW$239, DW_AT_low_pc(||__isfinite||)
	.dwattr $C$DW$239, DW_AT_high_pc(0x00)
	.dwattr $C$DW$239, DW_AT_linkage_name("__isfinite")
	.dwattr $C$DW$239, DW_AT_external
	.dwattr $C$DW$239, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$239, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$239, DW_AT_decl_line(0x14e)
	.dwattr $C$DW$239, DW_AT_decl_column(0x25)
	.dwattr $C$DW$239, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 335,column 1,is_stmt,address ||__isfinite||,isa 0

	.dwfde $C$DW$CIE, ||__isfinite||
$C$DW$240	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$240, DW_AT_name("d")
	.dwattr $C$DW$240, DW_AT_type(*$C$DW$T$122)
	.dwattr $C$DW$240, DW_AT_location[DW_OP_reg12]


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
$C$DW$241	.dwtag  DW_TAG_variable
	.dwattr $C$DW$241, DW_AT_name("d")
	.dwattr $C$DW$241, DW_AT_type(*$C$DW$T$123)
	.dwattr $C$DW$241, DW_AT_location[DW_OP_reg12]

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
$C$DW$242	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$242, DW_AT_low_pc(0x00)
	.dwattr $C$DW$242, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$239, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$239, DW_AT_TI_end_line(0x14f)
	.dwattr $C$DW$239, DW_AT_TI_end_column(0x2e)
	.dwendentry
	.dwendtag $C$DW$239

	.sect	".text:__fpclassifyl"
	.clink
	.global	||__fpclassifyl||

$C$DW$243	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$243, DW_AT_name("__fpclassifyl")
	.dwattr $C$DW$243, DW_AT_low_pc(||__fpclassifyl||)
	.dwattr $C$DW$243, DW_AT_high_pc(0x00)
	.dwattr $C$DW$243, DW_AT_linkage_name("__fpclassifyl")
	.dwattr $C$DW$243, DW_AT_external
	.dwattr $C$DW$243, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$243, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$243, DW_AT_decl_line(0x1ae)
	.dwattr $C$DW$243, DW_AT_decl_column(0x25)
	.dwattr $C$DW$243, DW_AT_TI_max_frame_size(-10)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 431,column 1,is_stmt,address ||__fpclassifyl||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassifyl||
$C$DW$244	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$244, DW_AT_name("e")
	.dwattr $C$DW$244, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$244, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __fpclassifyl                 FR SIZE:   8           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  4 Auto,  0 SOE     *
;***************************************************************

||__fpclassifyl||:
$C$DW$245	.dwtag  DW_TAG_variable
	.dwattr $C$DW$245, DW_AT_name("e")
	.dwattr $C$DW$245, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$245, DW_AT_location[DW_OP_breg20 -8]

;* AR5   assigned to $O$C1
;* AR4   assigned to e
$C$DW$246	.dwtag  DW_TAG_variable
	.dwattr $C$DW$246, DW_AT_name("e")
	.dwattr $C$DW$246, DW_AT_type(*$C$DW$T$126)
	.dwattr $C$DW$246, DW_AT_location[DW_OP_reg12]

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
        B         ||$C$L25||,NEQ        ; [CPU_ALU] |436| 
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
$C$DW$247	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$247, DW_AT_low_pc(0x00)
	.dwattr $C$DW$247, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$247, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |436| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |436| 
        CMPB      AL,#0                 ; [CPU_ALU] |436| 
        B         ||$C$L24||,EQ         ; [CPU_ALU] |436| 
        ; branchcc occurs ; [] |436| 
        MOVB      AL,#2                 ; [CPU_ALU] |436| 
        B         ||$C$L28||,UNC        ; [CPU_ALU] |436| 
        ; branch occurs ; [] |436| 
||$C$L24||:    
        MOVB      AL,#1                 ; [CPU_ALU] |436| 
        B         ||$C$L28||,UNC        ; [CPU_ALU] |436| 
        ; branch occurs ; [] |436| 
||$C$L25||:    
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
$C$DW$248	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$248, DW_AT_low_pc(0x00)
	.dwattr $C$DW$248, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$248, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |436| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |436| 
        CMPB      AL,#0                 ; [CPU_ALU] |436| 
        B         ||$C$L26||,EQ         ; [CPU_ALU] |436| 
        ; branchcc occurs ; [] |436| 
        MOV       AL,#-1                ; [CPU_ALU] |436| 
        B         ||$C$L28||,UNC        ; [CPU_ALU] |436| 
        ; branch occurs ; [] |436| 
||$C$L26||:    
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |436| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |436| 
        MOVL      P,XAR5                ; [CPU_ALU] |436| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |436| 
        AND       AL,#65535             ; [CPU_ALU] |436| 
        ANDB      AH,#15                ; [CPU_ALU] |436| 
        AND       PL,#65535             ; [CPU_ALU] |436| 
        AND       PH,#65535             ; [CPU_ALU] |436| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |436| 
$C$DW$249	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$249, DW_AT_low_pc(0x00)
	.dwattr $C$DW$249, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$249, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |436| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |436| 
        CMPB      AL,#0                 ; [CPU_ALU] |436| 
        B         ||$C$L27||,EQ         ; [CPU_ALU] |436| 
        ; branchcc occurs ; [] |436| 
        MOV       AL,#-2                ; [CPU_ALU] |436| 
        B         ||$C$L28||,UNC        ; [CPU_ALU] |436| 
        ; branch occurs ; [] |436| 
||$C$L27||:    
        MOVB      AL,#0                 ; [CPU_ALU] |436| 
||$C$L28||:    
        SUBB      SP,#8                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$250	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$250, DW_AT_low_pc(0x00)
	.dwattr $C$DW$250, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$243, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$243, DW_AT_TI_end_line(0x1bd)
	.dwattr $C$DW$243, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$243

	.sect	".text:__fpclassifyf"
	.clink
	.global	||__fpclassifyf||

$C$DW$251	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$251, DW_AT_name("__fpclassifyf")
	.dwattr $C$DW$251, DW_AT_low_pc(||__fpclassifyf||)
	.dwattr $C$DW$251, DW_AT_high_pc(0x00)
	.dwattr $C$DW$251, DW_AT_linkage_name("__fpclassifyf")
	.dwattr $C$DW$251, DW_AT_external
	.dwattr $C$DW$251, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$251, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$251, DW_AT_decl_line(0x18c)
	.dwattr $C$DW$251, DW_AT_decl_column(0x25)
	.dwattr $C$DW$251, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 397,column 1,is_stmt,address ||__fpclassifyf||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassifyf||
$C$DW$252	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$252, DW_AT_name("f")
	.dwattr $C$DW$252, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$252, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$253	.dwtag  DW_TAG_variable
	.dwattr $C$DW$253, DW_AT_name("f")
	.dwattr $C$DW$253, DW_AT_type(*$C$DW$T$120)
	.dwattr $C$DW$253, DW_AT_location[DW_OP_regx 0x2b]

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
        B         ||$C$L30||,NEQ        ; [CPU_ALU] |402| 
        ; branchcc occurs ; [] |402| 
        MOVL      ACC,P                 ; [CPU_ALU] |402| 
        ANDB      AH,#127               ; [CPU_ALU] |402| 
        TEST      ACC                   ; [CPU_ALU] |402| 
        B         ||$C$L29||,EQ         ; [CPU_ALU] |402| 
        ; branchcc occurs ; [] |402| 
	.dwcfi	remember_state
        MOVB      AL,#2                 ; [CPU_ALU] |402| 
$C$DW$254	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$254, DW_AT_low_pc(0x00)
	.dwattr $C$DW$254, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L29||:    
	.dwcfi	remember_state
        MOVB      AL,#1                 ; [CPU_ALU] |402| 
$C$DW$255	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$255, DW_AT_low_pc(0x00)
	.dwattr $C$DW$255, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L30||:    
        MOVL      ACC,P                 ; [CPU_ALU] |402| 
        MOV       T,#23                 ; [CPU_ALU] |402| 
        LSRL      ACC,T                 ; [CPU_ALU] |402| 
        ANDB      AL,#0xff              ; [CPU_ALU] |402| 
        B         ||$C$L31||,EQ         ; [CPU_ALU] |402| 
        ; branchcc occurs ; [] |402| 
	.dwcfi	remember_state
        MOV       AL,#-1                ; [CPU_ALU] |402| 
$C$DW$256	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$256, DW_AT_low_pc(0x00)
	.dwattr $C$DW$256, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L31||:    
        MOVL      ACC,P                 ; [CPU_ALU] |402| 
        ANDB      AH,#127               ; [CPU_ALU] |402| 
        TEST      ACC                   ; [CPU_ALU] |402| 
        B         ||$C$L32||,EQ         ; [CPU_ALU] |402| 
        ; branchcc occurs ; [] |402| 
	.dwcfi	remember_state
        MOV       AL,#-2                ; [CPU_ALU] |402| 
$C$DW$257	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$257, DW_AT_low_pc(0x00)
	.dwattr $C$DW$257, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L32||:    
        MOVB      AL,#0                 ; [CPU_ALU] |402| 
$C$DW$258	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$258, DW_AT_low_pc(0x00)
	.dwattr $C$DW$258, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$251, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$251, DW_AT_TI_end_line(0x19b)
	.dwattr $C$DW$251, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$251

	.sect	".text:__fpclassify"
	.clink
	.global	||__fpclassify||

$C$DW$259	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$259, DW_AT_name("__fpclassify")
	.dwattr $C$DW$259, DW_AT_low_pc(||__fpclassify||)
	.dwattr $C$DW$259, DW_AT_high_pc(0x00)
	.dwattr $C$DW$259, DW_AT_linkage_name("__fpclassify")
	.dwattr $C$DW$259, DW_AT_external
	.dwattr $C$DW$259, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$259, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$259, DW_AT_decl_line(0x19d)
	.dwattr $C$DW$259, DW_AT_decl_column(0x25)
	.dwattr $C$DW$259, DW_AT_TI_max_frame_size(-10)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 414,column 1,is_stmt,address ||__fpclassify||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassify||
$C$DW$260	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$260, DW_AT_name("d")
	.dwattr $C$DW$260, DW_AT_type(*$C$DW$T$122)
	.dwattr $C$DW$260, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __fpclassify                  FR SIZE:   8           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  4 Auto,  0 SOE     *
;***************************************************************

||__fpclassify||:
$C$DW$261	.dwtag  DW_TAG_variable
	.dwattr $C$DW$261, DW_AT_name("d")
	.dwattr $C$DW$261, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$261, DW_AT_location[DW_OP_breg20 -8]

;* AR5   assigned to $O$C1
;* AR4   assigned to d
$C$DW$262	.dwtag  DW_TAG_variable
	.dwattr $C$DW$262, DW_AT_name("d")
	.dwattr $C$DW$262, DW_AT_type(*$C$DW$T$123)
	.dwattr $C$DW$262, DW_AT_location[DW_OP_reg12]

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
        B         ||$C$L34||,NEQ        ; [CPU_ALU] |419| 
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
$C$DW$263	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$263, DW_AT_low_pc(0x00)
	.dwattr $C$DW$263, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$263, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |419| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |419| 
        CMPB      AL,#0                 ; [CPU_ALU] |419| 
        B         ||$C$L33||,EQ         ; [CPU_ALU] |419| 
        ; branchcc occurs ; [] |419| 
        MOVB      AL,#2                 ; [CPU_ALU] |419| 
        B         ||$C$L37||,UNC        ; [CPU_ALU] |419| 
        ; branch occurs ; [] |419| 
||$C$L33||:    
        MOVB      AL,#1                 ; [CPU_ALU] |419| 
        B         ||$C$L37||,UNC        ; [CPU_ALU] |419| 
        ; branch occurs ; [] |419| 
||$C$L34||:    
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
$C$DW$264	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$264, DW_AT_low_pc(0x00)
	.dwattr $C$DW$264, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$264, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |419| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |419| 
        CMPB      AL,#0                 ; [CPU_ALU] |419| 
        B         ||$C$L35||,EQ         ; [CPU_ALU] |419| 
        ; branchcc occurs ; [] |419| 
        MOV       AL,#-1                ; [CPU_ALU] |419| 
        B         ||$C$L37||,UNC        ; [CPU_ALU] |419| 
        ; branch occurs ; [] |419| 
||$C$L35||:    
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |419| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |419| 
        MOVL      P,XAR5                ; [CPU_ALU] |419| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |419| 
        AND       AL,#65535             ; [CPU_ALU] |419| 
        ANDB      AH,#15                ; [CPU_ALU] |419| 
        AND       PL,#65535             ; [CPU_ALU] |419| 
        AND       PH,#65535             ; [CPU_ALU] |419| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |419| 
$C$DW$265	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$265, DW_AT_low_pc(0x00)
	.dwattr $C$DW$265, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$265, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |419| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |419| 
        CMPB      AL,#0                 ; [CPU_ALU] |419| 
        B         ||$C$L36||,EQ         ; [CPU_ALU] |419| 
        ; branchcc occurs ; [] |419| 
        MOV       AL,#-2                ; [CPU_ALU] |419| 
        B         ||$C$L37||,UNC        ; [CPU_ALU] |419| 
        ; branch occurs ; [] |419| 
||$C$L36||:    
        MOVB      AL,#0                 ; [CPU_ALU] |419| 
||$C$L37||:    
        SUBB      SP,#8                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$266	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$266, DW_AT_low_pc(0x00)
	.dwattr $C$DW$266, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$259, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$259, DW_AT_TI_end_line(0x1ac)
	.dwattr $C$DW$259, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$259

	.sect	"ramfuncs"
	.clink
	.global	||BTS_updateReference||

$C$DW$267	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$267, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$267, DW_AT_low_pc(||BTS_updateReference||)
	.dwattr $C$DW$267, DW_AT_high_pc(0x00)
	.dwattr $C$DW$267, DW_AT_linkage_name("BTS_updateReference")
	.dwattr $C$DW$267, DW_AT_external
	.dwattr $C$DW$267, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$267, DW_AT_decl_line(0x2ff)
	.dwattr $C$DW$267, DW_AT_decl_column(0x06)
	.dwattr $C$DW$267, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts.c",line 768,column 1,is_stmt,address ||BTS_updateReference||,isa 0

	.dwfde $C$DW$CIE, ||BTS_updateReference||
$C$DW$268	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$268, DW_AT_name("userInput")
	.dwattr $C$DW$268, DW_AT_type(*$C$DW$T$61)
	.dwattr $C$DW$268, DW_AT_location[DW_OP_reg12]

$C$DW$269	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$269, DW_AT_name("ctrlLoopVariable")
	.dwattr $C$DW$269, DW_AT_type(*$C$DW$T$66)
	.dwattr $C$DW$269, DW_AT_location[DW_OP_reg14]


;***************************************************************
;* FNAME: BTS_updateReference           FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  2 SOE     *
;***************************************************************

||BTS_updateReference||:
;* AR4   assigned to userInput
$C$DW$270	.dwtag  DW_TAG_variable
	.dwattr $C$DW$270, DW_AT_name("userInput")
	.dwattr $C$DW$270, DW_AT_type(*$C$DW$T$62)
	.dwattr $C$DW$270, DW_AT_location[DW_OP_reg12]

;* AR5   assigned to ctrlLoopVariable
$C$DW$271	.dwtag  DW_TAG_variable
	.dwattr $C$DW$271, DW_AT_name("ctrlLoopVariable")
	.dwattr $C$DW$271, DW_AT_type(*$C$DW$T$67)
	.dwattr $C$DW$271, DW_AT_location[DW_OP_reg14]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts.c",line 770,column 5,is_stmt,isa 0
        MOV       AL,*+XAR4[7]          ; [CPU_ALU] |770| 
	.dwpsn	file "../bts.c",line 774,column 9,is_stmt,isa 0
        MOVB      XAR0,#34,EQ           ; [CPU_ALU] |774| 
        MOVB      *+XAR5[AR0],#1,EQ     ; [CPU_ALU] |774| 
        B         ||$C$L38||,EQ         ; [CPU_ALU] |774| 
        ; branchcc occurs ; [] |774| 
	.dwpsn	file "../bts.c",line 771,column 9,is_stmt,isa 0
        MOVB      XAR0,#34              ; [CPU_ALU] |771| 
        MOV       *+XAR5[AR0],#0        ; [CPU_ALU] |771| 
||$C$L38||:    
	.dwpsn	file "../bts.c",line 779,column 5,is_stmt,isa 0
        MOVB      XAR0,#14              ; [CPU_ALU] |779| 
        MOV32     R0H,*+XAR4[0]         ; [CPU_FPU] |779| 
        MOVB      XAR1,#16              ; [CPU_ALU] |779| 
        MOV32     R1H,*+XAR4[AR0]       ; [CPU_FPU] |779| 
        MPYF32    R0H,R1H,R0H           ; [CPU_FPU] |779| 
        MOV32     R3H,*+XAR4[AR1]       ; [CPU_FPU] |779| 
        ADDF32    R0H,R0H,R3H           ; [CPU_FPU] |779| 
	.dwpsn	file "../bts.c",line 781,column 5,is_stmt,isa 0
        MOVB      XAR0,#8               ; [CPU_ALU] |781| 
	.dwpsn	file "../bts.c",line 779,column 5,is_stmt,isa 0
        MOV32     *+XAR5[4],R0H         ; [CPU_FPU] |779| 
	.dwpsn	file "../bts.c",line 781,column 5,is_stmt,isa 0
        MOVL      ACC,*+XAR4[AR0]       ; [CPU_ALU] |781| 
        MOVL      *+XAR5[2],ACC         ; [CPU_ALU] |781| 
	.dwpsn	file "../bts.c",line 783,column 5,is_stmt,isa 0
        MOV       AL,*+XAR4[6]          ; [CPU_ALU] |783| 
        CMPB      AL,#1                 ; [CPU_ALU] |783| 
        B         ||$C$L39||,EQ         ; [CPU_ALU] |783| 
        ; branchcc occurs ; [] |783| 
	.dwpsn	file "../bts.c",line 790,column 9,is_stmt,isa 0
        MOVB      XAR0,#31              ; [CPU_ALU] |790| 
	.dwpsn	file "../bts.c",line 789,column 9,is_stmt,isa 0
        MOVIZ     R0H,#49024            ; [CPU_FPU] |789| 
	.dwpsn	file "../bts.c",line 790,column 9,is_stmt,isa 0
        MOV       *+XAR5[AR0],#0        ; [CPU_ALU] |790| 
	.dwpsn	file "../bts.c",line 789,column 9,is_stmt,isa 0
        MOVB      XAR0,#24              ; [CPU_ALU] |789| 
        MOV32     *+XAR5[AR0],R0H       ; [CPU_FPU] |789| 
	.dwpsn	file "../bts.c",line 791,column 9,is_stmt,isa 0
        MOV32     R0H,*+XAR4[4]         ; [CPU_FPU] |791| 
        B         ||$C$L40||,UNC        ; [CPU_ALU] |791| 
        ; branch occurs ; [] |791| 
||$C$L39||:    
	.dwpsn	file "../bts.c",line 785,column 9,is_stmt,isa 0
        MOVB      XAR0,#31              ; [CPU_ALU] |785| 
	.dwpsn	file "../bts.c",line 784,column 9,is_stmt,isa 0
        MOVIZ     R0H,#16256            ; [CPU_FPU] |784| 
	.dwpsn	file "../bts.c",line 785,column 9,is_stmt,isa 0
        MOVB      *+XAR5[AR0],#1,UNC    ; [CPU_ALU] |785| 
	.dwpsn	file "../bts.c",line 784,column 9,is_stmt,isa 0
        MOVB      XAR0,#24              ; [CPU_ALU] |784| 
        MOV32     *+XAR5[AR0],R0H       ; [CPU_FPU] |784| 
	.dwpsn	file "../bts.c",line 786,column 9,is_stmt,isa 0
        MOV32     R0H,*+XAR4[2]         ; [CPU_FPU] |786| 
||$C$L40||:    
        MOVB      XAR1,#22              ; [CPU_ALU] |786| 
        MOVB      XAR0,#24              ; [CPU_ALU] |786| 
        MOV32     R1H,*+XAR4[AR1]       ; [CPU_FPU] |786| 
        MPYF32    R0H,R1H,R0H           ; [CPU_FPU] |786| 
        MOV32     R3H,*+XAR4[AR0]       ; [CPU_FPU] |786| 
        ADDF32    R0H,R0H,R3H           ; [CPU_FPU] |786| 
        MOVB      XAR0,#10              ; [CPU_ALU] |786| 
        MOV32     *+XAR5[AR0],R0H       ; [CPU_FPU] |786| 
        MOVL      XAR1,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$272	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$272, DW_AT_low_pc(0x00)
	.dwattr $C$DW$272, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$267, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$267, DW_AT_TI_end_line(0x32e)
	.dwattr $C$DW$267, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$267

	.sect	".text"
	.clink
	.global	||BTS_setupSfraGui||

$C$DW$273	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$273, DW_AT_name("BTS_setupSfraGui")
	.dwattr $C$DW$273, DW_AT_low_pc(||BTS_setupSfraGui||)
	.dwattr $C$DW$273, DW_AT_high_pc(0x00)
	.dwattr $C$DW$273, DW_AT_linkage_name("BTS_setupSfraGui")
	.dwattr $C$DW$273, DW_AT_external
	.dwattr $C$DW$273, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$273, DW_AT_decl_line(0x210)
	.dwattr $C$DW$273, DW_AT_decl_column(0x06)
	.dwattr $C$DW$273, DW_AT_TI_max_frame_size(-18)
	.dwpsn	file "../bts.c",line 529,column 1,is_stmt,address ||BTS_setupSfraGui||,isa 0

	.dwfde $C$DW$CIE, ||BTS_setupSfraGui||

;***************************************************************
;* FNAME: BTS_setupSfraGui              FR SIZE:  16           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                           15 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_setupSfraGui||:
;* AL    assigned to $O$R1
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#16                ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -18
	.dwpsn	file "C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h",line 238,column 9,is_stmt,isa 0
        MOV       AL,#11520             ; [CPU_ALU] |238| 
        MOV       AH,#305               ; [CPU_ALU] |238| 
$C$DW$274	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$274, DW_AT_low_pc(0x00)
	.dwattr $C$DW$274, DW_AT_name("SysCtl_getLowSpeedClock")
	.dwattr $C$DW$274, DW_AT_TI_call

        LCR       #||SysCtl_getLowSpeedClock|| ; [CPU_ALU] |238| 
        ; call occurs [#||SysCtl_getLowSpeedClock||] ; [] |238| 
	.dwpsn	file "../bts.c",line 531,column 9,is_stmt,isa 0
        MOVL      XAR4,#57600           ; [CPU_ARAU] |531| 
        MOVL      XAR5,#530433          ; [CPU_ARAU] |531| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |531| 
        MOVL      *-SP[4],XAR4          ; [CPU_ALU] |531| 
        MOV       ACC,#8975 << 9        ; [CPU_ALU] |531| 
        MOVL      XAR4,#530945          ; [CPU_ARAU] |531| 
        MOVL      *-SP[6],XAR5          ; [CPU_ALU] |531| 
        MOVB      *-SP[7],#29,UNC       ; [CPU_ALU] |531| 
        MOVB      XAR5,#28              ; [CPU_ALU] |531| 
        MOVL      *-SP[10],XAR4         ; [CPU_ALU] |531| 
        MOVL      XAR4,#29184           ; [CPU_ARAU] |531| 
        MOVB      *-SP[11],#1,UNC       ; [CPU_ALU] |531| 
        MOVB      *-SP[12],#47,UNC      ; [CPU_ALU] |531| 
        MOVL      *-SP[14],ACC          ; [CPU_ALU] |531| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |531| 
        MOVL      XAR4,#||BTS_sfra||    ; [CPU_ARAU] |531| 
        MOVB      *-SP[15],#1,UNC       ; [CPU_ALU] |531| 
$C$DW$275	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$275, DW_AT_low_pc(0x00)
	.dwattr $C$DW$275, DW_AT_name("SFRA_GUI_config")
	.dwattr $C$DW$275, DW_AT_TI_call

        LCR       #||SFRA_GUI_config||  ; [CPU_ALU] |531| 
        ; call occurs [#||SFRA_GUI_config||] ; [] |531| 
        SUBB      SP,#16                ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$276	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$276, DW_AT_low_pc(0x00)
	.dwattr $C$DW$276, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$273, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$273, DW_AT_TI_end_line(0x220)
	.dwattr $C$DW$273, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$273

	.sect	".text"
	.clink
	.global	||BTS_setupSfra||

$C$DW$277	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$277, DW_AT_name("BTS_setupSfra")
	.dwattr $C$DW$277, DW_AT_low_pc(||BTS_setupSfra||)
	.dwattr $C$DW$277, DW_AT_high_pc(0x00)
	.dwattr $C$DW$277, DW_AT_linkage_name("BTS_setupSfra")
	.dwattr $C$DW$277, DW_AT_external
	.dwattr $C$DW$277, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$277, DW_AT_decl_line(0x1f7)
	.dwattr $C$DW$277, DW_AT_decl_column(0x06)
	.dwattr $C$DW$277, DW_AT_TI_max_frame_size(-16)
	.dwpsn	file "../bts.c",line 504,column 1,is_stmt,address ||BTS_setupSfra||,isa 0

	.dwfde $C$DW$CIE, ||BTS_setupSfra||

;***************************************************************
;* FNAME: BTS_setupSfra                 FR SIZE:  14           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                           12 Parameter,  0 Auto,  2 SOE     *
;***************************************************************

||BTS_setupSfra||:
;* AR1   assigned to $O$C1
;* AR5   assigned to $O$C2
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
        ADDB      SP,#12                ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -16
	.dwpsn	file "../bts.c",line 506,column 9,is_stmt,isa 0
        MOVL      XAR1,#||BTS_sfra||    ; [CPU_ARAU] |506| 
        MOVL      XAR4,XAR1             ; [CPU_ALU] |506| 
$C$DW$278	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$278, DW_AT_low_pc(0x00)
	.dwattr $C$DW$278, DW_AT_name("SFRA_F32_reset")
	.dwattr $C$DW$278, DW_AT_TI_call

        LCR       #||SFRA_F32_reset||   ; [CPU_ALU] |506| 
        ; call occurs [#||SFRA_F32_reset||] ; [] |506| 
	.dwpsn	file "../bts.c",line 507,column 9,is_stmt,isa 0
        MOVL      XAR5,#||BTS_sfraData|| ; [CPU_ARAU] |507| 
        MOVIZ     R0H,#18164            ; [CPU_FPU] |507| 
        MOVIZ     R1H,#15820            ; [CPU_FPU] |507| 
        MOVIZ     R3H,#16265            ; [CPU_FPU] |507| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |507| 
        MOVB      XAR7,#0               ; [CPU_ALU] |507| 
        MOVB      XAR6,#0               ; [CPU_ALU] |507| 
        MOVIZ     R2H,#16672            ; [CPU_FPU] |507| 
        ADDB      ACC,#206              ; [CPU_ALU] |507| 
        MOVL      XAR4,XAR1             ; [CPU_ALU] |507| 
        MOVXI     R0H,#9216             ; [CPU_FPU] |507| 
        MOVXI     R1H,#52429            ; [CPU_FPU] |507| 
        MOVXI     R3H,#36032            ; [CPU_FPU] |507| 
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |507| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |507| 
        ADD       ACC,#103 << 2         ; [CPU_ALU] |507| 
        MOVL      *-SP[4],ACC           ; [CPU_ALU] |507| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |507| 
        ADD       ACC,#309 << 1         ; [CPU_ALU] |507| 
        MOVL      *-SP[6],ACC           ; [CPU_ALU] |507| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |507| 
        MOVL      *-SP[8],XAR7          ; [CPU_ALU] |507| 
        ADD       ACC,#103 << 3         ; [CPU_ALU] |507| 
        MOVL      *-SP[10],XAR6         ; [CPU_ALU] |507| 
        MOVL      *-SP[12],ACC          ; [CPU_ALU] |507| 
        MOVB      AL,#103               ; [CPU_ALU] |507| 
        MOVB      AH,#3                 ; [CPU_ALU] |507| 
$C$DW$279	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$279, DW_AT_low_pc(0x00)
	.dwattr $C$DW$279, DW_AT_name("SFRA_F32_config")
	.dwattr $C$DW$279, DW_AT_TI_call

        LCR       #||SFRA_F32_config||  ; [CPU_ALU] |507| 
        ; call occurs [#||SFRA_F32_config||] ; [] |507| 
	.dwpsn	file "../bts.c",line 521,column 9,is_stmt,isa 0
        MOVL      XAR4,XAR1             ; [CPU_ALU] |521| 
$C$DW$280	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$280, DW_AT_low_pc(0x00)
	.dwattr $C$DW$280, DW_AT_name("SFRA_F32_resetFreqRespArray")
	.dwattr $C$DW$280, DW_AT_TI_call

        LCR       #||SFRA_F32_resetFreqRespArray|| ; [CPU_ALU] |521| 
        ; call occurs [#||SFRA_F32_resetFreqRespArray||] ; [] |521| 
	.dwpsn	file "../bts.c",line 522,column 9,is_stmt,isa 0
        MOVIZ     R1H,#16265            ; [CPU_FPU] |522| 
        MOVIZ     R0H,#16672            ; [CPU_FPU] |522| 
        MOVL      XAR4,XAR1             ; [CPU_ALU] |522| 
        MOVXI     R1H,#36032            ; [CPU_FPU] |522| 
$C$DW$281	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$281, DW_AT_low_pc(0x00)
	.dwattr $C$DW$281, DW_AT_name("SFRA_F32_initFreqArrayWithLogSteps")
	.dwattr $C$DW$281, DW_AT_TI_call

        LCR       #||SFRA_F32_initFreqArrayWithLogSteps|| ; [CPU_ALU] |522| 
        ; call occurs [#||SFRA_F32_initFreqArrayWithLogSteps||] ; [] |522| 
        SUBB      SP,#12                ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
        MOVL      XAR1,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$282	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$282, DW_AT_low_pc(0x00)
	.dwattr $C$DW$282, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$277, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$277, DW_AT_TI_end_line(0x20e)
	.dwattr $C$DW$277, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$277

	.sect	".text"
	.clink
	.global	||BTS_setupHrpwmMepScaleFactor||

$C$DW$283	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$283, DW_AT_name("BTS_setupHrpwmMepScaleFactor")
	.dwattr $C$DW$283, DW_AT_low_pc(||BTS_setupHrpwmMepScaleFactor||)
	.dwattr $C$DW$283, DW_AT_high_pc(0x00)
	.dwattr $C$DW$283, DW_AT_linkage_name("BTS_setupHrpwmMepScaleFactor")
	.dwattr $C$DW$283, DW_AT_external
	.dwattr $C$DW$283, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$283, DW_AT_decl_line(0x1e9)
	.dwattr $C$DW$283, DW_AT_decl_column(0x06)
	.dwattr $C$DW$283, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts.c",line 490,column 1,is_stmt,address ||BTS_setupHrpwmMepScaleFactor||,isa 0

	.dwfde $C$DW$CIE, ||BTS_setupHrpwmMepScaleFactor||

;***************************************************************
;* FNAME: BTS_setupHrpwmMepScaleFactor  FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_setupHrpwmMepScaleFactor||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
||$C$L41||:    
	.dwpsn	file "../bts.c",line 496,column 13,is_stmt,isa 0
$C$DW$284	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$284, DW_AT_low_pc(0x00)
	.dwattr $C$DW$284, DW_AT_name("SFO")
	.dwattr $C$DW$284, DW_AT_TI_call

        LCR       #||SFO||              ; [CPU_ALU] |496| 
        ; call occurs [#||SFO||] ; [] |496| 
        MOVW      DP,#||BTS_sfoStatus|| ; [CPU_ARAU] 
        CMPB      AL,#0                 ; [CPU_ALU] |496| 
        MOV       @||BTS_sfoStatus||,AL ; [CPU_FPU] |496| 
        B         ||$C$L41||,EQ         ; [CPU_ALU] |496| 
        ; branchcc occurs ; [] |496| 
$C$DW$285	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$285, DW_AT_low_pc(0x00)
	.dwattr $C$DW$285, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$283, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$283, DW_AT_TI_end_line(0x1f3)
	.dwattr $C$DW$283, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$283

	.sect	"ramfuncs"
	.clink
	.global	||BTS_monitor_Iout_Vout||

$C$DW$286	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$286, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$286, DW_AT_low_pc(||BTS_monitor_Iout_Vout||)
	.dwattr $C$DW$286, DW_AT_high_pc(0x00)
	.dwattr $C$DW$286, DW_AT_linkage_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$286, DW_AT_external
	.dwattr $C$DW$286, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$286, DW_AT_decl_line(0x332)
	.dwattr $C$DW$286, DW_AT_decl_column(0x06)
	.dwattr $C$DW$286, DW_AT_TI_max_frame_size(-8)
	.dwpsn	file "../bts.c",line 819,column 1,is_stmt,address ||BTS_monitor_Iout_Vout||,isa 0

	.dwfde $C$DW$CIE, ||BTS_monitor_Iout_Vout||
$C$DW$287	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$287, DW_AT_name("measValues")
	.dwattr $C$DW$287, DW_AT_type(*$C$DW$T$71)
	.dwattr $C$DW$287, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: BTS_monitor_Iout_Vout         FR SIZE:   6           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  6 SOE     *
;***************************************************************

||BTS_monitor_Iout_Vout||:
;* AR5   assigned to $O$U9
;* PL    assigned to $O$V0
;* AR7   assigned to $O$V1
;* AR4   assigned to measValues
$C$DW$288	.dwtag  DW_TAG_variable
	.dwattr $C$DW$288, DW_AT_name("measValues")
	.dwattr $C$DW$288, DW_AT_type(*$C$DW$T$72)
	.dwattr $C$DW$288, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts.c",line 820,column 5,is_stmt,isa 0
        MOVB      XAR0,#68              ; [CPU_ALU] |820| 
        MOVL      XAR5,XAR4             ; [CPU_ALU] 
        MOVB      XAR1,#68              ; [CPU_ALU] 
        MOVB      XAR6,#0               ; [CPU_ALU] |820| 
	.dwpsn	file "../bts.c",line 821,column 5,is_stmt,isa 0
        MOVB      ACC,#0                ; [CPU_ALU] |821| 
        MOV32     *SP++,R4H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 59, 4
	.dwcfi	cfa_offset, -6
        SETC      SXM                   ; [CPU_ALU] 
        MOV       P,#0                  ; [CPU_ALU] 
        MOV32     *SP++,R5H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 63, 6
	.dwcfi	cfa_offset, -8
        ADDB      XAR5,#4               ; [CPU_ALU] 
	.dwpsn	file "../bts.c",line 820,column 5,is_stmt,isa 0
        MOVL      *+XAR4[AR0],XAR6      ; [CPU_ALU] |820| 
	.dwpsn	file "../bts.c",line 821,column 5,is_stmt,isa 0
        MOVB      XAR0,#70              ; [CPU_ALU] |821| 
        MOVB      XAR6,#3               ; [CPU_ALU] 
        MOVL      XAR7,*+XAR4[AR1]      ; [CPU_ALU] 
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |821| 
	.dwpsn	file "../bts.c",line 824,column 19,is_stmt,isa 0
        RPTB      ||$C$L43||,AR6        ; [CPU_ALU] |824| 
        ; repeat block starts ; [] 
||$C$L42||:    
        MOVL      ACC,XAR7              ; [CPU_ALU] 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        MOVB      XAR1,#68              ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        MOVB      XAR0,#32              ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |825| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |825| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |825| 
        MOVL      ACC,P                 ; [CPU_ALU] |825| 
        MOVB      XAR1,#68              ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |826| 
        MOVB      XAR0,#70              ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        MOVL      P,ACC                 ; [CPU_ALU] |826| 
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |826| 
        MOVB      XAR0,#32              ; [CPU_ALU] |826| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |825| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |825| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |825| 
        MOVL      ACC,P                 ; [CPU_ALU] |825| 
        MOVB      XAR1,#68              ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |826| 
        MOVB      XAR0,#70              ; [CPU_ALU] |826| 
        MOVL      P,ACC                 ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |826| 
        MOVB      XAR0,#32              ; [CPU_ALU] |826| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |825| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |825| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |825| 
        MOVL      ACC,P                 ; [CPU_ALU] |825| 
        MOVB      XAR1,#68              ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |826| 
        MOVB      XAR0,#70              ; [CPU_ALU] |826| 
        MOVL      P,ACC                 ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |826| 
        MOVB      XAR0,#32              ; [CPU_ALU] |826| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |825| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |825| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |825| 
        MOVL      ACC,P                 ; [CPU_ALU] |825| 
        MOVB      XAR1,#68              ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |826| 
        MOVB      XAR0,#70              ; [CPU_ALU] |826| 
        MOVL      P,ACC                 ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |826| 
        MOVB      XAR0,#32              ; [CPU_ALU] |826| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |825| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |825| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |825| 
        MOVL      ACC,P                 ; [CPU_ALU] |825| 
        MOVB      XAR1,#68              ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |826| 
        MOVB      XAR0,#70              ; [CPU_ALU] |826| 
        MOVL      P,ACC                 ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |826| 
        MOVB      XAR0,#32              ; [CPU_ALU] |826| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |825| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |825| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |825| 
        MOVL      ACC,P                 ; [CPU_ALU] |825| 
        MOVB      XAR1,#68              ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |826| 
        MOVB      XAR0,#70              ; [CPU_ALU] |826| 
        MOVL      P,ACC                 ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |826| 
        MOVB      XAR0,#32              ; [CPU_ALU] |826| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |825| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |825| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |825| 
        MOVL      ACC,P                 ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        MOVB      XAR1,#70              ; [CPU_ALU] |826| 
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |826| 
        MOVB      XAR0,#70              ; [CPU_ALU] |826| 
        MOVL      P,ACC                 ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        MOVB      XAR0,#68              ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        MOVL      ACC,XAR7              ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |825| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |825| 
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        MOVB      XAR0,#32              ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 825,column 9,is_stmt,isa 0
        MOVL      ACC,P                 ; [CPU_ALU] |825| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |826| 
        MOVL      P,ACC                 ; [CPU_ALU] |826| 
	.dwpsn	file "../bts.c",line 824,column 19,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |824| 
	.dwpsn	file "../bts.c",line 826,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |826| 
        ; repeat block ends ; [] 
||$C$L43||:    
	.dwpsn	file "../bts.c",line 829,column 5,is_stmt,isa 0
        MOVB      XAR0,#68              ; [CPU_ALU] |829| 
        I32TOF32  R1H,*+XAR4[AR0]       ; [CPU_FPU] |829| 
	.dwpsn	file "../bts.c",line 831,column 5,is_stmt,isa 0
        MOVB      XAR0,#70              ; [CPU_ALU] |831| 
        MOVB      XAR1,#78              ; [CPU_ALU] |831| 
        I32TOF32  R0H,*+XAR4[AR0]       ; [CPU_FPU] |831| 
	.dwpsn	file "../bts.c",line 829,column 5,is_stmt,isa 0
        MOVB      XAR0,#74              ; [CPU_ALU] |829| 
        MPYF32    R4H,R1H,#13696        ; [CPU_FPU] |829| 
        MOV32     R3H,*+XAR4[AR0]       ; [CPU_FPU] |829| 
        MOVB      XAR0,#76              ; [CPU_ALU] |829| 
        MOV32     R5H,*+XAR4[AR0]       ; [CPU_FPU] |829| 
	.dwpsn	file "../bts.c",line 831,column 5,is_stmt,isa 0
        MPYF32    R1H,R0H,#13696        ; [CPU_FPU] |831| 
        MOVB      XAR0,#80              ; [CPU_ALU] |831| 
	.dwpsn	file "../bts.c",line 829,column 5,is_stmt,isa 0

        MPYF32    R3H,R4H,R3H           ; [CPU_FPU] |829| 
||      MOV32     R2H,*+XAR4[AR1]       ; [CPU_FPU] |831| 

	.dwpsn	file "../bts.c",line 831,column 5,is_stmt,isa 0
        MPYF32    R0H,R1H,R2H           ; [CPU_FPU] |831| 
	.dwpsn	file "../bts.c",line 829,column 5,is_stmt,isa 0

        ADDF32    R1H,R5H,R3H           ; [CPU_FPU] |829| 
||      MOV32     R2H,*+XAR4[AR0]       ; [CPU_FPU] |831| 

	.dwpsn	file "../bts.c",line 831,column 5,is_stmt,isa 0
        ADDF32    R0H,R0H,R2H           ; [CPU_FPU] |831| 
	.dwpsn	file "../bts.c",line 829,column 5,is_stmt,isa 0
        MOV32     *+XAR4[0],R1H         ; [CPU_FPU] |829| 
	.dwpsn	file "../bts.c",line 831,column 5,is_stmt,isa 0
        MOV32     *+XAR4[2],R0H         ; [CPU_FPU] |831| 
        MOV32     R5H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -6
	.dwcfi	restore_reg, 63
        MOV32     R4H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 59
        MOVL      XAR1,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$289	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$289, DW_AT_low_pc(0x00)
	.dwattr $C$DW$289, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$286, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$286, DW_AT_TI_end_line(0x341)
	.dwattr $C$DW$286, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$286

	.sect	".text"
	.clink
	.global	||BTS_initUserVariables||

$C$DW$290	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$290, DW_AT_name("BTS_initUserVariables")
	.dwattr $C$DW$290, DW_AT_low_pc(||BTS_initUserVariables||)
	.dwattr $C$DW$290, DW_AT_high_pc(0x00)
	.dwattr $C$DW$290, DW_AT_linkage_name("BTS_initUserVariables")
	.dwattr $C$DW$290, DW_AT_external
	.dwattr $C$DW$290, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$290, DW_AT_decl_line(0x99)
	.dwattr $C$DW$290, DW_AT_decl_column(0x06)
	.dwattr $C$DW$290, DW_AT_TI_max_frame_size(-130)
	.dwpsn	file "../bts.c",line 154,column 1,is_stmt,address ||BTS_initUserVariables||,isa 0

	.dwfde $C$DW$CIE, ||BTS_initUserVariables||

;***************************************************************
;* FNAME: BTS_initUserVariables         FR SIZE: 128           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter, 118 Auto, 10 SOE     *
;***************************************************************

||BTS_initUserVariables||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR2            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 9, 2
	.dwcfi	cfa_offset, -4
        MOV32     *SP++,R4H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 59, 4
	.dwcfi	cfa_offset, -6
        MOV32     *SP++,R5H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 63, 6
	.dwcfi	cfa_offset, -8
        MOV32     *SP++,R6H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 67, 8
	.dwcfi	cfa_offset, -10
        MOV32     *SP++,R7H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 71, 10
	.dwcfi	cfa_offset, -12
        MOVZ      AR2,SP                ; [CPU_ALU] 
        SUBB      FP,#12                ; [CPU_ARAU] 
        ADDB      SP,#118               ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -130
        MOVW      DP,#||BTS_userInput_ch1||+6 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 159,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16492            ; [CPU_FPU] |159| 
	.dwpsn	file "../bts.c",line 157,column 5,is_stmt,isa 0
        ZERO      R3H                   ; [CPU_FPU] |157| 
	.dwpsn	file "../bts.c",line 158,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16256            ; [CPU_FPU] |158| 
	.dwpsn	file "../bts.c",line 155,column 5,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_userInput_ch1||)+6,#1,UNC ; [CPU_ALU] |155| 
	.dwpsn	file "../bts.c",line 160,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16128            ; [CPU_FPU] |160| 
	.dwpsn	file "../bts.c",line 156,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_userInput_ch1||)+7,#0 ; [CPU_ALU] |156| 
	.dwpsn	file "../bts.c",line 159,column 5,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |159| 
	.dwpsn	file "../bts.c",line 157,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+8,R3H ; [CPU_FPU] |157| 
	.dwpsn	file "../bts.c",line 158,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||),R2H ; [CPU_FPU] |158| 
	.dwpsn	file "../bts.c",line 175,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16256            ; [CPU_FPU] |175| 
	.dwpsn	file "../bts.c",line 159,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+2,R0H ; [CPU_FPU] |159| 
	.dwpsn	file "../bts.c",line 176,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16492            ; [CPU_FPU] |176| 
	.dwpsn	file "../bts.c",line 160,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+4,R1H ; [CPU_FPU] |160| 
	.dwpsn	file "../bts.c",line 176,column 5,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |176| 
	.dwpsn	file "../bts.c",line 177,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16128            ; [CPU_FPU] |177| 
	.dwpsn	file "../bts.c",line 172,column 5,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_userInput_ch2||)+6,#1,UNC ; [CPU_ALU] |172| 
	.dwpsn	file "../bts.c",line 173,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_userInput_ch2||)+7,#0 ; [CPU_ALU] |173| 
	.dwpsn	file "../bts.c",line 221,column 5,is_stmt,isa 0
        MOVL      XAR0,#66              ; [CPU_ALU] |221| 
	.dwpsn	file "../bts.c",line 174,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+8,R3H ; [CPU_FPU] |174| 
	.dwpsn	file "../bts.c",line 175,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||),R2H ; [CPU_FPU] |175| 
	.dwpsn	file "../bts.c",line 192,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16256            ; [CPU_FPU] |192| 
	.dwpsn	file "../bts.c",line 176,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+2,R0H ; [CPU_FPU] |176| 
	.dwpsn	file "../bts.c",line 193,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16492            ; [CPU_FPU] |193| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |193| 
	.dwpsn	file "../bts.c",line 177,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+4,R1H ; [CPU_FPU] |177| 
        MOVW      DP,#||BTS_userInput_ch3||+6 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 194,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16128            ; [CPU_FPU] |194| 
	.dwpsn	file "../bts.c",line 189,column 5,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_userInput_ch3||)+6,#1,UNC ; [CPU_ALU] |189| 
	.dwpsn	file "../bts.c",line 281,column 5,is_stmt,isa 0
        MOVIZ     R6H,#15820            ; [CPU_FPU] |281| 
	.dwpsn	file "../bts.c",line 283,column 5,is_stmt,isa 0
        MOVIZ     R5H,#16672            ; [CPU_FPU] |283| 
	.dwpsn	file "../bts.c",line 284,column 5,is_stmt,isa 0
        MOVIZ     R4H,#45856            ; [CPU_FPU] |284| 
	.dwpsn	file "../bts.c",line 278,column 5,is_stmt,isa 0
        MOVIZ     R7H,#16492            ; [CPU_FPU] |278| 
	.dwpsn	file "../bts.c",line 190,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_userInput_ch3||)+7,#0 ; [CPU_ALU] |190| 
	.dwpsn	file "../bts.c",line 191,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+8,R3H ; [CPU_FPU] |191| 
	.dwpsn	file "../bts.c",line 192,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||),R2H ; [CPU_FPU] |192| 
	.dwpsn	file "../bts.c",line 209,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16256            ; [CPU_FPU] |209| 
	.dwpsn	file "../bts.c",line 193,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+2,R0H ; [CPU_FPU] |193| 
	.dwpsn	file "../bts.c",line 210,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16492            ; [CPU_FPU] |210| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |210| 
	.dwpsn	file "../bts.c",line 194,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+4,R1H ; [CPU_FPU] |194| 
	.dwpsn	file "../bts.c",line 211,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16128            ; [CPU_FPU] |211| 
	.dwpsn	file "../bts.c",line 206,column 5,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_userInput_ch4||)+6,#1,UNC ; [CPU_ALU] |206| 
	.dwpsn	file "../bts.c",line 207,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_userInput_ch4||)+7,#0 ; [CPU_ALU] |207| 
	.dwpsn	file "../bts.c",line 208,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+8,R3H ; [CPU_FPU] |208| 
	.dwpsn	file "../bts.c",line 209,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||),R2H ; [CPU_FPU] |209| 
	.dwpsn	file "../bts.c",line 226,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16256            ; [CPU_FPU] |226| 
	.dwpsn	file "../bts.c",line 210,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+2,R0H ; [CPU_FPU] |210| 
	.dwpsn	file "../bts.c",line 227,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16492            ; [CPU_FPU] |227| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |227| 
	.dwpsn	file "../bts.c",line 211,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+4,R1H ; [CPU_FPU] |211| 
	.dwpsn	file "../bts.c",line 228,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16128            ; [CPU_FPU] |228| 
        MOVW      DP,#||BTS_userInput_ch5||+6 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 223,column 5,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_userInput_ch5||)+6,#1,UNC ; [CPU_ALU] |223| 
	.dwpsn	file "../bts.c",line 224,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_userInput_ch5||)+7,#0 ; [CPU_ALU] |224| 
	.dwpsn	file "../bts.c",line 225,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch5||)+8,R3H ; [CPU_FPU] |225| 
	.dwpsn	file "../bts.c",line 226,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch5||),R2H ; [CPU_FPU] |226| 
	.dwpsn	file "../bts.c",line 243,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16256            ; [CPU_FPU] |243| 
	.dwpsn	file "../bts.c",line 227,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch5||)+2,R0H ; [CPU_FPU] |227| 
	.dwpsn	file "../bts.c",line 244,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16492            ; [CPU_FPU] |244| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |244| 
	.dwpsn	file "../bts.c",line 228,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch5||)+4,R1H ; [CPU_FPU] |228| 
	.dwpsn	file "../bts.c",line 245,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16128            ; [CPU_FPU] |245| 
	.dwpsn	file "../bts.c",line 240,column 5,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_userInput_ch6||)+6,#1,UNC ; [CPU_ALU] |240| 
	.dwpsn	file "../bts.c",line 241,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_userInput_ch6||)+7,#0 ; [CPU_ALU] |241| 
	.dwpsn	file "../bts.c",line 242,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch6||)+8,R3H ; [CPU_FPU] |242| 
	.dwpsn	file "../bts.c",line 243,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch6||),R2H ; [CPU_FPU] |243| 
	.dwpsn	file "../bts.c",line 260,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16256            ; [CPU_FPU] |260| 
	.dwpsn	file "../bts.c",line 244,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch6||)+2,R0H ; [CPU_FPU] |244| 
	.dwpsn	file "../bts.c",line 261,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16492            ; [CPU_FPU] |261| 
        MOVXI     R0H,#52429            ; [CPU_FPU] |261| 
	.dwpsn	file "../bts.c",line 245,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch6||)+4,R1H ; [CPU_FPU] |245| 
        MOVW      DP,#||BTS_userInput_ch7||+6 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 262,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16128            ; [CPU_FPU] |262| 
	.dwpsn	file "../bts.c",line 257,column 5,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_userInput_ch7||)+6,#1,UNC ; [CPU_ALU] |257| 
	.dwpsn	file "../bts.c",line 258,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_userInput_ch7||)+7,#0 ; [CPU_ALU] |258| 
	.dwpsn	file "../bts.c",line 259,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch7||)+8,R3H ; [CPU_FPU] |259| 
	.dwpsn	file "../bts.c",line 260,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch7||),R2H ; [CPU_FPU] |260| 
	.dwpsn	file "../bts.c",line 261,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch7||)+2,R0H ; [CPU_FPU] |261| 
	.dwpsn	file "../bts.c",line 162,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15821            ; [CPU_FPU] |162| 
        MOV32     *-SP[2],R0H           ; [CPU_FPU] |162| 
	.dwpsn	file "../bts.c",line 163,column 5,is_stmt,isa 0
        MOVIZ     R0H,#14724            ; [CPU_FPU] |163| 
        MOV32     *-SP[4],R0H           ; [CPU_FPU] |163| 
	.dwpsn	file "../bts.c",line 164,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16671            ; [CPU_FPU] |164| 
	.dwpsn	file "../bts.c",line 286,column 5,is_stmt,isa 0
        MOVIZ     R3H,#15951            ; [CPU_FPU] |286| 
	.dwpsn	file "../bts.c",line 164,column 5,is_stmt,isa 0
        MOV32     *-SP[6],R0H           ; [CPU_FPU] |164| 
	.dwpsn	file "../bts.c",line 165,column 5,is_stmt,isa 0
        MOVIZ     R0H,#47909            ; [CPU_FPU] |165| 
	.dwpsn	file "../bts.c",line 262,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch7||)+4,R1H ; [CPU_FPU] |262| 
	.dwpsn	file "../bts.c",line 165,column 5,is_stmt,isa 0
        MOV32     *-SP[8],R0H           ; [CPU_FPU] |165| 
	.dwpsn	file "../bts.c",line 167,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15951            ; [CPU_FPU] |167| 
        MOV32     *-SP[10],R0H          ; [CPU_FPU] |167| 
	.dwpsn	file "../bts.c",line 168,column 5,is_stmt,isa 0
        MOVIZ     R0H,#47658            ; [CPU_FPU] |168| 
	.dwpsn	file "../bts.c",line 288,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16542            ; [CPU_FPU] |288| 
	.dwpsn	file "../bts.c",line 168,column 5,is_stmt,isa 0
        MOV32     *-SP[12],R0H          ; [CPU_FPU] |168| 
	.dwpsn	file "../bts.c",line 169,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16541            ; [CPU_FPU] |169| 
        MOV32     *-SP[14],R0H          ; [CPU_FPU] |169| 
	.dwpsn	file "../bts.c",line 170,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15186            ; [CPU_FPU] |170| 
	.dwpsn	file "../bts.c",line 274,column 5,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_userInput_ch8||)+6,#1,UNC ; [CPU_ALU] |274| 
	.dwpsn	file "../bts.c",line 170,column 5,is_stmt,isa 0
        MOV32     *-SP[16],R0H          ; [CPU_FPU] |170| 
	.dwpsn	file "../bts.c",line 179,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |179| 
        MOV32     *-SP[18],R0H          ; [CPU_FPU] |179| 
	.dwpsn	file "../bts.c",line 181,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16672            ; [CPU_FPU] |181| 
        MOV32     *-SP[22],R0H          ; [CPU_FPU] |181| 
	.dwpsn	file "../bts.c",line 182,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45856            ; [CPU_FPU] |182| 
        MOV32     *-SP[24],R0H          ; [CPU_FPU] |182| 
	.dwpsn	file "../bts.c",line 184,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15951            ; [CPU_FPU] |184| 
        MOV32     *-SP[26],R0H          ; [CPU_FPU] |184| 
	.dwpsn	file "../bts.c",line 289,column 5,is_stmt,isa 0
        MOVIZ     R1H,#13214            ; [CPU_FPU] |289| 
	.dwpsn	file "../bts.c",line 186,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16542            ; [CPU_FPU] |186| 
        MOV32     *-SP[30],R0H          ; [CPU_FPU] |186| 
	.dwpsn	file "../bts.c",line 187,column 5,is_stmt,isa 0
        MOVIZ     R0H,#13214            ; [CPU_FPU] |187| 
        MOV32     *-SP[32],R0H          ; [CPU_FPU] |187| 
	.dwpsn	file "../bts.c",line 275,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_userInput_ch8||)+7,#0 ; [CPU_ALU] |275| 
	.dwpsn	file "../bts.c",line 196,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |196| 
        MOV32     *-SP[34],R0H          ; [CPU_FPU] |196| 
	.dwpsn	file "../bts.c",line 198,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16672            ; [CPU_FPU] |198| 
        MOV32     *-SP[38],R0H          ; [CPU_FPU] |198| 
	.dwpsn	file "../bts.c",line 199,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45856            ; [CPU_FPU] |199| 
        MOV32     *-SP[40],R0H          ; [CPU_FPU] |199| 
	.dwpsn	file "../bts.c",line 201,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15951            ; [CPU_FPU] |201| 
        MOV32     *-SP[42],R0H          ; [CPU_FPU] |201| 
	.dwpsn	file "../bts.c",line 203,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16542            ; [CPU_FPU] |203| 
        MOV32     *-SP[46],R0H          ; [CPU_FPU] |203| 
	.dwpsn	file "../bts.c",line 204,column 5,is_stmt,isa 0
        MOVIZ     R0H,#13214            ; [CPU_FPU] |204| 
        MOV32     *-SP[48],R0H          ; [CPU_FPU] |204| 
	.dwpsn	file "../bts.c",line 213,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |213| 
        MOV32     *-SP[50],R0H          ; [CPU_FPU] |213| 
	.dwpsn	file "../bts.c",line 215,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16672            ; [CPU_FPU] |215| 
        MOV32     *-SP[54],R0H          ; [CPU_FPU] |215| 
	.dwpsn	file "../bts.c",line 216,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45856            ; [CPU_FPU] |216| 
        MOV32     *-SP[56],R0H          ; [CPU_FPU] |216| 
	.dwpsn	file "../bts.c",line 218,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15951            ; [CPU_FPU] |218| 
        MOV32     *-SP[58],R0H          ; [CPU_FPU] |218| 
	.dwpsn	file "../bts.c",line 220,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16542            ; [CPU_FPU] |220| 
        MOV32     *-SP[62],R0H          ; [CPU_FPU] |220| 
	.dwpsn	file "../bts.c",line 221,column 5,is_stmt,isa 0
        MOVIZ     R0H,#13214            ; [CPU_FPU] |221| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |221| 
	.dwpsn	file "../bts.c",line 230,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |230| 
        MOVL      XAR0,#64              ; [CPU_ALU] |230| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |230| 
	.dwpsn	file "../bts.c",line 232,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16672            ; [CPU_FPU] |232| 
        MOVL      XAR0,#60              ; [CPU_ALU] |232| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |232| 
	.dwpsn	file "../bts.c",line 233,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45856            ; [CPU_FPU] |233| 
        MOVL      XAR0,#58              ; [CPU_ALU] |233| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |233| 
	.dwpsn	file "../bts.c",line 235,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15951            ; [CPU_FPU] |235| 
        MOVL      XAR0,#56              ; [CPU_ALU] |235| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |235| 
	.dwpsn	file "../bts.c",line 237,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16542            ; [CPU_FPU] |237| 
        MOVL      XAR0,#52              ; [CPU_ALU] |237| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |237| 
	.dwpsn	file "../bts.c",line 238,column 5,is_stmt,isa 0
        MOVIZ     R0H,#13214            ; [CPU_FPU] |238| 
        MOVL      XAR0,#50              ; [CPU_ALU] |238| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |238| 
	.dwpsn	file "../bts.c",line 247,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |247| 
        MOVL      XAR0,#48              ; [CPU_ALU] |247| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |247| 
	.dwpsn	file "../bts.c",line 249,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16672            ; [CPU_FPU] |249| 
        MOVL      XAR0,#44              ; [CPU_ALU] |249| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |249| 
	.dwpsn	file "../bts.c",line 250,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45856            ; [CPU_FPU] |250| 
        MOVL      XAR0,#42              ; [CPU_ALU] |250| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |250| 
	.dwpsn	file "../bts.c",line 252,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15951            ; [CPU_FPU] |252| 
        MOVL      XAR0,#40              ; [CPU_ALU] |252| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |252| 
	.dwpsn	file "../bts.c",line 254,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16542            ; [CPU_FPU] |254| 
        MOVL      XAR0,#36              ; [CPU_ALU] |254| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |254| 
	.dwpsn	file "../bts.c",line 255,column 5,is_stmt,isa 0
        MOVIZ     R0H,#13214            ; [CPU_FPU] |255| 
        MOVL      XAR0,#34              ; [CPU_ALU] |255| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |255| 
	.dwpsn	file "../bts.c",line 264,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15820            ; [CPU_FPU] |264| 
        MOVL      XAR0,#32              ; [CPU_ALU] |264| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |264| 
	.dwpsn	file "../bts.c",line 266,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16672            ; [CPU_FPU] |266| 
        MOVL      XAR0,#28              ; [CPU_ALU] |266| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |266| 
	.dwpsn	file "../bts.c",line 267,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45856            ; [CPU_FPU] |267| 
        MOVL      XAR0,#26              ; [CPU_ALU] |267| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |267| 
	.dwpsn	file "../bts.c",line 269,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15951            ; [CPU_FPU] |269| 
        MOVL      XAR0,#24              ; [CPU_ALU] |269| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |269| 
	.dwpsn	file "../bts.c",line 271,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16542            ; [CPU_FPU] |271| 
        MOVL      XAR0,#20              ; [CPU_ALU] |271| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |271| 
	.dwpsn	file "../bts.c",line 272,column 5,is_stmt,isa 0
        MOVIZ     R0H,#13214            ; [CPU_FPU] |272| 
        MOVL      XAR0,#18              ; [CPU_ALU] |272| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |272| 
	.dwpsn	file "../bts.c",line 277,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16256            ; [CPU_FPU] |277| 
        MOVL      XAR0,#16              ; [CPU_ALU] |277| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |277| 
	.dwpsn	file "../bts.c",line 276,column 5,is_stmt,isa 0
        ZERO      R0H                   ; [CPU_FPU] |276| 
	.dwpsn	file "../bts.c",line 231,column 5,is_stmt,isa 0
        MOVL      XAR0,#62              ; [CPU_ALU] |231| 
	.dwpsn	file "../bts.c",line 276,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch8||)+8,R0H ; [CPU_FPU] |276| 
	.dwpsn	file "../bts.c",line 180,column 5,is_stmt,isa 0
        MOVIZ     R0H,#12672            ; [CPU_FPU] |180| 
        MOV32     *-SP[20],R0H          ; [CPU_FPU] |180| 
	.dwpsn	file "../bts.c",line 185,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45696            ; [CPU_FPU] |185| 
        MOV32     *-SP[28],R0H          ; [CPU_FPU] |185| 
	.dwpsn	file "../bts.c",line 197,column 5,is_stmt,isa 0
        MOVIZ     R0H,#12672            ; [CPU_FPU] |197| 
        MOV32     *-SP[36],R0H          ; [CPU_FPU] |197| 
	.dwpsn	file "../bts.c",line 202,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45696            ; [CPU_FPU] |202| 
        MOV32     *-SP[44],R0H          ; [CPU_FPU] |202| 
	.dwpsn	file "../bts.c",line 214,column 5,is_stmt,isa 0
        MOVIZ     R0H,#12672            ; [CPU_FPU] |214| 
        MOV32     *-SP[52],R0H          ; [CPU_FPU] |214| 
	.dwpsn	file "../bts.c",line 219,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45696            ; [CPU_FPU] |219| 
        MOV32     *-SP[60],R0H          ; [CPU_FPU] |219| 
	.dwpsn	file "../bts.c",line 231,column 5,is_stmt,isa 0
        MOVIZ     R0H,#12672            ; [CPU_FPU] |231| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |231| 
	.dwpsn	file "../bts.c",line 236,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45696            ; [CPU_FPU] |236| 
        MOVL      XAR0,#54              ; [CPU_ALU] |236| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |236| 
	.dwpsn	file "../bts.c",line 248,column 5,is_stmt,isa 0
        MOVIZ     R0H,#12672            ; [CPU_FPU] |248| 
        MOVL      XAR0,#46              ; [CPU_ALU] |248| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |248| 
	.dwpsn	file "../bts.c",line 253,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45696            ; [CPU_FPU] |253| 
        MOVL      XAR0,#38              ; [CPU_ALU] |253| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |253| 
	.dwpsn	file "../bts.c",line 265,column 5,is_stmt,isa 0
        MOVIZ     R0H,#12672            ; [CPU_FPU] |265| 
        MOVL      XAR0,#30              ; [CPU_ALU] |265| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |265| 
	.dwpsn	file "../bts.c",line 270,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45696            ; [CPU_FPU] |270| 
        MOVL      XAR0,#22              ; [CPU_ALU] |270| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |270| 
	.dwpsn	file "../bts.c",line 282,column 5,is_stmt,isa 0
        MOVIZ     R0H,#12672            ; [CPU_FPU] |282| 
        MOVL      XAR0,#14              ; [CPU_ALU] |282| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |282| 
	.dwpsn	file "../bts.c",line 287,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45696            ; [CPU_FPU] |287| 
        MOVL      XAR0,#12              ; [CPU_ALU] |287| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |287| 
        MOV32     R0H,*-SP[2]           ; [CPU_FPU] |287| 
	.dwpsn	file "../bts.c",line 162,column 5,is_stmt,isa 0
        MOVXI     R0H,#29226            ; [CPU_FPU] |162| 
        MOV32     *-SP[2],R0H           ; [CPU_FPU] |162| 
        MOV32     R0H,*-SP[4]           ; [CPU_FPU] |162| 
	.dwpsn	file "../bts.c",line 220,column 5,is_stmt,isa 0
        MOVL      XAR0,#66              ; [CPU_ALU] |220| 
	.dwpsn	file "../bts.c",line 163,column 5,is_stmt,isa 0
        MOVXI     R0H,#28160            ; [CPU_FPU] |163| 
        MOV32     *-SP[4],R0H           ; [CPU_FPU] |163| 
        MOV32     R0H,*-SP[6]           ; [CPU_FPU] |163| 
	.dwpsn	file "../bts.c",line 164,column 5,is_stmt,isa 0
        MOVXI     R0H,#32567            ; [CPU_FPU] |164| 
        MOV32     *-SP[6],R0H           ; [CPU_FPU] |164| 
        MOV32     R0H,*-SP[8]           ; [CPU_FPU] |164| 
	.dwpsn	file "../bts.c",line 165,column 5,is_stmt,isa 0
        MOVXI     R0H,#1090             ; [CPU_FPU] |165| 
        MOV32     *-SP[8],R0H           ; [CPU_FPU] |165| 
        MOV32     R0H,*-SP[10]          ; [CPU_FPU] |165| 
	.dwpsn	file "../bts.c",line 167,column 5,is_stmt,isa 0
        MOVXI     R0H,#63120            ; [CPU_FPU] |167| 
        MOV32     *-SP[10],R0H          ; [CPU_FPU] |167| 
        MOV32     R0H,*-SP[12]          ; [CPU_FPU] |167| 
	.dwpsn	file "../bts.c",line 168,column 5,is_stmt,isa 0
        MOVXI     R0H,#44544            ; [CPU_FPU] |168| 
        MOV32     *-SP[12],R0H          ; [CPU_FPU] |168| 
        MOV32     R0H,*-SP[14]          ; [CPU_FPU] |168| 
	.dwpsn	file "../bts.c",line 169,column 5,is_stmt,isa 0
        MOVXI     R0H,#37119            ; [CPU_FPU] |169| 
        MOV32     *-SP[14],R0H          ; [CPU_FPU] |169| 
        MOV32     R0H,*-SP[16]          ; [CPU_FPU] |169| 
	.dwpsn	file "../bts.c",line 170,column 5,is_stmt,isa 0
        MOVXI     R0H,#6852             ; [CPU_FPU] |170| 
        MOV32     *-SP[16],R0H          ; [CPU_FPU] |170| 
        MOV32     R0H,*-SP[18]          ; [CPU_FPU] |170| 
	.dwpsn	file "../bts.c",line 179,column 5,is_stmt,isa 0
        MOVXI     R0H,#16513            ; [CPU_FPU] |179| 
        MOV32     *-SP[18],R0H          ; [CPU_FPU] |179| 
        MOV32     R0H,*-SP[22]          ; [CPU_FPU] |179| 
	.dwpsn	file "../bts.c",line 181,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |181| 
        MOV32     *-SP[22],R0H          ; [CPU_FPU] |181| 
        MOV32     R0H,*-SP[24]          ; [CPU_FPU] |181| 
	.dwpsn	file "../bts.c",line 182,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |182| 
        MOV32     *-SP[24],R0H          ; [CPU_FPU] |182| 
        MOV32     R0H,*-SP[26]          ; [CPU_FPU] |182| 
	.dwpsn	file "../bts.c",line 184,column 5,is_stmt,isa 0
        MOVXI     R0H,#11968            ; [CPU_FPU] |184| 
        MOV32     *-SP[26],R0H          ; [CPU_FPU] |184| 
        MOV32     R0H,*-SP[30]          ; [CPU_FPU] |184| 
	.dwpsn	file "../bts.c",line 186,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |186| 
        MOV32     *-SP[30],R0H          ; [CPU_FPU] |186| 
        MOV32     R0H,*-SP[32]          ; [CPU_FPU] |186| 
	.dwpsn	file "../bts.c",line 187,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |187| 
        MOV32     *-SP[32],R0H          ; [CPU_FPU] |187| 
        MOV32     R0H,*-SP[34]          ; [CPU_FPU] |187| 
	.dwpsn	file "../bts.c",line 196,column 5,is_stmt,isa 0
        MOVXI     R0H,#16513            ; [CPU_FPU] |196| 
        MOV32     *-SP[34],R0H          ; [CPU_FPU] |196| 
        MOV32     R0H,*-SP[38]          ; [CPU_FPU] |196| 
	.dwpsn	file "../bts.c",line 198,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |198| 
        MOV32     *-SP[38],R0H          ; [CPU_FPU] |198| 
        MOV32     R0H,*-SP[40]          ; [CPU_FPU] |198| 
	.dwpsn	file "../bts.c",line 199,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |199| 
        MOV32     *-SP[40],R0H          ; [CPU_FPU] |199| 
        MOV32     R0H,*-SP[42]          ; [CPU_FPU] |199| 
	.dwpsn	file "../bts.c",line 201,column 5,is_stmt,isa 0
        MOVXI     R0H,#11968            ; [CPU_FPU] |201| 
        MOV32     *-SP[42],R0H          ; [CPU_FPU] |201| 
        MOV32     R0H,*-SP[46]          ; [CPU_FPU] |201| 
	.dwpsn	file "../bts.c",line 203,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |203| 
        MOV32     *-SP[46],R0H          ; [CPU_FPU] |203| 
        MOV32     R0H,*-SP[48]          ; [CPU_FPU] |203| 
	.dwpsn	file "../bts.c",line 204,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |204| 
        MOV32     *-SP[48],R0H          ; [CPU_FPU] |204| 
        MOV32     R0H,*-SP[50]          ; [CPU_FPU] |204| 
	.dwpsn	file "../bts.c",line 213,column 5,is_stmt,isa 0
        MOVXI     R0H,#16513            ; [CPU_FPU] |213| 
        MOV32     *-SP[50],R0H          ; [CPU_FPU] |213| 
        MOV32     R0H,*-SP[54]          ; [CPU_FPU] |213| 
	.dwpsn	file "../bts.c",line 215,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |215| 
        MOV32     *-SP[54],R0H          ; [CPU_FPU] |215| 
        MOV32     R0H,*-SP[56]          ; [CPU_FPU] |215| 
	.dwpsn	file "../bts.c",line 216,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |216| 
        MOV32     *-SP[56],R0H          ; [CPU_FPU] |216| 
        MOV32     R0H,*-SP[58]          ; [CPU_FPU] |216| 
	.dwpsn	file "../bts.c",line 218,column 5,is_stmt,isa 0
        MOVXI     R0H,#11968            ; [CPU_FPU] |218| 
        MOV32     *-SP[58],R0H          ; [CPU_FPU] |218| 
        MOV32     R0H,*-SP[62]          ; [CPU_FPU] |218| 
	.dwpsn	file "../bts.c",line 220,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |220| 
        MOV32     *-SP[62],R0H          ; [CPU_FPU] |220| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |220| 
	.dwpsn	file "../bts.c",line 221,column 5,is_stmt,isa 0
        MOVL      XAR0,#66              ; [CPU_ALU] |221| 
        MOVXI     R0H,#10485            ; [CPU_FPU] |221| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |221| 
        MOVL      XAR0,#64              ; [CPU_ALU] |221| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |221| 
	.dwpsn	file "../bts.c",line 230,column 5,is_stmt,isa 0
        MOVL      XAR0,#64              ; [CPU_ALU] |230| 
        MOVXI     R0H,#16513            ; [CPU_FPU] |230| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |230| 
        MOVL      XAR0,#60              ; [CPU_ALU] |230| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |230| 
	.dwpsn	file "../bts.c",line 232,column 5,is_stmt,isa 0
        MOVL      XAR0,#60              ; [CPU_ALU] |232| 
        MOVXI     R0H,#28135            ; [CPU_FPU] |232| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |232| 
        MOVL      XAR0,#58              ; [CPU_ALU] |232| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |232| 
	.dwpsn	file "../bts.c",line 233,column 5,is_stmt,isa 0
        MOVL      XAR0,#58              ; [CPU_ALU] |233| 
        MOVXI     R0H,#28135            ; [CPU_FPU] |233| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |233| 
        MOVL      XAR0,#56              ; [CPU_ALU] |233| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |233| 
	.dwpsn	file "../bts.c",line 235,column 5,is_stmt,isa 0
        MOVL      XAR0,#56              ; [CPU_ALU] |235| 
        MOVXI     R0H,#11968            ; [CPU_FPU] |235| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |235| 
        MOVL      XAR0,#52              ; [CPU_ALU] |235| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |235| 
	.dwpsn	file "../bts.c",line 237,column 5,is_stmt,isa 0
        MOVL      XAR0,#52              ; [CPU_ALU] |237| 
        MOVXI     R0H,#10485            ; [CPU_FPU] |237| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |237| 
        MOVL      XAR0,#50              ; [CPU_ALU] |237| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |237| 
	.dwpsn	file "../bts.c",line 238,column 5,is_stmt,isa 0
        MOVL      XAR0,#50              ; [CPU_ALU] |238| 
        MOVXI     R0H,#10485            ; [CPU_FPU] |238| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |238| 
        MOVL      XAR0,#48              ; [CPU_ALU] |238| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |238| 
	.dwpsn	file "../bts.c",line 247,column 5,is_stmt,isa 0
        MOVL      XAR0,#48              ; [CPU_ALU] |247| 
        MOVXI     R0H,#16513            ; [CPU_FPU] |247| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |247| 
        MOVL      XAR0,#44              ; [CPU_ALU] |247| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |247| 
	.dwpsn	file "../bts.c",line 249,column 5,is_stmt,isa 0
        MOVL      XAR0,#44              ; [CPU_ALU] |249| 
        MOVXI     R0H,#28135            ; [CPU_FPU] |249| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |249| 
        MOVL      XAR0,#42              ; [CPU_ALU] |249| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |249| 
	.dwpsn	file "../bts.c",line 250,column 5,is_stmt,isa 0
        MOVL      XAR0,#42              ; [CPU_ALU] |250| 
        MOVXI     R0H,#28135            ; [CPU_FPU] |250| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |250| 
	.dwpsn	file "../bts.c",line 278,column 5,is_stmt,isa 0
        MOVXI     R7H,#52429            ; [CPU_FPU] |278| 
	.dwpsn	file "../bts.c",line 281,column 5,is_stmt,isa 0
        MOVXI     R6H,#16513            ; [CPU_FPU] |281| 
	.dwpsn	file "../bts.c",line 283,column 5,is_stmt,isa 0
        MOVXI     R5H,#28135            ; [CPU_FPU] |283| 
	.dwpsn	file "../bts.c",line 284,column 5,is_stmt,isa 0
        MOVXI     R4H,#28135            ; [CPU_FPU] |284| 
	.dwpsn	file "../bts.c",line 286,column 5,is_stmt,isa 0
        MOVXI     R3H,#11968            ; [CPU_FPU] |286| 
	.dwpsn	file "../bts.c",line 250,column 5,is_stmt,isa 0
        MOVL      XAR0,#40              ; [CPU_ALU] |250| 
	.dwpsn	file "../bts.c",line 288,column 5,is_stmt,isa 0
        MOVXI     R2H,#10485            ; [CPU_FPU] |288| 
	.dwpsn	file "../bts.c",line 289,column 5,is_stmt,isa 0
        MOVXI     R1H,#10485            ; [CPU_FPU] |289| 
	.dwpsn	file "../bts.c",line 250,column 5,is_stmt,isa 0
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |250| 
	.dwpsn	file "../bts.c",line 252,column 5,is_stmt,isa 0
        MOVL      XAR0,#40              ; [CPU_ALU] |252| 
        MOVXI     R0H,#11968            ; [CPU_FPU] |252| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |252| 
        MOVL      XAR0,#36              ; [CPU_ALU] |252| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |252| 
	.dwpsn	file "../bts.c",line 254,column 5,is_stmt,isa 0
        MOVL      XAR0,#36              ; [CPU_ALU] |254| 
        MOVXI     R0H,#10485            ; [CPU_FPU] |254| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |254| 
        MOVL      XAR0,#34              ; [CPU_ALU] |254| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |254| 
	.dwpsn	file "../bts.c",line 255,column 5,is_stmt,isa 0
        MOVL      XAR0,#34              ; [CPU_ALU] |255| 
        MOVXI     R0H,#10485            ; [CPU_FPU] |255| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |255| 
        MOVL      XAR0,#32              ; [CPU_ALU] |255| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |255| 
	.dwpsn	file "../bts.c",line 264,column 5,is_stmt,isa 0
        MOVL      XAR0,#32              ; [CPU_ALU] |264| 
        MOVXI     R0H,#16513            ; [CPU_FPU] |264| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |264| 
        MOVL      XAR0,#28              ; [CPU_ALU] |264| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |264| 
	.dwpsn	file "../bts.c",line 266,column 5,is_stmt,isa 0
        MOVL      XAR0,#28              ; [CPU_ALU] |266| 
        MOVXI     R0H,#28135            ; [CPU_FPU] |266| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |266| 
        MOVL      XAR0,#26              ; [CPU_ALU] |266| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |266| 
	.dwpsn	file "../bts.c",line 267,column 5,is_stmt,isa 0
        MOVL      XAR0,#26              ; [CPU_ALU] |267| 
        MOVXI     R0H,#28135            ; [CPU_FPU] |267| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |267| 
        MOVL      XAR0,#24              ; [CPU_ALU] |267| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |267| 
	.dwpsn	file "../bts.c",line 269,column 5,is_stmt,isa 0
        MOVL      XAR0,#24              ; [CPU_ALU] |269| 
        MOVXI     R0H,#11968            ; [CPU_FPU] |269| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |269| 
        MOVL      XAR0,#20              ; [CPU_ALU] |269| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |269| 
	.dwpsn	file "../bts.c",line 271,column 5,is_stmt,isa 0
        MOVL      XAR0,#20              ; [CPU_ALU] |271| 
        MOVXI     R0H,#10485            ; [CPU_FPU] |271| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |271| 
        MOVL      XAR0,#18              ; [CPU_ALU] |271| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |271| 
	.dwpsn	file "../bts.c",line 272,column 5,is_stmt,isa 0
        MOVL      XAR0,#18              ; [CPU_ALU] |272| 
        MOVXI     R0H,#10485            ; [CPU_FPU] |272| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |272| 
	.dwpsn	file "../bts.c",line 278,column 5,is_stmt,isa 0
        MOVL      XAR0,#16              ; [CPU_ALU] |278| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |278| 
	.dwpsn	file "../bts.c",line 277,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch8||),R0H ; [CPU_FPU] |277| 
	.dwpsn	file "../bts.c",line 279,column 5,is_stmt,isa 0
        MOVL      XAR0,#16              ; [CPU_ALU] |279| 
        MOVW      DP,#||BTS_userInput_ch2||+16 ; [CPU_ARAU] 
        MOVIZ     R0H,#16128            ; [CPU_FPU] |279| 
        MOV32     *+FP[AR0],R0H         ; [CPU_FPU] |279| 
        MOV32     R0H,*-SP[20]          ; [CPU_FPU] |279| 
	.dwpsn	file "../bts.c",line 180,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+16,R0H ; [CPU_FPU] |180| 
	.dwpsn	file "../bts.c",line 219,column 5,is_stmt,isa 0
        MOVL      XAR0,#62              ; [CPU_ALU] |219| 
	.dwpsn	file "../bts.c",line 180,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[28]          ; [CPU_FPU] |180| 
	.dwpsn	file "../bts.c",line 185,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+24,R0H ; [CPU_FPU] |185| 
        MOVW      DP,#||BTS_userInput_ch3||+16 ; [CPU_ARAU] 
        MOV32     R0H,*-SP[36]          ; [CPU_FPU] |185| 
	.dwpsn	file "../bts.c",line 197,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+16,R0H ; [CPU_FPU] |197| 
        MOV32     R0H,*-SP[44]          ; [CPU_FPU] |197| 
	.dwpsn	file "../bts.c",line 202,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+24,R0H ; [CPU_FPU] |202| 
        MOV32     R0H,*-SP[52]          ; [CPU_FPU] |202| 
	.dwpsn	file "../bts.c",line 214,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+16,R0H ; [CPU_FPU] |214| 
        MOV32     R0H,*-SP[60]          ; [CPU_FPU] |214| 
	.dwpsn	file "../bts.c",line 219,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+24,R0H ; [CPU_FPU] |219| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |219| 
        MOVW      DP,#||BTS_userInput_ch5||+16 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 231,column 5,is_stmt,isa 0
        MOVL      XAR0,#54              ; [CPU_ALU] |231| 
        MOV32     @$BLOCKED(||BTS_userInput_ch5||)+16,R0H ; [CPU_FPU] |231| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |231| 
	.dwpsn	file "../bts.c",line 236,column 5,is_stmt,isa 0
        MOVL      XAR0,#46              ; [CPU_ALU] |236| 
        MOV32     @$BLOCKED(||BTS_userInput_ch5||)+24,R0H ; [CPU_FPU] |236| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |236| 
	.dwpsn	file "../bts.c",line 248,column 5,is_stmt,isa 0
        MOVL      XAR0,#38              ; [CPU_ALU] |248| 
        MOV32     @$BLOCKED(||BTS_userInput_ch6||)+16,R0H ; [CPU_FPU] |248| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |248| 
	.dwpsn	file "../bts.c",line 253,column 5,is_stmt,isa 0
        MOVL      XAR0,#30              ; [CPU_ALU] |253| 
        MOV32     @$BLOCKED(||BTS_userInput_ch6||)+24,R0H ; [CPU_FPU] |253| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |253| 
        MOVW      DP,#||BTS_userInput_ch7||+16 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 265,column 5,is_stmt,isa 0
        MOVL      XAR0,#22              ; [CPU_ALU] |265| 
        MOV32     @$BLOCKED(||BTS_userInput_ch7||)+16,R0H ; [CPU_FPU] |265| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |265| 
	.dwpsn	file "../bts.c",line 270,column 5,is_stmt,isa 0
        MOVL      XAR0,#14              ; [CPU_ALU] |270| 
        MOV32     @$BLOCKED(||BTS_userInput_ch7||)+24,R0H ; [CPU_FPU] |270| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |270| 
	.dwpsn	file "../bts.c",line 282,column 5,is_stmt,isa 0
        MOVL      XAR0,#12              ; [CPU_ALU] |282| 
        MOV32     @$BLOCKED(||BTS_userInput_ch8||)+16,R0H ; [CPU_FPU] |282| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |282| 
	.dwpsn	file "../bts.c",line 287,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch8||)+24,R0H ; [CPU_FPU] |287| 
        MOV32     R0H,*-SP[2]           ; [CPU_FPU] |287| 
        MOVW      DP,#||BTS_userInput_ch1||+14 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 162,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+14,R0H ; [CPU_FPU] |162| 
        MOV32     R0H,*-SP[4]           ; [CPU_FPU] |162| 
	.dwpsn	file "../bts.c",line 163,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+16,R0H ; [CPU_FPU] |163| 
        MOV32     R0H,*-SP[6]           ; [CPU_FPU] |163| 
	.dwpsn	file "../bts.c",line 164,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+18,R0H ; [CPU_FPU] |164| 
        MOV32     R0H,*-SP[8]           ; [CPU_FPU] |164| 
	.dwpsn	file "../bts.c",line 220,column 5,is_stmt,isa 0
        MOVL      XAR0,#66              ; [CPU_ALU] |220| 
	.dwpsn	file "../bts.c",line 165,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+20,R0H ; [CPU_FPU] |165| 
        MOV32     R0H,*-SP[10]          ; [CPU_FPU] |165| 
	.dwpsn	file "../bts.c",line 167,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+22,R0H ; [CPU_FPU] |167| 
        MOV32     R0H,*-SP[12]          ; [CPU_FPU] |167| 
	.dwpsn	file "../bts.c",line 168,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+24,R0H ; [CPU_FPU] |168| 
        MOV32     R0H,*-SP[14]          ; [CPU_FPU] |168| 
	.dwpsn	file "../bts.c",line 169,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+26,R0H ; [CPU_FPU] |169| 
        MOV32     R0H,*-SP[16]          ; [CPU_FPU] |169| 
	.dwpsn	file "../bts.c",line 170,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+28,R0H ; [CPU_FPU] |170| 
        MOV32     R0H,*-SP[18]          ; [CPU_FPU] |170| 
	.dwpsn	file "../bts.c",line 179,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+14,R0H ; [CPU_FPU] |179| 
        MOV32     R0H,*-SP[22]          ; [CPU_FPU] |179| 
	.dwpsn	file "../bts.c",line 181,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+18,R0H ; [CPU_FPU] |181| 
        MOV32     R0H,*-SP[24]          ; [CPU_FPU] |181| 
	.dwpsn	file "../bts.c",line 182,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+20,R0H ; [CPU_FPU] |182| 
        MOV32     R0H,*-SP[26]          ; [CPU_FPU] |182| 
	.dwpsn	file "../bts.c",line 184,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+22,R0H ; [CPU_FPU] |184| 
        MOV32     R0H,*-SP[30]          ; [CPU_FPU] |184| 
	.dwpsn	file "../bts.c",line 186,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+26,R0H ; [CPU_FPU] |186| 
        MOV32     R0H,*-SP[32]          ; [CPU_FPU] |186| 
	.dwpsn	file "../bts.c",line 187,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+28,R0H ; [CPU_FPU] |187| 
        MOV32     R0H,*-SP[34]          ; [CPU_FPU] |187| 
        MOVW      DP,#||BTS_userInput_ch3||+14 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 196,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+14,R0H ; [CPU_FPU] |196| 
        MOV32     R0H,*-SP[38]          ; [CPU_FPU] |196| 
	.dwpsn	file "../bts.c",line 198,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+18,R0H ; [CPU_FPU] |198| 
        MOV32     R0H,*-SP[40]          ; [CPU_FPU] |198| 
	.dwpsn	file "../bts.c",line 199,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+20,R0H ; [CPU_FPU] |199| 
        MOV32     R0H,*-SP[42]          ; [CPU_FPU] |199| 
	.dwpsn	file "../bts.c",line 201,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+22,R0H ; [CPU_FPU] |201| 
        MOV32     R0H,*-SP[46]          ; [CPU_FPU] |201| 
	.dwpsn	file "../bts.c",line 203,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+26,R0H ; [CPU_FPU] |203| 
        MOV32     R0H,*-SP[48]          ; [CPU_FPU] |203| 
	.dwpsn	file "../bts.c",line 204,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+28,R0H ; [CPU_FPU] |204| 
        MOV32     R0H,*-SP[50]          ; [CPU_FPU] |204| 
	.dwpsn	file "../bts.c",line 213,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+14,R0H ; [CPU_FPU] |213| 
        MOV32     R0H,*-SP[54]          ; [CPU_FPU] |213| 
	.dwpsn	file "../bts.c",line 215,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+18,R0H ; [CPU_FPU] |215| 
        MOV32     R0H,*-SP[56]          ; [CPU_FPU] |215| 
	.dwpsn	file "../bts.c",line 216,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+20,R0H ; [CPU_FPU] |216| 
        MOV32     R0H,*-SP[58]          ; [CPU_FPU] |216| 
	.dwpsn	file "../bts.c",line 218,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+22,R0H ; [CPU_FPU] |218| 
        MOV32     R0H,*-SP[62]          ; [CPU_FPU] |218| 
	.dwpsn	file "../bts.c",line 220,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+26,R0H ; [CPU_FPU] |220| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |220| 
	.dwpsn	file "../bts.c",line 221,column 5,is_stmt,isa 0
        MOVL      XAR0,#64              ; [CPU_ALU] |221| 
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+28,R0H ; [CPU_FPU] |221| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |221| 
	.dwpsn	file "../bts.c",line 230,column 5,is_stmt,isa 0
        MOVL      XAR0,#60              ; [CPU_ALU] |230| 
        MOVW      DP,#||BTS_userInput_ch5||+14 ; [CPU_ARAU] 
        MOV32     @$BLOCKED(||BTS_userInput_ch5||)+14,R0H ; [CPU_FPU] |230| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |230| 
	.dwpsn	file "../bts.c",line 232,column 5,is_stmt,isa 0
        MOVL      XAR0,#58              ; [CPU_ALU] |232| 
        MOV32     @$BLOCKED(||BTS_userInput_ch5||)+18,R0H ; [CPU_FPU] |232| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |232| 
	.dwpsn	file "../bts.c",line 233,column 5,is_stmt,isa 0
        MOVL      XAR0,#56              ; [CPU_ALU] |233| 
        MOV32     @$BLOCKED(||BTS_userInput_ch5||)+20,R0H ; [CPU_FPU] |233| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |233| 
	.dwpsn	file "../bts.c",line 235,column 5,is_stmt,isa 0
        MOVL      XAR0,#52              ; [CPU_ALU] |235| 
        MOV32     @$BLOCKED(||BTS_userInput_ch5||)+22,R0H ; [CPU_FPU] |235| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |235| 
	.dwpsn	file "../bts.c",line 237,column 5,is_stmt,isa 0
        MOVL      XAR0,#50              ; [CPU_ALU] |237| 
        MOV32     @$BLOCKED(||BTS_userInput_ch5||)+26,R0H ; [CPU_FPU] |237| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |237| 
	.dwpsn	file "../bts.c",line 238,column 5,is_stmt,isa 0
        MOVL      XAR0,#48              ; [CPU_ALU] |238| 
        MOV32     @$BLOCKED(||BTS_userInput_ch5||)+28,R0H ; [CPU_FPU] |238| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |238| 
	.dwpsn	file "../bts.c",line 247,column 5,is_stmt,isa 0
        MOVL      XAR0,#44              ; [CPU_ALU] |247| 
        MOV32     @$BLOCKED(||BTS_userInput_ch6||)+14,R0H ; [CPU_FPU] |247| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |247| 
	.dwpsn	file "../bts.c",line 249,column 5,is_stmt,isa 0
        MOVL      XAR0,#42              ; [CPU_ALU] |249| 
        MOV32     @$BLOCKED(||BTS_userInput_ch6||)+18,R0H ; [CPU_FPU] |249| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |249| 
	.dwpsn	file "../bts.c",line 250,column 5,is_stmt,isa 0
        MOVL      XAR0,#40              ; [CPU_ALU] |250| 
        MOV32     @$BLOCKED(||BTS_userInput_ch6||)+20,R0H ; [CPU_FPU] |250| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |250| 
	.dwpsn	file "../bts.c",line 252,column 5,is_stmt,isa 0
        MOVL      XAR0,#36              ; [CPU_ALU] |252| 
        MOV32     @$BLOCKED(||BTS_userInput_ch6||)+22,R0H ; [CPU_FPU] |252| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |252| 
	.dwpsn	file "../bts.c",line 254,column 5,is_stmt,isa 0
        MOVL      XAR0,#34              ; [CPU_ALU] |254| 
        MOV32     @$BLOCKED(||BTS_userInput_ch6||)+26,R0H ; [CPU_FPU] |254| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |254| 
	.dwpsn	file "../bts.c",line 255,column 5,is_stmt,isa 0
        MOVL      XAR0,#32              ; [CPU_ALU] |255| 
        MOV32     @$BLOCKED(||BTS_userInput_ch6||)+28,R0H ; [CPU_FPU] |255| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |255| 
	.dwpsn	file "../bts.c",line 264,column 5,is_stmt,isa 0
        MOVL      XAR0,#28              ; [CPU_ALU] |264| 
        MOVW      DP,#||BTS_userInput_ch7||+14 ; [CPU_ARAU] 
        MOV32     @$BLOCKED(||BTS_userInput_ch7||)+14,R0H ; [CPU_FPU] |264| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |264| 
	.dwpsn	file "../bts.c",line 266,column 5,is_stmt,isa 0
        MOVL      XAR0,#26              ; [CPU_ALU] |266| 
        MOV32     @$BLOCKED(||BTS_userInput_ch7||)+18,R0H ; [CPU_FPU] |266| 
	.dwpsn	file "../bts.c",line 278,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch8||)+2,R7H ; [CPU_FPU] |278| 
	.dwpsn	file "../bts.c",line 281,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch8||)+14,R6H ; [CPU_FPU] |281| 
	.dwpsn	file "../bts.c",line 283,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch8||)+18,R5H ; [CPU_FPU] |283| 
	.dwpsn	file "../bts.c",line 284,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch8||)+20,R4H ; [CPU_FPU] |284| 
	.dwpsn	file "../bts.c",line 286,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch8||)+22,R3H ; [CPU_FPU] |286| 
	.dwpsn	file "../bts.c",line 288,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch8||)+26,R2H ; [CPU_FPU] |288| 
	.dwpsn	file "../bts.c",line 289,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch8||)+28,R1H ; [CPU_FPU] |289| 
	.dwpsn	file "../bts.c",line 266,column 5,is_stmt,isa 0
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |266| 
	.dwpsn	file "../bts.c",line 267,column 5,is_stmt,isa 0
        MOVL      XAR0,#24              ; [CPU_ALU] |267| 
        MOV32     @$BLOCKED(||BTS_userInput_ch7||)+20,R0H ; [CPU_FPU] |267| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |267| 
	.dwpsn	file "../bts.c",line 269,column 5,is_stmt,isa 0
        MOVL      XAR0,#20              ; [CPU_ALU] |269| 
        MOV32     @$BLOCKED(||BTS_userInput_ch7||)+22,R0H ; [CPU_FPU] |269| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |269| 
	.dwpsn	file "../bts.c",line 271,column 5,is_stmt,isa 0
        MOVL      XAR0,#18              ; [CPU_ALU] |271| 
        MOV32     @$BLOCKED(||BTS_userInput_ch7||)+26,R0H ; [CPU_FPU] |271| 
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |271| 
	.dwpsn	file "../bts.c",line 278,column 5,is_stmt,isa 0
        MOVL      XAR0,#16              ; [CPU_ALU] |278| 
	.dwpsn	file "../bts.c",line 272,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch7||)+28,R0H ; [CPU_FPU] |272| 
	.dwpsn	file "../bts.c",line 278,column 5,is_stmt,isa 0
        MOV32     R0H,*+FP[AR0]         ; [CPU_FPU] |278| 
	.dwpsn	file "../bts.c",line 279,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch8||)+4,R0H ; [CPU_FPU] |279| 
        SUBB      SP,#118               ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -12
        MOV32     R7H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -10
	.dwcfi	restore_reg, 71
        MOV32     R6H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -8
	.dwcfi	restore_reg, 67
        MOV32     R5H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -6
	.dwcfi	restore_reg, 63
        MOV32     R4H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 59
        MOVL      XAR2,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 9
$C$DW$291	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$291, DW_AT_low_pc(0x00)
	.dwattr $C$DW$291, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$290, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$290, DW_AT_TI_end_line(0x123)
	.dwattr $C$DW$290, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$290

	.sect	".text"
	.clink
	.global	||BTS_initProgramVariables||

$C$DW$292	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$292, DW_AT_name("BTS_initProgramVariables")
	.dwattr $C$DW$292, DW_AT_low_pc(||BTS_initProgramVariables||)
	.dwattr $C$DW$292, DW_AT_high_pc(0x00)
	.dwattr $C$DW$292, DW_AT_linkage_name("BTS_initProgramVariables")
	.dwattr $C$DW$292, DW_AT_external
	.dwattr $C$DW$292, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$292, DW_AT_decl_line(0x125)
	.dwattr $C$DW$292, DW_AT_decl_column(0x06)
	.dwattr $C$DW$292, DW_AT_TI_max_frame_size(-60)
	.dwpsn	file "../bts.c",line 293,column 36,is_stmt,address ||BTS_initProgramVariables||,isa 0

	.dwfde $C$DW$CIE, ||BTS_initProgramVariables||

;***************************************************************
;* FNAME: BTS_initProgramVariables      FR SIZE:  58           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter, 50 Auto,  8 SOE     *
;***************************************************************

||BTS_initProgramVariables||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOV32     *SP++,R4H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 59, 2
	.dwcfi	cfa_offset, -4
        MOV32     *SP++,R5H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 63, 4
	.dwcfi	cfa_offset, -6
        MOV32     *SP++,R6H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 67, 6
	.dwcfi	cfa_offset, -8
        MOV32     *SP++,R7H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 71, 8
	.dwcfi	cfa_offset, -10
        ADDB      SP,#50                ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -60
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1||+32 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 319,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16671            ; [CPU_FPU] |319| 
	.dwpsn	file "../bts.c",line 295,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+32,#26305 ; [CPU_ALU] |295| 
	.dwpsn	file "../bts.c",line 296,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+33,#-26305 ; [CPU_ALU] |296| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2||+32 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 298,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+32,#26305 ; [CPU_ALU] |298| 
	.dwpsn	file "../bts.c",line 299,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+33,#-26305 ; [CPU_ALU] |299| 
	.dwpsn	file "../bts.c",line 319,column 5,is_stmt,isa 0
        MOV32     *-SP[2],R0H           ; [CPU_FPU] |319| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3||+32 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 301,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+32,#26305 ; [CPU_ALU] |301| 
	.dwpsn	file "../bts.c",line 302,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+33,#-26305 ; [CPU_ALU] |302| 
	.dwpsn	file "../bts.c",line 320,column 5,is_stmt,isa 0
        MOVIZ     R0H,#47909            ; [CPU_FPU] |320| 
	.dwpsn	file "../bts.c",line 350,column 5,is_stmt,isa 0
        MOVIZ     R7H,#45856            ; [CPU_FPU] |350| 
	.dwpsn	file "../bts.c",line 351,column 5,is_stmt,isa 0
        MOVIZ     R6H,#16542            ; [CPU_FPU] |351| 
	.dwpsn	file "../bts.c",line 352,column 5,is_stmt,isa 0
        MOVIZ     R5H,#13214            ; [CPU_FPU] |352| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4||+32 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 354,column 5,is_stmt,isa 0
        MOVIZ     R4H,#16672            ; [CPU_FPU] |354| 
	.dwpsn	file "../bts.c",line 355,column 5,is_stmt,isa 0
        MOVIZ     R3H,#45856            ; [CPU_FPU] |355| 
	.dwpsn	file "../bts.c",line 356,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16542            ; [CPU_FPU] |356| 
	.dwpsn	file "../bts.c",line 357,column 5,is_stmt,isa 0
        MOVIZ     R1H,#13214            ; [CPU_FPU] |357| 
	.dwpsn	file "../bts.c",line 304,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+32,#26305 ; [CPU_ALU] |304| 
	.dwpsn	file "../bts.c",line 305,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+33,#-26305 ; [CPU_ALU] |305| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch5||+32 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 320,column 5,is_stmt,isa 0
        MOV32     *-SP[4],R0H           ; [CPU_FPU] |320| 
	.dwpsn	file "../bts.c",line 307,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch5||)+32,#26305 ; [CPU_ALU] |307| 
	.dwpsn	file "../bts.c",line 308,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch5||)+33,#-26305 ; [CPU_ALU] |308| 
	.dwpsn	file "../bts.c",line 321,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16541            ; [CPU_FPU] |321| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch6||+32 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 310,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch6||)+32,#26305 ; [CPU_ALU] |310| 
	.dwpsn	file "../bts.c",line 311,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch6||)+33,#-26305 ; [CPU_ALU] |311| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch7||+32 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 321,column 5,is_stmt,isa 0
        MOV32     *-SP[6],R0H           ; [CPU_FPU] |321| 
	.dwpsn	file "../bts.c",line 313,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch7||)+32,#26305 ; [CPU_ALU] |313| 
	.dwpsn	file "../bts.c",line 314,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch7||)+33,#-26305 ; [CPU_ALU] |314| 
	.dwpsn	file "../bts.c",line 322,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15186            ; [CPU_FPU] |322| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch8||+32 ; [CPU_ARAU] 
        MOV32     *-SP[8],R0H           ; [CPU_FPU] |322| 
	.dwpsn	file "../bts.c",line 316,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch8||)+32,#26305 ; [CPU_ALU] |316| 
	.dwpsn	file "../bts.c",line 317,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch8||)+33,#-26305 ; [CPU_ALU] |317| 
	.dwpsn	file "../bts.c",line 324,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16672            ; [CPU_FPU] |324| 
        MOV32     *-SP[10],R0H          ; [CPU_FPU] |324| 
	.dwpsn	file "../bts.c",line 325,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45856            ; [CPU_FPU] |325| 
        MOV32     *-SP[12],R0H          ; [CPU_FPU] |325| 
	.dwpsn	file "../bts.c",line 326,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16542            ; [CPU_FPU] |326| 
        MOV32     *-SP[14],R0H          ; [CPU_FPU] |326| 
	.dwpsn	file "../bts.c",line 327,column 5,is_stmt,isa 0
        MOVIZ     R0H,#13214            ; [CPU_FPU] |327| 
	.dwpsn	file "../bts.c",line 350,column 5,is_stmt,isa 0
        MOVXI     R7H,#28135            ; [CPU_FPU] |350| 
	.dwpsn	file "../bts.c",line 351,column 5,is_stmt,isa 0
        MOVXI     R6H,#10485            ; [CPU_FPU] |351| 
	.dwpsn	file "../bts.c",line 327,column 5,is_stmt,isa 0
        MOV32     *-SP[16],R0H          ; [CPU_FPU] |327| 
	.dwpsn	file "../bts.c",line 352,column 5,is_stmt,isa 0
        MOVXI     R5H,#10485            ; [CPU_FPU] |352| 
	.dwpsn	file "../bts.c",line 354,column 5,is_stmt,isa 0
        MOVXI     R4H,#28135            ; [CPU_FPU] |354| 
	.dwpsn	file "../bts.c",line 355,column 5,is_stmt,isa 0
        MOVXI     R3H,#28135            ; [CPU_FPU] |355| 
	.dwpsn	file "../bts.c",line 356,column 5,is_stmt,isa 0
        MOVXI     R2H,#10485            ; [CPU_FPU] |356| 
	.dwpsn	file "../bts.c",line 357,column 5,is_stmt,isa 0
        MOVXI     R1H,#10485            ; [CPU_FPU] |357| 
	.dwpsn	file "../bts.c",line 329,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16672            ; [CPU_FPU] |329| 
        MOVW      DP,#||BTS_measValues_ch1||+74 ; [CPU_ARAU] 
        MOV32     *-SP[18],R0H          ; [CPU_FPU] |329| 
	.dwpsn	file "../bts.c",line 330,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45856            ; [CPU_FPU] |330| 
        MOV32     *-SP[20],R0H          ; [CPU_FPU] |330| 
	.dwpsn	file "../bts.c",line 331,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16542            ; [CPU_FPU] |331| 
        MOV32     *-SP[22],R0H          ; [CPU_FPU] |331| 
	.dwpsn	file "../bts.c",line 332,column 5,is_stmt,isa 0
        MOVIZ     R0H,#13214            ; [CPU_FPU] |332| 
        MOV32     *-SP[24],R0H          ; [CPU_FPU] |332| 
	.dwpsn	file "../bts.c",line 334,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16672            ; [CPU_FPU] |334| 
        MOV32     *-SP[26],R0H          ; [CPU_FPU] |334| 
	.dwpsn	file "../bts.c",line 335,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45856            ; [CPU_FPU] |335| 
        MOV32     *-SP[28],R0H          ; [CPU_FPU] |335| 
	.dwpsn	file "../bts.c",line 336,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16542            ; [CPU_FPU] |336| 
        MOV32     *-SP[30],R0H          ; [CPU_FPU] |336| 
	.dwpsn	file "../bts.c",line 337,column 5,is_stmt,isa 0
        MOVIZ     R0H,#13214            ; [CPU_FPU] |337| 
        MOV32     *-SP[32],R0H          ; [CPU_FPU] |337| 
	.dwpsn	file "../bts.c",line 339,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16672            ; [CPU_FPU] |339| 
        MOV32     *-SP[34],R0H          ; [CPU_FPU] |339| 
	.dwpsn	file "../bts.c",line 340,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45856            ; [CPU_FPU] |340| 
        MOV32     *-SP[36],R0H          ; [CPU_FPU] |340| 
	.dwpsn	file "../bts.c",line 341,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16542            ; [CPU_FPU] |341| 
        MOV32     *-SP[38],R0H          ; [CPU_FPU] |341| 
	.dwpsn	file "../bts.c",line 342,column 5,is_stmt,isa 0
        MOVIZ     R0H,#13214            ; [CPU_FPU] |342| 
        MOV32     *-SP[40],R0H          ; [CPU_FPU] |342| 
	.dwpsn	file "../bts.c",line 344,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16672            ; [CPU_FPU] |344| 
        MOV32     *-SP[42],R0H          ; [CPU_FPU] |344| 
	.dwpsn	file "../bts.c",line 345,column 5,is_stmt,isa 0
        MOVIZ     R0H,#45856            ; [CPU_FPU] |345| 
        MOV32     *-SP[44],R0H          ; [CPU_FPU] |345| 
	.dwpsn	file "../bts.c",line 346,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16542            ; [CPU_FPU] |346| 
        MOV32     *-SP[46],R0H          ; [CPU_FPU] |346| 
	.dwpsn	file "../bts.c",line 347,column 5,is_stmt,isa 0
        MOVIZ     R0H,#13214            ; [CPU_FPU] |347| 
        MOV32     *-SP[48],R0H          ; [CPU_FPU] |347| 
	.dwpsn	file "../bts.c",line 349,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16672            ; [CPU_FPU] |349| 
        MOV32     *-SP[50],R0H          ; [CPU_FPU] |349| 
	.dwpsn	file "../bts.c",line 357,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[2]           ; [CPU_FPU] |357| 
	.dwpsn	file "../bts.c",line 319,column 5,is_stmt,isa 0
        MOVXI     R0H,#32567            ; [CPU_FPU] |319| 
        MOV32     *-SP[2],R0H           ; [CPU_FPU] |319| 
        MOV32     R0H,*-SP[4]           ; [CPU_FPU] |319| 
	.dwpsn	file "../bts.c",line 320,column 5,is_stmt,isa 0
        MOVXI     R0H,#1090             ; [CPU_FPU] |320| 
        MOV32     *-SP[4],R0H           ; [CPU_FPU] |320| 
        MOV32     R0H,*-SP[6]           ; [CPU_FPU] |320| 
	.dwpsn	file "../bts.c",line 321,column 5,is_stmt,isa 0
        MOVXI     R0H,#37119            ; [CPU_FPU] |321| 
        MOV32     *-SP[6],R0H           ; [CPU_FPU] |321| 
        MOV32     R0H,*-SP[8]           ; [CPU_FPU] |321| 
	.dwpsn	file "../bts.c",line 322,column 5,is_stmt,isa 0
        MOVXI     R0H,#6852             ; [CPU_FPU] |322| 
        MOV32     *-SP[8],R0H           ; [CPU_FPU] |322| 
        MOV32     R0H,*-SP[10]          ; [CPU_FPU] |322| 
	.dwpsn	file "../bts.c",line 324,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |324| 
        MOV32     *-SP[10],R0H          ; [CPU_FPU] |324| 
        MOV32     R0H,*-SP[12]          ; [CPU_FPU] |324| 
	.dwpsn	file "../bts.c",line 325,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |325| 
        MOV32     *-SP[12],R0H          ; [CPU_FPU] |325| 
        MOV32     R0H,*-SP[14]          ; [CPU_FPU] |325| 
	.dwpsn	file "../bts.c",line 326,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |326| 
        MOV32     *-SP[14],R0H          ; [CPU_FPU] |326| 
        MOV32     R0H,*-SP[16]          ; [CPU_FPU] |326| 
	.dwpsn	file "../bts.c",line 327,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |327| 
        MOV32     *-SP[16],R0H          ; [CPU_FPU] |327| 
        MOV32     R0H,*-SP[18]          ; [CPU_FPU] |327| 
	.dwpsn	file "../bts.c",line 329,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |329| 
        MOV32     *-SP[18],R0H          ; [CPU_FPU] |329| 
        MOV32     R0H,*-SP[20]          ; [CPU_FPU] |329| 
	.dwpsn	file "../bts.c",line 330,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |330| 
        MOV32     *-SP[20],R0H          ; [CPU_FPU] |330| 
        MOV32     R0H,*-SP[22]          ; [CPU_FPU] |330| 
	.dwpsn	file "../bts.c",line 331,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |331| 
        MOV32     *-SP[22],R0H          ; [CPU_FPU] |331| 
        MOV32     R0H,*-SP[24]          ; [CPU_FPU] |331| 
	.dwpsn	file "../bts.c",line 332,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |332| 
        MOV32     *-SP[24],R0H          ; [CPU_FPU] |332| 
        MOV32     R0H,*-SP[26]          ; [CPU_FPU] |332| 
	.dwpsn	file "../bts.c",line 334,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |334| 
        MOV32     *-SP[26],R0H          ; [CPU_FPU] |334| 
        MOV32     R0H,*-SP[28]          ; [CPU_FPU] |334| 
	.dwpsn	file "../bts.c",line 335,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |335| 
        MOV32     *-SP[28],R0H          ; [CPU_FPU] |335| 
        MOV32     R0H,*-SP[30]          ; [CPU_FPU] |335| 
	.dwpsn	file "../bts.c",line 336,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |336| 
        MOV32     *-SP[30],R0H          ; [CPU_FPU] |336| 
        MOV32     R0H,*-SP[32]          ; [CPU_FPU] |336| 
	.dwpsn	file "../bts.c",line 337,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |337| 
        MOV32     *-SP[32],R0H          ; [CPU_FPU] |337| 
        MOV32     R0H,*-SP[34]          ; [CPU_FPU] |337| 
	.dwpsn	file "../bts.c",line 339,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |339| 
        MOV32     *-SP[34],R0H          ; [CPU_FPU] |339| 
        MOV32     R0H,*-SP[36]          ; [CPU_FPU] |339| 
	.dwpsn	file "../bts.c",line 340,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |340| 
        MOV32     *-SP[36],R0H          ; [CPU_FPU] |340| 
        MOV32     R0H,*-SP[38]          ; [CPU_FPU] |340| 
	.dwpsn	file "../bts.c",line 341,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |341| 
        MOV32     *-SP[38],R0H          ; [CPU_FPU] |341| 
        MOV32     R0H,*-SP[40]          ; [CPU_FPU] |341| 
	.dwpsn	file "../bts.c",line 342,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |342| 
        MOV32     *-SP[40],R0H          ; [CPU_FPU] |342| 
        MOV32     R0H,*-SP[42]          ; [CPU_FPU] |342| 
	.dwpsn	file "../bts.c",line 344,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |344| 
        MOV32     *-SP[42],R0H          ; [CPU_FPU] |344| 
        MOV32     R0H,*-SP[44]          ; [CPU_FPU] |344| 
	.dwpsn	file "../bts.c",line 345,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |345| 
        MOV32     *-SP[44],R0H          ; [CPU_FPU] |345| 
        MOV32     R0H,*-SP[46]          ; [CPU_FPU] |345| 
	.dwpsn	file "../bts.c",line 346,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |346| 
        MOV32     *-SP[46],R0H          ; [CPU_FPU] |346| 
        MOV32     R0H,*-SP[48]          ; [CPU_FPU] |346| 
	.dwpsn	file "../bts.c",line 347,column 5,is_stmt,isa 0
        MOVXI     R0H,#10485            ; [CPU_FPU] |347| 
        MOV32     *-SP[48],R0H          ; [CPU_FPU] |347| 
        MOV32     R0H,*-SP[50]          ; [CPU_FPU] |347| 
	.dwpsn	file "../bts.c",line 349,column 5,is_stmt,isa 0
        MOVXI     R0H,#28135            ; [CPU_FPU] |349| 
        MOV32     *-SP[50],R0H          ; [CPU_FPU] |349| 
	.dwpsn	file "../bts.c",line 317,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[2]           ; [CPU_FPU] |317| 
	.dwpsn	file "../bts.c",line 319,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch1||)+74,R0H ; [CPU_FPU] |319| 
        MOV32     R0H,*-SP[4]           ; [CPU_FPU] |319| 
	.dwpsn	file "../bts.c",line 320,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch1||)+76,R0H ; [CPU_FPU] |320| 
        MOV32     R0H,*-SP[6]           ; [CPU_FPU] |320| 
	.dwpsn	file "../bts.c",line 321,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch1||)+78,R0H ; [CPU_FPU] |321| 
        MOV32     R0H,*-SP[8]           ; [CPU_FPU] |321| 
	.dwpsn	file "../bts.c",line 322,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch1||)+80,R0H ; [CPU_FPU] |322| 
        MOVW      DP,#||BTS_measValues_ch2||+74 ; [CPU_ARAU] 
        MOV32     R0H,*-SP[10]          ; [CPU_FPU] |322| 
	.dwpsn	file "../bts.c",line 324,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch2||)+74,R0H ; [CPU_FPU] |324| 
        MOV32     R0H,*-SP[12]          ; [CPU_FPU] |324| 
	.dwpsn	file "../bts.c",line 325,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch2||)+76,R0H ; [CPU_FPU] |325| 
        MOV32     R0H,*-SP[14]          ; [CPU_FPU] |325| 
	.dwpsn	file "../bts.c",line 326,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch2||)+78,R0H ; [CPU_FPU] |326| 
        MOV32     R0H,*-SP[16]          ; [CPU_FPU] |326| 
	.dwpsn	file "../bts.c",line 327,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch2||)+80,R0H ; [CPU_FPU] |327| 
        MOVW      DP,#||BTS_measValues_ch3||+74 ; [CPU_ARAU] 
        MOV32     R0H,*-SP[18]          ; [CPU_FPU] |327| 
	.dwpsn	file "../bts.c",line 329,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch3||)+74,R0H ; [CPU_FPU] |329| 
        MOV32     R0H,*-SP[20]          ; [CPU_FPU] |329| 
	.dwpsn	file "../bts.c",line 330,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch3||)+76,R0H ; [CPU_FPU] |330| 
        MOV32     R0H,*-SP[22]          ; [CPU_FPU] |330| 
	.dwpsn	file "../bts.c",line 331,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch3||)+78,R0H ; [CPU_FPU] |331| 
        MOV32     R0H,*-SP[24]          ; [CPU_FPU] |331| 
	.dwpsn	file "../bts.c",line 332,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch3||)+80,R0H ; [CPU_FPU] |332| 
        MOVW      DP,#||BTS_measValues_ch4||+74 ; [CPU_ARAU] 
        MOV32     R0H,*-SP[26]          ; [CPU_FPU] |332| 
	.dwpsn	file "../bts.c",line 334,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch4||)+74,R0H ; [CPU_FPU] |334| 
        MOV32     R0H,*-SP[28]          ; [CPU_FPU] |334| 
	.dwpsn	file "../bts.c",line 335,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch4||)+76,R0H ; [CPU_FPU] |335| 
        MOV32     R0H,*-SP[30]          ; [CPU_FPU] |335| 
	.dwpsn	file "../bts.c",line 336,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch4||)+78,R0H ; [CPU_FPU] |336| 
        MOV32     R0H,*-SP[32]          ; [CPU_FPU] |336| 
	.dwpsn	file "../bts.c",line 337,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch4||)+80,R0H ; [CPU_FPU] |337| 
        MOVW      DP,#||BTS_measValues_ch5||+74 ; [CPU_ARAU] 
        MOV32     R0H,*-SP[34]          ; [CPU_FPU] |337| 
	.dwpsn	file "../bts.c",line 339,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch5||)+74,R0H ; [CPU_FPU] |339| 
        MOV32     R0H,*-SP[36]          ; [CPU_FPU] |339| 
	.dwpsn	file "../bts.c",line 340,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch5||)+76,R0H ; [CPU_FPU] |340| 
        MOV32     R0H,*-SP[38]          ; [CPU_FPU] |340| 
	.dwpsn	file "../bts.c",line 341,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch5||)+78,R0H ; [CPU_FPU] |341| 
        MOV32     R0H,*-SP[40]          ; [CPU_FPU] |341| 
	.dwpsn	file "../bts.c",line 342,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch5||)+80,R0H ; [CPU_FPU] |342| 
        MOVW      DP,#||BTS_measValues_ch6||+74 ; [CPU_ARAU] 
        MOV32     R0H,*-SP[42]          ; [CPU_FPU] |342| 
	.dwpsn	file "../bts.c",line 344,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch6||)+74,R0H ; [CPU_FPU] |344| 
        MOV32     R0H,*-SP[44]          ; [CPU_FPU] |344| 
	.dwpsn	file "../bts.c",line 345,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch6||)+76,R0H ; [CPU_FPU] |345| 
        MOV32     R0H,*-SP[46]          ; [CPU_FPU] |345| 
	.dwpsn	file "../bts.c",line 346,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch6||)+78,R0H ; [CPU_FPU] |346| 
        MOV32     R0H,*-SP[48]          ; [CPU_FPU] |346| 
	.dwpsn	file "../bts.c",line 347,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch6||)+80,R0H ; [CPU_FPU] |347| 
        MOVW      DP,#||BTS_measValues_ch7||+74 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 350,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch7||)+76,R7H ; [CPU_FPU] |350| 
	.dwpsn	file "../bts.c",line 351,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch7||)+78,R6H ; [CPU_FPU] |351| 
	.dwpsn	file "../bts.c",line 352,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch7||)+80,R5H ; [CPU_FPU] |352| 
	.dwpsn	file "../bts.c",line 347,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[50]          ; [CPU_FPU] |347| 
	.dwpsn	file "../bts.c",line 349,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch7||)+74,R0H ; [CPU_FPU] |349| 
        MOVW      DP,#||BTS_measValues_ch8||+74 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 354,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch8||)+74,R4H ; [CPU_FPU] |354| 
	.dwpsn	file "../bts.c",line 355,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch8||)+76,R3H ; [CPU_FPU] |355| 
	.dwpsn	file "../bts.c",line 356,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch8||)+78,R2H ; [CPU_FPU] |356| 
	.dwpsn	file "../bts.c",line 357,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch8||)+80,R1H ; [CPU_FPU] |357| 
        SUBB      SP,#50                ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -10
        MOV32     R7H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -8
	.dwcfi	restore_reg, 71
        MOV32     R6H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -6
	.dwcfi	restore_reg, 67
        MOV32     R5H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 63
        MOV32     R4H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 59
$C$DW$293	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$293, DW_AT_low_pc(0x00)
	.dwattr $C$DW$293, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$292, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$292, DW_AT_TI_end_line(0x166)
	.dwattr $C$DW$292, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$292

	.sect	".text"
	.clink
	.global	||BTS_initController||

$C$DW$294	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$294, DW_AT_name("BTS_initController")
	.dwattr $C$DW$294, DW_AT_low_pc(||BTS_initController||)
	.dwattr $C$DW$294, DW_AT_high_pc(0x00)
	.dwattr $C$DW$294, DW_AT_linkage_name("BTS_initController")
	.dwattr $C$DW$294, DW_AT_external
	.dwattr $C$DW$294, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$294, DW_AT_decl_line(0x168)
	.dwattr $C$DW$294, DW_AT_decl_column(0x06)
	.dwattr $C$DW$294, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts.c",line 361,column 1,is_stmt,address ||BTS_initController||,isa 0

	.dwfde $C$DW$CIE, ||BTS_initController||

;***************************************************************
;* FNAME: BTS_initController            FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  2 SOE     *
;***************************************************************

||BTS_initController||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../bts.c",line 365,column 5,is_stmt,isa 0
        MOVIZ     R2H,#15623            ; [CPU_FPU] |365| 
	.dwpsn	file "../bts.c",line 366,column 5,is_stmt,isa 0
        MOVIZ     R1H,#48511            ; [CPU_FPU] |366| 
        MOVW      DP,#||BTS_ctrl_cc_ch1|| ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 367,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15600            ; [CPU_FPU] |367| 
        MOV32     *SP++,R4H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 59, 2
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts.c",line 365,column 5,is_stmt,isa 0
        MOVXI     R2H,#38256            ; [CPU_FPU] |365| 
	.dwpsn	file "../bts.c",line 366,column 5,is_stmt,isa 0
        MOVXI     R1H,#32169            ; [CPU_FPU] |366| 
	.dwpsn	file "../bts.c",line 365,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||),R2H ; [CPU_FPU] |365| 
	.dwpsn	file "../bts.c",line 367,column 5,is_stmt,isa 0
        MOVXI     R0H,#21649            ; [CPU_FPU] |367| 
	.dwpsn	file "../bts.c",line 368,column 5,is_stmt,isa 0
        MOVIZ     R2H,#49146            ; [CPU_FPU] |368| 
	.dwpsn	file "../bts.c",line 366,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+2,R1H ; [CPU_FPU] |366| 
	.dwpsn	file "../bts.c",line 369,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16245            ; [CPU_FPU] |369| 
	.dwpsn	file "../bts.c",line 368,column 5,is_stmt,isa 0
        MOVXI     R2H,#62539            ; [CPU_FPU] |368| 
	.dwpsn	file "../bts.c",line 480,column 5,is_stmt,isa 0
        MOVIZ     R4H,#16640            ; [CPU_FPU] |480| 
	.dwpsn	file "../bts.c",line 481,column 5,is_stmt,isa 0
        MOVIZ     R3H,#49491            ; [CPU_FPU] |481| 
	.dwpsn	file "../bts.c",line 367,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+4,R0H ; [CPU_FPU] |367| 
	.dwpsn	file "../bts.c",line 369,column 5,is_stmt,isa 0
        MOVXI     R1H,#59542            ; [CPU_FPU] |369| 
	.dwpsn	file "../bts.c",line 371,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16640            ; [CPU_FPU] |371| 
	.dwpsn	file "../bts.c",line 368,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+6,R2H ; [CPU_FPU] |368| 
	.dwpsn	file "../bts.c",line 372,column 5,is_stmt,isa 0
        MOVIZ     R2H,#49491            ; [CPU_FPU] |372| 
	.dwpsn	file "../bts.c",line 371,column 5,is_stmt,isa 0
        MOVXI     R0H,#39581            ; [CPU_FPU] |371| 
	.dwpsn	file "../bts.c",line 369,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+8,R1H ; [CPU_FPU] |369| 
	.dwpsn	file "../bts.c",line 372,column 5,is_stmt,isa 0
        MOVXI     R2H,#38693            ; [CPU_FPU] |372| 
	.dwpsn	file "../bts.c",line 373,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16551            ; [CPU_FPU] |373| 
        MOVW      DP,#||BTS_ctrl_cv_ch1|| ; [CPU_ARAU] 
        MOVXI     R1H,#45032            ; [CPU_FPU] |373| 
	.dwpsn	file "../bts.c",line 371,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch1||),R0H ; [CPU_FPU] |371| 
	.dwpsn	file "../bts.c",line 374,column 5,is_stmt,isa 0
        MOVIZ     R0H,#49109            ; [CPU_FPU] |374| 
	.dwpsn	file "../bts.c",line 372,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch1||)+2,R2H ; [CPU_FPU] |372| 
	.dwpsn	file "../bts.c",line 374,column 5,is_stmt,isa 0
        MOVXI     R0H,#9484             ; [CPU_FPU] |374| 
	.dwpsn	file "../bts.c",line 375,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16170            ; [CPU_FPU] |375| 
        MOVXI     R2H,#18968            ; [CPU_FPU] |375| 
	.dwpsn	file "../bts.c",line 373,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch1||)+4,R1H ; [CPU_FPU] |373| 
	.dwpsn	file "../bts.c",line 380,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15623            ; [CPU_FPU] |380| 
        MOVXI     R1H,#38256            ; [CPU_FPU] |380| 
	.dwpsn	file "../bts.c",line 374,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch1||)+6,R0H ; [CPU_FPU] |374| 
	.dwpsn	file "../bts.c",line 381,column 5,is_stmt,isa 0
        MOVIZ     R0H,#48511            ; [CPU_FPU] |381| 
        MOVXI     R0H,#32169            ; [CPU_FPU] |381| 
	.dwpsn	file "../bts.c",line 375,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch1||)+8,R2H ; [CPU_FPU] |375| 
	.dwpsn	file "../bts.c",line 382,column 5,is_stmt,isa 0
        MOVIZ     R2H,#15600            ; [CPU_FPU] |382| 
        MOVW      DP,#||BTS_ctrl_cc_ch2|| ; [CPU_ARAU] 
        MOVXI     R2H,#21649            ; [CPU_FPU] |382| 
	.dwpsn	file "../bts.c",line 380,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||),R1H ; [CPU_FPU] |380| 
	.dwpsn	file "../bts.c",line 383,column 5,is_stmt,isa 0
        MOVIZ     R1H,#49146            ; [CPU_FPU] |383| 
	.dwpsn	file "../bts.c",line 480,column 5,is_stmt,isa 0
        MOVXI     R4H,#39581            ; [CPU_FPU] |480| 
	.dwpsn	file "../bts.c",line 481,column 5,is_stmt,isa 0
        MOVXI     R3H,#38693            ; [CPU_FPU] |481| 
	.dwpsn	file "../bts.c",line 383,column 5,is_stmt,isa 0
        MOVXI     R1H,#62539            ; [CPU_FPU] |383| 
	.dwpsn	file "../bts.c",line 381,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||)+2,R0H ; [CPU_FPU] |381| 
	.dwpsn	file "../bts.c",line 384,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16245            ; [CPU_FPU] |384| 
        MOVXI     R0H,#59542            ; [CPU_FPU] |384| 
	.dwpsn	file "../bts.c",line 382,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||)+4,R2H ; [CPU_FPU] |382| 
	.dwpsn	file "../bts.c",line 386,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16640            ; [CPU_FPU] |386| 
        MOVXI     R2H,#39581            ; [CPU_FPU] |386| 
	.dwpsn	file "../bts.c",line 383,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||)+6,R1H ; [CPU_FPU] |383| 
	.dwpsn	file "../bts.c",line 387,column 5,is_stmt,isa 0
        MOVIZ     R1H,#49491            ; [CPU_FPU] |387| 
        MOVXI     R1H,#38693            ; [CPU_FPU] |387| 
	.dwpsn	file "../bts.c",line 384,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||)+8,R0H ; [CPU_FPU] |384| 
	.dwpsn	file "../bts.c",line 388,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16551            ; [CPU_FPU] |388| 
        MOVW      DP,#||BTS_ctrl_cv_ch2|| ; [CPU_ARAU] 
        MOVXI     R0H,#45032            ; [CPU_FPU] |388| 
	.dwpsn	file "../bts.c",line 386,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch2||),R2H ; [CPU_FPU] |386| 
	.dwpsn	file "../bts.c",line 389,column 5,is_stmt,isa 0
        MOVIZ     R2H,#49109            ; [CPU_FPU] |389| 
        MOVXI     R2H,#9484             ; [CPU_FPU] |389| 
	.dwpsn	file "../bts.c",line 387,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch2||)+2,R1H ; [CPU_FPU] |387| 
	.dwpsn	file "../bts.c",line 390,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16170            ; [CPU_FPU] |390| 
        MOVXI     R1H,#18968            ; [CPU_FPU] |390| 
	.dwpsn	file "../bts.c",line 388,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch2||)+4,R0H ; [CPU_FPU] |388| 
	.dwpsn	file "../bts.c",line 396,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15623            ; [CPU_FPU] |396| 
        MOVXI     R0H,#38256            ; [CPU_FPU] |396| 
	.dwpsn	file "../bts.c",line 389,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch2||)+6,R2H ; [CPU_FPU] |389| 
	.dwpsn	file "../bts.c",line 397,column 5,is_stmt,isa 0
        MOVIZ     R2H,#48511            ; [CPU_FPU] |397| 
        MOVXI     R2H,#32169            ; [CPU_FPU] |397| 
	.dwpsn	file "../bts.c",line 390,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch2||)+8,R1H ; [CPU_FPU] |390| 
	.dwpsn	file "../bts.c",line 398,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15600            ; [CPU_FPU] |398| 
        MOVW      DP,#||BTS_ctrl_cc_ch3|| ; [CPU_ARAU] 
        MOVXI     R1H,#21649            ; [CPU_FPU] |398| 
	.dwpsn	file "../bts.c",line 396,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||),R0H ; [CPU_FPU] |396| 
	.dwpsn	file "../bts.c",line 399,column 5,is_stmt,isa 0
        MOVIZ     R0H,#49146            ; [CPU_FPU] |399| 
        MOVXI     R0H,#62539            ; [CPU_FPU] |399| 
	.dwpsn	file "../bts.c",line 397,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||)+2,R2H ; [CPU_FPU] |397| 
	.dwpsn	file "../bts.c",line 400,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16245            ; [CPU_FPU] |400| 
        MOVXI     R2H,#59542            ; [CPU_FPU] |400| 
	.dwpsn	file "../bts.c",line 398,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||)+4,R1H ; [CPU_FPU] |398| 
	.dwpsn	file "../bts.c",line 402,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16640            ; [CPU_FPU] |402| 
        MOVXI     R1H,#39581            ; [CPU_FPU] |402| 
	.dwpsn	file "../bts.c",line 399,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||)+6,R0H ; [CPU_FPU] |399| 
	.dwpsn	file "../bts.c",line 403,column 5,is_stmt,isa 0
        MOVIZ     R0H,#49491            ; [CPU_FPU] |403| 
        MOVXI     R0H,#38693            ; [CPU_FPU] |403| 
	.dwpsn	file "../bts.c",line 400,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||)+8,R2H ; [CPU_FPU] |400| 
	.dwpsn	file "../bts.c",line 404,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16551            ; [CPU_FPU] |404| 
        MOVW      DP,#||BTS_ctrl_cv_ch3|| ; [CPU_ARAU] 
        MOVXI     R2H,#45032            ; [CPU_FPU] |404| 
	.dwpsn	file "../bts.c",line 402,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch3||),R1H ; [CPU_FPU] |402| 
	.dwpsn	file "../bts.c",line 405,column 5,is_stmt,isa 0
        MOVIZ     R1H,#49109            ; [CPU_FPU] |405| 
        MOVXI     R1H,#9484             ; [CPU_FPU] |405| 
	.dwpsn	file "../bts.c",line 403,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch3||)+2,R0H ; [CPU_FPU] |403| 
	.dwpsn	file "../bts.c",line 406,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16170            ; [CPU_FPU] |406| 
        MOVXI     R0H,#18968            ; [CPU_FPU] |406| 
	.dwpsn	file "../bts.c",line 404,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch3||)+4,R2H ; [CPU_FPU] |404| 
	.dwpsn	file "../bts.c",line 412,column 5,is_stmt,isa 0
        MOVIZ     R2H,#15623            ; [CPU_FPU] |412| 
        MOVXI     R2H,#38256            ; [CPU_FPU] |412| 
	.dwpsn	file "../bts.c",line 405,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch3||)+6,R1H ; [CPU_FPU] |405| 
	.dwpsn	file "../bts.c",line 413,column 5,is_stmt,isa 0
        MOVIZ     R1H,#48511            ; [CPU_FPU] |413| 
        MOVXI     R1H,#32169            ; [CPU_FPU] |413| 
	.dwpsn	file "../bts.c",line 406,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch3||)+8,R0H ; [CPU_FPU] |406| 
	.dwpsn	file "../bts.c",line 414,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15600            ; [CPU_FPU] |414| 
        MOVW      DP,#||BTS_ctrl_cc_ch4|| ; [CPU_ARAU] 
        MOVXI     R0H,#21649            ; [CPU_FPU] |414| 
	.dwpsn	file "../bts.c",line 412,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||),R2H ; [CPU_FPU] |412| 
	.dwpsn	file "../bts.c",line 415,column 5,is_stmt,isa 0
        MOVIZ     R2H,#49146            ; [CPU_FPU] |415| 
        MOVXI     R2H,#62539            ; [CPU_FPU] |415| 
	.dwpsn	file "../bts.c",line 413,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||)+2,R1H ; [CPU_FPU] |413| 
	.dwpsn	file "../bts.c",line 416,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16245            ; [CPU_FPU] |416| 
        MOVXI     R1H,#59542            ; [CPU_FPU] |416| 
	.dwpsn	file "../bts.c",line 414,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||)+4,R0H ; [CPU_FPU] |414| 
	.dwpsn	file "../bts.c",line 418,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16640            ; [CPU_FPU] |418| 
        MOVXI     R0H,#39581            ; [CPU_FPU] |418| 
	.dwpsn	file "../bts.c",line 415,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||)+6,R2H ; [CPU_FPU] |415| 
	.dwpsn	file "../bts.c",line 419,column 5,is_stmt,isa 0
        MOVIZ     R2H,#49491            ; [CPU_FPU] |419| 
        MOVXI     R2H,#38693            ; [CPU_FPU] |419| 
	.dwpsn	file "../bts.c",line 416,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||)+8,R1H ; [CPU_FPU] |416| 
	.dwpsn	file "../bts.c",line 420,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16551            ; [CPU_FPU] |420| 
        MOVW      DP,#||BTS_ctrl_cv_ch4|| ; [CPU_ARAU] 
        MOVXI     R1H,#45032            ; [CPU_FPU] |420| 
	.dwpsn	file "../bts.c",line 418,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch4||),R0H ; [CPU_FPU] |418| 
	.dwpsn	file "../bts.c",line 421,column 5,is_stmt,isa 0
        MOVIZ     R0H,#49109            ; [CPU_FPU] |421| 
        MOVXI     R0H,#9484             ; [CPU_FPU] |421| 
	.dwpsn	file "../bts.c",line 419,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch4||)+2,R2H ; [CPU_FPU] |419| 
	.dwpsn	file "../bts.c",line 422,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16170            ; [CPU_FPU] |422| 
        MOVXI     R2H,#18968            ; [CPU_FPU] |422| 
	.dwpsn	file "../bts.c",line 420,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch4||)+4,R1H ; [CPU_FPU] |420| 
	.dwpsn	file "../bts.c",line 427,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15623            ; [CPU_FPU] |427| 
        MOVXI     R1H,#38256            ; [CPU_FPU] |427| 
	.dwpsn	file "../bts.c",line 421,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch4||)+6,R0H ; [CPU_FPU] |421| 
	.dwpsn	file "../bts.c",line 428,column 5,is_stmt,isa 0
        MOVIZ     R0H,#48511            ; [CPU_FPU] |428| 
        MOVXI     R0H,#32169            ; [CPU_FPU] |428| 
	.dwpsn	file "../bts.c",line 422,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch4||)+8,R2H ; [CPU_FPU] |422| 
	.dwpsn	file "../bts.c",line 429,column 5,is_stmt,isa 0
        MOVIZ     R2H,#15600            ; [CPU_FPU] |429| 
        MOVW      DP,#||BTS_ctrl_cc_ch5|| ; [CPU_ARAU] 
        MOVXI     R2H,#21649            ; [CPU_FPU] |429| 
	.dwpsn	file "../bts.c",line 427,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch5||),R1H ; [CPU_FPU] |427| 
	.dwpsn	file "../bts.c",line 430,column 5,is_stmt,isa 0
        MOVIZ     R1H,#49146            ; [CPU_FPU] |430| 
        MOVXI     R1H,#62539            ; [CPU_FPU] |430| 
	.dwpsn	file "../bts.c",line 428,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch5||)+2,R0H ; [CPU_FPU] |428| 
	.dwpsn	file "../bts.c",line 431,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16245            ; [CPU_FPU] |431| 
        MOVXI     R0H,#59542            ; [CPU_FPU] |431| 
	.dwpsn	file "../bts.c",line 429,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch5||)+4,R2H ; [CPU_FPU] |429| 
	.dwpsn	file "../bts.c",line 433,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16640            ; [CPU_FPU] |433| 
        MOVXI     R2H,#39581            ; [CPU_FPU] |433| 
	.dwpsn	file "../bts.c",line 430,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch5||)+6,R1H ; [CPU_FPU] |430| 
	.dwpsn	file "../bts.c",line 434,column 5,is_stmt,isa 0
        MOVIZ     R1H,#49491            ; [CPU_FPU] |434| 
        MOVXI     R1H,#38693            ; [CPU_FPU] |434| 
	.dwpsn	file "../bts.c",line 431,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch5||)+8,R0H ; [CPU_FPU] |431| 
	.dwpsn	file "../bts.c",line 435,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16551            ; [CPU_FPU] |435| 
        MOVW      DP,#||BTS_ctrl_cv_ch5|| ; [CPU_ARAU] 
        MOVXI     R0H,#45032            ; [CPU_FPU] |435| 
	.dwpsn	file "../bts.c",line 433,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch5||),R2H ; [CPU_FPU] |433| 
	.dwpsn	file "../bts.c",line 436,column 5,is_stmt,isa 0
        MOVIZ     R2H,#49109            ; [CPU_FPU] |436| 
        MOVXI     R2H,#9484             ; [CPU_FPU] |436| 
	.dwpsn	file "../bts.c",line 434,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch5||)+2,R1H ; [CPU_FPU] |434| 
	.dwpsn	file "../bts.c",line 437,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16170            ; [CPU_FPU] |437| 
        MOVXI     R1H,#18968            ; [CPU_FPU] |437| 
	.dwpsn	file "../bts.c",line 435,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch5||)+4,R0H ; [CPU_FPU] |435| 
	.dwpsn	file "../bts.c",line 442,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15623            ; [CPU_FPU] |442| 
        MOVXI     R0H,#38256            ; [CPU_FPU] |442| 
	.dwpsn	file "../bts.c",line 436,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch5||)+6,R2H ; [CPU_FPU] |436| 
	.dwpsn	file "../bts.c",line 443,column 5,is_stmt,isa 0
        MOVIZ     R2H,#48511            ; [CPU_FPU] |443| 
        MOVXI     R2H,#32169            ; [CPU_FPU] |443| 
	.dwpsn	file "../bts.c",line 437,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch5||)+8,R1H ; [CPU_FPU] |437| 
	.dwpsn	file "../bts.c",line 444,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15600            ; [CPU_FPU] |444| 
        MOVW      DP,#||BTS_ctrl_cc_ch6|| ; [CPU_ARAU] 
        MOVXI     R1H,#21649            ; [CPU_FPU] |444| 
	.dwpsn	file "../bts.c",line 442,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch6||),R0H ; [CPU_FPU] |442| 
	.dwpsn	file "../bts.c",line 445,column 5,is_stmt,isa 0
        MOVIZ     R0H,#49146            ; [CPU_FPU] |445| 
        MOVXI     R0H,#62539            ; [CPU_FPU] |445| 
	.dwpsn	file "../bts.c",line 443,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch6||)+2,R2H ; [CPU_FPU] |443| 
	.dwpsn	file "../bts.c",line 446,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16245            ; [CPU_FPU] |446| 
        MOVXI     R2H,#59542            ; [CPU_FPU] |446| 
	.dwpsn	file "../bts.c",line 444,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch6||)+4,R1H ; [CPU_FPU] |444| 
	.dwpsn	file "../bts.c",line 448,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16640            ; [CPU_FPU] |448| 
        MOVXI     R1H,#39581            ; [CPU_FPU] |448| 
	.dwpsn	file "../bts.c",line 445,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch6||)+6,R0H ; [CPU_FPU] |445| 
	.dwpsn	file "../bts.c",line 449,column 5,is_stmt,isa 0
        MOVIZ     R0H,#49491            ; [CPU_FPU] |449| 
        MOVXI     R0H,#38693            ; [CPU_FPU] |449| 
	.dwpsn	file "../bts.c",line 446,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch6||)+8,R2H ; [CPU_FPU] |446| 
	.dwpsn	file "../bts.c",line 450,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16551            ; [CPU_FPU] |450| 
        MOVW      DP,#||BTS_ctrl_cv_ch6|| ; [CPU_ARAU] 
        MOVXI     R2H,#45032            ; [CPU_FPU] |450| 
	.dwpsn	file "../bts.c",line 448,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch6||),R1H ; [CPU_FPU] |448| 
	.dwpsn	file "../bts.c",line 451,column 5,is_stmt,isa 0
        MOVIZ     R1H,#49109            ; [CPU_FPU] |451| 
        MOVXI     R1H,#9484             ; [CPU_FPU] |451| 
	.dwpsn	file "../bts.c",line 449,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch6||)+2,R0H ; [CPU_FPU] |449| 
	.dwpsn	file "../bts.c",line 452,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16170            ; [CPU_FPU] |452| 
        MOVXI     R0H,#18968            ; [CPU_FPU] |452| 
	.dwpsn	file "../bts.c",line 450,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch6||)+4,R2H ; [CPU_FPU] |450| 
	.dwpsn	file "../bts.c",line 458,column 5,is_stmt,isa 0
        MOVIZ     R2H,#15623            ; [CPU_FPU] |458| 
        MOVXI     R2H,#38256            ; [CPU_FPU] |458| 
	.dwpsn	file "../bts.c",line 451,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch6||)+6,R1H ; [CPU_FPU] |451| 
	.dwpsn	file "../bts.c",line 459,column 5,is_stmt,isa 0
        MOVIZ     R1H,#48511            ; [CPU_FPU] |459| 
        MOVXI     R1H,#32169            ; [CPU_FPU] |459| 
	.dwpsn	file "../bts.c",line 452,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch6||)+8,R0H ; [CPU_FPU] |452| 
	.dwpsn	file "../bts.c",line 460,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15600            ; [CPU_FPU] |460| 
        MOVW      DP,#||BTS_ctrl_cc_ch7|| ; [CPU_ARAU] 
        MOVXI     R0H,#21649            ; [CPU_FPU] |460| 
	.dwpsn	file "../bts.c",line 458,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch7||),R2H ; [CPU_FPU] |458| 
	.dwpsn	file "../bts.c",line 461,column 5,is_stmt,isa 0
        MOVIZ     R2H,#49146            ; [CPU_FPU] |461| 
        MOVXI     R2H,#62539            ; [CPU_FPU] |461| 
	.dwpsn	file "../bts.c",line 459,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch7||)+2,R1H ; [CPU_FPU] |459| 
	.dwpsn	file "../bts.c",line 462,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16245            ; [CPU_FPU] |462| 
        MOVXI     R1H,#59542            ; [CPU_FPU] |462| 
	.dwpsn	file "../bts.c",line 460,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch7||)+4,R0H ; [CPU_FPU] |460| 
	.dwpsn	file "../bts.c",line 464,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16640            ; [CPU_FPU] |464| 
        MOVXI     R0H,#39581            ; [CPU_FPU] |464| 
	.dwpsn	file "../bts.c",line 461,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch7||)+6,R2H ; [CPU_FPU] |461| 
	.dwpsn	file "../bts.c",line 465,column 5,is_stmt,isa 0
        MOVIZ     R2H,#49491            ; [CPU_FPU] |465| 
        MOVXI     R2H,#38693            ; [CPU_FPU] |465| 
	.dwpsn	file "../bts.c",line 462,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch7||)+8,R1H ; [CPU_FPU] |462| 
	.dwpsn	file "../bts.c",line 466,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16551            ; [CPU_FPU] |466| 
        MOVW      DP,#||BTS_ctrl_cv_ch7|| ; [CPU_ARAU] 
        MOVXI     R1H,#45032            ; [CPU_FPU] |466| 
	.dwpsn	file "../bts.c",line 464,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch7||),R0H ; [CPU_FPU] |464| 
	.dwpsn	file "../bts.c",line 467,column 5,is_stmt,isa 0
        MOVIZ     R0H,#49109            ; [CPU_FPU] |467| 
        MOVXI     R0H,#9484             ; [CPU_FPU] |467| 
	.dwpsn	file "../bts.c",line 465,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch7||)+2,R2H ; [CPU_FPU] |465| 
	.dwpsn	file "../bts.c",line 468,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16170            ; [CPU_FPU] |468| 
        MOVXI     R2H,#18968            ; [CPU_FPU] |468| 
	.dwpsn	file "../bts.c",line 466,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch7||)+4,R1H ; [CPU_FPU] |466| 
	.dwpsn	file "../bts.c",line 474,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15623            ; [CPU_FPU] |474| 
        MOVXI     R1H,#38256            ; [CPU_FPU] |474| 
	.dwpsn	file "../bts.c",line 467,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch7||)+6,R0H ; [CPU_FPU] |467| 
	.dwpsn	file "../bts.c",line 475,column 5,is_stmt,isa 0
        MOVIZ     R0H,#48511            ; [CPU_FPU] |475| 
        MOVXI     R0H,#32169            ; [CPU_FPU] |475| 
	.dwpsn	file "../bts.c",line 468,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch7||)+8,R2H ; [CPU_FPU] |468| 
	.dwpsn	file "../bts.c",line 476,column 5,is_stmt,isa 0
        MOVIZ     R2H,#15600            ; [CPU_FPU] |476| 
        MOVW      DP,#||BTS_ctrl_cc_ch8|| ; [CPU_ARAU] 
        MOVXI     R2H,#21649            ; [CPU_FPU] |476| 
	.dwpsn	file "../bts.c",line 474,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch8||),R1H ; [CPU_FPU] |474| 
	.dwpsn	file "../bts.c",line 477,column 5,is_stmt,isa 0
        MOVIZ     R1H,#49146            ; [CPU_FPU] |477| 
        MOVXI     R1H,#62539            ; [CPU_FPU] |477| 
	.dwpsn	file "../bts.c",line 475,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch8||)+2,R0H ; [CPU_FPU] |475| 
	.dwpsn	file "../bts.c",line 478,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16245            ; [CPU_FPU] |478| 
        MOVXI     R0H,#59542            ; [CPU_FPU] |478| 
	.dwpsn	file "../bts.c",line 476,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch8||)+4,R2H ; [CPU_FPU] |476| 
	.dwpsn	file "../bts.c",line 482,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16551            ; [CPU_FPU] |482| 
        MOVXI     R2H,#45032            ; [CPU_FPU] |482| 
	.dwpsn	file "../bts.c",line 477,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch8||)+6,R1H ; [CPU_FPU] |477| 
	.dwpsn	file "../bts.c",line 483,column 5,is_stmt,isa 0
        MOVIZ     R1H,#49109            ; [CPU_FPU] |483| 
        MOVXI     R1H,#9484             ; [CPU_FPU] |483| 
	.dwpsn	file "../bts.c",line 478,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch8||)+8,R0H ; [CPU_FPU] |478| 
	.dwpsn	file "../bts.c",line 484,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16170            ; [CPU_FPU] |484| 
        MOVW      DP,#||BTS_ctrl_cv_ch8|| ; [CPU_ARAU] 
        MOVXI     R0H,#18968            ; [CPU_FPU] |484| 
	.dwpsn	file "../bts.c",line 480,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch8||),R4H ; [CPU_FPU] |480| 
	.dwpsn	file "../bts.c",line 481,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch8||)+2,R3H ; [CPU_FPU] |481| 
        MOV32     R4H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 59
	.dwpsn	file "../bts.c",line 482,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch8||)+4,R2H ; [CPU_FPU] |482| 
	.dwpsn	file "../bts.c",line 483,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch8||)+6,R1H ; [CPU_FPU] |483| 
	.dwpsn	file "../bts.c",line 484,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch8||)+8,R0H ; [CPU_FPU] |484| 
$C$DW$295	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$295, DW_AT_low_pc(0x00)
	.dwattr $C$DW$295, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$294, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$294, DW_AT_TI_end_line(0x1e6)
	.dwattr $C$DW$294, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$294

;**************************************************************
;* UNDEFINED EXTERNAL REFERENCES                              *
;**************************************************************
	.global	||SFRA_F32_reset||
	.global	||SFRA_F32_config||
	.global	||SFRA_F32_resetFreqRespArray||
	.global	||SFRA_F32_initFreqArrayWithLogSteps||
	.global	||SFRA_GUI_config||
	.global	||I2C_disableInterrupt||
	.global	||handleI2C_ErrorCondition||
	.global	||Write_Read_TX_RX_FIFO||
	.global	||I2C_enableInterrupt||
	.global	||I2C_clearInterruptStatus||
	.global	||SFO||
	.global	||SysCtl_getLowSpeedClock||
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

$C$DW$TU$23	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$23

$C$DW$T$23	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$23, DW_AT_byte_size(0x20)
$C$DW$296	.dwtag  DW_TAG_member
	.dwattr $C$DW$296, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$296, DW_AT_name("h_magVect")
	.dwattr $C$DW$296, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$296, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$296, DW_AT_decl_line(0x40)
	.dwattr $C$DW$296, DW_AT_decl_column(0x10)

$C$DW$297	.dwtag  DW_TAG_member
	.dwattr $C$DW$297, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$297, DW_AT_name("h_phaseVect")
	.dwattr $C$DW$297, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$297, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$297, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$297, DW_AT_decl_line(0x41)
	.dwattr $C$DW$297, DW_AT_decl_column(0x10)

$C$DW$298	.dwtag  DW_TAG_member
	.dwattr $C$DW$298, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$298, DW_AT_name("gh_magVect")
	.dwattr $C$DW$298, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$298, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$298, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$298, DW_AT_decl_line(0x42)
	.dwattr $C$DW$298, DW_AT_decl_column(0x10)

$C$DW$299	.dwtag  DW_TAG_member
	.dwattr $C$DW$299, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$299, DW_AT_name("gh_phaseVect")
	.dwattr $C$DW$299, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$299, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$299, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$299, DW_AT_decl_line(0x43)
	.dwattr $C$DW$299, DW_AT_decl_column(0x10)

$C$DW$300	.dwtag  DW_TAG_member
	.dwattr $C$DW$300, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$300, DW_AT_name("cl_magVect")
	.dwattr $C$DW$300, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$300, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$300, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$300, DW_AT_decl_line(0x44)
	.dwattr $C$DW$300, DW_AT_decl_column(0x10)

$C$DW$301	.dwtag  DW_TAG_member
	.dwattr $C$DW$301, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$301, DW_AT_name("cl_phaseVect")
	.dwattr $C$DW$301, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$301, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$301, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$301, DW_AT_decl_line(0x45)
	.dwattr $C$DW$301, DW_AT_decl_column(0x10)

$C$DW$302	.dwtag  DW_TAG_member
	.dwattr $C$DW$302, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$302, DW_AT_name("freqVect")
	.dwattr $C$DW$302, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$302, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$302, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$302, DW_AT_decl_line(0x46)
	.dwattr $C$DW$302, DW_AT_decl_column(0x10)

$C$DW$303	.dwtag  DW_TAG_member
	.dwattr $C$DW$303, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$303, DW_AT_name("amplitude")
	.dwattr $C$DW$303, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$303, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$303, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$303, DW_AT_decl_line(0x47)
	.dwattr $C$DW$303, DW_AT_decl_column(0x0f)

$C$DW$304	.dwtag  DW_TAG_member
	.dwattr $C$DW$304, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$304, DW_AT_name("isrFreq")
	.dwattr $C$DW$304, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$304, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$304, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$304, DW_AT_decl_line(0x48)
	.dwattr $C$DW$304, DW_AT_decl_column(0x0f)

$C$DW$305	.dwtag  DW_TAG_member
	.dwattr $C$DW$305, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$305, DW_AT_name("freqStart")
	.dwattr $C$DW$305, DW_AT_data_member_location[DW_OP_plus_uconst 0x12]
	.dwattr $C$DW$305, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$305, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$305, DW_AT_decl_line(0x49)
	.dwattr $C$DW$305, DW_AT_decl_column(0x0f)

$C$DW$306	.dwtag  DW_TAG_member
	.dwattr $C$DW$306, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$306, DW_AT_name("freqStep")
	.dwattr $C$DW$306, DW_AT_data_member_location[DW_OP_plus_uconst 0x14]
	.dwattr $C$DW$306, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$306, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$306, DW_AT_decl_line(0x4a)
	.dwattr $C$DW$306, DW_AT_decl_column(0x0f)

$C$DW$307	.dwtag  DW_TAG_member
	.dwattr $C$DW$307, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$307, DW_AT_name("start")
	.dwattr $C$DW$307, DW_AT_data_member_location[DW_OP_plus_uconst 0x16]
	.dwattr $C$DW$307, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$307, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$307, DW_AT_decl_line(0x4b)
	.dwattr $C$DW$307, DW_AT_decl_column(0x0d)

$C$DW$308	.dwtag  DW_TAG_member
	.dwattr $C$DW$308, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$308, DW_AT_name("state")
	.dwattr $C$DW$308, DW_AT_data_member_location[DW_OP_plus_uconst 0x17]
	.dwattr $C$DW$308, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$308, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$308, DW_AT_decl_line(0x4c)
	.dwattr $C$DW$308, DW_AT_decl_column(0x0d)

$C$DW$309	.dwtag  DW_TAG_member
	.dwattr $C$DW$309, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$309, DW_AT_name("status")
	.dwattr $C$DW$309, DW_AT_data_member_location[DW_OP_plus_uconst 0x18]
	.dwattr $C$DW$309, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$309, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$309, DW_AT_decl_line(0x4d)
	.dwattr $C$DW$309, DW_AT_decl_column(0x0d)

$C$DW$310	.dwtag  DW_TAG_member
	.dwattr $C$DW$310, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$310, DW_AT_name("vecLength")
	.dwattr $C$DW$310, DW_AT_data_member_location[DW_OP_plus_uconst 0x19]
	.dwattr $C$DW$310, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$310, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$310, DW_AT_decl_line(0x4e)
	.dwattr $C$DW$310, DW_AT_decl_column(0x0d)

$C$DW$311	.dwtag  DW_TAG_member
	.dwattr $C$DW$311, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$311, DW_AT_name("freqIndex")
	.dwattr $C$DW$311, DW_AT_data_member_location[DW_OP_plus_uconst 0x1a]
	.dwattr $C$DW$311, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$311, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$311, DW_AT_decl_line(0x4f)
	.dwattr $C$DW$311, DW_AT_decl_column(0x0d)

$C$DW$312	.dwtag  DW_TAG_member
	.dwattr $C$DW$312, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$312, DW_AT_name("storeH")
	.dwattr $C$DW$312, DW_AT_data_member_location[DW_OP_plus_uconst 0x1b]
	.dwattr $C$DW$312, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$312, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$312, DW_AT_decl_line(0x50)
	.dwattr $C$DW$312, DW_AT_decl_column(0x0d)

$C$DW$313	.dwtag  DW_TAG_member
	.dwattr $C$DW$313, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$313, DW_AT_name("storeGH")
	.dwattr $C$DW$313, DW_AT_data_member_location[DW_OP_plus_uconst 0x1c]
	.dwattr $C$DW$313, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$313, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$313, DW_AT_decl_line(0x51)
	.dwattr $C$DW$313, DW_AT_decl_column(0x0d)

$C$DW$314	.dwtag  DW_TAG_member
	.dwattr $C$DW$314, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$314, DW_AT_name("storeCL")
	.dwattr $C$DW$314, DW_AT_data_member_location[DW_OP_plus_uconst 0x1d]
	.dwattr $C$DW$314, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$314, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$314, DW_AT_decl_line(0x52)
	.dwattr $C$DW$314, DW_AT_decl_column(0x0d)

$C$DW$315	.dwtag  DW_TAG_member
	.dwattr $C$DW$315, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$315, DW_AT_name("speed")
	.dwattr $C$DW$315, DW_AT_data_member_location[DW_OP_plus_uconst 0x1e]
	.dwattr $C$DW$315, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$315, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$315, DW_AT_decl_line(0x53)
	.dwattr $C$DW$315, DW_AT_decl_column(0x0d)

	.dwattr $C$DW$T$23, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$T$23, DW_AT_decl_line(0x3f)
	.dwattr $C$DW$T$23, DW_AT_decl_column(0x0f)
	.dwendtag $C$DW$T$23

	.dwendtag $C$DW$TU$23


$C$DW$TU$57	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$57
$C$DW$T$57	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$57, DW_AT_name("SFRA_F32")
	.dwattr $C$DW$T$57, DW_AT_type(*$C$DW$T$23)
	.dwattr $C$DW$T$57, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra/sfra_f32.h")
	.dwattr $C$DW$T$57, DW_AT_decl_line(0x54)
	.dwattr $C$DW$T$57, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$57


$C$DW$TU$58	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$58
$C$DW$T$58	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$58, DW_AT_type(*$C$DW$T$57)
	.dwattr $C$DW$T$58, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$58


$C$DW$TU$28	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$28

$C$DW$T$28	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$28, DW_AT_byte_size(0x1e)
$C$DW$316	.dwtag  DW_TAG_member
	.dwattr $C$DW$316, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$316, DW_AT_name("iref_A")
	.dwattr $C$DW$316, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$316, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$316, DW_AT_decl_line(0x78)
	.dwattr $C$DW$316, DW_AT_decl_column(0x18)

$C$DW$317	.dwtag  DW_TAG_member
	.dwattr $C$DW$317, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$317, DW_AT_name("vref_charge_V")
	.dwattr $C$DW$317, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$317, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$317, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$317, DW_AT_decl_line(0x79)
	.dwattr $C$DW$317, DW_AT_decl_column(0x18)

$C$DW$318	.dwtag  DW_TAG_member
	.dwattr $C$DW$318, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$318, DW_AT_name("vref_discharge_V")
	.dwattr $C$DW$318, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$318, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$318, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$318, DW_AT_decl_line(0x7a)
	.dwattr $C$DW$318, DW_AT_decl_column(0x18)

$C$DW$319	.dwtag  DW_TAG_member
	.dwattr $C$DW$319, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$319, DW_AT_name("direction_logic")
	.dwattr $C$DW$319, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$319, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$319, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$319, DW_AT_decl_line(0x7b)
	.dwattr $C$DW$319, DW_AT_decl_column(0x17)

$C$DW$320	.dwtag  DW_TAG_member
	.dwattr $C$DW$320, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$320, DW_AT_name("enable_logic")
	.dwattr $C$DW$320, DW_AT_data_member_location[DW_OP_plus_uconst 0x7]
	.dwattr $C$DW$320, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$320, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$320, DW_AT_decl_line(0x7c)
	.dwattr $C$DW$320, DW_AT_decl_column(0x17)

$C$DW$321	.dwtag  DW_TAG_member
	.dwattr $C$DW$321, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$321, DW_AT_name("dutyRef_pu")
	.dwattr $C$DW$321, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$321, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$321, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$321, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$321, DW_AT_decl_column(0x18)

$C$DW$322	.dwtag  DW_TAG_member
	.dwattr $C$DW$322, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$322, DW_AT_name("ioutCal_pu")
	.dwattr $C$DW$322, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$322, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$322, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$322, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$322, DW_AT_decl_column(0x18)

$C$DW$323	.dwtag  DW_TAG_member
	.dwattr $C$DW$323, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$323, DW_AT_name("voutCal_pu")
	.dwattr $C$DW$323, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$323, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$323, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$323, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$323, DW_AT_decl_column(0x18)

$C$DW$324	.dwtag  DW_TAG_member
	.dwattr $C$DW$324, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$324, DW_AT_name("IoutGain_pu")
	.dwattr $C$DW$324, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$324, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$324, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$324, DW_AT_decl_line(0x81)
	.dwattr $C$DW$324, DW_AT_decl_column(0x0f)

$C$DW$325	.dwtag  DW_TAG_member
	.dwattr $C$DW$325, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$325, DW_AT_name("IoutOffset_pu")
	.dwattr $C$DW$325, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$325, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$325, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$325, DW_AT_decl_line(0x82)
	.dwattr $C$DW$325, DW_AT_decl_column(0x0f)

$C$DW$326	.dwtag  DW_TAG_member
	.dwattr $C$DW$326, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$326, DW_AT_name("IoutGain_A")
	.dwattr $C$DW$326, DW_AT_data_member_location[DW_OP_plus_uconst 0x12]
	.dwattr $C$DW$326, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$326, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$326, DW_AT_decl_line(0x83)
	.dwattr $C$DW$326, DW_AT_decl_column(0x0f)

$C$DW$327	.dwtag  DW_TAG_member
	.dwattr $C$DW$327, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$327, DW_AT_name("IoutOffset_A")
	.dwattr $C$DW$327, DW_AT_data_member_location[DW_OP_plus_uconst 0x14]
	.dwattr $C$DW$327, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$327, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$327, DW_AT_decl_line(0x84)
	.dwattr $C$DW$327, DW_AT_decl_column(0x0f)

$C$DW$328	.dwtag  DW_TAG_member
	.dwattr $C$DW$328, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$328, DW_AT_name("VoutGain_pu")
	.dwattr $C$DW$328, DW_AT_data_member_location[DW_OP_plus_uconst 0x16]
	.dwattr $C$DW$328, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$328, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$328, DW_AT_decl_line(0x86)
	.dwattr $C$DW$328, DW_AT_decl_column(0x0f)

$C$DW$329	.dwtag  DW_TAG_member
	.dwattr $C$DW$329, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$329, DW_AT_name("VoutOffset_pu")
	.dwattr $C$DW$329, DW_AT_data_member_location[DW_OP_plus_uconst 0x18]
	.dwattr $C$DW$329, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$329, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$329, DW_AT_decl_line(0x87)
	.dwattr $C$DW$329, DW_AT_decl_column(0x0f)

$C$DW$330	.dwtag  DW_TAG_member
	.dwattr $C$DW$330, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$330, DW_AT_name("VoutGain_V")
	.dwattr $C$DW$330, DW_AT_data_member_location[DW_OP_plus_uconst 0x1a]
	.dwattr $C$DW$330, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$330, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$330, DW_AT_decl_line(0x88)
	.dwattr $C$DW$330, DW_AT_decl_column(0x0f)

$C$DW$331	.dwtag  DW_TAG_member
	.dwattr $C$DW$331, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$331, DW_AT_name("VoutOffset_V")
	.dwattr $C$DW$331, DW_AT_data_member_location[DW_OP_plus_uconst 0x1c]
	.dwattr $C$DW$331, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$331, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$331, DW_AT_decl_line(0x89)
	.dwattr $C$DW$331, DW_AT_decl_column(0x0f)

	.dwattr $C$DW$T$28, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$28, DW_AT_decl_line(0x77)
	.dwattr $C$DW$T$28, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$28

	.dwendtag $C$DW$TU$28


$C$DW$TU$60	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$60
$C$DW$T$60	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$60, DW_AT_name("BTS_userInput")
	.dwattr $C$DW$T$60, DW_AT_type(*$C$DW$T$28)
	.dwattr $C$DW$T$60, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$60, DW_AT_decl_line(0x8b)
	.dwattr $C$DW$T$60, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$60


$C$DW$TU$61	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$61
$C$DW$T$61	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$61, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$T$61, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$61


$C$DW$TU$62	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$62
$C$DW$332	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$332, DW_AT_type(*$C$DW$T$61)

$C$DW$T$62	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$62, DW_AT_type(*$C$DW$332)

	.dwendtag $C$DW$TU$62


$C$DW$TU$29	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$29

$C$DW$T$29	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$29, DW_AT_byte_size(0x24)
$C$DW$333	.dwtag  DW_TAG_member
	.dwattr $C$DW$333, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$333, DW_AT_name("dutySet_pu")
	.dwattr $C$DW$333, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$333, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$333, DW_AT_decl_line(0x97)
	.dwattr $C$DW$333, DW_AT_decl_column(0x0f)

$C$DW$334	.dwtag  DW_TAG_member
	.dwattr $C$DW$334, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$334, DW_AT_name("dutySetRef_pu")
	.dwattr $C$DW$334, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$334, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$334, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$334, DW_AT_decl_line(0x98)
	.dwattr $C$DW$334, DW_AT_decl_column(0x0f)

$C$DW$335	.dwtag  DW_TAG_member
	.dwattr $C$DW$335, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$335, DW_AT_name("ioutRef_pu")
	.dwattr $C$DW$335, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$335, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$335, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$335, DW_AT_decl_line(0x9a)
	.dwattr $C$DW$335, DW_AT_decl_column(0x0f)

$C$DW$336	.dwtag  DW_TAG_member
	.dwattr $C$DW$336, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$336, DW_AT_name("ioutSet_pu")
	.dwattr $C$DW$336, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$336, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$336, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$336, DW_AT_decl_line(0x9b)
	.dwattr $C$DW$336, DW_AT_decl_column(0x0f)

$C$DW$337	.dwtag  DW_TAG_member
	.dwattr $C$DW$337, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$337, DW_AT_name("ioutSense_pu")
	.dwattr $C$DW$337, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$337, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$337, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$337, DW_AT_decl_line(0x9c)
	.dwattr $C$DW$337, DW_AT_decl_column(0x0f)

$C$DW$338	.dwtag  DW_TAG_member
	.dwattr $C$DW$338, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$338, DW_AT_name("voutRef_pu")
	.dwattr $C$DW$338, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$338, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$338, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$338, DW_AT_decl_line(0x9e)
	.dwattr $C$DW$338, DW_AT_decl_column(0x0f)

$C$DW$339	.dwtag  DW_TAG_member
	.dwattr $C$DW$339, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$339, DW_AT_name("voutSet_pu")
	.dwattr $C$DW$339, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$339, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$339, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$339, DW_AT_decl_line(0x9f)
	.dwattr $C$DW$339, DW_AT_decl_column(0x0f)

$C$DW$340	.dwtag  DW_TAG_member
	.dwattr $C$DW$340, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$340, DW_AT_name("voutSense_pu")
	.dwattr $C$DW$340, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$340, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$340, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$340, DW_AT_decl_line(0xa0)
	.dwattr $C$DW$340, DW_AT_decl_column(0x0f)

$C$DW$341	.dwtag  DW_TAG_member
	.dwattr $C$DW$341, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$341, DW_AT_name("uk_cc_pu")
	.dwattr $C$DW$341, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$341, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$341, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$341, DW_AT_decl_line(0xa2)
	.dwattr $C$DW$341, DW_AT_decl_column(0x0f)

$C$DW$342	.dwtag  DW_TAG_member
	.dwattr $C$DW$342, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$342, DW_AT_name("ek_cc_pu")
	.dwattr $C$DW$342, DW_AT_data_member_location[DW_OP_plus_uconst 0x12]
	.dwattr $C$DW$342, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$342, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$342, DW_AT_decl_line(0xa3)
	.dwattr $C$DW$342, DW_AT_decl_column(0x0f)

$C$DW$343	.dwtag  DW_TAG_member
	.dwattr $C$DW$343, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$343, DW_AT_name("uk_cv_pu")
	.dwattr $C$DW$343, DW_AT_data_member_location[DW_OP_plus_uconst 0x14]
	.dwattr $C$DW$343, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$343, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$343, DW_AT_decl_line(0xa4)
	.dwattr $C$DW$343, DW_AT_decl_column(0x0f)

$C$DW$344	.dwtag  DW_TAG_member
	.dwattr $C$DW$344, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$344, DW_AT_name("ek_cv_pu")
	.dwattr $C$DW$344, DW_AT_data_member_location[DW_OP_plus_uconst 0x16]
	.dwattr $C$DW$344, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$344, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$344, DW_AT_decl_line(0xa5)
	.dwattr $C$DW$344, DW_AT_decl_column(0x0f)

$C$DW$345	.dwtag  DW_TAG_member
	.dwattr $C$DW$345, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$345, DW_AT_name("direction_coeff")
	.dwattr $C$DW$345, DW_AT_data_member_location[DW_OP_plus_uconst 0x18]
	.dwattr $C$DW$345, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$345, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$345, DW_AT_decl_line(0xa6)
	.dwattr $C$DW$345, DW_AT_decl_column(0x0f)

$C$DW$346	.dwtag  DW_TAG_member
	.dwattr $C$DW$346, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$346, DW_AT_name("dutyH_pu")
	.dwattr $C$DW$346, DW_AT_data_member_location[DW_OP_plus_uconst 0x1a]
	.dwattr $C$DW$346, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$346, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$346, DW_AT_decl_line(0xa8)
	.dwattr $C$DW$346, DW_AT_decl_column(0x0f)

$C$DW$347	.dwtag  DW_TAG_member
	.dwattr $C$DW$347, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$347, DW_AT_name("dutyL_pu")
	.dwattr $C$DW$347, DW_AT_data_member_location[DW_OP_plus_uconst 0x1c]
	.dwattr $C$DW$347, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$347, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$347, DW_AT_decl_line(0xa9)
	.dwattr $C$DW$347, DW_AT_decl_column(0x0f)

$C$DW$348	.dwtag  DW_TAG_member
	.dwattr $C$DW$348, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$348, DW_AT_name("ctrlMode_logic")
	.dwattr $C$DW$348, DW_AT_data_member_location[DW_OP_plus_uconst 0x1e]
	.dwattr $C$DW$348, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$348, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$348, DW_AT_decl_line(0xab)
	.dwattr $C$DW$348, DW_AT_decl_column(0x0e)

$C$DW$349	.dwtag  DW_TAG_member
	.dwattr $C$DW$349, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$349, DW_AT_name("direction_logic")
	.dwattr $C$DW$349, DW_AT_data_member_location[DW_OP_plus_uconst 0x1f]
	.dwattr $C$DW$349, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$349, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$349, DW_AT_decl_line(0xac)
	.dwattr $C$DW$349, DW_AT_decl_column(0x0e)

$C$DW$350	.dwtag  DW_TAG_member
	.dwattr $C$DW$350, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$350, DW_AT_name("ioutTrip_16b")
	.dwattr $C$DW$350, DW_AT_data_member_location[DW_OP_plus_uconst 0x20]
	.dwattr $C$DW$350, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$350, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$350, DW_AT_decl_line(0xae)
	.dwattr $C$DW$350, DW_AT_decl_column(0x0d)

$C$DW$351	.dwtag  DW_TAG_member
	.dwattr $C$DW$351, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$351, DW_AT_name("ioutTrip_n_16b")
	.dwattr $C$DW$351, DW_AT_data_member_location[DW_OP_plus_uconst 0x21]
	.dwattr $C$DW$351, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$351, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$351, DW_AT_decl_line(0xaf)
	.dwattr $C$DW$351, DW_AT_decl_column(0x0d)

$C$DW$352	.dwtag  DW_TAG_member
	.dwattr $C$DW$352, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$352, DW_AT_name("tripFlag")
	.dwattr $C$DW$352, DW_AT_data_member_location[DW_OP_plus_uconst 0x22]
	.dwattr $C$DW$352, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$352, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$352, DW_AT_decl_line(0xb0)
	.dwattr $C$DW$352, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$29, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$29, DW_AT_decl_line(0x96)
	.dwattr $C$DW$T$29, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$29

	.dwendtag $C$DW$TU$29


$C$DW$TU$65	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$65
$C$DW$T$65	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$65, DW_AT_name("BTS_ctrlLoopVariable")
	.dwattr $C$DW$T$65, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$T$65, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$65, DW_AT_decl_line(0xb2)
	.dwattr $C$DW$T$65, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$65


$C$DW$TU$66	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$66
$C$DW$T$66	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$66, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$T$66, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$66


$C$DW$TU$67	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$67
$C$DW$353	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$353, DW_AT_type(*$C$DW$T$66)

$C$DW$T$67	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$67, DW_AT_type(*$C$DW$353)

	.dwendtag $C$DW$TU$67


$C$DW$TU$33	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$33

$C$DW$T$33	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$33, DW_AT_byte_size(0x52)
$C$DW$354	.dwtag  DW_TAG_member
	.dwattr $C$DW$354, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$354, DW_AT_name("Isense_A")
	.dwattr $C$DW$354, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$354, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$354, DW_AT_decl_line(0x5f)
	.dwattr $C$DW$354, DW_AT_decl_column(0x0f)

$C$DW$355	.dwtag  DW_TAG_member
	.dwattr $C$DW$355, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$355, DW_AT_name("Vsense_V")
	.dwattr $C$DW$355, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$355, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$355, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$355, DW_AT_decl_line(0x60)
	.dwattr $C$DW$355, DW_AT_decl_column(0x0f)

$C$DW$356	.dwtag  DW_TAG_member
	.dwattr $C$DW$356, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$356, DW_AT_name("Isense_16b")
	.dwattr $C$DW$356, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$356, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$356, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$356, DW_AT_decl_line(0x61)
	.dwattr $C$DW$356, DW_AT_decl_column(0x0d)

$C$DW$357	.dwtag  DW_TAG_member
	.dwattr $C$DW$357, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$357, DW_AT_name("Vsense_16b")
	.dwattr $C$DW$357, DW_AT_data_member_location[DW_OP_plus_uconst 0x24]
	.dwattr $C$DW$357, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$357, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$357, DW_AT_decl_line(0x62)
	.dwattr $C$DW$357, DW_AT_decl_column(0x0d)

$C$DW$358	.dwtag  DW_TAG_member
	.dwattr $C$DW$358, DW_AT_type(*$C$DW$T$32)
	.dwattr $C$DW$358, DW_AT_name("Sum_I")
	.dwattr $C$DW$358, DW_AT_data_member_location[DW_OP_plus_uconst 0x44]
	.dwattr $C$DW$358, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$358, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$358, DW_AT_decl_line(0x63)
	.dwattr $C$DW$358, DW_AT_decl_column(0x0d)

$C$DW$359	.dwtag  DW_TAG_member
	.dwattr $C$DW$359, DW_AT_type(*$C$DW$T$32)
	.dwattr $C$DW$359, DW_AT_name("Sum_V")
	.dwattr $C$DW$359, DW_AT_data_member_location[DW_OP_plus_uconst 0x46]
	.dwattr $C$DW$359, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$359, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$359, DW_AT_decl_line(0x64)
	.dwattr $C$DW$359, DW_AT_decl_column(0x0d)

$C$DW$360	.dwtag  DW_TAG_member
	.dwattr $C$DW$360, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$360, DW_AT_name("Index")
	.dwattr $C$DW$360, DW_AT_data_member_location[DW_OP_plus_uconst 0x48]
	.dwattr $C$DW$360, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$360, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$360, DW_AT_decl_line(0x65)
	.dwattr $C$DW$360, DW_AT_decl_column(0x0e)

$C$DW$361	.dwtag  DW_TAG_member
	.dwattr $C$DW$361, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$361, DW_AT_name("IoutGain_A")
	.dwattr $C$DW$361, DW_AT_data_member_location[DW_OP_plus_uconst 0x4a]
	.dwattr $C$DW$361, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$361, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$361, DW_AT_decl_line(0x66)
	.dwattr $C$DW$361, DW_AT_decl_column(0x0f)

$C$DW$362	.dwtag  DW_TAG_member
	.dwattr $C$DW$362, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$362, DW_AT_name("IoutOffset_A")
	.dwattr $C$DW$362, DW_AT_data_member_location[DW_OP_plus_uconst 0x4c]
	.dwattr $C$DW$362, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$362, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$362, DW_AT_decl_line(0x67)
	.dwattr $C$DW$362, DW_AT_decl_column(0x0f)

$C$DW$363	.dwtag  DW_TAG_member
	.dwattr $C$DW$363, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$363, DW_AT_name("VoutGain_V")
	.dwattr $C$DW$363, DW_AT_data_member_location[DW_OP_plus_uconst 0x4e]
	.dwattr $C$DW$363, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$363, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$363, DW_AT_decl_line(0x68)
	.dwattr $C$DW$363, DW_AT_decl_column(0x0f)

$C$DW$364	.dwtag  DW_TAG_member
	.dwattr $C$DW$364, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$364, DW_AT_name("VoutOffset_V")
	.dwattr $C$DW$364, DW_AT_data_member_location[DW_OP_plus_uconst 0x50]
	.dwattr $C$DW$364, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$364, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$364, DW_AT_decl_line(0x69)
	.dwattr $C$DW$364, DW_AT_decl_column(0x0f)

	.dwattr $C$DW$T$33, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$33, DW_AT_decl_line(0x5e)
	.dwattr $C$DW$T$33, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$33

	.dwendtag $C$DW$TU$33


$C$DW$TU$70	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$70
$C$DW$T$70	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$70, DW_AT_name("BTS_measValues")
	.dwattr $C$DW$T$70, DW_AT_type(*$C$DW$T$33)
	.dwattr $C$DW$T$70, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$70, DW_AT_decl_line(0x6b)
	.dwattr $C$DW$T$70, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$70


$C$DW$TU$71	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$71
$C$DW$T$71	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$71, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$T$71, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$71


$C$DW$TU$72	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$72
$C$DW$365	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$365, DW_AT_type(*$C$DW$T$71)

$C$DW$T$72	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$72, DW_AT_type(*$C$DW$365)

	.dwendtag $C$DW$TU$72


$C$DW$TU$35	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$35

$C$DW$T$35	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$35, DW_AT_byte_size(0x406)
$C$DW$366	.dwtag  DW_TAG_member
	.dwattr $C$DW$366, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$366, DW_AT_name("plantMagVect")
	.dwattr $C$DW$366, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$366, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$366, DW_AT_decl_line(0x149)
	.dwattr $C$DW$366, DW_AT_decl_column(0x14)

$C$DW$367	.dwtag  DW_TAG_member
	.dwattr $C$DW$367, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$367, DW_AT_name("plantPhaseVect")
	.dwattr $C$DW$367, DW_AT_data_member_location[DW_OP_plus_uconst 0xce]
	.dwattr $C$DW$367, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$367, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$367, DW_AT_decl_line(0x14a)
	.dwattr $C$DW$367, DW_AT_decl_column(0x14)

$C$DW$368	.dwtag  DW_TAG_member
	.dwattr $C$DW$368, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$368, DW_AT_name("olMagVect")
	.dwattr $C$DW$368, DW_AT_data_member_location[DW_OP_plus_uconst 0x19c]
	.dwattr $C$DW$368, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$368, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$368, DW_AT_decl_line(0x14b)
	.dwattr $C$DW$368, DW_AT_decl_column(0x14)

$C$DW$369	.dwtag  DW_TAG_member
	.dwattr $C$DW$369, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$369, DW_AT_name("olPhaseVect")
	.dwattr $C$DW$369, DW_AT_data_member_location[DW_OP_plus_uconst 0x26a]
	.dwattr $C$DW$369, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$369, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$369, DW_AT_decl_line(0x14c)
	.dwattr $C$DW$369, DW_AT_decl_column(0x14)

$C$DW$370	.dwtag  DW_TAG_member
	.dwattr $C$DW$370, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$370, DW_AT_name("freqVect")
	.dwattr $C$DW$370, DW_AT_data_member_location[DW_OP_plus_uconst 0x338]
	.dwattr $C$DW$370, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$370, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$370, DW_AT_decl_line(0x14d)
	.dwattr $C$DW$370, DW_AT_decl_column(0x14)

	.dwattr $C$DW$T$35, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$35, DW_AT_decl_line(0x148)
	.dwattr $C$DW$T$35, DW_AT_decl_column(0x14)
	.dwendtag $C$DW$T$35

	.dwendtag $C$DW$TU$35


$C$DW$TU$75	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$75
$C$DW$T$75	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$75, DW_AT_name("BTS_SfraDataType")
	.dwattr $C$DW$T$75, DW_AT_type(*$C$DW$T$35)
	.dwattr $C$DW$T$75, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$75, DW_AT_decl_line(0x14e)
	.dwattr $C$DW$T$75, DW_AT_decl_column(0x07)

	.dwendtag $C$DW$TU$75


$C$DW$TU$41	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$41

$C$DW$T$41	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$41, DW_AT_name("I2CHandle")
	.dwattr $C$DW$T$41, DW_AT_byte_size(0x12)
$C$DW$371	.dwtag  DW_TAG_member
	.dwattr $C$DW$371, DW_AT_type(*$C$DW$T$37)
	.dwattr $C$DW$371, DW_AT_name("base")
	.dwattr $C$DW$371, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$371, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\i2cLib_FIFO_master_slave_interrupt.h")
	.dwattr $C$DW$371, DW_AT_decl_line(0x48)
	.dwattr $C$DW$371, DW_AT_decl_column(0x0e)

$C$DW$372	.dwtag  DW_TAG_member
	.dwattr $C$DW$372, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$372, DW_AT_name("SlaveAddr")
	.dwattr $C$DW$372, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$372, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$372, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\i2cLib_FIFO_master_slave_interrupt.h")
	.dwattr $C$DW$372, DW_AT_decl_line(0x49)
	.dwattr $C$DW$372, DW_AT_decl_column(0x0e)

$C$DW$373	.dwtag  DW_TAG_member
	.dwattr $C$DW$373, DW_AT_type(*$C$DW$T$38)
	.dwattr $C$DW$373, DW_AT_name("pControlAddr")
	.dwattr $C$DW$373, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$373, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$373, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\i2cLib_FIFO_master_slave_interrupt.h")
	.dwattr $C$DW$373, DW_AT_decl_line(0x4a)
	.dwattr $C$DW$373, DW_AT_decl_column(0x0f)

$C$DW$374	.dwtag  DW_TAG_member
	.dwattr $C$DW$374, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$374, DW_AT_name("NumOfAddrBytes")
	.dwattr $C$DW$374, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$374, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$374, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\i2cLib_FIFO_master_slave_interrupt.h")
	.dwattr $C$DW$374, DW_AT_decl_line(0x4b)
	.dwattr $C$DW$374, DW_AT_decl_column(0x0e)

$C$DW$375	.dwtag  DW_TAG_member
	.dwattr $C$DW$375, DW_AT_type(*$C$DW$T$39)
	.dwattr $C$DW$375, DW_AT_name("pTX_MsgBuffer")
	.dwattr $C$DW$375, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$375, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$375, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\i2cLib_FIFO_master_slave_interrupt.h")
	.dwattr $C$DW$375, DW_AT_decl_line(0x4c)
	.dwattr $C$DW$375, DW_AT_decl_column(0x0f)

$C$DW$376	.dwtag  DW_TAG_member
	.dwattr $C$DW$376, DW_AT_type(*$C$DW$T$39)
	.dwattr $C$DW$376, DW_AT_name("pRX_MsgBuffer")
	.dwattr $C$DW$376, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$376, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$376, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\i2cLib_FIFO_master_slave_interrupt.h")
	.dwattr $C$DW$376, DW_AT_decl_line(0x4d)
	.dwattr $C$DW$376, DW_AT_decl_column(0x0f)

$C$DW$377	.dwtag  DW_TAG_member
	.dwattr $C$DW$377, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$377, DW_AT_name("NumOfDataBytes")
	.dwattr $C$DW$377, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$377, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$377, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\i2cLib_FIFO_master_slave_interrupt.h")
	.dwattr $C$DW$377, DW_AT_decl_line(0x4e)
	.dwattr $C$DW$377, DW_AT_decl_column(0x0e)

$C$DW$378	.dwtag  DW_TAG_member
	.dwattr $C$DW$378, DW_AT_type(*$C$DW$T$40)
	.dwattr $C$DW$378, DW_AT_name("currentHandlePtr")
	.dwattr $C$DW$378, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$378, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$378, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\i2cLib_FIFO_master_slave_interrupt.h")
	.dwattr $C$DW$378, DW_AT_decl_line(0x4f)
	.dwattr $C$DW$378, DW_AT_decl_column(0x17)

$C$DW$379	.dwtag  DW_TAG_member
	.dwattr $C$DW$379, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$379, DW_AT_name("numofSixteenByte")
	.dwattr $C$DW$379, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$379, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$379, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\i2cLib_FIFO_master_slave_interrupt.h")
	.dwattr $C$DW$379, DW_AT_decl_line(0x51)
	.dwattr $C$DW$379, DW_AT_decl_column(0x0e)

$C$DW$380	.dwtag  DW_TAG_member
	.dwattr $C$DW$380, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$380, DW_AT_name("remainingBytes")
	.dwattr $C$DW$380, DW_AT_data_member_location[DW_OP_plus_uconst 0x11]
	.dwattr $C$DW$380, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$380, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\i2cLib_FIFO_master_slave_interrupt.h")
	.dwattr $C$DW$380, DW_AT_decl_line(0x52)
	.dwattr $C$DW$380, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$41, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\i2cLib_FIFO_master_slave_interrupt.h")
	.dwattr $C$DW$T$41, DW_AT_decl_line(0x46)
	.dwattr $C$DW$T$41, DW_AT_decl_column(0x08)
	.dwendtag $C$DW$T$41

	.dwendtag $C$DW$TU$41


$C$DW$TU$40	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$40
$C$DW$T$40	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$40, DW_AT_type(*$C$DW$T$41)
	.dwattr $C$DW$T$40, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$40


$C$DW$TU$43	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$43

$C$DW$T$43	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$43, DW_AT_name("_Complex_double")
	.dwattr $C$DW$T$43, DW_AT_byte_size(0x08)
$C$DW$381	.dwtag  DW_TAG_member
	.dwattr $C$DW$381, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$381, DW_AT_name("_Vals")
	.dwattr $C$DW$381, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$381, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$381, DW_AT_decl_line(0xe9)
	.dwattr $C$DW$381, DW_AT_decl_column(0x18)

	.dwendtag $C$DW$T$43

	.dwendtag $C$DW$TU$43


$C$DW$TU$77	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$77
$C$DW$T$77	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$77, DW_AT_name("_Complex_double")
	.dwattr $C$DW$T$77, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$T$77, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$T$77, DW_AT_decl_line(0xe9)
	.dwattr $C$DW$T$77, DW_AT_decl_column(0x18)

	.dwendtag $C$DW$TU$77


$C$DW$TU$45	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$45

$C$DW$T$45	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$45, DW_AT_name("_Complex_float")
	.dwattr $C$DW$T$45, DW_AT_byte_size(0x04)
$C$DW$382	.dwtag  DW_TAG_member
	.dwattr $C$DW$382, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$382, DW_AT_name("_Vals")
	.dwattr $C$DW$382, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$382, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$382, DW_AT_decl_line(0xe9)
	.dwattr $C$DW$382, DW_AT_decl_column(0x18)

	.dwendtag $C$DW$T$45

	.dwendtag $C$DW$TU$45


$C$DW$TU$78	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$78
$C$DW$T$78	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$78, DW_AT_name("_Complex_float")
	.dwattr $C$DW$T$78, DW_AT_type(*$C$DW$T$45)
	.dwattr $C$DW$T$78, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$T$78, DW_AT_decl_line(0xe9)
	.dwattr $C$DW$T$78, DW_AT_decl_column(0x18)

	.dwendtag $C$DW$TU$78


$C$DW$TU$47	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$47

$C$DW$T$47	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$47, DW_AT_name("_Complex_long_double")
	.dwattr $C$DW$T$47, DW_AT_byte_size(0x08)
$C$DW$383	.dwtag  DW_TAG_member
	.dwattr $C$DW$383, DW_AT_type(*$C$DW$T$46)
	.dwattr $C$DW$383, DW_AT_name("_Vals")
	.dwattr $C$DW$383, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$383, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$383, DW_AT_decl_line(0xe9)
	.dwattr $C$DW$383, DW_AT_decl_column(0x18)

	.dwendtag $C$DW$T$47

	.dwendtag $C$DW$TU$47


$C$DW$TU$80	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$80
$C$DW$T$80	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$80, DW_AT_name("_Complex_long_double")
	.dwattr $C$DW$T$80, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$T$80, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\bts_hal.h")
	.dwattr $C$DW$T$80, DW_AT_decl_line(0xe9)
	.dwattr $C$DW$T$80, DW_AT_decl_column(0x18)

	.dwendtag $C$DW$TU$80


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


$C$DW$TU$21	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$21
$C$DW$T$21	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$21, DW_AT_name("__int16_t")
	.dwattr $C$DW$T$21, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$21, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$21, DW_AT_decl_line(0x40)
	.dwattr $C$DW$T$21, DW_AT_decl_column(0x1d)

	.dwendtag $C$DW$TU$21


$C$DW$TU$22	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$22
$C$DW$T$22	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$22, DW_AT_name("int16_t")
	.dwattr $C$DW$T$22, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$T$22, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$22, DW_AT_decl_line(0x2b)
	.dwattr $C$DW$T$22, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$22


$C$DW$TU$30	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$30

$C$DW$T$30	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$30, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$T$30, DW_AT_byte_size(0x20)
$C$DW$384	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$384, DW_AT_upper_bound(0x1f)

	.dwendtag $C$DW$T$30

	.dwendtag $C$DW$TU$30


$C$DW$TU$11	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$11
$C$DW$T$11	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$11, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$11, DW_AT_name("unsigned int")
	.dwattr $C$DW$T$11, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$11


$C$DW$TU$25	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$25
$C$DW$T$25	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$25, DW_AT_name("__uint16_t")
	.dwattr $C$DW$T$25, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$T$25, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$25, DW_AT_decl_line(0x41)
	.dwattr $C$DW$T$25, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$25


$C$DW$TU$26	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$26
$C$DW$T$26	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$26, DW_AT_name("uint16_t")
	.dwattr $C$DW$T$26, DW_AT_type(*$C$DW$T$25)
	.dwattr $C$DW$T$26, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$26, DW_AT_decl_line(0x41)
	.dwattr $C$DW$T$26, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$26


$C$DW$TU$39	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$39
$C$DW$T$39	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$39, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$T$39, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$39


$C$DW$TU$109	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$109

$C$DW$T$109	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$109, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$T$109, DW_AT_byte_size(0x14)
$C$DW$385	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$385, DW_AT_upper_bound(0x13)

	.dwendtag $C$DW$T$109

	.dwendtag $C$DW$TU$109


$C$DW$TU$110	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$110

$C$DW$T$110	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$110, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$T$110, DW_AT_byte_size(0x40)
$C$DW$386	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$386, DW_AT_upper_bound(0x3f)

	.dwendtag $C$DW$T$110

	.dwendtag $C$DW$TU$110


$C$DW$TU$27	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$27
$C$DW$387	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$387, DW_AT_type(*$C$DW$T$26)

$C$DW$T$27	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$27, DW_AT_type(*$C$DW$387)

	.dwendtag $C$DW$TU$27


$C$DW$TU$12	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$12
$C$DW$T$12	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$12, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$12, DW_AT_name("long")
	.dwattr $C$DW$T$12, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$12


$C$DW$TU$31	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$31
$C$DW$T$31	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$31, DW_AT_name("__int32_t")
	.dwattr $C$DW$T$31, DW_AT_type(*$C$DW$T$12)
	.dwattr $C$DW$T$31, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$31, DW_AT_decl_line(0x42)
	.dwattr $C$DW$T$31, DW_AT_decl_column(0x1d)

	.dwendtag $C$DW$TU$31


$C$DW$TU$32	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$32
$C$DW$T$32	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$32, DW_AT_name("int32_t")
	.dwattr $C$DW$T$32, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$T$32, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$32, DW_AT_decl_line(0x30)
	.dwattr $C$DW$T$32, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$32


$C$DW$TU$13	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$13
$C$DW$T$13	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$13, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$13, DW_AT_name("unsigned long")
	.dwattr $C$DW$T$13, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$13


$C$DW$TU$36	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$36
$C$DW$T$36	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$36, DW_AT_name("__uint32_t")
	.dwattr $C$DW$T$36, DW_AT_type(*$C$DW$T$13)
	.dwattr $C$DW$T$36, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$36, DW_AT_decl_line(0x43)
	.dwattr $C$DW$T$36, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$36


$C$DW$TU$37	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$37
$C$DW$T$37	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$37, DW_AT_name("uint32_t")
	.dwattr $C$DW$T$37, DW_AT_type(*$C$DW$T$36)
	.dwattr $C$DW$T$37, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$37, DW_AT_decl_line(0x46)
	.dwattr $C$DW$T$37, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$37


$C$DW$TU$38	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$38
$C$DW$T$38	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$38, DW_AT_type(*$C$DW$T$37)
	.dwattr $C$DW$T$38, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$38


$C$DW$TU$92	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$92
$C$DW$388	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$388, DW_AT_type(*$C$DW$T$37)

$C$DW$T$92	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$92, DW_AT_type(*$C$DW$388)

	.dwendtag $C$DW$TU$92


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


$C$DW$TU$44	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$44

$C$DW$T$44	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$44, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$T$44, DW_AT_byte_size(0x04)
$C$DW$389	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$389, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$44

	.dwendtag $C$DW$TU$44


$C$DW$TU$120	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$120
$C$DW$390	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$390, DW_AT_type(*$C$DW$T$16)

$C$DW$T$120	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$120, DW_AT_type(*$C$DW$390)

	.dwendtag $C$DW$TU$120


$C$DW$TU$19	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$19
$C$DW$T$19	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$19, DW_AT_name("float32_t")
	.dwattr $C$DW$T$19, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$T$19, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\inc/hw_types.h")
	.dwattr $C$DW$T$19, DW_AT_decl_line(0x5e)
	.dwattr $C$DW$T$19, DW_AT_decl_column(0x17)

	.dwendtag $C$DW$TU$19


$C$DW$TU$20	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$20
$C$DW$T$20	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$20, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$T$20, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$20


$C$DW$TU$34	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$34

$C$DW$T$34	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$34, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$T$34, DW_AT_byte_size(0xce)
$C$DW$391	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$391, DW_AT_upper_bound(0x66)

	.dwendtag $C$DW$T$34

	.dwendtag $C$DW$TU$34


$C$DW$TU$24	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$24
$C$DW$392	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$392, DW_AT_type(*$C$DW$T$19)

$C$DW$T$24	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$24, DW_AT_type(*$C$DW$392)

	.dwendtag $C$DW$TU$24


$C$DW$TU$17	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$17
$C$DW$T$17	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$17, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$17, DW_AT_name("double")
	.dwattr $C$DW$T$17, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$17


$C$DW$TU$42	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$42

$C$DW$T$42	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$42, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$T$42, DW_AT_byte_size(0x08)
$C$DW$393	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$393, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$42

	.dwendtag $C$DW$TU$42


$C$DW$TU$122	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$122
$C$DW$T$122	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$122, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$T$122, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$122


$C$DW$TU$123	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$123
$C$DW$394	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$394, DW_AT_type(*$C$DW$T$122)

$C$DW$T$123	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$123, DW_AT_type(*$C$DW$394)

	.dwendtag $C$DW$TU$123


$C$DW$TU$18	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$18
$C$DW$T$18	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$18, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$18, DW_AT_name("long double")
	.dwattr $C$DW$T$18, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$18


$C$DW$TU$46	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$46

$C$DW$T$46	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$46, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$46, DW_AT_byte_size(0x08)
$C$DW$395	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$395, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$46

	.dwendtag $C$DW$TU$46


$C$DW$TU$125	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$125
$C$DW$T$125	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$125, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$125, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$125


$C$DW$TU$126	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$126
$C$DW$396	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$396, DW_AT_type(*$C$DW$T$125)

$C$DW$T$126	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$126, DW_AT_type(*$C$DW$396)

	.dwendtag $C$DW$TU$126


$C$DW$TU$48	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$48

$C$DW$T$48	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$48, DW_AT_name("dcl_css")
	.dwattr $C$DW$T$48, DW_AT_byte_size(0x0a)
$C$DW$397	.dwtag  DW_TAG_member
	.dwattr $C$DW$397, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$397, DW_AT_name("tpt")
	.dwattr $C$DW$397, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$397, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$397, DW_AT_decl_line(0x91)
	.dwattr $C$DW$397, DW_AT_decl_column(0x0f)

$C$DW$398	.dwtag  DW_TAG_member
	.dwattr $C$DW$398, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$398, DW_AT_name("T")
	.dwattr $C$DW$398, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$398, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$398, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$398, DW_AT_decl_line(0x92)
	.dwattr $C$DW$398, DW_AT_decl_column(0x0f)

$C$DW$399	.dwtag  DW_TAG_member
	.dwattr $C$DW$399, DW_AT_type(*$C$DW$T$37)
	.dwattr $C$DW$399, DW_AT_name("sts")
	.dwattr $C$DW$399, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$399, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$399, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$399, DW_AT_decl_line(0x93)
	.dwattr $C$DW$399, DW_AT_decl_column(0x0e)

$C$DW$400	.dwtag  DW_TAG_member
	.dwattr $C$DW$400, DW_AT_type(*$C$DW$T$37)
	.dwattr $C$DW$400, DW_AT_name("err")
	.dwattr $C$DW$400, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$400, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$400, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$400, DW_AT_decl_line(0x94)
	.dwattr $C$DW$400, DW_AT_decl_column(0x0e)

$C$DW$401	.dwtag  DW_TAG_member
	.dwattr $C$DW$401, DW_AT_type(*$C$DW$T$37)
	.dwattr $C$DW$401, DW_AT_name("loc")
	.dwattr $C$DW$401, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$401, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$401, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$401, DW_AT_decl_line(0x95)
	.dwattr $C$DW$401, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$48, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$T$48, DW_AT_decl_line(0x90)
	.dwattr $C$DW$T$48, DW_AT_decl_column(0x19)
	.dwendtag $C$DW$T$48

	.dwendtag $C$DW$TU$48


$C$DW$TU$52	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$52
$C$DW$402	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$402, DW_AT_type(*$C$DW$T$48)

$C$DW$T$52	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$52, DW_AT_type(*$C$DW$402)

	.dwendtag $C$DW$TU$52


$C$DW$TU$53	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$53
$C$DW$T$53	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$53, DW_AT_name("DCL_CSS")
	.dwattr $C$DW$T$53, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$T$53, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$T$53, DW_AT_decl_line(0x96)
	.dwattr $C$DW$T$53, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$53


$C$DW$TU$54	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$54
$C$DW$T$54	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$54, DW_AT_type(*$C$DW$T$53)
	.dwattr $C$DW$T$54, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$54


$C$DW$TU$55	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$55

$C$DW$T$55	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$55, DW_AT_name("dcl_df22")
	.dwattr $C$DW$T$55, DW_AT_byte_size(0x12)
$C$DW$403	.dwtag  DW_TAG_member
	.dwattr $C$DW$403, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$403, DW_AT_name("b0")
	.dwattr $C$DW$403, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$403, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$403, DW_AT_decl_line(0x4ab)
	.dwattr $C$DW$403, DW_AT_decl_column(0x0f)

$C$DW$404	.dwtag  DW_TAG_member
	.dwattr $C$DW$404, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$404, DW_AT_name("b1")
	.dwattr $C$DW$404, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$404, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$404, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$404, DW_AT_decl_line(0x4ac)
	.dwattr $C$DW$404, DW_AT_decl_column(0x0f)

$C$DW$405	.dwtag  DW_TAG_member
	.dwattr $C$DW$405, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$405, DW_AT_name("b2")
	.dwattr $C$DW$405, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$405, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$405, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$405, DW_AT_decl_line(0x4ad)
	.dwattr $C$DW$405, DW_AT_decl_column(0x0f)

$C$DW$406	.dwtag  DW_TAG_member
	.dwattr $C$DW$406, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$406, DW_AT_name("a1")
	.dwattr $C$DW$406, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$406, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$406, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$406, DW_AT_decl_line(0x4ae)
	.dwattr $C$DW$406, DW_AT_decl_column(0x0f)

$C$DW$407	.dwtag  DW_TAG_member
	.dwattr $C$DW$407, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$407, DW_AT_name("a2")
	.dwattr $C$DW$407, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$407, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$407, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$407, DW_AT_decl_line(0x4af)
	.dwattr $C$DW$407, DW_AT_decl_column(0x0f)

$C$DW$408	.dwtag  DW_TAG_member
	.dwattr $C$DW$408, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$408, DW_AT_name("x1")
	.dwattr $C$DW$408, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$408, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$408, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$408, DW_AT_decl_line(0x4b0)
	.dwattr $C$DW$408, DW_AT_decl_column(0x0f)

$C$DW$409	.dwtag  DW_TAG_member
	.dwattr $C$DW$409, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$409, DW_AT_name("x2")
	.dwattr $C$DW$409, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$409, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$409, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$409, DW_AT_decl_line(0x4b1)
	.dwattr $C$DW$409, DW_AT_decl_column(0x0f)

$C$DW$410	.dwtag  DW_TAG_member
	.dwattr $C$DW$410, DW_AT_type(*$C$DW$T$51)
	.dwattr $C$DW$410, DW_AT_name("sps")
	.dwattr $C$DW$410, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$410, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$410, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$410, DW_AT_decl_line(0x4b2)
	.dwattr $C$DW$410, DW_AT_decl_column(0x13)

$C$DW$411	.dwtag  DW_TAG_member
	.dwattr $C$DW$411, DW_AT_type(*$C$DW$T$54)
	.dwattr $C$DW$411, DW_AT_name("css")
	.dwattr $C$DW$411, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$411, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$411, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$411, DW_AT_decl_line(0x4b3)
	.dwattr $C$DW$411, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$55, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$55, DW_AT_decl_line(0x4aa)
	.dwattr $C$DW$T$55, DW_AT_decl_column(0x19)
	.dwendtag $C$DW$T$55

	.dwendtag $C$DW$TU$55


$C$DW$TU$128	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$128
$C$DW$412	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$412, DW_AT_type(*$C$DW$T$55)

$C$DW$T$128	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$128, DW_AT_type(*$C$DW$412)

	.dwendtag $C$DW$TU$128


$C$DW$TU$129	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$129
$C$DW$T$129	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$129, DW_AT_name("DCL_DF22")
	.dwattr $C$DW$T$129, DW_AT_type(*$C$DW$T$128)
	.dwattr $C$DW$T$129, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$129, DW_AT_decl_line(0x4b4)
	.dwattr $C$DW$T$129, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$129


$C$DW$TU$56	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$56

$C$DW$T$56	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$56, DW_AT_name("dcl_df22_sps")
	.dwattr $C$DW$T$56, DW_AT_byte_size(0x0a)
$C$DW$413	.dwtag  DW_TAG_member
	.dwattr $C$DW$413, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$413, DW_AT_name("b0")
	.dwattr $C$DW$413, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$413, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$413, DW_AT_decl_line(0x49f)
	.dwattr $C$DW$413, DW_AT_decl_column(0x0f)

$C$DW$414	.dwtag  DW_TAG_member
	.dwattr $C$DW$414, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$414, DW_AT_name("b1")
	.dwattr $C$DW$414, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$414, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$414, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$414, DW_AT_decl_line(0x4a0)
	.dwattr $C$DW$414, DW_AT_decl_column(0x0f)

$C$DW$415	.dwtag  DW_TAG_member
	.dwattr $C$DW$415, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$415, DW_AT_name("b2")
	.dwattr $C$DW$415, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$415, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$415, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$415, DW_AT_decl_line(0x4a1)
	.dwattr $C$DW$415, DW_AT_decl_column(0x0f)

$C$DW$416	.dwtag  DW_TAG_member
	.dwattr $C$DW$416, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$416, DW_AT_name("a1")
	.dwattr $C$DW$416, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$416, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$416, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$416, DW_AT_decl_line(0x4a2)
	.dwattr $C$DW$416, DW_AT_decl_column(0x0f)

$C$DW$417	.dwtag  DW_TAG_member
	.dwattr $C$DW$417, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$417, DW_AT_name("a2")
	.dwattr $C$DW$417, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$417, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$417, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$417, DW_AT_decl_line(0x4a3)
	.dwattr $C$DW$417, DW_AT_decl_column(0x0f)

	.dwattr $C$DW$T$56, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$56, DW_AT_decl_line(0x49e)
	.dwattr $C$DW$T$56, DW_AT_decl_column(0x19)
	.dwendtag $C$DW$T$56

	.dwendtag $C$DW$TU$56


$C$DW$TU$49	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$49
$C$DW$418	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$418, DW_AT_type(*$C$DW$T$56)

$C$DW$T$49	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$49, DW_AT_type(*$C$DW$418)

	.dwendtag $C$DW$TU$49


$C$DW$TU$50	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$50
$C$DW$T$50	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$50, DW_AT_name("DCL_DF22_SPS")
	.dwattr $C$DW$T$50, DW_AT_type(*$C$DW$T$49)
	.dwattr $C$DW$T$50, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$50, DW_AT_decl_line(0x4a4)
	.dwattr $C$DW$T$50, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$50


$C$DW$TU$51	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$51
$C$DW$T$51	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$51, DW_AT_type(*$C$DW$T$50)
	.dwattr $C$DW$T$51, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$51

