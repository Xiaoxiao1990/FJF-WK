   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3852                     ; 9 void _output(void)
3852                     ; 10 {
3854                     	switch	.text
3855  0000               __output:
3859                     ; 11 	switch(MachineStatus)
3861  0000 b600          	ld	a,_MachineStatus
3863                     ; 55 		default:;
3864  0002 4d            	tnz	a
3865  0003 2709          	jreq	L7642
3866  0005 4a            	dec	a
3867  0006 2715          	jreq	L1742
3868  0008 4a            	dec	a
3869  0009 2767          	jreq	L3742
3870  000b cc00a6        	jra	L7152
3871  000e               L7642:
3872                     ; 15 			Green = OFF;
3874  000e 721a5005      	bset	_PB_ODR_5
3875                     ; 16 			Red   = OFF;
3877  0012 72185005      	bset	_PB_ODR_4
3878                     ; 17 			Heat = 0;
3880  0016 7219500f      	bres	_PD_ODR_4
3881                     ; 20 		break;
3883  001a cc00a6        	jra	L7152
3884  001d               L1742:
3885                     ; 23 			if(WorkTimeBkp > 0)
3887  001d 3d00          	tnz	_WorkTimeBkp
3888  001f 271b          	jreq	L1252
3889                     ; 25 				if(CurrentTemp <= (SetTemp - 30))
3891  0021 9c            	rvf
3892  0022 be00          	ldw	x,_SetTemp
3893  0024 1d001e        	subw	x,#30
3894  0027 b300          	cpw	x,_CurrentTemp
3895  0029 2f04          	jrslt	L3252
3896                     ; 27 					Heat = 1;
3898  002b 7218500f      	bset	_PD_ODR_4
3899  002f               L3252:
3900                     ; 29 				if(CurrentTemp >= SetTemp)Heat = 0;
3902  002f 9c            	rvf
3903  0030 be00          	ldw	x,_CurrentTemp
3904  0032 b300          	cpw	x,_SetTemp
3905  0034 2f0c          	jrslt	L7252
3908  0036 7219500f      	bres	_PD_ODR_4
3909  003a 2006          	jra	L7252
3910  003c               L1252:
3911                     ; 33 				MachineStatus = SHUTDOWN;
3913  003c 3f00          	clr	_MachineStatus
3914                     ; 34 				Heat = 0;
3916  003e 7219500f      	bres	_PD_ODR_4
3917  0042               L7252:
3918                     ; 36 			Red = Heat^1;
3920  0042 4f            	clr	a
3921                     	btst	_PD_ODR_4
3922  0048 49            	rlc	a
3923  0049 a801          	xor	a,#1
3924  004b 2602          	jrne	L02
3925  004d 2006          	jp	L6
3926  004f               L02:
3927  004f 72185005      	bset	_PB_ODR_4
3928  0053 2004          	jra	L01
3929  0055               L6:
3930  0055 72195005      	bres	_PB_ODR_4
3931  0059               L01:
3932                     ; 37 			Green = Red^1;
3934  0059 4f            	clr	a
3935                     	btst	_PB_ODR_4
3936  005f 49            	rlc	a
3937  0060 a801          	xor	a,#1
3938  0062 2602          	jrne	L22
3939  0064 2006          	jp	L21
3940  0066               L22:
3941  0066 721a5005      	bset	_PB_ODR_5
3942  006a 2004          	jra	L41
3943  006c               L21:
3944  006c 721b5005      	bres	_PB_ODR_5
3945  0070               L41:
3946                     ; 39 		break;
3948  0070 2034          	jra	L7152
3949  0072               L3742:
3950                     ; 42 			if(SetMode == SET_TEMP)
3952  0072 3d00          	tnz	_SetMode
3953  0074 2611          	jrne	L1352
3954                     ; 44 				if(isFlash1Hz)Red = ON;
3956                     	btst	_isFlash1Hz
3957  007b 2406          	jruge	L3352
3960  007d 72195005      	bres	_PB_ODR_4
3962  0081 2004          	jra	L1352
3963  0083               L3352:
3964                     ; 45 				else Red = OFF;
3966  0083 72185005      	bset	_PB_ODR_4
3967  0087               L1352:
3968                     ; 47 			if(SetMode == SET_TIME)
3970  0087 b600          	ld	a,_SetMode
3971  0089 a101          	cp	a,#1
3972  008b 2611          	jrne	L7352
3973                     ; 49 				if(isFlash3Hz)Red = ON;
3975                     	btst	_isFlash3Hz
3976  0092 2406          	jruge	L1452
3979  0094 72195005      	bres	_PB_ODR_4
3981  0098 2004          	jra	L7352
3982  009a               L1452:
3983                     ; 50 				else Red = OFF;
3985  009a 72185005      	bset	_PB_ODR_4
3986  009e               L7352:
3987                     ; 52 			Green = OFF;
3989  009e 721a5005      	bset	_PB_ODR_5
3990                     ; 53 			Heat = 0;
3992  00a2 7219500f      	bres	_PD_ODR_4
3993                     ; 54 		}break;
3995  00a6               L7152:
3996                     ; 57 }
3999  00a6 81            	ret
4012                     	xref.b	_WorkTimeBkp
4013                     	xref.b	_CurrentTemp
4014                     	xref.b	_SetTemp
4015                     	xref.b	_SetMode
4016                     	xref.b	_MachineStatus
4017                     	xbit	_isFlash3Hz
4018                     	xbit	_isFlash1Hz
4019                     	xdef	__output
4038                     	end
