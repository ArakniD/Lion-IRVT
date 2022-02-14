################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

CG_TOOL_ROOT := C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS

GEN_OPTS__FLAG := 
GEN_CMDS__FLAG := 

ORDERED_OBJS += \
"./bts.obj" \
"./bts_hal.obj" \
"./bts_main.obj" \
"./i2cLib_FIFO_master_slave_interrupt.obj" \
"./device/F2837xD_CodeStartBranch.obj" \
"./device/device.obj" \
"./libraries/DCL/DCL_error.obj" \
"./libraries/sfra/sfra_gui_scicomms_driverlib.obj" \
"../2837xD_RAM_lnk_cpu1.cmd" \
"../device/driverlib/driverlib_eabi.lib" \
"../libraries/FPUfastRTS/rts2800_fpu32_fast_supplement_eabi.lib" \
"../libraries/SFO/SFO_v8_fpu_lib_build_c28_driverlib_eabi.lib" \
"../libraries/sfra/sfra_f32_tmu_eabi.lib" \
$(GEN_CMDS__FLAG) \
-ldriverlib_eabi.lib \
-lsfra_f32_tmu_eabi.lib \
-lrts2800_fpu32_fast_supplement_eabi.lib \
-lrts2800_fpu32_eabi.lib \
-lSFO_v8_fpu_lib_build_c28_driverlib_eabi.lib \
-llibc.a \

-include ../makefile.init

