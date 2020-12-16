/*
 * bts_user_calibration.h
 *
 *  Two points calibration
 *  Gain & offset calculation
 *
 */

#ifndef BTS_USER_CALIBRATION_H_
#define BTS_USER_CALIBRATION_H_


#define BTS_CALIBRATION_ENABLED (false)
#define BTS_CALIBATION_MODE BTS_CALIBRATION_CC
#define BTS_CALIBRATION_CC (1)
#define BTS_CALIBRATION_CV (2)

#define BTS_IOUT_CALIBRATION_POINT1 ((float32_t)0.05)
#define BTS_IOUT_CALIBRATION_POINT2 ((float32_t)0.5)

#define BTS_VOUT_CALIBRATION_POINT1 ((float32_t)0.2)
#define BTS_VOUT_CALIBRATION_POINT2 ((float32_t)0.8)


#define BTS_ISET_MIN_A ((float32_t)-10.0)
#define BTS_ISET_MAX_A ((float32_t)10.0)

#define BTS_ISET_MIN_PU                     ((float32_t)BTS_IoutGain_ch1_pu*BTS_ISET_MIN_A+BTS_IoutOffset_ch1_pu)
#define BTS_ISET_MAX_PU                     ((float32_t)BTS_IoutGain_ch1_pu*BTS_ISET_MAX_A+BTS_IoutOffset_ch1_pu)


/*
 * Channel 1 calibration
 */

#define BTS_Iout1_ch1_pu BTS_IOUT_CALIBRATION_POINT1
#define BTS_Iout2_ch1_pu BTS_IOUT_CALIBRATION_POINT2
#define BTS_Iout1_ch1_A 0.680f
#define BTS_Iout2_ch1_A 6.816f

#define BTS_IoutGain_ch1_pu     ((float32_t)(BTS_Iout1_ch1_pu-BTS_Iout2_ch1_pu)/(BTS_Iout1_ch1_A-BTS_Iout2_ch1_A))
#define BTS_IoutOffset_ch1_pu   ((float32_t)(BTS_Iout1_ch1_pu- (BTS_Iout1_ch1_A)*BTS_IoutGain_ch1_pu))
#define BTS_IoutGain_ch1_A      ((float32_t)(1.0/BTS_IoutGain_ch1_pu))
#define BTS_IoutOffset_ch1_A    ((float32_t)(-1.0*BTS_IoutOffset_ch1_pu/BTS_IoutGain_ch1_pu))

#define BTS_Vout1_ch1_pu BTS_VOUT_CALIBRATION_POINT1
#define BTS_Vout2_ch1_pu BTS_VOUT_CALIBRATION_POINT2
#define BTS_Vout1_ch1_V 1.00997f
#define BTS_Vout2_ch1_V 4.0351f

#define BTS_VoutGain_ch1_pu     ((float32_t)(BTS_Vout1_ch1_pu-BTS_Vout2_ch1_pu)/(BTS_Vout1_ch1_V-BTS_Vout2_ch1_V))
#define BTS_VoutOffset_ch1_pu   ((float32_t)(BTS_Vout1_ch1_pu- (BTS_Vout1_ch1_V)*BTS_VoutGain_ch1_pu))
#define BTS_VoutGain_ch1_V      ((float32_t)(1.0/BTS_VoutGain_ch1_pu))
#define BTS_VoutOffset_ch1_V    ((float32_t)(-1.0*BTS_VoutOffset_ch1_pu/BTS_VoutGain_ch1_pu))



/*
 * Channel 2 calibration
 */
#define BTS_Iout1_ch2_pu BTS_IOUT_CALIBRATION_POINT1
#define BTS_Iout2_ch2_pu BTS_IOUT_CALIBRATION_POINT2
#define BTS_Iout1_ch2_A 0.680f
#define BTS_Iout2_ch2_A 6.816f

#define BTS_IoutGain_ch2_pu     ((float32_t)(BTS_Iout1_ch2_pu-BTS_Iout2_ch2_pu)/(BTS_Iout1_ch2_A-BTS_Iout2_ch2_A))
#define BTS_IoutOffset_ch2_pu   ((float32_t)(BTS_Iout1_ch2_pu- (BTS_Iout1_ch2_A)*BTS_IoutGain_ch2_pu))
#define BTS_IoutGain_ch2_A      ((float32_t)(1.0/BTS_IoutGain_ch2_pu))
#define BTS_IoutOffset_ch2_A    ((float32_t)(-1.0*BTS_IoutOffset_ch2_pu/BTS_IoutGain_ch2_pu))

#define BTS_Vout1_ch2_pu BTS_VOUT_CALIBRATION_POINT1
#define BTS_Vout2_ch2_pu BTS_VOUT_CALIBRATION_POINT2
#define BTS_Vout1_ch2_V 1.00997f
#define BTS_Vout2_ch2_V 4.0351f

