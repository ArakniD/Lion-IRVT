/*
 * wifi_mgr.c
 *
 * Station bring-up with a SoftAP fallback.
 *
 * Kept separate from the HTTP handlers so the network lifecycle is readable
 * on its own. web_api_init() calls wifi_mgr_start() then starts the server;
 * the server binds to whichever interface came up.
 */

#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/event_groups.h"
#include "esp_log.h"
#include "esp_wifi.h"
#include "esp_event.h"
#include "esp_netif.h"
#include "nvs.h"
#include "ble_svc.h"
#include "wifi_mgr.h"

static const char *TAG = "wifi_mgr";
static const char *NVS_NAMESPACE = "wifi";

#define WIFI_CONNECTED_BIT  BIT0
#define WIFI_FAILED_BIT     BIT1

/*
 * Join attempts before falling back to the SoftAP. Kept low: the point of
 * the fallback is that the tester stays reachable, and the station retries
 * forever in the background anyway once the AP is up.
 */
#define MAX_JOIN_RETRIES    5

static EventGroupHandle_t s_events;
static int                s_retries;
static bool               s_connected;
static bool               s_ap_active;
static esp_netif_t       *s_sta_netif;
static esp_netif_t       *s_ap_netif;

bool wifi_mgr_connected(void)
{
    return s_connected;
}

bool wifi_mgr_ap_active(void)
{
    return s_ap_active;
}

static void event_handler(void *arg, esp_event_base_t base,
                          int32_t id, void *data)
{
    (void)arg;

    if (base == WIFI_EVENT && id == WIFI_EVENT_STA_START) {
        esp_wifi_connect();
        return;
    }

    if (base == WIFI_EVENT && id == WIFI_EVENT_STA_DISCONNECTED) {
        s_connected = false;
        ble_svc_set_wifi_connected(false);
        if (s_retries < MAX_JOIN_RETRIES) {
            s_retries++;
            ESP_LOGW(TAG, "station disconnected, retry %d/%d",
                     s_retries, MAX_JOIN_RETRIES);
            esp_wifi_connect();
        } else {
            xEventGroupSetBits(s_events, WIFI_FAILED_BIT);
            /*
             * Keep trying in the background. The AP fallback makes the box
             * reachable meanwhile; if the real network comes back the
             * station rejoins without an operator power-cycling anything.
             */
            esp_wifi_connect();
        }
        return;
    }

    if (base == IP_EVENT && id == IP_EVENT_STA_GOT_IP) {
        const ip_event_got_ip_t *e = (const ip_event_got_ip_t *)data;
        ESP_LOGI(TAG, "station up, IP " IPSTR, IP2STR(&e->ip_info.ip));
        s_retries   = 0;
        s_connected = true;
        ble_svc_set_wifi_connected(true);
        xEventGroupSetBits(s_events, WIFI_CONNECTED_BIT);
        return;
    }

    if (base == WIFI_EVENT && id == WIFI_EVENT_AP_STACONNECTED) {
        const wifi_event_ap_staconnected_t *e = (const wifi_event_ap_staconnected_t *)data;
        ESP_LOGI(TAG, "AP client joined: %02x:%02x:%02x:%02x:%02x:%02x",
                 e->mac[0], e->mac[1], e->mac[2], e->mac[3], e->mac[4], e->mac[5]);
    }
}

/*
 * Copies into a fixed-width WiFi config field.
 *
 * esp_wifi's ssid/password fields are fixed-size arrays that do not require
 * a terminator, so a 32-character SSID legitimately fills the field. Returns
 * false when the source is longer than the field - better to refuse the
 * credentials than to join with a silently truncated SSID.
 */
static bool copy_wifi_field(uint8_t *dst, size_t dst_len, const char *src)
{
    const size_t n = (src != NULL) ? strlen(src) : 0;
    if (n > dst_len) {
        return false;
    }
    memset(dst, 0, dst_len);
    memcpy(dst, src, n);
    return true;
}

static bool load_credentials(char *ssid, size_t ssid_len,
                             char *pass, size_t pass_len)
{
    nvs_handle_t h;
    if (nvs_open(NVS_NAMESPACE, NVS_READONLY, &h) != ESP_OK) {
        return false;
    }

    size_t n = ssid_len;
    esp_err_t err = nvs_get_str(h, "ssid", ssid, &n);
    if (err == ESP_OK) {
        n = pass_len;
        if (nvs_get_str(h, "pass", pass, &n) != ESP_OK) {
            pass[0] = '\0';
        }
    }
    nvs_close(h);
    return err == ESP_OK && ssid[0] != '\0';
}

