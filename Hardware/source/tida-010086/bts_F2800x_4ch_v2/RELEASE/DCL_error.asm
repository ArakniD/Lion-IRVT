;***************************************************************
;* TMS320C2000 G3 C/C++ Codegen                               PC v20.2.1.LTS *
;* Date/Time created: Wed Sep 16 09:53:44 2020                 *
;***************************************************************
	.compiler_opts --abi=eabi --cla_support=cla2 --diag_wrap=off --float_support=fpu32 --hll_source=on --mem_model:code=flat --mem_model:data=large --object_format=elf --quiet --silicon_errata_fpu1_workaround=off --silicon_version=28 --symdebug:dwarf --symdebug:dwarf_version=4 --tmu_support=tmu0 --vcu_support=vcu0 
	.asg	XAR2, FP

$C$DW$CU	.dwtag  DW_TAG_compile_unit
	.dwattr $C$DW$CU, DW_AT_name("../libraries/DCL/DCL_error.c")
	.dwattr $C$DW$CU, DW_AT_producer("TI TMS320C2000 G3 C/C++ Codegen PC v20.2.1.LTS Copyright (c) 1996-2018 Texas Instruments Incorporated")
	.dwattr $C$DW$CU, DW_AT_TI_version(0x01)
	.dwattr $C$DW$CU, DW_AT_comp_dir("C:\Users\a0230328\workspace_v10\bts_F2800x_4ch_v2\RELEASE")
;	C:\ti\ccs1010\ccs\tools\compiler\ti-cgt-c2000_20.2.1.LTS\bin\opt2000.exe C:\\Users\\a0230328\\AppData\\Local\\Temp\\{1E985AC4-6C9D-439C-BA73-07E901C4F863} C:\\Users\\a0230328\\AppData\\Local\\Temp\\{6436DF6B-C18E-4CB7-AEFE-C05FFBE3F02B} 
;	C:\ti\ccs1010\ccs\tools\compiler\ti-cgt-c2000_20.2.1.LTS\bin\acia2000.exe -@C:\\Users\\a0230328\\AppData\\Local\\Temp\\{A5DDC1FB-8988-4B93-8579-C836EF2FBDBC} 
	.sect	".text:__signbitl"
	.clink
	.global	||__signbitl||

$C$DW$1	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$1, DW_AT_name("__signbitl")
	.dwattr $C$DW$1, DW_AT_low_pc(||__signbitl||)
	.dwattr $C$DW$1, DW_AT_high_pc(0x00)
	.dwattr $C$DW$1, DW_AT_linkage_name("__signbitl")
	.dwattr $C$DW$1, DW_AT_external
	.dwattr $C$DW$1, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$1, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$1, DW_AT_decl_line(0x16e)
	.dwattr $C$DW$1, DW_AT_decl_column(0x25)
	.dwattr $C$DW$1, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 367,column 1,is_stmt,address ||__signbitl||,isa 0

	.dwfde $C$DW$CIE, ||__signbitl||
$C$DW$2	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$2, DW_AT_name("e")
	.dwattr $C$DW$2, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$2, DW_AT_location[DW_OP_reg12]


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
$C$DW$3	.dwtag  DW_TAG_variable
	.dwattr $C$DW$3, DW_AT_name("e")
	.dwattr $C$DW$3, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$3, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 367,column 3,is_stmt,isa 0
        MOVB      ACC,#0                ; [CPU_ALU] |367| 
        MOVL      *-SP[4],ACC           ; [CPU_ALU] |367| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |367| 
        MOV       *-SP[1],#0            ; [CPU_ALU] |367| 
        MOVL      P,*+XAR4[0]           ; [CPU_ALU] |367| 
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |367| 
        AND       PL,#0                 ; [CPU_ALU] |367| 
        AND       PH,#0                 ; [CPU_ALU] |367| 
        ANDB      AL,#0                 ; [CPU_ALU] |367| 
        AND       AH,#32768             ; [CPU_ALU] |367| 
$C$DW$4	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$4, DW_AT_low_pc(0x00)
	.dwattr $C$DW$4, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$4, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |367| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |367| 
        MOVB      AH,#0                 ; [CPU_ALU] |367| 
        CMPB      AL,#0                 ; [CPU_ALU] |367| 
        MOVB      AH,#1,NEQ             ; [CPU_ALU] |367| 
        MOV       AL,AH                 ; [CPU_ALU] |367| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$5	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$5, DW_AT_low_pc(0x00)
	.dwattr $C$DW$5, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$1, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$1, DW_AT_TI_end_line(0x16f)
	.dwattr $C$DW$1, DW_AT_TI_end_column(0x2b)
	.dwendentry
	.dwendtag $C$DW$1

	.sect	".text:__signbitf"
	.clink
	.global	||__signbitf||

$C$DW$6	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$6, DW_AT_name("__signbitf")
	.dwattr $C$DW$6, DW_AT_low_pc(||__signbitf||)
	.dwattr $C$DW$6, DW_AT_high_pc(0x00)
	.dwattr $C$DW$6, DW_AT_linkage_name("__signbitf")
	.dwattr $C$DW$6, DW_AT_external
	.dwattr $C$DW$6, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$6, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$6, DW_AT_decl_line(0x16c)
	.dwattr $C$DW$6, DW_AT_decl_column(0x25)
	.dwattr $C$DW$6, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 365,column 1,is_stmt,address ||__signbitf||,isa 0

	.dwfde $C$DW$CIE, ||__signbitf||
$C$DW$7	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$7, DW_AT_name("f")
	.dwattr $C$DW$7, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$7, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$8	.dwtag  DW_TAG_variable
	.dwattr $C$DW$8, DW_AT_name("f")
	.dwattr $C$DW$8, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$8, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 365,column 3,is_stmt,isa 0
        MOV32     ACC,R0H               ; [CPU_FPU] |365| 
        MOVB      XAR6,#0               ; [CPU_ALU] |365| 
        ANDB      AL,#0                 ; [CPU_ALU] |365| 
        AND       AH,#32768             ; [CPU_ALU] |365| 
        TEST      ACC                   ; [CPU_ALU] |365| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |365| 
        MOV       AL,AR6                ; [CPU_ALU] |365| 
$C$DW$9	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$9, DW_AT_low_pc(0x00)
	.dwattr $C$DW$9, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$6, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$6, DW_AT_TI_end_line(0x16d)
	.dwattr $C$DW$6, DW_AT_TI_end_column(0x29)
	.dwendentry
	.dwendtag $C$DW$6

	.sect	".text:__signbit"
	.clink
	.global	||__signbit||

$C$DW$10	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$10, DW_AT_name("__signbit")
	.dwattr $C$DW$10, DW_AT_low_pc(||__signbit||)
	.dwattr $C$DW$10, DW_AT_high_pc(0x00)
	.dwattr $C$DW$10, DW_AT_linkage_name("__signbit")
	.dwattr $C$DW$10, DW_AT_external
	.dwattr $C$DW$10, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$10, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$10, DW_AT_decl_line(0x16a)
	.dwattr $C$DW$10, DW_AT_decl_column(0x25)
	.dwattr $C$DW$10, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 363,column 1,is_stmt,address ||__signbit||,isa 0

	.dwfde $C$DW$CIE, ||__signbit||
$C$DW$11	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$11, DW_AT_name("d")
	.dwattr $C$DW$11, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$11, DW_AT_location[DW_OP_reg12]


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
$C$DW$12	.dwtag  DW_TAG_variable
	.dwattr $C$DW$12, DW_AT_name("d")
	.dwattr $C$DW$12, DW_AT_type(*$C$DW$T$45)
	.dwattr $C$DW$12, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 363,column 3,is_stmt,isa 0
        MOVB      ACC,#0                ; [CPU_ALU] |363| 
        MOVL      *-SP[4],ACC           ; [CPU_ALU] |363| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |363| 
        MOV       *-SP[1],#0            ; [CPU_ALU] |363| 
        MOVL      P,*+XAR4[0]           ; [CPU_ALU] |363| 
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |363| 
        AND       PL,#0                 ; [CPU_ALU] |363| 
        AND       PH,#0                 ; [CPU_ALU] |363| 
        ANDB      AL,#0                 ; [CPU_ALU] |363| 
        AND       AH,#32768             ; [CPU_ALU] |363| 
$C$DW$13	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$13, DW_AT_low_pc(0x00)
	.dwattr $C$DW$13, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$13, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |363| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |363| 
        MOVB      AH,#0                 ; [CPU_ALU] |363| 
        CMPB      AL,#0                 ; [CPU_ALU] |363| 
        MOVB      AH,#1,NEQ             ; [CPU_ALU] |363| 
        MOV       AL,AH                 ; [CPU_ALU] |363| 
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$14	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$14, DW_AT_low_pc(0x00)
	.dwattr $C$DW$14, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$10, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$10, DW_AT_TI_end_line(0x16b)
	.dwattr $C$DW$10, DW_AT_TI_end_column(0x2a)
	.dwendentry
	.dwendtag $C$DW$10

	.sect	".text:__relaxed_sqrtf"
	.clink
	.global	||__relaxed_sqrtf||

$C$DW$15	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$15, DW_AT_name("__relaxed_sqrtf")
	.dwattr $C$DW$15, DW_AT_low_pc(||__relaxed_sqrtf||)
	.dwattr $C$DW$15, DW_AT_high_pc(0x00)
	.dwattr $C$DW$15, DW_AT_linkage_name("__relaxed_sqrtf")
	.dwattr $C$DW$15, DW_AT_external
	.dwattr $C$DW$15, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$15, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h")
	.dwattr $C$DW$15, DW_AT_decl_line(0xe3)
	.dwattr $C$DW$15, DW_AT_decl_column(0x10)
	.dwattr $C$DW$15, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h",line 228,column 1,is_stmt,address ||__relaxed_sqrtf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_sqrtf||
$C$DW$16	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$16, DW_AT_name("x")
	.dwattr $C$DW$16, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$16, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$17	.dwtag  DW_TAG_variable
	.dwattr $C$DW$17, DW_AT_name("x")
	.dwattr $C$DW$17, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$17, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h",line 229,column 5,is_stmt,isa 0
        SQRTF32   R0H,R0H               ; [CPU_FPU] |229| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$18	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$18, DW_AT_low_pc(0x00)
	.dwattr $C$DW$18, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$15, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h")
	.dwattr $C$DW$15, DW_AT_TI_end_line(0xe6)
	.dwattr $C$DW$15, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$15

	.sect	".text:__relaxed_sinf"
	.clink
	.global	||__relaxed_sinf||

