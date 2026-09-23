
MEMORY
{
PAGE 0 :  /* Program Memory */
          /* Memory (RAM/FLASH) blocks can be moved to PAGE1 for data allocation */
          /* BEGIN is used for the "boot to Flash" bootloader mode   */

   BEGIN            : origin = 0x080000, length = 0x000002
   RAMGS14          : origin = 0x01A000, length = 0x001000
   RAMGS15          : origin = 0x01B000, length = 0x00FF8
// RAMGS15_RSVD     : origin = 0x01BFF8, length = 0x000008  /* Reserve and do not use for code as per the errata advisory "Memory: Prefetching Beyond Valid Memory" */
                                                            /* Only on F28379D, F28377D, F28375D devices. Remove line on other devices. */
   RESET           	: origin = 0x3FFFC0, length = 0x000002

   /*
    * Flash sectors.
    *
    * On the F2837xD EACH CPU HAS ITS OWN COMPLETE FLASH BANK, and both banks
    * are mapped at the SAME addresses - 0x080000..0x0BFFFF is CPU1's flash
    * when CPU1 fetches it and CPU2's flash when CPU2 fetches it. They are
    * different silicon, not a shared region. Verified on hardware: address
    * 0x090000 reads program code from CPU1 and 0xFFFF from CPU2.
    *
    * TI's own references make this explicit - the MEMORY blocks of
    * 2837xD_FLASH_lnk_cpu1.cmd and 2837xD_FLASH_lnk_cpu2.cmd are identical,
    * and both place BEGIN at 0x080000.
    *
    * This file previously carved the map up as if the two cores shared one
    * bank (CPU1 = A..I, CPU2 = J..N) with BEGIN at 0x0B0000. That wasted
    * most of each core's flash and, more seriously, left CPU2's boot-to-flash
    * entry point at 0x080000 erased - so a standalone boot via
    * Device_bootCPU2(C1C2_BROM_BOOTMODE_BOOT_FROM_FLASH) would have jumped
    * the boot ROM into 0xFFFF, an illegal opcode. It only ever worked because
    * CCS loads CPU2 directly and _STANDALONE is not defined.
    */
   FLASHA           : origin = 0x080002, length = 0x001FFE	/* on-chip Flash */
   FLASHB           : origin = 0x082000, length = 0x002000	/* on-chip Flash */
   FLASHC           : origin = 0x084000, length = 0x002000	/* on-chip Flash */
   FLASHD           : origin = 0x086000, length = 0x002000	/* on-chip Flash */
   FLASHE           : origin = 0x088000, length = 0x008000	/* on-chip Flash */
   FLASHF           : origin = 0x090000, length = 0x008000	/* on-chip Flash */
   FLASHG           : origin = 0x098000, length = 0x008000	/* on-chip Flash */
   FLASHH           : origin = 0x0A0000, length = 0x008000	/* on-chip Flash */
   FLASHI           : origin = 0x0A8000, length = 0x008000	/* on-chip Flash */
   FLASHJ           : origin = 0x0B0000, length = 0x008000	/* on-chip Flash */
   FLASHK           : origin = 0x0B8000, length = 0x002000	/* on-chip Flash */
   FLASHL           : origin = 0x0BA000, length = 0x002000	/* on-chip Flash */
   FLASHM           : origin = 0x0BC000, length = 0x002000	/* on-chip Flash */
   FLASHN           : origin = 0x0BE000, length = 0x001FF0	/* on-chip Flash */
// FLASHN_RSVD      : origin = 0x0BFFF0, length = 0x000010    /* Reserve and do not use for code as per the errata advisory "Memory: Prefetching Beyond Valid Memory" */

PAGE 1 : /* Data Memory */
         /* Memory (RAM/FLASH) blocks can be moved to PAGE0 for program allocation */

//   BOOT_RSVD       : origin = 0x000002, length = 0x000120     /* Part of M0, BOOT rom will use this for stack */
//   RAMM1           : origin = 0x000400, length = 0x0003F8     /* on-chip RAM block M1 */
// RAMM1_RSVD      : origin = 0x0007F8, length = 0x000008     /* Reserve and do not use for code as per the errata advisory "Memory: Prefetching Beyond Valid Memory" */
//   RAMD1           : origin = 0x00B800, length = 0x000800
   RAMD01          	: origin = 0x00B800, length = 0x000800
   /*
    * No RAMLS block is declared for CPU2, deliberately.
    *
    * The LSx RAMs are per-subsystem, not shared silicon - each CPU has its
    * own LS0..LS5 at the same addresses, the way each has its own flash bank.
    * (MemCfg bears this out: GSxRAM has a CPU1/CPU2 controller select,
    * LSxRAM has only CPU-only/CPU+CLA1 - there is no arbitration to do.)
    * CPU2's .bss used to live in its own LS4/LS5 and has been moved to
    * RAMGS12/RAMGS13, which were entirely empty.
    *
    * The point is not a collision - there was none - but ownership: LS4 and
    * LS5 are now CLA1 program and data on CPU1, and CPU2's CLA is reserved
    * for the ADS131M08 current loop in a later phase. Leaving no RAMLS block
    * here means a future CPU2 CLA starts from a blank slate rather than
    * having to evict .bss first.
    */
   RAMGS11          : origin = 0x017000, length = 0x001000     /* Only Available on F28379D, F28377D, F28375D devices. Remove line on other devices. */
   RAMGS12          : origin = 0x018000, length = 0x001000     /* Only Available on F28379D, F28377D, F28375D devices. Remove line on other devices. */
   RAMGS13          : origin = 0x019000, length = 0x001000     /* Only Available on F28379D, F28377D, F28375D devices. Remove line on other devices. */


   CPU2TOCPU1RAM   : origin = 0x03F800, length = 0x000400
   CPU1TOCPU2RAM   : origin = 0x03FC00, length = 0x000400

   CANA_MSG_RAM     : origin = 0x049000, length = 0x000800
   CANB_MSG_RAM     : origin = 0x04B000, length = 0x000800
}

