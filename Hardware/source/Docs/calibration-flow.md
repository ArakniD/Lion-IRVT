# Calibration Flow Diagrams

Diagrams for the per-slot calibration feature. The authoritative definitions
are in [`calibration-design.md`](calibration-design.md); these render its
sections 5, 7 and 12 visually. The operator procedure is in
[`README.md`](README.md).

---

## 1. Operator process flow

Design doc section 12. One pass per slot; the script walks slots 1–8.

```mermaid
flowchart TD
    START([Start calibrate.py]) --> CFG[/"Configure: DMM IP, SCPI port, BLE address<br/>persisted to calibrate.ini"/]
    CFG --> DMM["Connect DMM over TCP 5025<br/>*IDN? verified, *RST, *CLS"]
    DMM --> DMMOK{Model<br/>supported?}
    DMMOK -->|no| ABORT([Abort])
    DMMOK -->|yes| BLE["Connect BLE: BTS-Tester<br/>check chars 000b / 000c present"]
    BLE --> SLOT{{"For each slot N in 1..8"}}

    SLOT --> WIRE[/"PROMPT: connect DC supply and DMM<br/>across slot N, DMM in PARALLEL"/]
    WIRE --> ENTER["CAL_CMD_ENTER (slot N)"]
    ENTER --> ENTOK{result<br/>== 0?}
    ENTOK -->|no| FAILSLOT["Report eCalResult as text<br/>CAL_CMD_EXIT"]
    ENTOK -->|yes| VLOW

    subgraph VOLT ["VOLTAGE PHASE — DMM in parallel"]
        VLOW[/"PROMPT: set supply to ~0.85 V"/] --> VLOWW{"live ADS pu<br/>&lt; 0.2 ?"}
        VLOWW -->|no, adjust| VLOWW
        VLOWW -->|yes| VLOWR["DMM: CONF:VOLT:DC, READ? -> V_lo"]
        VLOWR --> VLOWC["CAL_CMD_CAPTURE_VOLTAGE (V_lo)<br/>status bit 1"]
        VLOWC --> VHI[/"PROMPT: raise supply to ~4.25 V"/]
        VHI --> VHIW{"live ADS pu<br/>&gt; 0.8 ?"}
        VHIW -->|no, adjust| VHIW
        VHIW -->|yes| VHIR["DMM: READ? -> V_hi"]
        VHIR --> VHIC["CAL_CMD_CAPTURE_VOLTAGE (V_hi)<br/>status bit 2"]
    end

    VHIC --> IZERO

    subgraph CURR ["CURRENT PHASE — DMM in series"]
        IZERO[/"PROMPT: supply output OFF,<br/>break the slot current path"/] --> IZC["CAL_CMD_ZERO_CURRENT<br/>status bit 3"]
        IZC --> ILOAD[/"PROMPT: DMM into SERIES, supply ~3.7 V,<br/>ITS current limit 3 A, output ON"/]
        ILOAD --> ISET["CAL_CMD_SET_FIXED_CURRENT (0.25 pu)<br/>status bit 8 — slot now driving ~2.5 A"]
        ISET --> SETTLE["settle ~2 s"]
        SETTLE --> IREAD["DMM: CONF:CURR:DC, READ? -> I_hi"]
        IREAD --> IMAG["take |I_hi| — MAGNITUDE<br/>firmware applies the discharge sign"]
        IMAG --> ICAP["CAL_CMD_CAPTURE_CURRENT (|I_hi|)<br/>status bit 4"]
    end

    ICAP --> SAVE["CAL_CMD_COMPUTE_SAVE<br/>two-point maths, validate,<br/>F-RAM write, IPC reload<br/>status bits 5, 6, 7"]
    SAVE --> SAVEOK{"bit 7 set?"}
    SAVEOK -->|no| FAILSLOT
    SAVEOK -->|yes| EXIT["CAL_CMD_EXIT — reference zeroed"]
    EXIT --> VERIFY["Read slot status bits 13 / 14<br/>both set = both green ticks"]
    VERIFY --> TABLE["Print before/after gain table"]
    TABLE --> MORE{More<br/>slots?}
    FAILSLOT --> MORE
    MORE -->|yes| SLOT
    MORE -->|no| REPORT["Write JSON report"]
    REPORT --> DONE([Done])

    classDef prompt fill:#fff4e0,stroke:#d08a2a,color:#000
    classDef danger fill:#ffe3e3,stroke:#c0392b,color:#000
    class WIRE,VLOW,VHI,IZERO,ILOAD prompt
    class ISET,SETTLE,IREAD danger
```

