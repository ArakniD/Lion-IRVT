;***************************************************************
;* TMS320C2000 G3 C/C++ Codegen                               PC v20.2.4.LTS *
;* Date/Time created: Mon Jan 11 05:48:46 2021                 *
;***************************************************************
	.compiler_opts --abi=eabi --cla_support=cla1 --diag_wrap=off --float_support=fpu32 --hll_source=on --mem_model:code=flat --mem_model:data=large --object_format=elf --quiet --silicon_errata_fpu1_workaround=off --silicon_version=28 --symdebug:dwarf --symdebug:dwarf_version=4 --tmu_support=tmu0 --vcu_support=vcu2 
	.asg	XAR2, FP

$C$DW$CU	.dwtag  DW_TAG_compile_unit
	.dwattr $C$DW$CU, DW_AT_name("../bts.c")
	.dwattr $C$DW$CU, DW_AT_producer("TI TMS320C2000 G3 C/C++ Codegen PC v20.2.4.LTS Copyright (c) 1996-2018 Texas Instruments Incorporated")
	.dwattr $C$DW$CU, DW_AT_TI_version(0x01)
	.dwattr $C$DW$CU, DW_AT_comp_dir("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\RELEASE")
	.global	||BUCK_sfoStatus||
	.bss	||BUCK_sfoStatus||,1,1,0
$C$DW$1	.dwtag  DW_TAG_variable
	.dwattr $C$DW$1, DW_AT_name("BUCK_sfoStatus")
	.dwattr $C$DW$1, DW_AT_linkage_name("BUCK_sfoStatus")
	.dwattr $C$DW$1, DW_AT_location[DW_OP_addr ||BUCK_sfoStatus||]
	.dwattr $C$DW$1, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$1, DW_AT_external
	.dwattr $C$DW$1, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$1, DW_AT_decl_line(0x53)
	.dwattr $C$DW$1, DW_AT_decl_column(0x16)

	.global	||BTS_sfoStatus||
	.bss	||BTS_sfoStatus||,1,1,0
$C$DW$2	.dwtag  DW_TAG_variable
	.dwattr $C$DW$2, DW_AT_name("BTS_sfoStatus")
	.dwattr $C$DW$2, DW_AT_linkage_name("BTS_sfoStatus")
	.dwattr $C$DW$2, DW_AT_location[DW_OP_addr ||BTS_sfoStatus||]
	.dwattr $C$DW$2, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$2, DW_AT_external
	.dwattr $C$DW$2, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$2, DW_AT_decl_line(0x54)
	.dwattr $C$DW$2, DW_AT_decl_column(0x16)


$C$DW$3	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$3, DW_AT_name("SFO")
	.dwattr $C$DW$3, DW_AT_linkage_name("SFO")
	.dwattr $C$DW$3, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$3, DW_AT_declaration
	.dwattr $C$DW$3, DW_AT_external
	.dwattr $C$DW$3, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/SFO/SFO_V8.h")
	.dwattr $C$DW$3, DW_AT_decl_line(0x40)
	.dwattr $C$DW$3, DW_AT_decl_column(0x05)
	.dwendtag $C$DW$3

	.global	||MEP_ScaleFactor||
	.bss	||MEP_ScaleFactor||,2,1,1
$C$DW$4	.dwtag  DW_TAG_variable
	.dwattr $C$DW$4, DW_AT_name("MEP_ScaleFactor")
	.dwattr $C$DW$4, DW_AT_linkage_name("MEP_ScaleFactor")
	.dwattr $C$DW$4, DW_AT_location[DW_OP_addr ||MEP_ScaleFactor||]
	.dwattr $C$DW$4, DW_AT_type(*$C$DW$T$39)
	.dwattr $C$DW$4, DW_AT_external
	.dwattr $C$DW$4, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$4, DW_AT_decl_line(0x52)
	.dwattr $C$DW$4, DW_AT_decl_column(0x16)

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

$C$DW$5	.dwtag  DW_TAG_variable
	.dwattr $C$DW$5, DW_AT_name("BTS_ctrl_cc_ch1")
	.dwattr $C$DW$5, DW_AT_linkage_name("BTS_ctrl_cc_ch1")
	.dwattr $C$DW$5, DW_AT_location[DW_OP_addr ||BTS_ctrl_cc_ch1||]
	.dwattr $C$DW$5, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$5, DW_AT_external
	.dwattr $C$DW$5, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$5, DW_AT_decl_line(0x33)
	.dwattr $C$DW$5, DW_AT_decl_column(0x15)

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

$C$DW$6	.dwtag  DW_TAG_variable
	.dwattr $C$DW$6, DW_AT_name("BTS_ctrl_cc_ch2")
	.dwattr $C$DW$6, DW_AT_linkage_name("BTS_ctrl_cc_ch2")
	.dwattr $C$DW$6, DW_AT_location[DW_OP_addr ||BTS_ctrl_cc_ch2||]
	.dwattr $C$DW$6, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$6, DW_AT_external
	.dwattr $C$DW$6, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$6, DW_AT_decl_line(0x34)
	.dwattr $C$DW$6, DW_AT_decl_column(0x15)

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

$C$DW$7	.dwtag  DW_TAG_variable
	.dwattr $C$DW$7, DW_AT_name("BTS_ctrl_cc_ch3")
	.dwattr $C$DW$7, DW_AT_linkage_name("BTS_ctrl_cc_ch3")
	.dwattr $C$DW$7, DW_AT_location[DW_OP_addr ||BTS_ctrl_cc_ch3||]
	.dwattr $C$DW$7, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$7, DW_AT_external
	.dwattr $C$DW$7, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$7, DW_AT_decl_line(0x35)
	.dwattr $C$DW$7, DW_AT_decl_column(0x15)

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

$C$DW$8	.dwtag  DW_TAG_variable
	.dwattr $C$DW$8, DW_AT_name("BTS_ctrl_cc_ch4")
	.dwattr $C$DW$8, DW_AT_linkage_name("BTS_ctrl_cc_ch4")
	.dwattr $C$DW$8, DW_AT_location[DW_OP_addr ||BTS_ctrl_cc_ch4||]
	.dwattr $C$DW$8, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$8, DW_AT_external
	.dwattr $C$DW$8, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$8, DW_AT_decl_line(0x36)
	.dwattr $C$DW$8, DW_AT_decl_column(0x15)

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

$C$DW$9	.dwtag  DW_TAG_variable
	.dwattr $C$DW$9, DW_AT_name("BTS_ctrl_cv_ch1")
	.dwattr $C$DW$9, DW_AT_linkage_name("BTS_ctrl_cv_ch1")
	.dwattr $C$DW$9, DW_AT_location[DW_OP_addr ||BTS_ctrl_cv_ch1||]
	.dwattr $C$DW$9, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$9, DW_AT_external
	.dwattr $C$DW$9, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$9, DW_AT_decl_line(0x39)
	.dwattr $C$DW$9, DW_AT_decl_column(0x15)

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

$C$DW$10	.dwtag  DW_TAG_variable
	.dwattr $C$DW$10, DW_AT_name("BTS_ctrl_cv_ch2")
	.dwattr $C$DW$10, DW_AT_linkage_name("BTS_ctrl_cv_ch2")
	.dwattr $C$DW$10, DW_AT_location[DW_OP_addr ||BTS_ctrl_cv_ch2||]
	.dwattr $C$DW$10, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$10, DW_AT_external
	.dwattr $C$DW$10, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$10, DW_AT_decl_line(0x3a)
	.dwattr $C$DW$10, DW_AT_decl_column(0x15)

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

$C$DW$11	.dwtag  DW_TAG_variable
	.dwattr $C$DW$11, DW_AT_name("BTS_ctrl_cv_ch3")
	.dwattr $C$DW$11, DW_AT_linkage_name("BTS_ctrl_cv_ch3")
	.dwattr $C$DW$11, DW_AT_location[DW_OP_addr ||BTS_ctrl_cv_ch3||]
	.dwattr $C$DW$11, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$11, DW_AT_external
	.dwattr $C$DW$11, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$11, DW_AT_decl_line(0x3b)
	.dwattr $C$DW$11, DW_AT_decl_column(0x15)

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

$C$DW$12	.dwtag  DW_TAG_variable
	.dwattr $C$DW$12, DW_AT_name("BTS_ctrl_cv_ch4")
	.dwattr $C$DW$12, DW_AT_linkage_name("BTS_ctrl_cv_ch4")
	.dwattr $C$DW$12, DW_AT_location[DW_OP_addr ||BTS_ctrl_cv_ch4||]
	.dwattr $C$DW$12, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$12, DW_AT_external
	.dwattr $C$DW$12, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$12, DW_AT_decl_line(0x3c)
	.dwattr $C$DW$12, DW_AT_decl_column(0x15)

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

$C$DW$13	.dwtag  DW_TAG_variable
	.dwattr $C$DW$13, DW_AT_name("BTS_ctrl_ch1")
	.dwattr $C$DW$13, DW_AT_linkage_name("BTS_ctrl_ch1")
	.dwattr $C$DW$13, DW_AT_location[DW_OP_addr ||BTS_ctrl_ch1||]
	.dwattr $C$DW$13, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$13, DW_AT_external
	.dwattr $C$DW$13, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$13, DW_AT_decl_line(0x66)
	.dwattr $C$DW$13, DW_AT_decl_column(0x1e)

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

$C$DW$14	.dwtag  DW_TAG_variable
	.dwattr $C$DW$14, DW_AT_name("BTS_ctrl_ch2")
	.dwattr $C$DW$14, DW_AT_linkage_name("BTS_ctrl_ch2")
	.dwattr $C$DW$14, DW_AT_location[DW_OP_addr ||BTS_ctrl_ch2||]
	.dwattr $C$DW$14, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$14, DW_AT_external
	.dwattr $C$DW$14, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$14, DW_AT_decl_line(0x67)
	.dwattr $C$DW$14, DW_AT_decl_column(0x1e)

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

$C$DW$15	.dwtag  DW_TAG_variable
	.dwattr $C$DW$15, DW_AT_name("BTS_ctrl_ch3")
	.dwattr $C$DW$15, DW_AT_linkage_name("BTS_ctrl_ch3")
	.dwattr $C$DW$15, DW_AT_location[DW_OP_addr ||BTS_ctrl_ch3||]
	.dwattr $C$DW$15, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$15, DW_AT_external
	.dwattr $C$DW$15, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$15, DW_AT_decl_line(0x68)
	.dwattr $C$DW$15, DW_AT_decl_column(0x1e)

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

$C$DW$16	.dwtag  DW_TAG_variable
	.dwattr $C$DW$16, DW_AT_name("BTS_ctrl_ch4")
	.dwattr $C$DW$16, DW_AT_linkage_name("BTS_ctrl_ch4")
	.dwattr $C$DW$16, DW_AT_location[DW_OP_addr ||BTS_ctrl_ch4||]
	.dwattr $C$DW$16, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$16, DW_AT_external
	.dwattr $C$DW$16, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$16, DW_AT_decl_line(0x69)
	.dwattr $C$DW$16, DW_AT_decl_column(0x1e)

	.global	||BTS_userInput_ch1||
	.bss	||BTS_userInput_ch1||,30,1,1
$C$DW$17	.dwtag  DW_TAG_variable
	.dwattr $C$DW$17, DW_AT_name("BTS_userInput_ch1")
	.dwattr $C$DW$17, DW_AT_linkage_name("BTS_userInput_ch1")
	.dwattr $C$DW$17, DW_AT_location[DW_OP_addr ||BTS_userInput_ch1||]
	.dwattr $C$DW$17, DW_AT_type(*$C$DW$T$49)
	.dwattr $C$DW$17, DW_AT_external
	.dwattr $C$DW$17, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$17, DW_AT_decl_line(0x28)
	.dwattr $C$DW$17, DW_AT_decl_column(0x0f)

	.global	||BTS_userInput_ch2||
	.bss	||BTS_userInput_ch2||,30,1,1
$C$DW$18	.dwtag  DW_TAG_variable
	.dwattr $C$DW$18, DW_AT_name("BTS_userInput_ch2")
	.dwattr $C$DW$18, DW_AT_linkage_name("BTS_userInput_ch2")
	.dwattr $C$DW$18, DW_AT_location[DW_OP_addr ||BTS_userInput_ch2||]
	.dwattr $C$DW$18, DW_AT_type(*$C$DW$T$49)
	.dwattr $C$DW$18, DW_AT_external
	.dwattr $C$DW$18, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$18, DW_AT_decl_line(0x29)
	.dwattr $C$DW$18, DW_AT_decl_column(0x0f)

	.global	||BTS_userInput_ch3||
	.bss	||BTS_userInput_ch3||,30,1,1
$C$DW$19	.dwtag  DW_TAG_variable
	.dwattr $C$DW$19, DW_AT_name("BTS_userInput_ch3")
	.dwattr $C$DW$19, DW_AT_linkage_name("BTS_userInput_ch3")
	.dwattr $C$DW$19, DW_AT_location[DW_OP_addr ||BTS_userInput_ch3||]
	.dwattr $C$DW$19, DW_AT_type(*$C$DW$T$49)
	.dwattr $C$DW$19, DW_AT_external
	.dwattr $C$DW$19, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$19, DW_AT_decl_line(0x2a)
	.dwattr $C$DW$19, DW_AT_decl_column(0x0f)

	.global	||BTS_userInput_ch4||
	.bss	||BTS_userInput_ch4||,30,1,1
$C$DW$20	.dwtag  DW_TAG_variable
	.dwattr $C$DW$20, DW_AT_name("BTS_userInput_ch4")
	.dwattr $C$DW$20, DW_AT_linkage_name("BTS_userInput_ch4")
	.dwattr $C$DW$20, DW_AT_location[DW_OP_addr ||BTS_userInput_ch4||]
	.dwattr $C$DW$20, DW_AT_type(*$C$DW$T$49)
	.dwattr $C$DW$20, DW_AT_external
	.dwattr $C$DW$20, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$20, DW_AT_decl_line(0x2b)
	.dwattr $C$DW$20, DW_AT_decl_column(0x0f)

	.global	||BTS_ctrlLoopVariable_ch1||
	.bss	||BTS_ctrlLoopVariable_ch1||,36,1,1
$C$DW$21	.dwtag  DW_TAG_variable
	.dwattr $C$DW$21, DW_AT_name("BTS_ctrlLoopVariable_ch1")
	.dwattr $C$DW$21, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch1")
	.dwattr $C$DW$21, DW_AT_location[DW_OP_addr ||BTS_ctrlLoopVariable_ch1||]
	.dwattr $C$DW$21, DW_AT_type(*$C$DW$T$54)
	.dwattr $C$DW$21, DW_AT_external
	.dwattr $C$DW$21, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$21, DW_AT_decl_line(0x2d)
	.dwattr $C$DW$21, DW_AT_decl_column(0x16)

	.global	||BTS_ctrlLoopVariable_ch2||
	.bss	||BTS_ctrlLoopVariable_ch2||,36,1,1
$C$DW$22	.dwtag  DW_TAG_variable
	.dwattr $C$DW$22, DW_AT_name("BTS_ctrlLoopVariable_ch2")
	.dwattr $C$DW$22, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch2")
	.dwattr $C$DW$22, DW_AT_location[DW_OP_addr ||BTS_ctrlLoopVariable_ch2||]
	.dwattr $C$DW$22, DW_AT_type(*$C$DW$T$54)
	.dwattr $C$DW$22, DW_AT_external
	.dwattr $C$DW$22, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$22, DW_AT_decl_line(0x2e)
	.dwattr $C$DW$22, DW_AT_decl_column(0x16)

	.global	||BTS_ctrlLoopVariable_ch3||
	.bss	||BTS_ctrlLoopVariable_ch3||,36,1,1
$C$DW$23	.dwtag  DW_TAG_variable
	.dwattr $C$DW$23, DW_AT_name("BTS_ctrlLoopVariable_ch3")
	.dwattr $C$DW$23, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch3")
	.dwattr $C$DW$23, DW_AT_location[DW_OP_addr ||BTS_ctrlLoopVariable_ch3||]
	.dwattr $C$DW$23, DW_AT_type(*$C$DW$T$54)
	.dwattr $C$DW$23, DW_AT_external
	.dwattr $C$DW$23, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$23, DW_AT_decl_line(0x2f)
	.dwattr $C$DW$23, DW_AT_decl_column(0x16)

	.global	||BTS_ctrlLoopVariable_ch4||
	.bss	||BTS_ctrlLoopVariable_ch4||,36,1,1
$C$DW$24	.dwtag  DW_TAG_variable
	.dwattr $C$DW$24, DW_AT_name("BTS_ctrlLoopVariable_ch4")
	.dwattr $C$DW$24, DW_AT_linkage_name("BTS_ctrlLoopVariable_ch4")
	.dwattr $C$DW$24, DW_AT_location[DW_OP_addr ||BTS_ctrlLoopVariable_ch4||]
	.dwattr $C$DW$24, DW_AT_type(*$C$DW$T$54)
	.dwattr $C$DW$24, DW_AT_external
	.dwattr $C$DW$24, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$24, DW_AT_decl_line(0x30)
	.dwattr $C$DW$24, DW_AT_decl_column(0x16)

	.global	||BTS_measValues_ch1||
	.bss	||BTS_measValues_ch1||,82,1,1
$C$DW$25	.dwtag  DW_TAG_variable
	.dwattr $C$DW$25, DW_AT_name("BTS_measValues_ch1")
	.dwattr $C$DW$25, DW_AT_linkage_name("BTS_measValues_ch1")
	.dwattr $C$DW$25, DW_AT_location[DW_OP_addr ||BTS_measValues_ch1||]
	.dwattr $C$DW$25, DW_AT_type(*$C$DW$T$59)
	.dwattr $C$DW$25, DW_AT_external
	.dwattr $C$DW$25, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$25, DW_AT_decl_line(0x21)
	.dwattr $C$DW$25, DW_AT_decl_column(0x10)

	.global	||BTS_measValues_ch2||
	.bss	||BTS_measValues_ch2||,82,1,1
$C$DW$26	.dwtag  DW_TAG_variable
	.dwattr $C$DW$26, DW_AT_name("BTS_measValues_ch2")
	.dwattr $C$DW$26, DW_AT_linkage_name("BTS_measValues_ch2")
	.dwattr $C$DW$26, DW_AT_location[DW_OP_addr ||BTS_measValues_ch2||]
	.dwattr $C$DW$26, DW_AT_type(*$C$DW$T$59)
	.dwattr $C$DW$26, DW_AT_external
	.dwattr $C$DW$26, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$26, DW_AT_decl_line(0x22)
	.dwattr $C$DW$26, DW_AT_decl_column(0x10)

	.global	||BTS_measValues_ch3||
	.bss	||BTS_measValues_ch3||,82,1,1
$C$DW$27	.dwtag  DW_TAG_variable
	.dwattr $C$DW$27, DW_AT_name("BTS_measValues_ch3")
	.dwattr $C$DW$27, DW_AT_linkage_name("BTS_measValues_ch3")
	.dwattr $C$DW$27, DW_AT_location[DW_OP_addr ||BTS_measValues_ch3||]
	.dwattr $C$DW$27, DW_AT_type(*$C$DW$T$59)
	.dwattr $C$DW$27, DW_AT_external
	.dwattr $C$DW$27, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$27, DW_AT_decl_line(0x23)
	.dwattr $C$DW$27, DW_AT_decl_column(0x10)

	.global	||BTS_measValues_ch4||
	.bss	||BTS_measValues_ch4||,82,1,1
$C$DW$28	.dwtag  DW_TAG_variable
	.dwattr $C$DW$28, DW_AT_name("BTS_measValues_ch4")
	.dwattr $C$DW$28, DW_AT_linkage_name("BTS_measValues_ch4")
	.dwattr $C$DW$28, DW_AT_location[DW_OP_addr ||BTS_measValues_ch4||]
	.dwattr $C$DW$28, DW_AT_type(*$C$DW$T$59)
	.dwattr $C$DW$28, DW_AT_external
	.dwattr $C$DW$28, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$28, DW_AT_decl_line(0x24)
	.dwattr $C$DW$28, DW_AT_decl_column(0x10)

	.sblock	".bss"
	.sblock	".data"
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\opt2000.exe C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{F74DA015-2643-450E-BA01-867BD2A3A602} C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{82D3B6B2-6D7D-4BE7-8394-148A3D7D0908} 
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\acia2000.exe -@C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{A9F9C443-58F8-4158-9452-D1C632AF4684} 
	.sect	".text:__signbitl"
	.clink
	.global	||__signbitl||

$C$DW$29	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$29, DW_AT_name("__signbitl")
	.dwattr $C$DW$29, DW_AT_low_pc(||__signbitl||)
	.dwattr $C$DW$29, DW_AT_high_pc(0x00)
	.dwattr $C$DW$29, DW_AT_linkage_name("__signbitl")
	.dwattr $C$DW$29, DW_AT_external
	.dwattr $C$DW$29, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$29, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$29, DW_AT_decl_line(0x16f)
	.dwattr $C$DW$29, DW_AT_decl_column(0x25)
	.dwattr $C$DW$29, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 368,column 1,is_stmt,address ||__signbitl||,isa 0

	.dwfde $C$DW$CIE, ||__signbitl||
$C$DW$30	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$30, DW_AT_name("e")
	.dwattr $C$DW$30, DW_AT_type(*$C$DW$T$87)
	.dwattr $C$DW$30, DW_AT_location[DW_OP_reg12]


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
$C$DW$31	.dwtag  DW_TAG_variable
	.dwattr $C$DW$31, DW_AT_name("e")
	.dwattr $C$DW$31, DW_AT_type(*$C$DW$T$88)
	.dwattr $C$DW$31, DW_AT_location[DW_OP_reg12]

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
$C$DW$32	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$32, DW_AT_low_pc(0x00)
	.dwattr $C$DW$32, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$32, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |368| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |368| 
        MOVB      AH,#0                 ; [CPU_ALU] |368| 
        CMPB      AL,#0                 ; [CPU_ALU] |368| 
        MOVB      AH,#1,NEQ             ; [CPU_ALU] |368| 
        MOV       AL,AH                 ; [CPU_ALU] |368| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$33	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$33, DW_AT_low_pc(0x00)
	.dwattr $C$DW$33, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$29, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$29, DW_AT_TI_end_line(0x170)
	.dwattr $C$DW$29, DW_AT_TI_end_column(0x2b)
	.dwendentry
	.dwendtag $C$DW$29

	.sect	".text:__signbitf"
	.clink
	.global	||__signbitf||

$C$DW$34	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$34, DW_AT_name("__signbitf")
	.dwattr $C$DW$34, DW_AT_low_pc(||__signbitf||)
	.dwattr $C$DW$34, DW_AT_high_pc(0x00)
	.dwattr $C$DW$34, DW_AT_linkage_name("__signbitf")
	.dwattr $C$DW$34, DW_AT_external
	.dwattr $C$DW$34, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$34, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$34, DW_AT_decl_line(0x16d)
	.dwattr $C$DW$34, DW_AT_decl_column(0x25)
	.dwattr $C$DW$34, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 366,column 1,is_stmt,address ||__signbitf||,isa 0

	.dwfde $C$DW$CIE, ||__signbitf||
