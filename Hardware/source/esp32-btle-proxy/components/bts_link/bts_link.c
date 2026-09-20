/*
 * bts_link.c
 *
 * I2C transport and polling loop for the TIDA-010086 BTS unit.
 */

#include <string.h>
#include <math.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/semphr.h"
#include "driver/i2c_master.h"
#include "driver/gpio.h"
#include "esp_log.h"
#include "esp_check.h"
#include "esp_timer.h"
#include "bts_link.h"

static const char *TAG = "bts_link";

#define BTS_XFER_TIMEOUT_MS     100
#define BTS_POLL_TASK_STACK     4096
#define BTS_POLL_TASK_PRIO      6

static i2c_master_bus_handle_t s_bus;
static i2c_master_dev_handle_t s_dev;
static SemaphoreHandle_t       s_bus_mutex;
static SemaphoreHandle_t       s_snap_mutex;
static bts_snapshot_t          s_snapshot;
static bool                    s_stats_live;
static uint32_t                s_poll_interval_ms = 250;
static int                     s_sda_gpio = -1;
static int                     s_scl_gpio = -1;
/*
 * Set by every calibration command so the next poll reads the window even
 * though no channel has reported BTS_STATUS_CALIBRATING yet. Without it a
 * host that enters calibration and immediately asks for the state sees the
 * pre-command snapshot.
 */
static volatile bool           s_cal_poll_due;

/* ------------------------------------------------------------------ */
/* Low-level bus access. Callers must NOT hold s_bus_mutex.            */
/* ------------------------------------------------------------------ */

static esp_err_t bus_read_block(uint16_t reg_addr, float *out, size_t count)
{
    if (count == 0 || count > BTS_TOTAL_REGISTERS) {
        return ESP_ERR_INVALID_ARG;
    }

    uint8_t addr_buf[2] = {
        (uint8_t)((reg_addr >> 8) & 0xFFu),
        (uint8_t)(reg_addr & 0xFFu),
    };

    /*
     * One transaction for the whole block: the target auto-increments its
     * address after each complete 4-byte register on read.
     */
    /*
     * One lead-in byte.
     *
     * The C2000 target starts clocking data out the instant it
     * acknowledges the repeated start, which is before its interrupt can
     * possibly be serviced. Whatever its transmit register happens to
     * hold at that moment goes onto the wire first, so every reply is
     * preceded by one byte of padding. That is a property of the
     * peripheral, not a bug that can be fixed on the target - so read one
     * extra byte and step over it.
     */
    uint8_t rx[1 + BTS_TOTAL_REGISTERS * BTS_REGISTER_SIZE];
    size_t rx_len = 1u + (count * BTS_REGISTER_SIZE);

    esp_err_t err = i2c_master_transmit_receive(s_dev, addr_buf, sizeof(addr_buf),
                                                rx, rx_len, BTS_XFER_TIMEOUT_MS);
    if (err != ESP_OK) {
        return err;
    }

    for (size_t i = 0; i < count; i++) {
        out[i] = bts_wire_to_f32(&rx[1u + (i * BTS_REGISTER_SIZE)]);
    }
    return ESP_OK;
}

static esp_err_t bus_write_reg(uint16_t reg_addr, float value)
{
    uint8_t buf[2 + BTS_REGISTER_SIZE];
    buf[0] = (uint8_t)((reg_addr >> 8) & 0xFFu);
    buf[1] = (uint8_t)(reg_addr & 0xFFu);
    bts_f32_to_wire(value, &buf[2]);

    return i2c_master_transmit(s_dev, buf, sizeof(buf), BTS_XFER_TIMEOUT_MS);
}

/* ------------------------------------------------------------------ */
/* Public register access                                             */
/* ------------------------------------------------------------------ */

esp_err_t bts_link_read_block(uint16_t reg_addr, float *out_values, size_t count)
{
    if (out_values == NULL) {
        return ESP_ERR_INVALID_ARG;
    }
    if (xSemaphoreTake(s_bus_mutex, pdMS_TO_TICKS(500)) != pdTRUE) {
        return ESP_ERR_TIMEOUT;
    }
    esp_err_t err = bus_read_block(reg_addr, out_values, count);
    xSemaphoreGive(s_bus_mutex);
    return err;
}

esp_err_t bts_link_read_reg(uint16_t reg_addr, float *out_value)
{
    return bts_link_read_block(reg_addr, out_value, 1);
}

