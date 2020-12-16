/*
 * Copyright (c) 2018 Texas Instruments Incorporated - http://www.ti.com
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * *  Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * *  Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * *  Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

/*
 *  ======== TIDM_DC_DC_BUCK.syscfg.js ========
 *
 * Module that defines and populates SysConfig GUI
 */

"use strict";
let Common  = system.getScript("/devkits/Common.js").Common;

/* read solution.js, get kit properties*/
let solution = system.getScript("/solution.js").$solution;
let kitName = solution.kit.name;
let kitType = solution.kit.type;
let kitDevice = solution.kit.device;

/* powerStage values, this may be temporary */
let powerStage = system.getScript("/Kit.json");

/* Device specific intro splash on GUI */
let longDescription = "![](../source/devkits/.meta/" + kitName + "/"  + kitType + "/" + kitDevice + "/KitPowerStage.png)";

let PLANT = powerStage.MODEL.PLANT;
let COMP_OPTIONS = powerStage.MODEL.COMP_OPTIONS;

/* LP / Device Parameters */
let def_Site        = solution.LP_site;
let def_Fsw         = solution.Fsw_kHz;
let def_RampDec     = solution.RampDec;

/* Comp Designer */
let vmc_ModelId     = 1;   // 1=BUCK VMC
let vmc_CompNum     = 1;   // COMP[0]+1
let vmc_CompStyle   = 12;  // 12=DCL_DF22
let vmc_ModelStyle  = 0;   // 0=Math, 1=SFRA
let vmc_Kpwm        = 1;   // ??
let vmc_CompLimit   = 16;  // Caution if coeff > Limit

let pcmc_ModelId    = 1;  // 1=BUCK VMC
let pcmc_CompNum    = 2;  // COMP[1]+1
let pcmc_CompStyle  = 1;  // 1=PID
let pcmc_ModelStyle = 0;  // 0=Math, 1=SFRA
let pcmc_Kpwm       = 1;   // ??
let pcmc_CompLimit  = 16;  // Caution if coeff > Limit

/* Misc */
let pi              = 3.141592653589;
let adc_fullscale   = 3.3;

/* BP Parameters */
let def_Vin         = 9;
let def_Vout        = 2;
let def_Rload       = 1.6;
let def_Iload       = 1.3;
let def_L           = 4.8;
let def_Ldcr        = 0.0105;
let def_Celec       = 330;
let def_ESRelec     = 0.15;
let def_ESLelec     = 0.0;
let def_Ccer        = 66;
let def_ESRcer      = 0.002;
let def_ESLcer      = 0.0;
let def_Ra_Vi       = 1000;
let def_Rb_Vi       = 330;
let def_MaxSenseVi  = 13.3;
let def_Rc_Vo       = 340;
let def_Rd_Vo       = 330;
let def_MaxSenseVo  = 6.7;
let def_Rvos        = 1000;
let def_Cvos        = 3.3;
let def_CutOffVo    = 41.3;
let def_Rcs         = 0.03;
let def_Igain       = 14.63;
let def_MaxSenseI   = 7.52;
let def_Rcs_trip    = 150;
let def_Ccs_trip    = 0.22;
let def_CutOffCtrip = 4822.9;
let def_Rcs_avg     = 1000;
let def_Ccs_avg     = 3.3;
let def_CutOffCavg  = 48.229;
let def_Rds1        = 0.008;
let def_Rds2        = 0.0029;

