/*
 * bts_regs.h
 *
 * Mirror of the BTS register map exposed by the TI F2837xD over I2C.
 *
 * This is a transcription of tida-010086/bts_F2837xD_8ch/registers.h. When
 * that file changes, this one must be updated to match - there is no build
 * coupling between the C2000 project and this one.
 *
 * MAP VERSION 2
 * -------------
 * Every address moved in v2. The map is three regions rather than nine
 * scattered blocks, so a slot's live data is one contiguous burst and a poll
 * cycle costs ~10 transactions instead of ~33. Both sides must be flashed
 * together; there is no compatibility window.
 *
 * WIRE FORMAT
 * -----------
 * The unit is an I2C target at 0x50 on I2CA. A register access is:
 *
 *   read:   S ADDR+W  regHi regLo  Sr ADDR+R  pad b0 b1 b2 b3  P
 *   write:  S ADDR+W  regHi regLo  b0 b1 b2 b3  P
 *
 * Note the lead-in `pad` byte on every read: the C2000 starts clocking out
 * whatever its transmit register holds the instant it acknowledges the
 * repeated start, which is before its ISR can run. Read 1 + count*4 bytes and
 * discard the first - see bus_read_block() in bts_link.c.
 *
 * Every register is a 4-byte IEEE-754 float. The register address on the
 * wire is a BYTE address (index * 4).
 *
 * Both directions auto-increment by 4 after a complete register, so a burst
 * read of a whole block is a single transaction (see i2cSlaveISR() in
 * com_cpu2.c). A burst WRITE must NOT resend the address for subsequent
 * registers - the target keeps its own pointer across them.
 *
 * Any register read also reloads the unit's host watchdog, so the poll task
 * keeps the link supervision alive without a dedicated keep-alive write.
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
 * REGIONS
 * -------
 *   runtime   RO   base 0     stride 48 B (12 regs)    0 - 383
 *   settings  RW   base 384   stride 96 B (24 regs)    384 - 1151
 *   unit      mixed base 1152                          1152 - 1252
 *
 * The strides are deliberately larger than the fields in use, so adding a
 * field later does not move every slot again.
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
#define BTS_TOTAL_REGISTERS     314

/* Region bases and per-channel byte strides. */
#define BTS_RT_BASE             0
#define BTS_RT_STRIDE           48
#define BTS_RT_REG_COUNT        12

#define BTS_SET_BASE            384
#define BTS_SET_STRIDE          96
#define BTS_SET_REG_COUNT       24

#define BTS_UNIT_BASE           1152

/* Runtime block, byte offsets within a channel. All REG_ACCESS_RO. */
#define BTS_RT_STATUS                   0
#define BTS_RT_CELL_VOLTAGE             4    /* internal 12-bit ADC       */
#define BTS_RT_CELL_CURRENT             8    /* internal 12-bit ADC       */
#define BTS_RT_SENSE_VOLTAGE            12   /* ADS131M08 16-bit          */
#define BTS_RT_SENSE_CURRENT            16   /* ADS131M08 16-bit          */
#define BTS_RT_CELL_TEMP                20   /* ADS1119                   */
#define BTS_RT_CHARGE_MAH               24
#define BTS_RT_CHARGE_MWH               28
#define BTS_RT_CHARGE_SECONDS           32
#define BTS_RT_DISCHARGE_MAH            36
#define BTS_RT_DISCHARGE_MWH            40
#define BTS_RT_DISCHARGE_SECONDS        44

/*
 * Settings block, byte offsets within a channel.
 *
 * 21 of the 24 registers are used; +92 is spare. The 12 calibration
 * registers keep their internal order, so BTS_CAL_* below remain offsets
 * 0..44 relative to BTS_CAL_ADDR(ch, 0).
 */
