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
	//初始化定时器2                               
  TIM2_IER = 0x00;            // 禁止中断
  TIM2_EGR = 0x01;            // 允许产生更新事件
  TIM2_PSCR = 0x03;           // 计数器时钟=fmaster/prescaler = 8M/(2^3) = 1Mhz
															// 相当于计数器周期为1uS
														  // 设定重装载时的寄存器值
															// 注意必须保证先写入高8位，再写入低8位
  TIM2_ARRH = 0xc3;           // 设定重装载时的寄存器的高8位
  TIM2_ARRL = 0x50;  
  
  TIM2_CNTRH = 0xc3;          // 设定计数器的初值
  TIM2_CNTRL = 0x50;             
                              // 定时周期=1*50000=50000uS=50ms

  TIM2_CR1 = 0x01;            // b0 = 1,允许计数器工作
                              // b1 = 0,允许更新
                              // 设置控制器，启动定时器
  TIM2_IER = 0x01;            // 允许更新中断
  _asm("rim");                // 允许CPU全局中断
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