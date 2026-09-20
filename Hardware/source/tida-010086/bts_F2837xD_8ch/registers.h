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

//
//=============================================================================
// Register map v2
//=============================================================================
//
// Three regions with fixed, generous per-slot strides, so a future field does
// not shift every address again:
//
//   runtime   base    0, stride 12 regs (48 B), all RO  - one host burst/slot
//   settings  base  384, stride 24 regs (96 B)          - one host burst/slot
//   unit      base 1152
//
// Runtime ch7 ends at 383, immediately before the settings base; settings ch7
// ends at 1151, immediately before the unit base. Top address is 1256.
//
#define BTS_RT_REGS_PER_CH          (12U)
#define BTS_SET_REGS_PER_CH         (24U)

#define NUM_RUNTIME_REGISTERS   (NUM_CHANNELS * BTS_RT_REGS_PER_CH)   // 96
#define NUM_SETTINGS_REGISTERS  (NUM_CHANNELS * BTS_SET_REGS_PER_CH)  // 192
#define NUM_UNIT_REGISTERS      (27)
#define TOTAL_REGISTERS (NUM_RUNTIME_REGISTERS + NUM_SETTINGS_REGISTERS + NUM_UNIT_REGISTERS) // 315

// CAN bus configuration
#define CAN_BITRATE 500000 // 500 kbps
#define CAN_MSG_ID_BASE 0x1C000000 // Base for 29-bit ID
#define CAN_DEVICE_ID 0x0001 // Example device ID

typedef enum {
    REG_ACCESS_RO,  // Read-only
    REG_ACCESS_RW   // Read/write
} RegAccessType;

