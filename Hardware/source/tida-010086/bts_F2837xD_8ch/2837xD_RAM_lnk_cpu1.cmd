/*
 * CLA1 support.
 *
 * CLA_SCRATCHPAD_SIZE and the two --undef_sym directives are what the
 * compiler's CLA C support expects: --cla_support=cla1 emits references to
 * __cla_scratchpad_start/__cla_scratchpad_end for the CLA's compiler-managed
 * local frame, and the CLAscratch section below reserves the space between
 * them. Without the --undef_sym lines the linker drops the symbols before the
 * CLAscratch directive can place them.
 */
CLA_SCRATCHPAD_SIZE = 0x100;
--undef_sym=__cla_scratchpad_end
--undef_sym=__cla_scratchpad_start

MEMORY
{
PAGE 0 :  /* Program Memory */
          /* Memory (RAM/FLASH) blocks can be moved to PAGE1 for data allocation */
          /* BEGIN is used for the "boot to Flash" bootloader mode   */
   RAMLS0           : origin = 0x008000, length = 0x000800

   /*
    * LS4 and LS5 are CLA1's. They are CPU1-subsystem RAM, not shared silicon:
    * CPU2's linker used to place its .bss here and no longer does - see
    * 2837xD_RAM_lnk_cpu2.cmd, which now sends .bss to RAMGS12/RAMGS13.
    *
    * Split into two blocks rather than TI's single RAMLS4_5 because the
    * program/data selection (LSxCLAPGM) is per-LS-block: LS4 is handed to the
    * CLA as program memory and LS5 as data memory, so each needs its own
    * MEMORY range. Keeping the CLA's data here instead of sharing LS1..LS3
    * leaves .bss purely CPU-owned, so the control ISR never arbitrates with
    * the CLA for a RAM port.
    */
   RAMLS4           : origin = 0x00A000, length = 0x000800
   RAMLS5           : origin = 0x00A800, length = 0x000800

   BEGIN           	: origin = 0x080000, length = 0x000002
   RAMM0           	: origin = 0x000122, length = 0x0002DE

   RAMGS0      		: origin = 0x00C000, length = 0x001000
   RAMGS1      		: origin = 0x00D000, length = 0x001000
   RAMGS2      		: origin = 0x00E000, length = 0x001000
   /* RAMGS9+RAMGS10 are contiguous and are combined into one 0x2000
      region for the ISR code group. With all eight control loops
      compiled in, isrcodefuncs+dclfuncs no longer fits in a single
      0x1000 block. The Filter4/Difference_RegsFile sections that
      nominally sat here are unreferenced leftovers from the
      reference design. */
   RAMGS9_10   		: origin = 0x015000, length = 0x002000
   RESET           	: origin = 0x3FFFC0, length = 0x000002

   /* Flash sectors */
   FLASHA           : origin = 0x080002, length = 0x001FFE	/* on-chip Flash */
   FLASHB           : origin = 0x082000, length = 0x002000	/* on-chip Flash */
   FLASHC           : origin = 0x084000, length = 0x002000	/* on-chip Flash */
   FLASHD           : origin = 0x086000, length = 0x002000	/* on-chip Flash */
   FLASHE           : origin = 0x088000, length = 0x008000	/* on-chip Flash */
   FLASHF           : origin = 0x090000, length = 0x008000	/* on-chip Flash */
   FLASHG           : origin = 0x098000, length = 0x008000	/* on-chip Flash */
   FLASHH           : origin = 0x0A0000, length = 0x008000	/* on-chip Flash */
   FLASHI           : origin = 0x0A8000, length = 0x008000	/* on-chip Flash */
   /*
    * FLASHJ..FLASHN are CPU1's too. Each CPU on the F2837xD has its OWN
    * complete flash bank, both mapped at the same addresses - CPU2's linker
    * names the same sectors and they are different silicon, not a shared
    * region. Verified on hardware: 0x090000 reads code from CPU1 and 0xFFFF
    * from CPU2. TI's reference MEMORY blocks for the two cores are identical.
    */
   FLASHJ           : origin = 0x0B0000, length = 0x008000	/* on-chip Flash */
   FLASHK           : origin = 0x0B8000, length = 0x002000	/* on-chip Flash */
   FLASHL           : origin = 0x0BA000, length = 0x002000	/* on-chip Flash */
   FLASHM           : origin = 0x0BC000, length = 0x002000	/* on-chip Flash */
   FLASHN           : origin = 0x0BE000, length = 0x001FF0	/* on-chip Flash */
// FLASHN_RSVD      : origin = 0x0BFFF0, length = 0x000010    /* Reserve and do not use for code as per the errata advisory "Memory: Prefetching Beyond Valid Memory" */

PAGE 1 : /* Data Memory */
         /* Memory (RAM/FLASH) blocks can be moved to PAGE0 for program allocation */

   BOOT_RSVD        : origin = 0x000002, length = 0x000120     /* Part of M0, BOOT rom will use this for stack */
   RAMM1            : origin = 0x000400, length = 0x0003F8     /* on-chip RAM block M1 */
// RAMM1_RSVD       : origin = 0x0007F8, length = 0x000008     /* Reserve and do not use for code as per the errata advisory "Memory: Prefetching Beyond Valid Memory" */
   RAMD00          	: origin = 0x00B000, length = 0x000800
   /*
    * LS0 is split off onto PAGE 0 so CPU1's ramfuncs can RUN from local RAM
    * rather than a shared GSx block - see the note on the ramfuncs GROUP.
    * LS1..LS3 stay on PAGE 1 for .bss.
    */
   RAMLS1_3         : origin = 0x008800, length = 0x001800

   RAMGS3     		: origin = 0x00F000, length = 0x001000
   RAMGS4     		: origin = 0x010000, length = 0x001000
   RAMGS5     		: origin = 0x011000, length = 0x001000
   RAMGS6     		: origin = 0x012000, length = 0x001000
   RAMGS7      		: origin = 0x013000, length = 0x001000
   RAMGS8      		: origin = 0x014000, length = 0x001000

   /*
    * CLA1 message RAMs. Fixed addresses in the device memory map: the low
    * block is CLA-write / CPU-read and the high block CPU-write / CLA-read.
    * Declared for completeness so any object emitting the standard
    * Cla1ToCpuMsgRAM / CpuToCla1MsgRAM sections links; this design keeps its
    * shared data in LS5 instead, which is large enough for the whole filter
    * state where these 0x80-word windows are not.
    */
   CLA1_MSGRAMLOW   : origin = 0x001480, length = 0x000080
   CLA1_MSGRAMHIGH  : origin = 0x001500, length = 0x000080

   CPU2TOCPU1RAM   : origin = 0x03F800, length = 0x000400
   CPU1TOCPU2RAM   : origin = 0x03FC00, length = 0x000400

   CANA_MSG_RAM     : origin = 0x049000, length = 0x000800
   CANB_MSG_RAM     : origin = 0x04B000, length = 0x000800
}