esp_err_t bts_link_write_reg(uint16_t reg_addr, float value)
{
    if (xSemaphoreTake(s_bus_mutex, pdMS_TO_TICKS(500)) != pdTRUE) {
        return ESP_ERR_TIMEOUT;
    }
    esp_err_t err = bus_write_reg(reg_addr, value);
    xSemaphoreGive(s_bus_mutex);
    return err;
}

/* ------------------------------------------------------------------ */
/* Control helpers                                                    */
/* ------------------------------------------------------------------ */

esp_err_t bts_link_set_mode(uint8_t channel, uint32_t mode)
{
    if (channel >= BTS_NUM_CHANNELS) {
        return ESP_ERR_INVALID_ARG;
    }
    return bts_link_write_reg(BTS_SET_ADDR(channel, BTS_SET_MODE), (float)mode);
}

esp_err_t bts_link_stop_channel(uint8_t channel)
{
    return bts_link_set_mode(channel, BTS_MODE_STOP);
}

/*
 * Pause and resume are edge commands: the bit is acted on at the write and
 * not retained, so there is nothing to clear afterwards and no read-modify
 * of the mode register is needed.
 */
esp_err_t bts_link_pause_channel(uint8_t channel)
{
    return bts_link_set_mode(channel, BTS_MODE_PAUSE);
}

esp_err_t bts_link_resume_channel(uint8_t channel)
{
    return bts_link_set_mode(channel, BTS_MODE_RESUME);
}

esp_err_t bts_link_stop_all(void)
{
    esp_err_t first_err = ESP_OK;
    for (uint8_t ch = 0; ch < BTS_NUM_CHANNELS; ch++) {
        esp_err_t err = bts_link_stop_channel(ch);
        if (err != ESP_OK && first_err == ESP_OK) {
            first_err = err;
        }
    }
    return first_err;
}

static float clampf(float v, float lo, float hi)
{
    if (v < lo) return lo;
    if (v > hi) return hi;
    return v;
}

esp_err_t bts_link_set_limits(uint8_t channel, const bts_channel_limits_t *lim)
{
    if (channel >= BTS_NUM_CHANNELS || lim == NULL) {
        return ESP_ERR_INVALID_ARG;
    }

    /*
     * Last line of defence before the power stage. cell_profiles.c has
     * already clamped, but this function is reachable from the web API with
     * caller-supplied numbers, so clamp again here.
     */
    const float vmax = BTS_UNIT_MAX_VOLTAGE_V;
    const float imax = BTS_UNIT_MAX_CURRENT_A;

    struct { uint16_t addr; float value; } writes[] = {
        { BTS_SET_ADDR(channel, BTS_SET_CHARGE_V_MIN),
          clampf(lim->charge_voltage_min, 0.0f, vmax) },
        { BTS_SET_ADDR(channel, BTS_SET_CHARGE_V_MAX),
          clampf(lim->charge_voltage_max, 0.0f, vmax) },
        { BTS_SET_ADDR(channel, BTS_SET_DISCHARGE_V_MIN),
          clampf(lim->discharge_voltage_min, 0.0f, vmax) },
        { BTS_SET_ADDR(channel, BTS_SET_DISCHARGE_V_MAX),
          clampf(lim->discharge_voltage_max, 0.0f, vmax) },
        { BTS_SET_ADDR(channel, BTS_SET_CHARGE_I_MIN),
          clampf(lim->charge_current_min, 0.0f, imax) },
        { BTS_SET_ADDR(channel, BTS_SET_CHARGE_I_MAX),
          clampf(lim->charge_current_max, 0.0f, imax) },
        { BTS_SET_ADDR(channel, BTS_SET_DISCHARGE_I_MIN),
          clampf(lim->discharge_current_min, 0.0f, imax) },
        { BTS_SET_ADDR(channel, BTS_SET_DISCHARGE_I_MAX),
          clampf(lim->discharge_current_max, 0.0f, imax) },
        { BTS_SET_ADDR(channel, BTS_SET_MIN_CELL_TEMP), lim->min_cell_temp },
        { BTS_SET_ADDR(channel, BTS_SET_MAX_CELL_TEMP), lim->max_cell_temp },
    };

    if (xSemaphoreTake(s_bus_mutex, pdMS_TO_TICKS(1000)) != pdTRUE) {
        return ESP_ERR_TIMEOUT;
    }

    esp_err_t err = ESP_OK;
    for (size_t i = 0; i < sizeof(writes) / sizeof(writes[0]); i++) {
        /*
         * Deliberately one transaction per register rather than a burst.
         * Each RW write raises an IPC flag to CPU1, and these land in the
         * limit registers that modeCallback() will latch; keeping them
         * separate keeps the failure granularity per-register.
         */
        err = bus_write_reg(writes[i].addr, writes[i].value);
        if (err != ESP_OK) {
            ESP_LOGE(TAG, "ch%u limit write to 0x%03X failed: %s",
                     channel, writes[i].addr, esp_err_to_name(err));
            break;
        }
    }

    xSemaphoreGive(s_bus_mutex);
    return err;
}

