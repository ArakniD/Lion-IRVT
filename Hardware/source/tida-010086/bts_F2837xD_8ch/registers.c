/*
 * registers.c
 *
 *  Created on: 15 Apr. 2025
 *      Author: lucas
 */

#include "driverlib.h"
#include "device.h"
#include "registers.h"
#include "led_driver.h"
#include <string.h>
#include <stdlib.h>

//
// Shared data placement. The F2837xD message RAMs are single-writer:
// CPU2TOCPU1RAM is writable only by CPU2, CPU1TOCPU2RAM only by CPU1.
//

//
// CPU2 -> CPU1. CPU2 owns the register file; CPU1 only ever reads it.
//
#pragma DATA_SECTION(registers, "CPU2TOCPU1RAM")
volatile float32_t registers[TOTAL_REGISTERS];

#pragma DATA_SECTION(ipcMsg, "CPU2TOCPU1RAM")
volatile BTS_ipcMessage ipcMsg;

//
// The full calibration image is CPU2-private: every float in it is also
// published through registers[], which is what CPU1 actually reads. Keeping
// the array out of the message RAM buys back 288 words of a 1024-word block
// that the calibration registers had overflowed.
//
// CPU1 needs exactly one thing from it - the persisted validity flags, so a
// slot calibrated in an earlier session still reports its status bits after a
// power cycle. Those go across on their own.
//
BTS_channelCalibration calibrationData[NUM_CHANNELS];

#pragma DATA_SECTION(calValidFlags, "CPU2TOCPU1RAM")
volatile uint32_t calValidFlags[NUM_CHANNELS];

//
// Watchdog and boot-restore signalling. CPU2 detects both events but never
// touches slot control state - it publishes here and CPU1 acts.
//
#pragma DATA_SECTION(supervision, "CPU2TOCPU1RAM")
volatile BTS_supervision supervision;

//
// CPU1 -> CPU2. CPU1 publishes measurements and status here; CPU2 mirrors
// them into registers[] for the external interfaces.
//
#pragma DATA_SECTION(canData, "CPU1TOCPU2RAM")
volatile CAN_data canData[NUM_CHANNELS];

#pragma DATA_SECTION(cpu1Status, "CPU1TOCPU2RAM")
volatile BTS_cpu1Status cpu1Status;

#pragma DATA_SECTION(startup_mode, "CPU1TOCPU2RAM")
volatile uint32_t startup_mode;

#pragma DATA_SECTION(startup_enable, "CPU1TOCPU2RAM")
volatile uint32_t startup_enable;

