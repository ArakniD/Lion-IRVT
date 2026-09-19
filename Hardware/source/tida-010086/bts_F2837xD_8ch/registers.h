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
#define NUM_STATS_REGISTERS (NUM_CHANNELS * 6)    // 48 (voltage, current)
#define NUM_CALIBRATION_REGISTERS (NUM_CHANNELS * 12 + 16 + 4) // 16 + 4 + 96 (min/max temp, F28V/I gains/offsets, Iout/Vout calibrations, global voltages, calibration mode)
#define NUM_UNIT_REGISTERS (4)
//
// Measured cell temperature, one per channel, from the two ADS1119
// converters on I2CB. These are appended after the unit block rather than
// folded into the stats block on purpose: external hosts (see the ESP32
// bridge in esp32-controller/components/bts_i2c) hard-code the byte
// addresses of every block from 336 upward, so inserting a register
// mid-map would shift them all and change the stats stride.
//
#define NUM_TEMP_MEAS_REGISTERS (NUM_CHANNELS * 1) // 8
//
// Slot grouping, read back from the MODE/ENABLE dip switches. Appended for
// the same reason as the block above - never inserted mid-map.
//
#define NUM_GROUP_REGISTERS (3)
//
// Runtime slot calibration. Unit-scoped rather than per-slot: only one slot
// calibrates at a time, and eight copies of the telemetry window would need
// 144 words of CPU2TOCPU1RAM, which is not available.
//
#define NUM_CAL_CONTROL_REGISTERS (5)
#define NUM_CAL_TELEMETRY_REGISTERS (9)
//
// ADS131M08 engineering values, one pair per slot. The stats block at 336
// carries the 12-bit internal ADC; this is the 16-bit converter, which until
// now was computed every 100 ms and read by nothing.
//
#define NUM_SENSE_REGISTERS (NUM_CHANNELS * 2) // 16
//
// Discharge mAh/mWh accumulators. The pair at 320/332 in the stats block is
// the CHARGE direction; this block is the discharge one. Two blocks rather
// than one signed pair so a charge followed by a discharge on the same slot
// yields two separate positive totals instead of cancelling.
//
#define NUM_DISCHACC_REGISTERS (NUM_CHANNELS * 2) // 16
#define TOTAL_REGISTERS (NUM_CONTROL_REGISTERS + NUM_STATS_REGISTERS + NUM_CALIBRATION_REGISTERS + NUM_UNIT_REGISTERS + NUM_TEMP_MEAS_REGISTERS + NUM_GROUP_REGISTERS + NUM_CAL_CONTROL_REGISTERS + NUM_CAL_TELEMETRY_REGISTERS + NUM_SENSE_REGISTERS + NUM_DISCHACC_REGISTERS) // 305

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
    // Stats Block (48 registers)
    eCh0_ChargeAcc_mAh = 320,
    eCh0_MinVoltage = 324,
    eCh0_MaxVoltage = 328,
    eCh0_ChargeAcc_mWh = 332,
    eCh0_CellVoltage = 336,
    eCh0_CellCurrent = 340,
    eCh1_ChargeAcc_mAh = 344,
    eCh1_MinVoltage = 348,
    eCh1_MaxVoltage = 352,
    eCh1_ChargeAcc_mWh = 356,
    eCh1_CellVoltage = 360,
    eCh1_CellCurrent = 364,
    eCh2_ChargeAcc_mAh = 368,
    eCh2_MinVoltage = 372,
    eCh2_MaxVoltage = 376,
    eCh2_ChargeAcc_mWh = 380,
    eCh2_CellVoltage = 384,
    eCh2_CellCurrent = 388,
    eCh3_ChargeAcc_mAh = 392,
    eCh3_MinVoltage = 396,
    eCh3_MaxVoltage = 400,
    eCh3_ChargeAcc_mWh = 404,
    eCh3_CellVoltage = 408,
    eCh3_CellCurrent = 412,
    eCh4_ChargeAcc_mAh = 416,
    eCh4_MinVoltage = 420,
    eCh4_MaxVoltage = 424,
    eCh4_ChargeAcc_mWh = 428,
    eCh4_CellVoltage = 432,
    eCh4_CellCurrent = 436,
    eCh5_ChargeAcc_mAh = 440,
    eCh5_MinVoltage = 444,
    eCh5_MaxVoltage = 448,
    eCh5_ChargeAcc_mWh = 452,
    eCh5_CellVoltage = 456,
    eCh5_CellCurrent = 460,
    eCh6_ChargeAcc_mAh = 464,
    eCh6_MinVoltage = 468,
    eCh6_MaxVoltage = 472,
    eCh6_ChargeAcc_mWh = 476,
    eCh6_CellVoltage = 480,
    eCh6_CellCurrent = 484,
    eCh7_ChargeAcc_mAh = 488,
    eCh7_MinVoltage = 492,
    eCh7_MaxVoltage = 496,
    eCh7_ChargeAcc_mWh = 500,
    eCh7_CellVoltage = 504,
    eCh7_CellCurrent = 508,
    // Calibration Block (116 registers)
    eCh0_MinCellTemp = 512,
    eCh0_MaxCellTemp = 516,
    eCh1_MinCellTemp = 520,
    eCh1_MaxCellTemp = 524,
    eCh2_MinCellTemp = 528,
    eCh2_MaxCellTemp = 532,
    eCh3_MinCellTemp = 536,
    eCh3_MaxCellTemp = 540,
    eCh4_MinCellTemp = 544,
    eCh4_MaxCellTemp = 548,
    eCh5_MinCellTemp = 552,
    eCh5_MaxCellTemp = 556,
    eCh6_MinCellTemp = 560,
    eCh6_MaxCellTemp = 564,
    eCh7_MinCellTemp = 568,
    eCh7_MaxCellTemp = 572,
    eChargeDisableV = 576,
    eChargeRestrictV = 580,
    eDischargeRestrictV = 584,
    eDischargeDisableV = 588,
    eCh0_F28V_Gain = 592,
    eCh0_F28V_Offset = 596,
    eCh0_F28I_Gain = 600,
    eCh0_F28I_Offset = 604,
    eCh0_IoutGain_pu = 608,
    eCh0_IoutOffset_pu = 612,
    eCh0_IoutGain_A = 616,
    eCh0_IoutOffset_A = 620,
    eCh0_VoutGain_pu = 624,
    eCh0_VoutOffset_pu = 628,
    eCh0_VoutGain_V = 632,
    eCh0_VoutOffset_V = 636,
    eCh1_F28V_Gain = 640,
    eCh1_F28V_Offset = 644,
    eCh1_F28I_Gain = 648,
    eCh1_F28I_Offset = 652,
    eCh1_IoutGain_pu = 656,
    eCh1_IoutOffset_pu = 660,
    eCh1_IoutGain_A = 664,
    eCh1_IoutOffset_A = 668,
    eCh1_VoutGain_pu = 672,
    eCh1_VoutOffset_pu = 676,
    eCh1_VoutGain_V = 680,
    eCh1_VoutOffset_V = 684,
    eCh2_F28V_Gain = 688,
    eCh2_F28V_Offset = 692,
    eCh2_F28I_Gain = 696,
    eCh2_F28I_Offset = 700,
    eCh2_IoutGain_pu = 704,
    eCh2_IoutOffset_pu = 708,
    eCh2_IoutGain_A = 712,
    eCh2_IoutOffset_A = 716,
    eCh2_VoutGain_pu = 720,
    eCh2_VoutOffset_pu = 724,
    eCh2_VoutGain_V = 728,
    eCh2_VoutOffset_V = 732,
    eCh3_F28V_Gain = 736,
    eCh3_F28V_Offset = 740,
    eCh3_F28I_Gain = 744,
    eCh3_F28I_Offset = 748,
    eCh3_IoutGain_pu = 752,
    eCh3_IoutOffset_pu = 756,
    eCh3_IoutGain_A = 760,
    eCh3_IoutOffset_A = 764,
    eCh3_VoutGain_pu = 768,
    eCh3_VoutOffset_pu = 772,
    eCh3_VoutGain_V = 776,
    eCh3_VoutOffset_V = 780,
    eCh4_F28V_Gain = 784,
    eCh4_F28V_Offset = 788,
    eCh4_F28I_Gain = 792,
    eCh4_F28I_Offset = 796,
    eCh4_IoutGain_pu = 800,
    eCh4_IoutOffset_pu = 804,
    eCh4_IoutGain_A = 808,
    eCh4_IoutOffset_A = 812,
    eCh4_VoutGain_pu = 816,
    eCh4_VoutOffset_pu = 820,
    eCh4_VoutGain_V = 824,
    eCh4_VoutOffset_V = 828,
    eCh5_F28V_Gain = 832,
    eCh5_F28V_Offset = 836,
    eCh5_F28I_Gain = 840,
    eCh5_F28I_Offset = 844,
    eCh5_IoutGain_pu = 848,
    eCh5_IoutOffset_pu = 852,
    eCh5_IoutGain_A = 856,
    eCh5_IoutOffset_A = 860,
    eCh5_VoutGain_pu = 864,
    eCh5_VoutOffset_pu = 868,
    eCh5_VoutGain_V = 872,
    eCh5_VoutOffset_V = 876,
    eCh6_F28V_Gain = 880,
    eCh6_F28V_Offset = 884,
    eCh6_F28I_Gain = 888,
    eCh6_F28I_Offset = 892,
    eCh6_IoutGain_pu = 896,
    eCh6_IoutOffset_pu = 900,
    eCh6_IoutGain_A = 904,
    eCh6_IoutOffset_A = 908,
    eCh6_VoutGain_pu = 912,
    eCh6_VoutOffset_pu = 916,
    eCh6_VoutGain_V = 920,
    eCh6_VoutOffset_V = 924,
    eCh7_F28V_Gain = 928,
    eCh7_F28V_Offset = 932,
    eCh7_F28I_Gain = 936,
    eCh7_F28I_Offset = 940,
    eCh7_IoutGain_pu = 944,
    eCh7_IoutOffset_pu = 948,
    eCh7_IoutGain_A = 952,
    eCh7_IoutOffset_A = 956,
    eCh7_VoutGain_pu = 960,
    eCh7_VoutOffset_pu = 964,
    eCh7_VoutGain_V = 968,
    eCh7_VoutOffset_V = 972,
    // Unit Values (3 registers)
    eCalibrationMode = 976,
    eUnitState = 980,
    eInputVoltage = 984,
    eTripStatus = 988, // 32-bit bitfield for trip sources
    // Measured Cell Temperatures (8 registers, RO, degrees C)
    //
    // The measurement, NOT the configured trip window - the min/max pair in
    // the calibration block at 512 holds the limits and is mirrored into the
    // F-RAM image. Written by CPU2 from the ADS1119 DRDY ISRs.
    //
    eCh0_CellTemp = 992,
    eCh1_CellTemp = 996,
    eCh2_CellTemp = 1000,
    eCh3_CellTemp = 1004,
    eCh4_CellTemp = 1008,
    eCh5_CellTemp = 1012,
    eCh6_CellTemp = 1016,
    eCh7_CellTemp = 1020,
    //
    // Slot grouping (3 registers, RO). Latched from the MODE/ENABLE dip
    // switches by CPU1 at boot and mirrored here so a host can see how the
    // unit is strapped without reading the switches itself.
    //
    eSlotMode = 1024,
    eSlotEnable = 1028,
    eGroupSize = 1032,
    //
    // Calibration control (5 registers, unit-scoped). The host writes
    // eCalArgument first, then eCalCommand; the command is consumed on
    // write and eCalCommand self-clears.
    //
    eCalSlot = 1036,
    eCalCommand = 1040,
    eCalArgument = 1044,
    eCalStatus = 1048,
    eCalResult = 1052,
    //
    // Calibration live telemetry (9 registers, RO). A window on the slot
    // named by eCalSlot, zeroed when no slot is selected. The _pu values are
    // the raw normalised converter readings BEFORE any gain/offset - that is
    // the quantity the two-point maths consumes.
    //
    eCalAdsV_pu = 1056,
    eCalAdsI_pu = 1060,
    eCalAdsV_V = 1064,
    eCalAdsI_A = 1068,
    eCalF28V_pu = 1072,
    eCalF28I_pu = 1076,
    eCalF28V_V = 1080,
    eCalF28I_A = 1084,
    eCalTemp_C = 1088,
    //
    // ADS131M08 engineering values (16 registers, RO, stride 8).
    //
    eCh0_SenseVoltage = 1092,
    eCh0_SenseCurrent = 1096,
    eCh1_SenseVoltage = 1100,
    eCh1_SenseCurrent = 1104,
    eCh2_SenseVoltage = 1108,
    eCh2_SenseCurrent = 1112,
    eCh3_SenseVoltage = 1116,
    eCh3_SenseCurrent = 1120,
    eCh4_SenseVoltage = 1124,
    eCh4_SenseCurrent = 1128,
    eCh5_SenseVoltage = 1132,
    eCh5_SenseCurrent = 1136,
    eCh6_SenseVoltage = 1140,
    eCh6_SenseCurrent = 1144,
    eCh7_SenseVoltage = 1148,
    eCh7_SenseCurrent = 1152,
    //
    // Discharge accumulators (16 registers, RO, stride 8). The charge
    // direction lives at 320/332 in the stats block.
    //
    eCh0_DischargeAcc_mAh = 1156,
    eCh0_DischargeAcc_mWh = 1160,
    eCh1_DischargeAcc_mAh = 1164,
    eCh1_DischargeAcc_mWh = 1168,
    eCh2_DischargeAcc_mAh = 1172,
    eCh2_DischargeAcc_mWh = 1176,
    eCh3_DischargeAcc_mAh = 1180,
    eCh3_DischargeAcc_mWh = 1184,
    eCh4_DischargeAcc_mAh = 1188,
    eCh4_DischargeAcc_mWh = 1192,
    eCh5_DischargeAcc_mAh = 1196,
    eCh5_DischargeAcc_mWh = 1200,
    eCh6_DischargeAcc_mAh = 1204,
    eCh6_DischargeAcc_mWh = 1208,
    eCh7_DischargeAcc_mAh = 1212,
    eCh7_DischargeAcc_mWh = 1216,
} RegisterAddress;