RM := DEL /F
RMDIR := RMDIR /S/Q

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir_vars.mk
-include device/subdir_vars.mk
-include device/driverlib/subdir_vars.mk
-include libraries/DCL/subdir_vars.mk
-include libraries/FPUfastRTS/subdir_vars.mk
-include libraries/SFO/subdir_vars.mk
-include libraries/sfra/subdir_vars.mk
-include subdir_rules.mk
-include device/subdir_rules.mk
-include device/driverlib/subdir_rules.mk
-include libraries/DCL/subdir_rules.mk
-include libraries/FPUfastRTS/subdir_rules.mk
-include libraries/SFO/subdir_rules.mk
-include libraries/sfra/subdir_rules.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C55_DEPS)),)
-include $(C55_DEPS)
endif
ifneq ($(strip $(C_UPPER_DEPS)),)
-include $(C_UPPER_DEPS)
endif
ifneq ($(strip $(S67_DEPS)),)
-include $(S67_DEPS)
endif
ifneq ($(strip $(S62_DEPS)),)
-include $(S62_DEPS)
endif
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(OPT_DEPS)),)
-include $(OPT_DEPS)
endif
ifneq ($(strip $(C??_DEPS)),)
-include $(C??_DEPS)
endif
ifneq ($(strip $(ASM_UPPER_DEPS)),)
-include $(ASM_UPPER_DEPS)
endif
ifneq ($(strip $(S??_DEPS)),)
-include $(S??_DEPS)
endif
ifneq ($(strip $(C64_DEPS)),)
-include $(C64_DEPS)
endif
ifneq ($(strip $(CXX_DEPS)),)
-include $(CXX_DEPS)
endif
ifneq ($(strip $(S64_DEPS)),)
-include $(S64_DEPS)
endif
ifneq ($(strip $(INO_DEPS)),)
-include $(INO_DEPS)
endif
ifneq ($(strip $(CLA_DEPS)),)
-include $(CLA_DEPS)
endif
ifneq ($(strip $(S55_DEPS)),)
-include $(S55_DEPS)
endif
ifneq ($(strip $(SV7A_DEPS)),)
-include $(SV7A_DEPS)
endif
ifneq ($(strip $(C62_DEPS)),)
-include $(C62_DEPS)
endif
ifneq ($(strip $(C67_DEPS)),)
-include $(C67_DEPS)
endif
ifneq ($(strip $(PDE_DEPS)),)
-include $(PDE_DEPS)
endif
ifneq ($(strip $(K_DEPS)),)
-include $(K_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(CC_DEPS)),)
-include $(CC_DEPS)
endif
ifneq ($(strip $(C++_DEPS)),)
-include $(C++_DEPS)
endif
ifneq ($(strip $(C43_DEPS)),)
-include $(C43_DEPS)
endif
ifneq ($(strip $(S43_DEPS)),)
-include $(S43_DEPS)
endif
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(CPP_DEPS)),)
-include $(CPP_DEPS)
endif
ifneq ($(strip $(SA_DEPS)),)
-include $(SA_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
EXE_OUTPUTS += \
bts_F2837xD_8ch.out \

EXE_OUTPUTS__QUOTED += \
"bts_F2837xD_8ch.out" \

BIN_OUTPUTS += \
bts_F2837xD_8ch.hex \

BIN_OUTPUTS__QUOTED += \
"bts_F2837xD_8ch.hex" \


# All Target
all: $(OBJS) $(CMD_SRCS) $(LIB_SRCS) $(GEN_CMDS)
	@$(MAKE) --no-print-directory -Onone "bts_F2837xD_8ch.out"

# Tool invocations
bts_F2837xD_8ch.out: $(OBJS) $(CMD_SRCS) $(LIB_SRCS) $(GEN_CMDS)
	@echo 'Building target: "$@"'
	@echo 'Invoking: C2000 Linker'
	"C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O3 --opt_for_speed=5 --fp_mode=relaxed --define=_TI_EABI_ --define=_DEBUG --define=CLA_DEBUG=1 --define=F28x_DEVICE --define=CPU1 --define=LARGE_MODEL --define=_FLASH -g --float_operations_allowed=32 --diag_suppress=10063 --diag_suppress=173 --diag_warning=225 --diag_wrap=off --display_error_number --quiet --abi=eabi -k --asm_listing -z -m"bts_F2837xD_8ch.map" --heap_size=0x200 --stack_size=0x300 --warn_sections -i"C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/lib" -i"C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra" -i"C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/FPUfastRTS" -i"C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/device/driverlib" -i"C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/SFO" -i"C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include" --reread_libs --diag_wrap=off --display_error_number --xml_link_info="bts_F2837xD_8ch_linkInfo.xml" --ram_model -o "bts_F2837xD_8ch.out" $(ORDERED_OBJS)
	@echo 'Finished building target: "$@"'
	@echo ' '

bts_F2837xD_8ch.hex: $(EXE_OUTPUTS)
	@echo 'Building files: $(strip $(EXE_OUTPUTS__QUOTED))'
	@echo 'Invoking: C2000 Hex Utility'
	"C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/bin/hex2000" --diag_wrap=off -o "bts_F2837xD_8ch.hex" $(EXE_OUTPUTS__QUOTED)
	@echo 'Finished building: $(strip $(EXE_OUTPUTS__QUOTED))'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(BIN_OUTPUTS__QUOTED)$(EXE_OUTPUTS__QUOTED)
	-$(RM) "bts.lst" "bts_hal.lst" "bts_main.lst" "i2cLib_FIFO_master_slave_interrupt.lst" "device/F2837xD_CodeStartBranch.lst" "device/device.lst" "libraries/DCL/DCL_error.lst" "libraries/sfra/sfra_gui_scicomms_driverlib.lst" 
	-$(RM) "bts.obj" "bts_hal.obj" "bts_main.obj" "i2cLib_FIFO_master_slave_interrupt.obj" "device\F2837xD_CodeStartBranch.obj" "device\device.obj" "libraries\DCL\DCL_error.obj" "libraries\sfra\sfra_gui_scicomms_driverlib.obj" 
	-$(RM) "bts.d" "bts_hal.d" "bts_main.d" "i2cLib_FIFO_master_slave_interrupt.d" "device\device.d" "libraries\DCL\DCL_error.d" "libraries\sfra\sfra_gui_scicomms_driverlib.d" 
	-$(RM) "bts.asm" "bts_hal.asm" "bts_main.asm" "i2cLib_FIFO_master_slave_interrupt.asm" "device/F2837xD_CodeStartBranch.asm" "device/device.asm" "libraries/DCL/DCL_error.asm" "libraries/sfra/sfra_gui_scicomms_driverlib.asm" 
	-$(RM) "device\F2837xD_CodeStartBranch.d" 
	-@echo 'Finished clean'
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets

