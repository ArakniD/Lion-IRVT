################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
%.obj: ../%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: C2000 Compiler'
	"C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O3 --opt_for_speed=5 --fp_mode=relaxed --include_path="C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch" --include_path="C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/device" --include_path="C:/ti/c2000/C2000Ware_DigitalPower_SDK_3_01_00_00/c2000ware/driverlib/f2837xd/driverlib" --include_path="C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/sfra" --include_path="C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/DCL" --include_path="C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/libraries/SFO" --include_path="C:/ti/ccs1011/ccs/tools/compiler/ti-cgt-c2000_20.2.4.LTS/include" --define=_TI_EABI_ --define=_DEBUG --define=CLA_DEBUG=1 --define=F28x_DEVICE --define=CPU1 --define=LARGE_MODEL --define=_FLASH -g --float_operations_allowed=32 --diag_suppress=10063 --diag_suppress=173 --diag_warning=225 --diag_wrap=off --display_error_number --quiet --abi=eabi -k --asm_listing --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" --include_path="C:/sandbox/github/Lion-IRVT/Hardware/source/tida-010086/bts_F2837xD_8ch/release/syscfg" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: "$<"'
	@echo ' '