//
// Registers per channel in each block. Defined here rather than with the
// BTS_*_BASE() macros below because BTS_cpu1Status sizes an array with one.
//
#define BTS_CTRL_REGS_PER_CH        (10U)
#define BTS_STATS_REGS_PER_CH       (6U)
#define BTS_TEMP_REGS_PER_CH        (2U)
#define BTS_CAL_REGS_PER_CH         (12U)
#define BTS_SENSE_REGS_PER_CH       (2U)
#define BTS_DISCHACC_REGS_PER_CH    (2U)

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
    //
    // Grouping state. Packed into bits 8-11 of the published status word.
    // The word is carried to the host as a float32, whose 24-bit significand
    // makes integers exact only to bit 23 - do not extend past that.
    //
    uint32_t slaveMode;        // slot follows a lower-numbered leader
    uint32_t groupDisconnect;  // a member of this slot's group fell out of sync
    uint32_t reversePolarity;  // measured cell voltage is negative
    uint32_t slotDisabled;     // masked off by the ENABLE dip switch
    uint32_t calibrating;      // slot is in the runtime calibration state
    //
    // Set from the PERSISTED calFlags, not from the in-session capture, so a
    // slot calibrated in an earlier session still shows its ticks after a
    // power cycle.
    //
    uint32_t calVoltageValid;
    uint32_t calCurrentValid;
} ChannelStatus;

