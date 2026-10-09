/*
 * input.h
 *
 * Rotary encoder with a push switch, plus the separate KEY0 button.
 *
 * WIRING
 * ------
 *   A     GPIO32      quadrature channel A
 *   B     GPIO27      quadrature channel B
 *   SW    GPIO33      push switch to ground, internal pull-up
 *   KEY0  GPIO34      extra button to ground, pulled up on the LCD board
 *
 * A NOTE ON THESE PINS
 * --------------------
 * None of these is a strapping or JTAG pin, so nothing here can change how
 * the chip boots, whatever the encoder or the buttons are doing at reset.
 *
 * A and SW used to be on GPIO15 and GPIO2, both strapping pins: GPIO15 (MTDO)
 * silences the ROM boot log if held low at reset, and GPIO2 must not be high
 * while GPIO0 is low or download mode fails. They moved to GPIO32 and GPIO33
 * to take the encoder out of the boot path altogether. B was on GPIO13 until
 * the WS2812B driver claimed that pin for SPI3 MOSI (see led_strip.h), and
 * went to GPIO27. GPIO14 would also have worked, but it is MTMS: a JTAG pin on
 * the encoder would make the board awkward to debug over JTAG.
 *
 * GPIO34 is input only and has NO internal pull-up or pull-down. That is fine
 * for KEY0, which the LCD board pulls up to 3V3, but it means the driver must
 * not ask for one: the pull configuration is simply ignored on that pad, and
 * a board without the external pull-up would read a floating input.
 *
 * See the pin table in README.md and Docs/esp32-hardware-connections.md.
 *
 * DECODING
 * --------
 * The quadrature pair is decoded by the PCNT peripheral rather than by GPIO
 * interrupts: PCNT has a hardware glitch filter, and mechanical encoders
 * bounce badly enough that an ISR-based decoder miscounts on almost every
 * detent. Most detented encoders emit four edges per detent, so the raw
 * count is divided by INPUT_COUNTS_PER_DETENT.
 *
 * Events are delivered on a queue rather than by callback, so the consumer
 * (the UI task) handles them in its own context and nothing runs in an ISR.
 */

#ifndef INPUT_H
#define INPUT_H

#include <stdbool.h>
#include <stdint.h>
#include "esp_err.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Edges the encoder produces per mechanical detent. */
#define INPUT_COUNTS_PER_DETENT     4

typedef enum {
    INPUT_EVENT_NONE = 0,
    INPUT_EVENT_ROTATE_CW,
    INPUT_EVENT_ROTATE_CCW,
    INPUT_EVENT_PRESS,        /* released before the long-press threshold */
    INPUT_EVENT_LONG_PRESS,   /* fires once, while still held             */
    INPUT_EVENT_KEY0_PRESS,   /* KEY0 pressed; fires on the debounced edge */
} input_event_type_t;

typedef struct {
    input_event_type_t type;
    /* Detents in this event; always 1 for presses. */
    int32_t            steps;
} input_event_t;

typedef struct {
    int      encoder_a_gpio;
    int      encoder_b_gpio;
    int      switch_gpio;
    /* True when the switch shorts to ground and needs an internal pull-up. */
    bool     switch_active_low;
    /*
     * KEY0 button, active low. Negative disables it. There is no internal
     * pull to configure: the intended pin is input only, see above.
     * Note that an omitted designated initialiser is 0, which is GPIO0 and
     * not "disabled" - set this to -1 explicitly if there is no KEY0.
     */
    int      key0_gpio;
    uint32_t long_press_ms;      /* 0 => 800 */
    /* Swap if the encoder counts backwards relative to the UI. */
    bool     invert_direction;
    /* Logs pin levels and the raw PCNT count every 2 s, for bring-up. */
    bool     trace;
} input_config_t;

esp_err_t input_init(const input_config_t *config);

/*
 * Waits up to `timeout_ms` for the next event. Returns false on timeout.
 * Safe from one consumer task; the queue is not fanned out.
 */
bool input_wait_event(input_event_t *out, uint32_t timeout_ms);

/* Current switch state, for a UI that wants to show the hold in progress. */
bool input_switch_is_down(void);

/* Logs A/B/SW/KEY0 levels and the raw PCNT count. See input.c for how to read it. */
void input_log_pin_state(const char *when);

#ifdef __cplusplus
}
#endif

#endif /* INPUT_H */
