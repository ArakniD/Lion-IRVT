/*
 * registers.h
 *
 *  Created on: 15 Apr. 2025
 *      Author: lucas
 */

#ifndef REGISTERS_H_
#define REGISTERS_H_

//
//=============================================================================
// includes
//=============================================================================
//
#include "driverlib.h"
#include "device.h"
#include <stdint.h>
#include "bts_user_settings.h"

#define NUM_CHANNELS 8
#define NUM_CONTROL_REGISTERS (NUM_CHANNELS * 10) // 80
#define NUM_STATS_REGISTERS (NUM_CHANNELS * 4)    // 32
#define NUM_CALIBRATION_REGISTERS (NUM_CHANNELS * 8 + 1) // 64 + 1
#define TOTAL_REGISTERS (NUM_CONTROL_REGISTERS + NUM_STATS_REGISTERS + NUM_CALIBRATION_REGISTERS) // 177

// CAN bus configuration
#define CAN_BITRATE 500000 // 500 kbps
#define CAN_MSG_ID_BASE 0x1C000000 // Base for 29-bit ID
#define CAN_DEVICE_ID 0x0001 // Example device ID

typedef enum {
    REG_ACCESS_RO,  // Read-only
    REG_ACCESS_RW   // Read/write
} RegAccessType;

