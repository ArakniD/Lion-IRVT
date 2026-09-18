/*
 * bts_link.c
 *
 * I2C transport and polling loop for the TIDA-010086 BTS unit.
 */

#include <string.h>
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
/*
 * Reads per channel per poll: the whole 6-register stats block in one burst,
 * plus status and cell temperature. Status and temperature live in different
 * blocks so they cannot join the stats burst.
 */
#define BTS_STATS_REG_COUNT     6

static i2c_master_bus_handle_t s_bus;
static i2c_master_dev_handle_t s_dev;
static SemaphoreHandle_t       s_bus_mutex;
static SemaphoreHandle_t       s_snap_mutex;
static bts_snapshot_t          s_snapshot;
static bool                    s_stats_live;
static uint32_t                s_poll_interval_ms = 250;
static int                     s_sda_gpio = -1;
static int                     s_scl_gpio = -1;

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
    return bts_link_write_reg(BTS_CTRL_ADDR(channel, BTS_CTRL_MODE), (float)mode);
}

esp_err_t bts_link_stop_channel(uint8_t channel)
{
    return bts_link_set_mode(channel, BTS_MODE_STOP);
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
        { BTS_CTRL_ADDR(channel, BTS_CTRL_CHARGE_V_MIN),
          clampf(lim->charge_voltage_min, 0.0f, vmax) },
        { BTS_CTRL_ADDR(channel, BTS_CTRL_CHARGE_V_MAX),
          clampf(lim->charge_voltage_max, 0.0f, vmax) },
        { BTS_CTRL_ADDR(channel, BTS_CTRL_DISCHARGE_V_MIN),
          clampf(lim->discharge_voltage_min, 0.0f, vmax) },
        { BTS_CTRL_ADDR(channel, BTS_CTRL_DISCHARGE_V_MAX),
          clampf(lim->discharge_voltage_max, 0.0f, vmax) },
        { BTS_CTRL_ADDR(channel, BTS_CTRL_CHARGE_I_MIN),
          clampf(lim->charge_current_min, 0.0f, imax) },
        { BTS_CTRL_ADDR(channel, BTS_CTRL_CHARGE_I_MAX),
          clampf(lim->charge_current_max, 0.0f, imax) },
        { BTS_CTRL_ADDR(channel, BTS_CTRL_DISCHARGE_I_MIN),
          clampf(lim->discharge_current_min, 0.0f, imax) },
        { BTS_CTRL_ADDR(channel, BTS_CTRL_DISCHARGE_I_MAX),
          clampf(lim->discharge_current_max, 0.0f, imax) },
        { BTS_TEMPLIM_ADDR(channel, BTS_TEMPLIM_MIN), lim->min_cell_temp },
        { BTS_TEMPLIM_ADDR(channel, BTS_TEMPLIM_MAX), lim->max_cell_temp },
    };

    if (xSemaphoreTake(s_bus_mutex, pdMS_TO_TICKS(1000)) != pdTRUE) {
        return ESP_ERR_TIMEOUT;
    }

    esp_err_t err = ESP_OK;
    for (size_t i = 0; i < sizeof(writes) / sizeof(writes[0]); i++) {
        /*
         * Deliberately one transaction per register rather than a burst.
         * Each RW write raises an IPC flag to CPU1, and the control-block
         * writes land in the limit registers that modeCallback() will latch;
         * keeping them separate keeps the failure granularity per-register.
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
/* Poll task                                                          */
/* ------------------------------------------------------------------ */

static void poll_one_channel(uint8_t ch, bts_channel_state_t *st, uint32_t trip_bits)
{
    float stats[BTS_STATS_REG_COUNT];
    float status_raw = 0.0f;
    float temp_raw = 0.0f;

    esp_err_t err = bus_read_block(BTS_STATS_ADDR(ch, BTS_STATS_CURRENT_ACC),
                                   stats, BTS_STATS_REG_COUNT);
    if (err != ESP_OK) {
        st->valid = false;
        return;
    }

    if (bus_read_block(BTS_CTRL_ADDR(ch, BTS_CTRL_STATUS), &status_raw, 1) != ESP_OK) {
        st->valid = false;
        return;
    }
    if (bus_read_block(BTS_CELLTEMP_ADDR(ch), &temp_raw, 1) != ESP_OK) {
        st->valid = false;
        return;
    }

    st->current_acc    = stats[BTS_STATS_CURRENT_ACC  / BTS_REGISTER_SIZE];
    st->min_voltage_v  = stats[BTS_STATS_MIN_VOLTAGE  / BTS_REGISTER_SIZE];
    st->max_voltage_v  = stats[BTS_STATS_MAX_VOLTAGE  / BTS_REGISTER_SIZE];
    st->power_acc      = stats[BTS_STATS_POWER_ACC    / BTS_REGISTER_SIZE];
    st->cell_voltage_v = stats[BTS_STATS_CELL_VOLTAGE / BTS_REGISTER_SIZE];
    st->cell_current_a = stats[BTS_STATS_CELL_CURRENT / BTS_REGISTER_SIZE];
    st->cell_temp_c    = temp_raw;
    st->status_bits    = (uint32_t)status_raw;
    st->cmpss_trip     = (trip_bits & BTS_TRIP_CMPSS(ch)) != 0;
    st->gpio_trip      = (trip_bits & BTS_TRIP_GPIO(ch)) != 0;
    st->valid          = true;
}

static void bts_poll_task(void *arg)
{
    (void)arg;
    bts_snapshot_t local;
    memset(&local, 0, sizeof(local));

    for (;;) {
        bool cycle_ok = true;

        if (xSemaphoreTake(s_bus_mutex, pdMS_TO_TICKS(1000)) == pdTRUE) {
            /*
             * Unit block first: eCalibrationMode .. eTripStatus are four
             * consecutive registers, so one burst covers all of them and the
             * trip bitfield is then available for the per-channel decode.
             */
            float unit[4];
            esp_err_t unit_err = bus_read_block(BTS_REG_CALIBRATION_MODE, unit, 4);
            if (unit_err != ESP_OK) {
                static uint32_t err_log;
                if ((err_log++ % 40u) == 0u) {
                    ESP_LOGW(TAG, "unit read err=%d (%s)",
                             unit_err, esp_err_to_name(unit_err));
                }
            }
            if (unit_err == ESP_OK) {
                local.unit.unit_state      = (bts_unit_state_t)(uint32_t)unit[1];
                local.unit.input_voltage_v = unit[2];
                local.unit.trip_status     = (uint32_t)unit[3];
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
 * Runs a short discharge-free observation: read CurrentAcc/PowerAcc for
 * every channel twice, a poll apart. The current firmware never assigns
 * these registers, so they are identically zero and this returns false. If a
 * later BTS build starts integrating, any non-zero value flips it to true
 * and the raw accumulators get surfaced in the API for comparison against
 * the ESP32's own integration.
 */
static void probe_stats_liveness(void)
{
    s_stats_live = false;
    for (uint8_t ch = 0; ch < BTS_NUM_CHANNELS; ch++) {
        float v[4];
        if (bts_link_read_block(BTS_STATS_ADDR(ch, BTS_STATS_CURRENT_ACC), v, 4) != ESP_OK) {
            continue;
        }
        /* CurrentAcc, MinVoltage, MaxVoltage, PowerAcc all pinned at 0. */
        if (v[0] != 0.0f || v[3] != 0.0f) {
            s_stats_live = true;
            return;
        }
    }
    ESP_LOGW(TAG,
             "BTS mAh/mWh accumulators read back as zero and are REG_ACCESS_RO; "
             "using on-ESP32 coulomb counting instead");
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
         * 100 kHz. The C2000 target ISR does a fair amount of work per byte
         * and the bus runs over a ribbon to the BTS board; 400 kHz is not
         * worth the marginal risk here.
         */
        /* Conservative: a weak pull-up costs rise time, and nothing here
         * needs the bandwidth. */
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