/* The GUI */
let config = [
    {
        /* Build Options group */
        displayName: "Build Options",
        description: "",
        collapsed: false,
        config: [
            {
                name: "LabNum",
                displayName: "Lab",
                default: 1,
                onChange: update_Lab,
                options: [
                    {displayName: "1: Open Loop VMC",             name: 1},
                    {displayName: "2: Closed Loop VMC",           name: 2},
                    {displayName: "3: Open Loop PCMC",            name: 3},
                    {displayName: "4: Closed Loop PCMC",          name: 4}
                ]
            },
            {
                name: "Fsw",
                displayName: "PWM Switching Frequency (kHz)",
                default: def_Fsw,
                onChange: recalc_IsrFreq
            },
            {
                name: "IsrRatio",
                displayName: "Control Loop ISR Ratio",
                default: 1,
                onChange: recalc_IsrFreq,
                options: [
                    {displayName: "Control ISR runs at Fsw",     name: 1},
                    {displayName: "Control ISR runs at Fsw / 2", name: 2},
                    {displayName: "Control ISR runs at Fsw / 3", name: 3},
					{displayName: "Control ISR runs at Fsw / 4", name: 4},
					{displayName: "Control ISR runs at Fsw / 5", name: 5},
					{displayName: "Control ISR runs at Fsw / 6", name: 6},
					{displayName: "Control ISR runs at Fsw / 8", name: 8},
					{displayName: "Control ISR runs at Fsw / 10", name: 10}
                ]
            },
            {
                name: "IsrFreq",
                displayName: "Control Loop ISR Frequency (kHz)",
                readOnly: true,
                default: def_Fsw
            },
			
            {
                name: "Gain",
                displayName: "Set CC gain",
                default: 1,
                onChange: recalc_IsrFreq,
                options: [
                    {displayName: "Gain 1",     name: 1},
                    {displayName: "Gain 2", name: 2},
                    {displayName: "Gain 3", name: 3},
					{displayName: "Gain 4", name: 4}
                ]
            },
            {
                name: "RampDec",
                displayName: "Slope Compensation (16b RAMPDECVAL)",
                hidden: true,
                default: def_RampDec
            },
            {
                name: "SFRA",
                displayName: "Software Frequency Response Analyzer",
                buttonText: "Run SFRA",
                onLaunch: (inst) => {
                    return (Common.launchSFRA(inst));
                },
                onComplete: (inst, _ui, result) => {
                }
            },
            {
                name: "CompDesigner",
                displayName: "Compensation Designer",
                hidden: true,
                buttonText: "Run Compensation Designer",
                onLaunch: (inst) => {
                    return (Common.launchCompensationDesigner(powerStage));
                },
                onComplete: (inst, ui, result) => {
                    refreshKitJson(JSON.parse(result.data));
                }
            }
        ]
    },
    {
        displayName: "Power Stage Parameters",
        description: "",
        collapsed: false,
        config: [
            {
                name: "Hardware",
                displayName: "Hardware",
                description: "",
                collapsed: false,
                config: [
                    {
                        name: "PlantHw",
                        displayName: "Plant",
                        default: 1,
                        onChange: update_PlantHw,
                        options: [
                            {displayName: "Custom",           name: 0},
                            {displayName: "BOOSTXL-BUCKCONV", name: 1}
                        ]
                    },
                    {
                        name: "Site",
                        displayName: "LaunchPad Site",
                        default: def_Site,
                        options: [
                            {displayName: "Custom", name: 0},
                            {displayName: "Site 1", name: 1},
                            {displayName: "Site 2", name: 2}
                        ]
                    }
                ]
            },
            {
                name: "NominalValues",
                displayName: "Nominal Values",
                description: "",
                collapsed: false,
                config: [
                    {
                        name: "Vin",
                        displayName: "Vin (V)",
                        default: def_Vin,
                        readOnly: true,
                        onChange: updatePowerStage
                    },
                    {
                        name: "Vout",
                        displayName: "Vout (V)",
                        default: def_Vout,
                        readOnly: true,
                        onChange: recalc_Iload
                    },
                    {
                        name: "Rload",
                        displayName: "Rload (Ohm)",
                        default: def_Rload,
                        readOnly: true,
                        onChange: recalc_Iload
                    },
                    {
                        name: "Iload",
                        displayName: "Iload (A)",
                        default: def_Iload,
                        readOnly: true
                    }
                ]
            },
            {
                displayName: "Inductor",
                description: "",
                collapsed: false,
                config: [
                    {
                        name: "L",
                        displayName: "L (uH)",
                        default: def_L,
                        readOnly: true,
                        onChange: updatePowerStage
                    },
                    {
                        name: "Ldcr",
                        displayName: "DCR (Ohm)",
                        default: def_Ldcr,
                        readOnly: true,
                        onChange: updatePowerStage
                    }
                ]
            },
            {
                displayName: "Output Capacitors",
                description: "",
                collapsed: false,
                config: [
                    {
                        name: "Celec",
                        displayName: "Celec (uF)",
                        default: def_Celec,
                        readOnly: true,
                        onChange: updatePowerStage
                    },
                    {
                        name: "ESRelec",
                        displayName: "ESRelec (Ohm)",
                        default: def_ESRelec,
                        readOnly: true,
                        onChange: updatePowerStage
                    },
                    {
                        name: "ESLelec",
                        displayName: "ESLelec (uH)",
                        default: def_ESLelec,
                        readOnly: true,
                        hidden: true,
                        onChange: updatePowerStage
                    },
                    {
                        name: "Ccer",
                        displayName: "Ccer (uF)",
                        default: def_Ccer,
                        readOnly: true,
                        onChange: updatePowerStage
                    },
                    {
                        name: "ESRcer",
                        displayName: "ESRcer (Ohm)",
                        default: def_ESRcer,
                        readOnly: true,
                        onChange: updatePowerStage
                    },
                    {
                        name: "ESLcer",
                        displayName: "ESLcer (uH)",
                        default: def_ESLcer,
                        readOnly: true,
                        hidden: true,
                        onChange: updatePowerStage
                    }
                ]
            },
            {
                displayName: "Vin Sense",
                description: "",
                collapsed: false,
                config: [
                    {
                        name: "Ra_Vi",
                        displayName: "Ra_Vi (Ohm)",
                        default: def_Ra_Vi,
                        readOnly: true,
                        onChange: recalc_MaxSenseVi
                    },
                    {
                        name: "Rb_Vi",
                        displayName: "Rb_Vi (Ohm)",
                        default: def_Rb_Vi,
                        readOnly: true,
                        onChange: recalc_MaxSenseVi
                    },
                    {
                        name: "MaxSenseVi",
                        displayName: "Max Sense (V)",
                        default: def_MaxSenseVi,
                        readOnly: true
                    }
                ]
            },
            {
                displayName: "Vout Sense",
                description: "",
                collapsed: false,
                config: [
                    {
                        name: "Rc_Vo",
                        displayName: "Rc_Vo (Ohm)",
                        default: def_Rc_Vo,
                        readOnly: true,
                        onChange: recalc_Vsense
                    },
                    {
                        name: "Rd_Vo",
                        displayName: "Rd_Vo (Ohm)",
                        default: def_Rd_Vo,
                        readOnly: true,
                        onChange: recalc_Vsense
                    },
                    {
                        name: "MaxSenseVo",
                        displayName: "Max Sense (V)",
                        default: def_MaxSenseVo,
                        readOnly: true
                    },
                    {
                        name: "Rvos",
                        displayName: "Rvos (Ohm)",
                        default: def_Rvos,
                        readOnly: true,
                        onChange: recalc_Vsense
                    },
                    {
                        name: "Cvos",
                        displayName: "Cvos (nF)",
                        default: def_Cvos,
                        readOnly: true,
                        onChange: recalc_Vsense
                    },
                    {
                        name: "CutOffVo",
                        displayName: "Output Voltage Cut-off Freq (kHz)",
                        default: def_CutOffVo,
                        readOnly: true
                    }
                ]
            },
            {
                displayName: "Current Sense",
                description: "",
                collapsed: false,
                config: [
                    {
                        name: "Rcs",
                        displayName: "Rcs (Ohm)",
                        default: def_Rcs,
                        readOnly: true,
                        onChange: recalc_Isense
                    },
                    {
                        name: "Igain",
                        displayName: "Gcs (Gain)",
                        default: def_Igain,
                        readOnly: true,
                        onChange: recalc_Isense
                    },
                    {
                        name: "MaxSenseI",
                        displayName: "Max Sense (A)",
                        default: def_MaxSenseI,
                        readOnly: true
                    },
                    {
                        name: "Rcs_trip",
                        displayName: "Rcs_trip (Ohm)",
                        default: def_Rcs_trip,
                        readOnly: true,
                        onChange: recalc_Isense
                    },
                    {
                        name: "Ccs_trip",
                        displayName: "Ccs_trip (nF)",
                        default: def_Ccs_trip,
                        readOnly: true,
                        onChange: recalc_Isense
                    },
                    {
                        name: "CutOffCtrip",
                        displayName: "Trip Current Cut-off Freq (kHz)",
                        default: def_CutOffCtrip,
                        readOnly: true
                    },
                    {
                        name: "Rcs_avg",
                        displayName: "Rcs_avg (Ohm)",
                        default: def_Rcs_avg,
                        readOnly: true,
                        onChange: recalc_Isense
                    },
                    {
                        name: "Ccs_avg",
                        displayName: "Ccs_avg (nF)",
                        default: def_Ccs_avg,
                        readOnly: true,
                        onChange: recalc_Isense
                    },
                    {
                        name: "CutOffCavg",
                        displayName: "Average Current Cut-off Freq (kHz)",
                        default: def_CutOffCavg,
                        readOnly: true
                    }
                ]
            },
            {
                displayName: "FET RDS (On)",
                description: "",
                collapsed: false,
                config: [
                    {
                        name: "Rds1",
                        displayName: "Rds1 (Ohm)",
                        default: def_Rds1,
                        readOnly: true,
                        onChange: updatePowerStage
                    },
                    {
                        name: "Rds2",
                        displayName: "Rds2 (Ohm)",
                        default: def_Rds2,
                        readOnly: true,
                        onChange: updatePowerStage
                    }
                ]
            }
        ]
    }
];