$C$DW$19	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$19, DW_AT_name("__relaxed_sinf")
	.dwattr $C$DW$19, DW_AT_low_pc(||__relaxed_sinf||)
	.dwattr $C$DW$19, DW_AT_high_pc(0x00)
	.dwattr $C$DW$19, DW_AT_linkage_name("__relaxed_sinf")
	.dwattr $C$DW$19, DW_AT_external
	.dwattr $C$DW$19, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$19, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h")
	.dwattr $C$DW$19, DW_AT_decl_line(0xe8)
	.dwattr $C$DW$19, DW_AT_decl_column(0x10)
	.dwattr $C$DW$19, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h",line 233,column 1,is_stmt,address ||__relaxed_sinf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_sinf||
$C$DW$20	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$20, DW_AT_name("x")
	.dwattr $C$DW$20, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$20, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$21	.dwtag  DW_TAG_variable
	.dwattr $C$DW$21, DW_AT_name("x")
	.dwattr $C$DW$21, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$21, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h",line 234,column 5,is_stmt,isa 0
        DIV2PIF32 R0H,R0H               ; [CPU_FPU] |234| 
        NOP       ; [CPU_ALU] 
        SINPUF32  R0H,R0H               ; [CPU_FPU] |234| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$22	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$22, DW_AT_low_pc(0x00)
	.dwattr $C$DW$22, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$19, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h")
	.dwattr $C$DW$19, DW_AT_TI_end_line(0xeb)
	.dwattr $C$DW$19, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$19

	.sect	".text:__relaxed_cosf"
	.clink
	.global	||__relaxed_cosf||

$C$DW$23	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$23, DW_AT_name("__relaxed_cosf")
	.dwattr $C$DW$23, DW_AT_low_pc(||__relaxed_cosf||)
	.dwattr $C$DW$23, DW_AT_high_pc(0x00)
	.dwattr $C$DW$23, DW_AT_linkage_name("__relaxed_cosf")
	.dwattr $C$DW$23, DW_AT_external
	.dwattr $C$DW$23, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$23, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h")
	.dwattr $C$DW$23, DW_AT_decl_line(0xed)
	.dwattr $C$DW$23, DW_AT_decl_column(0x10)
	.dwattr $C$DW$23, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h",line 238,column 1,is_stmt,address ||__relaxed_cosf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_cosf||
$C$DW$24	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$24, DW_AT_name("x")
	.dwattr $C$DW$24, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$24, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$25	.dwtag  DW_TAG_variable
	.dwattr $C$DW$25, DW_AT_name("x")
	.dwattr $C$DW$25, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$25, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h",line 239,column 5,is_stmt,isa 0
        DIV2PIF32 R0H,R0H               ; [CPU_FPU] |239| 
        NOP       ; [CPU_ALU] 
        COSPUF32  R0H,R0H               ; [CPU_FPU] |239| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
$C$DW$26	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$26, DW_AT_low_pc(0x00)
	.dwattr $C$DW$26, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$23, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h")
	.dwattr $C$DW$23, DW_AT_TI_end_line(0xf0)
	.dwattr $C$DW$23, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$23

	.sect	".text:__relaxed_atanf"
	.clink
	.global	||__relaxed_atanf||

$C$DW$27	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$27, DW_AT_name("__relaxed_atanf")
	.dwattr $C$DW$27, DW_AT_low_pc(||__relaxed_atanf||)
	.dwattr $C$DW$27, DW_AT_high_pc(0x00)
	.dwattr $C$DW$27, DW_AT_linkage_name("__relaxed_atanf")
	.dwattr $C$DW$27, DW_AT_external
	.dwattr $C$DW$27, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$27, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h")
	.dwattr $C$DW$27, DW_AT_decl_line(0xf2)
	.dwattr $C$DW$27, DW_AT_decl_column(0x10)
	.dwattr $C$DW$27, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h",line 243,column 1,is_stmt,address ||__relaxed_atanf||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_atanf||
$C$DW$28	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$28, DW_AT_name("x")
	.dwattr $C$DW$28, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$28, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$29	.dwtag  DW_TAG_variable
	.dwattr $C$DW$29, DW_AT_name("x")
	.dwattr $C$DW$29, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$29, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h",line 244,column 3,is_stmt,isa 0
        MOVIZ     R1H,#16256            ; [CPU_FPU] |244| 
        QUADF32   R1H,R0H,R0H,R1H       ; [CPU_FPU] |244| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        ATANPUF32 R0H,R0H               ; [CPU_FPU] |244| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        ADDF32    R0H,R0H,R1H           ; [CPU_FPU] |244| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MPY2PIF32 R0H,R0H               ; [CPU_FPU] |244| 
        NOP       ; [CPU_ALU] 
$C$DW$30	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$30, DW_AT_low_pc(0x00)
	.dwattr $C$DW$30, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$27, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h")
	.dwattr $C$DW$27, DW_AT_TI_end_line(0xf5)
	.dwattr $C$DW$27, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$27

	.sect	".text:__relaxed_atan2f"
	.clink
	.global	||__relaxed_atan2f||

$C$DW$31	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$31, DW_AT_name("__relaxed_atan2f")
	.dwattr $C$DW$31, DW_AT_low_pc(||__relaxed_atan2f||)
	.dwattr $C$DW$31, DW_AT_high_pc(0x00)
	.dwattr $C$DW$31, DW_AT_linkage_name("__relaxed_atan2f")
	.dwattr $C$DW$31, DW_AT_external
	.dwattr $C$DW$31, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$31, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h")
	.dwattr $C$DW$31, DW_AT_decl_line(0xf7)
	.dwattr $C$DW$31, DW_AT_decl_column(0x10)
	.dwattr $C$DW$31, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h",line 248,column 1,is_stmt,address ||__relaxed_atan2f||,isa 0

	.dwfde $C$DW$CIE, ||__relaxed_atan2f||
$C$DW$32	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$32, DW_AT_name("y")
	.dwattr $C$DW$32, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$32, DW_AT_location[DW_OP_regx 0x2b]

$C$DW$33	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$33, DW_AT_name("x")
	.dwattr $C$DW$33, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$33, DW_AT_location[DW_OP_regx 0x2f]


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
$C$DW$34	.dwtag  DW_TAG_variable
	.dwattr $C$DW$34, DW_AT_name("y")
	.dwattr $C$DW$34, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$34, DW_AT_location[DW_OP_regx 0x2b]

;* R1    assigned to x
$C$DW$35	.dwtag  DW_TAG_variable
	.dwattr $C$DW$35, DW_AT_name("x")
	.dwattr $C$DW$35, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$35, DW_AT_location[DW_OP_regx 0x2f]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h",line 249,column 3,is_stmt,isa 0
        QUADF32   R1H,R0H,R0H,R1H       ; [CPU_FPU] |249| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        ATANPUF32 R0H,R0H               ; [CPU_FPU] |249| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        ADDF32    R0H,R0H,R1H           ; [CPU_FPU] |249| 
        NOP       ; [CPU_ALU] 
        NOP       ; [CPU_ALU] 
        MPY2PIF32 R0H,R0H               ; [CPU_FPU] |249| 
        NOP       ; [CPU_ALU] 
$C$DW$36	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$36, DW_AT_low_pc(0x00)
	.dwattr $C$DW$36, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$31, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/math.h")
	.dwattr $C$DW$31, DW_AT_TI_end_line(0xfa)
	.dwattr $C$DW$31, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$31

	.sect	".text:__isnormall"
	.clink
	.global	||__isnormall||

$C$DW$37	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$37, DW_AT_name("__isnormall")
	.dwattr $C$DW$37, DW_AT_low_pc(||__isnormall||)
	.dwattr $C$DW$37, DW_AT_high_pc(0x00)
	.dwattr $C$DW$37, DW_AT_linkage_name("__isnormall")
	.dwattr $C$DW$37, DW_AT_external
	.dwattr $C$DW$37, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$37, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$37, DW_AT_decl_line(0x166)
	.dwattr $C$DW$37, DW_AT_decl_column(0x25)
	.dwattr $C$DW$37, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 359,column 1,is_stmt,address ||__isnormall||,isa 0

	.dwfde $C$DW$CIE, ||__isnormall||
$C$DW$38	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$38, DW_AT_name("e")
	.dwattr $C$DW$38, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$38, DW_AT_location[DW_OP_reg12]


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
$C$DW$39	.dwtag  DW_TAG_variable
	.dwattr $C$DW$39, DW_AT_name("e")
	.dwattr $C$DW$39, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$39, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 359,column 3,is_stmt,isa 0
        MOVL      XAR5,*+XAR4[0]        ; [CPU_ALU] |359| 
        MOVL      XAR4,*+XAR4[2]        ; [CPU_ALU] |359| 
        MOVB      XAR6,#0               ; [CPU_ALU] |359| 
        MOV       T,#52                 ; [CPU_ALU] |359| 
        MOVL      P,XAR5                ; [CPU_ALU] |359| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |359| 
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |359| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |359| 
        LSR64     ACC:P,T               ; [CPU_ALU] |359| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |359| 
        ANDB      AL,#0                 ; [CPU_ALU] |359| 
        ANDB      AH,#0                 ; [CPU_ALU] |359| 
        AND       PL,#2047              ; [CPU_ALU] |359| 
        AND       PH,#0                 ; [CPU_ALU] |359| 
$C$DW$40	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$40, DW_AT_low_pc(0x00)
	.dwattr $C$DW$40, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$40, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |359| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |359| 
        MOVB      XAR6,#0               ; [CPU_ALU] |359| 
        CMPB      AL,#0                 ; [CPU_ALU] |359| 
        B         ||$C$L1||,EQ          ; [CPU_ALU] |359| 
        ; branchcc occurs ; [] |359| 
        MOVL      P,XAR5                ; [CPU_ALU] |359| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |359| 
        MOV       T,#48                 ; [CPU_ALU] |359| 
        LSR64     ACC:P,T               ; [CPU_ALU] |359| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |359| 
        MOVZ      AR7,PL                ; [CPU_ALU] |359| 
        MOVL      XAR4,#32752           ; [CPU_ARAU] |359| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |359| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |359| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |359| 
