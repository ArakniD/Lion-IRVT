/*
 * ble_svc.c
 *
 * NimBLE GATT server. See ble_svc.h for the service layout and ble_proto.h
 * for the wire records.
 */

#include <string.h>
#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_log.h"
#include "nimble/nimble_port.h"
#include "nimble/nimble_port_freertos.h"
#include "host/ble_hs.h"
#include "host/ble_uuid.h"
#include "host/util/util.h"
#include "services/gap/ble_svc_gap.h"
#include "services/gatt/ble_svc_gatt.h"

#include "ble_svc.h"
#include "ble_proto.h"
#include "test_engine.h"
#include "cell_profiles.h"
#include "bts_link.h"
#include "display.h"

static const char *TAG = "ble_svc";

/* e5f1xxxx-9a4c-4b7d-8f2e-1c3a5b7d9f01, little-endian byte order. */
#define TESTER_UUID128(a, b)                                            \
    BLE_UUID128_INIT(0x01, 0x9f, 0x7d, 0x5b, 0x3a, 0x1c, 0x2e, 0x8f,    \
                     0x7d, 0x4b, 0x4c, 0x9a, (b), (a), 0xf1, 0xe5)

static const ble_uuid128_t s_uuid_svc          = TESTER_UUID128(0x00, 0x01);
static const ble_uuid128_t s_uuid_unit_status  = TESTER_UUID128(0x00, 0x02);
static const ble_uuid128_t s_uuid_command      = TESTER_UUID128(0x00, 0x03);
static const ble_uuid128_t s_uuid_slot_select  = TESTER_UUID128(0x00, 0x04);
static const ble_uuid128_t s_uuid_slot_config  = TESTER_UUID128(0x00, 0x05);
static const ble_uuid128_t s_uuid_slot_result  = TESTER_UUID128(0x00, 0x06);
static const ble_uuid128_t s_uuid_slot_serial  = TESTER_UUID128(0x00, 0x07);
static const ble_uuid128_t s_uuid_cat_index    = TESTER_UUID128(0x00, 0x08);
static const ble_uuid128_t s_uuid_cat_entry    = TESTER_UUID128(0x00, 0x09);
static const ble_uuid128_t s_uuid_slot_status  = TESTER_UUID128(0x00, 0x0a);
static const ble_uuid128_t s_uuid_cal_cmd      = TESTER_UUID128(0x00, 0x0b);
static const ble_uuid128_t s_uuid_cal_status   = TESTER_UUID128(0x00, 0x0c);

static uint16_t s_unit_status_handle;
static uint16_t s_slot_status_handle;
static uint16_t s_cal_status_handle;
static uint16_t s_conn_handle = BLE_HS_CONN_HANDLE_NONE;
static uint8_t  s_own_addr_type;
static uint8_t  s_selected_slot;
static uint8_t  s_catalog_index;
static bool     s_wifi_connected;
static char     s_device_name[32] = "BTS-Tester";

static void ble_svc_advertise(void);

/* ------------------------------------------------------------------ */
/* Record builders                                                    */
/* ------------------------------------------------------------------ */

static void build_unit_status(ble_unit_status_t *out)
{
    bts_snapshot_t snap;
    bts_link_get_snapshot(&snap);

    memset(out, 0, sizeof(*out));
    out->version         = BLE_PROTO_VERSION;
    out->slot_count      = SLOT_COUNT;
    out->online          = snap.unit.online ? 1 : 0;
    out->unit_state      = (uint8_t)snap.unit.unit_state;
    out->trip_status     = snap.unit.trip_status;
    out->input_voltage_v = snap.unit.input_voltage_v;
    out->uptime_s        = (uint32_t)(esp_timer_get_time() / 1000000);
    out->stats_live      = bts_link_stats_are_live() ? 1 : 0;
    out->wifi_connected  = s_wifi_connected ? 1 : 0;
}

static void build_slot_status(uint8_t slot, const slot_status_t *st,
                              ble_slot_status_t *out)
{
    memset(out, 0, sizeof(*out));
    out->slot            = slot;
    out->state           = (uint8_t)st->state;
    out->fault           = (uint8_t)st->fault;
    out->configured      = st->configured ? 1 : 0;
    out->voltage_v       = st->voltage_v;
    out->current_a       = st->current_a;
    out->temp_c          = st->temp_c;
    out->live_mah        = (float)st->live_mah;
    out->live_mwh        = (float)st->live_mwh;
    out->progress        = st->progress;
    out->elapsed_s       = st->elapsed_s;
    out->state_elapsed_s = st->state_elapsed_s;
    out->status_bits     = st->status_bits;
}

