#include "includes.h"

#define PORT_KEY 	(PD_IDR&0b00101100)

#define KEYRELEASE_PORTVALUE	0b00000000
	/*
	PD2----S1
	PD3----S2
	PD5----S3
	PD6----S4
	*/
#define KEY_SUB		 					0b00100000   //S3
#define KEY_SET							0b00000100   //S1
#define KEY_ADD							0b00001000   //S2

#define KEY_SHORT_PRESS 30
#define KEY_LONG_PRESS  700

#define LONG_PRESS_ADD_UINT 4
#define LONG_PRESS_COUNT		8000
#define LONG_PRESS_LIMIT		3000
#define LONG_PRESS_SUB_UNIT 180

uchar keyActiveValue;
uint longPressCnt;
uint longPressBase;
_Bool isKeyLongPress;
_Bool isKeyProcess;
_Bool isCanEffect;
/*####### Update All LED status #######*/

void _IOInitial(void)
{
	
}

void keyscan(void)
{
	static uchar keyNewValue = KEYRELEASE_PORTVALUE;
	static uint keyScanCnt;
	static uchar steps;
	uchar  keyStatus;
	static uchar time_CNT = 0;
	
	if(++time_CNT < 10)
	{
		return;
	}
	time_CNT = 0;
	
	keyStatus = PORT_KEY ^ KEYRELEASE_PORTVALUE;
	switch(steps)
	{
		case 0:														//keys has been pressed
		{
			if(keyStatus != 0)
			{
				keyNewValue = keyStatus; 			//store the keys value;
				steps++;											//turn to next step
			}
			else
			{
				keyScanCnt = 0;
				isKeyLongPress = 0;
				isCanEffect = 1;
			}
		}break;
		case 1:														//confirm keys has been pressed
		{
			if(keyStatus == keyNewValue)		//if the keys value is not change
			{
				if(++keyScanCnt > KEY_SHORT_PRESS)					//dealy
				{
					keyScanCnt = 0;							//clear counter
					steps++;										//turn to next step
					keyActiveValue = keyNewValue;
				}
			}
			else
			{
				keyScanCnt = 0;								//clear time counter
				steps--;       								//back to first step
			}
		}break;
		case 2:														//clarify long press & short press.
		{
			if(keyStatus != keyNewValue)//Key release
			{
				if(!isKeyLongPress)isKeyProcess = 1;
				steps = 0;
				keyScanCnt = 0;
				longPressBase = LONG_PRESS_COUNT;
			}
			else
			{
				if(++keyScanCnt > KEY_LONG_PRESS)  //if key long time press
				{
					keyScanCnt = KEY_SHORT_PRESS;
					isKeyLongPress = 1;						  //set key long time press flag
				}
				inSetTimer = 0;										//Any key is pressed clear the time counter
			}
		}break;
		default:;
	}
}

void keyaddprocess(void)
{
	switch(MachineStatus)
	{
		case SHUTDOWN:break;
		case WORK:break;
		case SETTING:
		{
			if(SetMode == SET_TEMP)
			{
				if(SetTemp < 900)
				{
					SetTemp += 10;
				}
				else
				{
					SetTemp = 900;
				}
			}
			else
			{
				if(WorkTime < 99)WorkTime++;
				else WorkTime = 99; 
			}
		}break;
		default:;
	}
}
void keysubprocess(void)
{
	switch(MachineStatus)
	{
		case SHUTDOWN:break;
		case WORK:break;
		case SETTING:
		{
			if(SetMode == SET_TEMP)
			{
				if(SetTemp > 300)
				{
					SetTemp -= 10;
				}
				else
				{//-40C~-10C
					SetTemp = 300;
				}
			}
			else
			{
				if(WorkTime > 30)WorkTime--;
				else WorkTime = 30;
			}
		}break;
		default:;
	}
}

void keysetprocess(void)
{
	switch(MachineStatus)
	{
		case SHUTDOWN:break;
		case WORK:
		{
			MachineStatus = SETTING;
			SetMode = SET_TEMP;
		}break;
		case SETTING:
		{
			if(++SetMode > SET_TIME)SetMode = SET_TEMP;
			//MachineStatus = WORK;
		}break;
		default:;
	}
}

void _keyScanProcess(void)
{
	if (isKeyLongPress)
	{
		longPressCnt += LONG_PRESS_ADD_UINT;
		if(++longPressCnt > longPressBase)
		{
			longPressCnt = 0;
			if(longPressBase > LONG_PRESS_LIMIT)
			{
				longPressBase -= LONG_PRESS_SUB_UNIT;
			}
			//Key Long Press
			if((keyActiveValue == KEY_ADD)||(keyActiveValue == KEY_SUB))
			{
				if(MachineStatus == SETTING)isKeyProcess = 1;
			}
			else if(keyActiveValue == KEY_SET)
			{//Long Press SET 
				if(isCanEffect)
				{
					isCanEffect = 0;//Clear
					isUpdateDisplay = Yes;
					if(MachineStatus == WORK)
					{
						MachineStatus = SHUTDOWN;
					}
					else if(MachineStatus == SHUTDOWN)
					{
						MachineStatus = WORK;
						WorkTimeBkp = WorkTime;
					}
				}
			}
		}
	}
	if(isKeyProcess)
	{
		isKeyProcess = 0;
		isUpdateDisplay = Yes;
		switch(keyActiveValue)
		{
			case KEY_SET:
			{
				keysetprocess();
			}
			break;
			case KEY_ADD:
			{
				keyaddprocess();
			}break;
			case KEY_SUB:
			{
				keysubprocess();
			}break;
			default:;
		}
	}
}
