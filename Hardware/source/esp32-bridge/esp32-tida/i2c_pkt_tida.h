/* C header to define all c/c++ I2c packets between TIDA reference design and the WiFi bridge.
 *
 *  The bridge may be the CC3220SFMODA or the ESP32
 *
 */
typedef enum _ePkt_CmdType {
    ePkt_None = 0;
    ePkt_SlotConfig,
    
    ePkt_MAX
} ePkt_CmdType;

typedef struct __attribute((packed)) _i2cPacket_header_t {
    /* 32bits command header */
    uint8_t             cmddType;           // ePkt_CmdType goes here
    uint8_t             length;             // length of packet fill in here
    uint16_t            checksum;           // cheksum of entire packet plus command and length here , crc16 format

} i2cPacket_header_t ;

typedef struct __attribute((packed)) _tida_SetPoints_t {
    i2cPacket_header_t  header;             // Packet header

    uint8_t             slot_number;        // slot number 1-8 
    uint8_t             mRest_Charge;       // time in minutes
    uint8_t             mRest_Discharge;    // time in minutes
    uint8_t             Tterm_Safety;       // Temp in degC
    uint32_t            dts_cfgTime;        // u32 dts

    uint16_t            mVref_Charge;       // mV charge voltage
    uint16_t            mAref_Charge;       // mA charge termination
    uint16_t            mAterm_Charge;      // mA charge current
    uint16_t            mVterm_Discharge;   // mV discharge termination
    uint16_t            mAref_Discharge;    // mA discharge current
    uint16_t            mAh_expected;       // mAh expected capacity
    
} tida_SetPoints_t;


// I2C packet......
typedef struct sensorData_t {
  uint8_t     Header;
  uint8_t     DeviceID;   // device ID.
  uint16_t    BatteryVoltage;
  uint8_t     Running: 1; // lowest bit, compatile with full byte
  uint8_t     Complete: 1;
  uint8_t     Fault: 1;
  uint8_t     Idle: 1;
  uint16_t    Current;
  uint16_t    CurrentTotal;
  uint16_t    RunTime;
  uint8_t     socket;
} __attribute__ ((packed));
#define PACKET_SIZE sizeof(sensorData_t)

typedef struct sensorData_v2_t {
  sensorData_t  v1;
  uint16_t  Power;
  uint16_t  PowerTotal;
  uint16_t  SocketLoss;
  uint32_t  timeStamp;
  uint32_t  sampleTotal;
} __attribute__ ((packed));
#define PACKET_SIZE_V2 sizeof(sensorData_v2_t)

typedef enum _eTst_Sequence {
    eTst_stopped = 0,   // Slot is not running any sequences
    eTst_slotReady,     // Slot ready, cell loaded and DC DC primed for start
    eTst_zeroSoC,       // Empty the cell to known 0% SoC via discarge curret and voltage termination as per spec sheet
    eTst_zeroRest,      // Rest time at zero SoC
    eTst_charge,        // Charge cell to 100% SoC
    eTst_chargeRest,    // Rest time at 100% SoC
    eTst_drain,         // Drain full cell to 0% SoC
    eTst_drainRest,     // Rest time at 0% SoC
    eTst_shelfSoC,      // Refill cell to configured shelf/storage SoC based on actual measured cell state
    eTst_seqFinished,   // Sequence is complete
    eTst_eMAX
} eTst_Seq;

typedef enum _eTst_Status {
    eTst_noConfig = -3,
    eTst_hardFault = -2,
    eTst_slotEmpty = -1, // Empty slot, no cell voltage, DCDC converter is completely off
    eSts_idle = 0 ,
    eSts_reqCmd,        // Slot is currently paused and awaiting command
    eSts_reqReport,     // Slot needs its report data downloaded before it can proceed to the next mode of operation

} eTst_Status;

/* This packet is broadcasted from the discharger to the host, much like SMBUS transmits notifications of data */
typedef struct __attribute((packed)) _tida_SlotTelemetry_t {
    i2cPacket_header_t  header;         // Packet header

    uint8_t     slot_number;            // Tester slot number
    int8_t      tst_sequence;           // sequence the slot is in now
    uint16_t    seq_runTime;            // sequence run-time in seconds
    uint16_t    mVCell;                 // Cell voltage now
    uint16_t    mVnomCell;              // Cell voltage nominal in this sequence
    int16_t     mACell;                 // Cell mA now
    int32_t     mAhTotal;               // Cell mAh Total 
    int16_t     mWCell;                 // Cell mW now
    int32_t     mWhTotal;               // Cell mWh Total 
 
 
 
  uint8_t     Running: 1; // lowest bit, compatile with full byte
  uint8_t     Complete: 1;
  uint8_t     Fault: 1;
  uint8_t     Idle: 1;
  uint16_t    Current;
  uint16_t    CurrentTotal;
  uint16_t    RunTime;
  uint8_t     socket;
};

/* union of all types and raw bytes for packet reception and transmission */
typedef union __attribute((packed)) _tida_i2cPkt_u {
    /* Header must ALWAYS be the first entry in every packet type so that this
     * union functions correctly. Header always being first it can be referenced
     * via this union for packet checks, reception and transmission 
     */
    i2cPacket_header_t  header;

    /* Packet types go below */
    tida_SetPoints_t    setPoints;

    /* RAW packet bytes used for transmission and buffering */
    uint8_t             bytes[32];
} i2cPacket_u;