$C$DW$35	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$35, DW_AT_name("f")
	.dwattr $C$DW$35, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$35, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$36	.dwtag  DW_TAG_variable
	.dwattr $C$DW$36, DW_AT_name("f")
	.dwattr $C$DW$36, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$36, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$37	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$37, DW_AT_low_pc(0x00)
	.dwattr $C$DW$37, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$34, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$34, DW_AT_TI_end_line(0x16e)
	.dwattr $C$DW$34, DW_AT_TI_end_column(0x29)
	.dwendentry
	.dwendtag $C$DW$34

	.sect	".text:__signbit"
	.clink
	.global	||__signbit||

$C$DW$38	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$38, DW_AT_name("__signbit")
	.dwattr $C$DW$38, DW_AT_low_pc(||__signbit||)
	.dwattr $C$DW$38, DW_AT_high_pc(0x00)
	.dwattr $C$DW$38, DW_AT_linkage_name("__signbit")
	.dwattr $C$DW$38, DW_AT_external
	.dwattr $C$DW$38, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$38, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$38, DW_AT_decl_line(0x16b)
	.dwattr $C$DW$38, DW_AT_decl_column(0x25)
	.dwattr $C$DW$38, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 364,column 1,is_stmt,address ||__signbit||,isa 0

	.dwfde $C$DW$CIE, ||__signbit||
$C$DW$39	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$39, DW_AT_name("d")
	.dwattr $C$DW$39, DW_AT_type(*$C$DW$T$84)
	.dwattr $C$DW$39, DW_AT_location[DW_OP_reg12]


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
$C$DW$40	.dwtag  DW_TAG_variable
	.dwattr $C$DW$40, DW_AT_name("d")
	.dwattr $C$DW$40, DW_AT_type(*$C$DW$T$85)
	.dwattr $C$DW$40, DW_AT_location[DW_OP_reg12]

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
$C$DW$41	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$41, DW_AT_low_pc(0x00)
	.dwattr $C$DW$41, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$41, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |364| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |364| 
        MOVB      AH,#0                 ; [CPU_ALU] |364| 
        CMPB      AL,#0                 ; [CPU_ALU] |364| 
        MOVB      AH,#1,NEQ             ; [CPU_ALU] |364| 
        MOV       AL,AH                 ; [CPU_ALU] |364| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$42	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$42, DW_AT_low_pc(0x00)
	.dwattr $C$DW$42, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$38, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$38, DW_AT_TI_end_line(0x16c)
	.dwattr $C$DW$38, DW_AT_TI_end_column(0x2a)
	.dwendentry
	.dwendtag $C$DW$38

	.sect	".text:__relaxed_sqrtf"
	.clink
	.global	||__relaxed_sqrtf||

$C$DW$43	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$43, DW_AT_name("__relaxed_sqrtf")
	.dwattr $C$DW$43, DW_AT_low_pc(||__relaxed_sqrtf||)
	.dwattr $C$DW$43, DW_AT_high_pc(0x00)
	.dwattr $C$DW$43, DW_AT_linkage_name("__relaxed_sqrtf")
	.dwattr $C$DW$43, DW_AT_external
	.dwattr $C$DW$43, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$43, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$43, DW_AT_decl_line(0xe4)
	.dwattr $C$DW$43, DW_AT_decl_column(0x10)
	.dwattr $C$DW$43, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 229,column 1,is_stmt,address ||__relaxed_sqrtf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_sqrtf||
$C$DW$44	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$44, DW_AT_name("x")
	.dwattr $C$DW$44, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$44, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$45	.dwtag  DW_TAG_variable
	.dwattr $C$DW$45, DW_AT_name("x")
	.dwattr $C$DW$45, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$45, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 230,column 5,is_stmt,isa 0
        SQRTF32   R0H,R0H               ; [CPU_FPU] |230| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$46	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$46, DW_AT_low_pc(0x00)
	.dwattr $C$DW$46, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$43, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$43, DW_AT_TI_end_line(0xe7)
	.dwattr $C$DW$43, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$43

	.sect	".text:__relaxed_sinf"
	.clink
	.global	||__relaxed_sinf||

$C$DW$47	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$47, DW_AT_name("__relaxed_sinf")
	.dwattr $C$DW$47, DW_AT_low_pc(||__relaxed_sinf||)
	.dwattr $C$DW$47, DW_AT_high_pc(0x00)
	.dwattr $C$DW$47, DW_AT_linkage_name("__relaxed_sinf")
	.dwattr $C$DW$47, DW_AT_external
	.dwattr $C$DW$47, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$47, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$47, DW_AT_decl_line(0xe9)
	.dwattr $C$DW$47, DW_AT_decl_column(0x10)
	.dwattr $C$DW$47, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 234,column 1,is_stmt,address ||__relaxed_sinf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_sinf||
$C$DW$48	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$48, DW_AT_name("x")
	.dwattr $C$DW$48, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$48, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$49	.dwtag  DW_TAG_variable
	.dwattr $C$DW$49, DW_AT_name("x")
	.dwattr $C$DW$49, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$49, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 235,column 5,is_stmt,isa 0
        DIV2PIF32 R0H,R0H               ; [CPU_FPU] |235| 
        NOP       ; [CPU_ALU] 
        SINPUF32  R0H,R0H               ; [CPU_FPU] |235| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$50	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$50, DW_AT_low_pc(0x00)
	.dwattr $C$DW$50, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$47, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$47, DW_AT_TI_end_line(0xec)
	.dwattr $C$DW$47, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$47

	.sect	".text:__relaxed_cosf"
	.clink
	.global	||__relaxed_cosf||

$C$DW$51	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$51, DW_AT_name("__relaxed_cosf")
	.dwattr $C$DW$51, DW_AT_low_pc(||__relaxed_cosf||)
	.dwattr $C$DW$51, DW_AT_high_pc(0x00)
	.dwattr $C$DW$51, DW_AT_linkage_name("__relaxed_cosf")
	.dwattr $C$DW$51, DW_AT_external
	.dwattr $C$DW$51, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$51, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$51, DW_AT_decl_line(0xee)
	.dwattr $C$DW$51, DW_AT_decl_column(0x10)
	.dwattr $C$DW$51, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 239,column 1,is_stmt,address ||__relaxed_cosf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_cosf||
$C$DW$52	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$52, DW_AT_name("x")
	.dwattr $C$DW$52, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$52, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$53	.dwtag  DW_TAG_variable
	.dwattr $C$DW$53, DW_AT_name("x")
	.dwattr $C$DW$53, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$53, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 240,column 5,is_stmt,isa 0
        DIV2PIF32 R0H,R0H               ; [CPU_FPU] |240| 
        NOP       ; [CPU_ALU] 
        COSPUF32  R0H,R0H               ; [CPU_FPU] |240| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$54	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$54, DW_AT_low_pc(0x00)
	.dwattr $C$DW$54, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$51, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$51, DW_AT_TI_end_line(0xf1)
	.dwattr $C$DW$51, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$51

	.sect	".text:__relaxed_atanf"
	.clink
	.global	||__relaxed_atanf||

$C$DW$55	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$55, DW_AT_name("__relaxed_atanf")
	.dwattr $C$DW$55, DW_AT_low_pc(||__relaxed_atanf||)
	.dwattr $C$DW$55, DW_AT_high_pc(0x00)
	.dwattr $C$DW$55, DW_AT_linkage_name("__relaxed_atanf")
	.dwattr $C$DW$55, DW_AT_external
	.dwattr $C$DW$55, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$55, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$55, DW_AT_decl_line(0xf3)
	.dwattr $C$DW$55, DW_AT_decl_column(0x10)
	.dwattr $C$DW$55, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 244,column 1,is_stmt,address ||__relaxed_atanf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_atanf||
$C$DW$56	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$56, DW_AT_name("x")
	.dwattr $C$DW$56, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$56, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$57	.dwtag  DW_TAG_variable
	.dwattr $C$DW$57, DW_AT_name("x")
	.dwattr $C$DW$57, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$57, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$58	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$58, DW_AT_low_pc(0x00)
	.dwattr $C$DW$58, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$55, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$55, DW_AT_TI_end_line(0xf6)
	.dwattr $C$DW$55, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$55

	.sect	".text:__relaxed_atan2f"
	.clink
	.global	||__relaxed_atan2f||

$C$DW$59	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$59, DW_AT_name("__relaxed_atan2f")
	.dwattr $C$DW$59, DW_AT_low_pc(||__relaxed_atan2f||)
	.dwattr $C$DW$59, DW_AT_high_pc(0x00)
	.dwattr $C$DW$59, DW_AT_linkage_name("__relaxed_atan2f")
	.dwattr $C$DW$59, DW_AT_external
	.dwattr $C$DW$59, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$59, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$59, DW_AT_decl_line(0xf8)
	.dwattr $C$DW$59, DW_AT_decl_column(0x10)
	.dwattr $C$DW$59, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 249,column 1,is_stmt,address ||__relaxed_atan2f||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_atan2f||
$C$DW$60	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$60, DW_AT_name("y")
	.dwattr $C$DW$60, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$60, DW_AT_location[DW_OP_regx 0x2b]

$C$DW$61	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$61, DW_AT_name("x")
	.dwattr $C$DW$61, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$61, DW_AT_location[DW_OP_regx 0x2f]


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
$C$DW$62	.dwtag  DW_TAG_variable
	.dwattr $C$DW$62, DW_AT_name("y")
	.dwattr $C$DW$62, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$62, DW_AT_location[DW_OP_regx 0x2b]

;* R1    assigned to x
$C$DW$63	.dwtag  DW_TAG_variable
	.dwattr $C$DW$63, DW_AT_name("x")
	.dwattr $C$DW$63, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$63, DW_AT_location[DW_OP_regx 0x2f]

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
$C$DW$64	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$64, DW_AT_low_pc(0x00)
	.dwattr $C$DW$64, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$59, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$59, DW_AT_TI_end_line(0xfb)
	.dwattr $C$DW$59, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$59

	.sect	".text:__isnormall"
	.clink
	.global	||__isnormall||

$C$DW$65	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$65, DW_AT_name("__isnormall")
	.dwattr $C$DW$65, DW_AT_low_pc(||__isnormall||)
	.dwattr $C$DW$65, DW_AT_high_pc(0x00)
	.dwattr $C$DW$65, DW_AT_linkage_name("__isnormall")
	.dwattr $C$DW$65, DW_AT_external
	.dwattr $C$DW$65, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$65, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$65, DW_AT_decl_line(0x167)
	.dwattr $C$DW$65, DW_AT_decl_column(0x25)
	.dwattr $C$DW$65, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 360,column 1,is_stmt,address ||__isnormall||,isa 0

	.dwfde $C$DW$CIE, ||__isnormall||
$C$DW$66	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$66, DW_AT_name("e")
	.dwattr $C$DW$66, DW_AT_type(*$C$DW$T$87)
	.dwattr $C$DW$66, DW_AT_location[DW_OP_reg12]


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
$C$DW$67	.dwtag  DW_TAG_variable
	.dwattr $C$DW$67, DW_AT_name("e")
	.dwattr $C$DW$67, DW_AT_type(*$C$DW$T$88)
	.dwattr $C$DW$67, DW_AT_location[DW_OP_reg12]

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
$C$DW$68	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$68, DW_AT_low_pc(0x00)
	.dwattr $C$DW$68, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$68, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |360| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |360| 
        MOVB      XAR6,#0               ; [CPU_ALU] |360| 
        CMPB      AL,#0                 ; [CPU_ALU] |360| 
        B         ||$C$L1||,EQ          ; [CPU_ALU] |360| 
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
||$C$L1||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR6                ; [CPU_ALU] |360| 
$C$DW$69	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$69, DW_AT_low_pc(0x00)
	.dwattr $C$DW$69, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$65, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$65, DW_AT_TI_end_line(0x169)
	.dwattr $C$DW$65, DW_AT_TI_end_column(0x31)
	.dwendentry
	.dwendtag $C$DW$65

	.sect	".text:__isnormalf"
	.clink
	.global	||__isnormalf||

$C$DW$70	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$70, DW_AT_name("__isnormalf")
	.dwattr $C$DW$70, DW_AT_low_pc(||__isnormalf||)
	.dwattr $C$DW$70, DW_AT_high_pc(0x00)
	.dwattr $C$DW$70, DW_AT_linkage_name("__isnormalf")
	.dwattr $C$DW$70, DW_AT_external
	.dwattr $C$DW$70, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$70, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$70, DW_AT_decl_line(0x163)
	.dwattr $C$DW$70, DW_AT_decl_column(0x25)
	.dwattr $C$DW$70, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 356,column 1,is_stmt,address ||__isnormalf||,isa 0

	.dwfde $C$DW$CIE, ||__isnormalf||
$C$DW$71	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$71, DW_AT_name("f")
	.dwattr $C$DW$71, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$71, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$72	.dwtag  DW_TAG_variable
	.dwattr $C$DW$72, DW_AT_name("f")
	.dwattr $C$DW$72, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$72, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 356,column 3,is_stmt,isa 0
        MOV32     P,R0H                 ; [CPU_FPU] |356| 
        MOV       T,#23                 ; [CPU_ALU] |356| 
        MOVL      ACC,P                 ; [CPU_ALU] |356| 
        MOVB      XAR6,#0               ; [CPU_ALU] |356| 
        LSRL      ACC,T                 ; [CPU_ALU] |356| 
        ANDB      AL,#0xff              ; [CPU_ALU] |356| 
        B         ||$C$L2||,EQ          ; [CPU_ALU] |356| 
        ; branchcc occurs ; [] |356| 
        AND       AL,PH,#0x7f80         ; [CPU_ALU] |356| 
        MOVZ      AR7,AL                ; [CPU_ALU] |356| 
        MOVL      XAR4,#32640           ; [CPU_ARAU] |356| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |356| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |356| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |356| 
||$C$L2||:    
        MOV       AL,AR6                ; [CPU_ALU] |356| 
$C$DW$73	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$73, DW_AT_low_pc(0x00)
	.dwattr $C$DW$73, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$70, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$70, DW_AT_TI_end_line(0x165)
	.dwattr $C$DW$70, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$70

	.sect	".text:__isnormal"
	.clink
	.global	||__isnormal||

$C$DW$74	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$74, DW_AT_name("__isnormal")
	.dwattr $C$DW$74, DW_AT_low_pc(||__isnormal||)
	.dwattr $C$DW$74, DW_AT_high_pc(0x00)
	.dwattr $C$DW$74, DW_AT_linkage_name("__isnormal")
	.dwattr $C$DW$74, DW_AT_external
	.dwattr $C$DW$74, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$74, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$74, DW_AT_decl_line(0x15f)
	.dwattr $C$DW$74, DW_AT_decl_column(0x25)
	.dwattr $C$DW$74, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 352,column 1,is_stmt,address ||__isnormal||,isa 0

	.dwfde $C$DW$CIE, ||__isnormal||
$C$DW$75	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$75, DW_AT_name("d")
	.dwattr $C$DW$75, DW_AT_type(*$C$DW$T$84)
	.dwattr $C$DW$75, DW_AT_location[DW_OP_reg12]


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
$C$DW$76	.dwtag  DW_TAG_variable
	.dwattr $C$DW$76, DW_AT_name("d")
	.dwattr $C$DW$76, DW_AT_type(*$C$DW$T$85)
	.dwattr $C$DW$76, DW_AT_location[DW_OP_reg12]

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
$C$DW$77	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$77, DW_AT_low_pc(0x00)
	.dwattr $C$DW$77, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$77, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |352| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |352| 
        MOVB      XAR6,#0               ; [CPU_ALU] |352| 
        CMPB      AL,#0                 ; [CPU_ALU] |352| 
        B         ||$C$L3||,EQ          ; [CPU_ALU] |352| 
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
||$C$L3||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR6                ; [CPU_ALU] |352| 
$C$DW$78	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$78, DW_AT_low_pc(0x00)
	.dwattr $C$DW$78, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$74, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$74, DW_AT_TI_end_line(0x161)
	.dwattr $C$DW$74, DW_AT_TI_end_column(0x30)
	.dwendentry
	.dwendtag $C$DW$74

	.sect	".text:__isnanl"
	.clink
	.global	||__isnanl||

$C$DW$79	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$79, DW_AT_name("__isnanl")
	.dwattr $C$DW$79, DW_AT_low_pc(||__isnanl||)
	.dwattr $C$DW$79, DW_AT_high_pc(0x00)
	.dwattr $C$DW$79, DW_AT_linkage_name("__isnanl")
	.dwattr $C$DW$79, DW_AT_external
	.dwattr $C$DW$79, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$79, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$79, DW_AT_decl_line(0x15b)
	.dwattr $C$DW$79, DW_AT_decl_column(0x25)
	.dwattr $C$DW$79, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 348,column 1,is_stmt,address ||__isnanl||,isa 0

	.dwfde $C$DW$CIE, ||__isnanl||
$C$DW$80	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$80, DW_AT_name("e")
	.dwattr $C$DW$80, DW_AT_type(*$C$DW$T$87)
	.dwattr $C$DW$80, DW_AT_location[DW_OP_reg12]


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
$C$DW$81	.dwtag  DW_TAG_variable
	.dwattr $C$DW$81, DW_AT_name("e")
	.dwattr $C$DW$81, DW_AT_type(*$C$DW$T$88)
	.dwattr $C$DW$81, DW_AT_location[DW_OP_reg12]

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
        B         ||$C$L4||,NEQ         ; [CPU_ALU] |348| 
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
$C$DW$82	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$82, DW_AT_low_pc(0x00)
	.dwattr $C$DW$82, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$82, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |348| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |348| 
        CMPB      AL,#0                 ; [CPU_ALU] |348| 
        MOVB      XAR4,#1,NEQ           ; [CPU_ALU] |348| 
||$C$L4||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |348| 
$C$DW$83	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$83, DW_AT_low_pc(0x00)
	.dwattr $C$DW$83, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$79, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$79, DW_AT_TI_end_line(0x15d)
	.dwattr $C$DW$79, DW_AT_TI_end_column(0x30)
	.dwendentry
	.dwendtag $C$DW$79

	.sect	".text:__isnanf"
	.clink
	.global	||__isnanf||

$C$DW$84	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$84, DW_AT_name("__isnanf")
	.dwattr $C$DW$84, DW_AT_low_pc(||__isnanf||)
	.dwattr $C$DW$84, DW_AT_high_pc(0x00)
	.dwattr $C$DW$84, DW_AT_linkage_name("__isnanf")
	.dwattr $C$DW$84, DW_AT_external
	.dwattr $C$DW$84, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$84, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$84, DW_AT_decl_line(0x158)
	.dwattr $C$DW$84, DW_AT_decl_column(0x25)
	.dwattr $C$DW$84, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 345,column 1,is_stmt,address ||__isnanf||,isa 0

	.dwfde $C$DW$CIE, ||__isnanf||
$C$DW$85	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$85, DW_AT_name("f")
	.dwattr $C$DW$85, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$85, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$86	.dwtag  DW_TAG_variable
	.dwattr $C$DW$86, DW_AT_name("f")
	.dwattr $C$DW$86, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$86, DW_AT_location[DW_OP_regx 0x2b]

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
        B         ||$C$L5||,NEQ         ; [CPU_ALU] |345| 
        ; branchcc occurs ; [] |345| 
        MOVL      ACC,P                 ; [CPU_ALU] |345| 
        ANDB      AH,#127               ; [CPU_ALU] |345| 
        TEST      ACC                   ; [CPU_ALU] |345| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |345| 
||$C$L5||:    
        MOV       AL,AR6                ; [CPU_ALU] |345| 
$C$DW$87	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$87, DW_AT_low_pc(0x00)
	.dwattr $C$DW$87, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$84, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$84, DW_AT_TI_end_line(0x15a)
	.dwattr $C$DW$84, DW_AT_TI_end_column(0x2e)
	.dwendentry
	.dwendtag $C$DW$84

	.sect	".text:__isnan"
	.clink
	.global	||__isnan||

$C$DW$88	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$88, DW_AT_name("__isnan")
	.dwattr $C$DW$88, DW_AT_low_pc(||__isnan||)
	.dwattr $C$DW$88, DW_AT_high_pc(0x00)
	.dwattr $C$DW$88, DW_AT_linkage_name("__isnan")
	.dwattr $C$DW$88, DW_AT_external
	.dwattr $C$DW$88, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$88, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$88, DW_AT_decl_line(0x155)
	.dwattr $C$DW$88, DW_AT_decl_column(0x25)
	.dwattr $C$DW$88, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 342,column 1,is_stmt,address ||__isnan||,isa 0

	.dwfde $C$DW$CIE, ||__isnan||
$C$DW$89	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$89, DW_AT_name("d")
	.dwattr $C$DW$89, DW_AT_type(*$C$DW$T$84)
	.dwattr $C$DW$89, DW_AT_location[DW_OP_reg12]


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
$C$DW$90	.dwtag  DW_TAG_variable
	.dwattr $C$DW$90, DW_AT_name("d")
	.dwattr $C$DW$90, DW_AT_type(*$C$DW$T$85)
	.dwattr $C$DW$90, DW_AT_location[DW_OP_reg12]

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
        B         ||$C$L6||,NEQ         ; [CPU_ALU] |342| 
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
$C$DW$91	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$91, DW_AT_low_pc(0x00)
	.dwattr $C$DW$91, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$91, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |342| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |342| 
        CMPB      AL,#0                 ; [CPU_ALU] |342| 
        MOVB      XAR4,#1,NEQ           ; [CPU_ALU] |342| 
||$C$L6||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |342| 
$C$DW$92	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$92, DW_AT_low_pc(0x00)
	.dwattr $C$DW$92, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$88, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$88, DW_AT_TI_end_line(0x157)
	.dwattr $C$DW$88, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$88

	.sect	".text:__isinfl"
	.clink
	.global	||__isinfl||

$C$DW$93	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$93, DW_AT_name("__isinfl")
	.dwattr $C$DW$93, DW_AT_low_pc(||__isinfl||)
	.dwattr $C$DW$93, DW_AT_high_pc(0x00)
	.dwattr $C$DW$93, DW_AT_linkage_name("__isinfl")
	.dwattr $C$DW$93, DW_AT_external
	.dwattr $C$DW$93, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$93, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$93, DW_AT_decl_line(0x17a)
	.dwattr $C$DW$93, DW_AT_decl_column(0x25)
	.dwattr $C$DW$93, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 379,column 1,is_stmt,address ||__isinfl||,isa 0

	.dwfde $C$DW$CIE, ||__isinfl||
$C$DW$94	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$94, DW_AT_name("e")
	.dwattr $C$DW$94, DW_AT_type(*$C$DW$T$87)
	.dwattr $C$DW$94, DW_AT_location[DW_OP_reg12]


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
$C$DW$95	.dwtag  DW_TAG_variable
	.dwattr $C$DW$95, DW_AT_name("e")
	.dwattr $C$DW$95, DW_AT_type(*$C$DW$T$88)
	.dwattr $C$DW$95, DW_AT_location[DW_OP_reg12]

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
        B         ||$C$L7||,NEQ         ; [CPU_ALU] |379| 
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
$C$DW$96	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$96, DW_AT_low_pc(0x00)
	.dwattr $C$DW$96, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$96, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |379| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |379| 
        CMPB      AL,#0                 ; [CPU_ALU] |379| 
        MOVB      XAR4,#1,EQ            ; [CPU_ALU] |379| 
