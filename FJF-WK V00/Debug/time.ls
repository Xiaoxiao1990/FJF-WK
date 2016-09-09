   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3845                     ; 8 void _timerBaseInitial(void)
3845                     ; 9 {
3847                     	switch	.text
3848  0000               __timerBaseInitial:
3852                     ; 10 	TIM4_IER = 0x00; // disable interrup
3854  0000 725f5343      	clr	_TIM4_IER
3855                     ; 11 	TIM4_EGR = 0x01; // enable update
3857  0004 35015345      	mov	_TIM4_EGR,#1
3858                     ; 12 	TIM4_PSCR = 2; // timerclock=manclock/64=8MHZ/64=8us
3860  0008 35025347      	mov	_TIM4_PSCR,#2
3861                     ; 13 	TIM4_ARR = 255; // set reload resister
3863  000c 35ff5348      	mov	_TIM4_ARR,#255
3864                     ; 14 	TIM4_CNTR = 255; // set conter initial,cycle time=(ARR+1)*16=2.048ms
3866  0010 35ff5346      	mov	_TIM4_CNTR,#255
3867                     ; 15 	TIM4_CR1 = 0x01; // b0 = 1,enable timer 4,b1 = 0, enable update
3869  0014 35015340      	mov	_TIM4_CR1,#1
3870                     ; 16 }
3873  0018 81            	ret
3905                     ; 18 void _timer2_Initial(void)
3905                     ; 19 {
3906                     	switch	.text
3907  0019               __timer2_Initial:
3911                     ; 21   TIM2_IER = 0x00;            // 禁止中断
3913  0019 725f5303      	clr	_TIM2_IER
3914                     ; 22   TIM2_EGR = 0x01;            // 允许产生更新事件
3916  001d 35015306      	mov	_TIM2_EGR,#1
3917                     ; 23   TIM2_PSCR = 0x03;           // 计数器时钟=fmaster/prescaler = 8M/(2^3) = 1Mhz
3919  0021 3503530e      	mov	_TIM2_PSCR,#3
3920                     ; 27   TIM2_ARRH = 0xc3;           // 设定重装载时的寄存器的高8位
3922  0025 35c3530f      	mov	_TIM2_ARRH,#195
3923                     ; 28   TIM2_ARRL = 0x50;  
3925  0029 35505310      	mov	_TIM2_ARRL,#80
3926                     ; 30   TIM2_CNTRH = 0xc3;          // 设定计数器的初值
3928  002d 35c3530c      	mov	_TIM2_CNTRH,#195
3929                     ; 31   TIM2_CNTRL = 0x50;             
3931  0031 3550530d      	mov	_TIM2_CNTRL,#80
3932                     ; 34   TIM2_CR1 = 0x01;            // b0 = 1,允许计数器工作
3934  0035 35015300      	mov	_TIM2_CR1,#1
3935                     ; 37   TIM2_IER = 0x01;            // 允许更新中断
3937  0039 35015303      	mov	_TIM2_IER,#1
3938                     ; 38   _asm("rim");                // 允许CPU全局中断
3941  003d 9a            rim
3943                     ; 39 }
3946  003e 81            	ret
3971                     ; 41 void _timerBase(void)		//2.048ms
3971                     ; 42 {											
3972                     	switch	.text
3973  003f               __timerBase:
3977                     ; 43 	if (bitTIM4_SR1_UIF) // 
3979                     	btst	_bitTIM4_SR1_UIF
3980  0044 2408          	jruge	L5252
3981                     ; 45 		bitTIM4_SR1_UIF = 0; 
3983  0046 72115344      	bres	_bitTIM4_SR1_UIF
3984                     ; 46 		isTimeProcess = Yes;
3986  004a 72100000      	bset	_isTimeProcess
3987  004e               L5252:
3988                     ; 48 }
3991  004e 81            	ret
3994                     	bsct
3995  0000               L7252_timeCNT:
3996  0000 00            	dc.b	0
4036                     ; 50 void _timerWheel(void)
4036                     ; 51 {
4037                     	switch	.text
4038  004f               __timerWheel:
4042                     ; 54 	if(isOneSecond)
4044                     	btst	_isOneSecond
4045  0054 243b          	jruge	L7452
4046                     ; 56 		isOneSecond = Clear;
4048  0056 72110000      	bres	_isOneSecond
4049                     ; 57 		isUpdateDisplay = Yes;
4051  005a 72100000      	bset	_isUpdateDisplay
4052                     ; 59 		if(MachineStatus == WORK)
4054  005e b600          	ld	a,_MachineStatus
4055  0060 a101          	cp	a,#1
4056  0062 2610          	jrne	L1552
4057                     ; 61 			if(WorkTimeBkp > 0)
4059  0064 3d00          	tnz	_WorkTimeBkp
4060  0066 270c          	jreq	L1552
4061                     ; 63 				if(++timeCNT > 59)
4063  0068 3c00          	inc	L7252_timeCNT
4064  006a b600          	ld	a,L7252_timeCNT
4065  006c a13c          	cp	a,#60
4066  006e 2504          	jrult	L1552
4067                     ; 65 					timeCNT = 0;
4069  0070 3f00          	clr	L7252_timeCNT
4070                     ; 66 					WorkTimeBkp--;
4072  0072 3a00          	dec	_WorkTimeBkp
4073  0074               L1552:
4074                     ; 71 		if(MachineStatus == SETTING)
4076  0074 b600          	ld	a,_MachineStatus
4077  0076 a102          	cp	a,#2
4078  0078 2617          	jrne	L7452
4079                     ; 73 			if(++inSetTimer > 5)
4081  007a 3c00          	inc	_inSetTimer
4082  007c b600          	ld	a,_inSetTimer
4083  007e a106          	cp	a,#6
4084  0080 250f          	jrult	L7452
4085                     ; 75 				isInSetting = 0;
4087  0082 72110000      	bres	_isInSetting
4088                     ; 76 				inSetTimer = 0;
4090  0086 3f00          	clr	_inSetTimer
4091                     ; 77 				MachineStatus = WORK;
4093  0088 35010000      	mov	_MachineStatus,#1
4094                     ; 78 				SetMode = SET_TEMP;
4096  008c 3f00          	clr	_SetMode
4097                     ; 79 				_EEPROM_saveSettings();
4099  008e cd0000        	call	__EEPROM_saveSettings
4101  0091               L7452:
4102                     ; 83 }
4105  0091 81            	ret
4118                     	xref.b	_WorkTimeBkp
4119                     	xbit	_isInSetting
4120                     	xbit	_isTimeProcess
4121                     	xref.b	_SetMode
4122                     	xref.b	_MachineStatus
4123                     	xref.b	_inSetTimer
4124                     	xbit	_isOneSecond
4125                     	xbit	_isUpdateDisplay
4126                     	xref	__EEPROM_saveSettings
4127                     	xdef	__timerBase
4128                     	xdef	__timerWheel
4129                     	xdef	__timer2_Initial
4130                     	xdef	__timerBaseInitial
4149                     	end