/* ------------------------------------------------------------------ */
/* Calibration commands                                               */
/* ------------------------------------------------------------------ */

/*
 * One calibration command, as the three-step sequence the design requires:
 * argument, opcode, result.
 *
 * All three run under one take of the bus mutex. The opcode is consumed on
 * write and self-clears, so an argument that lands after it - which is what
 * an interleaved caller would produce - would be applied to nothing.
 */
static esp_err_t cal_command(uint8_t opcode, float argument, uint32_t *out_result)
{
    if (xSemaphoreTake(s_bus_mutex, pdMS_TO_TICKS(1000)) != pdTRUE) {
        return ESP_ERR_TIMEOUT;
    }

    esp_err_t err = bus_write_reg(BTS_REG_CAL_ARGUMENT, argument);
    if (err == ESP_OK) {
        err = bus_write_reg(BTS_REG_CAL_COMMAND, (float)opcode);
    }

    float result = 0.0f;
    if (err == ESP_OK) {
        err = bus_read_block(BTS_REG_CAL_RESULT, &result, 1);
    }

    xSemaphoreGive(s_bus_mutex);

    if (out_result != NULL) {
        *out_result = (err == ESP_OK) ? (uint32_t)result : 0u;
    }
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "cal opcode %u failed: %s", opcode, esp_err_to_name(err));
        return err;
    }

    /* Refresh the window on the next poll rather than waiting for the unit
     * to start reporting BTS_STATUS_CALIBRATING on some channel. */
    s_cal_poll_due = true;

    if ((uint32_t)result != BTS_CAL_ERR_OK) {
        ESP_LOGW(TAG, "cal opcode %u refused: %s", opcode,
                 bts_link_cal_result_name((uint32_t)result));
    }
    return ESP_OK;
}

esp_err_t bts_link_cal_enter(uint8_t slot, uint32_t *out_result)
{
    if (slot >= BTS_NUM_CHANNELS) {
        return ESP_ERR_INVALID_ARG;
    }
    /* eCalSlot is a separate register from the argument, so it is set before
     * the opcode rather than carried in it. */
    esp_err_t err = bts_link_write_reg(BTS_REG_CAL_SLOT, (float)slot);
    if (err != ESP_OK) {
        return err;
    }
    return cal_command(BTS_CAL_CMD_ENTER, 0.0f, out_result);
}

esp_err_t bts_link_cal_exit(uint32_t *out_result)
{
    return cal_command(BTS_CAL_CMD_EXIT, 0.0f, out_result);
}

esp_err_t bts_link_cal_clear(uint32_t *out_result)
{
    return cal_command(BTS_CAL_CMD_CLEAR, 0.0f, out_result);
}

esp_err_t bts_link_cal_capture_voltage(float measured_v, uint32_t *out_result)
{
    return cal_command(BTS_CAL_CMD_CAPTURE_VOLTAGE, measured_v, out_result);
}

esp_err_t bts_link_cal_zero_current(uint32_t *out_result)
{
    return cal_command(BTS_CAL_CMD_ZERO_CURRENT, 0.0f, out_result);
}

esp_err_t bts_link_cal_set_fixed_current(float pu, uint32_t *out_result)
{
    /*
     * The unit clamps this too, but rejecting here keeps an out-of-range
     * request off the wire entirely - this one puts real current through a
     * cell holder.
     */
    if (!(pu >= 0.0f) || pu > 0.8f) {
        return ESP_ERR_INVALID_ARG;
    }
    return cal_command(BTS_CAL_CMD_SET_FIXED_CURRENT, pu, out_result);
}

esp_err_t bts_link_cal_capture_current(float measured_a, uint32_t *out_result)
{
    /* The firmware applies the discharge sign itself; a signed value here
     * would invert the slot's stored gain. */
    return cal_command(BTS_CAL_CMD_CAPTURE_CURRENT, fabsf(measured_a), out_result);
}

esp_err_t bts_link_cal_compute_save(uint32_t *out_result)
{
    return cal_command(BTS_CAL_CMD_COMPUTE_SAVE, 0.0f, out_result);
}

