/*
 * test_engine.h
 *
 * Per-slot battery test state machine.
 *
 * SEQUENCE
 * --------
 * A slot is armed with a cell configuration and then started. The engine
 * runs one of two paths depending on how full the cell is when it arrives:
 *
 *   IDLE
 *     -> CHECK_REST      measure open-circuit voltage
 *        if V >= charge_v_max * (1 - rest_tolerance_pct/100)
 *          -> DISCHARGE
 *        else
 *          -> CHARGE -> REST (rest_minutes) -> DISCHARGE
 *     -> DISCHARGE       CC at the discharge C rate until the cell reaches
 *                        discharge_v_min, integrating mAh/mWh locally
 *     -> DISCHARGE_REST  settle, then record the true end voltage
 *     -> RECHARGE        only if auto_recharge_to_shipping is set: put back
 *                        shipping_pct of the mAh just removed, by coulomb
 *                        count, then stop
 *     -> COMPLETE
 *
 * Any state can transition to FAULT or ABORTED.
 *
 * WHY THE ENGINE TERMINATES THE DISCHARGE
 * ---------------------------------------
 * The BTS does not signal end-of-test on its own. status[].finished is
 * declared and published in the status bitfield but never set by any code
 * path on either C2000 core (only read, in publishStatusToCpu2()). So the
 * engine watches cell voltage against the cutoff itself and issues the stop.
 * If a future BTS build starts asserting BTS_STATUS_FINISHED, the engine
 * honours it as an additional termination condition.
 *
 * SAFETY
 * ------
 * Every state that has the power stage enabled is subject to per-tick
 * limit checks: over-temperature, over-current, trip bits, unit state, and
 * a wall-clock timeout. Any of them stops the channel and moves to FAULT.
 * The engine also stops every channel on a BTS comms blackout, so a dropped
 * I2C link cannot leave a cell on load indefinitely.
 */

#ifndef TEST_ENGINE_H
#define TEST_ENGINE_H

#include <stdint.h>
#include <stdbool.h>
#include "esp_err.h"
#include "bts_link.h"
#include "cell_profiles.h"
#include "coulomb_counter.h"

#ifdef __cplusplus
extern "C" {
#endif

#define SLOT_COUNT          BTS_NUM_CHANNELS
#define SERIAL_MAX          32

typedef enum {
    SLOT_STATE_IDLE = 0,
    SLOT_STATE_CHECK_REST,
    SLOT_STATE_CHARGE,
    SLOT_STATE_REST,
    SLOT_STATE_DISCHARGE,
    SLOT_STATE_DISCHARGE_REST,
    SLOT_STATE_RECHARGE,
    SLOT_STATE_COMPLETE,
    SLOT_STATE_FAULT,
    SLOT_STATE_ABORTED,
    SLOT_STATE_COUNT,
} slot_state_t;

typedef enum {
    SLOT_FAULT_NONE = 0,
    SLOT_FAULT_OVER_TEMP,
    SLOT_FAULT_UNDER_TEMP,
    SLOT_FAULT_OVER_CURRENT,
    SLOT_FAULT_CMPSS_TRIP,
    SLOT_FAULT_GPIO_TRIP,
    SLOT_FAULT_TIMEOUT,
    SLOT_FAULT_BTS_OFFLINE,
    SLOT_FAULT_UNIT_STATE,
    SLOT_FAULT_NO_CELL,
    SLOT_FAULT_CELL_REVERSED,
    SLOT_FAULT_COMMS,
    SLOT_FAULT_COUNT,
} slot_fault_t;

/* Caller-supplied configuration for one slot. */
typedef struct {
    cell_chemistry_t chemistry;
    char             model_name[CELL_NAME_MAX];
    char             serial[SERIAL_MAX];       /* barcode, optional */
    float            capacity_mah;             /* 0 => model default */
    float            charge_c;                 /* 0 => chemistry default */
    float            discharge_c;              /* 0 => chemistry default */
    bool             auto_recharge_to_shipping;
    float            shipping_pct;             /* default 60 */
    uint32_t         max_duration_minutes;     /* 0 => built-in default */
} slot_config_t;

/* Recorded result of a completed test. */
typedef struct {
    bool     valid;
    char     serial[SERIAL_MAX];
    char     model_name[CELL_NAME_MAX];
    cell_chemistry_t chemistry;

    float    start_voltage_v;      /* OCV before the discharge began    */
    float    end_voltage_v;        /* at the cutoff, under load         */
    float    rested_voltage_v;     /* after DISCHARGE_REST settled      */
    float    discharge_mah;
    float    discharge_mwh;
    float    max_temp_c;
    float    max_current_a;
    float    min_voltage_v;
    float    max_voltage_v;
    uint32_t discharge_seconds;

    /* Populated only when the recharge-to-shipping step ran. */
    bool     recharged;
    float    recharge_mah;
    float    shipping_voltage_v;

    /*
     * Raw BTS accumulator values at the end of the discharge. Meaningful
     * only if bts_link_stats_are_live() - see coulomb_counter.h.
     */
    float    bts_current_acc;
    float    bts_power_acc;

    int64_t  completed_unix;
} slot_result_t;

/* Live view of a slot, for the API and GATT layers. */
typedef struct {
    slot_state_t     state;
    slot_fault_t     fault;
    bool             configured;
    slot_config_t    config;
    cell_resolved_profile_t profile;

    float            voltage_v;
    float            current_a;
    float            temp_c;
    uint32_t         status_bits;

    double           live_mah;
    double           live_mwh;
    uint32_t         elapsed_s;
    uint32_t         state_elapsed_s;
    /* Fraction of the expected capacity moved so far, 0..1+. */
    float            progress;

    slot_result_t    last_result;
} slot_status_t;

esp_err_t test_engine_init(void);

/* Arming and control. All are safe from any task. */
esp_err_t test_engine_configure(uint8_t slot, const slot_config_t *config);
esp_err_t test_engine_start(uint8_t slot);
esp_err_t test_engine_abort(uint8_t slot);
esp_err_t test_engine_abort_all(void);
esp_err_t test_engine_clear_fault(uint8_t slot);

/*
 * Assigns a barcode/serial to a slot. Allowed at any point up to the moment
 * the result is persisted, so an operator can scan the cell after starting
 * the test.
 */
esp_err_t test_engine_set_serial(uint8_t slot, const char *serial);

void test_engine_get_status(uint8_t slot, slot_status_t *out);
esp_err_t test_engine_get_result(uint8_t slot, slot_result_t *out);

const char *slot_state_name(slot_state_t state);
const char *slot_fault_name(slot_fault_t fault);

/*
 * Registered by the BLE layer so a state change pushes a notification
 * without the GATT server having to poll.
 */
typedef void (*slot_change_cb_t)(uint8_t slot, const slot_status_t *status);
void test_engine_set_change_callback(slot_change_cb_t cb);

#ifdef __cplusplus
}
#endif

#endif /* TEST_ENGINE_H */
