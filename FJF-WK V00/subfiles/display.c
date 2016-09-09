#include "includes.h"
/*******************************************
*_display() with key scan subroutine
********************************************/

const uchar LEDCode[18]={//Share Cathode
	0b00111111,	//0
	0b00000110,	//1
	0b01011011,	//2
	0b01001111,	//3
	0b01100110,	//4
	0b01101101,	//5
	0b01111101,	//6
	0b00000111,	//7
	0b01111111,	//8
	0b01101111, //9
	0b01000000, //- //0x0a
	0b01110001, //F //0x0b
	0b00111001, //C //0x0c
	0b01110110, //H //0x0d
	0b01110011, //P //0x0e
	0b00000000, //Null //0x0f
	0b00110111, //N 0x10
	0b01000110  //-1  0x11
};

void tempdecode(signed int temp)
{
	if(temp < 0)
	{
		
		if(temp > -100)
		{
			LED_Buf[0] = LEDCode[0x0A];//-
			LED_Buf[1] = LEDCode[-temp%100/10];//with dot
		}
		else
		{
			LED_Buf[0] = LEDCode[0x11];//-1
			LED_Buf[1] = LEDCode[-temp%100/10];//without dot
		}
	}
	else
	{/**100C**/
		if(temp > 999)
		{
			LED_Buf[0] = LEDCode[temp/1000];
			LED_Buf[1] = LEDCode[temp%1000/100];
		}
		else if(temp < 100)
		{/**0.0~9.9C**/
			LED_Buf[0] = LEDCode[0x0F];//Null
			LED_Buf[1] = LEDCode[temp%100/10];			
		}
		else
		{/**10.0~-99.9C**/
			LED_Buf[0] = LEDCode[temp/100];
			LED_Buf[1] = LEDCode[temp%100/10];
		}
	}
}

void _displayDecode(void)
{
	/****************Start LED decode subtoutine*********/
	if(isUpdateDisplay)
	{
		isUpdateDisplay = 0;
		switch(MachineStatus)
		{
			case SHUTDOWN:
			{
				LED_Buf[0] = LEDCode[0x0f];//Null
				LED_Buf[1] = LEDCode[0x0f];//Null
			}break;
			case WORK://Temperature Control
			{
				tempdecode(CurrentTemp);
			}break;
			case SETTING:
			{
				if(SetMode == SET_TEMP)tempdecode(SetTemp);
				if(SetMode == SET_TIME)
				{
					LED_Buf[0] = LEDCode[WorkTime%100/10];
					LED_Buf[1] = LEDCode[WorkTime%10];
				}
			}break;
			default:;
		}
	}
	//			testValue = 23;
	//			LED_Buf[0] = LEDCode[testValue/10];
	//			LED_Buf[1] = LEDCode[testValue%10];
	/****************End LED decode subtoutine***********/
}
extern void keyscan(void);
void _displayAndKeyscan(void)
{
	static uchar displayNum = 0;
	uchar i;
	/****************Start display subtoutine************/
	PC_ODR |= 0B010101000;//Clear all  PC3/5/7
	/*KeyScan*/
	//Alter IO function
	PD_DDR &= 0B11010011;//PD2/3/5/6
	//Wait a while for stable level
	for(i = 0;i < 20;i++);

	//KeyScan here
	keyscan();
	//Recovery IO funtion
	PD_DDR |= 0B00101100;
	/*End*/
	if(displayNum == 1)
	{
		displayNum = 0;
		PD_ODR_2 = LED_Buf[1]&0b00000001;	//a
		PC_ODR_6 = LED_Buf[1]&0b00000010;	//b
		PA_ODR_2 = LED_Buf[1]&0b00000100;	//c
		PA_ODR_1 = LED_Buf[1]&0b00001000;	//d
		PD_ODR_6 = LED_Buf[1]&0b00010000;	//e
		PD_ODR_3 = LED_Buf[1]&0b00100000;	//f
		PD_ODR_5 = LED_Buf[1]&0b01000000;	//g
		PA_ODR_3 = LED_Buf[1]&0b10000000;	//dp
		PC_ODR &= 0b11011111;							//D0
	}
	else
	{
		displayNum = 1;
		PD_ODR_2 = LED_Buf[0]&0b00000001;	//a
		PC_ODR_6 = LED_Buf[0]&0b00000010;	//b
		PA_ODR_2 = LED_Buf[0]&0b00000100;	//c
		PA_ODR_1 = LED_Buf[0]&0b00001000;	//d
		PD_ODR_6 = LED_Buf[0]&0b00010000;	//e
		PD_ODR_3 = LED_Buf[0]&0b00100000;	//f
		PD_ODR_5 = LED_Buf[0]&0b01000000;	//g
		PA_ODR_3 = LED_Buf[0]&0b10000000;//dp
		PC_ODR &= 0b01111111;							//D1
	}
	
	for(i = 0;i < 200;i++);
	/****************End display subtoutine  ************/
}