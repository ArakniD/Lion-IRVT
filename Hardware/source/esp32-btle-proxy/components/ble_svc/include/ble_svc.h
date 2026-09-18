/*
 * ble_svc.h
 *
 * NimBLE GATT server exposing the tester to a browser over Web Bluetooth.
 *
 * NimBLE rather than Bluedroid: this build carries dual OTA slots in 4 MB of
 * flash, and the Bluedroid host costs roughly 100 kB more than NimBLE for a
 * peripheral-only role we do not otherwise need.
 *
 * SERVICE LAYOUT
 * --------------
 * One primary service, UUID e5f10001-9a4c-4b7d-8f2e-1c3a5b7d9f01, with a
 * 16-bit discriminator in bytes 2-3 of every characteristic UUID:
 *
 *   0002  unit status     read, notify   ble_unit_status_t
 *   0003  command         write          ble_cmd_t
 *   0004  slot select     read, write    uint8, selects the slot that the
 *                                        config/result reads return
 *   0005  slot config     read, write    ble_slot_config_t
 *   0006  slot result     read           ble_slot_result_t
 *   0007  slot serial     write          UTF-8 barcode for the selected slot
 *   0008  catalog index   read, write    uint8
 *   0009  catalog entry   read           ble_catalog_entry_t
 *   000a  slot status     read, notify   ble_slot_status_t
 *
 * The slot-status characteristic carries the slot number in its payload, so
 * a single subscription covers all eight slots. Notifications fire on every
 * state change and, while any slot is active, once a second regardless - a
 * live UI needs the running totals, not just the transitions.
 *
 * The select characteristics (0004, 0008) are per-server, not per-
 * connection: two clients paging the catalogue at the same time will
 * interfere. That is an accepted simplification for a single-operator bench
 * instrument. Writes never use them - ble_slot_config_t carries its own slot
 * field - so the failure mode is a stale read, never a command applied to
 * the wrong cell.
 */

#ifndef BLE_SVC_H
#define BLE_SVC_H

#include <stdbool.h>
#include "esp_err.h"

#ifdef __cplusplus
extern "C" {
#endif

esp_err_t ble_svc_init(const char *device_name);

/* Mirrored into the unit-status record so a BLE client can see whether the
 * richer HTTP API is reachable. */
void ble_svc_set_wifi_connected(bool connected);

bool ble_svc_is_connected(void);

#ifdef __cplusplus
}
#endif

#endif /* BLE_SVC_H */