function update_Lab(inst, ui)
{
    if(       inst.LabNum == 1) {
        inst.RampDec = 0;
        ui.RampDec.hidden = true;
        ui.CompDesigner.hidden = true;
        powerStage.MODEL.ID = String(0);
        COMP_OPTIONS.COMP_NUM = String(0);
        COMP_OPTIONS.MODEL_STYLE = String(0);
        COMP_OPTIONS.COMP_ABS_LIMIT = String(0);
        COMP_OPTIONS.COMP_STYLE = String(0);
    } else if(inst.LabNum == 2) {
        ui.RampDec.hidden = true;
        ui.CompDesigner.hidden = false;
        powerStage.MODEL.ID = String(vmc_ModelId);
        COMP_OPTIONS.COMP_NUM = String(vmc_CompNum);
        COMP_OPTIONS.MODEL_STYLE = String(vmc_ModelStyle);
        COMP_OPTIONS.COMP_ABS_LIMIT = String(vmc_CompLimit);
        COMP_OPTIONS.COMP_STYLE = String(vmc_CompStyle);
    }  else if(inst.LabNum == 3) {
        inst.RampDec = def_RampDec;
        ui.RampDec.hidden = false;
        ui.CompDesigner.hidden = true;
        powerStage.MODEL.ID = String(0);
        COMP_OPTIONS.COMP_NUM = String(0);
        COMP_OPTIONS.MODEL_STYLE = String(0);
        COMP_OPTIONS.COMP_ABS_LIMIT = String(0);
        COMP_OPTIONS.COMP_STYLE = String(0);
    } else if(inst.LabNum == 4) {
        inst.RampDec = def_RampDec;
        ui.RampDec.hidden = false;
        ui.CompDesigner.hidden = true;
        powerStage.MODEL.ID = String(pcmc_ModelId);
        COMP_OPTIONS.COMP_NUM = String(pcmc_CompNum);
        COMP_OPTIONS.MODEL_STYLE = String(pcmc_ModelStyle);
        COMP_OPTIONS.COMP_ABS_LIMIT = String(pcmc_CompLimit);
        COMP_OPTIONS.COMP_STYLE = String(pcmc_CompStyle);
    }
}

