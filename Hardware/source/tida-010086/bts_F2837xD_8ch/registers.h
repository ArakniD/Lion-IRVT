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
#define BTS_SET_REGS_PER_CH         (18U)

#define NUM_RUNTIME_REGISTERS   (NUM_CHANNELS * BTS_RT_REGS_PER_CH)   // 96
#define NUM_SETTINGS_REGISTERS  (NUM_CHANNELS * BTS_SET_REGS_PER_CH)  // 144
#define NUM_UNIT_REGISTERS      (27)
#define TOTAL_REGISTERS (NUM_RUNTIME_REGISTERS + NUM_SETTINGS_REGISTERS + NUM_UNIT_REGISTERS) // 267

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
    // Settings block, base 384, stride 72 bytes (18 registers per slot).
    //
    // Compressed 2026-09-22 from 24 registers. Charge and discharge no longer
    // have separate limits: a slot's direction is chosen by the mode register,
    // so one VoltageMin/VoltageMax and one CurrentMin/CurrentMax pair serves
    // both. MinCellTemp and the per-slot spare are gone - only a maximum cell
    // temperature is enforced.
    //
    // The 12 calibration registers keep their internal order and now start at
    // offset 6, which is what BTS_CAL_BASE() indexes.
    //
    eCh0_Mode = 384,
    eCh0_VoltageMin = 388,
    eCh0_VoltageMax = 392,
    eCh0_CurrentMin = 396,
    eCh0_CurrentMax = 400,
    eCh0_MaxCellTemp = 404,
    eCh0_F28V_Gain = 408,
    eCh0_F28V_Offset = 412,
    eCh0_F28I_Gain = 416,
    eCh0_F28I_Offset = 420,
    eCh0_IoutGain_pu = 424,
    eCh0_IoutOffset_pu = 428,
    eCh0_IoutGain_A = 432,
    eCh0_IoutOffset_A = 436,
    eCh0_VoutGain_pu = 440,
    eCh0_VoutOffset_pu = 444,
    eCh0_VoutGain_V = 448,
    eCh0_VoutOffset_V = 452,

    eCh1_Mode = 456,
    eCh1_VoltageMin = 460,
    eCh1_VoltageMax = 464,
    eCh1_CurrentMin = 468,
    eCh1_CurrentMax = 472,
    eCh1_MaxCellTemp = 476,
    eCh1_F28V_Gain = 480,
    eCh1_F28V_Offset = 484,
    eCh1_F28I_Gain = 488,
    eCh1_F28I_Offset = 492,
    eCh1_IoutGain_pu = 496,
    eCh1_IoutOffset_pu = 500,
    eCh1_IoutGain_A = 504,
    eCh1_IoutOffset_A = 508,
    eCh1_VoutGain_pu = 512,
    eCh1_VoutOffset_pu = 516,
    eCh1_VoutGain_V = 520,
    eCh1_VoutOffset_V = 524,

    eCh2_Mode = 528,
    eCh2_VoltageMin = 532,
    eCh2_VoltageMax = 536,
    eCh2_CurrentMin = 540,
    eCh2_CurrentMax = 544,
    eCh2_MaxCellTemp = 548,
    eCh2_F28V_Gain = 552,
    eCh2_F28V_Offset = 556,
    eCh2_F28I_Gain = 560,
    eCh2_F28I_Offset = 564,
    eCh2_IoutGain_pu = 568,
    eCh2_IoutOffset_pu = 572,
    eCh2_IoutGain_A = 576,
    eCh2_IoutOffset_A = 580,
    eCh2_VoutGain_pu = 584,
    eCh2_VoutOffset_pu = 588,
    eCh2_VoutGain_V = 592,
    eCh2_VoutOffset_V = 596,

    eCh3_Mode = 600,
    eCh3_VoltageMin = 604,
    eCh3_VoltageMax = 608,
    eCh3_CurrentMin = 612,
    eCh3_CurrentMax = 616,
    eCh3_MaxCellTemp = 620,
    eCh3_F28V_Gain = 624,
    eCh3_F28V_Offset = 628,
    eCh3_F28I_Gain = 632,
    eCh3_F28I_Offset = 636,
    eCh3_IoutGain_pu = 640,
    eCh3_IoutOffset_pu = 644,
    eCh3_IoutGain_A = 648,
    eCh3_IoutOffset_A = 652,
    eCh3_VoutGain_pu = 656,
    eCh3_VoutOffset_pu = 660,
    eCh3_VoutGain_V = 664,
    eCh3_VoutOffset_V = 668,

    eCh4_Mode = 672,
    eCh4_VoltageMin = 676,
    eCh4_VoltageMax = 680,
    eCh4_CurrentMin = 684,
    eCh4_CurrentMax = 688,
    eCh4_MaxCellTemp = 692,
    eCh4_F28V_Gain = 696,
    eCh4_F28V_Offset = 700,
    eCh4_F28I_Gain = 704,
    eCh4_F28I_Offset = 708,
    eCh4_IoutGain_pu = 712,
    eCh4_IoutOffset_pu = 716,
    eCh4_IoutGain_A = 720,
    eCh4_IoutOffset_A = 724,
    eCh4_VoutGain_pu = 728,
    eCh4_VoutOffset_pu = 732,
    eCh4_VoutGain_V = 736,
    eCh4_VoutOffset_V = 740,

    eCh5_Mode = 744,
    eCh5_VoltageMin = 748,
    eCh5_VoltageMax = 752,
    eCh5_CurrentMin = 756,
    eCh5_CurrentMax = 760,
    eCh5_MaxCellTemp = 764,
    eCh5_F28V_Gain = 768,
    eCh5_F28V_Offset = 772,
    eCh5_F28I_Gain = 776,
    eCh5_F28I_Offset = 780,
    eCh5_IoutGain_pu = 784,
    eCh5_IoutOffset_pu = 788,
    eCh5_IoutGain_A = 792,
    eCh5_IoutOffset_A = 796,
    eCh5_VoutGain_pu = 800,
    eCh5_VoutOffset_pu = 804,
    eCh5_VoutGain_V = 808,
    eCh5_VoutOffset_V = 812,

    eCh6_Mode = 816,
    eCh6_VoltageMin = 820,
    eCh6_VoltageMax = 824,
    eCh6_CurrentMin = 828,
    eCh6_CurrentMax = 832,
    eCh6_MaxCellTemp = 836,
    eCh6_F28V_Gain = 840,
    eCh6_F28V_Offset = 844,
    eCh6_F28I_Gain = 848,
    eCh6_F28I_Offset = 852,
    eCh6_IoutGain_pu = 856,
    eCh6_IoutOffset_pu = 860,
    eCh6_IoutGain_A = 864,
    eCh6_IoutOffset_A = 868,
    eCh6_VoutGain_pu = 872,
    eCh6_VoutOffset_pu = 876,
    eCh6_VoutGain_V = 880,
    eCh6_VoutOffset_V = 884,

    eCh7_Mode = 888,
    eCh7_VoltageMin = 892,
    eCh7_VoltageMax = 896,
    eCh7_CurrentMin = 900,
    eCh7_CurrentMax = 904,
    eCh7_MaxCellTemp = 908,
    eCh7_F28V_Gain = 912,
    eCh7_F28V_Offset = 916,
    eCh7_F28I_Gain = 920,
    eCh7_F28I_Offset = 924,
    eCh7_IoutGain_pu = 928,
    eCh7_IoutOffset_pu = 932,
    eCh7_IoutGain_A = 936,
    eCh7_IoutOffset_A = 940,
    eCh7_VoutGain_pu = 944,
    eCh7_VoutOffset_pu = 948,
    eCh7_VoutGain_V = 952,
    eCh7_VoutOffset_V = 956,
    //
    // Unit block, base 960. eWatchdogRemaining_s is the live
    // countdown; calibration telemetry follows at 1224-1256.
    //
    eChargeDisableV = 960,
    eChargeRestrictV = 964,
    eDischargeRestrictV = 968,
    eDischargeDisableV = 972,
    eCalibrationMode = 976,
    eUnitState = 980,
    eInputVoltage = 984,
    eTripStatus = 988,
    eSlotMode = 992,
    eSlotEnable = 996,
    eGroupSize = 1000,
    eHostWatchdog_s = 1004,
    eCalSlot = 1008,
    eCalCommand = 1012,
    eCalArgument = 1016,
    eCalStatus = 1020,
    eCalResult = 1024,
    eWatchdogRemaining_s = 1028,
    eCalAdsV_pu = 1032,
    eCalAdsI_pu = 1036,
    eCalAdsV_V = 1040,
    eCalAdsI_A = 1044,
    eCalF28V_pu = 1048,
    eCalF28I_pu = 1052,
    eCalF28V_V = 1056,
    eCalF28I_A = 1060,
    eCalTemp_C = 1064,
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

    float32_t MaxCellTemp;      // Maximum cell temperature (only a max is kept)
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
//
// Layout is fixed at 32 words = 64 wire bytes, matching STATE_FRAM_STRIDE
// exactly. The previous revision was 20 words = 40 bytes against a 32-byte
// stride, so every slot's record ran 8 bytes into the next slot's header and
// clobbered its saveCounter and crc32 - only slot 7 could ever validate.
// Keep sizeof(BTS_slotRuntimeState) * 2 <= STATE_FRAM_STRIDE; there is a
// compile-time check on this in com_cpu2.c.
//
// The per-slot voltage and current limits live HERE, with the runtime data -
// deliberately NOT in BTS_channelCalibration. Calibration is measured once
// against a reference and should not be rewritten every time an operator
// changes a charge current, which is what kept putting the calibration image
// at risk of corruption.
//
// crc32 is the LAST member so it occupies the final 4 bytes of the record.
// New fields consume `reserved` and every existing offset - including the
// CRC's - stays put, so an older record still validates against the same
// generator. Shrink `reserved` when adding a field; never append past crc32.
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
    //
    // Slot settings. Runtime information, not calibration.
    //
    float32_t voltageMin;
    float32_t voltageMax;
    float32_t currentMin;
    float32_t currentMax;
    uint32_t  saveCounter;      // increments every save; staleness/wear info
    uint32_t  reserved[2];      // expansion; zero-filled, covered by the CRC
    uint32_t  crc32;            // over all preceding fields - keep LAST
} BTS_slotRuntimeState;