typedef enum {
    // Control Block (80 registers)
    eCh0_Mode = 0,
    eCh0_ChargeVoltageMin = 4,
    eCh0_ChargeVoltageMax = 8,
    eCh0_DischargeVoltageMin = 12,
    eCh0_DischargeVoltageMax = 16,
    eCh0_ChargeCurrentMin = 20,
    eCh0_ChargeCurrentMax = 24,
    eCh0_DischargeCurrentMin = 28,
    eCh0_DischargeCurrentMax = 32,
    eCh0_Status = 36,
    eCh1_Mode = 40,
    eCh1_ChargeVoltageMin = 44,
    eCh1_ChargeVoltageMax = 48,
    eCh1_DischargeVoltageMin = 52,
    eCh1_DischargeVoltageMax = 56,
    eCh1_ChargeCurrentMin = 60,
    eCh1_ChargeCurrentMax = 64,
    eCh1_DischargeCurrentMin = 68,
    eCh1_DischargeCurrentMax = 72,
    eCh1_Status = 76,
    eCh2_Mode = 80,
    eCh2_ChargeVoltageMin = 84,
    eCh2_ChargeVoltageMax = 88,
    eCh2_DischargeVoltageMin = 92,
    eCh2_DischargeVoltageMax = 96,
    eCh2_ChargeCurrentMin = 100,
    eCh2_ChargeCurrentMax = 104,
    eCh2_DischargeCurrentMin = 108,
    eCh2_DischargeCurrentMax = 112,
    eCh2_Status = 116,
    eCh3_Mode = 120,
    eCh3_ChargeVoltageMin = 124,
    eCh3_ChargeVoltageMax = 128,
    eCh3_DischargeVoltageMin = 132,
    eCh3_DischargeVoltageMax = 136,
    eCh3_ChargeCurrentMin = 140,
    eCh3_ChargeCurrentMax = 144,
    eCh3_DischargeCurrentMin = 148,
    eCh3_DischargeCurrentMax = 152,
    eCh3_Status = 156,
    eCh4_Mode = 160,
    eCh4_ChargeVoltageMin = 164,
    eCh4_ChargeVoltageMax = 168,
    eCh4_DischargeVoltageMin = 172,
    eCh4_DischargeVoltageMax = 176,
    eCh4_ChargeCurrentMin = 180,
    eCh4_ChargeCurrentMax = 184,
    eCh4_DischargeCurrentMin = 188,
    eCh4_DischargeCurrentMax = 192,
    eCh4_Status = 196,
    eCh5_Mode = 200,
    eCh5_ChargeVoltageMin = 204,
    eCh5_ChargeVoltageMax = 208,
    eCh5_DischargeVoltageMin = 212,
    eCh5_DischargeVoltageMax = 216,
    eCh5_ChargeCurrentMin = 220,
    eCh5_ChargeCurrentMax = 224,
    eCh5_DischargeCurrentMin = 228,
    eCh5_DischargeCurrentMax = 232,
    eCh5_Status = 236,
    eCh6_Mode = 240,
    eCh6_ChargeVoltageMin = 244,
    eCh6_ChargeVoltageMax = 248,
    eCh6_DischargeVoltageMin = 252,
    eCh6_DischargeVoltageMax = 256,
    eCh6_ChargeCurrentMin = 260,
    eCh6_ChargeCurrentMax = 264,
    eCh6_DischargeCurrentMin = 268,
    eCh6_DischargeCurrentMax = 272,
    eCh6_Status = 276,
    eCh7_Mode = 280,
    eCh7_ChargeVoltageMin = 284,
    eCh7_ChargeVoltageMax = 288,
    eCh7_DischargeVoltageMin = 292,
    eCh7_DischargeVoltageMax = 296,
    eCh7_ChargeCurrentMin = 300,
    eCh7_ChargeCurrentMax = 304,
    eCh7_DischargeCurrentMin = 308,
    eCh7_DischargeCurrentMax = 312,
    eCh7_Status = 316,
    // Stats Block (32 registers)
    eCh0_CurrentAcc = 320,
    eCh0_MinVoltage = 324,
    eCh0_MaxVoltage = 328,
    eCh0_PowerAcc = 332,
    eCh1_CurrentAcc = 336,
    eCh1_MinVoltage = 340,
    eCh1_MaxVoltage = 344,
    eCh1_PowerAcc = 348,
    eCh2_CurrentAcc = 352,
    eCh2_MinVoltage = 356,
    eCh2_MaxVoltage = 360,
    eCh2_PowerAcc = 364,
    eCh3_CurrentAcc = 368,
    eCh3_MinVoltage = 372,
    eCh3_MaxVoltage = 376,
    eCh3_PowerAcc = 380,
    eCh4_CurrentAcc = 384,
    eCh4_MinVoltage = 388,
    eCh4_MaxVoltage = 392,
    eCh4_PowerAcc = 396,
    eCh5_CurrentAcc = 400,
    eCh5_MinVoltage = 404,
    eCh5_MaxVoltage = 408,
    eCh5_PowerAcc = 412,
    eCh6_CurrentAcc = 416,
    eCh6_MinVoltage = 420,
    eCh6_MaxVoltage = 424,
    eCh6_PowerAcc = 428,
    eCh7_CurrentAcc = 432,
    eCh7_MinVoltage = 436,
    eCh7_MaxVoltage = 440,
    eCh7_PowerAcc = 444,
    // Calibration Block (64 + 1 registers)
    eCh0_IoutGain_pu = 448,
    eCh0_IoutOffset_pu = 452,
    eCh0_IoutGain_A = 456,
    eCh0_IoutOffset_A = 460,
    eCh0_VoutGain_pu = 464,
    eCh0_VoutOffset_pu = 468,
    eCh0_VoutGain_V = 472,
    eCh0_VoutOffset_V = 476,
    eCh1_IoutGain_pu = 480,
    eCh1_IoutOffset_pu = 484,
    eCh1_IoutGain_A = 488,
    eCh1_IoutOffset_A = 492,
    eCh1_VoutGain_pu = 496,
    eCh1_VoutOffset_pu = 500,
    eCh1_VoutGain_V = 504,
    eCh1_VoutOffset_V = 508,
    eCh2_IoutGain_pu = 512,
    eCh2_IoutOffset_pu = 516,
    eCh2_IoutGain_A = 520,
    eCh2_IoutOffset_A = 524,
    eCh2_VoutGain_pu = 528,
    eCh2_VoutOffset_pu = 532,
    eCh2_VoutGain_V = 536,
    eCh2_VoutOffset_V = 540,
    eCh3_IoutGain_pu = 544,
    eCh3_IoutOffset_pu = 548,
    eCh3_IoutGain_A = 552,
    eCh3_IoutOffset_A = 556,
    eCh3_VoutGain_pu = 560,
    eCh3_VoutOffset_pu = 564,
    eCh3_VoutGain_V = 568,
    eCh3_VoutOffset_V = 572,
    eCh4_IoutGain_pu = 576,
    eCh4_IoutOffset_pu = 580,
    eCh4_IoutGain_A = 584,
    eCh4_IoutOffset_A = 588,
    eCh4_VoutGain_pu = 592,
    eCh4_VoutOffset_pu = 596,
    eCh4_VoutGain_V = 600,
    eCh4_VoutOffset_V = 604,
    eCh5_IoutGain_pu = 608,
    eCh5_IoutOffset_pu = 612,
    eCh5_IoutGain_A = 616,
    eCh5_IoutOffset_A = 620,
    eCh5_VoutGain_pu = 624,
    eCh5_VoutOffset_pu = 628,
    eCh5_VoutGain_V = 632,
    eCh5_VoutOffset_V = 636,
    eCh6_IoutGain_pu = 640,
    eCh6_IoutOffset_pu = 644,
    eCh6_IoutGain_A = 648,
    eCh6_IoutOffset_A = 652,
    eCh6_VoutGain_pu = 656,
    eCh6_VoutOffset_pu = 660,
    eCh6_VoutGain_V = 664,
    eCh6_VoutOffset_V = 668,
    eCh7_IoutGain_pu = 672,
    eCh7_IoutOffset_pu = 676,
    eCh7_IoutGain_A = 680,
    eCh7_IoutOffset_A = 684,
    eCh7_VoutGain_pu = 688,
    eCh7_VoutOffset_pu = 692,
    eCh7_VoutGain_V = 696,
    eCh7_VoutOffset_V = 700,
    eCalibrationMode = 704
} RegisterAddress;