typedef enum {
    //
    // Runtime block, base 0, stride 48 bytes (12 registers per slot).
    // Everything a host polls, contiguous so a slot is one I2C burst.
    // All REG_ACCESS_RO.
    //
    eCh0_Status = 0,
    eCh0_CellVoltage = 4,
    eCh0_CellCurrent = 8,
    eCh0_SenseVoltage = 12,
    eCh0_SenseCurrent = 16,
    eCh0_CellTemp = 20,
    eCh0_ChargeAcc_mAh = 24,
    eCh0_ChargeAcc_mWh = 28,
    eCh0_ChargeRuntime_s = 32,
    eCh0_DischargeAcc_mAh = 36,
    eCh0_DischargeAcc_mWh = 40,
    eCh0_DischargeRuntime_s = 44,
    eCh1_Status = 48,
    eCh1_CellVoltage = 52,
    eCh1_CellCurrent = 56,
    eCh1_SenseVoltage = 60,
    eCh1_SenseCurrent = 64,
    eCh1_CellTemp = 68,
    eCh1_ChargeAcc_mAh = 72,
    eCh1_ChargeAcc_mWh = 76,
    eCh1_ChargeRuntime_s = 80,
    eCh1_DischargeAcc_mAh = 84,
    eCh1_DischargeAcc_mWh = 88,
    eCh1_DischargeRuntime_s = 92,
    eCh2_Status = 96,
    eCh2_CellVoltage = 100,
    eCh2_CellCurrent = 104,
    eCh2_SenseVoltage = 108,
    eCh2_SenseCurrent = 112,
    eCh2_CellTemp = 116,
    eCh2_ChargeAcc_mAh = 120,
    eCh2_ChargeAcc_mWh = 124,
    eCh2_ChargeRuntime_s = 128,
    eCh2_DischargeAcc_mAh = 132,
    eCh2_DischargeAcc_mWh = 136,
    eCh2_DischargeRuntime_s = 140,
    eCh3_Status = 144,
    eCh3_CellVoltage = 148,
    eCh3_CellCurrent = 152,
    eCh3_SenseVoltage = 156,
    eCh3_SenseCurrent = 160,
    eCh3_CellTemp = 164,
    eCh3_ChargeAcc_mAh = 168,
    eCh3_ChargeAcc_mWh = 172,
    eCh3_ChargeRuntime_s = 176,
    eCh3_DischargeAcc_mAh = 180,
    eCh3_DischargeAcc_mWh = 184,
    eCh3_DischargeRuntime_s = 188,
    eCh4_Status = 192,
    eCh4_CellVoltage = 196,
    eCh4_CellCurrent = 200,
    eCh4_SenseVoltage = 204,
    eCh4_SenseCurrent = 208,
    eCh4_CellTemp = 212,
    eCh4_ChargeAcc_mAh = 216,
    eCh4_ChargeAcc_mWh = 220,
    eCh4_ChargeRuntime_s = 224,
    eCh4_DischargeAcc_mAh = 228,
    eCh4_DischargeAcc_mWh = 232,
    eCh4_DischargeRuntime_s = 236,
    eCh5_Status = 240,
    eCh5_CellVoltage = 244,
    eCh5_CellCurrent = 248,
    eCh5_SenseVoltage = 252,
    eCh5_SenseCurrent = 256,
    eCh5_CellTemp = 260,
    eCh5_ChargeAcc_mAh = 264,
    eCh5_ChargeAcc_mWh = 268,
    eCh5_ChargeRuntime_s = 272,
    eCh5_DischargeAcc_mAh = 276,
    eCh5_DischargeAcc_mWh = 280,
    eCh5_DischargeRuntime_s = 284,
    eCh6_Status = 288,
    eCh6_CellVoltage = 292,
    eCh6_CellCurrent = 296,
    eCh6_SenseVoltage = 300,
    eCh6_SenseCurrent = 304,
    eCh6_CellTemp = 308,
    eCh6_ChargeAcc_mAh = 312,
    eCh6_ChargeAcc_mWh = 316,
    eCh6_ChargeRuntime_s = 320,
    eCh6_DischargeAcc_mAh = 324,
    eCh6_DischargeAcc_mWh = 328,
    eCh6_DischargeRuntime_s = 332,
    eCh7_Status = 336,
    eCh7_CellVoltage = 340,
    eCh7_CellCurrent = 344,
    eCh7_SenseVoltage = 348,
    eCh7_SenseCurrent = 352,
    eCh7_CellTemp = 356,
    eCh7_ChargeAcc_mAh = 360,
    eCh7_ChargeAcc_mWh = 364,
    eCh7_ChargeRuntime_s = 368,
    eCh7_DischargeAcc_mAh = 372,
    eCh7_DischargeAcc_mWh = 376,
    eCh7_DischargeRuntime_s = 380,
    //
    // Settings block, base 384, stride 96 bytes (24 registers per slot).
    // 23 used, 1 spare per slot. The 12 calibration registers keep their
    // internal order at offset 11, which is what BTS_CAL_BASE() indexes.
    //
    eCh0_Mode = 384,
    eCh0_ChargeVoltageMin = 388,
    eCh0_ChargeVoltageMax = 392,
    eCh0_DischargeVoltageMin = 396,
    eCh0_DischargeVoltageMax = 400,
    eCh0_ChargeCurrentMin = 404,
    eCh0_ChargeCurrentMax = 408,
    eCh0_DischargeCurrentMin = 412,
    eCh0_DischargeCurrentMax = 416,
    eCh0_MinCellTemp = 420,
    eCh0_MaxCellTemp = 424,
    eCh0_F28V_Gain = 428,
    eCh0_F28V_Offset = 432,
    eCh0_F28I_Gain = 436,
    eCh0_F28I_Offset = 440,
    eCh0_IoutGain_pu = 444,
    eCh0_IoutOffset_pu = 448,
    eCh0_IoutGain_A = 452,
    eCh0_IoutOffset_A = 456,
    eCh0_VoutGain_pu = 460,
    eCh0_VoutOffset_pu = 464,
    eCh0_VoutGain_V = 468,
    eCh0_VoutOffset_V = 472,
    eCh0_SettingsSpare = 476,
    eCh1_Mode = 480,
    eCh1_ChargeVoltageMin = 484,
    eCh1_ChargeVoltageMax = 488,
    eCh1_DischargeVoltageMin = 492,
    eCh1_DischargeVoltageMax = 496,
    eCh1_ChargeCurrentMin = 500,
    eCh1_ChargeCurrentMax = 504,
    eCh1_DischargeCurrentMin = 508,
    eCh1_DischargeCurrentMax = 512,
    eCh1_MinCellTemp = 516,
    eCh1_MaxCellTemp = 520,
    eCh1_F28V_Gain = 524,
    eCh1_F28V_Offset = 528,
    eCh1_F28I_Gain = 532,
    eCh1_F28I_Offset = 536,
    eCh1_IoutGain_pu = 540,
    eCh1_IoutOffset_pu = 544,
    eCh1_IoutGain_A = 548,
    eCh1_IoutOffset_A = 552,
    eCh1_VoutGain_pu = 556,
    eCh1_VoutOffset_pu = 560,
    eCh1_VoutGain_V = 564,
    eCh1_VoutOffset_V = 568,
    eCh1_SettingsSpare = 572,
    eCh2_Mode = 576,
    eCh2_ChargeVoltageMin = 580,
    eCh2_ChargeVoltageMax = 584,
    eCh2_DischargeVoltageMin = 588,
    eCh2_DischargeVoltageMax = 592,
    eCh2_ChargeCurrentMin = 596,
    eCh2_ChargeCurrentMax = 600,
    eCh2_DischargeCurrentMin = 604,
    eCh2_DischargeCurrentMax = 608,
    eCh2_MinCellTemp = 612,
    eCh2_MaxCellTemp = 616,
    eCh2_F28V_Gain = 620,
    eCh2_F28V_Offset = 624,
    eCh2_F28I_Gain = 628,
    eCh2_F28I_Offset = 632,
    eCh2_IoutGain_pu = 636,
    eCh2_IoutOffset_pu = 640,
    eCh2_IoutGain_A = 644,
    eCh2_IoutOffset_A = 648,
    eCh2_VoutGain_pu = 652,
    eCh2_VoutOffset_pu = 656,
    eCh2_VoutGain_V = 660,
    eCh2_VoutOffset_V = 664,
    eCh2_SettingsSpare = 668,
    eCh3_Mode = 672,
    eCh3_ChargeVoltageMin = 676,
    eCh3_ChargeVoltageMax = 680,
    eCh3_DischargeVoltageMin = 684,
    eCh3_DischargeVoltageMax = 688,
    eCh3_ChargeCurrentMin = 692,
    eCh3_ChargeCurrentMax = 696,
    eCh3_DischargeCurrentMin = 700,
    eCh3_DischargeCurrentMax = 704,
    eCh3_MinCellTemp = 708,
    eCh3_MaxCellTemp = 712,
    eCh3_F28V_Gain = 716,
    eCh3_F28V_Offset = 720,
    eCh3_F28I_Gain = 724,
    eCh3_F28I_Offset = 728,
    eCh3_IoutGain_pu = 732,
    eCh3_IoutOffset_pu = 736,
    eCh3_IoutGain_A = 740,
    eCh3_IoutOffset_A = 744,
    eCh3_VoutGain_pu = 748,
    eCh3_VoutOffset_pu = 752,
    eCh3_VoutGain_V = 756,
    eCh3_VoutOffset_V = 760,
    eCh3_SettingsSpare = 764,
    eCh4_Mode = 768,
    eCh4_ChargeVoltageMin = 772,
    eCh4_ChargeVoltageMax = 776,
    eCh4_DischargeVoltageMin = 780,
    eCh4_DischargeVoltageMax = 784,
    eCh4_ChargeCurrentMin = 788,
    eCh4_ChargeCurrentMax = 792,
    eCh4_DischargeCurrentMin = 796,
    eCh4_DischargeCurrentMax = 800,
    eCh4_MinCellTemp = 804,
    eCh4_MaxCellTemp = 808,
    eCh4_F28V_Gain = 812,
    eCh4_F28V_Offset = 816,
    eCh4_F28I_Gain = 820,
    eCh4_F28I_Offset = 824,
    eCh4_IoutGain_pu = 828,
    eCh4_IoutOffset_pu = 832,
    eCh4_IoutGain_A = 836,
    eCh4_IoutOffset_A = 840,
    eCh4_VoutGain_pu = 844,
    eCh4_VoutOffset_pu = 848,
    eCh4_VoutGain_V = 852,
    eCh4_VoutOffset_V = 856,
    eCh4_SettingsSpare = 860,
    eCh5_Mode = 864,
    eCh5_ChargeVoltageMin = 868,
    eCh5_ChargeVoltageMax = 872,
    eCh5_DischargeVoltageMin = 876,
    eCh5_DischargeVoltageMax = 880,
    eCh5_ChargeCurrentMin = 884,
    eCh5_ChargeCurrentMax = 888,
    eCh5_DischargeCurrentMin = 892,
    eCh5_DischargeCurrentMax = 896,
    eCh5_MinCellTemp = 900,
    eCh5_MaxCellTemp = 904,
    eCh5_F28V_Gain = 908,
    eCh5_F28V_Offset = 912,
    eCh5_F28I_Gain = 916,
    eCh5_F28I_Offset = 920,
    eCh5_IoutGain_pu = 924,
    eCh5_IoutOffset_pu = 928,
    eCh5_IoutGain_A = 932,
    eCh5_IoutOffset_A = 936,
    eCh5_VoutGain_pu = 940,
    eCh5_VoutOffset_pu = 944,
    eCh5_VoutGain_V = 948,
    eCh5_VoutOffset_V = 952,
    eCh5_SettingsSpare = 956,
    eCh6_Mode = 960,
    eCh6_ChargeVoltageMin = 964,
    eCh6_ChargeVoltageMax = 968,
    eCh6_DischargeVoltageMin = 972,
    eCh6_DischargeVoltageMax = 976,
    eCh6_ChargeCurrentMin = 980,
    eCh6_ChargeCurrentMax = 984,
    eCh6_DischargeCurrentMin = 988,
    eCh6_DischargeCurrentMax = 992,
    eCh6_MinCellTemp = 996,
    eCh6_MaxCellTemp = 1000,
    eCh6_F28V_Gain = 1004,
    eCh6_F28V_Offset = 1008,
    eCh6_F28I_Gain = 1012,
    eCh6_F28I_Offset = 1016,
    eCh6_IoutGain_pu = 1020,
    eCh6_IoutOffset_pu = 1024,
    eCh6_IoutGain_A = 1028,
    eCh6_IoutOffset_A = 1032,
    eCh6_VoutGain_pu = 1036,
    eCh6_VoutOffset_pu = 1040,
    eCh6_VoutGain_V = 1044,
    eCh6_VoutOffset_V = 1048,
    eCh6_SettingsSpare = 1052,
    eCh7_Mode = 1056,
    eCh7_ChargeVoltageMin = 1060,
    eCh7_ChargeVoltageMax = 1064,
    eCh7_DischargeVoltageMin = 1068,
    eCh7_DischargeVoltageMax = 1072,
    eCh7_ChargeCurrentMin = 1076,
    eCh7_ChargeCurrentMax = 1080,
    eCh7_DischargeCurrentMin = 1084,
    eCh7_DischargeCurrentMax = 1088,
    eCh7_MinCellTemp = 1092,
    eCh7_MaxCellTemp = 1096,
    eCh7_F28V_Gain = 1100,
    eCh7_F28V_Offset = 1104,
    eCh7_F28I_Gain = 1108,
    eCh7_F28I_Offset = 1112,
    eCh7_IoutGain_pu = 1116,
    eCh7_IoutOffset_pu = 1120,
    eCh7_IoutGain_A = 1124,
    eCh7_IoutOffset_A = 1128,
    eCh7_VoutGain_pu = 1132,
    eCh7_VoutOffset_pu = 1136,
    eCh7_VoutGain_V = 1140,
    eCh7_VoutOffset_V = 1144,
    eCh7_SettingsSpare = 1148,
    //
    // Unit block, base 1152. eWatchdogRemaining_s is the live
    // countdown; calibration telemetry follows at 1224-1256.
    //
    eChargeDisableV = 1152,
    eChargeRestrictV = 1156,
    eDischargeRestrictV = 1160,
    eDischargeDisableV = 1164,
    eCalibrationMode = 1168,
    eUnitState = 1172,
    eInputVoltage = 1176,
    eTripStatus = 1180,
    eSlotMode = 1184,
    eSlotEnable = 1188,
    eGroupSize = 1192,
    eHostWatchdog_s = 1196,
    eCalSlot = 1200,
    eCalCommand = 1204,
    eCalArgument = 1208,
    eCalStatus = 1212,
    eCalResult = 1216,
    eWatchdogRemaining_s = 1220,
    eCalAdsV_pu = 1224,
    eCalAdsI_pu = 1228,
    eCalAdsV_V = 1232,
    eCalAdsI_A = 1236,
    eCalF28V_pu = 1240,
    eCalF28I_pu = 1244,
    eCalF28V_V = 1248,
    eCalF28I_A = 1252,
    eCalTemp_C = 1256,
} RegisterAddress;