static void build_slot_config(uint8_t slot, ble_slot_config_t *out)
{
    slot_status_t st;
    test_engine_get_status(slot, &st);

    memset(out, 0, sizeof(*out));
    out->slot                 = slot;
    out->chemistry            = (uint8_t)st.config.chemistry;
    out->auto_recharge        = st.config.auto_recharge_to_shipping ? 1 : 0;
    out->capacity_mah         = st.config.capacity_mah;
    out->charge_c             = st.config.charge_c;
    out->discharge_c          = st.config.discharge_c;
    out->shipping_pct         = st.config.shipping_pct;
    out->max_duration_minutes = st.config.max_duration_minutes;
    snprintf(out->model_name, sizeof(out->model_name), "%s", st.config.model_name);
    snprintf(out->serial, sizeof(out->serial), "%s", st.config.serial);
}

static void build_slot_result(uint8_t slot, ble_slot_result_t *out)
{
    slot_result_t r;

    memset(out, 0, sizeof(*out));
    out->slot = slot;
    if (test_engine_get_result(slot, &r) != ESP_OK || !r.valid) {
        return;
    }

    out->valid              = 1;
    out->chemistry          = (uint8_t)r.chemistry;
    out->recharged          = r.recharged ? 1 : 0;
    out->start_voltage_v    = r.start_voltage_v;
    out->end_voltage_v      = r.end_voltage_v;
    out->rested_voltage_v   = r.rested_voltage_v;
    out->discharge_mah      = r.discharge_mah;
    out->discharge_mwh      = r.discharge_mwh;
    out->max_temp_c         = r.max_temp_c;
    out->max_current_a      = r.max_current_a;
    out->min_voltage_v      = r.min_voltage_v;
    out->max_voltage_v      = r.max_voltage_v;
    out->recharge_mah       = r.recharge_mah;
    out->shipping_voltage_v = r.shipping_voltage_v;
    out->discharge_seconds  = r.discharge_seconds;
    out->completed_unix     = r.completed_unix;
    snprintf(out->model_name, sizeof(out->model_name), "%s", r.model_name);
    snprintf(out->serial, sizeof(out->serial), "%s", r.serial);
}

/*
 * The catalogue is presented as one flat index so a client can page it with
 * a single pair of characteristics: chemistries first, then models.
 */
static void build_catalog_entry(uint8_t index, ble_catalog_entry_t *out)
{
    const size_t chem_count  = CELL_CHEM_COUNT;
    const size_t model_count = cell_model_count();
    const size_t total       = chem_count + model_count;

    memset(out, 0, sizeof(*out));
    out->index = index;
    out->total = (uint8_t)total;
    if (index >= total) {
        return;
    }

    if (index < chem_count) {
        const cell_chemistry_profile_t *cp = cell_chemistry_get((cell_chemistry_t)index);
        if (cp == NULL) {
            return;
        }
        out->kind                    = BLE_CATALOG_KIND_CHEMISTRY;
        out->chemistry               = index;
        out->charge_v_max            = cp->charge_v_max;
        out->discharge_v_min         = cp->discharge_v_min;
        out->storage_v               = cp->storage_v;
        out->charge_c                = cp->default_charge_c;
        out->discharge_c             = cp->default_discharge_c;
        out->temp_min_c              = cp->temp_min_c;
        out->temp_max_c              = cp->temp_max_c;
        out->rest_minutes            = cp->rest_minutes;
        snprintf(out->name, sizeof(out->name), "%s", cp->name);
        return;
    }

    const cell_model_t *m = cell_model_at(index - chem_count);
    if (m == NULL) {
        return;
    }
    const cell_chemistry_profile_t *cp = cell_chemistry_get(m->chemistry);

    out->kind                    = BLE_CATALOG_KIND_MODEL;
    out->chemistry               = (uint8_t)m->chemistry;
    out->capacity_mah            = m->capacity_mah;
    out->charge_current_max_a    = m->charge_current_max_a;
    out->discharge_current_max_a = m->discharge_current_max_a;
    out->charge_v_max    = (m->charge_v_max    > 0.0f) ? m->charge_v_max
                                                       : (cp ? cp->charge_v_max : 0.0f);
    out->discharge_v_min = (m->discharge_v_min > 0.0f) ? m->discharge_v_min
                                                       : (cp ? cp->discharge_v_min : 0.0f);
    if (cp != NULL) {
        out->storage_v    = cp->storage_v;
        out->charge_c     = cp->default_charge_c;
        out->discharge_c  = cp->default_discharge_c;
        out->temp_min_c   = cp->temp_min_c;
        out->temp_max_c   = cp->temp_max_c;
        out->rest_minutes = cp->rest_minutes;
    }
    snprintf(out->name, sizeof(out->name), "%s", m->name);
    snprintf(out->manufacturer, sizeof(out->manufacturer), "%s", m->manufacturer);
}

