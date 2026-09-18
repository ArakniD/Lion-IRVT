/*
 * bts_regs.h
 *
 * Mirror of the BTS register map exposed by the TI F2837xD over I2C.
 *
 * This is a transcription of tida-010086/bts_F2837xD_8ch/registers.h. When
 * that file changes, this one must be updated to match - there is no build
 * coupling between the C2000 project and this one.
 *
 * WIRE FORMAT
 * -----------
 * The unit is an I2C target at 0x50 on I2CA. A register access is:
 *
 *   read:   S ADDR+W  regHi regLo  Sr ADDR+R  b0 b1 b2 b3  P
 *   write:  S ADDR+W  regHi regLo  b0 b1 b2 b3  P
 *
 * Every register is a 4-byte IEEE-754 float. The register address on the
 * wire is a BYTE address (index * 4).
 *
 * Both directions auto-increment by 4 after a complete register, so a burst
 * read of a whole block is a single transaction (see i2cSlaveISR() in
 * com_cpu2.c). After a write completes the ISR rewinds byteCount to 2, which
 * means a burst WRITE must NOT resend the address for subsequent registers.
 *
 * BYTE ORDER
 * ----------
 * The C2000 is a 16-bit-word machine. floatGetWireByte() in com_cpu2.c emits
 *   index 0 -> word1 high, 1 -> word1 low, 2 -> word0 high, 3 -> word0 low
 * where word0 is the low half of the float. That is big-endian byte order
 * for the float as a whole, NOT the little-endian assumed by the older
 * ESPHome bts_i2c component in esp32-controller/. Use bts_wire_to_f32() and
 * bts_f32_to_wire() below rather than memcpy.
 *
 * BLOCK STRIDES
 * -------------
 * The blocks do not share a stride. Deriving an address by assuming 10
 * registers per channel everywhere is the bug in the old ESPHome component
 * (it used x24 for stats and x8 for temperature against a x40 control map).
 *
 *   control      10 regs/channel   40 bytes/channel   base 0
 *   stats         6 regs/channel   24 bytes/channel   base 320
 *   temp limits   2 regs/channel    8 bytes/channel   base 512
 *   global V      4 regs total                        base 576
 *   calibration  12 regs/channel   48 bytes/channel   base 592
 *   unit          4 regs total                        base 976
 *   cell temp     1 reg/channel     4 bytes/channel   base 992
 */

#ifndef BTS_REGS_H
#define BTS_REGS_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

#define BTS_I2C_ADDRESS         0x50
#define BTS_NUM_CHANNELS        8
#define BTS_REGISTER_SIZE       4
#define BTS_TOTAL_REGISTERS     256

/* Block bases, as byte addresses. */
#define BTS_REG_CTRL_BASE       0
#define BTS_REG_STATS_BASE      320
#define BTS_REG_TEMPLIM_BASE    512
#define BTS_REG_GLOBALV_BASE    576
#define BTS_REG_CAL_BASE        592
#define BTS_REG_UNIT_BASE       976
#define BTS_REG_CELLTEMP_BASE   992

/* Per-channel byte strides. */
#define BTS_CTRL_STRIDE         40
#define BTS_STATS_STRIDE        24
#define BTS_TEMPLIM_STRIDE      8
#define BTS_CAL_STRIDE          48
#define BTS_CELLTEMP_STRIDE     4

/* Control block, offsets within a channel. */
#define BTS_CTRL_MODE                   0
#define BTS_CTRL_CHARGE_V_MIN           4
#define BTS_CTRL_CHARGE_V_MAX           8
#define BTS_CTRL_DISCHARGE_V_MIN        12
#define BTS_CTRL_DISCHARGE_V_MAX        16
#define BTS_CTRL_CHARGE_I_MIN           20
#define BTS_CTRL_CHARGE_I_MAX           24
#define BTS_CTRL_DISCHARGE_I_MIN        28
#define BTS_CTRL_DISCHARGE_I_MAX        32
#define BTS_CTRL_STATUS                 36

/* Stats block, offsets within a channel. */
#define BTS_STATS_CURRENT_ACC           0
#define BTS_STATS_MIN_VOLTAGE           4
#define BTS_STATS_MAX_VOLTAGE           8
#define BTS_STATS_POWER_ACC             12
#define BTS_STATS_CELL_VOLTAGE          16
#define BTS_STATS_CELL_CURRENT          20

/* Temperature limit block, offsets within a channel. */
#define BTS_TEMPLIM_MIN                 0
#define BTS_TEMPLIM_MAX                 4

/* Global voltage thresholds (unit-wide, not per channel). */
#define BTS_REG_CHARGE_DISABLE_V        576
#define BTS_REG_CHARGE_RESTRICT_V       580
#define BTS_REG_DISCHARGE_RESTRICT_V    584
#define BTS_REG_DISCHARGE_DISABLE_V     588