#define BTS_SET_MODE                    0
#define BTS_SET_CHARGE_V_MIN            4
#define BTS_SET_CHARGE_V_MAX            8
#define BTS_SET_DISCHARGE_V_MIN         12
#define BTS_SET_DISCHARGE_V_MAX         16
#define BTS_SET_CHARGE_I_MIN            20
#define BTS_SET_CHARGE_I_MAX            24
#define BTS_SET_DISCHARGE_I_MIN         28
#define BTS_SET_DISCHARGE_I_MAX         32
#define BTS_SET_MIN_CELL_TEMP           36
#define BTS_SET_MAX_CELL_TEMP           40
#define BTS_SET_CAL_FIRST               44

/* Unit block. */
#define BTS_REG_CHARGE_DISABLE_V        1152
#define BTS_REG_CHARGE_RESTRICT_V       1156
#define BTS_REG_DISCHARGE_RESTRICT_V    1160
#define BTS_REG_DISCHARGE_DISABLE_V     1164
#define BTS_REG_CALIBRATION_MODE        1168
#define BTS_REG_UNIT_STATE              1172
#define BTS_REG_INPUT_VOLTAGE           1176
#define BTS_REG_TRIP_STATUS             1180
/* Slot grouping, latched from the MODE/ENABLE straps by CPU1 at boot. */
#define BTS_REG_SLOT_MODE               1184
#define BTS_REG_SLOT_ENABLE             1188
#define BTS_REG_GROUP_SIZE              1192
/*
 * Host watchdog timeout in seconds, RW, default 30. Any host command -
 * including a register READ - reloads the unit's countdown; when it expires
 * every running slot is paused with BTS_STATUS_WD_TRIPPED. Writing 0
 * disables it, which is a bench-only setting and is logged loudly by the
 * unit. There is no register for the remaining seconds, only the timeout.
 */
#define BTS_REG_HOST_WATCHDOG_S         1196

/*
 * Calibration control block (unit-level).
 *
 * Unit-scoped rather than per-slot because only one slot calibrates at a
 * time - the per-slot form would not fit in CPU2TOCPU1RAM. eCalSlot names
 * the slot the telemetry block below refers to.
 */
#define BTS_REG_CAL_SLOT                1200
#define BTS_REG_CAL_COMMAND             1204
#define BTS_REG_CAL_ARGUMENT            1208
#define BTS_REG_CAL_STATUS              1212
#define BTS_REG_CAL_RESULT              1216

/* Calibration live telemetry for the slot named by eCalSlot. */
#define BTS_REG_CAL_ADS_V_PU            1220
#define BTS_REG_CAL_ADS_I_PU            1224
#define BTS_REG_CAL_ADS_V_V             1228
#define BTS_REG_CAL_ADS_I_A             1232
#define BTS_REG_CAL_F28_V_PU            1236
#define BTS_REG_CAL_F28_I_PU            1240
#define BTS_REG_CAL_F28_V_V             1244
#define BTS_REG_CAL_F28_I_A             1248
#define BTS_REG_CAL_TEMP_C              1252

/* Registers 1200..1252 inclusive, readable as one burst. */
#define BTS_CAL_WINDOW_COUNT            14

/*
 * Unit poll window: eCalibrationMode (1168) .. eHostWatchdog_s (1196), the
 * eight consecutive registers the poll task needs every cycle.
 */
#define BTS_UNIT_WINDOW_FIRST           BTS_REG_CALIBRATION_MODE
#define BTS_UNIT_WINDOW_COUNT           8

/* Address helpers. Prefer these over open-coded arithmetic. */
#define BTS_RT_ADDR(ch, off)    (BTS_RT_BASE  + (ch) * BTS_RT_STRIDE  + (off))
#define BTS_SET_ADDR(ch, off)   (BTS_SET_BASE + (ch) * BTS_SET_STRIDE + (off))
#define BTS_CAL_ADDR(ch, off)   (BTS_SET_ADDR((ch), BTS_SET_CAL_FIRST) + (off))

/*
 * Per-channel calibration block, byte offsets within BTS_CAL_ADDR(ch, .).
 * The order matches BTS_channelCalibration's float members on the C2000, so
 * these double as the F-RAM image layout.
 */
