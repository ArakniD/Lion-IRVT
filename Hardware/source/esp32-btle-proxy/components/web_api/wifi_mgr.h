/*
 * wifi_mgr.h
 *
 * Internal interface between web_api.c and wifi_mgr.c. Not installed in the
 * component's public include directory: callers use web_api.h.
 */

#ifndef WIFI_MGR_H
#define WIFI_MGR_H

#include <stdbool.h>
#include "esp_err.h"

esp_err_t wifi_mgr_start(const char *ap_ssid, const char *ap_password);
bool wifi_mgr_connected(void);
bool wifi_mgr_ap_active(void);
esp_err_t wifi_set_credentials(const char *ssid, const char *password);

#endif /* WIFI_MGR_H */