const char *bts_link_cal_result_name(uint32_t result)
{
    switch (result) {
    case BTS_CAL_ERR_OK:               return "ok";
    case BTS_CAL_ERR_BUSY:             return "another slot is calibrating";
    case BTS_CAL_ERR_TESTING:          return "slot is running a test";
    case BTS_CAL_ERR_SLOT_UNAVAILABLE: return "slot disabled or not a group leader";
    case BTS_CAL_ERR_PU_RANGE:         return "pu outside the required window";
    case BTS_CAL_ERR_INSUFFICIENT:     return "insufficient captures";
    case BTS_CAL_ERR_VALIDATE:         return "computed gain failed validation";
    case BTS_CAL_ERR_FRAM:             return "F-RAM write failed";
    case BTS_CAL_ERR_ARG:              return "argument out of range";
    case BTS_CAL_ERR_NOT_ACTIVE:       return "not in the calibration state";
    default:                           return "unknown";
    }
}

/* ------------------------------------------------------------------ */
/* Poll task                                                          */
/* ------------------------------------------------------------------ */

/*
 * One channel, one transaction.
 *
 * The whole runtime block is 12 consecutive RO registers in map v2, which is
 * the entire point of the reorder: the target auto-increments on read, so
 * status, both measurement paths, the temperature and all six counters
 * arrive in a single burst.
 */
static void poll_one_channel(uint8_t ch, bts_channel_state_t *st, uint32_t trip_bits)
{
    float rt[BTS_RT_REG_COUNT];

    if (bus_read_block(BTS_RT_ADDR(ch, 0), rt, BTS_RT_REG_COUNT) != ESP_OK) {
        st->valid = false;
        return;
    }

    const uint32_t status = (uint32_t)rt[BTS_RT_STATUS / BTS_REGISTER_SIZE];

    st->status_bits       = status;
    st->cell_voltage_v    = rt[BTS_RT_CELL_VOLTAGE      / BTS_REGISTER_SIZE];
    st->cell_current_a    = rt[BTS_RT_CELL_CURRENT      / BTS_REGISTER_SIZE];
    st->sense_voltage_v   = rt[BTS_RT_SENSE_VOLTAGE     / BTS_REGISTER_SIZE];
    st->sense_current_a   = rt[BTS_RT_SENSE_CURRENT     / BTS_REGISTER_SIZE];
    st->cell_temp_c       = rt[BTS_RT_CELL_TEMP         / BTS_REGISTER_SIZE];
    st->charge_mah        = rt[BTS_RT_CHARGE_MAH        / BTS_REGISTER_SIZE];
    st->charge_mwh        = rt[BTS_RT_CHARGE_MWH        / BTS_REGISTER_SIZE];
    st->charge_seconds    = rt[BTS_RT_CHARGE_SECONDS    / BTS_REGISTER_SIZE];
    st->discharge_mah     = rt[BTS_RT_DISCHARGE_MAH     / BTS_REGISTER_SIZE];
    st->discharge_mwh     = rt[BTS_RT_DISCHARGE_MWH     / BTS_REGISTER_SIZE];
    st->discharge_seconds = rt[BTS_RT_DISCHARGE_SECONDS / BTS_REGISTER_SIZE];

    st->paused     = (status & BTS_STATUS_PAUSED) != 0;
    st->wd_tripped = (status & BTS_STATUS_WD_TRIPPED) != 0;
    st->restored   = (status & BTS_STATUS_RESTORED) != 0;
    st->ended      = (status & BTS_STATUS_ENDED_MASK) != 0;
    st->cmpss_trip = (trip_bits & BTS_TRIP_CMPSS(ch)) != 0;
    st->gpio_trip  = (trip_bits & BTS_TRIP_GPIO(ch)) != 0;
    st->valid      = true;
}

/*
 * Refreshes the calibration window, registers 1200-1256, as one burst.
 *
 * Called only when calibration is live or a command has just been issued:
 * this feature is idle almost all of the time and there is no reason to
 * lengthen the normal cycle for it.
 */