//
//=============================================================================
// Status word bit positions
//=============================================================================
//
// Bits 0-7 are consumed by the ESP32 bridge; it masks each bit individually
// and ignores the rest, so bits 8+ are additive rather than breaking.
//
#define BTS_STATUS_RUNNING            0U
#define BTS_STATUS_STOPPED            1U
#define BTS_STATUS_FINISHED           2U
#define BTS_STATUS_OVERCURRENT_TRIP   3U
#define BTS_STATUS_CHARGING           4U
#define BTS_STATUS_DISCHARGING        5U
#define BTS_STATUS_CONST_VOLTAGE      6U
#define BTS_STATUS_CONST_CURRENT      7U
#define BTS_STATUS_SLAVE_MODE         8U
#define BTS_STATUS_GROUP_DISCONNECT   9U
#define BTS_STATUS_REVERSE_POLARITY  10U
#define BTS_STATUS_SLOT_DISABLED     11U
#define BTS_STATUS_CALIBRATING       12U
#define BTS_STATUS_CAL_V_VALID       13U
#define BTS_STATUS_CAL_I_VALID       14U

// Bitfield for eTripStatus register
typedef struct {
    uint32_t ch0_cmpss : 1; // Channel 0 CMPSS trip
    uint32_t ch0_gpio  : 1; // Channel 0 GPIO trip
    uint32_t ch1_cmpss : 1;
    uint32_t ch1_gpio  : 1;
    uint32_t ch2_cmpss : 1;
    uint32_t ch2_gpio  : 1;
    uint32_t ch3_cmpss : 1;
    uint32_t ch3_gpio  : 1;
    uint32_t ch4_cmpss : 1;
    uint32_t ch4_gpio  : 1;
    uint32_t ch5_cmpss : 1;
    uint32_t ch5_gpio  : 1;
    uint32_t ch6_cmpss : 1;
    uint32_t ch6_gpio  : 1;
    uint32_t ch7_cmpss : 1;
    uint32_t ch7_gpio  : 1;
    uint32_t reserved  : 16; // Padding to 32 bits
} TripStatusBitfield;