||$C$L7||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |379| 
$C$DW$97	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$97, DW_AT_low_pc(0x00)
	.dwattr $C$DW$97, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$93, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$93, DW_AT_TI_end_line(0x17b)
	.dwattr $C$DW$93, DW_AT_TI_end_column(0x4c)
	.dwendentry
	.dwendtag $C$DW$93

	.sect	".text:__isinff"
	.clink
	.global	||__isinff||

$C$DW$98	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$98, DW_AT_name("__isinff")
	.dwattr $C$DW$98, DW_AT_low_pc(||__isinff||)
	.dwattr $C$DW$98, DW_AT_high_pc(0x00)
	.dwattr $C$DW$98, DW_AT_linkage_name("__isinff")
	.dwattr $C$DW$98, DW_AT_external
	.dwattr $C$DW$98, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$98, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$98, DW_AT_decl_line(0x176)
	.dwattr $C$DW$98, DW_AT_decl_column(0x25)
	.dwattr $C$DW$98, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 375,column 1,is_stmt,address ||__isinff||,isa 0

	.dwfde $C$DW$CIE, ||__isinff||
$C$DW$99	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$99, DW_AT_name("f")
	.dwattr $C$DW$99, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$99, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$100	.dwtag  DW_TAG_variable
	.dwattr $C$DW$100, DW_AT_name("f")
	.dwattr $C$DW$100, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$100, DW_AT_location[DW_OP_regx 0x2b]

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
        B         ||$C$L8||,NEQ         ; [CPU_ALU] |375| 
        ; branchcc occurs ; [] |375| 
        MOVL      ACC,P                 ; [CPU_ALU] |375| 
        ANDB      AH,#127               ; [CPU_ALU] |375| 
        TEST      ACC                   ; [CPU_ALU] |375| 
        MOVB      XAR6,#1,EQ            ; [CPU_ALU] |375| 
||$C$L8||:    
        MOV       AL,AR6                ; [CPU_ALU] |375| 
$C$DW$101	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$101, DW_AT_low_pc(0x00)
	.dwattr $C$DW$101, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$98, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$98, DW_AT_TI_end_line(0x177)
	.dwattr $C$DW$98, DW_AT_TI_end_column(0x48)
	.dwendentry
	.dwendtag $C$DW$98

	.sect	".text:__isinf"
	.clink
	.global	||__isinf||

$C$DW$102	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$102, DW_AT_name("__isinf")
	.dwattr $C$DW$102, DW_AT_low_pc(||__isinf||)
	.dwattr $C$DW$102, DW_AT_high_pc(0x00)
	.dwattr $C$DW$102, DW_AT_linkage_name("__isinf")
	.dwattr $C$DW$102, DW_AT_external
	.dwattr $C$DW$102, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$102, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$102, DW_AT_decl_line(0x178)
	.dwattr $C$DW$102, DW_AT_decl_column(0x25)
	.dwattr $C$DW$102, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 377,column 1,is_stmt,address ||__isinf||,isa 0

	.dwfde $C$DW$CIE, ||__isinf||
$C$DW$103	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$103, DW_AT_name("d")
	.dwattr $C$DW$103, DW_AT_type(*$C$DW$T$84)
	.dwattr $C$DW$103, DW_AT_location[DW_OP_reg12]


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
$C$DW$104	.dwtag  DW_TAG_variable
	.dwattr $C$DW$104, DW_AT_name("d")
	.dwattr $C$DW$104, DW_AT_type(*$C$DW$T$85)
	.dwattr $C$DW$104, DW_AT_location[DW_OP_reg12]

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
        B         ||$C$L9||,NEQ         ; [CPU_ALU] |377| 
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
$C$DW$105	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$105, DW_AT_low_pc(0x00)
	.dwattr $C$DW$105, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$105, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |377| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |377| 
        CMPB      AL,#0                 ; [CPU_ALU] |377| 
        MOVB      XAR4,#1,EQ            ; [CPU_ALU] |377| 
||$C$L9||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |377| 
$C$DW$106	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$106, DW_AT_low_pc(0x00)
	.dwattr $C$DW$106, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$102, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$102, DW_AT_TI_end_line(0x179)
	.dwattr $C$DW$102, DW_AT_TI_end_column(0x4a)
	.dwendentry
	.dwendtag $C$DW$102

	.sect	".text:__isfinitel"
	.clink
	.global	||__isfinitel||

$C$DW$107	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$107, DW_AT_name("__isfinitel")
	.dwattr $C$DW$107, DW_AT_low_pc(||__isfinitel||)
	.dwattr $C$DW$107, DW_AT_high_pc(0x00)
	.dwattr $C$DW$107, DW_AT_linkage_name("__isfinitel")
	.dwattr $C$DW$107, DW_AT_external
	.dwattr $C$DW$107, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$107, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$107, DW_AT_decl_line(0x152)
	.dwattr $C$DW$107, DW_AT_decl_column(0x25)
	.dwattr $C$DW$107, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 339,column 1,is_stmt,address ||__isfinitel||,isa 0

	.dwfde $C$DW$CIE, ||__isfinitel||
$C$DW$108	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$108, DW_AT_name("e")
	.dwattr $C$DW$108, DW_AT_type(*$C$DW$T$87)
	.dwattr $C$DW$108, DW_AT_location[DW_OP_reg12]


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
$C$DW$109	.dwtag  DW_TAG_variable
	.dwattr $C$DW$109, DW_AT_name("e")
	.dwattr $C$DW$109, DW_AT_type(*$C$DW$T$88)
	.dwattr $C$DW$109, DW_AT_location[DW_OP_reg12]

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
$C$DW$110	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$110, DW_AT_low_pc(0x00)
	.dwattr $C$DW$110, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$107, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$107, DW_AT_TI_end_line(0x153)
	.dwattr $C$DW$107, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$107

	.sect	".text:__isfinitef"
	.clink
	.global	||__isfinitef||

$C$DW$111	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$111, DW_AT_name("__isfinitef")
	.dwattr $C$DW$111, DW_AT_low_pc(||__isfinitef||)
	.dwattr $C$DW$111, DW_AT_high_pc(0x00)
	.dwattr $C$DW$111, DW_AT_linkage_name("__isfinitef")
	.dwattr $C$DW$111, DW_AT_external
	.dwattr $C$DW$111, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$111, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$111, DW_AT_decl_line(0x150)
	.dwattr $C$DW$111, DW_AT_decl_column(0x25)
	.dwattr $C$DW$111, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 337,column 1,is_stmt,address ||__isfinitef||,isa 0

	.dwfde $C$DW$CIE, ||__isfinitef||
$C$DW$112	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$112, DW_AT_name("f")
	.dwattr $C$DW$112, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$112, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$113	.dwtag  DW_TAG_variable
	.dwattr $C$DW$113, DW_AT_name("f")
	.dwattr $C$DW$113, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$113, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$114	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$114, DW_AT_low_pc(0x00)
	.dwattr $C$DW$114, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$111, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$111, DW_AT_TI_end_line(0x151)
	.dwattr $C$DW$111, DW_AT_TI_end_column(0x2d)
	.dwendentry
	.dwendtag $C$DW$111

	.sect	".text:__isfinite"
	.clink
	.global	||__isfinite||

$C$DW$115	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$115, DW_AT_name("__isfinite")
	.dwattr $C$DW$115, DW_AT_low_pc(||__isfinite||)
	.dwattr $C$DW$115, DW_AT_high_pc(0x00)
	.dwattr $C$DW$115, DW_AT_linkage_name("__isfinite")
	.dwattr $C$DW$115, DW_AT_external
	.dwattr $C$DW$115, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$115, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$115, DW_AT_decl_line(0x14e)
	.dwattr $C$DW$115, DW_AT_decl_column(0x25)
	.dwattr $C$DW$115, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 335,column 1,is_stmt,address ||__isfinite||,isa 0

	.dwfde $C$DW$CIE, ||__isfinite||
$C$DW$116	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$116, DW_AT_name("d")
	.dwattr $C$DW$116, DW_AT_type(*$C$DW$T$84)
	.dwattr $C$DW$116, DW_AT_location[DW_OP_reg12]


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
$C$DW$117	.dwtag  DW_TAG_variable
	.dwattr $C$DW$117, DW_AT_name("d")
	.dwattr $C$DW$117, DW_AT_type(*$C$DW$T$85)
	.dwattr $C$DW$117, DW_AT_location[DW_OP_reg12]

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
$C$DW$118	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$118, DW_AT_low_pc(0x00)
	.dwattr $C$DW$118, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$115, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$115, DW_AT_TI_end_line(0x14f)
	.dwattr $C$DW$115, DW_AT_TI_end_column(0x2e)
	.dwendentry
	.dwendtag $C$DW$115

	.sect	".text:__fpclassifyl"
	.clink
	.global	||__fpclassifyl||

$C$DW$119	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$119, DW_AT_name("__fpclassifyl")
	.dwattr $C$DW$119, DW_AT_low_pc(||__fpclassifyl||)
	.dwattr $C$DW$119, DW_AT_high_pc(0x00)
	.dwattr $C$DW$119, DW_AT_linkage_name("__fpclassifyl")
	.dwattr $C$DW$119, DW_AT_external
	.dwattr $C$DW$119, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$119, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$119, DW_AT_decl_line(0x1ae)
	.dwattr $C$DW$119, DW_AT_decl_column(0x25)
	.dwattr $C$DW$119, DW_AT_TI_max_frame_size(-10)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 431,column 1,is_stmt,address ||__fpclassifyl||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassifyl||
$C$DW$120	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$120, DW_AT_name("e")
	.dwattr $C$DW$120, DW_AT_type(*$C$DW$T$87)
	.dwattr $C$DW$120, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __fpclassifyl                 FR SIZE:   8           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  4 Auto,  0 SOE     *
;***************************************************************

||__fpclassifyl||:
$C$DW$121	.dwtag  DW_TAG_variable
	.dwattr $C$DW$121, DW_AT_name("e")
	.dwattr $C$DW$121, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$121, DW_AT_location[DW_OP_breg20 -8]

;* AR5   assigned to $O$C1
;* AR4   assigned to e
$C$DW$122	.dwtag  DW_TAG_variable
	.dwattr $C$DW$122, DW_AT_name("e")
	.dwattr $C$DW$122, DW_AT_type(*$C$DW$T$88)
	.dwattr $C$DW$122, DW_AT_location[DW_OP_reg12]

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
        B         ||$C$L11||,NEQ        ; [CPU_ALU] |436| 
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
$C$DW$123	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$123, DW_AT_low_pc(0x00)
	.dwattr $C$DW$123, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$123, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |436| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |436| 
        CMPB      AL,#0                 ; [CPU_ALU] |436| 
        B         ||$C$L10||,EQ         ; [CPU_ALU] |436| 
        ; branchcc occurs ; [] |436| 
        MOVB      AL,#2                 ; [CPU_ALU] |436| 
        B         ||$C$L14||,UNC        ; [CPU_ALU] |436| 
        ; branch occurs ; [] |436| 
||$C$L10||:    
        MOVB      AL,#1                 ; [CPU_ALU] |436| 
        B         ||$C$L14||,UNC        ; [CPU_ALU] |436| 
        ; branch occurs ; [] |436| 
||$C$L11||:    
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
$C$DW$124	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$124, DW_AT_low_pc(0x00)
	.dwattr $C$DW$124, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$124, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |436| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |436| 
        CMPB      AL,#0                 ; [CPU_ALU] |436| 
        B         ||$C$L12||,EQ         ; [CPU_ALU] |436| 
        ; branchcc occurs ; [] |436| 
        MOV       AL,#-1                ; [CPU_ALU] |436| 
        B         ||$C$L14||,UNC        ; [CPU_ALU] |436| 
        ; branch occurs ; [] |436| 
||$C$L12||:    
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |436| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |436| 
        MOVL      P,XAR5                ; [CPU_ALU] |436| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |436| 
        AND       AL,#65535             ; [CPU_ALU] |436| 
        ANDB      AH,#15                ; [CPU_ALU] |436| 
        AND       PL,#65535             ; [CPU_ALU] |436| 
        AND       PH,#65535             ; [CPU_ALU] |436| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |436| 
$C$DW$125	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$125, DW_AT_low_pc(0x00)
	.dwattr $C$DW$125, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$125, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |436| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |436| 
        CMPB      AL,#0                 ; [CPU_ALU] |436| 
        B         ||$C$L13||,EQ         ; [CPU_ALU] |436| 
        ; branchcc occurs ; [] |436| 
        MOV       AL,#-2                ; [CPU_ALU] |436| 
        B         ||$C$L14||,UNC        ; [CPU_ALU] |436| 
        ; branch occurs ; [] |436| 
||$C$L13||:    
        MOVB      AL,#0                 ; [CPU_ALU] |436| 
||$C$L14||:    
        SUBB      SP,#8                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$126	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$126, DW_AT_low_pc(0x00)
	.dwattr $C$DW$126, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$119, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$119, DW_AT_TI_end_line(0x1bd)
	.dwattr $C$DW$119, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$119

	.sect	".text:__fpclassifyf"
	.clink
	.global	||__fpclassifyf||

$C$DW$127	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$127, DW_AT_name("__fpclassifyf")
	.dwattr $C$DW$127, DW_AT_low_pc(||__fpclassifyf||)
	.dwattr $C$DW$127, DW_AT_high_pc(0x00)
	.dwattr $C$DW$127, DW_AT_linkage_name("__fpclassifyf")
	.dwattr $C$DW$127, DW_AT_external
	.dwattr $C$DW$127, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$127, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$127, DW_AT_decl_line(0x18c)
	.dwattr $C$DW$127, DW_AT_decl_column(0x25)
	.dwattr $C$DW$127, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 397,column 1,is_stmt,address ||__fpclassifyf||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassifyf||
$C$DW$128	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$128, DW_AT_name("f")
	.dwattr $C$DW$128, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$128, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$129	.dwtag  DW_TAG_variable
	.dwattr $C$DW$129, DW_AT_name("f")
	.dwattr $C$DW$129, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$129, DW_AT_location[DW_OP_regx 0x2b]

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
        B         ||$C$L16||,NEQ        ; [CPU_ALU] |402| 
        ; branchcc occurs ; [] |402| 
        MOVL      ACC,P                 ; [CPU_ALU] |402| 
        ANDB      AH,#127               ; [CPU_ALU] |402| 
        TEST      ACC                   ; [CPU_ALU] |402| 
        B         ||$C$L15||,EQ         ; [CPU_ALU] |402| 
        ; branchcc occurs ; [] |402| 
	.dwcfi	remember_state
        MOVB      AL,#2                 ; [CPU_ALU] |402| 
$C$DW$130	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$130, DW_AT_low_pc(0x00)
	.dwattr $C$DW$130, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L15||:    
	.dwcfi	remember_state
        MOVB      AL,#1                 ; [CPU_ALU] |402| 
$C$DW$131	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$131, DW_AT_low_pc(0x00)
	.dwattr $C$DW$131, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L16||:    
        MOVL      ACC,P                 ; [CPU_ALU] |402| 
        MOV       T,#23                 ; [CPU_ALU] |402| 
        LSRL      ACC,T                 ; [CPU_ALU] |402| 
        ANDB      AL,#0xff              ; [CPU_ALU] |402| 
        B         ||$C$L17||,EQ         ; [CPU_ALU] |402| 
        ; branchcc occurs ; [] |402| 
	.dwcfi	remember_state
        MOV       AL,#-1                ; [CPU_ALU] |402| 
$C$DW$132	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$132, DW_AT_low_pc(0x00)
	.dwattr $C$DW$132, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L17||:    
        MOVL      ACC,P                 ; [CPU_ALU] |402| 
        ANDB      AH,#127               ; [CPU_ALU] |402| 
        TEST      ACC                   ; [CPU_ALU] |402| 
        B         ||$C$L18||,EQ         ; [CPU_ALU] |402| 
        ; branchcc occurs ; [] |402| 
	.dwcfi	remember_state
        MOV       AL,#-2                ; [CPU_ALU] |402| 
$C$DW$133	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$133, DW_AT_low_pc(0x00)
	.dwattr $C$DW$133, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L18||:    
        MOVB      AL,#0                 ; [CPU_ALU] |402| 
$C$DW$134	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$134, DW_AT_low_pc(0x00)
	.dwattr $C$DW$134, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$127, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$127, DW_AT_TI_end_line(0x19b)
	.dwattr $C$DW$127, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$127

	.sect	".text:__fpclassify"
	.clink
	.global	||__fpclassify||

$C$DW$135	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$135, DW_AT_name("__fpclassify")
	.dwattr $C$DW$135, DW_AT_low_pc(||__fpclassify||)
	.dwattr $C$DW$135, DW_AT_high_pc(0x00)
	.dwattr $C$DW$135, DW_AT_linkage_name("__fpclassify")
	.dwattr $C$DW$135, DW_AT_external
	.dwattr $C$DW$135, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$135, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$135, DW_AT_decl_line(0x19d)
	.dwattr $C$DW$135, DW_AT_decl_column(0x25)
	.dwattr $C$DW$135, DW_AT_TI_max_frame_size(-10)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 414,column 1,is_stmt,address ||__fpclassify||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassify||
$C$DW$136	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$136, DW_AT_name("d")
	.dwattr $C$DW$136, DW_AT_type(*$C$DW$T$84)
	.dwattr $C$DW$136, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __fpclassify                  FR SIZE:   8           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  4 Auto,  0 SOE     *
;***************************************************************

||__fpclassify||:
$C$DW$137	.dwtag  DW_TAG_variable
	.dwattr $C$DW$137, DW_AT_name("d")
	.dwattr $C$DW$137, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$137, DW_AT_location[DW_OP_breg20 -8]

;* AR5   assigned to $O$C1
;* AR4   assigned to d
$C$DW$138	.dwtag  DW_TAG_variable
	.dwattr $C$DW$138, DW_AT_name("d")
	.dwattr $C$DW$138, DW_AT_type(*$C$DW$T$85)
	.dwattr $C$DW$138, DW_AT_location[DW_OP_reg12]

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
        B         ||$C$L20||,NEQ        ; [CPU_ALU] |419| 
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
$C$DW$139	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$139, DW_AT_low_pc(0x00)
	.dwattr $C$DW$139, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$139, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |419| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |419| 
        CMPB      AL,#0                 ; [CPU_ALU] |419| 
        B         ||$C$L19||,EQ         ; [CPU_ALU] |419| 
        ; branchcc occurs ; [] |419| 
        MOVB      AL,#2                 ; [CPU_ALU] |419| 
        B         ||$C$L23||,UNC        ; [CPU_ALU] |419| 
        ; branch occurs ; [] |419| 
||$C$L19||:    
        MOVB      AL,#1                 ; [CPU_ALU] |419| 
        B         ||$C$L23||,UNC        ; [CPU_ALU] |419| 
        ; branch occurs ; [] |419| 
||$C$L20||:    
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
$C$DW$140	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$140, DW_AT_low_pc(0x00)
	.dwattr $C$DW$140, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$140, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |419| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |419| 
        CMPB      AL,#0                 ; [CPU_ALU] |419| 
        B         ||$C$L21||,EQ         ; [CPU_ALU] |419| 
        ; branchcc occurs ; [] |419| 
        MOV       AL,#-1                ; [CPU_ALU] |419| 
        B         ||$C$L23||,UNC        ; [CPU_ALU] |419| 
        ; branch occurs ; [] |419| 
||$C$L21||:    
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |419| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |419| 
        MOVL      P,XAR5                ; [CPU_ALU] |419| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |419| 
        AND       AL,#65535             ; [CPU_ALU] |419| 
        ANDB      AH,#15                ; [CPU_ALU] |419| 
        AND       PL,#65535             ; [CPU_ALU] |419| 
        AND       PH,#65535             ; [CPU_ALU] |419| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |419| 
$C$DW$141	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$141, DW_AT_low_pc(0x00)
	.dwattr $C$DW$141, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$141, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |419| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |419| 
        CMPB      AL,#0                 ; [CPU_ALU] |419| 
        B         ||$C$L22||,EQ         ; [CPU_ALU] |419| 
        ; branchcc occurs ; [] |419| 
        MOV       AL,#-2                ; [CPU_ALU] |419| 
        B         ||$C$L23||,UNC        ; [CPU_ALU] |419| 
        ; branch occurs ; [] |419| 
||$C$L22||:    
        MOVB      AL,#0                 ; [CPU_ALU] |419| 
||$C$L23||:    
        SUBB      SP,#8                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$142	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$142, DW_AT_low_pc(0x00)
	.dwattr $C$DW$142, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$135, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$135, DW_AT_TI_end_line(0x1ac)
	.dwattr $C$DW$135, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$135

	.sect	"ramfuncs"
	.clink
	.global	||BTS_updateReference||

$C$DW$143	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$143, DW_AT_name("BTS_updateReference")
	.dwattr $C$DW$143, DW_AT_low_pc(||BTS_updateReference||)
	.dwattr $C$DW$143, DW_AT_high_pc(0x00)
	.dwattr $C$DW$143, DW_AT_linkage_name("BTS_updateReference")
	.dwattr $C$DW$143, DW_AT_external
	.dwattr $C$DW$143, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$143, DW_AT_decl_line(0x178)
	.dwattr $C$DW$143, DW_AT_decl_column(0x06)
	.dwattr $C$DW$143, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts.c",line 377,column 1,is_stmt,address ||BTS_updateReference||,isa 0

	.dwfde $C$DW$CIE, ||BTS_updateReference||
$C$DW$144	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$144, DW_AT_name("userInput")
	.dwattr $C$DW$144, DW_AT_type(*$C$DW$T$50)
	.dwattr $C$DW$144, DW_AT_location[DW_OP_reg12]

$C$DW$145	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$145, DW_AT_name("ctrlLoopVariable")
	.dwattr $C$DW$145, DW_AT_type(*$C$DW$T$55)
	.dwattr $C$DW$145, DW_AT_location[DW_OP_reg14]


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
$C$DW$146	.dwtag  DW_TAG_variable
	.dwattr $C$DW$146, DW_AT_name("userInput")
	.dwattr $C$DW$146, DW_AT_type(*$C$DW$T$51)
	.dwattr $C$DW$146, DW_AT_location[DW_OP_reg12]

;* AR5   assigned to ctrlLoopVariable
$C$DW$147	.dwtag  DW_TAG_variable
	.dwattr $C$DW$147, DW_AT_name("ctrlLoopVariable")
	.dwattr $C$DW$147, DW_AT_type(*$C$DW$T$56)
	.dwattr $C$DW$147, DW_AT_location[DW_OP_reg14]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts.c",line 379,column 5,is_stmt,isa 0
        MOV       AL,*+XAR4[7]          ; [CPU_ALU] |379| 
	.dwpsn	file "../bts.c",line 383,column 9,is_stmt,isa 0
        MOVB      XAR0,#34,EQ           ; [CPU_ALU] |383| 
        MOVB      *+XAR5[AR0],#1,EQ     ; [CPU_ALU] |383| 
        B         ||$C$L24||,EQ         ; [CPU_ALU] |383| 
        ; branchcc occurs ; [] |383| 
	.dwpsn	file "../bts.c",line 380,column 9,is_stmt,isa 0
        MOVB      XAR0,#34              ; [CPU_ALU] |380| 
        MOV       *+XAR5[AR0],#0        ; [CPU_ALU] |380| 