||$C$L1||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR6                ; [CPU_ALU] |359| 
$C$DW$41	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$41, DW_AT_low_pc(0x00)
	.dwattr $C$DW$41, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$37, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$37, DW_AT_TI_end_line(0x168)
	.dwattr $C$DW$37, DW_AT_TI_end_column(0x31)
	.dwendentry
	.dwendtag $C$DW$37

	.sect	".text:__isnormalf"
	.clink
	.global	||__isnormalf||

$C$DW$42	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$42, DW_AT_name("__isnormalf")
	.dwattr $C$DW$42, DW_AT_low_pc(||__isnormalf||)
	.dwattr $C$DW$42, DW_AT_high_pc(0x00)
	.dwattr $C$DW$42, DW_AT_linkage_name("__isnormalf")
	.dwattr $C$DW$42, DW_AT_external
	.dwattr $C$DW$42, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$42, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$42, DW_AT_decl_line(0x162)
	.dwattr $C$DW$42, DW_AT_decl_column(0x25)
	.dwattr $C$DW$42, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 355,column 1,is_stmt,address ||__isnormalf||,isa 0

	.dwfde $C$DW$CIE, ||__isnormalf||
$C$DW$43	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$43, DW_AT_name("f")
	.dwattr $C$DW$43, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$43, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$44	.dwtag  DW_TAG_variable
	.dwattr $C$DW$44, DW_AT_name("f")
	.dwattr $C$DW$44, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$44, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 355,column 3,is_stmt,isa 0
        MOV32     P,R0H                 ; [CPU_FPU] |355| 
        MOV       T,#23                 ; [CPU_ALU] |355| 
        MOVL      ACC,P                 ; [CPU_ALU] |355| 
        MOVB      XAR6,#0               ; [CPU_ALU] |355| 
        LSRL      ACC,T                 ; [CPU_ALU] |355| 
        ANDB      AL,#0xff              ; [CPU_ALU] |355| 
        B         ||$C$L2||,EQ          ; [CPU_ALU] |355| 
        ; branchcc occurs ; [] |355| 
        AND       AL,PH,#0x7f80         ; [CPU_ALU] |355| 
        MOVZ      AR7,AL                ; [CPU_ALU] |355| 
        MOVL      XAR4,#32640           ; [CPU_ARAU] |355| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |355| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |355| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |355| 
||$C$L2||:    
        MOV       AL,AR6                ; [CPU_ALU] |355| 
$C$DW$45	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$45, DW_AT_low_pc(0x00)
	.dwattr $C$DW$45, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$42, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$42, DW_AT_TI_end_line(0x164)
	.dwattr $C$DW$42, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$42

	.sect	".text:__isnormal"
	.clink
	.global	||__isnormal||

$C$DW$46	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$46, DW_AT_name("__isnormal")
	.dwattr $C$DW$46, DW_AT_low_pc(||__isnormal||)
	.dwattr $C$DW$46, DW_AT_high_pc(0x00)
	.dwattr $C$DW$46, DW_AT_linkage_name("__isnormal")
	.dwattr $C$DW$46, DW_AT_external
	.dwattr $C$DW$46, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$46, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$46, DW_AT_decl_line(0x15e)
	.dwattr $C$DW$46, DW_AT_decl_column(0x25)
	.dwattr $C$DW$46, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 351,column 1,is_stmt,address ||__isnormal||,isa 0

	.dwfde $C$DW$CIE, ||__isnormal||
$C$DW$47	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$47, DW_AT_name("d")
	.dwattr $C$DW$47, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$47, DW_AT_location[DW_OP_reg12]


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
$C$DW$48	.dwtag  DW_TAG_variable
	.dwattr $C$DW$48, DW_AT_name("d")
	.dwattr $C$DW$48, DW_AT_type(*$C$DW$T$45)
	.dwattr $C$DW$48, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 351,column 3,is_stmt,isa 0
        MOVL      XAR5,*+XAR4[0]        ; [CPU_ALU] |351| 
        MOVL      XAR4,*+XAR4[2]        ; [CPU_ALU] |351| 
        MOVB      XAR6,#0               ; [CPU_ALU] |351| 
        MOV       T,#52                 ; [CPU_ALU] |351| 
        MOVL      P,XAR5                ; [CPU_ALU] |351| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |351| 
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |351| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |351| 
        LSR64     ACC:P,T               ; [CPU_ALU] |351| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |351| 
        ANDB      AL,#0                 ; [CPU_ALU] |351| 
        ANDB      AH,#0                 ; [CPU_ALU] |351| 
        AND       PL,#2047              ; [CPU_ALU] |351| 
        AND       PH,#0                 ; [CPU_ALU] |351| 
$C$DW$49	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$49, DW_AT_low_pc(0x00)
	.dwattr $C$DW$49, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$49, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |351| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |351| 
        MOVB      XAR6,#0               ; [CPU_ALU] |351| 
        CMPB      AL,#0                 ; [CPU_ALU] |351| 
        B         ||$C$L3||,EQ          ; [CPU_ALU] |351| 
        ; branchcc occurs ; [] |351| 
        MOVL      P,XAR5                ; [CPU_ALU] |351| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |351| 
        MOV       T,#48                 ; [CPU_ALU] |351| 
        LSR64     ACC:P,T               ; [CPU_ALU] |351| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |351| 
        MOVZ      AR7,PL                ; [CPU_ALU] |351| 
        MOVL      XAR4,#32752           ; [CPU_ARAU] |351| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |351| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |351| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |351| 
||$C$L3||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR6                ; [CPU_ALU] |351| 
$C$DW$50	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$50, DW_AT_low_pc(0x00)
	.dwattr $C$DW$50, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$46, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$46, DW_AT_TI_end_line(0x160)
	.dwattr $C$DW$46, DW_AT_TI_end_column(0x30)
	.dwendentry
	.dwendtag $C$DW$46

	.sect	".text:__isnanl"
	.clink
	.global	||__isnanl||

$C$DW$51	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$51, DW_AT_name("__isnanl")
	.dwattr $C$DW$51, DW_AT_low_pc(||__isnanl||)
	.dwattr $C$DW$51, DW_AT_high_pc(0x00)
	.dwattr $C$DW$51, DW_AT_linkage_name("__isnanl")
	.dwattr $C$DW$51, DW_AT_external
	.dwattr $C$DW$51, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$51, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$51, DW_AT_decl_line(0x15a)
	.dwattr $C$DW$51, DW_AT_decl_column(0x25)
	.dwattr $C$DW$51, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 347,column 1,is_stmt,address ||__isnanl||,isa 0

	.dwfde $C$DW$CIE, ||__isnanl||
$C$DW$52	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$52, DW_AT_name("e")
	.dwattr $C$DW$52, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$52, DW_AT_location[DW_OP_reg12]


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
$C$DW$53	.dwtag  DW_TAG_variable
	.dwattr $C$DW$53, DW_AT_name("e")
	.dwattr $C$DW$53, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$53, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 347,column 3,is_stmt,isa 0
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |347| 
        MOVL      XAR7,*+XAR4[0]        ; [CPU_ALU] |347| 
        MOV       T,#48                 ; [CPU_ALU] |347| 
        MOVL      XAR5,#32752           ; [CPU_ARAU] |347| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |347| 
        MOVL      P,XAR7                ; [CPU_ALU] |347| 
        MOVB      XAR4,#0               ; [CPU_ALU] |347| 
        LSR64     ACC:P,T               ; [CPU_ALU] |347| 
        MOV       PH,#0                 ; [CPU_ALU] |347| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |347| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |347| 
        CMPL      ACC,P                 ; [CPU_ALU] |347| 
        B         ||$C$L4||,NEQ         ; [CPU_ALU] |347| 
        ; branchcc occurs ; [] |347| 
        MOVL      ACC,XAR6              ; [CPU_ALU] |347| 
        MOVL      P,XAR7                ; [CPU_ALU] |347| 
        MOVB      XAR6,#0               ; [CPU_ALU] |347| 
        AND       AL,#65535             ; [CPU_ALU] |347| 
        ANDB      AH,#15                ; [CPU_ALU] |347| 
        AND       PL,#65535             ; [CPU_ALU] |347| 
        AND       PH,#65535             ; [CPU_ALU] |347| 
        MOVL      *-SP[4],XAR6          ; [CPU_FPU] |347| 
        MOV       *-SP[2],#0            ; [CPU_FPU] |347| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |347| 
$C$DW$54	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$54, DW_AT_low_pc(0x00)
	.dwattr $C$DW$54, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$54, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |347| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |347| 
        CMPB      AL,#0                 ; [CPU_ALU] |347| 
        MOVB      XAR4,#1,NEQ           ; [CPU_ALU] |347| 
||$C$L4||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |347| 
$C$DW$55	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$55, DW_AT_low_pc(0x00)
	.dwattr $C$DW$55, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$51, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$51, DW_AT_TI_end_line(0x15c)
	.dwattr $C$DW$51, DW_AT_TI_end_column(0x30)
	.dwendentry
	.dwendtag $C$DW$51

	.sect	".text:__isnanf"
	.clink
	.global	||__isnanf||

$C$DW$56	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$56, DW_AT_name("__isnanf")
	.dwattr $C$DW$56, DW_AT_low_pc(||__isnanf||)
	.dwattr $C$DW$56, DW_AT_high_pc(0x00)
	.dwattr $C$DW$56, DW_AT_linkage_name("__isnanf")
	.dwattr $C$DW$56, DW_AT_external
	.dwattr $C$DW$56, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$56, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$56, DW_AT_decl_line(0x157)
	.dwattr $C$DW$56, DW_AT_decl_column(0x25)
	.dwattr $C$DW$56, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 344,column 1,is_stmt,address ||__isnanf||,isa 0

	.dwfde $C$DW$CIE, ||__isnanf||
$C$DW$57	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$57, DW_AT_name("f")
	.dwattr $C$DW$57, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$57, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$58	.dwtag  DW_TAG_variable
	.dwattr $C$DW$58, DW_AT_name("f")
	.dwattr $C$DW$58, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$58, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 344,column 3,is_stmt,isa 0
        MOV32     P,R0H                 ; [CPU_FPU] |344| 
        AND       AL,PH,#0x7f80         ; [CPU_ALU] |344| 
        MOVZ      AR7,AL                ; [CPU_ALU] |344| 
        MOVL      XAR4,#32640           ; [CPU_ARAU] |344| 
        MOVB      XAR6,#0               ; [CPU_ALU] |344| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |344| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |344| 
        B         ||$C$L5||,NEQ         ; [CPU_ALU] |344| 
        ; branchcc occurs ; [] |344| 
        MOVL      ACC,P                 ; [CPU_ALU] |344| 
        ANDB      AH,#127               ; [CPU_ALU] |344| 
        TEST      ACC                   ; [CPU_ALU] |344| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |344| 
