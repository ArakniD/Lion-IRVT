let $solution = {
    kit                  : {name: "TIDM_02008", type: "ttplpfc", device: "F28004x"},
    cpuSysClock          : 100,
    PWMSysClkFreq		 : 100,
    eCAPSysClkFreq		 : 100,
	adcMaxRange			 : 3.3,
    pwmSwitchingFreq     : {min : 20, max : 200, default : 100},
    vInSenseMaxDefault  : 13.3,
    vOutSenseMaxDefault : 9.76,
    iLMaxSensedDefault   : 5.5,
    iLTripLevelDefault   : 4.0,
    ADCSense_Fltr_Cuttoff : 23.417,

     /* No GUI configs, init here? */
    ACFreq               : 60.0,
};

exports = {
    $solution: $solution,
};