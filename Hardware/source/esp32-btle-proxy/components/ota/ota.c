/*
 * ota.c
 *
 * See ota.h for the trial-boot contract and the limits of the OTA key.
 */

#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_log.h"
#include "esp_system.h"
#include "esp_timer.h"
#include "esp_ota_ops.h"
#include "esp_app_desc.h"
#include "esp_app_format.h"
#include "esp_partition.h"
#include "nvs.h"

#include "ota.h"
#include "bts_link.h"

static const char *TAG = "ota";
static const char *NVS_NAMESPACE = "ota";
static const char *NVS_KEY       = "key";

/*
 * How long a new image waits for the BTS link before confirming itself on
 * the weaker evidence. Generous on purpose: the C2000 can be mid-boot, or
 * the rack can be off while the proxy runs on its backup cell, and neither
 * is a reason to roll back an image that is otherwise healthy.
 */
#define OTA_CONFIRM_GRACE_S     180

#define CONFIRM_POLL_MS         1000
#define CONFIRM_TASK_STACK      3072
#define CONFIRM_TASK_PRIO       3

/* Enough of the image to hold the header, segment header and app descriptor. */
#define HEADER_BYTES    (sizeof(esp_image_header_t) + \
                         sizeof(esp_image_segment_header_t) + \
                         sizeof(esp_app_desc_t))

static esp_ota_handle_t       s_handle;
static const esp_partition_t *s_target;
static bool                   s_in_progress;
static bool                   s_header_checked;
static uint8_t                s_header[HEADER_BYTES];
static size_t                 s_header_len;
static size_t                 s_written;
static bool                   s_confirmed;

/* ------------------------------------------------------------------ */
/* The trial boot                                                     */
/* ------------------------------------------------------------------ */

static bool running_is_pending_verify(void)
{
    const esp_partition_t *running = esp_ota_get_running_partition();
    esp_ota_img_states_t   state;

    if (running == NULL ||
        esp_ota_get_state_partition(running, &state) != ESP_OK) {
        return false;
    }
    return state == ESP_OTA_IMG_PENDING_VERIFY;
}

static void confirm_task(void *arg)
{
    (void)arg;

    const int64_t deadline =
        esp_timer_get_time() + ((int64_t)OTA_CONFIRM_GRACE_S * 1000000LL);

    ESP_LOGW(TAG, "this image is on trial - confirming once the BTS link is "
                  "up, or after %d s regardless", OTA_CONFIRM_GRACE_S);

    for (;;) {
        bts_snapshot_t snap;
        bts_link_get_snapshot(&snap);

        if (snap.unit.online) {
            if (esp_ota_mark_app_valid_cancel_rollback() == ESP_OK) {
                s_confirmed = true;
                ESP_LOGI(TAG, "image confirmed: BTS link up, registers "
                              "answering");
            } else {
                ESP_LOGE(TAG, "could not mark the image valid; it will roll "
                              "back on the next reboot");
            }
            break;
        }

        if (esp_timer_get_time() >= deadline) {
            /*
             * Weaker evidence, and said so plainly in the log: the image
             * booted, brought up its tasks and ran for the grace period, but
             * never reached the BTS. Confirmed anyway, because the
             * alternative is rolling back a good image every time the rack
             * is powered down - and a confirmed image that cannot talk to
             * the unit is still reachable to be replaced by another OTA.
             */
            if (esp_ota_mark_app_valid_cancel_rollback() == ESP_OK) {
                s_confirmed = true;
                ESP_LOGW(TAG, "image confirmed WITHOUT a BTS link after %d s "
                              "- check the unit is powered and the I2C wiring",
                         OTA_CONFIRM_GRACE_S);
            } else {
                ESP_LOGE(TAG, "could not mark the image valid; it will roll "
                              "back on the next reboot");
            }
            break;
        }

        vTaskDelay(pdMS_TO_TICKS(CONFIRM_POLL_MS));
    }

    vTaskDelete(NULL);
}

