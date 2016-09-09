#ifndef _INCLUDES_H_
#define _INCLUDES_H_

#include "stm8s003F3.h"					/*Register map*/
#include "stm8s_bitsdefine.h"
#include "keyscan.h"
#include "time.h"
#include "display.h"
#include "config.h"
#include "eeprom.h"
#include "adc.h"
#include "output.h"

#define Yes 1
#define No  0

#define Set 	1
#define Reset 0

#define Clear Reset

/*MachineStatus define*/
#define SHUTDOWN					0
#define WORK							1
#define SETTING						2

/*SetMode define*/
#define SET_TEMP					0
#define SET_TIME					1

typedef unsigned char uchar;
typedef unsigned int uint;

extern uchar LED_Buf[2];
extern _Bool isUpdateDisplay;
extern _Bool isOneSecond;
extern _Bool isFlash1Hz;
extern _Bool isFlash3Hz;
extern uchar inSetTimer;
extern uchar MachineStatus;
extern uchar SetMode;
extern _Bool isTimeProcess;
extern _Bool isInSetting;
extern signed int SetTemp;
extern signed int CurrentTemp;
extern uchar WorkTime;
extern uchar WorkTimeBkp;

extern uchar testValue;
/*
DisplayMode:
0-Controller Off:000
1-ON:On time
2-ON:Off time
3-Set
*/

#endif