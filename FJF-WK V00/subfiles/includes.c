#include "includes.h"

/*Global*/
uchar LED_Buf[2];
_Bool isUpdateDisplay;
_Bool isOneSecond;
_Bool isFlash1Hz;
_Bool isFlash3Hz;
uchar inSetTimer;
uchar SetMode;
uchar MachineStatus;
_Bool isTimeProcess;
_Bool isInSetting;
signed int SetTemp = 40;
signed int CurrentTemp;
uchar WorkTime;
uchar WorkTimeBkp;

uchar testValue;