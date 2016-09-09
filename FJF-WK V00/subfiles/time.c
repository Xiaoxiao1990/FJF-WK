#include "includes.h"

#define IN_SET_TIME 5		//5 seconds
#define pinRelay 	PD_ODR_1
#define pinBuzzer PD_ODR_4
#define BUZZER_TIME 122

void _timerBaseInitial(void)
{
	TIM4_IER = 0x00; // disable interrup
	TIM4_EGR = 0x01; // enable update
	TIM4_PSCR = 2; // timerclock=manclock/64=8MHZ/64=8us
	TIM4_ARR = 255; // set reload resister
	TIM4_CNTR = 255; // set conter initial,cycle time=(ARR+1)*16=2.048ms
	TIM4_CR1 = 0x01; // b0 = 1,enable timer 4,b1 = 0, enable update
}

void _timer2_Initial(void)
{
	//��ʼ����ʱ��2                               
  TIM2_IER = 0x00;            // ��ֹ�ж�
  TIM2_EGR = 0x01;            // ������������¼�
  TIM2_PSCR = 0x03;           // ������ʱ��=fmaster/prescaler = 8M/(2^3) = 1Mhz
															// �൱�ڼ���������Ϊ1uS
														  // �趨��װ��ʱ�ļĴ���ֵ
															// ע����뱣֤��д���8λ����д���8λ
  TIM2_ARRH = 0xc3;           // �趨��װ��ʱ�ļĴ����ĸ�8λ
  TIM2_ARRL = 0x50;  
  
  TIM2_CNTRH = 0xc3;          // �趨�������ĳ�ֵ
  TIM2_CNTRL = 0x50;             
                              // ��ʱ����=1*50000=50000uS=50ms

  TIM2_CR1 = 0x01;            // b0 = 1,�������������
                              // b1 = 0,�������
                              // ���ÿ�������������ʱ��
  TIM2_IER = 0x01;            // ��������ж�
  _asm("rim");                // ����CPUȫ���ж�
}

void _timerBase(void)		//2.048ms
{											
	if (bitTIM4_SR1_UIF) // 
	{
		bitTIM4_SR1_UIF = 0; 
		isTimeProcess = Yes;
	}
}

void _timerWheel(void)
{
	static uchar timeCNT = 0;
	
	if(isOneSecond)
	{
		isOneSecond = Clear;
		isUpdateDisplay = Yes;
		
		if(MachineStatus == WORK)
		{
			if(WorkTimeBkp > 0)
			{
				if(++timeCNT > 59)
				{
					timeCNT = 0;
					WorkTimeBkp--;
				}
			}
		}
		
		if(MachineStatus == SETTING)
		{
			if(++inSetTimer > 5)
			{
				isInSetting = 0;
				inSetTimer = 0;
				MachineStatus = WORK;
				SetMode = SET_TEMP;
				_EEPROM_saveSettings();
			}
		}
	}
}