SECTIONS
{
   /* Allocate program areas: */
   .cinit              : > FLASHA | FLASHB,      PAGE = 0, ALIGN(4)
   .init_array         : > FLASHE,     PAGE = 0, ALIGN(4)
   .text               : >> FLASHF | FLASHG | FLASHH | FLASHI      PAGE = 0, ALIGN(4)
   codestart           : > BEGIN       PAGE = 0, ALIGN(4)

   /*
    * RUN = RAMLS0, deliberately NOT a global-shared (GSx) block.
    *
    * CCS programs flash by downloading a flash algorithm into target RAM and
    * executing it there, and for a CPU2 load that algorithm is staged in
    * RAMGS0 - the GSx blocks are shared silicon reachable from either core's
    * debug access. These functions used to RUN at RAMGS0 (0x00C000), so
    * every `loadProgram` on CPU2 overwrote CPU1's live ramfuncs underneath
    * it. CPU1 then called BTS_monitor_Iout_Vout() from C1(), landed in the
    * flash algorithm, and took an illegal-instruction trap into
    * Interrupt_illegalOperationHandler() - an infinite loop that froze
    * cpu1Status.seq and killed the host link.
    *
    * Verified at 0x00C128: correct code 0xB2BD 0xD098 after CPU1's own
    * memcpy, reverting to the algorithm's 0x01F6 0xFFEF after a CPU2 load.
    *
    * RAMLS0 (0x008000-0x0087FF) is CPU1-local - CPU2's linker only claims
    * LS4/LS5 - so the programmer cannot reach it and the two cores can be
    * loaded in either order. Shares the block with .bss, which has room:
    * ramfuncs is 0x2C0 words against LS0's 0x800.
    */
   GROUP
    {
        .TI.ramfunc
        ramfuncs
    }
        LOAD = FLASHD,
        RUN = RAMLS0,
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
         RUN =  RAMGS9_10,
         LOAD_START(isrcodefuncsLoadStart),
         LOAD_SIZE(isrcodefuncsLoadSize),
         LOAD_END(isrcodefuncsLoadEnd),
         RUN_START(isrcodefuncsRunStart),
         RUN_SIZE(isrcodefuncsRunSize),
         RUN_END(isrcodefuncsRunEnd),
         PAGE = 0, ALIGN(4)

   /* Allocate uninitalized data sections: */
   .stack             : > RAMD00             PAGE = 1
   .bss               : >> RAMLS1_3          PAGE = 1
   .sysmem            : > RAMGS3             PAGE = 1
   .data           	  : >> RAMM1 | RAMD00    PAGE = 1   //added from COFF to EABI

   /* Initalized sections go in Flash */
   .const             : >> FLASHF | FLASHG | FLASHH      PAGE = 0, ALIGN(4)
   .switch             : > FLASHB      PAGE = 0, ALIGN(4)

   .reset              : > RESET,     PAGE = 0, TYPE = DSECT /* not used, */

   Filter_RegsFile     : > RAMGS4,	  PAGE = 1

   SHARERAMGS0		: > RAMGS4,		PAGE = 1
   SHARERAMGS1		: > RAMGS5,		PAGE = 1
   ramgs0           : > RAMGS4,     PAGE = 1
   ramgs1           : > RAMGS5,     PAGE = 1

   controlVariables : > RAMGS6,  PAGE = 1

   /*
    * ==================== CLA1 ====================
    *
    * Everything the CLA touches must live in an LSx block. The CLA's address
    * bus is only 16 bits wide (TRM 6.7.2), so RAMGS/RAMM/flash are all out of
    * reach - .scratchpad, .bss_cla and .const_cla used to sit in RAMGS6/RAMGS2
    * where no CLA could ever have read them. They were inert because no CLA
    * code existed; they are real now.
    *
    * LS4 is program, LS5 is data. bts_cpu1.c hands both blocks to the CLA and
    * sets LSxCLAPGM accordingly in BTS_initCla().
    */
   Cla1Prog         :  LOAD = FLASHK,
                       RUN = RAMLS4,
                       LOAD_START(Cla1funcsLoadStart),
                       LOAD_END(Cla1funcsLoadEnd),
                       RUN_START(Cla1funcsRunStart),
                       LOAD_SIZE(Cla1funcsLoadSize),
                       PAGE = 0, ALIGN(8)

   /*
    * CLA local data. CLADataLS5 carries this design's filter state, which is
    * defined in C (bts_cla_data.c) - the CLA compiler cannot export a symbol
    * the C28x linker will resolve, so anything both sides touch is a C object
    * placed here by #pragma DATA_SECTION.
    */
   CLADataLS5       : > RAMLS5,  PAGE = 0
   .scratchpad      : > RAMLS5,  PAGE = 0
   .bss_cla         : > RAMLS5,  PAGE = 0

   CLAscratch       : { *.obj(CLAscratch)
                        . += CLA_SCRATCHPAD_SIZE;
                        *.obj(CLAscratch_end) }
                    > RAMLS5,  PAGE = 0

   /*
    * device.c copies this unconditionally when _FLASH is defined, so the
    * LOAD/RUN symbols have to exist whether or not the CLA has any constants.
    */
   .const_cla       :  LOAD = FLASHL,
                       RUN = RAMLS5,
                       RUN_START(Cla1ConstRunStart),
                       LOAD_START(Cla1ConstLoadStart),
                       LOAD_SIZE(Cla1ConstLoadSize),
                       PAGE = 0, ALIGN(4)

   Cla1ToCpuMsgRAM  : > CLA1_MSGRAMLOW,   PAGE = 1
   CpuToCla1MsgRAM  : > CLA1_MSGRAMHIGH,  PAGE = 1

   /* The following section definitions are required when using the IPC API Drivers */
    GROUP : > CPU1TOCPU2RAM, PAGE = 1
    {
        PUTBUFFER
        PUTWRITEIDX
        GETREADIDX
    }

    GROUP : > CPU2TOCPU1RAM, PAGE = 1
    {
        GETBUFFER :    TYPE = DSECT
        GETWRITEIDX :  TYPE = DSECT
        PUTREADIDX :   TYPE = DSECT
    }

   /*
    * Application shared data.
    *
    * The F2837xD message RAMs are single-writer. From CPU1's point of view:
    *   CPU1TOCPU2RAM  - CPU1 writes, CPU2 reads (canData, cpu1Status,
    *                    startup_mode, startup_enable)
    *   CPU2TOCPU1RAM  - CPU2 writes, CPU1 reads (registers, ipcMsg,
    *                    calibrationData). Marked NOLOAD so CPU1's image does
    *                    not initialise memory that CPU2 owns.
    *
    * Both cores must keep these origins/lengths identical - see
    * 2837xD_RAM_lnk_cpu2.cmd.
    */
    CPU1TOCPU2RAM      : > CPU1TOCPU2RAM, PAGE = 1
    CPU2TOCPU1RAM      : > CPU2TOCPU1RAM, PAGE = 1, TYPE = NOLOAD

   /* IPC message-queue buffers used by the driverlib IPC message API */
    MSGRAM_CPU1_TO_CPU2 : > CPU1TOCPU2RAM, PAGE = 1
    MSGRAM_CPU2_TO_CPU1 : > CPU2TOCPU1RAM, PAGE = 1, TYPE = NOLOAD

   /* The following section definition are for SDFM examples */
   Filter1_RegsFile : > RAMGS6,	PAGE = 1, fill=0x1111
   Filter2_RegsFile : > RAMGS7,	PAGE = 1, fill=0x2222
   Filter3_RegsFile : > RAMGS8,	PAGE = 1, fill=0x3333


    SFRA_F32_Data : > RAMGS4, ALIGN = 64, PAGE = 1

 	//FPUmathTables	: > FLASHN, PAGE = 0
    FPUmathTables	: > RAMGS4, PAGE =1

 	cntl_coeff_RAM	: > RAMGS4, PAGE = 1
 	cntl_var_RAM	: > RAMGS5, PAGE = 1

 	cntl_coeff_RAM2	: > RAMGS4, PAGE = 1
 	cntl_var_RAM2	: > RAMGS5, PAGE = 1

}

/*
//===========================================================================
// End of file.
//===========================================================================
*/