esp_err_t ota_init(void)
{
    if (!running_is_pending_verify()) {
        /*
         * Either rollback is compiled out, or this image was confirmed on an
         * earlier boot, or it is the factory-flashed one. Nothing to do -
         * and nothing to log, since this is every normal boot.
         */
        s_confirmed = true;
        return ESP_OK;
    }

    const BaseType_t ok = xTaskCreate(confirm_task, "ota_confirm",
                                      CONFIRM_TASK_STACK, NULL,
                                      CONFIRM_TASK_PRIO, NULL);
    return (ok == pdPASS) ? ESP_OK : ESP_ERR_NO_MEM;
}

/* ------------------------------------------------------------------ */
/* The key                                                            */
/* ------------------------------------------------------------------ */

static bool key_load(char *out, size_t out_len)
{
    nvs_handle_t h;
    if (nvs_open(NVS_NAMESPACE, NVS_READONLY, &h) != ESP_OK) {
        return false;
    }
    size_t n = out_len;
    const esp_err_t err = nvs_get_str(h, NVS_KEY, out, &n);
    nvs_close(h);
    return err == ESP_OK && out[0] != '\0';
}

bool ota_key_is_set(void)
{
    char key[OTA_KEY_MAX];
    return key_load(key, sizeof(key));
}

/*
 * Compares without branching on the data.
 *
 * A plain strcmp returns as soon as two bytes differ, so the time it takes
 * leaks how much of a guess was right, one byte at a time. The accumulator
 * form looks at every byte either way. Lengths are compared first, which
 * does leak the length - acceptable, and unavoidable without padding.
 */
static bool constant_time_equal(const char *a, const char *b)
{
    const size_t la = strlen(a);
    const size_t lb = strlen(b);
    if (la != lb) {
        return false;
    }
    uint8_t diff = 0;
    for (size_t i = 0; i < la; i++) {
        diff |= (uint8_t)a[i] ^ (uint8_t)b[i];
    }
    return diff == 0;
}

bool ota_key_check(const char *presented)
{
    char key[OTA_KEY_MAX];

    if (presented == NULL || !key_load(key, sizeof(key))) {
        return false;   /* no key stored => OTA refused outright */
    }
    return constant_time_equal(key, presented);
}

esp_err_t ota_key_set(const char *current, const char *next)
{
    char stored[OTA_KEY_MAX];

    if (key_load(stored, sizeof(stored))) {
        if (current == NULL || !constant_time_equal(stored, current)) {
            return ESP_ERR_INVALID_STATE;
        }
    }
    if (next == NULL) {
        return ESP_ERR_INVALID_ARG;
    }
    if (strlen(next) >= OTA_KEY_MAX) {
        return ESP_ERR_INVALID_SIZE;
    }

    nvs_handle_t h;
    esp_err_t err = nvs_open(NVS_NAMESPACE, NVS_READWRITE, &h);
    if (err != ESP_OK) {
        return err;
    }
    if (next[0] == '\0') {
        err = nvs_erase_key(h, NVS_KEY);
        if (err == ESP_ERR_NVS_NOT_FOUND) {
            err = ESP_OK;
        }
    } else {
        err = nvs_set_str(h, NVS_KEY, next);
    }
    if (err == ESP_OK) {
        err = nvs_commit(h);
    }
    nvs_close(h);

    if (err == ESP_OK) {
        ESP_LOGW(TAG, "OTA key %s", next[0] ? "changed" : "cleared (OTA now refused)");
    }
    return err;
}

/* ------------------------------------------------------------------ */
/* Streaming an image                                                 */
/* ------------------------------------------------------------------ */

/*
 * Checks the start of the image before any more of it is accepted.
 *
 * esp_ota_end() verifies the image's own hash, but only after the whole
 * thing has been written. These four fields are readable from the first
 * block and catch the mistakes that actually happen at a bench - a
 * bootloader or partition-table binary posted instead of the app, an image
 * for a different chip, or the wrong project's firmware - before a megabyte
 * has gone over the air and over the flash.
 */
