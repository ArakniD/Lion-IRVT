//*****************************************************************************
//
//  f2837xd_pinmux.h - Created using TI Pinmux 1.7.0+1616 on 3/1/2021 at 8:21:48 PM.
//
//*****************************************************************************
//
// Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
//
//   Redistributions of source code must retain the above copyright
//   notice, this list of conditions and the following disclaimer.
//
//   Redistributions in binary form must reproduce the above copyright
//   notice, this list of conditions and the following disclaimer in the
//   documentation and/or other materials provided with the
//   distribution.
//
//   Neither the name of Texas Instruments Incorporated nor the names of
//   its contributors may be used to endorse or promote products derived
//   from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//*****************************************************************************
//
//  These values will provide the functionality requested when written into
//  the registers for which the #defines are named.  For example, using the
//  C2000Ware device support header files, use the defines like in this
//  sample function:
//
//  void samplePinMuxFxn(void)
//  {
//      EALLOW;
//      //
//      // Write generated values to mux registers
//      //
//      GpioCtrlRegs.GPAMUX1.all  = GPAMUX1_VALUE;
//      GpioCtrlRegs.GPAMUX2.all  = GPAMUX2_VALUE;
//      GpioCtrlRegs.GPBMUX1.all  = GPBMUX1_VALUE;
//        . . .
//      EDIS;
//  }
//
//  NOTE:  These GPIO control registers are only available on CPU1.
//
//*****************************************************************************

//
// Port A mux register values
//
// Pin T11 (GPIO30) to CANRXA (mode 1)
// Pin U11 (GPIO31) to CANTXA (mode 1)
// Pin K1 (GPIO26) to GPIO26 (mode 0)
// Pin L1 (GPIO27) to GPIO27 (mode 0)
// Pin C8 (GPIO0) to GPIO0 (mode 0)
// Pin W11 (GPIO29) to SCITXDA (mode 1)
// Pin E1 (GPIO16) to SPISIMOA (mode 1)
// Pin E3 (GPIO18) to SPICLKA (mode 1)
// Pin E2 (GPIO17) to SPISOMIA (mode 1)
#define GPAMUX1_MASK		0x00000003
#define GPAMUX2_MASK		0xfcf0003f
#define GPAMUX1_VALUE		0x00000000
#define GPAMUX2_VALUE		0x54000015
#define GPAGMUX1_VALUE		0x00000000
#define GPAGMUX2_VALUE		0x00000000

//
// Port B mux register values
//
// Pin P18 (GPIO54) to GPIO54 (mode 0)
// Pin P19 (GPIO55) to GPIO55 (mode 0)
// Pin N16 (GPIO56) to GPIO56 (mode 0)
// Pin N18 (GPIO57) to GPIO57 (mode 0)
// Pin N17 (GPIO58) to GPIO58 (mode 0)
// Pin M16 (GPIO59) to GPIO59 (mode 0)
// Pin U14 (GPIO34) to GPIO34 (mode 0)
// Pin W17 (GPIO39) to GPIO39 (mode 0)
// Pin K18 (GPIO44) to GPIO44 (mode 0)
// Pin K19 (GPIO45) to GPIO45 (mode 0)
// Pin E19 (GPIO46) to GPIO46 (mode 0)
// Pin E18 (GPIO47) to GPIO47 (mode 0)
// Pin V17 (GPIO40) to SDAB (mode 6)
// Pin U17 (GPIO41) to SCLB (mode 6)
// Pin U13 (GPIO32) to SDAA (mode 1)
// Pin T13 (GPIO33) to SCLA (mode 1)
// Pin R18 (GPIO50) to SPISIMOC (mode 6)
// Pin P16 (GPIO52) to SPICLKC (mode 6)
// Pin R19 (GPIO51) to SPISOMIC (mode 6)
#define GPBMUX1_MASK		0xff0fc03f
#define GPBMUX2_MASK		0x00fff3f0
#define GPBMUX1_VALUE		0x000a0005
#define GPBMUX2_VALUE		0x000002a0
#define GPBGMUX1_VALUE		0x00050000
#define GPBGMUX2_VALUE		0x00000150

//
// Port C mux register values
//
#define GPCMUX1_MASK		0x00000000
#define GPCMUX2_MASK		0x00000000
#define GPCMUX1_VALUE		0x00000000
#define GPCMUX2_VALUE		0x00000000
#define GPCGMUX1_VALUE		0x00000000
#define GPCGMUX2_VALUE		0x00000000

//
// Port D mux register values
//
// Pin U8 (GPIO123) to SD1_C1 (mode 7)
// Pin T8 (GPIO122) to SD1_D1 (mode 7)
// Pin T9 (GPIO125) to SD1_C2 (mode 7)
// Pin V8 (GPIO124) to SD1_D2 (mode 7)
#define GPDMUX1_MASK		0x00000000
#define GPDMUX2_MASK		0x0ff00000
#define GPDMUX1_VALUE		0x00000000
#define GPDMUX2_VALUE		0x0ff00000
#define GPDGMUX1_VALUE		0x00000000
#define GPDGMUX2_VALUE		0x05500000

//
// Port E mux register values
//
#define GPEMUX1_MASK		0x00000000
#define GPEMUX2_MASK		0x00000000
#define GPEMUX1_VALUE		0x00000000
#define GPEMUX2_VALUE		0x00000000
#define GPEGMUX1_VALUE		0x00000000
#define GPEGMUX2_VALUE		0x00000000

//
// Port F mux register values
//
#define GPFMUX1_MASK		0x00000000
#define GPFMUX1_VALUE		0x00000000
#define GPFGMUX1_VALUE		0x00000000

//
// Port B analog mode register values
//
#define GPBAMSEL_MASK		0x00000000
#define GPBAMSEL_VALUE		0x00000000

//*****************************************************************************
//
// Function prototype for function to write values above into their
// corresponding registers. This function is found in f2837xd_pinmux.c. Its use
// is completely optional.
//
//*****************************************************************************
extern void GPIO_setPinMuxConfig(void);