const RegisterConfig regConfig[TOTAL_REGISTERS] = {

    // Channel 0 runtime
    {eCh0_Status, REG_ACCESS_RO, 4}, {eCh0_CellVoltage, REG_ACCESS_RO, 4},
    {eCh0_CellCurrent, REG_ACCESS_RO, 4}, {eCh0_SenseVoltage, REG_ACCESS_RO, 4},
    {eCh0_SenseCurrent, REG_ACCESS_RO, 4}, {eCh0_CellTemp, REG_ACCESS_RO, 4},
    {eCh0_ChargeAcc_mAh, REG_ACCESS_RO, 4}, {eCh0_ChargeAcc_mWh, REG_ACCESS_RO, 4},
    {eCh0_ChargeRuntime_s, REG_ACCESS_RO, 4}, {eCh0_DischargeAcc_mAh, REG_ACCESS_RO, 4},
    {eCh0_DischargeAcc_mWh, REG_ACCESS_RO, 4}, {eCh0_DischargeRuntime_s, REG_ACCESS_RO, 4},
    // Channel 1 runtime
    {eCh1_Status, REG_ACCESS_RO, 4}, {eCh1_CellVoltage, REG_ACCESS_RO, 4},
    {eCh1_CellCurrent, REG_ACCESS_RO, 4}, {eCh1_SenseVoltage, REG_ACCESS_RO, 4},
    {eCh1_SenseCurrent, REG_ACCESS_RO, 4}, {eCh1_CellTemp, REG_ACCESS_RO, 4},
    {eCh1_ChargeAcc_mAh, REG_ACCESS_RO, 4}, {eCh1_ChargeAcc_mWh, REG_ACCESS_RO, 4},
    {eCh1_ChargeRuntime_s, REG_ACCESS_RO, 4}, {eCh1_DischargeAcc_mAh, REG_ACCESS_RO, 4},
    {eCh1_DischargeAcc_mWh, REG_ACCESS_RO, 4}, {eCh1_DischargeRuntime_s, REG_ACCESS_RO, 4},
    // Channel 2 runtime
    {eCh2_Status, REG_ACCESS_RO, 4}, {eCh2_CellVoltage, REG_ACCESS_RO, 4},
    {eCh2_CellCurrent, REG_ACCESS_RO, 4}, {eCh2_SenseVoltage, REG_ACCESS_RO, 4},
    {eCh2_SenseCurrent, REG_ACCESS_RO, 4}, {eCh2_CellTemp, REG_ACCESS_RO, 4},
    {eCh2_ChargeAcc_mAh, REG_ACCESS_RO, 4}, {eCh2_ChargeAcc_mWh, REG_ACCESS_RO, 4},
    {eCh2_ChargeRuntime_s, REG_ACCESS_RO, 4}, {eCh2_DischargeAcc_mAh, REG_ACCESS_RO, 4},
    {eCh2_DischargeAcc_mWh, REG_ACCESS_RO, 4}, {eCh2_DischargeRuntime_s, REG_ACCESS_RO, 4},
    // Channel 3 runtime
    {eCh3_Status, REG_ACCESS_RO, 4}, {eCh3_CellVoltage, REG_ACCESS_RO, 4},
    {eCh3_CellCurrent, REG_ACCESS_RO, 4}, {eCh3_SenseVoltage, REG_ACCESS_RO, 4},
    {eCh3_SenseCurrent, REG_ACCESS_RO, 4}, {eCh3_CellTemp, REG_ACCESS_RO, 4},
    {eCh3_ChargeAcc_mAh, REG_ACCESS_RO, 4}, {eCh3_ChargeAcc_mWh, REG_ACCESS_RO, 4},
    {eCh3_ChargeRuntime_s, REG_ACCESS_RO, 4}, {eCh3_DischargeAcc_mAh, REG_ACCESS_RO, 4},
    {eCh3_DischargeAcc_mWh, REG_ACCESS_RO, 4}, {eCh3_DischargeRuntime_s, REG_ACCESS_RO, 4},
    // Channel 4 runtime
    {eCh4_Status, REG_ACCESS_RO, 4}, {eCh4_CellVoltage, REG_ACCESS_RO, 4},
    {eCh4_CellCurrent, REG_ACCESS_RO, 4}, {eCh4_SenseVoltage, REG_ACCESS_RO, 4},
    {eCh4_SenseCurrent, REG_ACCESS_RO, 4}, {eCh4_CellTemp, REG_ACCESS_RO, 4},
    {eCh4_ChargeAcc_mAh, REG_ACCESS_RO, 4}, {eCh4_ChargeAcc_mWh, REG_ACCESS_RO, 4},
    {eCh4_ChargeRuntime_s, REG_ACCESS_RO, 4}, {eCh4_DischargeAcc_mAh, REG_ACCESS_RO, 4},
    {eCh4_DischargeAcc_mWh, REG_ACCESS_RO, 4}, {eCh4_DischargeRuntime_s, REG_ACCESS_RO, 4},
    // Channel 5 runtime
    {eCh5_Status, REG_ACCESS_RO, 4}, {eCh5_CellVoltage, REG_ACCESS_RO, 4},
    {eCh5_CellCurrent, REG_ACCESS_RO, 4}, {eCh5_SenseVoltage, REG_ACCESS_RO, 4},
    {eCh5_SenseCurrent, REG_ACCESS_RO, 4}, {eCh5_CellTemp, REG_ACCESS_RO, 4},
    {eCh5_ChargeAcc_mAh, REG_ACCESS_RO, 4}, {eCh5_ChargeAcc_mWh, REG_ACCESS_RO, 4},
    {eCh5_ChargeRuntime_s, REG_ACCESS_RO, 4}, {eCh5_DischargeAcc_mAh, REG_ACCESS_RO, 4},
    {eCh5_DischargeAcc_mWh, REG_ACCESS_RO, 4}, {eCh5_DischargeRuntime_s, REG_ACCESS_RO, 4},
    // Channel 6 runtime
    {eCh6_Status, REG_ACCESS_RO, 4}, {eCh6_CellVoltage, REG_ACCESS_RO, 4},
    {eCh6_CellCurrent, REG_ACCESS_RO, 4}, {eCh6_SenseVoltage, REG_ACCESS_RO, 4},
    {eCh6_SenseCurrent, REG_ACCESS_RO, 4}, {eCh6_CellTemp, REG_ACCESS_RO, 4},
    {eCh6_ChargeAcc_mAh, REG_ACCESS_RO, 4}, {eCh6_ChargeAcc_mWh, REG_ACCESS_RO, 4},
    {eCh6_ChargeRuntime_s, REG_ACCESS_RO, 4}, {eCh6_DischargeAcc_mAh, REG_ACCESS_RO, 4},
    {eCh6_DischargeAcc_mWh, REG_ACCESS_RO, 4}, {eCh6_DischargeRuntime_s, REG_ACCESS_RO, 4},
    // Channel 7 runtime
    {eCh7_Status, REG_ACCESS_RO, 4}, {eCh7_CellVoltage, REG_ACCESS_RO, 4},
    {eCh7_CellCurrent, REG_ACCESS_RO, 4}, {eCh7_SenseVoltage, REG_ACCESS_RO, 4},
    {eCh7_SenseCurrent, REG_ACCESS_RO, 4}, {eCh7_CellTemp, REG_ACCESS_RO, 4},
    {eCh7_ChargeAcc_mAh, REG_ACCESS_RO, 4}, {eCh7_ChargeAcc_mWh, REG_ACCESS_RO, 4},
    {eCh7_ChargeRuntime_s, REG_ACCESS_RO, 4}, {eCh7_DischargeAcc_mAh, REG_ACCESS_RO, 4},
    {eCh7_DischargeAcc_mWh, REG_ACCESS_RO, 4}, {eCh7_DischargeRuntime_s, REG_ACCESS_RO, 4},
    // Settings block
    {eCh0_Mode, REG_ACCESS_RW, 4}, {eCh0_VoltageMin, REG_ACCESS_RW, 4},
    {eCh0_VoltageMax, REG_ACCESS_RW, 4}, {eCh0_CurrentMin, REG_ACCESS_RW, 4},
    {eCh0_CurrentMax, REG_ACCESS_RW, 4}, {eCh0_MaxCellTemp, REG_ACCESS_RW, 4},
    {eCh0_F28V_Gain, REG_ACCESS_RW, 4}, {eCh0_F28V_Offset, REG_ACCESS_RW, 4},
    {eCh0_F28I_Gain, REG_ACCESS_RW, 4}, {eCh0_F28I_Offset, REG_ACCESS_RW, 4},
    {eCh0_IoutGain_pu, REG_ACCESS_RW, 4}, {eCh0_IoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh0_IoutGain_A, REG_ACCESS_RW, 4}, {eCh0_IoutOffset_A, REG_ACCESS_RW, 4},
    {eCh0_VoutGain_pu, REG_ACCESS_RW, 4}, {eCh0_VoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh0_VoutGain_V, REG_ACCESS_RW, 4}, {eCh0_VoutOffset_V, REG_ACCESS_RW, 4},
    // Channel 1 settings
    {eCh1_Mode, REG_ACCESS_RW, 4}, {eCh1_VoltageMin, REG_ACCESS_RW, 4},
    {eCh1_VoltageMax, REG_ACCESS_RW, 4}, {eCh1_CurrentMin, REG_ACCESS_RW, 4},
    {eCh1_CurrentMax, REG_ACCESS_RW, 4}, {eCh1_MaxCellTemp, REG_ACCESS_RW, 4},
    {eCh1_F28V_Gain, REG_ACCESS_RW, 4}, {eCh1_F28V_Offset, REG_ACCESS_RW, 4},
    {eCh1_F28I_Gain, REG_ACCESS_RW, 4}, {eCh1_F28I_Offset, REG_ACCESS_RW, 4},
    {eCh1_IoutGain_pu, REG_ACCESS_RW, 4}, {eCh1_IoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh1_IoutGain_A, REG_ACCESS_RW, 4}, {eCh1_IoutOffset_A, REG_ACCESS_RW, 4},
    {eCh1_VoutGain_pu, REG_ACCESS_RW, 4}, {eCh1_VoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh1_VoutGain_V, REG_ACCESS_RW, 4}, {eCh1_VoutOffset_V, REG_ACCESS_RW, 4},
    // Channel 2 settings
    {eCh2_Mode, REG_ACCESS_RW, 4}, {eCh2_VoltageMin, REG_ACCESS_RW, 4},
    {eCh2_VoltageMax, REG_ACCESS_RW, 4}, {eCh2_CurrentMin, REG_ACCESS_RW, 4},
    {eCh2_CurrentMax, REG_ACCESS_RW, 4}, {eCh2_MaxCellTemp, REG_ACCESS_RW, 4},
    {eCh2_F28V_Gain, REG_ACCESS_RW, 4}, {eCh2_F28V_Offset, REG_ACCESS_RW, 4},
    {eCh2_F28I_Gain, REG_ACCESS_RW, 4}, {eCh2_F28I_Offset, REG_ACCESS_RW, 4},
    {eCh2_IoutGain_pu, REG_ACCESS_RW, 4}, {eCh2_IoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh2_IoutGain_A, REG_ACCESS_RW, 4}, {eCh2_IoutOffset_A, REG_ACCESS_RW, 4},
    {eCh2_VoutGain_pu, REG_ACCESS_RW, 4}, {eCh2_VoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh2_VoutGain_V, REG_ACCESS_RW, 4}, {eCh2_VoutOffset_V, REG_ACCESS_RW, 4},
    // Channel 3 settings
    {eCh3_Mode, REG_ACCESS_RW, 4}, {eCh3_VoltageMin, REG_ACCESS_RW, 4},
    {eCh3_VoltageMax, REG_ACCESS_RW, 4}, {eCh3_CurrentMin, REG_ACCESS_RW, 4},
    {eCh3_CurrentMax, REG_ACCESS_RW, 4}, {eCh3_MaxCellTemp, REG_ACCESS_RW, 4},
    {eCh3_F28V_Gain, REG_ACCESS_RW, 4}, {eCh3_F28V_Offset, REG_ACCESS_RW, 4},
    {eCh3_F28I_Gain, REG_ACCESS_RW, 4}, {eCh3_F28I_Offset, REG_ACCESS_RW, 4},
    {eCh3_IoutGain_pu, REG_ACCESS_RW, 4}, {eCh3_IoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh3_IoutGain_A, REG_ACCESS_RW, 4}, {eCh3_IoutOffset_A, REG_ACCESS_RW, 4},
    {eCh3_VoutGain_pu, REG_ACCESS_RW, 4}, {eCh3_VoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh3_VoutGain_V, REG_ACCESS_RW, 4}, {eCh3_VoutOffset_V, REG_ACCESS_RW, 4},
    // Channel 4 settings
    {eCh4_Mode, REG_ACCESS_RW, 4}, {eCh4_VoltageMin, REG_ACCESS_RW, 4},
    {eCh4_VoltageMax, REG_ACCESS_RW, 4}, {eCh4_CurrentMin, REG_ACCESS_RW, 4},
    {eCh4_CurrentMax, REG_ACCESS_RW, 4}, {eCh4_MaxCellTemp, REG_ACCESS_RW, 4},
    {eCh4_F28V_Gain, REG_ACCESS_RW, 4}, {eCh4_F28V_Offset, REG_ACCESS_RW, 4},
    {eCh4_F28I_Gain, REG_ACCESS_RW, 4}, {eCh4_F28I_Offset, REG_ACCESS_RW, 4},
    {eCh4_IoutGain_pu, REG_ACCESS_RW, 4}, {eCh4_IoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh4_IoutGain_A, REG_ACCESS_RW, 4}, {eCh4_IoutOffset_A, REG_ACCESS_RW, 4},
    {eCh4_VoutGain_pu, REG_ACCESS_RW, 4}, {eCh4_VoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh4_VoutGain_V, REG_ACCESS_RW, 4}, {eCh4_VoutOffset_V, REG_ACCESS_RW, 4},
    // Channel 5 settings
    {eCh5_Mode, REG_ACCESS_RW, 4}, {eCh5_VoltageMin, REG_ACCESS_RW, 4},
    {eCh5_VoltageMax, REG_ACCESS_RW, 4}, {eCh5_CurrentMin, REG_ACCESS_RW, 4},
    {eCh5_CurrentMax, REG_ACCESS_RW, 4}, {eCh5_MaxCellTemp, REG_ACCESS_RW, 4},
    {eCh5_F28V_Gain, REG_ACCESS_RW, 4}, {eCh5_F28V_Offset, REG_ACCESS_RW, 4},
    {eCh5_F28I_Gain, REG_ACCESS_RW, 4}, {eCh5_F28I_Offset, REG_ACCESS_RW, 4},
    {eCh5_IoutGain_pu, REG_ACCESS_RW, 4}, {eCh5_IoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh5_IoutGain_A, REG_ACCESS_RW, 4}, {eCh5_IoutOffset_A, REG_ACCESS_RW, 4},
    {eCh5_VoutGain_pu, REG_ACCESS_RW, 4}, {eCh5_VoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh5_VoutGain_V, REG_ACCESS_RW, 4}, {eCh5_VoutOffset_V, REG_ACCESS_RW, 4},
    // Channel 6 settings
    {eCh6_Mode, REG_ACCESS_RW, 4}, {eCh6_VoltageMin, REG_ACCESS_RW, 4},
    {eCh6_VoltageMax, REG_ACCESS_RW, 4}, {eCh6_CurrentMin, REG_ACCESS_RW, 4},
    {eCh6_CurrentMax, REG_ACCESS_RW, 4}, {eCh6_MaxCellTemp, REG_ACCESS_RW, 4},
    {eCh6_F28V_Gain, REG_ACCESS_RW, 4}, {eCh6_F28V_Offset, REG_ACCESS_RW, 4},
    {eCh6_F28I_Gain, REG_ACCESS_RW, 4}, {eCh6_F28I_Offset, REG_ACCESS_RW, 4},
    {eCh6_IoutGain_pu, REG_ACCESS_RW, 4}, {eCh6_IoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh6_IoutGain_A, REG_ACCESS_RW, 4}, {eCh6_IoutOffset_A, REG_ACCESS_RW, 4},
    {eCh6_VoutGain_pu, REG_ACCESS_RW, 4}, {eCh6_VoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh6_VoutGain_V, REG_ACCESS_RW, 4}, {eCh6_VoutOffset_V, REG_ACCESS_RW, 4},
    // Channel 7 settings
    {eCh7_Mode, REG_ACCESS_RW, 4}, {eCh7_VoltageMin, REG_ACCESS_RW, 4},
    {eCh7_VoltageMax, REG_ACCESS_RW, 4}, {eCh7_CurrentMin, REG_ACCESS_RW, 4},
    {eCh7_CurrentMax, REG_ACCESS_RW, 4}, {eCh7_MaxCellTemp, REG_ACCESS_RW, 4},
    {eCh7_F28V_Gain, REG_ACCESS_RW, 4}, {eCh7_F28V_Offset, REG_ACCESS_RW, 4},
    {eCh7_F28I_Gain, REG_ACCESS_RW, 4}, {eCh7_F28I_Offset, REG_ACCESS_RW, 4},
    {eCh7_IoutGain_pu, REG_ACCESS_RW, 4}, {eCh7_IoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh7_IoutGain_A, REG_ACCESS_RW, 4}, {eCh7_IoutOffset_A, REG_ACCESS_RW, 4},
    {eCh7_VoutGain_pu, REG_ACCESS_RW, 4}, {eCh7_VoutOffset_pu, REG_ACCESS_RW, 4},
    {eCh7_VoutGain_V, REG_ACCESS_RW, 4}, {eCh7_VoutOffset_V, REG_ACCESS_RW, 4},
    // Unit block
    {eChargeDisableV, REG_ACCESS_RW, 4}, {eChargeRestrictV, REG_ACCESS_RW, 4},
    {eDischargeRestrictV, REG_ACCESS_RW, 4}, {eDischargeDisableV, REG_ACCESS_RW, 4},
    {eCalibrationMode, REG_ACCESS_RW, 4}, {eUnitState, REG_ACCESS_RO, 4},
    {eInputVoltage, REG_ACCESS_RO, 4}, {eTripStatus, REG_ACCESS_RO, 4},
    {eSlotMode, REG_ACCESS_RO, 4}, {eSlotEnable, REG_ACCESS_RO, 4}, {eGroupSize, REG_ACCESS_RO, 4},
    {eHostWatchdog_s, REG_ACCESS_RW, 4}, {eCalSlot, REG_ACCESS_RW, 4},
    {eCalCommand, REG_ACCESS_RW, 4}, {eCalArgument, REG_ACCESS_RW, 4},
    {eCalStatus, REG_ACCESS_RO, 4}, {eCalResult, REG_ACCESS_RO, 4},
    {eWatchdogRemaining_s, REG_ACCESS_RO, 4}, {eCalAdsV_pu, REG_ACCESS_RO, 4},
    {eCalAdsI_pu, REG_ACCESS_RO, 4}, {eCalAdsV_V, REG_ACCESS_RO, 4}, {eCalAdsI_A, REG_ACCESS_RO, 4},
    {eCalF28V_pu, REG_ACCESS_RO, 4}, {eCalF28I_pu, REG_ACCESS_RO, 4},
    {eCalF28V_V, REG_ACCESS_RO, 4}, {eCalF28I_A, REG_ACCESS_RO, 4}, {eCalTemp_C, REG_ACCESS_RO, 4}
};