#define BTS_CAL_F28V_GAIN               0
#define BTS_CAL_F28V_OFFSET             4
#define BTS_CAL_F28I_GAIN               8
#define BTS_CAL_F28I_OFFSET             12
#define BTS_CAL_IOUT_GAIN_PU            16
#define BTS_CAL_IOUT_OFFSET_PU          20
#define BTS_CAL_IOUT_GAIN_A             24
#define BTS_CAL_IOUT_OFFSET_A           28
#define BTS_CAL_VOUT_GAIN_PU            32
#define BTS_CAL_VOUT_OFFSET_PU          36
#define BTS_CAL_VOUT_GAIN_V             40
#define BTS_CAL_VOUT_OFFSET_V           44

/*
 * Calibration command opcodes, written to BTS_REG_CAL_COMMAND.
 *
 * The argument register must be written FIRST: the command is consumed on
 * write and self-clears, so an argument that arrives afterwards is too late.
 */
typedef enum {
    BTS_CAL_CMD_NONE             = 0,
    BTS_CAL_CMD_ENTER            = 1,
    BTS_CAL_CMD_EXIT             = 2,
    BTS_CAL_CMD_CAPTURE_VOLTAGE  = 3,  /* arg: measured volts              */
    BTS_CAL_CMD_ZERO_CURRENT     = 4,
    BTS_CAL_CMD_SET_FIXED_CURRENT= 5,  /* arg: pu setpoint, 0.0 .. 0.8     */
    BTS_CAL_CMD_CAPTURE_CURRENT  = 6,  /* arg: measured amps, magnitude    */
    BTS_CAL_CMD_COMPUTE_SAVE     = 7,
    BTS_CAL_CMD_CLEAR            = 8,
} bts_cal_cmd_t;

/* BTS_REG_CAL_STATUS bitfield. */
#define BTS_CAL_ST_ACTIVE           (1u << 0)
#define BTS_CAL_ST_V_LOW            (1u << 1)
#define BTS_CAL_ST_V_HIGH           (1u << 2)
#define BTS_CAL_ST_I_ZERO           (1u << 3)
#define BTS_CAL_ST_I_LOADED         (1u << 4)
#define BTS_CAL_ST_V_COMPUTED       (1u << 5)
#define BTS_CAL_ST_I_COMPUTED       (1u << 6)
#define BTS_CAL_ST_SAVED            (1u << 7)
#define BTS_CAL_ST_DRIVING          (1u << 8)
#define BTS_CAL_ST_FAILED           (1u << 9)

/* BTS_REG_CAL_RESULT codes, the outcome of the last command. */
typedef enum {
    BTS_CAL_ERR_OK               = 0,
    BTS_CAL_ERR_BUSY             = 1,  /* another slot is calibrating      */
    BTS_CAL_ERR_TESTING          = 2,
    BTS_CAL_ERR_SLOT_UNAVAILABLE = 3,  /* strap-disabled or a follower     */
    BTS_CAL_ERR_PU_RANGE         = 4,
    BTS_CAL_ERR_INSUFFICIENT     = 5,
    BTS_CAL_ERR_VALIDATE         = 6,
    BTS_CAL_ERR_FRAM             = 7,
    BTS_CAL_ERR_ARG              = 8,
    BTS_CAL_ERR_NOT_ACTIVE       = 9,
} bts_cal_result_t;

/* eCalSlot value meaning "no slot selected". */
#define BTS_CAL_SLOT_NONE           255u

/*
 * Mode register bitfield, consumed by modeCallback() on CPU1.
 *
 * Note the asymmetry: bit 1 clear means DISCHARGE, so "stop" and "start a
 * discharge" differ only in bit 0. modeCallback() also refuses the command
 * outright if the DC input voltage is outside the charge/discharge restrict
 * window, leaving the channel stopped - always read back the status.
 *
 * Bit 2 is a second entry point into calibration, equivalent to writing
 * eCalSlot then CAL_CMD_ENTER. Both route to the same handler on CPU1, so
 * the one-slot-at-a-time rule is enforced once.
 *
 * Bits 3 and 4 are EDGE commands: acted on at the write and not retained, so
 * there is no matching "un-pause" bit to clear afterwards. Resume on a slot
 * that is not paused is a no-op, and writing plain RUN to a paused slot also
 * resumes it, so a host that predates v2 still works.
 */