SECTIONS
{
   /* Allocate program areas: */
   .cinit              : >> FLASHA | FLASHB,      PAGE = 0, ALIGN(4)
   .init_array         : > FLASHE,     PAGE = 0, ALIGN(4)
   .text               : >> FLASHF | FLASHG | FLASHH | FLASHI      PAGE = 0, ALIGN(4)
   codestart           : > BEGIN       PAGE = 0, ALIGN(4)
   GROUP
    {
        .TI.ramfunc
        ramfuncs
    }
        LOAD = FLASHD,
        RUN = RAMGS14,
        LOAD_START(RamfuncsLoadStart),
        LOAD_SIZE(RamfuncsLoadSize),
        LOAD_END(RamfuncsLoadEnd),
        RUN_START(RamfuncsRunStart),
        RUN_SIZE(RamfuncsRunSize),
        RUN_END(RamfuncsRunEnd),
        PAGE = 0, ALIGN(4)

    GROUP
    {
        isrcodefuncs
        dclfuncs
    }    LOAD = FLASHC,
         RUN =  RAMGS15,
         LOAD_START(isrcodefuncsLoadStart),
         LOAD_SIZE(isrcodefuncsLoadSize),
         LOAD_END(isrcodefuncsLoadEnd),
         RUN_START(isrcodefuncsRunStart),
         RUN_SIZE(isrcodefuncsRunSize),
         RUN_END(isrcodefuncsRunEnd),
         PAGE = 0, ALIGN(4)

   /* Allocate uninitalized data sections: */
   .stack             : > RAMD01             PAGE = 1
   .bss               : >> RAMGS12 | RAMGS13   PAGE = 1
   .sysmem            : > RAMGS11            PAGE = 1
   .data           	  : >> RAMD01 | RAMGS12  PAGE = 1   //added from COFF to EABI

   /*
    * Initialized sections. CPU2 has its own complete flash bank, so the
    * sector names here are CPU2's own A..N - they do not collide with the
    * identically-named sectors in the CPU1 linker.
    */
   .const             : >> FLASHJ | FLASHK | FLASHL      PAGE = 0, ALIGN(4)
   .switch            : >> FLASHL | FLASHK      PAGE = 0, ALIGN(4)

   .reset              : > RESET,     PAGE = 0, TYPE = DSECT /* not used, */

   /* device.c unconditionally copies the CLA constants when _FLASH is
      defined, so these symbols must be defined on CPU2 too. CPU2 runs no CLA
      code, so the section is empty and the copy is a no-op. */
   .const_cla       :  LOAD = FLASHM, PAGE = 0,
                       RUN = RAMGS13, PAGE = 1,
                       RUN_START(Cla1ConstRunStart),
                       LOAD_START(Cla1ConstLoadStart),
                       LOAD_SIZE(Cla1ConstLoadSize)

   /* Same story for the CLA program image, which device.c now also copies
      unconditionally. CPU1 runs a CLA task and CPU2 does not, so on this core
      Cla1Prog is empty and Cla1funcsLoadSize resolves to zero - the memcpy
      copies nothing. The symbols exist only so the link succeeds. */
   Cla1Prog         :  LOAD = FLASHM, PAGE = 0,
                       RUN = RAMGS13, PAGE = 1,
                       LOAD_START(Cla1funcsLoadStart),
                       LOAD_END(Cla1funcsLoadEnd),
                       RUN_START(Cla1funcsRunStart),
                       LOAD_SIZE(Cla1funcsLoadSize)

   /* The following section definitions are required when using the IPC API
      Drivers. On CPU2 the Put side is CPU2->CPU1 and the Get side is
      CPU1->CPU2 - the mirror of the CPU1 linker file. */
    GROUP : > CPU2TOCPU1RAM, PAGE = 1
    {
        PUTBUFFER
        PUTWRITEIDX
        GETREADIDX
    }

    GROUP : > CPU1TOCPU2RAM, PAGE = 1
    {
        GETBUFFER :    TYPE = DSECT
        GETWRITEIDX :  TYPE = DSECT
        PUTREADIDX :   TYPE = DSECT
    }

   /*
    * Application shared data. Mirror image of the CPU1 linker file - the
    * origins and lengths must match exactly. From CPU2's point of view:
    *   CPU2TOCPU1RAM  - CPU2 writes, CPU1 reads (registers, ipcMsg,
    *                    calibrationData)
    *   CPU1TOCPU2RAM  - CPU1 writes, CPU2 reads (canData, cpu1Status,
    *                    startup_mode, startup_enable). NOLOAD so CPU2's
    *                    image does not initialise memory that CPU1 owns.
    */
    CPU2TOCPU1RAM      : > CPU2TOCPU1RAM, PAGE = 1
    CPU1TOCPU2RAM      : > CPU1TOCPU2RAM, PAGE = 1, TYPE = NOLOAD

   /* IPC message-queue buffers used by the driverlib IPC message API */
    MSGRAM_CPU2_TO_CPU1 : > CPU2TOCPU1RAM, PAGE = 1
    MSGRAM_CPU1_TO_CPU2 : > CPU1TOCPU2RAM, PAGE = 1, TYPE = NOLOAD

}

/*
//===========================================================================
// End of file.
//===========================================================================
*/