static void poll_cal_window(bts_cal_state_t *cal, const bts_channel_state_t *chans)
{
    float w[BTS_CAL_WINDOW_COUNT];

    if (bus_read_block(BTS_REG_CAL_SLOT, w, BTS_CAL_WINDOW_COUNT) != ESP_OK) {
        cal->active = false;
        return;
    }

    const uint32_t slot = (uint32_t)w[0];

    /*
     * Indices are offsets from BTS_REG_CAL_SLOT (1200), four bytes apart:
     *   0 eCalSlot      1 eCalCommand   2 eCalArgument  3 eCalStatus
     *   4 eCalResult    5 eWatchdogRemaining_s          6.. telemetry
     *
     * Index 5 is the watchdog countdown, NOT ads_v_pu. It used to be read as
     * ads_v_pu because this mirror was missing eWatchdogRemaining_s, which
     * shifted all nine telemetry floats one register low - a plausible but
     * wrong pu that would land a capture in the wrong window.
     */
    cal->slot        = (slot < BTS_NUM_CHANNELS) ? (uint8_t)slot : BTS_CAL_SLOT_NONE;
    /* w[1] is eCalCommand, which self-clears and carries nothing for a host. */
    cal->status_bits = (uint32_t)w[3];
    cal->result      = (uint32_t)w[4];
    cal->ads_v_pu    = w[6];
    cal->ads_i_pu    = w[7];
    cal->ads_v_v     = w[8];
    cal->ads_i_a     = w[9];
    cal->f28_v_pu    = w[10];
    cal->f28_i_pu    = w[11];
    cal->f28_v_v     = w[12];
    cal->f28_i_a     = w[13];
    cal->temp_c      = w[14];
    cal->active      = (cal->status_bits & BTS_CAL_ST_ACTIVE) != 0;

    /* Ticks come from the slot's own status word, which reflects what is
     * persisted rather than what this session captured. */
    if (cal->slot < BTS_NUM_CHANNELS) {
        const uint32_t st = chans[cal->slot].status_bits;
        cal->v_tick = (st & BTS_STATUS_CAL_V_VALID) != 0;
        cal->i_tick = (st & BTS_STATUS_CAL_I_VALID) != 0;
    } else {
        cal->v_tick = false;
        cal->i_tick = false;
    }
}