static void build_cal_status(ble_cal_status_t *out)
{
    bts_snapshot_t snap;
    bts_link_get_snapshot(&snap);

    memset(out, 0, sizeof(*out));
    out->slot        = snap.cal.slot;
    out->active      = snap.cal.active ? 1 : 0;
    out->v_tick      = snap.cal.v_tick ? 1 : 0;
    out->i_tick      = snap.cal.i_tick ? 1 : 0;
    out->status_bits = snap.cal.status_bits;
    out->result      = snap.cal.result;
    out->ads_v_pu    = snap.cal.ads_v_pu;
    out->ads_i_pu    = snap.cal.ads_i_pu;
    out->ads_v_v     = snap.cal.ads_v_v;
    out->ads_i_a     = snap.cal.ads_i_a;
    out->f28_v_pu    = snap.cal.f28_v_pu;
    out->f28_i_pu    = snap.cal.f28_i_pu;
    out->f28_v_v     = snap.cal.f28_v_v;
    out->f28_i_a     = snap.cal.f28_i_a;
    out->temp_c      = snap.cal.temp_c;
}

/* ------------------------------------------------------------------ */
/* Write handlers                                                     */
/* ------------------------------------------------------------------ */
static int read_flat(struct os_mbuf *om, void *dst, uint16_t exact_len)
{
    uint16_t om_len = OS_MBUF_PKTLEN(om);
    uint16_t copied = 0;

    if (om_len != exact_len) {
        return BLE_ATT_ERR_INVALID_ATTR_VALUE_LEN;
    }
    if (ble_hs_mbuf_to_flat(om, dst, exact_len, &copied) != 0 || copied != exact_len) {
        return BLE_ATT_ERR_UNLIKELY;
    }
    return 0;
}

static int handle_command(struct os_mbuf *om)
{
    ble_cmd_t cmd;
    int rc = read_flat(om, &cmd, sizeof(cmd));
    if (rc != 0) {
        return rc;
    }

    esp_err_t err;
    switch (cmd.opcode) {
    case BLE_CMD_START:       err = test_engine_start(cmd.slot);       break;
    case BLE_CMD_ABORT:       err = test_engine_abort(cmd.slot);       break;
    case BLE_CMD_CLEAR_FAULT: err = test_engine_clear_fault(cmd.slot); break;
    case BLE_CMD_ABORT_ALL:   err = test_engine_abort_all();           break;
    default:
        ESP_LOGW(TAG, "unknown command opcode %u", cmd.opcode);
        return BLE_ATT_ERR_REQ_NOT_SUPPORTED;
    }

    if (err != ESP_OK) {
        ESP_LOGW(TAG, "command %u on slot %u refused: %s",
                 cmd.opcode, cmd.slot, esp_err_to_name(err));
        /*
         * A refusal is a state error, not a protocol error. Report it as
         * "unlikely" so the client sees the failure; the reason is visible
         * in the slot's state and fault fields.
         */
        return BLE_ATT_ERR_UNLIKELY;
    }
    return 0;
}

/*
 * Calibration commands go straight to the unit; the ESP32 holds no
 * calibration state of its own. A refusal by the BTS is reported as a
 * generic ATT error - the specific code is in the status characteristic,
 * which a client reads anyway to watch the capture progress.
 */
