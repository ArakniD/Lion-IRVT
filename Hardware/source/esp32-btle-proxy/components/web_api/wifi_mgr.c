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
#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/event_groups.h"
#include "esp_log.h"
#include "esp_wifi.h"
#include "esp_event.h"
#include "esp_netif.h"
#include "esp_timer.h"
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

/*
 * Once those are spent, the gap between background attempts - and a longer
 * one while anybody is on the SoftAP.
 *
 * The ESP32 has one radio, so every attempt to find the station's network
 * takes the SoftAP off its channel for a full scan. Measured on the bench
 * with a Windows laptop on the AP and a saved network that was not there: at
 * a 30 s cadence the setup page was unreachable for about 20 s of every 35.
 * The scan itself is brief; the client notices the beacons stop, drops the
 * AP, and takes its own time to rejoin.
 *
 * So the 30 s cadence applies only with nobody on the AP, where nothing is
 * disturbed. While a client is connected the retry backs off to 5 minutes,
 * which gives an operator who joined the AP to fix a mistyped password a
 * steady page to fix it on, and still rejoins a site network that comes
 * back while a tablet is left on the AP.
 */
#define BACKGROUND_RETRY_US     (30LL * 1000000LL)
#define BACKGROUND_RETRY_AP_US  (300LL * 1000000LL)

/* How long a credential change waits for an in-flight connect to settle. */
#define RECONFIG_SETTLE_TRIES   20
#define RECONFIG_SETTLE_MS      50

static EventGroupHandle_t s_events;
static int                s_retries;
static bool               s_connected;
static bool               s_ap_active;
static esp_netif_t       *s_sta_netif;
static esp_netif_t       *s_ap_netif;
static char               s_ap_ssid[33];
static esp_timer_handle_t s_retry_timer;
/*
 * Set while wifi_set_credentials() is swapping the station config. The
 * disconnect it causes must not trigger a reconnect to the OLD network,
 * which would race the new config in and fail it with ESP_ERR_WIFI_STATE.
 */
static volatile bool      s_reconfiguring;
/*
 * True while a station network is configured. Without it the driver is asked
 * to connect with an empty SSID - harmless, but it was also the path by which
 * a network the operator had forgotten could come back.
 */
static volatile bool      s_have_sta;
/* Clients on the SoftAP, refreshed from the driver on every join and leave. */
static volatile int       s_ap_clients;

bool wifi_mgr_connected(void)
{
    return s_connected;
}

bool wifi_mgr_ap_active(void)
{
    return s_ap_active;
}

static void addr_to_str(const esp_netif_ip_info_t *info, char *out, size_t len)
{
    snprintf(out, len, IPSTR, IP2STR(&info->ip));
}

void wifi_mgr_get_info(wifi_mgr_info_t *out)
{
    if (out == NULL) {
        return;
    }
    memset(out, 0, sizeof(*out));

    /*
     * The SSID comes from the live station config rather than from NVS, so
     * what is reported is what the radio is actually trying to join - the
     * two differ for the moments between a credential write and the
     * reconnect, and after a stored SSID was rejected as too long at boot.
     */
    wifi_config_t cfg;
    if (esp_wifi_get_config(WIFI_IF_STA, &cfg) == ESP_OK) {
        memcpy(out->ssid, cfg.sta.ssid, sizeof(cfg.sta.ssid));
        out->ssid[sizeof(cfg.sta.ssid)] = '\0';
    }

    out->connected = s_connected;
    out->ap_active = s_ap_active;
    strncpy(out->ap_ssid, s_ap_ssid, sizeof(out->ap_ssid) - 1);

    esp_netif_ip_info_t ip;
    if (s_connected && s_sta_netif != NULL &&
        esp_netif_get_ip_info(s_sta_netif, &ip) == ESP_OK) {
        addr_to_str(&ip, out->ip, sizeof(out->ip));
    }
    if (s_ap_active && s_ap_netif != NULL &&
        esp_netif_get_ip_info(s_ap_netif, &ip) == ESP_OK) {
        addr_to_str(&ip, out->ap_ip, sizeof(out->ap_ip));
    }

    wifi_ap_record_t ap;
    if (s_connected && esp_wifi_sta_get_ap_info(&ap) == ESP_OK) {
        out->rssi = ap.rssi;
    }
}

static int64_t background_retry_period(void)
{
    return (s_ap_clients > 0) ? BACKGROUND_RETRY_AP_US : BACKGROUND_RETRY_US;
}

/* (Re)arms the background retry at the period that suits the AP's use. */
static void schedule_background_retry(void)
{
    if (s_retry_timer == NULL || !s_have_sta) {
        return;
    }
    esp_timer_stop(s_retry_timer);      /* not running is fine */
    esp_timer_start_once(s_retry_timer, background_retry_period());
}

static void refresh_ap_clients(void)
{
    wifi_sta_list_t list;
    if (esp_wifi_ap_get_sta_list(&list) == ESP_OK) {
        s_ap_clients = list.num;
    }

    /*
     * Re-time a retry that is already waiting, so a client who has just
     * joined gets the long quiet window from now rather than whatever was
     * left of the short one - and the short cadence resumes as soon as the
     * last client leaves. A join attempt in flight is left alone; its
     * failure schedules the next one at the new period.
     */
    if (!s_connected && s_retry_timer != NULL &&
        esp_timer_is_active(s_retry_timer)) {
        schedule_background_retry();
    }
}