||$C$L24||:    
	.dwpsn	file "../bts.c",line 388,column 5,is_stmt,isa 0
        MOVB      XAR0,#14              ; [CPU_ALU] |388| 
        MOV32     R0H,*+XAR4[0]         ; [CPU_FPU] |388| 
        MOVB      XAR1,#16              ; [CPU_ALU] |388| 
        MOV32     R1H,*+XAR4[AR0]       ; [CPU_FPU] |388| 
        MPYF32    R0H,R1H,R0H           ; [CPU_FPU] |388| 
        MOV32     R3H,*+XAR4[AR1]       ; [CPU_FPU] |388| 
        ADDF32    R0H,R0H,R3H           ; [CPU_FPU] |388| 
	.dwpsn	file "../bts.c",line 390,column 5,is_stmt,isa 0
        MOVB      XAR0,#8               ; [CPU_ALU] |390| 
	.dwpsn	file "../bts.c",line 388,column 5,is_stmt,isa 0
        MOV32     *+XAR5[4],R0H         ; [CPU_FPU] |388| 
	.dwpsn	file "../bts.c",line 390,column 5,is_stmt,isa 0
        MOVL      ACC,*+XAR4[AR0]       ; [CPU_ALU] |390| 
        MOVL      *+XAR5[2],ACC         ; [CPU_ALU] |390| 
	.dwpsn	file "../bts.c",line 392,column 5,is_stmt,isa 0
        MOV       AL,*+XAR4[6]          ; [CPU_ALU] |392| 
        CMPB      AL,#1                 ; [CPU_ALU] |392| 
        B         ||$C$L25||,EQ         ; [CPU_ALU] |392| 
        ; branchcc occurs ; [] |392| 
	.dwpsn	file "../bts.c",line 399,column 9,is_stmt,isa 0
        MOVB      XAR0,#31              ; [CPU_ALU] |399| 
	.dwpsn	file "../bts.c",line 398,column 9,is_stmt,isa 0
        MOVIZ     R0H,#49024            ; [CPU_FPU] |398| 
	.dwpsn	file "../bts.c",line 399,column 9,is_stmt,isa 0
        MOV       *+XAR5[AR0],#0        ; [CPU_ALU] |399| 
	.dwpsn	file "../bts.c",line 398,column 9,is_stmt,isa 0
        MOVB      XAR0,#24              ; [CPU_ALU] |398| 
        MOV32     *+XAR5[AR0],R0H       ; [CPU_FPU] |398| 
	.dwpsn	file "../bts.c",line 400,column 9,is_stmt,isa 0
        MOV32     R0H,*+XAR4[4]         ; [CPU_FPU] |400| 
        B         ||$C$L26||,UNC        ; [CPU_ALU] |400| 
        ; branch occurs ; [] |400| 
||$C$L25||:    
	.dwpsn	file "../bts.c",line 394,column 9,is_stmt,isa 0
        MOVB      XAR0,#31              ; [CPU_ALU] |394| 
	.dwpsn	file "../bts.c",line 393,column 9,is_stmt,isa 0
        MOVIZ     R0H,#16256            ; [CPU_FPU] |393| 
	.dwpsn	file "../bts.c",line 394,column 9,is_stmt,isa 0
        MOVB      *+XAR5[AR0],#1,UNC    ; [CPU_ALU] |394| 
	.dwpsn	file "../bts.c",line 393,column 9,is_stmt,isa 0
        MOVB      XAR0,#24              ; [CPU_ALU] |393| 
        MOV32     *+XAR5[AR0],R0H       ; [CPU_FPU] |393| 
	.dwpsn	file "../bts.c",line 395,column 9,is_stmt,isa 0
        MOV32     R0H,*+XAR4[2]         ; [CPU_FPU] |395| 
||$C$L26||:    
        MOVB      XAR1,#22              ; [CPU_ALU] |395| 
        MOVB      XAR0,#24              ; [CPU_ALU] |395| 
        MOV32     R1H,*+XAR4[AR1]       ; [CPU_FPU] |395| 
        MPYF32    R0H,R1H,R0H           ; [CPU_FPU] |395| 
        MOV32     R3H,*+XAR4[AR0]       ; [CPU_FPU] |395| 
        ADDF32    R0H,R0H,R3H           ; [CPU_FPU] |395| 
        MOVB      XAR0,#10              ; [CPU_ALU] |395| 
        MOV32     *+XAR5[AR0],R0H       ; [CPU_FPU] |395| 
        MOVL      XAR1,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$148	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$148, DW_AT_low_pc(0x00)
	.dwattr $C$DW$148, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$143, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$143, DW_AT_TI_end_line(0x1a7)
	.dwattr $C$DW$143, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$143

	.sect	".text"
	.clink
	.global	||BTS_setupSfraGui||

$C$DW$149	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$149, DW_AT_name("BTS_setupSfraGui")
	.dwattr $C$DW$149, DW_AT_low_pc(||BTS_setupSfraGui||)
	.dwattr $C$DW$149, DW_AT_high_pc(0x00)
	.dwattr $C$DW$149, DW_AT_linkage_name("BTS_setupSfraGui")
	.dwattr $C$DW$149, DW_AT_external
	.dwattr $C$DW$149, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$149, DW_AT_decl_line(0x161)
	.dwattr $C$DW$149, DW_AT_decl_column(0x06)
	.dwattr $C$DW$149, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts.c",line 354,column 1,is_stmt,address ||BTS_setupSfraGui||,isa 0

	.dwfde $C$DW$CIE, ||BTS_setupSfraGui||

;***************************************************************
;* FNAME: BTS_setupSfraGui              FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_setupSfraGui||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
$C$DW$150	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$150, DW_AT_low_pc(0x00)
	.dwattr $C$DW$150, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$149, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$149, DW_AT_TI_end_line(0x171)
	.dwattr $C$DW$149, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$149

	.sect	".text"
	.clink
	.global	||BTS_setupSfra||

$C$DW$151	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$151, DW_AT_name("BTS_setupSfra")
	.dwattr $C$DW$151, DW_AT_low_pc(||BTS_setupSfra||)
	.dwattr $C$DW$151, DW_AT_high_pc(0x00)
	.dwattr $C$DW$151, DW_AT_linkage_name("BTS_setupSfra")
	.dwattr $C$DW$151, DW_AT_external
	.dwattr $C$DW$151, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$151, DW_AT_decl_line(0x148)
	.dwattr $C$DW$151, DW_AT_decl_column(0x06)
	.dwattr $C$DW$151, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts.c",line 329,column 1,is_stmt,address ||BTS_setupSfra||,isa 0

	.dwfde $C$DW$CIE, ||BTS_setupSfra||

;***************************************************************
;* FNAME: BTS_setupSfra                 FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||BTS_setupSfra||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
$C$DW$152	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$152, DW_AT_low_pc(0x00)
	.dwattr $C$DW$152, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$151, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$151, DW_AT_TI_end_line(0x15f)
	.dwattr $C$DW$151, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$151

	.sect	".text"
	.clink
	.global	||BTS_setupHrpwmMepScaleFactor||

$C$DW$153	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$153, DW_AT_name("BTS_setupHrpwmMepScaleFactor")
	.dwattr $C$DW$153, DW_AT_low_pc(||BTS_setupHrpwmMepScaleFactor||)
	.dwattr $C$DW$153, DW_AT_high_pc(0x00)
	.dwattr $C$DW$153, DW_AT_linkage_name("BTS_setupHrpwmMepScaleFactor")
	.dwattr $C$DW$153, DW_AT_external
	.dwattr $C$DW$153, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$153, DW_AT_decl_line(0x13a)
	.dwattr $C$DW$153, DW_AT_decl_column(0x06)
	.dwattr $C$DW$153, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../bts.c",line 315,column 1,is_stmt,address ||BTS_setupHrpwmMepScaleFactor||,isa 0

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
||$C$L27||:    
	.dwpsn	file "../bts.c",line 321,column 13,is_stmt,isa 0