The red-tinted steps are the only ones where the slot is driving current.
Everything from `CAL_CMD_SET_FIXED_CURRENT` to `CAL_CMD_COMPUTE_SAVE` runs with
roughly 2.5 A flowing and the hardware trips disabled — this is the window that
must not be left unattended.

---

## 2. Per-slot calibration state machine

Design doc section 7. `calState` is a new field in `BTS_userInput`, evaluated
every millisecond in `BTS_updateReference()`.

```mermaid
stateDiagram-v2
    direction TB

    [*] --> Normal

    state "calState = 0 — NORMAL" as Normal
    state "calState = 1 — CAL IDLE" as CalIdle
    state "calState = 2 — CAL FIXED CURRENT" as CalDrive

    Normal: Existing reference arithmetic, unchanged
    Normal: ioutRef_pu = iref_A * IoutGain_pu + IoutOffset_pu
    Normal: Slot runs charge / discharge tests normally

    CalIdle: enable_logic = 0, references zeroed
    CalIdle: Measurement still running — telemetry is live
    CalIdle: Voltage captures happen here
    CalIdle: LED flashes white

    CalDrive: ioutRef_pu = ioutCal_pu
    CalDrive: voutRef_pu = 1.0
    CalDrive: direction_logic = 0, direction_coeff = -1.0 (DISCHARGE)
    CalDrive: Min-voltage cutout bypassed for THIS slot only
    CalDrive: 120 s dead-man timer running

    Normal --> CalIdle : CAL_CMD_ENTER or eChX_Mode bit 2<br/>force-exits every other slot<br/>rejected if any slot is testing
    CalIdle --> CalDrive : CAL_CMD_SET_FIXED_CURRENT (pu)<br/>0.0 to 0.8 pu, else CAL_ERR_ARG<br/>status bit 8 set

    CalDrive --> CalIdle : CAL_CMD_CAPTURE_CURRENT<br/>then setpoint released
    CalDrive --> CalIdle : dead-man timeout — 120 s<br/>with no calibration command<br/>reference zeroed
    CalDrive --> Normal : TRIP — CMPSS or GPIO<br/>reference zeroed immediately
    CalDrive --> Normal : CAL_CMD_EXIT
    CalDrive --> Normal : host disconnect timeout<br/>or unit state change

    CalIdle --> Normal : CAL_CMD_EXIT<br/>captures discarded unless already saved
    CalIdle --> Normal : TRIP
    CalIdle --> Normal : host disconnect / unit state change

    CalIdle --> CalIdle : CAL_CMD_CAPTURE_VOLTAGE<br/>pu below 0.2 is the low point,<br/>above 0.8 the high point,<br/>between them CAL_ERR_PU_RANGE
    CalIdle --> CalIdle : CAL_CMD_ZERO_CURRENT
    CalIdle --> CalIdle : CAL_CMD_COMPUTE_SAVE<br/>deferred F-RAM write from the idle loop
    CalIdle --> CalIdle : CAL_CMD_CLEAR<br/>discard captures, stay in calibration

    note right of CalDrive
        Trips are NEVER disabled, masked or
        re-thresholded during calibration.
        A trip always wins and always exits.
    end note

    note left of CalIdle
        One slot at a time. Group followers and
        strap-disabled slots are refused with
        CAL_ERR_SLOT_UNAVAILABLE.
    end note
```

### Exit paths, and what each guarantees

