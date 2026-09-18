#!/usr/bin/env python3
"""
Sweeps the EN-release / IO0-assert timing to find a working download entry.

WHAT THE EARLIER PROBES ESTABLISHED
-----------------------------------
  * RTS asserted  -> EN low. Resets the chip reliably (boot:0x13 each time).
  * DTR asserted while RTS is asserted -> no reset at all.

The second point is the two-transistor circuit's known quirk: each transistor
is driven by one line being asserted *while the other is not*, so asserting
both turns both off and leaves EN and IO0 high. IO0 therefore cannot be held
low while the chip sits in reset - it has to go low at the same moment EN is
released, and the ROM samples the strap on EN's rising edge.

What makes that work on most boards is the capacitor on EN: it slows EN's
rise enough that IO0 is already low by the time the ROM samples. Whether it
works here depends on that cap against the host's ioctl latency, which is
what this sweeps: for each gap, assert DTR then deassert RTS that many
milliseconds apart (and the reverse order), and read back the boot mode.

A run where every gap reports 0x13 means the strap never arrives in time and
this board cannot self-enter download mode - use the BOOT button.

Usage:  python tools/sweep_reset.py COM6
"""

import re
import sys
import time

import serial

BOOT_RE = re.compile(rb"boot:(0x[0-9a-fA-F]+)")
EN_HOLD_S = 0.30


def read_boot_mode(ser, seconds=1.0):
    deadline = time.time() + seconds
    buf = b""
    while time.time() < deadline:
        chunk = ser.read(256)
        if chunk:
            buf += chunk
            m = BOOT_RE.search(buf)
            if m:
                return m.group(1).decode(), buf
    return None, buf


def attempt(ser, gap_s, dtr_first):
    ser.dtr = False
    ser.rts = False
    time.sleep(0.10)

    ser.rts = True                 # EN low - chip in reset
    time.sleep(EN_HOLD_S)
    ser.reset_input_buffer()

    if dtr_first:
        ser.dtr = True             # IO0 low (also releases EN via the quirk)
        if gap_s:
            time.sleep(gap_s)
        ser.rts = False            # EN definitively released
    else:
        ser.rts = False            # EN released
        if gap_s:
            time.sleep(gap_s)
        ser.dtr = True             # IO0 low

    mode, buf = read_boot_mode(ser)
    ser.dtr = False
    ser.rts = False
    return mode, buf


def main():
    port = sys.argv[1] if len(sys.argv) > 1 else "COM6"
    gaps_ms = [0, 1, 2, 5, 10, 20, 50]

    found = None
    with serial.Serial(port, 115200, timeout=0.05) as ser:
        for dtr_first in (True, False):
            order = "DTR then RTS" if dtr_first else "RTS then DTR"
            for gap in gaps_ms:
                mode, _ = attempt(ser, gap / 1000.0, dtr_first)
                shown = f"boot:{mode}" if mode else "no banner"
                download = bool(mode and mode.lower() in ("0x3", "0x03"))
                flag = "  <== DOWNLOAD MODE" if download else ""
                print(f"{order:14}  gap {gap:3d} ms   {shown}{flag}")
                if download:
                    found = (order, gap)
                    break
                time.sleep(0.15)
            if found:
                break

    if found:
        order, gap = found
        print(f"\nWorks: {order}, {gap} ms gap.")
        return 0

    print(
        "\nNo timing reached download mode - the EN/IO0 strap cannot be driven "
        "from the host on this board.\n"
        "Hold BOOT/IO0, tap EN/RST, release BOOT, then flash with:\n"
        "    idf.py -p %s --before no-reset flash" % port,
        file=sys.stderr,
    )
    return 1


if __name__ == "__main__":
    sys.exit(main())