$C$DW$154	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$154, DW_AT_low_pc(0x00)
	.dwattr $C$DW$154, DW_AT_name("SFO")
	.dwattr $C$DW$154, DW_AT_TI_call

        LCR       #||SFO||              ; [CPU_ALU] |321| 
        ; call occurs [#||SFO||] ; [] |321| 
        MOVW      DP,#||BTS_sfoStatus|| ; [CPU_ARAU] 
        CMPB      AL,#0                 ; [CPU_ALU] |321| 
        MOV       @||BTS_sfoStatus||,AL ; [CPU_FPU] |321| 
        B         ||$C$L27||,EQ         ; [CPU_ALU] |321| 
        ; branchcc occurs ; [] |321| 
$C$DW$155	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$155, DW_AT_low_pc(0x00)
	.dwattr $C$DW$155, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$153, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$153, DW_AT_TI_end_line(0x144)
	.dwattr $C$DW$153, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$153

	.sect	"ramfuncs"
	.clink
	.global	||BTS_monitor_Iout_Vout||

$C$DW$156	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$156, DW_AT_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$156, DW_AT_low_pc(||BTS_monitor_Iout_Vout||)
	.dwattr $C$DW$156, DW_AT_high_pc(0x00)
	.dwattr $C$DW$156, DW_AT_linkage_name("BTS_monitor_Iout_Vout")
	.dwattr $C$DW$156, DW_AT_external
	.dwattr $C$DW$156, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$156, DW_AT_decl_line(0x1ab)
	.dwattr $C$DW$156, DW_AT_decl_column(0x06)
	.dwattr $C$DW$156, DW_AT_TI_max_frame_size(-8)
	.dwpsn	file "../bts.c",line 428,column 1,is_stmt,address ||BTS_monitor_Iout_Vout||,isa 0

	.dwfde $C$DW$CIE, ||BTS_monitor_Iout_Vout||
$C$DW$157	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$157, DW_AT_name("measValues")
	.dwattr $C$DW$157, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$157, DW_AT_location[DW_OP_reg12]


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
$C$DW$158	.dwtag  DW_TAG_variable
	.dwattr $C$DW$158, DW_AT_name("measValues")
	.dwattr $C$DW$158, DW_AT_type(*$C$DW$T$61)
	.dwattr $C$DW$158, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts.c",line 429,column 5,is_stmt,isa 0
        MOVB      XAR0,#68              ; [CPU_ALU] |429| 
        MOVL      XAR5,XAR4             ; [CPU_ALU] 
        MOVB      XAR1,#68              ; [CPU_ALU] 
        MOVB      XAR6,#0               ; [CPU_ALU] |429| 
	.dwpsn	file "../bts.c",line 430,column 5,is_stmt,isa 0
        MOVB      ACC,#0                ; [CPU_ALU] |430| 
        MOV32     *SP++,R4H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 59, 4
	.dwcfi	cfa_offset, -6
        SETC      SXM                   ; [CPU_ALU] 
        MOV       P,#0                  ; [CPU_ALU] 
        MOV32     *SP++,R5H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 63, 6
	.dwcfi	cfa_offset, -8
        ADDB      XAR5,#4               ; [CPU_ALU] 
	.dwpsn	file "../bts.c",line 429,column 5,is_stmt,isa 0
        MOVL      *+XAR4[AR0],XAR6      ; [CPU_ALU] |429| 
	.dwpsn	file "../bts.c",line 430,column 5,is_stmt,isa 0
        MOVB      XAR0,#70              ; [CPU_ALU] |430| 
        MOVB      XAR6,#3               ; [CPU_ALU] 
        MOVL      XAR7,*+XAR4[AR1]      ; [CPU_ALU] 
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |430| 
	.dwpsn	file "../bts.c",line 433,column 19,is_stmt,isa 0
        RPTB      ||$C$L29||,AR6        ; [CPU_ALU] |433| 
        ; repeat block starts ; [] 
||$C$L28||:    
        MOVL      ACC,XAR7              ; [CPU_ALU] 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        MOVB      XAR1,#68              ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        MOVB      XAR0,#32              ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |434| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |434| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |434| 
        MOVL      ACC,P                 ; [CPU_ALU] |434| 
        MOVB      XAR1,#68              ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |435| 
        MOVB      XAR0,#70              ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        MOVL      P,ACC                 ; [CPU_ALU] |435| 
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |435| 
        MOVB      XAR0,#32              ; [CPU_ALU] |435| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |434| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |434| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |434| 
        MOVL      ACC,P                 ; [CPU_ALU] |434| 
        MOVB      XAR1,#68              ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |435| 
        MOVB      XAR0,#70              ; [CPU_ALU] |435| 
        MOVL      P,ACC                 ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |435| 
        MOVB      XAR0,#32              ; [CPU_ALU] |435| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |434| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |434| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |434| 
        MOVL      ACC,P                 ; [CPU_ALU] |434| 
        MOVB      XAR1,#68              ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |435| 
        MOVB      XAR0,#70              ; [CPU_ALU] |435| 
        MOVL      P,ACC                 ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |435| 
        MOVB      XAR0,#32              ; [CPU_ALU] |435| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |434| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |434| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |434| 
        MOVL      ACC,P                 ; [CPU_ALU] |434| 
        MOVB      XAR1,#68              ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |435| 
        MOVB      XAR0,#70              ; [CPU_ALU] |435| 
        MOVL      P,ACC                 ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |435| 
        MOVB      XAR0,#32              ; [CPU_ALU] |435| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |434| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |434| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |434| 
        MOVL      ACC,P                 ; [CPU_ALU] |434| 
        MOVB      XAR1,#68              ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |435| 
        MOVB      XAR0,#70              ; [CPU_ALU] |435| 
        MOVL      P,ACC                 ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |435| 
        MOVB      XAR0,#32              ; [CPU_ALU] |435| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |434| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |434| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |434| 
        MOVL      ACC,P                 ; [CPU_ALU] |434| 
        MOVB      XAR1,#68              ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |435| 
        MOVB      XAR0,#70              ; [CPU_ALU] |435| 
        MOVL      P,ACC                 ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |435| 
        MOVB      XAR0,#32              ; [CPU_ALU] |435| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |434| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |434| 
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |434| 
        MOVL      ACC,P                 ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        MOVB      XAR1,#70              ; [CPU_ALU] |435| 
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |435| 
        MOVB      XAR0,#70              ; [CPU_ALU] |435| 
        MOVL      P,ACC                 ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        MOVB      XAR0,#68              ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        MOVL      ACC,XAR7              ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[0]         ; [CPU_ALU] |434| 
        MOVL      XAR7,ACC              ; [CPU_ALU] |434| 
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        MOVB      XAR0,#32              ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 434,column 9,is_stmt,isa 0
        MOVL      ACC,P                 ; [CPU_ALU] |434| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        ADD       ACC,*+XAR5[AR0]       ; [CPU_ALU] |435| 
        MOVL      P,ACC                 ; [CPU_ALU] |435| 
	.dwpsn	file "../bts.c",line 433,column 19,is_stmt,isa 0
        ADDB      XAR5,#1               ; [CPU_ALU] |433| 
	.dwpsn	file "../bts.c",line 435,column 9,is_stmt,isa 0
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |435| 
        ; repeat block ends ; [] 
||$C$L29||:    
	.dwpsn	file "../bts.c",line 438,column 5,is_stmt,isa 0
        MOVB      XAR0,#68              ; [CPU_ALU] |438| 
        I32TOF32  R1H,*+XAR4[AR0]       ; [CPU_FPU] |438| 
	.dwpsn	file "../bts.c",line 440,column 5,is_stmt,isa 0
        MOVB      XAR0,#70              ; [CPU_ALU] |440| 
        MOVB      XAR1,#78              ; [CPU_ALU] |440| 
        I32TOF32  R0H,*+XAR4[AR0]       ; [CPU_FPU] |440| 
	.dwpsn	file "../bts.c",line 438,column 5,is_stmt,isa 0
        MOVB      XAR0,#74              ; [CPU_ALU] |438| 
        MPYF32    R4H,R1H,#13696        ; [CPU_FPU] |438| 
        MOV32     R3H,*+XAR4[AR0]       ; [CPU_FPU] |438| 
        MOVB      XAR0,#76              ; [CPU_ALU] |438| 
        MOV32     R5H,*+XAR4[AR0]       ; [CPU_FPU] |438| 
	.dwpsn	file "../bts.c",line 440,column 5,is_stmt,isa 0
        MPYF32    R1H,R0H,#13696        ; [CPU_FPU] |440| 
        MOVB      XAR0,#80              ; [CPU_ALU] |440| 
	.dwpsn	file "../bts.c",line 438,column 5,is_stmt,isa 0

        MPYF32    R3H,R4H,R3H           ; [CPU_FPU] |438| 
||      MOV32     R2H,*+XAR4[AR1]       ; [CPU_FPU] |440| 

	.dwpsn	file "../bts.c",line 440,column 5,is_stmt,isa 0
        MPYF32    R0H,R1H,R2H           ; [CPU_FPU] |440| 
	.dwpsn	file "../bts.c",line 438,column 5,is_stmt,isa 0

        ADDF32    R1H,R5H,R3H           ; [CPU_FPU] |438| 
||      MOV32     R2H,*+XAR4[AR0]       ; [CPU_FPU] |440| 

	.dwpsn	file "../bts.c",line 440,column 5,is_stmt,isa 0
        ADDF32    R0H,R0H,R2H           ; [CPU_FPU] |440| 
	.dwpsn	file "../bts.c",line 438,column 5,is_stmt,isa 0
        MOV32     *+XAR4[0],R1H         ; [CPU_FPU] |438| 
	.dwpsn	file "../bts.c",line 440,column 5,is_stmt,isa 0
        MOV32     *+XAR4[2],R0H         ; [CPU_FPU] |440| 
        MOV32     R5H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -6
	.dwcfi	restore_reg, 63
        MOV32     R4H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 59
        MOVL      XAR1,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$159	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$159, DW_AT_low_pc(0x00)
	.dwattr $C$DW$159, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$156, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$156, DW_AT_TI_end_line(0x1ba)
	.dwattr $C$DW$156, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$156

	.sect	".text"
	.clink
	.global	||BTS_initUserVariables||

$C$DW$160	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$160, DW_AT_name("BTS_initUserVariables")
	.dwattr $C$DW$160, DW_AT_low_pc(||BTS_initUserVariables||)
	.dwattr $C$DW$160, DW_AT_high_pc(0x00)
	.dwattr $C$DW$160, DW_AT_linkage_name("BTS_initUserVariables")
	.dwattr $C$DW$160, DW_AT_external
	.dwattr $C$DW$160, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$160, DW_AT_decl_line(0x89)
	.dwattr $C$DW$160, DW_AT_decl_column(0x06)
	.dwattr $C$DW$160, DW_AT_TI_max_frame_size(-64)
	.dwpsn	file "../bts.c",line 138,column 1,is_stmt,address ||BTS_initUserVariables||,isa 0

	.dwfde $C$DW$CIE, ||BTS_initUserVariables||

;***************************************************************
;* FNAME: BTS_initUserVariables         FR SIZE:  62           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter, 54 Auto,  8 SOE     *
;***************************************************************

||BTS_initUserVariables||:
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
        ADDB      SP,#54                ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -64
        MOVW      DP,#||BTS_userInput_ch1||+6 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 143,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16492            ; [CPU_FPU] |143| 
	.dwpsn	file "../bts.c",line 139,column 5,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_userInput_ch1||)+6,#1,UNC ; [CPU_ALU] |139| 
	.dwpsn	file "../bts.c",line 141,column 5,is_stmt,isa 0
        ZERO      R3H                   ; [CPU_FPU] |141| 
	.dwpsn	file "../bts.c",line 142,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16256            ; [CPU_FPU] |142| 
	.dwpsn	file "../bts.c",line 144,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16128            ; [CPU_FPU] |144| 
	.dwpsn	file "../bts.c",line 140,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_userInput_ch1||)+7,#0 ; [CPU_ALU] |140| 
	.dwpsn	file "../bts.c",line 143,column 5,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |143| 
	.dwpsn	file "../bts.c",line 201,column 5,is_stmt,isa 0
        MOVIZ     R7H,#14600            ; [CPU_FPU] |201| 
	.dwpsn	file "../bts.c",line 202,column 5,is_stmt,isa 0
        MOVIZ     R6H,#15766            ; [CPU_FPU] |202| 
	.dwpsn	file "../bts.c",line 203,column 5,is_stmt,isa 0
        MOVIZ     R5H,#14600            ; [CPU_FPU] |203| 
	.dwpsn	file "../bts.c",line 205,column 5,is_stmt,isa 0
        MOVIZ     R4H,#15947            ; [CPU_FPU] |205| 
	.dwpsn	file "../bts.c",line 141,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+8,R3H ; [CPU_FPU] |141| 
	.dwpsn	file "../bts.c",line 142,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||),R2H ; [CPU_FPU] |142| 
	.dwpsn	file "../bts.c",line 161,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16256            ; [CPU_FPU] |161| 
	.dwpsn	file "../bts.c",line 143,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+2,R0H ; [CPU_FPU] |143| 
	.dwpsn	file "../bts.c",line 162,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16492            ; [CPU_FPU] |162| 
	.dwpsn	file "../bts.c",line 144,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+4,R1H ; [CPU_FPU] |144| 
	.dwpsn	file "../bts.c",line 162,column 5,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |162| 
	.dwpsn	file "../bts.c",line 158,column 5,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_userInput_ch2||)+6,#1,UNC ; [CPU_ALU] |158| 
	.dwpsn	file "../bts.c",line 163,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16128            ; [CPU_FPU] |163| 
	.dwpsn	file "../bts.c",line 159,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_userInput_ch2||)+7,#0 ; [CPU_ALU] |159| 
	.dwpsn	file "../bts.c",line 160,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+8,R3H ; [CPU_FPU] |160| 
	.dwpsn	file "../bts.c",line 161,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||),R2H ; [CPU_FPU] |161| 
	.dwpsn	file "../bts.c",line 178,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16256            ; [CPU_FPU] |178| 
	.dwpsn	file "../bts.c",line 162,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+2,R0H ; [CPU_FPU] |162| 
	.dwpsn	file "../bts.c",line 179,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16492            ; [CPU_FPU] |179| 
	.dwpsn	file "../bts.c",line 201,column 5,is_stmt,isa 0
        MOVXI     R7H,#46848            ; [CPU_FPU] |201| 
	.dwpsn	file "../bts.c",line 202,column 5,is_stmt,isa 0
        MOVXI     R6H,#12816            ; [CPU_FPU] |202| 
	.dwpsn	file "../bts.c",line 203,column 5,is_stmt,isa 0
        MOVXI     R5H,#46848            ; [CPU_FPU] |203| 
	.dwpsn	file "../bts.c",line 205,column 5,is_stmt,isa 0
        MOVXI     R4H,#6469             ; [CPU_FPU] |205| 
	.dwpsn	file "../bts.c",line 179,column 5,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |179| 
	.dwpsn	file "../bts.c",line 163,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+4,R1H ; [CPU_FPU] |163| 
        MOVW      DP,#||BTS_userInput_ch3||+6 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 180,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16128            ; [CPU_FPU] |180| 
	.dwpsn	file "../bts.c",line 175,column 5,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_userInput_ch3||)+6,#1,UNC ; [CPU_ALU] |175| 
	.dwpsn	file "../bts.c",line 176,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_userInput_ch3||)+7,#0 ; [CPU_ALU] |176| 
	.dwpsn	file "../bts.c",line 177,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+8,R3H ; [CPU_FPU] |177| 
	.dwpsn	file "../bts.c",line 206,column 5,is_stmt,isa 0
        MOVIZ     R3H,#47525            ; [CPU_FPU] |206| 
	.dwpsn	file "../bts.c",line 178,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||),R2H ; [CPU_FPU] |178| 
	.dwpsn	file "../bts.c",line 207,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16545            ; [CPU_FPU] |207| 
	.dwpsn	file "../bts.c",line 179,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+2,R0H ; [CPU_FPU] |179| 
	.dwpsn	file "../bts.c",line 146,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15766            ; [CPU_FPU] |146| 
        MOV32     *-SP[2],R0H           ; [CPU_FPU] |146| 
	.dwpsn	file "../bts.c",line 147,column 5,is_stmt,isa 0
        MOVIZ     R0H,#14600            ; [CPU_FPU] |147| 
	.dwpsn	file "../bts.c",line 180,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+4,R1H ; [CPU_FPU] |180| 
	.dwpsn	file "../bts.c",line 147,column 5,is_stmt,isa 0
        MOV32     *-SP[4],R0H           ; [CPU_FPU] |147| 
	.dwpsn	file "../bts.c",line 148,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15766            ; [CPU_FPU] |148| 
	.dwpsn	file "../bts.c",line 197,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16492            ; [CPU_FPU] |197| 
	.dwpsn	file "../bts.c",line 148,column 5,is_stmt,isa 0
        MOV32     *-SP[6],R1H           ; [CPU_FPU] |148| 
	.dwpsn	file "../bts.c",line 197,column 5,is_stmt,isa 0
        MOV32     *-SP[52],R0H          ; [CPU_FPU] |197| 
	.dwpsn	file "../bts.c",line 149,column 5,is_stmt,isa 0
        MOVIZ     R1H,#14600            ; [CPU_FPU] |149| 
	.dwpsn	file "../bts.c",line 196,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16256            ; [CPU_FPU] |196| 
	.dwpsn	file "../bts.c",line 193,column 5,is_stmt,isa 0
        MOVB      @$BLOCKED(||BTS_userInput_ch4||)+6,#1,UNC ; [CPU_ALU] |193| 
	.dwpsn	file "../bts.c",line 149,column 5,is_stmt,isa 0
        MOV32     *-SP[8],R1H           ; [CPU_FPU] |149| 
	.dwpsn	file "../bts.c",line 196,column 5,is_stmt,isa 0
        MOV32     *-SP[50],R0H          ; [CPU_FPU] |196| 
	.dwpsn	file "../bts.c",line 151,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15947            ; [CPU_FPU] |151| 
	.dwpsn	file "../bts.c",line 195,column 5,is_stmt,isa 0
        ZERO      R0H                   ; [CPU_FPU] |195| 
	.dwpsn	file "../bts.c",line 151,column 5,is_stmt,isa 0
        MOV32     *-SP[10],R1H          ; [CPU_FPU] |151| 
	.dwpsn	file "../bts.c",line 206,column 5,is_stmt,isa 0
        MOVXI     R3H,#44544            ; [CPU_FPU] |206| 
	.dwpsn	file "../bts.c",line 152,column 5,is_stmt,isa 0
        MOVIZ     R1H,#47525            ; [CPU_FPU] |152| 
	.dwpsn	file "../bts.c",line 194,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_userInput_ch4||)+7,#0 ; [CPU_ALU] |194| 
	.dwpsn	file "../bts.c",line 152,column 5,is_stmt,isa 0
        MOV32     *-SP[12],R1H          ; [CPU_FPU] |152| 
	.dwpsn	file "../bts.c",line 153,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16545            ; [CPU_FPU] |153| 
        MOV32     *-SP[14],R1H          ; [CPU_FPU] |153| 
	.dwpsn	file "../bts.c",line 207,column 5,is_stmt,isa 0
        MOVXI     R2H,#22300            ; [CPU_FPU] |207| 
	.dwpsn	file "../bts.c",line 154,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15056            ; [CPU_FPU] |154| 
	.dwpsn	file "../bts.c",line 195,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+8,R0H ; [CPU_FPU] |195| 
	.dwpsn	file "../bts.c",line 154,column 5,is_stmt,isa 0
        MOV32     *-SP[16],R1H          ; [CPU_FPU] |154| 
	.dwpsn	file "../bts.c",line 165,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15766            ; [CPU_FPU] |165| 
	.dwpsn	file "../bts.c",line 195,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[2]           ; [CPU_FPU] |195| 
	.dwpsn	file "../bts.c",line 146,column 5,is_stmt,isa 0
        MOVXI     R0H,#12816            ; [CPU_FPU] |146| 
	.dwpsn	file "../bts.c",line 165,column 5,is_stmt,isa 0
        MOV32     *-SP[18],R1H          ; [CPU_FPU] |165| 
	.dwpsn	file "../bts.c",line 166,column 5,is_stmt,isa 0
        MOVIZ     R1H,#14600            ; [CPU_FPU] |166| 
	.dwpsn	file "../bts.c",line 146,column 5,is_stmt,isa 0
        MOV32     *-SP[2],R0H           ; [CPU_FPU] |146| 
	.dwpsn	file "../bts.c",line 166,column 5,is_stmt,isa 0
        MOV32     *-SP[20],R1H          ; [CPU_FPU] |166| 
	.dwpsn	file "../bts.c",line 167,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15766            ; [CPU_FPU] |167| 
	.dwpsn	file "../bts.c",line 146,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[4]           ; [CPU_FPU] |146| 
	.dwpsn	file "../bts.c",line 147,column 5,is_stmt,isa 0
        MOVXI     R0H,#46848            ; [CPU_FPU] |147| 
	.dwpsn	file "../bts.c",line 167,column 5,is_stmt,isa 0
        MOV32     *-SP[22],R1H          ; [CPU_FPU] |167| 
	.dwpsn	file "../bts.c",line 168,column 5,is_stmt,isa 0
        MOVIZ     R1H,#14600            ; [CPU_FPU] |168| 
	.dwpsn	file "../bts.c",line 147,column 5,is_stmt,isa 0
        MOV32     *-SP[4],R0H           ; [CPU_FPU] |147| 
	.dwpsn	file "../bts.c",line 168,column 5,is_stmt,isa 0
        MOV32     *-SP[24],R1H          ; [CPU_FPU] |168| 
	.dwpsn	file "../bts.c",line 170,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15947            ; [CPU_FPU] |170| 
	.dwpsn	file "../bts.c",line 147,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[6]           ; [CPU_FPU] |147| 
	.dwpsn	file "../bts.c",line 170,column 5,is_stmt,isa 0
        MOV32     *-SP[26],R1H          ; [CPU_FPU] |170| 
	.dwpsn	file "../bts.c",line 148,column 5,is_stmt,isa 0
        MOVXI     R0H,#12816            ; [CPU_FPU] |148| 
	.dwpsn	file "../bts.c",line 171,column 5,is_stmt,isa 0
        MOVIZ     R1H,#47525            ; [CPU_FPU] |171| 
	.dwpsn	file "../bts.c",line 148,column 5,is_stmt,isa 0
        MOV32     *-SP[6],R0H           ; [CPU_FPU] |148| 
	.dwpsn	file "../bts.c",line 171,column 5,is_stmt,isa 0
        MOV32     *-SP[28],R1H          ; [CPU_FPU] |171| 
	.dwpsn	file "../bts.c",line 172,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16545            ; [CPU_FPU] |172| 
	.dwpsn	file "../bts.c",line 148,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[8]           ; [CPU_FPU] |148| 
	.dwpsn	file "../bts.c",line 172,column 5,is_stmt,isa 0
        MOV32     *-SP[30],R1H          ; [CPU_FPU] |172| 
	.dwpsn	file "../bts.c",line 149,column 5,is_stmt,isa 0
        MOVXI     R0H,#46848            ; [CPU_FPU] |149| 
	.dwpsn	file "../bts.c",line 173,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15056            ; [CPU_FPU] |173| 
	.dwpsn	file "../bts.c",line 149,column 5,is_stmt,isa 0
        MOV32     *-SP[8],R0H           ; [CPU_FPU] |149| 
	.dwpsn	file "../bts.c",line 173,column 5,is_stmt,isa 0
        MOV32     *-SP[32],R1H          ; [CPU_FPU] |173| 
	.dwpsn	file "../bts.c",line 182,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15766            ; [CPU_FPU] |182| 
	.dwpsn	file "../bts.c",line 149,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[10]          ; [CPU_FPU] |149| 
	.dwpsn	file "../bts.c",line 182,column 5,is_stmt,isa 0
        MOV32     *-SP[34],R1H          ; [CPU_FPU] |182| 
	.dwpsn	file "../bts.c",line 151,column 5,is_stmt,isa 0
        MOVXI     R0H,#6469             ; [CPU_FPU] |151| 
	.dwpsn	file "../bts.c",line 183,column 5,is_stmt,isa 0
        MOVIZ     R1H,#14600            ; [CPU_FPU] |183| 
	.dwpsn	file "../bts.c",line 151,column 5,is_stmt,isa 0
        MOV32     *-SP[10],R0H          ; [CPU_FPU] |151| 
	.dwpsn	file "../bts.c",line 183,column 5,is_stmt,isa 0
        MOV32     *-SP[36],R1H          ; [CPU_FPU] |183| 
	.dwpsn	file "../bts.c",line 184,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15766            ; [CPU_FPU] |184| 
	.dwpsn	file "../bts.c",line 151,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[12]          ; [CPU_FPU] |151| 
	.dwpsn	file "../bts.c",line 184,column 5,is_stmt,isa 0
        MOV32     *-SP[38],R1H          ; [CPU_FPU] |184| 
	.dwpsn	file "../bts.c",line 152,column 5,is_stmt,isa 0
        MOVXI     R0H,#44544            ; [CPU_FPU] |152| 
	.dwpsn	file "../bts.c",line 185,column 5,is_stmt,isa 0
        MOVIZ     R1H,#14600            ; [CPU_FPU] |185| 
	.dwpsn	file "../bts.c",line 152,column 5,is_stmt,isa 0
        MOV32     *-SP[12],R0H          ; [CPU_FPU] |152| 
	.dwpsn	file "../bts.c",line 185,column 5,is_stmt,isa 0
        MOV32     *-SP[40],R1H          ; [CPU_FPU] |185| 
	.dwpsn	file "../bts.c",line 187,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15947            ; [CPU_FPU] |187| 
	.dwpsn	file "../bts.c",line 152,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[14]          ; [CPU_FPU] |152| 
	.dwpsn	file "../bts.c",line 187,column 5,is_stmt,isa 0
        MOV32     *-SP[42],R1H          ; [CPU_FPU] |187| 
	.dwpsn	file "../bts.c",line 153,column 5,is_stmt,isa 0
        MOVXI     R0H,#22300            ; [CPU_FPU] |153| 
	.dwpsn	file "../bts.c",line 188,column 5,is_stmt,isa 0
        MOVIZ     R1H,#47525            ; [CPU_FPU] |188| 
        MOV32     *-SP[44],R1H          ; [CPU_FPU] |188| 
	.dwpsn	file "../bts.c",line 153,column 5,is_stmt,isa 0
        MOV32     *-SP[14],R0H          ; [CPU_FPU] |153| 
	.dwpsn	file "../bts.c",line 189,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16545            ; [CPU_FPU] |189| 
	.dwpsn	file "../bts.c",line 153,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[16]          ; [CPU_FPU] |153| 
	.dwpsn	file "../bts.c",line 189,column 5,is_stmt,isa 0
        MOV32     *-SP[46],R1H          ; [CPU_FPU] |189| 
	.dwpsn	file "../bts.c",line 154,column 5,is_stmt,isa 0
        MOVXI     R0H,#54684            ; [CPU_FPU] |154| 
	.dwpsn	file "../bts.c",line 190,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15056            ; [CPU_FPU] |190| 
        MOV32     *-SP[48],R1H          ; [CPU_FPU] |190| 
	.dwpsn	file "../bts.c",line 154,column 5,is_stmt,isa 0
        MOV32     *-SP[16],R0H          ; [CPU_FPU] |154| 
	.dwpsn	file "../bts.c",line 200,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15766            ; [CPU_FPU] |200| 
	.dwpsn	file "../bts.c",line 154,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[18]          ; [CPU_FPU] |154| 
	.dwpsn	file "../bts.c",line 200,column 5,is_stmt,isa 0
        MOV32     *-SP[54],R1H          ; [CPU_FPU] |200| 
	.dwpsn	file "../bts.c",line 165,column 5,is_stmt,isa 0
        MOVXI     R0H,#12816            ; [CPU_FPU] |165| 
	.dwpsn	file "../bts.c",line 208,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15056            ; [CPU_FPU] |208| 
	.dwpsn	file "../bts.c",line 165,column 5,is_stmt,isa 0
        MOV32     *-SP[18],R0H          ; [CPU_FPU] |165| 
        MOV32     R0H,*-SP[20]          ; [CPU_FPU] |165| 
	.dwpsn	file "../bts.c",line 166,column 5,is_stmt,isa 0
        MOVXI     R0H,#46848            ; [CPU_FPU] |166| 
        MOV32     *-SP[20],R0H          ; [CPU_FPU] |166| 
        MOV32     R0H,*-SP[22]          ; [CPU_FPU] |166| 
	.dwpsn	file "../bts.c",line 167,column 5,is_stmt,isa 0
        MOVXI     R0H,#12816            ; [CPU_FPU] |167| 
	.dwpsn	file "../bts.c",line 208,column 5,is_stmt,isa 0
        MOVXI     R1H,#54684            ; [CPU_FPU] |208| 
	.dwpsn	file "../bts.c",line 167,column 5,is_stmt,isa 0
        MOV32     *-SP[22],R0H          ; [CPU_FPU] |167| 
        MOV32     R0H,*-SP[24]          ; [CPU_FPU] |167| 
	.dwpsn	file "../bts.c",line 168,column 5,is_stmt,isa 0
        MOVXI     R0H,#46848            ; [CPU_FPU] |168| 
        MOV32     *-SP[24],R0H          ; [CPU_FPU] |168| 
        MOV32     R0H,*-SP[26]          ; [CPU_FPU] |168| 
	.dwpsn	file "../bts.c",line 170,column 5,is_stmt,isa 0
        MOVXI     R0H,#6469             ; [CPU_FPU] |170| 
        MOV32     *-SP[26],R0H          ; [CPU_FPU] |170| 
        MOV32     R0H,*-SP[28]          ; [CPU_FPU] |170| 
	.dwpsn	file "../bts.c",line 171,column 5,is_stmt,isa 0
        MOVXI     R0H,#44544            ; [CPU_FPU] |171| 
        MOV32     *-SP[28],R0H          ; [CPU_FPU] |171| 
        MOV32     R0H,*-SP[30]          ; [CPU_FPU] |171| 
	.dwpsn	file "../bts.c",line 172,column 5,is_stmt,isa 0
        MOVXI     R0H,#22300            ; [CPU_FPU] |172| 
        MOV32     *-SP[30],R0H          ; [CPU_FPU] |172| 
        MOV32     R0H,*-SP[32]          ; [CPU_FPU] |172| 
	.dwpsn	file "../bts.c",line 173,column 5,is_stmt,isa 0
        MOVXI     R0H,#54684            ; [CPU_FPU] |173| 
        MOV32     *-SP[32],R0H          ; [CPU_FPU] |173| 
        MOV32     R0H,*-SP[34]          ; [CPU_FPU] |173| 
	.dwpsn	file "../bts.c",line 182,column 5,is_stmt,isa 0
        MOVXI     R0H,#12816            ; [CPU_FPU] |182| 
        MOV32     *-SP[34],R0H          ; [CPU_FPU] |182| 
        MOV32     R0H,*-SP[36]          ; [CPU_FPU] |182| 
	.dwpsn	file "../bts.c",line 183,column 5,is_stmt,isa 0
        MOVXI     R0H,#46848            ; [CPU_FPU] |183| 
        MOV32     *-SP[36],R0H          ; [CPU_FPU] |183| 
        MOV32     R0H,*-SP[38]          ; [CPU_FPU] |183| 
	.dwpsn	file "../bts.c",line 184,column 5,is_stmt,isa 0
        MOVXI     R0H,#12816            ; [CPU_FPU] |184| 
        MOV32     *-SP[38],R0H          ; [CPU_FPU] |184| 
        MOV32     R0H,*-SP[40]          ; [CPU_FPU] |184| 
	.dwpsn	file "../bts.c",line 185,column 5,is_stmt,isa 0
        MOVXI     R0H,#46848            ; [CPU_FPU] |185| 
        MOV32     *-SP[40],R0H          ; [CPU_FPU] |185| 
        MOV32     R0H,*-SP[42]          ; [CPU_FPU] |185| 
	.dwpsn	file "../bts.c",line 187,column 5,is_stmt,isa 0
        MOVXI     R0H,#6469             ; [CPU_FPU] |187| 
        MOV32     *-SP[42],R0H          ; [CPU_FPU] |187| 
        MOV32     R0H,*-SP[44]          ; [CPU_FPU] |187| 
	.dwpsn	file "../bts.c",line 188,column 5,is_stmt,isa 0
        MOVXI     R0H,#44544            ; [CPU_FPU] |188| 
        MOV32     *-SP[44],R0H          ; [CPU_FPU] |188| 
        MOV32     R0H,*-SP[46]          ; [CPU_FPU] |188| 
	.dwpsn	file "../bts.c",line 189,column 5,is_stmt,isa 0
        MOVXI     R0H,#22300            ; [CPU_FPU] |189| 
        MOV32     *-SP[46],R0H          ; [CPU_FPU] |189| 
        MOV32     R0H,*-SP[48]          ; [CPU_FPU] |189| 
	.dwpsn	file "../bts.c",line 190,column 5,is_stmt,isa 0
        MOVXI     R0H,#54684            ; [CPU_FPU] |190| 
        MOV32     *-SP[48],R0H          ; [CPU_FPU] |190| 
        MOV32     R0H,*-SP[54]          ; [CPU_FPU] |190| 
	.dwpsn	file "../bts.c",line 200,column 5,is_stmt,isa 0
        MOVXI     R0H,#12816            ; [CPU_FPU] |200| 
        MOV32     *-SP[54],R0H          ; [CPU_FPU] |200| 
	.dwpsn	file "../bts.c",line 208,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[52]          ; [CPU_FPU] |208| 
	.dwpsn	file "../bts.c",line 197,column 5,is_stmt,isa 0
        MOVXI     R0H,#52429            ; [CPU_FPU] |197| 
        MOV32     *-SP[52],R0H          ; [CPU_FPU] |197| 
        MOV32     R0H,*-SP[50]          ; [CPU_FPU] |197| 
	.dwpsn	file "../bts.c",line 196,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||),R0H ; [CPU_FPU] |196| 
	.dwpsn	file "../bts.c",line 198,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16128            ; [CPU_FPU] |198| 
        MOVW      DP,#||BTS_userInput_ch1||+14 ; [CPU_ARAU] 
        MOV32     *-SP[50],R0H          ; [CPU_FPU] |198| 
        MOV32     R0H,*-SP[2]           ; [CPU_FPU] |198| 
	.dwpsn	file "../bts.c",line 146,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+14,R0H ; [CPU_FPU] |146| 
        MOV32     R0H,*-SP[4]           ; [CPU_FPU] |146| 
	.dwpsn	file "../bts.c",line 147,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+16,R0H ; [CPU_FPU] |147| 
        MOV32     R0H,*-SP[6]           ; [CPU_FPU] |147| 
	.dwpsn	file "../bts.c",line 148,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+18,R0H ; [CPU_FPU] |148| 
        MOV32     R0H,*-SP[8]           ; [CPU_FPU] |148| 
	.dwpsn	file "../bts.c",line 149,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+20,R0H ; [CPU_FPU] |149| 
        MOV32     R0H,*-SP[10]          ; [CPU_FPU] |149| 
	.dwpsn	file "../bts.c",line 151,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+22,R0H ; [CPU_FPU] |151| 
        MOV32     R0H,*-SP[12]          ; [CPU_FPU] |151| 
	.dwpsn	file "../bts.c",line 152,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+24,R0H ; [CPU_FPU] |152| 
        MOV32     R0H,*-SP[14]          ; [CPU_FPU] |152| 
	.dwpsn	file "../bts.c",line 153,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+26,R0H ; [CPU_FPU] |153| 
        MOV32     R0H,*-SP[16]          ; [CPU_FPU] |153| 
	.dwpsn	file "../bts.c",line 154,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch1||)+28,R0H ; [CPU_FPU] |154| 
        MOV32     R0H,*-SP[18]          ; [CPU_FPU] |154| 
	.dwpsn	file "../bts.c",line 165,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+14,R0H ; [CPU_FPU] |165| 
        MOV32     R0H,*-SP[20]          ; [CPU_FPU] |165| 
	.dwpsn	file "../bts.c",line 166,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+16,R0H ; [CPU_FPU] |166| 
        MOV32     R0H,*-SP[22]          ; [CPU_FPU] |166| 
	.dwpsn	file "../bts.c",line 167,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+18,R0H ; [CPU_FPU] |167| 
        MOV32     R0H,*-SP[24]          ; [CPU_FPU] |167| 
	.dwpsn	file "../bts.c",line 168,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+20,R0H ; [CPU_FPU] |168| 
        MOV32     R0H,*-SP[26]          ; [CPU_FPU] |168| 
	.dwpsn	file "../bts.c",line 170,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+22,R0H ; [CPU_FPU] |170| 
        MOV32     R0H,*-SP[28]          ; [CPU_FPU] |170| 
	.dwpsn	file "../bts.c",line 171,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+24,R0H ; [CPU_FPU] |171| 
        MOV32     R0H,*-SP[30]          ; [CPU_FPU] |171| 
	.dwpsn	file "../bts.c",line 172,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+26,R0H ; [CPU_FPU] |172| 
        MOV32     R0H,*-SP[32]          ; [CPU_FPU] |172| 
	.dwpsn	file "../bts.c",line 173,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch2||)+28,R0H ; [CPU_FPU] |173| 
        MOV32     R0H,*-SP[34]          ; [CPU_FPU] |173| 
        MOVW      DP,#||BTS_userInput_ch3||+14 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 182,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+14,R0H ; [CPU_FPU] |182| 
	.dwpsn	file "../bts.c",line 208,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+28,R1H ; [CPU_FPU] |208| 
	.dwpsn	file "../bts.c",line 182,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[36]          ; [CPU_FPU] |182| 
	.dwpsn	file "../bts.c",line 201,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+16,R7H ; [CPU_FPU] |201| 
	.dwpsn	file "../bts.c",line 202,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+18,R6H ; [CPU_FPU] |202| 
	.dwpsn	file "../bts.c",line 203,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+20,R5H ; [CPU_FPU] |203| 
	.dwpsn	file "../bts.c",line 205,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+22,R4H ; [CPU_FPU] |205| 
	.dwpsn	file "../bts.c",line 208,column 5,is_stmt,isa 0
        MOV32     R1H,*-SP[52]          ; [CPU_FPU] |208| 
	.dwpsn	file "../bts.c",line 206,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+24,R3H ; [CPU_FPU] |206| 
	.dwpsn	file "../bts.c",line 183,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+16,R0H ; [CPU_FPU] |183| 
        MOV32     R0H,*-SP[38]          ; [CPU_FPU] |183| 
	.dwpsn	file "../bts.c",line 184,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+18,R0H ; [CPU_FPU] |184| 
        MOV32     R0H,*-SP[40]          ; [CPU_FPU] |184| 
	.dwpsn	file "../bts.c",line 185,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+20,R0H ; [CPU_FPU] |185| 
	.dwpsn	file "../bts.c",line 197,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+2,R1H ; [CPU_FPU] |197| 
	.dwpsn	file "../bts.c",line 185,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[42]          ; [CPU_FPU] |185| 
	.dwpsn	file "../bts.c",line 187,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+22,R0H ; [CPU_FPU] |187| 
        MOV32     R0H,*-SP[44]          ; [CPU_FPU] |187| 
	.dwpsn	file "../bts.c",line 188,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+24,R0H ; [CPU_FPU] |188| 
        MOV32     R0H,*-SP[46]          ; [CPU_FPU] |188| 
	.dwpsn	file "../bts.c",line 189,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+26,R0H ; [CPU_FPU] |189| 
        MOV32     R0H,*-SP[48]          ; [CPU_FPU] |189| 
	.dwpsn	file "../bts.c",line 190,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch3||)+28,R0H ; [CPU_FPU] |190| 
        MOV32     R0H,*-SP[54]          ; [CPU_FPU] |190| 
	.dwpsn	file "../bts.c",line 200,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+14,R0H ; [CPU_FPU] |200| 
	.dwpsn	file "../bts.c",line 197,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[50]          ; [CPU_FPU] |197| 
	.dwpsn	file "../bts.c",line 207,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+26,R2H ; [CPU_FPU] |207| 
	.dwpsn	file "../bts.c",line 198,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_userInput_ch4||)+4,R0H ; [CPU_FPU] |198| 
        SUBB      SP,#54                ; [CPU_ARAU] 
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
$C$DW$161	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$161, DW_AT_low_pc(0x00)
	.dwattr $C$DW$161, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$160, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$160, DW_AT_TI_end_line(0xd2)
	.dwattr $C$DW$160, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$160

	.sect	".text"
	.clink
	.global	||BTS_initProgramVariables||

