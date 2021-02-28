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
#define BTS_IOUT_CALIBRATION_POINT3 ((float32_t)0.25)

#define BTS_VOUT_CALIBRATION_POINT1 ((float32_t)0.2)
#define BTS_VOUT_CALIBRATION_POINT2 ((float32_t)0.8)

#define BTS_ISET_MIN_A ((float32_t)-10)
#define BTS_ISET_MAX_A ((float32_t)10)

#define BTS_ISET_MIN_PU                     ((float32_t)BTS_IoutGain_ch1_pu*BTS_ISET_MIN_A+BTS_IoutOffset_ch1_pu)
#define BTS_ISET_MAX_PU                     ((float32_t)BTS_IoutGain_ch1_pu*BTS_ISET_MAX_A+BTS_IoutOffset_ch1_pu)

/*
 * Channel 1 calibration
 */

#define BTS_Iout1_ch1_pu 0.0500000007f
#define BTS_Iout2_ch1_pu 0.250061035f
#define BTS_Iout1_ch1_A 0.49591f
#define BTS_Iout2_ch1_A 2.49023f

#define BTS_IoutGain_ch1_pu     ((float32_t)(BTS_Iout1_ch1_pu-BTS_Iout2_ch1_pu)/(BTS_Iout1_ch1_A-BTS_Iout2_ch1_A))
#define BTS_IoutOffset_ch1_pu   ((float32_t)(BTS_Iout1_ch1_pu- (BTS_Iout1_ch1_A)*BTS_IoutGain_ch1_pu))
#define BTS_IoutGain_ch1_A      ((float32_t)(1.0/BTS_IoutGain_ch1_pu))
#define BTS_IoutOffset_ch1_A    ((float32_t)(-1.0*BTS_IoutOffset_ch1_pu/BTS_IoutGain_ch1_pu))

#define BTS_Vout1_ch1_pu 0.202636719f
#define BTS_Vout2_ch1_pu 0.811920166f
#define BTS_Vout1_ch1_V 1.000979f
#define BTS_Vout2_ch1_V 4.00106f

#define BTS_VoutGain_ch1_pu     ((float32_t)(BTS_Vout1_ch1_pu-BTS_Vout2_ch1_pu)/(BTS_Vout1_ch1_V-BTS_Vout2_ch1_V))
#define BTS_VoutOffset_ch1_pu   ((float32_t)(BTS_Vout1_ch1_pu- (BTS_Vout1_ch1_V)*BTS_VoutGain_ch1_pu))
#define BTS_VoutGain_ch1_V      ((float32_t)(1.0/BTS_VoutGain_ch1_pu))
#define BTS_VoutOffset_ch1_V    ((float32_t)(-1.0*BTS_VoutOffset_ch1_pu/BTS_VoutGain_ch1_pu))

/*
 * Channel 2 calibration
 */
#define BTS_Iout1_ch2_pu BTS_IOUT_CALIBRATION_POINT1
#define BTS_Iout2_ch2_pu BTS_IOUT_CALIBRATION_POINT2
#define BTS_Iout1_ch2_A 0.501341510f
#define BTS_Iout2_ch2_A 5.013415101f

#define BTS_IoutGain_ch2_pu     ((float32_t)(BTS_Iout1_ch2_pu-BTS_Iout2_ch2_pu)/(BTS_Iout1_ch2_A-BTS_Iout2_ch2_A))
#define BTS_IoutOffset_ch2_pu   ((float32_t)(BTS_Iout1_ch2_pu- (BTS_Iout1_ch2_A)*BTS_IoutGain_ch2_pu))
#define BTS_IoutGain_ch2_A      ((float32_t)(1.0/BTS_IoutGain_ch2_pu))
#define BTS_IoutOffset_ch2_A    ((float32_t)(-1.0*BTS_IoutOffset_ch2_pu/BTS_IoutGain_ch2_pu))

#define BTS_Vout1_ch2_pu BTS_VOUT_CALIBRATION_POINT1
#define BTS_Vout2_ch2_pu BTS_VOUT_CALIBRATION_POINT2
#define BTS_Vout1_ch2_V 0.9885f
#define BTS_Vout2_ch2_V 3.954f