#define BTS_VoutGain_ch2_pu     ((float32_t)(BTS_Vout1_ch2_pu-BTS_Vout2_ch2_pu)/(BTS_Vout1_ch2_V-BTS_Vout2_ch2_V))
#define BTS_VoutOffset_ch2_pu   ((float32_t)(BTS_Vout1_ch2_pu- (BTS_Vout1_ch2_V)*BTS_VoutGain_ch2_pu))
#define BTS_VoutGain_ch2_V      ((float32_t)(1.0/BTS_VoutGain_ch2_pu))
#define BTS_VoutOffset_ch2_V    ((float32_t)(-1.0*BTS_VoutOffset_ch2_pu/BTS_VoutGain_ch2_pu))


/*
 * Channel 3 calibration
 */
#define BTS_Iout1_ch3_pu BTS_IOUT_CALIBRATION_POINT1
#define BTS_Iout2_ch3_pu BTS_IOUT_CALIBRATION_POINT2
#define BTS_Iout1_ch3_A 0.680f
#define BTS_Iout2_ch3_A 6.816f

#define BTS_IoutGain_ch3_pu     ((float32_t)(BTS_Iout1_ch3_pu-BTS_Iout2_ch3_pu)/(BTS_Iout1_ch3_A-BTS_Iout2_ch3_A))
#define BTS_IoutOffset_ch3_pu   ((float32_t)(BTS_Iout1_ch3_pu- (BTS_Iout1_ch3_A)*BTS_IoutGain_ch3_pu))
#define BTS_IoutGain_ch3_A      ((float32_t)(1.0/BTS_IoutGain_ch3_pu))
#define BTS_IoutOffset_ch3_A    ((float32_t)(-1.0*BTS_IoutOffset_ch3_pu/BTS_IoutGain_ch3_pu))

#define BTS_Vout1_ch3_pu BTS_VOUT_CALIBRATION_POINT1
#define BTS_Vout2_ch3_pu BTS_VOUT_CALIBRATION_POINT2
#define BTS_Vout1_ch3_V 1.00997f
#define BTS_Vout2_ch3_V 4.0351f

#define BTS_VoutGain_ch3_pu     ((float32_t)(BTS_Vout1_ch3_pu-BTS_Vout2_ch3_pu)/(BTS_Vout1_ch3_V-BTS_Vout2_ch3_V))
#define BTS_VoutOffset_ch3_pu   ((float32_t)(BTS_Vout1_ch3_pu- (BTS_Vout1_ch3_V)*BTS_VoutGain_ch3_pu))
#define BTS_VoutGain_ch3_V      ((float32_t)(1.0/BTS_VoutGain_ch3_pu))
#define BTS_VoutOffset_ch3_V    ((float32_t)(-1.0*BTS_VoutOffset_ch3_pu/BTS_VoutGain_ch3_pu))


/*
 * Channel 4 calibration
 */

#define BTS_Iout1_ch4_pu BTS_IOUT_CALIBRATION_POINT1
#define BTS_Iout2_ch4_pu BTS_IOUT_CALIBRATION_POINT2
#define BTS_Iout1_ch4_A 0.680f
#define BTS_Iout2_ch4_A 6.816f

#define BTS_IoutGain_ch4_pu     ((float32_t)(BTS_Iout1_ch4_pu-BTS_Iout2_ch4_pu)/(BTS_Iout1_ch4_A-BTS_Iout2_ch4_A))
#define BTS_IoutOffset_ch4_pu   ((float32_t)(BTS_Iout1_ch4_pu- (BTS_Iout1_ch4_A)*BTS_IoutGain_ch4_pu))
#define BTS_IoutGain_ch4_A      ((float32_t)(1.0/BTS_IoutGain_ch4_pu))
#define BTS_IoutOffset_ch4_A    ((float32_t)(-1.0*BTS_IoutOffset_ch4_pu/BTS_IoutGain_ch4_pu))

#define BTS_Vout1_ch4_pu BTS_VOUT_CALIBRATION_POINT1
#define BTS_Vout2_ch4_pu BTS_VOUT_CALIBRATION_POINT2
#define BTS_Vout1_ch4_V 1.00997f
#define BTS_Vout2_ch4_V 4.0351f

#define BTS_VoutGain_ch4_pu     ((float32_t)(BTS_Vout1_ch4_pu-BTS_Vout2_ch4_pu)/(BTS_Vout1_ch4_V-BTS_Vout2_ch4_V))
#define BTS_VoutOffset_ch4_pu   ((float32_t)(BTS_Vout1_ch4_pu- (BTS_Vout1_ch4_V)*BTS_VoutGain_ch4_pu))
#define BTS_VoutGain_ch4_V      ((float32_t)(1.0/BTS_VoutGain_ch4_pu))
#define BTS_VoutOffset_ch4_V    ((float32_t)(-1.0*BTS_VoutOffset_ch4_pu/BTS_VoutGain_ch4_pu))



#endif /* BTS_USER_CALIBRATION_H_ */
