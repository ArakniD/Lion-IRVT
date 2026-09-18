#!/usr/bin/env python3
"""
Last-resort attempts at host-driven download mode, each verified by a real
esptool SYNC rather than by the boot banner.

WHY THE ORDINARY SEQUENCE FAILS ON THIS BOARD
---------------------------------------------
The auto-program circuit is two transistors, each turned on by one line
being asserted while the other is not:

    DTR asserted, RTS released  ->  IO0 low
    RTS asserted, DTR released  ->  EN  low
    BOTH asserted               ->  both transistors off, EN and IO0 HIGH

That last row is the problem. Entering download mode needs IO0 low at the
instant EN is released, but going from "EN low" to "IO0 low" means moving
from (RTS asserted) to (DTR asserted), and on Windows those are two separate
ioctls. Whichever order is used, the pair passes through an invalid state:

    assert DTR first   -> both asserted -> EN released early, IO0 still high
    release RTS first  -> both released -> EN released early, IO0 still high

Either way the ROM samples IO0 high and boots from flash (boot:0x13).

On most ESP32 boards the capacitor on EN saves this: EN rises slowly enough
that IO0 is low before the strap is sampled. Whether that works here depends
on that cap against host ioctl latency - which is what these strategies
probe. `unix_tight_bootloader_reset` would sidestep it with an atomic
TIOCMSET, but that is POSIX-only and raises NotImplementedError on Windows.

Usage:  python tools/try_download_hard.py COM6
"""

import sys
import time

import serial
from esp_pylib.serial_reset import classic_bootloader_reset

sys.path.insert(0, ".")
from enter_download import rom_is_listening  # noqa: E402  (same tools dir)


def strat_classic(ser, enter_delay, reset_delay, flow_control=False):
    classic_bootloader_reset(
        ser,
        enter_boot_delay=enter_delay,
        reset_delay=reset_delay,
        flow_control=flow_control,
    )


def main():
    port = sys.argv[1] if len(sys.argv) > 1 else "COM6"

    # (label, enter_boot_delay, reset_delay, flow_control)
    variants = [
        ("classic, stock timing",        0.10, 0.05, False),
        ("classic, long EN hold",        0.50, 0.05, False),
        ("classic, very long EN hold",   1.00, 0.10, False),
        ("classic, flow_control=True",   0.30, 0.05, True),
        ("classic, tiny reset_delay",    0.30, 0.001, False),
    ]

    with serial.Serial(port, 115200, timeout=0.1) as ser:
        for label, ed, rd, fc in variants:
            print(f"{label:30} ", end="", flush=True)
            strat_classic(ser, ed, rd, fc)
            print("SYNC OK - download mode!" if rom_is_listening(ser) else "no sync")
            time.sleep(0.2)

        # If it is a race, repeated identical attempts may occasionally win.
        print("\nretrying stock sequence 20x in case it is a marginal race...")
        for i in range(20):
            strat_classic(ser, 0.10, 0.05, False)
            if rom_is_listening(ser):
                print(f"  attempt {i + 1}: SYNC OK - download mode!")
                return 0
        print("  20/20 failed")

    print("\nHost-driven download mode is not achievable on this board.",
          file=sys.stderr)
    return 1


if __name__ == "__main__":
    sys.exit(main())