| Exit | Trigger | Reference zeroed | State after |
|---|---|---|---|
| Commanded | `CAL_CMD_EXIT` | yes, before the state change | Normal |
| Trip | CMPSS or GPIO trip zone | yes, immediately | Normal |
| Dead-man | 120 s with no calibration command in `calState == 2` | yes | Cal idle |
| Host loss | BLE/HTTP disconnect timeout | yes | Normal |
| Unit state | Input bus leaves its window | yes | Normal |

Every path zeroes the reference **before** it changes state. There is no
ordering in which the slot is left driving current with nothing supervising it.

---

## 3. One capture, end to end

What happens between the script calling `CAL_CMD_CAPTURE_VOLTAGE` and the
result coming back. The measurement path is the interesting half: the value
being captured originates on CPU1 and has already travelled the other way.

```mermaid
sequenceDiagram
    autonumber
    participant OP as Operator
    participant PY as calibrate.py
    participant DMM as Keysight DMM<br/>SCPI port 5025
    participant BLE as BLE / NimBLE<br/>ble_svc.c
    participant ESP as ESP32<br/>bts_link.c
    participant C2 as C2000 CPU2<br/>com_cpu2.c
    participant C1 as C2000 CPU1<br/>bts_cpu1.c
    participant HW as ADS131M08 +<br/>on-chip ADC

    Note over C1,HW: Measurement path — free-running, independent of any capture
    loop every control period
        HW->>C1: 16-bit sample pair
        C1->>C1: BTS_monitor_Iout_Vout()<br/>average, apply current gain/offset
        C1->>C2: cpu1Status (CPU1TOCPU2RAM)<br/>seq++ guards a torn read
        C2->>C2: mirror into registers[]<br/>CPU2 is the only writer
    end

    Note over OP,DMM: Capture begins
    OP->>PY: supply set to ~0.85 V
    PY->>BLE: read char e5f1000c (cal status)
    BLE-->>PY: ble_cal_status_t, little-endian
    PY->>PY: check ADS pu < 0.2, else keep prompting

    PY->>DMM: CONF:VOLT:DC AUTO
    PY->>DMM: READ?
    DMM-->>PY: 0.849683

    PY->>BLE: write char e5f1000b<br/>{opcode=3, slot=1, rsvd, arg=0.849683f}<br/>packed LITTLE-endian
    BLE->>ESP: bts_link_cal_capture_voltage(slot, v)

    Note over ESP,C2: I2C wire format is BIG-endian — opposite to BLE
    ESP->>C2: write eCalArgument (1044) = 0.849683f<br/>S 0x50+W | 0x04 0x14 | b0 b1 b2 b3 | P
    ESP->>C2: write eCalCommand (1040) = 3.0f
    C2->>C2: i2cSlaveISR -> applyHostRegisterWrite()
    C2->>C1: ipcMsg{regAddr, value} + IPC_FLAG0

    Note over C1: The new 1036+ block MUST be added to the<br/>BTS_HandleRegisterWrite() decode, or the command<br/>is acked and silently discarded
    C1->>C1: BTS_HandleRegisterWrite() decodes 1040
    C1->>C1: sample both paths at this instant:<br/>ADS pu and internal-ADC volts-at-pin
    C1->>C1: classify by ADS pu: <0.2 low, >0.8 high<br/>else CAL_ERR_PU_RANGE
    C1->>C1: store the point, set eCalStatus bit 1
    C1->>C2: cpu1Status: status bits + telemetry

    C2->>C2: mirror eCalStatus (1048), eCalResult (1052)<br/>and the 9 telemetry registers (1056-1088)
    ESP->>C2: burst read 1036..1088, one transaction
    Note over ESP,C2: skip the lead-in pad byte — the C2000 clocks out<br/>a stale TX byte before its ISR can run
    C2-->>ESP: pad, then 14 big-endian floats
    ESP->>ESP: bts_wire_to_f32() -> bts_cal_state_t
    ESP->>BLE: snapshot updated
    BLE-->>PY: notify e5f1000c at 2 Hz<br/>+ explicit read after the command
    PY->>PY: result == 0 ? continue : raise with result text
    PY-->>OP: "pu = 0.1710 OK / DMM: 0.84968 V"
```

