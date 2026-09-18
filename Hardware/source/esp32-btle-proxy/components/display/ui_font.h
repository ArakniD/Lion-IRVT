/*
 * ui_font.h
 *
 * 5x7 bitmap font in a 6x8 cell, covering printable ASCII 0x20-0x7E.
 *
 * Each glyph is five bytes, one per column, bit 0 at the top. The sixth
 * column of the cell is the inter-character gap and is not stored.
 *
 * Rendering is into a caller-supplied RGB565 band buffer rather than
 * straight to the panel: the ESP32 has nowhere near enough DRAM for a
 * 240x240x16bpp framebuffer (115 kB against ~89 kB free after BLE and WiFi
 * are up), so the UI is drawn one row-band at a time.
 */

#ifndef UI_FONT_H
#define UI_FONT_H

#include <stdint.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

#define FONT_W          5
#define FONT_H          7
#define FONT_CELL_W     6
#define FONT_CELL_H     8

/* Returns the five column bytes for `c`, or the blank glyph if unmapped. */
const uint8_t *ui_font_glyph(char c);

/* Width in pixels of `s` rendered at `scale`. */
static inline int ui_text_width(const char *s, int scale)
{
    int n = 0;
    for (const char *p = s; *p; p++) {
        n++;
    }
    return n * FONT_CELL_W * scale;
}

#ifdef __cplusplus
}
#endif

#endif /* UI_FONT_H */
