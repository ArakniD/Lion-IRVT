;***************************************************************
;* TMS320C2000 G3 C/C++ Codegen                               PC v20.2.4.LTS *
;* Date/Time created: Mon Jan 11 08:47:46 2021                 *
;***************************************************************
	.compiler_opts --abi=eabi --cla_support=cla1 --diag_wrap=off --float_support=fpu32 --hll_source=on --mem_model:code=flat --mem_model:data=large --object_format=elf --quiet --silicon_errata_fpu1_workaround=off --silicon_version=28 --symdebug:dwarf --symdebug:dwarf_version=4 --tmu_support=tmu0 --vcu_support=vcu2 
	.asg	XAR2, FP

$C$DW$CU	.dwtag  DW_TAG_compile_unit
	.dwattr $C$DW$CU, DW_AT_name("../device/device.c")
	.dwattr $C$DW$CU, DW_AT_producer("TI TMS320C2000 G3 C/C++ Codegen PC v20.2.4.LTS Copyright (c) 1996-2018 Texas Instruments Incorporated")
	.dwattr $C$DW$CU, DW_AT_TI_version(0x01)
	.dwattr $C$DW$CU, DW_AT_comp_dir("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\RELEASE")

$C$DW$1	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$1, DW_AT_name("Flash_initModule")
	.dwattr $C$DW$1, DW_AT_linkage_name("Flash_initModule")
	.dwattr $C$DW$1, DW_AT_declaration
	.dwattr $C$DW$1, DW_AT_external
	.dwattr $C$DW$1, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/flash.h")
	.dwattr $C$DW$1, DW_AT_decl_line(0x649)
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
	.dwattr $C$DW$5, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$5, DW_AT_decl_line(0x325)
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
	.dwattr $C$DW$8, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$8, DW_AT_decl_line(0x395)
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
	.dwattr $C$DW$11, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$11, DW_AT_decl_line(0x401)
	.dwattr $C$DW$11, DW_AT_decl_column(0x01)
$C$DW$12	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$12, DW_AT_type(*$C$DW$T$47)

	.dwendtag $C$DW$11


$C$DW$13	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$13, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$13, DW_AT_linkage_name("GPIO_setMasterCore")
	.dwattr $C$DW$13, DW_AT_declaration
	.dwattr $C$DW$13, DW_AT_external
	.dwattr $C$DW$13, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$13, DW_AT_decl_line(0x3d1)
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


$C$DW$19	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$19, DW_AT_name("SysCtl_getDeviceParametric")
	.dwattr $C$DW$19, DW_AT_linkage_name("SysCtl_getDeviceParametric")
	.dwattr $C$DW$19, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$19, DW_AT_declaration
	.dwattr $C$DW$19, DW_AT_external
	.dwattr $C$DW$19, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$19, DW_AT_decl_line(0xca4)
	.dwattr $C$DW$19, DW_AT_decl_column(0x01)
$C$DW$20	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$20, DW_AT_type(*$C$DW$T$28)

	.dwendtag $C$DW$19


$C$DW$21	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$21, DW_AT_name("SysCtl_setClock")
	.dwattr $C$DW$21, DW_AT_linkage_name("SysCtl_setClock")
	.dwattr $C$DW$21, DW_AT_type(*$C$DW$T$77)
	.dwattr $C$DW$21, DW_AT_declaration
	.dwattr $C$DW$21, DW_AT_external
	.dwattr $C$DW$21, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$21, DW_AT_decl_line(0xc56)
	.dwattr $C$DW$21, DW_AT_decl_column(0x01)
$C$DW$22	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$22, DW_AT_type(*$C$DW$T$47)

	.dwendtag $C$DW$21

	.global	||Example_Result||
	.data
	.align	2
	.elfsym	||Example_Result||,SYM_SIZE(2),SYM_BLOCKED(1)
||Example_Result||:
	.bits		0x1,32
			; Example_Result @ 0

$C$DW$23	.dwtag  DW_TAG_variable
	.dwattr $C$DW$23, DW_AT_name("Example_Result")
	.dwattr $C$DW$23, DW_AT_linkage_name("Example_Result")
	.dwattr $C$DW$23, DW_AT_location[DW_OP_addr ||Example_Result||]
	.dwattr $C$DW$23, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$23, DW_AT_external
	.dwattr $C$DW$23, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$23, DW_AT_decl_line(0x39)
	.dwattr $C$DW$23, DW_AT_decl_column(0x0a)

	.global	||Example_PassCount||
	.data
	.align	2
	.elfsym	||Example_PassCount||,SYM_SIZE(2),SYM_BLOCKED(1)
||Example_PassCount||:
	.bits		0,32
			; Example_PassCount @ 0

$C$DW$24	.dwtag  DW_TAG_variable
	.dwattr $C$DW$24, DW_AT_name("Example_PassCount")
	.dwattr $C$DW$24, DW_AT_linkage_name("Example_PassCount")
	.dwattr $C$DW$24, DW_AT_location[DW_OP_addr ||Example_PassCount||]
	.dwattr $C$DW$24, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$24, DW_AT_external
	.dwattr $C$DW$24, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$24, DW_AT_decl_line(0x3a)
	.dwattr $C$DW$24, DW_AT_decl_column(0x0a)

	.global	||Example_Fail||
	.data
	.align	2
	.elfsym	||Example_Fail||,SYM_SIZE(2),SYM_BLOCKED(1)
||Example_Fail||:
	.bits		0,32
			; Example_Fail @ 0

$C$DW$25	.dwtag  DW_TAG_variable
	.dwattr $C$DW$25, DW_AT_name("Example_Fail")
	.dwattr $C$DW$25, DW_AT_linkage_name("Example_Fail")
	.dwattr $C$DW$25, DW_AT_location[DW_OP_addr ||Example_Fail||]
	.dwattr $C$DW$25, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$25, DW_AT_external
	.dwattr $C$DW$25, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$25, DW_AT_decl_line(0x3b)
	.dwattr $C$DW$25, DW_AT_decl_column(0x0a)


$C$DW$26	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$26, DW_AT_name("__eallow")
	.dwattr $C$DW$26, DW_AT_linkage_name("__eallow")
	.dwattr $C$DW$26, DW_AT_declaration
	.dwattr $C$DW$26, DW_AT_external
	.dwendtag $C$DW$26


$C$DW$27	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$27, DW_AT_name("__edis")
	.dwattr $C$DW$27, DW_AT_linkage_name("__edis")
	.dwattr $C$DW$27, DW_AT_declaration
	.dwattr $C$DW$27, DW_AT_external
	.dwendtag $C$DW$27

	.sblock	".data"
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\opt2000.exe C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{5A8C1277-14DB-49EB-9E9C-6EAF568B2B8B} C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{661B7938-AE3A-4546-A672-0C6A389D2435} 
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\acia2000.exe -@C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{58FB0A8C-E133-4B78-A163-AC45A79C0041} 
	.sect	".text"
	.clink
	.global	||__error__||

$C$DW$28	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$28, DW_AT_name("__error__")
	.dwattr $C$DW$28, DW_AT_low_pc(||__error__||)
	.dwattr $C$DW$28, DW_AT_high_pc(0x00)
	.dwattr $C$DW$28, DW_AT_linkage_name("__error__")
	.dwattr $C$DW$28, DW_AT_external
	.dwattr $C$DW$28, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$28, DW_AT_decl_line(0x2a2)
	.dwattr $C$DW$28, DW_AT_decl_column(0x06)
	.dwattr $C$DW$28, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 675,column 1,is_stmt,address ||__error__||,isa 0

	.dwfde $C$DW$CIE, ||__error__||
$C$DW$29	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$29, DW_AT_name("filename")
	.dwattr $C$DW$29, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$29, DW_AT_location[DW_OP_reg12]

$C$DW$30	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$30, DW_AT_name("line")
	.dwattr $C$DW$30, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$30, DW_AT_location[DW_OP_reg0]


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
$C$DW$31	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$31, DW_AT_low_pc(0x00)
	.dwattr $C$DW$31, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$28, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$28, DW_AT_TI_end_line(0x2a9)
	.dwattr $C$DW$28, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$28

	.sect	".text"
	.clink
	.global	||Example_setResultPass||

$C$DW$32	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$32, DW_AT_name("Example_setResultPass")
	.dwattr $C$DW$32, DW_AT_low_pc(||Example_setResultPass||)
	.dwattr $C$DW$32, DW_AT_high_pc(0x00)
	.dwattr $C$DW$32, DW_AT_linkage_name("Example_setResultPass")
	.dwattr $C$DW$32, DW_AT_external
	.dwattr $C$DW$32, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$32, DW_AT_decl_line(0x2ab)
	.dwattr $C$DW$32, DW_AT_decl_column(0x06)
	.dwattr $C$DW$32, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 684,column 1,is_stmt,address ||Example_setResultPass||,isa 0

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
	.dwpsn	file "../device/device.c",line 685,column 5,is_stmt,isa 0
        MOVB      ACC,#0                ; [CPU_ALU] |685| 
        MOVW      DP,#||Example_Result|| ; [CPU_ARAU] 
        MOVL      @||Example_Result||,ACC ; [CPU_ALU] |685| 
$C$DW$33	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$33, DW_AT_low_pc(0x00)
	.dwattr $C$DW$33, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$32, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$32, DW_AT_TI_end_line(0x2ae)
	.dwattr $C$DW$32, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$32

	.sect	".text"
	.clink
	.global	||Example_setResultFail||

$C$DW$34	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$34, DW_AT_name("Example_setResultFail")
	.dwattr $C$DW$34, DW_AT_low_pc(||Example_setResultFail||)
	.dwattr $C$DW$34, DW_AT_high_pc(0x00)
	.dwattr $C$DW$34, DW_AT_linkage_name("Example_setResultFail")
	.dwattr $C$DW$34, DW_AT_external
	.dwattr $C$DW$34, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$34, DW_AT_decl_line(0x2b0)
	.dwattr $C$DW$34, DW_AT_decl_column(0x06)
	.dwattr $C$DW$34, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 689,column 1,is_stmt,address ||Example_setResultFail||,isa 0

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
	.dwpsn	file "../device/device.c",line 690,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |690| 
        MOVW      DP,#||Example_Result|| ; [CPU_ARAU] 
        MOVL      @||Example_Result||,ACC ; [CPU_ALU] |690| 
$C$DW$35	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$35, DW_AT_low_pc(0x00)
	.dwattr $C$DW$35, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$34, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$34, DW_AT_TI_end_line(0x2b3)
	.dwattr $C$DW$34, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$34

	.sect	".text"
	.clink
	.global	||Example_done||

$C$DW$36	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$36, DW_AT_name("Example_done")
	.dwattr $C$DW$36, DW_AT_low_pc(||Example_done||)
	.dwattr $C$DW$36, DW_AT_high_pc(0x00)
	.dwattr $C$DW$36, DW_AT_linkage_name("Example_done")
	.dwattr $C$DW$36, DW_AT_external
	.dwattr $C$DW$36, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$36, DW_AT_decl_line(0x2b5)
	.dwattr $C$DW$36, DW_AT_decl_column(0x06)
	.dwattr $C$DW$36, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 694,column 1,is_stmt,address ||Example_done||,isa 0

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
	.dwpsn	file "../device/device.c",line 695,column 11,is_stmt,isa 0
        B         ||$C$L1||,UNC         ; [CPU_ALU] |695| 
        ; branch occurs ; [] |695| 
	.dwattr $C$DW$36, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$36, DW_AT_TI_end_line(0x2b8)
	.dwattr $C$DW$36, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$36

	.sect	".text"
	.clink
	.global	||Device_enableUnbondedGPIOPullupsFor176Pin||

$C$DW$37	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$37, DW_AT_name("Device_enableUnbondedGPIOPullupsFor176Pin")
	.dwattr $C$DW$37, DW_AT_low_pc(||Device_enableUnbondedGPIOPullupsFor176Pin||)
	.dwattr $C$DW$37, DW_AT_high_pc(0x00)
	.dwattr $C$DW$37, DW_AT_linkage_name("Device_enableUnbondedGPIOPullupsFor176Pin")
	.dwattr $C$DW$37, DW_AT_external
	.dwattr $C$DW$37, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$37, DW_AT_decl_line(0x114)
	.dwattr $C$DW$37, DW_AT_decl_column(0x06)
	.dwattr $C$DW$37, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../device/device.c",line 277,column 1,is_stmt,address ||Device_enableUnbondedGPIOPullupsFor176Pin||,isa 0

	.dwfde $C$DW$CIE, ||Device_enableUnbondedGPIOPullupsFor176Pin||

;***************************************************************
;* FNAME: Device_enableUnbondedGPIOPullupsFor176Pin FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  2 SOE     *
;***************************************************************