#define BTS_VoutGain_ch2_pu     ((float32_t)(BTS_Vout1_ch2_pu-BTS_Vout2_ch2_pu)/(BTS_Vout1_ch2_V-BTS_Vout2_ch2_V))
#define BTS_VoutOffset_ch2_pu   ((float32_t)(BTS_Vout1_ch2_pu- (BTS_Vout1_ch2_V)*BTS_VoutGain_ch2_pu))
#define BTS_VoutGain_ch2_V      ((float32_t)(1.0/BTS_VoutGain_ch2_pu))
#define BTS_VoutOffset_ch2_V    ((float32_t)(-1.0*BTS_VoutOffset_ch2_pu/BTS_VoutGain_ch2_pu))


/*
 * Channel 3 calibration
 */
#define BTS_Iout1_ch3_pu BTS_IOUT_CALIBRATION_POINT1
#define BTS_Iout2_ch3_pu BTS_IOUT_CALIBRATION_POINT2
#define BTS_Iout1_ch3_A 0.501341510f
#define BTS_Iout2_ch3_A 5.013415101f

#define BTS_IoutGain_ch3_pu     ((float32_t)(BTS_Iout1_ch3_pu-BTS_Iout2_ch3_pu)/(BTS_Iout1_ch3_A-BTS_Iout2_ch3_A))
#define BTS_IoutOffset_ch3_pu   ((float32_t)(BTS_Iout1_ch3_pu- (BTS_Iout1_ch3_A)*BTS_IoutGain_ch3_pu))
#define BTS_IoutGain_ch3_A      ((float32_t)(1.0/BTS_IoutGain_ch3_pu))
#define BTS_IoutOffset_ch3_A    ((float32_t)(-1.0*BTS_IoutOffset_ch3_pu/BTS_IoutGain_ch3_pu))

#define BTS_Vout1_ch3_pu BTS_VOUT_CALIBRATION_POINT1
#define BTS_Vout2_ch3_pu BTS_VOUT_CALIBRATION_POINT2
#define BTS_Vout1_ch3_V 0.9885f
#define BTS_Vout2_ch3_V 3.954f

#define BTS_VoutGain_ch3_pu     ((float32_t)(BTS_Vout1_ch3_pu-BTS_Vout2_ch3_pu)/(BTS_Vout1_ch3_V-BTS_Vout2_ch3_V))
#define BTS_VoutOffset_ch3_pu   ((float32_t)(BTS_Vout1_ch3_pu- (BTS_Vout1_ch3_V)*BTS_VoutGain_ch3_pu))
#define BTS_VoutGain_ch3_V      ((float32_t)(1.0/BTS_VoutGain_ch3_pu))
#define BTS_VoutOffset_ch3_V    ((float32_t)(-1.0*BTS_VoutOffset_ch3_pu/BTS_VoutGain_ch3_pu))


/*
 * Channel 4 calibration
 */

#define BTS_Iout1_ch4_pu BTS_IOUT_CALIBRATION_POINT1
#define BTS_Iout2_ch4_pu BTS_IOUT_CALIBRATION_POINT2
#define BTS_Iout1_ch4_A 0.501341510f
#define BTS_Iout2_ch4_A 5.013415101f

#define BTS_IoutGain_ch4_pu     ((float32_t)(BTS_Iout1_ch4_pu-BTS_Iout2_ch4_pu)/(BTS_Iout1_ch4_A-BTS_Iout2_ch4_A))
#define BTS_IoutOffset_ch4_pu   ((float32_t)(BTS_Iout1_ch4_pu- (BTS_Iout1_ch4_A)*BTS_IoutGain_ch4_pu))
#define BTS_IoutGain_ch4_A      ((float32_t)(1.0/BTS_IoutGain_ch4_pu))
#define BTS_IoutOffset_ch4_A    ((float32_t)(-1.0*BTS_IoutOffset_ch4_pu/BTS_IoutGain_ch4_pu))

#define BTS_Vout1_ch4_pu BTS_VOUT_CALIBRATION_POINT1
#define BTS_Vout2_ch4_pu BTS_VOUT_CALIBRATION_POINT2
#define BTS_Vout1_ch4_V 0.9885f
#define BTS_Vout2_ch4_V 3.954f

#define BTS_VoutGain_ch4_pu     ((float32_t)(BTS_Vout1_ch4_pu-BTS_Vout2_ch4_pu)/(BTS_Vout1_ch4_V-BTS_Vout2_ch4_V))
#define BTS_VoutOffset_ch4_pu   ((float32_t)(BTS_Vout1_ch4_pu- (BTS_Vout1_ch4_V)*BTS_VoutGain_ch4_pu))
#define BTS_VoutGain_ch4_V      ((float32_t)(1.0/BTS_VoutGain_ch4_pu))
#define BTS_VoutOffset_ch4_V    ((float32_t)(-1.0*BTS_VoutOffset_ch4_pu/BTS_VoutGain_ch4_pu))