typedef struct _BTS_channelCalibration
{
    uint32_t  header;  // 0xA5CC for validation
    uint32_t  dateTime;

    float32_t MinCellTemp;      // Minimum cell temperature
    float32_t MaxCellTemp;      // Maximum cell temperature
    float32_t F28V_Gain;        // ADC gain for cell voltage
    float32_t F28V_Offset;      // ADC offset for cell voltage
    float32_t F28I_Gain;        // ADC gain for cell current
    float32_t F28I_Offset;      // ADC offset for cell current
    float32_t IoutGain_pu;
    float32_t IoutOffset_pu;
    float32_t IoutGain_A;
    float32_t IoutOffset_A;
    float32_t VoutGain_pu;
    float32_t VoutOffset_pu;
    float32_t VoutGain_V;
    float32_t VoutOffset_V;
    //
    // Appended at the END so every field above keeps its existing offset in
    // the F-RAM image.
    //
    uint32_t  calFlags;         // BTS_CAL_FLAG_*
    uint32_t  crc32;            // over all preceding fields
} BTS_channelCalibration;

#define BTS_CAL_FLAG_V_VALID   0x00000001UL
#define BTS_CAL_FLAG_I_VALID   0x00000002UL
#define BTS_CAL_FLAG_EXTERNAL  0x00000004UL  // externally referenced, not a compiled default

