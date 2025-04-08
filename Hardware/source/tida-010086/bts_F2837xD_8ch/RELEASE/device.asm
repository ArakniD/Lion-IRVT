;***************************************************************
;* TMS320C2000 G3 C/C++ Codegen                               PC v22.6.1.LTS *
;* Date/Time created: Sun Aug 11 14:43:18 2024                 *
;***************************************************************
	.compiler_opts --abi=eabi --cla_support=cla1 --diag_wrap=off --float_support=fpu32 --hll_source=on --mem_model:code=flat --mem_model:data=large --object_format=elf --quiet --silicon_errata_fpu1_workaround=off --silicon_version=28 --symdebug:dwarf --symdebug:dwarf_version=4 --tmu_support=tmu0 --vcu_support=vcu2 
	.asg	XAR2, FP

$C$DW$CU	.dwtag  DW_TAG_compile_unit
	.dwattr $C$DW$CU, DW_AT_name("../device/device.c")
	.dwattr $C$DW$CU, DW_AT_producer("TI TMS320C2000 G3 C/C++ Codegen PC v22.6.1.LTS Copyright (c) 1996-2018 Texas Instruments Incorporated")
	.dwattr $C$DW$CU, DW_AT_TI_version(0x01)
	.dwattr $C$DW$CU, DW_AT_comp_dir("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\RELEASE")

$C$DW$1	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$1, DW_AT_name("Flash_initModule")
	.dwattr $C$DW$1, DW_AT_linkage_name("Flash_initModule")
	.dwattr $C$DW$1, DW_AT_declaration
	.dwattr $C$DW$1, DW_AT_external
	.dwattr $C$DW$1, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/flash.h")
	.dwattr $C$DW$1, DW_AT_decl_line(0x650)
	.dwattr $C$DW$1, DW_AT_decl_column(0x01)
$C$DW$2	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$2, DW_AT_type(*$C$DW$T$47)

$C$DW$3	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$3, DW_AT_type(*$C$DW$T$47)

$C$DW$4	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$4, DW_AT_type(*$C$DW$T$44)

	.dwendtag $C$DW$1


$C$DW$5	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$5, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$5, DW_AT_linkage_name("GPIO_setDirectionMode")
	.dwattr $C$DW$5, DW_AT_declaration
	.dwattr $C$DW$5, DW_AT_external
	.dwattr $C$DW$5, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$5, DW_AT_decl_line(0x324)
	.dwattr $C$DW$5, DW_AT_decl_column(0x01)
$C$DW$6	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$6, DW_AT_type(*$C$DW$T$47)

$C$DW$7	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$7, DW_AT_type(*$C$DW$T$32)

	.dwendtag $C$DW$5


$C$DW$8	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$8, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$8, DW_AT_linkage_name("GPIO_setQualificationMode")
	.dwattr $C$DW$8, DW_AT_declaration
	.dwattr $C$DW$8, DW_AT_external
	.dwattr $C$DW$8, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$8, DW_AT_decl_line(0x394)
	.dwattr $C$DW$8, DW_AT_decl_column(0x01)
$C$DW$9	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$9, DW_AT_type(*$C$DW$T$47)

$C$DW$10	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$10, DW_AT_type(*$C$DW$T$34)

	.dwendtag $C$DW$8


$C$DW$11	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$11, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$11, DW_AT_linkage_name("GPIO_setPinConfig")
	.dwattr $C$DW$11, DW_AT_declaration
	.dwattr $C$DW$11, DW_AT_external
	.dwattr $C$DW$11, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$11, DW_AT_decl_line(0x403)
	.dwattr $C$DW$11, DW_AT_decl_column(0x01)
$C$DW$12	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$12, DW_AT_type(*$C$DW$T$47)

	.dwendtag $C$DW$11


$C$DW$13	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$13, DW_AT_name("GPIO_setControllerCore")
	.dwattr $C$DW$13, DW_AT_linkage_name("GPIO_setControllerCore")
	.dwattr $C$DW$13, DW_AT_declaration
	.dwattr $C$DW$13, DW_AT_external
	.dwattr $C$DW$13, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$13, DW_AT_decl_line(0x3d0)
	.dwattr $C$DW$13, DW_AT_decl_column(0x01)
$C$DW$14	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$14, DW_AT_type(*$C$DW$T$47)

$C$DW$15	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$15, DW_AT_type(*$C$DW$T$36)

	.dwendtag $C$DW$13

$C$DW$16	.dwtag  DW_TAG_variable
	.dwattr $C$DW$16, DW_AT_name("RamfuncsLoadStart")
	.dwattr $C$DW$16, DW_AT_linkage_name("RamfuncsLoadStart")
	.dwattr $C$DW$16, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$16, DW_AT_declaration
	.dwattr $C$DW$16, DW_AT_external
	.dwattr $C$DW$16, DW_AT_decl_file("..\device\device.h")
	.dwattr $C$DW$16, DW_AT_decl_line(0xd9)
	.dwattr $C$DW$16, DW_AT_decl_column(0x11)

$C$DW$17	.dwtag  DW_TAG_variable
	.dwattr $C$DW$17, DW_AT_name("RamfuncsLoadSize")
	.dwattr $C$DW$17, DW_AT_linkage_name("RamfuncsLoadSize")
	.dwattr $C$DW$17, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$17, DW_AT_declaration
	.dwattr $C$DW$17, DW_AT_external
	.dwattr $C$DW$17, DW_AT_decl_file("..\device\device.h")
	.dwattr $C$DW$17, DW_AT_decl_line(0xdb)
	.dwattr $C$DW$17, DW_AT_decl_column(0x11)

$C$DW$18	.dwtag  DW_TAG_variable
	.dwattr $C$DW$18, DW_AT_name("RamfuncsRunStart")
	.dwattr $C$DW$18, DW_AT_linkage_name("RamfuncsRunStart")
	.dwattr $C$DW$18, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$18, DW_AT_declaration
	.dwattr $C$DW$18, DW_AT_external
	.dwattr $C$DW$18, DW_AT_decl_file("..\device\device.h")
	.dwattr $C$DW$18, DW_AT_decl_line(0xdc)
	.dwattr $C$DW$18, DW_AT_decl_column(0x11)

$C$DW$19	.dwtag  DW_TAG_variable
	.dwattr $C$DW$19, DW_AT_name("isrcodefuncsRunStart")
	.dwattr $C$DW$19, DW_AT_linkage_name("isrcodefuncsRunStart")
	.dwattr $C$DW$19, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$19, DW_AT_declaration
	.dwattr $C$DW$19, DW_AT_external
	.dwattr $C$DW$19, DW_AT_decl_file("..\device\device.h")
	.dwattr $C$DW$19, DW_AT_decl_line(0xe0)
	.dwattr $C$DW$19, DW_AT_decl_column(0x11)

$C$DW$20	.dwtag  DW_TAG_variable
	.dwattr $C$DW$20, DW_AT_name("isrcodefuncsLoadStart")
	.dwattr $C$DW$20, DW_AT_linkage_name("isrcodefuncsLoadStart")
	.dwattr $C$DW$20, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$20, DW_AT_declaration
	.dwattr $C$DW$20, DW_AT_external
	.dwattr $C$DW$20, DW_AT_decl_file("..\device\device.h")
	.dwattr $C$DW$20, DW_AT_decl_line(0xe1)
	.dwattr $C$DW$20, DW_AT_decl_column(0x11)

$C$DW$21	.dwtag  DW_TAG_variable
	.dwattr $C$DW$21, DW_AT_name("isrcodefuncsLoadSize")
	.dwattr $C$DW$21, DW_AT_linkage_name("isrcodefuncsLoadSize")
	.dwattr $C$DW$21, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$21, DW_AT_declaration
	.dwattr $C$DW$21, DW_AT_external
	.dwattr $C$DW$21, DW_AT_decl_file("..\device\device.h")
	.dwattr $C$DW$21, DW_AT_decl_line(0xe2)
	.dwattr $C$DW$21, DW_AT_decl_column(0x11)

$C$DW$22	.dwtag  DW_TAG_variable
	.dwattr $C$DW$22, DW_AT_name("Cla1ConstRunStart")
	.dwattr $C$DW$22, DW_AT_linkage_name("Cla1ConstRunStart")
	.dwattr $C$DW$22, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$22, DW_AT_declaration
	.dwattr $C$DW$22, DW_AT_external
	.dwattr $C$DW$22, DW_AT_decl_file("..\device\device.h")
	.dwattr $C$DW$22, DW_AT_decl_line(0xe3)
	.dwattr $C$DW$22, DW_AT_decl_column(0x11)

$C$DW$23	.dwtag  DW_TAG_variable
	.dwattr $C$DW$23, DW_AT_name("Cla1ConstLoadStart")
	.dwattr $C$DW$23, DW_AT_linkage_name("Cla1ConstLoadStart")
	.dwattr $C$DW$23, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$23, DW_AT_declaration
	.dwattr $C$DW$23, DW_AT_external
	.dwattr $C$DW$23, DW_AT_decl_file("..\device\device.h")
	.dwattr $C$DW$23, DW_AT_decl_line(0xe4)
	.dwattr $C$DW$23, DW_AT_decl_column(0x11)

$C$DW$24	.dwtag  DW_TAG_variable
	.dwattr $C$DW$24, DW_AT_name("Cla1ConstLoadSize")
	.dwattr $C$DW$24, DW_AT_linkage_name("Cla1ConstLoadSize")
	.dwattr $C$DW$24, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$24, DW_AT_declaration
	.dwattr $C$DW$24, DW_AT_external
	.dwattr $C$DW$24, DW_AT_decl_file("..\device\device.h")
	.dwattr $C$DW$24, DW_AT_decl_line(0xe5)
	.dwattr $C$DW$24, DW_AT_decl_column(0x11)


$C$DW$25	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$25, DW_AT_name("SysCtl_getDeviceParametric")
	.dwattr $C$DW$25, DW_AT_linkage_name("SysCtl_getDeviceParametric")
	.dwattr $C$DW$25, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$25, DW_AT_declaration
	.dwattr $C$DW$25, DW_AT_external
	.dwattr $C$DW$25, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$25, DW_AT_decl_line(0xd8d)
	.dwattr $C$DW$25, DW_AT_decl_column(0x01)
$C$DW$26	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$26, DW_AT_type(*$C$DW$T$28)

	.dwendtag $C$DW$25


$C$DW$27	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$27, DW_AT_name("SysCtl_setClock")
	.dwattr $C$DW$27, DW_AT_linkage_name("SysCtl_setClock")
	.dwattr $C$DW$27, DW_AT_type(*$C$DW$T$78)
	.dwattr $C$DW$27, DW_AT_declaration
	.dwattr $C$DW$27, DW_AT_external
	.dwattr $C$DW$27, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$27, DW_AT_decl_line(0xd2b)
	.dwattr $C$DW$27, DW_AT_decl_column(0x01)
$C$DW$28	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$28, DW_AT_type(*$C$DW$T$47)

	.dwendtag $C$DW$27

	.global	||Example_Result||
	.data
	.align	2
	.elfsym	||Example_Result||,SYM_SIZE(2),SYM_BLOCKED(1)
||Example_Result||:
	.bits		0x1,32
			; Example_Result @ 0

$C$DW$29	.dwtag  DW_TAG_variable
	.dwattr $C$DW$29, DW_AT_name("Example_Result")
	.dwattr $C$DW$29, DW_AT_linkage_name("Example_Result")
	.dwattr $C$DW$29, DW_AT_location[DW_OP_addr ||Example_Result||]
	.dwattr $C$DW$29, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$29, DW_AT_external
	.dwattr $C$DW$29, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$29, DW_AT_decl_line(0x3d)
	.dwattr $C$DW$29, DW_AT_decl_column(0x0a)

	.global	||Example_PassCount||
	.data
	.align	2
	.elfsym	||Example_PassCount||,SYM_SIZE(2),SYM_BLOCKED(1)
||Example_PassCount||:
	.bits		0,32
			; Example_PassCount @ 0

$C$DW$30	.dwtag  DW_TAG_variable
	.dwattr $C$DW$30, DW_AT_name("Example_PassCount")
	.dwattr $C$DW$30, DW_AT_linkage_name("Example_PassCount")
	.dwattr $C$DW$30, DW_AT_location[DW_OP_addr ||Example_PassCount||]
	.dwattr $C$DW$30, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$30, DW_AT_external
	.dwattr $C$DW$30, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$30, DW_AT_decl_line(0x3e)
	.dwattr $C$DW$30, DW_AT_decl_column(0x0a)

	.global	||Example_Fail||
	.data
	.align	2
	.elfsym	||Example_Fail||,SYM_SIZE(2),SYM_BLOCKED(1)
||Example_Fail||:
	.bits		0,32
			; Example_Fail @ 0

$C$DW$31	.dwtag  DW_TAG_variable
	.dwattr $C$DW$31, DW_AT_name("Example_Fail")
	.dwattr $C$DW$31, DW_AT_linkage_name("Example_Fail")
	.dwattr $C$DW$31, DW_AT_location[DW_OP_addr ||Example_Fail||]
	.dwattr $C$DW$31, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$31, DW_AT_external
	.dwattr $C$DW$31, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$31, DW_AT_decl_line(0x3f)
	.dwattr $C$DW$31, DW_AT_decl_column(0x0a)


$C$DW$32	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$32, DW_AT_name("__eallow")
	.dwattr $C$DW$32, DW_AT_linkage_name("__eallow")
	.dwattr $C$DW$32, DW_AT_declaration
	.dwattr $C$DW$32, DW_AT_external
	.dwendtag $C$DW$32


$C$DW$33	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$33, DW_AT_name("__edis")
	.dwattr $C$DW$33, DW_AT_linkage_name("__edis")
	.dwattr $C$DW$33, DW_AT_declaration
	.dwattr $C$DW$33, DW_AT_external
	.dwendtag $C$DW$33

	.sblock	".data"
;	C:\ti\ccs1271\ccs\tools\compiler\ti-cgt-c2000_22.6.1.LTS\bin\opt2000.exe C:\\Users\\lucas\\AppData\\Local\\Temp\\{9E712F12-0B74-4FB1-AA49-62F56C78A385} C:\\Users\\lucas\\AppData\\Local\\Temp\\{2385738B-89DB-422F-B778-AB9356ECD901} 
;	C:\ti\ccs1271\ccs\tools\compiler\ti-cgt-c2000_22.6.1.LTS\bin\acia2000.exe -@C:\\Users\\lucas\\AppData\\Local\\Temp\\{ECA1C235-1C6E-4D7C-A9C4-ADA30F068AAE} 
	.sect	".text"
	.clink
	.global	||__error__||

$C$DW$34	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$34, DW_AT_name("__error__")
	.dwattr $C$DW$34, DW_AT_low_pc(||__error__||)
	.dwattr $C$DW$34, DW_AT_high_pc(0x00)
	.dwattr $C$DW$34, DW_AT_linkage_name("__error__")
	.dwattr $C$DW$34, DW_AT_external
	.dwattr $C$DW$34, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$34, DW_AT_decl_line(0x2ae)
	.dwattr $C$DW$34, DW_AT_decl_column(0x06)
	.dwattr $C$DW$34, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 687,column 1,is_stmt,address ||__error__||,isa 0

	.dwfde $C$DW$CIE, ||__error__||