//
// Sub-blocks within a slot's settings region. The calibration group is 12
// registers at offset 11; BTS_cpu1Status sizes an array with that count.
//
#define BTS_CAL_REGS_PER_CH         (12U)
#define BTS_TEMP_REGS_PER_CH        (2U)

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
    //
    // Pause is not a direction: a paused slot keeps its charging/discharging
    // bit set alongside it, so a host sees both that it is held and what it
    // will resume into.
    //
    uint32_t paused;
    uint32_t wdTripped;        // paused by the host watchdog
    uint32_t restored;         // paused by a FRAM boot restore
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
//
// Slot state model. PAUSED sits alongside the direction bit rather than
// replacing it.
//
// END is an ALIAS for FINISHED (bit 2), not a new bit: that bit was declared
// from the start and never written, so it is driven now with the END meaning
// rather than duplicated at bit 16. Bit 16 is therefore free.
//
#define BTS_STATUS_PAUSED            15U
#define BTS_STATUS_END               BTS_STATUS_FINISHED
#define BTS_STATUS_WD_TRIPPED        17U  /* paused by the host watchdog   */
#define BTS_STATUS_RESTORED          18U  /* paused by a FRAM boot restore */

//
// eChX_Mode command bits. Bits 3 and 4 are edge commands: acted on at the
// write and not retained, so a host never has to clear them afterwards.
//
#define BTS_MODE_RUN                 0x01U
#define BTS_MODE_CHARGE              0x02U
#define BTS_MODE_CALIBRATE           0x04U
#define BTS_MODE_PAUSE               0x08U
#define BTS_MODE_RESUME              0x10U

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
// Slot runtime state persistence
//=============================================================================
//
// Saved to F-RAM every 6 s and on each state transition, so a slot that was
// mid-run when the unit reset comes back knowing what it was doing and how
// far it had got. Restored as PAUSED, never resumed - see loadSlotStates().
//
typedef struct _BTS_slotRuntimeState
{
    uint32_t  header;           // BTS_STATE_HEADER | channel
    uint32_t  stateFlags;       // running direction + END, at save time
    float32_t chargeMah;
    float32_t chargeMwh;
    float32_t chargeSeconds;
    float32_t dischargeMah;
    float32_t dischargeMwh;
    float32_t dischargeSeconds;
    uint32_t  saveCounter;      // increments every save; staleness/wear info
    uint32_t  crc32;            // over all preceding fields
} BTS_slotRuntimeState;

