#include "includes.h"
#include "stm8s_adc1.h"

#define RES_UPVALUE	1594// 51000/32

//============== resister =============

#define RESISTOR_TEMP_UPLIMIT 114	//140C
#define RESISTOR_TEMP_LOWLIMIT 9297	//-10C
//-10~100
//R25`C = 54.62K;  B=3950
//Rtable = R/32
const uint tempTable[111]={
9297,8822,8372,7950,7550,7172,6816,6478,6159,5859,5575,5297,
5034,4784,4550,4325,4116,3916,3728,3547,3378,3222,3073,2933,
2799,2672,2552,2438,2329,2226,2128,2035,1947,1863,1783,1707,
1633,1564,1497,1434,1374,1317,1262,1210,1160,1113,1068,1025,
983,945,907,871,837,804,773,743,715,688,662,637,613,590,569,
548,528,508,489,472,454,438,422,407,393,378,365,353,340,328,
317,306,296,286,276,267,258,250,241,233,226,219,211,205,198,
192,186,180,174,169,164,159,154,150,145,141,136,132,129,125,
121,118,114
};
/***************************************************************
===================== _AD_resister initialize ==================

****************************************************************/
void _ADC_Initial(void)
{
	uchar i;

	ADC_CR2 = ADC1_ALIGN_RIGHT; // A/D data rigth align
	ADC_CR1 = 0x00; // ADC clock=main clock/2=4MHZm,sigle converterm,disable convert
	ADC_CSR = 0x02; // choose channel 2
	//ADC_TDRL = 0x20;
	bitADC1_CR1_ADON = 1;	//ADC_CR1 = 0x01; // enable AD start
	
	for(i=0;i<100;i++); // wait at least 7us
	for(i=0;i<100;i++); // wait at least 7us
	bitADC1_CR1_ADON = 1;
	bitADC1_CSR_EOC = 0;
}

void _AD_temperature(void)
{
	int temp0;
	uchar i;
	uint	ResistorValue;
	static uchar sumTimes = 0;
	static uint	sum_AD_value = 0;
	static signed int CurrentTempBkp = 0,CurrentTempValue = 0;
	
	if (ADC1_GetFlagStatus(ADC1_FLAG_EOC)== 0) return;// SET or RESET
	sum_AD_value += ADC1_GetConversionValue();
	bitADC1_CR1_ADON = 1;
	if (++sumTimes >= 16)
	{
		sumTimes = 0;
		sum_AD_value >>= 4;
		if(sum_AD_value >= 1000)//NTC may Open circuit
		{
			ResistorValue = RESISTOR_TEMP_LOWLIMIT;
			if(MachineStatus == WORK)MachineStatus = SHUTDOWN;
		}
		else
		{
			ResistorValue = (long)sum_AD_value*RES_UPVALUE/(1024-sum_AD_value);
		}
		if (ResistorValue >= RESISTOR_TEMP_LOWLIMIT)//-30`c ,
		{
			ResistorValue = RESISTOR_TEMP_LOWLIMIT;
			CurrentTempValue = -100;
		}
		else if (ResistorValue < RESISTOR_TEMP_UPLIMIT)//NTC may short circuit
		{
			ResistorValue = RESISTOR_TEMP_UPLIMIT;
			CurrentTempValue = 1000;
			if(MachineStatus == WORK)MachineStatus = SHUTDOWN;
		}	
		else 
		{
			for (i = 0;ResistorValue <= tempTable[i];i++)if(i > 200)break;
			if(i == 0)
			{
				CurrentTempValue = -100;
			}
			else
			{
				temp0 = (long)10*(tempTable[i-1]-ResistorValue)/(tempTable[i-1]-tempTable[i])+1;
				CurrentTempValue = -100+(i-1)*10+temp0;
				if (CurrentTempValue <= -100)
				{
					CurrentTempValue = -100;
				}
				else
				{
					if(CurrentTempValue > 1000)
					{
						CurrentTempValue = 1000;
					}
				}
			}
		}

		CurrentTempBkp = (13*CurrentTempBkp + CurrentTempValue*3)>>4;//filter
		CurrentTemp = CurrentTempBkp;//+ CorrectTemp*10;
		isUpdateDisplay = Yes;
	
	//	CurrentTemp += CorrectTemp;
		sum_AD_value = 0;
	}
}