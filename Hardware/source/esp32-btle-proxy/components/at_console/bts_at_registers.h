/*
 * bts_at_registers.h - register name table for the AT console.
 *
 * The table itself is GENERATED from the C2000's uartRegConfig[] by
 * tools/gen_at_registers.py. See the banner in the generated .c for why.
 */

#ifndef BTS_AT_REGISTERS_H
#define BTS_AT_REGISTERS_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/*
 * One register as the AT console sees it.
 *
 * Both names are accepted, exactly as the C2000 console accepts either: the
 * short form is what an operator types (C0VOLT), the long form is what a
 * script emits (Ch0_CellVoltage). Comparison is case sensitive on both,
 * matching strcmp() in the firmware.
 */
typedef struct {
    const char *short_name;
    const char *long_name;
    uint16_t    address;    /* byte address, not register index */
    bool        read_only;  /* REG_ACCESS_RO in the firmware table */
} bts_at_register_t;

extern const bts_at_register_t BTS_AT_REGISTERS[];
extern const size_t BTS_AT_REGISTER_COUNT;

/*
 * Resolve a name to its table entry, or NULL if there is no such register.
 * Tries the short name first, then the long, like the firmware's loop.
 */
const bts_at_register_t *bts_at_register_find(const char *name);

#ifdef __cplusplus
}
#endif

#endif /* BTS_AT_REGISTERS_H */