static void event_handler(void *arg, esp_event_base_t base,
                          int32_t id, void *data)
{
    (void)arg;

    if (base == WIFI_EVENT && id == WIFI_EVENT_STA_START) {
        if (s_have_sta) {
            esp_wifi_connect();
        }
        return;
    }

    if (base == WIFI_EVENT && id == WIFI_EVENT_STA_DISCONNECTED) {
        const wifi_event_sta_disconnected_t *e =
            (const wifi_event_sta_disconnected_t *)data;
        s_connected = false;
        ble_svc_set_wifi_connected(false);
        if (s_reconfiguring || !s_have_sta) {
            return;     /* a credential change reconnects itself */
        }
        if (s_retries < MAX_JOIN_RETRIES) {
            s_retries++;
            ESP_LOGW(TAG, "station disconnected (reason %u), retry %d/%d",
                     e->reason, s_retries, MAX_JOIN_RETRIES);
            esp_wifi_connect();
        } else {
            xEventGroupSetBits(s_events, WIFI_FAILED_BIT);
            /*
             * Keep trying in the background, but spaced out - see
             * BACKGROUND_RETRY_US. The AP fallback makes the box reachable
             * meanwhile; if the real network comes back the station rejoins
             * without an operator power-cycling anything.
             */
            ESP_LOGW(TAG, "station join failed (reason %u); next try in "
                          "%lld s", e->reason,
                     background_retry_period() / 1000000LL);
            schedule_background_retry();
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
        refresh_ap_clients();
        return;
    }

    if (base == WIFI_EVENT && id == WIFI_EVENT_AP_STADISCONNECTED) {
        refresh_ap_clients();
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

    /*
     * Apply immediately rather than waiting for a reboot.
     *
     * The background retry is cancelled and the disconnect handler told to
     * stand down, so nothing reconnects to the old network underneath the
     * config swap. A connect already in flight still makes set_config return
     * ESP_ERR_WIFI_STATE until it settles, hence the short retry.
     */
    s_reconfiguring = true;
    if (s_retry_timer != NULL) {
        esp_timer_stop(s_retry_timer);
    }
    s_retries = 0;
    esp_wifi_disconnect();

    for (int i = 0; i < RECONFIG_SETTLE_TRIES; i++) {
        err = esp_wifi_set_config(WIFI_IF_STA, &cfg);
        if (err != ESP_ERR_WIFI_STATE) {
            break;
        }
        vTaskDelay(pdMS_TO_TICKS(RECONFIG_SETTLE_MS));
        esp_wifi_disconnect();
    }
    s_have_sta      = true;
    s_reconfiguring = false;

    if (err == ESP_OK) {
        err = esp_wifi_connect();
    }
    if (err != ESP_OK) {
        /*
         * Saved but not applied. Reported as such rather than as success,
         * but the credentials are in NVS and will be used from the next
         * boot, so the caller can say exactly that.
         */
        ESP_LOGE(TAG, "credentials for '%s' saved but not applied: %s",
                 ssid, esp_err_to_name(err));
        return ESP_ERR_NOT_FINISHED;
    }
    ESP_LOGI(TAG, "credentials updated for SSID '%s'", ssid);
    return ESP_OK;
}

esp_err_t wifi_forget_credentials(void)
{
    nvs_handle_t h;
    esp_err_t err = nvs_open(NVS_NAMESPACE, NVS_READWRITE, &h);
    if (err != ESP_OK) {
        return err;
    }
    (void)nvs_erase_key(h, "ssid");     /* absent is fine */
    (void)nvs_erase_key(h, "pass");
    err = nvs_commit(h);
    nvs_close(h);
    if (err != ESP_OK) {
        return err;
    }

    /*
     * Stand everything down before the config is blanked, so the disconnect
     * this causes does not set off a retry against the network just removed.
     */
    s_reconfiguring = true;
    s_have_sta      = false;
    if (s_retry_timer != NULL) {
        esp_timer_stop(s_retry_timer);
    }
    s_retries = 0;
    esp_wifi_disconnect();

    wifi_config_t cfg;
    memset(&cfg, 0, sizeof(cfg));
    for (int i = 0; i < RECONFIG_SETTLE_TRIES; i++) {
        err = esp_wifi_set_config(WIFI_IF_STA, &cfg);
        if (err != ESP_ERR_WIFI_STATE) {
            break;
        }
        vTaskDelay(pdMS_TO_TICKS(RECONFIG_SETTLE_MS));
        esp_wifi_disconnect();
    }
    s_reconfiguring = false;

    /*
     * The NVS keys are gone either way, so the next boot comes up AP-only
     * whatever the driver said. Only report the live state if it disagrees.
     */
    ESP_LOGI(TAG, "station credentials forgotten; AP only");
    return (err == ESP_OK) ? ESP_OK : ESP_ERR_NOT_FINISHED;
}

static void retry_timer_cb(void *arg)
{
    (void)arg;
    if (!s_connected && !s_reconfiguring && s_have_sta) {
        esp_wifi_connect();
    }
}

esp_err_t wifi_mgr_start(const char *ap_ssid, const char *ap_password)
{
    s_events = xEventGroupCreate();
    if (s_events == NULL) {
        return ESP_ERR_NO_MEM;
    }

    const esp_timer_create_args_t retry_args = {
        .callback = retry_timer_cb,
        .name     = "wifi_retry",
    };
    ESP_ERROR_CHECK(esp_timer_create(&retry_args, &s_retry_timer));

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
    strncpy(s_ap_ssid, ssid_src, sizeof(s_ap_ssid) - 1);
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
            s_have_sta = true;
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