#define BTS_STATE_HEADER       0x5A5E0000UL
#define BTS_STATE_HEADER_MASK  0xFFFF0000UL
#define BTS_STATE_CHANNEL_MASK 0x0000FFFFUL
#define BTS_STATE_MAKE_HEADER(ch)  (BTS_STATE_HEADER | ((uint32_t)(ch) & BTS_STATE_CHANNEL_MASK))

// stateFlags, saved and restored. Deliberately a small private set rather
// than the full status word: only what a restore has to reconstruct.
#define BTS_STATE_F_RUNNING    0x00000001UL
#define BTS_STATE_F_CHARGING   0x00000002UL
#define BTS_STATE_F_END        0x00000004UL

//
//=============================================================================
// Host watchdog
//=============================================================================
//
// A supervision timeout, not over-current protection: hardware trips are
// disabled and the software check in BTS_tripEpwm() is still the only fast
// protection. Reloaded by any host command on any interface; on expiry every
// running slot is paused with BTS_STATUS_WD_TRIPPED set.
//
#define BTS_HOST_WD_DEFAULT_S  ((float32_t)30.0)
#define BTS_HOST_WD_MAX_S      ((float32_t)86400.0)

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
//   IPC_FLAG3  CPU2 -> CPU1  slot runtime state restored from F-RAM
//
#define BTS_IPC_FLAG_REG_WRITE   IPC_FLAG0
#define BTS_IPC_FLAG_TEMP_UPDATE IPC_FLAG1
#define BTS_IPC_FLAG_CAL_RELOAD  IPC_FLAG2
#define BTS_IPC_FLAG_STATE_RESTORE IPC_FLAG3