/*
 * Channel 5 calibration
 */

#define BTS_Iout1_ch5_pu BTS_IOUT_CALIBRATION_POINT1
#define BTS_Iout2_ch5_pu BTS_IOUT_CALIBRATION_POINT2
#define BTS_Iout1_ch5_A 0.501341510f
#define BTS_Iout2_ch5_A 5.013415101f

#define BTS_IoutGain_ch5_pu     ((float32_t)(BTS_Iout1_ch5_pu-BTS_Iout2_ch5_pu)/(BTS_Iout1_ch5_A-BTS_Iout2_ch5_A))
#define BTS_IoutOffset_ch5_pu   ((float32_t)(BTS_Iout1_ch5_pu- (BTS_Iout1_ch5_A)*BTS_IoutGain_ch5_pu))
#define BTS_IoutGain_ch5_A      ((float32_t)(1.0/BTS_IoutGain_ch5_pu))
#define BTS_IoutOffset_ch5_A    ((float32_t)(-1.0*BTS_IoutOffset_ch5_pu/BTS_IoutGain_ch5_pu))

#define BTS_Vout1_ch5_pu BTS_VOUT_CALIBRATION_POINT1
#define BTS_Vout2_ch5_pu BTS_VOUT_CALIBRATION_POINT2
#define BTS_Vout1_ch5_V 0.9885f
#define BTS_Vout2_ch5_V 3.954f

#define BTS_VoutGain_ch5_pu     ((float32_t)(BTS_Vout1_ch5_pu-BTS_Vout2_ch5_pu)/(BTS_Vout1_ch5_V-BTS_Vout2_ch5_V))
#define BTS_VoutOffset_ch5_pu   ((float32_t)(BTS_Vout1_ch5_pu- (BTS_Vout1_ch5_V)*BTS_VoutGain_ch5_pu))
#define BTS_VoutGain_ch5_V      ((float32_t)(1.0/BTS_VoutGain_ch5_pu))
#define BTS_VoutOffset_ch5_V    ((float32_t)(-1.0*BTS_VoutOffset_ch5_pu/BTS_VoutGain_ch5_pu))

/*
 * Channel 6 calibration
 */

#define BTS_Iout1_ch6_pu BTS_IOUT_CALIBRATION_POINT1
#define BTS_Iout2_ch6_pu BTS_IOUT_CALIBRATION_POINT2
#define BTS_Iout1_ch6_A 0.501341510f
#define BTS_Iout2_ch6_A 5.013415101f

#define BTS_IoutGain_ch6_pu     ((float32_t)(BTS_Iout1_ch6_pu-BTS_Iout2_ch6_pu)/(BTS_Iout1_ch6_A-BTS_Iout2_ch6_A))
#define BTS_IoutOffset_ch6_pu   ((float32_t)(BTS_Iout1_ch6_pu- (BTS_Iout1_ch6_A)*BTS_IoutGain_ch6_pu))
#define BTS_IoutGain_ch6_A      ((float32_t)(1.0/BTS_IoutGain_ch6_pu))
#define BTS_IoutOffset_ch6_A    ((float32_t)(-1.0*BTS_IoutOffset_ch6_pu/BTS_IoutGain_ch6_pu))

#define BTS_Vout1_ch6_pu BTS_VOUT_CALIBRATION_POINT1
#define BTS_Vout2_ch6_pu BTS_VOUT_CALIBRATION_POINT2
#define BTS_Vout1_ch6_V 0.9885f
#define BTS_Vout2_ch6_V 3.954f

#define BTS_VoutGain_ch6_pu     ((float32_t)(BTS_Vout1_ch6_pu-BTS_Vout2_ch6_pu)/(BTS_Vout1_ch6_V-BTS_Vout2_ch6_V))
#define BTS_VoutOffset_ch6_pu   ((float32_t)(BTS_Vout1_ch6_pu- (BTS_Vout1_ch6_V)*BTS_VoutGain_ch6_pu))
#define BTS_VoutGain_ch6_V      ((float32_t)(1.0/BTS_VoutGain_ch6_pu))
#define BTS_VoutOffset_ch6_V    ((float32_t)(-1.0*BTS_VoutOffset_ch6_pu/BTS_VoutGain_ch6_pu))

