# I2C Interface Specification (Slave – ESP32 / Host)

## Physical Layer

- Bus: I2CA
- Pins: GPIO32 (SDA), GPIO33 (SCL)
- Slave address: 0x50 (7-bit)
- Speed: Standard / Fast mode (host controlled; device does not stretch beyond interrupt latency)
- Pull-ups: external (typically 2.2 kΩ–4.7 kΩ)

## Transaction Format

All multi-byte values use **big-endian** byte order for the 32-bit float payload.

### Write (Host → Device)

```
S | 0xA0 (addr<<1 | W) | AddrH | AddrL | D3 | D2 | D1 | D0 | P
```

- AddrH/AddrL = 16-bit register address (from `RegisterAddress` enum, byte address)
- D3..D0 = IEEE-754 float (D3 = MSB)

Auto-increment is supported: after a successful 4-byte write the internal address pointer advances by 4. Subsequent data bytes continue writing consecutive registers until STOP.

### Read (Host ← Device)

```
S | 0xA0 | AddrH | AddrL | Sr | 0xA1 (addr<<1 | R) | D3 | D2 | D1 | D0 | P
```

or repeated reads with auto-increment.

On any write to a `REG_ACCESS_RW` register Core 2:

1. Stores the float into `registers[addr/4]`
2. Populates `ipcMsg` and sets `IPC_FLAG0` (or `IPC_FLAG1` for temperature)
3. If the register is `eCalibrationMode` and value == 2.0f, calls `saveCalibration()` for every channel

## Address Map Summary

Addresses are byte offsets (enum values). Internal index = address / 4.

### Control Block (80 registers, 0–316)

Per channel (ch = 0..7), base = ch * 40:

| Offset | Enum                      | Access | Description |
|--------|---------------------------|--------|-------------|
| +0     | eChX_Mode                 | RW     | bit0=run, bit1=charge (0=discharge) |
| +4     | eChX_ChargeVoltageMin     | RW     | V |
| +8     | eChX_ChargeVoltageMax     | RW     | V |
| +12    | eChX_DischargeVoltageMin  | RW     | V |
| +16    | eChX_DischargeVoltageMax  | RW     | V |
| +20    | eChX_ChargeCurrentMin     | RW     | A |
| +24    | eChX_ChargeCurrentMax     | RW     | A |
| +28    | eChX_DischargeCurrentMin  | RW     | A |
| +32    | eChX_DischargeCurrentMax  | RW     | A |
| +36    | eChX_Status               | RO     | bitfield (running, stopped, finished, OCP, charging, discharging, CV, CC) |

### Stats Block (48 registers, 320–508)

Per channel base = 320 + ch * 24:

| Offset | Enum               | Access | Description |
|--------|--------------------|--------|-------------|
| +0     | eChX_CurrentAcc    | RO     | mAh accumulator |
| +4     | eChX_MinVoltage    | RO     | V |
| +8     | eChX_MaxVoltage    | RO     | V |
| +12    | eChX_PowerAcc      | RO     | mWh accumulator |
| +16    | eChX_CellVoltage   | RO     | V (from on-chip ADC) |
| +20    | eChX_CellCurrent   | RO     | A (from on-chip ADC) |

### Calibration Block (start 512)

- Per-channel min/max cell temp (512 + ch*8)
- Global: ChargeDisableV, ChargeRestrictV, DischargeRestrictV, DischargeDisableV (576–588)
- Per-channel F28V/I gain/offset + Iout/Vout pu/A/V gain/offset (12 floats × 8 = 96 registers)
- Unit: CalibrationMode (976), UnitState (980), InputVoltage (984), TripStatus (988)

Full list is in `registers.h` / `regConfig[]`.

## ESP32 Example Patterns (Arduino / ESP-IDF style)

```c
// Write float to register
void bts_write_reg(uint16_t addr, float value) {
    uint8_t buf[6];
    buf[0] = addr >> 8;
    buf[1] = addr & 0xFF;
    uint32_t u;
    memcpy(&u, &value, 4);
    buf[2] = (u >> 24) & 0xFF; // big-endian
    buf[3] = (u >> 16) & 0xFF;
    buf[4] = (u >>  8) & 0xFF;
    buf[5] = (u >>  0) & 0xFF;
    // i2c_master_write_to_device(0x50, buf, 6, ...);
}

// Read float
float bts_read_reg(uint16_t addr) {
    uint8_t addr_buf[2] = {addr >> 8, addr & 0xFF};
    uint8_t data[4];
    // write addr then read 4 bytes
    uint32_t u = (data[0]<<24) | (data[1]<<16) | (data[2]<<8) | data[3];
    float f;
    memcpy(&f, &u, 4);
    return f;
}
```

## Error / Edge Cases

- Writes to RO registers or out-of-range addresses are ignored (no NACK on data phase in current implementation).
- Float NaN / Inf should be avoided; device does not sanitize.
- Concurrent UART / CAN / I2C writes to the same register are last-writer-wins; IPC only notifies Core 1 of the final value.