||$C$L5||:    
        MOV       AL,AR6                ; [CPU_ALU] |344| 
$C$DW$59	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$59, DW_AT_low_pc(0x00)
	.dwattr $C$DW$59, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$56, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$56, DW_AT_TI_end_line(0x159)
	.dwattr $C$DW$56, DW_AT_TI_end_column(0x2e)
	.dwendentry
	.dwendtag $C$DW$56

	.sect	".text:__isnan"
	.clink
	.global	||__isnan||

$C$DW$60	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$60, DW_AT_name("__isnan")
	.dwattr $C$DW$60, DW_AT_low_pc(||__isnan||)
	.dwattr $C$DW$60, DW_AT_high_pc(0x00)
	.dwattr $C$DW$60, DW_AT_linkage_name("__isnan")
	.dwattr $C$DW$60, DW_AT_external
	.dwattr $C$DW$60, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$60, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$60, DW_AT_decl_line(0x154)
	.dwattr $C$DW$60, DW_AT_decl_column(0x25)
	.dwattr $C$DW$60, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 341,column 1,is_stmt,address ||__isnan||,isa 0

	.dwfde $C$DW$CIE, ||__isnan||
$C$DW$61	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$61, DW_AT_name("d")
	.dwattr $C$DW$61, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$61, DW_AT_location[DW_OP_reg12]


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
$C$DW$62	.dwtag  DW_TAG_variable
	.dwattr $C$DW$62, DW_AT_name("d")
	.dwattr $C$DW$62, DW_AT_type(*$C$DW$T$45)
	.dwattr $C$DW$62, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 341,column 3,is_stmt,isa 0
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |341| 
        MOVL      XAR7,*+XAR4[0]        ; [CPU_ALU] |341| 
        MOV       T,#48                 ; [CPU_ALU] |341| 
        MOVL      XAR5,#32752           ; [CPU_ARAU] |341| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |341| 
        MOVL      P,XAR7                ; [CPU_ALU] |341| 
        MOVB      XAR4,#0               ; [CPU_ALU] |341| 
        LSR64     ACC:P,T               ; [CPU_ALU] |341| 
        MOV       PH,#0                 ; [CPU_ALU] |341| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |341| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |341| 
        CMPL      ACC,P                 ; [CPU_ALU] |341| 
        B         ||$C$L6||,NEQ         ; [CPU_ALU] |341| 
        ; branchcc occurs ; [] |341| 
        MOVL      ACC,XAR6              ; [CPU_ALU] |341| 
        MOVL      P,XAR7                ; [CPU_ALU] |341| 
        MOVB      XAR6,#0               ; [CPU_ALU] |341| 
        AND       AL,#65535             ; [CPU_ALU] |341| 
        ANDB      AH,#15                ; [CPU_ALU] |341| 
        AND       PL,#65535             ; [CPU_ALU] |341| 
        AND       PH,#65535             ; [CPU_ALU] |341| 
        MOVL      *-SP[4],XAR6          ; [CPU_FPU] |341| 
        MOV       *-SP[2],#0            ; [CPU_FPU] |341| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |341| 
$C$DW$63	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$63, DW_AT_low_pc(0x00)
	.dwattr $C$DW$63, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$63, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |341| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |341| 
        CMPB      AL,#0                 ; [CPU_ALU] |341| 
        MOVB      XAR4,#1,NEQ           ; [CPU_ALU] |341| 
||$C$L6||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |341| 
$C$DW$64	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$64, DW_AT_low_pc(0x00)
	.dwattr $C$DW$64, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$60, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$60, DW_AT_TI_end_line(0x156)
	.dwattr $C$DW$60, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$60

	.sect	".text:__isinfl"
	.clink
	.global	||__isinfl||

$C$DW$65	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$65, DW_AT_name("__isinfl")
	.dwattr $C$DW$65, DW_AT_low_pc(||__isinfl||)
	.dwattr $C$DW$65, DW_AT_high_pc(0x00)
	.dwattr $C$DW$65, DW_AT_linkage_name("__isinfl")
	.dwattr $C$DW$65, DW_AT_external
	.dwattr $C$DW$65, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$65, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$65, DW_AT_decl_line(0x179)
	.dwattr $C$DW$65, DW_AT_decl_column(0x25)
	.dwattr $C$DW$65, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 378,column 1,is_stmt,address ||__isinfl||,isa 0

	.dwfde $C$DW$CIE, ||__isinfl||
$C$DW$66	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$66, DW_AT_name("e")
	.dwattr $C$DW$66, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$66, DW_AT_location[DW_OP_reg12]


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
$C$DW$67	.dwtag  DW_TAG_variable
	.dwattr $C$DW$67, DW_AT_name("e")
	.dwattr $C$DW$67, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$67, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 378,column 3,is_stmt,isa 0
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |378| 
        MOVL      XAR7,*+XAR4[0]        ; [CPU_ALU] |378| 
        MOV       T,#48                 ; [CPU_ALU] |378| 
        MOVL      XAR5,#32752           ; [CPU_ARAU] |378| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |378| 
        MOVL      P,XAR7                ; [CPU_ALU] |378| 
        MOVB      XAR4,#0               ; [CPU_ALU] |378| 
        LSR64     ACC:P,T               ; [CPU_ALU] |378| 
        MOV       PH,#0                 ; [CPU_ALU] |378| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |378| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |378| 
        CMPL      ACC,P                 ; [CPU_ALU] |378| 
        B         ||$C$L7||,NEQ         ; [CPU_ALU] |378| 
        ; branchcc occurs ; [] |378| 
        MOVL      ACC,XAR6              ; [CPU_ALU] |378| 
        MOVL      P,XAR7                ; [CPU_ALU] |378| 
        MOVB      XAR6,#0               ; [CPU_ALU] |378| 
        AND       AL,#65535             ; [CPU_ALU] |378| 
        ANDB      AH,#15                ; [CPU_ALU] |378| 
        AND       PL,#65535             ; [CPU_ALU] |378| 
        AND       PH,#65535             ; [CPU_ALU] |378| 
        MOVL      *-SP[4],XAR6          ; [CPU_FPU] |378| 
        MOV       *-SP[2],#0            ; [CPU_FPU] |378| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |378| 
$C$DW$68	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$68, DW_AT_low_pc(0x00)
	.dwattr $C$DW$68, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$68, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |378| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |378| 
        CMPB      AL,#0                 ; [CPU_ALU] |378| 
        MOVB      XAR4,#1,EQ            ; [CPU_ALU] |378| 
||$C$L7||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |378| 
$C$DW$69	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$69, DW_AT_low_pc(0x00)
	.dwattr $C$DW$69, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$65, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$65, DW_AT_TI_end_line(0x17a)
	.dwattr $C$DW$65, DW_AT_TI_end_column(0x4c)
	.dwendentry
	.dwendtag $C$DW$65

	.sect	".text:__isinff"
	.clink
	.global	||__isinff||

$C$DW$70	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$70, DW_AT_name("__isinff")
	.dwattr $C$DW$70, DW_AT_low_pc(||__isinff||)
	.dwattr $C$DW$70, DW_AT_high_pc(0x00)
	.dwattr $C$DW$70, DW_AT_linkage_name("__isinff")
	.dwattr $C$DW$70, DW_AT_external
	.dwattr $C$DW$70, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$70, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$70, DW_AT_decl_line(0x175)
	.dwattr $C$DW$70, DW_AT_decl_column(0x25)
	.dwattr $C$DW$70, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 374,column 1,is_stmt,address ||__isinff||,isa 0

	.dwfde $C$DW$CIE, ||__isinff||
$C$DW$71	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$71, DW_AT_name("f")
	.dwattr $C$DW$71, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$71, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$72	.dwtag  DW_TAG_variable
	.dwattr $C$DW$72, DW_AT_name("f")
	.dwattr $C$DW$72, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$72, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 374,column 3,is_stmt,isa 0
        MOV32     P,R0H                 ; [CPU_FPU] |374| 
        AND       AL,PH,#0x7f80         ; [CPU_ALU] |374| 
        MOVZ      AR7,AL                ; [CPU_ALU] |374| 
        MOVL      XAR4,#32640           ; [CPU_ARAU] |374| 
        MOVB      XAR6,#0               ; [CPU_ALU] |374| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |374| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |374| 
        B         ||$C$L8||,NEQ         ; [CPU_ALU] |374| 
        ; branchcc occurs ; [] |374| 
        MOVL      ACC,P                 ; [CPU_ALU] |374| 
        ANDB      AH,#127               ; [CPU_ALU] |374| 
        TEST      ACC                   ; [CPU_ALU] |374| 
        MOVB      XAR6,#1,EQ            ; [CPU_ALU] |374| 
||$C$L8||:    
        MOV       AL,AR6                ; [CPU_ALU] |374| 
$C$DW$73	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$73, DW_AT_low_pc(0x00)
	.dwattr $C$DW$73, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$70, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$70, DW_AT_TI_end_line(0x176)
	.dwattr $C$DW$70, DW_AT_TI_end_column(0x48)
	.dwendentry
	.dwendtag $C$DW$70

	.sect	".text:__isinf"
	.clink
	.global	||__isinf||

$C$DW$74	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$74, DW_AT_name("__isinf")
	.dwattr $C$DW$74, DW_AT_low_pc(||__isinf||)
	.dwattr $C$DW$74, DW_AT_high_pc(0x00)
	.dwattr $C$DW$74, DW_AT_linkage_name("__isinf")
	.dwattr $C$DW$74, DW_AT_external
	.dwattr $C$DW$74, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$74, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$74, DW_AT_decl_line(0x177)
	.dwattr $C$DW$74, DW_AT_decl_column(0x25)
	.dwattr $C$DW$74, DW_AT_TI_max_frame_size(-6)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 376,column 1,is_stmt,address ||__isinf||,isa 0

	.dwfde $C$DW$CIE, ||__isinf||
