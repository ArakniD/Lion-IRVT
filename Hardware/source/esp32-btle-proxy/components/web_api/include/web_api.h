/*
 * web_api.h
 *
 * JSON HTTP API and WiFi bring-up.
 *
 * The BLE interface is the primary one for an operator at the bench; this is
 * the interface for a browser on the LAN, for scripted integration, and for
 * bulk retrieval of the result history (which does not fit comfortably in a
 * GATT characteristic).
 *
 * ENDPOINTS
 * ---------
 *   GET  /api/status                 unit + all slots
 *   GET  /api/slot/<n>               one slot, including its resolved profile
 *   POST /api/slot/<n>/config        slot_config_t fields, all optional
 *   POST /api/slot/<n>/start
 *   POST /api/slot/<n>/abort
 *   POST /api/slot/<n>/clear
 *   POST /api/slot/<n>/pause         pause a running slot on the BTS
 *   POST /api/slot/<n>/resume        resume a paused one - operator action
 *   POST /api/slot/<n>/serial        {"serial":"..."}
 *   GET  /api/slot/<n>/result        the slot's latest result
 *   GET  /api/results?offset=&limit= rolling history across all slots
 *   GET  /api/catalog                chemistries and cell models
 *   POST /api/chemistry/<name>       override a chemistry profile in NVS
 *   POST /api/abort_all
 *   GET  /api/registers              raw BTS register blocks, for bring-up
 *
 * WIFI
 * ----
 * Credentials live in the default NVS partition under the "wifi" namespace
 * and are set with wifi_set_credentials(); there is no captive portal. If no
 * credentials are stored, or the join fails, the device falls back to a
 * SoftAP so the API stays reachable - a tester that cannot be talked to
 * because someone changed the WiFi password is worse than an open AP on a
 * bench network.
 */

#ifndef WEB_API_H
#define WEB_API_H

#include <stdint.h>
#include <stdbool.h>
#include "esp_err.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    const char *ap_ssid;        /* fallback SoftAP SSID          */
    const char *ap_password;    /* >= 8 chars, or NULL for open  */
    uint16_t    port;           /* 0 => 80                       */
} web_api_config_t;

/* Brings up WiFi (STA with SoftAP fallback) and starts the HTTP server. */
esp_err_t web_api_init(const web_api_config_t *config);

/* Stores station credentials in NVS and reconnects. */
esp_err_t wifi_set_credentials(const char *ssid, const char *password);

bool web_api_sta_connected(void);

#ifdef __cplusplus
}
#endif

#endif /* WEB_API_H */