$C$DW$162	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$162, DW_AT_name("BTS_initProgramVariables")
	.dwattr $C$DW$162, DW_AT_low_pc(||BTS_initProgramVariables||)
	.dwattr $C$DW$162, DW_AT_high_pc(0x00)
	.dwattr $C$DW$162, DW_AT_linkage_name("BTS_initProgramVariables")
	.dwattr $C$DW$162, DW_AT_external
	.dwattr $C$DW$162, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$162, DW_AT_decl_line(0xd4)
	.dwattr $C$DW$162, DW_AT_decl_column(0x06)
	.dwattr $C$DW$162, DW_AT_TI_max_frame_size(-28)
	.dwpsn	file "../bts.c",line 212,column 36,is_stmt,address ||BTS_initProgramVariables||,isa 0

	.dwfde $C$DW$CIE, ||BTS_initProgramVariables||

;***************************************************************
;* FNAME: BTS_initProgramVariables      FR SIZE:  26           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter, 18 Auto,  8 SOE     *
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
        ADDB      SP,#18                ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -28
        MOVW      DP,#||BTS_ctrlLoopVariable_ch1||+32 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 214,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+32,#28841 ; [CPU_ALU] |214| 
	.dwpsn	file "../bts.c",line 215,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch1||)+33,#-28841 ; [CPU_ALU] |215| 
	.dwpsn	file "../bts.c",line 226,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16730            ; [CPU_FPU] |226| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch2||+32 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 237,column 5,is_stmt,isa 0
        MOVIZ     R7H,#47849            ; [CPU_FPU] |237| 
	.dwpsn	file "../bts.c",line 238,column 5,is_stmt,isa 0
        MOVIZ     R6H,#16545            ; [CPU_FPU] |238| 
	.dwpsn	file "../bts.c",line 239,column 5,is_stmt,isa 0
        MOVIZ     R5H,#15056            ; [CPU_FPU] |239| 
	.dwpsn	file "../bts.c",line 217,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+32,#28841 ; [CPU_ALU] |217| 
	.dwpsn	file "../bts.c",line 218,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch2||)+33,#-28841 ; [CPU_ALU] |218| 
	.dwpsn	file "../bts.c",line 241,column 5,is_stmt,isa 0
        MOVIZ     R4H,#16730            ; [CPU_FPU] |241| 
	.dwpsn	file "../bts.c",line 242,column 5,is_stmt,isa 0
        MOVIZ     R3H,#47849            ; [CPU_FPU] |242| 
	.dwpsn	file "../bts.c",line 243,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16545            ; [CPU_FPU] |243| 
	.dwpsn	file "../bts.c",line 226,column 5,is_stmt,isa 0
        MOV32     *-SP[2],R0H           ; [CPU_FPU] |226| 
	.dwpsn	file "../bts.c",line 244,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15056            ; [CPU_FPU] |244| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch3||+32 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 227,column 5,is_stmt,isa 0
        MOVIZ     R0H,#47849            ; [CPU_FPU] |227| 
	.dwpsn	file "../bts.c",line 220,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+32,#28841 ; [CPU_ALU] |220| 
	.dwpsn	file "../bts.c",line 221,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch3||)+33,#-28841 ; [CPU_ALU] |221| 
        MOVW      DP,#||BTS_ctrlLoopVariable_ch4||+32 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 227,column 5,is_stmt,isa 0
        MOV32     *-SP[4],R0H           ; [CPU_FPU] |227| 
	.dwpsn	file "../bts.c",line 223,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+32,#28841 ; [CPU_ALU] |223| 
	.dwpsn	file "../bts.c",line 224,column 5,is_stmt,isa 0
        MOV       @$BLOCKED(||BTS_ctrlLoopVariable_ch4||)+33,#-28841 ; [CPU_ALU] |224| 
	.dwpsn	file "../bts.c",line 228,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16545            ; [CPU_FPU] |228| 
        MOV32     *-SP[6],R0H           ; [CPU_FPU] |228| 
	.dwpsn	file "../bts.c",line 237,column 5,is_stmt,isa 0
        MOVXI     R7H,#1499             ; [CPU_FPU] |237| 
	.dwpsn	file "../bts.c",line 238,column 5,is_stmt,isa 0
        MOVXI     R6H,#22300            ; [CPU_FPU] |238| 
	.dwpsn	file "../bts.c",line 229,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15056            ; [CPU_FPU] |229| 
	.dwpsn	file "../bts.c",line 239,column 5,is_stmt,isa 0
        MOVXI     R5H,#54684            ; [CPU_FPU] |239| 
	.dwpsn	file "../bts.c",line 241,column 5,is_stmt,isa 0
        MOVXI     R4H,#11069            ; [CPU_FPU] |241| 
	.dwpsn	file "../bts.c",line 242,column 5,is_stmt,isa 0
        MOVXI     R3H,#1499             ; [CPU_FPU] |242| 
	.dwpsn	file "../bts.c",line 243,column 5,is_stmt,isa 0
        MOVXI     R2H,#22300            ; [CPU_FPU] |243| 
	.dwpsn	file "../bts.c",line 244,column 5,is_stmt,isa 0
        MOVXI     R1H,#54684            ; [CPU_FPU] |244| 
        MOVW      DP,#||BTS_measValues_ch1||+74 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 229,column 5,is_stmt,isa 0
        MOV32     *-SP[8],R0H           ; [CPU_FPU] |229| 
	.dwpsn	file "../bts.c",line 231,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16730            ; [CPU_FPU] |231| 
        MOV32     *-SP[10],R0H          ; [CPU_FPU] |231| 
	.dwpsn	file "../bts.c",line 232,column 5,is_stmt,isa 0
        MOVIZ     R0H,#47849            ; [CPU_FPU] |232| 
        MOV32     *-SP[12],R0H          ; [CPU_FPU] |232| 
	.dwpsn	file "../bts.c",line 233,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16545            ; [CPU_FPU] |233| 
        MOV32     *-SP[14],R0H          ; [CPU_FPU] |233| 
	.dwpsn	file "../bts.c",line 234,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15056            ; [CPU_FPU] |234| 
        MOV32     *-SP[16],R0H          ; [CPU_FPU] |234| 
	.dwpsn	file "../bts.c",line 236,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16730            ; [CPU_FPU] |236| 
        MOV32     *-SP[18],R0H          ; [CPU_FPU] |236| 
	.dwpsn	file "../bts.c",line 244,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[2]           ; [CPU_FPU] |244| 
	.dwpsn	file "../bts.c",line 226,column 5,is_stmt,isa 0
        MOVXI     R0H,#11069            ; [CPU_FPU] |226| 
        MOV32     *-SP[2],R0H           ; [CPU_FPU] |226| 
        MOV32     R0H,*-SP[4]           ; [CPU_FPU] |226| 
	.dwpsn	file "../bts.c",line 227,column 5,is_stmt,isa 0
        MOVXI     R0H,#1499             ; [CPU_FPU] |227| 
        MOV32     *-SP[4],R0H           ; [CPU_FPU] |227| 
        MOV32     R0H,*-SP[6]           ; [CPU_FPU] |227| 
	.dwpsn	file "../bts.c",line 228,column 5,is_stmt,isa 0
        MOVXI     R0H,#22300            ; [CPU_FPU] |228| 
        MOV32     *-SP[6],R0H           ; [CPU_FPU] |228| 
        MOV32     R0H,*-SP[8]           ; [CPU_FPU] |228| 
	.dwpsn	file "../bts.c",line 229,column 5,is_stmt,isa 0
        MOVXI     R0H,#54684            ; [CPU_FPU] |229| 
        MOV32     *-SP[8],R0H           ; [CPU_FPU] |229| 
        MOV32     R0H,*-SP[10]          ; [CPU_FPU] |229| 
	.dwpsn	file "../bts.c",line 231,column 5,is_stmt,isa 0
        MOVXI     R0H,#11069            ; [CPU_FPU] |231| 
        MOV32     *-SP[10],R0H          ; [CPU_FPU] |231| 
        MOV32     R0H,*-SP[12]          ; [CPU_FPU] |231| 
	.dwpsn	file "../bts.c",line 232,column 5,is_stmt,isa 0
        MOVXI     R0H,#1499             ; [CPU_FPU] |232| 
        MOV32     *-SP[12],R0H          ; [CPU_FPU] |232| 
        MOV32     R0H,*-SP[14]          ; [CPU_FPU] |232| 
	.dwpsn	file "../bts.c",line 233,column 5,is_stmt,isa 0
        MOVXI     R0H,#22300            ; [CPU_FPU] |233| 
        MOV32     *-SP[14],R0H          ; [CPU_FPU] |233| 
        MOV32     R0H,*-SP[16]          ; [CPU_FPU] |233| 
	.dwpsn	file "../bts.c",line 234,column 5,is_stmt,isa 0
        MOVXI     R0H,#54684            ; [CPU_FPU] |234| 
        MOV32     *-SP[16],R0H          ; [CPU_FPU] |234| 
        MOV32     R0H,*-SP[18]          ; [CPU_FPU] |234| 
	.dwpsn	file "../bts.c",line 236,column 5,is_stmt,isa 0
        MOVXI     R0H,#11069            ; [CPU_FPU] |236| 
        MOV32     *-SP[18],R0H          ; [CPU_FPU] |236| 
	.dwpsn	file "../bts.c",line 224,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[2]           ; [CPU_FPU] |224| 
	.dwpsn	file "../bts.c",line 226,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch1||)+74,R0H ; [CPU_FPU] |226| 
        MOV32     R0H,*-SP[4]           ; [CPU_FPU] |226| 
	.dwpsn	file "../bts.c",line 227,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch1||)+76,R0H ; [CPU_FPU] |227| 
        MOV32     R0H,*-SP[6]           ; [CPU_FPU] |227| 
	.dwpsn	file "../bts.c",line 228,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch1||)+78,R0H ; [CPU_FPU] |228| 
        MOV32     R0H,*-SP[8]           ; [CPU_FPU] |228| 
	.dwpsn	file "../bts.c",line 229,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch1||)+80,R0H ; [CPU_FPU] |229| 
        MOVW      DP,#||BTS_measValues_ch2||+74 ; [CPU_ARAU] 
        MOV32     R0H,*-SP[10]          ; [CPU_FPU] |229| 
	.dwpsn	file "../bts.c",line 231,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch2||)+74,R0H ; [CPU_FPU] |231| 
        MOV32     R0H,*-SP[12]          ; [CPU_FPU] |231| 
	.dwpsn	file "../bts.c",line 232,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch2||)+76,R0H ; [CPU_FPU] |232| 
        MOV32     R0H,*-SP[14]          ; [CPU_FPU] |232| 
	.dwpsn	file "../bts.c",line 233,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch2||)+78,R0H ; [CPU_FPU] |233| 
        MOV32     R0H,*-SP[16]          ; [CPU_FPU] |233| 
	.dwpsn	file "../bts.c",line 234,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch2||)+80,R0H ; [CPU_FPU] |234| 
        MOVW      DP,#||BTS_measValues_ch3||+74 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 237,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch3||)+76,R7H ; [CPU_FPU] |237| 
	.dwpsn	file "../bts.c",line 238,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch3||)+78,R6H ; [CPU_FPU] |238| 
	.dwpsn	file "../bts.c",line 239,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch3||)+80,R5H ; [CPU_FPU] |239| 
	.dwpsn	file "../bts.c",line 234,column 5,is_stmt,isa 0
        MOV32     R0H,*-SP[18]          ; [CPU_FPU] |234| 
	.dwpsn	file "../bts.c",line 236,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch3||)+74,R0H ; [CPU_FPU] |236| 
        MOVW      DP,#||BTS_measValues_ch4||+74 ; [CPU_ARAU] 
	.dwpsn	file "../bts.c",line 241,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch4||)+74,R4H ; [CPU_FPU] |241| 
	.dwpsn	file "../bts.c",line 242,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch4||)+76,R3H ; [CPU_FPU] |242| 
	.dwpsn	file "../bts.c",line 243,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch4||)+78,R2H ; [CPU_FPU] |243| 
	.dwpsn	file "../bts.c",line 244,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_measValues_ch4||)+80,R1H ; [CPU_FPU] |244| 
        SUBB      SP,#18                ; [CPU_ARAU] 
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
$C$DW$163	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$163, DW_AT_low_pc(0x00)
	.dwattr $C$DW$163, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$162, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$162, DW_AT_TI_end_line(0xf5)
	.dwattr $C$DW$162, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$162

	.sect	".text"
	.clink
	.global	||BTS_initController||

$C$DW$164	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$164, DW_AT_name("BTS_initController")
	.dwattr $C$DW$164, DW_AT_low_pc(||BTS_initController||)
	.dwattr $C$DW$164, DW_AT_high_pc(0x00)
	.dwattr $C$DW$164, DW_AT_linkage_name("BTS_initController")
	.dwattr $C$DW$164, DW_AT_external
	.dwattr $C$DW$164, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$164, DW_AT_decl_line(0xf7)
	.dwattr $C$DW$164, DW_AT_decl_column(0x06)
	.dwattr $C$DW$164, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../bts.c",line 248,column 1,is_stmt,address ||BTS_initController||,isa 0

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
	.dwpsn	file "../bts.c",line 252,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15628            ; [CPU_FPU] |252| 
	.dwpsn	file "../bts.c",line 253,column 5,is_stmt,isa 0
        MOVIZ     R0H,#48506            ; [CPU_FPU] |253| 
	.dwpsn	file "../bts.c",line 254,column 5,is_stmt,isa 0
        MOVIZ     R2H,#15581            ; [CPU_FPU] |254| 
        MOVW      DP,#||BTS_ctrl_cc_ch1|| ; [CPU_ARAU] 
        MOV32     *SP++,R4H             ; [CPU_FPU] 
	.dwcfi	save_reg_to_mem, 59, 2
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../bts.c",line 252,column 5,is_stmt,isa 0
        MOVXI     R1H,#31105            ; [CPU_FPU] |252| 
	.dwpsn	file "../bts.c",line 253,column 5,is_stmt,isa 0
        MOVXI     R0H,#27704            ; [CPU_FPU] |253| 
	.dwpsn	file "../bts.c",line 254,column 5,is_stmt,isa 0
        MOVXI     R2H,#54450            ; [CPU_FPU] |254| 
	.dwpsn	file "../bts.c",line 252,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||),R1H ; [CPU_FPU] |252| 
	.dwpsn	file "../bts.c",line 305,column 5,is_stmt,isa 0
        MOVIZ     R4H,#16303            ; [CPU_FPU] |305| 
	.dwpsn	file "../bts.c",line 306,column 5,is_stmt,isa 0
        MOVIZ     R3H,#49180            ; [CPU_FPU] |306| 
	.dwpsn	file "../bts.c",line 255,column 5,is_stmt,isa 0
        MOVIZ     R1H,#49142            ; [CPU_FPU] |255| 
	.dwpsn	file "../bts.c",line 253,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+2,R0H ; [CPU_FPU] |253| 
	.dwpsn	file "../bts.c",line 256,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16236            ; [CPU_FPU] |256| 
	.dwpsn	file "../bts.c",line 255,column 5,is_stmt,isa 0
        MOVXI     R1H,#21415            ; [CPU_FPU] |255| 
	.dwpsn	file "../bts.c",line 254,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+4,R2H ; [CPU_FPU] |254| 
	.dwpsn	file "../bts.c",line 256,column 5,is_stmt,isa 0
        MOVXI     R0H,#42830            ; [CPU_FPU] |256| 
	.dwpsn	file "../bts.c",line 258,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16303            ; [CPU_FPU] |258| 
	.dwpsn	file "../bts.c",line 255,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+6,R1H ; [CPU_FPU] |255| 
	.dwpsn	file "../bts.c",line 259,column 5,is_stmt,isa 0
        MOVIZ     R1H,#49180            ; [CPU_FPU] |259| 
	.dwpsn	file "../bts.c",line 258,column 5,is_stmt,isa 0
        MOVXI     R2H,#38882            ; [CPU_FPU] |258| 
	.dwpsn	file "../bts.c",line 256,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch1||)+8,R0H ; [CPU_FPU] |256| 
	.dwpsn	file "../bts.c",line 259,column 5,is_stmt,isa 0
        MOVXI     R1H,#33699            ; [CPU_FPU] |259| 
	.dwpsn	file "../bts.c",line 260,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16266            ; [CPU_FPU] |260| 
        MOVW      DP,#||BTS_ctrl_cv_ch1|| ; [CPU_ARAU] 
        MOVXI     R0H,#42223            ; [CPU_FPU] |260| 
	.dwpsn	file "../bts.c",line 258,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch1||),R2H ; [CPU_FPU] |258| 
	.dwpsn	file "../bts.c",line 261,column 5,is_stmt,isa 0
        MOVIZ     R2H,#49142            ; [CPU_FPU] |261| 
	.dwpsn	file "../bts.c",line 259,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch1||)+2,R1H ; [CPU_FPU] |259| 
	.dwpsn	file "../bts.c",line 261,column 5,is_stmt,isa 0
        MOVXI     R2H,#21415            ; [CPU_FPU] |261| 
	.dwpsn	file "../bts.c",line 305,column 5,is_stmt,isa 0
        MOVXI     R4H,#38882            ; [CPU_FPU] |305| 
	.dwpsn	file "../bts.c",line 306,column 5,is_stmt,isa 0
        MOVXI     R3H,#33699            ; [CPU_FPU] |306| 
	.dwpsn	file "../bts.c",line 262,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16236            ; [CPU_FPU] |262| 
        MOVXI     R1H,#42831            ; [CPU_FPU] |262| 
	.dwpsn	file "../bts.c",line 260,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch1||)+4,R0H ; [CPU_FPU] |260| 
	.dwpsn	file "../bts.c",line 267,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15628            ; [CPU_FPU] |267| 
        MOVXI     R0H,#31105            ; [CPU_FPU] |267| 
	.dwpsn	file "../bts.c",line 261,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch1||)+6,R2H ; [CPU_FPU] |261| 
	.dwpsn	file "../bts.c",line 268,column 5,is_stmt,isa 0
        MOVIZ     R2H,#48506            ; [CPU_FPU] |268| 
        MOVXI     R2H,#27704            ; [CPU_FPU] |268| 
	.dwpsn	file "../bts.c",line 262,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch1||)+8,R1H ; [CPU_FPU] |262| 
	.dwpsn	file "../bts.c",line 269,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15581            ; [CPU_FPU] |269| 
        MOVW      DP,#||BTS_ctrl_cc_ch2|| ; [CPU_ARAU] 
        MOVXI     R1H,#54450            ; [CPU_FPU] |269| 
	.dwpsn	file "../bts.c",line 267,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||),R0H ; [CPU_FPU] |267| 
	.dwpsn	file "../bts.c",line 270,column 5,is_stmt,isa 0
        MOVIZ     R0H,#49142            ; [CPU_FPU] |270| 
        MOVXI     R0H,#21415            ; [CPU_FPU] |270| 
	.dwpsn	file "../bts.c",line 268,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||)+2,R2H ; [CPU_FPU] |268| 
	.dwpsn	file "../bts.c",line 271,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16236            ; [CPU_FPU] |271| 
        MOVXI     R2H,#42830            ; [CPU_FPU] |271| 
	.dwpsn	file "../bts.c",line 269,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||)+4,R1H ; [CPU_FPU] |269| 
	.dwpsn	file "../bts.c",line 273,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16303            ; [CPU_FPU] |273| 
        MOVXI     R1H,#38882            ; [CPU_FPU] |273| 
	.dwpsn	file "../bts.c",line 270,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||)+6,R0H ; [CPU_FPU] |270| 
	.dwpsn	file "../bts.c",line 274,column 5,is_stmt,isa 0
        MOVIZ     R0H,#49180            ; [CPU_FPU] |274| 
        MOVXI     R0H,#33699            ; [CPU_FPU] |274| 
	.dwpsn	file "../bts.c",line 271,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch2||)+8,R2H ; [CPU_FPU] |271| 
	.dwpsn	file "../bts.c",line 275,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16266            ; [CPU_FPU] |275| 
        MOVW      DP,#||BTS_ctrl_cv_ch2|| ; [CPU_ARAU] 
        MOVXI     R2H,#42223            ; [CPU_FPU] |275| 
	.dwpsn	file "../bts.c",line 273,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch2||),R1H ; [CPU_FPU] |273| 
	.dwpsn	file "../bts.c",line 276,column 5,is_stmt,isa 0
        MOVIZ     R1H,#49142            ; [CPU_FPU] |276| 
        MOVXI     R1H,#21415            ; [CPU_FPU] |276| 
	.dwpsn	file "../bts.c",line 274,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch2||)+2,R0H ; [CPU_FPU] |274| 
	.dwpsn	file "../bts.c",line 277,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16236            ; [CPU_FPU] |277| 
        MOVXI     R0H,#42831            ; [CPU_FPU] |277| 
	.dwpsn	file "../bts.c",line 275,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch2||)+4,R2H ; [CPU_FPU] |275| 
	.dwpsn	file "../bts.c",line 283,column 5,is_stmt,isa 0
        MOVIZ     R2H,#15628            ; [CPU_FPU] |283| 
        MOVXI     R2H,#31105            ; [CPU_FPU] |283| 
	.dwpsn	file "../bts.c",line 276,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch2||)+6,R1H ; [CPU_FPU] |276| 
	.dwpsn	file "../bts.c",line 284,column 5,is_stmt,isa 0
        MOVIZ     R1H,#48506            ; [CPU_FPU] |284| 
        MOVXI     R1H,#27704            ; [CPU_FPU] |284| 
	.dwpsn	file "../bts.c",line 277,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch2||)+8,R0H ; [CPU_FPU] |277| 
	.dwpsn	file "../bts.c",line 285,column 5,is_stmt,isa 0
        MOVIZ     R0H,#15581            ; [CPU_FPU] |285| 
        MOVW      DP,#||BTS_ctrl_cc_ch3|| ; [CPU_ARAU] 
        MOVXI     R0H,#54450            ; [CPU_FPU] |285| 
	.dwpsn	file "../bts.c",line 283,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||),R2H ; [CPU_FPU] |283| 
	.dwpsn	file "../bts.c",line 286,column 5,is_stmt,isa 0
        MOVIZ     R2H,#49142            ; [CPU_FPU] |286| 
        MOVXI     R2H,#21415            ; [CPU_FPU] |286| 
	.dwpsn	file "../bts.c",line 284,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||)+2,R1H ; [CPU_FPU] |284| 
	.dwpsn	file "../bts.c",line 287,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16236            ; [CPU_FPU] |287| 
        MOVXI     R1H,#42830            ; [CPU_FPU] |287| 
	.dwpsn	file "../bts.c",line 285,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||)+4,R0H ; [CPU_FPU] |285| 
	.dwpsn	file "../bts.c",line 289,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16303            ; [CPU_FPU] |289| 
        MOVXI     R0H,#38882            ; [CPU_FPU] |289| 
	.dwpsn	file "../bts.c",line 286,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||)+6,R2H ; [CPU_FPU] |286| 
	.dwpsn	file "../bts.c",line 290,column 5,is_stmt,isa 0
        MOVIZ     R2H,#49180            ; [CPU_FPU] |290| 
        MOVXI     R2H,#33699            ; [CPU_FPU] |290| 
	.dwpsn	file "../bts.c",line 287,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch3||)+8,R1H ; [CPU_FPU] |287| 
	.dwpsn	file "../bts.c",line 291,column 5,is_stmt,isa 0
        MOVIZ     R1H,#16266            ; [CPU_FPU] |291| 
        MOVW      DP,#||BTS_ctrl_cv_ch3|| ; [CPU_ARAU] 
        MOVXI     R1H,#42223            ; [CPU_FPU] |291| 
	.dwpsn	file "../bts.c",line 289,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch3||),R0H ; [CPU_FPU] |289| 
	.dwpsn	file "../bts.c",line 292,column 5,is_stmt,isa 0
        MOVIZ     R0H,#49142            ; [CPU_FPU] |292| 
        MOVXI     R0H,#21415            ; [CPU_FPU] |292| 
	.dwpsn	file "../bts.c",line 290,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch3||)+2,R2H ; [CPU_FPU] |290| 
	.dwpsn	file "../bts.c",line 293,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16236            ; [CPU_FPU] |293| 
        MOVXI     R2H,#42831            ; [CPU_FPU] |293| 
	.dwpsn	file "../bts.c",line 291,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch3||)+4,R1H ; [CPU_FPU] |291| 
	.dwpsn	file "../bts.c",line 299,column 5,is_stmt,isa 0
        MOVIZ     R1H,#15628            ; [CPU_FPU] |299| 
        MOVXI     R1H,#31105            ; [CPU_FPU] |299| 
	.dwpsn	file "../bts.c",line 292,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch3||)+6,R0H ; [CPU_FPU] |292| 
	.dwpsn	file "../bts.c",line 300,column 5,is_stmt,isa 0
        MOVIZ     R0H,#48506            ; [CPU_FPU] |300| 
        MOVXI     R0H,#27704            ; [CPU_FPU] |300| 
	.dwpsn	file "../bts.c",line 293,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch3||)+8,R2H ; [CPU_FPU] |293| 
	.dwpsn	file "../bts.c",line 301,column 5,is_stmt,isa 0
        MOVIZ     R2H,#15581            ; [CPU_FPU] |301| 
        MOVW      DP,#||BTS_ctrl_cc_ch4|| ; [CPU_ARAU] 
        MOVXI     R2H,#54450            ; [CPU_FPU] |301| 
	.dwpsn	file "../bts.c",line 299,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||),R1H ; [CPU_FPU] |299| 
	.dwpsn	file "../bts.c",line 302,column 5,is_stmt,isa 0
        MOVIZ     R1H,#49142            ; [CPU_FPU] |302| 
        MOVXI     R1H,#21415            ; [CPU_FPU] |302| 
	.dwpsn	file "../bts.c",line 300,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||)+2,R0H ; [CPU_FPU] |300| 
	.dwpsn	file "../bts.c",line 303,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16236            ; [CPU_FPU] |303| 
        MOVXI     R0H,#42830            ; [CPU_FPU] |303| 
	.dwpsn	file "../bts.c",line 301,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||)+4,R2H ; [CPU_FPU] |301| 
	.dwpsn	file "../bts.c",line 307,column 5,is_stmt,isa 0
        MOVIZ     R2H,#16266            ; [CPU_FPU] |307| 
        MOVXI     R2H,#42223            ; [CPU_FPU] |307| 
	.dwpsn	file "../bts.c",line 302,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||)+6,R1H ; [CPU_FPU] |302| 
	.dwpsn	file "../bts.c",line 308,column 5,is_stmt,isa 0
        MOVIZ     R1H,#49142            ; [CPU_FPU] |308| 
        MOVXI     R1H,#21415            ; [CPU_FPU] |308| 
	.dwpsn	file "../bts.c",line 303,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cc_ch4||)+8,R0H ; [CPU_FPU] |303| 
	.dwpsn	file "../bts.c",line 309,column 5,is_stmt,isa 0
        MOVIZ     R0H,#16236            ; [CPU_FPU] |309| 
        MOVW      DP,#||BTS_ctrl_cv_ch4|| ; [CPU_ARAU] 
        MOVXI     R0H,#42831            ; [CPU_FPU] |309| 
	.dwpsn	file "../bts.c",line 305,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch4||),R4H ; [CPU_FPU] |305| 
	.dwpsn	file "../bts.c",line 306,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch4||)+2,R3H ; [CPU_FPU] |306| 
        MOV32     R4H,*--SP             ; [CPU_FPU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 59
	.dwpsn	file "../bts.c",line 307,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch4||)+4,R2H ; [CPU_FPU] |307| 
	.dwpsn	file "../bts.c",line 308,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch4||)+6,R1H ; [CPU_FPU] |308| 
	.dwpsn	file "../bts.c",line 309,column 5,is_stmt,isa 0
        MOV32     @$BLOCKED(||BTS_ctrl_cv_ch4||)+8,R0H ; [CPU_FPU] |309| 