//
//=============================================================================
// Runtime slot calibration protocol
//=============================================================================
//
typedef enum {
    eCalCmdNone = 0,
    eCalCmdEnter = 1,
    eCalCmdExit = 2,
    eCalCmdCaptureVoltage = 3,   // argument: measured volts
    eCalCmdZeroCurrent = 4,
    eCalCmdSetFixedCurrent = 5,  // argument: uncalibrated pu setpoint
    eCalCmdCaptureCurrent = 6,   // argument: measured amps, MAGNITUDE
    eCalCmdComputeSave = 7,
    eCalCmdClear = 8,
} BTS_calCommand;

#define BTS_CAL_ST_ACTIVE        0U
#define BTS_CAL_ST_V_LO          1U
#define BTS_CAL_ST_V_HI          2U
#define BTS_CAL_ST_I_ZERO        3U
#define BTS_CAL_ST_I_LOADED      4U
#define BTS_CAL_ST_V_COMPUTED    5U
#define BTS_CAL_ST_I_COMPUTED    6U
#define BTS_CAL_ST_SAVED         7U
#define BTS_CAL_ST_DRIVING       8U
#define BTS_CAL_ST_FAILED        9U

typedef enum {
    eCalErrOk = 0,
    eCalErrBusy = 1,               // another slot is already calibrating
    eCalErrSlotTesting = 2,        // a slot is running a charge/discharge test
    eCalErrSlotUnavailable = 3,    // strap-disabled, or a group follower
    eCalErrPuRange = 4,            // reading outside the required pu window
    eCalErrNoCaptures = 5,
    eCalErrValidate = 6,           // computed gain failed validation
    eCalErrWriteFailed = 7,
    eCalErrArg = 8,
    eCalErrNotCalibrating = 9,
} BTS_calResult;

//
// Per-channel runtime calibration state, held in BTS_userInput.calState.
//
#define BTS_CAL_STATE_NORMAL   0U
#define BTS_CAL_STATE_IDLE     1U   // enable_logic held low, measurement still runs
#define BTS_CAL_STATE_FIXED_I  2U   // driving ioutCal_pu in discharge

// Highest fixed-current setpoint the handler will accept, ~8 A.
#define BTS_CAL_FIXED_I_MAX_PU ((float32_t)0.8)

// eCalSlot value meaning "no slot selected".
#define BTS_CAL_SLOT_NONE      ((uint16_t)255U)

typedef struct
{
    float32_t Isense_A;
    float32_t Vsense_V;
    float32_t CellVoltage_V;
    float32_t CellCurrent_I;
    int16_t Isense_16b[BTS_senseAverageFactor];
    int16_t Vsense_16b[BTS_senseAverageFactor];
    int16_t CellVoltage_16b[BTS_f28AverageFactor];
    int16_t CellCurrent_16b[BTS_f28AverageFactor];
    int32_t Sum_I;
    int32_t Sum_V;
    int32_t Sum_CellV;
    int32_t Sum_CellI;
    uint16_t Index;
    uint16_t F28Index;
    float32_t IoutGain_A;
    float32_t IoutOffset_A;
    float32_t VoutGain_V;
    float32_t VoutOffset_V;
    float32_t F28V_Gain;
    float32_t F28V_Offset;
    float32_t F28I_Gain;
    float32_t F28I_Offset;
} BTS_measValue;

typedef struct {
    uint16_t channel; // 0-7
    float voltage;    // Volts
    float current;    // Amps
    float mAh;        // Milliamp-hours
    float mWh;        // Milliwatt-hours
} CAN_data;