/*
 * Channel 7 calibration
 */

#define BTS_Iout1_ch7_pu BTS_IOUT_CALIBRATION_POINT1
#define BTS_Iout2_ch7_pu BTS_IOUT_CALIBRATION_POINT2
#define BTS_Iout1_ch7_A 0.501341510f
#define BTS_Iout2_ch7_A 5.013415101f

#define BTS_IoutGain_ch7_pu     ((float32_t)(BTS_Iout1_ch7_pu-BTS_Iout2_ch7_pu)/(BTS_Iout1_ch7_A-BTS_Iout2_ch7_A))
#define BTS_IoutOffset_ch7_pu   ((float32_t)(BTS_Iout1_ch7_pu- (BTS_Iout1_ch7_A)*BTS_IoutGain_ch7_pu))
#define BTS_IoutGain_ch7_A      ((float32_t)(1.0/BTS_IoutGain_ch7_pu))
#define BTS_IoutOffset_ch7_A    ((float32_t)(-1.0*BTS_IoutOffset_ch7_pu/BTS_IoutGain_ch7_pu))

#define BTS_Vout1_ch7_pu BTS_VOUT_CALIBRATION_POINT1
#define BTS_Vout2_ch7_pu BTS_VOUT_CALIBRATION_POINT2
#define BTS_Vout1_ch7_V 0.9885f
#define BTS_Vout2_ch7_V 3.954f

#define BTS_VoutGain_ch7_pu     ((float32_t)(BTS_Vout1_ch7_pu-BTS_Vout2_ch7_pu)/(BTS_Vout1_ch7_V-BTS_Vout2_ch7_V))
#define BTS_VoutOffset_ch7_pu   ((float32_t)(BTS_Vout1_ch7_pu- (BTS_Vout1_ch7_V)*BTS_VoutGain_ch7_pu))
#define BTS_VoutGain_ch7_V      ((float32_t)(1.0/BTS_VoutGain_ch7_pu))
#define BTS_VoutOffset_ch7_V    ((float32_t)(-1.0*BTS_VoutOffset_ch7_pu/BTS_VoutGain_ch7_pu))

/*
 * Channel 8 calibration
 */

#define BTS_Iout1_ch8_pu BTS_IOUT_CALIBRATION_POINT1
#define BTS_Iout2_ch8_pu BTS_IOUT_CALIBRATION_POINT2
#define BTS_Iout1_ch8_A 0.501341510f
#define BTS_Iout2_ch8_A 5.013415101f

#define BTS_IoutGain_ch8_pu     ((float32_t)(BTS_Iout1_ch8_pu-BTS_Iout2_ch8_pu)/(BTS_Iout1_ch8_A-BTS_Iout2_ch8_A))
#define BTS_IoutOffset_ch8_pu   ((float32_t)(BTS_Iout1_ch8_pu- (BTS_Iout1_ch8_A)*BTS_IoutGain_ch8_pu))
#define BTS_IoutGain_ch8_A      ((float32_t)(1.0/BTS_IoutGain_ch8_pu))
#define BTS_IoutOffset_ch8_A    ((float32_t)(-1.0*BTS_IoutOffset_ch8_pu/BTS_IoutGain_ch8_pu))

#define BTS_Vout1_ch8_pu BTS_VOUT_CALIBRATION_POINT1
#define BTS_Vout2_ch8_pu BTS_VOUT_CALIBRATION_POINT2
#define BTS_Vout1_ch8_V 0.9885f
#define BTS_Vout2_ch8_V 3.954f

#define BTS_VoutGain_ch8_pu     ((float32_t)(BTS_Vout1_ch8_pu-BTS_Vout2_ch8_pu)/(BTS_Vout1_ch8_V-BTS_Vout2_ch8_V))
#define BTS_VoutOffset_ch8_pu   ((float32_t)(BTS_Vout1_ch8_pu- (BTS_Vout1_ch8_V)*BTS_VoutGain_ch8_pu))
#define BTS_VoutGain_ch8_V      ((float32_t)(1.0/BTS_VoutGain_ch8_pu))
#define BTS_VoutOffset_ch8_V    ((float32_t)(-1.0*BTS_VoutOffset_ch8_pu/BTS_VoutGain_ch8_pu))

#endif /* BTS_USER_CALIBRATION_H_ */