static esp_err_t check_header(const uint8_t *buf, size_t len)
{
    if (len < HEADER_BYTES) {
        return ESP_ERR_INVALID_SIZE;
    }

    const esp_image_header_t *img = (const esp_image_header_t *)buf;
    if (img->magic != ESP_IMAGE_HEADER_MAGIC) {
        ESP_LOGE(TAG, "not an application image (magic 0x%02x)", img->magic);
        return OTA_ERR_BAD_IMAGE;
    }
    if (img->chip_id != CONFIG_IDF_FIRMWARE_CHIP_ID) {
        ESP_LOGE(TAG, "image is for chip id 0x%04x, this is 0x%04x",
                 (unsigned)img->chip_id, (unsigned)CONFIG_IDF_FIRMWARE_CHIP_ID);
        return OTA_ERR_BAD_IMAGE;
    }

    const esp_app_desc_t *desc =
        (const esp_app_desc_t *)(buf + sizeof(esp_image_header_t) +
                                 sizeof(esp_image_segment_header_t));
    if (desc->magic_word != ESP_APP_DESC_MAGIC_WORD) {
        ESP_LOGE(TAG, "no application descriptor in the image");
        return OTA_ERR_BAD_IMAGE;
    }

    const esp_app_desc_t *running = esp_app_get_description();
    if (running != NULL &&
        strncmp(desc->project_name, running->project_name,
                sizeof(desc->project_name)) != 0) {
        /*
         * Refused rather than warned about. Flashing another ESP-IDF project
         * onto this board would come up without the BTS link, fail to
         * confirm, and roll back - but only after taking the tester off the
         * network for two reboots and a three-minute grace period.
         */
        ESP_LOGE(TAG, "image is '%.32s', this firmware is '%.32s'",
                 desc->project_name, running->project_name);
        return OTA_ERR_BAD_IMAGE;
    }

    ESP_LOGI(TAG, "incoming image: %.32s %.32s (%.16s %.16s), IDF %.32s",
             desc->project_name, desc->version, desc->date, desc->time,
             desc->idf_ver);
    return ESP_OK;
}

esp_err_t ota_begin(size_t image_size)
{
    if (s_in_progress) {
        return ESP_ERR_INVALID_STATE;
    }

    s_target = esp_ota_get_next_update_partition(NULL);
    if (s_target == NULL) {
        ESP_LOGE(TAG, "no OTA partition available");
        return ESP_ERR_NOT_FOUND;
    }
    if (image_size != 0 && image_size > s_target->size) {
        ESP_LOGE(TAG, "image is %u bytes, partition %s holds %u",
                 (unsigned)image_size, s_target->label,
                 (unsigned)s_target->size);
        return ESP_ERR_INVALID_SIZE;
    }

    /*
     * OTA_WITH_SEQUENTIAL_WRITES erases as it goes rather than erasing the
     * whole partition up front. The upload is being streamed in order
     * anyway, and a single erase of 1.9 MB takes long enough that the
     * client's socket can time out before the first byte is written.
     */
    const esp_err_t err = esp_ota_begin(s_target,
                                        image_size ? image_size
                                                   : OTA_WITH_SEQUENTIAL_WRITES,
                                        &s_handle);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "esp_ota_begin: %s", esp_err_to_name(err));
        return err;
    }

    s_in_progress    = true;
    s_header_checked = false;
    s_header_len     = 0;
    s_written        = 0;
    ESP_LOGI(TAG, "receiving %u bytes into %s",
             (unsigned)image_size, s_target->label);
    return ESP_OK;
}

esp_err_t ota_write(const void *data, size_t len)
{
    if (!s_in_progress) {
        return ESP_ERR_INVALID_STATE;
    }
    if (len == 0) {
        return ESP_OK;
    }

    /*
     * The header can be split across chunks - a socket read is not obliged
     * to hand over the first 288 bytes in one piece - so it is accumulated
     * until there is enough to check. Writing continues meanwhile: esp_ota
     * wants the stream in order, and holding bytes back to validate first
     * would mean buffering them twice.
     */
    if (!s_header_checked) {
        const size_t want = HEADER_BYTES - s_header_len;
        const size_t take = (len < want) ? len : want;
        memcpy(s_header + s_header_len, data, take);
        s_header_len += take;

        if (s_header_len == HEADER_BYTES) {
            const esp_err_t err = check_header(s_header, s_header_len);
            if (err != ESP_OK) {
                return err;
            }
            s_header_checked = true;
        }
    }

    const esp_err_t err = esp_ota_write(s_handle, data, len);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "esp_ota_write at %u: %s",
                 (unsigned)s_written, esp_err_to_name(err));
        return err;
    }
    s_written += len;
    return ESP_OK;
}

