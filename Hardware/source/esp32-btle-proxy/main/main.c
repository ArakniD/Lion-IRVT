/*
 * main.c
 *
 * BTS BLE/WiFi proxy for the TIDA-010086 eight-channel battery tester.
 *
 * HARDWARE
 * --------
 * LOLIN32 v1.0.0 (ESP-WROOM-32) with an on-board lithium charger and a
 * backup cell, wired to the BTS unit's I2C communication port. The backup
 * cell is what makes the boot-time stop in test_engine_init() necessary:
 * the proxy can outlive a BTS power cycle, so at startup it has no idea
 * what the unit is doing and must not assume the channels are idle.
 *
 * I2C
 * ---
 * GPIO21/22 are the LOLIN32's default SDA/SCL pins and are free on this
 * board. The BTS is the only target on the bus, at 0x50.
 *
 * INIT ORDER
 * ----------
 * NVS first, because both cell_profiles and result_store read from it.
 * bts_link before test_engine, because the engine stops every channel as
 * its first act. ble_svc and web_api last: both call into the engine.
 */

#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_log.h"
#include "esp_system.h"
#include "esp_chip_info.h"
#include "nvs_flash.h"

#include "bts_link.h"
#include "cell_profiles.h"
#include "test_engine.h"
#include "result_store.h"
#include "ble_svc.h"
#include "web_api.h"
#include "display.h"
#include "input.h"

static const char *TAG = "main";

/* LOLIN32 default I2C pins. */
#define BTS_SDA_GPIO        21
#define BTS_SCL_GPIO        22
#define BTS_I2C_HZ          100000
#define BTS_POLL_MS         250

/*
 * ST7789 status display on SPI2 (HSPI), using the hardware MOSI/SCK pads so
 * the SPI peripheral drives them through the IO_MUX rather than the GPIO
 * matrix. None of these collide with the BTS I2C pins or the console UART.
 */
#define LCD_MOSI_GPIO       23
#define LCD_SCLK_GPIO       18
#define LCD_RESET_GPIO      17
#define LCD_DC_GPIO         16
#define LCD_BACKLIGHT_GPIO  4

/*
 * Rotary encoder with push switch. See input.h for the strapping-pin
 * caveats on GPIO15 and GPIO2 - neither affects normal running.
 */
#define ENC_A_GPIO          15
#define ENC_B_GPIO          13
#define ENC_SW_GPIO         2

#define BLE_DEVICE_NAME     "BTS-Tester"
#define AP_SSID             "BTS-Tester"
/*
 * Open AP. The bench network is the security boundary; a WPA2 key baked
 * into firmware that ships on a tester is not one. Set station credentials
 * with POST /api/wifi to get it onto a real network.
 */
#define AP_PASSWORD         NULL

static void log_boot_banner(void)
{
    esp_chip_info_t chip;
    esp_chip_info(&chip);

    ESP_LOGI(TAG, "BTS proxy starting: %s rev %u, %d core(s), heap %u",
             CONFIG_IDF_TARGET, (unsigned)chip.revision, chip.cores,
             (unsigned)esp_get_free_heap_size());

    if (esp_reset_reason() == ESP_RST_BROWNOUT) {
        /*
         * Worth calling out: on a unit with a backup cell a brownout means
         * the cell is flat or the charger is not keeping up, and every test
         * that was running has been lost.
         */
        ESP_LOGW(TAG, "last reset was a brownout - check the backup battery");
    }
}

void app_main(void)
{
    log_boot_banner();

    esp_err_t err = nvs_flash_init();
    if (err == ESP_ERR_NVS_NO_FREE_PAGES || err == ESP_ERR_NVS_NEW_VERSION_FOUND) {
        ESP_LOGW(TAG, "default NVS needs erase, reformatting");
        ESP_ERROR_CHECK(nvs_flash_erase());
        err = nvs_flash_init();
    }
    ESP_ERROR_CHECK(err);

    /*
     * The I2C driver logs an error per failed transfer. With the BTS absent
     * that is four lines every 250 ms, which buries everything else on the
     * console. bts_link already reports link state at a sane rate, so the
     * driver's own chatter is turned down to ERROR-and-above off.
     */
    esp_log_level_set("i2c.master", ESP_LOG_NONE);
    esp_log_level_set("i2c.common", ESP_LOG_NONE);

    ESP_ERROR_CHECK(cell_profiles_init());
    ESP_ERROR_CHECK(result_store_init());

    const bts_link_config_t bts_cfg = {
        .sda_gpio         = BTS_SDA_GPIO,
        .scl_gpio         = BTS_SCL_GPIO,
        .scl_speed_hz     = BTS_I2C_HZ,
        .poll_interval_ms = BTS_POLL_MS,
    };
    ESP_ERROR_CHECK(bts_link_init(&bts_cfg));

    ESP_ERROR_CHECK(test_engine_init());

    /*
     * The display comes up before BLE and WiFi so that a boot failure in
     * either is visible on the panel rather than only on the console. It is
     * a pure consumer of test_engine and bts_link state, so it needs those
     * two initialised first but nothing after it.
     */
    const display_config_t lcd_cfg = {
        .mosi_gpio      = LCD_MOSI_GPIO,
        .sclk_gpio      = LCD_SCLK_GPIO,
        .reset_gpio     = LCD_RESET_GPIO,
        .dc_gpio        = LCD_DC_GPIO,
        .backlight_gpio = LCD_BACKLIGHT_GPIO,
        .width          = 240,
        .height         = 240,
        .x_offset       = 0,
        .y_offset       = 0,
        .invert_colour  = true,
        /*
         * Mode 2 and a slow clock while the panel is being brought up.
         * Mode 0 is the ST7789 datasheet default, but several breakout
         * boards latch on the opposite edge; the bus is write-only so a
         * mismatch is silent. Once the self-test pattern is confirmed,
         * raise pclk_hz and, if it still works, try mode 0.
         */
        .spi_mode       = 2,
        .pclk_hz        = 10 * 1000 * 1000,
        .self_test      = true,
        .refresh_ms     = 500,
    };
    err = display_init(&lcd_cfg);
    if (err != ESP_OK) {
        /* A tester with no panel is still a working tester over BLE. */
        ESP_LOGE(TAG, "display unavailable: %s", esp_err_to_name(err));
    }

    const input_config_t enc_cfg = {
        .encoder_a_gpio    = ENC_A_GPIO,
        .encoder_b_gpio    = ENC_B_GPIO,
        .switch_gpio       = ENC_SW_GPIO,
        .switch_active_low = true,      /* switch to GND, internal pull-up */
        .long_press_ms     = 800,
        .invert_direction  = false,
        .trace             = true,
    };
    err = input_init(&enc_cfg);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "encoder unavailable: %s", esp_err_to_name(err));
    }

    ESP_ERROR_CHECK(ble_svc_init(BLE_DEVICE_NAME));

    const web_api_config_t web_cfg = {
        .ap_ssid     = AP_SSID,
        .ap_password = AP_PASSWORD,
        .port        = 80,
    };
    /*
     * Not fatal. BLE is the primary operator interface, so a tester with no
     * network is still a usable tester - do not take the whole box down
     * because WiFi did not come up.
     */
    err = web_api_init(&web_cfg);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "web API unavailable: %s (BLE still up)", esp_err_to_name(err));
    }

    ESP_LOGI(TAG, "ready, free heap %u", (unsigned)esp_get_free_heap_size());
}