function update_PlantHw(inst, ui)
{
    if(inst.PlantHw == 1) {
        inst.Vin         = def_Vin;
        inst.Vout        = def_Vout;
        inst.Rload       = def_Rload;
        inst.Iload       = def_Iload;
        inst.L           = def_L;
        inst.Ldcr        = def_Ldcr;
        inst.Celec       = def_Celec;
        inst.ESRelec     = def_ESRelec;
        inst.ESLelec     = def_ESLelec;
        inst.Ccer        = def_Ccer;
        inst.ESRcer      = def_ESRcer;
        inst.ESLcer      = def_ESLcer;
        inst.Ra_Vi       = def_Ra_Vi;
        inst.Rb_Vi       = def_Rb_Vi;
        inst.MaxSenseVi  = def_MaxSenseVi;
        inst.Rc_Vo       = def_Rc_Vo;
        inst.Rd_Vo       = def_Rd_Vo;
        inst.MaxSenseVo  = def_MaxSenseVo;
        inst.Rvos        = def_Rvos;
        inst.Cvos        = def_Cvos;
        inst.CutOffVo    = def_CutOffVo;
        inst.Rcs         = def_Rcs;
        inst.Igain       = def_Igain;
        inst.MaxSenseI   = def_MaxSenseI;
        inst.Rcs_trip    = def_Rcs_trip;
        inst.Ccs_trip    = def_Ccs_trip;
        inst.CutOffCtrip = def_CutOffCtrip;
        inst.Rcs_avg     = def_Rcs_avg;
        inst.Ccs_avg     = def_Ccs_avg;
        inst.CutOffCavg  = def_CutOffCavg;
        inst.Rds1        = def_Rds1;
        inst.Rds2        = def_Rds2;
        ui.Vin.readOnly        = true;
        ui.Vout.readOnly       = true;
        ui.Rload.readOnly      = true;
        ui.L.readOnly          = true;
        ui.Ldcr.readOnly       = true;
        ui.Celec.readOnly      = true;
        ui.ESRelec.readOnly    = true;
        ui.ESLelec.readOnly    = true;
        ui.Ccer.readOnly       = true;
        ui.ESRcer.readOnly     = true;
        ui.ESLcer.readOnly     = true;
        ui.Ra_Vi.readOnly      = true;
        ui.Rb_Vi.readOnly      = true;
        ui.Rc_Vo.readOnly      = true;
        ui.Rd_Vo.readOnly      = true;
        ui.Rvos.readOnly       = true;
        ui.Cvos.readOnly       = true;
        ui.Rcs.readOnly        = true;
        ui.Igain.readOnly      = true;
        ui.Rcs_trip.readOnly   = true;
        ui.Ccs_trip.readOnly   = true;
        ui.Rcs_avg.readOnly    = true;
        ui.Ccs_avg.readOnly    = true;
        ui.Rds1.readOnly       = true;
        ui.Rds2.readOnly       = true;
    } else {
        ui.Vin.readOnly        = false;
        ui.Vout.readOnly       = false;
        ui.Rload.readOnly      = false;
        ui.L.readOnly          = false;
        ui.Ldcr.readOnly       = false;
        ui.Celec.readOnly      = false;
        ui.ESRelec.readOnly    = false;
        ui.ESLelec.readOnly    = false;
        ui.Ccer.readOnly       = false;
        ui.ESRcer.readOnly     = false;
        ui.ESLcer.readOnly     = false;
        ui.Ra_Vi.readOnly      = false;
        ui.Rb_Vi.readOnly      = false;
        ui.Rc_Vo.readOnly      = false;
        ui.Rd_Vo.readOnly      = false;
        ui.Rvos.readOnly       = false;
        ui.Cvos.readOnly       = false;
        ui.Rcs.readOnly        = false;
        ui.Igain.readOnly      = false;
        ui.Rcs_trip.readOnly   = false;
        ui.Ccs_trip.readOnly   = false;
        ui.Rcs_avg.readOnly    = false;
        ui.Ccs_avg.readOnly    = false;
        ui.Rds1.readOnly       = false;
        ui.Rds2.readOnly       = false;
    }
    updatePowerStage(inst);
}

