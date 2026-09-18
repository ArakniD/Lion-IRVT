/*
 * result_store.c
 *
 * NVS-backed persistence of completed test results.
 */

#include <string.h>
#include <stdio.h>
#include "esp_log.h"
#include "nvs_flash.h"
#include "nvs.h"
#include "result_store.h"

static const char *TAG = "result_store";
static const char *PARTITION = "results";
static const char *NAMESPACE = "tests";
static const char *KEY_HEAD  = "hist_head";
static const char *KEY_COUNT = "hist_count";

static uint32_t s_head;
static uint32_t s_count;
static bool     s_ready;

esp_err_t result_store_init(void)
{
    esp_err_t err = nvs_flash_init_partition(PARTITION);
    if (err == ESP_ERR_NVS_NO_FREE_PAGES || err == ESP_ERR_NVS_NEW_VERSION_FOUND) {
        ESP_LOGW(TAG, "results partition needs erase, reformatting");
        ESP_ERROR_CHECK(nvs_flash_erase_partition(PARTITION));
        err = nvs_flash_init_partition(PARTITION);
    }
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "results partition init failed: %s", esp_err_to_name(err));
        return err;
    }

    nvs_handle_t h;
    err = nvs_open_from_partition(PARTITION, NAMESPACE, NVS_READONLY, &h);
    if (err == ESP_OK) {
        if (nvs_get_u32(h, KEY_HEAD, &s_head) != ESP_OK)   s_head = 0;
        if (nvs_get_u32(h, KEY_COUNT, &s_count) != ESP_OK) s_count = 0;
        nvs_close(h);
    }

    s_ready = true;
    ESP_LOGI(TAG, "result store ready (%u historical entries)", (unsigned)s_count);
    return ESP_OK;
}

static void hist_key(uint32_t index, char *buf, size_t len)
{
    snprintf(buf, len, "h%lu", (unsigned long)index);
}

static void latest_key(uint8_t slot, char *buf, size_t len)
{
    snprintf(buf, len, "s%u", (unsigned)slot);
}

esp_err_t result_store_save(uint8_t slot, const slot_result_t *result)
{
    if (!s_ready || slot >= SLOT_COUNT || result == NULL) {
        return ESP_ERR_INVALID_ARG;
    }

    nvs_handle_t h;
    esp_err_t err = nvs_open_from_partition(PARTITION, NAMESPACE, NVS_READWRITE, &h);
    if (err != ESP_OK) {
        return err;
    }

    char key[16];

    latest_key(slot, key, sizeof(key));
    err = nvs_set_blob(h, key, result, sizeof(*result));
    if (err != ESP_OK) {
        goto out;
    }

    /* Append to the ring. */
    hist_key(s_head, key, sizeof(key));
    err = nvs_set_blob(h, key, result, sizeof(*result));
    if (err != ESP_OK) {
        goto out;
    }

    s_head = (s_head + 1) % RESULT_HISTORY_DEPTH;
    if (s_count < RESULT_HISTORY_DEPTH) {
        s_count++;
    }
    nvs_set_u32(h, KEY_HEAD, s_head);
    nvs_set_u32(h, KEY_COUNT, s_count);

    err = nvs_commit(h);

out:
    nvs_close(h);
    if (err == ESP_OK) {
        ESP_LOGI(TAG, "slot %u result saved: %.1f mAh %.1f mWh serial=%s",
                 slot, result->discharge_mah, result->discharge_mwh,
                 result->serial[0] ? result->serial : "(none)");
    } else {
        ESP_LOGE(TAG, "slot %u result save failed: %s", slot, esp_err_to_name(err));
    }
    return err;
}

esp_err_t result_store_load_latest(uint8_t slot, slot_result_t *out)
{
    if (!s_ready || slot >= SLOT_COUNT || out == NULL) {
        return ESP_ERR_INVALID_ARG;
    }

    nvs_handle_t h;
    esp_err_t err = nvs_open_from_partition(PARTITION, NAMESPACE, NVS_READONLY, &h);
    if (err != ESP_OK) {
        return err;
    }

    char key[16];
    latest_key(slot, key, sizeof(key));
    size_t len = sizeof(*out);
    err = nvs_get_blob(h, key, out, &len);
    nvs_close(h);

    if (err == ESP_OK && len != sizeof(*out)) {
        /* Layout changed across a firmware update; treat as absent. */
        return ESP_ERR_INVALID_SIZE;
    }
    return err;
}

size_t result_store_history_count(void)
{
    return s_count;
}

esp_err_t result_store_history_at(size_t index, slot_result_t *out)
{
    if (!s_ready || out == NULL) {
        return ESP_ERR_INVALID_ARG;
    }
    if (index >= s_count) {
        return ESP_ERR_NOT_FOUND;
    }

    /* index 0 is the most recent, which sits just behind the head. */
    uint32_t slot_index = (s_head + RESULT_HISTORY_DEPTH - 1 - (uint32_t)index)
                          % RESULT_HISTORY_DEPTH;

    nvs_handle_t h;
    esp_err_t err = nvs_open_from_partition(PARTITION, NAMESPACE, NVS_READONLY, &h);
    if (err != ESP_OK) {
        return err;
    }

    char key[16];
    hist_key(slot_index, key, sizeof(key));
    size_t len = sizeof(*out);
    err = nvs_get_blob(h, key, out, &len);
    nvs_close(h);

    if (err == ESP_OK && len != sizeof(*out)) {
        return ESP_ERR_INVALID_SIZE;
    }
    return err;
}

esp_err_t result_store_clear(void)
{
    nvs_handle_t h;
    esp_err_t err = nvs_open_from_partition(PARTITION, NAMESPACE, NVS_READWRITE, &h);
    if (err != ESP_OK) {
        return err;
    }
    err = nvs_erase_all(h);
    if (err == ESP_OK) {
        err = nvs_commit(h);
    }
    nvs_close(h);

    s_head = 0;
    s_count = 0;
    return err;
}
