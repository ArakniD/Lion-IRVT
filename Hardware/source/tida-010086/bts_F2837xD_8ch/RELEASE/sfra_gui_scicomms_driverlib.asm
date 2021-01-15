;***************************************************************
;* TMS320C2000 G3 C/C++ Codegen                               PC v20.2.4.LTS *
;* Date/Time created: Mon Jan 11 05:48:46 2021                 *
;***************************************************************
	.compiler_opts --abi=eabi --cla_support=cla1 --diag_wrap=off --float_support=fpu32 --hll_source=on --mem_model:code=flat --mem_model:data=large --object_format=elf --quiet --silicon_errata_fpu1_workaround=off --silicon_version=28 --symdebug:dwarf --symdebug:dwarf_version=4 --tmu_support=tmu0 --vcu_support=vcu2 
	.asg	XAR2, FP

$C$DW$CU	.dwtag  DW_TAG_compile_unit
	.dwattr $C$DW$CU, DW_AT_name("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$CU, DW_AT_producer("TI TMS320C2000 G3 C/C++ Codegen PC v20.2.4.LTS Copyright (c) 1996-2018 Texas Instruments Incorporated")
	.dwattr $C$DW$CU, DW_AT_TI_version(0x01)
	.dwattr $C$DW$CU, DW_AT_comp_dir("C:\sandbox\github\Lion-IRVT\Hardware\source\tida-010086\bts_F2837xD_8ch\RELEASE")

;**************************************************************
;* FUNCTION SYNONYMS                                          *
;**************************************************************
	.global	||SFRA_GUI_getVariable||
||SFRA_GUI_getVariable||	.set ||SFRA_GUI_sendData||
	.global	||SFRA_GUI_getArray||
||SFRA_GUI_getArray||	.set ||SFRA_GUI_sendData||

$C$DW$1	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$1, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$1, DW_AT_linkage_name("GPIO_setPinConfig")
	.dwattr $C$DW$1, DW_AT_declaration
	.dwattr $C$DW$1, DW_AT_external
	.dwattr $C$DW$1, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$1, DW_AT_decl_line(0x401)
	.dwattr $C$DW$1, DW_AT_decl_column(0x01)
$C$DW$2	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$2, DW_AT_type(*$C$DW$T$34)

	.dwendtag $C$DW$1


$C$DW$3	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$3, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$3, DW_AT_linkage_name("GPIO_setQualificationMode")
	.dwattr $C$DW$3, DW_AT_declaration
	.dwattr $C$DW$3, DW_AT_external
	.dwattr $C$DW$3, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$3, DW_AT_decl_line(0x395)
	.dwattr $C$DW$3, DW_AT_decl_column(0x01)
$C$DW$4	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$4, DW_AT_type(*$C$DW$T$34)

$C$DW$5	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$5, DW_AT_type(*$C$DW$T$27)

	.dwendtag $C$DW$3


$C$DW$6	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$6, DW_AT_name("SCI_setConfig")
	.dwattr $C$DW$6, DW_AT_linkage_name("SCI_setConfig")
	.dwattr $C$DW$6, DW_AT_declaration
	.dwattr $C$DW$6, DW_AT_external
	.dwattr $C$DW$6, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h")
	.dwattr $C$DW$6, DW_AT_decl_line(0x4ea)
	.dwattr $C$DW$6, DW_AT_decl_column(0x01)
$C$DW$7	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$7, DW_AT_type(*$C$DW$T$34)

$C$DW$8	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$8, DW_AT_type(*$C$DW$T$34)

$C$DW$9	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$9, DW_AT_type(*$C$DW$T$34)

$C$DW$10	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$10, DW_AT_type(*$C$DW$T$34)

	.dwendtag $C$DW$6


$C$DW$11	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$11, DW_AT_name("SCI_enableInterrupt")
	.dwattr $C$DW$11, DW_AT_linkage_name("SCI_enableInterrupt")
	.dwattr $C$DW$11, DW_AT_declaration
	.dwattr $C$DW$11, DW_AT_external
	.dwattr $C$DW$11, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h")
	.dwattr $C$DW$11, DW_AT_decl_line(0x535)
	.dwattr $C$DW$11, DW_AT_decl_column(0x01)
$C$DW$12	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$12, DW_AT_type(*$C$DW$T$34)

$C$DW$13	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$13, DW_AT_type(*$C$DW$T$34)

	.dwendtag $C$DW$11


$C$DW$14	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$14, DW_AT_name("SCI_clearInterruptStatus")
	.dwattr $C$DW$14, DW_AT_linkage_name("SCI_clearInterruptStatus")
	.dwattr $C$DW$14, DW_AT_declaration
	.dwattr $C$DW$14, DW_AT_external
	.dwattr $C$DW$14, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h")
	.dwattr $C$DW$14, DW_AT_decl_line(0x56a)
	.dwattr $C$DW$14, DW_AT_decl_column(0x01)
$C$DW$15	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$15, DW_AT_type(*$C$DW$T$34)

$C$DW$16	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$16, DW_AT_type(*$C$DW$T$34)

	.dwendtag $C$DW$14


$C$DW$17	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$17, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$17, DW_AT_linkage_name("GPIO_setDirectionMode")
	.dwattr $C$DW$17, DW_AT_declaration
	.dwattr $C$DW$17, DW_AT_external
	.dwattr $C$DW$17, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$17, DW_AT_decl_line(0x325)
	.dwattr $C$DW$17, DW_AT_decl_column(0x01)
$C$DW$18	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$18, DW_AT_type(*$C$DW$T$34)

$C$DW$19	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$19, DW_AT_type(*$C$DW$T$25)

	.dwendtag $C$DW$17

	.global	||SFRA_GUI_commsOKflg||
	.bss	||SFRA_GUI_commsOKflg||,1,1,0
$C$DW$20	.dwtag  DW_TAG_variable
	.dwattr $C$DW$20, DW_AT_name("SFRA_GUI_commsOKflg")
	.dwattr $C$DW$20, DW_AT_linkage_name("SFRA_GUI_commsOKflg")
	.dwattr $C$DW$20, DW_AT_location[DW_OP_addr ||SFRA_GUI_commsOKflg||]
	.dwattr $C$DW$20, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$20, DW_AT_external
	.dwattr $C$DW$20, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$20, DW_AT_decl_line(0x48)
	.dwattr $C$DW$20, DW_AT_decl_column(0x12)

	.global	||SFRA_GUI_serialCommsTimer||
	.bss	||SFRA_GUI_serialCommsTimer||,1,1,0
$C$DW$21	.dwtag  DW_TAG_variable
	.dwattr $C$DW$21, DW_AT_name("SFRA_GUI_serialCommsTimer")
	.dwattr $C$DW$21, DW_AT_linkage_name("SFRA_GUI_serialCommsTimer")
	.dwattr $C$DW$21, DW_AT_location[DW_OP_addr ||SFRA_GUI_serialCommsTimer||]
	.dwattr $C$DW$21, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$21, DW_AT_external
	.dwattr $C$DW$21, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$21, DW_AT_decl_line(0x49)
	.dwattr $C$DW$21, DW_AT_decl_column(0x12)

	.global	||SFRA_GUI_lowByteFlag||
	.bss	||SFRA_GUI_lowByteFlag||,1,1,0
$C$DW$22	.dwtag  DW_TAG_variable
	.dwattr $C$DW$22, DW_AT_name("SFRA_GUI_lowByteFlag")
	.dwattr $C$DW$22, DW_AT_linkage_name("SFRA_GUI_lowByteFlag")
	.dwattr $C$DW$22, DW_AT_location[DW_OP_addr ||SFRA_GUI_lowByteFlag||]
	.dwattr $C$DW$22, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$22, DW_AT_external
	.dwattr $C$DW$22, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$22, DW_AT_decl_line(0x4d)
	.dwattr $C$DW$22, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_sendTaskPtr||
	.bss	||SFRA_GUI_sendTaskPtr||,1,1,0
$C$DW$23	.dwtag  DW_TAG_variable
	.dwattr $C$DW$23, DW_AT_name("SFRA_GUI_sendTaskPtr")
	.dwattr $C$DW$23, DW_AT_linkage_name("SFRA_GUI_sendTaskPtr")
	.dwattr $C$DW$23, DW_AT_location[DW_OP_addr ||SFRA_GUI_sendTaskPtr||]
	.dwattr $C$DW$23, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$23, DW_AT_external
	.dwattr $C$DW$23, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$23, DW_AT_decl_line(0x4e)
	.dwattr $C$DW$23, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_rxChar||
	.bss	||SFRA_GUI_rxChar||,1,1,0
$C$DW$24	.dwtag  DW_TAG_variable
	.dwattr $C$DW$24, DW_AT_name("SFRA_GUI_rxChar")
	.dwattr $C$DW$24, DW_AT_linkage_name("SFRA_GUI_rxChar")
	.dwattr $C$DW$24, DW_AT_location[DW_OP_addr ||SFRA_GUI_rxChar||]
	.dwattr $C$DW$24, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$24, DW_AT_external
	.dwattr $C$DW$24, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$24, DW_AT_decl_line(0x4f)
	.dwattr $C$DW$24, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_rxWord||
	.bss	||SFRA_GUI_rxWord||,1,1,0
$C$DW$25	.dwtag  DW_TAG_variable
	.dwattr $C$DW$25, DW_AT_name("SFRA_GUI_rxWord")
	.dwattr $C$DW$25, DW_AT_linkage_name("SFRA_GUI_rxWord")
	.dwattr $C$DW$25, DW_AT_location[DW_OP_addr ||SFRA_GUI_rxWord||]
	.dwattr $C$DW$25, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$25, DW_AT_external
	.dwattr $C$DW$25, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$25, DW_AT_decl_line(0x50)
	.dwattr $C$DW$25, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_taskDoneFlag||
	.bss	||SFRA_GUI_taskDoneFlag||,1,1,0
$C$DW$26	.dwtag  DW_TAG_variable
	.dwattr $C$DW$26, DW_AT_name("SFRA_GUI_taskDoneFlag")
	.dwattr $C$DW$26, DW_AT_linkage_name("SFRA_GUI_taskDoneFlag")
	.dwattr $C$DW$26, DW_AT_location[DW_OP_addr ||SFRA_GUI_taskDoneFlag||]
	.dwattr $C$DW$26, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$26, DW_AT_external
	.dwattr $C$DW$26, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$26, DW_AT_decl_line(0x52)
	.dwattr $C$DW$26, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_numWords||
	.bss	||SFRA_GUI_numWords||,1,1,0
$C$DW$27	.dwtag  DW_TAG_variable
	.dwattr $C$DW$27, DW_AT_name("SFRA_GUI_numWords")
	.dwattr $C$DW$27, DW_AT_linkage_name("SFRA_GUI_numWords")
	.dwattr $C$DW$27, DW_AT_location[DW_OP_addr ||SFRA_GUI_numWords||]
	.dwattr $C$DW$27, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$27, DW_AT_external
	.dwattr $C$DW$27, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$27, DW_AT_decl_line(0x53)
	.dwattr $C$DW$27, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_wordsLeftToGet||
	.bss	||SFRA_GUI_wordsLeftToGet||,1,1,0
$C$DW$28	.dwtag  DW_TAG_variable
	.dwattr $C$DW$28, DW_AT_name("SFRA_GUI_wordsLeftToGet")
	.dwattr $C$DW$28, DW_AT_linkage_name("SFRA_GUI_wordsLeftToGet")
	.dwattr $C$DW$28, DW_AT_location[DW_OP_addr ||SFRA_GUI_wordsLeftToGet||]
	.dwattr $C$DW$28, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$28, DW_AT_external
	.dwattr $C$DW$28, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$28, DW_AT_decl_line(0x54)
	.dwattr $C$DW$28, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_dataOut16||
	.bss	||SFRA_GUI_dataOut16||,1,1,0
$C$DW$29	.dwtag  DW_TAG_variable
	.dwattr $C$DW$29, DW_AT_name("SFRA_GUI_dataOut16")
	.dwattr $C$DW$29, DW_AT_linkage_name("SFRA_GUI_dataOut16")
	.dwattr $C$DW$29, DW_AT_location[DW_OP_addr ||SFRA_GUI_dataOut16||]
	.dwattr $C$DW$29, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$29, DW_AT_external
	.dwattr $C$DW$29, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$29, DW_AT_decl_line(0x56)
	.dwattr $C$DW$29, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_rcvTskPtrShdw||
	.bss	||SFRA_GUI_rcvTskPtrShdw||,1,1,0
$C$DW$30	.dwtag  DW_TAG_variable
	.dwattr $C$DW$30, DW_AT_name("SFRA_GUI_rcvTskPtrShdw")
	.dwattr $C$DW$30, DW_AT_linkage_name("SFRA_GUI_rcvTskPtrShdw")
	.dwattr $C$DW$30, DW_AT_location[DW_OP_addr ||SFRA_GUI_rcvTskPtrShdw||]
	.dwattr $C$DW$30, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$30, DW_AT_external
	.dwattr $C$DW$30, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$30, DW_AT_decl_line(0x5f)
	.dwattr $C$DW$30, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_delayer||
	.bss	||SFRA_GUI_delayer||,1,1,0
$C$DW$31	.dwtag  DW_TAG_variable
	.dwattr $C$DW$31, DW_AT_name("SFRA_GUI_delayer")
	.dwattr $C$DW$31, DW_AT_linkage_name("SFRA_GUI_delayer")
	.dwattr $C$DW$31, DW_AT_location[DW_OP_addr ||SFRA_GUI_delayer||]
	.dwattr $C$DW$31, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$31, DW_AT_external
	.dwattr $C$DW$31, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$31, DW_AT_decl_line(0x61)
	.dwattr $C$DW$31, DW_AT_decl_column(0x09)

	.global	||SFRA_GUI_memGetPtr||
	.bss	||SFRA_GUI_memGetPtr||,1,1,0
$C$DW$32	.dwtag  DW_TAG_variable
	.dwattr $C$DW$32, DW_AT_name("SFRA_GUI_memGetPtr")
	.dwattr $C$DW$32, DW_AT_linkage_name("SFRA_GUI_memGetPtr")
	.dwattr $C$DW$32, DW_AT_location[DW_OP_addr ||SFRA_GUI_memGetPtr||]
	.dwattr $C$DW$32, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$32, DW_AT_external
	.dwattr $C$DW$32, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$32, DW_AT_decl_line(0x63)
	.dwattr $C$DW$32, DW_AT_decl_column(0x09)

	.global	||SFRA_GUI_memGetAmount||
	.bss	||SFRA_GUI_memGetAmount||,1,1,0
$C$DW$33	.dwtag  DW_TAG_variable
	.dwattr $C$DW$33, DW_AT_name("SFRA_GUI_memGetAmount")
	.dwattr $C$DW$33, DW_AT_linkage_name("SFRA_GUI_memGetAmount")
	.dwattr $C$DW$33, DW_AT_location[DW_OP_addr ||SFRA_GUI_memGetAmount||]
	.dwattr $C$DW$33, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$33, DW_AT_external
	.dwattr $C$DW$33, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$33, DW_AT_decl_line(0x65)
	.dwattr $C$DW$33, DW_AT_decl_column(0x09)

	.global	||SFRA_GUI_memSetPtr||
	.bss	||SFRA_GUI_memSetPtr||,1,1,0
$C$DW$34	.dwtag  DW_TAG_variable
	.dwattr $C$DW$34, DW_AT_name("SFRA_GUI_memSetPtr")
	.dwattr $C$DW$34, DW_AT_linkage_name("SFRA_GUI_memSetPtr")
	.dwattr $C$DW$34, DW_AT_location[DW_OP_addr ||SFRA_GUI_memSetPtr||]
	.dwattr $C$DW$34, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$34, DW_AT_external
	.dwattr $C$DW$34, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$34, DW_AT_decl_line(0x67)
	.dwattr $C$DW$34, DW_AT_decl_column(0x09)

	.global	||SFRA_GUI_led_flag||
	.bss	||SFRA_GUI_led_flag||,1,1,0
$C$DW$35	.dwtag  DW_TAG_variable
	.dwattr $C$DW$35, DW_AT_name("SFRA_GUI_led_flag")
	.dwattr $C$DW$35, DW_AT_linkage_name("SFRA_GUI_led_flag")
	.dwattr $C$DW$35, DW_AT_location[DW_OP_addr ||SFRA_GUI_led_flag||]
	.dwattr $C$DW$35, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$35, DW_AT_external
	.dwattr $C$DW$35, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$35, DW_AT_decl_line(0x6c)
	.dwattr $C$DW$35, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_led_gpio||
	.bss	||SFRA_GUI_led_gpio||,1,1,0
$C$DW$36	.dwtag  DW_TAG_variable
	.dwattr $C$DW$36, DW_AT_name("SFRA_GUI_led_gpio")
	.dwattr $C$DW$36, DW_AT_linkage_name("SFRA_GUI_led_gpio")
	.dwattr $C$DW$36, DW_AT_location[DW_OP_addr ||SFRA_GUI_led_gpio||]
	.dwattr $C$DW$36, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$36, DW_AT_external
	.dwattr $C$DW$36, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$36, DW_AT_decl_line(0x6d)
	.dwattr $C$DW$36, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_sweep_start||
	.bss	||SFRA_GUI_sweep_start||,1,1,0
$C$DW$37	.dwtag  DW_TAG_variable
	.dwattr $C$DW$37, DW_AT_name("SFRA_GUI_sweep_start")
	.dwattr $C$DW$37, DW_AT_linkage_name("SFRA_GUI_sweep_start")
	.dwattr $C$DW$37, DW_AT_location[DW_OP_addr ||SFRA_GUI_sweep_start||]
	.dwattr $C$DW$37, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$37, DW_AT_external
	.dwattr $C$DW$37, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$37, DW_AT_decl_line(0x6f)
	.dwattr $C$DW$37, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_rcvTaskPointer||
	.bss	||SFRA_GUI_rcvTaskPointer||,2,1,1
$C$DW$38	.dwtag  DW_TAG_variable
	.dwattr $C$DW$38, DW_AT_name("SFRA_GUI_rcvTaskPointer")
	.dwattr $C$DW$38, DW_AT_linkage_name("SFRA_GUI_rcvTaskPointer")
	.dwattr $C$DW$38, DW_AT_location[DW_OP_addr ||SFRA_GUI_rcvTaskPointer||]
	.dwattr $C$DW$38, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$38, DW_AT_external
	.dwattr $C$DW$38, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$38, DW_AT_decl_line(0x39)
	.dwattr $C$DW$38, DW_AT_decl_column(0x08)

	.global	||SFRA_GUI_sci_base_addr||
	.bss	||SFRA_GUI_sci_base_addr||,2,1,1
$C$DW$39	.dwtag  DW_TAG_variable
	.dwattr $C$DW$39, DW_AT_name("SFRA_GUI_sci_base_addr")
	.dwattr $C$DW$39, DW_AT_linkage_name("SFRA_GUI_sci_base_addr")
	.dwattr $C$DW$39, DW_AT_location[DW_OP_addr ||SFRA_GUI_sci_base_addr||]
	.dwattr $C$DW$39, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$39, DW_AT_external
	.dwattr $C$DW$39, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$39, DW_AT_decl_line(0x4b)
	.dwattr $C$DW$39, DW_AT_decl_column(0x13)

	.global	||SFRA_GUI_dataOut32||
	.bss	||SFRA_GUI_dataOut32||,2,1,1
$C$DW$40	.dwtag  DW_TAG_variable
	.dwattr $C$DW$40, DW_AT_name("SFRA_GUI_dataOut32")
	.dwattr $C$DW$40, DW_AT_linkage_name("SFRA_GUI_dataOut32")
	.dwattr $C$DW$40, DW_AT_location[DW_OP_addr ||SFRA_GUI_dataOut32||]
	.dwattr $C$DW$40, DW_AT_type(*$C$DW$T$83)
	.dwattr $C$DW$40, DW_AT_external
	.dwattr $C$DW$40, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$40, DW_AT_decl_line(0x57)
	.dwattr $C$DW$40, DW_AT_decl_column(0x09)

	.global	||SFRA_GUI_memDataPtr16||
	.bss	||SFRA_GUI_memDataPtr16||,2,1,1
$C$DW$41	.dwtag  DW_TAG_variable
	.dwattr $C$DW$41, DW_AT_name("SFRA_GUI_memDataPtr16")
	.dwattr $C$DW$41, DW_AT_linkage_name("SFRA_GUI_memDataPtr16")
	.dwattr $C$DW$41, DW_AT_location[DW_OP_addr ||SFRA_GUI_memDataPtr16||]
	.dwattr $C$DW$41, DW_AT_type(*$C$DW$T$64)
	.dwattr $C$DW$41, DW_AT_external
	.dwattr $C$DW$41, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$41, DW_AT_decl_line(0x59)
	.dwattr $C$DW$41, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_memDataPtr32||
	.bss	||SFRA_GUI_memDataPtr32||,2,1,1
$C$DW$42	.dwtag  DW_TAG_variable
	.dwattr $C$DW$42, DW_AT_name("SFRA_GUI_memDataPtr32")
	.dwattr $C$DW$42, DW_AT_linkage_name("SFRA_GUI_memDataPtr32")
	.dwattr $C$DW$42, DW_AT_location[DW_OP_addr ||SFRA_GUI_memDataPtr32||]
	.dwattr $C$DW$42, DW_AT_type(*$C$DW$T$84)
	.dwattr $C$DW$42, DW_AT_external
	.dwattr $C$DW$42, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$42, DW_AT_decl_line(0x5a)
	.dwattr $C$DW$42, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_memGetAddress||
	.bss	||SFRA_GUI_memGetAddress||,2,1,1
$C$DW$43	.dwtag  DW_TAG_variable
	.dwattr $C$DW$43, DW_AT_name("SFRA_GUI_memGetAddress")
	.dwattr $C$DW$43, DW_AT_linkage_name("SFRA_GUI_memGetAddress")
	.dwattr $C$DW$43, DW_AT_location[DW_OP_addr ||SFRA_GUI_memGetAddress||]
	.dwattr $C$DW$43, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$43, DW_AT_external
	.dwattr $C$DW$43, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$43, DW_AT_decl_line(0x64)
	.dwattr $C$DW$43, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_memSetValue||
	.bss	||SFRA_GUI_memSetValue||,2,1,1
$C$DW$44	.dwtag  DW_TAG_variable
	.dwattr $C$DW$44, DW_AT_name("SFRA_GUI_memSetValue")
	.dwattr $C$DW$44, DW_AT_linkage_name("SFRA_GUI_memSetValue")
	.dwattr $C$DW$44, DW_AT_location[DW_OP_addr ||SFRA_GUI_memSetValue||]
	.dwattr $C$DW$44, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$44, DW_AT_external
	.dwattr $C$DW$44, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$44, DW_AT_decl_line(0x68)
	.dwattr $C$DW$44, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_temp||
	.bss	||SFRA_GUI_temp||,2,1,1
$C$DW$45	.dwtag  DW_TAG_variable
	.dwattr $C$DW$45, DW_AT_name("SFRA_GUI_temp")
	.dwattr $C$DW$45, DW_AT_linkage_name("SFRA_GUI_temp")
	.dwattr $C$DW$45, DW_AT_location[DW_OP_addr ||SFRA_GUI_temp||]
	.dwattr $C$DW$45, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$45, DW_AT_external
	.dwattr $C$DW$45, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$45, DW_AT_decl_line(0x6a)
	.dwattr $C$DW$45, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_cmdPacket||
||SFRA_GUI_cmdPacket||:	.usect	".bss:SFRA_GUI_cmdPacket",6,0,0
$C$DW$46	.dwtag  DW_TAG_variable
	.dwattr $C$DW$46, DW_AT_name("SFRA_GUI_cmdPacket")
	.dwattr $C$DW$46, DW_AT_linkage_name("SFRA_GUI_cmdPacket")
	.dwattr $C$DW$46, DW_AT_location[DW_OP_addr ||SFRA_GUI_cmdPacket||]
	.dwattr $C$DW$46, DW_AT_type(*$C$DW$T$74)
	.dwattr $C$DW$46, DW_AT_external
	.dwattr $C$DW$46, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$46, DW_AT_decl_line(0x51)
	.dwattr $C$DW$46, DW_AT_decl_column(0x0a)

	.global	||SFRA_GUI_cmdDispatcher||
||SFRA_GUI_cmdDispatcher||:	.usect	".bss:SFRA_GUI_cmdDispatcher",32,0,1
$C$DW$47	.dwtag  DW_TAG_variable
	.dwattr $C$DW$47, DW_AT_name("SFRA_GUI_cmdDispatcher")
	.dwattr $C$DW$47, DW_AT_linkage_name("SFRA_GUI_cmdDispatcher")
	.dwattr $C$DW$47, DW_AT_location[DW_OP_addr ||SFRA_GUI_cmdDispatcher||]
	.dwattr $C$DW$47, DW_AT_type(*$C$DW$T$53)
	.dwattr $C$DW$47, DW_AT_external
	.dwattr $C$DW$47, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$47, DW_AT_decl_line(0x3e)
	.dwattr $C$DW$47, DW_AT_decl_column(0x08)

	.global	||SFRA_GUI_varSetTxtList||
||SFRA_GUI_varSetTxtList||:	.usect	".bss:SFRA_GUI_varSetTxtList",32,0,1
$C$DW$48	.dwtag  DW_TAG_variable
	.dwattr $C$DW$48, DW_AT_name("SFRA_GUI_varSetTxtList")
	.dwattr $C$DW$48, DW_AT_linkage_name("SFRA_GUI_varSetTxtList")
	.dwattr $C$DW$48, DW_AT_location[DW_OP_addr ||SFRA_GUI_varSetTxtList||]
	.dwattr $C$DW$48, DW_AT_type(*$C$DW$T$67)
	.dwattr $C$DW$48, DW_AT_external
	.dwattr $C$DW$48, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$48, DW_AT_decl_line(0x40)
	.dwattr $C$DW$48, DW_AT_decl_column(0x13)

	.global	||SFRA_GUI_varSetBtnList||
||SFRA_GUI_varSetBtnList||:	.usect	".bss:SFRA_GUI_varSetBtnList",32,0,1
$C$DW$49	.dwtag  DW_TAG_variable
	.dwattr $C$DW$49, DW_AT_name("SFRA_GUI_varSetBtnList")
	.dwattr $C$DW$49, DW_AT_linkage_name("SFRA_GUI_varSetBtnList")
	.dwattr $C$DW$49, DW_AT_location[DW_OP_addr ||SFRA_GUI_varSetBtnList||]
	.dwattr $C$DW$49, DW_AT_type(*$C$DW$T$67)
	.dwattr $C$DW$49, DW_AT_external
	.dwattr $C$DW$49, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$49, DW_AT_decl_line(0x41)
	.dwattr $C$DW$49, DW_AT_decl_column(0x13)

	.global	||SFRA_GUI_varSetSldrList||
||SFRA_GUI_varSetSldrList||:	.usect	".bss:SFRA_GUI_varSetSldrList",32,0,1
$C$DW$50	.dwtag  DW_TAG_variable
	.dwattr $C$DW$50, DW_AT_name("SFRA_GUI_varSetSldrList")
	.dwattr $C$DW$50, DW_AT_linkage_name("SFRA_GUI_varSetSldrList")
	.dwattr $C$DW$50, DW_AT_location[DW_OP_addr ||SFRA_GUI_varSetSldrList||]
	.dwattr $C$DW$50, DW_AT_type(*$C$DW$T$67)
	.dwattr $C$DW$50, DW_AT_external
	.dwattr $C$DW$50, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$50, DW_AT_decl_line(0x42)
	.dwattr $C$DW$50, DW_AT_decl_column(0x13)

	.global	||SFRA_GUI_varGetList||
||SFRA_GUI_varGetList||:	.usect	".bss:SFRA_GUI_varGetList",32,0,1
$C$DW$51	.dwtag  DW_TAG_variable
	.dwattr $C$DW$51, DW_AT_name("SFRA_GUI_varGetList")
	.dwattr $C$DW$51, DW_AT_linkage_name("SFRA_GUI_varGetList")
	.dwattr $C$DW$51, DW_AT_location[DW_OP_addr ||SFRA_GUI_varGetList||]
	.dwattr $C$DW$51, DW_AT_type(*$C$DW$T$67)
	.dwattr $C$DW$51, DW_AT_external
	.dwattr $C$DW$51, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$51, DW_AT_decl_line(0x43)
	.dwattr $C$DW$51, DW_AT_decl_column(0x13)

	.global	||SFRA_GUI_arrayGetList||
||SFRA_GUI_arrayGetList||:	.usect	".bss:SFRA_GUI_arrayGetList",32,0,1
$C$DW$52	.dwtag  DW_TAG_variable
	.dwattr $C$DW$52, DW_AT_name("SFRA_GUI_arrayGetList")
	.dwattr $C$DW$52, DW_AT_linkage_name("SFRA_GUI_arrayGetList")
	.dwattr $C$DW$52, DW_AT_location[DW_OP_addr ||SFRA_GUI_arrayGetList||]
	.dwattr $C$DW$52, DW_AT_type(*$C$DW$T$87)
	.dwattr $C$DW$52, DW_AT_external
	.dwattr $C$DW$52, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$52, DW_AT_decl_line(0x44)
	.dwattr $C$DW$52, DW_AT_decl_column(0x13)

	.global	||SFRA_GUI_dataGetList||
||SFRA_GUI_dataGetList||:	.usect	".bss:SFRA_GUI_dataGetList",32,0,1
$C$DW$53	.dwtag  DW_TAG_variable
	.dwattr $C$DW$53, DW_AT_name("SFRA_GUI_dataGetList")
	.dwattr $C$DW$53, DW_AT_linkage_name("SFRA_GUI_dataGetList")
	.dwattr $C$DW$53, DW_AT_location[DW_OP_addr ||SFRA_GUI_dataGetList||]
	.dwattr $C$DW$53, DW_AT_type(*$C$DW$T$67)
	.dwattr $C$DW$53, DW_AT_external
	.dwattr $C$DW$53, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$53, DW_AT_decl_line(0x45)
	.dwattr $C$DW$53, DW_AT_decl_column(0x13)

	.global	||SFRA_GUI_dataSetList||
||SFRA_GUI_dataSetList||:	.usect	".bss:SFRA_GUI_dataSetList",32,0,1
$C$DW$54	.dwtag  DW_TAG_variable
	.dwattr $C$DW$54, DW_AT_name("SFRA_GUI_dataSetList")
	.dwattr $C$DW$54, DW_AT_linkage_name("SFRA_GUI_dataSetList")
	.dwattr $C$DW$54, DW_AT_location[DW_OP_addr ||SFRA_GUI_dataSetList||]
	.dwattr $C$DW$54, DW_AT_type(*$C$DW$T$95)
	.dwattr $C$DW$54, DW_AT_external
	.dwattr $C$DW$54, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$54, DW_AT_decl_line(0x46)
	.dwattr $C$DW$54, DW_AT_decl_column(0x14)

	.sblock	".bss"
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\opt2000.exe C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{D3879C9A-F1E2-4935-9868-85B2B589D42B} C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{C654BA2A-6AE7-4B0D-AF34-2DC3BA59893F} 
;	C:\ti\ccs1011\ccs\tools\compiler\ti-cgt-c2000_20.2.4.LTS\bin\acia2000.exe -@C:\\Users\\LUCAS~1.OLD\\AppData\\Local\\Temp\\{0836A08E-D48B-43AF-9BD5-AB47F70B8024} 
	.sect	".text:__signbitl"
	.clink
	.global	||__signbitl||

$C$DW$55	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$55, DW_AT_name("__signbitl")
	.dwattr $C$DW$55, DW_AT_low_pc(||__signbitl||)
	.dwattr $C$DW$55, DW_AT_high_pc(0x00)
	.dwattr $C$DW$55, DW_AT_linkage_name("__signbitl")
	.dwattr $C$DW$55, DW_AT_external
	.dwattr $C$DW$55, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$55, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$55, DW_AT_decl_line(0x16f)
	.dwattr $C$DW$55, DW_AT_decl_column(0x25)
	.dwattr $C$DW$55, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 368,column 1,is_stmt,address ||__signbitl||,isa 0

	.dwfde $C$DW$CIE, ||__signbitl||
$C$DW$56	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$56, DW_AT_name("e")
	.dwattr $C$DW$56, DW_AT_type(*$C$DW$T$103)
	.dwattr $C$DW$56, DW_AT_location[DW_OP_reg12]


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
$C$DW$57	.dwtag  DW_TAG_variable
	.dwattr $C$DW$57, DW_AT_name("e")
	.dwattr $C$DW$57, DW_AT_type(*$C$DW$T$104)
	.dwattr $C$DW$57, DW_AT_location[DW_OP_reg12]

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
$C$DW$58	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$58, DW_AT_low_pc(0x00)
	.dwattr $C$DW$58, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$58, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |368| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |368| 
        MOVB      AH,#0                 ; [CPU_ALU] |368| 
        CMPB      AL,#0                 ; [CPU_ALU] |368| 
        MOVB      AH,#1,NEQ             ; [CPU_ALU] |368| 
        MOV       AL,AH                 ; [CPU_ALU] |368| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$59	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$59, DW_AT_low_pc(0x00)
	.dwattr $C$DW$59, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$55, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$55, DW_AT_TI_end_line(0x170)
	.dwattr $C$DW$55, DW_AT_TI_end_column(0x2b)
	.dwendentry
	.dwendtag $C$DW$55

	.sect	".text:__signbitf"
	.clink
	.global	||__signbitf||

$C$DW$60	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$60, DW_AT_name("__signbitf")
	.dwattr $C$DW$60, DW_AT_low_pc(||__signbitf||)
	.dwattr $C$DW$60, DW_AT_high_pc(0x00)
	.dwattr $C$DW$60, DW_AT_linkage_name("__signbitf")
	.dwattr $C$DW$60, DW_AT_external
	.dwattr $C$DW$60, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$60, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$60, DW_AT_decl_line(0x16d)
	.dwattr $C$DW$60, DW_AT_decl_column(0x25)
	.dwattr $C$DW$60, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 366,column 1,is_stmt,address ||__signbitf||,isa 0

	.dwfde $C$DW$CIE, ||__signbitf||
$C$DW$61	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$61, DW_AT_name("f")
	.dwattr $C$DW$61, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$61, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$62	.dwtag  DW_TAG_variable
	.dwattr $C$DW$62, DW_AT_name("f")
	.dwattr $C$DW$62, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$62, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$63	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$63, DW_AT_low_pc(0x00)
	.dwattr $C$DW$63, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$60, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$60, DW_AT_TI_end_line(0x16e)
	.dwattr $C$DW$60, DW_AT_TI_end_column(0x29)
	.dwendentry
	.dwendtag $C$DW$60

	.sect	".text:__signbit"
	.clink
	.global	||__signbit||

$C$DW$64	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$64, DW_AT_name("__signbit")
	.dwattr $C$DW$64, DW_AT_low_pc(||__signbit||)
	.dwattr $C$DW$64, DW_AT_high_pc(0x00)
	.dwattr $C$DW$64, DW_AT_linkage_name("__signbit")
	.dwattr $C$DW$64, DW_AT_external
	.dwattr $C$DW$64, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$64, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$64, DW_AT_decl_line(0x16b)
	.dwattr $C$DW$64, DW_AT_decl_column(0x25)
	.dwattr $C$DW$64, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 364,column 1,is_stmt,address ||__signbit||,isa 0

	.dwfde $C$DW$CIE, ||__signbit||
$C$DW$65	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$65, DW_AT_name("d")
	.dwattr $C$DW$65, DW_AT_type(*$C$DW$T$101)
	.dwattr $C$DW$65, DW_AT_location[DW_OP_reg12]


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
$C$DW$66	.dwtag  DW_TAG_variable
	.dwattr $C$DW$66, DW_AT_name("d")
	.dwattr $C$DW$66, DW_AT_type(*$C$DW$T$102)
	.dwattr $C$DW$66, DW_AT_location[DW_OP_reg12]

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
$C$DW$67	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$67, DW_AT_low_pc(0x00)
	.dwattr $C$DW$67, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$67, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |364| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |364| 
        MOVB      AH,#0                 ; [CPU_ALU] |364| 
        CMPB      AL,#0                 ; [CPU_ALU] |364| 
        MOVB      AH,#1,NEQ             ; [CPU_ALU] |364| 
        MOV       AL,AH                 ; [CPU_ALU] |364| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$68	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$68, DW_AT_low_pc(0x00)
	.dwattr $C$DW$68, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$64, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$64, DW_AT_TI_end_line(0x16c)
	.dwattr $C$DW$64, DW_AT_TI_end_column(0x2a)
	.dwendentry
	.dwendtag $C$DW$64

	.sect	".text:__relaxed_sqrtf"
	.clink
	.global	||__relaxed_sqrtf||

$C$DW$69	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$69, DW_AT_name("__relaxed_sqrtf")
	.dwattr $C$DW$69, DW_AT_low_pc(||__relaxed_sqrtf||)
	.dwattr $C$DW$69, DW_AT_high_pc(0x00)
	.dwattr $C$DW$69, DW_AT_linkage_name("__relaxed_sqrtf")
	.dwattr $C$DW$69, DW_AT_external
	.dwattr $C$DW$69, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$69, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$69, DW_AT_decl_line(0xe4)
	.dwattr $C$DW$69, DW_AT_decl_column(0x10)
	.dwattr $C$DW$69, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 229,column 1,is_stmt,address ||__relaxed_sqrtf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_sqrtf||
$C$DW$70	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$70, DW_AT_name("x")
	.dwattr $C$DW$70, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$70, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$71	.dwtag  DW_TAG_variable
	.dwattr $C$DW$71, DW_AT_name("x")
	.dwattr $C$DW$71, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$71, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 230,column 5,is_stmt,isa 0
        SQRTF32   R0H,R0H               ; [CPU_FPU] |230| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$72	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$72, DW_AT_low_pc(0x00)
	.dwattr $C$DW$72, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$69, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$69, DW_AT_TI_end_line(0xe7)
	.dwattr $C$DW$69, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$69

	.sect	".text:__relaxed_sinf"
	.clink
	.global	||__relaxed_sinf||

$C$DW$73	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$73, DW_AT_name("__relaxed_sinf")
	.dwattr $C$DW$73, DW_AT_low_pc(||__relaxed_sinf||)
	.dwattr $C$DW$73, DW_AT_high_pc(0x00)
	.dwattr $C$DW$73, DW_AT_linkage_name("__relaxed_sinf")
	.dwattr $C$DW$73, DW_AT_external
	.dwattr $C$DW$73, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$73, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$73, DW_AT_decl_line(0xe9)
	.dwattr $C$DW$73, DW_AT_decl_column(0x10)
	.dwattr $C$DW$73, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 234,column 1,is_stmt,address ||__relaxed_sinf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_sinf||
$C$DW$74	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$74, DW_AT_name("x")
	.dwattr $C$DW$74, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$74, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$75	.dwtag  DW_TAG_variable
	.dwattr $C$DW$75, DW_AT_name("x")
	.dwattr $C$DW$75, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$75, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 235,column 5,is_stmt,isa 0
        DIV2PIF32 R0H,R0H               ; [CPU_FPU] |235| 
        NOP       ; [CPU_ALU] 
        SINPUF32  R0H,R0H               ; [CPU_FPU] |235| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$76	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$76, DW_AT_low_pc(0x00)
	.dwattr $C$DW$76, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$73, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$73, DW_AT_TI_end_line(0xec)
	.dwattr $C$DW$73, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$73

	.sect	".text:__relaxed_cosf"
	.clink
	.global	||__relaxed_cosf||

$C$DW$77	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$77, DW_AT_name("__relaxed_cosf")
	.dwattr $C$DW$77, DW_AT_low_pc(||__relaxed_cosf||)
	.dwattr $C$DW$77, DW_AT_high_pc(0x00)
	.dwattr $C$DW$77, DW_AT_linkage_name("__relaxed_cosf")
	.dwattr $C$DW$77, DW_AT_external
	.dwattr $C$DW$77, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$77, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$77, DW_AT_decl_line(0xee)
	.dwattr $C$DW$77, DW_AT_decl_column(0x10)
	.dwattr $C$DW$77, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 239,column 1,is_stmt,address ||__relaxed_cosf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_cosf||
$C$DW$78	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$78, DW_AT_name("x")
	.dwattr $C$DW$78, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$78, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$79	.dwtag  DW_TAG_variable
	.dwattr $C$DW$79, DW_AT_name("x")
	.dwattr $C$DW$79, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$79, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 240,column 5,is_stmt,isa 0
        DIV2PIF32 R0H,R0H               ; [CPU_FPU] |240| 
        NOP       ; [CPU_ALU] 
        COSPUF32  R0H,R0H               ; [CPU_FPU] |240| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$80	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$80, DW_AT_low_pc(0x00)
	.dwattr $C$DW$80, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$77, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$77, DW_AT_TI_end_line(0xf1)
	.dwattr $C$DW$77, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$77

	.sect	".text:__relaxed_atanf"
	.clink
	.global	||__relaxed_atanf||

$C$DW$81	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$81, DW_AT_name("__relaxed_atanf")
	.dwattr $C$DW$81, DW_AT_low_pc(||__relaxed_atanf||)
	.dwattr $C$DW$81, DW_AT_high_pc(0x00)
	.dwattr $C$DW$81, DW_AT_linkage_name("__relaxed_atanf")
	.dwattr $C$DW$81, DW_AT_external
	.dwattr $C$DW$81, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$81, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$81, DW_AT_decl_line(0xf3)
	.dwattr $C$DW$81, DW_AT_decl_column(0x10)
	.dwattr $C$DW$81, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 244,column 1,is_stmt,address ||__relaxed_atanf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_atanf||
$C$DW$82	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$82, DW_AT_name("x")
	.dwattr $C$DW$82, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$82, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$83	.dwtag  DW_TAG_variable
	.dwattr $C$DW$83, DW_AT_name("x")
	.dwattr $C$DW$83, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$83, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$84	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$84, DW_AT_low_pc(0x00)
	.dwattr $C$DW$84, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$81, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$81, DW_AT_TI_end_line(0xf6)
	.dwattr $C$DW$81, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$81

	.sect	".text:__relaxed_atan2f"
	.clink
	.global	||__relaxed_atan2f||

$C$DW$85	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$85, DW_AT_name("__relaxed_atan2f")
	.dwattr $C$DW$85, DW_AT_low_pc(||__relaxed_atan2f||)
	.dwattr $C$DW$85, DW_AT_high_pc(0x00)
	.dwattr $C$DW$85, DW_AT_linkage_name("__relaxed_atan2f")
	.dwattr $C$DW$85, DW_AT_external
	.dwattr $C$DW$85, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$85, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$85, DW_AT_decl_line(0xf8)
	.dwattr $C$DW$85, DW_AT_decl_column(0x10)
	.dwattr $C$DW$85, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h",line 249,column 1,is_stmt,address ||__relaxed_atan2f||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_atan2f||
$C$DW$86	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$86, DW_AT_name("y")
	.dwattr $C$DW$86, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$86, DW_AT_location[DW_OP_regx 0x2b]

$C$DW$87	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$87, DW_AT_name("x")
	.dwattr $C$DW$87, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$87, DW_AT_location[DW_OP_regx 0x2f]


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
$C$DW$88	.dwtag  DW_TAG_variable
	.dwattr $C$DW$88, DW_AT_name("y")
	.dwattr $C$DW$88, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$88, DW_AT_location[DW_OP_regx 0x2b]

;* R1    assigned to x
$C$DW$89	.dwtag  DW_TAG_variable
	.dwattr $C$DW$89, DW_AT_name("x")
	.dwattr $C$DW$89, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$89, DW_AT_location[DW_OP_regx 0x2f]

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
$C$DW$90	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$90, DW_AT_low_pc(0x00)
	.dwattr $C$DW$90, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$85, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/math.h")
	.dwattr $C$DW$85, DW_AT_TI_end_line(0xfb)
	.dwattr $C$DW$85, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$85

	.sect	".text:__isnormall"
	.clink
	.global	||__isnormall||

$C$DW$91	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$91, DW_AT_name("__isnormall")
	.dwattr $C$DW$91, DW_AT_low_pc(||__isnormall||)
	.dwattr $C$DW$91, DW_AT_high_pc(0x00)
	.dwattr $C$DW$91, DW_AT_linkage_name("__isnormall")
	.dwattr $C$DW$91, DW_AT_external
	.dwattr $C$DW$91, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$91, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$91, DW_AT_decl_line(0x167)
	.dwattr $C$DW$91, DW_AT_decl_column(0x25)
	.dwattr $C$DW$91, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 360,column 1,is_stmt,address ||__isnormall||,isa 0

	.dwfde $C$DW$CIE, ||__isnormall||
$C$DW$92	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$92, DW_AT_name("e")
	.dwattr $C$DW$92, DW_AT_type(*$C$DW$T$103)
	.dwattr $C$DW$92, DW_AT_location[DW_OP_reg12]


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
$C$DW$93	.dwtag  DW_TAG_variable
	.dwattr $C$DW$93, DW_AT_name("e")
	.dwattr $C$DW$93, DW_AT_type(*$C$DW$T$104)
	.dwattr $C$DW$93, DW_AT_location[DW_OP_reg12]

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
$C$DW$94	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$94, DW_AT_low_pc(0x00)
	.dwattr $C$DW$94, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$94, DW_AT_TI_call

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
$C$DW$95	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$95, DW_AT_low_pc(0x00)
	.dwattr $C$DW$95, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$91, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$91, DW_AT_TI_end_line(0x169)
	.dwattr $C$DW$91, DW_AT_TI_end_column(0x31)
	.dwendentry
	.dwendtag $C$DW$91

	.sect	".text:__isnormalf"
	.clink
	.global	||__isnormalf||

$C$DW$96	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$96, DW_AT_name("__isnormalf")
	.dwattr $C$DW$96, DW_AT_low_pc(||__isnormalf||)
	.dwattr $C$DW$96, DW_AT_high_pc(0x00)
	.dwattr $C$DW$96, DW_AT_linkage_name("__isnormalf")
	.dwattr $C$DW$96, DW_AT_external
	.dwattr $C$DW$96, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$96, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$96, DW_AT_decl_line(0x163)
	.dwattr $C$DW$96, DW_AT_decl_column(0x25)
	.dwattr $C$DW$96, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 356,column 1,is_stmt,address ||__isnormalf||,isa 0

	.dwfde $C$DW$CIE, ||__isnormalf||
$C$DW$97	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$97, DW_AT_name("f")
	.dwattr $C$DW$97, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$97, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$98	.dwtag  DW_TAG_variable
	.dwattr $C$DW$98, DW_AT_name("f")
	.dwattr $C$DW$98, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$98, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$99	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$99, DW_AT_low_pc(0x00)
	.dwattr $C$DW$99, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$96, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$96, DW_AT_TI_end_line(0x165)
	.dwattr $C$DW$96, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$96

	.sect	".text:__isnormal"
	.clink
	.global	||__isnormal||

$C$DW$100	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$100, DW_AT_name("__isnormal")
	.dwattr $C$DW$100, DW_AT_low_pc(||__isnormal||)
	.dwattr $C$DW$100, DW_AT_high_pc(0x00)
	.dwattr $C$DW$100, DW_AT_linkage_name("__isnormal")
	.dwattr $C$DW$100, DW_AT_external
	.dwattr $C$DW$100, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$100, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$100, DW_AT_decl_line(0x15f)
	.dwattr $C$DW$100, DW_AT_decl_column(0x25)
	.dwattr $C$DW$100, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 352,column 1,is_stmt,address ||__isnormal||,isa 0

	.dwfde $C$DW$CIE, ||__isnormal||
$C$DW$101	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$101, DW_AT_name("d")
	.dwattr $C$DW$101, DW_AT_type(*$C$DW$T$101)
	.dwattr $C$DW$101, DW_AT_location[DW_OP_reg12]


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
$C$DW$102	.dwtag  DW_TAG_variable
	.dwattr $C$DW$102, DW_AT_name("d")
	.dwattr $C$DW$102, DW_AT_type(*$C$DW$T$102)
	.dwattr $C$DW$102, DW_AT_location[DW_OP_reg12]

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
$C$DW$103	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$103, DW_AT_low_pc(0x00)
	.dwattr $C$DW$103, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$103, DW_AT_TI_call

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
$C$DW$104	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$104, DW_AT_low_pc(0x00)
	.dwattr $C$DW$104, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$100, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$100, DW_AT_TI_end_line(0x161)
	.dwattr $C$DW$100, DW_AT_TI_end_column(0x30)
	.dwendentry
	.dwendtag $C$DW$100

	.sect	".text:__isnanl"
	.clink
	.global	||__isnanl||

$C$DW$105	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$105, DW_AT_name("__isnanl")
	.dwattr $C$DW$105, DW_AT_low_pc(||__isnanl||)
	.dwattr $C$DW$105, DW_AT_high_pc(0x00)
	.dwattr $C$DW$105, DW_AT_linkage_name("__isnanl")
	.dwattr $C$DW$105, DW_AT_external
	.dwattr $C$DW$105, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$105, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$105, DW_AT_decl_line(0x15b)
	.dwattr $C$DW$105, DW_AT_decl_column(0x25)
	.dwattr $C$DW$105, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 348,column 1,is_stmt,address ||__isnanl||,isa 0

	.dwfde $C$DW$CIE, ||__isnanl||
$C$DW$106	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$106, DW_AT_name("e")
	.dwattr $C$DW$106, DW_AT_type(*$C$DW$T$103)
	.dwattr $C$DW$106, DW_AT_location[DW_OP_reg12]


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
$C$DW$107	.dwtag  DW_TAG_variable
	.dwattr $C$DW$107, DW_AT_name("e")
	.dwattr $C$DW$107, DW_AT_type(*$C$DW$T$104)
	.dwattr $C$DW$107, DW_AT_location[DW_OP_reg12]

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
$C$DW$108	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$108, DW_AT_low_pc(0x00)
	.dwattr $C$DW$108, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$108, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |348| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |348| 
        CMPB      AL,#0                 ; [CPU_ALU] |348| 
        MOVB      XAR4,#1,NEQ           ; [CPU_ALU] |348| 
||$C$L4||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |348| 
$C$DW$109	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$109, DW_AT_low_pc(0x00)
	.dwattr $C$DW$109, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$105, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$105, DW_AT_TI_end_line(0x15d)
	.dwattr $C$DW$105, DW_AT_TI_end_column(0x30)
	.dwendentry
	.dwendtag $C$DW$105

	.sect	".text:__isnanf"
	.clink
	.global	||__isnanf||

$C$DW$110	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$110, DW_AT_name("__isnanf")
	.dwattr $C$DW$110, DW_AT_low_pc(||__isnanf||)
	.dwattr $C$DW$110, DW_AT_high_pc(0x00)
	.dwattr $C$DW$110, DW_AT_linkage_name("__isnanf")
	.dwattr $C$DW$110, DW_AT_external
	.dwattr $C$DW$110, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$110, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$110, DW_AT_decl_line(0x158)
	.dwattr $C$DW$110, DW_AT_decl_column(0x25)
	.dwattr $C$DW$110, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 345,column 1,is_stmt,address ||__isnanf||,isa 0

	.dwfde $C$DW$CIE, ||__isnanf||
$C$DW$111	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$111, DW_AT_name("f")
	.dwattr $C$DW$111, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$111, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$112	.dwtag  DW_TAG_variable
	.dwattr $C$DW$112, DW_AT_name("f")
	.dwattr $C$DW$112, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$112, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$113	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$113, DW_AT_low_pc(0x00)
	.dwattr $C$DW$113, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$110, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$110, DW_AT_TI_end_line(0x15a)
	.dwattr $C$DW$110, DW_AT_TI_end_column(0x2e)
	.dwendentry
	.dwendtag $C$DW$110

	.sect	".text:__isnan"
	.clink
	.global	||__isnan||

$C$DW$114	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$114, DW_AT_name("__isnan")
	.dwattr $C$DW$114, DW_AT_low_pc(||__isnan||)
	.dwattr $C$DW$114, DW_AT_high_pc(0x00)
	.dwattr $C$DW$114, DW_AT_linkage_name("__isnan")
	.dwattr $C$DW$114, DW_AT_external
	.dwattr $C$DW$114, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$114, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$114, DW_AT_decl_line(0x155)
	.dwattr $C$DW$114, DW_AT_decl_column(0x25)
	.dwattr $C$DW$114, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 342,column 1,is_stmt,address ||__isnan||,isa 0

	.dwfde $C$DW$CIE, ||__isnan||
$C$DW$115	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$115, DW_AT_name("d")
	.dwattr $C$DW$115, DW_AT_type(*$C$DW$T$101)
	.dwattr $C$DW$115, DW_AT_location[DW_OP_reg12]


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
$C$DW$116	.dwtag  DW_TAG_variable
	.dwattr $C$DW$116, DW_AT_name("d")
	.dwattr $C$DW$116, DW_AT_type(*$C$DW$T$102)
	.dwattr $C$DW$116, DW_AT_location[DW_OP_reg12]

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
$C$DW$117	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$117, DW_AT_low_pc(0x00)
	.dwattr $C$DW$117, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$117, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |342| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |342| 
        CMPB      AL,#0                 ; [CPU_ALU] |342| 
        MOVB      XAR4,#1,NEQ           ; [CPU_ALU] |342| 
||$C$L6||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |342| 
$C$DW$118	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$118, DW_AT_low_pc(0x00)
	.dwattr $C$DW$118, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$114, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$114, DW_AT_TI_end_line(0x157)
	.dwattr $C$DW$114, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$114

	.sect	".text:__isinfl"
	.clink
	.global	||__isinfl||

$C$DW$119	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$119, DW_AT_name("__isinfl")
	.dwattr $C$DW$119, DW_AT_low_pc(||__isinfl||)
	.dwattr $C$DW$119, DW_AT_high_pc(0x00)
	.dwattr $C$DW$119, DW_AT_linkage_name("__isinfl")
	.dwattr $C$DW$119, DW_AT_external
	.dwattr $C$DW$119, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$119, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$119, DW_AT_decl_line(0x17a)
	.dwattr $C$DW$119, DW_AT_decl_column(0x25)
	.dwattr $C$DW$119, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 379,column 1,is_stmt,address ||__isinfl||,isa 0

	.dwfde $C$DW$CIE, ||__isinfl||
$C$DW$120	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$120, DW_AT_name("e")
	.dwattr $C$DW$120, DW_AT_type(*$C$DW$T$103)
	.dwattr $C$DW$120, DW_AT_location[DW_OP_reg12]


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
$C$DW$121	.dwtag  DW_TAG_variable
	.dwattr $C$DW$121, DW_AT_name("e")
	.dwattr $C$DW$121, DW_AT_type(*$C$DW$T$104)
	.dwattr $C$DW$121, DW_AT_location[DW_OP_reg12]

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
$C$DW$122	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$122, DW_AT_low_pc(0x00)
	.dwattr $C$DW$122, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$122, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |379| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |379| 
        CMPB      AL,#0                 ; [CPU_ALU] |379| 
        MOVB      XAR4,#1,EQ            ; [CPU_ALU] |379| 
||$C$L7||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |379| 
$C$DW$123	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$123, DW_AT_low_pc(0x00)
	.dwattr $C$DW$123, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$119, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$119, DW_AT_TI_end_line(0x17b)
	.dwattr $C$DW$119, DW_AT_TI_end_column(0x4c)
	.dwendentry
	.dwendtag $C$DW$119

	.sect	".text:__isinff"
	.clink
	.global	||__isinff||

$C$DW$124	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$124, DW_AT_name("__isinff")
	.dwattr $C$DW$124, DW_AT_low_pc(||__isinff||)
	.dwattr $C$DW$124, DW_AT_high_pc(0x00)
	.dwattr $C$DW$124, DW_AT_linkage_name("__isinff")
	.dwattr $C$DW$124, DW_AT_external
	.dwattr $C$DW$124, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$124, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$124, DW_AT_decl_line(0x176)
	.dwattr $C$DW$124, DW_AT_decl_column(0x25)
	.dwattr $C$DW$124, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 375,column 1,is_stmt,address ||__isinff||,isa 0

	.dwfde $C$DW$CIE, ||__isinff||
$C$DW$125	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$125, DW_AT_name("f")
	.dwattr $C$DW$125, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$125, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$126	.dwtag  DW_TAG_variable
	.dwattr $C$DW$126, DW_AT_name("f")
	.dwattr $C$DW$126, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$126, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$127	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$127, DW_AT_low_pc(0x00)
	.dwattr $C$DW$127, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$124, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$124, DW_AT_TI_end_line(0x177)
	.dwattr $C$DW$124, DW_AT_TI_end_column(0x48)
	.dwendentry
	.dwendtag $C$DW$124

	.sect	".text:__isinf"
	.clink
	.global	||__isinf||

$C$DW$128	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$128, DW_AT_name("__isinf")
	.dwattr $C$DW$128, DW_AT_low_pc(||__isinf||)
	.dwattr $C$DW$128, DW_AT_high_pc(0x00)
	.dwattr $C$DW$128, DW_AT_linkage_name("__isinf")
	.dwattr $C$DW$128, DW_AT_external
	.dwattr $C$DW$128, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$128, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$128, DW_AT_decl_line(0x178)
	.dwattr $C$DW$128, DW_AT_decl_column(0x25)
	.dwattr $C$DW$128, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 377,column 1,is_stmt,address ||__isinf||,isa 0

	.dwfde $C$DW$CIE, ||__isinf||
$C$DW$129	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$129, DW_AT_name("d")
	.dwattr $C$DW$129, DW_AT_type(*$C$DW$T$101)
	.dwattr $C$DW$129, DW_AT_location[DW_OP_reg12]


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
$C$DW$130	.dwtag  DW_TAG_variable
	.dwattr $C$DW$130, DW_AT_name("d")
	.dwattr $C$DW$130, DW_AT_type(*$C$DW$T$102)
	.dwattr $C$DW$130, DW_AT_location[DW_OP_reg12]

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
$C$DW$131	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$131, DW_AT_low_pc(0x00)
	.dwattr $C$DW$131, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$131, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |377| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |377| 
        CMPB      AL,#0                 ; [CPU_ALU] |377| 
        MOVB      XAR4,#1,EQ            ; [CPU_ALU] |377| 
||$C$L9||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |377| 
$C$DW$132	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$132, DW_AT_low_pc(0x00)
	.dwattr $C$DW$132, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$128, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$128, DW_AT_TI_end_line(0x179)
	.dwattr $C$DW$128, DW_AT_TI_end_column(0x4a)
	.dwendentry
	.dwendtag $C$DW$128

	.sect	".text:__isfinitel"
	.clink
	.global	||__isfinitel||

$C$DW$133	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$133, DW_AT_name("__isfinitel")
	.dwattr $C$DW$133, DW_AT_low_pc(||__isfinitel||)
	.dwattr $C$DW$133, DW_AT_high_pc(0x00)
	.dwattr $C$DW$133, DW_AT_linkage_name("__isfinitel")
	.dwattr $C$DW$133, DW_AT_external
	.dwattr $C$DW$133, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$133, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$133, DW_AT_decl_line(0x152)
	.dwattr $C$DW$133, DW_AT_decl_column(0x25)
	.dwattr $C$DW$133, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 339,column 1,is_stmt,address ||__isfinitel||,isa 0

	.dwfde $C$DW$CIE, ||__isfinitel||
$C$DW$134	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$134, DW_AT_name("e")
	.dwattr $C$DW$134, DW_AT_type(*$C$DW$T$103)
	.dwattr $C$DW$134, DW_AT_location[DW_OP_reg12]


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
$C$DW$135	.dwtag  DW_TAG_variable
	.dwattr $C$DW$135, DW_AT_name("e")
	.dwattr $C$DW$135, DW_AT_type(*$C$DW$T$104)
	.dwattr $C$DW$135, DW_AT_location[DW_OP_reg12]

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
$C$DW$136	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$136, DW_AT_low_pc(0x00)
	.dwattr $C$DW$136, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$133, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$133, DW_AT_TI_end_line(0x153)
	.dwattr $C$DW$133, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$133

	.sect	".text:__isfinitef"
	.clink
	.global	||__isfinitef||

$C$DW$137	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$137, DW_AT_name("__isfinitef")
	.dwattr $C$DW$137, DW_AT_low_pc(||__isfinitef||)
	.dwattr $C$DW$137, DW_AT_high_pc(0x00)
	.dwattr $C$DW$137, DW_AT_linkage_name("__isfinitef")
	.dwattr $C$DW$137, DW_AT_external
	.dwattr $C$DW$137, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$137, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$137, DW_AT_decl_line(0x150)
	.dwattr $C$DW$137, DW_AT_decl_column(0x25)
	.dwattr $C$DW$137, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 337,column 1,is_stmt,address ||__isfinitef||,isa 0

	.dwfde $C$DW$CIE, ||__isfinitef||
$C$DW$138	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$138, DW_AT_name("f")
	.dwattr $C$DW$138, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$138, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$139	.dwtag  DW_TAG_variable
	.dwattr $C$DW$139, DW_AT_name("f")
	.dwattr $C$DW$139, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$139, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$140	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$140, DW_AT_low_pc(0x00)
	.dwattr $C$DW$140, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$137, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$137, DW_AT_TI_end_line(0x151)
	.dwattr $C$DW$137, DW_AT_TI_end_column(0x2d)
	.dwendentry
	.dwendtag $C$DW$137

	.sect	".text:__isfinite"
	.clink
	.global	||__isfinite||

$C$DW$141	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$141, DW_AT_name("__isfinite")
	.dwattr $C$DW$141, DW_AT_low_pc(||__isfinite||)
	.dwattr $C$DW$141, DW_AT_high_pc(0x00)
	.dwattr $C$DW$141, DW_AT_linkage_name("__isfinite")
	.dwattr $C$DW$141, DW_AT_external
	.dwattr $C$DW$141, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$141, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$141, DW_AT_decl_line(0x14e)
	.dwattr $C$DW$141, DW_AT_decl_column(0x25)
	.dwattr $C$DW$141, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 335,column 1,is_stmt,address ||__isfinite||,isa 0

	.dwfde $C$DW$CIE, ||__isfinite||
$C$DW$142	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$142, DW_AT_name("d")
	.dwattr $C$DW$142, DW_AT_type(*$C$DW$T$101)
	.dwattr $C$DW$142, DW_AT_location[DW_OP_reg12]


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
$C$DW$143	.dwtag  DW_TAG_variable
	.dwattr $C$DW$143, DW_AT_name("d")
	.dwattr $C$DW$143, DW_AT_type(*$C$DW$T$102)
	.dwattr $C$DW$143, DW_AT_location[DW_OP_reg12]

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
$C$DW$144	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$144, DW_AT_low_pc(0x00)
	.dwattr $C$DW$144, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$141, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$141, DW_AT_TI_end_line(0x14f)
	.dwattr $C$DW$141, DW_AT_TI_end_column(0x2e)
	.dwendentry
	.dwendtag $C$DW$141

	.sect	".text:__fpclassifyl"
	.clink
	.global	||__fpclassifyl||

$C$DW$145	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$145, DW_AT_name("__fpclassifyl")
	.dwattr $C$DW$145, DW_AT_low_pc(||__fpclassifyl||)
	.dwattr $C$DW$145, DW_AT_high_pc(0x00)
	.dwattr $C$DW$145, DW_AT_linkage_name("__fpclassifyl")
	.dwattr $C$DW$145, DW_AT_external
	.dwattr $C$DW$145, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$145, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$145, DW_AT_decl_line(0x1ae)
	.dwattr $C$DW$145, DW_AT_decl_column(0x25)
	.dwattr $C$DW$145, DW_AT_TI_max_frame_size(-10)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 431,column 1,is_stmt,address ||__fpclassifyl||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassifyl||
$C$DW$146	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$146, DW_AT_name("e")
	.dwattr $C$DW$146, DW_AT_type(*$C$DW$T$103)
	.dwattr $C$DW$146, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __fpclassifyl                 FR SIZE:   8           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  4 Auto,  0 SOE     *
;***************************************************************

||__fpclassifyl||:
$C$DW$147	.dwtag  DW_TAG_variable
	.dwattr $C$DW$147, DW_AT_name("e")
	.dwattr $C$DW$147, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$147, DW_AT_location[DW_OP_breg20 -8]

;* AR5   assigned to $O$C1
;* AR4   assigned to e
$C$DW$148	.dwtag  DW_TAG_variable
	.dwattr $C$DW$148, DW_AT_name("e")
	.dwattr $C$DW$148, DW_AT_type(*$C$DW$T$104)
	.dwattr $C$DW$148, DW_AT_location[DW_OP_reg12]

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
$C$DW$149	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$149, DW_AT_low_pc(0x00)
	.dwattr $C$DW$149, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$149, DW_AT_TI_call

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
$C$DW$150	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$150, DW_AT_low_pc(0x00)
	.dwattr $C$DW$150, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$150, DW_AT_TI_call

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
$C$DW$151	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$151, DW_AT_low_pc(0x00)
	.dwattr $C$DW$151, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$151, DW_AT_TI_call

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
$C$DW$152	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$152, DW_AT_low_pc(0x00)
	.dwattr $C$DW$152, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$145, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$145, DW_AT_TI_end_line(0x1bd)
	.dwattr $C$DW$145, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$145

	.sect	".text:__fpclassifyf"
	.clink
	.global	||__fpclassifyf||

$C$DW$153	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$153, DW_AT_name("__fpclassifyf")
	.dwattr $C$DW$153, DW_AT_low_pc(||__fpclassifyf||)
	.dwattr $C$DW$153, DW_AT_high_pc(0x00)
	.dwattr $C$DW$153, DW_AT_linkage_name("__fpclassifyf")
	.dwattr $C$DW$153, DW_AT_external
	.dwattr $C$DW$153, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$153, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$153, DW_AT_decl_line(0x18c)
	.dwattr $C$DW$153, DW_AT_decl_column(0x25)
	.dwattr $C$DW$153, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 397,column 1,is_stmt,address ||__fpclassifyf||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassifyf||
$C$DW$154	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$154, DW_AT_name("f")
	.dwattr $C$DW$154, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$154, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$155	.dwtag  DW_TAG_variable
	.dwattr $C$DW$155, DW_AT_name("f")
	.dwattr $C$DW$155, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$155, DW_AT_location[DW_OP_regx 0x2b]

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
$C$DW$156	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$156, DW_AT_low_pc(0x00)
	.dwattr $C$DW$156, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L15||:    
	.dwcfi	remember_state
        MOVB      AL,#1                 ; [CPU_ALU] |402| 
$C$DW$157	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$157, DW_AT_low_pc(0x00)
	.dwattr $C$DW$157, DW_AT_TI_return

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
$C$DW$158	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$158, DW_AT_low_pc(0x00)
	.dwattr $C$DW$158, DW_AT_TI_return

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
$C$DW$159	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$159, DW_AT_low_pc(0x00)
	.dwattr $C$DW$159, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L18||:    
        MOVB      AL,#0                 ; [CPU_ALU] |402| 
$C$DW$160	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$160, DW_AT_low_pc(0x00)
	.dwattr $C$DW$160, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$153, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$153, DW_AT_TI_end_line(0x19b)
	.dwattr $C$DW$153, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$153

	.sect	".text:__fpclassify"
	.clink
	.global	||__fpclassify||

$C$DW$161	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$161, DW_AT_name("__fpclassify")
	.dwattr $C$DW$161, DW_AT_low_pc(||__fpclassify||)
	.dwattr $C$DW$161, DW_AT_high_pc(0x00)
	.dwattr $C$DW$161, DW_AT_linkage_name("__fpclassify")
	.dwattr $C$DW$161, DW_AT_external
	.dwattr $C$DW$161, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$161, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$161, DW_AT_decl_line(0x19d)
	.dwattr $C$DW$161, DW_AT_decl_column(0x25)
	.dwattr $C$DW$161, DW_AT_TI_max_frame_size(-10)
	.dwpsn	file "C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h",line 414,column 1,is_stmt,address ||__fpclassify||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassify||
$C$DW$162	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$162, DW_AT_name("d")
	.dwattr $C$DW$162, DW_AT_type(*$C$DW$T$101)
	.dwattr $C$DW$162, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __fpclassify                  FR SIZE:   8           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  4 Auto,  0 SOE     *
;***************************************************************

||__fpclassify||:
$C$DW$163	.dwtag  DW_TAG_variable
	.dwattr $C$DW$163, DW_AT_name("d")
	.dwattr $C$DW$163, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$163, DW_AT_location[DW_OP_breg20 -8]

;* AR5   assigned to $O$C1
;* AR4   assigned to d
$C$DW$164	.dwtag  DW_TAG_variable
	.dwattr $C$DW$164, DW_AT_name("d")
	.dwattr $C$DW$164, DW_AT_type(*$C$DW$T$102)
	.dwattr $C$DW$164, DW_AT_location[DW_OP_reg12]

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
$C$DW$165	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$165, DW_AT_low_pc(0x00)
	.dwattr $C$DW$165, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$165, DW_AT_TI_call

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
$C$DW$166	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$166, DW_AT_low_pc(0x00)
	.dwattr $C$DW$166, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$166, DW_AT_TI_call

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
$C$DW$167	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$167, DW_AT_low_pc(0x00)
	.dwattr $C$DW$167, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$167, DW_AT_TI_call

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
$C$DW$168	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$168, DW_AT_low_pc(0x00)
	.dwattr $C$DW$168, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$161, DW_AT_TI_end_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/_defs.h")
	.dwattr $C$DW$161, DW_AT_TI_end_line(0x1ac)
	.dwattr $C$DW$161, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$161

	.sect	".text"
	.clink
	.global	||SFRA_GUI_spareTsk08||

$C$DW$169	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$169, DW_AT_name("SFRA_GUI_spareTsk08")
	.dwattr $C$DW$169, DW_AT_low_pc(||SFRA_GUI_spareTsk08||)
	.dwattr $C$DW$169, DW_AT_high_pc(0x00)
	.dwattr $C$DW$169, DW_AT_linkage_name("SFRA_GUI_spareTsk08")
	.dwattr $C$DW$169, DW_AT_external
	.dwattr $C$DW$169, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$169, DW_AT_decl_line(0x2f4)
	.dwattr $C$DW$169, DW_AT_decl_column(0x06)
	.dwattr $C$DW$169, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 757,column 1,is_stmt,address ||SFRA_GUI_spareTsk08||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_spareTsk08||

;***************************************************************
;* FNAME: SFRA_GUI_spareTsk08           FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_spareTsk08||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVW      DP,#||SFRA_GUI_taskDoneFlag|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 761,column 5,is_stmt,isa 0
        MOVB      @||SFRA_GUI_taskDoneFlag||,#1,UNC ; [CPU_ALU] |761| 
$C$DW$170	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$170, DW_AT_low_pc(0x00)
	.dwattr $C$DW$170, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$169, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$169, DW_AT_TI_end_line(0x2fa)
	.dwattr $C$DW$169, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$169

	.sect	".text"
	.clink
	.global	||SFRA_GUI_setText||

$C$DW$171	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$171, DW_AT_name("SFRA_GUI_setText")
	.dwattr $C$DW$171, DW_AT_low_pc(||SFRA_GUI_setText||)
	.dwattr $C$DW$171, DW_AT_high_pc(0x00)
	.dwattr $C$DW$171, DW_AT_linkage_name("SFRA_GUI_setText")
	.dwattr $C$DW$171, DW_AT_external
	.dwattr $C$DW$171, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$171, DW_AT_decl_line(0x27d)
	.dwattr $C$DW$171, DW_AT_decl_column(0x06)
	.dwattr $C$DW$171, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 638,column 1,is_stmt,address ||SFRA_GUI_setText||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_setText||

;***************************************************************
;* FNAME: SFRA_GUI_setText              FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_setText||:
;* AR5   assigned to $O$C1
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 639,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_cmdPacket|| ; [CPU_ARAU] |639| 
        CLRC      SXM                   ; [CPU_ALU] 
        MOVL      XAR4,#||SFRA_GUI_varSetTxtList|| ; [CPU_ARAU] |639| 
        MOV       ACC,*+XAR5[1] << 1    ; [CPU_ALU] |639| 
        ADDL      XAR4,ACC              ; [CPU_ALU] |639| 
        MOVL      XAR4,*+XAR4[0]        ; [CPU_ALU] |639| 
        MOV       AL,*+XAR5[2]          ; [CPU_ALU] |639| 
        MOVW      DP,#||SFRA_GUI_taskDoneFlag|| ; [CPU_ARAU] 
        MOV       *+XAR4[0],AL          ; [CPU_ALU] |639| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 644,column 5,is_stmt,isa 0
        MOVB      @||SFRA_GUI_taskDoneFlag||,#1,UNC ; [CPU_ALU] |644| 
$C$DW$172	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$172, DW_AT_low_pc(0x00)
	.dwattr $C$DW$172, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$171, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$171, DW_AT_TI_end_line(0x285)
	.dwattr $C$DW$171, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$171

	.sect	".text"
	.clink
	.global	||SFRA_GUI_setSlider||

$C$DW$173	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$173, DW_AT_name("SFRA_GUI_setSlider")
	.dwattr $C$DW$173, DW_AT_low_pc(||SFRA_GUI_setSlider||)
	.dwattr $C$DW$173, DW_AT_high_pc(0x00)
	.dwattr $C$DW$173, DW_AT_linkage_name("SFRA_GUI_setSlider")
	.dwattr $C$DW$173, DW_AT_external
	.dwattr $C$DW$173, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$173, DW_AT_decl_line(0x297)
	.dwattr $C$DW$173, DW_AT_decl_column(0x06)
	.dwattr $C$DW$173, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 664,column 1,is_stmt,address ||SFRA_GUI_setSlider||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_setSlider||

;***************************************************************
;* FNAME: SFRA_GUI_setSlider            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_setSlider||:
;* AR5   assigned to $O$C1
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 665,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_cmdPacket|| ; [CPU_ARAU] |665| 
        CLRC      SXM                   ; [CPU_ALU] 
        MOVL      XAR4,#||SFRA_GUI_varSetSldrList|| ; [CPU_ARAU] |665| 
        MOV       ACC,*+XAR5[1] << 1    ; [CPU_ALU] |665| 
        ADDL      XAR4,ACC              ; [CPU_ALU] |665| 
        MOVL      XAR4,*+XAR4[0]        ; [CPU_ALU] |665| 
        MOV       AL,*+XAR5[2]          ; [CPU_ALU] |665| 
        MOVW      DP,#||SFRA_GUI_taskDoneFlag|| ; [CPU_ARAU] 
        MOV       *+XAR4[0],AL          ; [CPU_ALU] |665| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 669,column 5,is_stmt,isa 0
        MOVB      @||SFRA_GUI_taskDoneFlag||,#1,UNC ; [CPU_ALU] |669| 
$C$DW$174	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$174, DW_AT_low_pc(0x00)
	.dwattr $C$DW$174, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$173, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$173, DW_AT_TI_end_line(0x29e)
	.dwattr $C$DW$173, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$173

	.sect	".text"
	.clink
	.global	||SFRA_GUI_setData32||

$C$DW$175	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$175, DW_AT_name("SFRA_GUI_setData32")
	.dwattr $C$DW$175, DW_AT_low_pc(||SFRA_GUI_setData32||)
	.dwattr $C$DW$175, DW_AT_high_pc(0x00)
	.dwattr $C$DW$175, DW_AT_linkage_name("SFRA_GUI_setData32")
	.dwattr $C$DW$175, DW_AT_external
	.dwattr $C$DW$175, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$175, DW_AT_decl_line(0x2d9)
	.dwattr $C$DW$175, DW_AT_decl_column(0x06)
	.dwattr $C$DW$175, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 730,column 1,is_stmt,address ||SFRA_GUI_setData32||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_setData32||

;***************************************************************
;* FNAME: SFRA_GUI_setData32            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_setData32||:
;* AR4   assigned to $O$C1
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVW      DP,#||SFRA_GUI_memSetPtr|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 731,column 5,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_memSetPtr|| ; [CPU_ALU] |731| 
        B         ||$C$L24||,EQ         ; [CPU_ALU] |731| 
        ; branchcc occurs ; [] |731| 
        CMPB      AL,#1                 ; [CPU_ALU] |731| 
        B         ||$C$L26||,NEQ        ; [CPU_ALU] |731| 
        ; branchcc occurs ; [] |731| 
        MOVW      DP,#||SFRA_GUI_cmdPacket||+2 ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 741,column 13,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_cmdPacket|| ; [CPU_ARAU] |741| 
        MOVZ      AR6,@||SFRA_GUI_cmdPacket||+2 ; [CPU_ALU] |741| 
        CLRC      SXM                   ; [CPU_ALU] 
        MOVU      ACC,*+XAR4[2]         ; [CPU_ALU] |741| 
        MOVW      DP,#||SFRA_GUI_temp|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 742,column 13,is_stmt,isa 0
        LSL       ACC,16                ; [CPU_ALU] |742| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 741,column 13,is_stmt,isa 0
        MOVL      @||SFRA_GUI_temp||,XAR6 ; [CPU_ALU] |741| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 742,column 13,is_stmt,isa 0
        ADDL      @||SFRA_GUI_memSetValue||,ACC ; [CPU_ALU] |742| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 744,column 13,is_stmt,isa 0
        MOV       ACC,*+XAR4[1] << 1    ; [CPU_FPU] |744| 
        MOVL      XAR4,#||SFRA_GUI_dataSetList|| ; [CPU_ARAU] |744| 
        ADDL      XAR4,ACC              ; [CPU_ALU] |744| 
        MOVL      XAR4,*+XAR4[0]        ; [CPU_ALU] |744| 
        MOVL      ACC,@||SFRA_GUI_memSetValue|| ; [CPU_ALU] |744| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 746,column 13,is_stmt,isa 0
        MOV       @||SFRA_GUI_memSetPtr||,#0 ; [CPU_ALU] |746| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 744,column 13,is_stmt,isa 0
        MOVL      *+XAR4[0],ACC         ; [CPU_ALU] |744| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 748,column 13,is_stmt,isa 0
        B         ||$C$L25||,UNC        ; [CPU_ALU] |748| 
        ; branch occurs ; [] |748| 
||$C$L24||:    
        MOVW      DP,#||SFRA_GUI_cmdPacket||+2 ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 734,column 13,is_stmt,isa 0
        MOVU      ACC,@||SFRA_GUI_cmdPacket||+2 ; [CPU_ALU] |734| 
        MOVW      DP,#||SFRA_GUI_memSetPtr|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 735,column 13,is_stmt,isa 0
        MOVB      @||SFRA_GUI_memSetPtr||,#1,UNC ; [CPU_ALU] |735| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 734,column 13,is_stmt,isa 0
        MOVL      @||SFRA_GUI_memSetValue||,ACC ; [CPU_ALU] |734| 
||$C$L25||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 737,column 13,is_stmt,isa 0
        MOVB      @||SFRA_GUI_taskDoneFlag||,#1,UNC ; [CPU_ALU] |737| 
||$C$L26||:    
$C$DW$176	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$176, DW_AT_low_pc(0x00)
	.dwattr $C$DW$176, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$175, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$175, DW_AT_TI_end_line(0x2ef)
	.dwattr $C$DW$175, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$175

	.sect	".text"
	.clink
	.global	||SFRA_GUI_setButton||

$C$DW$177	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$177, DW_AT_name("SFRA_GUI_setButton")
	.dwattr $C$DW$177, DW_AT_low_pc(||SFRA_GUI_setButton||)
	.dwattr $C$DW$177, DW_AT_high_pc(0x00)
	.dwattr $C$DW$177, DW_AT_linkage_name("SFRA_GUI_setButton")
	.dwattr $C$DW$177, DW_AT_external
	.dwattr $C$DW$177, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$177, DW_AT_decl_line(0x28a)
	.dwattr $C$DW$177, DW_AT_decl_column(0x06)
	.dwattr $C$DW$177, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 651,column 1,is_stmt,address ||SFRA_GUI_setButton||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_setButton||

;***************************************************************
;* FNAME: SFRA_GUI_setButton            FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_setButton||:
;* AR5   assigned to $O$C1
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 652,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_cmdPacket|| ; [CPU_ARAU] |652| 
        CLRC      SXM                   ; [CPU_ALU] 
        MOVL      XAR4,#||SFRA_GUI_varSetBtnList|| ; [CPU_ARAU] |652| 
        MOV       ACC,*+XAR5[1] << 1    ; [CPU_ALU] |652| 
        ADDL      XAR4,ACC              ; [CPU_ALU] |652| 
        MOVL      XAR4,*+XAR4[0]        ; [CPU_ALU] |652| 
        MOV       AL,*+XAR5[2]          ; [CPU_ALU] |652| 
        MOVW      DP,#||SFRA_GUI_taskDoneFlag|| ; [CPU_ARAU] 
        MOV       *+XAR4[0],AL          ; [CPU_ALU] |652| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 657,column 5,is_stmt,isa 0
        MOVB      @||SFRA_GUI_taskDoneFlag||,#1,UNC ; [CPU_ALU] |657| 
$C$DW$178	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$178, DW_AT_low_pc(0x00)
	.dwattr $C$DW$178, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$177, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$177, DW_AT_TI_end_line(0x292)
	.dwattr $C$DW$177, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$177

	.sect	".text"
	.clink
	.global	||SFRA_GUI_sendData||

$C$DW$179	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$179, DW_AT_name("SFRA_GUI_sendData")
	.dwattr $C$DW$179, DW_AT_low_pc(||SFRA_GUI_sendData||)
	.dwattr $C$DW$179, DW_AT_high_pc(0x00)
	.dwattr $C$DW$179, DW_AT_linkage_name("SFRA_GUI_sendData")
	.dwattr $C$DW$179, DW_AT_external
	.dwattr $C$DW$179, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$179, DW_AT_decl_line(0x2ff)
	.dwattr $C$DW$179, DW_AT_decl_column(0x06)
	.dwattr $C$DW$179, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 768,column 1,is_stmt,address ||SFRA_GUI_sendData||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_sendData||

;***************************************************************
;* FNAME: SFRA_GUI_sendData             FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_sendData||:
;* AL    assigned to $O$C19
;* AR7   assigned to $O$v2
;* AR7   assigned to $O$v2
;* AR5   assigned to $O$v1
;* AR5   assigned to $O$v1
;* AR4   assigned to $O$K1
;* AL    assigned to $O$R1
;* AL    assigned to $O$R4
;* AL    assigned to $O$R7
;* AL    assigned to $O$R10
;* AL    assigned to $O$R13
;* AL    assigned to $O$R16
;* AR4   assigned to base
$C$DW$180	.dwtag  DW_TAG_variable
	.dwattr $C$DW$180, DW_AT_name("base")
	.dwattr $C$DW$180, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$180, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$181	.dwtag  DW_TAG_variable
	.dwattr $C$DW$181, DW_AT_name("base")
	.dwattr $C$DW$181, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$181, DW_AT_location[DW_OP_reg12]

;* AL    assigned to data
$C$DW$182	.dwtag  DW_TAG_variable
	.dwattr $C$DW$182, DW_AT_name("data")
	.dwattr $C$DW$182, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$182, DW_AT_location[DW_OP_reg0]

;* AR4   assigned to base
$C$DW$183	.dwtag  DW_TAG_variable
	.dwattr $C$DW$183, DW_AT_name("base")
	.dwattr $C$DW$183, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$183, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$184	.dwtag  DW_TAG_variable
	.dwattr $C$DW$184, DW_AT_name("base")
	.dwattr $C$DW$184, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$184, DW_AT_location[DW_OP_reg12]

;* AL    assigned to data
$C$DW$185	.dwtag  DW_TAG_variable
	.dwattr $C$DW$185, DW_AT_name("data")
	.dwattr $C$DW$185, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$185, DW_AT_location[DW_OP_reg0]

;* AR4   assigned to base
$C$DW$186	.dwtag  DW_TAG_variable
	.dwattr $C$DW$186, DW_AT_name("base")
	.dwattr $C$DW$186, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$186, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$187	.dwtag  DW_TAG_variable
	.dwattr $C$DW$187, DW_AT_name("base")
	.dwattr $C$DW$187, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$187, DW_AT_location[DW_OP_reg12]

;* AL    assigned to data
$C$DW$188	.dwtag  DW_TAG_variable
	.dwattr $C$DW$188, DW_AT_name("data")
	.dwattr $C$DW$188, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$188, DW_AT_location[DW_OP_reg0]

;* AR4   assigned to base
$C$DW$189	.dwtag  DW_TAG_variable
	.dwattr $C$DW$189, DW_AT_name("base")
	.dwattr $C$DW$189, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$189, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$190	.dwtag  DW_TAG_variable
	.dwattr $C$DW$190, DW_AT_name("base")
	.dwattr $C$DW$190, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$190, DW_AT_location[DW_OP_reg12]

;* AL    assigned to data
$C$DW$191	.dwtag  DW_TAG_variable
	.dwattr $C$DW$191, DW_AT_name("data")
	.dwattr $C$DW$191, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$191, DW_AT_location[DW_OP_reg0]

;* AR4   assigned to base
$C$DW$192	.dwtag  DW_TAG_variable
	.dwattr $C$DW$192, DW_AT_name("base")
	.dwattr $C$DW$192, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$192, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$193	.dwtag  DW_TAG_variable
	.dwattr $C$DW$193, DW_AT_name("base")
	.dwattr $C$DW$193, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$193, DW_AT_location[DW_OP_reg12]

;* AL    assigned to data
$C$DW$194	.dwtag  DW_TAG_variable
	.dwattr $C$DW$194, DW_AT_name("data")
	.dwattr $C$DW$194, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$194, DW_AT_location[DW_OP_reg0]

;* AR4   assigned to base
$C$DW$195	.dwtag  DW_TAG_variable
	.dwattr $C$DW$195, DW_AT_name("base")
	.dwattr $C$DW$195, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$195, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$196	.dwtag  DW_TAG_variable
	.dwattr $C$DW$196, DW_AT_name("base")
	.dwattr $C$DW$196, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$196, DW_AT_location[DW_OP_reg12]

;* AL    assigned to data
$C$DW$197	.dwtag  DW_TAG_variable
	.dwattr $C$DW$197, DW_AT_name("data")
	.dwattr $C$DW$197, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$197, DW_AT_location[DW_OP_reg0]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 771,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_cmdPacket|| ; [CPU_ARAU] |771| 
        MOV       AL,*+XAR4[0]          ; [CPU_ALU] |771| 
        CMPB      AL,#4                 ; [CPU_ALU] |771| 
        B         ||$C$L45||,EQ         ; [CPU_ALU] |771| 
        ; branchcc occurs ; [] |771| 
        CMPB      AL,#6                 ; [CPU_ALU] |771| 
        B         ||$C$L45||,EQ         ; [CPU_ALU] |771| 
        ; branchcc occurs ; [] |771| 
        MOVW      DP,#||SFRA_GUI_sendTaskPtr|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 816,column 9,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_sendTaskPtr|| ; [CPU_ALU] |816| 
        CMPB      AL,#2                 ; [CPU_ALU] |816| 
        B         ||$C$L27||,GT         ; [CPU_ALU] |816| 
        ; branchcc occurs ; [] |816| 
        CMPB      AL,#2                 ; [CPU_ALU] |816| 
        B         ||$C$L33||,EQ         ; [CPU_ALU] |816| 
        ; branchcc occurs ; [] |816| 
        CMPB      AL,#0                 ; [CPU_ALU] |816| 
        B         ||$C$L28||,EQ         ; [CPU_ALU] |816| 
        ; branchcc occurs ; [] |816| 
        CMPB      AL,#1                 ; [CPU_ALU] |816| 
        B         ||$C$L29||,EQ         ; [CPU_ALU] |816| 
        ; branchcc occurs ; [] |816| 
	.dwcfi	remember_state
$C$DW$198	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$198, DW_AT_low_pc(0x00)
	.dwattr $C$DW$198, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L27||:    
        CMPB      AL,#3                 ; [CPU_ALU] |816| 
        B         ||$C$L37||,EQ         ; [CPU_ALU] |816| 
        ; branchcc occurs ; [] |816| 
        CMPB      AL,#4                 ; [CPU_ALU] |816| 
        B         ||$C$L41||,EQ         ; [CPU_ALU] |816| 
        ; branchcc occurs ; [] |816| 
	.dwcfi	remember_state
$C$DW$199	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$199, DW_AT_low_pc(0x00)
	.dwattr $C$DW$199, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L28||:    
        CLRC      SXM                   ; [CPU_ALU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 819,column 9,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_arrayGetList|| ; [CPU_ARAU] |819| 
        MOV       ACC,*+XAR4[1] << 1    ; [CPU_ALU] |819| 
        ADDL      XAR5,ACC              ; [CPU_ALU] |819| 
        MOVL      XAR5,*+XAR5[0]        ; [CPU_ALU] |819| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 821,column 9,is_stmt,isa 0
        MOVL      XAR6,*+XAR5[0]        ; [CPU_ALU] |821| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 822,column 9,is_stmt,isa 0
        MOV       AL,*+XAR4[2]          ; [CPU_ALU] |822| 
        MOV       @||SFRA_GUI_wordsLeftToGet||,AL ; [CPU_ALU] |822| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 819,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_memDataPtr32||,XAR5 ; [CPU_ALU] |819| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 821,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_dataOut32||,XAR6 ; [CPU_ALU] |821| 
||$C$L29||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 827,column 13,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_wordsLeftToGet|| ; [CPU_ALU] |827| 
        B         ||$C$L56||,EQ         ; [CPU_ALU] |827| 
        ; branchcc occurs ; [] |827| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 809,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |809| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 588,column 5,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |588| 
        TBIT      *+XAR4[AR0],#14       ; [CPU_ALU] |588| 
        B         ||$C$L30||,TC         ; [CPU_ALU] |588| 
        ; branchcc occurs ; [] |588| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 832,column 9,is_stmt,isa 0
        MOV       AL,*+XAR4[4]          ; [CPU_ALU] |832| 
        LSR       AL,6                  ; [CPU_ALU] |832| 
        XORB      AL,#0x01              ; [CPU_ALU] |832| 
        ANDB      AL,#0x01              ; [CPU_ALU] |832| 
        B         ||$C$L31||,UNC        ; [CPU_ALU] |832| 
        ; branch occurs ; [] |832| 
||$C$L30||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 823,column 9,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |823| 
        AND       AL,*+XAR4[AR0],#0x1f00 ; [CPU_ALU] |823| 
        MOVZ      AR7,AL                ; [CPU_ALU] |823| 
        MOVB      XAR6,#0               ; [CPU_ALU] |823| 
        MOVL      XAR4,#7936            ; [CPU_ARAU] |823| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |823| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |823| 
        MOVB      XAR6,#1,EQ            ; [CPU_ALU] |823| 
        MOV       AL,AR6                ; [CPU_ALU] |823| 
||$C$L31||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 829,column 17,is_stmt,isa 0
        CMPB      AL,#0                 ; [CPU_ALU] |829| 
        B         ||$C$L33||,NEQ        ; [CPU_ALU] |829| 
        ; branchcc occurs ; [] |829| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 893,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |893| 
        AND       AL,@||SFRA_GUI_dataOut32||,#0x00ff ; [CPU_ALU] |893| 
||$C$L32||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 714,column 1,is_stmt,isa 0
        TBIT      *+XAR4[4],#7          ; [CPU_ALU] |714| 
        B         ||$C$L32||,NTC        ; [CPU_ALU] |714| 
        ; branchcc occurs ; [] |714| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 909,column 5,is_stmt,isa 0
        MOVB      XAR0,#9               ; [CPU_ALU] |909| 
        MOVW      DP,#||SFRA_GUI_sendTaskPtr|| ; [CPU_ARAU] 
        MOV       *+XAR4[AR0],AL        ; [CPU_ALU] |909| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 833,column 21,is_stmt,isa 0
        MOVB      @||SFRA_GUI_sendTaskPtr||,#2,UNC ; [CPU_ALU] |833| 
||$C$L33||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 809,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |809| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 588,column 5,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |588| 
        TBIT      *+XAR4[AR0],#14       ; [CPU_ALU] |588| 
        B         ||$C$L34||,TC         ; [CPU_ALU] |588| 
        ; branchcc occurs ; [] |588| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 832,column 9,is_stmt,isa 0
        MOV       AL,*+XAR4[4]          ; [CPU_ALU] |832| 
        LSR       AL,6                  ; [CPU_ALU] |832| 
        XORB      AL,#0x01              ; [CPU_ALU] |832| 
        ANDB      AL,#0x01              ; [CPU_ALU] |832| 
        B         ||$C$L35||,UNC        ; [CPU_ALU] |832| 
        ; branch occurs ; [] |832| 
||$C$L34||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 823,column 9,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |823| 
        AND       AL,*+XAR4[AR0],#0x1f00 ; [CPU_ALU] |823| 
        MOVZ      AR7,AL                ; [CPU_ALU] |823| 
        MOVB      XAR6,#0               ; [CPU_ALU] |823| 
        MOVL      XAR4,#7936            ; [CPU_ARAU] |823| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |823| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |823| 
        MOVB      XAR6,#1,EQ            ; [CPU_ALU] |823| 
        MOV       AL,AR6                ; [CPU_ALU] |823| 
||$C$L35||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 844,column 13,is_stmt,isa 0
        CMPB      AL,#0                 ; [CPU_ALU] |844| 
        B         ||$C$L37||,NEQ        ; [CPU_ALU] |844| 
        ; branchcc occurs ; [] |844| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 893,column 1,is_stmt,isa 0
        MOVL      ACC,@||SFRA_GUI_dataOut32|| ; [CPU_ALU] |893| 
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |893| 
        SETC      SXM                   ; [CPU_ALU] 
        SFR       ACC,8                 ; [CPU_ALU] |893| 
        ANDB      AL,#0xff              ; [CPU_ALU] |893| 
||$C$L36||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 714,column 1,is_stmt,isa 0
        TBIT      *+XAR4[4],#7          ; [CPU_ALU] |714| 
        B         ||$C$L36||,NTC        ; [CPU_ALU] |714| 
        ; branchcc occurs ; [] |714| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 909,column 5,is_stmt,isa 0
        MOVB      XAR0,#9               ; [CPU_ALU] |909| 
        MOVW      DP,#||SFRA_GUI_sendTaskPtr|| ; [CPU_ARAU] 
        MOV       *+XAR4[AR0],AL        ; [CPU_ALU] |909| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 848,column 17,is_stmt,isa 0
        MOVB      @||SFRA_GUI_sendTaskPtr||,#3,UNC ; [CPU_ALU] |848| 
||$C$L37||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 809,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |809| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 588,column 5,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |588| 
        TBIT      *+XAR4[AR0],#14       ; [CPU_ALU] |588| 
        B         ||$C$L38||,TC         ; [CPU_ALU] |588| 
        ; branchcc occurs ; [] |588| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 832,column 9,is_stmt,isa 0
        MOV       AL,*+XAR4[4]          ; [CPU_ALU] |832| 
        LSR       AL,6                  ; [CPU_ALU] |832| 
        XORB      AL,#0x01              ; [CPU_ALU] |832| 
        ANDB      AL,#0x01              ; [CPU_ALU] |832| 
        B         ||$C$L39||,UNC        ; [CPU_ALU] |832| 
        ; branch occurs ; [] |832| 
||$C$L38||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 823,column 9,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |823| 
        AND       AL,*+XAR4[AR0],#0x1f00 ; [CPU_ALU] |823| 
        MOVZ      AR7,AL                ; [CPU_ALU] |823| 
        MOVB      XAR6,#0               ; [CPU_ALU] |823| 
        MOVL      XAR4,#7936            ; [CPU_ARAU] |823| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |823| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |823| 
        MOVB      XAR6,#1,EQ            ; [CPU_ALU] |823| 
        MOV       AL,AR6                ; [CPU_ALU] |823| 
||$C$L39||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 852,column 13,is_stmt,isa 0
        CMPB      AL,#0                 ; [CPU_ALU] |852| 
        B         ||$C$L41||,NEQ        ; [CPU_ALU] |852| 
        ; branchcc occurs ; [] |852| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 893,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |893| 
        AND       AL,@$BLOCKED(||SFRA_GUI_dataOut32||)+1,#0x00ff ; [CPU_ALU] |893| 
||$C$L40||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 714,column 1,is_stmt,isa 0
        TBIT      *+XAR4[4],#7          ; [CPU_ALU] |714| 
        B         ||$C$L40||,NTC        ; [CPU_ALU] |714| 
        ; branchcc occurs ; [] |714| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 909,column 5,is_stmt,isa 0
        MOVB      XAR0,#9               ; [CPU_ALU] |909| 
        MOVW      DP,#||SFRA_GUI_sendTaskPtr|| ; [CPU_ARAU] 
        MOV       *+XAR4[AR0],AL        ; [CPU_ALU] |909| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 856,column 17,is_stmt,isa 0
        MOVB      @||SFRA_GUI_sendTaskPtr||,#4,UNC ; [CPU_ALU] |856| 
||$C$L41||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 809,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |809| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 588,column 5,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |588| 
        TBIT      *+XAR4[AR0],#14       ; [CPU_ALU] |588| 
        B         ||$C$L42||,TC         ; [CPU_ALU] |588| 
        ; branchcc occurs ; [] |588| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 832,column 9,is_stmt,isa 0
        MOV       AL,*+XAR4[4]          ; [CPU_ALU] |832| 
        LSR       AL,6                  ; [CPU_ALU] |832| 
        XORB      AL,#0x01              ; [CPU_ALU] |832| 
        ANDB      AL,#0x01              ; [CPU_ALU] |832| 
        B         ||$C$L43||,UNC        ; [CPU_ALU] |832| 
        ; branch occurs ; [] |832| 
||$C$L42||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 823,column 9,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |823| 
        AND       AL,*+XAR4[AR0],#0x1f00 ; [CPU_ALU] |823| 
        MOVZ      AR7,AL                ; [CPU_ALU] |823| 
        MOVB      XAR6,#0               ; [CPU_ALU] |823| 
        MOVL      XAR4,#7936            ; [CPU_ARAU] |823| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |823| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |823| 
        MOVB      XAR6,#1,EQ            ; [CPU_ALU] |823| 
        MOV       AL,AR6                ; [CPU_ALU] |823| 
||$C$L43||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 863,column 13,is_stmt,isa 0
        CMPB      AL,#0                 ; [CPU_ALU] |863| 
        B         ||$C$L57||,NEQ        ; [CPU_ALU] |863| 
        ; branchcc occurs ; [] |863| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 893,column 1,is_stmt,isa 0
        MOVL      ACC,@||SFRA_GUI_dataOut32|| ; [CPU_ALU] |893| 
        MOV       T,#24                 ; [CPU_ALU] |893| 
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |893| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 902,column 5,is_stmt,isa 0
        MOVL      XAR5,@||SFRA_GUI_memDataPtr32|| ; [CPU_ALU] |902| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 893,column 1,is_stmt,isa 0
        ASRL      ACC,T                 ; [CPU_ALU] |893| 
        ANDB      AL,#0xff              ; [CPU_ALU] |893| 
||$C$L44||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 714,column 1,is_stmt,isa 0
        TBIT      *+XAR4[4],#7          ; [CPU_ALU] |714| 
        B         ||$C$L44||,NTC        ; [CPU_ALU] |714| 
        ; branchcc occurs ; [] |714| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 909,column 5,is_stmt,isa 0
        MOVB      XAR0,#9               ; [CPU_ALU] |909| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 868,column 17,is_stmt,isa 0
        ADDB      XAR5,#2               ; [CPU_ALU] |868| 
        MOVW      DP,#||SFRA_GUI_memDataPtr32|| ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 909,column 5,is_stmt,isa 0
        MOV       *+XAR4[AR0],AL        ; [CPU_FPU] |909| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 869,column 17,is_stmt,isa 0
        MOVL      ACC,*+XAR5[0]         ; [CPU_ALU] |869| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 868,column 17,is_stmt,isa 0
        MOVL      @||SFRA_GUI_memDataPtr32||,XAR5 ; [CPU_ALU] |868| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 869,column 17,is_stmt,isa 0
        MOVL      @||SFRA_GUI_dataOut32||,ACC ; [CPU_ALU] |869| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 871,column 17,is_stmt,isa 0
        B         ||$C$L55||,UNC        ; [CPU_ALU] |871| 
        ; branch occurs ; [] |871| 
||$C$L45||:    
        MOVW      DP,#||SFRA_GUI_sendTaskPtr|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 771,column 9,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_sendTaskPtr|| ; [CPU_ALU] |771| 
        B         ||$C$L46||,EQ         ; [CPU_ALU] |771| 
        ; branchcc occurs ; [] |771| 
        CMPB      AL,#1                 ; [CPU_ALU] |771| 
        B         ||$C$L47||,EQ         ; [CPU_ALU] |771| 
        ; branchcc occurs ; [] |771| 
        CMPB      AL,#2                 ; [CPU_ALU] |771| 
        B         ||$C$L51||,EQ         ; [CPU_ALU] |771| 
        ; branchcc occurs ; [] |771| 
	.dwcfi	remember_state
$C$DW$200	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$200, DW_AT_low_pc(0x00)
	.dwattr $C$DW$200, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L46||:    
        CLRC      SXM                   ; [CPU_ALU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 775,column 13,is_stmt,isa 0
        MOV       ACC,*+XAR4[1] << 1    ; [CPU_ALU] |775| 
        MOVL      XAR4,#||SFRA_GUI_varGetList|| ; [CPU_ARAU] |775| 
        ADDL      XAR4,ACC              ; [CPU_ALU] |775| 
        MOVL      XAR7,*+XAR4[0]        ; [CPU_ALU] |775| 
        MOVL      @||SFRA_GUI_memDataPtr16||,XAR7 ; [CPU_ALU] |775| 
        MOVW      DP,#||SFRA_GUI_cmdPacket||+2 ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 777,column 13,is_stmt,isa 0
        MOV       AL,*+XAR7[0]          ; [CPU_ALU] |777| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 778,column 13,is_stmt,isa 0
        MOV       AH,@||SFRA_GUI_cmdPacket||+2 ; [CPU_ALU] |778| 
        MOVW      DP,#||SFRA_GUI_dataOut16|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 777,column 13,is_stmt,isa 0
        MOV       @||SFRA_GUI_dataOut16||,AL ; [CPU_ALU] |777| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 778,column 13,is_stmt,isa 0
        MOV       @||SFRA_GUI_wordsLeftToGet||,AH ; [CPU_ALU] |778| 
||$C$L47||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 784,column 13,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_wordsLeftToGet|| ; [CPU_ALU] |784| 
        B         ||$C$L56||,EQ         ; [CPU_ALU] |784| 
        ; branchcc occurs ; [] |784| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 809,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |809| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 588,column 5,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |588| 
        TBIT      *+XAR4[AR0],#14       ; [CPU_ALU] |588| 
        B         ||$C$L48||,TC         ; [CPU_ALU] |588| 
        ; branchcc occurs ; [] |588| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 832,column 9,is_stmt,isa 0
        MOV       AL,*+XAR4[4]          ; [CPU_ALU] |832| 
        LSR       AL,6                  ; [CPU_ALU] |832| 
        XORB      AL,#0x01              ; [CPU_ALU] |832| 
        ANDB      AL,#0x01              ; [CPU_ALU] |832| 
        B         ||$C$L49||,UNC        ; [CPU_ALU] |832| 
        ; branch occurs ; [] |832| 
||$C$L48||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 823,column 9,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |823| 
        AND       AL,*+XAR4[AR0],#0x1f00 ; [CPU_ALU] |823| 
        MOVZ      AR7,AL                ; [CPU_ALU] |823| 
        MOVB      XAR6,#0               ; [CPU_ALU] |823| 
        MOVL      XAR4,#7936            ; [CPU_ARAU] |823| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |823| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |823| 
        MOVB      XAR6,#1,EQ            ; [CPU_ALU] |823| 
        MOV       AL,AR6                ; [CPU_ALU] |823| 
||$C$L49||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 786,column 17,is_stmt,isa 0
        CMPB      AL,#0                 ; [CPU_ALU] |786| 
        B         ||$C$L51||,NEQ        ; [CPU_ALU] |786| 
        ; branchcc occurs ; [] |786| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 893,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |893| 
        AND       AL,@||SFRA_GUI_dataOut16||,#0x00ff ; [CPU_ALU] |893| 
||$C$L50||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 714,column 1,is_stmt,isa 0
        TBIT      *+XAR4[4],#7          ; [CPU_ALU] |714| 
        B         ||$C$L50||,NTC        ; [CPU_ALU] |714| 
        ; branchcc occurs ; [] |714| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 909,column 5,is_stmt,isa 0
        MOVB      XAR0,#9               ; [CPU_ALU] |909| 
        MOVW      DP,#||SFRA_GUI_sendTaskPtr|| ; [CPU_ARAU] 
        MOV       *+XAR4[AR0],AL        ; [CPU_ALU] |909| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 790,column 17,is_stmt,isa 0
        MOVB      @||SFRA_GUI_sendTaskPtr||,#2,UNC ; [CPU_ALU] |790| 
||$C$L51||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 809,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |809| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 588,column 5,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |588| 
        TBIT      *+XAR4[AR0],#14       ; [CPU_ALU] |588| 
        B         ||$C$L52||,TC         ; [CPU_ALU] |588| 
        ; branchcc occurs ; [] |588| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 832,column 9,is_stmt,isa 0
        MOV       AL,*+XAR4[4]          ; [CPU_ALU] |832| 
        LSR       AL,6                  ; [CPU_ALU] |832| 
        XORB      AL,#0x01              ; [CPU_ALU] |832| 
        ANDB      AL,#0x01              ; [CPU_ALU] |832| 
        B         ||$C$L53||,UNC        ; [CPU_ALU] |832| 
        ; branch occurs ; [] |832| 
||$C$L52||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 823,column 9,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |823| 
        AND       AL,*+XAR4[AR0],#0x1f00 ; [CPU_ALU] |823| 
        MOVZ      AR7,AL                ; [CPU_ALU] |823| 
        MOVB      XAR6,#0               ; [CPU_ALU] |823| 
        MOVL      XAR4,#7936            ; [CPU_ARAU] |823| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |823| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |823| 
        MOVB      XAR6,#1,EQ            ; [CPU_ALU] |823| 
        MOV       AL,AR6                ; [CPU_ALU] |823| 
||$C$L53||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 801,column 13,is_stmt,isa 0
        CMPB      AL,#0                 ; [CPU_ALU] |801| 
        B         ||$C$L57||,NEQ        ; [CPU_ALU] |801| 
        ; branchcc occurs ; [] |801| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 893,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |893| 
        MOV       AL,@||SFRA_GUI_dataOut16|| ; [CPU_ALU] |893| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 902,column 5,is_stmt,isa 0
        MOVL      XAR7,@||SFRA_GUI_memDataPtr16|| ; [CPU_ALU] |902| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 893,column 1,is_stmt,isa 0
        LSR       AL,8                  ; [CPU_ALU] |893| 
||$C$L54||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 714,column 1,is_stmt,isa 0
        TBIT      *+XAR4[4],#7          ; [CPU_ALU] |714| 
        B         ||$C$L54||,NTC        ; [CPU_ALU] |714| 
        ; branchcc occurs ; [] |714| 
	.dwcfi	remember_state
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 909,column 5,is_stmt,isa 0
        MOVB      XAR0,#9               ; [CPU_ALU] |909| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 806,column 17,is_stmt,isa 0
        ADDB      XAR7,#1               ; [CPU_ALU] |806| 
        MOVW      DP,#||SFRA_GUI_memDataPtr16|| ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 909,column 5,is_stmt,isa 0
        MOV       *+XAR4[AR0],AL        ; [CPU_ALU] |909| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 806,column 17,is_stmt,isa 0
        MOVL      @||SFRA_GUI_memDataPtr16||,XAR7 ; [CPU_ALU] |806| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 807,column 17,is_stmt,isa 0
        MOV       AL,*+XAR7[0]          ; [CPU_ALU] |807| 
        MOV       @||SFRA_GUI_dataOut16||,AL ; [CPU_ALU] |807| 
||$C$L55||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 808,column 17,is_stmt,isa 0
        DEC       @||SFRA_GUI_wordsLeftToGet|| ; [CPU_ALU] |808| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 809,column 17,is_stmt,isa 0
        MOVB      @||SFRA_GUI_sendTaskPtr||,#1,UNC ; [CPU_ALU] |809| 
$C$DW$201	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$201, DW_AT_low_pc(0x00)
	.dwattr $C$DW$201, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L56||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 795,column 17,is_stmt,isa 0
        MOV       @||SFRA_GUI_sendTaskPtr||,#0 ; [CPU_ALU] |795| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 796,column 17,is_stmt,isa 0
        MOVB      @||SFRA_GUI_taskDoneFlag||,#1,UNC ; [CPU_ALU] |796| 
||$C$L57||:    
$C$DW$202	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$202, DW_AT_low_pc(0x00)
	.dwattr $C$DW$202, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$179, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$179, DW_AT_TI_end_line(0x36f)
	.dwattr $C$DW$179, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$179

	.sect	".text"
	.clink
	.global	||SFRA_GUI_echoDataByte||

$C$DW$203	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$203, DW_AT_name("SFRA_GUI_echoDataByte")
	.dwattr $C$DW$203, DW_AT_low_pc(||SFRA_GUI_echoDataByte||)
	.dwattr $C$DW$203, DW_AT_high_pc(0x00)
	.dwattr $C$DW$203, DW_AT_linkage_name("SFRA_GUI_echoDataByte")
	.dwattr $C$DW$203, DW_AT_external
	.dwattr $C$DW$203, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$203, DW_AT_decl_line(0x1fd)
	.dwattr $C$DW$203, DW_AT_decl_column(0x06)
	.dwattr $C$DW$203, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 510,column 1,is_stmt,address ||SFRA_GUI_echoDataByte||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_echoDataByte||

;***************************************************************
;* FNAME: SFRA_GUI_echoDataByte         FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_echoDataByte||:
;* AL    assigned to $O$R1
;* AR4   assigned to base
$C$DW$204	.dwtag  DW_TAG_variable
	.dwattr $C$DW$204, DW_AT_name("base")
	.dwattr $C$DW$204, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$204, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$205	.dwtag  DW_TAG_variable
	.dwattr $C$DW$205, DW_AT_name("base")
	.dwattr $C$DW$205, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$205, DW_AT_location[DW_OP_reg12]

;* AL    assigned to data
$C$DW$206	.dwtag  DW_TAG_variable
	.dwattr $C$DW$206, DW_AT_name("data")
	.dwattr $C$DW$206, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$206, DW_AT_location[DW_OP_reg0]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVW      DP,#||SFRA_GUI_sci_base_addr|| ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 809,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |809| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 588,column 5,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |588| 
        TBIT      *+XAR4[AR0],#14       ; [CPU_ALU] |588| 
        B         ||$C$L58||,TC         ; [CPU_ALU] |588| 
        ; branchcc occurs ; [] |588| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 832,column 9,is_stmt,isa 0
        MOV       AL,*+XAR4[4]          ; [CPU_ALU] |832| 
        LSR       AL,6                  ; [CPU_ALU] |832| 
        XORB      AL,#0x01              ; [CPU_ALU] |832| 
        ANDB      AL,#0x01              ; [CPU_ALU] |832| 
        B         ||$C$L59||,UNC        ; [CPU_ALU] |832| 
        ; branch occurs ; [] |832| 
||$C$L58||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 823,column 9,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |823| 
        AND       AL,*+XAR4[AR0],#0x1f00 ; [CPU_ALU] |823| 
        MOVZ      AR7,AL                ; [CPU_ALU] |823| 
        MOVB      XAR6,#0               ; [CPU_ALU] |823| 
        MOVL      XAR4,#7936            ; [CPU_ARAU] |823| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |823| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |823| 
        MOVB      XAR6,#1,EQ            ; [CPU_ALU] |823| 
        MOV       AL,AR6                ; [CPU_ALU] |823| 
||$C$L59||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 514,column 5,is_stmt,isa 0
        CMPB      AL,#0                 ; [CPU_ALU] |514| 
        B         ||$C$L61||,NEQ        ; [CPU_ALU] |514| 
        ; branchcc occurs ; [] |514| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 893,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |893| 
        MOV       AL,@||SFRA_GUI_rxChar|| ; [CPU_ALU] |893| 
||$C$L60||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 714,column 1,is_stmt,isa 0
        TBIT      *+XAR4[4],#7          ; [CPU_ALU] |714| 
        B         ||$C$L60||,NTC        ; [CPU_ALU] |714| 
        ; branchcc occurs ; [] |714| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 909,column 5,is_stmt,isa 0
        MOVB      XAR0,#9               ; [CPU_ALU] |909| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 517,column 9,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_packWord|| ; [CPU_ARAU] |517| 
        MOVW      DP,#||SFRA_GUI_rcvTaskPointer|| ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 909,column 5,is_stmt,isa 0
        MOV       *+XAR4[AR0],AL        ; [CPU_ALU] |909| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 517,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR5 ; [CPU_ALU] |517| 
||$C$L61||:    
$C$DW$207	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$207, DW_AT_low_pc(0x00)
	.dwattr $C$DW$207, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$203, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$203, DW_AT_TI_end_line(0x20b)
	.dwattr $C$DW$203, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$203

	.sect	".text"
	.clink
	.global	||SFRA_GUI_getDataByte||

$C$DW$208	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$208, DW_AT_name("SFRA_GUI_getDataByte")
	.dwattr $C$DW$208, DW_AT_low_pc(||SFRA_GUI_getDataByte||)
	.dwattr $C$DW$208, DW_AT_high_pc(0x00)
	.dwattr $C$DW$208, DW_AT_linkage_name("SFRA_GUI_getDataByte")
	.dwattr $C$DW$208, DW_AT_external
	.dwattr $C$DW$208, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$208, DW_AT_decl_line(0x1d9)
	.dwattr $C$DW$208, DW_AT_decl_column(0x06)
	.dwattr $C$DW$208, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 474,column 1,is_stmt,address ||SFRA_GUI_getDataByte||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_getDataByte||

;***************************************************************
;* FNAME: SFRA_GUI_getDataByte          FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_getDataByte||:
;* AL    assigned to $O$R1
;* AR4   assigned to base
$C$DW$209	.dwtag  DW_TAG_variable
	.dwattr $C$DW$209, DW_AT_name("base")
	.dwattr $C$DW$209, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$209, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$210	.dwtag  DW_TAG_variable
	.dwattr $C$DW$210, DW_AT_name("base")
	.dwattr $C$DW$210, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$210, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVW      DP,#||SFRA_GUI_sci_base_addr|| ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 967,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |967| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 976,column 5,is_stmt,isa 0
        MOV       AL,*+XAR4[5]          ; [CPU_ALU] |976| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 478,column 5,is_stmt,isa 0
        TBIT      AL,#6                 ; [CPU_ALU] |478| 
        B         ||$C$L62||,TC         ; [CPU_ALU] |478| 
        ; branchcc occurs ; [] |478| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 495,column 10,is_stmt,isa 0
        CMP       @||SFRA_GUI_serialCommsTimer||,#1000 ; [CPU_ALU] |495| 
        B         ||$C$L64||,LEQ        ; [CPU_ALU] |495| 
        ; branchcc occurs ; [] |495| 
	.dwcfi	remember_state
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 497,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_commsOKflg||,#0 ; [CPU_ALU] |497| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 501,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_getCmdByte|| ; [CPU_ARAU] |501| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 502,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_serialCommsTimer||,#0 ; [CPU_ALU] |502| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 501,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR4 ; [CPU_ALU] |501| 
$C$DW$211	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$211, DW_AT_low_pc(0x00)
	.dwattr $C$DW$211, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L62||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1040,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |1040| 
||$C$L63||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 685,column 1,is_stmt,isa 0
        TBIT      *+XAR4[5],#6          ; [CPU_ALU] |685| 
        B         ||$C$L63||,NTC        ; [CPU_ALU] |685| 
        ; branchcc occurs ; [] |685| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1056,column 5,is_stmt,isa 0
        MOV       AL,*+XAR4[7]          ; [CPU_ALU] |1056| 
        MOVW      DP,#||SFRA_GUI_rcvTaskPointer|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 484,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_echoDataByte|| ; [CPU_ARAU] |484| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1056,column 5,is_stmt,isa 0
        ANDB      AL,#0xff              ; [CPU_ALU] |1056| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 484,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR4 ; [CPU_FPU] |484| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1056,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_rxChar||,AL ; [CPU_ALU] |1056| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 489,column 9,is_stmt,isa 0
$C$DW$212	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$212, DW_AT_low_pc(0x00)
	.dwattr $C$DW$212, DW_AT_name("SFRA_GUI_echoDataByte")
	.dwattr $C$DW$212, DW_AT_TI_call

        LCR       #||SFRA_GUI_echoDataByte|| ; [CPU_ALU] |489| 
        ; call occurs [#||SFRA_GUI_echoDataByte||] ; [] |489| 
||$C$L64||:    
$C$DW$213	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$213, DW_AT_low_pc(0x00)
	.dwattr $C$DW$213, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$208, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$208, DW_AT_TI_end_line(0x1f8)
	.dwattr $C$DW$208, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$208

	.sect	".text"
	.clink
	.global	||SFRA_GUI_packWord||

$C$DW$214	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$214, DW_AT_name("SFRA_GUI_packWord")
	.dwattr $C$DW$214, DW_AT_low_pc(||SFRA_GUI_packWord||)
	.dwattr $C$DW$214, DW_AT_high_pc(0x00)
	.dwattr $C$DW$214, DW_AT_linkage_name("SFRA_GUI_packWord")
	.dwattr $C$DW$214, DW_AT_external
	.dwattr $C$DW$214, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$214, DW_AT_decl_line(0x210)
	.dwattr $C$DW$214, DW_AT_decl_column(0x06)
	.dwattr $C$DW$214, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 529,column 1,is_stmt,address ||SFRA_GUI_packWord||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_packWord||

;***************************************************************
;* FNAME: SFRA_GUI_packWord             FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_packWord||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVW      DP,#||SFRA_GUI_lowByteFlag|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 530,column 5,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_lowByteFlag|| ; [CPU_ALU] |530| 
        CMPB      AL,#1                 ; [CPU_ALU] |530| 
        B         ||$C$L65||,EQ         ; [CPU_ALU] |530| 
        ; branchcc occurs ; [] |530| 
	.dwcfi	remember_state
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 543,column 9,is_stmt,isa 0
        MOV       ACC,@||SFRA_GUI_rxChar|| << #8 ; [CPU_ALU] |543| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 549,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_cmdInterpreter|| ; [CPU_ARAU] |549| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 544,column 9,is_stmt,isa 0
        MOVB      @||SFRA_GUI_lowByteFlag||,#1,UNC ; [CPU_ALU] |544| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 555,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_taskDoneFlag||,#0 ; [CPU_ALU] |555| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 543,column 9,is_stmt,isa 0
        OR        @||SFRA_GUI_rxWord||,AL ; [CPU_ALU] |543| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 549,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR4 ; [CPU_ALU] |549| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 548,column 9,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_rxWord|| ; [CPU_ALU] |548| 
        MOVW      DP,#||SFRA_GUI_cmdPacket||+2 ; [CPU_ARAU] 
        MOV       @||SFRA_GUI_cmdPacket||+2,AL ; [CPU_ALU] |548| 
$C$DW$215	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$215, DW_AT_low_pc(0x00)
	.dwattr $C$DW$215, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L65||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 532,column 9,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_rxChar|| ; [CPU_ALU] |532| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 534,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_getDataByte|| ; [CPU_ARAU] |534| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 533,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_lowByteFlag||,#0 ; [CPU_ALU] |533| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 532,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_rxWord||,AL ; [CPU_ALU] |532| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 534,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR4 ; [CPU_ALU] |534| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 539,column 9,is_stmt,isa 0
$C$DW$216	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$216, DW_AT_low_pc(0x00)
	.dwattr $C$DW$216, DW_AT_name("SFRA_GUI_getDataByte")
	.dwattr $C$DW$216, DW_AT_TI_call

        LCR       #||SFRA_GUI_getDataByte|| ; [CPU_ALU] |539| 
        ; call occurs [#||SFRA_GUI_getDataByte||] ; [] |539| 
$C$DW$217	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$217, DW_AT_low_pc(0x00)
	.dwattr $C$DW$217, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$214, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$214, DW_AT_TI_end_line(0x22d)
	.dwattr $C$DW$214, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$214

	.sect	".text"
	.clink
	.global	||SFRA_GUI_echoSizeByte||

$C$DW$218	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$218, DW_AT_name("SFRA_GUI_echoSizeByte")
	.dwattr $C$DW$218, DW_AT_low_pc(||SFRA_GUI_echoSizeByte||)
	.dwattr $C$DW$218, DW_AT_high_pc(0x00)
	.dwattr $C$DW$218, DW_AT_linkage_name("SFRA_GUI_echoSizeByte")
	.dwattr $C$DW$218, DW_AT_external
	.dwattr $C$DW$218, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$218, DW_AT_decl_line(0x1c1)
	.dwattr $C$DW$218, DW_AT_decl_column(0x06)
	.dwattr $C$DW$218, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 450,column 1,is_stmt,address ||SFRA_GUI_echoSizeByte||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_echoSizeByte||

;***************************************************************
;* FNAME: SFRA_GUI_echoSizeByte         FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_echoSizeByte||:
;* AL    assigned to $O$R1
;* AR4   assigned to base
$C$DW$219	.dwtag  DW_TAG_variable
	.dwattr $C$DW$219, DW_AT_name("base")
	.dwattr $C$DW$219, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$219, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$220	.dwtag  DW_TAG_variable
	.dwattr $C$DW$220, DW_AT_name("base")
	.dwattr $C$DW$220, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$220, DW_AT_location[DW_OP_reg12]

;* AL    assigned to data
$C$DW$221	.dwtag  DW_TAG_variable
	.dwattr $C$DW$221, DW_AT_name("data")
	.dwattr $C$DW$221, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$221, DW_AT_location[DW_OP_reg0]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVW      DP,#||SFRA_GUI_sci_base_addr|| ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 809,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |809| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 588,column 5,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |588| 
        TBIT      *+XAR4[AR0],#14       ; [CPU_ALU] |588| 
        B         ||$C$L66||,TC         ; [CPU_ALU] |588| 
        ; branchcc occurs ; [] |588| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 832,column 9,is_stmt,isa 0
        MOV       AL,*+XAR4[4]          ; [CPU_ALU] |832| 
        LSR       AL,6                  ; [CPU_ALU] |832| 
        XORB      AL,#0x01              ; [CPU_ALU] |832| 
        ANDB      AL,#0x01              ; [CPU_ALU] |832| 
        B         ||$C$L67||,UNC        ; [CPU_ALU] |832| 
        ; branch occurs ; [] |832| 
||$C$L66||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 823,column 9,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |823| 
        AND       AL,*+XAR4[AR0],#0x1f00 ; [CPU_ALU] |823| 
        MOVZ      AR7,AL                ; [CPU_ALU] |823| 
        MOVB      XAR6,#0               ; [CPU_ALU] |823| 
        MOVL      XAR4,#7936            ; [CPU_ARAU] |823| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |823| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |823| 
        MOVB      XAR6,#1,EQ            ; [CPU_ALU] |823| 
        MOV       AL,AR6                ; [CPU_ALU] |823| 
||$C$L67||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 454,column 5,is_stmt,isa 0
        CMPB      AL,#0                 ; [CPU_ALU] |454| 
        B         ||$C$L69||,NEQ        ; [CPU_ALU] |454| 
        ; branchcc occurs ; [] |454| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 893,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |893| 
        MOV       AL,@||SFRA_GUI_rxChar|| ; [CPU_ALU] |893| 
||$C$L68||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 714,column 1,is_stmt,isa 0
        TBIT      *+XAR4[4],#7          ; [CPU_ALU] |714| 
        B         ||$C$L68||,NTC        ; [CPU_ALU] |714| 
        ; branchcc occurs ; [] |714| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 909,column 5,is_stmt,isa 0
        MOVB      XAR0,#9               ; [CPU_ALU] |909| 
        MOVW      DP,#||SFRA_GUI_rxChar|| ; [CPU_ARAU] 
        MOV       *+XAR4[AR0],AL        ; [CPU_ALU] |909| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 458,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_getDataByte|| ; [CPU_ARAU] |458| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 466,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_serialCommsTimer||,#0 ; [CPU_ALU] |466| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 457,column 9,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_rxChar|| ; [CPU_ALU] |457| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 458,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR4 ; [CPU_ALU] |458| 
        MOVW      DP,#||SFRA_GUI_cmdPacket||+1 ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 457,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_cmdPacket||+1,AL ; [CPU_ALU] |457| 
||$C$L69||:    
$C$DW$222	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$222, DW_AT_low_pc(0x00)
	.dwattr $C$DW$222, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$218, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$218, DW_AT_TI_end_line(0x1d4)
	.dwattr $C$DW$218, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$218

	.sect	".text"
	.clink
	.global	||SFRA_GUI_getSizeByte||

$C$DW$223	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$223, DW_AT_name("SFRA_GUI_getSizeByte")
	.dwattr $C$DW$223, DW_AT_low_pc(||SFRA_GUI_getSizeByte||)
	.dwattr $C$DW$223, DW_AT_high_pc(0x00)
	.dwattr $C$DW$223, DW_AT_linkage_name("SFRA_GUI_getSizeByte")
	.dwattr $C$DW$223, DW_AT_external
	.dwattr $C$DW$223, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$223, DW_AT_decl_line(0x19c)
	.dwattr $C$DW$223, DW_AT_decl_column(0x06)
	.dwattr $C$DW$223, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 413,column 1,is_stmt,address ||SFRA_GUI_getSizeByte||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_getSizeByte||

;***************************************************************
;* FNAME: SFRA_GUI_getSizeByte          FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_getSizeByte||:
;* AL    assigned to $O$R1
;* AR4   assigned to base
$C$DW$224	.dwtag  DW_TAG_variable
	.dwattr $C$DW$224, DW_AT_name("base")
	.dwattr $C$DW$224, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$224, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$225	.dwtag  DW_TAG_variable
	.dwattr $C$DW$225, DW_AT_name("base")
	.dwattr $C$DW$225, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$225, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVW      DP,#||SFRA_GUI_sci_base_addr|| ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 967,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |967| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 976,column 5,is_stmt,isa 0
        MOV       AL,*+XAR4[5]          ; [CPU_ALU] |976| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 417,column 5,is_stmt,isa 0
        TBIT      AL,#6                 ; [CPU_ALU] |417| 
        B         ||$C$L70||,TC         ; [CPU_ALU] |417| 
        ; branchcc occurs ; [] |417| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 435,column 10,is_stmt,isa 0
        CMP       @||SFRA_GUI_serialCommsTimer||,#1000 ; [CPU_ALU] |435| 
        B         ||$C$L72||,LEQ        ; [CPU_ALU] |435| 
        ; branchcc occurs ; [] |435| 
	.dwcfi	remember_state
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 437,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_commsOKflg||,#0 ; [CPU_ALU] |437| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 441,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_getCmdByte|| ; [CPU_ARAU] |441| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 442,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_serialCommsTimer||,#0 ; [CPU_ALU] |442| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 441,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR4 ; [CPU_ALU] |441| 
$C$DW$226	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$226, DW_AT_low_pc(0x00)
	.dwattr $C$DW$226, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L70||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1040,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |1040| 
||$C$L71||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 685,column 1,is_stmt,isa 0
        TBIT      *+XAR4[5],#6          ; [CPU_ALU] |685| 
        B         ||$C$L71||,NTC        ; [CPU_ALU] |685| 
        ; branchcc occurs ; [] |685| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1056,column 5,is_stmt,isa 0
        MOV       AL,*+XAR4[7]          ; [CPU_ALU] |1056| 
        MOVW      DP,#||SFRA_GUI_rcvTaskPointer|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 424,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_echoSizeByte|| ; [CPU_ARAU] |424| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1056,column 5,is_stmt,isa 0
        ANDB      AL,#0xff              ; [CPU_ALU] |1056| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 424,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR4 ; [CPU_FPU] |424| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1056,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_rxChar||,AL ; [CPU_ALU] |1056| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 429,column 9,is_stmt,isa 0
$C$DW$227	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$227, DW_AT_low_pc(0x00)
	.dwattr $C$DW$227, DW_AT_name("SFRA_GUI_echoSizeByte")
	.dwattr $C$DW$227, DW_AT_TI_call

        LCR       #||SFRA_GUI_echoSizeByte|| ; [CPU_ALU] |429| 
        ; call occurs [#||SFRA_GUI_echoSizeByte||] ; [] |429| 
||$C$L72||:    
$C$DW$228	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$228, DW_AT_low_pc(0x00)
	.dwattr $C$DW$228, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$223, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$223, DW_AT_TI_end_line(0x1bc)
	.dwattr $C$DW$223, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$223

	.sect	".text"
	.clink
	.global	||SFRA_GUI_echoCmdByte||

$C$DW$229	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$229, DW_AT_name("SFRA_GUI_echoCmdByte")
	.dwattr $C$DW$229, DW_AT_low_pc(||SFRA_GUI_echoCmdByte||)
	.dwattr $C$DW$229, DW_AT_high_pc(0x00)
	.dwattr $C$DW$229, DW_AT_linkage_name("SFRA_GUI_echoCmdByte")
	.dwattr $C$DW$229, DW_AT_external
	.dwattr $C$DW$229, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$229, DW_AT_decl_line(0x183)
	.dwattr $C$DW$229, DW_AT_decl_column(0x06)
	.dwattr $C$DW$229, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 388,column 1,is_stmt,address ||SFRA_GUI_echoCmdByte||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_echoCmdByte||

;***************************************************************
;* FNAME: SFRA_GUI_echoCmdByte          FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_echoCmdByte||:
;* AL    assigned to $O$R1
;* AR4   assigned to base
$C$DW$230	.dwtag  DW_TAG_variable
	.dwattr $C$DW$230, DW_AT_name("base")
	.dwattr $C$DW$230, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$230, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$231	.dwtag  DW_TAG_variable
	.dwattr $C$DW$231, DW_AT_name("base")
	.dwattr $C$DW$231, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$231, DW_AT_location[DW_OP_reg12]

;* AL    assigned to data
$C$DW$232	.dwtag  DW_TAG_variable
	.dwattr $C$DW$232, DW_AT_name("data")
	.dwattr $C$DW$232, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$232, DW_AT_location[DW_OP_reg0]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVW      DP,#||SFRA_GUI_sci_base_addr|| ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 809,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |809| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 588,column 5,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |588| 
        TBIT      *+XAR4[AR0],#14       ; [CPU_ALU] |588| 
        B         ||$C$L73||,TC         ; [CPU_ALU] |588| 
        ; branchcc occurs ; [] |588| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 832,column 9,is_stmt,isa 0
        MOV       AL,*+XAR4[4]          ; [CPU_ALU] |832| 
        LSR       AL,6                  ; [CPU_ALU] |832| 
        XORB      AL,#0x01              ; [CPU_ALU] |832| 
        ANDB      AL,#0x01              ; [CPU_ALU] |832| 
        B         ||$C$L74||,UNC        ; [CPU_ALU] |832| 
        ; branch occurs ; [] |832| 
||$C$L73||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 823,column 9,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |823| 
        AND       AL,*+XAR4[AR0],#0x1f00 ; [CPU_ALU] |823| 
        MOVZ      AR7,AL                ; [CPU_ALU] |823| 
        MOVB      XAR6,#0               ; [CPU_ALU] |823| 
        MOVL      XAR4,#7936            ; [CPU_ARAU] |823| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |823| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |823| 
        MOVB      XAR6,#1,EQ            ; [CPU_ALU] |823| 
        MOV       AL,AR6                ; [CPU_ALU] |823| 
||$C$L74||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 392,column 5,is_stmt,isa 0
        CMPB      AL,#0                 ; [CPU_ALU] |392| 
        B         ||$C$L76||,NEQ        ; [CPU_ALU] |392| 
        ; branchcc occurs ; [] |392| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 893,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |893| 
        MOV       AL,@||SFRA_GUI_rxChar|| ; [CPU_ALU] |893| 
||$C$L75||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 714,column 1,is_stmt,isa 0
        TBIT      *+XAR4[4],#7          ; [CPU_ALU] |714| 
        B         ||$C$L75||,NTC        ; [CPU_ALU] |714| 
        ; branchcc occurs ; [] |714| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 909,column 5,is_stmt,isa 0
        MOVB      XAR0,#9               ; [CPU_ALU] |909| 
        MOVW      DP,#||SFRA_GUI_rxChar|| ; [CPU_ARAU] 
        MOV       *+XAR4[AR0],AL        ; [CPU_ALU] |909| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 396,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_getSizeByte|| ; [CPU_ARAU] |396| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 404,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_serialCommsTimer||,#0 ; [CPU_ALU] |404| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 395,column 9,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_rxChar|| ; [CPU_ALU] |395| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 396,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR4 ; [CPU_ALU] |396| 
        MOVW      DP,#||SFRA_GUI_cmdPacket|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 395,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_cmdPacket||,AL ; [CPU_ALU] |395| 
||$C$L76||:    
$C$DW$233	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$233, DW_AT_low_pc(0x00)
	.dwattr $C$DW$233, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$229, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$229, DW_AT_TI_end_line(0x197)
	.dwattr $C$DW$229, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$229

	.sect	".text"
	.clink
	.global	||SFRA_GUI_getData||

$C$DW$234	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$234, DW_AT_name("SFRA_GUI_getData")
	.dwattr $C$DW$234, DW_AT_low_pc(||SFRA_GUI_getData||)
	.dwattr $C$DW$234, DW_AT_high_pc(0x00)
	.dwattr $C$DW$234, DW_AT_linkage_name("SFRA_GUI_getData")
	.dwattr $C$DW$234, DW_AT_external
	.dwattr $C$DW$234, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$234, DW_AT_decl_line(0x2b4)
	.dwattr $C$DW$234, DW_AT_decl_column(0x06)
	.dwattr $C$DW$234, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 693,column 1,is_stmt,address ||SFRA_GUI_getData||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_getData||

;***************************************************************
;* FNAME: SFRA_GUI_getData              FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_getData||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVW      DP,#||SFRA_GUI_memGetPtr|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 694,column 5,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_memGetPtr|| ; [CPU_ALU] |694| 
        B         ||$C$L77||,EQ         ; [CPU_ALU] |694| 
        ; branchcc occurs ; [] |694| 
        CMPB      AL,#1                 ; [CPU_ALU] |694| 
        B         ||$C$L78||,NEQ        ; [CPU_ALU] |694| 
        ; branchcc occurs ; [] |694| 
        MOVW      DP,#||SFRA_GUI_cmdPacket||+2 ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 706,column 13,is_stmt,isa 0
        MOVZ      AR6,@||SFRA_GUI_cmdPacket||+2 ; [CPU_ALU] |706| 
        MOVU      ACC,@||SFRA_GUI_cmdPacket||+2 ; [CPU_ALU] |706| 
        MOVW      DP,#||SFRA_GUI_temp|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 707,column 13,is_stmt,isa 0
        LSL       ACC,16                ; [CPU_ALU] |707| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 706,column 13,is_stmt,isa 0
        MOVL      @||SFRA_GUI_temp||,XAR6 ; [CPU_FPU] |706| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 707,column 13,is_stmt,isa 0
        ADDL      @||SFRA_GUI_memGetAddress||,ACC ; [CPU_ALU] |707| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 710,column 13,is_stmt,isa 0
        MOVL      XAR7,@||SFRA_GUI_memGetAddress|| ; [CPU_ALU] |710| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 709,column 13,is_stmt,isa 0
        MOVL      ACC,@||SFRA_GUI_memGetAddress|| ; [CPU_ALU] |709| 
        MOVL      @||SFRA_GUI_memDataPtr16||,ACC ; [CPU_ALU] |709| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 710,column 13,is_stmt,isa 0
        MOV       AL,*+XAR7[0]          ; [CPU_ALU] |710| 
        MOV       @||SFRA_GUI_dataOut16||,AL ; [CPU_ALU] |710| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 711,column 13,is_stmt,isa 0
$C$DW$235	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$235, DW_AT_low_pc(0x00)
	.dwattr $C$DW$235, DW_AT_name("SFRA_GUI_sendData")
	.dwattr $C$DW$235, DW_AT_TI_call

        LCR       #||SFRA_GUI_sendData|| ; [CPU_ALU] |711| 
        ; call occurs [#||SFRA_GUI_sendData||] ; [] |711| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 713,column 13,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_taskDoneFlag|| ; [CPU_ALU] |713| 
        CMPB      AL,#1                 ; [CPU_ALU] |713| 
        B         ||$C$L78||,NEQ        ; [CPU_ALU] |713| 
        ; branchcc occurs ; [] |713| 
	.dwcfi	remember_state
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 715,column 17,is_stmt,isa 0
        MOV       @||SFRA_GUI_memGetPtr||,#0 ; [CPU_ALU] |715| 
$C$DW$236	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$236, DW_AT_low_pc(0x00)
	.dwattr $C$DW$236, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L77||:    
        MOVW      DP,#||SFRA_GUI_cmdPacket||+2 ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 697,column 13,is_stmt,isa 0
        MOVU      ACC,@||SFRA_GUI_cmdPacket||+2 ; [CPU_ALU] |697| 
        MOVW      DP,#||SFRA_GUI_memGetPtr|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 698,column 13,is_stmt,isa 0
        MOVB      @||SFRA_GUI_memGetPtr||,#1,UNC ; [CPU_ALU] |698| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 700,column 13,is_stmt,isa 0
        MOVB      @||SFRA_GUI_wordsLeftToGet||,#1,UNC ; [CPU_ALU] |700| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 701,column 13,is_stmt,isa 0
        MOVB      @||SFRA_GUI_sendTaskPtr||,#1,UNC ; [CPU_ALU] |701| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 702,column 13,is_stmt,isa 0
        MOVB      @||SFRA_GUI_taskDoneFlag||,#1,UNC ; [CPU_ALU] |702| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 697,column 13,is_stmt,isa 0
        MOVL      @||SFRA_GUI_memGetAddress||,ACC ; [CPU_ALU] |697| 
||$C$L78||:    
$C$DW$237	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$237, DW_AT_low_pc(0x00)
	.dwattr $C$DW$237, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$234, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$234, DW_AT_TI_end_line(0x2d4)
	.dwattr $C$DW$234, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$234

	.sect	".text"
	.clink
	.global	||SFRA_GUI_lifePulseTsk||

$C$DW$238	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$238, DW_AT_name("SFRA_GUI_lifePulseTsk")
	.dwattr $C$DW$238, DW_AT_low_pc(||SFRA_GUI_lifePulseTsk||)
	.dwattr $C$DW$238, DW_AT_high_pc(0x00)
	.dwattr $C$DW$238, DW_AT_linkage_name("SFRA_GUI_lifePulseTsk")
	.dwattr $C$DW$238, DW_AT_external
	.dwattr $C$DW$238, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$238, DW_AT_decl_line(0x25a)
	.dwattr $C$DW$238, DW_AT_decl_column(0x06)
	.dwattr $C$DW$238, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 603,column 1,is_stmt,address ||SFRA_GUI_lifePulseTsk||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_lifePulseTsk||

;***************************************************************
;* FNAME: SFRA_GUI_lifePulseTsk         FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_lifePulseTsk||:
;* AR4   assigned to $O$C1
;* AR4   assigned to $O$C2
;* AR4   assigned to $O$C3
;* AR7   assigned to pin
$C$DW$239	.dwtag  DW_TAG_variable
	.dwattr $C$DW$239, DW_AT_name("pin")
	.dwattr $C$DW$239, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$239, DW_AT_location[DW_OP_reg18]

;* AR7   assigned to pin
$C$DW$240	.dwtag  DW_TAG_variable
	.dwattr $C$DW$240, DW_AT_name("pin")
	.dwattr $C$DW$240, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$240, DW_AT_location[DW_OP_reg18]

;* AR7   assigned to pin
$C$DW$241	.dwtag  DW_TAG_variable
	.dwattr $C$DW$241, DW_AT_name("pin")
	.dwattr $C$DW$241, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$241, DW_AT_location[DW_OP_reg18]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVW      DP,#||SFRA_GUI_led_flag|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 604,column 5,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_led_flag|| ; [CPU_ALU] |604| 
        CMPB      AL,#1                 ; [CPU_ALU] |604| 
        B         ||$C$L81||,NEQ        ; [CPU_ALU] |604| 
        ; branchcc occurs ; [] |604| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 609,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_cmdPacket|| ; [CPU_ARAU] |609| 
        MOV       AL,*+XAR4[2]          ; [CPU_ALU] |609| 
        B         ||$C$L79||,NEQ        ; [CPU_ALU] |609| 
        ; branchcc occurs ; [] |609| 
        MOV       AL,*+XAR4[1]          ; [CPU_ALU] |609| 
        B         ||$C$L79||,NEQ        ; [CPU_ALU] |609| 
        ; branchcc occurs ; [] |609| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 493,column 1,is_stmt,isa 0
        MOVZ      AR7,@||SFRA_GUI_led_gpio|| ; [CPU_ALU] |493| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 504,column 5,is_stmt,isa 0
        MOV       AL,AR7                ; [CPU_ALU] |504| 
        CLRC      SXM                   ; [CPU_ALU] 
        ANDB      AL,#0x1f              ; [CPU_ALU] |504| 
        MOV       T,AL                  ; [CPU_ALU] |504| 
        MOVB      ACC,#1                ; [CPU_ALU] |504| 
        LSLL      ACC,T                 ; [CPU_ALU] |504| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |504| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |504| 
        SFR       ACC,5                 ; [CPU_ALU] |504| 
        LSL       ACC,2                 ; [CPU_ALU] |504| 
        LSL       ACC,1                 ; [CPU_ALU] |504| 
        ADD       ACC,#127 << 8         ; [CPU_ALU] |504| 
        MOVL      XAR4,ACC              ; [CPU_ALU] |504| 
        MOVL      *+XAR4[6],XAR6        ; [CPU_ALU] |504| 
||$C$L79||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 616,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_cmdPacket|| ; [CPU_ARAU] |616| 
        MOV       AL,*+XAR4[2]          ; [CPU_ALU] |616| 
        CMPB      AL,#1                 ; [CPU_ALU] |616| 
        B         ||$C$L80||,NEQ        ; [CPU_ALU] |616| 
        ; branchcc occurs ; [] |616| 
        MOV       AL,*+XAR4[1]          ; [CPU_ALU] |616| 
        B         ||$C$L80||,NEQ        ; [CPU_ALU] |616| 
        ; branchcc occurs ; [] |616| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 493,column 1,is_stmt,isa 0
        MOVZ      AR7,@||SFRA_GUI_led_gpio|| ; [CPU_ALU] |493| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 504,column 5,is_stmt,isa 0
        MOV       AL,AR7                ; [CPU_ALU] |504| 
        CLRC      SXM                   ; [CPU_ALU] 
        ANDB      AL,#0x1f              ; [CPU_ALU] |504| 
        MOV       T,AL                  ; [CPU_ALU] |504| 
        MOVB      ACC,#1                ; [CPU_ALU] |504| 
        LSLL      ACC,T                 ; [CPU_ALU] |504| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |504| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |504| 
        SFR       ACC,5                 ; [CPU_ALU] |504| 
        LSL       ACC,2                 ; [CPU_ALU] |504| 
        LSL       ACC,1                 ; [CPU_ALU] |504| 
        ADD       ACC,#127 << 8         ; [CPU_ALU] |504| 
        MOVL      XAR4,ACC              ; [CPU_ALU] |504| 
        MOVL      *+XAR4[6],XAR6        ; [CPU_ALU] |504| 
||$C$L80||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 623,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_cmdPacket|| ; [CPU_ARAU] |623| 
        MOV       AL,*+XAR4[2]          ; [CPU_ALU] |623| 
        CMPB      AL,#2                 ; [CPU_ALU] |623| 
        B         ||$C$L81||,NEQ        ; [CPU_ALU] |623| 
        ; branchcc occurs ; [] |623| 
        MOV       AL,*+XAR4[1]          ; [CPU_ALU] |623| 
        B         ||$C$L81||,NEQ        ; [CPU_ALU] |623| 
        ; branchcc occurs ; [] |623| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 493,column 1,is_stmt,isa 0
        MOVZ      AR7,@||SFRA_GUI_led_gpio|| ; [CPU_ALU] |493| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h",line 504,column 5,is_stmt,isa 0
        MOV       AL,AR7                ; [CPU_ALU] |504| 
        CLRC      SXM                   ; [CPU_ALU] 
        ANDB      AL,#0x1f              ; [CPU_ALU] |504| 
        MOV       T,AL                  ; [CPU_ALU] |504| 
        MOVB      ACC,#1                ; [CPU_ALU] |504| 
        LSLL      ACC,T                 ; [CPU_ALU] |504| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |504| 
        MOVL      ACC,XAR7              ; [CPU_ALU] |504| 
        SFR       ACC,5                 ; [CPU_ALU] |504| 
        LSL       ACC,2                 ; [CPU_ALU] |504| 
        LSL       ACC,1                 ; [CPU_ALU] |504| 
        ADD       ACC,#127 << 8         ; [CPU_ALU] |504| 
        MOVL      XAR4,ACC              ; [CPU_ALU] |504| 
        MOVL      *+XAR4[6],XAR6        ; [CPU_ALU] |504| 
||$C$L81||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 629,column 5,is_stmt,isa 0
        MOVB      @||SFRA_GUI_commsOKflg||,#1,UNC ; [CPU_ALU] |629| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 631,column 5,is_stmt,isa 0
        MOVB      @||SFRA_GUI_taskDoneFlag||,#1,UNC ; [CPU_ALU] |631| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 630,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_serialCommsTimer||,#0 ; [CPU_ALU] |630| 
$C$DW$242	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$242, DW_AT_low_pc(0x00)
	.dwattr $C$DW$242, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$238, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$238, DW_AT_TI_end_line(0x278)
	.dwattr $C$DW$238, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$238

	.sect	".text"
	.clink
	.global	||SFRA_GUI_getCmdByte||

$C$DW$243	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$243, DW_AT_name("SFRA_GUI_getCmdByte")
	.dwattr $C$DW$243, DW_AT_low_pc(||SFRA_GUI_getCmdByte||)
	.dwattr $C$DW$243, DW_AT_high_pc(0x00)
	.dwattr $C$DW$243, DW_AT_linkage_name("SFRA_GUI_getCmdByte")
	.dwattr $C$DW$243, DW_AT_external
	.dwattr $C$DW$243, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$243, DW_AT_decl_line(0x146)
	.dwattr $C$DW$243, DW_AT_decl_column(0x06)
	.dwattr $C$DW$243, DW_AT_TI_max_frame_size(-4)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 327,column 1,is_stmt,address ||SFRA_GUI_getCmdByte||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_getCmdByte||

;***************************************************************
;* FNAME: SFRA_GUI_getCmdByte           FR SIZE:   2           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            2 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_getCmdByte||:
;* AL    assigned to $O$R1
;* AL    assigned to $O$R2
;* AR4   assigned to base
$C$DW$244	.dwtag  DW_TAG_variable
	.dwattr $C$DW$244, DW_AT_name("base")
	.dwattr $C$DW$244, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$244, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$245	.dwtag  DW_TAG_variable
	.dwattr $C$DW$245, DW_AT_name("base")
	.dwattr $C$DW$245, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$245, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$246	.dwtag  DW_TAG_variable
	.dwattr $C$DW$246, DW_AT_name("base")
	.dwattr $C$DW$246, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$246, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$247	.dwtag  DW_TAG_variable
	.dwattr $C$DW$247, DW_AT_name("base")
	.dwattr $C$DW$247, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$247, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$248	.dwtag  DW_TAG_variable
	.dwattr $C$DW$248, DW_AT_name("base")
	.dwattr $C$DW$248, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$248, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -4
        MOVW      DP,#||SFRA_GUI_sci_base_addr|| ; [CPU_ARAU] 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 967,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |967| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 976,column 5,is_stmt,isa 0
        MOV       AL,*+XAR4[5]          ; [CPU_ALU] |976| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 331,column 5,is_stmt,isa 0
        TBIT      AL,#6                 ; [CPU_ALU] |331| 
        B         ||$C$L83||,TC         ; [CPU_ALU] |331| 
        ; branchcc occurs ; [] |331| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 967,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |967| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 976,column 5,is_stmt,isa 0
        MOV       AL,*+XAR4[5]          ; [CPU_ALU] |976| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 349,column 10,is_stmt,isa 0
        TBIT      AL,#5                 ; [CPU_ALU] |349| 
        B         ||$C$L82||,TC         ; [CPU_ALU] |349| 
        ; branchcc occurs ; [] |349| 
        CMP       @||SFRA_GUI_serialCommsTimer||,#2500 ; [CPU_ALU] |349| 
        B         ||$C$L85||,LEQ        ; [CPU_ALU] |349| 
        ; branchcc occurs ; [] |349| 
||$C$L82||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 468,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |468| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 477,column 5,is_stmt,isa 0
        OR        *+XAR4[1],#0x0023     ; [CPU_ALU] |477| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1107,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |1107| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 361,column 9,is_stmt,isa 0
        MOVB      ACC,#6                ; [CPU_ALU] |361| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1116,column 5,is_stmt,isa 0
        AND       *+XAR4[1],#0xffdf     ; [CPU_ALU] |1116| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1117,column 5,is_stmt,isa 0
        OR        *+XAR4[1],#0x0020     ; [CPU_ALU] |1117| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 361,column 9,is_stmt,isa 0
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |361| 
        MOVL      ACC,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |361| 
$C$DW$249	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$249, DW_AT_low_pc(0x00)
	.dwattr $C$DW$249, DW_AT_name("SCI_clearInterruptStatus")
	.dwattr $C$DW$249, DW_AT_TI_call

        LCR       #||SCI_clearInterruptStatus|| ; [CPU_ALU] |361| 
        ; call occurs [#||SCI_clearInterruptStatus||] ; [] |361| 
 RPT#8 || NOP
        MOVW      DP,#||SFRA_GUI_serialCommsTimer|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 376,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_getCmdByte|| ; [CPU_ARAU] |376| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 370,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_serialCommsTimer||,#0 ; [CPU_ALU] |370| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 369,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_sendTaskPtr||,#0 ; [CPU_ALU] |369| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 376,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR4 ; [CPU_ALU] |376| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 375,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_commsOKflg||,#0 ; [CPU_ALU] |375| 
        B         ||$C$L85||,UNC        ; [CPU_ALU] 
        ; branch occurs ; [] 
||$C$L83||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1040,column 1,is_stmt,isa 0
        MOVL      XAR4,@||SFRA_GUI_sci_base_addr|| ; [CPU_ALU] |1040| 
||$C$L84||:    
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 685,column 1,is_stmt,isa 0
        TBIT      *+XAR4[5],#6          ; [CPU_ALU] |685| 
        B         ||$C$L84||,NTC        ; [CPU_ALU] |685| 
        ; branchcc occurs ; [] |685| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1056,column 5,is_stmt,isa 0
        MOV       AL,*+XAR4[7]          ; [CPU_ALU] |1056| 
        MOVW      DP,#||SFRA_GUI_serialCommsTimer|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 337,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_echoCmdByte|| ; [CPU_ARAU] |337| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1056,column 5,is_stmt,isa 0
        ANDB      AL,#0xff              ; [CPU_ALU] |1056| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 338,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_serialCommsTimer||,#0 ; [CPU_ALU] |338| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 337,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR4 ; [CPU_ALU] |337| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1056,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_rxChar||,AL ; [CPU_ALU] |1056| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 343,column 9,is_stmt,isa 0
$C$DW$250	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$250, DW_AT_low_pc(0x00)
	.dwattr $C$DW$250, DW_AT_name("SFRA_GUI_echoCmdByte")
	.dwattr $C$DW$250, DW_AT_TI_call

        LCR       #||SFRA_GUI_echoCmdByte|| ; [CPU_ALU] |343| 
        ; call occurs [#||SFRA_GUI_echoCmdByte||] ; [] |343| 
||$C$L85||:    
        SUBB      SP,#2                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        SPM       #0                    ; [CPU_ALU] 
$C$DW$251	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$251, DW_AT_low_pc(0x00)
	.dwattr $C$DW$251, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$243, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$243, DW_AT_TI_end_line(0x17e)
	.dwattr $C$DW$243, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$243

	.sect	".text"
	.clink
	.global	||SFRA_GUI_cmdInterpreter||

$C$DW$252	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$252, DW_AT_name("SFRA_GUI_cmdInterpreter")
	.dwattr $C$DW$252, DW_AT_low_pc(||SFRA_GUI_cmdInterpreter||)
	.dwattr $C$DW$252, DW_AT_high_pc(0x00)
	.dwattr $C$DW$252, DW_AT_linkage_name("SFRA_GUI_cmdInterpreter")
	.dwattr $C$DW$252, DW_AT_external
	.dwattr $C$DW$252, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$252, DW_AT_decl_line(0x232)
	.dwattr $C$DW$252, DW_AT_decl_column(0x06)
	.dwattr $C$DW$252, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 563,column 1,is_stmt,address ||SFRA_GUI_cmdInterpreter||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_cmdInterpreter||

;***************************************************************
;* FNAME: SFRA_GUI_cmdInterpreter       FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_cmdInterpreter||:
	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVW      DP,#||SFRA_GUI_taskDoneFlag|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 564,column 5,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_taskDoneFlag|| ; [CPU_ALU] |564| 
        B         ||$C$L86||,NEQ        ; [CPU_ALU] |564| 
        ; branchcc occurs ; [] |564| 
        CLRC      SXM                   ; [CPU_ALU] 
        MOVW      DP,#||SFRA_GUI_cmdPacket|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 569,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_cmdDispatcher|| ; [CPU_ARAU] |569| 
        MOV       ACC,@||SFRA_GUI_cmdPacket|| << 1 ; [CPU_ALU] |569| 
        ADDL      XAR4,ACC              ; [CPU_ALU] |569| 
        MOVL      XAR7,*+XAR4[0]        ; [CPU_ALU] |569| 
$C$DW$253	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$253, DW_AT_low_pc(0x00)
	.dwattr $C$DW$253, DW_AT_TI_call
	.dwattr $C$DW$253, DW_AT_TI_indirect

        LCR       *XAR7                 ; [CPU_ALU] |569| 
        ; call occurs [XAR7] ; [] |569| 
||$C$L86||:    
        MOVW      DP,#||SFRA_GUI_serialCommsTimer|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 576,column 5,is_stmt,isa 0
        CMP       @||SFRA_GUI_serialCommsTimer||,#2500 ; [CPU_ALU] |576| 
        B         ||$C$L87||,LEQ        ; [CPU_ALU] |576| 
        ; branchcc occurs ; [] |576| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 578,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_commsOKflg||,#0 ; [CPU_ALU] |578| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 582,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_getCmdByte|| ; [CPU_ARAU] |582| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 583,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_serialCommsTimer||,#0 ; [CPU_ALU] |583| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 582,column 9,is_stmt,isa 0
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR4 ; [CPU_ALU] |582| 
||$C$L87||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 585,column 5,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_taskDoneFlag|| ; [CPU_ALU] |585| 
        CMPB      AL,#1                 ; [CPU_ALU] |585| 
        B         ||$C$L88||,NEQ        ; [CPU_ALU] |585| 
        ; branchcc occurs ; [] |585| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 587,column 9,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_getCmdByte|| ; [CPU_ARAU] |587| 
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR4 ; [CPU_ALU] |587| 
||$C$L88||:    
$C$DW$254	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$254, DW_AT_low_pc(0x00)
	.dwattr $C$DW$254, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$252, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$252, DW_AT_TI_end_line(0x251)
	.dwattr $C$DW$252, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$252

	.sect	".text"
	.clink
	.global	||SFRA_GUI_runSerialHostComms||

$C$DW$255	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$255, DW_AT_name("SFRA_GUI_runSerialHostComms")
	.dwattr $C$DW$255, DW_AT_low_pc(||SFRA_GUI_runSerialHostComms||)
	.dwattr $C$DW$255, DW_AT_high_pc(0x00)
	.dwattr $C$DW$255, DW_AT_linkage_name("SFRA_GUI_runSerialHostComms")
	.dwattr $C$DW$255, DW_AT_external
	.dwattr $C$DW$255, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$255, DW_AT_decl_line(0x133)
	.dwattr $C$DW$255, DW_AT_decl_column(0x06)
	.dwattr $C$DW$255, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 308,column 1,is_stmt,address ||SFRA_GUI_runSerialHostComms||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_runSerialHostComms||
$C$DW$256	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$256, DW_AT_name("sfra")
	.dwattr $C$DW$256, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$256, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: SFRA_GUI_runSerialHostComms   FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||SFRA_GUI_runSerialHostComms||:
;* AR4   assigned to sfra
$C$DW$257	.dwtag  DW_TAG_variable
	.dwattr $C$DW$257, DW_AT_name("sfra")
	.dwattr $C$DW$257, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$257, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVW      DP,#||SFRA_GUI_sweep_start|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 309,column 5,is_stmt,isa 0
        MOV       AL,@||SFRA_GUI_sweep_start|| ; [CPU_ALU] |309| 
        CMPB      AL,#1                 ; [CPU_ALU] |309| 
        B         ||$C$L89||,NEQ        ; [CPU_ALU] |309| 
        ; branchcc occurs ; [] |309| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 312,column 9,is_stmt,isa 0
        MOVB      XAR0,#22              ; [CPU_ALU] |312| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 311,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_sweep_start||,#0 ; [CPU_ALU] |311| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 312,column 9,is_stmt,isa 0
        MOVB      *+XAR4[AR0],#1,UNC    ; [CPU_ALU] |312| 
||$C$L89||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 317,column 5,is_stmt,isa 0
        MOVL      XAR7,@||SFRA_GUI_rcvTaskPointer|| ; [CPU_ALU] |317| 
$C$DW$258	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$258, DW_AT_low_pc(0x00)
	.dwattr $C$DW$258, DW_AT_TI_call
	.dwattr $C$DW$258, DW_AT_TI_indirect

        LCR       *XAR7                 ; [CPU_ALU] |317| 
        ; call occurs [XAR7] ; [] |317| 
        MOVW      DP,#||SFRA_GUI_serialCommsTimer|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 319,column 5,is_stmt,isa 0
        INC       @||SFRA_GUI_serialCommsTimer|| ; [CPU_ALU] |319| 
$C$DW$259	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$259, DW_AT_low_pc(0x00)
	.dwattr $C$DW$259, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$255, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$255, DW_AT_TI_end_line(0x140)
	.dwattr $C$DW$255, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$255

	.sect	".text"
	.clink
	.global	||SFRA_GUI_config||

$C$DW$260	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$260, DW_AT_name("SFRA_GUI_config")
	.dwattr $C$DW$260, DW_AT_low_pc(||SFRA_GUI_config||)
	.dwattr $C$DW$260, DW_AT_high_pc(0x00)
	.dwattr $C$DW$260, DW_AT_linkage_name("SFRA_GUI_config")
	.dwattr $C$DW$260, DW_AT_external
	.dwattr $C$DW$260, DW_AT_decl_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$260, DW_AT_decl_line(0x71)
	.dwattr $C$DW$260, DW_AT_decl_column(0x06)
	.dwattr $C$DW$260, DW_AT_TI_max_frame_size(-68)
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 125,column 1,is_stmt,address ||SFRA_GUI_config||,isa 0

	.dwfde $C$DW$CIE, ||SFRA_GUI_config||
$C$DW$261	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$261, DW_AT_name("sci_base")
	.dwattr $C$DW$261, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$261, DW_AT_location[DW_OP_reg0]

$C$DW$262	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$262, DW_AT_name("vbus_clk")
	.dwattr $C$DW$262, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$262, DW_AT_location[DW_OP_breg20 -70]

$C$DW$263	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$263, DW_AT_name("baudrate")
	.dwattr $C$DW$263, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$263, DW_AT_location[DW_OP_breg20 -72]

$C$DW$264	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$264, DW_AT_name("scirx_gpio_pin")
	.dwattr $C$DW$264, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$264, DW_AT_location[DW_OP_reg14]

$C$DW$265	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$265, DW_AT_name("scirx_gpio_pin_config")
	.dwattr $C$DW$265, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$265, DW_AT_location[DW_OP_breg20 -74]

$C$DW$266	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$266, DW_AT_name("scitx_gpio_pin")
	.dwattr $C$DW$266, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$266, DW_AT_location[DW_OP_breg20 -75]

$C$DW$267	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$267, DW_AT_name("scitx_gpio_pin_config")
	.dwattr $C$DW$267, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$267, DW_AT_location[DW_OP_breg20 -78]

$C$DW$268	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$268, DW_AT_name("led_indicator_flag")
	.dwattr $C$DW$268, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$268, DW_AT_location[DW_OP_breg20 -79]

$C$DW$269	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$269, DW_AT_name("led_gpio_pin")
	.dwattr $C$DW$269, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$269, DW_AT_location[DW_OP_breg20 -80]

$C$DW$270	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$270, DW_AT_name("led_gpio_pin_config")
	.dwattr $C$DW$270, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$270, DW_AT_location[DW_OP_breg20 -82]

$C$DW$271	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$271, DW_AT_name("sfra")
	.dwattr $C$DW$271, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$271, DW_AT_location[DW_OP_reg12]

$C$DW$272	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$272, DW_AT_name("plot_option")
	.dwattr $C$DW$272, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$272, DW_AT_location[DW_OP_breg20 -83]


;***************************************************************
;* FNAME: SFRA_GUI_config               FR SIZE:  66           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            6 Parameter, 54 Auto,  6 SOE     *
;***************************************************************

||SFRA_GUI_config||:
$C$DW$273	.dwtag  DW_TAG_variable
	.dwattr $C$DW$273, DW_AT_name("sci_base")
	.dwattr $C$DW$273, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$273, DW_AT_location[DW_OP_breg20 -8]

;* AR4   assigned to $O$C1
;* AR5   assigned to $O$C2
;* AR5   assigned to $O$C3
;* AR3   assigned to $O$C5
;* AR7   assigned to $O$C6
;* AR6   assigned to $O$U57
;* AR4   assigned to sci_base
$C$DW$274	.dwtag  DW_TAG_variable
	.dwattr $C$DW$274, DW_AT_name("sci_base")
	.dwattr $C$DW$274, DW_AT_type(*$C$DW$T$96)
	.dwattr $C$DW$274, DW_AT_location[DW_OP_reg12]

;* AR1   assigned to vbus_clk
$C$DW$275	.dwtag  DW_TAG_variable
	.dwattr $C$DW$275, DW_AT_name("vbus_clk")
	.dwattr $C$DW$275, DW_AT_type(*$C$DW$T$96)
	.dwattr $C$DW$275, DW_AT_location[DW_OP_reg6]

$C$DW$276	.dwtag  DW_TAG_variable
	.dwattr $C$DW$276, DW_AT_name("baudrate")
	.dwattr $C$DW$276, DW_AT_type(*$C$DW$T$96)
	.dwattr $C$DW$276, DW_AT_location[DW_OP_breg20 -14]

;* AL    assigned to scirx_gpio_pin
$C$DW$277	.dwtag  DW_TAG_variable
	.dwattr $C$DW$277, DW_AT_name("scirx_gpio_pin")
	.dwattr $C$DW$277, DW_AT_type(*$C$DW$T$75)
	.dwattr $C$DW$277, DW_AT_location[DW_OP_reg0]

;* AL    assigned to scirx_gpio_pin_config
$C$DW$278	.dwtag  DW_TAG_variable
	.dwattr $C$DW$278, DW_AT_name("scirx_gpio_pin_config")
	.dwattr $C$DW$278, DW_AT_type(*$C$DW$T$96)
	.dwattr $C$DW$278, DW_AT_location[DW_OP_reg0]

;* AR3   assigned to scitx_gpio_pin
$C$DW$279	.dwtag  DW_TAG_variable
	.dwattr $C$DW$279, DW_AT_name("scitx_gpio_pin")
	.dwattr $C$DW$279, DW_AT_type(*$C$DW$T$75)
	.dwattr $C$DW$279, DW_AT_location[DW_OP_reg10]

$C$DW$280	.dwtag  DW_TAG_variable
	.dwattr $C$DW$280, DW_AT_name("scitx_gpio_pin_config")
	.dwattr $C$DW$280, DW_AT_type(*$C$DW$T$96)
	.dwattr $C$DW$280, DW_AT_location[DW_OP_breg20 -16]

$C$DW$281	.dwtag  DW_TAG_variable
	.dwattr $C$DW$281, DW_AT_name("led_indicator_flag")
	.dwattr $C$DW$281, DW_AT_type(*$C$DW$T$75)
	.dwattr $C$DW$281, DW_AT_location[DW_OP_breg20 -9]

$C$DW$282	.dwtag  DW_TAG_variable
	.dwattr $C$DW$282, DW_AT_name("led_gpio_pin")
	.dwattr $C$DW$282, DW_AT_type(*$C$DW$T$75)
	.dwattr $C$DW$282, DW_AT_location[DW_OP_breg20 -10]

$C$DW$283	.dwtag  DW_TAG_variable
	.dwattr $C$DW$283, DW_AT_name("led_gpio_pin_config")
	.dwattr $C$DW$283, DW_AT_type(*$C$DW$T$96)
	.dwattr $C$DW$283, DW_AT_location[DW_OP_breg20 -22]

;* AR4   assigned to sfra
$C$DW$284	.dwtag  DW_TAG_variable
	.dwattr $C$DW$284, DW_AT_name("sfra")
	.dwattr $C$DW$284, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$284, DW_AT_location[DW_OP_reg12]

$C$DW$285	.dwtag  DW_TAG_variable
	.dwattr $C$DW$285, DW_AT_name("plot_option")
	.dwattr $C$DW$285, DW_AT_type(*$C$DW$T$75)
	.dwattr $C$DW$285, DW_AT_location[DW_OP_breg20 -11]

;* AR4   assigned to base
$C$DW$286	.dwtag  DW_TAG_variable
	.dwattr $C$DW$286, DW_AT_name("base")
	.dwattr $C$DW$286, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$286, DW_AT_location[DW_OP_reg12]

;* AR4   assigned to base
$C$DW$287	.dwtag  DW_TAG_variable
	.dwattr $C$DW$287, DW_AT_name("base")
	.dwattr $C$DW$287, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$287, DW_AT_location[DW_OP_reg12]

;* AR5   assigned to base
$C$DW$288	.dwtag  DW_TAG_variable
	.dwattr $C$DW$288, DW_AT_name("base")
	.dwattr $C$DW$288, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$288, DW_AT_location[DW_OP_reg14]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        MOVL      *SP++,XAR1            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 7, 2
	.dwcfi	cfa_offset, -4
        MOVL      *SP++,XAR2            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 9, 4
	.dwcfi	cfa_offset, -6
        MOVL      *SP++,XAR3            ; [CPU_ALU] 
	.dwcfi	save_reg_to_mem, 11, 6
	.dwcfi	cfa_offset, -8
        MOVZ      AR2,SP                ; [CPU_ALU] 
        SUBB      FP,#23                ; [CPU_ARAU] 
        ADDB      SP,#60                ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -68
        MOVL      XAR0,#8               ; [CPU_ALU] |125| 
        MOVL      *-SP[18],XAR4         ; [CPU_ALU] |125| 
        MOV       *-SP[12],AR5          ; [CPU_ALU] |125| 
        MOVZ      AR3,*+FP[AR0]         ; [CPU_ALU] |125| 
        MOVZ      AR0,*+FP[0]           ; [CPU_ALU] |125| 
        MOVL      XAR1,#9               ; [CPU_ALU] |125| 
        MOVL      XAR4,ACC              ; [CPU_ALU] |125| 
        MOV       *-SP[11],AR0          ; [CPU_ALU] |125| 
        MOVL      XAR0,*+FP[5]          ; [CPU_ALU] |125| 
        MOVL      ACC,*+FP[AR1]         ; [CPU_ALU] |125| 
        MOVL      XAR1,#11              ; [CPU_ALU] |125| 
        MOVZ      AR6,AR1               ; [CPU_ALU] |125| 
        MOVL      *-SP[16],XAR0         ; [CPU_ALU] |125| 
        MOVL      *-SP[8],XAR4          ; [CPU_ALU] |125| 
        MOVL      XAR4,*+FP[1]          ; [CPU_ALU] |125| 
        MOVZ      AR0,AR6               ; [CPU_ALU] |125| 
        MOVL      *-SP[22],XAR4         ; [CPU_ALU] |125| 
        MOV       PL,*+FP[3]            ; [CPU_ALU] |125| 
        MOV       *-SP[10],P            ; [CPU_ALU] |125| 
        MOVZ      AR7,*+FP[4]           ; [CPU_ALU] |125| 
        MOVL      XAR6,*+FP[AR0]        ; [CPU_ALU] |125| 
        MOVL      XAR1,#13              ; [CPU_ALU] |125| 
        MOVL      XAR1,*+FP[AR1]        ; [CPU_ALU] |125| 
        MOV       *-SP[9],AR7           ; [CPU_ALU] |125| 
        MOVL      *-SP[14],XAR6         ; [CPU_ALU] |125| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 132,column 5,is_stmt,isa 0
$C$DW$289	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$289, DW_AT_low_pc(0x00)
	.dwattr $C$DW$289, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$289, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |132| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |132| 
        MOVL      ACC,*-SP[16]          ; [CPU_ALU] |132| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 133,column 5,is_stmt,isa 0
$C$DW$290	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$290, DW_AT_low_pc(0x00)
	.dwattr $C$DW$290, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$290, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |133| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |133| 
        MOV       AL,*-SP[12]           ; [CPU_ALU] |133| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 134,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |134| 
        MOVU      ACC,AL                ; [CPU_ALU] |134| 
$C$DW$291	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$291, DW_AT_low_pc(0x00)
	.dwattr $C$DW$291, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$291, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |134| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |134| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 135,column 5,is_stmt,isa 0
        MOVB      XAR4,#3               ; [CPU_ALU] |135| 
        MOVU      ACC,AR3               ; [CPU_ALU] |135| 
$C$DW$292	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$292, DW_AT_low_pc(0x00)
	.dwattr $C$DW$292, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$292, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |135| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |135| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 145,column 5,is_stmt,isa 0
        MOVL      *-SP[2],XAR1          ; [CPU_ALU] |145| 
        MOVL      XAR6,*-SP[14]         ; [CPU_ALU] |145| 
        MOVB      ACC,#7                ; [CPU_ALU] |145| 
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |145| 
        MOVL      *-SP[6],ACC           ; [CPU_ALU] |145| 
        MOVL      ACC,*-SP[8]           ; [CPU_ALU] |145| 
$C$DW$293	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$293, DW_AT_low_pc(0x00)
	.dwattr $C$DW$293, DW_AT_name("SCI_setConfig")
	.dwattr $C$DW$293, DW_AT_TI_call

        LCR       #||SCI_setConfig||    ; [CPU_ALU] |145| 
        ; call occurs [#||SCI_setConfig||] ; [] |145| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1160,column 1,is_stmt,isa 0
        MOVL      XAR4,*-SP[8]          ; [CPU_ALU] |1160| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 155,column 5,is_stmt,isa 0
        MOVB      ACC,#6                ; [CPU_ALU] |155| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1169,column 5,is_stmt,isa 0
        AND       *+XAR4[0],#0xffef     ; [CPU_ALU] |1169| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 155,column 5,is_stmt,isa 0
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |155| 
        MOVL      ACC,*-SP[8]           ; [CPU_ALU] |155| 
$C$DW$294	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$294, DW_AT_low_pc(0x00)
	.dwattr $C$DW$294, DW_AT_name("SCI_enableInterrupt")
	.dwattr $C$DW$294, DW_AT_TI_call

        LCR       #||SCI_enableInterrupt|| ; [CPU_ALU] |155| 
        ; call occurs [#||SCI_enableInterrupt||] ; [] |155| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 468,column 1,is_stmt,isa 0
        MOVL      XAR4,*-SP[8]          ; [CPU_ALU] |468| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 477,column 5,is_stmt,isa 0
        OR        *+XAR4[1],#0x0023     ; [CPU_ALU] |477| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1107,column 1,is_stmt,isa 0
        MOVL      XAR5,*-SP[8]          ; [CPU_ALU] |1107| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 163,column 5,is_stmt,isa 0
        MOVB      ACC,#10               ; [CPU_ALU] |163| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1116,column 5,is_stmt,isa 0
        AND       *+XAR5[1],#0xffdf     ; [CPU_ALU] |1116| 
	.dwpsn	file "C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/sci.h",line 1117,column 5,is_stmt,isa 0
        OR        *+XAR5[1],#0x0020     ; [CPU_ALU] |1117| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 163,column 5,is_stmt,isa 0
        ADDL      ACC,*-SP[8]           ; [CPU_ALU] |163| 
        MOVL      XAR4,ACC              ; [CPU_ALU] |163| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 164,column 5,is_stmt,isa 0
        MOVB      ACC,#11               ; [CPU_ALU] |164| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 163,column 5,is_stmt,isa 0
        MOV       *+XAR4[0],#32832      ; [CPU_ALU] |163| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 164,column 5,is_stmt,isa 0
        ADDL      ACC,*-SP[8]           ; [CPU_ALU] |164| 
        MOVL      XAR4,ACC              ; [CPU_ALU] |164| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 165,column 5,is_stmt,isa 0
        MOVB      ACC,#12               ; [CPU_ALU] |165| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 164,column 5,is_stmt,isa 0
        MOV       *+XAR4[0],#8271       ; [CPU_ALU] |164| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 165,column 5,is_stmt,isa 0
        ADDL      ACC,*-SP[8]           ; [CPU_ALU] |165| 
        MOVL      XAR4,ACC              ; [CPU_ALU] |165| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 170,column 5,is_stmt,isa 0
        MOVB      ACC,#6                ; [CPU_ALU] |170| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 165,column 5,is_stmt,isa 0
        MOV       *+XAR4[0],#0          ; [CPU_ALU] |165| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 170,column 5,is_stmt,isa 0
        MOVL      *-SP[2],ACC           ; [CPU_ALU] |170| 
        MOVL      ACC,*-SP[8]           ; [CPU_ALU] |170| 
$C$DW$295	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$295, DW_AT_low_pc(0x00)
	.dwattr $C$DW$295, DW_AT_name("SCI_clearInterruptStatus")
	.dwattr $C$DW$295, DW_AT_TI_call

        LCR       #||SCI_clearInterruptStatus|| ; [CPU_ALU] |170| 
        ; call occurs [#||SCI_clearInterruptStatus||] ; [] |170| 
        MOVW      DP,#||SFRA_GUI_serialCommsTimer|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 176,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_getCmdByte|| ; [CPU_ARAU] |176| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 218,column 9,is_stmt,isa 0
        MOVL      XAR6,#||SFRA_GUI_cmdPacket|| ; [CPU_ARAU] |218| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 255,column 5,is_stmt,isa 0
        MOVB      XAR0,#12              ; [CPU_ALU] |255| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 170,column 5,is_stmt,isa 0
        MOVL      XAR4,*-SP[18]         ; [CPU_ALU] |170| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 208,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_serialCommsTimer||,#0 ; [CPU_ALU] |208| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 176,column 5,is_stmt,isa 0
        MOVL      *-SP[24],XAR5         ; [CPU_ALU] |176| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 218,column 9,is_stmt,isa 0
        MOV       *XAR6++,#0            ; [CPU_ALU] |218| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 238,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_sweep_start|| ; [CPU_ARAU] |238| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 255,column 5,is_stmt,isa 0
        MOVL      XT,*+XAR4[AR0]        ; [CPU_ALU] |255| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 248,column 5,is_stmt,isa 0
        MOVL      *-SP[16],XAR4         ; [CPU_ALU] |248| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 209,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_commsOKflg||,#0 ; [CPU_ALU] |209| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 218,column 9,is_stmt,isa 0
        MOV       *XAR6++,#0            ; [CPU_ALU] |218| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 238,column 5,is_stmt,isa 0
        MOVL      *-SP[50],XAR5         ; [CPU_ALU] |238| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 233,column 5,is_stmt,isa 0
        MOVL      XAR0,#||SFRA_GUI_setData32|| ; [CPU_ARAU] |233| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 184,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_sendTaskPtr||,#0 ; [CPU_ALU] |184| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 188,column 5,is_stmt,isa 0
        MOVB      @||SFRA_GUI_lowByteFlag||,#1,UNC ; [CPU_ALU] |188| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 190,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_dataOut16||,#0 ; [CPU_ALU] |190| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 196,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_rcvTskPtrShdw||,#0 ; [CPU_ALU] |196| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 198,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_delayer||,#0 ; [CPU_ALU] |198| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 200,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_memGetPtr||,#0 ; [CPU_ALU] |200| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 202,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_memGetAmount||,#0 ; [CPU_ALU] |202| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 204,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_memSetPtr||,#0 ; [CPU_ALU] |204| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 207,column 5,is_stmt,isa 0
        MOV       @||SFRA_GUI_sweep_start||,#0 ; [CPU_ALU] |207| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 218,column 9,is_stmt,isa 0
        MOVL      XAR7,*-SP[16]         ; [CPU_ALU] |218| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 226,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_lifePulseTsk|| ; [CPU_ARAU] |226| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 218,column 9,is_stmt,isa 0
        MOV       *XAR6++,#0            ; [CPU_ALU] |218| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 240,column 5,is_stmt,isa 0
        MOVL      *-SP[52],XAR4         ; [CPU_ALU] |240| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 250,column 5,is_stmt,isa 0
        MOVL      *-SP[20],XAR4         ; [CPU_ALU] |250| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 233,column 5,is_stmt,isa 0
        MOVL      *-SP[46],XAR0         ; [CPU_ALU] |233| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 226,column 5,is_stmt,isa 0
        MOVL      *-SP[32],XAR5         ; [CPU_ALU] |226| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 218,column 9,is_stmt,isa 0
        MOV       *XAR6++,#0            ; [CPU_ALU] |218| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 248,column 5,is_stmt,isa 0
        ADDB      XAR7,#18              ; [CPU_ALU] |248| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 211,column 5,is_stmt,isa 0
        MOVL      XAR0,*-SP[8]          ; [CPU_ALU] |211| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 227,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_setText|| ; [CPU_ARAU] |227| 
        MOVL      *-SP[34],XAR5         ; [CPU_ALU] |227| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 248,column 5,is_stmt,isa 0
        MOVL      *-SP[16],XAR7         ; [CPU_ALU] |248| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 211,column 5,is_stmt,isa 0
        MOVL      *-SP[30],XAR0         ; [CPU_ALU] |211| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 228,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_setButton|| ; [CPU_ARAU] |228| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 218,column 9,is_stmt,isa 0
        MOV       *XAR6++,#0            ; [CPU_ALU] |218| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 248,column 5,is_stmt,isa 0
        MOVL      XAR7,*-SP[18]         ; [CPU_ALU] |248| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 228,column 5,is_stmt,isa 0
        MOVL      *-SP[36],XAR5         ; [CPU_ALU] |228| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 234,column 5,is_stmt,isa 0
        MOVL      XAR0,#||SFRA_GUI_spareTsk08|| ; [CPU_ARAU] |234| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 229,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_setSlider|| ; [CPU_ARAU] |229| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 234,column 5,is_stmt,isa 0
        MOVL      *-SP[48],XAR0         ; [CPU_ALU] |234| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 249,column 5,is_stmt,isa 0
        ADDB      XAR7,#14              ; [CPU_ALU] |249| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 229,column 5,is_stmt,isa 0
        MOVL      *-SP[38],XAR5         ; [CPU_ALU] |229| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 207,column 5,is_stmt,isa 0
        MOVL      XAR0,*-SP[24]         ; [CPU_ALU] |207| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 249,column 5,is_stmt,isa 0
        MOVL      *-SP[18],XAR7         ; [CPU_ALU] |249| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 240,column 5,is_stmt,isa 0
        MOVL      XAR5,*-SP[52]         ; [CPU_ALU] |240| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 241,column 5,is_stmt,isa 0
        MOVL      *-SP[54],XAR4         ; [CPU_ALU] |241| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 176,column 5,is_stmt,isa 0
        MOVL      @||SFRA_GUI_rcvTaskPointer||,XAR0 ; [CPU_ALU] |176| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 249,column 5,is_stmt,isa 0
        MOVL      XAR7,*-SP[20]         ; [CPU_ALU] |249| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 240,column 5,is_stmt,isa 0
        ADDB      XAR5,#25              ; [CPU_ALU] |240| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 176,column 5,is_stmt,isa 0
        MOVL      XAR0,*-SP[50]         ; [CPU_ALU] |176| 
        MOVW      DP,#||SFRA_GUI_varSetBtnList|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 250,column 5,is_stmt,isa 0
        ADDB      XAR7,#20              ; [CPU_ALU] |250| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 240,column 5,is_stmt,isa 0
        MOVL      *-SP[52],XAR5         ; [CPU_ALU] |240| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 218,column 9,is_stmt,isa 0
        MOV       *+XAR6[0],#0          ; [CPU_ALU] |218| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 238,column 5,is_stmt,isa 0
        MOVL      @||SFRA_GUI_varSetBtnList||,XAR0 ; [CPU_ALU] |238| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 250,column 5,is_stmt,isa 0
        MOVL      *-SP[20],XAR7         ; [CPU_ALU] |250| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 240,column 5,is_stmt,isa 0
        MOVL      XAR5,*-SP[54]         ; [CPU_ALU] |240| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 226,column 5,is_stmt,isa 0
        MOVL      XAR7,#||SFRA_GUI_cmdDispatcher|| ; [CPU_ARAU] |226| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 238,column 5,is_stmt,isa 0
        MOVL      XAR0,*-SP[32]         ; [CPU_ALU] |238| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 242,column 5,is_stmt,isa 0
        MOVL      *-SP[56],XAR4         ; [CPU_ALU] |242| 
        MOVW      DP,#||SFRA_GUI_dataOut32|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 241,column 5,is_stmt,isa 0
        ADDB      XAR5,#24              ; [CPU_ALU] |241| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 226,column 5,is_stmt,isa 0
        MOVL      *+XAR7[0],XAR0        ; [CPU_ALU] |226| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 241,column 5,is_stmt,isa 0
        MOVL      *-SP[54],XAR5         ; [CPU_ALU] |241| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 226,column 5,is_stmt,isa 0
        MOVL      XAR0,*-SP[34]         ; [CPU_ALU] |226| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 241,column 5,is_stmt,isa 0
        MOVL      XAR5,*-SP[56]         ; [CPU_ALU] |241| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 191,column 5,is_stmt,isa 0
        MOV       P,#0                  ; [CPU_ALU] |191| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 248,column 5,is_stmt,isa 0
        MOVL      *-SP[58],XAR4         ; [CPU_ALU] |248| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 227,column 5,is_stmt,isa 0
        MOVL      *+XAR7[2],XAR0        ; [CPU_ALU] |227| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 242,column 5,is_stmt,isa 0
        ADDB      XAR5,#26              ; [CPU_ALU] |242| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 227,column 5,is_stmt,isa 0
        MOVL      XAR0,*-SP[36]         ; [CPU_ALU] |227| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 205,column 5,is_stmt,isa 0
        MOVL      @||SFRA_GUI_memSetValue||,P ; [CPU_ALU] |205| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 242,column 5,is_stmt,isa 0
        MOVL      *-SP[56],XAR5         ; [CPU_ALU] |242| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 248,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_dataSetList|| ; [CPU_ARAU] |248| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 228,column 5,is_stmt,isa 0
        MOVL      *+XAR7[4],XAR0        ; [CPU_ALU] |228| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 248,column 5,is_stmt,isa 0
        MOVL      *-SP[14],XAR5         ; [CPU_ALU] |248| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 228,column 5,is_stmt,isa 0
        MOVL      XAR0,*-SP[38]         ; [CPU_ALU] |228| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 191,column 5,is_stmt,isa 0
        MOVL      XAR5,*-SP[58]         ; [CPU_ALU] |191| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 250,column 5,is_stmt,isa 0
        MOVL      ACC,XAR4              ; [CPU_ALU] |250| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 240,column 5,is_stmt,isa 0
        MOVL      XAR3,#||SFRA_GUI_varGetList|| ; [CPU_ARAU] |240| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 229,column 5,is_stmt,isa 0
        MOVL      *+XAR7[6],XAR0        ; [CPU_ALU] |229| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 248,column 5,is_stmt,isa 0
        ADDB      XAR5,#18              ; [CPU_ALU] |248| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 229,column 5,is_stmt,isa 0
        MOVL      XAR0,*-SP[52]         ; [CPU_ALU] |229| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 249,column 5,is_stmt,isa 0
        MOVL      *-SP[60],XAR4         ; [CPU_ALU] |249| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 250,column 5,is_stmt,isa 0
        ADDB      ACC,#20               ; [CPU_ALU] |250| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 248,column 5,is_stmt,isa 0
        MOVL      *-SP[58],XAR5         ; [CPU_ALU] |248| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 240,column 5,is_stmt,isa 0
        MOVL      *+XAR3[0],XAR0        ; [CPU_ALU] |240| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 201,column 5,is_stmt,isa 0
        MOVL      XAR5,*-SP[60]         ; [CPU_FPU] |201| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 240,column 5,is_stmt,isa 0
        MOVL      XAR0,*-SP[54]         ; [CPU_FPU] |240| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 191,column 5,is_stmt,isa 0
        MOVL      *-SP[26],P            ; [CPU_FPU] |191| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 234,column 5,is_stmt,isa 0
        MOVB      XAR1,#16              ; [CPU_ALU] |234| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 249,column 5,is_stmt,isa 0
        ADDB      XAR5,#14              ; [CPU_ALU] |249| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 241,column 5,is_stmt,isa 0
        MOVL      *+XAR3[2],XAR0        ; [CPU_ALU] |241| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 249,column 5,is_stmt,isa 0
        MOVL      *-SP[60],XAR5         ; [CPU_ALU] |249| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 230,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_getVariable|| ; [CPU_ARAU] |230| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 241,column 5,is_stmt,isa 0
        MOVL      XAR0,*-SP[56]         ; [CPU_ALU] |241| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 201,column 5,is_stmt,isa 0
        MOVL      *-SP[28],P            ; [CPU_ALU] |201| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 230,column 5,is_stmt,isa 0
        MOVL      *-SP[40],XAR5         ; [CPU_ALU] |230| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 231,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_getArray|| ; [CPU_ARAU] |231| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 242,column 5,is_stmt,isa 0
        MOVL      *+XAR3[4],XAR0        ; [CPU_ALU] |242| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 231,column 5,is_stmt,isa 0
        MOVL      *-SP[42],XAR5         ; [CPU_ALU] |231| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 242,column 5,is_stmt,isa 0
        MOVL      XAR0,*-SP[14]         ; [CPU_ALU] |242| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 232,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_getData|| ; [CPU_ARAU] |232| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 242,column 5,is_stmt,isa 0
        MOVL      XAR3,*-SP[58]         ; [CPU_ALU] |242| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 232,column 5,is_stmt,isa 0
        MOVL      *-SP[44],XAR5         ; [CPU_ALU] |232| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 250,column 5,is_stmt,isa 0
        MOVL      *+XAR0[4],ACC         ; [CPU_ALU] |250| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 255,column 5,is_stmt,isa 0
        MOVL      XAR5,#||SFRA_GUI_arrayGetList|| ; [CPU_ARAU] |255| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 248,column 5,is_stmt,isa 0
        MOVL      *+XAR0[0],XAR3        ; [CPU_ALU] |248| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 250,column 5,is_stmt,isa 0
        MOVL      ACC,*-SP[26]          ; [CPU_ALU] |250| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 191,column 5,is_stmt,isa 0
        MOVL      @||SFRA_GUI_dataOut32||,ACC ; [CPU_ALU] |191| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 248,column 5,is_stmt,isa 0
        MOVL      XAR3,*-SP[60]         ; [CPU_ALU] |248| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 201,column 5,is_stmt,isa 0
        MOVL      @||SFRA_GUI_memGetAddress||,ACC ; [CPU_ALU] |201| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 255,column 5,is_stmt,isa 0
        MOVL      *+XAR5[0],XT          ; [CPU_ALU] |255| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 230,column 5,is_stmt,isa 0
        MOVL      ACC,*-SP[40]          ; [CPU_ALU] |230| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 249,column 5,is_stmt,isa 0
        MOVL      *+XAR0[2],XAR3        ; [CPU_ALU] |249| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 230,column 5,is_stmt,isa 0
        MOVB      XAR0,#8               ; [CPU_ALU] |230| 
        MOVL      *+XAR7[AR0],ACC       ; [CPU_ALU] |230| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 231,column 5,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |231| 
        MOVL      ACC,*-SP[42]          ; [CPU_ALU] |231| 
        MOVL      *+XAR7[AR0],ACC       ; [CPU_ALU] |231| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 232,column 5,is_stmt,isa 0
        MOVB      XAR0,#12              ; [CPU_ALU] |232| 
        MOVL      ACC,*-SP[44]          ; [CPU_ALU] |232| 
        MOVL      *+XAR7[AR0],ACC       ; [CPU_ALU] |232| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 233,column 5,is_stmt,isa 0
        MOVB      XAR0,#14              ; [CPU_ALU] |233| 
        MOVL      ACC,*-SP[46]          ; [CPU_ALU] |233| 
        MOVL      *+XAR7[AR0],ACC       ; [CPU_ALU] |233| 
        MOVL      ACC,*-SP[48]          ; [CPU_ALU] |233| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 234,column 5,is_stmt,isa 0
        MOVL      *+XAR7[AR1],ACC       ; [CPU_ALU] |234| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 255,column 5,is_stmt,isa 0
        MOVL      ACC,*-SP[30]          ; [CPU_ALU] |255| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 211,column 5,is_stmt,isa 0
        MOVL      @||SFRA_GUI_sci_base_addr||,ACC ; [CPU_ALU] |211| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 218,column 9,is_stmt,isa 0
        MOV       AL,*-SP[11]           ; [CPU_ALU] |218| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 258,column 5,is_stmt,isa 0
        CMPB      AL,#2                 ; [CPU_ALU] |258| 
        B         ||$C$L90||,EQ         ; [CPU_ALU] |258| 
        ; branchcc occurs ; [] |258| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 274,column 9,is_stmt,isa 0
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |274| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 275,column 9,is_stmt,isa 0
        MOVL      P,*+XAR4[2]           ; [CPU_ALU] |275| 
        B         ||$C$L91||,UNC        ; [CPU_ALU] |275| 
        ; branch occurs ; [] |275| 
||$C$L90||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 263,column 9,is_stmt,isa 0
        MOVB      XAR0,#8               ; [CPU_ALU] |263| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 264,column 9,is_stmt,isa 0
        MOVB      XAR1,#10              ; [CPU_ALU] |264| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 263,column 9,is_stmt,isa 0
        MOVL      ACC,*+XAR4[AR0]       ; [CPU_ALU] |263| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 264,column 9,is_stmt,isa 0
        MOVL      P,*+XAR4[AR1]         ; [CPU_ALU] |264| 
||$C$L91||:    
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 260,column 9,is_stmt,isa 0
        MOVL      XAR7,*+XAR4[4]        ; [CPU_ALU] |260| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 261,column 9,is_stmt,isa 0
        MOVL      XAR6,*+XAR4[6]        ; [CPU_ALU] |261| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 264,column 9,is_stmt,isa 0
        MOVB      XAR0,#8               ; [CPU_ALU] |264| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 280,column 5,is_stmt,isa 0
        MOVL      XAR4,#||SFRA_GUI_arrayGetList|| ; [CPU_ARAU] |280| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 282,column 5,is_stmt,isa 0
        MOVB      XAR1,#14              ; [CPU_ALU] |282| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 260,column 9,is_stmt,isa 0
        MOVL      *+XAR5[2],XAR7        ; [CPU_ALU] |260| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 261,column 9,is_stmt,isa 0
        MOVL      *+XAR5[4],XAR6        ; [CPU_ALU] |261| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 263,column 9,is_stmt,isa 0
        MOVL      *+XAR5[6],ACC         ; [CPU_ALU] |263| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 264,column 9,is_stmt,isa 0
        MOVL      *+XAR5[AR0],P         ; [CPU_ALU] |264| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 280,column 5,is_stmt,isa 0
        MOVB      XAR0,#10              ; [CPU_ALU] |280| 
        MOVL      ACC,*-SP[16]          ; [CPU_ALU] |280| 
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |280| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 281,column 5,is_stmt,isa 0
        MOVB      XAR0,#12              ; [CPU_ALU] |281| 
        MOVL      ACC,*-SP[18]          ; [CPU_ALU] |281| 
        MOVL      *+XAR4[AR0],ACC       ; [CPU_ALU] |281| 
        MOVL      ACC,*-SP[20]          ; [CPU_ALU] |281| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 282,column 5,is_stmt,isa 0
        MOVL      *+XAR4[AR1],ACC       ; [CPU_ALU] |282| 
        MOV       AL,*-SP[9]            ; [CPU_ALU] |282| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 285,column 5,is_stmt,isa 0
        CMPB      AL,#1                 ; [CPU_ALU] |285| 
        B         ||$C$L92||,EQ         ; [CPU_ALU] |285| 
        ; branchcc occurs ; [] |285| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 295,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_led_flag||,#0 ; [CPU_ALU] |295| 
        B         ||$C$L93||,UNC        ; [CPU_ALU] |295| 
        ; branch occurs ; [] |295| 
||$C$L92||:    
        MOVZ      AR1,*-SP[10]          ; [CPU_ALU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 287,column 9,is_stmt,isa 0
        MOVB      XAR4,#1               ; [CPU_ALU] |287| 
        MOVU      ACC,AR1               ; [CPU_ALU] |287| 
$C$DW$296	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$296, DW_AT_low_pc(0x00)
	.dwattr $C$DW$296, DW_AT_name("GPIO_setDirectionMode")
	.dwattr $C$DW$296, DW_AT_TI_call

        LCR       #||GPIO_setDirectionMode|| ; [CPU_ALU] |287| 
        ; call occurs [#||GPIO_setDirectionMode||] ; [] |287| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 288,column 9,is_stmt,isa 0
        MOVB      XAR4,#0               ; [CPU_ALU] |288| 
        MOVU      ACC,AR1               ; [CPU_ALU] |288| 
$C$DW$297	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$297, DW_AT_low_pc(0x00)
	.dwattr $C$DW$297, DW_AT_name("GPIO_setQualificationMode")
	.dwattr $C$DW$297, DW_AT_TI_call

        LCR       #||GPIO_setQualificationMode|| ; [CPU_ALU] |288| 
        ; call occurs [#||GPIO_setQualificationMode||] ; [] |288| 
        MOVL      ACC,*-SP[22]          ; [CPU_ALU] |288| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 289,column 9,is_stmt,isa 0
$C$DW$298	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$298, DW_AT_low_pc(0x00)
	.dwattr $C$DW$298, DW_AT_name("GPIO_setPinConfig")
	.dwattr $C$DW$298, DW_AT_TI_call

        LCR       #||GPIO_setPinConfig|| ; [CPU_ALU] |289| 
        ; call occurs [#||GPIO_setPinConfig||] ; [] |289| 
        MOVW      DP,#||SFRA_GUI_led_flag|| ; [CPU_ARAU] 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 290,column 9,is_stmt,isa 0
        MOVB      @||SFRA_GUI_led_flag||,#1,UNC ; [CPU_ALU] |290| 
	.dwpsn	file "../libraries/sfra/sfra_gui_scicomms_driverlib.c",line 291,column 9,is_stmt,isa 0
        MOV       @||SFRA_GUI_led_gpio||,AR1 ; [CPU_ALU] |291| 
||$C$L93||:    
        SUBB      SP,#60                ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -8
        MOVL      XAR3,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -6
	.dwcfi	restore_reg, 11
        MOVL      XAR2,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -4
	.dwcfi	restore_reg, 9
        MOVL      XAR1,*--SP            ; [CPU_ALU] 
	.dwcfi	cfa_offset, -2
	.dwcfi	restore_reg, 7
$C$DW$299	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$299, DW_AT_low_pc(0x00)
	.dwattr $C$DW$299, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$260, DW_AT_TI_end_file("../libraries/sfra/sfra_gui_scicomms_driverlib.c")
	.dwattr $C$DW$260, DW_AT_TI_end_line(0x12a)
	.dwattr $C$DW$260, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$260

;**************************************************************
;* UNDEFINED EXTERNAL REFERENCES                              *
;**************************************************************
	.global	||GPIO_setPinConfig||
	.global	||GPIO_setQualificationMode||
	.global	||SCI_setConfig||
	.global	||SCI_enableInterrupt||
	.global	||SCI_clearInterruptStatus||
	.global	||GPIO_setDirectionMode||
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

$C$DW$T$24	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$24, DW_AT_byte_size(0x01)
$C$DW$300	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$300, DW_AT_name("GPIO_DIR_MODE_IN")
	.dwattr $C$DW$300, DW_AT_const_value(0x00)
	.dwattr $C$DW$300, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$300, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$300, DW_AT_decl_column(0x05)

$C$DW$301	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$301, DW_AT_name("GPIO_DIR_MODE_OUT")
	.dwattr $C$DW$301, DW_AT_const_value(0x01)
	.dwattr $C$DW$301, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$301, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$301, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$24, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$24, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$T$24, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$24

	.dwendtag $C$DW$TU$24


$C$DW$TU$25	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$25
$C$DW$T$25	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$25, DW_AT_name("GPIO_Direction")
	.dwattr $C$DW$T$25, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$T$25, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$25, DW_AT_decl_line(0x80)
	.dwattr $C$DW$T$25, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$25


$C$DW$TU$26	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$26

$C$DW$T$26	.dwtag  DW_TAG_enumeration_type
	.dwattr $C$DW$T$26, DW_AT_byte_size(0x01)
$C$DW$302	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$302, DW_AT_name("GPIO_QUAL_SYNC")
	.dwattr $C$DW$302, DW_AT_const_value(0x00)
	.dwattr $C$DW$302, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$302, DW_AT_decl_line(0x97)
	.dwattr $C$DW$302, DW_AT_decl_column(0x05)

$C$DW$303	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$303, DW_AT_name("GPIO_QUAL_3SAMPLE")
	.dwattr $C$DW$303, DW_AT_const_value(0x01)
	.dwattr $C$DW$303, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$303, DW_AT_decl_line(0x98)
	.dwattr $C$DW$303, DW_AT_decl_column(0x05)

$C$DW$304	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$304, DW_AT_name("GPIO_QUAL_6SAMPLE")
	.dwattr $C$DW$304, DW_AT_const_value(0x02)
	.dwattr $C$DW$304, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$304, DW_AT_decl_line(0x99)
	.dwattr $C$DW$304, DW_AT_decl_column(0x05)

$C$DW$305	.dwtag  DW_TAG_enumerator
	.dwattr $C$DW$305, DW_AT_name("GPIO_QUAL_ASYNC")
	.dwattr $C$DW$305, DW_AT_const_value(0x03)
	.dwattr $C$DW$305, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$305, DW_AT_decl_line(0x9a)
	.dwattr $C$DW$305, DW_AT_decl_column(0x05)

	.dwattr $C$DW$T$26, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$26, DW_AT_decl_line(0x96)
	.dwattr $C$DW$T$26, DW_AT_decl_column(0x01)
	.dwendtag $C$DW$T$26

	.dwendtag $C$DW$TU$26


$C$DW$TU$27	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$27
$C$DW$T$27	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$27, DW_AT_name("GPIO_QualificationMode")
	.dwattr $C$DW$T$27, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$T$27, DW_AT_decl_file("C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib/gpio.h")
	.dwattr $C$DW$T$27, DW_AT_decl_line(0x9b)
	.dwattr $C$DW$T$27, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$27


$C$DW$TU$23	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$23

$C$DW$T$23	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$23, DW_AT_byte_size(0x20)
$C$DW$306	.dwtag  DW_TAG_member
	.dwattr $C$DW$306, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$306, DW_AT_name("h_magVect")
	.dwattr $C$DW$306, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$306, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$306, DW_AT_decl_line(0x40)
	.dwattr $C$DW$306, DW_AT_decl_column(0x10)

$C$DW$307	.dwtag  DW_TAG_member
	.dwattr $C$DW$307, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$307, DW_AT_name("h_phaseVect")
	.dwattr $C$DW$307, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$307, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$307, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$307, DW_AT_decl_line(0x41)
	.dwattr $C$DW$307, DW_AT_decl_column(0x10)

$C$DW$308	.dwtag  DW_TAG_member
	.dwattr $C$DW$308, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$308, DW_AT_name("gh_magVect")
	.dwattr $C$DW$308, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$308, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$308, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$308, DW_AT_decl_line(0x42)
	.dwattr $C$DW$308, DW_AT_decl_column(0x10)

$C$DW$309	.dwtag  DW_TAG_member
	.dwattr $C$DW$309, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$309, DW_AT_name("gh_phaseVect")
	.dwattr $C$DW$309, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$309, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$309, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$309, DW_AT_decl_line(0x43)
	.dwattr $C$DW$309, DW_AT_decl_column(0x10)

$C$DW$310	.dwtag  DW_TAG_member
	.dwattr $C$DW$310, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$310, DW_AT_name("cl_magVect")
	.dwattr $C$DW$310, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$310, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$310, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$310, DW_AT_decl_line(0x44)
	.dwattr $C$DW$310, DW_AT_decl_column(0x10)

$C$DW$311	.dwtag  DW_TAG_member
	.dwattr $C$DW$311, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$311, DW_AT_name("cl_phaseVect")
	.dwattr $C$DW$311, DW_AT_data_member_location[DW_OP_plus_uconst 0xa]
	.dwattr $C$DW$311, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$311, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$311, DW_AT_decl_line(0x45)
	.dwattr $C$DW$311, DW_AT_decl_column(0x10)

$C$DW$312	.dwtag  DW_TAG_member
	.dwattr $C$DW$312, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$312, DW_AT_name("freqVect")
	.dwattr $C$DW$312, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$312, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$312, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$312, DW_AT_decl_line(0x46)
	.dwattr $C$DW$312, DW_AT_decl_column(0x10)

$C$DW$313	.dwtag  DW_TAG_member
	.dwattr $C$DW$313, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$313, DW_AT_name("amplitude")
	.dwattr $C$DW$313, DW_AT_data_member_location[DW_OP_plus_uconst 0xe]
	.dwattr $C$DW$313, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$313, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$313, DW_AT_decl_line(0x47)
	.dwattr $C$DW$313, DW_AT_decl_column(0x0f)

$C$DW$314	.dwtag  DW_TAG_member
	.dwattr $C$DW$314, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$314, DW_AT_name("isrFreq")
	.dwattr $C$DW$314, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$314, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$314, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$314, DW_AT_decl_line(0x48)
	.dwattr $C$DW$314, DW_AT_decl_column(0x0f)

$C$DW$315	.dwtag  DW_TAG_member
	.dwattr $C$DW$315, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$315, DW_AT_name("freqStart")
	.dwattr $C$DW$315, DW_AT_data_member_location[DW_OP_plus_uconst 0x12]
	.dwattr $C$DW$315, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$315, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$315, DW_AT_decl_line(0x49)
	.dwattr $C$DW$315, DW_AT_decl_column(0x0f)

$C$DW$316	.dwtag  DW_TAG_member
	.dwattr $C$DW$316, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$316, DW_AT_name("freqStep")
	.dwattr $C$DW$316, DW_AT_data_member_location[DW_OP_plus_uconst 0x14]
	.dwattr $C$DW$316, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$316, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$316, DW_AT_decl_line(0x4a)
	.dwattr $C$DW$316, DW_AT_decl_column(0x0f)

$C$DW$317	.dwtag  DW_TAG_member
	.dwattr $C$DW$317, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$317, DW_AT_name("start")
	.dwattr $C$DW$317, DW_AT_data_member_location[DW_OP_plus_uconst 0x16]
	.dwattr $C$DW$317, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$317, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$317, DW_AT_decl_line(0x4b)
	.dwattr $C$DW$317, DW_AT_decl_column(0x0d)

$C$DW$318	.dwtag  DW_TAG_member
	.dwattr $C$DW$318, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$318, DW_AT_name("state")
	.dwattr $C$DW$318, DW_AT_data_member_location[DW_OP_plus_uconst 0x17]
	.dwattr $C$DW$318, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$318, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$318, DW_AT_decl_line(0x4c)
	.dwattr $C$DW$318, DW_AT_decl_column(0x0d)

$C$DW$319	.dwtag  DW_TAG_member
	.dwattr $C$DW$319, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$319, DW_AT_name("status")
	.dwattr $C$DW$319, DW_AT_data_member_location[DW_OP_plus_uconst 0x18]
	.dwattr $C$DW$319, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$319, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$319, DW_AT_decl_line(0x4d)
	.dwattr $C$DW$319, DW_AT_decl_column(0x0d)

$C$DW$320	.dwtag  DW_TAG_member
	.dwattr $C$DW$320, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$320, DW_AT_name("vecLength")
	.dwattr $C$DW$320, DW_AT_data_member_location[DW_OP_plus_uconst 0x19]
	.dwattr $C$DW$320, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$320, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$320, DW_AT_decl_line(0x4e)
	.dwattr $C$DW$320, DW_AT_decl_column(0x0d)

$C$DW$321	.dwtag  DW_TAG_member
	.dwattr $C$DW$321, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$321, DW_AT_name("freqIndex")
	.dwattr $C$DW$321, DW_AT_data_member_location[DW_OP_plus_uconst 0x1a]
	.dwattr $C$DW$321, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$321, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$321, DW_AT_decl_line(0x4f)
	.dwattr $C$DW$321, DW_AT_decl_column(0x0d)

$C$DW$322	.dwtag  DW_TAG_member
	.dwattr $C$DW$322, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$322, DW_AT_name("storeH")
	.dwattr $C$DW$322, DW_AT_data_member_location[DW_OP_plus_uconst 0x1b]
	.dwattr $C$DW$322, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$322, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$322, DW_AT_decl_line(0x50)
	.dwattr $C$DW$322, DW_AT_decl_column(0x0d)

$C$DW$323	.dwtag  DW_TAG_member
	.dwattr $C$DW$323, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$323, DW_AT_name("storeGH")
	.dwattr $C$DW$323, DW_AT_data_member_location[DW_OP_plus_uconst 0x1c]
	.dwattr $C$DW$323, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$323, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$323, DW_AT_decl_line(0x51)
	.dwattr $C$DW$323, DW_AT_decl_column(0x0d)

$C$DW$324	.dwtag  DW_TAG_member
	.dwattr $C$DW$324, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$324, DW_AT_name("storeCL")
	.dwattr $C$DW$324, DW_AT_data_member_location[DW_OP_plus_uconst 0x1d]
	.dwattr $C$DW$324, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$324, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$324, DW_AT_decl_line(0x52)
	.dwattr $C$DW$324, DW_AT_decl_column(0x0d)

$C$DW$325	.dwtag  DW_TAG_member
	.dwattr $C$DW$325, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$325, DW_AT_name("speed")
	.dwattr $C$DW$325, DW_AT_data_member_location[DW_OP_plus_uconst 0x1e]
	.dwattr $C$DW$325, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$325, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$325, DW_AT_decl_line(0x53)
	.dwattr $C$DW$325, DW_AT_decl_column(0x0d)

	.dwattr $C$DW$T$23, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$T$23, DW_AT_decl_line(0x3f)
	.dwattr $C$DW$T$23, DW_AT_decl_column(0x0f)
	.dwendtag $C$DW$T$23

	.dwendtag $C$DW$TU$23


$C$DW$TU$28	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$28
$C$DW$T$28	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$28, DW_AT_name("SFRA_F32")
	.dwattr $C$DW$T$28, DW_AT_type(*$C$DW$T$23)
	.dwattr $C$DW$T$28, DW_AT_decl_file("..\libraries\sfra\sfra_f32.h")
	.dwattr $C$DW$T$28, DW_AT_decl_line(0x54)
	.dwattr $C$DW$T$28, DW_AT_decl_column(0x02)

	.dwendtag $C$DW$TU$28


$C$DW$TU$29	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$29
$C$DW$T$29	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$29, DW_AT_type(*$C$DW$T$28)
	.dwattr $C$DW$T$29, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$29


$C$DW$TU$30	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$30
$C$DW$326	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$326, DW_AT_type(*$C$DW$T$29)

$C$DW$T$30	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$30, DW_AT_type(*$C$DW$326)

	.dwendtag $C$DW$TU$30


$C$DW$TU$2	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$2
$C$DW$T$2	.dwtag  DW_TAG_unspecified_type
	.dwattr $C$DW$T$2, DW_AT_name("void")

	.dwendtag $C$DW$TU$2


$C$DW$TU$51	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$51

$C$DW$T$51	.dwtag  DW_TAG_subroutine_type
	.dwendtag $C$DW$T$51

	.dwendtag $C$DW$TU$51


$C$DW$TU$52	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$52
$C$DW$T$52	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$52, DW_AT_type(*$C$DW$T$51)
	.dwattr $C$DW$T$52, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$52


$C$DW$TU$53	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$53

$C$DW$T$53	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$53, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$T$53, DW_AT_byte_size(0x20)
$C$DW$327	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$327, DW_AT_upper_bound(0x0f)

	.dwendtag $C$DW$T$53

	.dwendtag $C$DW$TU$53


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


$C$DW$TU$64	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$64
$C$DW$T$64	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$64, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$T$64, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$64


$C$DW$TU$65	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$65
$C$DW$328	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$328, DW_AT_type(*$C$DW$T$22)

$C$DW$T$65	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$65, DW_AT_type(*$C$DW$328)

	.dwendtag $C$DW$TU$65


$C$DW$TU$66	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$66
$C$DW$T$66	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$66, DW_AT_type(*$C$DW$T$65)
	.dwattr $C$DW$T$66, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$66


$C$DW$TU$67	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$67

$C$DW$T$67	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$67, DW_AT_type(*$C$DW$T$66)
	.dwattr $C$DW$T$67, DW_AT_byte_size(0x20)
$C$DW$329	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$329, DW_AT_upper_bound(0x0f)

	.dwendtag $C$DW$T$67

	.dwendtag $C$DW$TU$67


$C$DW$TU$11	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$11
$C$DW$T$11	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$11, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$11, DW_AT_name("unsigned int")
	.dwattr $C$DW$T$11, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$11


$C$DW$TU$41	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$41
$C$DW$T$41	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$41, DW_AT_name("__uint16_t")
	.dwattr $C$DW$T$41, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$T$41, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$41, DW_AT_decl_line(0x41)
	.dwattr $C$DW$T$41, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$41


$C$DW$TU$42	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$42
$C$DW$T$42	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$42, DW_AT_name("uint16_t")
	.dwattr $C$DW$T$42, DW_AT_type(*$C$DW$T$41)
	.dwattr $C$DW$T$42, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$42, DW_AT_decl_line(0x41)
	.dwattr $C$DW$T$42, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$42


$C$DW$TU$74	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$74

$C$DW$T$74	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$74, DW_AT_type(*$C$DW$T$42)
	.dwattr $C$DW$T$74, DW_AT_byte_size(0x06)
$C$DW$330	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$330, DW_AT_upper_bound(0x05)

	.dwendtag $C$DW$T$74

	.dwendtag $C$DW$TU$74


$C$DW$TU$75	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$75
$C$DW$331	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$331, DW_AT_type(*$C$DW$T$42)

$C$DW$T$75	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$75, DW_AT_type(*$C$DW$331)

	.dwendtag $C$DW$TU$75


$C$DW$TU$12	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$12
$C$DW$T$12	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$12, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$12, DW_AT_name("long")
	.dwattr $C$DW$T$12, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$12


$C$DW$TU$82	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$82
$C$DW$T$82	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$82, DW_AT_name("__int32_t")
	.dwattr $C$DW$T$82, DW_AT_type(*$C$DW$T$12)
	.dwattr $C$DW$T$82, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$82, DW_AT_decl_line(0x42)
	.dwattr $C$DW$T$82, DW_AT_decl_column(0x1d)

	.dwendtag $C$DW$TU$82


$C$DW$TU$83	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$83
$C$DW$T$83	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$83, DW_AT_name("int32_t")
	.dwattr $C$DW$T$83, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$T$83, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$83, DW_AT_decl_line(0x30)
	.dwattr $C$DW$T$83, DW_AT_decl_column(0x14)

	.dwendtag $C$DW$TU$83


$C$DW$TU$84	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$84
$C$DW$T$84	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$84, DW_AT_type(*$C$DW$T$83)
	.dwattr $C$DW$T$84, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$84


$C$DW$TU$85	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$85
$C$DW$332	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$332, DW_AT_type(*$C$DW$T$83)

$C$DW$T$85	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$85, DW_AT_type(*$C$DW$332)

	.dwendtag $C$DW$TU$85


$C$DW$TU$86	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$86
$C$DW$T$86	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$86, DW_AT_type(*$C$DW$T$85)
	.dwattr $C$DW$T$86, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$86


$C$DW$TU$87	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$87

$C$DW$T$87	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$87, DW_AT_type(*$C$DW$T$86)
	.dwattr $C$DW$T$87, DW_AT_byte_size(0x20)
$C$DW$333	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$333, DW_AT_upper_bound(0x0f)

	.dwendtag $C$DW$T$87

	.dwendtag $C$DW$TU$87


$C$DW$TU$13	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$13
$C$DW$T$13	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$13, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$13, DW_AT_name("unsigned long")
	.dwattr $C$DW$T$13, DW_AT_byte_size(0x02)

	.dwendtag $C$DW$TU$13


$C$DW$TU$33	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$33
$C$DW$T$33	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$33, DW_AT_name("__uint32_t")
	.dwattr $C$DW$T$33, DW_AT_type(*$C$DW$T$13)
	.dwattr $C$DW$T$33, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$33, DW_AT_decl_line(0x43)
	.dwattr $C$DW$T$33, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$33


$C$DW$TU$34	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$34
$C$DW$T$34	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$34, DW_AT_name("uint32_t")
	.dwattr $C$DW$T$34, DW_AT_type(*$C$DW$T$33)
	.dwattr $C$DW$T$34, DW_AT_decl_file("C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$34, DW_AT_decl_line(0x46)
	.dwattr $C$DW$T$34, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$34


$C$DW$TU$48	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$48
$C$DW$334	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$334, DW_AT_type(*$C$DW$T$34)

$C$DW$T$48	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$48, DW_AT_type(*$C$DW$334)

	.dwendtag $C$DW$TU$48


$C$DW$TU$94	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$94
$C$DW$T$94	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$94, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$T$94, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$94


$C$DW$TU$95	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$95

$C$DW$T$95	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$95, DW_AT_type(*$C$DW$T$94)
	.dwattr $C$DW$T$95, DW_AT_byte_size(0x20)
$C$DW$335	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$335, DW_AT_upper_bound(0x0f)

	.dwendtag $C$DW$T$95

	.dwendtag $C$DW$TU$95


$C$DW$TU$96	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$96
$C$DW$336	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$336, DW_AT_type(*$C$DW$T$34)

$C$DW$T$96	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$96, DW_AT_type(*$C$DW$336)

	.dwendtag $C$DW$TU$96


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


$C$DW$TU$100	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$100
$C$DW$337	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$337, DW_AT_type(*$C$DW$T$16)

$C$DW$T$100	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$100, DW_AT_type(*$C$DW$337)

	.dwendtag $C$DW$TU$100


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


$C$DW$TU$17	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$17
$C$DW$T$17	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$17, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$17, DW_AT_name("double")
	.dwattr $C$DW$T$17, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$17


$C$DW$TU$101	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$101
$C$DW$T$101	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$101, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$T$101, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$101


$C$DW$TU$102	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$102
$C$DW$338	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$338, DW_AT_type(*$C$DW$T$101)

$C$DW$T$102	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$102, DW_AT_type(*$C$DW$338)

	.dwendtag $C$DW$TU$102


$C$DW$TU$18	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$18
$C$DW$T$18	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$18, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$18, DW_AT_name("long double")
	.dwattr $C$DW$T$18, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$18


$C$DW$TU$103	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$103
$C$DW$T$103	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$103, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$103, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$103


$C$DW$TU$104	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$104
$C$DW$339	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$339, DW_AT_type(*$C$DW$T$103)

$C$DW$T$104	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$104, DW_AT_type(*$C$DW$339)

	.dwendtag $C$DW$TU$104


$C$DW$TU$105	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$105
$C$DW$T$105	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$105, DW_AT_encoding(DW_ATE_unsigned_char)
	.dwattr $C$DW$T$105, DW_AT_name("unsigned char")
	.dwattr $C$DW$T$105, DW_AT_byte_size(0x01)

	.dwendtag $C$DW$TU$105