static int handle_cal_cmd(struct os_mbuf *om)
{
    ble_cal_cmd_t cmd;
    int rc = read_flat(om, &cmd, sizeof(cmd));
    if (rc != 0) {
        return rc;
    }

    esp_err_t err;
    uint32_t  result = 0;
    switch (cmd.opcode) {
    case BTS_CAL_CMD_ENTER:
        if (cmd.slot >= SLOT_COUNT) {
            return BLE_ATT_ERR_INVALID_ATTR_VALUE_LEN;
        }
        err = bts_link_cal_enter(cmd.slot, &result);
        break;
    case BTS_CAL_CMD_EXIT:
        err = bts_link_cal_exit(&result);
        break;
    case BTS_CAL_CMD_CAPTURE_VOLTAGE:
        err = bts_link_cal_capture_voltage(cmd.arg, &result);
        break;
    case BTS_CAL_CMD_ZERO_CURRENT:
        err = bts_link_cal_zero_current(&result);
        break;
    case BTS_CAL_CMD_SET_FIXED_CURRENT:
        err = bts_link_cal_set_fixed_current(cmd.arg, &result);
        break;
    case BTS_CAL_CMD_CAPTURE_CURRENT:
        err = bts_link_cal_capture_current(cmd.arg, &result);
        break;
    case BTS_CAL_CMD_COMPUTE_SAVE:
        err = bts_link_cal_compute_save(&result);
        break;
    case BTS_CAL_CMD_CLEAR:
        err = bts_link_cal_clear(&result);
        break;
    default:
        ESP_LOGW(TAG, "unknown calibration opcode %u", cmd.opcode);
        return BLE_ATT_ERR_REQ_NOT_SUPPORTED;
    }

    if (err != ESP_OK || result != BTS_CAL_ERR_OK) {
        ESP_LOGW(TAG, "cal opcode %u refused: %s", cmd.opcode,
                 (err != ESP_OK) ? esp_err_to_name(err)
                                 : bts_link_cal_result_name(result));
        return BLE_ATT_ERR_UNLIKELY;
    }
    return 0;
}

static int handle_slot_config_write(struct os_mbuf *om)
{
    ble_slot_config_t w;
    int rc = read_flat(om, &w, sizeof(w));
    if (rc != 0) {
        return rc;
    }
    if (w.slot >= SLOT_COUNT || w.chemistry >= CELL_CHEM_COUNT) {
        return BLE_ATT_ERR_INVALID_ATTR_VALUE_LEN;
    }

    slot_config_t cfg;
    memset(&cfg, 0, sizeof(cfg));
    cfg.chemistry                 = (cell_chemistry_t)w.chemistry;
    cfg.capacity_mah              = w.capacity_mah;
    cfg.charge_c                  = w.charge_c;
    cfg.discharge_c               = w.discharge_c;
    cfg.auto_recharge_to_shipping = w.auto_recharge != 0;
    cfg.shipping_pct              = (w.shipping_pct > 0.0f) ? w.shipping_pct : 60.0f;
    cfg.max_duration_minutes      = w.max_duration_minutes;

    /* The client's strings are not guaranteed NUL-terminated. */
    memcpy(cfg.model_name, w.model_name, sizeof(cfg.model_name) - 1);
    memcpy(cfg.serial, w.serial, sizeof(cfg.serial) - 1);

    esp_err_t err = test_engine_configure(w.slot, &cfg);
    if (err != ESP_OK) {
        ESP_LOGW(TAG, "slot %u configure refused: %s", w.slot, esp_err_to_name(err));
        return BLE_ATT_ERR_UNLIKELY;
    }
    return 0;
}

static int handle_serial_write(struct os_mbuf *om)
{
    char     buf[SERIAL_MAX];
    uint16_t om_len = OS_MBUF_PKTLEN(om);
    uint16_t copied = 0;

    if (om_len == 0 || om_len >= sizeof(buf)) {
        return BLE_ATT_ERR_INVALID_ATTR_VALUE_LEN;
    }
    memset(buf, 0, sizeof(buf));
    if (ble_hs_mbuf_to_flat(om, buf, sizeof(buf) - 1, &copied) != 0) {
        return BLE_ATT_ERR_UNLIKELY;
    }
    buf[copied] = '\0';

    if (test_engine_set_serial(s_selected_slot, buf) != ESP_OK) {
        return BLE_ATT_ERR_UNLIKELY;
    }
    return 0;
}

/* ------------------------------------------------------------------ */
/* GATT access                                                        */
/* ------------------------------------------------------------------ */

