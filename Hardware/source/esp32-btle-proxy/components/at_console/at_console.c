/*
 * at_console.c - AT command interface over UART0.
 *
 * The grammar is transcribed from the C2000's own console in com_cpu2.c so
 * the two are interchangeable. See at_console.h for why this exists.
 *
 * GRAMMAR (matching the unit exactly)
 * -----------------------------------
 *   AT+<name>?            read  -> "+<name>=<value>" then "OK"
 *   AT+<name>=<value>     write -> "OK"
 *   AT+C<n>PAUSE          pause slot n (0-7) -> "OK"
 *   AT+C<n>RESUME         resume slot n      -> "OK"
 *
 * Every response line ends "\r\n". Errors are a single line beginning
 * "ERROR: ", with the same four texts the unit emits:
 *
 *   ERROR: Invalid register     - no register by that name
 *   ERROR: Read-only register   - write attempted on an RO register
 *   ERROR: Invalid command      - AT+<name> with neither ? nor =
 *   ERROR: Invalid SFRA command  (unit only, see below)
 *
 * Values are formatted to two decimal places, as the unit does. The unit
 * renders them from a scaled int32 because its build forbids doubles; the
 * ESP32 has no such constraint, but the FORMAT must match or a parser written
 * against one console mis-reads the other.
 *
 * A bare "AT" is ignored, deliberately, exactly as the unit ignores it: the
 * firmware tests strncmp(buf, "AT+", 3) and silently drops anything else, so
 * an operator probing with a bare AT gets no reply from either console. Probe
 * with "AT+InputVoltage?" instead.
 *
 * DIFFERENCES FROM THE UNIT'S CONSOLE, and why
 * --------------------------------------------
 *   AT+SFRA_CAL is NOT implemented. It calls SFRA_startCalibration() inside
 *   the firmware and has no register representation, so a proxy that reaches
 *   the unit only over I2C cannot perform it. It reports "ERROR: Invalid
 *   register" here rather than pretending to succeed.
 *
 *   Reads come from the live unit over I2C, so a read can fail in ways the
 *   unit's own console cannot. A transport failure reports
 *   "ERROR: Link failure" rather than a stale or fabricated value.
 */

#include "at_console.h"

#include <stdbool.h>
#include <stdio.h>
#include <string.h>

#include "bts_at_registers.h"
#include "bts_link.h"
#include "driver/uart.h"
#include "esp_log.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#define AT_UART_NUM         UART_NUM_0
#define AT_UART_BAUD        115200

/*
 * The unit's console buffer is 64 bytes (UART_BUFFER_SIZE in com_cpu2.c) and
 * it silently drops anything past that. Matched here so a command that is too
 * long behaves the same way on both consoles rather than working on one.
 */
#define AT_LINE_MAX         64

#define AT_RX_BUFFER        512
#define AT_TASK_STACK       4096
#define AT_TASK_PRIORITY    5

static const char *TAG = "at_console";

static bool s_active = false;

/*
 * Swallow every log line once the console owns the port.
 *
 * esp_log_set_vprintf() is the whole mechanism: ESP_LOG* calls still run and
 * still cost their arguments, but the output goes nowhere. Setting the level
 * to NONE as well means most call sites return before formatting, which is
 * the cheaper half of the job.
 */
static int at_swallow_log(const char *format, va_list args)
{
    (void)format;
    (void)args;
    return 0;
}

static void at_write(const char *text)
{
    uart_write_bytes(AT_UART_NUM, text, strlen(text));
}

/*
 * One response line, CRLF terminated. Mirrors uartSendResponse() on the unit,
 * which appends '\r' then '\n' to every response without exception.
 */
static void at_respond(const char *text)
{
    at_write(text);
    at_write("\r\n");
}

/*
 * "+<name>=<value>" with two decimals, matching formatRegisterValue().
 *
 * The unit builds this from a scaled integer because its compiler forbids
 * double-returning functions; "%.2f" here produces the identical text for
 * every value either console can carry, including the sign placement on
 * negatives ("+C0CURR=-1.50").
 */
static void at_respond_value(const char *name, float value)
{
    char line[64];
    snprintf(line, sizeof(line), "+%s=%.2f", name, value);
    at_respond(line);
}

const bts_at_register_t *bts_at_register_find(const char *name)
{
    for (size_t i = 0; i < BTS_AT_REGISTER_COUNT; i++) {
        if (strcmp(name, BTS_AT_REGISTERS[i].short_name) == 0 ||
            strcmp(name, BTS_AT_REGISTERS[i].long_name) == 0) {
            return &BTS_AT_REGISTERS[i];
        }
    }
    return NULL;
}