function recalc_IsrFreq(inst)
{
    inst.IsrFreq = inst.Fsw/inst.IsrRatio;
	/*inst.IsrFreq = 16;*/
    updatePowerStage(inst);
}

function recalc_Iload(inst)
{
    inst.Iload = inst.Vout/inst.Rload;
    updatePowerStage(inst);
}

function recalc_MaxSenseVi(inst)
{
    inst.MaxSenseVi = adc_fullscale*(inst.Ra_Vi+inst.Rb_Vi)/inst.Rb_Vi;
    updatePowerStage(inst);
}

function recalc_Vsense(inst)
{
    inst.MaxSenseVo = adc_fullscale*(inst.Rc_Vo+inst.Rd_Vo)/inst.Rd_Vo;
    inst.CutOffVo = 1000000/(2*pi*(((inst.Rc_Vo*inst.Rd_Vo)/(inst.Rc_Vo+inst.Rd_Vo))+inst.Rvs)*inst.Cvs);
    updatePowerStage(inst);
}

function recalc_Isense(inst)
{
    inst.MaxSenseI = adc_fullscale/(inst.Rcs*inst.Igain);
    inst.CutOffCtrip = 1000000/(2*pi*inst.Rcs_trip*inst.Ccs_trip);
    inst.CutOffCavg  = 1000000/(2*pi*inst.Rcs_avg*inst.Ccs_avg);
    updatePowerStage(inst);
}