//
//=============================================================================
// Inter-processor messaging
//=============================================================================
//
// The F2837xD message RAMs are single-writer: CPU2TOCPU1RAM may only be
// written by CPU2 (CPU1 reads it), CPU1TOCPU2RAM may only be written by CPU1
// (CPU2 reads it). The register file therefore lives in CPU2TOCPU1RAM and is
// owned exclusively by CPU2 - CPU1 never writes registers[]. Measurements and
// status produced on CPU1 travel the other way through cpu1Status and are
// mirrored into registers[] by CPU2.
//
// IPC flag allocation (both directions use the same numbering):
//   IPC_FLAG0  CPU2 -> CPU1  single register write, payload in ipcMsg
//   IPC_FLAG1  CPU2 -> CPU1  cell temperature update, payload in ipcMsg
//   IPC_FLAG2  CPU2 -> CPU1  whole calibration block reloaded, no payload
//
#define BTS_IPC_FLAG_REG_WRITE   IPC_FLAG0
#define BTS_IPC_FLAG_TEMP_UPDATE IPC_FLAG1
#define BTS_IPC_FLAG_CAL_RELOAD  IPC_FLAG2

// CPU2 -> CPU1 single register mailbox. Lives in CPU2TOCPU1RAM.
typedef struct {
    uint16_t  regAddr;   // index into registers[], i.e. byte address / 4
    float32_t value;
} BTS_ipcMessage;

// CPU1 -> CPU2 status and measurement block. Lives in CPU1TOCPU2RAM.
// Single writer (CPU1), single reader (CPU2). seq is incremented after a
// complete update so CPU2 can detect a torn read and retry.
typedef struct {
    uint32_t  seq;
    uint32_t  statusBits[NUM_CHANNELS];  // mirrors eChX_Status
    float32_t cellVoltage[NUM_CHANNELS]; // mirrors eChX_CellVoltage
    float32_t cellCurrent[NUM_CHANNELS]; // mirrors eChX_CellCurrent
    float32_t inputVoltage;              // mirrors eInputVoltage
    uint32_t  unitState;                 // mirrors eUnitState
    uint32_t  tripStatus;                // mirrors eTripStatus
    //
    // Dip-switch straps, latched by CPU1 in BTS_HAL_setupGPIO(). Carried
    // inside this struct rather than read from the bare globals so they
    // inherit the seq guard: the two cores boot independently and
    // CPU1TOCPU2RAM is NOLOAD from CPU2's side, so its power-up contents
    // are not guaranteed zero. strapsValid stays 0 until CPU1 has latched.
    //
    uint32_t  strapsValid;               // 1 once the straps below are real
    uint32_t  slotMode;                  // mirrors eSlotMode,   0-7
    uint32_t  slotEnable;                // mirrors eSlotEnable, 0-7
    uint32_t  groupSize;                 // mirrors eGroupSize,  1/2/4/8
    //
    // ADS131M08 engineering values, mirrors eChX_SenseVoltage/SenseCurrent.
    //
    float32_t senseVoltage[NUM_CHANNELS];
    float32_t senseCurrent[NUM_CHANNELS];
    //
    // Per-direction charge/energy totals, integrated in C1() from the
    // ADS131M08 pair above. Mirrors eChX_ChargeAcc_* and eChX_DischargeAcc_*.
    //
    float32_t chargeMah[NUM_CHANNELS];
    float32_t chargeMwh[NUM_CHANNELS];
    float32_t dischargeMah[NUM_CHANNELS];
    float32_t dischargeMwh[NUM_CHANNELS];
    //
    // Runtime calibration. CPU1 owns the state machine and the captures;
    // CPU2 mirrors these into the 1036+ block and performs the F-RAM write,
    // which must never happen from an ISR.
    //
    uint32_t  calActiveSlot;             // 0-7, or BTS_CAL_SLOT_NONE
    uint32_t  calStatus;                 // mirrors eCalStatus, except bit 7
    uint32_t  calResult;                 // mirrors eCalResult
    //
    // Live telemetry for calActiveSlot, in eCalAdsV_pu..eCalF28I_A order.
    // eCalTemp_C is filled by CPU2, which owns the ADS1119 readings.
    //
    float32_t calTelemetry[8];
    //
    // Compute-and-save handshake. CPU1 fills calComputed in
    // BTS_CAL_F28V_GAIN..BTS_CAL_VOUT_OFFSET_V order and then bumps
    // calSaveSeq; CPU2 acts on the change exactly once.
    //
    uint32_t  calSaveSeq;
    uint32_t  calSaveSlot;
    uint32_t  calSaveFlags;              // BTS_CAL_FLAG_*
    float32_t calComputed[BTS_CAL_REGS_PER_CH];
} BTS_cpu1Status;