$C$DW$165	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$165, DW_AT_low_pc(0x00)
	.dwattr $C$DW$165, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$164, DW_AT_TI_end_file("../bts.c")
	.dwattr $C$DW$164, DW_AT_TI_end_line(0x137)
	.dwattr $C$DW$164, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$164

;**************************************************************
;* UNDEFINED EXTERNAL REFERENCES                              *
;**************************************************************
	.global	||SFO||
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

$C$DW$TU$24	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$24

$C$DW$T$24	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$24, DW_AT_byte_size(0x1e)
$C$DW$166	.dwtag  DW_TAG_member
	.dwattr $C$DW$166, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$166, DW_AT_name("iref_A")
	.dwattr $C$DW$166, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$166, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$166, DW_AT_decl_line(0x74)
	.dwattr $C$DW$166, DW_AT_decl_column(0x18)

$C$DW$167	.dwtag  DW_TAG_member
	.dwattr $C$DW$167, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$167, DW_AT_name("vref_charge_V")
	.dwattr $C$DW$167, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$167, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$167, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$167, DW_AT_decl_line(0x75)
	.dwattr $C$DW$167, DW_AT_decl_column(0x18)

$C$DW$168	.dwtag  DW_TAG_member
	.dwattr $C$DW$168, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$168, DW_AT_name("vref_discharge_V")
	.dwattr $C$DW$168, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$168, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$168, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$168, DW_AT_decl_line(0x76)
	.dwattr $C$DW$168, DW_AT_decl_column(0x18)

$C$DW$169	.dwtag  DW_TAG_member
	.dwattr $C$DW$169, DW_AT_type(*$C$DW$T$23)
	.dwattr $C$DW$169, DW_AT_name("direction_logic")
	.dwattr $C$DW$169, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$169, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$169, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$169, DW_AT_decl_line(0x77)
	.dwattr $C$DW$169, DW_AT_decl_column(0x17)

$C$DW$170	.dwtag  DW_TAG_member
	.dwattr $C$DW$170, DW_AT_type(*$C$DW$T$23)
	.dwattr $C$DW$170, DW_AT_name("enable_logic")
	.dwattr $C$DW$170, DW_AT_data_member_location[DW_OP_plus_uconst 0x7]
	.dwattr $C$DW$170, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$170, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$170, DW_AT_decl_line(0x78)
	.dwattr $C$DW$170, DW_AT_decl_column(0x17)

$C$DW$171	.dwtag  DW_TAG_member
	.dwattr $C$DW$171, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$171, DW_AT_name("dutyRef_pu")
	.dwattr $C$DW$171, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$171, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$171, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$171, DW_AT_decl_line(0x79)
	.dwattr $C$DW$171, DW_AT_decl_column(0x18)

$C$DW$172	.dwtag  DW_TAG_member
	.dwattr $C$DW$172, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$172, DW_AT_name("ioutCal_pu")
	.dwattr $C$DW$172, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$172, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$172, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$172, DW_AT_decl_line(0x7a)
	.dwattr $C$DW$172, DW_AT_decl_column(0x18)

$C$DW$173	.dwtag  DW_TAG_member
	.dwattr $C$DW$173, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$173, DW_AT_name("voutCal_pu")
	.dwattr $C$DW$173, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$173, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$173, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$173, DW_AT_decl_line(0x7b)
	.dwattr $C$DW$173, DW_AT_decl_column(0x18)

$C$DW$174	.dwtag  DW_TAG_member
	.dwattr $C$DW$174, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$174, DW_AT_name("IoutGain_pu")
	.dwattr $C$DW$174, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$174, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$174, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$174, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$174, DW_AT_decl_column(0x0f)

$C$DW$175	.dwtag  DW_TAG_member
	.dwattr $C$DW$175, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$175, DW_AT_name("IoutOffset_pu")
	.dwattr $C$DW$175, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$175, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$175, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$175, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$175, DW_AT_decl_column(0x0f)

$C$DW$176	.dwtag  DW_TAG_member
	.dwattr $C$DW$176, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$176, DW_AT_name("IoutGain_A")
	.dwattr $C$DW$176, DW_AT_data_member_location[DW_OP_plus_uconst 0x12]
	.dwattr $C$DW$176, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$176, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$176, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$176, DW_AT_decl_column(0x0f)

$C$DW$177	.dwtag  DW_TAG_member
	.dwattr $C$DW$177, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$177, DW_AT_name("IoutOffset_A")
	.dwattr $C$DW$177, DW_AT_data_member_location[DW_OP_plus_uconst 0x14]
	.dwattr $C$DW$177, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$177, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$177, DW_AT_decl_line(0x80)
	.dwattr $C$DW$177, DW_AT_decl_column(0x0f)

$C$DW$178	.dwtag  DW_TAG_member
	.dwattr $C$DW$178, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$178, DW_AT_name("VoutGain_pu")
	.dwattr $C$DW$178, DW_AT_data_member_location[DW_OP_plus_uconst 0x16]
	.dwattr $C$DW$178, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$178, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$178, DW_AT_decl_line(0x82)
	.dwattr $C$DW$178, DW_AT_decl_column(0x0f)

$C$DW$179	.dwtag  DW_TAG_member
	.dwattr $C$DW$179, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$179, DW_AT_name("VoutOffset_pu")
	.dwattr $C$DW$179, DW_AT_data_member_location[DW_OP_plus_uconst 0x18]
	.dwattr $C$DW$179, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$179, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$179, DW_AT_decl_line(0x83)
	.dwattr $C$DW$179, DW_AT_decl_column(0x0f)

$C$DW$180	.dwtag  DW_TAG_member
	.dwattr $C$DW$180, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$180, DW_AT_name("VoutGain_V")
	.dwattr $C$DW$180, DW_AT_data_member_location[DW_OP_plus_uconst 0x1a]
	.dwattr $C$DW$180, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$180, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$180, DW_AT_decl_line(0x84)
	.dwattr $C$DW$180, DW_AT_decl_column(0x0f)

$C$DW$181	.dwtag  DW_TAG_member
	.dwattr $C$DW$181, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$181, DW_AT_name("VoutOffset_V")
	.dwattr $C$DW$181, DW_AT_data_member_location[DW_OP_plus_uconst 0x1c]
	.dwattr $C$DW$181, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$181, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$181, DW_AT_decl_line(0x85)
	.dwattr $C$DW$181, DW_AT_decl_column(0x0f)

	.dwattr $C$DW$T$24, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$24, DW_AT_decl_line(0x73)
	.dwattr $C$DW$T$24, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$24

	.dwendtag $C$DW$TU$24


$C$DW$TU$49	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$49
$C$DW$T$49	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$49, DW_AT_name("BTS_userInput")
	.dwattr $C$DW$T$49, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$T$49, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$49, DW_AT_decl_line(0x87)
	.dwattr $C$DW$T$49, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$49


$C$DW$TU$50	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$50
$C$DW$T$50	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$50, DW_AT_type(*$C$DW$T$49)
	.dwattr $C$DW$T$50, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$50


$C$DW$TU$51	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$51
$C$DW$182	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$182, DW_AT_type(*$C$DW$T$50)

$C$DW$T$51	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$51, DW_AT_type(*$C$DW$182)

	.dwendtag $C$DW$TU$51


$C$DW$TU$27	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$27

$C$DW$T$27	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$27, DW_AT_byte_size(0x24)
$C$DW$183	.dwtag  DW_TAG_member
	.dwattr $C$DW$183, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$183, DW_AT_name("dutySet_pu")
	.dwattr $C$DW$183, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$183, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$183, DW_AT_decl_line(0x90)
	.dwattr $C$DW$183, DW_AT_decl_column(0x0f)

$C$DW$184	.dwtag  DW_TAG_member
	.dwattr $C$DW$184, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$184, DW_AT_name("dutySetRef_pu")
	.dwattr $C$DW$184, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$184, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$184, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$184, DW_AT_decl_line(0x91)
	.dwattr $C$DW$184, DW_AT_decl_column(0x0f)

$C$DW$185	.dwtag  DW_TAG_member
	.dwattr $C$DW$185, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$185, DW_AT_name("ioutRef_pu")
	.dwattr $C$DW$185, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$185, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$185, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$185, DW_AT_decl_line(0x93)
	.dwattr $C$DW$185, DW_AT_decl_column(0x0f)

$C$DW$186	.dwtag  DW_TAG_member
	.dwattr $C$DW$186, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$186, DW_AT_name("ioutSet_pu")
	.dwattr $C$DW$186, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$186, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$186, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$186, DW_AT_decl_line(0x94)
	.dwattr $C$DW$186, DW_AT_decl_column(0x0f)

$C$DW$187	.dwtag  DW_TAG_member
	.dwattr $C$DW$187, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$187, DW_AT_name("ioutSense_pu")
	.dwattr $C$DW$187, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$187, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$187, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$187, DW_AT_decl_line(0x95)
	.dwattr $C$DW$187, DW_AT_decl_column(0x0f)

$C$DW$188	.dwtag  DW_TAG_member
	.dwattr $C$DW$188, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$188, DW_AT_name("voutRef_pu")
	.dwattr $C$DW$188, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$188, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$188, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$188, DW_AT_decl_line(0x97)
	.dwattr $C$DW$188, DW_AT_decl_column(0x0f)

$C$DW$189	.dwtag  DW_TAG_member
	.dwattr $C$DW$189, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$189, DW_AT_name("voutSet_pu")
	.dwattr $C$DW$189, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$189, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$189, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$189, DW_AT_decl_line(0x98)
	.dwattr $C$DW$189, DW_AT_decl_column(0x0f)

$C$DW$190	.dwtag  DW_TAG_member
	.dwattr $C$DW$190, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$190, DW_AT_name("voutSense_pu")
	.dwattr $C$DW$190, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$190, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$190, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$190, DW_AT_decl_line(0x99)
	.dwattr $C$DW$190, DW_AT_decl_column(0x0f)

$C$DW$191	.dwtag  DW_TAG_member
	.dwattr $C$DW$191, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$191, DW_AT_name("uk_cc_pu")
	.dwattr $C$DW$191, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$191, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$191, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$191, DW_AT_decl_line(0x9b)
	.dwattr $C$DW$191, DW_AT_decl_column(0x0f)

$C$DW$192	.dwtag  DW_TAG_member
	.dwattr $C$DW$192, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$192, DW_AT_name("ek_cc_pu")
	.dwattr $C$DW$192, DW_AT_data_member_location[DW_OP_plus_uconst 0x12]
	.dwattr $C$DW$192, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$192, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$192, DW_AT_decl_line(0x9c)
	.dwattr $C$DW$192, DW_AT_decl_column(0x0f)

$C$DW$193	.dwtag  DW_TAG_member
	.dwattr $C$DW$193, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$193, DW_AT_name("uk_cv_pu")
	.dwattr $C$DW$193, DW_AT_data_member_location[DW_OP_plus_uconst 0x14]
	.dwattr $C$DW$193, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$193, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$193, DW_AT_decl_line(0x9d)
	.dwattr $C$DW$193, DW_AT_decl_column(0x0f)

$C$DW$194	.dwtag  DW_TAG_member
	.dwattr $C$DW$194, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$194, DW_AT_name("ek_cv_pu")
	.dwattr $C$DW$194, DW_AT_data_member_location[DW_OP_plus_uconst 0x16]
	.dwattr $C$DW$194, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$194, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$194, DW_AT_decl_line(0x9e)
	.dwattr $C$DW$194, DW_AT_decl_column(0x0f)

$C$DW$195	.dwtag  DW_TAG_member
	.dwattr $C$DW$195, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$195, DW_AT_name("direction_coeff")
	.dwattr $C$DW$195, DW_AT_data_member_location[DW_OP_plus_uconst 0x18]
	.dwattr $C$DW$195, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$195, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$195, DW_AT_decl_line(0x9f)
	.dwattr $C$DW$195, DW_AT_decl_column(0x0f)

$C$DW$196	.dwtag  DW_TAG_member
	.dwattr $C$DW$196, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$196, DW_AT_name("dutyH_pu")
	.dwattr $C$DW$196, DW_AT_data_member_location[DW_OP_plus_uconst 0x1a]
	.dwattr $C$DW$196, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$196, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$196, DW_AT_decl_line(0xa1)
	.dwattr $C$DW$196, DW_AT_decl_column(0x0f)

$C$DW$197	.dwtag  DW_TAG_member
	.dwattr $C$DW$197, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$197, DW_AT_name("dutyL_pu")
	.dwattr $C$DW$197, DW_AT_data_member_location[DW_OP_plus_uconst 0x1c]
	.dwattr $C$DW$197, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$197, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$197, DW_AT_decl_line(0xa2)
	.dwattr $C$DW$197, DW_AT_decl_column(0x0f)

$C$DW$198	.dwtag  DW_TAG_member
	.dwattr $C$DW$198, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$198, DW_AT_name("ctrlMode_logic")
	.dwattr $C$DW$198, DW_AT_data_member_location[DW_OP_plus_uconst 0x1e]
	.dwattr $C$DW$198, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$198, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$198, DW_AT_decl_line(0xa4)
	.dwattr $C$DW$198, DW_AT_decl_column(0x0e)

$C$DW$199	.dwtag  DW_TAG_member
	.dwattr $C$DW$199, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$199, DW_AT_name("direction_logic")
	.dwattr $C$DW$199, DW_AT_data_member_location[DW_OP_plus_uconst 0x1f]
	.dwattr $C$DW$199, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$199, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$199, DW_AT_decl_line(0xa5)
	.dwattr $C$DW$199, DW_AT_decl_column(0x0e)

$C$DW$200	.dwtag  DW_TAG_member
	.dwattr $C$DW$200, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$200, DW_AT_name("ioutTrip_16b")
	.dwattr $C$DW$200, DW_AT_data_member_location[DW_OP_plus_uconst 0x20]
	.dwattr $C$DW$200, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$200, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$200, DW_AT_decl_line(0xa7)
	.dwattr $C$DW$200, DW_AT_decl_column(0x0d)

$C$DW$201	.dwtag  DW_TAG_member
	.dwattr $C$DW$201, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$201, DW_AT_name("ioutTrip_n_16b")
	.dwattr $C$DW$201, DW_AT_data_member_location[DW_OP_plus_uconst 0x21]
	.dwattr $C$DW$201, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$201, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$201, DW_AT_decl_line(0xa8)
	.dwattr $C$DW$201, DW_AT_decl_column(0x0d)

$C$DW$202	.dwtag  DW_TAG_member
	.dwattr $C$DW$202, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$202, DW_AT_name("tripFlag")
	.dwattr $C$DW$202, DW_AT_data_member_location[DW_OP_plus_uconst 0x22]
	.dwattr $C$DW$202, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$202, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$202, DW_AT_decl_line(0xa9)
	.dwattr $C$DW$202, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$27, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$27, DW_AT_decl_line(0x8f)
	.dwattr $C$DW$T$27, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$27

	.dwendtag $C$DW$TU$27


$C$DW$TU$54	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$54
$C$DW$T$54	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$54, DW_AT_name("BTS_ctrlLoopVariable")
	.dwattr $C$DW$T$54, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$T$54, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$54, DW_AT_decl_line(0xab)
	.dwattr $C$DW$T$54, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$54


$C$DW$TU$55	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$55
$C$DW$T$55	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$55, DW_AT_type(*$C$DW$T$54)
	.dwattr $C$DW$T$55, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$55


$C$DW$TU$56	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$56
$C$DW$203	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$203, DW_AT_type(*$C$DW$T$55)

$C$DW$T$56	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$56, DW_AT_type(*$C$DW$203)

	.dwendtag $C$DW$TU$56


$C$DW$TU$31	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$31

$C$DW$T$31	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$31, DW_AT_byte_size(0x52)
$C$DW$204	.dwtag  DW_TAG_member
	.dwattr $C$DW$204, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$204, DW_AT_name("Isense_A")
	.dwattr $C$DW$204, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$204, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$204, DW_AT_decl_line(0x5f)
	.dwattr $C$DW$204, DW_AT_decl_column(0x0f)

