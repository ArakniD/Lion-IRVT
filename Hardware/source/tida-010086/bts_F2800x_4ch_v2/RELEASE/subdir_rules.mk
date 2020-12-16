################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
%.obj: ../%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: C2000 Compiler'
	"C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla2 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu0 -O3 --opt_for_speed=5 --fp_mode=relaxed --include_path="C:/Users/a0230328/workspace_v10/bts_F2800x_4ch_v2" --include_path="C:/Users/a0230328/workspace_v10/bts_F2800x_4ch_v2/device" --include_path="C:/ti/C2000Ware_DigitalPower_SDK_3_00_01_00/c2000ware/driverlib/f28004x/driverlib" --include_path="C:/Users/a0230328/workspace_v10/bts_F2800x_4ch_v2/libraries/sfra" --include_path="C:/Users/a0230328/workspace_v10/bts_F2800x_4ch_v2/libraries/DCL" --include_path="C:/Users/a0230328/workspace_v10/bts_F2800x_4ch_v2/libraries/SFO" --include_path="C:/ti/ccs1010/ccs/tools/compiler/ti-cgt-c2000_20.2.1.LTS/include" --define=_TI_EABI_ --define=_DEBUG --define=CLA_DEBUG=1 --define=F28x_DEVICE --define=CPU1 --define=LARGE_MODEL --define=_FLASH -g --float_operations_allowed=32 --diag_suppress=10063 --diag_suppress=173 --diag_warning=225 --diag_wrap=off --display_error_number --quiet --abi=eabi -k --asm_listing --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" --include_path="C:/Users/a0230328/workspace_v10/bts_F2800x_4ch_v2/RELEASE/syscfg" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: "$<"'
	@echo ' '