//
// Bumped 0x5A5E -> 0x5A5F with the 64-byte record. Old records were written
// with an overrunning stride and cannot be trusted, so they must fail the
// header test rather than be reinterpreted against the new layout.
//
#define BTS_STATE_HEADER       0x5A5F0000UL
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
    //
    // Raw sample rings. The two converters have different widths, and the
    // storage must not narrow either of them:
    //
    //   ADS131M08  24-bit silicon, but this firmware configures it into
    //              16-bit WORD mode (MODE register written 0x0000,
    //              WLENGTH = 00, in BTS_HAL_setupExAdc_*). Samples arrive
    //              as 16-bit two's complement. int32_t is used anyway so
    //              raising WLENGTH to 24-bit later needs no storage change -
    //              and so the sum below cannot silently narrow.
    //   F2837xD    12-bit single-ended, so int16_t is exact and sufficient.
    //
    // BTS_ADS131_FULLSCALE must track the configured WORD length, not the
    // converter's silicon width. See the note on it in bts_user_settings.h.
    //
    int32_t Isense_24b[BTS_senseAverageFactor];
    int32_t Vsense_24b[BTS_senseAverageFactor];
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
//   settings  18 regs/slot  eCh0_Mode    .. eCh7_VoutOffset_V
//   unit      27 regs total eChargeDisableV .. eCalTemp_C
//
#define BTS_REG_IDX(addr)           ((uint16_t)((addr) / 4U))

