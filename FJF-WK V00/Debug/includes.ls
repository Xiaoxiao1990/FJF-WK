   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3788                     	bsct
3789  0000               _SetTemp:
3790  0000 0028          	dc.w	40
3953                     	switch	.ubsct
3954  0000               _testValue:
3955  0000 00            	ds.b	1
3956                     	xdef	_testValue
3957  0001               _WorkTimeBkp:
3958  0001 00            	ds.b	1
3959                     	xdef	_WorkTimeBkp
3960  0002               _WorkTime:
3961  0002 00            	ds.b	1
3962                     	xdef	_WorkTime
3963  0003               _CurrentTemp:
3964  0003 0000          	ds.b	2
3965                     	xdef	_CurrentTemp
3966                     	xdef	_SetTemp
3967                     .bit:	section	.data,bit
3968  0000               _isInSetting:
3969  0000 00            	ds.b	1
3970                     	xdef	_isInSetting
3971  0001               _isTimeProcess:
3972  0001 00            	ds.b	1
3973                     	xdef	_isTimeProcess
3974                     	switch	.ubsct
3975  0005               _SetMode:
3976  0005 00            	ds.b	1
3977                     	xdef	_SetMode
3978  0006               _MachineStatus:
3979  0006 00            	ds.b	1
3980                     	xdef	_MachineStatus
3981  0007               _inSetTimer:
3982  0007 00            	ds.b	1
3983                     	xdef	_inSetTimer
3984                     	switch	.bit
3985  0002               _isFlash3Hz:
3986  0002 00            	ds.b	1
3987                     	xdef	_isFlash3Hz
3988  0003               _isFlash1Hz:
3989  0003 00            	ds.b	1
3990                     	xdef	_isFlash1Hz
3991  0004               _isOneSecond:
3992  0004 00            	ds.b	1
3993                     	xdef	_isOneSecond
3994  0005               _isUpdateDisplay:
3995  0005 00            	ds.b	1
3996                     	xdef	_isUpdateDisplay
3997                     	switch	.ubsct
3998  0008               _LED_Buf:
3999  0008 0000          	ds.b	2
4000                     	xdef	_LED_Buf
4020                     	end