||Device_enableUnbondedGPIOPullupsFor176Pin||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR2            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 9, 2
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../device/device.c",line 278,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |278| 
	.dwpsn	file "../device/device.c",line 279,column 5,is_stmt,isa 0
        MOV       AL,#65535             ; [CPU_ALU] |279| 
        MOV       AH,#32767             ; [CPU_ALU] |279| 
        MOVL      XAR0,#31884           ; [CPU_ARAU] |279| 
	.dwpsn	file "../device/device.c",line 280,column 5,is_stmt,isa 0
        MOVL      XAR7,#31948           ; [CPU_ARAU] |280| 
	.dwpsn	file "../device/device.c",line 281,column 5,is_stmt,isa 0
        MOV       PL,#32                ; [CPU_ALU] |281| 
        MOV       PH,#0                 ; [CPU_ALU] |281| 
        MOVL      XAR6,#32012           ; [CPU_ARAU] |281| 
	.dwpsn	file "../device/device.c",line 280,column 5,is_stmt,isa 0
        MOVB      XAR2,#8               ; [CPU_ALU] |280| 
	.dwpsn	file "../device/device.c",line 282,column 5,is_stmt,isa 0
        MOVL      XAR4,#65024           ; [CPU_ARAU] |282| 
        MOVL      XAR5,#32076           ; [CPU_ARAU] |282| 
	.dwpsn	file "../device/device.c",line 279,column 5,is_stmt,isa 0
        MOVL      *+XAR0[0],ACC         ; [CPU_ALU] |279| 
	.dwpsn	file "../device/device.c",line 280,column 5,is_stmt,isa 0
        MOVL      *+XAR7[0],XAR2        ; [CPU_ALU] |280| 
	.dwpsn	file "../device/device.c",line 281,column 5,is_stmt,isa 0
        MOVL      *+XAR6[0],P           ; [CPU_ALU] |281| 
	.dwpsn	file "../device/device.c",line 282,column 5,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |282| 
	.dwpsn	file "../device/device.c",line 283,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |283| 
        MOVL      XAR2,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 9
$C$DW$38	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$38, DW_AT_low_pc(0x00)
	.dwattr $C$DW$38, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$37, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$37, DW_AT_TI_end_line(0x11c)
	.dwattr $C$DW$37, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$37

	.sect	".text"
	.clink
	.global	||Device_enableUnbondedGPIOPullupsFor100Pin||

$C$DW$39	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$39, DW_AT_name("Device_enableUnbondedGPIOPullupsFor100Pin")
	.dwattr $C$DW$39, DW_AT_low_pc(||Device_enableUnbondedGPIOPullupsFor100Pin||)
	.dwattr $C$DW$39, DW_AT_high_pc(0x00)
	.dwattr $C$DW$39, DW_AT_linkage_name("Device_enableUnbondedGPIOPullupsFor100Pin")
	.dwattr $C$DW$39, DW_AT_external
	.dwattr $C$DW$39, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$39, DW_AT_decl_line(0x130)
	.dwattr $C$DW$39, DW_AT_decl_column(0x06)
	.dwattr $C$DW$39, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../device/device.c",line 305,column 1,is_stmt,address ||Device_enableUnbondedGPIOPullupsFor100Pin||,isa 0

	.dwfde $C$DW$CIE, ||Device_enableUnbondedGPIOPullupsFor100Pin||

;***************************************************************
;* FNAME: Device_enableUnbondedGPIOPullupsFor100Pin FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  2 SOE     *
;***************************************************************

||Device_enableUnbondedGPIOPullupsFor100Pin||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR2            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 9, 2
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../device/device.c",line 306,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |306| 
	.dwpsn	file "../device/device.c",line 307,column 5,is_stmt,isa 0
        MOVL      XAR5,#4193308         ; [CPU_ARAU] |307| 
        MOVL      XAR6,#31756           ; [CPU_ARAU] |307| 
	.dwpsn	file "../device/device.c",line 308,column 5,is_stmt,isa 0
        MOV       AL,#3584              ; [CPU_ALU] |308| 
        MOV       AH,#64512             ; [CPU_ALU] |308| 
        MOVL      XAR4,#31820           ; [CPU_ARAU] |308| 
	.dwpsn	file "../device/device.c",line 309,column 5,is_stmt,isa 0
        MOVL      XAR0,#31884           ; [CPU_ARAU] |309| 
	.dwpsn	file "../device/device.c",line 310,column 5,is_stmt,isa 0
        MOV       PL,#8                 ; [CPU_ALU] |310| 
        MOV       PH,#0                 ; [CPU_ALU] |310| 
        MOVL      XAR7,#31948           ; [CPU_ARAU] |310| 
	.dwpsn	file "../device/device.c",line 311,column 5,is_stmt,isa 0
        MOVB      XAR2,#0               ; [CPU_ALU] |311| 
	.dwpsn	file "../device/device.c",line 307,column 5,is_stmt,isa 0
        MOVL      *+XAR6[0],XAR5        ; [CPU_ALU] |307| 
	.dwpsn	file "../device/device.c",line 311,column 5,is_stmt,isa 0
        MOVL      XAR6,#32012           ; [CPU_ARAU] |311| 
	.dwpsn	file "../device/device.c",line 308,column 5,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |308| 
	.dwpsn	file "../device/device.c",line 312,column 5,is_stmt,isa 0
        MOVL      XAR5,#32076           ; [CPU_ARAU] |312| 
	.dwpsn	file "../device/device.c",line 309,column 5,is_stmt,isa 0
        MOV       AL,#17383             ; [CPU_ALU] |309| 
        MOV       AH,#7920              ; [CPU_ALU] |309| 
	.dwpsn	file "../device/device.c",line 312,column 5,is_stmt,isa 0
        MOVL      XAR4,#65024           ; [CPU_ARAU] |312| 
	.dwpsn	file "../device/device.c",line 309,column 5,is_stmt,isa 0
        MOVL      *+XAR0[0],ACC         ; [CPU_ALU] |309| 
	.dwpsn	file "../device/device.c",line 310,column 5,is_stmt,isa 0
        MOVL      *+XAR7[0],P           ; [CPU_ALU] |310| 
	.dwpsn	file "../device/device.c",line 311,column 5,is_stmt,isa 0
        MOVL      *+XAR6[0],XAR2        ; [CPU_ALU] |311| 
	.dwpsn	file "../device/device.c",line 312,column 5,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |312| 
	.dwpsn	file "../device/device.c",line 313,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |313| 
        MOVL      XAR2,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 9
$C$DW$40	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$40, DW_AT_low_pc(0x00)
	.dwattr $C$DW$40, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$39, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$39, DW_AT_TI_end_line(0x13a)
	.dwattr $C$DW$39, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$39

	.sect	".text"
	.clink
	.global	||Device_enableUnbondedGPIOPullups||

$C$DW$41	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$41, DW_AT_name("Device_enableUnbondedGPIOPullups")
	.dwattr $C$DW$41, DW_AT_low_pc(||Device_enableUnbondedGPIOPullups||)
	.dwattr $C$DW$41, DW_AT_high_pc(0x00)
	.dwattr $C$DW$41, DW_AT_linkage_name("Device_enableUnbondedGPIOPullups")
	.dwattr $C$DW$41, DW_AT_external
	.dwattr $C$DW$41, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$41, DW_AT_decl_line(0x142)
	.dwattr $C$DW$41, DW_AT_decl_column(0x06)
	.dwattr $C$DW$41, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../device/device.c",line 323,column 1,is_stmt,address ||Device_enableUnbondedGPIOPullups||,isa 0

	.dwfde $C$DW$CIE, ||Device_enableUnbondedGPIOPullups||

;***************************************************************
;* FNAME: Device_enableUnbondedGPIOPullups FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  2 SOE     *
;***************************************************************

||Device_enableUnbondedGPIOPullups||:
;* AL    assigned to pinCount
$C$DW$42	.dwtag  DW_TAG_variable
	.dwattr $C$DW$42, DW_AT_name("pinCount")
	.dwattr $C$DW$42, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$42, DW_AT_location[DW_OP_reg0]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR2            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 9, 2
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../device/device.c",line 327,column 23,is_stmt,isa 0
        MOVL      XAR4,#380936          ; [CPU_ARAU] |327| 
        CLRC      SXM                   ; [CPU_ALU] 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |327| 
        SFR       ACC,8                 ; [CPU_ALU] |327| 
        ANDB      AL,#0x07              ; [CPU_ALU] |327| 
        CMPB      AL,#5                 ; [CPU_ALU] |327| 
        B         ||$C$L2||,EQ          ; [CPU_ALU] |327| 
        ; branchcc occurs ; [] |327| 
	.dwpsn	file "../device/device.c",line 340,column 10,is_stmt,isa 0
        CMPB      AL,#6                 ; [CPU_ALU] |340| 
        B         ||$C$L3||,NEQ         ; [CPU_ALU] |340| 
        ; branchcc occurs ; [] |340| 
	.dwpsn	file "../device/device.c",line 278,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |278| 
	.dwpsn	file "../device/device.c",line 279,column 5,is_stmt,isa 0
        MOV       AL,#65535             ; [CPU_ALU] |279| 
        MOV       AH,#32767             ; [CPU_ALU] |279| 
        MOVL      XAR0,#31884           ; [CPU_ARAU] |279| 
	.dwpsn	file "../device/device.c",line 280,column 5,is_stmt,isa 0
        MOVB      XAR2,#8               ; [CPU_ALU] |280| 
        MOVL      XAR7,#31948           ; [CPU_ARAU] |280| 
	.dwpsn	file "../device/device.c",line 281,column 5,is_stmt,isa 0
        MOV       PL,#32                ; [CPU_ALU] |281| 
        MOV       PH,#0                 ; [CPU_ALU] |281| 
        MOVL      XAR6,#32012           ; [CPU_ARAU] |281| 
	.dwpsn	file "../device/device.c",line 282,column 5,is_stmt,isa 0
        MOVL      XAR4,#65024           ; [CPU_ARAU] |282| 
        MOVL      XAR5,#32076           ; [CPU_ARAU] |282| 
	.dwpsn	file "../device/device.c",line 279,column 5,is_stmt,isa 0
        MOVL      *+XAR0[0],ACC         ; [CPU_ALU] |279| 
	.dwpsn	file "../device/device.c",line 280,column 5,is_stmt,isa 0
        MOVL      *+XAR7[0],XAR2        ; [CPU_ALU] |280| 
	.dwpsn	file "../device/device.c",line 281,column 5,is_stmt,isa 0
        MOVL      *+XAR6[0],P           ; [CPU_ALU] |281| 
	.dwpsn	file "../device/device.c",line 282,column 5,is_stmt,isa 0
        MOVL      *+XAR5[0],XAR4        ; [CPU_ALU] |282| 
	.dwpsn	file "../device/device.c",line 283,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |283| 
        B         ||$C$L3||,UNC         ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L2||:    
	.dwpsn	file "../device/device.c",line 338,column 9,is_stmt,isa 0
