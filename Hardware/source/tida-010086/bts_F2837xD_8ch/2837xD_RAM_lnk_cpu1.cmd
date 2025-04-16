
MEMORY
{
PAGE 0 :  /* Program Memory */
          /* Memory (RAM/FLASH) blocks can be moved to PAGE1 for data allocation */
          /* BEGIN is used for the "boot to Flash" bootloader mode   */

   BEGIN           	: origin = 0x080000, length = 0x000002
   RAMM0           	: origin = 0x000122, length = 0x0002DE

   RAMGS0      		: origin = 0x00C000, length = 0x001000
   RAMGS1      		: origin = 0x00D000, length = 0x001000
   RAMGS2      		: origin = 0x00E000, length = 0x001000
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

PAGE 1 : /* Data Memory */
         /* Memory (RAM/FLASH) blocks can be moved to PAGE0 for program allocation */

   BOOT_RSVD        : origin = 0x000002, length = 0x000120     /* Part of M0, BOOT rom will use this for stack */
   RAMM1            : origin = 0x000400, length = 0x0003F8     /* on-chip RAM block M1 */
// RAMM1_RSVD       : origin = 0x0007F8, length = 0x000008     /* Reserve and do not use for code as per the errata advisory "Memory: Prefetching Beyond Valid Memory" */
   RAMD00          	: origin = 0x00B000, length = 0x000800
   RAMLS0_3         : origin = 0x008000, length = 0x002000

   RAMGS3     		: origin = 0x00F000, length = 0x001000
   RAMGS4     		: origin = 0x010000, length = 0x001000
   RAMGS5     		: origin = 0x011000, length = 0x001000
   RAMGS6     		: origin = 0x012000, length = 0x001000
   RAMGS7      		: origin = 0x013000, length = 0x001000
   RAMGS8      		: origin = 0x014000, length = 0x001000
   RAMGS9      		: origin = 0x015000, length = 0x001000
   RAMGS10     		: origin = 0x016000, length = 0x001000

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

   GROUP
    {
        .TI.ramfunc
        {
            -l sfra_f32_tmu_eabi.lib
        }
        ramfuncs
    }
        LOAD = FLASHD,
        RUN = RAMGS0,
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
         RUN =  RAMGS1,
         LOAD_START(isrcodefuncsLoadStart),
         LOAD_SIZE(isrcodefuncsLoadSize),
         LOAD_END(isrcodefuncsLoadEnd),
         RUN_START(isrcodefuncsRunStart),
         RUN_SIZE(isrcodefuncsRunSize),
         RUN_END(isrcodefuncsRunEnd),
         PAGE = 0, ALIGN(4)

   /* Allocate uninitalized data sections: */
   .stack             : > RAMD00             PAGE = 1
   .bss               : >> RAMLS0_3          PAGE = 1
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

   .scratchpad      : > RAMGS6, PAGE = 1
   .bss_cla         : > RAMGS6,  PAGE = 1
   controlVariables : > RAMGS6,  PAGE = 1

   .const_cla       :  LOAD = FLASHL,
                       RUN = RAMGS2,
                       RUN_START(Cla1ConstRunStart),
                       LOAD_START(Cla1ConstLoadStart),
                       LOAD_SIZE(Cla1ConstLoadSize),
                       PAGE = 0

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

   /* The following section definition are for SDFM examples */
   Filter1_RegsFile : > RAMGS6,	PAGE = 1, fill=0x1111
   Filter2_RegsFile : > RAMGS7,	PAGE = 1, fill=0x2222
   Filter3_RegsFile : > RAMGS8,	PAGE = 1, fill=0x3333
   Filter4_RegsFile : > RAMGS9,	PAGE = 1, fill=0x4444
   Difference_RegsFile : >RAMGS10, 	PAGE = 1, fill=0x3333


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