esp_err_t ota_finish(void)
{
    if (!s_in_progress) {
        return ESP_ERR_INVALID_STATE;
    }
    s_in_progress = false;

    if (!s_header_checked) {
        /* Fewer than 288 bytes arrived: not an image at all. */
        esp_ota_abort(s_handle);
        ESP_LOGE(TAG, "image too short (%u bytes)", (unsigned)s_written);
        return OTA_ERR_BAD_IMAGE;
    }

    esp_err_t err = esp_ota_end(s_handle);
    if (err != ESP_OK) {
        /* esp_ota_end already released the handle on every failure path. */
        ESP_LOGE(TAG, "esp_ota_end: %s", esp_err_to_name(err));
        return err;
    }

    err = esp_ota_set_boot_partition(s_target);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "esp_ota_set_boot_partition: %s", esp_err_to_name(err));
        return err;
    }

    ESP_LOGW(TAG, "%u bytes written to %s; it boots next and must confirm "
                  "itself or roll back",
             (unsigned)s_written, s_target->label);
    return ESP_OK;
}

void ota_abort(void)
{
    if (!s_in_progress) {
        return;
    }
    s_in_progress = false;
    esp_ota_abort(s_handle);
    ESP_LOGW(TAG, "update aborted after %u bytes", (unsigned)s_written);
}

/* ------------------------------------------------------------------ */
/* Status and restart                                                 */
/* ------------------------------------------------------------------ */

void ota_get_status(ota_status_t *out)
{
    if (out == NULL) {
        return;
    }
    memset(out, 0, sizeof(*out));

    const esp_partition_t *running = esp_ota_get_running_partition();
    const esp_partition_t *next    = esp_ota_get_next_update_partition(NULL);
    out->running_label = (running != NULL) ? running->label : "?";
    out->next_label    = (next != NULL) ? next->label : "?";

    const esp_app_desc_t *desc = esp_app_get_description();
    if (desc != NULL) {
        memcpy(out->version, desc->version, sizeof(out->version));
        memcpy(out->date, desc->date, sizeof(out->date));
        memcpy(out->time, desc->time, sizeof(out->time));
        memcpy(out->idf_ver, desc->idf_ver, sizeof(out->idf_ver));
        out->version[sizeof(out->version) - 1] = '\0';
        out->date[sizeof(out->date) - 1]       = '\0';
        out->time[sizeof(out->time) - 1]       = '\0';
        out->idf_ver[sizeof(out->idf_ver) - 1] = '\0';
    }
    esp_app_get_elf_sha256(out->elf_sha, sizeof(out->elf_sha));

    out->pending_verify     = running_is_pending_verify();
    out->confirmed          = s_confirmed;
    out->rollback_possible  = esp_ota_check_rollback_is_possible();
    out->key_set            = ota_key_is_set();
    out->in_progress        = s_in_progress;
    out->uptime_s           = (uint32_t)(esp_timer_get_time() / 1000000);
}

static void restart_task(void *arg)
{
    const uint32_t delay_ms = (uint32_t)(uintptr_t)arg;
    vTaskDelay(pdMS_TO_TICKS(delay_ms));
    ESP_LOGW(TAG, "restarting");
    esp_restart();
}

void ota_schedule_restart(uint32_t delay_ms)
{
    if (xTaskCreate(restart_task, "ota_restart", 2048,
                    (void *)(uintptr_t)delay_ms, CONFIRM_TASK_PRIO,
                    NULL) != pdPASS) {
        /* No task: restart now and lose the response rather than not at all. */
        esp_restart();
    }
}

_Static_assert(OTA_ERR_BAD_IMAGE == ESP_ERR_OTA_VALIDATE_FAILED,
               "OTA_ERR_BAD_IMAGE must track ESP_ERR_OTA_VALIDATE_FAILED");