#define BTS_MODE_STOP               0x00u
#define BTS_MODE_RUN                0x01u
#define BTS_MODE_CHARGE             0x02u
#define BTS_MODE_CALIBRATE          0x04u
#define BTS_MODE_PAUSE              0x08u
#define BTS_MODE_RESUME             0x10u
#define BTS_MODE_RUN_DISCHARGE      (BTS_MODE_RUN)
#define BTS_MODE_RUN_CHARGE         (BTS_MODE_RUN | BTS_MODE_CHARGE)

/*
 * Status register bitfield, as packed by publishStatusToCpu2() on CPU1.
 *
 * The word arrives as a float32, whose 24-bit significand makes integers
 * exact only to bit 23 - the C2000 side must never publish past that.
 *
 * NOTE these are MASKS, while the identically-named BTS_STATUS_* in the
 * C2000 registers.h are bit POSITIONS (RUNNING is 0U there, 1u<<0 here).
 * The same split applies to BTS_CAL_ST_*, and to the BTS_CAL_ and BTS_RT_
 * offsets, which are register indices on the C2000 and byte offsets here.
 * Copying a line between the two files compiles and is silently wrong.
 */
#define BTS_STATUS_RUNNING          (1u << 0)
#define BTS_STATUS_STOPPED          (1u << 1)
#define BTS_STATUS_FINISHED         (1u << 2)
#define BTS_STATUS_OVERCURRENT      (1u << 3)
#define BTS_STATUS_CHARGING         (1u << 4)
#define BTS_STATUS_DISCHARGING      (1u << 5)
#define BTS_STATUS_CONST_VOLTAGE    (1u << 6)
#define BTS_STATUS_CONST_CURRENT    (1u << 7)
#define BTS_STATUS_SLAVE_MODE       (1u << 8)
#define BTS_STATUS_GROUP_DISCONNECT (1u << 9)
#define BTS_STATUS_REVERSE_POLARITY (1u << 10)
#define BTS_STATUS_SLOT_DISABLED    (1u << 11)
#define BTS_STATUS_CALIBRATING      (1u << 12)
/*
 * Bits 13/14 are driven from the PERSISTED calibration validity, not from
 * the in-session capture, so a slot calibrated in an earlier session still
 * shows its ticks on the display after a power cycle.
 */
#define BTS_STATUS_CAL_V_VALID      (1u << 13)
#define BTS_STATUS_CAL_I_VALID      (1u << 14)
/*
 * PAUSED is not a direction of its own: the slot keeps its CHARGING or
 * DISCHARGING bit set alongside it, so a host can see both that it is paused
 * and what it would resume into. WD_TRIPPED and RESTORED say WHY, which is
 * what decides whether resuming is safe - a watchdog pause means the link
 * died mid-run, a restore means the unit reset and the cell may have been
 * swapped while it was off. Both clear on resume.
 */
#define BTS_STATUS_PAUSED           (1u << 15)
#define BTS_STATUS_WD_TRIPPED       (1u << 17)
#define BTS_STATUS_RESTORED         (1u << 18)

/*
 * A normally terminated test is FINISHED, bit 2. That bit was declared but
 * never driven before v2; the firmware now drives it and defines its own
 * BTS_STATUS_END as an alias for it rather than spending a second bit on the
 * same state. Bit 16 is unused and reads a constant 0 - do not test for it.
 *
 * The mask is kept as the single thing consumers test, so if END ever does
 * become a distinct bit this is the one line that changes.
 */
#define BTS_STATUS_END              BTS_STATUS_FINISHED
#define BTS_STATUS_ENDED_MASK       (BTS_STATUS_FINISHED)

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