#define BTS_RT_BASE(ch)     (BTS_REG_IDX(eCh0_Status) + (ch) * BTS_RT_REGS_PER_CH)
#define BTS_SET_BASE(ch)    (BTS_REG_IDX(eCh0_Mode)   + (ch) * BTS_SET_REGS_PER_CH)

// The 12 calibration registers sit at settings offset 11 and keep their
// internal BTS_CAL_* order, so saveCalibration()/loadCalibration() index
// through this exactly as before.
#define BTS_CAL_BASE(ch)    (BTS_SET_BASE(ch) + 6U)
#define BTS_TEMP_BASE(ch)   (BTS_SET_BASE(ch) + 5U)

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

// Offsets within a slot's settings block at BTS_SET_BASE(ch). Offset 5 is the
// maximum cell temperature (BTS_TEMP_BASE) and 6-17 the calibration group
// (BTS_CAL_BASE).
//
// The limits are direction-agnostic: the mode register selects charge or
// discharge, so one voltage pair and one current pair covers both. The old
// BTS_SET_CHG_*/BTS_SET_DIS_* split is gone.
#define BTS_SET_MODE           0U
#define BTS_SET_V_MIN          1U
#define BTS_SET_V_MAX          2U
#define BTS_SET_I_MIN          3U
#define BTS_SET_I_MAX          4U

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

// Cell-temperature limit at BTS_TEMP_BASE(ch). Only a maximum is enforced -
// the minimum was removed in the 2026-09-22 compression.
#define BTS_TEMP_MAX           0U

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