static int gatt_access(uint16_t conn_handle, uint16_t attr_handle,
                       struct ble_gatt_access_ctxt *ctxt, void *arg)
{
    (void)conn_handle;
    (void)attr_handle;
    (void)arg;

    const ble_uuid_t *uuid = ctxt->chr->uuid;

    switch (ctxt->op) {
    case BLE_GATT_ACCESS_OP_READ_CHR:
        if (ble_uuid_cmp(uuid, &s_uuid_unit_status.u) == 0) {
            ble_unit_status_t rec;
            build_unit_status(&rec);
            return os_mbuf_append(ctxt->om, &rec, sizeof(rec)) == 0
                       ? 0 : BLE_ATT_ERR_INSUFFICIENT_RES;
        }
        if (ble_uuid_cmp(uuid, &s_uuid_slot_status.u) == 0) {
            slot_status_t st;
            ble_slot_status_t rec;
            test_engine_get_status(s_selected_slot, &st);
            build_slot_status(s_selected_slot, &st, &rec);
            return os_mbuf_append(ctxt->om, &rec, sizeof(rec)) == 0
                       ? 0 : BLE_ATT_ERR_INSUFFICIENT_RES;
        }
        if (ble_uuid_cmp(uuid, &s_uuid_slot_select.u) == 0) {
            return os_mbuf_append(ctxt->om, &s_selected_slot, 1) == 0
                       ? 0 : BLE_ATT_ERR_INSUFFICIENT_RES;
        }
        if (ble_uuid_cmp(uuid, &s_uuid_slot_config.u) == 0) {
            ble_slot_config_t rec;
            build_slot_config(s_selected_slot, &rec);
            return os_mbuf_append(ctxt->om, &rec, sizeof(rec)) == 0
                       ? 0 : BLE_ATT_ERR_INSUFFICIENT_RES;
        }
        if (ble_uuid_cmp(uuid, &s_uuid_slot_result.u) == 0) {
            ble_slot_result_t rec;
            build_slot_result(s_selected_slot, &rec);
            return os_mbuf_append(ctxt->om, &rec, sizeof(rec)) == 0
                       ? 0 : BLE_ATT_ERR_INSUFFICIENT_RES;
        }
        if (ble_uuid_cmp(uuid, &s_uuid_cat_index.u) == 0) {
            return os_mbuf_append(ctxt->om, &s_catalog_index, 1) == 0
                       ? 0 : BLE_ATT_ERR_INSUFFICIENT_RES;
        }
        if (ble_uuid_cmp(uuid, &s_uuid_cat_entry.u) == 0) {
            ble_catalog_entry_t rec;
            build_catalog_entry(s_catalog_index, &rec);
            return os_mbuf_append(ctxt->om, &rec, sizeof(rec)) == 0
                       ? 0 : BLE_ATT_ERR_INSUFFICIENT_RES;
        }
        if (ble_uuid_cmp(uuid, &s_uuid_cal_status.u) == 0) {
            ble_cal_status_t rec;
            build_cal_status(&rec);
            return os_mbuf_append(ctxt->om, &rec, sizeof(rec)) == 0
                       ? 0 : BLE_ATT_ERR_INSUFFICIENT_RES;
        }
        return BLE_ATT_ERR_UNLIKELY;

    case BLE_GATT_ACCESS_OP_WRITE_CHR:
        if (ble_uuid_cmp(uuid, &s_uuid_command.u) == 0) {
            return handle_command(ctxt->om);
        }
        if (ble_uuid_cmp(uuid, &s_uuid_cal_cmd.u) == 0) {
            return handle_cal_cmd(ctxt->om);
        }
        if (ble_uuid_cmp(uuid, &s_uuid_slot_config.u) == 0) {
            return handle_slot_config_write(ctxt->om);
        }
        if (ble_uuid_cmp(uuid, &s_uuid_slot_serial.u) == 0) {
            return handle_serial_write(ctxt->om);
        }
        if (ble_uuid_cmp(uuid, &s_uuid_slot_select.u) == 0) {
            uint8_t v;
            int rc = read_flat(ctxt->om, &v, 1);
            if (rc != 0) {
                return rc;
            }
            if (v >= SLOT_COUNT) {
                return BLE_ATT_ERR_INVALID_ATTR_VALUE_LEN;
            }
            s_selected_slot = v;
            return 0;
        }
        if (ble_uuid_cmp(uuid, &s_uuid_cat_index.u) == 0) {
            uint8_t v;
            int rc = read_flat(ctxt->om, &v, 1);
            if (rc != 0) {
                return rc;
            }
            s_catalog_index = v;
            return 0;
        }
        return BLE_ATT_ERR_UNLIKELY;

    default:
        return BLE_ATT_ERR_UNLIKELY;
    }
}