$C$DW$35	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$35, DW_AT_name("filename")
	.dwattr $C$DW$35, DW_AT_type(*$C$DW$T$61)
	.dwattr $C$DW$35, DW_AT_location[DW_OP_reg12]

$C$DW$36	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$36, DW_AT_name("line")
	.dwattr $C$DW$36, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$36, DW_AT_location[DW_OP_reg0]


;***************************************************************
;* FNAME: __error__                     FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||__error__||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
 ESTOP0
        SPM       #0                    ; [CPU_ALU] 
$C$DW$37	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$37, DW_AT_low_pc(0x00)
	.dwattr $C$DW$37, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$34, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$34, DW_AT_TI_end_line(0x2b5)
	.dwattr $C$DW$34, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$34

	.sect	".text"
	.clink
	.global	||Example_setResultPass||

$C$DW$38	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$38, DW_AT_name("Example_setResultPass")
	.dwattr $C$DW$38, DW_AT_low_pc(||Example_setResultPass||)
	.dwattr $C$DW$38, DW_AT_high_pc(0x00)
	.dwattr $C$DW$38, DW_AT_linkage_name("Example_setResultPass")
	.dwattr $C$DW$38, DW_AT_external
	.dwattr $C$DW$38, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$38, DW_AT_decl_line(0x2b7)
	.dwattr $C$DW$38, DW_AT_decl_column(0x06)
	.dwattr $C$DW$38, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 696,column 1,is_stmt,address ||Example_setResultPass||,isa 0

	.dwfde $C$DW$CIE, ||Example_setResultPass||

;***************************************************************
;* FNAME: Example_setResultPass         FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||Example_setResultPass||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../device/device.c",line 697,column 5,is_stmt,isa 0
        MOVB      ACC,#0                ; [CPU_ALU] |697| 
        MOVW      DP,#||Example_Result|| ; [CPU_ARAU] 
        MOVL      @||Example_Result||,ACC ; [CPU_ALU] |697| 
$C$DW$39	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$39, DW_AT_low_pc(0x00)
	.dwattr $C$DW$39, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$38, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$38, DW_AT_TI_end_line(0x2ba)
	.dwattr $C$DW$38, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$38

	.sect	".text"
	.clink
	.global	||Example_setResultFail||

$C$DW$40	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$40, DW_AT_name("Example_setResultFail")
	.dwattr $C$DW$40, DW_AT_low_pc(||Example_setResultFail||)
	.dwattr $C$DW$40, DW_AT_high_pc(0x00)
	.dwattr $C$DW$40, DW_AT_linkage_name("Example_setResultFail")
	.dwattr $C$DW$40, DW_AT_external
	.dwattr $C$DW$40, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$40, DW_AT_decl_line(0x2bc)
	.dwattr $C$DW$40, DW_AT_decl_column(0x06)
	.dwattr $C$DW$40, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 701,column 1,is_stmt,address ||Example_setResultFail||,isa 0

	.dwfde $C$DW$CIE, ||Example_setResultFail||

;***************************************************************
;* FNAME: Example_setResultFail         FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||Example_setResultFail||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../device/device.c",line 702,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |702| 
        MOVW      DP,#||Example_Result|| ; [CPU_ARAU] 
        MOVL      @||Example_Result||,ACC ; [CPU_ALU] |702| 
$C$DW$41	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$41, DW_AT_low_pc(0x00)
	.dwattr $C$DW$41, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$40, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$40, DW_AT_TI_end_line(0x2bf)
	.dwattr $C$DW$40, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$40

	.sect	".text"
	.clink
	.global	||Example_done||

$C$DW$42	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$42, DW_AT_name("Example_done")
	.dwattr $C$DW$42, DW_AT_low_pc(||Example_done||)
	.dwattr $C$DW$42, DW_AT_high_pc(0x00)
	.dwattr $C$DW$42, DW_AT_linkage_name("Example_done")
	.dwattr $C$DW$42, DW_AT_external
	.dwattr $C$DW$42, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$42, DW_AT_decl_line(0x2c1)
	.dwattr $C$DW$42, DW_AT_decl_column(0x06)
	.dwattr $C$DW$42, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 706,column 1,is_stmt,address ||Example_done||,isa 0

	.dwfde $C$DW$CIE, ||Example_done||

;***************************************************************
;* FNAME: Example_done                  FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||Example_done||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
||$C$L1||:    
	.dwpsn	file "../device/device.c",line 707,column 11,is_stmt,isa 0
        B         ||$C$L1||,UNC         ; [CPU_ALU] |707| 
        ; branch occurs ; [] |707| 
	.dwattr $C$DW$42, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$42, DW_AT_TI_end_line(0x2c4)
	.dwattr $C$DW$42, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$42

	.sect	".text"
	.clink
	.global	||Device_enableUnbondedGPIOPullupsFor176Pin||

$C$DW$43	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$43, DW_AT_name("Device_enableUnbondedGPIOPullupsFor176Pin")
	.dwattr $C$DW$43, DW_AT_low_pc(||Device_enableUnbondedGPIOPullupsFor176Pin||)
	.dwattr $C$DW$43, DW_AT_high_pc(0x00)
	.dwattr $C$DW$43, DW_AT_linkage_name("Device_enableUnbondedGPIOPullupsFor176Pin")
	.dwattr $C$DW$43, DW_AT_external
	.dwattr $C$DW$43, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$43, DW_AT_decl_line(0x120)
	.dwattr $C$DW$43, DW_AT_decl_column(0x06)
	.dwattr $C$DW$43, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 289,column 1,is_stmt,address ||Device_enableUnbondedGPIOPullupsFor176Pin||,isa 0

	.dwfde $C$DW$CIE, ||Device_enableUnbondedGPIOPullupsFor176Pin||

;***************************************************************
;* FNAME: Device_enableUnbondedGPIOPullupsFor176Pin FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||Device_enableUnbondedGPIOPullupsFor176Pin||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../device/device.c",line 290,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |290| 
	.dwpsn	file "../device/device.c",line 291,column 5,is_stmt,isa 0
        MOV       AL,#65535             ; [CPU_ALU] |291| 
        MOV       AH,#32767             ; [CPU_ALU] |291| 
	.dwpsn	file "../device/device.c",line 292,column 5,is_stmt,isa 0
        MOVB      XAR7,#8               ; [CPU_ALU] |292| 
	.dwpsn	file "../device/device.c",line 293,column 5,is_stmt,isa 0
        MOVB      XAR6,#32              ; [CPU_ALU] |293| 
	.dwpsn	file "../device/device.c",line 294,column 5,is_stmt,isa 0
        MOVL      XAR4,#65024           ; [CPU_ARAU] |294| 
	.dwpsn	file "../device/device.c",line 291,column 5,is_stmt,isa 0
        MOV32     *(0:0x7c8c),ACC       ; [CPU_FPU] |291| 
	.dwpsn	file "../device/device.c",line 292,column 5,is_stmt,isa 0
        MOV32     *(0:0x7ccc),XAR7      ; [CPU_FPU] |292| 
	.dwpsn	file "../device/device.c",line 293,column 5,is_stmt,isa 0
        MOV32     *(0:0x7d0c),XAR6      ; [CPU_FPU] |293| 
	.dwpsn	file "../device/device.c",line 294,column 5,is_stmt,isa 0
        MOV32     *(0:0x7d4c),XAR4      ; [CPU_FPU] |294| 
	.dwpsn	file "../device/device.c",line 295,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |295| 
$C$DW$44	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$44, DW_AT_low_pc(0x00)
	.dwattr $C$DW$44, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$43, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$43, DW_AT_TI_end_line(0x128)
	.dwattr $C$DW$43, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$43

	.sect	".text"
	.clink
	.global	||Device_enableUnbondedGPIOPullupsFor100Pin||

$C$DW$45	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$45, DW_AT_name("Device_enableUnbondedGPIOPullupsFor100Pin")
	.dwattr $C$DW$45, DW_AT_low_pc(||Device_enableUnbondedGPIOPullupsFor100Pin||)
	.dwattr $C$DW$45, DW_AT_high_pc(0x00)
	.dwattr $C$DW$45, DW_AT_linkage_name("Device_enableUnbondedGPIOPullupsFor100Pin")
	.dwattr $C$DW$45, DW_AT_external
	.dwattr $C$DW$45, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$45, DW_AT_decl_line(0x13c)
	.dwattr $C$DW$45, DW_AT_decl_column(0x06)
	.dwattr $C$DW$45, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 317,column 1,is_stmt,address ||Device_enableUnbondedGPIOPullupsFor100Pin||,isa 0

	.dwfde $C$DW$CIE, ||Device_enableUnbondedGPIOPullupsFor100Pin||

;***************************************************************
;* FNAME: Device_enableUnbondedGPIOPullupsFor100Pin FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||Device_enableUnbondedGPIOPullupsFor100Pin||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../device/device.c",line 318,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |318| 
	.dwpsn	file "../device/device.c",line 319,column 5,is_stmt,isa 0
        MOVL      XAR4,#4193308         ; [CPU_ARAU] |319| 
	.dwpsn	file "../device/device.c",line 320,column 5,is_stmt,isa 0
        MOV       AL,#3584              ; [CPU_ALU] |320| 
        MOV       AH,#64512             ; [CPU_ALU] |320| 
	.dwpsn	file "../device/device.c",line 319,column 5,is_stmt,isa 0
        MOV32     *(0:0x7c0c),XAR4      ; [CPU_FPU] |319| 
	.dwpsn	file "../device/device.c",line 322,column 5,is_stmt,isa 0
        MOVB      XAR6,#8               ; [CPU_ALU] |322| 
	.dwpsn	file "../device/device.c",line 323,column 5,is_stmt,isa 0
        MOVB      XAR7,#0               ; [CPU_ALU] |323| 
	.dwpsn	file "../device/device.c",line 320,column 5,is_stmt,isa 0
        MOV32     *(0:0x7c4c),ACC       ; [CPU_FPU] |320| 
	.dwpsn	file "../device/device.c",line 321,column 5,is_stmt,isa 0
        MOV       AL,#17383             ; [CPU_ALU] |321| 
        MOV       AH,#7920              ; [CPU_ALU] |321| 
	.dwpsn	file "../device/device.c",line 324,column 5,is_stmt,isa 0
        MOVL      XAR4,#65024           ; [CPU_ARAU] |324| 
	.dwpsn	file "../device/device.c",line 321,column 5,is_stmt,isa 0
        MOV32     *(0:0x7c8c),ACC       ; [CPU_FPU] |321| 
	.dwpsn	file "../device/device.c",line 322,column 5,is_stmt,isa 0
        MOV32     *(0:0x7ccc),XAR6      ; [CPU_FPU] |322| 
	.dwpsn	file "../device/device.c",line 323,column 5,is_stmt,isa 0
        MOV32     *(0:0x7d0c),XAR7      ; [CPU_FPU] |323| 
	.dwpsn	file "../device/device.c",line 324,column 5,is_stmt,isa 0
        MOV32     *(0:0x7d4c),XAR4      ; [CPU_FPU] |324| 
	.dwpsn	file "../device/device.c",line 325,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |325| 
$C$DW$46	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$46, DW_AT_low_pc(0x00)
	.dwattr $C$DW$46, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$45, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$45, DW_AT_TI_end_line(0x146)
	.dwattr $C$DW$45, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$45

	.sect	".text"
	.clink
	.global	||Device_enableUnbondedGPIOPullups||

$C$DW$47	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$47, DW_AT_name("Device_enableUnbondedGPIOPullups")
	.dwattr $C$DW$47, DW_AT_low_pc(||Device_enableUnbondedGPIOPullups||)
	.dwattr $C$DW$47, DW_AT_high_pc(0x00)
	.dwattr $C$DW$47, DW_AT_linkage_name("Device_enableUnbondedGPIOPullups")
	.dwattr $C$DW$47, DW_AT_external
	.dwattr $C$DW$47, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$47, DW_AT_decl_line(0x14e)
	.dwattr $C$DW$47, DW_AT_decl_column(0x06)
	.dwattr $C$DW$47, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 335,column 1,is_stmt,address ||Device_enableUnbondedGPIOPullups||,isa 0

	.dwfde $C$DW$CIE, ||Device_enableUnbondedGPIOPullups||

;***************************************************************
;* FNAME: Device_enableUnbondedGPIOPullups FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||Device_enableUnbondedGPIOPullups||:
;* AL    assigned to pinCount
$C$DW$48	.dwtag  DW_TAG_variable
	.dwattr $C$DW$48, DW_AT_name("pinCount")
	.dwattr $C$DW$48, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$48, DW_AT_location[DW_OP_reg0]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../device/device.c",line 339,column 23,is_stmt,isa 0
        MOVL      XAR4,#380936          ; [CPU_ARAU] |339| 
        CLRC      SXM                   ; [CPU_ALU] 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |339| 
        SFR       ACC,8                 ; [CPU_ALU] |339| 
        ANDB      AL,#0x07              ; [CPU_ALU] |339| 
        CMPB      AL,#5                 ; [CPU_ALU] |339| 
        B         ||$C$L2||,EQ          ; [CPU_ALU] |339| 
        ; branchcc occurs ; [] |339| 
	.dwpsn	file "../device/device.c",line 352,column 10,is_stmt,isa 0
        CMPB      AL,#6                 ; [CPU_ALU] |352| 
        B         ||$C$L3||,NEQ         ; [CPU_ALU] |352| 
        ; branchcc occurs ; [] |352| 
	.dwcfi	remember_state
	.dwpsn	file "../device/device.c",line 290,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |290| 
	.dwpsn	file "../device/device.c",line 291,column 5,is_stmt,isa 0
        MOV       AL,#65535             ; [CPU_ALU] |291| 
        MOV       AH,#32767             ; [CPU_ALU] |291| 
	.dwpsn	file "../device/device.c",line 292,column 5,is_stmt,isa 0
        MOVB      XAR7,#8               ; [CPU_ALU] |292| 
	.dwpsn	file "../device/device.c",line 293,column 5,is_stmt,isa 0
        MOVB      XAR6,#32              ; [CPU_ALU] |293| 
	.dwpsn	file "../device/device.c",line 294,column 5,is_stmt,isa 0
        MOVL      XAR4,#65024           ; [CPU_ARAU] |294| 
	.dwpsn	file "../device/device.c",line 291,column 5,is_stmt,isa 0
        MOV32     *(0:0x7c8c),ACC       ; [CPU_FPU] |291| 
	.dwpsn	file "../device/device.c",line 292,column 5,is_stmt,isa 0
        MOV32     *(0:0x7ccc),XAR7      ; [CPU_FPU] |292| 
	.dwpsn	file "../device/device.c",line 293,column 5,is_stmt,isa 0
        MOV32     *(0:0x7d0c),XAR6      ; [CPU_FPU] |293| 
	.dwpsn	file "../device/device.c",line 294,column 5,is_stmt,isa 0
        MOV32     *(0:0x7d4c),XAR4      ; [CPU_FPU] |294| 
	.dwpsn	file "../device/device.c",line 295,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |295| 
$C$DW$49	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$49, DW_AT_low_pc(0x00)
	.dwattr $C$DW$49, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L2||:    
	.dwpsn	file "../device/device.c",line 350,column 9,is_stmt,isa 0