$C$DW$75	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$75, DW_AT_name("d")
	.dwattr $C$DW$75, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$75, DW_AT_location[DW_OP_reg12]


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
$C$DW$76	.dwtag  DW_TAG_variable
	.dwattr $C$DW$76, DW_AT_name("d")
	.dwattr $C$DW$76, DW_AT_type(*$C$DW$T$45)
	.dwattr $C$DW$76, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -6
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 376,column 3,is_stmt,isa 0
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |376| 
        MOVL      XAR7,*+XAR4[0]        ; [CPU_ALU] |376| 
        MOV       T,#48                 ; [CPU_ALU] |376| 
        MOVL      XAR5,#32752           ; [CPU_ARAU] |376| 
        MOVL      XAR6,ACC              ; [CPU_ALU] |376| 
        MOVL      P,XAR7                ; [CPU_ALU] |376| 
        MOVB      XAR4,#0               ; [CPU_ALU] |376| 
        LSR64     ACC:P,T               ; [CPU_ALU] |376| 
        MOV       PH,#0                 ; [CPU_ALU] |376| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |376| 
        MOVL      ACC,XAR5              ; [CPU_ALU] |376| 
        CMPL      ACC,P                 ; [CPU_ALU] |376| 
        B         ||$C$L9||,NEQ         ; [CPU_ALU] |376| 
        ; branchcc occurs ; [] |376| 
        MOVL      ACC,XAR6              ; [CPU_ALU] |376| 
        MOVL      P,XAR7                ; [CPU_ALU] |376| 
        MOVB      XAR6,#0               ; [CPU_ALU] |376| 
        AND       AL,#65535             ; [CPU_ALU] |376| 
        ANDB      AH,#15                ; [CPU_ALU] |376| 
        AND       PL,#65535             ; [CPU_ALU] |376| 
        AND       PH,#65535             ; [CPU_ALU] |376| 
        MOVL      *-SP[4],XAR6          ; [CPU_FPU] |376| 
        MOV       *-SP[2],#0            ; [CPU_FPU] |376| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |376| 
$C$DW$77	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$77, DW_AT_low_pc(0x00)
	.dwattr $C$DW$77, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$77, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |376| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |376| 
        CMPB      AL,#0                 ; [CPU_ALU] |376| 
        MOVB      XAR4,#1,EQ            ; [CPU_ALU] |376| 
||$C$L9||:    
        SUBB      SP,#4                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
        MOV       AL,AR4                ; [CPU_ALU] |376| 
$C$DW$78	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$78, DW_AT_low_pc(0x00)
	.dwattr $C$DW$78, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$74, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$74, DW_AT_TI_end_line(0x178)
	.dwattr $C$DW$74, DW_AT_TI_end_column(0x4a)
	.dwendentry
	.dwendtag $C$DW$74

	.sect	".text:__isfinitel"
	.clink
	.global	||__isfinitel||

$C$DW$79	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$79, DW_AT_name("__isfinitel")
	.dwattr $C$DW$79, DW_AT_low_pc(||__isfinitel||)
	.dwattr $C$DW$79, DW_AT_high_pc(0x00)
	.dwattr $C$DW$79, DW_AT_linkage_name("__isfinitel")
	.dwattr $C$DW$79, DW_AT_external
	.dwattr $C$DW$79, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$79, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$79, DW_AT_decl_line(0x151)
	.dwattr $C$DW$79, DW_AT_decl_column(0x25)
	.dwattr $C$DW$79, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 338,column 1,is_stmt,address ||__isfinitel||,isa 0

	.dwfde $C$DW$CIE, ||__isfinitel||
$C$DW$80	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$80, DW_AT_name("e")
	.dwattr $C$DW$80, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$80, DW_AT_location[DW_OP_reg12]


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
$C$DW$81	.dwtag  DW_TAG_variable
	.dwattr $C$DW$81, DW_AT_name("e")
	.dwattr $C$DW$81, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$81, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 338,column 3,is_stmt,isa 0
        MOVL      P,*+XAR4[0]           ; [CPU_ALU] |338| 
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |338| 
        MOV       T,#48                 ; [CPU_ALU] |338| 
        LSR64     ACC:P,T               ; [CPU_ALU] |338| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |338| 
        MOVZ      AR7,PL                ; [CPU_ALU] |338| 
        MOVL      XAR4,#32752           ; [CPU_ARAU] |338| 
        MOVB      XAR6,#0               ; [CPU_ALU] |338| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |338| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |338| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |338| 
        MOV       AL,AR6                ; [CPU_ALU] |338| 
$C$DW$82	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$82, DW_AT_low_pc(0x00)
	.dwattr $C$DW$82, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$79, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$79, DW_AT_TI_end_line(0x152)
	.dwattr $C$DW$79, DW_AT_TI_end_column(0x2f)
	.dwendentry
	.dwendtag $C$DW$79

	.sect	".text:__isfinitef"
	.clink
	.global	||__isfinitef||

$C$DW$83	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$83, DW_AT_name("__isfinitef")
	.dwattr $C$DW$83, DW_AT_low_pc(||__isfinitef||)
	.dwattr $C$DW$83, DW_AT_high_pc(0x00)
	.dwattr $C$DW$83, DW_AT_linkage_name("__isfinitef")
	.dwattr $C$DW$83, DW_AT_external
	.dwattr $C$DW$83, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$83, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$83, DW_AT_decl_line(0x14f)
	.dwattr $C$DW$83, DW_AT_decl_column(0x25)
	.dwattr $C$DW$83, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 336,column 1,is_stmt,address ||__isfinitef||,isa 0

	.dwfde $C$DW$CIE, ||__isfinitef||
$C$DW$84	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$84, DW_AT_name("f")
	.dwattr $C$DW$84, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$84, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$85	.dwtag  DW_TAG_variable
	.dwattr $C$DW$85, DW_AT_name("f")
	.dwattr $C$DW$85, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$85, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 336,column 3,is_stmt,isa 0
        MOV32     ACC,R0H               ; [CPU_FPU] |336| 
        AND       AH,#0x7f80            ; [CPU_ALU] |336| 
        MOVZ      AR7,AH                ; [CPU_ALU] |336| 
        MOVL      XAR4,#32640           ; [CPU_ARAU] |336| 
        MOVB      XAR6,#0               ; [CPU_ALU] |336| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |336| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |336| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |336| 
        MOV       AL,AR6                ; [CPU_ALU] |336| 
$C$DW$86	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$86, DW_AT_low_pc(0x00)
	.dwattr $C$DW$86, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$83, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$83, DW_AT_TI_end_line(0x150)
	.dwattr $C$DW$83, DW_AT_TI_end_column(0x2d)
	.dwendentry
	.dwendtag $C$DW$83

	.sect	".text:__isfinite"
	.clink
	.global	||__isfinite||

$C$DW$87	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$87, DW_AT_name("__isfinite")
	.dwattr $C$DW$87, DW_AT_low_pc(||__isfinite||)
	.dwattr $C$DW$87, DW_AT_high_pc(0x00)
	.dwattr $C$DW$87, DW_AT_linkage_name("__isfinite")
	.dwattr $C$DW$87, DW_AT_external
	.dwattr $C$DW$87, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$87, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$87, DW_AT_decl_line(0x14d)
	.dwattr $C$DW$87, DW_AT_decl_column(0x25)
	.dwattr $C$DW$87, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 334,column 1,is_stmt,address ||__isfinite||,isa 0

	.dwfde $C$DW$CIE, ||__isfinite||
$C$DW$88	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$88, DW_AT_name("d")
	.dwattr $C$DW$88, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$88, DW_AT_location[DW_OP_reg12]


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
$C$DW$89	.dwtag  DW_TAG_variable
	.dwattr $C$DW$89, DW_AT_name("d")
	.dwattr $C$DW$89, DW_AT_type(*$C$DW$T$45)
	.dwattr $C$DW$89, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 334,column 3,is_stmt,isa 0
        MOVL      P,*+XAR4[0]           ; [CPU_ALU] |334| 
        MOVL      ACC,*+XAR4[2]         ; [CPU_ALU] |334| 
        MOV       T,#48                 ; [CPU_ALU] |334| 
        LSR64     ACC:P,T               ; [CPU_ALU] |334| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |334| 
        MOVZ      AR7,PL                ; [CPU_ALU] |334| 
        MOVL      XAR4,#32752           ; [CPU_ARAU] |334| 
        MOVB      XAR6,#0               ; [CPU_ALU] |334| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |334| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |334| 
        MOVB      XAR6,#1,NEQ           ; [CPU_ALU] |334| 
        MOV       AL,AR6                ; [CPU_ALU] |334| 
$C$DW$90	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$90, DW_AT_low_pc(0x00)
	.dwattr $C$DW$90, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$87, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$87, DW_AT_TI_end_line(0x14e)
	.dwattr $C$DW$87, DW_AT_TI_end_column(0x2e)
	.dwendentry
	.dwendtag $C$DW$87

	.sect	".text:__fpclassifyl"
	.clink
	.global	||__fpclassifyl||

$C$DW$91	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$91, DW_AT_name("__fpclassifyl")
	.dwattr $C$DW$91, DW_AT_low_pc(||__fpclassifyl||)
	.dwattr $C$DW$91, DW_AT_high_pc(0x00)
	.dwattr $C$DW$91, DW_AT_linkage_name("__fpclassifyl")
	.dwattr $C$DW$91, DW_AT_external
	.dwattr $C$DW$91, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$91, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$91, DW_AT_decl_line(0x1ad)
	.dwattr $C$DW$91, DW_AT_decl_column(0x25)
	.dwattr $C$DW$91, DW_AT_TI_max_frame_size(-10)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 430,column 1,is_stmt,address ||__fpclassifyl||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassifyl||
$C$DW$92	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$92, DW_AT_name("e")
	.dwattr $C$DW$92, DW_AT_type(*$C$DW$T$47)
	.dwattr $C$DW$92, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __fpclassifyl                 FR SIZE:   8           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  4 Auto,  0 SOE     *
;***************************************************************

||__fpclassifyl||:
$C$DW$93	.dwtag  DW_TAG_variable
	.dwattr $C$DW$93, DW_AT_name("e")
	.dwattr $C$DW$93, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$93, DW_AT_location[DW_OP_breg20 -8]