static const struct ble_gatt_svc_def s_gatt_svcs[] = {
    {
        .type = BLE_GATT_SVC_TYPE_PRIMARY,
        .uuid = &s_uuid_svc.u,
        .characteristics = (struct ble_gatt_chr_def[]) {
            {
                .uuid = &s_uuid_unit_status.u,
                .access_cb = gatt_access,
                .flags = BLE_GATT_CHR_F_READ | BLE_GATT_CHR_F_NOTIFY,
                .val_handle = &s_unit_status_handle,
            }, {
                .uuid = &s_uuid_command.u,
                .access_cb = gatt_access,
                .flags = BLE_GATT_CHR_F_WRITE,
            }, {
                .uuid = &s_uuid_slot_select.u,
                .access_cb = gatt_access,
                .flags = BLE_GATT_CHR_F_READ | BLE_GATT_CHR_F_WRITE,
            }, {
                .uuid = &s_uuid_slot_config.u,
                .access_cb = gatt_access,
                .flags = BLE_GATT_CHR_F_READ | BLE_GATT_CHR_F_WRITE,
            }, {
                .uuid = &s_uuid_slot_result.u,
                .access_cb = gatt_access,
                .flags = BLE_GATT_CHR_F_READ,
            }, {
                .uuid = &s_uuid_slot_serial.u,
                .access_cb = gatt_access,
                .flags = BLE_GATT_CHR_F_WRITE,
            }, {
                .uuid = &s_uuid_cat_index.u,
                .access_cb = gatt_access,
                .flags = BLE_GATT_CHR_F_READ | BLE_GATT_CHR_F_WRITE,
            }, {
                .uuid = &s_uuid_cat_entry.u,
                .access_cb = gatt_access,
                .flags = BLE_GATT_CHR_F_READ,
            }, {
                .uuid = &s_uuid_slot_status.u,
                .access_cb = gatt_access,
                .flags = BLE_GATT_CHR_F_READ | BLE_GATT_CHR_F_NOTIFY,
                .val_handle = &s_slot_status_handle,
            }, {
                /* Appended, never inserted: the discriminators are the
                 * client's contract and renumbering them breaks every
                 * existing decoder. */
                .uuid = &s_uuid_cal_cmd.u,
                .access_cb = gatt_access,
                .flags = BLE_GATT_CHR_F_WRITE,
            }, {
                .uuid = &s_uuid_cal_status.u,
                .access_cb = gatt_access,
                .flags = BLE_GATT_CHR_F_READ | BLE_GATT_CHR_F_NOTIFY,
                .val_handle = &s_cal_status_handle,
            }, {
                0,
            },
        },
    },
    {
        0,
    },
};

/* ------------------------------------------------------------------ */
/* Notifications                                                      */
/* ------------------------------------------------------------------ */

static void notify_slot(uint8_t slot, const slot_status_t *st)
{
    if (s_conn_handle == BLE_HS_CONN_HANDLE_NONE || s_slot_status_handle == 0) {
        return;
    }

    ble_slot_status_t rec;
    build_slot_status(slot, st, &rec);

    struct os_mbuf *om = ble_hs_mbuf_from_flat(&rec, sizeof(rec));
    if (om == NULL) {
        /* Out of mbufs - drop it. The client re-reads on its own cadence. */
        return;
    }
    /* ble_gatts_notify_custom() consumes the mbuf either way. */
    (void)ble_gatts_notify_custom(s_conn_handle, s_slot_status_handle, om);
}

/*
 * Called from the test engine's tick on every state change.
 *
 * Runs on the engine task with the engine lock already dropped, so a slow
 * host stack delays only the notification, not the control loop.
 */
static void on_slot_change(uint8_t slot, const slot_status_t *status)
{
    notify_slot(slot, status);
}