static void bts_poll_task(void *arg)
{
    (void)arg;
    bts_snapshot_t local;
    memset(&local, 0, sizeof(local));
    /* Zero is slot 0, so the "none" sentinel has to be set explicitly. */
    local.cal.slot = BTS_CAL_SLOT_NONE;

    /*
     * This cycle is what feeds the unit's 30 s host watchdog, and it issues
     * nothing but reads - 9 transactions, one per slot plus the unit block.
     * So the BTS's reload hook must cover the I2C READ path, not only
     * applyHostRegisterWrite(): a unit that reloads on writes alone would
     * pause every running slot 30 s after the last mode command, however
     * healthily this task is polling.
     */
    for (;;) {
        bool cycle_ok = true;

        if (xSemaphoreTake(s_bus_mutex, pdMS_TO_TICKS(1000)) == pdTRUE) {
            /*
             * Unit block first: eCalibrationMode .. eHostWatchdog_s are
             * eight consecutive registers, so one burst covers all of them
             * and the trip bitfield is then available for the per-channel
             * decode.
             */
            float unit[BTS_UNIT_WINDOW_COUNT];
            esp_err_t unit_err = bus_read_block(BTS_UNIT_WINDOW_FIRST, unit,
                                                BTS_UNIT_WINDOW_COUNT);
            if (unit_err != ESP_OK) {
                static uint32_t err_log;
                if ((err_log++ % 40u) == 0u) {
                    ESP_LOGW(TAG, "unit read err=%d (%s)",
                             unit_err, esp_err_to_name(unit_err));
                }
            }
            if (unit_err == ESP_OK) {
                local.unit.unit_state         = (bts_unit_state_t)(uint32_t)unit[1];
                local.unit.input_voltage_v    = unit[2];
                local.unit.trip_status        = (uint32_t)unit[3];
                /* unit[4..6] are the strap-latched slot mode/enable/group
                 * size, which CPU1 fixes at boot and nothing here consumes. */
                local.unit.watchdog_timeout_s = unit[7];
            } else {
                cycle_ok = false;
                /* Periodic bus scan while the link is down: tells a wiring
                 * or address fault apart from a target that answers but
                 * will not talk. */
                static uint32_t scan_div;
                if ((scan_div++ % 40u) == 0u) {
                    int found = 0;
                    for (uint8_t a = 0x08; a < 0x78; a++) {
                        if (i2c_master_probe(s_bus, a, 20) == ESP_OK) {
                            ESP_LOGW(TAG, "scan: found 0x%02X", a);
                            found++;
                        }
                    }
                    ESP_LOGW(TAG, "scan: %d device(s)", found);
                    /* Read the pads back as plain inputs. An idle I2C bus
                     * must read 1/1: anything else is a short, a missing
                     * pull-up, or a peer holding the line. */
                    {
                        gpio_num_t sda = (gpio_num_t)s_sda_gpio;
                        gpio_num_t scl = (gpio_num_t)s_scl_gpio;
                        ESP_LOGW(TAG, "bus level: SDA(%d)=%d SCL(%d)=%d",
                                 s_sda_gpio, gpio_get_level(sda),
                                 s_scl_gpio, gpio_get_level(scl));
                    }
                }
            }

            for (uint8_t ch = 0; ch < BTS_NUM_CHANNELS; ch++) {
                poll_one_channel(ch, &local.channel[ch], local.unit.trip_status);
                if (!local.channel[ch].valid) {
                    cycle_ok = false;
                }
            }

            /*
             * The calibration burst is conditional: a slot reporting
             * BTS_STATUS_CALIBRATING, the window already active, or a
             * command just issued. Reading it unconditionally would add a
             * tenth transaction to every 250 ms cycle for a feature used at
             * the bench a few times in a unit's life.
             */
            bool cal_wanted = local.cal.active || s_cal_poll_due;
            for (uint8_t ch = 0; ch < BTS_NUM_CHANNELS && !cal_wanted; ch++) {
                cal_wanted = (local.channel[ch].status_bits &
                              BTS_STATUS_CALIBRATING) != 0;
            }
            if (cal_wanted) {
                s_cal_poll_due = false;
                poll_cal_window(&local.cal, local.channel);
            }

            xSemaphoreGive(s_bus_mutex);
        } else {
            cycle_ok = false;
        }

        local.unit.online = cycle_ok;
        local.unit.last_poll_us = esp_timer_get_time();
        if (cycle_ok) {
            if (local.unit.consecutive_errors != 0) {
                ESP_LOGI(TAG, "BTS link up");
            }
            /* Periodic proof of life with real register content, so a
             * working link is visible rather than merely inferred from
             * the absence of errors. */
            static uint32_t ok_div;
            if ((ok_div++ % 20u) == 0u) {
                ESP_LOGI(TAG,
                    "BTS ok: state=%d Vin=%.2f ch0 V=%.3f I=%.3f T=%.1f",
                    (int)local.unit.unit_state, local.unit.input_voltage_v,
                    local.channel[0].cell_voltage_v,
                    local.channel[0].cell_current_a,
                    local.channel[0].cell_temp_c);
            }
            local.unit.consecutive_errors = 0;
        } else {
            local.unit.consecutive_errors++;
            if (local.unit.consecutive_errors == 1 ||
                local.unit.consecutive_errors % 40 == 0) {
                ESP_LOGW(TAG, "BTS poll failing (%u consecutive)",
                         (unsigned)local.unit.consecutive_errors);
            }
        }

        if (xSemaphoreTake(s_snap_mutex, pdMS_TO_TICKS(100)) == pdTRUE) {
            memcpy(&s_snapshot, &local, sizeof(s_snapshot));
            xSemaphoreGive(s_snap_mutex);
        }

        vTaskDelay(pdMS_TO_TICKS(s_poll_interval_ms));
    }
}

void bts_link_get_snapshot(bts_snapshot_t *out)
{
    if (out == NULL) {
        return;
    }
    if (xSemaphoreTake(s_snap_mutex, pdMS_TO_TICKS(100)) == pdTRUE) {
        memcpy(out, &s_snapshot, sizeof(*out));
        xSemaphoreGive(s_snap_mutex);
    } else {
        memset(out, 0, sizeof(*out));
    }
}

bool bts_link_stats_are_live(void)
{
    return s_stats_live;
}

/* ------------------------------------------------------------------ */
/* Init                                                               */
/* ------------------------------------------------------------------ */

/*
 * Probes whether the BTS is populating its own accumulators.
 *
 * One runtime-block read per channel covers both directions' totals. A
 * firmware that integrates leaves a non-zero total behind on any slot that
 * has run since power-up, so this is a positive test only: a unit that is
 * genuinely idle from cold reads all-zero and is indistinguishable from the
 * older firmware that never wrote these registers at all. The result only
 * gates whether the BTS figures are reported beside the local ones, so
 * failing closed costs nothing.
 */
