/*
 * input.h
 *
 * Rotary encoder with a push switch.
 *
 * WIRING
 * ------
 *   A    GPIO15      quadrature channel A
 *   B    GPIO13      quadrature channel B
 *   SW   GPIO2       push switch to ground, internal pull-up
 *
 * A NOTE ON THESE PINS
 * --------------------
 * All three are ESP32 strapping or JTAG pins, and two of them matter at
 * boot:
 *
 *   GPIO15 (MTDO) is read at reset. Held LOW it silences the ROM bootloader
 *          log; it has an internal pull-up and idles high, so an encoder
 *          detent resting on A-low at power-up only costs the boot banner.
 *   GPIO2  is a strapping pin for download mode: it must NOT be high while
 *          GPIO0 is low. The switch here is to GROUND with a pull-up, so it
 *          reads high when idle - which is fine for a normal boot, but if
 *          you ever enter download mode by hand, do not hold the encoder
 *          button down at the same time.
 *   GPIO13 has no boot role and is unconditionally safe.
 *
 * None of this affects normal running, and the pins are otherwise free on
 * the LOLIN32. See the pin table in README.md.
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

/* Logs A/B/SW levels and the raw PCNT count. See input.c for how to read it. */
void input_log_pin_state(const char *when);

#ifdef __cplusplus
}
#endif

#endif /* INPUT_H */