/*
 * While anything is running, push every slot once a second so a UI gets the
 * live mAh/mWh totals without polling over GATT. Idle slots produce nothing.
 *
 * Calibration is the exception: it notifies at 2 Hz while active, because an
 * operator adjusting a bench supply to land inside a pu window is watching
 * the number move and a 1 Hz update feels unresponsive. The tick is
 * therefore 500 ms and the slot/unit work runs on every second pass.
 */
static void notify_task(void *arg)
{
    (void)arg;
    bool slot_pass = false;

    for (;;) {
        vTaskDelay(pdMS_TO_TICKS(500));
        slot_pass = !slot_pass;

        if (s_conn_handle == BLE_HS_CONN_HANDLE_NONE) {
            continue;
        }

        if (s_cal_status_handle != 0) {
            ble_cal_status_t cal;
            build_cal_status(&cal);
            if (cal.active) {
                struct os_mbuf *om = ble_hs_mbuf_from_flat(&cal, sizeof(cal));
                if (om != NULL) {
                    (void)ble_gatts_notify_custom(s_conn_handle,
                                                  s_cal_status_handle, om);
                }
            }
        }

        if (!slot_pass) {
            continue;
        }

        for (uint8_t slot = 0; slot < SLOT_COUNT; slot++) {
            slot_status_t st;
            test_engine_get_status(slot, &st);
            switch (st.state) {
            case SLOT_STATE_IDLE:
            case SLOT_STATE_COMPLETE:
            case SLOT_STATE_FAULT:
            case SLOT_STATE_ABORTED:
                continue;
            default:
                break;
            }
            notify_slot(slot, &st);
        }

        if (s_unit_status_handle != 0) {
            ble_unit_status_t rec;
            build_unit_status(&rec);
            struct os_mbuf *om = ble_hs_mbuf_from_flat(&rec, sizeof(rec));
            if (om != NULL) {
                (void)ble_gatts_notify_custom(s_conn_handle, s_unit_status_handle, om);
            }
        }
    }
}

/* ------------------------------------------------------------------ */
/* GAP                                                                */
/* ------------------------------------------------------------------ */

static int gap_event(struct ble_gap_event *event, void *arg)
{
    (void)arg;

    switch (event->type) {
    case BLE_GAP_EVENT_CONNECT:
        if (event->connect.status == 0) {
            s_conn_handle = event->connect.conn_handle;
            display_set_ble_connected(true);
            ESP_LOGI(TAG, "client connected, handle %u", s_conn_handle);
        } else {
            ESP_LOGW(TAG, "connect failed, status %d", event->connect.status);
            ble_svc_advertise();
        }
        return 0;

    case BLE_GAP_EVENT_DISCONNECT:
        ESP_LOGI(TAG, "client disconnected, reason %d", event->disconnect.reason);
        s_conn_handle = BLE_HS_CONN_HANDLE_NONE;
        display_set_ble_connected(false);
        /*
         * Deliberately does NOT abort running tests. A multi-hour discharge
         * must survive an operator walking away with the tablet; the engine
         * has its own supervision and the results are persisted to NVS.
         */
        ble_svc_advertise();
        return 0;

    case BLE_GAP_EVENT_ADV_COMPLETE:
        ble_svc_advertise();
        return 0;

    case BLE_GAP_EVENT_SUBSCRIBE:
        ESP_LOGI(TAG, "subscribe: handle %u notify %d",
                 event->subscribe.attr_handle, event->subscribe.cur_notify);
        return 0;

    case BLE_GAP_EVENT_MTU:
        ESP_LOGI(TAG, "MTU now %d", event->mtu.value);
        return 0;

    default:
        return 0;
    }
}