/* Unit block. */
#define BTS_REG_CALIBRATION_MODE        976
#define BTS_REG_UNIT_STATE              980
#define BTS_REG_INPUT_VOLTAGE           984
#define BTS_REG_TRIP_STATUS             988

/* Address helpers. Prefer these over open-coded arithmetic. */
#define BTS_CTRL_ADDR(ch, off)      (BTS_REG_CTRL_BASE     + (ch) * BTS_CTRL_STRIDE     + (off))
#define BTS_STATS_ADDR(ch, off)     (BTS_REG_STATS_BASE    + (ch) * BTS_STATS_STRIDE    + (off))
#define BTS_TEMPLIM_ADDR(ch, off)   (BTS_REG_TEMPLIM_BASE  + (ch) * BTS_TEMPLIM_STRIDE  + (off))
#define BTS_CAL_ADDR(ch, off)       (BTS_REG_CAL_BASE      + (ch) * BTS_CAL_STRIDE      + (off))
#define BTS_CELLTEMP_ADDR(ch)       (BTS_REG_CELLTEMP_BASE + (ch) * BTS_CELLTEMP_STRIDE)

/*
 * Mode register bitfield, consumed by modeCallback() on CPU1.
 *
 * Note the asymmetry: bit 1 clear means DISCHARGE, so "stop" and "start a
 * discharge" differ only in bit 0. modeCallback() also refuses the command
 * outright if the DC input voltage is outside the charge/discharge restrict
 * window, leaving the channel stopped - always read back the status.
 */
#define BTS_MODE_STOP               0x00u
#define BTS_MODE_RUN                0x01u
#define BTS_MODE_CHARGE             0x02u
#define BTS_MODE_RUN_DISCHARGE      (BTS_MODE_RUN)
#define BTS_MODE_RUN_CHARGE         (BTS_MODE_RUN | BTS_MODE_CHARGE)

/* Status register bitfield, as packed by publishStatusToCpu2() on CPU1. */
#define BTS_STATUS_RUNNING          (1u << 0)
#define BTS_STATUS_STOPPED          (1u << 1)
#define BTS_STATUS_FINISHED         (1u << 2)
#define BTS_STATUS_OVERCURRENT      (1u << 3)
#define BTS_STATUS_CHARGING         (1u << 4)
#define BTS_STATUS_DISCHARGING      (1u << 5)
#define BTS_STATUS_CONST_VOLTAGE    (1u << 6)
#define BTS_STATUS_CONST_CURRENT    (1u << 7)

/* Trip status bitfield: two bits per channel, CMPSS then GPIO. */
#define BTS_TRIP_CMPSS(ch)          (1u << ((ch) * 2u))
#define BTS_TRIP_GPIO(ch)           (1u << ((ch) * 2u + 1u))

/* eUnitState values, mirroring the UnitState enum in registers.h. */
typedef enum {
    BTS_UNIT_INPUT_LOW_CHARGE_DISABLED      = 0,
    BTS_UNIT_INPUT_LOW_CHARGE_RESTRICTED    = 1,
    BTS_UNIT_INPUT_OK                       = 2,
    BTS_UNIT_INPUT_HIGH_DISCHARGE_RESTRICTED = 3,
    BTS_UNIT_INPUT_HIGH_DISCHARGE_DISABLED  = 4,
} bts_unit_state_t;

/*
 * Hardware envelope of the TIDA-010086 unit itself. Any cell profile that
 * asks for more than this is clamped before it reaches the BTS - see
 * cell_profiles.c. Sourced from bts_user_settings.h
 * (BTS_CMPSS_FULLSCALE_A) and the 0-5 V per-channel output range.
 */
#define BTS_UNIT_MAX_CURRENT_A      10.0f
#define BTS_UNIT_MAX_VOLTAGE_V      5.0f

/*
 * Wire <-> float conversion.
 *
 * The C2000 emits the float most-significant byte first. These helpers are
 * endian-independent on the ESP32 side: they assemble through a uint32_t
 * rather than aliasing a float, so they are correct regardless of how the
 * compiler lays out the target.
 */
static inline float bts_wire_to_f32(const uint8_t b[4])
{
    union { uint32_t u; float f; } cvt;
    cvt.u = ((uint32_t)b[0] << 24) | ((uint32_t)b[1] << 16) |
            ((uint32_t)b[2] << 8)  | ((uint32_t)b[3]);
    return cvt.f;
}

static inline void bts_f32_to_wire(float value, uint8_t b[4])
{
    union { uint32_t u; float f; } cvt;
    cvt.f = value;
    b[0] = (uint8_t)((cvt.u >> 24) & 0xFFu);
    b[1] = (uint8_t)((cvt.u >> 16) & 0xFFu);
    b[2] = (uint8_t)((cvt.u >> 8)  & 0xFFu);
    b[3] = (uint8_t)(cvt.u & 0xFFu);
}

#ifdef __cplusplus
}
#endif

#endif /* BTS_REGS_H */