esp_err_t wifi_set_credentials(const char *ssid, const char *password)
{
    if (ssid == NULL || ssid[0] == '\0') {
        return ESP_ERR_INVALID_ARG;
    }

    /*
     * Build the config first, so an over-long SSID is rejected before it
     * reaches flash rather than after - otherwise the device would come up
     * on every subsequent boot trying to join a truncated network name.
     */
    wifi_config_t cfg;
    memset(&cfg, 0, sizeof(cfg));
    if (!copy_wifi_field(cfg.sta.ssid, sizeof(cfg.sta.ssid), ssid) ||
        !copy_wifi_field(cfg.sta.password, sizeof(cfg.sta.password),
                         password ? password : "")) {
        ESP_LOGE(TAG, "SSID or password too long for the WiFi config");
        return ESP_ERR_INVALID_SIZE;
    }

    nvs_handle_t h;
    esp_err_t err = nvs_open(NVS_NAMESPACE, NVS_READWRITE, &h);
    if (err != ESP_OK) {
        return err;
    }
    err = nvs_set_str(h, "ssid", ssid);
    if (err == ESP_OK) {
        err = nvs_set_str(h, "pass", password ? password : "");
    }
    if (err == ESP_OK) {
        err = nvs_commit(h);
    }
    nvs_close(h);
    if (err != ESP_OK) {
        return err;
    }

    /* Apply immediately rather than waiting for a reboot. */
    s_retries = 0;
    esp_wifi_disconnect();
    err = esp_wifi_set_config(WIFI_IF_STA, &cfg);
    if (err == ESP_OK) {
        err = esp_wifi_connect();
    }
    ESP_LOGI(TAG, "credentials updated for SSID '%s'", ssid);
    return err;
}

esp_err_t wifi_mgr_start(const char *ap_ssid, const char *ap_password)
{
    s_events = xEventGroupCreate();
    if (s_events == NULL) {
        return ESP_ERR_NO_MEM;
    }

    ESP_ERROR_CHECK(esp_netif_init());
    ESP_ERROR_CHECK(esp_event_loop_create_default());
    s_sta_netif = esp_netif_create_default_wifi_sta();
    s_ap_netif  = esp_netif_create_default_wifi_ap();

    wifi_init_config_t init_cfg = WIFI_INIT_CONFIG_DEFAULT();
    ESP_ERROR_CHECK(esp_wifi_init(&init_cfg));

    ESP_ERROR_CHECK(esp_event_handler_instance_register(
        WIFI_EVENT, ESP_EVENT_ANY_ID, event_handler, NULL, NULL));
    ESP_ERROR_CHECK(esp_event_handler_instance_register(
        IP_EVENT, IP_EVENT_STA_GOT_IP, event_handler, NULL, NULL));

    char ssid[33] = {0};
    char pass[65] = {0};
    bool have_creds = load_credentials(ssid, sizeof(ssid), pass, sizeof(pass));

    /*
     * APSTA unconditionally. Coming up in both roles means the fallback does
     * not need a mode switch (which drops the station association) and the
     * bench AP stays available even once the site network is joined - useful
     * when the tester is moved between benches.
     */
    ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_APSTA));

    wifi_config_t ap_cfg;
    memset(&ap_cfg, 0, sizeof(ap_cfg));
    const char *ssid_src = (ap_ssid && ap_ssid[0]) ? ap_ssid : "BTS-Tester";
    if (!copy_wifi_field(ap_cfg.ap.ssid, sizeof(ap_cfg.ap.ssid), ssid_src)) {
        ESP_LOGE(TAG, "AP SSID too long");
        return ESP_ERR_INVALID_ARG;
    }
    ap_cfg.ap.ssid_len       = (uint8_t)strlen(ssid_src);
    ap_cfg.ap.max_connection = 4;
    ap_cfg.ap.channel        = 1;
    if (ap_password != NULL && strlen(ap_password) >= 8) {
        if (!copy_wifi_field(ap_cfg.ap.password, sizeof(ap_cfg.ap.password),
                             ap_password)) {
            ESP_LOGE(TAG, "AP password too long");
            return ESP_ERR_INVALID_ARG;
        }
        ap_cfg.ap.authmode = WIFI_AUTH_WPA2_PSK;
    } else {
        ap_cfg.ap.authmode = WIFI_AUTH_OPEN;
    }
    ESP_ERROR_CHECK(esp_wifi_set_config(WIFI_IF_AP, &ap_cfg));

    if (have_creds) {
        wifi_config_t sta_cfg;
        memset(&sta_cfg, 0, sizeof(sta_cfg));
        if (!copy_wifi_field(sta_cfg.sta.ssid, sizeof(sta_cfg.sta.ssid), ssid) ||
            !copy_wifi_field(sta_cfg.sta.password, sizeof(sta_cfg.sta.password), pass)) {
            /* Stored by an older build with a different field width. */
            ESP_LOGE(TAG, "stored credentials do not fit; AP only");
            have_creds = false;
        } else {
            ESP_ERROR_CHECK(esp_wifi_set_config(WIFI_IF_STA, &sta_cfg));
            ESP_LOGI(TAG, "joining '%s'", ssid);
        }
    }
    if (!have_creds) {
        ESP_LOGW(TAG, "no usable stored credentials; AP only "
                      "(POST /api/wifi to set them)");
    }

    ESP_ERROR_CHECK(esp_wifi_start());
    s_ap_active = true;

    if (have_creds) {
        /* Bounded wait so boot is not held up by an absent network. */
        xEventGroupWaitBits(s_events, WIFI_CONNECTED_BIT | WIFI_FAILED_BIT,
                            pdFALSE, pdFALSE, pdMS_TO_TICKS(10000));
    }

    esp_netif_ip_info_t ap_ip;
    if (esp_netif_get_ip_info(s_ap_netif, &ap_ip) == ESP_OK) {
        ESP_LOGI(TAG, "AP '%s' at " IPSTR, ap_cfg.ap.ssid, IP2STR(&ap_ip.ip));
    }
    return ESP_OK;
}