static void probe_stats_liveness(void)
{
    s_stats_live = false;
    for (uint8_t ch = 0; ch < BTS_NUM_CHANNELS; ch++) {
        float rt[BTS_RT_REG_COUNT];

        if (bts_link_read_block(BTS_RT_ADDR(ch, 0), rt, BTS_RT_REG_COUNT) != ESP_OK) {
            continue;
        }
        for (int i = BTS_RT_CHARGE_MAH / BTS_REGISTER_SIZE;
             i < BTS_RT_REG_COUNT; i++) {
            if (rt[i] != 0.0f) {
                s_stats_live = true;
                return;
            }
        }
    }
    ESP_LOGI(TAG,
             "BTS accumulators all zero - either no slot has run since power-up "
             "or this is a build that never populated them; using on-ESP32 "
             "coulomb counting either way");
}

esp_err_t bts_link_init(const bts_link_config_t *config)
{
    if (config == NULL) {
        return ESP_ERR_INVALID_ARG;
    }

    s_bus_mutex  = xSemaphoreCreateMutex();
    s_snap_mutex = xSemaphoreCreateMutex();
    if (s_bus_mutex == NULL || s_snap_mutex == NULL) {
        return ESP_ERR_NO_MEM;
    }

    s_poll_interval_ms = config->poll_interval_ms ? config->poll_interval_ms : 250;
    s_sda_gpio = config->sda_gpio;
    s_scl_gpio = config->scl_gpio;

    /*
     * Bring the bus up by trying the plausible combinations rather than
     * assuming one.
     *
     * Two things are uncertain on a new harness: which way round SDA and SCL
     * are wired, and whether the pull-ups are stiff enough for the bit rate.
     * The board pulls up with 10k, which is weak for 100 kHz over a ribbon -
     * the rise time may not make it inside a bit period even though the idle
     * level reads high. Rather than guess, probe at a low rate first and in
     * both pin orders, and keep whichever combination actually answers.
     */
    struct {
        int sda;
        int scl;
        uint32_t hz;
    } attempts[] = {
        { config->sda_gpio, config->scl_gpio, 50000 },
        { config->sda_gpio, config->scl_gpio, 10000 },
        { config->scl_gpio, config->sda_gpio, 50000 },
        { config->scl_gpio, config->sda_gpio, 10000 },
        { config->sda_gpio, config->scl_gpio,
          config->scl_speed_hz ? config->scl_speed_hz : 100000 },
    };

    bool linked = false;
    for (size_t i = 0; i < sizeof(attempts) / sizeof(attempts[0]); i++) {
        i2c_master_bus_config_t try_cfg = {
            .i2c_port = -1,
            .sda_io_num = attempts[i].sda,
            .scl_io_num = attempts[i].scl,
            .clk_source = I2C_CLK_SRC_DEFAULT,
            .glitch_ignore_cnt = 7,
            .flags.enable_internal_pullup = true,
        };
        if (i2c_new_master_bus(&try_cfg, &s_bus) != ESP_OK) {
            continue;
        }

        if (i2c_master_probe(s_bus, BTS_I2C_ADDRESS, 200) == ESP_OK) {
            ESP_LOGW(TAG, "link up: SDA=%d SCL=%d @ %u Hz",
                     attempts[i].sda, attempts[i].scl,
                     (unsigned)attempts[i].hz);
            s_sda_gpio = attempts[i].sda;
            s_scl_gpio = attempts[i].scl;
            linked = true;
            break;
        }

        ESP_LOGW(TAG, "no answer: SDA=%d SCL=%d @ %u Hz",
                 attempts[i].sda, attempts[i].scl, (unsigned)attempts[i].hz);
        i2c_del_master_bus(s_bus);
        s_bus = NULL;
    }

    if (!linked) {
        /* Fall back to the configured pins so the poll task can keep
         * retrying - the unit may simply be powered down. */
        i2c_master_bus_config_t bus_cfg = {
            .i2c_port = -1,
            .sda_io_num = config->sda_gpio,
            .scl_io_num = config->scl_gpio,
            .clk_source = I2C_CLK_SRC_DEFAULT,
            .glitch_ignore_cnt = 7,
            .flags.enable_internal_pullup = true,
        };
        ESP_RETURN_ON_ERROR(i2c_new_master_bus(&bus_cfg, &s_bus), TAG, "i2c bus");
    }

    i2c_device_config_t dev_cfg = {
        .dev_addr_length = I2C_ADDR_BIT_LEN_7,
        .device_address = BTS_I2C_ADDRESS,
        /*
         * 50 kHz, deliberately overriding config->scl_speed_hz (main.c asks
         * for 100 kHz, which reaches only the bring-up probe list). The C2000
         * target ISR does a fair amount of work per byte, the bus runs over a
         * ribbon to the BTS board, and the board's 10k pull-ups are weak, so
         * rise time - not bandwidth - is the binding constraint. Nothing here
         * needs the throughput.
         */
        .scl_speed_hz = 50000,
    };
    ESP_RETURN_ON_ERROR(i2c_master_bus_add_device(s_bus, &dev_cfg, &s_dev), TAG, "i2c dev");

    /* Scan the whole bus once at start-up so a wiring or address fault is
     * distinguishable from a target that is present but not answering. */
    {
        int found = 0;
        for (uint8_t a = 0x08; a < 0x78; a++) {
            if (i2c_master_probe(s_bus, a, 50) == ESP_OK) {
                ESP_LOGW(TAG, "i2c scan: device at 0x%02X", a);
                found++;
            }
        }
        ESP_LOGW(TAG, "i2c scan complete: %d device(s) on SDA=%d SCL=%d",
                 found, config->sda_gpio, config->scl_gpio);
    }

    esp_err_t probe = i2c_master_probe(s_bus, BTS_I2C_ADDRESS, 200);
    if (probe == ESP_OK) {
        ESP_LOGI(TAG, "BTS found at 0x%02X on SDA=%d SCL=%d",
                 BTS_I2C_ADDRESS, config->sda_gpio, config->scl_gpio);
    } else {
        /*
         * Not fatal. The proxy runs on a backup battery and is expected to
         * stay up across a BTS power cycle; the poll task will pick the unit
         * up when it returns.
         */
        ESP_LOGW(TAG, "BTS not responding at 0x%02X (%s); continuing offline",
                 BTS_I2C_ADDRESS, esp_err_to_name(probe));
    }

    if (probe == ESP_OK) {
        probe_stats_liveness();
    }

    BaseType_t ok = xTaskCreate(bts_poll_task, "bts_poll", BTS_POLL_TASK_STACK,
                                NULL, BTS_POLL_TASK_PRIO, NULL);
    return (ok == pdPASS) ? ESP_OK : ESP_ERR_NO_MEM;
}