;* AR5   assigned to $O$C1
;* AR4   assigned to e
$C$DW$94	.dwtag  DW_TAG_variable
	.dwattr $C$DW$94, DW_AT_name("e")
	.dwattr $C$DW$94, DW_AT_type(*$C$DW$T$48)
	.dwattr $C$DW$94, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#8                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -10
        MOVL      XAR6,*+XAR4[2]        ; [CPU_ALU] |430| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |430| 
        MOVL      *-SP[8],ACC           ; [CPU_ALU] |430| 
        MOVL      *-SP[6],XAR6          ; [CPU_ALU] |430| 
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 431,column 5,is_stmt,isa 0
        MOVL      XAR5,*-SP[8]          ; [CPU_ALU] |431| 
        MOVL      XAR4,*-SP[6]          ; [CPU_ALU] |431| 
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 435,column 14,is_stmt,isa 0
        MOV       T,#48                 ; [CPU_ALU] |435| 
        MOVL      P,XAR5                ; [CPU_ALU] |435| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |435| 
        LSR64     ACC:P,T               ; [CPU_ALU] |435| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |435| 
        MOVZ      AR7,PL                ; [CPU_ALU] |435| 
        MOVL      XAR6,#32752           ; [CPU_ARAU] |435| 
        MOVL      ACC,XAR6              ; [CPU_ALU] |435| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |435| 
        B         ||$C$L11||,NEQ        ; [CPU_ALU] |435| 
        ; branchcc occurs ; [] |435| 
        MOVB      ACC,#0                ; [CPU_ALU] |435| 
        MOVL      *-SP[4],ACC           ; [CPU_ALU] |435| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |435| 
        MOV       *-SP[1],#0            ; [CPU_ALU] |435| 
        MOVL      P,*-SP[8]             ; [CPU_ALU] |435| 
        MOVL      ACC,*-SP[6]           ; [CPU_ALU] |435| 
        AND       PL,#65535             ; [CPU_ALU] |435| 
        AND       PH,#65535             ; [CPU_ALU] |435| 
        AND       AL,#65535             ; [CPU_ALU] |435| 
        ANDB      AH,#15                ; [CPU_ALU] |435| 
$C$DW$95	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$95, DW_AT_low_pc(0x00)
	.dwattr $C$DW$95, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$95, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |435| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |435| 
        CMPB      AL,#0                 ; [CPU_ALU] |435| 
        B         ||$C$L10||,EQ         ; [CPU_ALU] |435| 
        ; branchcc occurs ; [] |435| 
        MOVB      AL,#2                 ; [CPU_ALU] |435| 
        B         ||$C$L14||,UNC        ; [CPU_ALU] |435| 
        ; branch occurs ; [] |435| 
||$C$L10||:    
        MOVB      AL,#1                 ; [CPU_ALU] |435| 
        B         ||$C$L14||,UNC        ; [CPU_ALU] |435| 
        ; branch occurs ; [] |435| 
||$C$L11||:    
        MOVB      XAR6,#0               ; [CPU_ALU] |435| 
        MOVL      P,XAR5                ; [CPU_ALU] |435| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |435| 
        MOV       T,#52                 ; [CPU_ALU] |435| 
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |435| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |435| 
        LSR64     ACC:P,T               ; [CPU_ALU] |435| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |435| 
        ANDB      AL,#0                 ; [CPU_ALU] |435| 
        ANDB      AH,#0                 ; [CPU_ALU] |435| 
        AND       PL,#2047              ; [CPU_ALU] |435| 
        AND       PH,#0                 ; [CPU_ALU] |435| 
$C$DW$96	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$96, DW_AT_low_pc(0x00)
	.dwattr $C$DW$96, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$96, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |435| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |435| 
        CMPB      AL,#0                 ; [CPU_ALU] |435| 
        B         ||$C$L12||,EQ         ; [CPU_ALU] |435| 
        ; branchcc occurs ; [] |435| 
        MOV       AL,#-1                ; [CPU_ALU] |435| 
        B         ||$C$L14||,UNC        ; [CPU_ALU] |435| 
        ; branch occurs ; [] |435| 
||$C$L12||:    
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |435| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |435| 
        MOVL      P,XAR5                ; [CPU_ALU] |435| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |435| 
        AND       AL,#65535             ; [CPU_ALU] |435| 
        ANDB      AH,#15                ; [CPU_ALU] |435| 
        AND       PL,#65535             ; [CPU_ALU] |435| 
        AND       PH,#65535             ; [CPU_ALU] |435| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |435| 
$C$DW$97	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$97, DW_AT_low_pc(0x00)
	.dwattr $C$DW$97, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$97, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |435| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |435| 
        CMPB      AL,#0                 ; [CPU_ALU] |435| 
        B         ||$C$L13||,EQ         ; [CPU_ALU] |435| 
        ; branchcc occurs ; [] |435| 
        MOV       AL,#-2                ; [CPU_ALU] |435| 
        B         ||$C$L14||,UNC        ; [CPU_ALU] |435| 
        ; branch occurs ; [] |435| 
||$C$L13||:    
        MOVB      AL,#0                 ; [CPU_ALU] |435| 
||$C$L14||:    
        SUBB      SP,#8                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$98	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$98, DW_AT_low_pc(0x00)
	.dwattr $C$DW$98, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$91, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$91, DW_AT_TI_end_line(0x1bc)
	.dwattr $C$DW$91, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$91

	.sect	".text:__fpclassifyf"
	.clink
	.global	||__fpclassifyf||

$C$DW$99	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$99, DW_AT_name("__fpclassifyf")
	.dwattr $C$DW$99, DW_AT_low_pc(||__fpclassifyf||)
	.dwattr $C$DW$99, DW_AT_high_pc(0x00)
	.dwattr $C$DW$99, DW_AT_linkage_name("__fpclassifyf")
	.dwattr $C$DW$99, DW_AT_external
	.dwattr $C$DW$99, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$99, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$99, DW_AT_decl_line(0x18b)
	.dwattr $C$DW$99, DW_AT_decl_column(0x25)
	.dwattr $C$DW$99, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 396,column 1,is_stmt,address ||__fpclassifyf||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassifyf||
$C$DW$100	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$100, DW_AT_name("f")
	.dwattr $C$DW$100, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$100, DW_AT_location[DW_OP_regx 0x2b]


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
$C$DW$101	.dwtag  DW_TAG_variable
	.dwattr $C$DW$101, DW_AT_name("f")
	.dwattr $C$DW$101, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$101, DW_AT_location[DW_OP_regx 0x2b]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 397,column 5,is_stmt,isa 0
        MOV32     P,R0H                 ; [CPU_FPU] |397| 
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 401,column 14,is_stmt,isa 0
        AND       AL,PH,#0x7f80         ; [CPU_ALU] |401| 
        MOVZ      AR6,AL                ; [CPU_ALU] |401| 
        MOVL      XAR4,#32640           ; [CPU_ARAU] |401| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |401| 
        CMPL      ACC,XAR6              ; [CPU_ALU] |401| 
        B         ||$C$L16||,NEQ        ; [CPU_ALU] |401| 
        ; branchcc occurs ; [] |401| 
        MOVL      ACC,P                 ; [CPU_ALU] |401| 
        ANDB      AH,#127               ; [CPU_ALU] |401| 
        TEST      ACC                   ; [CPU_ALU] |401| 
        B         ||$C$L15||,EQ         ; [CPU_ALU] |401| 
        ; branchcc occurs ; [] |401| 
	.dwcfi	remember_state
        MOVB      AL,#2                 ; [CPU_ALU] |401| 
$C$DW$102	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$102, DW_AT_low_pc(0x00)
	.dwattr $C$DW$102, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L15||:    
	.dwcfi	remember_state
        MOVB      AL,#1                 ; [CPU_ALU] |401| 
$C$DW$103	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$103, DW_AT_low_pc(0x00)
	.dwattr $C$DW$103, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L16||:    
        MOVL      ACC,P                 ; [CPU_ALU] |401| 
        MOV       T,#23                 ; [CPU_ALU] |401| 
        LSRL      ACC,T                 ; [CPU_ALU] |401| 
        ANDB      AL,#0xff              ; [CPU_ALU] |401| 
        B         ||$C$L17||,EQ         ; [CPU_ALU] |401| 
        ; branchcc occurs ; [] |401| 
	.dwcfi	remember_state
        MOV       AL,#-1                ; [CPU_ALU] |401| 
$C$DW$104	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$104, DW_AT_low_pc(0x00)
	.dwattr $C$DW$104, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L17||:    
        MOVL      ACC,P                 ; [CPU_ALU] |401| 
        ANDB      AH,#127               ; [CPU_ALU] |401| 
        TEST      ACC                   ; [CPU_ALU] |401| 
        B         ||$C$L18||,EQ         ; [CPU_ALU] |401| 
        ; branchcc occurs ; [] |401| 
	.dwcfi	remember_state
        MOV       AL,#-2                ; [CPU_ALU] |401| 
$C$DW$105	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$105, DW_AT_low_pc(0x00)
	.dwattr $C$DW$105, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwcfi	restore_state
||$C$L18||:    
        MOVB      AL,#0                 ; [CPU_ALU] |401| 
$C$DW$106	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$106, DW_AT_low_pc(0x00)
	.dwattr $C$DW$106, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$99, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$99, DW_AT_TI_end_line(0x19a)
	.dwattr $C$DW$99, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$99

	.sect	".text:__fpclassify"
	.clink
	.global	||__fpclassify||

$C$DW$107	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$107, DW_AT_name("__fpclassify")
	.dwattr $C$DW$107, DW_AT_low_pc(||__fpclassify||)
	.dwattr $C$DW$107, DW_AT_high_pc(0x00)
	.dwattr $C$DW$107, DW_AT_linkage_name("__fpclassify")
	.dwattr $C$DW$107, DW_AT_external
	.dwattr $C$DW$107, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$107, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$107, DW_AT_decl_line(0x19c)
	.dwattr $C$DW$107, DW_AT_decl_column(0x25)
	.dwattr $C$DW$107, DW_AT_TI_max_frame_size(-10)
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 413,column 1,is_stmt,address ||__fpclassify||,isa 0

	.dwfde $C$DW$CIE, ||__fpclassify||
$C$DW$108	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$108, DW_AT_name("d")
	.dwattr $C$DW$108, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$108, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: __fpclassify                  FR SIZE:   8           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            4 Parameter,  4 Auto,  0 SOE     *
