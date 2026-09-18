#!/usr/bin/env python3
"""
Second stage of the reset probe: EN is known to work, so test IO0.

probe_reset.py established that RTS drives EN on this board (RTS asserted
resets the chip and it reboots reporting boot:0x13). What is unproven is
whether DTR reaches IO0 at all.

This holds DTR in each state across an RTS-driven reset and reads the boot
mode back. If DTR reaches IO0, one of the two must report boot:0x03.
Both reporting 0x13 means the IO0 transistor is not being driven - on the
LOLIN32 v1.0.0 that is expected, the board has no auto-program circuit.

Usage:  python tools/probe_io0.py COM6
"""

import re
import sys
import time

import serial

BOOT_RE = re.compile(rb"boot:(0x[0-9a-fA-F]+)")


def reset_with_dtr(ser, dtr_state, settle=0.05):
    # Park DTR in the state under test before reset is released, so IO0 is
    # already settled when the ROM samples the strap.
    ser.dtr = dtr_state
    ser.rts = True              # EN low - hold in reset
    time.sleep(0.30)
    ser.reset_input_buffer()
    ser.rts = False             # release EN; ROM samples IO0 now
    time.sleep(settle)

    deadline = time.time() + 1.2
    buf = b""
    while time.time() < deadline:
        chunk = ser.read(256)
        if chunk:
            buf += chunk
            if BOOT_RE.search(buf):
                break
    ser.dtr = False
    return buf


def main():
    port = sys.argv[1] if len(sys.argv) > 1 else "COM6"
    modes = {}

    with serial.Serial(port, 115200, timeout=0.05) as ser:
        for dtr_state in (False, True):
            buf = reset_with_dtr(ser, dtr_state)
            m = BOOT_RE.search(buf)
            mode = m.group(1).decode() if m else None
            modes[dtr_state] = mode
            label = f"DTR asserted={dtr_state!s:5}"
            if mode is None:
                print(f"{label}  no boot: line seen")
            else:
                dl = mode.lower() in ("0x3", "0x03")
                print(f"{label}  boot:{mode}  {'DOWNLOAD MODE' if dl else 'flash boot'}")
            time.sleep(0.2)

    values = {v for v in modes.values() if v}
    if any(v and v.lower() in ("0x3", "0x03") for v in modes.values()):
        good = [k for k, v in modes.items() if v and v.lower() in ("0x3", "0x03")][0]
        print(f"\nIO0 is driven by DTR. Assert DTR={good} across the reset.")
        return 0

    if len(values) <= 1:
        print(
            "\nDTR does not change the boot mode: the IO0 strap is not wired to "
            "it on this board.\nDownload mode needs the BOOT button "
            "(hold BOOT, tap RST, release BOOT).",
            file=sys.stderr,
        )
    return 1


if __name__ == "__main__":
    sys.exit(main())