const UARTRegisterConfig uartRegConfig[TOTAL_REGISTERS] = {
    // Channel 0 runtime
    {eCh0_Status, "C0S", "Ch0_Status", REG_ACCESS_RO},
    {eCh0_CellVoltage, "C0VOLT", "Ch0_CellVoltage", REG_ACCESS_RO},
    {eCh0_CellCurrent, "C0CURR", "Ch0_CellCurrent", REG_ACCESS_RO},
    {eCh0_SenseVoltage, "C0SV", "Ch0_SenseVoltage", REG_ACCESS_RO},
    {eCh0_SenseCurrent, "C0SI", "Ch0_SenseCurrent", REG_ACCESS_RO},
    {eCh0_CellTemp, "C0TEMP", "Ch0_CellTemp", REG_ACCESS_RO},
    {eCh0_ChargeAcc_mAh, "C0CA", "Ch0_ChargeAcc_mAh", REG_ACCESS_RO},
    {eCh0_ChargeAcc_mWh, "C0CW", "Ch0_ChargeAcc_mWh", REG_ACCESS_RO},
    {eCh0_ChargeRuntime_s, "C0CHS", "Ch0_ChargeRuntime_s", REG_ACCESS_RO},
    {eCh0_DischargeAcc_mAh, "C0DA", "Ch0_DischargeAcc_mAh", REG_ACCESS_RO},
    {eCh0_DischargeAcc_mWh, "C0DW", "Ch0_DischargeAcc_mWh", REG_ACCESS_RO},
    {eCh0_DischargeRuntime_s, "C0DHS", "Ch0_DischargeRuntime_s", REG_ACCESS_RO},
    // Channel 1 runtime
    {eCh1_Status, "C1S", "Ch1_Status", REG_ACCESS_RO},
    {eCh1_CellVoltage, "C1VOLT", "Ch1_CellVoltage", REG_ACCESS_RO},
    {eCh1_CellCurrent, "C1CURR", "Ch1_CellCurrent", REG_ACCESS_RO},
    {eCh1_SenseVoltage, "C1SV", "Ch1_SenseVoltage", REG_ACCESS_RO},
    {eCh1_SenseCurrent, "C1SI", "Ch1_SenseCurrent", REG_ACCESS_RO},
    {eCh1_CellTemp, "C1TEMP", "Ch1_CellTemp", REG_ACCESS_RO},
    {eCh1_ChargeAcc_mAh, "C1CA", "Ch1_ChargeAcc_mAh", REG_ACCESS_RO},
    {eCh1_ChargeAcc_mWh, "C1CW", "Ch1_ChargeAcc_mWh", REG_ACCESS_RO},
    {eCh1_ChargeRuntime_s, "C1CHS", "Ch1_ChargeRuntime_s", REG_ACCESS_RO},
    {eCh1_DischargeAcc_mAh, "C1DA", "Ch1_DischargeAcc_mAh", REG_ACCESS_RO},
    {eCh1_DischargeAcc_mWh, "C1DW", "Ch1_DischargeAcc_mWh", REG_ACCESS_RO},
    {eCh1_DischargeRuntime_s, "C1DHS", "Ch1_DischargeRuntime_s", REG_ACCESS_RO},
    // Channel 2 runtime
    {eCh2_Status, "C2S", "Ch2_Status", REG_ACCESS_RO},
    {eCh2_CellVoltage, "C2VOLT", "Ch2_CellVoltage", REG_ACCESS_RO},
    {eCh2_CellCurrent, "C2CURR", "Ch2_CellCurrent", REG_ACCESS_RO},
    {eCh2_SenseVoltage, "C2SV", "Ch2_SenseVoltage", REG_ACCESS_RO},
    {eCh2_SenseCurrent, "C2SI", "Ch2_SenseCurrent", REG_ACCESS_RO},
    {eCh2_CellTemp, "C2TEMP", "Ch2_CellTemp", REG_ACCESS_RO},
    {eCh2_ChargeAcc_mAh, "C2CA", "Ch2_ChargeAcc_mAh", REG_ACCESS_RO},
    {eCh2_ChargeAcc_mWh, "C2CW", "Ch2_ChargeAcc_mWh", REG_ACCESS_RO},
    {eCh2_ChargeRuntime_s, "C2CHS", "Ch2_ChargeRuntime_s", REG_ACCESS_RO},
    {eCh2_DischargeAcc_mAh, "C2DA", "Ch2_DischargeAcc_mAh", REG_ACCESS_RO},
    {eCh2_DischargeAcc_mWh, "C2DW", "Ch2_DischargeAcc_mWh", REG_ACCESS_RO},
    {eCh2_DischargeRuntime_s, "C2DHS", "Ch2_DischargeRuntime_s", REG_ACCESS_RO},
    // Channel 3 runtime
    {eCh3_Status, "C3S", "Ch3_Status", REG_ACCESS_RO},
    {eCh3_CellVoltage, "C3VOLT", "Ch3_CellVoltage", REG_ACCESS_RO},
    {eCh3_CellCurrent, "C3CURR", "Ch3_CellCurrent", REG_ACCESS_RO},
    {eCh3_SenseVoltage, "C3SV", "Ch3_SenseVoltage", REG_ACCESS_RO},
    {eCh3_SenseCurrent, "C3SI", "Ch3_SenseCurrent", REG_ACCESS_RO},
    {eCh3_CellTemp, "C3TEMP", "Ch3_CellTemp", REG_ACCESS_RO},
    {eCh3_ChargeAcc_mAh, "C3CA", "Ch3_ChargeAcc_mAh", REG_ACCESS_RO},
    {eCh3_ChargeAcc_mWh, "C3CW", "Ch3_ChargeAcc_mWh", REG_ACCESS_RO},
    {eCh3_ChargeRuntime_s, "C3CHS", "Ch3_ChargeRuntime_s", REG_ACCESS_RO},
    {eCh3_DischargeAcc_mAh, "C3DA", "Ch3_DischargeAcc_mAh", REG_ACCESS_RO},
    {eCh3_DischargeAcc_mWh, "C3DW", "Ch3_DischargeAcc_mWh", REG_ACCESS_RO},
    {eCh3_DischargeRuntime_s, "C3DHS", "Ch3_DischargeRuntime_s", REG_ACCESS_RO},
    // Channel 4 runtime
    {eCh4_Status, "C4S", "Ch4_Status", REG_ACCESS_RO},
    {eCh4_CellVoltage, "C4VOLT", "Ch4_CellVoltage", REG_ACCESS_RO},
    {eCh4_CellCurrent, "C4CURR", "Ch4_CellCurrent", REG_ACCESS_RO},
    {eCh4_SenseVoltage, "C4SV", "Ch4_SenseVoltage", REG_ACCESS_RO},
    {eCh4_SenseCurrent, "C4SI", "Ch4_SenseCurrent", REG_ACCESS_RO},
    {eCh4_CellTemp, "C4TEMP", "Ch4_CellTemp", REG_ACCESS_RO},
    {eCh4_ChargeAcc_mAh, "C4CA", "Ch4_ChargeAcc_mAh", REG_ACCESS_RO},
    {eCh4_ChargeAcc_mWh, "C4CW", "Ch4_ChargeAcc_mWh", REG_ACCESS_RO},
    {eCh4_ChargeRuntime_s, "C4CHS", "Ch4_ChargeRuntime_s", REG_ACCESS_RO},
    {eCh4_DischargeAcc_mAh, "C4DA", "Ch4_DischargeAcc_mAh", REG_ACCESS_RO},
    {eCh4_DischargeAcc_mWh, "C4DW", "Ch4_DischargeAcc_mWh", REG_ACCESS_RO},
    {eCh4_DischargeRuntime_s, "C4DHS", "Ch4_DischargeRuntime_s", REG_ACCESS_RO},
    // Channel 5 runtime
    {eCh5_Status, "C5S", "Ch5_Status", REG_ACCESS_RO},
    {eCh5_CellVoltage, "C5VOLT", "Ch5_CellVoltage", REG_ACCESS_RO},
    {eCh5_CellCurrent, "C5CURR", "Ch5_CellCurrent", REG_ACCESS_RO},
    {eCh5_SenseVoltage, "C5SV", "Ch5_SenseVoltage", REG_ACCESS_RO},
    {eCh5_SenseCurrent, "C5SI", "Ch5_SenseCurrent", REG_ACCESS_RO},
    {eCh5_CellTemp, "C5TEMP", "Ch5_CellTemp", REG_ACCESS_RO},
    {eCh5_ChargeAcc_mAh, "C5CA", "Ch5_ChargeAcc_mAh", REG_ACCESS_RO},
    {eCh5_ChargeAcc_mWh, "C5CW", "Ch5_ChargeAcc_mWh", REG_ACCESS_RO},
    {eCh5_ChargeRuntime_s, "C5CHS", "Ch5_ChargeRuntime_s", REG_ACCESS_RO},
    {eCh5_DischargeAcc_mAh, "C5DA", "Ch5_DischargeAcc_mAh", REG_ACCESS_RO},
    {eCh5_DischargeAcc_mWh, "C5DW", "Ch5_DischargeAcc_mWh", REG_ACCESS_RO},
    {eCh5_DischargeRuntime_s, "C5DHS", "Ch5_DischargeRuntime_s", REG_ACCESS_RO},
    // Channel 6 runtime
    {eCh6_Status, "C6S", "Ch6_Status", REG_ACCESS_RO},
    {eCh6_CellVoltage, "C6VOLT", "Ch6_CellVoltage", REG_ACCESS_RO},
    {eCh6_CellCurrent, "C6CURR", "Ch6_CellCurrent", REG_ACCESS_RO},
    {eCh6_SenseVoltage, "C6SV", "Ch6_SenseVoltage", REG_ACCESS_RO},
    {eCh6_SenseCurrent, "C6SI", "Ch6_SenseCurrent", REG_ACCESS_RO},
    {eCh6_CellTemp, "C6TEMP", "Ch6_CellTemp", REG_ACCESS_RO},
    {eCh6_ChargeAcc_mAh, "C6CA", "Ch6_ChargeAcc_mAh", REG_ACCESS_RO},
    {eCh6_ChargeAcc_mWh, "C6CW", "Ch6_ChargeAcc_mWh", REG_ACCESS_RO},
    {eCh6_ChargeRuntime_s, "C6CHS", "Ch6_ChargeRuntime_s", REG_ACCESS_RO},
    {eCh6_DischargeAcc_mAh, "C6DA", "Ch6_DischargeAcc_mAh", REG_ACCESS_RO},
    {eCh6_DischargeAcc_mWh, "C6DW", "Ch6_DischargeAcc_mWh", REG_ACCESS_RO},
    {eCh6_DischargeRuntime_s, "C6DHS", "Ch6_DischargeRuntime_s", REG_ACCESS_RO},
    // Channel 7 runtime
    {eCh7_Status, "C7S", "Ch7_Status", REG_ACCESS_RO},
    {eCh7_CellVoltage, "C7VOLT", "Ch7_CellVoltage", REG_ACCESS_RO},
    {eCh7_CellCurrent, "C7CURR", "Ch7_CellCurrent", REG_ACCESS_RO},
    {eCh7_SenseVoltage, "C7SV", "Ch7_SenseVoltage", REG_ACCESS_RO},
    {eCh7_SenseCurrent, "C7SI", "Ch7_SenseCurrent", REG_ACCESS_RO},
    {eCh7_CellTemp, "C7TEMP", "Ch7_CellTemp", REG_ACCESS_RO},
    {eCh7_ChargeAcc_mAh, "C7CA", "Ch7_ChargeAcc_mAh", REG_ACCESS_RO},
    {eCh7_ChargeAcc_mWh, "C7CW", "Ch7_ChargeAcc_mWh", REG_ACCESS_RO},
    {eCh7_ChargeRuntime_s, "C7CHS", "Ch7_ChargeRuntime_s", REG_ACCESS_RO},
    {eCh7_DischargeAcc_mAh, "C7DA", "Ch7_DischargeAcc_mAh", REG_ACCESS_RO},
    {eCh7_DischargeAcc_mWh, "C7DW", "Ch7_DischargeAcc_mWh", REG_ACCESS_RO},
    {eCh7_DischargeRuntime_s, "C7DHS", "Ch7_DischargeRuntime_s", REG_ACCESS_RO},
    // Settings block
    {eCh0_Mode, "C0M", "Ch0_Mode", REG_ACCESS_RW},
    {eCh0_VoltageMin, "C0VMIN", "Ch0_VoltageMin", REG_ACCESS_RW},
    {eCh0_VoltageMax, "C0VMAX", "Ch0_VoltageMax", REG_ACCESS_RW},
    {eCh0_CurrentMin, "C0IMIN", "Ch0_CurrentMin", REG_ACCESS_RW},
    {eCh0_CurrentMax, "C0IMAX", "Ch0_CurrentMax", REG_ACCESS_RW},
    {eCh0_MaxCellTemp, "C0TMAX", "Ch0_MaxCellTemp", REG_ACCESS_RW},
    {eCh0_F28V_Gain, "C0F28VG", "Ch0_F28V_Gain", REG_ACCESS_RW},
    {eCh0_F28V_Offset, "C0F28VO", "Ch0_F28V_Offset", REG_ACCESS_RW},
    {eCh0_F28I_Gain, "C0F28IG", "Ch0_F28I_Gain", REG_ACCESS_RW},
    {eCh0_F28I_Offset, "C0F28IO", "Ch0_F28I_Offset", REG_ACCESS_RW},
    {eCh0_IoutGain_pu, "C0IGPU", "Ch0_IoutGain_pu", REG_ACCESS_RW},
    {eCh0_IoutOffset_pu, "C0IOPU", "Ch0_IoutOffset_pu", REG_ACCESS_RW},
    {eCh0_IoutGain_A, "C0IGA", "Ch0_IoutGain_A", REG_ACCESS_RW},
    {eCh0_IoutOffset_A, "C0IOA", "Ch0_IoutOffset_A", REG_ACCESS_RW},
    {eCh0_VoutGain_pu, "C0VGPU", "Ch0_VoutGain_pu", REG_ACCESS_RW},
    {eCh0_VoutOffset_pu, "C0VOPU", "Ch0_VoutOffset_pu", REG_ACCESS_RW},
    {eCh0_VoutGain_V, "C0VGV", "Ch0_VoutGain_V", REG_ACCESS_RW},
    {eCh0_VoutOffset_V, "C0VOV", "Ch0_VoutOffset_V", REG_ACCESS_RW},
    {eCh1_Mode, "C1M", "Ch1_Mode", REG_ACCESS_RW},
    {eCh1_VoltageMin, "C1VMIN", "Ch1_VoltageMin", REG_ACCESS_RW},
    {eCh1_VoltageMax, "C1VMAX", "Ch1_VoltageMax", REG_ACCESS_RW},
    {eCh1_CurrentMin, "C1IMIN", "Ch1_CurrentMin", REG_ACCESS_RW},
    {eCh1_CurrentMax, "C1IMAX", "Ch1_CurrentMax", REG_ACCESS_RW},
    {eCh1_MaxCellTemp, "C1TMAX", "Ch1_MaxCellTemp", REG_ACCESS_RW},
    {eCh1_F28V_Gain, "C1F28VG", "Ch1_F28V_Gain", REG_ACCESS_RW},
    {eCh1_F28V_Offset, "C1F28VO", "Ch1_F28V_Offset", REG_ACCESS_RW},
    {eCh1_F28I_Gain, "C1F28IG", "Ch1_F28I_Gain", REG_ACCESS_RW},
    {eCh1_F28I_Offset, "C1F28IO", "Ch1_F28I_Offset", REG_ACCESS_RW},
    {eCh1_IoutGain_pu, "C1IGPU", "Ch1_IoutGain_pu", REG_ACCESS_RW},
    {eCh1_IoutOffset_pu, "C1IOPU", "Ch1_IoutOffset_pu", REG_ACCESS_RW},
    {eCh1_IoutGain_A, "C1IGA", "Ch1_IoutGain_A", REG_ACCESS_RW},
    {eCh1_IoutOffset_A, "C1IOA", "Ch1_IoutOffset_A", REG_ACCESS_RW},
    {eCh1_VoutGain_pu, "C1VGPU", "Ch1_VoutGain_pu", REG_ACCESS_RW},
    {eCh1_VoutOffset_pu, "C1VOPU", "Ch1_VoutOffset_pu", REG_ACCESS_RW},
    {eCh1_VoutGain_V, "C1VGV", "Ch1_VoutGain_V", REG_ACCESS_RW},
    {eCh1_VoutOffset_V, "C1VOV", "Ch1_VoutOffset_V", REG_ACCESS_RW},
    {eCh2_Mode, "C2M", "Ch2_Mode", REG_ACCESS_RW},
    {eCh2_VoltageMin, "C2VMIN", "Ch2_VoltageMin", REG_ACCESS_RW},
    {eCh2_VoltageMax, "C2VMAX", "Ch2_VoltageMax", REG_ACCESS_RW},
    {eCh2_CurrentMin, "C2IMIN", "Ch2_CurrentMin", REG_ACCESS_RW},
    {eCh2_CurrentMax, "C2IMAX", "Ch2_CurrentMax", REG_ACCESS_RW},
    {eCh2_MaxCellTemp, "C2TMAX", "Ch2_MaxCellTemp", REG_ACCESS_RW},
    {eCh2_F28V_Gain, "C2F28VG", "Ch2_F28V_Gain", REG_ACCESS_RW},
    {eCh2_F28V_Offset, "C2F28VO", "Ch2_F28V_Offset", REG_ACCESS_RW},
    {eCh2_F28I_Gain, "C2F28IG", "Ch2_F28I_Gain", REG_ACCESS_RW},
    {eCh2_F28I_Offset, "C2F28IO", "Ch2_F28I_Offset", REG_ACCESS_RW},
    {eCh2_IoutGain_pu, "C2IGPU", "Ch2_IoutGain_pu", REG_ACCESS_RW},
    {eCh2_IoutOffset_pu, "C2IOPU", "Ch2_IoutOffset_pu", REG_ACCESS_RW},
    {eCh2_IoutGain_A, "C2IGA", "Ch2_IoutGain_A", REG_ACCESS_RW},
    {eCh2_IoutOffset_A, "C2IOA", "Ch2_IoutOffset_A", REG_ACCESS_RW},
    {eCh2_VoutGain_pu, "C2VGPU", "Ch2_VoutGain_pu", REG_ACCESS_RW},
    {eCh2_VoutOffset_pu, "C2VOPU", "Ch2_VoutOffset_pu", REG_ACCESS_RW},
    {eCh2_VoutGain_V, "C2VGV", "Ch2_VoutGain_V", REG_ACCESS_RW},
    {eCh2_VoutOffset_V, "C2VOV", "Ch2_VoutOffset_V", REG_ACCESS_RW},
    {eCh3_Mode, "C3M", "Ch3_Mode", REG_ACCESS_RW},
    {eCh3_VoltageMin, "C3VMIN", "Ch3_VoltageMin", REG_ACCESS_RW},
    {eCh3_VoltageMax, "C3VMAX", "Ch3_VoltageMax", REG_ACCESS_RW},
    {eCh3_CurrentMin, "C3IMIN", "Ch3_CurrentMin", REG_ACCESS_RW},
    {eCh3_CurrentMax, "C3IMAX", "Ch3_CurrentMax", REG_ACCESS_RW},
    {eCh3_MaxCellTemp, "C3TMAX", "Ch3_MaxCellTemp", REG_ACCESS_RW},
    {eCh3_F28V_Gain, "C3F28VG", "Ch3_F28V_Gain", REG_ACCESS_RW},
    {eCh3_F28V_Offset, "C3F28VO", "Ch3_F28V_Offset", REG_ACCESS_RW},
    {eCh3_F28I_Gain, "C3F28IG", "Ch3_F28I_Gain", REG_ACCESS_RW},
    {eCh3_F28I_Offset, "C3F28IO", "Ch3_F28I_Offset", REG_ACCESS_RW},
    {eCh3_IoutGain_pu, "C3IGPU", "Ch3_IoutGain_pu", REG_ACCESS_RW},
    {eCh3_IoutOffset_pu, "C3IOPU", "Ch3_IoutOffset_pu", REG_ACCESS_RW},
    {eCh3_IoutGain_A, "C3IGA", "Ch3_IoutGain_A", REG_ACCESS_RW},
    {eCh3_IoutOffset_A, "C3IOA", "Ch3_IoutOffset_A", REG_ACCESS_RW},
    {eCh3_VoutGain_pu, "C3VGPU", "Ch3_VoutGain_pu", REG_ACCESS_RW},
    {eCh3_VoutOffset_pu, "C3VOPU", "Ch3_VoutOffset_pu", REG_ACCESS_RW},
    {eCh3_VoutGain_V, "C3VGV", "Ch3_VoutGain_V", REG_ACCESS_RW},
    {eCh3_VoutOffset_V, "C3VOV", "Ch3_VoutOffset_V", REG_ACCESS_RW},
    {eCh4_Mode, "C4M", "Ch4_Mode", REG_ACCESS_RW},
    {eCh4_VoltageMin, "C4VMIN", "Ch4_VoltageMin", REG_ACCESS_RW},
    {eCh4_VoltageMax, "C4VMAX", "Ch4_VoltageMax", REG_ACCESS_RW},
    {eCh4_CurrentMin, "C4IMIN", "Ch4_CurrentMin", REG_ACCESS_RW},
    {eCh4_CurrentMax, "C4IMAX", "Ch4_CurrentMax", REG_ACCESS_RW},
    {eCh4_MaxCellTemp, "C4TMAX", "Ch4_MaxCellTemp", REG_ACCESS_RW},
    {eCh4_F28V_Gain, "C4F28VG", "Ch4_F28V_Gain", REG_ACCESS_RW},
    {eCh4_F28V_Offset, "C4F28VO", "Ch4_F28V_Offset", REG_ACCESS_RW},
    {eCh4_F28I_Gain, "C4F28IG", "Ch4_F28I_Gain", REG_ACCESS_RW},
    {eCh4_F28I_Offset, "C4F28IO", "Ch4_F28I_Offset", REG_ACCESS_RW},
    {eCh4_IoutGain_pu, "C4IGPU", "Ch4_IoutGain_pu", REG_ACCESS_RW},
    {eCh4_IoutOffset_pu, "C4IOPU", "Ch4_IoutOffset_pu", REG_ACCESS_RW},
    {eCh4_IoutGain_A, "C4IGA", "Ch4_IoutGain_A", REG_ACCESS_RW},
    {eCh4_IoutOffset_A, "C4IOA", "Ch4_IoutOffset_A", REG_ACCESS_RW},
    {eCh4_VoutGain_pu, "C4VGPU", "Ch4_VoutGain_pu", REG_ACCESS_RW},
    {eCh4_VoutOffset_pu, "C4VOPU", "Ch4_VoutOffset_pu", REG_ACCESS_RW},
    {eCh4_VoutGain_V, "C4VGV", "Ch4_VoutGain_V", REG_ACCESS_RW},
    {eCh4_VoutOffset_V, "C4VOV", "Ch4_VoutOffset_V", REG_ACCESS_RW},
    {eCh5_Mode, "C5M", "Ch5_Mode", REG_ACCESS_RW},
    {eCh5_VoltageMin, "C5VMIN", "Ch5_VoltageMin", REG_ACCESS_RW},
    {eCh5_VoltageMax, "C5VMAX", "Ch5_VoltageMax", REG_ACCESS_RW},
    {eCh5_CurrentMin, "C5IMIN", "Ch5_CurrentMin", REG_ACCESS_RW},
    {eCh5_CurrentMax, "C5IMAX", "Ch5_CurrentMax", REG_ACCESS_RW},
    {eCh5_MaxCellTemp, "C5TMAX", "Ch5_MaxCellTemp", REG_ACCESS_RW},
    {eCh5_F28V_Gain, "C5F28VG", "Ch5_F28V_Gain", REG_ACCESS_RW},
    {eCh5_F28V_Offset, "C5F28VO", "Ch5_F28V_Offset", REG_ACCESS_RW},
    {eCh5_F28I_Gain, "C5F28IG", "Ch5_F28I_Gain", REG_ACCESS_RW},
    {eCh5_F28I_Offset, "C5F28IO", "Ch5_F28I_Offset", REG_ACCESS_RW},
    {eCh5_IoutGain_pu, "C5IGPU", "Ch5_IoutGain_pu", REG_ACCESS_RW},
    {eCh5_IoutOffset_pu, "C5IOPU", "Ch5_IoutOffset_pu", REG_ACCESS_RW},
    {eCh5_IoutGain_A, "C5IGA", "Ch5_IoutGain_A", REG_ACCESS_RW},
    {eCh5_IoutOffset_A, "C5IOA", "Ch5_IoutOffset_A", REG_ACCESS_RW},
    {eCh5_VoutGain_pu, "C5VGPU", "Ch5_VoutGain_pu", REG_ACCESS_RW},
    {eCh5_VoutOffset_pu, "C5VOPU", "Ch5_VoutOffset_pu", REG_ACCESS_RW},
    {eCh5_VoutGain_V, "C5VGV", "Ch5_VoutGain_V", REG_ACCESS_RW},
    {eCh5_VoutOffset_V, "C5VOV", "Ch5_VoutOffset_V", REG_ACCESS_RW},
    {eCh6_Mode, "C6M", "Ch6_Mode", REG_ACCESS_RW},
    {eCh6_VoltageMin, "C6VMIN", "Ch6_VoltageMin", REG_ACCESS_RW},
    {eCh6_VoltageMax, "C6VMAX", "Ch6_VoltageMax", REG_ACCESS_RW},
    {eCh6_CurrentMin, "C6IMIN", "Ch6_CurrentMin", REG_ACCESS_RW},
    {eCh6_CurrentMax, "C6IMAX", "Ch6_CurrentMax", REG_ACCESS_RW},
    {eCh6_MaxCellTemp, "C6TMAX", "Ch6_MaxCellTemp", REG_ACCESS_RW},
    {eCh6_F28V_Gain, "C6F28VG", "Ch6_F28V_Gain", REG_ACCESS_RW},
    {eCh6_F28V_Offset, "C6F28VO", "Ch6_F28V_Offset", REG_ACCESS_RW},
    {eCh6_F28I_Gain, "C6F28IG", "Ch6_F28I_Gain", REG_ACCESS_RW},
    {eCh6_F28I_Offset, "C6F28IO", "Ch6_F28I_Offset", REG_ACCESS_RW},
    {eCh6_IoutGain_pu, "C6IGPU", "Ch6_IoutGain_pu", REG_ACCESS_RW},
    {eCh6_IoutOffset_pu, "C6IOPU", "Ch6_IoutOffset_pu", REG_ACCESS_RW},
    {eCh6_IoutGain_A, "C6IGA", "Ch6_IoutGain_A", REG_ACCESS_RW},
    {eCh6_IoutOffset_A, "C6IOA", "Ch6_IoutOffset_A", REG_ACCESS_RW},
    {eCh6_VoutGain_pu, "C6VGPU", "Ch6_VoutGain_pu", REG_ACCESS_RW},
    {eCh6_VoutOffset_pu, "C6VOPU", "Ch6_VoutOffset_pu", REG_ACCESS_RW},
    {eCh6_VoutGain_V, "C6VGV", "Ch6_VoutGain_V", REG_ACCESS_RW},
    {eCh6_VoutOffset_V, "C6VOV", "Ch6_VoutOffset_V", REG_ACCESS_RW},
    {eCh7_Mode, "C7M", "Ch7_Mode", REG_ACCESS_RW},
    {eCh7_VoltageMin, "C7VMIN", "Ch7_VoltageMin", REG_ACCESS_RW},
    {eCh7_VoltageMax, "C7VMAX", "Ch7_VoltageMax", REG_ACCESS_RW},
    {eCh7_CurrentMin, "C7IMIN", "Ch7_CurrentMin", REG_ACCESS_RW},
    {eCh7_CurrentMax, "C7IMAX", "Ch7_CurrentMax", REG_ACCESS_RW},
    {eCh7_MaxCellTemp, "C7TMAX", "Ch7_MaxCellTemp", REG_ACCESS_RW},
    {eCh7_F28V_Gain, "C7F28VG", "Ch7_F28V_Gain", REG_ACCESS_RW},
    {eCh7_F28V_Offset, "C7F28VO", "Ch7_F28V_Offset", REG_ACCESS_RW},
    {eCh7_F28I_Gain, "C7F28IG", "Ch7_F28I_Gain", REG_ACCESS_RW},
    {eCh7_F28I_Offset, "C7F28IO", "Ch7_F28I_Offset", REG_ACCESS_RW},
    {eCh7_IoutGain_pu, "C7IGPU", "Ch7_IoutGain_pu", REG_ACCESS_RW},
    {eCh7_IoutOffset_pu, "C7IOPU", "Ch7_IoutOffset_pu", REG_ACCESS_RW},
    {eCh7_IoutGain_A, "C7IGA", "Ch7_IoutGain_A", REG_ACCESS_RW},
    {eCh7_IoutOffset_A, "C7IOA", "Ch7_IoutOffset_A", REG_ACCESS_RW},
    {eCh7_VoutGain_pu, "C7VGPU", "Ch7_VoutGain_pu", REG_ACCESS_RW},
    {eCh7_VoutOffset_pu, "C7VOPU", "Ch7_VoutOffset_pu", REG_ACCESS_RW},
    {eCh7_VoutGain_V, "C7VGV", "Ch7_VoutGain_V", REG_ACCESS_RW},
    {eCh7_VoutOffset_V, "C7VOV", "Ch7_VoutOffset_V", REG_ACCESS_RW},
    // Unit block
    {eChargeDisableV, "CDV", "ChargeDisableV", REG_ACCESS_RW},
    {eChargeRestrictV, "CRV", "ChargeRestrictV", REG_ACCESS_RW},
    {eDischargeRestrictV, "DRV", "DischargeRestrictV", REG_ACCESS_RW},
    {eDischargeDisableV, "DDV", "DischargeDisableV", REG_ACCESS_RW},
    {eCalibrationMode, "CALM", "CalibrationMode", REG_ACCESS_RW},
    {eUnitState, "UNITST", "UnitState", REG_ACCESS_RO},
    {eInputVoltage, "VIN", "InputVoltage", REG_ACCESS_RO},
    {eTripStatus, "TRIPS", "TripStatus", REG_ACCESS_RO},
    {eSlotMode, "SMD", "SlotMode", REG_ACCESS_RO},
    {eSlotEnable, "SEN", "SlotEnable", REG_ACCESS_RO},
    {eGroupSize, "SGS", "GroupSize", REG_ACCESS_RO},
    {eHostWatchdog_s, "WD", "HostWatchdog_s", REG_ACCESS_RW},
    {eCalSlot, "CALSLOT", "CalSlot", REG_ACCESS_RW},
    {eCalCommand, "CALCMD", "CalCommand", REG_ACCESS_RW},
    {eCalArgument, "CALARG", "CalArgument", REG_ACCESS_RW},
    {eCalStatus, "CALSTAT", "CalStatus", REG_ACCESS_RO},
    {eCalResult, "CALRES", "CalResult", REG_ACCESS_RO},
    {eWatchdogRemaining_s, "WDREM", "WatchdogRemaining_s", REG_ACCESS_RO},
    {eCalAdsV_pu, "CALAVPU", "CalAdsV_pu", REG_ACCESS_RO},
    {eCalAdsI_pu, "CALAIPU", "CalAdsI_pu", REG_ACCESS_RO},
    {eCalAdsV_V, "CALAVV", "CalAdsV_V", REG_ACCESS_RO},
    {eCalAdsI_A, "CALAIA", "CalAdsI_A", REG_ACCESS_RO},
    {eCalF28V_pu, "CALFVPU", "CalF28V_pu", REG_ACCESS_RO},
    {eCalF28I_pu, "CALFIPU", "CalF28I_pu", REG_ACCESS_RO},
    {eCalF28V_V, "CALFVV", "CalF28V_V", REG_ACCESS_RO},
    {eCalF28I_A, "CALFIA", "CalF28I_A", REG_ACCESS_RO},
    {eCalTemp_C, "CALTEMP", "CalTemp_C", REG_ACCESS_RO}
};