### Two things this diagram is drawn to make obvious

**The endianness flips in the middle.** BLE records are packed
**little-endian** (`ble_proto.h`, native to both the ESP32 and a browser's
`DataView`). The I2C register wire format is **big-endian** (`floatGetWireByte()`
in `com_cpu2.c`). They are opposite, and the conversion happens in `bts_regs.h`
— nothing above `bts_link` should ever see the C2000's byte order.

**CPU1 never writes `registers[]`.** The register file lives in `CPU2TOCPU1RAM`,
which only CPU2 may write. Every measurement CPU1 produces reaches a host by
travelling through `cpu1Status` under its `seq` seqlock and being mirrored by
CPU2. Calibration does not get an exception to this.

---

## 4. Where the numbers come from

The two-point fit, as data rather than as prose. Design doc section 6.

```mermaid
flowchart LR
    subgraph CAP ["Captured per slot"]
        VLO["V low point<br/>(pu_lo, V_lo)"]
        VHI["V high point<br/>(pu_hi, V_hi)"]
        IZ["I zero point<br/>(pu_zero, 0.0 A)"]
        IL["I loaded point<br/>(pu_hi, |I_hi|)"]
    end

    subgraph EXT ["External path — ADS131M08"]
        VGP["VoutGain_pu = (pu_hi - pu_lo) / (V_hi - V_lo)"]
        VOP["VoutOffset_pu = pu_lo - V_lo * VoutGain_pu"]
        VGV["VoutGain_V = 1 / VoutGain_pu"]
        IGP["IoutGain_pu = (pu_hi - pu_zero) / I_hi"]
        IOP["IoutOffset_pu = pu_zero"]
        IGA["IoutGain_A = 1 / IoutGain_pu"]
    end

    subgraph INT ["Internal path — on-chip ADC, x = (sum / (N * 4096)) * 2.5"]
        FVG["F28V_Gain = (V_hi - V_lo) / (x_hi - x_lo)"]
        FVO["F28V_Offset = V_lo - x_lo * F28V_Gain"]
        FIG["F28I_Gain = I_hi / (x_hi - x_zero)"]
        FIO["F28I_Offset = -x_zero * F28I_Gain"]
    end

    VLO --> VGP
    VHI --> VGP
    VGP --> VOP --> VGV
    IZ --> IGP
    IL --> IGP
    IGP --> IOP --> IGA
    VLO --> FVG
    VHI --> FVG
    FVG --> FVO
    IZ --> FIG
    IL --> FIG
    FIG --> FIO

    VGV --> VAL{{"Validate<br/>IoutGain_pu 0.05-0.20<br/>VoutGain_pu 0.10-0.40<br/>F28 gains 0.5-2.0<br/>reciprocals within 0.1%"}}
    IGA --> VAL
    FVO --> VAL
    FIO --> VAL

    VAL -->|pass| FRAM[("FM24V10 F-RAM<br/>128-byte stride<br/>header 0xA5CD_00NN<br/>+ calFlags + crc32")]
    VAL -->|fail| ERR["CAL_ERR_VALIDATE<br/>nothing written"]
    FRAM --> RELOAD["IPC_FLAG2 — CAL_RELOAD<br/>CPU1 re-derives the program"]
    RELOAD --> TICKS["Status bits 13 / 14<br/>green ticks on the display"]
```

Note the **reciprocal pair**. `IoutGain_pu` converts amps to per-unit for the
control loop's setpoint; `IoutGain_A` converts per-unit back to amps for
reporting. They are stored separately and validated against each other to
within 0.1 %, which is what catches a partially-written F-RAM block. The
current *sense* side is never gain-corrected — the loop closes in raw-ADC
per-unit space and calibration is folded into the setpoint only.
