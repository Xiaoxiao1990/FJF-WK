/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "includes.h"
#include "stm8s_iwdg.h"

main()
{
	uchar time_CNT_M = 0;
	_configSet();
	_timer2_Initial();
	_timerBaseInitial();
	_EEPROM_Initial();
	_ADC_Initial();
	_IOInitial();
	/*Watch dog*/
//	IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
//	IWDG_SetPrescaler(IWDG_Prescaler_64);//128kHz
//	IWDG_SetReload(0xff);//Counter 256
//	IWDG_ReloadCounter();//Watch Dog Reset Time = (1/128k)*61*256 = 128ms
//	IWDG_Enable();
//	IWDG_WriteAccessCmd(IWDG_WriteAccess_Disable);

	while(1)
	{
		_displayAndKeyscan();
		_timerBase();
//		IWDG_ReloadCounter();//Clear Watch Dog Counter.
		if(isTimeProcess)
		{
			isTimeProcess = No;
			_output();
			_timerWheel();
			_displayDecode();
			_keyScanProcess();
			if(++time_CNT_M > 15)
			{
				time_CNT_M = 0;
				_AD_temperature();
			}
		}
	}
}