$C$DW$43	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$43, DW_AT_low_pc(0x00)
	.dwattr $C$DW$43, DW_AT_name("Device_enableUnbondedGPIOPullupsFor100Pin")
	.dwattr $C$DW$43, DW_AT_TI_call

        LCR       #||Device_enableUnbondedGPIOPullupsFor100Pin|| ; [CPU_ALU] |338| 
        ; call occurs [#||Device_enableUnbondedGPIOPullupsFor100Pin||] ; [] |338| 
||$C$L3||:    
        MOVL      XAR2,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 9
$C$DW$44	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$44, DW_AT_low_pc(0x00)
	.dwattr $C$DW$44, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$41, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$41, DW_AT_TI_end_line(0x15e)
	.dwattr $C$DW$41, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$41

	.sect	".text"
	.clink
	.global	||Device_initGPIO||

$C$DW$45	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$45, DW_AT_name("Device_initGPIO")
	.dwattr $C$DW$45, DW_AT_low_pc(||Device_initGPIO||)
	.dwattr $C$DW$45, DW_AT_high_pc(0x00)
	.dwattr $C$DW$45, DW_AT_linkage_name("Device_initGPIO")
	.dwattr $C$DW$45, DW_AT_external
	.dwattr $C$DW$45, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$45, DW_AT_decl_line(0xf6)
	.dwattr $C$DW$45, DW_AT_decl_column(0x06)
	.dwattr $C$DW$45, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 247,column 1,is_stmt,address ||Device_initGPIO||,isa 0

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
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 735,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |735| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 736,column 5,is_stmt,isa 0
        MOVL      XAR4,#31804           ; [CPU_ARAU] |736| 
        MOVB      ACC,#0                ; [CPU_ALU] |736| 
        MOVL      XAR6,*+XAR4[0]        ; [CPU_ALU] |736| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |736| 
        MOVL      XAR4,#31868           ; [CPU_ARAU] |736| 
        MOVL      XAR6,*+XAR4[0]        ; [CPU_ALU] |736| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |736| 
        MOVL      XAR4,#31932           ; [CPU_ARAU] |736| 
        MOVL      XAR6,*+XAR4[0]        ; [CPU_ALU] |736| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |736| 
        MOVL      XAR4,#31996           ; [CPU_ARAU] |736| 
        MOVL      XAR6,*+XAR4[0]        ; [CPU_ALU] |736| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |736| 
        MOVL      XAR4,#32060           ; [CPU_ARAU] |736| 
        MOVL      XAR6,*+XAR4[0]        ; [CPU_ALU] |736| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |736| 
        MOVL      XAR4,#32124           ; [CPU_ARAU] |736| 
        MOVL      XAR6,*+XAR4[0]        ; [CPU_ALU] |736| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |736| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 737,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |737| 
	.dwpsn	file "../device/device.c",line 261,column 5,is_stmt,isa 0
$C$DW$46	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$46, DW_AT_low_pc(0x00)
	.dwattr $C$DW$46, DW_AT_name("Device_enableUnbondedGPIOPullups")
	.dwattr $C$DW$46, DW_AT_TI_call

        LCR       #||Device_enableUnbondedGPIOPullups|| ; [CPU_ALU] |261| 
        ; call occurs [#||Device_enableUnbondedGPIOPullups||] ; [] |261| 
$C$DW$47	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$47, DW_AT_low_pc(0x00)
	.dwattr $C$DW$47, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$45, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$45, DW_AT_TI_end_line(0x106)
	.dwattr $C$DW$45, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$45

	.sect	".text"
	.clink
	.global	||Device_configureTMXAnalogTrim||

$C$DW$48	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$48, DW_AT_name("Device_configureTMXAnalogTrim")
	.dwattr $C$DW$48, DW_AT_low_pc(||Device_configureTMXAnalogTrim||)
	.dwattr $C$DW$48, DW_AT_high_pc(0x00)
	.dwattr $C$DW$48, DW_AT_linkage_name("Device_configureTMXAnalogTrim")
	.dwattr $C$DW$48, DW_AT_external
	.dwattr $C$DW$48, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$48, DW_AT_decl_line(0x166)
	.dwattr $C$DW$48, DW_AT_decl_column(0x06)
	.dwattr $C$DW$48, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 359,column 1,is_stmt,address ||Device_configureTMXAnalogTrim||,isa 0

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
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 887,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |887| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 892,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381756          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
	.dwpsn	file "../device/device.c",line 372,column 5,is_stmt,isa 0
        MOVL      XAR7,#381366          ; [CPU_ARAU] |372| 
	.dwpsn	file "../device/device.c",line 373,column 5,is_stmt,isa 0
        MOVL      XAR6,#381368          ; [CPU_ARAU] |373| 
	.dwpsn	file "../device/device.c",line 374,column 5,is_stmt,isa 0
        MOVL      XAR5,#381370          ; [CPU_ARAU] |374| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 892,column 5,is_stmt,isa 0
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#2                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#4                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#8                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
	.dwpsn	file "../device/device.c",line 372,column 5,is_stmt,isa 0
        MOV       *+XAR7[0],#31709      ; [CPU_ALU] |372| 
	.dwpsn	file "../device/device.c",line 375,column 5,is_stmt,isa 0
        MOVL      XAR4,#381372          ; [CPU_ARAU] |375| 
	.dwpsn	file "../device/device.c",line 373,column 5,is_stmt,isa 0
        MOV       *+XAR6[0],#31709      ; [CPU_ALU] |373| 
	.dwpsn	file "../device/device.c",line 374,column 5,is_stmt,isa 0
        MOV       *+XAR5[0],#31709      ; [CPU_ALU] |374| 
	.dwpsn	file "../device/device.c",line 375,column 5,is_stmt,isa 0
        MOV       *+XAR4[0],#31709      ; [CPU_ALU] |375| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 928,column 5,is_stmt,isa 0
        MOVL      XAR4,#381756          ; [CPU_ARAU] |928| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |928| 
        AND       AL,#65534             ; [CPU_ALU] |928| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |928| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |928| 
        AND       AL,#65533             ; [CPU_ALU] |928| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |928| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |928| 
        AND       AL,#65531             ; [CPU_ALU] |928| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |928| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |928| 
        AND       AL,#65527             ; [CPU_ALU] |928| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |928| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 930,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |930| 
$C$DW$49	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$49, DW_AT_low_pc(0x00)
	.dwattr $C$DW$49, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$48, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$48, DW_AT_TI_end_line(0x19d)
	.dwattr $C$DW$48, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$48

	.sect	".text"
	.clink
	.global	||Device_enableAllPeripherals||

$C$DW$50	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$50, DW_AT_name("Device_enableAllPeripherals")
	.dwattr $C$DW$50, DW_AT_low_pc(||Device_enableAllPeripherals||)
	.dwattr $C$DW$50, DW_AT_high_pc(0x00)
	.dwattr $C$DW$50, DW_AT_linkage_name("Device_enableAllPeripherals")
	.dwattr $C$DW$50, DW_AT_external
	.dwattr $C$DW$50, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$50, DW_AT_decl_line(0x9a)
	.dwattr $C$DW$50, DW_AT_decl_column(0x06)
	.dwattr $C$DW$50, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../device/device.c",line 155,column 1,is_stmt,address ||Device_enableAllPeripherals||,isa 0

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
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 887,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |887| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 892,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381730          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#4                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#8                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#16               ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#32               ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |892| 
        OR        AH,#1                 ; [CPU_ALU] |892| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |892| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |892| 
        OR        AH,#4                 ; [CPU_ALU] |892| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |892| 
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381732          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#2                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381734          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#2                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#4                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#8                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#16               ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#32               ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#64               ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#128              ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |892| 
        OR        AL,#1024              ; [CPU_ALU] |892| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |892| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |892| 
        OR        AL,#2048              ; [CPU_ALU] |892| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |892| 
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381736          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#2                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#4                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#8                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#16               ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#32               ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381738          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#2                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#4                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381742          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#2                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381744          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#2                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#4                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#8                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381746          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#4                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381748          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#2                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381750          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVL      XAR4,#381752          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#2                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |892| 
        OR        AH,#1                 ; [CPU_ALU] |892| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |892| 
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381754          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVL      XAR4,#381756          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#2                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#4                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#8                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381758          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#2                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#4                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#8                ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#16               ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#32               ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#64               ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVB      ACC,#128              ; [CPU_ALU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
        MOVL      XAR4,#381762          ; [CPU_ARAU] |892| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |892| 
        OR        AH,#1                 ; [CPU_ALU] |892| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |892| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |892| 
        OR        AH,#2                 ; [CPU_ALU] |892| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |892| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |892| 
        OR        AH,#4                 ; [CPU_ALU] |892| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |892| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 894,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |894| 
$C$DW$51	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$51, DW_AT_low_pc(0x00)
	.dwattr $C$DW$51, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$50, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$50, DW_AT_TI_end_line(0xef)
	.dwattr $C$DW$50, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$50

	.sect	".text"
	.clink
	.global	||Device_init||

$C$DW$52	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$52, DW_AT_name("Device_init")
	.dwattr $C$DW$52, DW_AT_low_pc(||Device_init||)
	.dwattr $C$DW$52, DW_AT_high_pc(0x00)
	.dwattr $C$DW$52, DW_AT_linkage_name("Device_init")
	.dwattr $C$DW$52, DW_AT_external
	.dwattr $C$DW$52, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$52, DW_AT_decl_line(0x44)
	.dwattr $C$DW$52, DW_AT_decl_column(0x06)
	.dwattr $C$DW$52, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../device/device.c",line 69,column 1,is_stmt,address ||Device_init||,isa 0

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
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1830,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |1830| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1835,column 5,is_stmt,isa 0
        MOV       AL,*(0:0x7029)        ; [CPU_ALU] |1835| 
        ORB       AL,#0x68              ; [CPU_ALU] |1835| 
        MOV       *(0:0x7029),AL        ; [CPU_ALU] |1835| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1837,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |1837| 
	.dwpsn	file "../device/device.c",line 83,column 5,is_stmt,isa 0
        MOVL      XAR5,#||RamfuncsLoadStart|| ; [CPU_ARAU] |83| 
        MOV       AH,#$HI16(||RamfuncsLoadSize||) + 0 ; [CPU_ALU] |83| 
        MOVL      XAR4,#||RamfuncsRunStart|| ; [CPU_ARAU] |83| 
        MOV       AL,#$LO16(||RamfuncsLoadSize||) + 0 ; [CPU_ALU] |83| 
$C$DW$53	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$53, DW_AT_low_pc(0x00)
	.dwattr $C$DW$53, DW_AT_name("memcpy")
	.dwattr $C$DW$53, DW_AT_TI_call

        LCR       #||memcpy||           ; [CPU_ALU] |83| 
        ; call occurs [#||memcpy||] ; [] |83| 
	.dwpsn	file "../device/device.c",line 89,column 5,is_stmt,isa 0
        MOVL      XAR4,#391936          ; [CPU_ARAU] |89| 
        MOVL      XAR5,#391168          ; [CPU_ARAU] |89| 
        MOVL      *-SP[2],XAR4          ; [CPU_ALU] |89| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |89| 
        MOVB      XAR4,#3               ; [CPU_ALU] |89| 
$C$DW$54	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$54, DW_AT_low_pc(0x00)
	.dwattr $C$DW$54, DW_AT_name("Flash_initModule")
	.dwattr $C$DW$54, DW_AT_TI_call

        LCR       #||Flash_initModule|| ; [CPU_ALU] |89| 
        ; call occurs [#||Flash_initModule||] ; [] |89| 
	.dwpsn	file "../device/device.c",line 96,column 5,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |96| 
$C$DW$55	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$55, DW_AT_low_pc(0x00)
	.dwattr $C$DW$55, DW_AT_name("SysCtl_getDeviceParametric")
	.dwattr $C$DW$55, DW_AT_TI_call

        LCR       #||SysCtl_getDeviceParametric|| ; [CPU_ALU] |96| 
        ; call occurs [#||SysCtl_getDeviceParametric||] ; [] |96| 
        CMPB      AL,#0                 ; [CPU_ALU] |96| 
        B         ||$C$L4||,NEQ         ; [CPU_ALU] |96| 
        ; branchcc occurs ; [] |96| 
        MOVL      XAR4,#381366          ; [CPU_ARAU] |96| 
        MOV       AL,*+XAR4[0]          ; [CPU_ALU] |96| 
        B         ||$C$L4||,NEQ         ; [CPU_ALU] |96| 
        ; branchcc occurs ; [] |96| 
	.dwpsn	file "../device/device.c",line 99,column 9,is_stmt,isa 0
$C$DW$56	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$56, DW_AT_low_pc(0x00)
	.dwattr $C$DW$56, DW_AT_name("Device_configureTMXAnalogTrim")
	.dwattr $C$DW$56, DW_AT_TI_call

        LCR       #||Device_configureTMXAnalogTrim|| ; [CPU_ALU] |99| 
        ; call occurs [#||Device_configureTMXAnalogTrim||] ; [] |99| 
||$C$L4||:    
	.dwpsn	file "../device/device.c",line 105,column 5,is_stmt,isa 0
        MOV       AL,#148               ; [CPU_ALU] |105| 
        MOV       AH,#32769             ; [CPU_ALU] |105| 
$C$DW$57	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$57, DW_AT_low_pc(0x00)
	.dwattr $C$DW$57, DW_AT_name("SysCtl_setClock")
	.dwattr $C$DW$57, DW_AT_TI_call

        LCR       #||SysCtl_setClock||  ; [CPU_ALU] |105| 
        ; call occurs [#||SysCtl_setClock||] ; [] |105| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1077,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |1077| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1078,column 5,is_stmt,isa 0
        MOVL      XAR4,#381484          ; [CPU_ARAU] |1078| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |1078| 
        AND       AL,#65528             ; [CPU_ALU] |1078| 
        ANDB      AH,#0                 ; [CPU_ALU] |1078| 
        ORB       AL,#0x02              ; [CPU_ALU] |1078| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |1078| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 1081,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |1081| 
	.dwpsn	file "../device/device.c",line 138,column 5,is_stmt,isa 0
$C$DW$58	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$58, DW_AT_low_pc(0x00)
	.dwattr $C$DW$58, DW_AT_name("Device_enableAllPeripherals")
	.dwattr $C$DW$58, DW_AT_TI_call

        LCR       #||Device_enableAllPeripherals|| ; [CPU_ALU] |138| 
        ; call occurs [#||Device_enableAllPeripherals||] ; [] |138| 
        MOVW      DP,#||Example_Result|| ; [CPU_ARAU] 
	.dwpsn	file "../device/device.c",line 143,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |143| 
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOVL      @||Example_Result||,ACC ; [CPU_ALU] |143| 
$C$DW$59	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$59, DW_AT_low_pc(0x00)
	.dwattr $C$DW$59, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$52, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$52, DW_AT_TI_end_line(0x90)
	.dwattr $C$DW$52, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$52

	.sect	".text"
	.clink
	.global	||Device_bootCPU2||

$C$DW$60	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$60, DW_AT_name("Device_bootCPU2")
	.dwattr $C$DW$60, DW_AT_low_pc(||Device_bootCPU2||)
	.dwattr $C$DW$60, DW_AT_high_pc(0x00)
	.dwattr $C$DW$60, DW_AT_linkage_name("Device_bootCPU2")
	.dwattr $C$DW$60, DW_AT_external
	.dwattr $C$DW$60, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$60, DW_AT_decl_file("../device/device.c")
	.dwattr $C$DW$60, DW_AT_decl_line(0x1ba)
	.dwattr $C$DW$60, DW_AT_decl_column(0x01)
	.dwattr $C$DW$60, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "../device/device.c",line 443,column 1,is_stmt,address ||Device_bootCPU2||,isa 0

	.dwfde $C$DW$CIE, ||Device_bootCPU2||
$C$DW$61	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$61, DW_AT_name("bootMode")
	.dwattr $C$DW$61, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$61, DW_AT_location[DW_OP_reg0]


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
$C$DW$62	.dwtag  DW_TAG_variable
	.dwattr $C$DW$62, DW_AT_name("bootMode")
	.dwattr $C$DW$62, DW_AT_type(*$C$DW$T$76)
	.dwattr $C$DW$62, DW_AT_location[DW_OP_reg8]

;* AR1   assigned to pin
$C$DW$63	.dwtag  DW_TAG_variable
	.dwattr $C$DW$63, DW_AT_name("pin")
	.dwattr $C$DW$63, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$63, DW_AT_location[DW_OP_reg6]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
	.dwpsn	file "../device/device.c",line 452,column 5,is_stmt,isa 0
        MOVL      XAR4,#327712          ; [CPU_ARAU] |452| 
        MOVB      XAR6,#3               ; [CPU_ALU] |452| 
        MOVL      *SP++,XAR2            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 9, 4
	.dwcfi	cfa_offset, -6
	.dwpsn	file "../device/device.c",line 443,column 1,is_stmt,isa 0
        MOVL      XAR2,ACC              ; [CPU_ALU] |443| 
	.dwpsn	file "../device/device.c",line 452,column 5,is_stmt,isa 0
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |452| 
        MOVB      AH,#0                 ; [CPU_ALU] |452| 
        ANDB      AL,#0x0f              ; [CPU_ALU] |452| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |452| 
        B         ||$C$L5||,NEQ         ; [CPU_ALU] |452| 
        ; branchcc occurs ; [] |452| 
	.dwpsn	file "../device/device.c",line 459,column 9,is_stmt,isa 0
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |459| 
        ANDB      AL,#0                 ; [CPU_ALU] |459| 
        AND       AH,#32768             ; [CPU_ALU] |459| 
        TEST      ACC                   ; [CPU_ALU] |459| 
        B         ||$C$L8||,NEQ         ; [CPU_ALU] |459| 
        ; branchcc occurs ; [] |459| 
||$C$L5||:    
	.dwpsn	file "../device/device.c",line 476,column 9,is_stmt,isa 0
        TBIT      *+XAR4[0],#1          ; [CPU_ALU] |476| 
        B         ||$C$L5||,NTC         ; [CPU_ALU] |476| 
        ; branchcc occurs ; [] |476| 
	.dwpsn	file "../device/device.c",line 483,column 12,is_stmt,isa 0
        MOVL      XAR4,#327688          ; [CPU_ARAU] |483| 
||$C$L6||:    
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |483| 
        TBIT      AL,#0                 ; [CPU_ALU] |483| 
        B         ||$C$L7||,NTC         ; [CPU_ALU] |483| 
        ; branchcc occurs ; [] |483| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |483| 
        TBIT      AL,#0                 ; [CPU_ALU] |483| 
        B         ||$C$L6||,TC          ; [CPU_ALU] |483| 
        ; branchcc occurs ; [] |483| 
||$C$L7||:    
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |483| 
        ANDB      AL,#0                 ; [CPU_ALU] |483| 
        AND       AH,#32768             ; [CPU_ALU] |483| 
        TEST      ACC                   ; [CPU_ALU] |483| 
        B         ||$C$L6||,NEQ         ; [CPU_ALU] |483| 
        ; branchcc occurs ; [] |483| 
	.dwpsn	file "../device/device.c",line 489,column 5,is_stmt,isa 0
        MOVB      ACC,#12               ; [CPU_ALU] |489| 
        CMPL      ACC,XAR2              ; [CPU_ALU] |489| 
        B         ||$C$L9||,HI          ; [CPU_ALU] |489| 
        ; branchcc occurs ; [] |489| 
||$C$L8||:    
	.dwpsn	file "../device/device.c",line 666,column 5,is_stmt,isa 0
        MOVB      XAR7,#1               ; [CPU_ALU] |666| 
        B         ||$C$L18||,UNC        ; [CPU_ALU] |666| 
        ; branch occurs ; [] |666| 
||$C$L9||:    
	.dwpsn	file "../device/device.c",line 499,column 9,is_stmt,isa 0
        MOVL      XAR6,XAR2             ; [CPU_ALU] |499| 
        MOVB      ACC,#4                ; [CPU_ALU] |499| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |499| 
        B         ||$C$L10||,LT         ; [CPU_ALU] |499| 
        ; branchcc occurs ; [] |499| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |499| 
        B         ||$C$L12||,EQ         ; [CPU_ALU] |499| 
        ; branchcc occurs ; [] |499| 
        MOVL      ACC,XAR6              ; [CPU_ALU] 
        B         ||$C$L14||,EQ         ; [CPU_ALU] |499| 
        ; branchcc occurs ; [] |499| 
        MOVB      ACC,#1                ; [CPU_ALU] |499| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |499| 
        B         ||$C$L13||,EQ         ; [CPU_ALU] |499| 
        ; branchcc occurs ; [] |499| 
        B         ||$C$L17||,UNC        ; [CPU_ALU] |499| 
        ; branch occurs ; [] |499| 
||$C$L10||:    
        MOVB      ACC,#5                ; [CPU_ALU] |499| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |499| 
        B         ||$C$L11||,EQ         ; [CPU_ALU] |499| 
        ; branchcc occurs ; [] |499| 
        MOVB      ACC,#7                ; [CPU_ALU] |499| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |499| 
        B         ||$C$L17||,NEQ        ; [CPU_ALU] |499| 
        ; branchcc occurs ; [] |499| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 735,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |735| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 736,column 5,is_stmt,isa 0
        MOVL      XAR4,#31932           ; [CPU_ARAU] |736| 
        MOVB      ACC,#0                ; [CPU_ALU] |736| 
        MOVL      XAR6,*+XAR4[0]        ; [CPU_ALU] |736| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |736| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 737,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |737| 
	.dwpsn	file "../device/device.c",line 626,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |626| 
        MOVB      ACC,#71               ; [CPU_ALU] |626| 
$C$DW$64	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$64, DW_AT_low_pc(0x00)
	.dwattr $C$DW$64, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$64, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |626| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |626| 
	.dwpsn	file "../device/device.c",line 627,column 18,is_stmt,isa 0
        MOV       AL,#3589              ; [CPU_ALU] |627| 
        MOV       AH,#134               ; [CPU_ALU] |627| 
$C$DW$65	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$65, DW_AT_low_pc(0x00)
	.dwattr $C$DW$65, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$65, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |627| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |627| 
	.dwpsn	file "../device/device.c",line 628,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |628| 
        MOVB      ACC,#71               ; [CPU_ALU] |628| 
$C$DW$66	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$66, DW_AT_low_pc(0x00)
	.dwattr $C$DW$66, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$66, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |628| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |628| 
	.dwpsn	file "../device/device.c",line 630,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |630| 
        MOVB      ACC,#70               ; [CPU_ALU] |630| 
$C$DW$67	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$67, DW_AT_low_pc(0x00)
	.dwattr $C$DW$67, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$67, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |630| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |630| 
	.dwpsn	file "../device/device.c",line 631,column 18,is_stmt,isa 0
        MOV       AL,#3077              ; [CPU_ALU] |631| 
        MOV       AH,#134               ; [CPU_ALU] |631| 
$C$DW$68	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$68, DW_AT_low_pc(0x00)
	.dwattr $C$DW$68, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$68, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |631| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |631| 
	.dwpsn	file "../device/device.c",line 632,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |632| 
        MOVB      ACC,#70               ; [CPU_ALU] |632| 
$C$DW$69	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$69, DW_AT_low_pc(0x00)
	.dwattr $C$DW$69, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$69, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |632| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |632| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 700,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_ALU] |700| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 701,column 5,is_stmt,isa 0
        MOVL      XAR4,#31932           ; [CPU_ARAU] |701| 
	.dwpsn	file "../device/device.c",line 641,column 18,is_stmt,isa 0
        MOVB      ACC,#12               ; [CPU_ALU] |641| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 701,column 5,is_stmt,isa 0
        OR        *+XAR4[0],#65535      ; [CPU_ALU] |701| 
        OR        *+XAR4[1],#65535      ; [CPU_ALU] |701| 
	.dwpsn	file "../device/device.c",line 641,column 18,is_stmt,isa 0
        MOVL      XAR4,#381450          ; [CPU_ARAU] |641| 
        AND       *+XAR4[0],AL          ; [CPU_ALU] |641| 
        AND       *+XAR4[1],AH          ; [CPU_ALU] |641| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 892,column 5,is_stmt,isa 0
        MOVB      ACC,#1                ; [CPU_ALU] |892| 
        MOVL      XAR4,#381750          ; [CPU_ARAU] |892| 
        OR        *+XAR4[0],AL          ; [CPU_ALU] |892| 
        OR        *+XAR4[1],AH          ; [CPU_ALU] |892| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 894,column 5,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |894| 
	.dwpsn	file "../device/device.c",line 646,column 16,is_stmt,isa 0
        B         ||$C$L17||,UNC        ; [CPU_ALU] |646| 
        ; branch occurs ; [] |646| 
||$C$L11||:    
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2811,column 5,is_stmt,isa 0
        MOVL      XAR4,#381156          ; [CPU_ARAU] |2811| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |2811| 
        AND       AL,#65534             ; [CPU_ALU] |2811| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2815,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_FPU] |2815| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2816,column 5,is_stmt,isa 0
        ORB       AL,#0x01              ; [CPU_ALU] |2816| 
	.dwpsn	file "../device/device.c",line 581,column 18,is_stmt,isa 0
        MOVL      XAR5,#381440          ; [CPU_ARAU] |581| 
	.dwpsn	file "../device/device.c",line 582,column 18,is_stmt,isa 0
        MOVB      XAR6,#2               ; [CPU_ALU] |582| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2816,column 5,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |2816| 
	.dwpsn	file "../device/device.c",line 581,column 18,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |581| 
        MOV       AH,#42405             ; [CPU_ALU] |581| 
	.dwpsn	file "../device/device.c",line 582,column 18,is_stmt,isa 0
        MOVL      XAR4,#381484          ; [CPU_ARAU] |582| 
	.dwpsn	file "../device/device.c",line 581,column 18,is_stmt,isa 0
        MOVL      *+XAR5[0],ACC         ; [CPU_ALU] |581| 
	.dwpsn	file "../device/device.c",line 582,column 18,is_stmt,isa 0
        MOVL      *+XAR4[0],XAR6        ; [CPU_ALU] |582| 
	.dwpsn	file "../device/device.c",line 583,column 18,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |583| 
	.dwpsn	file "../device/device.c",line 585,column 18,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |585| 
        MOVB      ACC,#32               ; [CPU_ALU] |585| 
$C$DW$70	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$70, DW_AT_low_pc(0x00)
	.dwattr $C$DW$70, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$70, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |585| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |585| 
	.dwpsn	file "../device/device.c",line 586,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |586| 
        MOVB      ACC,#32               ; [CPU_ALU] |586| 
$C$DW$71	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$71, DW_AT_low_pc(0x00)
	.dwattr $C$DW$71, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$71, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |586| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |586| 
	.dwpsn	file "../device/device.c",line 587,column 18,is_stmt,isa 0
        MOV       AL,#1                 ; [CPU_ALU] |587| 
        MOV       AH,#70                ; [CPU_ALU] |587| 
$C$DW$72	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$72, DW_AT_low_pc(0x00)
	.dwattr $C$DW$72, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$72, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |587| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |587| 
	.dwpsn	file "../device/device.c",line 588,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |588| 
        MOVB      ACC,#32               ; [CPU_ALU] |588| 
$C$DW$73	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$73, DW_AT_low_pc(0x00)
	.dwattr $C$DW$73, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$73, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |588| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |588| 
	.dwpsn	file "../device/device.c",line 590,column 18,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |590| 
        MOVB      ACC,#33               ; [CPU_ALU] |590| 
$C$DW$74	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$74, DW_AT_low_pc(0x00)
	.dwattr $C$DW$74, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$74, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |590| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |590| 
	.dwpsn	file "../device/device.c",line 591,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |591| 
        MOVB      ACC,#33               ; [CPU_ALU] |591| 
$C$DW$75	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$75, DW_AT_low_pc(0x00)
	.dwattr $C$DW$75, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$75, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |591| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |591| 
	.dwpsn	file "../device/device.c",line 592,column 18,is_stmt,isa 0
        MOV       AL,#513               ; [CPU_ALU] |592| 
        MOV       AH,#70                ; [CPU_ALU] |592| 
$C$DW$76	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$76, DW_AT_low_pc(0x00)
	.dwattr $C$DW$76, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$76, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |592| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |592| 
	.dwpsn	file "../device/device.c",line 593,column 18,is_stmt,isa 0
        MOVB      ACC,#33               ; [CPU_ALU] |593| 
	.dwpsn	file "../device/device.c",line 595,column 17,is_stmt,isa 0
        B         ||$C$L16||,UNC        ; [CPU_ALU] |595| 
        ; branch occurs ; [] |595| 
||$C$L12||:    
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2811,column 5,is_stmt,isa 0
        MOVL      XAR4,#381154          ; [CPU_ARAU] |2811| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |2811| 
        AND       AL,#65534             ; [CPU_ALU] |2811| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2815,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_FPU] |2815| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2816,column 5,is_stmt,isa 0
        ORB       AL,#0x01              ; [CPU_ALU] |2816| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |2816| 
	.dwpsn	file "../device/device.c",line 543,column 18,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |543| 
        MOV       AH,#42405             ; [CPU_ALU] |543| 
        MOVL      XAR4,#381440          ; [CPU_ARAU] |543| 
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |543| 
	.dwpsn	file "../device/device.c",line 544,column 18,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |544| 
	.dwpsn	file "../device/device.c",line 546,column 18,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |546| 
        MOVB      ACC,#16               ; [CPU_ALU] |546| 
$C$DW$77	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$77, DW_AT_low_pc(0x00)
	.dwattr $C$DW$77, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$77, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |546| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |546| 
	.dwpsn	file "../device/device.c",line 547,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |547| 
        MOVB      ACC,#16               ; [CPU_ALU] |547| 
$C$DW$78	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$78, DW_AT_low_pc(0x00)
	.dwattr $C$DW$78, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$78, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |547| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |547| 
	.dwpsn	file "../device/device.c",line 548,column 18,is_stmt,isa 0
        MOVL      XAR4,#524289          ; [CPU_ARAU] |548| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |548| 
$C$DW$79	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$79, DW_AT_low_pc(0x00)
	.dwattr $C$DW$79, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$79, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |548| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |548| 
	.dwpsn	file "../device/device.c",line 549,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |549| 
        MOVB      ACC,#16               ; [CPU_ALU] |549| 
$C$DW$80	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$80, DW_AT_low_pc(0x00)
	.dwattr $C$DW$80, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$80, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |549| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |549| 
	.dwpsn	file "../device/device.c",line 551,column 18,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |551| 
        MOVB      ACC,#17               ; [CPU_ALU] |551| 
$C$DW$81	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$81, DW_AT_low_pc(0x00)
	.dwattr $C$DW$81, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$81, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |551| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |551| 
	.dwpsn	file "../device/device.c",line 552,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |552| 
        MOVB      ACC,#17               ; [CPU_ALU] |552| 
$C$DW$82	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$82, DW_AT_low_pc(0x00)
	.dwattr $C$DW$82, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$82, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |552| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |552| 
	.dwpsn	file "../device/device.c",line 553,column 18,is_stmt,isa 0
        MOVL      XAR4,#524801          ; [CPU_ARAU] |553| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |553| 
$C$DW$83	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$83, DW_AT_low_pc(0x00)
	.dwattr $C$DW$83, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$83, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |553| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |553| 
	.dwpsn	file "../device/device.c",line 554,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |554| 
        MOVB      ACC,#17               ; [CPU_ALU] |554| 
$C$DW$84	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$84, DW_AT_low_pc(0x00)
	.dwattr $C$DW$84, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$84, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |554| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |554| 
	.dwpsn	file "../device/device.c",line 556,column 18,is_stmt,isa 0
        MOVB      ACC,#18               ; [CPU_ALU] |556| 
        MOVB      XAR4,#0               ; [CPU_ALU] |556| 
$C$DW$85	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$85, DW_AT_low_pc(0x00)
	.dwattr $C$DW$85, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$85, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |556| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |556| 
	.dwpsn	file "../device/device.c",line 557,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |557| 
        MOVB      ACC,#18               ; [CPU_ALU] |557| 
$C$DW$86	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$86, DW_AT_low_pc(0x00)
	.dwattr $C$DW$86, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$86, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |557| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |557| 
	.dwpsn	file "../device/device.c",line 558,column 18,is_stmt,isa 0
        MOVL      XAR4,#525313          ; [CPU_ARAU] |558| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |558| 
$C$DW$87	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$87, DW_AT_low_pc(0x00)
	.dwattr $C$DW$87, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$87, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |558| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |558| 
	.dwpsn	file "../device/device.c",line 559,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |559| 
        MOVB      ACC,#18               ; [CPU_ALU] |559| 
$C$DW$88	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$88, DW_AT_low_pc(0x00)
	.dwattr $C$DW$88, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$88, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |559| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |559| 
	.dwpsn	file "../device/device.c",line 561,column 18,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |561| 
        MOVB      ACC,#19               ; [CPU_ALU] |561| 
$C$DW$89	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$89, DW_AT_low_pc(0x00)
	.dwattr $C$DW$89, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$89, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |561| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |561| 
	.dwpsn	file "../device/device.c",line 562,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |562| 
        MOVB      ACC,#19               ; [CPU_ALU] |562| 
$C$DW$90	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$90, DW_AT_low_pc(0x00)
	.dwattr $C$DW$90, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$90, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |562| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |562| 
	.dwpsn	file "../device/device.c",line 563,column 18,is_stmt,isa 0
        MOVL      XAR4,#525824          ; [CPU_ARAU] |563| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |563| 
$C$DW$91	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$91, DW_AT_low_pc(0x00)
	.dwattr $C$DW$91, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$91, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |563| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |563| 
	.dwpsn	file "../device/device.c",line 564,column 18,is_stmt,isa 0
        MOVB      ACC,#19               ; [CPU_ALU] |564| 
	.dwpsn	file "../device/device.c",line 566,column 17,is_stmt,isa 0
        B         ||$C$L16||,UNC        ; [CPU_ALU] |566| 
        ; branch occurs ; [] |566| 
||$C$L13||:    
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2811,column 5,is_stmt,isa 0
        MOVL      XAR4,#381152          ; [CPU_ARAU] |2811| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |2811| 
        AND       AL,#65534             ; [CPU_ALU] |2811| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2815,column 5,is_stmt,isa 0
        EALLOW    ; [CPU_FPU] |2815| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2816,column 5,is_stmt,isa 0
        ORB       AL,#0x01              ; [CPU_ALU] |2816| 
	.dwpsn	file "../device/device.c",line 514,column 18,is_stmt,isa 0
        MOVL      XAR5,#381440          ; [CPU_ARAU] |514| 
	.dwpsn	file "../device/device.c",line 515,column 18,is_stmt,isa 0
        MOVB      XAR6,#2               ; [CPU_ALU] |515| 
	.dwpsn	file "C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h",line 2816,column 5,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |2816| 
	.dwpsn	file "../device/device.c",line 514,column 18,is_stmt,isa 0
        MOVB      AL,#0                 ; [CPU_ALU] |514| 
        MOV       AH,#42405             ; [CPU_ALU] |514| 
	.dwpsn	file "../device/device.c",line 515,column 18,is_stmt,isa 0
        MOVL      XAR4,#381484          ; [CPU_ARAU] |515| 
	.dwpsn	file "../device/device.c",line 514,column 18,is_stmt,isa 0
        MOVL      *+XAR5[0],ACC         ; [CPU_ALU] |514| 
	.dwpsn	file "../device/device.c",line 515,column 18,is_stmt,isa 0
        MOVL      *+XAR4[0],XAR6        ; [CPU_ALU] |515| 
	.dwpsn	file "../device/device.c",line 516,column 18,is_stmt,isa 0
        EDIS      ; [CPU_ALU] |516| 
	.dwpsn	file "../device/device.c",line 518,column 18,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |518| 
        MOVB      ACC,#29               ; [CPU_ALU] |518| 
$C$DW$92	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$92, DW_AT_low_pc(0x00)
	.dwattr $C$DW$92, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$92, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |518| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |518| 
	.dwpsn	file "../device/device.c",line 519,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |519| 
        MOVB      ACC,#29               ; [CPU_ALU] |519| 
$C$DW$93	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$93, DW_AT_low_pc(0x00)
	.dwattr $C$DW$93, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$93, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |519| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |519| 
	.dwpsn	file "../device/device.c",line 520,column 18,is_stmt,isa 0
        MOVL      XAR4,#530945          ; [CPU_ARAU] |520| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |520| 
$C$DW$94	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$94, DW_AT_low_pc(0x00)
	.dwattr $C$DW$94, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$94, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |520| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |520| 
	.dwpsn	file "../device/device.c",line 521,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |521| 
        MOVB      ACC,#29               ; [CPU_ALU] |521| 
$C$DW$95	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$95, DW_AT_low_pc(0x00)
	.dwattr $C$DW$95, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$95, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |521| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |521| 
	.dwpsn	file "../device/device.c",line 523,column 18,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |523| 
        MOVB      ACC,#28               ; [CPU_ALU] |523| 
$C$DW$96	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$96, DW_AT_low_pc(0x00)
	.dwattr $C$DW$96, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$96, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |523| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |523| 
	.dwpsn	file "../device/device.c",line 524,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |524| 
        MOVB      ACC,#28               ; [CPU_ALU] |524| 
$C$DW$97	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$97, DW_AT_low_pc(0x00)
	.dwattr $C$DW$97, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$97, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |524| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |524| 
	.dwpsn	file "../device/device.c",line 525,column 18,is_stmt,isa 0
        MOVL      XAR4,#530433          ; [CPU_ARAU] |525| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |525| 
$C$DW$98	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$98, DW_AT_low_pc(0x00)
	.dwattr $C$DW$98, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$98, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |525| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |525| 
	.dwpsn	file "../device/device.c",line 526,column 18,is_stmt,isa 0
        MOVB      ACC,#28               ; [CPU_ALU] |526| 
	.dwpsn	file "../device/device.c",line 528,column 17,is_stmt,isa 0
        B         ||$C$L16||,UNC        ; [CPU_ALU] |528| 
        ; branch occurs ; [] |528| 
||$C$L14||:    
	.dwpsn	file "../device/device.c",line 599,column 22,is_stmt,isa 0
        MOVB      XAR1,#58              ; [CPU_ALU] |599| 
||$C$L15||:    
	.dwpsn	file "../device/device.c",line 601,column 22,is_stmt,isa 0
        MOVU      ACC,AR1               ; [CPU_ALU] |601| 
        MOVB      XAR4,#0               ; [CPU_ALU] |601| 
$C$DW$99	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$99, DW_AT_low_pc(0x00)
	.dwattr $C$DW$99, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$99, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |601| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |601| 
	.dwpsn	file "../device/device.c",line 602,column 22,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |602| 
        MOVU      ACC,AR1               ; [CPU_ALU] |602| 
$C$DW$100	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$100, DW_AT_low_pc(0x00)
	.dwattr $C$DW$100, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$100, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |602| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |602| 
	.dwpsn	file "../device/device.c",line 603,column 22,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |603| 
        MOVU      ACC,AR1               ; [CPU_ALU] |603| 
$C$DW$101	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$101, DW_AT_low_pc(0x00)
	.dwattr $C$DW$101, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$101, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |603| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |603| 
	.dwpsn	file "../device/device.c",line 599,column 29,is_stmt,isa 0
        ADDB      XAR1,#1               ; [CPU_ALU] |599| 
        MOV       AL,AR1                ; [CPU_ALU] |599| 
        CMPB      AL,#65                ; [CPU_ALU] |599| 
        B         ||$C$L15||,LOS        ; [CPU_ALU] |599| 
        ; branchcc occurs ; [] |599| 
	.dwpsn	file "../device/device.c",line 606,column 18,is_stmt,isa 0
        MOVB      ACC,#69               ; [CPU_ALU] |606| 
        MOVB      XAR4,#0               ; [CPU_ALU] |606| 
$C$DW$102	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$102, DW_AT_low_pc(0x00)
	.dwattr $C$DW$102, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$102, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |606| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |606| 
	.dwpsn	file "../device/device.c",line 607,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |607| 
        MOVB      ACC,#69               ; [CPU_ALU] |607| 
$C$DW$103	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$103, DW_AT_low_pc(0x00)
	.dwattr $C$DW$103, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$103, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |607| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |607| 
	.dwpsn	file "../device/device.c",line 608,column 18,is_stmt,isa 0
        MOV       ACC,#17157 << 9       ; [CPU_ALU] |608| 
$C$DW$104	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$104, DW_AT_low_pc(0x00)
	.dwattr $C$DW$104, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$104, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |608| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |608| 
	.dwpsn	file "../device/device.c",line 609,column 18,is_stmt,isa 0
        MOVB      XAR4,#2               ; [CPU_ALU] |609| 
        MOVB      ACC,#69               ; [CPU_ALU] |609| 
$C$DW$105	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$105, DW_AT_low_pc(0x00)
	.dwattr $C$DW$105, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$105, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |609| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |609| 
	.dwpsn	file "../device/device.c",line 611,column 18,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |611| 
        MOVB      ACC,#70               ; [CPU_ALU] |611| 
$C$DW$106	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$106, DW_AT_low_pc(0x00)
	.dwattr $C$DW$106, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$106, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |611| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |611| 
	.dwpsn	file "../device/device.c",line 612,column 18,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |612| 
        MOVB      ACC,#70               ; [CPU_ALU] |612| 
$C$DW$107	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$107, DW_AT_low_pc(0x00)
	.dwattr $C$DW$107, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$107, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |612| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |612| 
	.dwpsn	file "../device/device.c",line 613,column 18,is_stmt,isa 0
        MOV       ACC,#8579 << 10       ; [CPU_ALU] |613| 
$C$DW$108	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$108, DW_AT_low_pc(0x00)
	.dwattr $C$DW$108, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$108, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |613| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |613| 
	.dwpsn	file "../device/device.c",line 614,column 18,is_stmt,isa 0
        MOVB      ACC,#70               ; [CPU_ALU] |614| 
||$C$L16||:    
        MOVB      XAR4,#2               ; [CPU_ALU] |614| 
$C$DW$109	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$109, DW_AT_low_pc(0x00)
	.dwattr $C$DW$109, DW_AT_name("GPIO_setMasterCore")
	.dwattr $C$DW$109, DW_AT_TI_call

        LCR       #||GPIO_setMasterCore|| ; [CPU_ALU] |614| 
        ; call occurs [#||GPIO_setMasterCore||] ; [] |614| 
||$C$L17||:    
	.dwpsn	file "../device/device.c",line 653,column 9,is_stmt,isa 0
        MOVL      XAR6,#327714          ; [CPU_ARAU] |653| 
	.dwpsn	file "../device/device.c",line 658,column 9,is_stmt,isa 0
        MOV       PL,#19                ; [CPU_ALU] |658| 
        MOV       PH,#0                 ; [CPU_ALU] |658| 
        MOVL      XAR5,#327696          ; [CPU_ARAU] |658| 
	.dwpsn	file "../device/device.c",line 663,column 9,is_stmt,isa 0
        MOV       AL,#1                 ; [CPU_ALU] |663| 
        MOV       AH,#32768             ; [CPU_ALU] |663| 
        MOVL      XAR4,#327684          ; [CPU_ARAU] |663| 
	.dwpsn	file "../device/device.c",line 666,column 5,is_stmt,isa 0
        MOVB      XAR7,#0               ; [CPU_ALU] |666| 
	.dwpsn	file "../device/device.c",line 653,column 9,is_stmt,isa 0
        MOVL      *+XAR6[0],XAR2        ; [CPU_ALU] |653| 
	.dwpsn	file "../device/device.c",line 658,column 9,is_stmt,isa 0
        MOVL      *+XAR5[0],P           ; [CPU_ALU] |658| 
	.dwpsn	file "../device/device.c",line 663,column 9,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |663| 
||$C$L18||:    
	.dwpsn	file "../device/device.c",line 666,column 5,is_stmt,isa 0
        MOVL      XAR2,*--SP            ; [CPU_ALU] |666| 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 9
        MOV       AL,AR7                ; [CPU_ALU] |666| 
        MOVL      XAR1,*--SP            ; [CPU_ALU] |666| 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$110	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$110, DW_AT_low_pc(0x00)
	.dwattr $C$DW$110, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$60, DW_AT_TI_end_file("../device/device.c")
	.dwattr $C$DW$60, DW_AT_TI_end_line(0x29b)
	.dwattr $C$DW$60, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$60

;**************************************************************
;* UNDEFINED EXTERNAL REFERENCES                              *
;**************************************************************
	.global	||Flash_initModule||
	.global	||GPIO_setDirectionMode||
	.global	||GPIO_setQualificationMode||
	.global	||GPIO_setPinConfig||
	.global	||GPIO_setMasterCore||
	.global	||RamfuncsLoadStart||
	.global	||RamfuncsLoadSize||
	.global	||RamfuncsRunStart||
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
$C$DW$111	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$111, DW_AT_name("SYSCTL_PERIPH_CLK_CLA1")
	.dwattr $C$DW$111, DW_AT_const_value(0x00)
	.dwattr $C$DW$111, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$111, DW_AT_decl_line(0x152)
	.dwattr $C$DW$111, DW_AT_decl_column(0x05)

$C$DW$112	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$112, DW_AT_name("SYSCTL_PERIPH_CLK_DMA")
	.dwattr $C$DW$112, DW_AT_const_value(0x200)
	.dwattr $C$DW$112, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$112, DW_AT_decl_line(0x153)
	.dwattr $C$DW$112, DW_AT_decl_column(0x05)

$C$DW$113	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$113, DW_AT_name("SYSCTL_PERIPH_CLK_TIMER0")
	.dwattr $C$DW$113, DW_AT_const_value(0x300)
	.dwattr $C$DW$113, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$113, DW_AT_decl_line(0x154)
	.dwattr $C$DW$113, DW_AT_decl_column(0x05)

$C$DW$114	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$114, DW_AT_name("SYSCTL_PERIPH_CLK_TIMER1")
	.dwattr $C$DW$114, DW_AT_const_value(0x400)
	.dwattr $C$DW$114, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$114, DW_AT_decl_line(0x155)
	.dwattr $C$DW$114, DW_AT_decl_column(0x05)

$C$DW$115	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$115, DW_AT_name("SYSCTL_PERIPH_CLK_TIMER2")
	.dwattr $C$DW$115, DW_AT_const_value(0x500)
	.dwattr $C$DW$115, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$115, DW_AT_decl_line(0x156)
	.dwattr $C$DW$115, DW_AT_decl_column(0x05)

$C$DW$116	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$116, DW_AT_name("SYSCTL_PERIPH_CLK_HRPWM")
	.dwattr $C$DW$116, DW_AT_const_value(0x1000)
	.dwattr $C$DW$116, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$116, DW_AT_decl_line(0x157)
	.dwattr $C$DW$116, DW_AT_decl_column(0x05)

$C$DW$117	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$117, DW_AT_name("SYSCTL_PERIPH_CLK_TBCLKSYNC")
	.dwattr $C$DW$117, DW_AT_const_value(0x1200)
	.dwattr $C$DW$117, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$117, DW_AT_decl_line(0x158)
	.dwattr $C$DW$117, DW_AT_decl_column(0x05)

$C$DW$118	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$118, DW_AT_name("SYSCTL_PERIPH_CLK_GTBCLKSYNC")
	.dwattr $C$DW$118, DW_AT_const_value(0x1300)
	.dwattr $C$DW$118, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$118, DW_AT_decl_line(0x159)
	.dwattr $C$DW$118, DW_AT_decl_column(0x05)

$C$DW$119	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$119, DW_AT_name("SYSCTL_PERIPH_CLK_EMIF1")
	.dwattr $C$DW$119, DW_AT_const_value(0x01)
	.dwattr $C$DW$119, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$119, DW_AT_decl_line(0x15a)
	.dwattr $C$DW$119, DW_AT_decl_column(0x05)

$C$DW$120	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$120, DW_AT_name("SYSCTL_PERIPH_CLK_EMIF2")
	.dwattr $C$DW$120, DW_AT_const_value(0x101)
	.dwattr $C$DW$120, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$120, DW_AT_decl_line(0x15b)
	.dwattr $C$DW$120, DW_AT_decl_column(0x05)

$C$DW$121	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$121, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM1")
	.dwattr $C$DW$121, DW_AT_const_value(0x02)
	.dwattr $C$DW$121, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$121, DW_AT_decl_line(0x15c)
	.dwattr $C$DW$121, DW_AT_decl_column(0x05)

$C$DW$122	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$122, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM2")
	.dwattr $C$DW$122, DW_AT_const_value(0x102)
	.dwattr $C$DW$122, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$122, DW_AT_decl_line(0x15d)
	.dwattr $C$DW$122, DW_AT_decl_column(0x05)

$C$DW$123	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$123, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM3")
	.dwattr $C$DW$123, DW_AT_const_value(0x202)
	.dwattr $C$DW$123, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$123, DW_AT_decl_line(0x15e)
	.dwattr $C$DW$123, DW_AT_decl_column(0x05)

$C$DW$124	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$124, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM4")
	.dwattr $C$DW$124, DW_AT_const_value(0x302)
	.dwattr $C$DW$124, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$124, DW_AT_decl_line(0x15f)
	.dwattr $C$DW$124, DW_AT_decl_column(0x05)

$C$DW$125	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$125, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM5")
	.dwattr $C$DW$125, DW_AT_const_value(0x402)
	.dwattr $C$DW$125, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$125, DW_AT_decl_line(0x160)
	.dwattr $C$DW$125, DW_AT_decl_column(0x05)

$C$DW$126	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$126, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM6")
	.dwattr $C$DW$126, DW_AT_const_value(0x502)
	.dwattr $C$DW$126, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$126, DW_AT_decl_line(0x161)
	.dwattr $C$DW$126, DW_AT_decl_column(0x05)

$C$DW$127	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$127, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM7")
	.dwattr $C$DW$127, DW_AT_const_value(0x602)
	.dwattr $C$DW$127, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$127, DW_AT_decl_line(0x162)
	.dwattr $C$DW$127, DW_AT_decl_column(0x05)

$C$DW$128	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$128, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM8")
	.dwattr $C$DW$128, DW_AT_const_value(0x702)
	.dwattr $C$DW$128, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$128, DW_AT_decl_line(0x163)
	.dwattr $C$DW$128, DW_AT_decl_column(0x05)

$C$DW$129	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$129, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM9")
	.dwattr $C$DW$129, DW_AT_const_value(0x802)
	.dwattr $C$DW$129, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$129, DW_AT_decl_line(0x164)
	.dwattr $C$DW$129, DW_AT_decl_column(0x05)

$C$DW$130	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$130, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM10")
	.dwattr $C$DW$130, DW_AT_const_value(0x902)
	.dwattr $C$DW$130, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$130, DW_AT_decl_line(0x165)
	.dwattr $C$DW$130, DW_AT_decl_column(0x05)

$C$DW$131	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$131, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM11")
	.dwattr $C$DW$131, DW_AT_const_value(0xa02)
	.dwattr $C$DW$131, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$131, DW_AT_decl_line(0x166)
	.dwattr $C$DW$131, DW_AT_decl_column(0x05)

$C$DW$132	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$132, DW_AT_name("SYSCTL_PERIPH_CLK_EPWM12")
	.dwattr $C$DW$132, DW_AT_const_value(0xb02)
	.dwattr $C$DW$132, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$132, DW_AT_decl_line(0x167)
	.dwattr $C$DW$132, DW_AT_decl_column(0x05)

$C$DW$133	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$133, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP1")
	.dwattr $C$DW$133, DW_AT_const_value(0x03)
	.dwattr $C$DW$133, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$133, DW_AT_decl_line(0x168)
	.dwattr $C$DW$133, DW_AT_decl_column(0x05)

$C$DW$134	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$134, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP2")
	.dwattr $C$DW$134, DW_AT_const_value(0x103)
	.dwattr $C$DW$134, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$134, DW_AT_decl_line(0x169)
	.dwattr $C$DW$134, DW_AT_decl_column(0x05)

$C$DW$135	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$135, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP3")
	.dwattr $C$DW$135, DW_AT_const_value(0x203)
	.dwattr $C$DW$135, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$135, DW_AT_decl_line(0x16a)
	.dwattr $C$DW$135, DW_AT_decl_column(0x05)

$C$DW$136	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$136, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP4")
	.dwattr $C$DW$136, DW_AT_const_value(0x303)
	.dwattr $C$DW$136, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$136, DW_AT_decl_line(0x16b)
	.dwattr $C$DW$136, DW_AT_decl_column(0x05)

$C$DW$137	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$137, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP5")
	.dwattr $C$DW$137, DW_AT_const_value(0x403)
	.dwattr $C$DW$137, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$137, DW_AT_decl_line(0x16c)
	.dwattr $C$DW$137, DW_AT_decl_column(0x05)

$C$DW$138	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$138, DW_AT_name("SYSCTL_PERIPH_CLK_ECAP6")
	.dwattr $C$DW$138, DW_AT_const_value(0x503)
	.dwattr $C$DW$138, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$138, DW_AT_decl_line(0x16d)
	.dwattr $C$DW$138, DW_AT_decl_column(0x05)

$C$DW$139	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$139, DW_AT_name("SYSCTL_PERIPH_CLK_EQEP1")
	.dwattr $C$DW$139, DW_AT_const_value(0x04)
	.dwattr $C$DW$139, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$139, DW_AT_decl_line(0x16e)
	.dwattr $C$DW$139, DW_AT_decl_column(0x05)

$C$DW$140	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$140, DW_AT_name("SYSCTL_PERIPH_CLK_EQEP2")
	.dwattr $C$DW$140, DW_AT_const_value(0x104)
	.dwattr $C$DW$140, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$140, DW_AT_decl_line(0x16f)
	.dwattr $C$DW$140, DW_AT_decl_column(0x05)

$C$DW$141	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$141, DW_AT_name("SYSCTL_PERIPH_CLK_EQEP3")
	.dwattr $C$DW$141, DW_AT_const_value(0x204)
	.dwattr $C$DW$141, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$141, DW_AT_decl_line(0x170)
	.dwattr $C$DW$141, DW_AT_decl_column(0x05)

$C$DW$142	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$142, DW_AT_name("SYSCTL_PERIPH_CLK_SD1")
	.dwattr $C$DW$142, DW_AT_const_value(0x06)
	.dwattr $C$DW$142, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$142, DW_AT_decl_line(0x171)
	.dwattr $C$DW$142, DW_AT_decl_column(0x05)

$C$DW$143	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$143, DW_AT_name("SYSCTL_PERIPH_CLK_SD2")
	.dwattr $C$DW$143, DW_AT_const_value(0x106)
	.dwattr $C$DW$143, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$143, DW_AT_decl_line(0x172)
	.dwattr $C$DW$143, DW_AT_decl_column(0x05)

$C$DW$144	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$144, DW_AT_name("SYSCTL_PERIPH_CLK_SCIA")
	.dwattr $C$DW$144, DW_AT_const_value(0x07)
	.dwattr $C$DW$144, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$144, DW_AT_decl_line(0x173)
	.dwattr $C$DW$144, DW_AT_decl_column(0x05)

$C$DW$145	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$145, DW_AT_name("SYSCTL_PERIPH_CLK_SCIB")
	.dwattr $C$DW$145, DW_AT_const_value(0x107)
	.dwattr $C$DW$145, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$145, DW_AT_decl_line(0x174)
	.dwattr $C$DW$145, DW_AT_decl_column(0x05)

$C$DW$146	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$146, DW_AT_name("SYSCTL_PERIPH_CLK_SCIC")
	.dwattr $C$DW$146, DW_AT_const_value(0x207)
	.dwattr $C$DW$146, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$146, DW_AT_decl_line(0x175)
	.dwattr $C$DW$146, DW_AT_decl_column(0x05)

$C$DW$147	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$147, DW_AT_name("SYSCTL_PERIPH_CLK_SCID")
	.dwattr $C$DW$147, DW_AT_const_value(0x307)
	.dwattr $C$DW$147, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$147, DW_AT_decl_line(0x176)
	.dwattr $C$DW$147, DW_AT_decl_column(0x05)

$C$DW$148	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$148, DW_AT_name("SYSCTL_PERIPH_CLK_SPIA")
	.dwattr $C$DW$148, DW_AT_const_value(0x08)
	.dwattr $C$DW$148, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$148, DW_AT_decl_line(0x177)
	.dwattr $C$DW$148, DW_AT_decl_column(0x05)

$C$DW$149	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$149, DW_AT_name("SYSCTL_PERIPH_CLK_SPIB")
	.dwattr $C$DW$149, DW_AT_const_value(0x108)
	.dwattr $C$DW$149, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$149, DW_AT_decl_line(0x178)
	.dwattr $C$DW$149, DW_AT_decl_column(0x05)

$C$DW$150	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$150, DW_AT_name("SYSCTL_PERIPH_CLK_SPIC")
	.dwattr $C$DW$150, DW_AT_const_value(0x208)
	.dwattr $C$DW$150, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$150, DW_AT_decl_line(0x179)
	.dwattr $C$DW$150, DW_AT_decl_column(0x05)

$C$DW$151	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$151, DW_AT_name("SYSCTL_PERIPH_CLK_I2CA")
	.dwattr $C$DW$151, DW_AT_const_value(0x09)
	.dwattr $C$DW$151, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$151, DW_AT_decl_line(0x17a)
	.dwattr $C$DW$151, DW_AT_decl_column(0x05)

$C$DW$152	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$152, DW_AT_name("SYSCTL_PERIPH_CLK_I2CB")
	.dwattr $C$DW$152, DW_AT_const_value(0x109)
	.dwattr $C$DW$152, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$152, DW_AT_decl_line(0x17b)
	.dwattr $C$DW$152, DW_AT_decl_column(0x05)

$C$DW$153	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$153, DW_AT_name("SYSCTL_PERIPH_CLK_CANA")
	.dwattr $C$DW$153, DW_AT_const_value(0x0a)
	.dwattr $C$DW$153, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$153, DW_AT_decl_line(0x17c)
	.dwattr $C$DW$153, DW_AT_decl_column(0x05)

$C$DW$154	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$154, DW_AT_name("SYSCTL_PERIPH_CLK_CANB")
	.dwattr $C$DW$154, DW_AT_const_value(0x10a)
	.dwattr $C$DW$154, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$154, DW_AT_decl_line(0x17d)
	.dwattr $C$DW$154, DW_AT_decl_column(0x05)

$C$DW$155	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$155, DW_AT_name("SYSCTL_PERIPH_CLK_MCBSPA")
	.dwattr $C$DW$155, DW_AT_const_value(0x0b)
	.dwattr $C$DW$155, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$155, DW_AT_decl_line(0x17e)
	.dwattr $C$DW$155, DW_AT_decl_column(0x05)

$C$DW$156	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$156, DW_AT_name("SYSCTL_PERIPH_CLK_MCBSPB")
	.dwattr $C$DW$156, DW_AT_const_value(0x10b)
	.dwattr $C$DW$156, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$156, DW_AT_decl_line(0x17f)
	.dwattr $C$DW$156, DW_AT_decl_column(0x05)

$C$DW$157	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$157, DW_AT_name("SYSCTL_PERIPH_CLK_USBA")
	.dwattr $C$DW$157, DW_AT_const_value(0x100b)
	.dwattr $C$DW$157, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$157, DW_AT_decl_line(0x180)
	.dwattr $C$DW$157, DW_AT_decl_column(0x05)

$C$DW$158	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$158, DW_AT_name("SYSCTL_PERIPH_CLK_UPPA")
	.dwattr $C$DW$158, DW_AT_const_value(0x0c)
	.dwattr $C$DW$158, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$158, DW_AT_decl_line(0x181)
	.dwattr $C$DW$158, DW_AT_decl_column(0x05)

$C$DW$159	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$159, DW_AT_name("SYSCTL_PERIPH_CLK_ADCA")
	.dwattr $C$DW$159, DW_AT_const_value(0x0d)
	.dwattr $C$DW$159, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$159, DW_AT_decl_line(0x182)
	.dwattr $C$DW$159, DW_AT_decl_column(0x05)

$C$DW$160	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$160, DW_AT_name("SYSCTL_PERIPH_CLK_ADCB")
	.dwattr $C$DW$160, DW_AT_const_value(0x10d)
	.dwattr $C$DW$160, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$160, DW_AT_decl_line(0x183)
	.dwattr $C$DW$160, DW_AT_decl_column(0x05)

$C$DW$161	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$161, DW_AT_name("SYSCTL_PERIPH_CLK_ADCC")
	.dwattr $C$DW$161, DW_AT_const_value(0x20d)
	.dwattr $C$DW$161, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$161, DW_AT_decl_line(0x184)
	.dwattr $C$DW$161, DW_AT_decl_column(0x05)

$C$DW$162	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$162, DW_AT_name("SYSCTL_PERIPH_CLK_ADCD")
	.dwattr $C$DW$162, DW_AT_const_value(0x30d)
	.dwattr $C$DW$162, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$162, DW_AT_decl_line(0x185)
	.dwattr $C$DW$162, DW_AT_decl_column(0x05)

$C$DW$163	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$163, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS1")
	.dwattr $C$DW$163, DW_AT_const_value(0x0e)
	.dwattr $C$DW$163, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$163, DW_AT_decl_line(0x186)
	.dwattr $C$DW$163, DW_AT_decl_column(0x05)

$C$DW$164	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$164, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS2")
	.dwattr $C$DW$164, DW_AT_const_value(0x10e)
	.dwattr $C$DW$164, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$164, DW_AT_decl_line(0x187)
	.dwattr $C$DW$164, DW_AT_decl_column(0x05)

$C$DW$165	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$165, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS3")
	.dwattr $C$DW$165, DW_AT_const_value(0x20e)
	.dwattr $C$DW$165, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$165, DW_AT_decl_line(0x188)
	.dwattr $C$DW$165, DW_AT_decl_column(0x05)

$C$DW$166	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$166, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS4")
	.dwattr $C$DW$166, DW_AT_const_value(0x30e)
	.dwattr $C$DW$166, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$166, DW_AT_decl_line(0x189)
	.dwattr $C$DW$166, DW_AT_decl_column(0x05)

$C$DW$167	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$167, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS5")
	.dwattr $C$DW$167, DW_AT_const_value(0x40e)
	.dwattr $C$DW$167, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$167, DW_AT_decl_line(0x18a)
	.dwattr $C$DW$167, DW_AT_decl_column(0x05)

$C$DW$168	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$168, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS6")
	.dwattr $C$DW$168, DW_AT_const_value(0x50e)
	.dwattr $C$DW$168, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$168, DW_AT_decl_line(0x18b)
	.dwattr $C$DW$168, DW_AT_decl_column(0x05)

$C$DW$169	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$169, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS7")
	.dwattr $C$DW$169, DW_AT_const_value(0x60e)
	.dwattr $C$DW$169, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$169, DW_AT_decl_line(0x18c)
	.dwattr $C$DW$169, DW_AT_decl_column(0x05)

$C$DW$170	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$170, DW_AT_name("SYSCTL_PERIPH_CLK_CMPSS8")
	.dwattr $C$DW$170, DW_AT_const_value(0x70e)
	.dwattr $C$DW$170, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$170, DW_AT_decl_line(0x18d)
	.dwattr $C$DW$170, DW_AT_decl_column(0x05)

$C$DW$171	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$171, DW_AT_name("SYSCTL_PERIPH_CLK_DACA")
	.dwattr $C$DW$171, DW_AT_const_value(0x1010)
	.dwattr $C$DW$171, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$171, DW_AT_decl_line(0x18e)
	.dwattr $C$DW$171, DW_AT_decl_column(0x05)

$C$DW$172	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$172, DW_AT_name("SYSCTL_PERIPH_CLK_DACB")
	.dwattr $C$DW$172, DW_AT_const_value(0x1110)
	.dwattr $C$DW$172, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$172, DW_AT_decl_line(0x18f)
	.dwattr $C$DW$172, DW_AT_decl_column(0x05)

$C$DW$173	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$173, DW_AT_name("SYSCTL_PERIPH_CLK_DACC")
	.dwattr $C$DW$173, DW_AT_const_value(0x1210)
	.dwattr $C$DW$173, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$173, DW_AT_decl_line(0x190)
	.dwattr $C$DW$173, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$19, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$19, DW_AT_decl_line(0x151)
	.dwattr $C$DW$T$19, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$19

	.dwendtag $C$DW$TU$19


$C$DW$TU$20	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$20
$C$DW$T$20	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$20, DW_AT_name("SysCtl_PeripheralPCLOCKCR")
	.dwattr $C$DW$T$20, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$T$20, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$20, DW_AT_decl_line(0x191)
	.dwattr $C$DW$T$20, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$20


$C$DW$TU$21	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$21

$C$DW$T$21	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$21, DW_AT_byte_size(0x01)
$C$DW$174	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$174, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_1")
	.dwattr $C$DW$174, DW_AT_const_value(0x00)
	.dwattr $C$DW$174, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$174, DW_AT_decl_line(0x22b)
	.dwattr $C$DW$174, DW_AT_decl_column(0x05)

$C$DW$175	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$175, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_2")
	.dwattr $C$DW$175, DW_AT_const_value(0x01)
	.dwattr $C$DW$175, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$175, DW_AT_decl_line(0x22c)
	.dwattr $C$DW$175, DW_AT_decl_column(0x05)

$C$DW$176	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$176, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_4")
	.dwattr $C$DW$176, DW_AT_const_value(0x02)
	.dwattr $C$DW$176, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$176, DW_AT_decl_line(0x22d)
	.dwattr $C$DW$176, DW_AT_decl_column(0x05)

$C$DW$177	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$177, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_6")
	.dwattr $C$DW$177, DW_AT_const_value(0x03)
	.dwattr $C$DW$177, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$177, DW_AT_decl_line(0x22e)
	.dwattr $C$DW$177, DW_AT_decl_column(0x05)

$C$DW$178	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$178, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_8")
	.dwattr $C$DW$178, DW_AT_const_value(0x04)
	.dwattr $C$DW$178, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$178, DW_AT_decl_line(0x22f)
	.dwattr $C$DW$178, DW_AT_decl_column(0x05)

$C$DW$179	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$179, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_10")
	.dwattr $C$DW$179, DW_AT_const_value(0x05)
	.dwattr $C$DW$179, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$179, DW_AT_decl_line(0x230)
	.dwattr $C$DW$179, DW_AT_decl_column(0x05)

$C$DW$180	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$180, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_12")
	.dwattr $C$DW$180, DW_AT_const_value(0x06)
	.dwattr $C$DW$180, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$180, DW_AT_decl_line(0x231)
	.dwattr $C$DW$180, DW_AT_decl_column(0x05)

$C$DW$181	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$181, DW_AT_name("SYSCTL_LSPCLK_PRESCALE_14")
	.dwattr $C$DW$181, DW_AT_const_value(0x07)
	.dwattr $C$DW$181, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$181, DW_AT_decl_line(0x232)
	.dwattr $C$DW$181, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$21, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$21, DW_AT_decl_line(0x22a)
	.dwattr $C$DW$T$21, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$21

	.dwendtag $C$DW$TU$21


$C$DW$TU$22	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$22
$C$DW$T$22	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$22, DW_AT_name("SysCtl_LSPCLKPrescaler")
	.dwattr $C$DW$T$22, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$T$22, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$22, DW_AT_decl_line(0x233)
	.dwattr $C$DW$T$22, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$22


$C$DW$TU$23	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$23

$C$DW$T$23	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$23, DW_AT_byte_size(0x01)
$C$DW$182	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$182, DW_AT_name("SYSCTL_CPUSEL0_EPWM")
	.dwattr $C$DW$182, DW_AT_const_value(0x00)
	.dwattr $C$DW$182, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$182, DW_AT_decl_line(0x1dd)
	.dwattr $C$DW$182, DW_AT_decl_column(0x05)

$C$DW$183	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$183, DW_AT_name("SYSCTL_CPUSEL1_ECAP")
	.dwattr $C$DW$183, DW_AT_const_value(0x01)
	.dwattr $C$DW$183, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$183, DW_AT_decl_line(0x1df)
	.dwattr $C$DW$183, DW_AT_decl_column(0x05)

$C$DW$184	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$184, DW_AT_name("SYSCTL_CPUSEL2_EQEP")
	.dwattr $C$DW$184, DW_AT_const_value(0x02)
	.dwattr $C$DW$184, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$184, DW_AT_decl_line(0x1e1)
	.dwattr $C$DW$184, DW_AT_decl_column(0x05)

$C$DW$185	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$185, DW_AT_name("SYSCTL_CPUSEL4_SD")
	.dwattr $C$DW$185, DW_AT_const_value(0x04)
	.dwattr $C$DW$185, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$185, DW_AT_decl_line(0x1e3)
	.dwattr $C$DW$185, DW_AT_decl_column(0x05)

$C$DW$186	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$186, DW_AT_name("SYSCTL_CPUSEL5_SCI")
	.dwattr $C$DW$186, DW_AT_const_value(0x05)
	.dwattr $C$DW$186, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$186, DW_AT_decl_line(0x1e5)
	.dwattr $C$DW$186, DW_AT_decl_column(0x05)

$C$DW$187	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$187, DW_AT_name("SYSCTL_CPUSEL6_SPI")
	.dwattr $C$DW$187, DW_AT_const_value(0x06)
	.dwattr $C$DW$187, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$187, DW_AT_decl_line(0x1e7)
	.dwattr $C$DW$187, DW_AT_decl_column(0x05)

$C$DW$188	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$188, DW_AT_name("SYSCTL_CPUSEL7_I2C")
	.dwattr $C$DW$188, DW_AT_const_value(0x07)
	.dwattr $C$DW$188, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$188, DW_AT_decl_line(0x1e9)
	.dwattr $C$DW$188, DW_AT_decl_column(0x05)

$C$DW$189	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$189, DW_AT_name("SYSCTL_CPUSEL8_CAN")
	.dwattr $C$DW$189, DW_AT_const_value(0x08)
	.dwattr $C$DW$189, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$189, DW_AT_decl_line(0x1eb)
	.dwattr $C$DW$189, DW_AT_decl_column(0x05)

$C$DW$190	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$190, DW_AT_name("SYSCTL_CPUSEL9_MCBSP")
	.dwattr $C$DW$190, DW_AT_const_value(0x09)
	.dwattr $C$DW$190, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$190, DW_AT_decl_line(0x1ed)
	.dwattr $C$DW$190, DW_AT_decl_column(0x05)

$C$DW$191	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$191, DW_AT_name("SYSCTL_CPUSEL11_ADC")
	.dwattr $C$DW$191, DW_AT_const_value(0x0b)
	.dwattr $C$DW$191, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$191, DW_AT_decl_line(0x1ef)
	.dwattr $C$DW$191, DW_AT_decl_column(0x05)

$C$DW$192	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$192, DW_AT_name("SYSCTL_CPUSEL12_CMPSS")
	.dwattr $C$DW$192, DW_AT_const_value(0x0c)
	.dwattr $C$DW$192, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$192, DW_AT_decl_line(0x1f1)
	.dwattr $C$DW$192, DW_AT_decl_column(0x05)

$C$DW$193	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$193, DW_AT_name("SYSCTL_CPUSEL14_DAC")
	.dwattr $C$DW$193, DW_AT_const_value(0x0e)
	.dwattr $C$DW$193, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$193, DW_AT_decl_line(0x1f3)
	.dwattr $C$DW$193, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$23, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$23, DW_AT_decl_line(0x1db)
	.dwattr $C$DW$T$23, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$23

	.dwendtag $C$DW$TU$23


$C$DW$TU$24	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$24
$C$DW$T$24	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$24, DW_AT_name("SysCtl_CPUSelPeripheral")
	.dwattr $C$DW$T$24, DW_AT_type(*$C$DW$T$23)
	.dwattr $C$DW$T$24, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$24, DW_AT_decl_line(0x1f4)
	.dwattr $C$DW$T$24, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$24


$C$DW$TU$25	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$25

$C$DW$T$25	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$25, DW_AT_byte_size(0x01)
$C$DW$194	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$194, DW_AT_name("SYSCTL_CPUSEL_CPU1")
	.dwattr $C$DW$194, DW_AT_const_value(0x00)
	.dwattr $C$DW$194, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$194, DW_AT_decl_line(0x1ff)
	.dwattr $C$DW$194, DW_AT_decl_column(0x05)

$C$DW$195	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$195, DW_AT_name("SYSCTL_CPUSEL_CPU2")
	.dwattr $C$DW$195, DW_AT_const_value(0x01)
	.dwattr $C$DW$195, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$195, DW_AT_decl_line(0x201)
	.dwattr $C$DW$195, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$25, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$25, DW_AT_decl_line(0x1fd)
	.dwattr $C$DW$T$25, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$25

	.dwendtag $C$DW$TU$25


$C$DW$TU$26	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$26
$C$DW$T$26	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$26, DW_AT_name("SysCtl_CPUSel")
	.dwattr $C$DW$T$26, DW_AT_type(*$C$DW$T$25)
	.dwattr $C$DW$T$26, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$26, DW_AT_decl_line(0x202)
	.dwattr $C$DW$T$26, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$26


$C$DW$TU$27	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$27

$C$DW$T$27	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$27, DW_AT_byte_size(0x01)
$C$DW$196	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$196, DW_AT_name("SYSCTL_DEVICE_QUAL")
	.dwattr $C$DW$196, DW_AT_const_value(0x00)
	.dwattr $C$DW$196, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$196, DW_AT_decl_line(0x2a9)
	.dwattr $C$DW$196, DW_AT_decl_column(0x05)

$C$DW$197	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$197, DW_AT_name("SYSCTL_DEVICE_PINCOUNT")
	.dwattr $C$DW$197, DW_AT_const_value(0x01)
	.dwattr $C$DW$197, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$197, DW_AT_decl_line(0x2aa)
	.dwattr $C$DW$197, DW_AT_decl_column(0x05)

$C$DW$198	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$198, DW_AT_name("SYSCTL_DEVICE_INSTASPIN")
	.dwattr $C$DW$198, DW_AT_const_value(0x02)
	.dwattr $C$DW$198, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$198, DW_AT_decl_line(0x2ab)
	.dwattr $C$DW$198, DW_AT_decl_column(0x05)

$C$DW$199	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$199, DW_AT_name("SYSCTL_DEVICE_FLASH")
	.dwattr $C$DW$199, DW_AT_const_value(0x03)
	.dwattr $C$DW$199, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$199, DW_AT_decl_line(0x2ac)
	.dwattr $C$DW$199, DW_AT_decl_column(0x05)

$C$DW$200	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$200, DW_AT_name("SYSCTL_DEVICE_PARTID")
	.dwattr $C$DW$200, DW_AT_const_value(0x04)
	.dwattr $C$DW$200, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$200, DW_AT_decl_line(0x2ad)
	.dwattr $C$DW$200, DW_AT_decl_column(0x05)

$C$DW$201	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$201, DW_AT_name("SYSCTL_DEVICE_FAMILY")
	.dwattr $C$DW$201, DW_AT_const_value(0x05)
	.dwattr $C$DW$201, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$201, DW_AT_decl_line(0x2ae)
	.dwattr $C$DW$201, DW_AT_decl_column(0x05)

$C$DW$202	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$202, DW_AT_name("SYSCTL_DEVICE_PARTNO")
	.dwattr $C$DW$202, DW_AT_const_value(0x06)
	.dwattr $C$DW$202, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$202, DW_AT_decl_line(0x2af)
	.dwattr $C$DW$202, DW_AT_decl_column(0x05)

$C$DW$203	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$203, DW_AT_name("SYSCTL_DEVICE_CLASSID")
	.dwattr $C$DW$203, DW_AT_const_value(0x07)
	.dwattr $C$DW$203, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$203, DW_AT_decl_line(0x2b0)
	.dwattr $C$DW$203, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$27, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$27, DW_AT_decl_line(0x2a8)
	.dwattr $C$DW$T$27, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$27

	.dwendtag $C$DW$TU$27


$C$DW$TU$28	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$28
$C$DW$T$28	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$28, DW_AT_name("SysCtl_DeviceParametric")
	.dwattr $C$DW$T$28, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$T$28, DW_AT_decl_file("C:\ti\c2000\C2000Ware_DigitalPower_SDK_3_01_00_00\c2000ware\driverlib\f2837xd\driverlib\sysctl.h")
	.dwattr $C$DW$T$28, DW_AT_decl_line(0x2b1)
	.dwattr $C$DW$T$28, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$28


$C$DW$TU$29	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$29

$C$DW$T$29	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$29, DW_AT_byte_size(0x01)
$C$DW$204	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$204, DW_AT_name("GPIO_PORT_A")
	.dwattr $C$DW$204, DW_AT_const_value(0x00)
	.dwattr $C$DW$204, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$204, DW_AT_decl_line(0xbd)
	.dwattr $C$DW$204, DW_AT_decl_column(0x05)

$C$DW$205	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$205, DW_AT_name("GPIO_PORT_B")
	.dwattr $C$DW$205, DW_AT_const_value(0x01)
	.dwattr $C$DW$205, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$205, DW_AT_decl_line(0xbe)
	.dwattr $C$DW$205, DW_AT_decl_column(0x05)

$C$DW$206	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$206, DW_AT_name("GPIO_PORT_C")
	.dwattr $C$DW$206, DW_AT_const_value(0x02)
	.dwattr $C$DW$206, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$206, DW_AT_decl_line(0xbf)
	.dwattr $C$DW$206, DW_AT_decl_column(0x05)

$C$DW$207	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$207, DW_AT_name("GPIO_PORT_D")
	.dwattr $C$DW$207, DW_AT_const_value(0x03)
	.dwattr $C$DW$207, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$207, DW_AT_decl_line(0xc0)
	.dwattr $C$DW$207, DW_AT_decl_column(0x05)

$C$DW$208	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$208, DW_AT_name("GPIO_PORT_E")
	.dwattr $C$DW$208, DW_AT_const_value(0x04)
	.dwattr $C$DW$208, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$208, DW_AT_decl_line(0xc1)
	.dwattr $C$DW$208, DW_AT_decl_column(0x05)

$C$DW$209	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$209, DW_AT_name("GPIO_PORT_F")
	.dwattr $C$DW$209, DW_AT_const_value(0x05)
	.dwattr $C$DW$209, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$209, DW_AT_decl_line(0xc2)
	.dwattr $C$DW$209, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$29, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$29, DW_AT_decl_line(0xbc)
	.dwattr $C$DW$T$29, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$29

	.dwendtag $C$DW$TU$29


$C$DW$TU$30	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$30
$C$DW$T$30	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$30, DW_AT_name("GPIO_Port")
	.dwattr $C$DW$T$30, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$T$30, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$30, DW_AT_decl_line(0xc3)
	.dwattr $C$DW$T$30, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$30


$C$DW$TU$31	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$31

$C$DW$T$31	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$31, DW_AT_byte_size(0x01)
$C$DW$210	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$210, DW_AT_name("GPIO_DIR_MODE_IN")
	.dwattr $C$DW$210, DW_AT_const_value(0x00)
	.dwattr $C$DW$210, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$210, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$210, DW_AT_decl_column(0x05)

$C$DW$211	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$211, DW_AT_name("GPIO_DIR_MODE_OUT")
	.dwattr $C$DW$211, DW_AT_const_value(0x01)
	.dwattr $C$DW$211, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$211, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$211, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$31, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$31, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$T$31, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$31

	.dwendtag $C$DW$TU$31


$C$DW$TU$32	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$32
$C$DW$T$32	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$32, DW_AT_name("GPIO_Direction")
	.dwattr $C$DW$T$32, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$T$32, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$32, DW_AT_decl_line(0x80)
	.dwattr $C$DW$T$32, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$32


$C$DW$TU$33	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$33

$C$DW$T$33	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$33, DW_AT_byte_size(0x01)
$C$DW$212	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$212, DW_AT_name("GPIO_QUAL_SYNC")
	.dwattr $C$DW$212, DW_AT_const_value(0x00)
	.dwattr $C$DW$212, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$212, DW_AT_decl_line(0x97)
	.dwattr $C$DW$212, DW_AT_decl_column(0x05)

$C$DW$213	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$213, DW_AT_name("GPIO_QUAL_3SAMPLE")
	.dwattr $C$DW$213, DW_AT_const_value(0x01)
	.dwattr $C$DW$213, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$213, DW_AT_decl_line(0x98)
	.dwattr $C$DW$213, DW_AT_decl_column(0x05)

$C$DW$214	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$214, DW_AT_name("GPIO_QUAL_6SAMPLE")
	.dwattr $C$DW$214, DW_AT_const_value(0x02)
	.dwattr $C$DW$214, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$214, DW_AT_decl_line(0x99)
	.dwattr $C$DW$214, DW_AT_decl_column(0x05)

$C$DW$215	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$215, DW_AT_name("GPIO_QUAL_ASYNC")
	.dwattr $C$DW$215, DW_AT_const_value(0x03)
	.dwattr $C$DW$215, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$215, DW_AT_decl_line(0x9a)
	.dwattr $C$DW$215, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$33, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$33, DW_AT_decl_line(0x96)
	.dwattr $C$DW$T$33, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$33

	.dwendtag $C$DW$TU$33


$C$DW$TU$34	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$34
$C$DW$T$34	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$34, DW_AT_name("GPIO_QualificationMode")
	.dwattr $C$DW$T$34, DW_AT_type(*$C$DW$T$33)
	.dwattr $C$DW$T$34, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$34, DW_AT_decl_line(0x9b)
	.dwattr $C$DW$T$34, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$34


$C$DW$TU$35	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$35

$C$DW$T$35	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$35, DW_AT_byte_size(0x01)
$C$DW$216	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$216, DW_AT_name("GPIO_CORE_CPU1")
	.dwattr $C$DW$216, DW_AT_const_value(0x00)
	.dwattr $C$DW$216, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$216, DW_AT_decl_line(0xaf)
	.dwattr $C$DW$216, DW_AT_decl_column(0x05)

$C$DW$217	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$217, DW_AT_name("GPIO_CORE_CPU1_CLA1")
	.dwattr $C$DW$217, DW_AT_const_value(0x01)
	.dwattr $C$DW$217, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$217, DW_AT_decl_line(0xb0)
	.dwattr $C$DW$217, DW_AT_decl_column(0x05)

$C$DW$218	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$218, DW_AT_name("GPIO_CORE_CPU2")
	.dwattr $C$DW$218, DW_AT_const_value(0x02)
	.dwattr $C$DW$218, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$218, DW_AT_decl_line(0xb1)
	.dwattr $C$DW$218, DW_AT_decl_column(0x05)

$C$DW$219	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$219, DW_AT_name("GPIO_CORE_CPU2_CLA1")
	.dwattr $C$DW$219, DW_AT_const_value(0x03)
	.dwattr $C$DW$219, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$219, DW_AT_decl_line(0xb2)
	.dwattr $C$DW$219, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$35, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$35, DW_AT_decl_line(0xae)
	.dwattr $C$DW$T$35, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$35

	.dwendtag $C$DW$TU$35


$C$DW$TU$36	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$36
$C$DW$T$36	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$36, DW_AT_name("GPIO_CoreSelect")
	.dwattr $C$DW$T$36, DW_AT_type(*$C$DW$T$35)
	.dwattr $C$DW$T$36, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$36, DW_AT_decl_line(0xb3)
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
	.dwattr $C$DW$T$43, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$43, DW_AT_decl_line(0x41)
	.dwattr $C$DW$T$43, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$43


$C$DW$TU$44	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$44
$C$DW$T$44	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$44, DW_AT_name("uint16_t")
	.dwattr $C$DW$T$44, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$T$44, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
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
	.dwattr $C$DW$T$46, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$46, DW_AT_decl_line(0x43)
	.dwattr $C$DW$T$46, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$46


$C$DW$TU$47	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$47
$C$DW$T$47	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$47, DW_AT_name("uint32_t")
	.dwattr $C$DW$T$47, DW_AT_type(*$C$DW$T$46)
	.dwattr $C$DW$T$47, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$47, DW_AT_decl_line(0x46)
	.dwattr $C$DW$T$47, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$47


$C$DW$TU$76	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$76
$C$DW$220	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$220, DW_AT_type(*$C$DW$T$47)

$C$DW$T$76	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$76, DW_AT_type(*$C$DW$220)

	.dwendtag $C$DW$TU$76


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
$C$DW$T$60	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$60, DW_AT_type(*$C$DW$T$5)
	.dwattr $C$DW$T$60, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$60


$C$DW$TU$77	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$77
$C$DW$T$77	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$77, DW_AT_encoding(DW_ATE_unsigned_char)
	.dwattr $C$DW$T$77, DW_AT_name("unsigned char")
	.dwattr $C$DW$T$77, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$77

