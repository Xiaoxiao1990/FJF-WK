   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3844                     ; 13 @far @interrupt void NonHandledInterrupt (void)
3844                     ; 14 {
3845                     	switch	.text
3846  0000               f_NonHandledInterrupt:
3850                     ; 18 	return;
3853  0000 80            	iret
3855                     	bsct
3856  0000               L5052_basicTimeCNT:
3857  0000 00            	dc.b	0
3858  0001               L7052_timeCNT:
3859  0001 00            	dc.b	0
3905                     ; 23 @far @interrupt void TIM2_UPD_IRQHandler (void)
3905                     ; 24 {
3906                     	switch	.text
3907  0001               f_TIM2_UPD_IRQHandler:
3911                     ; 29 	TIM2_SR1 = 0x00;          			// 清除更新标志
3913  0001 725f5304      	clr	_TIM2_SR1
3914                     ; 30 	if(++basicTimeCNT > 19)					//20*50ms = 1s
3916  0005 3c00          	inc	L5052_basicTimeCNT
3917  0007 b600          	ld	a,L5052_basicTimeCNT
3918  0009 a114          	cp	a,#20
3919  000b 250a          	jrult	L3352
3920                     ; 32 		basicTimeCNT = 0;
3922  000d 3f00          	clr	L5052_basicTimeCNT
3923                     ; 33 		isOneSecond = Yes;
3925  000f 72100000      	bset	_isOneSecond
3926                     ; 34 		isFlash1Hz ^= 1;
3928  0013 90100000      	bcpl	_isFlash1Hz
3929  0017               L3352:
3930                     ; 36 	if(++timeCNT > 3)
3932  0017 3c01          	inc	L7052_timeCNT
3933  0019 b601          	ld	a,L7052_timeCNT
3934  001b a104          	cp	a,#4
3935  001d 2506          	jrult	L5352
3936                     ; 38 		timeCNT = 0;
3938  001f 3f01          	clr	L7052_timeCNT
3939                     ; 39 		isFlash3Hz ^= 1;
3941  0021 90100000      	bcpl	_isFlash3Hz
3942  0025               L5352:
3943                     ; 41 }
3946  0025 80            	iret
3948                     .const:	section	.text
3949  0000               __vectab:
3950  0000 82            	dc.b	130
3952  0001 00            	dc.b	page(__stext)
3953  0002 0000          	dc.w	__stext
3954  0004 82            	dc.b	130
3956  0005 00            	dc.b	page(f_NonHandledInterrupt)
3957  0006 0000          	dc.w	f_NonHandledInterrupt
3958  0008 82            	dc.b	130
3960  0009 00            	dc.b	page(f_NonHandledInterrupt)
3961  000a 0000          	dc.w	f_NonHandledInterrupt
3962  000c 82            	dc.b	130
3964  000d 00            	dc.b	page(f_NonHandledInterrupt)
3965  000e 0000          	dc.w	f_NonHandledInterrupt
3966  0010 82            	dc.b	130
3968  0011 00            	dc.b	page(f_NonHandledInterrupt)
3969  0012 0000          	dc.w	f_NonHandledInterrupt
3970  0014 82            	dc.b	130
3972  0015 00            	dc.b	page(f_NonHandledInterrupt)
3973  0016 0000          	dc.w	f_NonHandledInterrupt
3974  0018 82            	dc.b	130
3976  0019 00            	dc.b	page(f_NonHandledInterrupt)
3977  001a 0000          	dc.w	f_NonHandledInterrupt
3978  001c 82            	dc.b	130
3980  001d 00            	dc.b	page(f_NonHandledInterrupt)
3981  001e 0000          	dc.w	f_NonHandledInterrupt
3982  0020 82            	dc.b	130
3984  0021 00            	dc.b	page(f_NonHandledInterrupt)
3985  0022 0000          	dc.w	f_NonHandledInterrupt
3986  0024 82            	dc.b	130
3988  0025 00            	dc.b	page(f_NonHandledInterrupt)
3989  0026 0000          	dc.w	f_NonHandledInterrupt
3990  0028 82            	dc.b	130
3992  0029 00            	dc.b	page(f_NonHandledInterrupt)
3993  002a 0000          	dc.w	f_NonHandledInterrupt
3994  002c 82            	dc.b	130
3996  002d 00            	dc.b	page(f_NonHandledInterrupt)
3997  002e 0000          	dc.w	f_NonHandledInterrupt
3998  0030 82            	dc.b	130
4000  0031 00            	dc.b	page(f_NonHandledInterrupt)
4001  0032 0000          	dc.w	f_NonHandledInterrupt
4002  0034 82            	dc.b	130
4004  0035 00            	dc.b	page(f_NonHandledInterrupt)
4005  0036 0000          	dc.w	f_NonHandledInterrupt
4006  0038 82            	dc.b	130
4008  0039 00            	dc.b	page(f_NonHandledInterrupt)
4009  003a 0000          	dc.w	f_NonHandledInterrupt
4010  003c 82            	dc.b	130
4012  003d 01            	dc.b	page(f_TIM2_UPD_IRQHandler)
4013  003e 0001          	dc.w	f_TIM2_UPD_IRQHandler
4014  0040 82            	dc.b	130
4016  0041 00            	dc.b	page(f_NonHandledInterrupt)
4017  0042 0000          	dc.w	f_NonHandledInterrupt
4018  0044 82            	dc.b	130
4020  0045 00            	dc.b	page(f_NonHandledInterrupt)
4021  0046 0000          	dc.w	f_NonHandledInterrupt
4022  0048 82            	dc.b	130
4024  0049 00            	dc.b	page(f_NonHandledInterrupt)
4025  004a 0000          	dc.w	f_NonHandledInterrupt
4026  004c 82            	dc.b	130
4028  004d 00            	dc.b	page(f_NonHandledInterrupt)
4029  004e 0000          	dc.w	f_NonHandledInterrupt
4030  0050 82            	dc.b	130
4032  0051 00            	dc.b	page(f_NonHandledInterrupt)
4033  0052 0000          	dc.w	f_NonHandledInterrupt
4034  0054 82            	dc.b	130
4036  0055 00            	dc.b	page(f_NonHandledInterrupt)
4037  0056 0000          	dc.w	f_NonHandledInterrupt
4038  0058 82            	dc.b	130
4040  0059 00            	dc.b	page(f_NonHandledInterrupt)
4041  005a 0000          	dc.w	f_NonHandledInterrupt
4042  005c 82            	dc.b	130
4044  005d 00            	dc.b	page(f_NonHandledInterrupt)
4045  005e 0000          	dc.w	f_NonHandledInterrupt
4046  0060 82            	dc.b	130
4048  0061 00            	dc.b	page(f_NonHandledInterrupt)
4049  0062 0000          	dc.w	f_NonHandledInterrupt
4050  0064 82            	dc.b	130
4052  0065 00            	dc.b	page(f_NonHandledInterrupt)
4053  0066 0000          	dc.w	f_NonHandledInterrupt
4054  0068 82            	dc.b	130
4056  0069 00            	dc.b	page(f_NonHandledInterrupt)
4057  006a 0000          	dc.w	f_NonHandledInterrupt
4058  006c 82            	dc.b	130
4060  006d 00            	dc.b	page(f_NonHandledInterrupt)
4061  006e 0000          	dc.w	f_NonHandledInterrupt
4062  0070 82            	dc.b	130
4064  0071 00            	dc.b	page(f_NonHandledInterrupt)
4065  0072 0000          	dc.w	f_NonHandledInterrupt
4066  0074 82            	dc.b	130
4068  0075 00            	dc.b	page(f_NonHandledInterrupt)
4069  0076 0000          	dc.w	f_NonHandledInterrupt
4070  0078 82            	dc.b	130
4072  0079 00            	dc.b	page(f_NonHandledInterrupt)
4073  007a 0000          	dc.w	f_NonHandledInterrupt
4074  007c 82            	dc.b	130
4076  007d 00            	dc.b	page(f_NonHandledInterrupt)
4077  007e 0000          	dc.w	f_NonHandledInterrupt
4128                     	xdef	__vectab
4129                     	xdef	f_TIM2_UPD_IRQHandler
4130                     	xref	__stext
4131                     	xdef	f_NonHandledInterrupt
4132                     	xbit	_isFlash3Hz
4133                     	xbit	_isFlash1Hz
4134                     	xbit	_isOneSecond
4153                     	end
