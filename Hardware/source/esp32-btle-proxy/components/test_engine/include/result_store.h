/*
 * result_store.h
 *
 * Persistence for completed test results.
 *
 * Results are written to the dedicated `results` NVS partition (see
 * partitions.csv) rather than the default one, so that filling it with test
 * history cannot displace the chemistry overrides or WiFi credentials.
 *
 * The store is a fixed-size ring: each slot keeps its most recent result
 * under a per-slot key plus a rolling history of the last
 * RESULT_HISTORY_DEPTH tests across all slots. That is enough to survive a
 * power cut mid-shift; longer-term retention is the web layer's job.
 */

#ifndef RESULT_STORE_H
#define RESULT_STORE_H

#include "esp_err.h"
#include "test_engine.h"

#ifdef __cplusplus
extern "C" {
#endif

#define RESULT_HISTORY_DEPTH  64

esp_err_t result_store_init(void);

/* Persists a result as slot `slot`'s latest and appends it to the history. */
esp_err_t result_store_save(uint8_t slot, const slot_result_t *result);

/* Loads slot `slot`'s most recent result. */
esp_err_t result_store_load_latest(uint8_t slot, slot_result_t *out);

/*
 * Reads history entry `index`, 0 being the most recent. Returns
 * ESP_ERR_NOT_FOUND once the history is exhausted.
 */
esp_err_t result_store_history_at(size_t index, slot_result_t *out);
size_t result_store_history_count(void);

esp_err_t result_store_clear(void);

#ifdef __cplusplus
}
#endif

#endif /* RESULT_STORE_H */
