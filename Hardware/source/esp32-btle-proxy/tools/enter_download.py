#!/usr/bin/env python3
"""
Puts the LOLIN32 into ROM download mode by driving DTR/RTS directly.

WHY THIS EXISTS
---------------
esptool's own reset gives "Wrong boot mode detected (0x13)" on this board:
the EN capacitor is large enough that the 100 ms hold in its classic reset
does not reliably bring EN low, so the chip re-boots from flash with IO0
still high.

The board wires EN and IO0 through the usual two-transistor circuit:

    DTR high, RTS low   ->  EN  low   (chip held in reset)
    RTS high, DTR low   ->  IO0 low   (strap for download mode)
    both low            ->  both high (normal run)

The two lines cannot pull both pins low at once - that is what the circuit
is for. Download mode is entered on the transition: hold EN low, then swap
the lines so EN releases while IO0 is still low, and the ROM samples IO0 as
it comes out of reset.

IO0 is only sampled at the moment reset is released, so once the chip is in
download mode it stays there, and the lines (and the port) can be released.

Usage:  python tools/enter_download.py COM6 [--invert]

Then flash without letting esptool reset the board again:

    idf.py -p COM6 --before no-reset flash
"""

import struct
import sys
import time

import serial

EN_HOLD_S = 0.25      # EN low; generous, the board's EN cap is slow
IO0_HOLD_S = 0.60     # IO0 low after EN releases, while the ROM boots
SYNC_TIMEOUT_S = 0.4


def slip_encode(payload: bytes) -> bytes:
    body = payload.replace(b"\xdb", b"\xdb\xdd").replace(b"\xc0", b"\xdb\xdc")
    return b"\xc0" + body + b"\xc0"


def rom_is_listening(ser: serial.Serial) -> bool:
    """Sends the ROM SYNC command and reports whether anything answered."""
    data = b"\x07\x07\x12\x20" + b"\x55" * 32
    packet = struct.pack("<BBHI", 0x00, 0x08, len(data), 0) + data
    frame = slip_encode(packet)

    for _ in range(8):
        ser.reset_input_buffer()
        ser.write(frame)
        ser.flush()
        deadline = time.time() + SYNC_TIMEOUT_S
        buf = b""
        while time.time() < deadline:
            chunk = ser.read(64)
            if chunk:
                buf += chunk
                # A response frame is 0xC0, direction 0x01, command 0x08.
                if b"\xc0\x01\x08" in buf:
                    return True
        time.sleep(0.05)
    return False


def enter_download(ser: serial.Serial, invert: bool) -> None:
    # pyserial's dtr/rts are the *asserted* state; whether that is a high or
    # a low at the pin depends on the bridge, so --invert flips the mapping.
    def set_lines(dtr: bool, rts: bool) -> None:
        ser.dtr = (not dtr) if invert else dtr
        ser.rts = (not rts) if invert else rts

    set_lines(dtr=False, rts=False)   # idle: EN high, IO0 high
    time.sleep(0.1)

    set_lines(dtr=True, rts=False)    # EN low - chip held in reset
    time.sleep(EN_HOLD_S)

    set_lines(dtr=False, rts=True)    # EN released, IO0 low -> strap sampled
    time.sleep(IO0_HOLD_S)

    set_lines(dtr=False, rts=False)   # release both; mode is already latched
    time.sleep(0.1)


def main() -> int:
    port = sys.argv[1] if len(sys.argv) > 1 else "COM6"
    explicit_invert = "--invert" in sys.argv

    orders = [explicit_invert] if explicit_invert else [False, True]

    for invert in orders:
        label = "inverted" if invert else "normal"
        print(f"{port}: driving DTR/RTS ({label} polarity)...")
        with serial.Serial(port, 115200, timeout=0.1) as ser:
            enter_download(ser, invert)
            if rom_is_listening(ser):
                print(f"{port}: ROM bootloader is answering - download mode entered.")
                print("Now flash with:  idf.py -p %s --before no-reset flash" % port)
                return 0
        print(f"{port}: no answer with {label} polarity.")

    print(
        f"{port}: could not reach the ROM bootloader.\n"
        "Hold BOOT/IO0, tap EN/RST, release BOOT, then flash with --before no-reset.",
        file=sys.stderr,
    )
    return 1


if __name__ == "__main__":
    sys.exit(main())