/* ------------------------------------------------------------------ */
/* Bus diagnostics                                                    */
/* ------------------------------------------------------------------ */

int bts_link_bus_diagnose(bts_bus_diag_t *diag, uint8_t *found, int max_found)
{
    if (diag == NULL) {
        return 0;
    }
    memset(diag, 0, sizeof(*diag));

    /*
     * Read the two lines as plain inputs. Both should idle high through the
     * pull-ups; either one low is a wiring fault and no transfer can work.
     *
     * The I2C peripheral keeps driving the pads while this runs, so the
     * matrix is pointed at a GPIO input only long enough to sample. That is
     * safe here because the caller holds the bus mutex, so the poll task is
     * not mid-transaction.
     */
    if (xSemaphoreTake(s_bus_mutex, pdMS_TO_TICKS(1000)) != pdTRUE) {
        return 0;
    }

    gpio_config_t in_cfg = {
        .pin_bit_mask = BIT64(s_sda_gpio) | BIT64(s_scl_gpio),
        .mode = GPIO_MODE_INPUT,
        .pull_up_en = GPIO_PULLUP_ENABLE,
        .pull_down_en = GPIO_PULLDOWN_DISABLE,
        .intr_type = GPIO_INTR_DISABLE,
    };
    if (gpio_config(&in_cfg) == ESP_OK) {
        /* Let the pull-ups settle before sampling. */
        vTaskDelay(pdMS_TO_TICKS(5));
        diag->sda_high = gpio_get_level(s_sda_gpio) != 0;
        diag->scl_high = gpio_get_level(s_scl_gpio) != 0;
    }

    xSemaphoreGive(s_bus_mutex);

    /*
     * Only scan when both lines idle high - probing a stuck bus just
     * produces 128 timeouts and takes half a minute doing it.
     */
    if (!diag->sda_high || !diag->scl_high) {
        ESP_LOGE(TAG, "I2C lines stuck: SDA=%s SCL=%s",
                 diag->sda_high ? "high" : "LOW",
                 diag->scl_high ? "high" : "LOW");
        return 0;
    }

    int n = 0;
    for (uint8_t addr = 0x08; addr < 0x78; addr++) {
        if (i2c_master_probe(s_bus, addr, 50) == ESP_OK) {
            ESP_LOGI(TAG, "I2C target found at 0x%02X", addr);
            if (found != NULL && n < max_found) {
                found[n] = addr;
            }
            n++;
        }
    }
    diag->target_count = n;
    if (n == 0) {
        ESP_LOGW(TAG, "I2C lines idle high but no target answered "
                      "(check address, power, or SDA/SCL swapped)");
    }
    return n;
}