typedef enum {
    eInputLow_ChargeDisabled,
    eInputLow_ChargeRestricted,
    eInputOK,
    eInputHigh_DischargeRestricted,
    eInputHigh_DischargeDisabled
} UnitState;

// Not auto generated below

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
    //
    // Runtime calibration state, BTS_CAL_STATE_*. Replaces the compile-time
    // BTS_CALIBRATION_ENABLED path, which selected calibration behaviour for
    // every channel at once.
    //
    volatile uint16_t  calState;

    /* Calibration Data Entry */
    float32_t IoutGain_pu;
    float32_t IoutOffset_pu;
    float32_t IoutGain_A;
    float32_t IoutOffset_A;

    float32_t VoutGain_pu;
    float32_t VoutOffset_pu;
    float32_t VoutGain_V;
    float32_t VoutOffset_V;

    float32_t F28V_Gain;
    float32_t F28V_Offset;
    float32_t F28I_Gain;
    float32_t F28I_Offset;

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

//
//=============================================================================
// Register map helpers
//=============================================================================
//
// The register file is indexed by (byte address / 4). The blocks do NOT share
// a stride, so always derive an index through these macros rather than
// assuming 10 registers per channel:
//
//   control      10 regs/channel  eCh0_Mode        .. eCh7_Status
//   stats         6 regs/channel  eCh0_ChargeAcc_mAh  .. eCh7_CellCurrent
//   temperature   2 regs/channel  eCh0_MinCellTemp .. eCh7_MaxCellTemp
//   global V      4 regs total    eChargeDisableV  .. eDischargeDisableV
//   calibration  12 regs/channel  eCh0_F28V_Gain   .. eCh7_VoutOffset_V
//   unit          4 regs total    eCalibrationMode .. eTripStatus
//   cell temp     1 reg/channel   eCh0_CellTemp    .. eCh7_CellTemp
//   discharge acc 2 regs/channel  eCh0_DischargeAcc_mAh .. eCh7_DischargeAcc_mWh
//
#define BTS_REG_IDX(addr)           ((uint16_t)((addr) / 4U))

#define BTS_CTRL_BASE(ch)   (BTS_REG_IDX(eCh0_Mode)         + (ch) * BTS_CTRL_REGS_PER_CH)
#define BTS_STATS_BASE(ch)  (BTS_REG_IDX(eCh0_ChargeAcc_mAh)   + (ch) * BTS_STATS_REGS_PER_CH)
#define BTS_TEMP_BASE(ch)   (BTS_REG_IDX(eCh0_MinCellTemp)  + (ch) * BTS_TEMP_REGS_PER_CH)
#define BTS_CAL_BASE(ch)    (BTS_REG_IDX(eCh0_F28V_Gain)    + (ch) * BTS_CAL_REGS_PER_CH)
#define BTS_SENSE_BASE(ch)  (BTS_REG_IDX(eCh0_SenseVoltage) + (ch) * BTS_SENSE_REGS_PER_CH)
#define BTS_DISCHACC_BASE(ch) (BTS_REG_IDX(eCh0_DischargeAcc_mAh) + (ch) * BTS_DISCHACC_REGS_PER_CH)

// Offsets within the 2-register accumulator blocks. The charge pair is not
// contiguous - it is interleaved with min/max voltage in the stats block - so
// only the discharge block gets a base-plus-offset pair.
#define BTS_DISCHACC_MAH       0U
#define BTS_DISCHACC_MWH       1U

// Offsets within the 2-register sense block at BTS_SENSE_BASE(ch).
#define BTS_SENSE_VOLTAGE      0U
#define BTS_SENSE_CURRENT      1U

// Measured cell temperature is one register per channel, so the index is the
// block base plus the channel. Distinct from BTS_TEMP_BASE(), which is the
// configured min/max limit pair.
#define BTS_CELLTEMP_IDX(ch) (BTS_REG_IDX(eCh0_CellTemp)     + (ch))