static void ble_svc_advertise(void)
{
    struct ble_gap_adv_params adv_params;
    struct ble_hs_adv_fields  fields;
    struct ble_hs_adv_fields  rsp_fields;
    int rc;

    memset(&fields, 0, sizeof(fields));
    fields.flags = BLE_HS_ADV_F_DISC_GEN | BLE_HS_ADV_F_BREDR_UNSUP;
    fields.tx_pwr_lvl_is_present = 1;
    fields.tx_pwr_lvl = BLE_HS_ADV_TX_PWR_LVL_AUTO;
    fields.name = (uint8_t *)s_device_name;
    fields.name_len = strlen(s_device_name);
    fields.name_is_complete = 1;

    rc = ble_gap_adv_set_fields(&fields);
    if (rc != 0) {
        ESP_LOGE(TAG, "adv_set_fields rc=%d", rc);
        return;
    }

    /*
     * The 128-bit service UUID goes in the scan response: with the name it
     * would not fit in the 31-byte advertising payload, and Web Bluetooth
     * needs the UUID present to offer the device in a filtered chooser.
     */
    memset(&rsp_fields, 0, sizeof(rsp_fields));
    rsp_fields.uuids128 = (ble_uuid128_t *)&s_uuid_svc;
    rsp_fields.num_uuids128 = 1;
    rsp_fields.uuids128_is_complete = 1;
    rc = ble_gap_adv_rsp_set_fields(&rsp_fields);
    if (rc != 0) {
        ESP_LOGE(TAG, "adv_rsp_set_fields rc=%d", rc);
        return;
    }

    memset(&adv_params, 0, sizeof(adv_params));
    adv_params.conn_mode = BLE_GAP_CONN_MODE_UND;
    adv_params.disc_mode = BLE_GAP_DISC_MODE_GEN;

    rc = ble_gap_adv_start(s_own_addr_type, NULL, BLE_HS_FOREVER,
                           &adv_params, gap_event, NULL);
    if (rc != 0 && rc != BLE_HS_EALREADY) {
        ESP_LOGE(TAG, "adv_start rc=%d", rc);
    }
}

static void on_sync(void)
{
    int rc = ble_hs_util_ensure_addr(0);
    if (rc != 0) {
        ESP_LOGE(TAG, "ensure_addr rc=%d", rc);
        return;
    }
    rc = ble_hs_id_infer_auto(0, &s_own_addr_type);
    if (rc != 0) {
        ESP_LOGE(TAG, "infer_auto rc=%d", rc);
        return;
    }

    uint8_t addr[6] = {0};
    ble_hs_id_copy_addr(s_own_addr_type, addr, NULL);
    ESP_LOGI(TAG, "BLE up as %s, %02x:%02x:%02x:%02x:%02x:%02x",
             s_device_name, addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);

    ble_svc_advertise();
}

static void on_reset(int reason)
{
    ESP_LOGW(TAG, "host reset, reason %d", reason);
    s_conn_handle = BLE_HS_CONN_HANDLE_NONE;
}

static void host_task(void *param)
{
    (void)param;
    nimble_port_run();               /* returns only on nimble_port_stop() */
    nimble_port_freertos_deinit();
}

/* ------------------------------------------------------------------ */
/* Public                                                             */
/* ------------------------------------------------------------------ */

void ble_svc_set_wifi_connected(bool connected)
{
    s_wifi_connected = connected;
}

bool ble_svc_is_connected(void)
{
    return s_conn_handle != BLE_HS_CONN_HANDLE_NONE;
}

esp_err_t ble_svc_init(const char *device_name)
{
    if (device_name != NULL && device_name[0] != '\0') {
        snprintf(s_device_name, sizeof(s_device_name), "%s", device_name);
    }

    esp_err_t err = nimble_port_init();
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "nimble_port_init: %s", esp_err_to_name(err));
        return err;
    }

    ble_hs_cfg.reset_cb        = on_reset;
    ble_hs_cfg.sync_cb         = on_sync;
    ble_hs_cfg.store_status_cb = ble_store_util_status_rr;

    ble_svc_gap_init();
    ble_svc_gatt_init();

    int rc = ble_gatts_count_cfg(s_gatt_svcs);
    if (rc != 0) {
        ESP_LOGE(TAG, "gatts_count_cfg rc=%d", rc);
        return ESP_FAIL;
    }
    rc = ble_gatts_add_svcs(s_gatt_svcs);
    if (rc != 0) {
        ESP_LOGE(TAG, "gatts_add_svcs rc=%d", rc);
        return ESP_FAIL;
    }

    rc = ble_svc_gap_device_name_set(s_device_name);
    if (rc != 0) {
        ESP_LOGW(TAG, "device_name_set rc=%d", rc);
    }

    test_engine_set_change_callback(on_slot_change);

    nimble_port_freertos_init(host_task);

    if (xTaskCreate(notify_task, "ble_notify", 3072, NULL, 4, NULL) != pdPASS) {
        ESP_LOGW(TAG, "periodic notify task not started; clients must poll");
    }

    return ESP_OK;
}