typedef struct {
    uint16_t virtualAddr;   // Register address (from RegisterAddress enum)
    RegAccessType access;   // RO or RW
    uint16_t length;        // Length in bytes (4)
} RegisterConfig;

typedef struct {
    uint16_t virtualAddr;   // Register address (from RegisterAddress enum)
    const char* shortName;  // Short name (e.g., "C0M")
    const char* longName;   // Long name (e.g., "Ch0_Mode")
    RegAccessType access;   // RO or RW
} UARTRegisterConfig;

typedef struct {
    uint32_t running;
    uint32_t stopped;
    uint32_t finished;
    uint32_t overCurrentTrip;
    uint32_t charging;
    uint32_t discharging;
    uint32_t constVoltage;
    uint32_t constCurrent;
} ChannelStatus;

typedef struct _BTS_channelCalibration
{
    /* Header and checksum for forward persistent storage
     * Compatibility and in-place upgrade pathway
     */
    uint32_t  header;
    uint32_t  dateTime;

    float32_t IoutGain_pu;
    float32_t IoutOffset_pu;
    float32_t IoutGain_A;
    float32_t IoutOffset_A;

    float32_t VoutGain_pu;
    float32_t VoutOffset_pu;
    float32_t VoutGain_V;
    float32_t VoutOffset_V;

} BTS_channelCalibration;

typedef struct
{
    /* run-time set points and logic */
    volatile float32_t iref_A;
    volatile float32_t iref_cuttout_A;
    volatile float32_t vref_charge_V;
    volatile float32_t vref_discharge_V;
    volatile uint16_t  direction_logic;
    volatile uint16_t  enable_logic;
    volatile float32_t dutyRef_pu;
    volatile float32_t ioutCal_pu;
    volatile float32_t voutCal_pu;

    /* Calibration Data Entry */
    float32_t IoutGain_pu;
    float32_t IoutOffset_pu;
    float32_t IoutGain_A;
    float32_t IoutOffset_A;

    float32_t VoutGain_pu;
    float32_t VoutOffset_pu;
    float32_t VoutGain_V;
    float32_t VoutOffset_V;

    /* Set to 1 to enforce updating of internal measurement data */
    /* Set to 2 to enforce updating and save to EEPROM */
    uint16_t  pendingUpdate;

}BTS_userInput;

typedef struct
{
    float32_t dutySet_pu; // this variable is used in the open loop
    float32_t dutySetRef_pu;

    float32_t ioutRef_pu;
    float32_t ioutSet_pu;
    float32_t ioutSense_pu;

    float32_t voutRef_pu;
    float32_t voutSet_pu;
    float32_t voutSense_pu;

    float32_t uk_cc_pu;
    float32_t ek_cc_pu;
    float32_t uk_cv_pu;
    float32_t ek_cv_pu;
    float32_t direction_coeff;

    float32_t dutyH_pu;
    float32_t dutyL_pu;

    uint16_t ctrlMode_logic;
    uint16_t direction_logic;

    int16_t ioutTrip_16b;
    int16_t ioutTrip_n_16b;
    uint16_t tripFlag;

}BTS_ctrlLoopVariable;

typedef struct
{
    float32_t Isense_A;
    float32_t Vsense_V;
    int16_t Isense_16b[BTS_senseAverageFactor];
    int16_t Vsense_16b[BTS_senseAverageFactor];
    int32_t Sum_I;
    int32_t Sum_V;
    uint16_t Index;
    float32_t IoutGain_A;
    float32_t IoutOffset_A;
    float32_t VoutGain_V;
    float32_t VoutOffset_V;

}BTS_measValue;


typedef struct {
    uint16_t channel; // 0-7
    float voltage;    // Volts
    float current;    // Amps
    float mAh;        // Milliamp-hours
    float mWh;        // Milliwatt-hours
} CAN_data;

#endif /* REGISTERS_H_ */