$C$DW$50	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$50, DW_AT_low_pc(0x00)
	.dwattr $C$DW$50, DW_AT_name("Device_enableUnbondedGPIOPullupsFor100Pin")
	.dwattr $C$DW$50, DW_AT_TI_call

        LCR       #||Device_enableUnbondedGPIOPullupsFor100Pin|| ; [CPU_ALU] |350| 
        ; call occurs [#||Device_enableUnbondedGPIOPullupsFor100Pin||] ; [] |350| 
||$C$L3||:    
$C$DW$51	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$51, DW_AT_low_pc(0x00)
	.dwattr $C$DW$51, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$47, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$47, DW_AT_TI_end_line(0x16a)
	.dwattr $C$DW$47, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$47

	.sect	".text"
	.clink
	.global	||Device_initGPIO||

$C$DW$52	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$52, DW_AT_name("Device_initGPIO")
	.dwattr $C$DW$52, DW_AT_low_pc(||Device_initGPIO||)
	.dwattr $C$DW$52, DW_AT_high_pc(0x00)
	.dwattr $C$DW$52, DW_AT_linkage_name("Device_initGPIO")
	.dwattr $C$DW$52, DW_AT_external
	.dwattr $C$DW$52, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$52, DW_AT_decl_line(0x102)
	.dwattr $C$DW$52, DW_AT_decl_column(0x06)
	.dwattr $C$DW$52, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 259,column 1,is_stmt,address ||Device_initGPIO||,isa 0

	.dwfde $C$DW$CIE, ||Device_initGPIO||

;***************************************************************
;* FNAME: Device_initGPIO               FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||Device_initGPIO||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 734,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |734| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 735,column 5,is_stmt,isa 0
        MOV32     ACC,*(0:0x7c3c)       ; [CPU_FPU] |735| 
        MOVB      ACC,#0                ; [CPU_ALU] |735| 
        MOV32     *(0:0x7c3c),ACC       ; [CPU_FPU] |735| 
        MOV32     XAR6,*(0:0x7c7c)      ; [CPU_FPU] |735| 
        MOV32     *(0:0x7c7c),ACC       ; [CPU_FPU] |735| 
        MOV32     XAR6,*(0:0x7cbc)      ; [CPU_FPU] |735| 
        MOV32     *(0:0x7cbc),ACC       ; [CPU_FPU] |735| 
        MOV32     XAR6,*(0:0x7cfc)      ; [CPU_FPU] |735| 
        MOV32     *(0:0x7cfc),ACC       ; [CPU_FPU] |735| 
        MOV32     XAR6,*(0:0x7d3c)      ; [CPU_FPU] |735| 
        MOV32     *(0:0x7d3c),ACC       ; [CPU_FPU] |735| 
        MOV32     XAR6,*(0:0x7d7c)      ; [CPU_FPU] |735| 
        MOV32     *(0:0x7d7c),ACC       ; [CPU_FPU] |735| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 736,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |736| 
	.dwpsn	file "../device/device.c",line 273,column 5,is_stmt,isa 0
$C$DW$53	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$53, DW_AT_low_pc(0x00)
	.dwattr $C$DW$53, DW_AT_name("Device_enableUnbondedGPIOPullups")
	.dwattr $C$DW$53, DW_AT_TI_call

        LCR       #||Device_enableUnbondedGPIOPullups|| ; [CPU_ALU] |273| 
        ; call occurs [#||Device_enableUnbondedGPIOPullups||] ; [] |273| 
$C$DW$54	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$54, DW_AT_low_pc(0x00)
	.dwattr $C$DW$54, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$52, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$52, DW_AT_TI_end_line(0x112)
	.dwattr $C$DW$52, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$52

	.sect	".text"
	.clink
	.global	||Device_configureTMXAnalogTrim||

$C$DW$55	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$55, DW_AT_name("Device_configureTMXAnalogTrim")
	.dwattr $C$DW$55, DW_AT_low_pc(||Device_configureTMXAnalogTrim||)
	.dwattr $C$DW$55, DW_AT_high_pc(0x00)
	.dwattr $C$DW$55, DW_AT_linkage_name("Device_configureTMXAnalogTrim")
	.dwattr $C$DW$55, DW_AT_external
	.dwattr $C$DW$55, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$55, DW_AT_decl_line(0x172)
	.dwattr $C$DW$55, DW_AT_decl_column(0x06)
	.dwattr $C$DW$55, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 371,column 1,is_stmt,address ||Device_configureTMXAnalogTrim||,isa 0

	.dwfde $C$DW$CIE, ||Device_configureTMXAnalogTrim||

;***************************************************************
;* FNAME: Device_configureTMXAnalogTrim FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||Device_configureTMXAnalogTrim||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 988,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |988| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 993,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381756          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
	.dwpsn	file "../device/device.c",line 384,column 5,is_stmt,isa 0
        MOVL      XAR7,#381366          ; [CPU_ARAU] |384| 
	.dwpsn	file "../device/device.c",line 385,column 5,is_stmt,isa 0
        MOVL      XAR6,#381368          ; [CPU_ARAU] |385| 
	.dwpsn	file "../device/device.c",line 386,column 5,is_stmt,isa 0
        MOVL      XAR5,#381370          ; [CPU_ARAU] |386| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 993,column 5,is_stmt,isa 0
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#2                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#4                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#8                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
	.dwpsn	file "../device/device.c",line 384,column 5,is_stmt,isa 0
        MOV       *+XAR7[0],#31709      ; [CPU_ALU] |384| 
	.dwpsn	file "../device/device.c",line 387,column 5,is_stmt,isa 0
        MOVL      XAR4,#381372          ; [CPU_ARAU] |387| 
	.dwpsn	file "../device/device.c",line 385,column 5,is_stmt,isa 0
        MOV       *+XAR6[0],#31709      ; [CPU_ALU] |385| 
	.dwpsn	file "../device/device.c",line 386,column 5,is_stmt,isa 0
        MOV       *+XAR5[0],#31709      ; [CPU_ALU] |386| 
	.dwpsn	file "../device/device.c",line 387,column 5,is_stmt,isa 0
        MOV       *+XAR4[0],#31709      ; [CPU_ALU] |387| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1028,column 5,is_stmt,isa 0
        MOVL      XAR4,#381756          ; [CPU_ARAU] |1028| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |1028| 
        AND       AL,#65534             ; [CPU_ALU] |1028| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |1028| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |1028| 
        AND       AL,#65533             ; [CPU_ALU] |1028| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |1028| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |1028| 
        AND       AL,#65531             ; [CPU_ALU] |1028| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |1028| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |1028| 
        AND       AL,#65527             ; [CPU_ALU] |1028| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |1028| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1029,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |1029| 
$C$DW$56	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$56, DW_AT_low_pc(0x00)
	.dwattr $C$DW$56, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$55, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$55, DW_AT_TI_end_line(0x1a9)
	.dwattr $C$DW$55, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$55

	.sect	".text"
	.clink
	.global	||Device_enableAllPeripherals||

$C$DW$57	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$57, DW_AT_name("Device_enableAllPeripherals")
	.dwattr $C$DW$57, DW_AT_low_pc(||Device_enableAllPeripherals||)
	.dwattr $C$DW$57, DW_AT_high_pc(0x00)
	.dwattr $C$DW$57, DW_AT_linkage_name("Device_enableAllPeripherals")
	.dwattr $C$DW$57, DW_AT_external
	.dwattr $C$DW$57, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$57, DW_AT_decl_line(0xa6)
	.dwattr $C$DW$57, DW_AT_decl_column(0x06)
	.dwattr $C$DW$57, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 167,column 1,is_stmt,address ||Device_enableAllPeripherals||,isa 0

	.dwfde $C$DW$CIE, ||Device_enableAllPeripherals||

;***************************************************************
;* FNAME: Device_enableAllPeripherals   FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||Device_enableAllPeripherals||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 988,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |988| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 993,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381730          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#4                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#8                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#16               ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#32               ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |993| 
        OR        AH,#1                 ; [CPU_ALU] |993| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |993| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |993| 
        OR        AH,#4                 ; [CPU_ALU] |993| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |993| 
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381732          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#2                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381734          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#2                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#4                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#8                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#16               ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#32               ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#64               ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#128              ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |993| 
        OR        AL,#1024              ; [CPU_ALU] |993| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |993| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |993| 
        OR        AL,#2048              ; [CPU_ALU] |993| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |993| 
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381736          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#2                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#4                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#8                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#16               ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#32               ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381738          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#2                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#4                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381742          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#2                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381744          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#2                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#4                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#8                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381746          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#4                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381748          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#2                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381750          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVL      XAR4,#381752          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#2                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |993| 
        OR        AH,#1                 ; [CPU_ALU] |993| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |993| 
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381754          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVL      XAR4,#381756          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#2                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#4                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#8                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381758          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#2                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#4                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#8                ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#16               ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#32               ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#64               ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVB      ACC,#128              ; [CPU_ALU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
        MOVL      XAR4,#381762          ; [CPU_ARAU] |993| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |993| 
        OR        AH,#1                 ; [CPU_ALU] |993| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |993| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |993| 
        OR        AH,#2                 ; [CPU_ALU] |993| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |993| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |993| 
        OR        AH,#4                 ; [CPU_ALU] |993| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |993| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 994,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |994| 
$C$DW$58	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$58, DW_AT_low_pc(0x00)
	.dwattr $C$DW$58, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$57, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$57, DW_AT_TI_end_line(0xfb)
	.dwattr $C$DW$57, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$57

	.sect	".text"
	.clink
	.global	||Device_init||

$C$DW$59	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$59, DW_AT_name("Device_init")
	.dwattr $C$DW$59, DW_AT_low_pc(||Device_init||)
	.dwattr $C$DW$59, DW_AT_high_pc(0x00)
	.dwattr $C$DW$59, DW_AT_linkage_name("Device_init")
	.dwattr $C$DW$59, DW_AT_external
	.dwattr $C$DW$59, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$59, DW_AT_decl_line(0x48)
	.dwattr $C$DW$59, DW_AT_decl_column(0x06)
	.dwattr $C$DW$59, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../device/device.c",line 73,column 1,is_stmt,address ||Device_init||,isa 0

	.dwfde $C$DW$CIE, ||Device_init||

;***************************************************************
;* FNAME: Device_init                   FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||Device_init||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1946,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |1946| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1951,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7029)        ; [CPU_ALU] |1951| 
        ORB       AL,#0x68              ; [CPU_ALU] |1951| 
        MOV       *(0:0x7029),AL        ; [CPU_ALU] |1951| 
 RPT #69 || NOP
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1954,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |1954| 
	.dwpsn	file "../device/device.c",line 92,column 5,is_stmt,isa 0
        MOVL      XAR5,#||RamfuncsLoadStart|| ; [CPU_ARAU] |92| 
        MOV       AH,#$HI16(||RamfuncsLoadSize||) + 0 ; [CPU_ALU] |92| 
        MOVL      XAR4,#||RamfuncsRunStart|| ; [CPU_ARAU] |92| 
        SPM       #0                    ; [CPU_ALU] 
        MOV       AL,#$LO16(||RamfuncsLoadSize||) + 0 ; [CPU_ALU] |92| 
$C$DW$60	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$60, DW_AT_low_pc(0x00)
	.dwattr $C$DW$60, DW_AT_name("memcpy")
	.dwattr $C$DW$60, DW_AT_TI_call

        LCR       #||memcpy||           ; [CPU_ALU] |92| 
        ; call occurs [#||memcpy||] ; [] |92| 
	.dwpsn	file "../device/device.c",line 93,column 5,is_stmt,isa 0
        MOV       AL,#$LO16(||isrcodefuncsLoadSize||) + 0 ; [CPU_ALU] |93| 
        MOV       AH,#$HI16(||isrcodefuncsLoadSize||) + 0 ; [CPU_ALU] |93| 
        MOVL      XAR5,#||isrcodefuncsLoadStart|| ; [CPU_ARAU] |93| 
        MOVL      XAR4,#||isrcodefuncsRunStart|| ; [CPU_ARAU] |93| 
$C$DW$61	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$61, DW_AT_low_pc(0x00)
	.dwattr $C$DW$61, DW_AT_name("memcpy")
	.dwattr $C$DW$61, DW_AT_TI_call

        LCR       #||memcpy||           ; [CPU_ALU] |93| 
        ; call occurs [#||memcpy||] ; [] |93| 
	.dwpsn	file "../device/device.c",line 94,column 5,is_stmt,isa 0
        MOV       AL,#$LO16(||Cla1ConstLoadSize||) + 0 ; [CPU_ALU] |94| 
        MOV       AH,#$HI16(||Cla1ConstLoadSize||) + 0 ; [CPU_ALU] |94| 
        MOVL      XAR5,#||Cla1ConstLoadStart|| ; [CPU_ARAU] |94| 
        MOVL      XAR4,#||Cla1ConstRunStart|| ; [CPU_ARAU] |94| 
$C$DW$62	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$62, DW_AT_low_pc(0x00)
	.dwattr $C$DW$62, DW_AT_name("memcpy")
	.dwattr $C$DW$62, DW_AT_TI_call

        LCR       #||memcpy||           ; [CPU_ALU] |94| 
        ; call occurs [#||memcpy||] ; [] |94| 
	.dwpsn	file "../device/device.c",line 101,column 5,is_stmt,isa 0
        MOVL      XAR4,#391936          ; [CPU_ARAU] |101| 
        MOVL      XAR5,#391168          ; [CPU_ARAU] |101| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |101| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |101| 
        MOVB      XAR4,#3               ; [CPU_ALU] |101| 
$C$DW$63	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$63, DW_AT_low_pc(0x00)
	.dwattr $C$DW$63, DW_AT_name("Flash_initModule")
	.dwattr $C$DW$63, DW_AT_TI_call

        LCR       #||Flash_initModule|| ; [CPU_ALU] |101| 
        ; call occurs [#||Flash_initModule||] ; [] |101| 
	.dwpsn	file "../device/device.c",line 108,column 5,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |108| 
$C$DW$64	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$64, DW_AT_low_pc(0x00)
	.dwattr $C$DW$64, DW_AT_name("SysCtl_getDeviceParametric")
	.dwattr $C$DW$64, DW_AT_TI_call

        LCR       #||SysCtl_getDeviceParametric|| ; [CPU_ALU] |108| 
        ; call occurs [#||SysCtl_getDeviceParametric||] ; [] |108| 
        CMPB      AL,#0                 ; [CPU_ALU] |108| 
        B         ||$C$L4||,NEQ         ; [CPU_ALU] |108| 
        ; branchcc occurs ; [] |108| 
        MOVL      XAR4,#381366          ; [CPU_ARAU] |108| 
        MOV       AL,*+XAR4[0]          ; [CPU_ALU] |108| 
        B         ||$C$L4||,NEQ         ; [CPU_ALU] |108| 
        ; branchcc occurs ; [] |108| 
	.dwpsn	file "../device/device.c",line 111,column 9,is_stmt,isa 0
$C$DW$65	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$65, DW_AT_low_pc(0x00)
	.dwattr $C$DW$65, DW_AT_name("Device_configureTMXAnalogTrim")
	.dwattr $C$DW$65, DW_AT_TI_call

        LCR       #||Device_configureTMXAnalogTrim|| ; [CPU_ALU] |111| 
        ; call occurs [#||Device_configureTMXAnalogTrim||] ; [] |111| 
||$C$L4||:    
	.dwpsn	file "../device/device.c",line 117,column 5,is_stmt,isa 0
        MOV       AL,#144               ; [CPU_ALU] |117| 
        MOV       AH,#32769             ; [CPU_ALU] |117| 
$C$DW$66	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$66, DW_AT_low_pc(0x00)
	.dwattr $C$DW$66, DW_AT_name("SysCtl_setClock")
	.dwattr $C$DW$66, DW_AT_TI_call

        LCR       #||SysCtl_setClock||  ; [CPU_ALU] |117| 
        ; call occurs [#||SysCtl_setClock||] ; [] |117| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1181,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |1181| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1182,column 5,is_stmt,isa 0
        MOVL      XAR4,#381484          ; [CPU_ARAU] |1182| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |1182| 
        AND       AL,#65528             ; [CPU_ALU] |1182| 
        ORB       AL,#0x02              ; [CPU_ALU] |1182| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |1182| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1185,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |1185| 
	.dwpsn	file "../device/device.c",line 150,column 5,is_stmt,isa 0
$C$DW$67	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$67, DW_AT_low_pc(0x00)
	.dwattr $C$DW$67, DW_AT_name("Device_enableAllPeripherals")
	.dwattr $C$DW$67, DW_AT_TI_call

        LCR       #||Device_enableAllPeripherals|| ; [CPU_ALU] |150| 
        ; call occurs [#||Device_enableAllPeripherals||] ; [] |150| 
        MOVW      DP,#||Example_Result|| ; [CPU_ARAU] 
	.dwpsn	file "../device/device.c",line 155,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |155| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOVL      @||Example_Result||,ACC ; [CPU_ALU] |155| 
$C$DW$68	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$68, DW_AT_low_pc(0x00)
	.dwattr $C$DW$68, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$59, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$59, DW_AT_TI_end_line(0x9c)
	.dwattr $C$DW$59, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$59

	.sect	".text"
	.clink
	.global	||Device_bootCPU2||

$C$DW$69	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$69, DW_AT_name("Device_bootCPU2")
	.dwattr $C$DW$69, DW_AT_low_pc(||Device_bootCPU2||)
	.dwattr $C$DW$69, DW_AT_high_pc(0x00)
	.dwattr $C$DW$69, DW_AT_linkage_name("Device_bootCPU2")
	.dwattr $C$DW$69, DW_AT_external
	.dwattr $C$DW$69, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$69, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$69, DW_AT_decl_line(0x1c6)
	.dwattr $C$DW$69, DW_AT_decl_column(0x01)
	.dwattr $C$DW$69, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "../device/device.c",line 455,column 1,is_stmt,address ||Device_bootCPU2||,isa 0

	.dwfde $C$DW$CIE, ||Device_bootCPU2||
$C$DW$70	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$70, DW_AT_name("bootMode")
	.dwattr $C$DW$70, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$70, DW_AT_location[DW_OP_reg0]


;***************************************************************
;* FNAME: Device_bootCPU2               FR SIZE:   4           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  4 SOE     *
;***************************************************************

||Device_bootCPU2||:
;* AR2   assigned to bootMode
$C$DW$71	.dwtag  DW_TAG_variable
	.dwattr $C$DW$71, DW_AT_name("bootMode")
	.dwattr $C$DW$71, DW_AT_type(*$C$DW$T$77)
	.dwattr $C$DW$71, DW_AT_location[DW_OP_reg8]

;* AR1   assigned to pin
$C$DW$72	.dwtag  DW_TAG_variable
	.dwattr $C$DW$72, DW_AT_name("pin")
	.dwattr $C$DW$72, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$72, DW_AT_location[DW_OP_reg6]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../device/device.c",line 464,column 5,is_stmt,isa 0
        MOVL      XAR4,#327712          ; [CPU_ARAU] |464| 
        MOVB      XAR6,#3               ; [CPU_ALU] |464| 
        MOVL      *SP++,XAR2            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 9, 4
	.dwcfi	cfa_offset, -6
	.dwpsn	file "../device/device.c",line 455,column 1,is_stmt,isa 0
        MOVL      XAR2,ACC              ; [CPU_ALU] |455| 
	.dwpsn	file "../device/device.c",line 464,column 5,is_stmt,isa 0
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |464| 
        MOVB      AH,#0                 ; [CPU_ALU] |464| 
        ANDB      AL,#0x0f              ; [CPU_ALU] |464| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |464| 
        B         ||$C$L5||,NEQ         ; [CPU_ALU] |464| 
        ; branchcc occurs ; [] |464| 
	.dwpsn	file "../device/device.c",line 471,column 9,is_stmt,isa 0
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |471| 
        ANDB      AL,#0                 ; [CPU_ALU] |471| 
        AND       AH,#32768             ; [CPU_ALU] |471| 
        TEST      ACC                   ; [CPU_ALU] |471| 
        B         ||$C$L8||,NEQ         ; [CPU_ALU] |471| 
        ; branchcc occurs ; [] |471| 
||$C$L5||:    
	.dwpsn	file "../device/device.c",line 488,column 9,is_stmt,isa 0
        TBIT      *+XAR4[0],#1          ; [CPU_ALU] |488| 
        B         ||$C$L5||,NTC         ; [CPU_ALU] |488| 
        ; branchcc occurs ; [] |488| 
	.dwpsn	file "../device/device.c",line 495,column 12,is_stmt,isa 0
        MOVL      XAR4,#327688          ; [CPU_ARAU] |495| 
||$C$L6||:    
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |495| 
        TBIT      AL,#0                 ; [CPU_ALU] |495| 
        B         ||$C$L7||,NTC         ; [CPU_ALU] |495| 
        ; branchcc occurs ; [] |495| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |495| 
        TBIT      AL,#0                 ; [CPU_ALU] |495| 
        B         ||$C$L6||,TC          ; [CPU_ALU] |495| 
        ; branchcc occurs ; [] |495| 
||$C$L7||:    
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |495| 
        ANDB      AL,#0                 ; [CPU_ALU] |495| 
        AND       AH,#32768             ; [CPU_ALU] |495| 
        TEST      ACC                   ; [CPU_ALU] |495| 
        B         ||$C$L6||,NEQ         ; [CPU_ALU] |495| 
        ; branchcc occurs ; [] |495| 
	.dwpsn	file "../device/device.c",line 501,column 5,is_stmt,isa 0
        MOVB      ACC,#12               ; [CPU_ALU] |501| 
        CMPL      ACC,XAR2              ; [CPU_ALU] |501| 
        B         ||$C$L9||,HI          ; [CPU_ALU] |501| 
        ; branchcc occurs ; [] |501| 
||$C$L8||:    
	.dwpsn	file "../device/device.c",line 678,column 5,is_stmt,isa 0
        MOVB      XAR7,#1               ; [CPU_ALU] |678| 
        B         ||$C$L18||,UNC        ; [CPU_ALU] |678| 
        ; branch occurs ; [] |678| 
||$C$L9||:    
	.dwpsn	file "../device/device.c",line 511,column 9,is_stmt,isa 0
        MOVL      XAR6,XAR2             ; [CPU_ALU] |511| 
        MOVB      ACC,#4                ; [CPU_ALU] |511| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |511| 
        B         ||$C$L10||,LT         ; [CPU_ALU] |511| 
        ; branchcc occurs ; [] |511| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |511| 
        B         ||$C$L12||,EQ         ; [CPU_ALU] |511| 
        ; branchcc occurs ; [] |511| 
        MOVL      ACC,XAR6              ; [CPU_ALU] 
        B         ||$C$L14||,EQ         ; [CPU_ALU] |511| 
        ; branchcc occurs ; [] |511| 
        MOVB      ACC,#1                ; [CPU_ALU] |511| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |511| 
        B         ||$C$L13||,EQ         ; [CPU_ALU] |511| 
        ; branchcc occurs ; [] |511| 
        B         ||$C$L17||,UNC        ; [CPU_ALU] |511| 
        ; branch occurs ; [] |511| 
||$C$L10||:    
        MOVB      ACC,#5                ; [CPU_ALU] |511| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |511| 
        B         ||$C$L11||,EQ         ; [CPU_ALU] |511| 
        ; branchcc occurs ; [] |511| 
        MOVB      ACC,#7                ; [CPU_ALU] |511| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |511| 
        B         ||$C$L17||,NEQ        ; [CPU_ALU] |511| 
        ; branchcc occurs ; [] |511| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 734,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |734| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 735,column 5,is_stmt,isa 0
        MOV32     ACC,*(0:0x7cbc)       ; [CPU_FPU] |735| 
        MOVB      ACC,#0                ; [CPU_ALU] |735| 
        MOV32     *(0:0x7cbc),ACC       ; [CPU_FPU] |735| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 736,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |736| 
	.dwpsn	file "../device/device.c",line 638,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |638| 
        MOVB      ACC,#71               ; [CPU_ALU] |638| 
$C$DW$73	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$73, DW_AT_low_pc(0x00)
	.dwattr $C$DW$73, DW_AT_name("GPIO_setControllerCore")
	.dwattr $C$DW$73, DW_AT_TI_call

        LCR       #||GPIO_setControllerCore|| ; [CPU_ALU] |638| 
        ; call occurs [#||GPIO_setControllerCore||] ; [] |638| 
	.dwpsn	file "../device/device.c",line 639,column 18,is_stmt,isa 0
        MOV       AL,#3589              ; [CPU_ALU] |639| 
        MOV       AH,#134               ; [CPU_ALU] |639| 
$C$DW$74	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$74, DW_AT_low_pc(0x00)
	.dwattr $C$DW$74, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$74, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |639| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |639| 
	.dwpsn	file "../device/device.c",line 640,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |640| 
        MOVB      ACC,#71               ; [CPU_ALU] |640| 
$C$DW$75	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$75, DW_AT_low_pc(0x00)
	.dwattr $C$DW$75, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$75, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |640| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |640| 
	.dwpsn	file "../device/device.c",line 642,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |642| 
        MOVB      ACC,#70               ; [CPU_ALU] |642| 
$C$DW$76	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$76, DW_AT_low_pc(0x00)
	.dwattr $C$DW$76, DW_AT_name("GPIO_setControllerCore")
	.dwattr $C$DW$76, DW_AT_TI_call

        LCR       #||GPIO_setControllerCore|| ; [CPU_ALU] |642| 
        ; call occurs [#||GPIO_setControllerCore||] ; [] |642| 
	.dwpsn	file "../device/device.c",line 643,column 18,is_stmt,isa 0
        MOV       AL,#3077              ; [CPU_ALU] |643| 
        MOV       AH,#134               ; [CPU_ALU] |643| 
$C$DW$77	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$77, DW_AT_low_pc(0x00)
	.dwattr $C$DW$77, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$77, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |643| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |643| 
	.dwpsn	file "../device/device.c",line 644,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |644| 
        MOVB      ACC,#70               ; [CPU_ALU] |644| 
$C$DW$78	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$78, DW_AT_low_pc(0x00)
	.dwattr $C$DW$78, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$78, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |644| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |644| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 699,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |699| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 700,column 5,is_stmt,isa 0
        MOV32     ACC,*(0:0x7cbc)       ; [CPU_FPU] |700| 
	.dwpsn	file "../device/device.c",line 653,column 18,is_stmt,isa 0
        MOVL      XAR4,#381450          ; [CPU_ARAU] |653| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 700,column 5,is_stmt,isa 0
        OR        AL,#65535             ; [CPU_ALU] |700| 
        OR        AH,#65535             ; [CPU_ALU] |700| 
        MOV32     *(0:0x7cbc),ACC       ; [CPU_FPU] |700| 
	.dwpsn	file "../device/device.c",line 653,column 18,is_stmt,isa 0
        MOVB      ACC,#12               ; [CPU_ALU] |653| 
        AND       *+XAR4[0],AL          ; [CPU_ALU] |653| 
        AND       *+XAR4[1],AH          ; [CPU_ALU] |653| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 993,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |993| 
        MOVL      XAR4,#381750          ; [CPU_ARAU] |993| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |993| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |993| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 994,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |994| 
	.dwpsn	file "../device/device.c",line 658,column 16,is_stmt,isa 0
        B         ||$C$L17||,UNC        ; [CPU_ALU] |658| 
        ; branch occurs ; [] |658| 
||$C$L11||:    
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2999,column 5,is_stmt,isa 0
        MOVL      XAR4,#381156          ; [CPU_ARAU] |2999| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |2999| 
        AND       AL,#65534             ; [CPU_ALU] |2999| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 3003,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_FPU] |3003| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 3004,column 5,is_stmt,isa 0
        ORB       AL,#0x01              ; [CPU_ALU] |3004| 
	.dwpsn	file "../device/device.c",line 593,column 18,is_stmt,isa 0
        MOVL      XAR5,#381440          ; [CPU_ARAU] |593| 
	.dwpsn	file "../device/device.c",line 594,column 18,is_stmt,isa 0
        MOVB      XAR6,#2               ; [CPU_ALU] |594| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 3004,column 5,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |3004| 
	.dwpsn	file "../device/device.c",line 593,column 18,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |593| 
        MOV       AH,#42405             ; [CPU_ALU] |593| 
	.dwpsn	file "../device/device.c",line 594,column 18,is_stmt,isa 0
        MOVL      XAR4,#381484          ; [CPU_ARAU] |594| 
	.dwpsn	file "../device/device.c",line 593,column 18,is_stmt,isa 0
        MOVL      *+XAR5[0],ACC         ; [CPU_ALU] |593| 
	.dwpsn	file "../device/device.c",line 594,column 18,is_stmt,isa 0
        MOVL      *+XAR4[0],XAR6        ; [CPU_ALU] |594| 
	.dwpsn	file "../device/device.c",line 595,column 18,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |595| 
	.dwpsn	file "../device/device.c",line 597,column 18,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |597| 
        MOVB      ACC,#32               ; [CPU_ALU] |597| 
$C$DW$79	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$79, DW_AT_low_pc(0x00)
	.dwattr $C$DW$79, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$79, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |597| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |597| 
	.dwpsn	file "../device/device.c",line 598,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |598| 
        MOVB      ACC,#32               ; [CPU_ALU] |598| 
$C$DW$80	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$80, DW_AT_low_pc(0x00)
	.dwattr $C$DW$80, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$80, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |598| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |598| 
	.dwpsn	file "../device/device.c",line 599,column 18,is_stmt,isa 0
        MOV       AL,#1                 ; [CPU_ALU] |599| 
        MOV       AH,#70                ; [CPU_ALU] |599| 
$C$DW$81	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$81, DW_AT_low_pc(0x00)
	.dwattr $C$DW$81, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$81, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |599| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |599| 
	.dwpsn	file "../device/device.c",line 600,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |600| 
        MOVB      ACC,#32               ; [CPU_ALU] |600| 
$C$DW$82	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$82, DW_AT_low_pc(0x00)
	.dwattr $C$DW$82, DW_AT_name("GPIO_setControllerCore")
	.dwattr $C$DW$82, DW_AT_TI_call

        LCR       #||GPIO_setControllerCore|| ; [CPU_ALU] |600| 
        ; call occurs [#||GPIO_setControllerCore||] ; [] |600| 
	.dwpsn	file "../device/device.c",line 602,column 18,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |602| 
        MOVB      ACC,#33               ; [CPU_ALU] |602| 
$C$DW$83	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$83, DW_AT_low_pc(0x00)
	.dwattr $C$DW$83, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$83, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |602| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |602| 
	.dwpsn	file "../device/device.c",line 603,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |603| 
        MOVB      ACC,#33               ; [CPU_ALU] |603| 
$C$DW$84	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$84, DW_AT_low_pc(0x00)
	.dwattr $C$DW$84, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$84, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |603| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |603| 
	.dwpsn	file "../device/device.c",line 604,column 18,is_stmt,isa 0
        MOV       AL,#513               ; [CPU_ALU] |604| 
        MOV       AH,#70                ; [CPU_ALU] |604| 
$C$DW$85	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$85, DW_AT_low_pc(0x00)
	.dwattr $C$DW$85, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$85, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |604| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |604| 
	.dwpsn	file "../device/device.c",line 605,column 18,is_stmt,isa 0
        MOVB      ACC,#33               ; [CPU_ALU] |605| 
	.dwpsn	file "../device/device.c",line 607,column 17,is_stmt,isa 0
        B         ||$C$L16||,UNC        ; [CPU_ALU] |607| 
        ; branch occurs ; [] |607| 
||$C$L12||:    
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2999,column 5,is_stmt,isa 0
        MOVL      XAR4,#381154          ; [CPU_ARAU] |2999| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |2999| 
        AND       AL,#65534             ; [CPU_ALU] |2999| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 3003,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_FPU] |3003| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 3004,column 5,is_stmt,isa 0
        ORB       AL,#0x01              ; [CPU_ALU] |3004| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |3004| 
	.dwpsn	file "../device/device.c",line 555,column 18,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |555| 
        MOV       AH,#42405             ; [CPU_ALU] |555| 
        MOVL      XAR4,#381440          ; [CPU_ARAU] |555| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |555| 
	.dwpsn	file "../device/device.c",line 556,column 18,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |556| 
	.dwpsn	file "../device/device.c",line 558,column 18,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |558| 
        MOVB      ACC,#16               ; [CPU_ALU] |558| 
$C$DW$86	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$86, DW_AT_low_pc(0x00)
	.dwattr $C$DW$86, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$86, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |558| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |558| 
	.dwpsn	file "../device/device.c",line 559,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |559| 
        MOVB      ACC,#16               ; [CPU_ALU] |559| 
$C$DW$87	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$87, DW_AT_low_pc(0x00)
	.dwattr $C$DW$87, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$87, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |559| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |559| 
	.dwpsn	file "../device/device.c",line 560,column 18,is_stmt,isa 0
        MOVL      XAR4,#524289          ; [CPU_ARAU] |560| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |560| 
$C$DW$88	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$88, DW_AT_low_pc(0x00)
	.dwattr $C$DW$88, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$88, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |560| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |560| 
	.dwpsn	file "../device/device.c",line 561,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |561| 
        MOVB      ACC,#16               ; [CPU_ALU] |561| 
$C$DW$89	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$89, DW_AT_low_pc(0x00)
	.dwattr $C$DW$89, DW_AT_name("GPIO_setControllerCore")
	.dwattr $C$DW$89, DW_AT_TI_call

        LCR       #||GPIO_setControllerCore|| ; [CPU_ALU] |561| 
        ; call occurs [#||GPIO_setControllerCore||] ; [] |561| 
	.dwpsn	file "../device/device.c",line 563,column 18,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |563| 
        MOVB      ACC,#17               ; [CPU_ALU] |563| 
$C$DW$90	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$90, DW_AT_low_pc(0x00)
	.dwattr $C$DW$90, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$90, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |563| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |563| 
	.dwpsn	file "../device/device.c",line 564,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |564| 
        MOVB      ACC,#17               ; [CPU_ALU] |564| 
$C$DW$91	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$91, DW_AT_low_pc(0x00)
	.dwattr $C$DW$91, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$91, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |564| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |564| 
	.dwpsn	file "../device/device.c",line 565,column 18,is_stmt,isa 0
        MOVL      XAR4,#524801          ; [CPU_ARAU] |565| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |565| 
$C$DW$92	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$92, DW_AT_low_pc(0x00)
	.dwattr $C$DW$92, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$92, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |565| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |565| 
	.dwpsn	file "../device/device.c",line 566,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |566| 
        MOVB      ACC,#17               ; [CPU_ALU] |566| 
$C$DW$93	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$93, DW_AT_low_pc(0x00)
	.dwattr $C$DW$93, DW_AT_name("GPIO_setControllerCore")
	.dwattr $C$DW$93, DW_AT_TI_call

        LCR       #||GPIO_setControllerCore|| ; [CPU_ALU] |566| 
        ; call occurs [#||GPIO_setControllerCore||] ; [] |566| 
	.dwpsn	file "../device/device.c",line 568,column 18,is_stmt,isa 0
        MOVB      ACC,#18               ; [CPU_ALU] |568| 
        MOVB      XAR4,#0               ; [CPU_ALU] |568| 
$C$DW$94	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$94, DW_AT_low_pc(0x00)
	.dwattr $C$DW$94, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$94, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |568| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |568| 
	.dwpsn	file "../device/device.c",line 569,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |569| 
        MOVB      ACC,#18               ; [CPU_ALU] |569| 
$C$DW$95	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$95, DW_AT_low_pc(0x00)
	.dwattr $C$DW$95, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$95, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |569| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |569| 
	.dwpsn	file "../device/device.c",line 570,column 18,is_stmt,isa 0
        MOVL      XAR4,#525313          ; [CPU_ARAU] |570| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |570| 
$C$DW$96	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$96, DW_AT_low_pc(0x00)
	.dwattr $C$DW$96, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$96, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |570| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |570| 
	.dwpsn	file "../device/device.c",line 571,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |571| 
        MOVB      ACC,#18               ; [CPU_ALU] |571| 
$C$DW$97	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$97, DW_AT_low_pc(0x00)
	.dwattr $C$DW$97, DW_AT_name("GPIO_setControllerCore")
	.dwattr $C$DW$97, DW_AT_TI_call

        LCR       #||GPIO_setControllerCore|| ; [CPU_ALU] |571| 
        ; call occurs [#||GPIO_setControllerCore||] ; [] |571| 
	.dwpsn	file "../device/device.c",line 573,column 18,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |573| 
        MOVB      ACC,#19               ; [CPU_ALU] |573| 
$C$DW$98	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$98, DW_AT_low_pc(0x00)
	.dwattr $C$DW$98, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$98, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |573| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |573| 
	.dwpsn	file "../device/device.c",line 574,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |574| 
        MOVB      ACC,#19               ; [CPU_ALU] |574| 
$C$DW$99	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$99, DW_AT_low_pc(0x00)
	.dwattr $C$DW$99, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$99, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |574| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |574| 
	.dwpsn	file "../device/device.c",line 575,column 18,is_stmt,isa 0
        MOVL      XAR4,#525824          ; [CPU_ARAU] |575| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |575| 
$C$DW$100	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$100, DW_AT_low_pc(0x00)
	.dwattr $C$DW$100, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$100, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |575| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |575| 
	.dwpsn	file "../device/device.c",line 576,column 18,is_stmt,isa 0
        MOVB      ACC,#19               ; [CPU_ALU] |576| 
	.dwpsn	file "../device/device.c",line 578,column 17,is_stmt,isa 0
        B         ||$C$L16||,UNC        ; [CPU_ALU] |578| 
        ; branch occurs ; [] |578| 
||$C$L13||:    
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2999,column 5,is_stmt,isa 0
        MOVL      XAR4,#381152          ; [CPU_ARAU] |2999| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |2999| 
        AND       AL,#65534             ; [CPU_ALU] |2999| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 3003,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_FPU] |3003| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 3004,column 5,is_stmt,isa 0
        ORB       AL,#0x01              ; [CPU_ALU] |3004| 
	.dwpsn	file "../device/device.c",line 526,column 18,is_stmt,isa 0
        MOVL      XAR5,#381440          ; [CPU_ARAU] |526| 
	.dwpsn	file "../device/device.c",line 527,column 18,is_stmt,isa 0
        MOVB      XAR6,#2               ; [CPU_ALU] |527| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 3004,column 5,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |3004| 
	.dwpsn	file "../device/device.c",line 526,column 18,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |526| 
        MOV       AH,#42405             ; [CPU_ALU] |526| 
	.dwpsn	file "../device/device.c",line 527,column 18,is_stmt,isa 0
        MOVL      XAR4,#381484          ; [CPU_ARAU] |527| 
	.dwpsn	file "../device/device.c",line 526,column 18,is_stmt,isa 0
        MOVL      *+XAR5[0],ACC         ; [CPU_ALU] |526| 
	.dwpsn	file "../device/device.c",line 527,column 18,is_stmt,isa 0
        MOVL      *+XAR4[0],XAR6        ; [CPU_ALU] |527| 
	.dwpsn	file "../device/device.c",line 528,column 18,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |528| 
	.dwpsn	file "../device/device.c",line 530,column 18,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |530| 
        MOVB      ACC,#29               ; [CPU_ALU] |530| 
$C$DW$101	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$101, DW_AT_low_pc(0x00)
	.dwattr $C$DW$101, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$101, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |530| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |530| 
	.dwpsn	file "../device/device.c",line 531,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |531| 
        MOVB      ACC,#29               ; [CPU_ALU] |531| 
$C$DW$102	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$102, DW_AT_low_pc(0x00)
	.dwattr $C$DW$102, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$102, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |531| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |531| 
	.dwpsn	file "../device/device.c",line 532,column 18,is_stmt,isa 0
        MOVL      XAR4,#530945          ; [CPU_ARAU] |532| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |532| 
$C$DW$103	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$103, DW_AT_low_pc(0x00)
	.dwattr $C$DW$103, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$103, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |532| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |532| 
	.dwpsn	file "../device/device.c",line 533,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |533| 
        MOVB      ACC,#29               ; [CPU_ALU] |533| 
$C$DW$104	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$104, DW_AT_low_pc(0x00)
	.dwattr $C$DW$104, DW_AT_name("GPIO_setControllerCore")
	.dwattr $C$DW$104, DW_AT_TI_call

        LCR       #||GPIO_setControllerCore|| ; [CPU_ALU] |533| 
        ; call occurs [#||GPIO_setControllerCore||] ; [] |533| 
	.dwpsn	file "../device/device.c",line 535,column 18,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |535| 
        MOVB      ACC,#28               ; [CPU_ALU] |535| 
$C$DW$105	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$105, DW_AT_low_pc(0x00)
	.dwattr $C$DW$105, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$105, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |535| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |535| 
	.dwpsn	file "../device/device.c",line 536,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |536| 
        MOVB      ACC,#28               ; [CPU_ALU] |536| 
$C$DW$106	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$106, DW_AT_low_pc(0x00)
	.dwattr $C$DW$106, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$106, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |536| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |536| 
	.dwpsn	file "../device/device.c",line 537,column 18,is_stmt,isa 0
        MOVL      XAR4,#530433          ; [CPU_ARAU] |537| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |537| 
$C$DW$107	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$107, DW_AT_low_pc(0x00)
	.dwattr $C$DW$107, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$107, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |537| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |537| 
	.dwpsn	file "../device/device.c",line 538,column 18,is_stmt,isa 0
        MOVB      ACC,#28               ; [CPU_ALU] |538| 
	.dwpsn	file "../device/device.c",line 540,column 17,is_stmt,isa 0
        B         ||$C$L16||,UNC        ; [CPU_ALU] |540| 
        ; branch occurs ; [] |540| 
||$C$L14||:    
	.dwpsn	file "../device/device.c",line 611,column 22,is_stmt,isa 0
        MOVB      XAR1,#58              ; [CPU_ALU] |611| 
||$C$L15||:    
	.dwpsn	file "../device/device.c",line 613,column 22,is_stmt,isa 0
        MOVU      ACC,AR1               ; [CPU_ALU] |613| 
        MOVB      XAR4,#0               ; [CPU_ALU] |613| 
$C$DW$108	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$108, DW_AT_low_pc(0x00)
	.dwattr $C$DW$108, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$108, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |613| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |613| 
	.dwpsn	file "../device/device.c",line 614,column 22,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |614| 
        MOVU      ACC,AR1               ; [CPU_ALU] |614| 
$C$DW$109	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$109, DW_AT_low_pc(0x00)
	.dwattr $C$DW$109, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$109, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |614| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |614| 
	.dwpsn	file "../device/device.c",line 615,column 22,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |615| 
        MOVU      ACC,AR1               ; [CPU_ALU] |615| 
$C$DW$110	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$110, DW_AT_low_pc(0x00)
	.dwattr $C$DW$110, DW_AT_name("GPIO_setControllerCore")
	.dwattr $C$DW$110, DW_AT_TI_call

        LCR       #||GPIO_setControllerCore|| ; [CPU_ALU] |615| 
        ; call occurs [#||GPIO_setControllerCore||] ; [] |615| 
	.dwpsn	file "../device/device.c",line 611,column 29,is_stmt,isa 0
        ADDB      XAR1,#1               ; [CPU_ALU] |611| 
        MOV       AL,AR1                ; [CPU_ALU] |611| 
        CMPB      AL,#65                ; [CPU_ALU] |611| 
        B         ||$C$L15||,LOS        ; [CPU_ALU] |611| 
        ; branchcc occurs ; [] |611| 
	.dwpsn	file "../device/device.c",line 618,column 18,is_stmt,isa 0
        MOVB      ACC,#69               ; [CPU_ALU] |618| 
        MOVB      XAR4,#0               ; [CPU_ALU] |618| 
$C$DW$111	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$111, DW_AT_low_pc(0x00)
	.dwattr $C$DW$111, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$111, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |618| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |618| 
	.dwpsn	file "../device/device.c",line 619,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |619| 
        MOVB      ACC,#69               ; [CPU_ALU] |619| 
$C$DW$112	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$112, DW_AT_low_pc(0x00)
	.dwattr $C$DW$112, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$112, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |619| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |619| 
	.dwpsn	file "../device/device.c",line 620,column 18,is_stmt,isa 0
        MOV       ACC,#17157 << 9       ; [CPU_ALU] |620| 
$C$DW$113	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$113, DW_AT_low_pc(0x00)
	.dwattr $C$DW$113, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$113, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |620| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |620| 
	.dwpsn	file "../device/device.c",line 621,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |621| 
        MOVB      ACC,#69               ; [CPU_ALU] |621| 
$C$DW$114	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$114, DW_AT_low_pc(0x00)
	.dwattr $C$DW$114, DW_AT_name("GPIO_setControllerCore")
	.dwattr $C$DW$114, DW_AT_TI_call

        LCR       #||GPIO_setControllerCore|| ; [CPU_ALU] |621| 
        ; call occurs [#||GPIO_setControllerCore||] ; [] |621| 
	.dwpsn	file "../device/device.c",line 623,column 18,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |623| 
        MOVB      ACC,#70               ; [CPU_ALU] |623| 
$C$DW$115	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$115, DW_AT_low_pc(0x00)
	.dwattr $C$DW$115, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$115, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |623| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |623| 
	.dwpsn	file "../device/device.c",line 624,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |624| 
        MOVB      ACC,#70               ; [CPU_ALU] |624| 
$C$DW$116	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$116, DW_AT_low_pc(0x00)
	.dwattr $C$DW$116, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$116, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |624| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |624| 
	.dwpsn	file "../device/device.c",line 625,column 18,is_stmt,isa 0
        MOV       ACC,#8579 << 10       ; [CPU_ALU] |625| 
$C$DW$117	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$117, DW_AT_low_pc(0x00)
	.dwattr $C$DW$117, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$117, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |625| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |625| 
	.dwpsn	file "../device/device.c",line 626,column 18,is_stmt,isa 0
        MOVB      ACC,#70               ; [CPU_ALU] |626| 
||$C$L16||:    
        MOVB      XAR4,#2               ; [CPU_ALU] |626| 
$C$DW$118	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$118, DW_AT_low_pc(0x00)
	.dwattr $C$DW$118, DW_AT_name("GPIO_setControllerCore")
	.dwattr $C$DW$118, DW_AT_TI_call

        LCR       #||GPIO_setControllerCore|| ; [CPU_ALU] |626| 
        ; call occurs [#||GPIO_setControllerCore||] ; [] |626| 
||$C$L17||:    
	.dwpsn	file "../device/device.c",line 665,column 9,is_stmt,isa 0
        MOVL      XAR6,#327714          ; [CPU_ARAU] |665| 
	.dwpsn	file "../device/device.c",line 670,column 9,is_stmt,isa 0
        MOV       PL,#19                ; [CPU_ALU] |670| 
        MOV       PH,#0                 ; [CPU_ALU] |670| 
        MOVL      XAR5,#327696          ; [CPU_ARAU] |670| 
	.dwpsn	file "../device/device.c",line 675,column 9,is_stmt,isa 0
        MOV       AL,#1                 ; [CPU_ALU] |675| 
        MOV       AH,#32768             ; [CPU_ALU] |675| 
        MOVL      XAR4,#327684          ; [CPU_ARAU] |675| 
	.dwpsn	file "../device/device.c",line 678,column 5,is_stmt,isa 0
        MOVB      XAR7,#0               ; [CPU_ALU] |678| 
	.dwpsn	file "../device/device.c",line 665,column 9,is_stmt,isa 0
        MOVL      *+XAR6[0],XAR2        ; [CPU_ALU] |665| 
	.dwpsn	file "../device/device.c",line 670,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],P           ; [CPU_ALU] |670| 
	.dwpsn	file "../device/device.c",line 675,column 9,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |675| 
||$C$L18||:    
	.dwpsn	file "../device/device.c",line 678,column 5,is_stmt,isa 0
        MOVL      XAR2,*--SP            ; [CPU_ALU] |678| 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 9
        MOV       AL,AR7                ; [CPU_ALU] |678| 
        MOVL      XAR1,*--SP            ; [CPU_ALU] |678| 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$119	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$119, DW_AT_low_pc(0x00)
	.dwattr $C$DW$119, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$69, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$69, DW_AT_TI_end_line(0x2a7)
	.dwattr $C$DW$69, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$69

;**************************************************************
;* UNDEFINED EXTERNAL REFERENCES                              *
;**************************************************************
	.global	||Flash_initModule||
	.global	||GPIO_setDirectionMode||
	.global	||GPIO_setQualificationMode||
	.global	||GPIO_setPinConfig||
	.global	||GPIO_setControllerCore||
	.global	||RamfuncsLoadStart||
	.global	||RamfuncsLoadSize||
	.global	||RamfuncsRunStart||
	.global	||isrcodefuncsRunStart||
	.global	||isrcodefuncsLoadStart||
	.global	||isrcodefuncsLoadSize||
	.global	||Cla1ConstRunStart||
	.global	||Cla1ConstLoadStart||
	.global	||Cla1ConstLoadSize||
	.global	||SysCtl_getDeviceParametric||
	.global	||SysCtl_setClock||
	.global	||memcpy||

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

$C$DW$TU$19	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$19

$C$DW$T$19	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$19, DW_AT_byte_size(0x01)
$C$DW$120	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$120, DW_AT_name("SYSCTL_PERIPH_CLK_CLA1")
	.dwattr $C$DW$120, DW_AT_const_value(0x00)
	.dwattr $C$DW$120, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$120, DW_AT_decl_line(0x181)
	.dwattr $C$DW$120, DW_AT_decl_column(0x05)

$C$DW$121	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$121, DW_AT_name("SYSCTL_PERIPH_CLK_DMA")
	.dwattr $C$DW$121, DW_AT_const_value(0x200)
	.dwattr $C$DW$121, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$121, DW_AT_decl_line(0x182)
	.dwattr $C$DW$121, DW_AT_decl_column(0x05)

$C$DW$122	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$122, DW_AT_name("SYSCTL_PERIPH_CLK_TIMER0")
	.dwattr $C$DW$122, DW_AT_const_value(0x300)
	.dwattr $C$DW$122, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$122, DW_AT_decl_line(0x183)
	.dwattr $C$DW$122, DW_AT_decl_column(0x05)

$C$DW$123	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$123, DW_AT_name("SYSCTL_PERIPH_CLK_TIMER1")
	.dwattr $C$DW$123, DW_AT_const_value(0x400)
	.dwattr $C$DW$123, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$123, DW_AT_decl_line(0x184)
	.dwattr $C$DW$123, DW_AT_decl_column(0x05)

$C$DW$124	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$124, DW_AT_name("SYSCTL_PERIPH_CLK_TIMER2")
	.dwattr $C$DW$124, DW_AT_const_value(0x500)
	.dwattr $C$DW$124, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$124, DW_AT_decl_line(0x185)
	.dwattr $C$DW$124, DW_AT_decl_column(0x05)

$C$DW$125	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$125, DW_AT_name("SYSCTL_PERIPH_CLK_HRPWM")
	.dwattr $C$DW$125, DW_AT_const_value(0x1000)
	.dwattr $C$DW$125, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$125, DW_AT_decl_line(0x186)
	.dwattr $C$DW$125, DW_AT_decl_column(0x05)

$C$DW$126	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$126, DW_AT_name("SYSCTL_PERIPH_CLK_TBCLKSYNC")
	.dwattr $C$DW$126, DW_AT_const_value(0x1200)
	.dwattr $C$DW$126, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$126, DW_AT_decl_line(0x187)
	.dwattr $C$DW$126, DW_AT_decl_column(0x05)

$C$DW$127	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$127, DW_AT_name("SYSCTL_PERIPH_CLK_GTBCLKSYNC")
	.dwattr $C$DW$127, DW_AT_const_value(0x1300)
	.dwattr $C$DW$127, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$127, DW_AT_decl_line(0x188)
	.dwattr $C$DW$127, DW_AT_decl_column(0x05)

$C$DW$128	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$128, DW_AT_name("SYSCTL_PERIPH_CLK_EMIF1")
	.dwattr $C$DW$128, DW_AT_const_value(0x01)
	.dwattr $C$DW$128, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$128, DW_AT_decl_line(0x189)
	.dwattr $C$DW$128, DW_AT_decl_column(0x05)

$C$DW$129	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$129, DW_AT_name("SYSCTL_PERIPH_CLK_EMIF2")
	.dwattr $C$DW$129, DW_AT_const_value(0x101)
	.dwattr $C$DW$129, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$129, DW_AT_decl_line(0x18a)
	.dwattr $C$DW$129, DW_AT_decl_column(0x05)

$C$DW$130	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$130, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM1")
	.dwattr $C$DW$130, DW_AT_const_value(0x02)
	.dwattr $C$DW$130, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$130, DW_AT_decl_line(0x18b)
	.dwattr $C$DW$130, DW_AT_decl_column(0x05)

$C$DW$131	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$131, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM2")
	.dwattr $C$DW$131, DW_AT_const_value(0x102)
	.dwattr $C$DW$131, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$131, DW_AT_decl_line(0x18c)
	.dwattr $C$DW$131, DW_AT_decl_column(0x05)

$C$DW$132	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$132, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM3")
	.dwattr $C$DW$132, DW_AT_const_value(0x202)
	.dwattr $C$DW$132, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$132, DW_AT_decl_line(0x18d)
	.dwattr $C$DW$132, DW_AT_decl_column(0x05)

$C$DW$133	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$133, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM4")
	.dwattr $C$DW$133, DW_AT_const_value(0x302)
	.dwattr $C$DW$133, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$133, DW_AT_decl_line(0x18e)
	.dwattr $C$DW$133, DW_AT_decl_column(0x05)

$C$DW$134	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$134, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM5")
	.dwattr $C$DW$134, DW_AT_const_value(0x402)
	.dwattr $C$DW$134, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$134, DW_AT_decl_line(0x18f)
	.dwattr $C$DW$134, DW_AT_decl_column(0x05)

$C$DW$135	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$135, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM6")
	.dwattr $C$DW$135, DW_AT_const_value(0x502)
	.dwattr $C$DW$135, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$135, DW_AT_decl_line(0x190)
	.dwattr $C$DW$135, DW_AT_decl_column(0x05)

$C$DW$136	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$136, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM7")
	.dwattr $C$DW$136, DW_AT_const_value(0x602)
	.dwattr $C$DW$136, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$136, DW_AT_decl_line(0x191)
	.dwattr $C$DW$136, DW_AT_decl_column(0x05)

$C$DW$137	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$137, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM8")
	.dwattr $C$DW$137, DW_AT_const_value(0x702)
	.dwattr $C$DW$137, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$137, DW_AT_decl_line(0x192)
	.dwattr $C$DW$137, DW_AT_decl_column(0x05)

$C$DW$138	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$138, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM9")
	.dwattr $C$DW$138, DW_AT_const_value(0x802)
	.dwattr $C$DW$138, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$138, DW_AT_decl_line(0x193)
	.dwattr $C$DW$138, DW_AT_decl_column(0x05)

$C$DW$139	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$139, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM10")
	.dwattr $C$DW$139, DW_AT_const_value(0x902)
	.dwattr $C$DW$139, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$139, DW_AT_decl_line(0x194)
	.dwattr $C$DW$139, DW_AT_decl_column(0x05)

$C$DW$140	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$140, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM11")
	.dwattr $C$DW$140, DW_AT_const_value(0xa02)
	.dwattr $C$DW$140, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$140, DW_AT_decl_line(0x195)
	.dwattr $C$DW$140, DW_AT_decl_column(0x05)

$C$DW$141	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$141, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM12")
	.dwattr $C$DW$141, DW_AT_const_value(0xb02)
	.dwattr $C$DW$141, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$141, DW_AT_decl_line(0x196)
	.dwattr $C$DW$141, DW_AT_decl_column(0x05)

$C$DW$142	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$142, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP1")
	.dwattr $C$DW$142, DW_AT_const_value(0x03)
	.dwattr $C$DW$142, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$142, DW_AT_decl_line(0x197)
	.dwattr $C$DW$142, DW_AT_decl_column(0x05)

$C$DW$143	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$143, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP2")
	.dwattr $C$DW$143, DW_AT_const_value(0x103)
	.dwattr $C$DW$143, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$143, DW_AT_decl_line(0x198)
	.dwattr $C$DW$143, DW_AT_decl_column(0x05)

$C$DW$144	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$144, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP3")
	.dwattr $C$DW$144, DW_AT_const_value(0x203)
	.dwattr $C$DW$144, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$144, DW_AT_decl_line(0x199)
	.dwattr $C$DW$144, DW_AT_decl_column(0x05)

$C$DW$145	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$145, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP4")
	.dwattr $C$DW$145, DW_AT_const_value(0x303)
	.dwattr $C$DW$145, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$145, DW_AT_decl_line(0x19a)
	.dwattr $C$DW$145, DW_AT_decl_column(0x05)

$C$DW$146	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$146, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP5")
	.dwattr $C$DW$146, DW_AT_const_value(0x403)
	.dwattr $C$DW$146, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$146, DW_AT_decl_line(0x19b)
	.dwattr $C$DW$146, DW_AT_decl_column(0x05)

$C$DW$147	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$147, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP6")
	.dwattr $C$DW$147, DW_AT_const_value(0x503)
	.dwattr $C$DW$147, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$147, DW_AT_decl_line(0x19c)
	.dwattr $C$DW$147, DW_AT_decl_column(0x05)

$C$DW$148	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$148, DW_AT_name("SYSCTL_PERIPH_CLK_EQEP1")
	.dwattr $C$DW$148, DW_AT_const_value(0x04)
	.dwattr $C$DW$148, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$148, DW_AT_decl_line(0x19d)
	.dwattr $C$DW$148, DW_AT_decl_column(0x05)

$C$DW$149	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$149, DW_AT_name("SYSCTL_PERIPH_CLK_EQEP2")
	.dwattr $C$DW$149, DW_AT_const_value(0x104)
	.dwattr $C$DW$149, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$149, DW_AT_decl_line(0x19e)
	.dwattr $C$DW$149, DW_AT_decl_column(0x05)

$C$DW$150	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$150, DW_AT_name("SYSCTL_PERIPH_CLK_EQEP3")
	.dwattr $C$DW$150, DW_AT_const_value(0x204)
	.dwattr $C$DW$150, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$150, DW_AT_decl_line(0x19f)
	.dwattr $C$DW$150, DW_AT_decl_column(0x05)

$C$DW$151	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$151, DW_AT_name("SYSCTL_PERIPH_CLK_SD1")
	.dwattr $C$DW$151, DW_AT_const_value(0x06)
	.dwattr $C$DW$151, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$151, DW_AT_decl_line(0x1a0)
	.dwattr $C$DW$151, DW_AT_decl_column(0x05)

$C$DW$152	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$152, DW_AT_name("SYSCTL_PERIPH_CLK_SD2")
	.dwattr $C$DW$152, DW_AT_const_value(0x106)
	.dwattr $C$DW$152, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$152, DW_AT_decl_line(0x1a1)
	.dwattr $C$DW$152, DW_AT_decl_column(0x05)

$C$DW$153	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$153, DW_AT_name("SYSCTL_PERIPH_CLK_SCIA")
	.dwattr $C$DW$153, DW_AT_const_value(0x07)
	.dwattr $C$DW$153, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$153, DW_AT_decl_line(0x1a2)
	.dwattr $C$DW$153, DW_AT_decl_column(0x05)

$C$DW$154	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$154, DW_AT_name("SYSCTL_PERIPH_CLK_SCIB")
	.dwattr $C$DW$154, DW_AT_const_value(0x107)
	.dwattr $C$DW$154, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$154, DW_AT_decl_line(0x1a3)
	.dwattr $C$DW$154, DW_AT_decl_column(0x05)

$C$DW$155	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$155, DW_AT_name("SYSCTL_PERIPH_CLK_SCIC")
	.dwattr $C$DW$155, DW_AT_const_value(0x207)
	.dwattr $C$DW$155, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$155, DW_AT_decl_line(0x1a4)
	.dwattr $C$DW$155, DW_AT_decl_column(0x05)

$C$DW$156	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$156, DW_AT_name("SYSCTL_PERIPH_CLK_SCID")
	.dwattr $C$DW$156, DW_AT_const_value(0x307)
	.dwattr $C$DW$156, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$156, DW_AT_decl_line(0x1a5)
	.dwattr $C$DW$156, DW_AT_decl_column(0x05)

$C$DW$157	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$157, DW_AT_name("SYSCTL_PERIPH_CLK_SPIA")
	.dwattr $C$DW$157, DW_AT_const_value(0x08)
	.dwattr $C$DW$157, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$157, DW_AT_decl_line(0x1a6)
	.dwattr $C$DW$157, DW_AT_decl_column(0x05)

$C$DW$158	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$158, DW_AT_name("SYSCTL_PERIPH_CLK_SPIB")
	.dwattr $C$DW$158, DW_AT_const_value(0x108)
	.dwattr $C$DW$158, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$158, DW_AT_decl_line(0x1a7)
	.dwattr $C$DW$158, DW_AT_decl_column(0x05)

$C$DW$159	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$159, DW_AT_name("SYSCTL_PERIPH_CLK_SPIC")
	.dwattr $C$DW$159, DW_AT_const_value(0x208)
	.dwattr $C$DW$159, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$159, DW_AT_decl_line(0x1a8)
	.dwattr $C$DW$159, DW_AT_decl_column(0x05)

$C$DW$160	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$160, DW_AT_name("SYSCTL_PERIPH_CLK_I2CA")
	.dwattr $C$DW$160, DW_AT_const_value(0x09)
	.dwattr $C$DW$160, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$160, DW_AT_decl_line(0x1a9)
	.dwattr $C$DW$160, DW_AT_decl_column(0x05)

$C$DW$161	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$161, DW_AT_name("SYSCTL_PERIPH_CLK_I2CB")
	.dwattr $C$DW$161, DW_AT_const_value(0x109)
	.dwattr $C$DW$161, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$161, DW_AT_decl_line(0x1aa)
	.dwattr $C$DW$161, DW_AT_decl_column(0x05)

$C$DW$162	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$162, DW_AT_name("SYSCTL_PERIPH_CLK_CANA")
	.dwattr $C$DW$162, DW_AT_const_value(0x0a)
	.dwattr $C$DW$162, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$162, DW_AT_decl_line(0x1ab)
	.dwattr $C$DW$162, DW_AT_decl_column(0x05)

$C$DW$163	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$163, DW_AT_name("SYSCTL_PERIPH_CLK_CANB")
	.dwattr $C$DW$163, DW_AT_const_value(0x10a)
	.dwattr $C$DW$163, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$163, DW_AT_decl_line(0x1ac)
	.dwattr $C$DW$163, DW_AT_decl_column(0x05)

$C$DW$164	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$164, DW_AT_name("SYSCTL_PERIPH_CLK_MCBSPA")
	.dwattr $C$DW$164, DW_AT_const_value(0x0b)
	.dwattr $C$DW$164, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$164, DW_AT_decl_line(0x1ad)
	.dwattr $C$DW$164, DW_AT_decl_column(0x05)

$C$DW$165	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$165, DW_AT_name("SYSCTL_PERIPH_CLK_MCBSPB")
	.dwattr $C$DW$165, DW_AT_const_value(0x10b)
	.dwattr $C$DW$165, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$165, DW_AT_decl_line(0x1ae)
	.dwattr $C$DW$165, DW_AT_decl_column(0x05)

$C$DW$166	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$166, DW_AT_name("SYSCTL_PERIPH_CLK_USBA")
	.dwattr $C$DW$166, DW_AT_const_value(0x100b)
	.dwattr $C$DW$166, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$166, DW_AT_decl_line(0x1af)
	.dwattr $C$DW$166, DW_AT_decl_column(0x05)

$C$DW$167	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$167, DW_AT_name("SYSCTL_PERIPH_CLK_UPPA")
	.dwattr $C$DW$167, DW_AT_const_value(0x0c)
	.dwattr $C$DW$167, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$167, DW_AT_decl_line(0x1b0)
	.dwattr $C$DW$167, DW_AT_decl_column(0x05)

$C$DW$168	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$168, DW_AT_name("SYSCTL_PERIPH_CLK_ADCA")
	.dwattr $C$DW$168, DW_AT_const_value(0x0d)
	.dwattr $C$DW$168, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$168, DW_AT_decl_line(0x1b1)
	.dwattr $C$DW$168, DW_AT_decl_column(0x05)

$C$DW$169	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$169, DW_AT_name("SYSCTL_PERIPH_CLK_ADCB")
	.dwattr $C$DW$169, DW_AT_const_value(0x10d)
	.dwattr $C$DW$169, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$169, DW_AT_decl_line(0x1b2)
	.dwattr $C$DW$169, DW_AT_decl_column(0x05)

$C$DW$170	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$170, DW_AT_name("SYSCTL_PERIPH_CLK_ADCC")
	.dwattr $C$DW$170, DW_AT_const_value(0x20d)
	.dwattr $C$DW$170, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$170, DW_AT_decl_line(0x1b3)
	.dwattr $C$DW$170, DW_AT_decl_column(0x05)

$C$DW$171	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$171, DW_AT_name("SYSCTL_PERIPH_CLK_ADCD")
	.dwattr $C$DW$171, DW_AT_const_value(0x30d)
	.dwattr $C$DW$171, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$171, DW_AT_decl_line(0x1b4)
	.dwattr $C$DW$171, DW_AT_decl_column(0x05)

$C$DW$172	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$172, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS1")
	.dwattr $C$DW$172, DW_AT_const_value(0x0e)
	.dwattr $C$DW$172, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$172, DW_AT_decl_line(0x1b5)
	.dwattr $C$DW$172, DW_AT_decl_column(0x05)

$C$DW$173	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$173, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS2")
	.dwattr $C$DW$173, DW_AT_const_value(0x10e)
	.dwattr $C$DW$173, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$173, DW_AT_decl_line(0x1b6)
	.dwattr $C$DW$173, DW_AT_decl_column(0x05)

$C$DW$174	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$174, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS3")
	.dwattr $C$DW$174, DW_AT_const_value(0x20e)
	.dwattr $C$DW$174, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$174, DW_AT_decl_line(0x1b7)
	.dwattr $C$DW$174, DW_AT_decl_column(0x05)

$C$DW$175	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$175, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS4")
	.dwattr $C$DW$175, DW_AT_const_value(0x30e)
	.dwattr $C$DW$175, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$175, DW_AT_decl_line(0x1b8)
	.dwattr $C$DW$175, DW_AT_decl_column(0x05)

$C$DW$176	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$176, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS5")
	.dwattr $C$DW$176, DW_AT_const_value(0x40e)
	.dwattr $C$DW$176, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$176, DW_AT_decl_line(0x1b9)
	.dwattr $C$DW$176, DW_AT_decl_column(0x05)

$C$DW$177	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$177, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS6")
	.dwattr $C$DW$177, DW_AT_const_value(0x50e)
	.dwattr $C$DW$177, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$177, DW_AT_decl_line(0x1ba)
	.dwattr $C$DW$177, DW_AT_decl_column(0x05)

$C$DW$178	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$178, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS7")
	.dwattr $C$DW$178, DW_AT_const_value(0x60e)
	.dwattr $C$DW$178, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$178, DW_AT_decl_line(0x1bb)
	.dwattr $C$DW$178, DW_AT_decl_column(0x05)

$C$DW$179	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$179, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS8")
	.dwattr $C$DW$179, DW_AT_const_value(0x70e)
	.dwattr $C$DW$179, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$179, DW_AT_decl_line(0x1bc)
	.dwattr $C$DW$179, DW_AT_decl_column(0x05)

$C$DW$180	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$180, DW_AT_name("SYSCTL_PERIPH_CLK_DACA")
	.dwattr $C$DW$180, DW_AT_const_value(0x1010)
	.dwattr $C$DW$180, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$180, DW_AT_decl_line(0x1bd)
	.dwattr $C$DW$180, DW_AT_decl_column(0x05)

$C$DW$181	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$181, DW_AT_name("SYSCTL_PERIPH_CLK_DACB")
	.dwattr $C$DW$181, DW_AT_const_value(0x1110)
	.dwattr $C$DW$181, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$181, DW_AT_decl_line(0x1be)
	.dwattr $C$DW$181, DW_AT_decl_column(0x05)

$C$DW$182	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$182, DW_AT_name("SYSCTL_PERIPH_CLK_DACC")
	.dwattr $C$DW$182, DW_AT_const_value(0x1210)
	.dwattr $C$DW$182, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$182, DW_AT_decl_line(0x1bf)
	.dwattr $C$DW$182, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$19, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$19, DW_AT_decl_line(0x180)
	.dwattr $C$DW$T$19, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$19

	.dwendtag $C$DW$TU$19


$C$DW$TU$20	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$20
$C$DW$T$20	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$20, DW_AT_name("SysCtl_PeripheralPCLOCKCR")
	.dwattr $C$DW$T$20, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$T$20, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$20, DW_AT_decl_line(0x1c0)
	.dwattr $C$DW$T$20, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$20


$C$DW$TU$21	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$21

$C$DW$T$21	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$21, DW_AT_byte_size(0x01)
$C$DW$183	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$183, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_1")
	.dwattr $C$DW$183, DW_AT_const_value(0x00)
	.dwattr $C$DW$183, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$183, DW_AT_decl_line(0x296)
	.dwattr $C$DW$183, DW_AT_decl_column(0x05)

$C$DW$184	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$184, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_2")
	.dwattr $C$DW$184, DW_AT_const_value(0x01)
	.dwattr $C$DW$184, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$184, DW_AT_decl_line(0x297)
	.dwattr $C$DW$184, DW_AT_decl_column(0x05)

$C$DW$185	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$185, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_4")
	.dwattr $C$DW$185, DW_AT_const_value(0x02)
	.dwattr $C$DW$185, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$185, DW_AT_decl_line(0x298)
	.dwattr $C$DW$185, DW_AT_decl_column(0x05)

$C$DW$186	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$186, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_6")
	.dwattr $C$DW$186, DW_AT_const_value(0x03)
	.dwattr $C$DW$186, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$186, DW_AT_decl_line(0x299)
	.dwattr $C$DW$186, DW_AT_decl_column(0x05)

$C$DW$187	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$187, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_8")
	.dwattr $C$DW$187, DW_AT_const_value(0x04)
	.dwattr $C$DW$187, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$187, DW_AT_decl_line(0x29a)
	.dwattr $C$DW$187, DW_AT_decl_column(0x05)

$C$DW$188	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$188, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_10")
	.dwattr $C$DW$188, DW_AT_const_value(0x05)
	.dwattr $C$DW$188, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$188, DW_AT_decl_line(0x29b)
	.dwattr $C$DW$188, DW_AT_decl_column(0x05)

$C$DW$189	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$189, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_12")
	.dwattr $C$DW$189, DW_AT_const_value(0x06)
	.dwattr $C$DW$189, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$189, DW_AT_decl_line(0x29c)
	.dwattr $C$DW$189, DW_AT_decl_column(0x05)

$C$DW$190	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$190, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_14")
	.dwattr $C$DW$190, DW_AT_const_value(0x07)
	.dwattr $C$DW$190, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$190, DW_AT_decl_line(0x29d)
	.dwattr $C$DW$190, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$21, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$21, DW_AT_decl_line(0x295)
	.dwattr $C$DW$T$21, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$21

	.dwendtag $C$DW$TU$21


$C$DW$TU$22	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$22
$C$DW$T$22	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$22, DW_AT_name("SysCtl_LSPCLKPrescaler")
	.dwattr $C$DW$T$22, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$T$22, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$22, DW_AT_decl_line(0x29e)
	.dwattr $C$DW$T$22, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$22


$C$DW$TU$23	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$23

$C$DW$T$23	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$23, DW_AT_byte_size(0x01)
$C$DW$191	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$191, DW_AT_name("SYSCTL_CPUSEL0_EPWM")
	.dwattr $C$DW$191, DW_AT_const_value(0x00)
	.dwattr $C$DW$191, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$191, DW_AT_decl_line(0x20b)
	.dwattr $C$DW$191, DW_AT_decl_column(0x05)

$C$DW$192	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$192, DW_AT_name("SYSCTL_CPUSEL1_ECAP")
	.dwattr $C$DW$192, DW_AT_const_value(0x01)
	.dwattr $C$DW$192, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$192, DW_AT_decl_line(0x20d)
	.dwattr $C$DW$192, DW_AT_decl_column(0x05)

$C$DW$193	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$193, DW_AT_name("SYSCTL_CPUSEL2_EQEP")
	.dwattr $C$DW$193, DW_AT_const_value(0x02)
	.dwattr $C$DW$193, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$193, DW_AT_decl_line(0x20f)
	.dwattr $C$DW$193, DW_AT_decl_column(0x05)

$C$DW$194	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$194, DW_AT_name("SYSCTL_CPUSEL4_SD")
	.dwattr $C$DW$194, DW_AT_const_value(0x04)
	.dwattr $C$DW$194, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$194, DW_AT_decl_line(0x211)
	.dwattr $C$DW$194, DW_AT_decl_column(0x05)

$C$DW$195	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$195, DW_AT_name("SYSCTL_CPUSEL5_SCI")
	.dwattr $C$DW$195, DW_AT_const_value(0x05)
	.dwattr $C$DW$195, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$195, DW_AT_decl_line(0x213)
	.dwattr $C$DW$195, DW_AT_decl_column(0x05)

$C$DW$196	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$196, DW_AT_name("SYSCTL_CPUSEL6_SPI")
	.dwattr $C$DW$196, DW_AT_const_value(0x06)
	.dwattr $C$DW$196, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$196, DW_AT_decl_line(0x215)
	.dwattr $C$DW$196, DW_AT_decl_column(0x05)

$C$DW$197	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$197, DW_AT_name("SYSCTL_CPUSEL7_I2C")
	.dwattr $C$DW$197, DW_AT_const_value(0x07)
	.dwattr $C$DW$197, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$197, DW_AT_decl_line(0x217)
	.dwattr $C$DW$197, DW_AT_decl_column(0x05)

$C$DW$198	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$198, DW_AT_name("SYSCTL_CPUSEL8_CAN")
	.dwattr $C$DW$198, DW_AT_const_value(0x08)
	.dwattr $C$DW$198, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$198, DW_AT_decl_line(0x219)
	.dwattr $C$DW$198, DW_AT_decl_column(0x05)

$C$DW$199	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$199, DW_AT_name("SYSCTL_CPUSEL9_MCBSP")
	.dwattr $C$DW$199, DW_AT_const_value(0x09)
	.dwattr $C$DW$199, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$199, DW_AT_decl_line(0x21b)
	.dwattr $C$DW$199, DW_AT_decl_column(0x05)

$C$DW$200	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$200, DW_AT_name("SYSCTL_CPUSEL11_ADC")
	.dwattr $C$DW$200, DW_AT_const_value(0x0b)
	.dwattr $C$DW$200, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$200, DW_AT_decl_line(0x21d)
	.dwattr $C$DW$200, DW_AT_decl_column(0x05)

$C$DW$201	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$201, DW_AT_name("SYSCTL_CPUSEL12_CMPSS")
	.dwattr $C$DW$201, DW_AT_const_value(0x0c)
	.dwattr $C$DW$201, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$201, DW_AT_decl_line(0x21f)
	.dwattr $C$DW$201, DW_AT_decl_column(0x05)

$C$DW$202	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$202, DW_AT_name("SYSCTL_CPUSEL14_DAC")
	.dwattr $C$DW$202, DW_AT_const_value(0x0e)
	.dwattr $C$DW$202, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$202, DW_AT_decl_line(0x221)
	.dwattr $C$DW$202, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$23, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$23, DW_AT_decl_line(0x209)
	.dwattr $C$DW$T$23, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$23

	.dwendtag $C$DW$TU$23


$C$DW$TU$24	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$24
$C$DW$T$24	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$24, DW_AT_name("SysCtl_CPUSelPeripheral")
	.dwattr $C$DW$T$24, DW_AT_type(*$C$DW$T$23)
	.dwattr $C$DW$T$24, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$24, DW_AT_decl_line(0x222)
	.dwattr $C$DW$T$24, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$24


$C$DW$TU$25	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$25

$C$DW$T$25	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$25, DW_AT_byte_size(0x01)
$C$DW$203	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$203, DW_AT_name("SYSCTL_CPUSEL_CPU1")
	.dwattr $C$DW$203, DW_AT_const_value(0x00)
	.dwattr $C$DW$203, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$203, DW_AT_decl_line(0x26a)
	.dwattr $C$DW$203, DW_AT_decl_column(0x05)

$C$DW$204	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$204, DW_AT_name("SYSCTL_CPUSEL_CPU2")
	.dwattr $C$DW$204, DW_AT_const_value(0x01)
	.dwattr $C$DW$204, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$204, DW_AT_decl_line(0x26c)
	.dwattr $C$DW$204, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$25, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$25, DW_AT_decl_line(0x268)
	.dwattr $C$DW$T$25, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$25

	.dwendtag $C$DW$TU$25


$C$DW$TU$26	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$26
$C$DW$T$26	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$26, DW_AT_name("SysCtl_CPUSel")
	.dwattr $C$DW$T$26, DW_AT_type(*$C$DW$T$25)
	.dwattr $C$DW$T$26, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$26, DW_AT_decl_line(0x26d)
	.dwattr $C$DW$T$26, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$26


$C$DW$TU$27	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$27

$C$DW$T$27	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$27, DW_AT_byte_size(0x01)
$C$DW$205	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$205, DW_AT_name("SYSCTL_DEVICE_QUAL")
	.dwattr $C$DW$205, DW_AT_const_value(0x00)
	.dwattr $C$DW$205, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$205, DW_AT_decl_line(0x314)
	.dwattr $C$DW$205, DW_AT_decl_column(0x05)

$C$DW$206	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$206, DW_AT_name("SYSCTL_DEVICE_PINCOUNT")
	.dwattr $C$DW$206, DW_AT_const_value(0x01)
	.dwattr $C$DW$206, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$206, DW_AT_decl_line(0x315)
	.dwattr $C$DW$206, DW_AT_decl_column(0x05)

$C$DW$207	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$207, DW_AT_name("SYSCTL_DEVICE_INSTASPIN")
	.dwattr $C$DW$207, DW_AT_const_value(0x02)
	.dwattr $C$DW$207, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$207, DW_AT_decl_line(0x316)
	.dwattr $C$DW$207, DW_AT_decl_column(0x05)

$C$DW$208	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$208, DW_AT_name("SYSCTL_DEVICE_FLASH")
	.dwattr $C$DW$208, DW_AT_const_value(0x03)
	.dwattr $C$DW$208, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$208, DW_AT_decl_line(0x317)
	.dwattr $C$DW$208, DW_AT_decl_column(0x05)

$C$DW$209	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$209, DW_AT_name("SYSCTL_DEVICE_PARTID")
	.dwattr $C$DW$209, DW_AT_const_value(0x04)
	.dwattr $C$DW$209, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$209, DW_AT_decl_line(0x318)
	.dwattr $C$DW$209, DW_AT_decl_column(0x05)

$C$DW$210	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$210, DW_AT_name("SYSCTL_DEVICE_FAMILY")
	.dwattr $C$DW$210, DW_AT_const_value(0x05)
	.dwattr $C$DW$210, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$210, DW_AT_decl_line(0x319)
	.dwattr $C$DW$210, DW_AT_decl_column(0x05)

$C$DW$211	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$211, DW_AT_name("SYSCTL_DEVICE_PARTNO")
	.dwattr $C$DW$211, DW_AT_const_value(0x06)
	.dwattr $C$DW$211, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$211, DW_AT_decl_line(0x31a)
	.dwattr $C$DW$211, DW_AT_decl_column(0x05)

$C$DW$212	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$212, DW_AT_name("SYSCTL_DEVICE_CLASSID")
	.dwattr $C$DW$212, DW_AT_const_value(0x07)
	.dwattr $C$DW$212, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$212, DW_AT_decl_line(0x31b)
	.dwattr $C$DW$212, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$27, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$27, DW_AT_decl_line(0x313)
	.dwattr $C$DW$T$27, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$27

	.dwendtag $C$DW$TU$27


$C$DW$TU$28	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$28
$C$DW$T$28	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$28, DW_AT_name("SysCtl_DeviceParametric")
	.dwattr $C$DW$T$28, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$T$28, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_5_03_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$28, DW_AT_decl_line(0x31c)
	.dwattr $C$DW$T$28, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$28


$C$DW$TU$29	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$29

$C$DW$T$29	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$29, DW_AT_byte_size(0x01)
$C$DW$213	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$213, DW_AT_name("GPIO_PORT_A")
	.dwattr $C$DW$213, DW_AT_const_value(0x00)
	.dwattr $C$DW$213, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$213, DW_AT_decl_line(0xbc)
	.dwattr $C$DW$213, DW_AT_decl_column(0x05)

$C$DW$214	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$214, DW_AT_name("GPIO_PORT_B")
	.dwattr $C$DW$214, DW_AT_const_value(0x01)
	.dwattr $C$DW$214, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$214, DW_AT_decl_line(0xbd)
	.dwattr $C$DW$214, DW_AT_decl_column(0x05)

$C$DW$215	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$215, DW_AT_name("GPIO_PORT_C")
	.dwattr $C$DW$215, DW_AT_const_value(0x02)
	.dwattr $C$DW$215, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$215, DW_AT_decl_line(0xbe)
	.dwattr $C$DW$215, DW_AT_decl_column(0x05)

$C$DW$216	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$216, DW_AT_name("GPIO_PORT_D")
	.dwattr $C$DW$216, DW_AT_const_value(0x03)
	.dwattr $C$DW$216, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$216, DW_AT_decl_line(0xbf)
	.dwattr $C$DW$216, DW_AT_decl_column(0x05)

$C$DW$217	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$217, DW_AT_name("GPIO_PORT_E")
	.dwattr $C$DW$217, DW_AT_const_value(0x04)
	.dwattr $C$DW$217, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$217, DW_AT_decl_line(0xc0)
	.dwattr $C$DW$217, DW_AT_decl_column(0x05)

$C$DW$218	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$218, DW_AT_name("GPIO_PORT_F")
	.dwattr $C$DW$218, DW_AT_const_value(0x05)
	.dwattr $C$DW$218, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$218, DW_AT_decl_line(0xc1)
	.dwattr $C$DW$218, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$29, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$29, DW_AT_decl_line(0xbb)
	.dwattr $C$DW$T$29, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$29

	.dwendtag $C$DW$TU$29


$C$DW$TU$30	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$30
$C$DW$T$30	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$30, DW_AT_name("GPIO_Port")
	.dwattr $C$DW$T$30, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$T$30, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$30, DW_AT_decl_line(0xc2)
	.dwattr $C$DW$T$30, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$30


$C$DW$TU$31	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$31

$C$DW$T$31	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$31, DW_AT_byte_size(0x01)
$C$DW$219	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$219, DW_AT_name("GPIO_DIR_MODE_IN")
	.dwattr $C$DW$219, DW_AT_const_value(0x00)
	.dwattr $C$DW$219, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$219, DW_AT_decl_line(0x7c)
	.dwattr $C$DW$219, DW_AT_decl_column(0x05)

$C$DW$220	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$220, DW_AT_name("GPIO_DIR_MODE_OUT")
	.dwattr $C$DW$220, DW_AT_const_value(0x01)
	.dwattr $C$DW$220, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$220, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$220, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$31, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$31, DW_AT_decl_line(0x7b)
	.dwattr $C$DW$T$31, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$31

	.dwendtag $C$DW$TU$31


$C$DW$TU$32	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$32
$C$DW$T$32	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$32, DW_AT_name("GPIO_Direction")
	.dwattr $C$DW$T$32, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$T$32, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$32, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$T$32, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$32


$C$DW$TU$33	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$33

$C$DW$T$33	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$33, DW_AT_byte_size(0x01)
$C$DW$221	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$221, DW_AT_name("GPIO_QUAL_SYNC")
	.dwattr $C$DW$221, DW_AT_const_value(0x00)
	.dwattr $C$DW$221, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$221, DW_AT_decl_line(0x95)
	.dwattr $C$DW$221, DW_AT_decl_column(0x05)

$C$DW$222	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$222, DW_AT_name("GPIO_QUAL_3SAMPLE")
	.dwattr $C$DW$222, DW_AT_const_value(0x01)
	.dwattr $C$DW$222, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$222, DW_AT_decl_line(0x96)
	.dwattr $C$DW$222, DW_AT_decl_column(0x05)

$C$DW$223	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$223, DW_AT_name("GPIO_QUAL_6SAMPLE")
	.dwattr $C$DW$223, DW_AT_const_value(0x02)
	.dwattr $C$DW$223, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$223, DW_AT_decl_line(0x97)
	.dwattr $C$DW$223, DW_AT_decl_column(0x05)

$C$DW$224	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$224, DW_AT_name("GPIO_QUAL_ASYNC")
	.dwattr $C$DW$224, DW_AT_const_value(0x03)
	.dwattr $C$DW$224, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$224, DW_AT_decl_line(0x98)
	.dwattr $C$DW$224, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$33, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$33, DW_AT_decl_line(0x94)
	.dwattr $C$DW$T$33, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$33

	.dwendtag $C$DW$TU$33


$C$DW$TU$34	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$34
$C$DW$T$34	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$34, DW_AT_name("GPIO_QualificationMode")
	.dwattr $C$DW$T$34, DW_AT_type(*$C$DW$T$33)
	.dwattr $C$DW$T$34, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$34, DW_AT_decl_line(0x99)
	.dwattr $C$DW$T$34, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$34


$C$DW$TU$35	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$35

$C$DW$T$35	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$35, DW_AT_byte_size(0x01)
$C$DW$225	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$225, DW_AT_name("GPIO_CORE_CPU1")
	.dwattr $C$DW$225, DW_AT_const_value(0x00)
	.dwattr $C$DW$225, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$225, DW_AT_decl_line(0xae)
	.dwattr $C$DW$225, DW_AT_decl_column(0x05)

$C$DW$226	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$226, DW_AT_name("GPIO_CORE_CPU1_CLA1")
	.dwattr $C$DW$226, DW_AT_const_value(0x01)
	.dwattr $C$DW$226, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$226, DW_AT_decl_line(0xaf)
	.dwattr $C$DW$226, DW_AT_decl_column(0x05)

$C$DW$227	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$227, DW_AT_name("GPIO_CORE_CPU2")
	.dwattr $C$DW$227, DW_AT_const_value(0x02)
	.dwattr $C$DW$227, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$227, DW_AT_decl_line(0xb0)
	.dwattr $C$DW$227, DW_AT_decl_column(0x05)

$C$DW$228	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$228, DW_AT_name("GPIO_CORE_CPU2_CLA1")
	.dwattr $C$DW$228, DW_AT_const_value(0x03)
	.dwattr $C$DW$228, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$228, DW_AT_decl_line(0xb1)
	.dwattr $C$DW$228, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$35, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$35, DW_AT_decl_line(0xad)
	.dwattr $C$DW$T$35, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$35

	.dwendtag $C$DW$TU$35


$C$DW$TU$36	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$36
$C$DW$T$36	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$36, DW_AT_name("GPIO_CoreSelect")
	.dwattr $C$DW$T$36, DW_AT_type(*$C$DW$T$35)
	.dwattr $C$DW$T$36, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$36, DW_AT_decl_line(0xb2)
	.dwattr $C$DW$T$36, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$36


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


$C$DW$TU$43	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$43
$C$DW$T$43	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$43, DW_AT_name("__uint16_t")
	.dwattr $C$DW$T$43, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$T$43, DW_AT_decl_file("C:/ti/ccs1271/ccs/tools/compiler/ti-cgt-c2000_22.6.1.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$43, DW_AT_decl_line(0x41)
	.dwattr $C$DW$T$43, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$43


$C$DW$TU$44	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$44
$C$DW$T$44	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$44, DW_AT_name("uint16_t")
	.dwattr $C$DW$T$44, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$T$44, DW_AT_decl_file("C:/ti/ccs1271/ccs/tools/compiler/ti-cgt-c2000_22.6.1.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$44, DW_AT_decl_line(0x41)
	.dwattr $C$DW$T$44, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$44


$C$DW$TU$12	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$12
$C$DW$T$12	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$12, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$12, DW_AT_name("long")
	.dwattr $C$DW$T$12, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$12


$C$DW$TU$13	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$13
$C$DW$T$13	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$13, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$13, DW_AT_name("unsigned long")
	.dwattr $C$DW$T$13, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$13


$C$DW$TU$46	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$46
$C$DW$T$46	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$46, DW_AT_name("__uint32_t")
	.dwattr $C$DW$T$46, DW_AT_type(*$C$DW$T$13)
	.dwattr $C$DW$T$46, DW_AT_decl_file("C:/ti/ccs1271/ccs/tools/compiler/ti-cgt-c2000_22.6.1.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$46, DW_AT_decl_line(0x43)
	.dwattr $C$DW$T$46, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$46


$C$DW$TU$47	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$47
$C$DW$T$47	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$47, DW_AT_name("uint32_t")
	.dwattr $C$DW$T$47, DW_AT_type(*$C$DW$T$46)
	.dwattr $C$DW$T$47, DW_AT_decl_file("C:/ti/ccs1271/ccs/tools/compiler/ti-cgt-c2000_22.6.1.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$47, DW_AT_decl_line(0x46)
	.dwattr $C$DW$T$47, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$47


$C$DW$TU$77	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$77
$C$DW$229	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$229, DW_AT_type(*$C$DW$T$47)

$C$DW$T$77	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$77, DW_AT_type(*$C$DW$229)

	.dwendtag $C$DW$TU$77


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


$C$DW$TU$60	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$60
$C$DW$230	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$230, DW_AT_type(*$C$DW$T$5)

$C$DW$T$60	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$60, DW_AT_type(*$C$DW$230)

	.dwendtag $C$DW$TU$60


$C$DW$TU$61	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$61
$C$DW$T$61	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$61, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$T$61, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$61


$C$DW$TU$78	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$78
$C$DW$T$78	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$78, DW_AT_encoding(DW_ATE_unsigned_char)
	.dwattr $C$DW$T$78, DW_AT_name("unsigned char")
	.dwattr $C$DW$T$78, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$78