/*
 *  ======== refreshKitJson ========
 */
function refreshKitJson(kitJson, inst)
{
    powerStage = kitJson;
    /* update any configs that need it */
}

/*
 *  ======== updatePowerStage ========
 *  Sync relevant powerStage parameters to configs
 */
function updatePowerStage(inst)
{
    PLANT.Fsw = String(inst.Fsw * 1000);
    PLANT.Fctrl = String(16 * 1000);
    PLANT.Vin = String(inst.Vin);
    PLANT.Vout = String(inst.Vout);
    PLANT.Iout = String(inst.Iload);
    PLANT.Vout_SenseMax = String(inst.MaxSenseVo);
    PLANT.Vin_SenseMax = String(inst.MaxSenseVi);
    PLANT.Il_SenseMax = String(inst.MaxSenseI);
    PLANT.Rds1 = String(inst.Rds1);
    PLANT.Rds2 = String(inst.Rds2);
    PLANT.L = String(inst.L / 1000000);
    PLANT.DCR = String(inst.Ldcr);
    PLANT.Ccer = String(inst.Ccer / 1000000);
    PLANT.Celec = String(inst.Celec / 1000000);
    PLANT.ESRcer = String(inst.ESRcer);
    PLANT.ESLcer = String(inst.ESLcer / 1000000);
    PLANT.ESRelec = String(inst.ESRelec);
    PLANT.ESLelec = String(inst.ESLelec / 1000000);
    PLANT.Rfltr_a = String(inst.Rvos);
    PLANT.Cfltr_a = String(inst.Cvos / 1000000);
    PLANT.Rfltr_b = String(inst.Rcs_trip);
    PLANT.Cfltr_b = String(inst.Ccs_trip / 1000000);
    PLANT.Kpwm = String(1);

    COMP_OPTIONS.COMP_STYLE = String(vmc_CompStyle);
    COMP_OPTIONS.COMP_NUM = String(vmc_CompNum);
}

/*
 *  ======== validate ========
 *  Validate this inst's configuration
 *  This function is called every time any configurable changes
 *
 */
function validate(inst, validation)
{
    if (inst.Hello) {
        /* Example of how to validate the "Hello" configurable */
        if (inst.Hello != "World") {
            validation.logError("Hello != World!", inst, "Hello");
        }
    }
}

let hTemplate = "/devkits/" + kitName + "/" + kitType + "/" + kitType + "_settings.h.xdt";
let powerStageTemplate = "/devkits/" + kitName + "/" + kitType + "/Kit.json.xdt"
exports = {
    staticOnly: true,
    name: kitName,
    displayName: kitName,
    description: kitType,
    longDescription: longDescription,
	alwaysShowLongDescription: true,
    maxInstances: 1,
    moduleStatic: {
        config,
        validate: validate
    },

    /* pass powerStage and solution properties to template generator file */
    templates: {
        [hTemplate] : {powerStage: powerStage, solution: solution},
        [powerStageTemplate] : {powerStage: powerStage}
    }
};

