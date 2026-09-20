/*
 * ble_proto.h
 *
 * Packed wire records for the GATT interface.
 *
 * These are the exact bytes a BLE client reads and notifies on. They are
 * versioned by BLE_PROTO_VERSION, published in the unit-status record, so a
 * web client can refuse to decode a firmware it does not understand rather
 * than silently misreading a struct.
 *
 * Everything is little-endian, which is both the ESP32's native order and
 * the order a browser's DataView defaults to with littleEndian=true. Note
 * that this is the opposite of the BTS I2C wire format (big-endian) - the
 * conversion happens in bts_regs.h and nothing past bts_link sees the
 * C2000's byte order.
 *
 * All structs are explicitly packed and padded to a multiple of 4 so that a
 * compiler change cannot silently move a field.
 */

#ifndef BLE_PROTO_H
#define BLE_PROTO_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define BLE_PROTO_VERSION       3

/* Attribute value sizes are bounded by the negotiated MTU (247 - 3). */
#define BLE_PROTO_MAX_PAYLOAD   244

/* Command opcodes for the command characteristic. */
typedef enum {
    BLE_CMD_START        = 1,
    BLE_CMD_ABORT        = 2,
    BLE_CMD_CLEAR_FAULT  = 3,
    BLE_CMD_ABORT_ALL    = 4,
    BLE_CMD_PAUSE        = 5,
    BLE_CMD_RESUME       = 6,
} ble_cmd_op_t;

typedef struct __attribute__((packed)) {
    uint8_t  opcode;        /* ble_cmd_op_t                          */
    uint8_t  slot;          /* ignored by ABORT_ALL                  */
    uint16_t reserved;
} ble_cmd_t;

typedef struct __attribute__((packed)) {
    uint8_t  version;       /* BLE_PROTO_VERSION                     */
    uint8_t  slot_count;
    uint8_t  online;        /* BTS link up                           */
    uint8_t  unit_state;    /* bts_unit_state_t                      */
    uint32_t trip_status;   /* two bits per channel                  */
    float    input_voltage_v;
    uint32_t uptime_s;
    uint8_t  stats_live;    /* BTS accumulators populated - see       */
                            /* bts_link_stats_are_live()             */
    uint8_t  wifi_connected;
    uint16_t reserved;
    /*
     * The unit's configured host-watchdog timeout, 0 when disabled. The BTS
     * does not publish the remaining count, only the setting, so a client
     * can show whether supervision is armed but not a countdown.
     */
    float    watchdog_timeout_s;
} ble_unit_status_t;

typedef struct __attribute__((packed)) {
    uint8_t  slot;
    uint8_t  state;         /* slot_state_t                          */
    uint8_t  fault;         /* slot_fault_t                          */
    uint8_t  configured;

    float    voltage_v;
    float    current_a;
    float    temp_c;
    float    live_mah;
    float    live_mwh;
    float    progress;      /* 0..1+                                 */

    uint32_t elapsed_s;
    uint32_t state_elapsed_s;
    uint32_t status_bits;   /* BTS_STATUS_*                          */

    /*
     * The BTS's own view, appended in proto 3. `restored` says the unit
     * reset mid-run and is holding this slot's counters - the client must
     * make resuming an explicit operator choice, because the cell may have
     * been changed while the unit was off.
     */
    uint8_t  bts_paused;
    uint8_t  bts_wd_tripped;
    uint8_t  bts_restored;
    uint8_t  bts_ended;

    float    bts_charge_mah;
    float    bts_charge_mwh;
    float    bts_charge_seconds;
    float    bts_discharge_mah;
    float    bts_discharge_mwh;
    float    bts_discharge_seconds;
} ble_slot_status_t;

typedef struct __attribute__((packed)) {
    uint8_t  slot;
    uint8_t  chemistry;     /* cell_chemistry_t                      */
    uint8_t  auto_recharge;
    uint8_t  reserved;

    float    capacity_mah;  /* 0 => model default                    */
    float    charge_c;      /* 0 => chemistry default                */
    float    discharge_c;   /* 0 => chemistry default                */
    float    shipping_pct;
    uint32_t max_duration_minutes;

    char     model_name[24];
    char     serial[32];
} ble_slot_config_t;

typedef struct __attribute__((packed)) {
    uint8_t  slot;
    uint8_t  valid;
    uint8_t  chemistry;
    uint8_t  recharged;

    float    start_voltage_v;
    float    end_voltage_v;
    float    rested_voltage_v;
    float    discharge_mah;
    float    discharge_mwh;
    float    max_temp_c;
    float    max_current_a;
    float    min_voltage_v;
    float    max_voltage_v;
    float    recharge_mah;
    float    shipping_voltage_v;

    uint32_t discharge_seconds;
    int64_t  completed_unix;

    char     model_name[24];
    char     serial[32];
} ble_slot_result_t;

/*
 * One entry of the built-in catalogue, indexed by the catalog-index
 * characteristic. Chemistries occupy indices [0, chem_count), models follow
 * at [chem_count, chem_count + model_count).
 */
typedef struct __attribute__((packed)) {
    uint8_t  index;
    uint8_t  kind;          /* 0 = chemistry, 1 = model              */
    uint8_t  chemistry;
    uint8_t  total;         /* total catalogue entries               */

    float    capacity_mah;      /* models only        */
    float    charge_v_max;
    float    discharge_v_min;
    float    storage_v;
    float    charge_c;
    float    discharge_c;
    float    charge_current_max_a;
    float    discharge_current_max_a;
    float    temp_min_c;
    float    temp_max_c;
    uint32_t rest_minutes;

    char     name[24];
    char     manufacturer[24];
} ble_catalog_entry_t;

#define BLE_CATALOG_KIND_CHEMISTRY  0
#define BLE_CATALOG_KIND_MODEL      1

/*
 * Calibration control, characteristic 000b.
 *
 * `opcode` is a bts_cal_cmd_t; `arg` carries the measured volts, measured
 * amps or pu setpoint, and is ignored by the opcodes that take none. `slot`
 * is only read by ENTER.
 */
typedef struct __attribute__((packed)) {
    uint8_t  opcode;
    uint8_t  slot;
    uint16_t reserved;
    float    arg;
} ble_cal_cmd_t;

/*
 * Calibration status, characteristic 000c.
 *
 * The 9 telemetry floats are the raw pre-gain per-unit readings and the
 * post-gain engineering values of both measurement paths, as the unit
 * publishes them at 1056-1088.
 */
typedef struct __attribute__((packed)) {
    uint8_t  slot;          /* 255 = none                            */
    uint8_t  active;
    uint8_t  v_tick;        /* persisted voltage cal valid           */
    uint8_t  i_tick;        /* persisted current cal valid           */

    uint32_t status_bits;   /* BTS_CAL_ST_*                          */
    uint32_t result;        /* bts_cal_result_t of the last command  */

    float    ads_v_pu;
    float    ads_i_pu;
    float    ads_v_v;
    float    ads_i_a;
    float    f28_v_pu;
    float    f28_i_pu;
    float    f28_v_v;
    float    f28_i_a;
    float    temp_c;
} ble_cal_status_t;

#ifdef __cplusplus
}
#endif

#endif /* BLE_PROTO_H */
