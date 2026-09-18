#!/usr/bin/env python3
"""
Characterises the DTR line on its own.

pyserial's `True` means *asserted*, and esp_pylib defines PIN_LOW = True:
an asserted line pulls its pin LOW. So DTR asserted should mean IO0 low.

RTS is already proven: asserting it alone resets the chip, so RTS -> EN
is wired and the host can drive it. What is unproven is DTR. Asserting
DTR *alone* (RTS released) distinguishes the three possibilities:

  * a boot banner appears        -> DTR reaches EN (the lines are swapped
                                    relative to the usual convention)
  * no banner, chip keeps running-> DTR reaches IO0 or nothing; inconclusive
                                    on its own, but combined with a failing
                                    classic sequence it points at IO0
  * chip stops talking           -> DTR holds something low permanently

Run with the board already booted and printing, so a reset is obvious.

Usage:  python tools/probe_dtr_alone.py COM6
"""

import sys
import time

import serial


def drain(ser, seconds):
    deadline = time.time() + seconds
    buf = b""
    while time.time() < deadline:
        chunk = ser.read(256)
        if chunk:
            buf += chunk
    return buf


def main():
    port = sys.argv[1] if len(sys.argv) > 1 else "COM6"

    with serial.Serial(port, 115200, timeout=0.05) as ser:
        ser.dtr = False
        ser.rts = False
        time.sleep(0.2)

        print("baseline (both released), listening 1.5 s...")
        base = drain(ser, 1.5)
        print(f"  {len(base)} bytes")

        print("asserting DTR alone for 1.5 s...")
        ser.reset_input_buffer()
        ser.dtr = True
        during = drain(ser, 1.5)
        ser.dtr = False
        print(f"  {len(during)} bytes")
        if b"boot:" in during or b"rst:" in during:
            print("  -> DTR RESET THE CHIP: DTR is wired to EN, lines are swapped.")
        elif during.strip():
            print("  -> chip kept running; DTR did not reset it.")
        else:
            print("  -> silence while DTR asserted.")

        print("releasing DTR, listening 1.5 s...")
        after = drain(ser, 1.5)
        print(f"  {len(after)} bytes")
        if b"boot:" in after or b"rst:" in after:
            print("  -> chip reset on DTR RELEASE.")

        # Now the reference: RTS alone, which is known to work.
        print("asserting RTS alone for 0.3 s (known-good reset)...")
        ser.reset_input_buffer()
        ser.rts = True
        time.sleep(0.3)
        ser.rts = False
        ref = drain(ser, 1.5)
        print(f"  {len(ref)} bytes; banner seen: {b'boot:' in ref or b'rst:' in ref}")

    return 0


if __name__ == "__main__":
    sys.exit(main())