$C$DW$205	.dwtag  DW_TAG_member
	.dwattr $C$DW$205, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$205, DW_AT_name("Vsense_V")
	.dwattr $C$DW$205, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$205, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$205, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$205, DW_AT_decl_line(0x60)
	.dwattr $C$DW$205, DW_AT_decl_column(0x0f)

$C$DW$206	.dwtag  DW_TAG_member
	.dwattr $C$DW$206, DW_AT_type(*$C$DW$T$28)
	.dwattr $C$DW$206, DW_AT_name("Isense_16b")
	.dwattr $C$DW$206, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$206, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$206, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$206, DW_AT_decl_line(0x61)
	.dwattr $C$DW$206, DW_AT_decl_column(0x0d)

$C$DW$207	.dwtag  DW_TAG_member
	.dwattr $C$DW$207, DW_AT_type(*$C$DW$T$28)
	.dwattr $C$DW$207, DW_AT_name("Vsense_16b")
	.dwattr $C$DW$207, DW_AT_data_member_location[DW_OP_plus_uconst 0x24]
	.dwattr $C$DW$207, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$207, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$207, DW_AT_decl_line(0x62)
	.dwattr $C$DW$207, DW_AT_decl_column(0x0d)

$C$DW$208	.dwtag  DW_TAG_member
	.dwattr $C$DW$208, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$208, DW_AT_name("Sum_I")
	.dwattr $C$DW$208, DW_AT_data_member_location[DW_OP_plus_uconst 0x44]
	.dwattr $C$DW$208, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$208, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$208, DW_AT_decl_line(0x63)
	.dwattr $C$DW$208, DW_AT_decl_column(0x0d)

$C$DW$209	.dwtag  DW_TAG_member
	.dwattr $C$DW$209, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$209, DW_AT_name("Sum_V")
	.dwattr $C$DW$209, DW_AT_data_member_location[DW_OP_plus_uconst 0x46]
	.dwattr $C$DW$209, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$209, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$209, DW_AT_decl_line(0x64)
	.dwattr $C$DW$209, DW_AT_decl_column(0x0d)

$C$DW$210	.dwtag  DW_TAG_member
	.dwattr $C$DW$210, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$210, DW_AT_name("Index")
	.dwattr $C$DW$210, DW_AT_data_member_location[DW_OP_plus_uconst 0x48]
	.dwattr $C$DW$210, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$210, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$210, DW_AT_decl_line(0x65)
	.dwattr $C$DW$210, DW_AT_decl_column(0x0e)

$C$DW$211	.dwtag  DW_TAG_member
	.dwattr $C$DW$211, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$211, DW_AT_name("IoutGain_A")
	.dwattr $C$DW$211, DW_AT_data_member_location[DW_OP_plus_uconst 0x4a]
	.dwattr $C$DW$211, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$211, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$211, DW_AT_decl_line(0x66)
	.dwattr $C$DW$211, DW_AT_decl_column(0x0f)

$C$DW$212	.dwtag  DW_TAG_member
	.dwattr $C$DW$212, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$212, DW_AT_name("IoutOffset_A")
	.dwattr $C$DW$212, DW_AT_data_member_location[DW_OP_plus_uconst 0x4c]
	.dwattr $C$DW$212, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$212, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$212, DW_AT_decl_line(0x67)
	.dwattr $C$DW$212, DW_AT_decl_column(0x0f)

$C$DW$213	.dwtag  DW_TAG_member
	.dwattr $C$DW$213, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$213, DW_AT_name("VoutGain_V")
	.dwattr $C$DW$213, DW_AT_data_member_location[DW_OP_plus_uconst 0x4e]
	.dwattr $C$DW$213, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$213, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$213, DW_AT_decl_line(0x68)
	.dwattr $C$DW$213, DW_AT_decl_column(0x0f)

$C$DW$214	.dwtag  DW_TAG_member
	.dwattr $C$DW$214, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$214, DW_AT_name("VoutOffset_V")
	.dwattr $C$DW$214, DW_AT_data_member_location[DW_OP_plus_uconst 0x50]
	.dwattr $C$DW$214, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$214, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$214, DW_AT_decl_line(0x69)
	.dwattr $C$DW$214, DW_AT_decl_column(0x0f)

	.dwattr $C$DW$T$31, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$31, DW_AT_decl_line(0x5e)
	.dwattr $C$DW$T$31, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$31

	.dwendtag $C$DW$TU$31


$C$DW$TU$59	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$59
$C$DW$T$59	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$59, DW_AT_name("BTS_measValues")
	.dwattr $C$DW$T$59, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$T$59, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/bts.h")
	.dwattr $C$DW$T$59, DW_AT_decl_line(0x6b)
	.dwattr $C$DW$T$59, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$59


$C$DW$TU$60	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$60
$C$DW$T$60	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$60, DW_AT_type(*$C$DW$T$59)
	.dwattr $C$DW$T$60, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$60


$C$DW$TU$61	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$61
$C$DW$215	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$215, DW_AT_type(*$C$DW$T$60)

$C$DW$T$61	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$61, DW_AT_type(*$C$DW$215)

	.dwendtag $C$DW$TU$61


$C$DW$TU$33	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$33

$C$DW$T$33	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$33, DW_AT_name("_Complex_double")
	.dwattr $C$DW$T$33, DW_AT_byte_size(0x08)
$C$DW$216	.dwtag  DW_TAG_member
	.dwattr $C$DW$216, DW_AT_type(*$C$DW$T$32)
	.dwattr $C$DW$216, DW_AT_name("_Vals")
	.dwattr $C$DW$216, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$216, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$216, DW_AT_decl_line(0x01)
	.dwattr $C$DW$216, DW_AT_decl_column(0x00)

	.dwendtag $C$DW$T$33

	.dwendtag $C$DW$TU$33


$C$DW$TU$64	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$64
$C$DW$T$64	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$64, DW_AT_name("_Complex_double")
	.dwattr $C$DW$T$64, DW_AT_type(*$C$DW$T$33)
	.dwattr $C$DW$T$64, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$T$64, DW_AT_decl_line(0x01)
	.dwattr $C$DW$T$64, DW_AT_decl_column(0x00)

	.dwendtag $C$DW$TU$64


$C$DW$TU$35	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$35

$C$DW$T$35	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$35, DW_AT_name("_Complex_float")
	.dwattr $C$DW$T$35, DW_AT_byte_size(0x04)
$C$DW$217	.dwtag  DW_TAG_member
	.dwattr $C$DW$217, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$217, DW_AT_name("_Vals")
	.dwattr $C$DW$217, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$217, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$217, DW_AT_decl_line(0x01)
	.dwattr $C$DW$217, DW_AT_decl_column(0x00)

	.dwendtag $C$DW$T$35

	.dwendtag $C$DW$TU$35


$C$DW$TU$65	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$65
$C$DW$T$65	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$65, DW_AT_name("_Complex_float")
	.dwattr $C$DW$T$65, DW_AT_type(*$C$DW$T$35)
	.dwattr $C$DW$T$65, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$T$65, DW_AT_decl_line(0x01)
	.dwattr $C$DW$T$65, DW_AT_decl_column(0x00)

	.dwendtag $C$DW$TU$65


$C$DW$TU$37	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$37

$C$DW$T$37	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$37, DW_AT_name("_Complex_long_double")
	.dwattr $C$DW$T$37, DW_AT_byte_size(0x08)
$C$DW$218	.dwtag  DW_TAG_member
	.dwattr $C$DW$218, DW_AT_type(*$C$DW$T$36)
	.dwattr $C$DW$218, DW_AT_name("_Vals")
	.dwattr $C$DW$218, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$218, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$218, DW_AT_decl_line(0x01)
	.dwattr $C$DW$218, DW_AT_decl_column(0x00)

	.dwendtag $C$DW$T$37

	.dwendtag $C$DW$TU$37


$C$DW$TU$67	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$67
$C$DW$T$67	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$67, DW_AT_name("_Complex_long_double")
	.dwattr $C$DW$T$67, DW_AT_type(*$C$DW$T$37)
	.dwattr $C$DW$T$67, DW_AT_decl_file("../bts.c")
	.dwattr $C$DW$T$67, DW_AT_decl_line(0x01)
	.dwattr $C$DW$T$67, DW_AT_decl_column(0x00)

	.dwendtag $C$DW$TU$67


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


$C$DW$TU$25	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$25
$C$DW$T$25	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$25, DW_AT_name("__int16_t")
	.dwattr $C$DW$T$25, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$25, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$25, DW_AT_decl_line(0x40)
	.dwattr $C$DW$T$25, DW_AT_decl_column(0x1d)

	.dwendtag $C$DW$TU$25


$C$DW$TU$26	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$26
$C$DW$T$26	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$26, DW_AT_name("int16_t")
	.dwattr $C$DW$T$26, DW_AT_type(*$C$DW$T$25)
	.dwattr $C$DW$T$26, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$26, DW_AT_decl_line(0x2b)
	.dwattr $C$DW$T$26, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$26


$C$DW$TU$28	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$28

$C$DW$T$28	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$28, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$T$28, DW_AT_byte_size(0x20)
$C$DW$219	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$219, DW_AT_upper_bound(0x1f)

	.dwendtag $C$DW$T$28

	.dwendtag $C$DW$TU$28


$C$DW$TU$11	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$11
$C$DW$T$11	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$11, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$11, DW_AT_name("unsigned int")
	.dwattr $C$DW$T$11, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$11


$C$DW$TU$21	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$21
$C$DW$T$21	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$21, DW_AT_name("__uint16_t")
	.dwattr $C$DW$T$21, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$T$21, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$21, DW_AT_decl_line(0x41)
	.dwattr $C$DW$T$21, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$21


$C$DW$TU$22	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$22
$C$DW$T$22	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$22, DW_AT_name("uint16_t")
	.dwattr $C$DW$T$22, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$T$22, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$22, DW_AT_decl_line(0x41)
	.dwattr $C$DW$T$22, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$22


$C$DW$TU$23	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$23
$C$DW$220	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$220, DW_AT_type(*$C$DW$T$22)

$C$DW$T$23	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$23, DW_AT_type(*$C$DW$220)

	.dwendtag $C$DW$TU$23


$C$DW$TU$12	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$12
$C$DW$T$12	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$12, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$12, DW_AT_name("long")
	.dwattr $C$DW$T$12, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$12


$C$DW$TU$29	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$29
$C$DW$T$29	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$29, DW_AT_name("__int32_t")
	.dwattr $C$DW$T$29, DW_AT_type(*$C$DW$T$12)
	.dwattr $C$DW$T$29, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$29, DW_AT_decl_line(0x42)
	.dwattr $C$DW$T$29, DW_AT_decl_column(0x1d)

	.dwendtag $C$DW$TU$29


$C$DW$TU$30	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$30
$C$DW$T$30	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$30, DW_AT_name("int32_t")
	.dwattr $C$DW$T$30, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$T$30, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$30, DW_AT_decl_line(0x30)
	.dwattr $C$DW$T$30, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$30


$C$DW$TU$13	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$13
$C$DW$T$13	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$13, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$13, DW_AT_name("unsigned long")
	.dwattr $C$DW$T$13, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$13


$C$DW$TU$38	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$38
$C$DW$T$38	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$38, DW_AT_name("__uint32_t")
	.dwattr $C$DW$T$38, DW_AT_type(*$C$DW$T$13)
	.dwattr $C$DW$T$38, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$38, DW_AT_decl_line(0x43)
	.dwattr $C$DW$T$38, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$38


$C$DW$TU$39	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$39
$C$DW$T$39	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$39, DW_AT_name("uint32_t")
	.dwattr $C$DW$T$39, DW_AT_type(*$C$DW$T$38)
	.dwattr $C$DW$T$39, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$39, DW_AT_decl_line(0x46)
	.dwattr $C$DW$T$39, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$39


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


$C$DW$TU$34	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$34

$C$DW$T$34	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$34, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$T$34, DW_AT_byte_size(0x04)
$C$DW$221	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$221, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$34

	.dwendtag $C$DW$TU$34


$C$DW$TU$82	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$82
$C$DW$222	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$222, DW_AT_type(*$C$DW$T$16)

$C$DW$T$82	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$82, DW_AT_type(*$C$DW$222)

	.dwendtag $C$DW$TU$82


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
$C$DW$223	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$223, DW_AT_type(*$C$DW$T$19)

$C$DW$T$20	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$20, DW_AT_type(*$C$DW$223)

	.dwendtag $C$DW$TU$20


$C$DW$TU$17	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$17
$C$DW$T$17	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$17, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$17, DW_AT_name("double")
	.dwattr $C$DW$T$17, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$17


$C$DW$TU$32	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$32

$C$DW$T$32	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$32, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$T$32, DW_AT_byte_size(0x08)
$C$DW$224	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$224, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$32

	.dwendtag $C$DW$TU$32


$C$DW$TU$84	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$84
$C$DW$T$84	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$84, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$T$84, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$84


$C$DW$TU$85	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$85
$C$DW$225	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$225, DW_AT_type(*$C$DW$T$84)

$C$DW$T$85	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$85, DW_AT_type(*$C$DW$225)

	.dwendtag $C$DW$TU$85


$C$DW$TU$18	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$18
$C$DW$T$18	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$18, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$18, DW_AT_name("long double")
	.dwattr $C$DW$T$18, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$18


$C$DW$TU$36	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$36

$C$DW$T$36	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$36, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$36, DW_AT_byte_size(0x08)
$C$DW$226	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$226, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$36

	.dwendtag $C$DW$TU$36


$C$DW$TU$87	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$87
$C$DW$T$87	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$87, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$87, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$87


$C$DW$TU$88	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$88
$C$DW$227	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$227, DW_AT_type(*$C$DW$T$87)

$C$DW$T$88	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$88, DW_AT_type(*$C$DW$227)

	.dwendtag $C$DW$TU$88


$C$DW$TU$40	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$40

$C$DW$T$40	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$40, DW_AT_name("dcl_css")
	.dwattr $C$DW$T$40, DW_AT_byte_size(0x0a)
$C$DW$228	.dwtag  DW_TAG_member
	.dwattr $C$DW$228, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$228, DW_AT_name("tpt")
	.dwattr $C$DW$228, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$228, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$228, DW_AT_decl_line(0x91)
	.dwattr $C$DW$228, DW_AT_decl_column(0x0f)

$C$DW$229	.dwtag  DW_TAG_member
	.dwattr $C$DW$229, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$229, DW_AT_name("T")
	.dwattr $C$DW$229, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$229, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$229, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$229, DW_AT_decl_line(0x92)
	.dwattr $C$DW$229, DW_AT_decl_column(0x0f)

$C$DW$230	.dwtag  DW_TAG_member
	.dwattr $C$DW$230, DW_AT_type(*$C$DW$T$39)
	.dwattr $C$DW$230, DW_AT_name("sts")
	.dwattr $C$DW$230, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$230, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$230, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$230, DW_AT_decl_line(0x93)
	.dwattr $C$DW$230, DW_AT_decl_column(0x0e)

$C$DW$231	.dwtag  DW_TAG_member
	.dwattr $C$DW$231, DW_AT_type(*$C$DW$T$39)
	.dwattr $C$DW$231, DW_AT_name("err")
	.dwattr $C$DW$231, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$231, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$231, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$231, DW_AT_decl_line(0x94)
	.dwattr $C$DW$231, DW_AT_decl_column(0x0e)

$C$DW$232	.dwtag  DW_TAG_member
	.dwattr $C$DW$232, DW_AT_type(*$C$DW$T$39)
	.dwattr $C$DW$232, DW_AT_name("loc")
	.dwattr $C$DW$232, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$232, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$232, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$232, DW_AT_decl_line(0x95)
	.dwattr $C$DW$232, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$40, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$T$40, DW_AT_decl_line(0x90)
	.dwattr $C$DW$T$40, DW_AT_decl_column(0x19)
	.dwendtag $C$DW$T$40

	.dwendtag $C$DW$TU$40


$C$DW$TU$44	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$44
$C$DW$233	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$233, DW_AT_type(*$C$DW$T$40)

$C$DW$T$44	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$44, DW_AT_type(*$C$DW$233)

	.dwendtag $C$DW$TU$44


$C$DW$TU$45	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$45
$C$DW$T$45	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$45, DW_AT_name("DCL_CSS")
	.dwattr $C$DW$T$45, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$T$45, DW_AT_decl_file("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\libraries\DCL\DCL.h")
	.dwattr $C$DW$T$45, DW_AT_decl_line(0x96)
	.dwattr $C$DW$T$45, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$45


$C$DW$TU$46	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$46
$C$DW$T$46	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$46, DW_AT_type(*$C$DW$T$45)
	.dwattr $C$DW$T$46, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$46


$C$DW$TU$47	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$47

$C$DW$T$47	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$47, DW_AT_name("dcl_df22")
	.dwattr $C$DW$T$47, DW_AT_byte_size(0x12)
$C$DW$234	.dwtag  DW_TAG_member
	.dwattr $C$DW$234, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$234, DW_AT_name("b0")
	.dwattr $C$DW$234, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$234, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$234, DW_AT_decl_line(0x4ab)
	.dwattr $C$DW$234, DW_AT_decl_column(0x0f)

$C$DW$235	.dwtag  DW_TAG_member
	.dwattr $C$DW$235, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$235, DW_AT_name("b1")
	.dwattr $C$DW$235, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$235, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$235, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$235, DW_AT_decl_line(0x4ac)
	.dwattr $C$DW$235, DW_AT_decl_column(0x0f)

$C$DW$236	.dwtag  DW_TAG_member
	.dwattr $C$DW$236, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$236, DW_AT_name("b2")
	.dwattr $C$DW$236, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$236, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$236, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$236, DW_AT_decl_line(0x4ad)
	.dwattr $C$DW$236, DW_AT_decl_column(0x0f)

$C$DW$237	.dwtag  DW_TAG_member
	.dwattr $C$DW$237, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$237, DW_AT_name("a1")
	.dwattr $C$DW$237, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$237, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$237, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$237, DW_AT_decl_line(0x4ae)
	.dwattr $C$DW$237, DW_AT_decl_column(0x0f)

$C$DW$238	.dwtag  DW_TAG_member
	.dwattr $C$DW$238, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$238, DW_AT_name("a2")
	.dwattr $C$DW$238, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$238, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$238, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$238, DW_AT_decl_line(0x4af)
	.dwattr $C$DW$238, DW_AT_decl_column(0x0f)

$C$DW$239	.dwtag  DW_TAG_member
	.dwattr $C$DW$239, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$239, DW_AT_name("x1")
	.dwattr $C$DW$239, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$239, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$239, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$239, DW_AT_decl_line(0x4b0)
	.dwattr $C$DW$239, DW_AT_decl_column(0x0f)

$C$DW$240	.dwtag  DW_TAG_member
	.dwattr $C$DW$240, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$240, DW_AT_name("x2")
	.dwattr $C$DW$240, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$240, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$240, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$240, DW_AT_decl_line(0x4b1)
	.dwattr $C$DW$240, DW_AT_decl_column(0x0f)

$C$DW$241	.dwtag  DW_TAG_member
	.dwattr $C$DW$241, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$241, DW_AT_name("sps")
	.dwattr $C$DW$241, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$241, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$241, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$241, DW_AT_decl_line(0x4b2)
	.dwattr $C$DW$241, DW_AT_decl_column(0x13)

$C$DW$242	.dwtag  DW_TAG_member
	.dwattr $C$DW$242, DW_AT_type(*$C$DW$T$46)
	.dwattr $C$DW$242, DW_AT_name("css")
	.dwattr $C$DW$242, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$242, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$242, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$242, DW_AT_decl_line(0x4b3)
	.dwattr $C$DW$242, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$47, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$47, DW_AT_decl_line(0x4aa)
	.dwattr $C$DW$T$47, DW_AT_decl_column(0x19)
	.dwendtag $C$DW$T$47

	.dwendtag $C$DW$TU$47


$C$DW$TU$90	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$90
$C$DW$243	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$243, DW_AT_type(*$C$DW$T$47)

$C$DW$T$90	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$90, DW_AT_type(*$C$DW$243)

	.dwendtag $C$DW$TU$90


$C$DW$TU$91	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$91
$C$DW$T$91	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$91, DW_AT_name("DCL_DF22")
	.dwattr $C$DW$T$91, DW_AT_type(*$C$DW$T$90)
	.dwattr $C$DW$T$91, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$91, DW_AT_decl_line(0x4b4)
	.dwattr $C$DW$T$91, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$91


$C$DW$TU$48	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$48

$C$DW$T$48	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$48, DW_AT_name("dcl_df22_sps")
	.dwattr $C$DW$T$48, DW_AT_byte_size(0x0a)
$C$DW$244	.dwtag  DW_TAG_member
	.dwattr $C$DW$244, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$244, DW_AT_name("b0")
	.dwattr $C$DW$244, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$244, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$244, DW_AT_decl_line(0x49f)
	.dwattr $C$DW$244, DW_AT_decl_column(0x0f)

$C$DW$245	.dwtag  DW_TAG_member
	.dwattr $C$DW$245, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$245, DW_AT_name("b1")
	.dwattr $C$DW$245, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$245, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$245, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$245, DW_AT_decl_line(0x4a0)
	.dwattr $C$DW$245, DW_AT_decl_column(0x0f)

$C$DW$246	.dwtag  DW_TAG_member
	.dwattr $C$DW$246, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$246, DW_AT_name("b2")
	.dwattr $C$DW$246, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$246, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$246, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$246, DW_AT_decl_line(0x4a1)
	.dwattr $C$DW$246, DW_AT_decl_column(0x0f)

$C$DW$247	.dwtag  DW_TAG_member
	.dwattr $C$DW$247, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$247, DW_AT_name("a1")
	.dwattr $C$DW$247, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$247, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$247, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$247, DW_AT_decl_line(0x4a2)
	.dwattr $C$DW$247, DW_AT_decl_column(0x0f)

$C$DW$248	.dwtag  DW_TAG_member
	.dwattr $C$DW$248, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$248, DW_AT_name("a2")
	.dwattr $C$DW$248, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$248, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$248, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$248, DW_AT_decl_line(0x4a3)
	.dwattr $C$DW$248, DW_AT_decl_column(0x0f)

	.dwattr $C$DW$T$48, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$48, DW_AT_decl_line(0x49e)
	.dwattr $C$DW$T$48, DW_AT_decl_column(0x19)
	.dwendtag $C$DW$T$48

	.dwendtag $C$DW$TU$48


$C$DW$TU$41	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$41
$C$DW$249	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$249, DW_AT_type(*$C$DW$T$48)

$C$DW$T$41	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$41, DW_AT_type(*$C$DW$249)

	.dwendtag $C$DW$TU$41


$C$DW$TU$42	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$42
$C$DW$T$42	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$42, DW_AT_name("DCL_DF22_SPS")
	.dwattr $C$DW$T$42, DW_AT_type(*$C$DW$T$41)
	.dwattr $C$DW$T$42, DW_AT_decl_file("C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL/DCLF32.h")
	.dwattr $C$DW$T$42, DW_AT_decl_line(0x4a4)
	.dwattr $C$DW$T$42, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$42


$C$DW$TU$43	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$43
$C$DW$T$43	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$43, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$T$43, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$43

