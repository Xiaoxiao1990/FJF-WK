#include "includes.h"
#include "stm8s_flash.h"

#define EEPROM_START_ADDR				0x4000
#define EEPROM_CODE_ADDR				EEPROM_START_ADDR
#define DATA_ADDR								EEPROM_CODE_ADDR+2
#define EEPROM_CODE 						0xaa

void chardatacheck(uchar *data,uchar low,uchar high)
{
	if(*data > high)*data = high;
	if(*data < low)*data = low;
}

void intdatacheck(signed int *data,signed int low,signed int high)
{
	if(*data > high)*data = high;
	if(*data < low)*data = low;
}

void _EEPROM_Initial(void)
{
	uchar temp;

	temp = FLASH_ReadByte(EEPROM_CODE_ADDR);
	if (temp == EEPROM_CODE)
	{
		
		SetTemp = FLASH_ReadByte(DATA_ADDR)<<8;
		SetTemp += FLASH_ReadByte(DATA_ADDR+1);
		
		intdatacheck(&SetTemp,300,900);

		WorkTime = FLASH_ReadByte(DATA_ADDR+2);
		
		chardatacheck(&WorkTime,30,99);
		WorkTimeBkp = WorkTime;
	}
	else
	{
		do
		{
			FLASH_Unlock(FLASH_MEMTYPE_DATA);
		}while(FLASH_GetFlagStatus(FLASH_FLAG_DUL) == 0);
		
		FLASH_ProgramByte(EEPROM_CODE_ADDR, EEPROM_CODE);
		
		SetTemp = 40;
		WorkTime = 60;
		FLASH_ProgramByte(DATA_ADDR,SetTemp>>8);
		FLASH_ProgramByte(DATA_ADDR+1,SetTemp&0xff);
		FLASH_ProgramByte(DATA_ADDR+2,WorkTime);
		while(FLASH_GetFlagStatus(FLASH_FLAG_EOP) == 0);
		
		FLASH_Lock(FLASH_MEMTYPE_DATA);
	}
}

void _EEPROM_saveSettings(void)
{
	uchar temp = 0;
	do
	{
		FLASH_Unlock(FLASH_MEMTYPE_DATA);
	}while(FLASH_GetFlagStatus(FLASH_FLAG_DUL) == 0);

	FLASH_ProgramByte(DATA_ADDR,SetTemp>>8);
	FLASH_ProgramByte(DATA_ADDR+1,SetTemp&0xff);
	FLASH_ProgramByte(DATA_ADDR+2,WorkTime);
	WorkTimeBkp = WorkTime;
	while(FLASH_GetFlagStatus(FLASH_FLAG_EOP) == 0);
	
	FLASH_Lock(FLASH_MEMTYPE_DATA);
}
