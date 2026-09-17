
MEMORY
{
PAGE 0 :  /* Program Memory */
          /* Memory (RAM/FLASH) blocks can be moved to PAGE1 for data allocation */
          /* BEGIN is used for the "boot to Flash" bootloader mode   */

   BEGIN            : origin = 0x0B0000, length = 0x000002
   RAMGS14          : origin = 0x01A000, length = 0x001000
   RAMGS15          : origin = 0x01B000, length = 0x00FF8
// RAMGS15_RSVD     : origin = 0x01BFF8, length = 0x000008  /* Reserve and do not use for code as per the errata advisory "Memory: Prefetching Beyond Valid Memory" */
                                                            /* Only on F28379D, F28377D, F28375D devices. Remove line on other devices. */
   RESET           	: origin = 0x3FFFC0, length = 0x000002

   /* Flash sectors - CPU2 owns FLASHJ..FLASHN. FLASHA..FLASHI belong to
      CPU1 (see 2837xD_RAM_lnk_cpu1.cmd) and must not be referenced here. */
   FLASHJ_START     : origin = 0x0B0002, length = 0x007FFE	/* on-chip Flash, less the codestart branch */
   FLASHK           : origin = 0x0B8000, length = 0x002000	/* on-chip Flash */
   FLASHL           : origin = 0x0BA000, length = 0x002000	/* on-chip Flash */
   FLASHM           : origin = 0x0BC000, length = 0x002000	/* on-chip Flash */
   FLASHN           : origin = 0x0BE000, length = 0x002000	/* on-chip Flash */

PAGE 1 : /* Data Memory */
         /* Memory (RAM/FLASH) blocks can be moved to PAGE0 for program allocation */

//   BOOT_RSVD       : origin = 0x000002, length = 0x000120     /* Part of M0, BOOT rom will use this for stack */
//   RAMM1           : origin = 0x000400, length = 0x0003F8     /* on-chip RAM block M1 */
// RAMM1_RSVD      : origin = 0x0007F8, length = 0x000008     /* Reserve and do not use for code as per the errata advisory "Memory: Prefetching Beyond Valid Memory" */
//   RAMD1           : origin = 0x00B800, length = 0x000800
   RAMD01          	: origin = 0x00B800, length = 0x000800
   /* The F2837xD has LS0..LS5 only, spanning 0x008000..0x00AFFF.
      CPU1 takes LS0..LS3 (0x008000..0x009FFF), CPU2 takes LS4..LS5
      (0x00A000..0x00AFFF). A 0x2000 length here would run into RAMD01. */
   RAMLS4_5         : origin = 0x00A000, length = 0x001000
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
   .cinit              : >> FLASHJ_START | FLASHK | FLASHL,      PAGE = 0, ALIGN(4)
   .init_array         : > FLASHL,     PAGE = 0, ALIGN(4)
   .text               : >> FLASHJ_START | FLASHK | FLASHL      PAGE = 0, ALIGN(4)
   codestart           : > BEGIN       PAGE = 0, ALIGN(4)
   GROUP
    {
        .TI.ramfunc
        ramfuncs
    }
        LOAD = FLASHN,
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
    }    LOAD = FLASHM,
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
   .bss               : >> RAMLS4_5 | RAMGS12 | RAMGS13   PAGE = 1
   .sysmem            : > RAMGS11            PAGE = 1
   .data           	  : >> RAMD01 | RAMGS12  PAGE = 1   //added from COFF to EABI

   /* Initalized sections go in Flash - CPU2 sectors only.
      FLASHB/F/G/H belong to CPU1 and must not be referenced here. */
   .const             : >> FLASHK | FLASHL | FLASHJ_START      PAGE = 0, ALIGN(4)
   .switch            : >> FLASHL | FLASHK      PAGE = 0, ALIGN(4)

   .reset              : > RESET,     PAGE = 0, TYPE = DSECT /* not used, */

   /* device.c unconditionally copies the CLA constants when _FLASH is
      defined, so these symbols must be defined on CPU2 too. CPU2 runs no CLA
      code, so the section is empty and the copy is a no-op. */
   .const_cla       :  LOAD = FLASHL, PAGE = 0,
                       RUN = RAMGS13, PAGE = 1,
                       RUN_START(Cla1ConstRunStart),
                       LOAD_START(Cla1ConstLoadStart),
                       LOAD_SIZE(Cla1ConstLoadSize)

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
