#!/usr/bin/env python3
"""
Works out which DTR/RTS combination puts this board into download mode.

The ESP32 ROM prints its strapping result on every reset:

    boot:0x13 (SPI_FAST_FLASH_BOOT)   IO0 was high - booted from flash
    boot:0x03 (DOWNLOAD_BOOT...)      IO0 was low  - download mode

So rather than guessing the polarity, this drives each candidate combination
and reads back what the ROM says. Whichever one yields 0x03 is the correct
mapping for this board.

Usage:  python tools/probe_reset.py COM6
"""

import re
import sys
import time

import serial

EN_HOLD_S = 0.30
IO0_HOLD_S = 0.10   # after EN releases, before the banner is read

BOOT_RE = re.compile(rb"boot:(0x[0-9a-fA-F]+)")


def capture(ser, seconds=1.2):
    deadline = time.time() + seconds
    buf = b""
    while time.time() < deadline:
        chunk = ser.read(256)
        if chunk:
            buf += chunk
    return buf


def try_combo(ser, en_dtr, en_rts, io0_dtr, io0_rts):
    """Holds EN low with one pair, then releases it with the other."""
    ser.dtr, ser.rts = False, False
    time.sleep(0.10)

    ser.dtr, ser.rts = en_dtr, en_rts        # intended: EN low
    time.sleep(EN_HOLD_S)

    ser.dtr, ser.rts = io0_dtr, io0_rts      # intended: EN released, IO0 low
    ser.reset_input_buffer()
    time.sleep(IO0_HOLD_S)

    banner = capture(ser)

    ser.dtr, ser.rts = False, False
    return banner


COMBOS = [
    # label,                      EN-low pair,   IO0-low pair
    ("DTR=1,RTS=0 -> DTR=0,RTS=1", (True, False), (False, True)),
    ("DTR=0,RTS=1 -> DTR=1,RTS=0", (False, True), (True, False)),
    ("DTR=1,RTS=1 -> DTR=0,RTS=1", (True, True),  (False, True)),
    ("DTR=1,RTS=1 -> DTR=1,RTS=0", (True, True),  (True, False)),
]


def main():
    port = sys.argv[1] if len(sys.argv) > 1 else "COM6"

    with serial.Serial(port, 115200, timeout=0.05) as ser:
        for label, en, io0 in COMBOS:
            banner = try_combo(ser, en[0], en[1], io0[0], io0[1])
            m = BOOT_RE.search(banner)
            if m:
                mode = m.group(1).decode()
                verdict = "DOWNLOAD MODE" if mode.lower() in ("0x3", "0x03") else "flash boot"
                print(f"{label:32}  boot:{mode}  {verdict}")
                if verdict == "DOWNLOAD MODE":
                    print("\nUse this combination. Flash with --before no-reset "
                          "after running enter_download.py.")
                    return 0
            elif banner.strip():
                head = banner.strip()[:60]
                print(f"{label:32}  no boot: line; got {head!r}")
            else:
                print(f"{label:32}  silence - EN may not be toggling")

    print("\nNo combination produced download mode.", file=sys.stderr)
    return 1


if __name__ == "__main__":
    sys.exit(main())