;***************************************************************

||__fpclassify||:
$C$DW$109	.dwtag  DW_TAG_variable
	.dwattr $C$DW$109, DW_AT_name("d")
	.dwattr $C$DW$109, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$109, DW_AT_location[DW_OP_breg20 -8]

;* AR5   assigned to $O$C1
;* AR4   assigned to d
$C$DW$110	.dwtag  DW_TAG_variable
	.dwattr $C$DW$110, DW_AT_name("d")
	.dwattr $C$DW$110, DW_AT_type(*$C$DW$T$45)
	.dwattr $C$DW$110, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
        ADDB      SP,#8                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -10
        MOVL      XAR6,*+XAR4[2]        ; [CPU_ALU] |413| 
        MOVL      ACC,*+XAR4[0]         ; [CPU_ALU] |413| 
        MOVL      *-SP[8],ACC           ; [CPU_ALU] |413| 
        MOVL      *-SP[6],XAR6          ; [CPU_ALU] |413| 
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 414,column 5,is_stmt,isa 0
        MOVL      XAR5,*-SP[8]          ; [CPU_ALU] |414| 
        MOVL      XAR4,*-SP[6]          ; [CPU_ALU] |414| 
	.dwpsn	file "C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h",line 418,column 14,is_stmt,isa 0
        MOV       T,#48                 ; [CPU_ALU] |418| 
        MOVL      P,XAR5                ; [CPU_ALU] |418| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |418| 
        LSR64     ACC:P,T               ; [CPU_ALU] |418| 
        AND       PL,#0x7ff0            ; [CPU_ALU] |418| 
        MOVZ      AR7,PL                ; [CPU_ALU] |418| 
        MOVL      XAR6,#32752           ; [CPU_ARAU] |418| 
        MOVL      ACC,XAR6              ; [CPU_ALU] |418| 
        CMPL      ACC,XAR7              ; [CPU_ALU] |418| 
        B         ||$C$L20||,NEQ        ; [CPU_ALU] |418| 
        ; branchcc occurs ; [] |418| 
        MOVB      ACC,#0                ; [CPU_ALU] |418| 
        MOVL      *-SP[4],ACC           ; [CPU_ALU] |418| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |418| 
        MOV       *-SP[1],#0            ; [CPU_ALU] |418| 
        MOVL      P,*-SP[8]             ; [CPU_ALU] |418| 
        MOVL      ACC,*-SP[6]           ; [CPU_ALU] |418| 
        AND       PL,#65535             ; [CPU_ALU] |418| 
        AND       PH,#65535             ; [CPU_ALU] |418| 
        AND       AL,#65535             ; [CPU_ALU] |418| 
        ANDB      AH,#15                ; [CPU_ALU] |418| 
$C$DW$111	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$111, DW_AT_low_pc(0x00)
	.dwattr $C$DW$111, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$111, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |418| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |418| 
        CMPB      AL,#0                 ; [CPU_ALU] |418| 
        B         ||$C$L19||,EQ         ; [CPU_ALU] |418| 
        ; branchcc occurs ; [] |418| 
        MOVB      AL,#2                 ; [CPU_ALU] |418| 
        B         ||$C$L23||,UNC        ; [CPU_ALU] |418| 
        ; branch occurs ; [] |418| 
||$C$L19||:    
        MOVB      AL,#1                 ; [CPU_ALU] |418| 
        B         ||$C$L23||,UNC        ; [CPU_ALU] |418| 
        ; branch occurs ; [] |418| 
||$C$L20||:    
        MOVB      XAR6,#0               ; [CPU_ALU] |418| 
        MOVL      P,XAR5                ; [CPU_ALU] |418| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |418| 
        MOV       T,#52                 ; [CPU_ALU] |418| 
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |418| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |418| 
        LSR64     ACC:P,T               ; [CPU_ALU] |418| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |418| 
        ANDB      AL,#0                 ; [CPU_ALU] |418| 
        ANDB      AH,#0                 ; [CPU_ALU] |418| 
        AND       PL,#2047              ; [CPU_ALU] |418| 
        AND       PH,#0                 ; [CPU_ALU] |418| 
$C$DW$112	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$112, DW_AT_low_pc(0x00)
	.dwattr $C$DW$112, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$112, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |418| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |418| 
        CMPB      AL,#0                 ; [CPU_ALU] |418| 
        B         ||$C$L21||,EQ         ; [CPU_ALU] |418| 
        ; branchcc occurs ; [] |418| 
        MOV       AL,#-1                ; [CPU_ALU] |418| 
        B         ||$C$L23||,UNC        ; [CPU_ALU] |418| 
        ; branch occurs ; [] |418| 
||$C$L21||:    
        MOVL      *-SP[4],XAR6          ; [CPU_ALU] |418| 
        MOVL      ACC,XAR4              ; [CPU_ALU] |418| 
        MOVL      P,XAR5                ; [CPU_ALU] |418| 
        MOV       *-SP[2],#0            ; [CPU_ALU] |418| 
        AND       AL,#65535             ; [CPU_ALU] |418| 
        ANDB      AH,#15                ; [CPU_ALU] |418| 
        AND       PL,#65535             ; [CPU_ALU] |418| 
        AND       PH,#65535             ; [CPU_ALU] |418| 
        MOV       *-SP[1],#0            ; [CPU_FPU] |418| 
