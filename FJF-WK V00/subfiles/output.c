#include "includes.h"

#define Green PB_ODR_5
#define Red   PB_ODR_4
#define Heat	PD_ODR_4
#define ON   0
#define OFF	 1

void _output(void)
{
	switch(MachineStatus)
	{
		case SHUTDOWN:
		{
			Green = OFF;
			Red   = OFF;
			Heat = 0;
			//MachineStatus++;
		}
		break;
		case WORK:
		{
			if(WorkTimeBkp > 0)
			{
				if(CurrentTemp <= (SetTemp - 30))
				{
					Heat = 1;
				}
				if(CurrentTemp >= SetTemp)Heat = 0;
			}
			else
			{
				MachineStatus = SHUTDOWN;
				Heat = 0;
			}
			Red = Heat^1;
			Green = Red^1;
		}
		break;
		case SETTING:
		{
			if(SetMode == SET_TEMP)
			{
				if(isFlash1Hz)Red = ON;
				else Red = OFF;
			}
			if(SetMode == SET_TIME)
			{
				if(isFlash3Hz)Red = ON;
				else Red = OFF;
			}
			Green = OFF;
			Heat = 0;
		}break;
		default:;
	}
}