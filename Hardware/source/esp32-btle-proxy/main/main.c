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
#include "at_console.h"
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
#include "led_strip.h"
#include "ota.h"

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
 *
 * CS is a real GPIO: this module has no tie to ground. GPIO19 has no strapping
 * role, and an external 10k pull-up to 3V3 holds the panel deselected from
 * reset until the driver takes the pin.
 */
#define LCD_MOSI_GPIO       23
#define LCD_SCLK_GPIO       18
#define LCD_CS_GPIO         19
#define LCD_RESET_GPIO      17
#define LCD_DC_GPIO         16
#define LCD_BACKLIGHT_GPIO  4

/*
 * Rotary encoder with push switch, and the extra KEY0 button. None of these
 * is a strapping or JTAG pin; see input.h.
 *
 * A and the switch were on GPIO15 and GPIO2, both strapping pins, and moved
 * to GPIO32 and GPIO33. B moved off GPIO13 earlier, when the WS2812B driver
 * took that pin for SPI3 MOSI. GPIO14 was not used for B: it is MTMS, and a
 * JTAG pin on the encoder would make the box awkward to debug over JTAG later.
 *
 * KEY0 is on GPIO34, which is input only with no internal pull. The LCD board
 * pulls KEY0 up to 3V3, so it needs none.
 */
#define ENC_A_GPIO          32
#define ENC_B_GPIO          27
#define ENC_SW_GPIO         33
#define KEY0_GPIO           34

/*
 * WS2812B slot indicators, one per slot, on SPI3 (VSPI) MOSI.
 *
 * SPI3 and not SPI2: the ST7789 above holds SPI2 (HSPI), despite sitting on
 * the GPIO23/18 pads that are VSPI's IO_MUX defaults - it reaches them
 * through the GPIO matrix. Sharing one host would let an LED frame stall a
 * panel repaint and vice versa.
 *
 * See led_strip.h for the bitstream encoding and for why this is on the
 * ESP32 at all rather than on the C2000 that owns the slots.
 */
#define LED_DATA_GPIO       13

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

    /*
     * Straight after the link, and before anything that could fail: if this
     * image arrived over the air it is on trial, and ota_init() starts the
     * task that confirms it once the BTS answers. On an image that is not on
     * trial - every USB-flashed one - this returns immediately.
     */
    err = ota_init();
    if (err != ESP_OK) {
        /*
         * Not fatal, but it does mean an OTA-delivered image will roll back
         * on its next reboot, so it is logged loudly rather than ignored.
         */
        ESP_LOGE(TAG, "OTA confirm task did not start: %s - an updated image "
                      "will roll back", esp_err_to_name(err));
    }

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
        .cs_gpio        = LCD_CS_GPIO,
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
        .key0_gpio         = KEY0_GPIO, /* to GND, board pull-up to 3V3    */
        .long_press_ms     = 800,
        .invert_direction  = false,
        .trace             = true,
    };
    err = input_init(&enc_cfg);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "encoder unavailable: %s", esp_err_to_name(err));
    }

    const led_strip_config_t led_cfg = {
        .data_gpio  = LED_DATA_GPIO,
        /*
         * 25 ms: fast enough that the 125 ms half-period of the quickest
         * flash (reverse polarity) still gets five frames, and slow enough
         * that the strip costs well under a percent of one core.
         */
        .refresh_ms = 25,
        /*
         * These sit in an operator's eyeline on a bench. Full brightness on
         * eight WS2812Bs is both hard to look at and 480 mA if every pixel
         * ever went white at once.
         */
        .brightness = 64,
    };
    err = led_strip_init(&led_cfg);
    if (err != ESP_OK) {
        /* Dark indicators; BLE, HTTP and the AT console are unaffected. */
        ESP_LOGE(TAG, "LED strip unavailable: %s", esp_err_to_name(err));
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

    /*
     * The AT console goes LAST, and the ordering is load bearing: starting it
     * silences ESP_LOG on UART0, so everything above still reports its own
     * failures to a console that is watching. Bring it up first and a WiFi or
     * BLE error would vanish.
     *
     * It takes the port because it has to. An AT dialogue and a log stream
     * cannot share a UART - log lines would interleave with responses and
     * break any parser expecting a clean "+NAME=value\r\nOK\r\n". Losing
     * the serial log was accepted deliberately; logs are still reachable over
     * the network interfaces.
     *
     * Not fatal, for the same reason the web API is not: a tester with no AT
     * console is still a usable tester over BLE and HTTP.
     */
    err = at_console_start();
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "AT console unavailable: %s", esp_err_to_name(err));
    }
}