//
//=============================================================================
// Slot grouping - MODE / ENABLE dip switches
//=============================================================================
//
// Both straps arrive through an SN74HC148 8:3 priority encoder and are
// decoded to 0-7 by CPU1 in BTS_HAL_setupGPIO().
//
// MODE selects how slots are grouped, and whether the control loop takes its
// voltage feedback from the external ADS131M08 (modes 0-3) or the C2000's
// own ADC (modes 4-7). The low two bits are the group size and bit 2 selects
// the converter, so the two halves of the table are deliberately parallel.
//
// ENABLE is the index of the highest enabled slot: 0 enables slot 1 alone,
// 7 enables all eight.
//
typedef enum {
    eModeIndependent       = 0,  // 8 independent slots
    eModePairs             = 1,  // 1+2, 3+4, 5+6, 7+8
    eModeQuads             = 2,  // 1-4, 5-8
    eModeOctet             = 3,  // 1-8 as one group
    eModeIndependentIntAdc = 4,  // as above, internal ADC voltage control
    eModePairsIntAdc       = 5,
    eModeQuadsIntAdc       = 6,
    eModeOctetIntAdc       = 7,
} BTS_SlotMode;

// Slots per group: 1, 2, 4 or 8.
#define BTS_MODE_GROUP_SIZE(m)      ((uint16_t)1U << ((uint16_t)(m) & 0x3U))

// Modes 4-7 close the voltage loop on the C2000's internal ADC instead of
// the ADS131M08.
#define BTS_MODE_USES_INT_ADC(m)    ((((uint16_t)(m)) & 0x4U) != 0U)

// The group leader is the lowest-numbered slot in the group. Group sizes are
// powers of two, so masking off the low bits of the channel index gives it.
#define BTS_GROUP_LEADER(ch, m)     ((uint16_t)(ch) & (uint16_t)~(BTS_MODE_GROUP_SIZE(m) - 1U))
#define BTS_IS_GROUP_LEADER(ch, m)  ((uint16_t)(ch) == BTS_GROUP_LEADER((ch), (m)))

// ENABLE holds the highest enabled slot index, so this is a direct compare.
#define BTS_SLOT_ENABLED(ch, en)    ((uint16_t)(ch) <= (uint16_t)(en))

// Offsets within the 12-register calibration block at BTS_CAL_BASE(ch).
// Order must match BTS_channelCalibration's float members.
#define BTS_CAL_F28V_GAIN      0U
#define BTS_CAL_F28V_OFFSET    1U
#define BTS_CAL_F28I_GAIN      2U
#define BTS_CAL_F28I_OFFSET    3U
#define BTS_CAL_IOUT_GAIN_PU   4U
#define BTS_CAL_IOUT_OFFSET_PU 5U
#define BTS_CAL_IOUT_GAIN_A    6U
#define BTS_CAL_IOUT_OFFSET_A  7U
#define BTS_CAL_VOUT_GAIN_PU   8U
#define BTS_CAL_VOUT_OFFSET_PU 9U
#define BTS_CAL_VOUT_GAIN_V    10U
#define BTS_CAL_VOUT_OFFSET_V  11U

// Offsets within the 2-register temperature block at BTS_TEMP_BASE(ch).
#define BTS_TEMP_MIN           0U
#define BTS_TEMP_MAX           1U

// EEPROM validation header. The channel is carried in its own field rather
// than OR-ed into the header, which would collide for channels >= 4.
//
// Bumped to 0xA5CD for the calFlags/crc32 revision and the fixed 128-byte
// F-RAM stride. Pre-change images are rejected rather than reinterpreted, so
// every slot falls back to compiled defaults once and must be recalibrated.
#define BTS_CAL_HEADER         0xA5CD0000UL
#define BTS_CAL_HEADER_MASK    0xFFFF0000UL
#define BTS_CAL_CHANNEL_MASK   0x0000FFFFUL
#define BTS_CAL_MAKE_HEADER(ch)    (BTS_CAL_HEADER | ((uint32_t)(ch) & BTS_CAL_CHANNEL_MASK))

//
//=============================================================================
// Shared data - defined in registers.c, placed in the message RAMs
//=============================================================================
//
// Written by CPU2, read by CPU1 (CPU2TOCPU1RAM):
extern volatile float32_t              registers[TOTAL_REGISTERS];
extern volatile BTS_ipcMessage         ipcMsg;
extern volatile uint32_t               calValidFlags[NUM_CHANNELS];

// CPU2-private: the full image never crosses to CPU1, only calValidFlags does.
extern BTS_channelCalibration          calibrationData[NUM_CHANNELS];

// Written by CPU1, read by CPU2 (CPU1TOCPU2RAM):
extern volatile CAN_data               canData[NUM_CHANNELS];
extern volatile BTS_cpu1Status         cpu1Status;
extern volatile uint32_t               startup_mode;
extern volatile uint32_t               startup_enable;

// Access tables (in flash, compiled into both cores):
extern const RegisterConfig     regConfig[TOTAL_REGISTERS];
extern const UARTRegisterConfig uartRegConfig[TOTAL_REGISTERS];

#endif /* REGISTERS_H_ */
