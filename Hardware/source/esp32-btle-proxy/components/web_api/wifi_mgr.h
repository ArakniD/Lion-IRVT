/*
 * wifi_mgr.h
 *
 * Internal interface between web_api.c and wifi_mgr.c. Not installed in the
 * component's public include directory: callers use web_api.h.
 */

#ifndef WIFI_MGR_H
#define WIFI_MGR_H

#include <stdbool.h>
#include <stdint.h>
#include "esp_err.h"

/*
 * What the setup page shows about the network.
 *
 * No password field, by design: credentials go in through
 * wifi_set_credentials() and never come back out. The SoftAP is open, so
 * anything readable here is readable by anyone within radio range.
 */
typedef struct {
    char    ssid[33];       /* configured station SSID, "" if none   */
    bool    connected;      /* station has an IP                     */
    char    ip[16];         /* station address, "" when not joined   */
    bool    ap_active;
    char    ap_ssid[33];
    char    ap_ip[16];
    int8_t  rssi;           /* 0 when not joined                     */
} wifi_mgr_info_t;

esp_err_t wifi_mgr_start(const char *ap_ssid, const char *ap_password);
bool wifi_mgr_connected(void);
bool wifi_mgr_ap_active(void);
void wifi_mgr_get_info(wifi_mgr_info_t *out);
/*
 * Stores station credentials in NVS and rejoins with them.
 *
 *   ESP_OK                saved and the join started
 *   ESP_ERR_INVALID_ARG   empty SSID
 *   ESP_ERR_INVALID_SIZE  SSID over 32 bytes or password over 64; nothing saved
 *   ESP_ERR_NOT_FINISHED  saved, but the radio would not take the new config;
 *                         it is used from the next boot
 *   anything else         the NVS write failed; nothing saved
 */
esp_err_t wifi_set_credentials(const char *ssid, const char *password);

#endif /* WIFI_MGR_H */