/*
 * AT+C<n>PAUSE / AT+C<n>RESUME.
 *
 * Present because an operator should not have to compute a mode bitmask to
 * stop a cell safely - the same reasoning the firmware gives. Returns true if
 * the command was recognised and handled.
 */
static bool at_try_slot_command(const char *name)
{
    if (name[0] != 'C' || name[1] < '0' || name[1] > '7') {
        return false;
    }

    uint8_t slot = (uint8_t)(name[1] - '0');
    esp_err_t err;

    if (strcmp(&name[2], "PAUSE") == 0) {
        err = bts_link_pause_channel(slot);
    } else if (strcmp(&name[2], "RESUME") == 0) {
        err = bts_link_resume_channel(slot);
    } else {
        return false;
    }

    at_respond(err == ESP_OK ? "OK" : "ERROR: Link failure");
    return true;
}

/*
 * Handle one complete line. `line` is NUL terminated and has had its
 * terminator stripped.
 */
static void at_handle_line(char *line)
{
    /*
     * Anything not starting "AT+" is dropped without a reply, including a
     * bare "AT". This is the firmware's behaviour and tooling depends on it.
     */
    if (strncmp(line, "AT+", 3) != 0) {
        return;
    }

    char *cmd = line + 3;
    char *value_str = strchr(cmd, '=');
    char *query = strchr(cmd, '?');

    /* Split the name off, exactly as the firmware does. */
    if (value_str != NULL) {
        *value_str = '\0';
    }
    if (query != NULL) {
        *query = '\0';
    }

    if (value_str == NULL && query == NULL) {
        if (at_try_slot_command(cmd)) {
            return;
        }
        at_respond("ERROR: Invalid command");
        return;
    }

    const bts_at_register_t *reg = bts_at_register_find(cmd);
    if (reg == NULL) {
        at_respond("ERROR: Invalid register");
        return;
    }

    if (value_str != NULL) {
        if (reg->read_only) {
            at_respond("ERROR: Read-only register");
            return;
        }
        float value = strtof(value_str + 1, NULL);
        esp_err_t err = bts_link_write_reg(reg->address, value);
        at_respond(err == ESP_OK ? "OK" : "ERROR: Link failure");
        return;
    }

    /* Query. */
    float value = 0.0f;
    esp_err_t err = bts_link_read_reg(reg->address, &value);
    if (err != ESP_OK) {
        at_respond("ERROR: Link failure");
        return;
    }
    at_respond_value(cmd, value);
    at_respond("OK");
}

static void at_console_task(void *arg)
{
    (void)arg;

    static char line[AT_LINE_MAX];
    size_t len = 0;
    uint8_t ch;

    for (;;) {
        int got = uart_read_bytes(AT_UART_NUM, &ch, 1, portMAX_DELAY);
        if (got != 1) {
            continue;
        }

        if (ch == '\r' || ch == '\n') {
            line[len] = '\0';
            if (len > 0) {
                at_handle_line(line);
            }
            len = 0;
        } else if (len < (AT_LINE_MAX - 1)) {
            line[len++] = (char)ch;
        }
        /*
         * Past the buffer the character is dropped and the line runs on. The
         * unit does the same - an overlong command is truncated rather than
         * split into two, so neither console invents a command that was never
         * typed.
         */
    }
}

bool at_console_is_active(void)
{
    return s_active;
}

esp_err_t at_console_start(void)
{
    if (s_active) {
        return ESP_ERR_INVALID_STATE;
    }

    const uart_config_t cfg = {
        .baud_rate = AT_UART_BAUD,
        .data_bits = UART_DATA_8_BITS,
        .parity    = UART_PARITY_DISABLE,
        .stop_bits = UART_STOP_BITS_1,
        .flow_ctrl = UART_HW_FLOWCTRL_DISABLE,
        .source_clk = UART_SCLK_DEFAULT,
    };

    esp_err_t err = uart_driver_install(AT_UART_NUM, AT_RX_BUFFER, 0, 0, NULL, 0);
    if (err != ESP_OK && err != ESP_ERR_INVALID_STATE) {
        return err;
    }

    err = uart_param_config(AT_UART_NUM, &cfg);
    if (err != ESP_OK) {
        return err;
    }

    /*
     * Log output goes last, so a failure above still leaves the log usable
     * for diagnosing it.
     */
    ESP_LOGI(TAG, "AT console starting on UART%d; log output on this port ends now",
             AT_UART_NUM);

    esp_log_level_set("*", ESP_LOG_NONE);
    esp_log_set_vprintf(at_swallow_log);

    BaseType_t ok = xTaskCreate(at_console_task, "at_console",
                                AT_TASK_STACK, NULL, AT_TASK_PRIORITY, NULL);
    if (ok != pdPASS) {
        return ESP_ERR_NO_MEM;
    }

    s_active = true;
    return ESP_OK;
}
