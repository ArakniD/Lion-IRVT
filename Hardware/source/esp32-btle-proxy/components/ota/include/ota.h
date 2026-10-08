/*
 * ota.h
 *
 * Over-the-air firmware update for the proxy, over WiFi.
 *
 * The flash has carried two app slots since the partition table was written;
 * this is the code that uses them. An image is streamed into whichever slot
 * is not running, the boot partition is switched, and the device restarts.
 *
 * THE TRIAL BOOT
 * --------------
 * With CONFIG_BOOTLOADER_APP_ROLLBACK_ENABLE the bootloader marks a newly
 * written image PENDING_VERIFY on its first boot. If the device reboots
 * again while it is still in that state, the bootloader gives up on it and
 * goes back to the slot that worked. So a new image has to say it is alive,
 * and what counts as alive here is the thing this box exists to do:
 *
 *   ota_init() starts a task that confirms the image once the BTS link is
 *   up - a real register poll answered over I2C, not merely "it booted".
 *
 * That catches an image whose I2C, pin mapping or poll task is broken, which
 * a bare "did it boot" check would happily confirm.
 *
 * It cannot be the only rule. The proxy has a backup cell and routinely runs
 * with the BTS powered down, where waiting for the link forever would mean a
 * perfectly good image is rolled back by the next power blip. So after
 * OTA_CONFIRM_GRACE_S with no link the image is confirmed anyway - the
 * weaker evidence, taken only once the stronger one has had its chance, and
 * logged as such. An image that got that far is still serving HTTP, so it
 * can always be replaced by another OTA.
 *
 * AUTHENTICATION, AND ITS LIMIT
 * -----------------------------
 * An unauthenticated firmware upload is remote code execution on anything
 * that can reach port 80, so this endpoint - alone in the API - takes a key,
 * presented in `X-OTA-Key`. Until a key is set, OTA is refused outright
 * rather than left open.
 *
 * The key is set through the same unauthenticated API (trust on first use):
 * the first set needs nothing, and every later change needs the current key.
 * **So this protects a unit that was provisioned before an attacker reached
 * it, and not one provisioned afterwards.** It is a guard against accidents
 * and against casual access to a bench LAN, not a security boundary. The
 * rest of the API has no authentication at all; if that matters for your
 * network, the answer is the network, not this key.
 */

#ifndef OTA_H
#define OTA_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include "esp_err.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Longest key accepted, including the terminator. */
#define OTA_KEY_MAX     65

/*
 * Returned by ota_write() and ota_finish() for an image this device will not
 * run - wrong chip, wrong project, not an app at all, or a failed hash.
 * Distinct from every other failure so a caller can tell "you sent the wrong
 * file" (the client's fault, 400) from "the flash write failed" (ours, 500).
 *
 * Same value as ESP_ERR_OTA_VALIDATE_FAILED, which is what is actually
 * returned; restated here so callers need not depend on app_update.
 */
#define OTA_ERR_BAD_IMAGE   (0x1500 + 0x03)

typedef struct {
    const char *running_label;   /* partition the running image came from   */
    const char *next_label;      /* partition an upload would be written to */
    char        version[32];     /* running image's version string          */
    char        date[16];
    char        time[16];
    char        idf_ver[32];
    bool        pending_verify;  /* on trial, not yet confirmed             */
    bool        confirmed;       /* this boot's image is marked VALID       */
    bool        rollback_possible;
    bool        key_set;
    bool        in_progress;
    uint32_t    uptime_s;
} ota_status_t;

/*
 * Starts the confirm task. Call after bts_link_init(), since the task reads
 * the link snapshot. Cheap and non-blocking: on an image that is not on
 * trial the task exits immediately.
 */
esp_err_t ota_init(void);

void ota_get_status(ota_status_t *out);

/* True when a key is stored, which is also the only state that allows OTA. */
bool ota_key_is_set(void);

/*
 * Constant-time compare against the stored key. False when none is stored,
 * so a unit without a key refuses every upload.
 */
bool ota_key_check(const char *presented);

/*
 * Sets or changes the key. `current` is ignored when none is stored (trust
 * on first use) and must match otherwise. An empty `next` clears the key and
 * so disables OTA.
 *
 * Returns ESP_ERR_INVALID_STATE when `current` does not match.
 */
esp_err_t ota_key_set(const char *current, const char *next);

/*
 * Streaming write of one image. begin -> write* -> finish, with abort on any
 * failure. Only one may be in flight; a second begin returns
 * ESP_ERR_INVALID_STATE.
 *
 * ota_write() validates the image header on the first call and refuses an
 * image that is not this project's, built for this chip.
 */
esp_err_t ota_begin(size_t image_size);
esp_err_t ota_write(const void *data, size_t len);
esp_err_t ota_finish(void);
void      ota_abort(void);

/* Restarts the device after `delay_ms`, so an HTTP response can be flushed. */
void ota_schedule_restart(uint32_t delay_ms);

#ifdef __cplusplus
}
#endif

#endif /* OTA_H */