$C$DW$113	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$113, DW_AT_low_pc(0x00)
	.dwattr $C$DW$113, DW_AT_name("__c28xabi_cmpull")
	.dwattr $C$DW$113, DW_AT_TI_call

        LCR       #||__c28xabi_cmpull|| ; [CPU_ALU] |418| 
        ; call occurs [#||__c28xabi_cmpull||] ; [] |418| 
        CMPB      AL,#0                 ; [CPU_ALU] |418| 
        B         ||$C$L22||,EQ         ; [CPU_ALU] |418| 
        ; branchcc occurs ; [] |418| 
        MOV       AL,#-2                ; [CPU_ALU] |418| 
        B         ||$C$L23||,UNC        ; [CPU_ALU] |418| 
        ; branch occurs ; [] |418| 
||$C$L22||:    
        MOVB      AL,#0                 ; [CPU_ALU] |418| 
||$C$L23||:    
        SUBB      SP,#8                 ; [CPU_ARAU] 
	.dwcfi	cfa_offset, -2
$C$DW$114	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$114, DW_AT_low_pc(0x00)
	.dwattr $C$DW$114, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$107, DW_AT_TI_end_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/_defs.h")
	.dwattr $C$DW$107, DW_AT_TI_end_line(0x1ab)
	.dwattr $C$DW$107, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$107

	.sect	".text"
	.clink
	.global	||DCL_runErrorHandler||

$C$DW$115	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$115, DW_AT_name("DCL_runErrorHandler")
	.dwattr $C$DW$115, DW_AT_low_pc(||DCL_runErrorHandler||)
	.dwattr $C$DW$115, DW_AT_high_pc(0x00)
	.dwattr $C$DW$115, DW_AT_linkage_name("DCL_runErrorHandler")
	.dwattr $C$DW$115, DW_AT_external
	.dwattr $C$DW$115, DW_AT_decl_file("../libraries/DCL/DCL_error.c")
	.dwattr $C$DW$115, DW_AT_decl_line(0x05)
	.dwattr $C$DW$115, DW_AT_decl_column(0x06)
	.dwattr $C$DW$115, DW_AT_TI_max_frame_size(-2)
	.dwpsn	file "../libraries/DCL/DCL_error.c",line 6,column 1,is_stmt,address ||DCL_runErrorHandler||,isa 0

	.dwfde $C$DW$CIE, ||DCL_runErrorHandler||
$C$DW$116	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$116, DW_AT_name("p")
	.dwattr $C$DW$116, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$116, DW_AT_location[DW_OP_reg12]


;***************************************************************
;* FNAME: DCL_runErrorHandler           FR SIZE:   0           *
;*                                                             *
;* FUNCTION ENVIRONMENT                                        *
;*                                                             *
;* FUNCTION PROPERTIES                                         *
;*                            0 Parameter,  0 Auto,  0 SOE     *
;***************************************************************

||DCL_runErrorHandler||:
;* AR4   assigned to p
$C$DW$117	.dwtag  DW_TAG_variable
	.dwattr $C$DW$117, DW_AT_name("p")
	.dwattr $C$DW$117, DW_AT_type(*$C$DW$T$50)
	.dwattr $C$DW$117, DW_AT_location[DW_OP_reg12]

	.dwcfi	cfa_offset, -2
	.dwcfi	save_reg_to_mem, 26, 0
	.dwpsn	file "../libraries/DCL/DCL_error.c",line 7,column 5,is_stmt,isa 0
        MOVL      ACC,*+XAR4[6]         ; [CPU_ALU] |7| 
        B         ||$C$L24||,EQ         ; [CPU_ALU] |7| 
        ; branchcc occurs ; [] |7| 
 ESTOP0
||$C$L24||:    
        SPM       #0                    ; [CPU_ALU] 
$C$DW$118	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$118, DW_AT_low_pc(0x00)
	.dwattr $C$DW$118, DW_AT_TI_return

        LRETR     ; [CPU_ALU] 
        ; return occurs ; [] 
	.dwattr $C$DW$115, DW_AT_TI_end_file("../libraries/DCL/DCL_error.c")
	.dwattr $C$DW$115, DW_AT_TI_end_line(0x0f)
	.dwattr $C$DW$115, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$115

;**************************************************************
;* UNDEFINED EXTERNAL REFERENCES                              *
;**************************************************************
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

$C$DW$TU$20	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$20

$C$DW$T$20	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$20, DW_AT_name("_Complex_double")
	.dwattr $C$DW$T$20, DW_AT_byte_size(0x08)
$C$DW$119	.dwtag  DW_TAG_member
	.dwattr $C$DW$119, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$119, DW_AT_name("_Vals")
	.dwattr $C$DW$119, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$119, DW_AT_decl_file("../libraries/DCL/DCL_error.c")
	.dwattr $C$DW$119, DW_AT_decl_line(0x01)
	.dwattr $C$DW$119, DW_AT_decl_column(0x00)

	.dwendtag $C$DW$T$20

	.dwendtag $C$DW$TU$20


$C$DW$TU$29	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$29
$C$DW$T$29	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$29, DW_AT_name("_Complex_double")
	.dwattr $C$DW$T$29, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$T$29, DW_AT_decl_file("../libraries/DCL/DCL_error.c")
	.dwattr $C$DW$T$29, DW_AT_decl_line(0x01)
	.dwattr $C$DW$T$29, DW_AT_decl_column(0x00)

	.dwendtag $C$DW$TU$29


$C$DW$TU$22	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$22

$C$DW$T$22	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$22, DW_AT_name("_Complex_float")
	.dwattr $C$DW$T$22, DW_AT_byte_size(0x04)
$C$DW$120	.dwtag  DW_TAG_member
	.dwattr $C$DW$120, DW_AT_type(*$C$DW$T$21)
	.dwattr $C$DW$120, DW_AT_name("_Vals")
	.dwattr $C$DW$120, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$120, DW_AT_decl_file("../libraries/DCL/DCL_error.c")
	.dwattr $C$DW$120, DW_AT_decl_line(0x01)
	.dwattr $C$DW$120, DW_AT_decl_column(0x00)

	.dwendtag $C$DW$T$22

	.dwendtag $C$DW$TU$22


$C$DW$TU$30	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$30
$C$DW$T$30	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$30, DW_AT_name("_Complex_float")
	.dwattr $C$DW$T$30, DW_AT_type(*$C$DW$T$22)
	.dwattr $C$DW$T$30, DW_AT_decl_file("../libraries/DCL/DCL_error.c")
	.dwattr $C$DW$T$30, DW_AT_decl_line(0x01)
	.dwattr $C$DW$T$30, DW_AT_decl_column(0x00)

	.dwendtag $C$DW$TU$30


$C$DW$TU$24	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$24

$C$DW$T$24	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$24, DW_AT_name("_Complex_long_double")
	.dwattr $C$DW$T$24, DW_AT_byte_size(0x08)
$C$DW$121	.dwtag  DW_TAG_member
	.dwattr $C$DW$121, DW_AT_type(*$C$DW$T$23)
	.dwattr $C$DW$121, DW_AT_name("_Vals")
	.dwattr $C$DW$121, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$121, DW_AT_decl_file("../libraries/DCL/DCL_error.c")
	.dwattr $C$DW$121, DW_AT_decl_line(0x01)
	.dwattr $C$DW$121, DW_AT_decl_column(0x00)

	.dwendtag $C$DW$T$24

	.dwendtag $C$DW$TU$24


$C$DW$TU$31	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$31
$C$DW$T$31	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$31, DW_AT_name("_Complex_long_double")
	.dwattr $C$DW$T$31, DW_AT_type(*$C$DW$T$24)
	.dwattr $C$DW$T$31, DW_AT_decl_file("../libraries/DCL/DCL_error.c")
	.dwattr $C$DW$T$31, DW_AT_decl_line(0x01)
	.dwattr $C$DW$T$31, DW_AT_decl_column(0x00)

	.dwendtag $C$DW$TU$31


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


$C$DW$TU$26	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$26
$C$DW$T$26	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$26, DW_AT_name("__uint32_t")
	.dwattr $C$DW$T$26, DW_AT_type(*$C$DW$T$13)
	.dwattr $C$DW$T$26, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$26, DW_AT_decl_line(0x43)
	.dwattr $C$DW$T$26, DW_AT_decl_column(0x1c)

	.dwendtag $C$DW$TU$26


$C$DW$TU$27	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$27
$C$DW$T$27	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$27, DW_AT_name("uint32_t")
	.dwattr $C$DW$T$27, DW_AT_type(*$C$DW$T$26)
	.dwattr $C$DW$T$27, DW_AT_decl_file("C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include/sys/_stdint.h")
	.dwattr $C$DW$T$27, DW_AT_decl_line(0x46)
	.dwattr $C$DW$T$27, DW_AT_decl_column(0x15)

	.dwendtag $C$DW$TU$27


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


$C$DW$TU$21	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$21

$C$DW$T$21	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$21, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$T$21, DW_AT_byte_size(0x04)
$C$DW$122	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$122, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$21

	.dwendtag $C$DW$TU$21


$C$DW$TU$43	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$43
$C$DW$123	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$123, DW_AT_type(*$C$DW$T$16)

$C$DW$T$43	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$43, DW_AT_type(*$C$DW$123)

	.dwendtag $C$DW$TU$43


$C$DW$TU$25	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$25
$C$DW$T$25	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$25, DW_AT_name("float32_t")
	.dwattr $C$DW$T$25, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$T$25, DW_AT_decl_file("..\libraries\DCL\DCL.h")
	.dwattr $C$DW$T$25, DW_AT_decl_line(0x19)
	.dwattr $C$DW$T$25, DW_AT_decl_column(0x0f)

	.dwendtag $C$DW$TU$25


$C$DW$TU$17	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$17
$C$DW$T$17	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$17, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$17, DW_AT_name("double")
	.dwattr $C$DW$T$17, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$17


$C$DW$TU$19	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$19

$C$DW$T$19	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$19, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$T$19, DW_AT_byte_size(0x08)
$C$DW$124	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$124, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$19

	.dwendtag $C$DW$TU$19


$C$DW$TU$44	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$44
$C$DW$T$44	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$44, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$T$44, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$44


$C$DW$TU$45	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$45
$C$DW$125	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$125, DW_AT_type(*$C$DW$T$44)

$C$DW$T$45	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$45, DW_AT_type(*$C$DW$125)

	.dwendtag $C$DW$TU$45


$C$DW$TU$18	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$18
$C$DW$T$18	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$18, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$18, DW_AT_name("long double")
	.dwattr $C$DW$T$18, DW_AT_byte_size(0x04)

	.dwendtag $C$DW$TU$18


$C$DW$TU$23	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$23

$C$DW$T$23	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$23, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$23, DW_AT_byte_size(0x08)
$C$DW$126	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$126, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$23

	.dwendtag $C$DW$TU$23


$C$DW$TU$47	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$47
$C$DW$T$47	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$47, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$47, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$47


$C$DW$TU$48	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$48
$C$DW$127	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$127, DW_AT_type(*$C$DW$T$47)

$C$DW$T$48	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$48, DW_AT_type(*$C$DW$127)

	.dwendtag $C$DW$TU$48


$C$DW$TU$28	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$28

$C$DW$T$28	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$28, DW_AT_name("dcl_css")
	.dwattr $C$DW$T$28, DW_AT_byte_size(0x0a)
$C$DW$128	.dwtag  DW_TAG_member
	.dwattr $C$DW$128, DW_AT_type(*$C$DW$T$25)
	.dwattr $C$DW$128, DW_AT_name("tpt")
	.dwattr $C$DW$128, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$128, DW_AT_decl_file("..\libraries\DCL\DCL.h")
	.dwattr $C$DW$128, DW_AT_decl_line(0x91)
	.dwattr $C$DW$128, DW_AT_decl_column(0x0f)

$C$DW$129	.dwtag  DW_TAG_member
	.dwattr $C$DW$129, DW_AT_type(*$C$DW$T$25)
	.dwattr $C$DW$129, DW_AT_name("T")
	.dwattr $C$DW$129, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$129, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$129, DW_AT_decl_file("..\libraries\DCL\DCL.h")
	.dwattr $C$DW$129, DW_AT_decl_line(0x92)
	.dwattr $C$DW$129, DW_AT_decl_column(0x0f)

$C$DW$130	.dwtag  DW_TAG_member
	.dwattr $C$DW$130, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$130, DW_AT_name("sts")
	.dwattr $C$DW$130, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$130, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$130, DW_AT_decl_file("..\libraries\DCL\DCL.h")
	.dwattr $C$DW$130, DW_AT_decl_line(0x93)
	.dwattr $C$DW$130, DW_AT_decl_column(0x0e)

$C$DW$131	.dwtag  DW_TAG_member
	.dwattr $C$DW$131, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$131, DW_AT_name("err")
	.dwattr $C$DW$131, DW_AT_data_member_location[DW_OP_plus_uconst 0x6]
	.dwattr $C$DW$131, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$131, DW_AT_decl_file("..\libraries\DCL\DCL.h")
	.dwattr $C$DW$131, DW_AT_decl_line(0x94)
	.dwattr $C$DW$131, DW_AT_decl_column(0x0e)

$C$DW$132	.dwtag  DW_TAG_member
	.dwattr $C$DW$132, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$132, DW_AT_name("loc")
	.dwattr $C$DW$132, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$132, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$132, DW_AT_decl_file("..\libraries\DCL\DCL.h")
	.dwattr $C$DW$132, DW_AT_decl_line(0x95)
	.dwattr $C$DW$132, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$28, DW_AT_decl_file("..\libraries\DCL\DCL.h")
	.dwattr $C$DW$T$28, DW_AT_decl_line(0x90)
	.dwattr $C$DW$T$28, DW_AT_decl_column(0x19)
	.dwendtag $C$DW$T$28

	.dwendtag $C$DW$TU$28


$C$DW$TU$32	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$32
$C$DW$133	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$133, DW_AT_type(*$C$DW$T$28)

$C$DW$T$32	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$32, DW_AT_type(*$C$DW$133)

	.dwendtag $C$DW$TU$32


$C$DW$TU$33	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$33
$C$DW$T$33	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$33, DW_AT_name("DCL_CSS")
	.dwattr $C$DW$T$33, DW_AT_type(*$C$DW$T$32)
	.dwattr $C$DW$T$33, DW_AT_decl_file("..\libraries\DCL\DCL.h")
	.dwattr $C$DW$T$33, DW_AT_decl_line(0x96)
	.dwattr $C$DW$T$33, DW_AT_decl_column(0x03)

	.dwendtag $C$DW$TU$33


$C$DW$TU$34	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$34
$C$DW$T$34	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$34, DW_AT_type(*$C$DW$T$33)
	.dwattr $C$DW$T$34, DW_AT_address_class(0x20)

	.dwendtag $C$DW$TU$34


$C$DW$TU$50	.dwtag  DW_TAG_type_unit
	.dwmtype  $C$DW$T$50
$C$DW$134	.dwtag  DW_TAG_TI_far_type
	.dwattr $C$DW$134, DW_AT_type(*$C$DW$T$34)

$C$DW$T$50	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$50, DW_AT_type(*$C$DW$134)

	.dwendtag $C$DW$TU$50