//
// CPU2 -> CPU1 supervision mailbox. Lives in CPU2TOCPU1RAM.
//
// CPU2 owns the host interfaces and the timebase, so it detects the watchdog
// timeout - but it must never write a slot's control state, so it only bumps
// a counter here and CPU1 performs the pause. Single-writer rule intact.
//
typedef struct {
    uint32_t wdPauseSeq;     // bumped once per watchdog expiry
    uint32_t restoreFlags;   // 3 bits per slot: BTS_STATE_F_* << (ch * 3)
} BTS_supervision;

#define BTS_STATE_FLAGS_SHIFT(ch)  ((uint16_t)(ch) * 3U)
#define BTS_STATE_FLAGS_MASK       0x7UL

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
    float32_t chargeSeconds[NUM_CHANNELS];
    float32_t dischargeMah[NUM_CHANNELS];
    float32_t dischargeMwh[NUM_CHANNELS];
    float32_t dischargeSeconds[NUM_CHANNELS];
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
// The register file is indexed by (byte address / 4). Two per-slot regions,
// each with its own stride - always derive an index through these macros:
//
//   runtime   12 regs/slot  eCh0_Status  .. eCh7_DischargeRuntime_s  (RO)
//   settings  24 regs/slot  eCh0_Mode    .. eCh7_SettingsSpare
//   unit      27 regs total eChargeDisableV .. eCalTemp_C
//
#define BTS_REG_IDX(addr)           ((uint16_t)((addr) / 4U))

