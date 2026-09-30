#!/usr/bin/env python3
"""Generate the ESP32's AT-command register name table from the C2000 source.

WHY GENERATED, NOT HAND-WRITTEN
-------------------------------
The AT console on the C2000 resolves a command like ``AT+C0VOLT?`` by walking
``uartRegConfig[]`` in registers.c and comparing against BOTH the short and the
long name of every register. For the ESP32's AT interface to be command
compatible, it needs the same 280 name pairs, the same addresses and the same
read-only flags.

Hand-transcribing 280 rows would drift the first time a register is added -
and drift here is silent: an unknown name simply reports "ERROR: Invalid
register", and a wrong access flag turns a writable register read-only. So the
table is generated from the authoritative source and regenerated whenever the
register map changes.

USAGE
-----
    python3 tools/gen_at_registers.py

Writes components/at_console/bts_at_registers.c. Run it from the
esp32-btle-proxy directory.
"""

import io
import os
import re
import sys

C2000_REGISTERS_C = os.path.join(
    '..', 'tida-010086', 'bts_F2837xD_8ch', 'registers.c')
OUT_PATH = os.path.join('components', 'at_console', 'bts_at_registers.c')

ROW_RE = re.compile(
    r'\{\s*(e\w+)\s*,\s*"([^"]+)"\s*,\s*"([^"]+)"\s*,\s*(REG_ACCESS_\w+)\s*\}')

ENUM_RE = re.compile(r'^\s*(e\w+)\s*=\s*(\d+)\s*,', re.M)


def parse_addresses(header_path):
    """Map every enum name to its byte address."""
    text = io.open(header_path, encoding='utf-8', errors='replace').read()
    return {m.group(1): int(m.group(2)) for m in ENUM_RE.finditer(text)}


def main():
    if not os.path.exists(C2000_REGISTERS_C):
        sys.exit('cannot find %s - run this from esp32-btle-proxy/' %
                 C2000_REGISTERS_C)

    header = C2000_REGISTERS_C.replace('registers.c', 'registers.h')
    addresses = parse_addresses(header)

    text = io.open(C2000_REGISTERS_C, encoding='utf-8', errors='replace').read()
    start = text.find('uartRegConfig[TOTAL_REGISTERS]')
    if start < 0:
        sys.exit('uartRegConfig[] not found in registers.c')
    block = text[start:text.find('};', start)]

    rows = ROW_RE.findall(block)
    if not rows:
        sys.exit('no rows parsed from uartRegConfig[]')

    missing = [name for name, _, _, _ in rows if name not in addresses]
    if missing:
        sys.exit('enum address not found for: %s' % ', '.join(missing[:5]))

    lines = []
    lines.append('/*')
    lines.append(' * bts_at_registers.c - GENERATED FILE, DO NOT EDIT BY HAND.')
    lines.append(' *')
    lines.append(' * Regenerate with:  python3 tools/gen_at_registers.py')
    lines.append(' *')
    lines.append(' * Source of truth is uartRegConfig[] in the C2000 firmware')
    lines.append(' * (tida-010086/bts_F2837xD_8ch/registers.c), which is what the')
    lines.append(' * unit\'s own AT console resolves names against. Generating rather')
    lines.append(' * than transcribing keeps the two consoles command compatible: an')
    lines.append(' * added register reaches this table by re-running the script, and a')
    lines.append(' * hand edit here would drift silently - an unknown name just reports')
    lines.append(' * "ERROR: Invalid register".')
    lines.append(' */')
    lines.append('')
    lines.append('#include "bts_at_registers.h"')
    lines.append('')
    lines.append('const bts_at_register_t BTS_AT_REGISTERS[] = {')

    for name, short, long_name, access in rows:
        ro = 'true' if access == 'REG_ACCESS_RO' else 'false'
        lines.append('    { "%s", "%s", %d, %s },' %
                     (short, long_name, addresses[name], ro))

    lines.append('};')
    lines.append('')
    lines.append('const size_t BTS_AT_REGISTER_COUNT =')
    lines.append('    sizeof(BTS_AT_REGISTERS) / sizeof(BTS_AT_REGISTERS[0]);')
    lines.append('')

    out_dir = os.path.dirname(OUT_PATH)
    if not os.path.isdir(out_dir):
        os.makedirs(out_dir)

    io.open(OUT_PATH, 'wb').write(('\n'.join(lines)).encode('utf-8'))

    ro_count = sum(1 for r in rows if r[3] == 'REG_ACCESS_RO')
    print('wrote %s' % OUT_PATH)
    print('  %d registers  (%d read-only, %d writable)' %
          (len(rows), ro_count, len(rows) - ro_count))
    print('  address range %d..%d' %
          (min(addresses[r[0]] for r in rows),
           max(addresses[r[0]] for r in rows)))
    return 0


if __name__ == '__main__':
    sys.exit(main())
