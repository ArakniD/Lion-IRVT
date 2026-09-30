#!/usr/bin/env python3
"""Check the ESP32 AT console against the C2000 console it must impersonate.

WHY THIS EXISTS
---------------
Two consoles now answer the same AT grammar: the unit's own, in
com_cpu2.c's uartRxISR(), and the ESP32 proxy's, in
components/at_console/at_console.c. Tooling is written once and pointed at
either, so a divergence between them is a silent incompatibility - a command
that works on the bench fails in the field, or worse, returns a differently
formatted number that a parser misreads.

The register name table is generated (tools/gen_at_registers.py), so the
names cannot drift. What CAN drift is everything around them: the response
strings, the error texts, the buffer length, which registers are writable.
This checks those.

Run from esp32-btle-proxy/:  python3 tools/check_at_parity.py
"""

import io
import os
import re
import sys

C2000 = os.path.join('..', 'tida-010086', 'bts_F2837xD_8ch')
FIRMWARE = os.path.join(C2000, 'com_cpu2.c')
REGISTERS_C = os.path.join(C2000, 'registers.c')
REGISTERS_H = os.path.join(C2000, 'registers.h')
AT_CONSOLE = os.path.join('components', 'at_console', 'at_console.c')
AT_TABLE = os.path.join('components', 'at_console', 'bts_at_registers.c')

failures = []
checks = 0


def check(label, ok, detail=''):
    global checks
    checks += 1
    if ok:
        print('  PASS  %s' % label)
    else:
        print('  FAIL  %s  %s' % (label, detail))
        failures.append(label)


def read(path):
    return io.open(path, encoding='utf-8', errors='replace').read()


def main():
    for p in (FIRMWARE, REGISTERS_C, REGISTERS_H, AT_CONSOLE, AT_TABLE):
        if not os.path.exists(p):
            sys.exit('missing %s - run from esp32-btle-proxy/' % p)

    fw = read(FIRMWARE)
    at = read(AT_CONSOLE)
    table = read(AT_TABLE)

    print('AT console parity: ESP32 vs C2000')
    print()

    # --- error strings must match exactly -----------------------------------
    # A parser keying on these texts breaks if one console reworded them.
    print('error strings')
    for text in ('ERROR: Invalid register',
                 'ERROR: Read-only register',
                 'ERROR: Invalid command'):
        check('%-28s in both' % text,
              text in fw and text in at,
              '(firmware=%s esp32=%s)' % (text in fw, text in at))

    # --- success responses ---------------------------------------------------
    print('response format')
    check('"OK" in both', '"OK"' in fw and '"OK"' in at)
    # The firmware builds "+<name>=<value>" in formatRegisterValue().
    check('value prefix "+%s=" in both',
          '"+%s=%s%ld.%02ld"' in fw and '"+%s=%.2f"' in at,
          'firmware uses a scaled-int form, esp32 uses %.2f - both render two decimals')

    # --- command prefix ------------------------------------------------------
    print('grammar')
    check('both test the "AT+" prefix',
          '"AT+"' in fw and '"AT+"' in at)
    check('both accept PAUSE', '"PAUSE"' in fw and '"PAUSE"' in at)
    check('both accept RESUME', '"RESUME"' in fw and '"RESUME"' in at)

    # --- line buffer ---------------------------------------------------------
    m_fw = re.search(r'#define\s+UART_BUFFER_SIZE\s+(\d+)', fw)
    m_at = re.search(r'#define\s+AT_LINE_MAX\s+(\d+)', at)
    check('line buffer sizes agree',
          m_fw and m_at and int(m_fw.group(1)) == int(m_at.group(1)),
          '(firmware=%s esp32=%s)' % (m_fw.group(1) if m_fw else '?',
                                      m_at.group(1) if m_at else '?'))

    # --- the generated table against the firmware table ----------------------
    print('register table')
    rows_fw = re.findall(
        r'\{\s*(e\w+)\s*,\s*"([^"]+)"\s*,\s*"([^"]+)"\s*,\s*(REG_ACCESS_\w+)\s*\}',
        fw_table(read(REGISTERS_C)))
    rows_at = re.findall(r'\{\s*"([^"]+)",\s*"([^"]+)",\s*(\d+),\s*(true|false)\s*\}',
                         table)

    check('row counts agree',
          len(rows_fw) == len(rows_at),
          '(firmware=%d esp32=%d)' % (len(rows_fw), len(rows_at)))

    addresses = {m.group(1): int(m.group(2))
                 for m in re.finditer(r'^\s*(e\w+)\s*=\s*(\d+)\s*,',
                                      read(REGISTERS_H), re.M)}

    mismatched = []
    for (enum, short, long_name, access), (a_short, a_long, a_addr, a_ro) in zip(
            rows_fw, rows_at):
        want_ro = 'true' if access == 'REG_ACCESS_RO' else 'false'
        if (short != a_short or long_name != a_long
                or addresses.get(enum) != int(a_addr) or want_ro != a_ro):
            mismatched.append(short)

    check('every name, address and access flag matches',
          not mismatched,
          '(%d differ: %s)' % (len(mismatched), ', '.join(mismatched[:5])))

    # --- documented divergences ---------------------------------------------
    print('known divergences (expected, must stay documented)')
    check('SFRA_CAL absent from the proxy and explained',
          'SFRA_CAL' in fw and 'SFRA_CAL' not in _code_only(at)
          and 'SFRA_CAL' in at,
          'must be mentioned in a comment but not implemented')
    check('proxy reports link failures',
          'ERROR: Link failure' in at,
          'the unit cannot fail this way; the proxy can')

    print()
    if failures:
        print('%d of %d checks FAILED' % (len(failures), checks))
        return 1
    print('all %d checks passed' % checks)
    return 0


def fw_table(registers_c):
    start = registers_c.find('uartRegConfig[TOTAL_REGISTERS]')
    return registers_c[start:registers_c.find('};', start)]


def _code_only(src):
    """Strip block comments, so a mention in prose is not read as code."""
    return re.sub(r'/\*.*?\*/', '', src, flags=re.S)


if __name__ == '__main__':
    sys.exit(main())