#define BTS_RT_BASE(ch)     (BTS_REG_IDX(eCh0_Status) + (ch) * BTS_RT_REGS_PER_CH)
#define BTS_SET_BASE(ch)    (BTS_REG_IDX(eCh0_Mode)   + (ch) * BTS_SET_REGS_PER_CH)

// The 12 calibration registers sit at settings offset 11 and keep their
// internal BTS_CAL_* order, so saveCalibration()/loadCalibration() index
// through this exactly as before.
#define BTS_CAL_BASE(ch)    (BTS_SET_BASE(ch) + 11U)
#define BTS_TEMP_BASE(ch)   (BTS_SET_BASE(ch) + 9U)

// Offsets within a slot's runtime block at BTS_RT_BASE(ch).
#define BTS_RT_STATUS          0U
#define BTS_RT_CELL_VOLTAGE    1U
#define BTS_RT_CELL_CURRENT    2U
#define BTS_RT_SENSE_VOLTAGE   3U
#define BTS_RT_SENSE_CURRENT   4U
#define BTS_RT_CELL_TEMP       5U
#define BTS_RT_CHARGE_MAH      6U
#define BTS_RT_CHARGE_MWH      7U
#define BTS_RT_CHARGE_SECONDS  8U
#define BTS_RT_DISCHARGE_MAH   9U
#define BTS_RT_DISCHARGE_MWH  10U
#define BTS_RT_DISCHARGE_SECONDS 11U

// Offsets within a slot's settings block at BTS_SET_BASE(ch). Offsets 9-10
// are the temperature window (BTS_TEMP_BASE) and 11-22 the calibration group
// (BTS_CAL_BASE); 23 is spare.
#define BTS_SET_MODE           0U
#define BTS_SET_CHG_V_MIN      1U
#define BTS_SET_CHG_V_MAX      2U
#define BTS_SET_DIS_V_MIN      3U
#define BTS_SET_DIS_V_MAX      4U
#define BTS_SET_CHG_I_MIN      5U
#define BTS_SET_CHG_I_MAX      6U
#define BTS_SET_DIS_I_MIN      7U
#define BTS_SET_DIS_I_MAX      8U

// Measured cell temperature now lives in the runtime block with the rest of
// the per-slot telemetry. The macro is kept so the ADS1119 publish path and
// the calibration window still index it by name.
#define BTS_CELLTEMP_IDX(ch) (BTS_RT_BASE(ch) + BTS_RT_CELL_TEMP)

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
extern volatile BTS_supervision        supervision;

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
