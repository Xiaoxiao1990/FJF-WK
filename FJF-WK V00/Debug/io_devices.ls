   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3788                     .const:	section	.text
3789  0000               _LEDCode:
3790  0000 3f            	dc.b	63
3791  0001 06            	dc.b	6
3792  0002 5b            	dc.b	91
3793  0003 4f            	dc.b	79
3794  0004 66            	dc.b	102
3795  0005 6d            	dc.b	109
3796  0006 7d            	dc.b	125
3797  0007 07            	dc.b	7
3798  0008 7f            	dc.b	127
3799  0009 6f            	dc.b	111
3800  000a 40            	dc.b	64
3801  000b 71            	dc.b	113
3802  000c 39            	dc.b	57
3803  000d 76            	dc.b	118
3804  000e 73            	dc.b	115
3805  000f 00            	dc.b	0
3862                     ; 60 void _IOInitial(void)
3862                     ; 61 {
3864                     	switch	.text
3865  0000               __IOInitial:
3869                     ; 62 	pinRelay = Reset;//Off
3871  0000 7213500f      	bres	_PD_ODR_1
3872                     ; 63 }
3875  0004 81            	ret
3902                     ; 65 void T_C_relay(void)
3902                     ; 66 {
3903                     	switch	.text
3904  0005               _T_C_relay:
3908                     ; 67 	if(HighTemp > LowTemp)
3910  0005 9c            	rvf
3911  0006 b600          	ld	a,_HighTemp
3912  0008 b100          	cp	a,_LowTemp
3913  000a 2d32          	jrsle	L5152
3914                     ; 69 		if(CurrentTemp >= (HighTemp*10))
3916  000c 9c            	rvf
3917  000d 5f            	clrw	x
3918  000e b600          	ld	a,_HighTemp
3919  0010 2a01          	jrpl	L01
3920  0012 53            	cplw	x
3921  0013               L01:
3922  0013 97            	ld	xl,a
3923  0014 90ae000a      	ldw	y,#10
3924  0018 cd0000        	call	c_imul
3926  001b b300          	cpw	x,_CurrentTemp
3927  001d 2c06          	jrsgt	L7152
3928                     ; 71 			pinRelay = Set;
3930  001f 7212500f      	bset	_PD_ODR_1
3932  0023 2056          	jra	L5252
3933  0025               L7152:
3934                     ; 73 		else if(CurrentTemp <= (LowTemp*10))
3936  0025 9c            	rvf
3937  0026 5f            	clrw	x
3938  0027 b600          	ld	a,_LowTemp
3939  0029 2a01          	jrpl	L21
3940  002b 53            	cplw	x
3941  002c               L21:
3942  002c 97            	ld	xl,a
3943  002d 90ae000a      	ldw	y,#10
3944  0031 cd0000        	call	c_imul
3946  0034 b300          	cpw	x,_CurrentTemp
3947  0036 2f43          	jrslt	L5252
3948                     ; 75 			pinRelay = Reset;
3950  0038 7213500f      	bres	_PD_ODR_1
3951  003c 203d          	jra	L5252
3952  003e               L5152:
3953                     ; 78 	else if(HighTemp < LowTemp)
3955  003e 9c            	rvf
3956  003f b600          	ld	a,_HighTemp
3957  0041 b100          	cp	a,_LowTemp
3958  0043 2e32          	jrsge	L7252
3959                     ; 80 		if(CurrentTemp <= (10*HighTemp))
3961  0045 9c            	rvf
3962  0046 5f            	clrw	x
3963  0047 b600          	ld	a,_HighTemp
3964  0049 2a01          	jrpl	L41
3965  004b 53            	cplw	x
3966  004c               L41:
3967  004c 97            	ld	xl,a
3968  004d 90ae000a      	ldw	y,#10
3969  0051 cd0000        	call	c_imul
3971  0054 b300          	cpw	x,_CurrentTemp
3972  0056 2f06          	jrslt	L1352
3973                     ; 82 			pinRelay = Set;
3975  0058 7212500f      	bset	_PD_ODR_1
3977  005c 201d          	jra	L5252
3978  005e               L1352:
3979                     ; 84 		else if(CurrentTemp >= (10*LowTemp))
3981  005e 9c            	rvf
3982  005f 5f            	clrw	x
3983  0060 b600          	ld	a,_LowTemp
3984  0062 2a01          	jrpl	L61
3985  0064 53            	cplw	x
3986  0065               L61:
3987  0065 97            	ld	xl,a
3988  0066 90ae000a      	ldw	y,#10
3989  006a cd0000        	call	c_imul
3991  006d b300          	cpw	x,_CurrentTemp
3992  006f 2c0a          	jrsgt	L5252
3993                     ; 86 			pinRelay = Reset;
3995  0071 7213500f      	bres	_PD_ODR_1
3996  0075 2004          	jra	L5252
3997  0077               L7252:
3998                     ; 91 		pinRelay = Reset;
4000  0077 7213500f      	bres	_PD_ODR_1
4001  007b               L5252:
4002                     ; 93 }
4005  007b 81            	ret
4029                     ; 95 void _output(void)
4029                     ; 96 {
4030                     	switch	.text
4031  007c               __output:
4035                     ; 101 }
4039  007c 81            	ret
4068                     ; 103 void _displayDecode(void)
4068                     ; 104 {
4069                     	switch	.text
4070  007d               __displayDecode:
4074                     ; 106 	if(isUpdateDisplay)
4076                     	btst	_isUpdateDisplay
4077  0082 2503          	jrult	L63
4078  0084 cc0216        	jp	L3752
4079  0087               L63:
4080                     ; 108 		isUpdateDisplay = 0;
4082  0087 72110000      	bres	_isUpdateDisplay
4083                     ; 109 		switch(MachineStatus)
4085  008b b600          	ld	a,_MachineStatus
4087                     ; 189 			default:;
4088  008d 4d            	tnz	a
4089  008e 270d          	jreq	L1552
4090  0090 4a            	dec	a
4091  0091 2716          	jreq	L3552
4092  0093 4a            	dec	a
4093  0094 2603          	jrne	L04
4094  0096 cc01b7        	jp	L5552
4095  0099               L04:
4096  0099 ac160216      	jpf	L3752
4097  009d               L1552:
4098                     ; 113 				LED_Buf[0] = 0x0f;//Null
4100  009d 350f0000      	mov	_LED_Buf,#15
4101                     ; 114 				LED_Buf[1] = 0x0f;//Null
4103  00a1 350f0001      	mov	_LED_Buf+1,#15
4104                     ; 115 				LED_Buf[2] = 0x0f;//Null
4106  00a5 350f0002      	mov	_LED_Buf+2,#15
4107  00a9               L3552:
4108                     ; 119 				if(CurrentTemp < 0)
4110  00a9 9c            	rvf
4111  00aa be00          	ldw	x,_CurrentTemp
4112  00ac 2e7a          	jrsge	L1062
4113                     ; 121 					if(CurrentTemp < -99)
4115  00ae 9c            	rvf
4116  00af be00          	ldw	x,_CurrentTemp
4117  00b1 a3ff9d        	cpw	x,#65437
4118  00b4 2e52          	jrsge	L3062
4119                     ; 123 						if(CurrentTemp < -199)
4121  00b6 9c            	rvf
4122  00b7 be00          	ldw	x,_CurrentTemp
4123  00b9 a3ff39        	cpw	x,#65337
4124  00bc 2e25          	jrsge	L5062
4125                     ; 125 							LED_Buf[0] = 0x0A;//-
4127  00be 350a0000      	mov	_LED_Buf,#10
4128                     ; 126 							LED_Buf[1] = -CurrentTemp/100;
4130  00c2 be00          	ldw	x,_CurrentTemp
4131  00c4 50            	negw	x
4132  00c5 a664          	ld	a,#100
4133  00c7 cd0000        	call	c_sdivx
4135  00ca 01            	rrwa	x,a
4136  00cb b701          	ld	_LED_Buf+1,a
4137  00cd 02            	rlwa	x,a
4138                     ; 127 							LED_Buf[2] = -CurrentTemp%100/10;
4140  00ce be00          	ldw	x,_CurrentTemp
4141  00d0 50            	negw	x
4142  00d1 a664          	ld	a,#100
4143  00d3 cd0000        	call	c_smodx
4145  00d6 a60a          	ld	a,#10
4146  00d8 cd0000        	call	c_sdivx
4148  00db 01            	rrwa	x,a
4149  00dc b702          	ld	_LED_Buf+2,a
4150  00de 02            	rlwa	x,a
4152  00df ac160216      	jpf	L3752
4153  00e3               L5062:
4154                     ; 131 							LED_Buf[0] = 0x0B;//-1
4156  00e3 350b0000      	mov	_LED_Buf,#11
4157                     ; 132 							LED_Buf[1] = -CurrentTemp%100/10;
4159  00e7 be00          	ldw	x,_CurrentTemp
4160  00e9 50            	negw	x
4161  00ea a664          	ld	a,#100
4162  00ec cd0000        	call	c_smodx
4164  00ef a60a          	ld	a,#10
4165  00f1 cd0000        	call	c_sdivx
4167  00f4 01            	rrwa	x,a
4168  00f5 b701          	ld	_LED_Buf+1,a
4169  00f7 02            	rlwa	x,a
4170                     ; 133 							LED_Buf[2] = -CurrentTemp%10;
4172  00f8 be00          	ldw	x,_CurrentTemp
4173  00fa 50            	negw	x
4174  00fb a60a          	ld	a,#10
4175  00fd cd0000        	call	c_smodx
4177  0100 01            	rrwa	x,a
4178  0101 b702          	ld	_LED_Buf+2,a
4179  0103 02            	rlwa	x,a
4180  0104 ac160216      	jpf	L3752
4181  0108               L3062:
4182                     ; 138 						LED_Buf[0] = 0x0A;//-
4184  0108 350a0000      	mov	_LED_Buf,#10
4185                     ; 139 						LED_Buf[1] = -CurrentTemp/10;
4187  010c be00          	ldw	x,_CurrentTemp
4188  010e 50            	negw	x
4189  010f a60a          	ld	a,#10
4190  0111 cd0000        	call	c_sdivx
4192  0114 01            	rrwa	x,a
4193  0115 b701          	ld	_LED_Buf+1,a
4194  0117 02            	rlwa	x,a
4195                     ; 140 						LED_Buf[2] = -CurrentTemp%10;
4197  0118 be00          	ldw	x,_CurrentTemp
4198  011a 50            	negw	x
4199  011b a60a          	ld	a,#10
4200  011d cd0000        	call	c_smodx
4202  0120 01            	rrwa	x,a
4203  0121 b702          	ld	_LED_Buf+2,a
4204  0123 02            	rlwa	x,a
4205  0124 ac160216      	jpf	L3752
4206  0128               L1062:
4207                     ; 145 					if(CurrentTemp > 999)
4209  0128 9c            	rvf
4210  0129 be00          	ldw	x,_CurrentTemp
4211  012b a303e8        	cpw	x,#1000
4212  012e 2f34          	jrslt	L5162
4213                     ; 147 						LED_Buf[0] = CurrentTemp/1000;
4215  0130 be00          	ldw	x,_CurrentTemp
4216  0132 90ae03e8      	ldw	y,#1000
4217  0136 cd0000        	call	c_idiv
4219  0139 01            	rrwa	x,a
4220  013a b700          	ld	_LED_Buf,a
4221  013c 02            	rlwa	x,a
4222                     ; 148 						LED_Buf[1] = CurrentTemp%1000/100;
4224  013d be00          	ldw	x,_CurrentTemp
4225  013f 90ae03e8      	ldw	y,#1000
4226  0143 cd0000        	call	c_idiv
4228  0146 51            	exgw	x,y
4229  0147 a664          	ld	a,#100
4230  0149 cd0000        	call	c_sdivx
4232  014c 01            	rrwa	x,a
4233  014d b701          	ld	_LED_Buf+1,a
4234  014f 02            	rlwa	x,a
4235                     ; 149 						LED_Buf[2] = CurrentTemp%100/10;
4237  0150 be00          	ldw	x,_CurrentTemp
4238  0152 a664          	ld	a,#100
4239  0154 cd0000        	call	c_smodx
4241  0157 a60a          	ld	a,#10
4242  0159 cd0000        	call	c_sdivx
4244  015c 01            	rrwa	x,a
4245  015d b702          	ld	_LED_Buf+2,a
4246  015f 02            	rlwa	x,a
4248  0160 ac160216      	jpf	L3752
4249  0164               L5162:
4250                     ; 151 					else if(CurrentTemp < 100)
4252  0164 9c            	rvf
4253  0165 be00          	ldw	x,_CurrentTemp
4254  0167 a30064        	cpw	x,#100
4255  016a 2e23          	jrsge	L1262
4256                     ; 153 						LED_Buf[0] = 0x0F;//Null
4258  016c 350f0000      	mov	_LED_Buf,#15
4259                     ; 154 						LED_Buf[1] = CurrentTemp%100/10;
4261  0170 be00          	ldw	x,_CurrentTemp
4262  0172 a664          	ld	a,#100
4263  0174 cd0000        	call	c_smodx
4265  0177 a60a          	ld	a,#10
4266  0179 cd0000        	call	c_sdivx
4268  017c 01            	rrwa	x,a
4269  017d b701          	ld	_LED_Buf+1,a
4270  017f 02            	rlwa	x,a
4271                     ; 155 						LED_Buf[2] = CurrentTemp%10;				
4273  0180 be00          	ldw	x,_CurrentTemp
4274  0182 a60a          	ld	a,#10
4275  0184 cd0000        	call	c_smodx
4277  0187 01            	rrwa	x,a
4278  0188 b702          	ld	_LED_Buf+2,a
4279  018a 02            	rlwa	x,a
4281  018b ac160216      	jpf	L3752
4282  018f               L1262:
4283                     ; 159 						LED_Buf[0] = CurrentTemp/100;
4285  018f be00          	ldw	x,_CurrentTemp
4286  0191 a664          	ld	a,#100
4287  0193 cd0000        	call	c_sdivx
4289  0196 01            	rrwa	x,a
4290  0197 b700          	ld	_LED_Buf,a
4291  0199 02            	rlwa	x,a
4292                     ; 160 						LED_Buf[1] = CurrentTemp%100/10;
4294  019a be00          	ldw	x,_CurrentTemp
4295  019c a664          	ld	a,#100
4296  019e cd0000        	call	c_smodx
4298  01a1 a60a          	ld	a,#10
4299  01a3 cd0000        	call	c_sdivx
4301  01a6 01            	rrwa	x,a
4302  01a7 b701          	ld	_LED_Buf+1,a
4303  01a9 02            	rlwa	x,a
4304                     ; 161 						LED_Buf[2] = CurrentTemp%10;
4306  01aa be00          	ldw	x,_CurrentTemp
4307  01ac a60a          	ld	a,#10
4308  01ae cd0000        	call	c_smodx
4310  01b1 01            	rrwa	x,a
4311  01b2 b702          	ld	_LED_Buf+2,a
4312  01b4 02            	rlwa	x,a
4313  01b5 205f          	jra	L3752
4314  01b7               L5552:
4315                     ; 167 				switch(SetMode)
4317  01b7 3d00          	tnz	_SetMode
4318  01b9 2700          	jreq	L7262
4321  01bb               L7552:
4322                     ; 173 					break;
4324  01bb               L7262:
4325                     ; 176 				if(HighTemp < 0)
4327  01bb 9c            	rvf
4328  01bc b600          	ld	a,_HighTemp
4329  01be a100          	cp	a,#0
4330  01c0 2e28          	jrsge	L1362
4331                     ; 178 					LED_Buf[0] = 0x0A;	//-
4333  01c2 350a0000      	mov	_LED_Buf,#10
4334                     ; 179 					LED_Buf[1] = -HighTemp/10;
4336  01c6 5f            	clrw	x
4337  01c7 b600          	ld	a,_HighTemp
4338  01c9 2a01          	jrpl	L42
4339  01cb 53            	cplw	x
4340  01cc               L42:
4341  01cc 97            	ld	xl,a
4342  01cd 50            	negw	x
4343  01ce a60a          	ld	a,#10
4344  01d0 cd0000        	call	c_sdivx
4346  01d3 01            	rrwa	x,a
4347  01d4 b701          	ld	_LED_Buf+1,a
4348  01d6 02            	rlwa	x,a
4349                     ; 180 					LED_Buf[2] = -HighTemp%10;
4351  01d7 5f            	clrw	x
4352  01d8 b600          	ld	a,_HighTemp
4353  01da 2a01          	jrpl	L62
4354  01dc 53            	cplw	x
4355  01dd               L62:
4356  01dd 97            	ld	xl,a
4357  01de 50            	negw	x
4358  01df a60a          	ld	a,#10
4359  01e1 cd0000        	call	c_smodx
4361  01e4 01            	rrwa	x,a
4362  01e5 b702          	ld	_LED_Buf+2,a
4363  01e7 02            	rlwa	x,a
4365  01e8 202c          	jra	L3752
4366  01ea               L1362:
4367                     ; 184 					LED_Buf[0] = 0x0D;	//[
4369  01ea 350d0000      	mov	_LED_Buf,#13
4370                     ; 185 					LED_Buf[1] = HighTemp%100/10;
4372  01ee 5f            	clrw	x
4373  01ef b600          	ld	a,_HighTemp
4374  01f1 2a01          	jrpl	L03
4375  01f3 53            	cplw	x
4376  01f4               L03:
4377  01f4 97            	ld	xl,a
4378  01f5 a664          	ld	a,#100
4379  01f7 cd0000        	call	c_smodx
4381  01fa a60a          	ld	a,#10
4382  01fc cd0000        	call	c_sdivx
4384  01ff 01            	rrwa	x,a
4385  0200 b701          	ld	_LED_Buf+1,a
4386  0202 02            	rlwa	x,a
4387                     ; 186 					LED_Buf[2] = HighTemp%10;
4389  0203 b600          	ld	a,_HighTemp
4390  0205 ae000a        	ldw	x,#10
4391  0208 51            	exgw	x,y
4392  0209 5f            	clrw	x
4393  020a 4d            	tnz	a
4394  020b 2a01          	jrpl	L23
4395  020d 5a            	decw	x
4396  020e               L23:
4397  020e 02            	rlwa	x,a
4398  020f cd0000        	call	c_idiv
4400  0212 909f          	ld	a,yl
4401  0214 b702          	ld	_LED_Buf+2,a
4402  0216               L7752:
4403  0216               L3752:
4404                     ; 196 }
4407  0216 81            	ret
4410                     	bsct
4411  0000               L5362_keyNewValue:
4412  0000 6c            	dc.b	108
4413  0001               L3462_time_CNT:
4414  0001 00            	dc.b	0
4415                     	switch	.ubsct
4416  0000               L7362_keyScanCnt:
4417  0000 0000          	ds.b	2
4418  0002               L1462_steps:
4419  0002 00            	ds.b	1
4495                     ; 197 void keyscan(void)
4495                     ; 198 {
4496                     	switch	.text
4497  0217               _keyscan:
4499  0217 88            	push	a
4500       00000001      OFST:	set	1
4503                     ; 205 	if(++time_CNT < 10)
4505  0218 3c01          	inc	L3462_time_CNT
4506  021a b601          	ld	a,L3462_time_CNT
4507  021c a10a          	cp	a,#10
4508  021e 2402          	jruge	L3172
4509                     ; 207 		return;
4512  0220 84            	pop	a
4513  0221 81            	ret
4514  0222               L3172:
4515                     ; 209 	time_CNT = 0;
4517  0222 3f01          	clr	L3462_time_CNT
4518                     ; 211 	keyStatus = PORT_KEY ^ KEYRELEASE_PORTVALUE;
4520  0224 c65010        	ld	a,_PD_IDR
4521  0227 a46c          	and	a,#108
4522  0229 a86c          	xor	a,#108
4523  022b 6b01          	ld	(OFST+0,sp),a
4524                     ; 212 	switch(steps)
4526  022d b602          	ld	a,L1462_steps
4528                     ; 265 		default:;
4529  022f 4d            	tnz	a
4530  0230 2708          	jreq	L5462
4531  0232 4a            	dec	a
4532  0233 271a          	jreq	L7462
4533  0235 4a            	dec	a
4534  0236 2738          	jreq	L1562
4535  0238 2072          	jra	L7172
4536  023a               L5462:
4537                     ; 216 			if(keyStatus != 0)
4539  023a 0d01          	tnz	(OFST+0,sp)
4540  023c 2708          	jreq	L1272
4541                     ; 218 				keyNewValue = keyStatus; 			//store the keys value;
4543  023e 7b01          	ld	a,(OFST+0,sp)
4544  0240 b700          	ld	L5362_keyNewValue,a
4545                     ; 219 				steps++;											//turn to next step
4547  0242 3c02          	inc	L1462_steps
4549  0244 2066          	jra	L7172
4550  0246               L1272:
4551                     ; 223 				keyScanCnt = 0;
4553  0246 5f            	clrw	x
4554  0247 bf00          	ldw	L7362_keyScanCnt,x
4555                     ; 224 				isKeyLongPress = 0;
4557  0249 72110001      	bres	_isKeyLongPress
4558  024d 205d          	jra	L7172
4559  024f               L7462:
4560                     ; 229 			if(keyStatus == keyNewValue)		//if the keys value is not change
4562  024f 7b01          	ld	a,(OFST+0,sp)
4563  0251 b100          	cp	a,L5362_keyNewValue
4564  0253 2616          	jrne	L5272
4565                     ; 231 				if(++keyScanCnt > KEY_SHORT_PRESS)					//dealy
4567  0255 be00          	ldw	x,L7362_keyScanCnt
4568  0257 1c0001        	addw	x,#1
4569  025a bf00          	ldw	L7362_keyScanCnt,x
4570  025c a30065        	cpw	x,#101
4571  025f 250f          	jrult	L1562
4572                     ; 233 					keyScanCnt = 0;							//clear counter
4574  0261 5f            	clrw	x
4575  0262 bf00          	ldw	L7362_keyScanCnt,x
4576                     ; 234 					steps++;										//turn to next step
4578  0264 3c02          	inc	L1462_steps
4579                     ; 235 					keyActiveValue = keyNewValue;
4581  0266 450007        	mov	_keyActiveValue,L5362_keyNewValue
4582  0269 2005          	jra	L1562
4583  026b               L5272:
4584                     ; 240 				keyScanCnt = 0;								//clear time counter
4586  026b 5f            	clrw	x
4587  026c bf00          	ldw	L7362_keyScanCnt,x
4588                     ; 241 				steps--;       								//back to first step
4590  026e 3a02          	dec	L1462_steps
4591  0270               L1562:
4592                     ; 246 			if(keyStatus != keyNewValue)//Key release
4594  0270 7b01          	ld	a,(OFST+0,sp)
4595  0272 b100          	cp	a,L5362_keyNewValue
4596  0274 271f          	jreq	L3372
4597                     ; 248 				if(!isKeyLongPress)isKeyProcess = 1;
4599                     	btst	_isKeyLongPress
4600  027b 2504          	jrult	L5372
4603  027d 72100000      	bset	_isKeyProcess
4604  0281               L5372:
4605                     ; 249 				isStartToCount4S = Clear;
4607  0281 72110000      	bres	_isStartToCount4S
4608                     ; 250 				is4SecondTimeOn = Clear;
4610  0285 72110000      	bres	_is4SecondTimeOn
4611                     ; 251 				steps = 0;
4613  0289 3f02          	clr	L1462_steps
4614                     ; 252 				keyScanCnt = 0;
4616  028b 5f            	clrw	x
4617  028c bf00          	ldw	L7362_keyScanCnt,x
4618                     ; 253 				longPressBase = LONG_PRESS_COUNT;
4620  028e ae1f40        	ldw	x,#8000
4621  0291 bf03          	ldw	_longPressBase,x
4623  0293 2017          	jra	L7172
4624  0295               L3372:
4625                     ; 257 				if(++keyScanCnt > KEY_LONG_PRESS)  //if key long time press
4627  0295 be00          	ldw	x,L7362_keyScanCnt
4628  0297 1c0001        	addw	x,#1
4629  029a bf00          	ldw	L7362_keyScanCnt,x
4630  029c a304b1        	cpw	x,#1201
4631  029f 2509          	jrult	L1472
4632                     ; 259 					keyScanCnt = KEY_SHORT_PRESS;
4634  02a1 ae0064        	ldw	x,#100
4635  02a4 bf00          	ldw	L7362_keyScanCnt,x
4636                     ; 260 					isKeyLongPress = 1;						  //set key long time press flag
4638  02a6 72100001      	bset	_isKeyLongPress
4639  02aa               L1472:
4640                     ; 262 				inSetTimer = 0;										//Any key is pressed clear the time counter
4642  02aa 3f00          	clr	_inSetTimer
4643  02ac               L7172:
4644                     ; 267 }
4647  02ac 84            	pop	a
4648  02ad 81            	ret
4673                     ; 269 void keysetprocess(void)
4673                     ; 270 {
4674                     	switch	.text
4675  02ae               _keysetprocess:
4679                     ; 271 	switch(MachineStatus)
4681  02ae b600          	ld	a,_MachineStatus
4683                     ; 294 		default:;
4684  02b0 4d            	tnz	a
4685  02b1 2727          	jreq	L7672
4686  02b3 4a            	dec	a
4687  02b4 2708          	jreq	L5472
4688  02b6 4a            	dec	a
4689  02b7 270f          	jreq	L7472
4690  02b9 4a            	dec	a
4691  02ba 2712          	jreq	L1572
4692  02bc 201c          	jra	L7672
4693  02be               L5472:
4694                     ; 277 			MachineStatus = SETTING;
4696  02be 35030000      	mov	_MachineStatus,#3
4697                     ; 278 			SetMode = TEMP_SET;
4699  02c2 35080000      	mov	_SetMode,#8
4700                     ; 280 		break;
4702  02c6 2012          	jra	L7672
4703  02c8               L7472:
4704                     ; 283 			MachineStatus = SETTING;
4706  02c8 35030000      	mov	_MachineStatus,#3
4707                     ; 285 		break;
4709  02cc 200c          	jra	L7672
4710  02ce               L1572:
4711                     ; 288 			if(SetMode == TEMP_SET)
4713  02ce b600          	ld	a,_SetMode
4714  02d0 a108          	cp	a,#8
4715  02d2 2606          	jrne	L7672
4716                     ; 290 				MachineStatus = WORK;
4718  02d4 35010000      	mov	_MachineStatus,#1
4719                     ; 291 				SetMode = P0;
4721  02d8 3f00          	clr	_SetMode
4722  02da               L7672:
4723                     ; 296 }
4726  02da 81            	ret
4761                     ; 297 void keyaddprocess(void)
4761                     ; 298 {
4762                     	switch	.text
4763  02db               _keyaddprocess:
4767                     ; 299 	switch(MachineStatus)
4769  02db b600          	ld	a,_MachineStatus
4771                     ; 359 		default:;
4772  02dd 4d            	tnz	a
4773  02de 2603          	jrne	L46
4774  02e0 cc0439        	jp	L5403
4775  02e3               L46:
4776  02e3 4a            	dec	a
4777  02e4 2603          	jrne	L66
4778  02e6 cc0439        	jp	L5403
4779  02e9               L66:
4780  02e9 4a            	dec	a
4781  02ea 2707          	jreq	L7772
4782  02ec 4a            	dec	a
4783  02ed 2716          	jreq	L1003
4784  02ef ac390439      	jpf	L5403
4785  02f3               L7772:
4786                     ; 305 			if(SetMode < P7)SetMode++;
4788  02f3 b600          	ld	a,_SetMode
4789  02f5 a107          	cp	a,#7
4790  02f7 2406          	jruge	L7403
4793  02f9 3c00          	inc	_SetMode
4795  02fb ac390439      	jpf	L5403
4796  02ff               L7403:
4797                     ; 306 			else SetMode = P0;
4799  02ff 3f00          	clr	_SetMode
4800  0301 ac390439      	jpf	L5403
4801  0305               L1003:
4802                     ; 310 			switch(SetMode)
4804  0305 b600          	ld	a,_SetMode
4806                     ; 356 				default:;
4807  0307 4d            	tnz	a
4808  0308 2731          	jreq	L3003
4809  030a 4a            	dec	a
4810  030b 2736          	jreq	L5003
4811  030d 4a            	dec	a
4812  030e 274f          	jreq	L7003
4813  0310 4a            	dec	a
4814  0311 2761          	jreq	L1103
4815  0313 4a            	dec	a
4816  0314 2603cc039d    	jreq	L3103
4817  0319 4a            	dec	a
4818  031a 2603          	jrne	L07
4819  031c cc03b7        	jp	L5103
4820  031f               L07:
4821  031f 4a            	dec	a
4822  0320 2603          	jrne	L27
4823  0322 cc03ce        	jp	L7103
4824  0325               L27:
4825  0325 4a            	dec	a
4826  0326 2603          	jrne	L47
4827  0328 cc03d4        	jp	L1203
4828  032b               L47:
4829  032b 4a            	dec	a
4830  032c 2603          	jrne	L67
4831  032e cc03da        	jp	L3203
4832  0331               L67:
4833  0331 4a            	dec	a
4834  0332 2603          	jrne	L001
4835  0334 cc0423        	jp	L5203
4836  0337               L001:
4837  0337 ac390439      	jpf	L5403
4838  033b               L3003:
4839                     ; 312 				case P0:WorkMode = 1;break;
4841  033b 72100000      	bset	_WorkMode
4844  033f ac390439      	jpf	L5403
4845  0343               L5003:
4846                     ; 313 				case P1:if(LoopTemp < 300)LoopTemp++;else LoopTemp = 300;break;
4848  0343 9c            	rvf
4849  0344 be00          	ldw	x,_LoopTemp
4850  0346 a3012c        	cpw	x,#300
4851  0349 2e0b          	jrsge	L7503
4854  034b be00          	ldw	x,_LoopTemp
4855  034d 1c0001        	addw	x,#1
4856  0350 bf00          	ldw	_LoopTemp,x
4858  0352 ac390439      	jpf	L5403
4859  0356               L7503:
4862  0356 ae012c        	ldw	x,#300
4863  0359 bf00          	ldw	_LoopTemp,x
4864  035b ac390439      	jpf	L5403
4865  035f               L7003:
4866                     ; 314 				case P2:if(HighTemp < 120)HighTemp++;else HighTemp = 120;break;
4868  035f 9c            	rvf
4869  0360 b600          	ld	a,_HighTemp
4870  0362 a178          	cp	a,#120
4871  0364 2e06          	jrsge	L3603
4874  0366 3c00          	inc	_HighTemp
4876  0368 ac390439      	jpf	L5403
4877  036c               L3603:
4880  036c 35780000      	mov	_HighTemp,#120
4881  0370 ac390439      	jpf	L5403
4882  0374               L1103:
4883                     ; 315 				case P3:if(LowTemp < (HighTemp - 1))LowTemp++;else LowTemp = HighTemp + 1;break;
4885  0374 9c            	rvf
4886  0375 5f            	clrw	x
4887  0376 b600          	ld	a,_HighTemp
4888  0378 2a01          	jrpl	L45
4889  037a 53            	cplw	x
4890  037b               L45:
4891  037b 97            	ld	xl,a
4892  037c 5a            	decw	x
4893  037d 905f          	clrw	y
4894  037f b600          	ld	a,_LowTemp
4895  0381 2a02          	jrpl	L65
4896  0383 9053          	cplw	y
4897  0385               L65:
4898  0385 9097          	ld	yl,a
4899  0387 90bf00        	ldw	c_y,y
4900  038a b300          	cpw	x,c_y
4901  038c 2d06          	jrsle	L7603
4904  038e 3c00          	inc	_LowTemp
4906  0390 ac390439      	jpf	L5403
4907  0394               L7603:
4910  0394 b600          	ld	a,_HighTemp
4911  0396 4c            	inc	a
4912  0397 b700          	ld	_LowTemp,a
4913  0399 ac390439      	jpf	L5403
4914  039d               L3103:
4915                     ; 316 				case P4:if(CorrectTemp < 100)CorrectTemp++;else CorrectTemp = 100;break;
4917  039d 9c            	rvf
4918  039e be00          	ldw	x,_CorrectTemp
4919  03a0 a30064        	cpw	x,#100
4920  03a3 2e0a          	jrsge	L3703
4923  03a5 be00          	ldw	x,_CorrectTemp
4924  03a7 1c0001        	addw	x,#1
4925  03aa bf00          	ldw	_CorrectTemp,x
4927  03ac cc0439        	jra	L5403
4928  03af               L3703:
4931  03af ae0064        	ldw	x,#100
4932  03b2 bf00          	ldw	_CorrectTemp,x
4933  03b4 cc0439        	jra	L5403
4934  03b7               L5103:
4935                     ; 317 				case P5:if(DelayTime_Bkp < 10)DelayTime_Bkp++;else DelayTime_Bkp = 10;break;
4937  03b7 be00          	ldw	x,_DelayTime_Bkp
4938  03b9 a3000a        	cpw	x,#10
4939  03bc 2409          	jruge	L7703
4942  03be be00          	ldw	x,_DelayTime_Bkp
4943  03c0 1c0001        	addw	x,#1
4944  03c3 bf00          	ldw	_DelayTime_Bkp,x
4946  03c5 2072          	jra	L5403
4947  03c7               L7703:
4950  03c7 ae000a        	ldw	x,#10
4951  03ca bf00          	ldw	_DelayTime_Bkp,x
4952  03cc 206b          	jra	L5403
4953  03ce               L7103:
4954                     ; 320 					isAlert = 1;
4956  03ce 72100000      	bset	_isAlert
4957                     ; 321 				}break;
4959  03d2 2065          	jra	L5403
4960  03d4               L1203:
4961                     ; 322 				case P7:isDataLock = 1;break;
4963  03d4 72100000      	bset	_isDataLock
4966  03d8 205f          	jra	L5403
4967  03da               L3203:
4968                     ; 325 					if(SetTemp < 1200)
4970  03da 9c            	rvf
4971  03db be00          	ldw	x,_SetTemp
4972  03dd a304b0        	cpw	x,#1200
4973  03e0 2e3a          	jrsge	L3013
4974                     ; 327 						if(SetTemp < 1000)
4976  03e2 9c            	rvf
4977  03e3 be00          	ldw	x,_SetTemp
4978  03e5 a303e8        	cpw	x,#1000
4979  03e8 2e29          	jrsge	L5013
4980                     ; 329 							if(SetTemp < -100)
4982  03ea 9c            	rvf
4983  03eb be00          	ldw	x,_SetTemp
4984  03ed a3ff9c        	cpw	x,#65436
4985  03f0 2e18          	jrsge	L7013
4986                     ; 331 								if(SetTemp < -400)
4988  03f2 9c            	rvf
4989  03f3 be00          	ldw	x,_SetTemp
4990  03f5 a3fe70        	cpw	x,#65136
4991  03f8 2e07          	jrsge	L1113
4992                     ; 333 									SetTemp = -400;
4994  03fa aefe70        	ldw	x,#65136
4995  03fd bf00          	ldw	_SetTemp,x
4997  03ff 2038          	jra	L5403
4998  0401               L1113:
4999                     ; 337 									SetTemp += 10;
5001  0401 be00          	ldw	x,_SetTemp
5002  0403 1c000a        	addw	x,#10
5003  0406 bf00          	ldw	_SetTemp,x
5004  0408 202f          	jra	L5403
5005  040a               L7013:
5006                     ; 342 								SetTemp++;
5008  040a be00          	ldw	x,_SetTemp
5009  040c 1c0001        	addw	x,#1
5010  040f bf00          	ldw	_SetTemp,x
5011  0411 2026          	jra	L5403
5012  0413               L5013:
5013                     ; 347 							SetTemp += 10;
5015  0413 be00          	ldw	x,_SetTemp
5016  0415 1c000a        	addw	x,#10
5017  0418 bf00          	ldw	_SetTemp,x
5018  041a 201d          	jra	L5403
5019  041c               L3013:
5020                     ; 352 						SetTemp = 1200;
5022  041c ae04b0        	ldw	x,#1200
5023  041f bf00          	ldw	_SetTemp,x
5024  0421 2016          	jra	L5403
5025  0423               L5203:
5026                     ; 355 				case ALERT_TEMP:if(AlertTemp < 120)AlertTemp++;else AlertTemp = 120;break;
5028  0423 9c            	rvf
5029  0424 be00          	ldw	x,_AlertTemp
5030  0426 a30078        	cpw	x,#120
5031  0429 2e09          	jrsge	L3213
5034  042b be00          	ldw	x,_AlertTemp
5035  042d 1c0001        	addw	x,#1
5036  0430 bf00          	ldw	_AlertTemp,x
5038  0432 2005          	jra	L5403
5039  0434               L3213:
5042  0434 ae0078        	ldw	x,#120
5043  0437 bf00          	ldw	_AlertTemp,x
5044  0439               L5503:
5045                     ; 358 		}break;
5047  0439               L5403:
5048                     ; 361 }
5051  0439 81            	ret
5086                     ; 362 void keysubprocess(void)
5086                     ; 363 {
5087                     	switch	.text
5088  043a               _keysubprocess:
5092                     ; 364 	switch(MachineStatus)
5094  043a b600          	ld	a,_MachineStatus
5096                     ; 421 		default:;
5097  043c 4d            	tnz	a
5098  043d 2603          	jrne	L411
5099  043f cc0592        	jp	L1023
5100  0442               L411:
5101  0442 4a            	dec	a
5102  0443 2603          	jrne	L611
5103  0445 cc0592        	jp	L1023
5104  0448               L611:
5105  0448 4a            	dec	a
5106  0449 2707          	jreq	L3313
5107  044b 4a            	dec	a
5108  044c 2716          	jreq	L5313
5109  044e ac920592      	jpf	L1023
5110  0452               L3313:
5111                     ; 370 			if(SetMode > 0)SetMode--;
5113  0452 3d00          	tnz	_SetMode
5114  0454 2706          	jreq	L3023
5117  0456 3a00          	dec	_SetMode
5119  0458 ac920592      	jpf	L1023
5120  045c               L3023:
5121                     ; 371 			else SetMode = P7;
5123  045c 35070000      	mov	_SetMode,#7
5124  0460 ac920592      	jpf	L1023
5125  0464               L5313:
5126                     ; 375 			switch(SetMode)
5128  0464 b600          	ld	a,_SetMode
5130                     ; 418 				default:;
5131  0466 4d            	tnz	a
5132  0467 2731          	jreq	L7313
5133  0469 4a            	dec	a
5134  046a 2736          	jreq	L1413
5135  046c 4a            	dec	a
5136  046d 274f          	jreq	L3413
5137  046f 4a            	dec	a
5138  0470 2775          	jreq	L5413
5139  0472 4a            	dec	a
5140  0473 2603cc04fc    	jreq	L7413
5141  0478 4a            	dec	a
5142  0479 2603          	jrne	L021
5143  047b cc0515        	jp	L1513
5144  047e               L021:
5145  047e 4a            	dec	a
5146  047f 2603          	jrne	L221
5147  0481 cc0527        	jp	L3513
5148  0484               L221:
5149  0484 4a            	dec	a
5150  0485 2603          	jrne	L421
5151  0487 cc052d        	jp	L5513
5152  048a               L421:
5153  048a 4a            	dec	a
5154  048b 2603          	jrne	L621
5155  048d cc0533        	jp	L7513
5156  0490               L621:
5157  0490 4a            	dec	a
5158  0491 2603          	jrne	L031
5159  0493 cc057c        	jp	L1613
5160  0496               L031:
5161  0496 ac920592      	jpf	L1023
5162  049a               L7313:
5163                     ; 377 				case P0:WorkMode = 0;break;
5165  049a 72110000      	bres	_WorkMode
5168  049e ac920592      	jpf	L1023
5169  04a2               L1413:
5170                     ; 378 				case P1:if(LoopTemp > 1)LoopTemp--;else LoopTemp = 1;break;
5172  04a2 9c            	rvf
5173  04a3 be00          	ldw	x,_LoopTemp
5174  04a5 a30002        	cpw	x,#2
5175  04a8 2f0b          	jrslt	L3123
5178  04aa be00          	ldw	x,_LoopTemp
5179  04ac 1d0001        	subw	x,#1
5180  04af bf00          	ldw	_LoopTemp,x
5182  04b1 ac920592      	jpf	L1023
5183  04b5               L3123:
5186  04b5 ae0001        	ldw	x,#1
5187  04b8 bf00          	ldw	_LoopTemp,x
5188  04ba ac920592      	jpf	L1023
5189  04be               L3413:
5190                     ; 379 				case P2:if(HighTemp > (LowTemp+1))HighTemp--;else HighTemp = LowTemp + 1;break;
5192  04be 9c            	rvf
5193  04bf 5f            	clrw	x
5194  04c0 b600          	ld	a,_LowTemp
5195  04c2 2a01          	jrpl	L401
5196  04c4 53            	cplw	x
5197  04c5               L401:
5198  04c5 97            	ld	xl,a
5199  04c6 5c            	incw	x
5200  04c7 905f          	clrw	y
5201  04c9 b600          	ld	a,_HighTemp
5202  04cb 2a02          	jrpl	L601
5203  04cd 9053          	cplw	y
5204  04cf               L601:
5205  04cf 9097          	ld	yl,a
5206  04d1 90bf00        	ldw	c_y,y
5207  04d4 b300          	cpw	x,c_y
5208  04d6 2e06          	jrsge	L7123
5211  04d8 3a00          	dec	_HighTemp
5213  04da ac920592      	jpf	L1023
5214  04de               L7123:
5217  04de b600          	ld	a,_LowTemp
5218  04e0 4c            	inc	a
5219  04e1 b700          	ld	_HighTemp,a
5220  04e3 ac920592      	jpf	L1023
5221  04e7               L5413:
5222                     ; 380 				case P3:if(LowTemp > -40)LowTemp--;else LowTemp = -40;break;
5224  04e7 9c            	rvf
5225  04e8 b600          	ld	a,_LowTemp
5226  04ea a1d9          	cp	a,#217
5227  04ec 2f06          	jrslt	L3223
5230  04ee 3a00          	dec	_LowTemp
5232  04f0 ac920592      	jpf	L1023
5233  04f4               L3223:
5236  04f4 35d80000      	mov	_LowTemp,#216
5237  04f8 ac920592      	jpf	L1023
5238  04fc               L7413:
5239                     ; 381 				case P4:if(CorrectTemp > -100)CorrectTemp--;else CorrectTemp = -100;break;
5241  04fc 9c            	rvf
5242  04fd be00          	ldw	x,_CorrectTemp
5243  04ff a3ff9d        	cpw	x,#65437
5244  0502 2f0a          	jrslt	L7223
5247  0504 be00          	ldw	x,_CorrectTemp
5248  0506 1d0001        	subw	x,#1
5249  0509 bf00          	ldw	_CorrectTemp,x
5251  050b cc0592        	jra	L1023
5252  050e               L7223:
5255  050e aeff9c        	ldw	x,#65436
5256  0511 bf00          	ldw	_CorrectTemp,x
5257  0513 207d          	jra	L1023
5258  0515               L1513:
5259                     ; 382 				case P5:if(DelayTime_Bkp > 0)DelayTime_Bkp--;else DelayTime_Bkp = 0;break;
5261  0515 be00          	ldw	x,_DelayTime_Bkp
5262  0517 2709          	jreq	L3323
5265  0519 be00          	ldw	x,_DelayTime_Bkp
5266  051b 1d0001        	subw	x,#1
5267  051e bf00          	ldw	_DelayTime_Bkp,x
5269  0520 2070          	jra	L1023
5270  0522               L3323:
5273  0522 5f            	clrw	x
5274  0523 bf00          	ldw	_DelayTime_Bkp,x
5275  0525 206b          	jra	L1023
5276  0527               L3513:
5277                     ; 383 				case P6:isAlert = 0;break;
5279  0527 72110000      	bres	_isAlert
5282  052b 2065          	jra	L1023
5283  052d               L5513:
5284                     ; 384 				case P7:isDataLock = 0;break;
5286  052d 72110000      	bres	_isDataLock
5289  0531 205f          	jra	L1023
5290  0533               L7513:
5291                     ; 387 					if(SetTemp > -400)
5293  0533 9c            	rvf
5294  0534 be00          	ldw	x,_SetTemp
5295  0536 a3fe71        	cpw	x,#65137
5296  0539 2f3a          	jrslt	L7323
5297                     ; 389 						if(SetTemp > -100)
5299  053b 9c            	rvf
5300  053c be00          	ldw	x,_SetTemp
5301  053e a3ff9d        	cpw	x,#65437
5302  0541 2f29          	jrslt	L1423
5303                     ; 391 							if(SetTemp > 1000)
5305  0543 9c            	rvf
5306  0544 be00          	ldw	x,_SetTemp
5307  0546 a303e9        	cpw	x,#1001
5308  0549 2f18          	jrslt	L3423
5309                     ; 393 								if(SetTemp > 1200)
5311  054b 9c            	rvf
5312  054c be00          	ldw	x,_SetTemp
5313  054e a304b1        	cpw	x,#1201
5314  0551 2f07          	jrslt	L5423
5315                     ; 395 									SetTemp = 1200;
5317  0553 ae04b0        	ldw	x,#1200
5318  0556 bf00          	ldw	_SetTemp,x
5320  0558 2038          	jra	L1023
5321  055a               L5423:
5322                     ; 399 									SetTemp -= 10;
5324  055a be00          	ldw	x,_SetTemp
5325  055c 1d000a        	subw	x,#10
5326  055f bf00          	ldw	_SetTemp,x
5327  0561 202f          	jra	L1023
5328  0563               L3423:
5329                     ; 404 								SetTemp--;
5331  0563 be00          	ldw	x,_SetTemp
5332  0565 1d0001        	subw	x,#1
5333  0568 bf00          	ldw	_SetTemp,x
5334  056a 2026          	jra	L1023
5335  056c               L1423:
5336                     ; 409 							SetTemp -= 10;
5338  056c be00          	ldw	x,_SetTemp
5339  056e 1d000a        	subw	x,#10
5340  0571 bf00          	ldw	_SetTemp,x
5341  0573 201d          	jra	L1023
5342  0575               L7323:
5343                     ; 414 						SetTemp = -400;
5345  0575 aefe70        	ldw	x,#65136
5346  0578 bf00          	ldw	_SetTemp,x
5347  057a 2016          	jra	L1023
5348  057c               L1613:
5349                     ; 417 				case ALERT_TEMP:if(AlertTemp > -40)AlertTemp--;else AlertTemp = -40;break;
5351  057c 9c            	rvf
5352  057d be00          	ldw	x,_AlertTemp
5353  057f a3ffd9        	cpw	x,#65497
5354  0582 2f09          	jrslt	L7523
5357  0584 be00          	ldw	x,_AlertTemp
5358  0586 1d0001        	subw	x,#1
5359  0589 bf00          	ldw	_AlertTemp,x
5361  058b 2005          	jra	L1023
5362  058d               L7523:
5365  058d aeffd8        	ldw	x,#65496
5366  0590 bf00          	ldw	_AlertTemp,x
5367  0592               L1123:
5368                     ; 420 		}break;
5370  0592               L1023:
5371                     ; 423 }
5374  0592 81            	ret
5411                     ; 424 void _keyScanProcess(void)
5411                     ; 425 {
5412                     	switch	.text
5413  0593               __keyScanProcess:
5417                     ; 426 	if (isKeyLongPress)
5419                     	btst	_isKeyLongPress
5420  0598 2503cc0629    	jruge	L5033
5421                     ; 428 		longPressCnt += LONG_PRESS_ADD_UINT;
5423  059d be05          	ldw	x,_longPressCnt
5424  059f 1c001e        	addw	x,#30
5425  05a2 bf05          	ldw	_longPressCnt,x
5426                     ; 429 		if(++longPressCnt > longPressBase)
5428  05a4 be05          	ldw	x,_longPressCnt
5429  05a6 1c0001        	addw	x,#1
5430  05a9 bf05          	ldw	_longPressCnt,x
5431  05ab b303          	cpw	x,_longPressBase
5432  05ad 237a          	jrule	L5033
5433                     ; 431 			longPressCnt = 0;
5435  05af 5f            	clrw	x
5436  05b0 bf05          	ldw	_longPressCnt,x
5437                     ; 432 			if(longPressBase > LONG_PRESS_LIMIT)
5439  05b2 be03          	ldw	x,_longPressBase
5440  05b4 a303e9        	cpw	x,#1001
5441  05b7 2507          	jrult	L1133
5442                     ; 434 				longPressBase -= LONG_PRESS_SUB_UNIT;
5444  05b9 be03          	ldw	x,_longPressBase
5445  05bb 1d00b4        	subw	x,#180
5446  05be bf03          	ldw	_longPressBase,x
5447  05c0               L1133:
5448                     ; 437 			if(keyActiveValue == KEY_SET)
5450  05c0 b607          	ld	a,_keyActiveValue
5451  05c2 a120          	cp	a,#32
5452  05c4 261a          	jrne	L3133
5453                     ; 439 				if(MachineStatus == WORK)
5455  05c6 b600          	ld	a,_MachineStatus
5456  05c8 a101          	cp	a,#1
5457  05ca 265d          	jrne	L5033
5458                     ; 441 					MachineStatus = SET_SELECT;
5460  05cc 35020000      	mov	_MachineStatus,#2
5461                     ; 442 					isUpdateDisplay = Yes;
5463  05d0 72100000      	bset	_isUpdateDisplay
5464                     ; 443 					isBuzzerOn = Yes;
5466  05d4 72100000      	bset	_isBuzzerOn
5467                     ; 444 					pinBuzzer = 1;
5469  05d8 7218500f      	bset	_PD_ODR_4
5470                     ; 445 					buzzerTimer = 0;
5472  05dc 3f00          	clr	_buzzerTimer
5473  05de 2049          	jra	L5033
5474  05e0               L3133:
5475                     ; 448 			else if(keyActiveValue == KEY_ENT)
5477  05e0 b607          	ld	a,_keyActiveValue
5478  05e2 a140          	cp	a,#64
5479  05e4 262f          	jrne	L1233
5480                     ; 450 				isStartToCount4S = Yes;
5482  05e6 72100000      	bset	_isStartToCount4S
5483                     ; 452 				if(is4SecondTimeOn)
5485                     	btst	_is4SecondTimeOn
5486  05ef 2438          	jruge	L5033
5487                     ; 454 					isBuzzerOn = Yes;
5489  05f1 72100000      	bset	_isBuzzerOn
5490                     ; 455 					pinBuzzer = 1;
5492  05f5 7218500f      	bset	_PD_ODR_4
5493                     ; 456 					buzzerTimer = 0;
5495  05f9 3f00          	clr	_buzzerTimer
5496                     ; 457 					isUpdateDisplay = Yes;
5498  05fb 72100000      	bset	_isUpdateDisplay
5499                     ; 458 					isStartToCount4S = Clear;			//Clear both while the key press release.
5501  05ff 72110000      	bres	_isStartToCount4S
5502                     ; 459 					is4SecondTimeOn = Clear;
5504  0603 72110000      	bres	_is4SecondTimeOn
5505                     ; 460 					if(MachineStatus > 0)
5507  0607 3d00          	tnz	_MachineStatus
5508  0609 2704          	jreq	L5233
5509                     ; 462 						MachineStatus = 0;
5511  060b 3f00          	clr	_MachineStatus
5513  060d 201a          	jra	L5033
5514  060f               L5233:
5515                     ; 466 						MachineStatus = 1;
5517  060f 35010000      	mov	_MachineStatus,#1
5518  0613 2014          	jra	L5033
5519  0615               L1233:
5520                     ; 470 			else if(keyActiveValue & FORCE_RECOVERY)
5522  0615 b607          	ld	a,_keyActiveValue
5523  0617 a50c          	bcp	a,#12
5524  0619 270e          	jreq	L5033
5525                     ; 472 				isKeyProcess = 1;
5527  061b 72100000      	bset	_isKeyProcess
5528                     ; 473 				isBuzzerOn = Yes;
5530  061f 72100000      	bset	_isBuzzerOn
5531                     ; 474 				pinBuzzer = 1;
5533  0623 7218500f      	bset	_PD_ODR_4
5534                     ; 475 				buzzerTimer = 0;
5536  0627 3f00          	clr	_buzzerTimer
5537  0629               L5033:
5538                     ; 479 	if(isKeyProcess)
5540                     	btst	_isKeyProcess
5541  062e 2420          	jruge	L5333
5542                     ; 481 		isKeyProcess = 0;
5544  0630 72110000      	bres	_isKeyProcess
5545                     ; 482 		inSetTimer = 0;
5547  0634 3f00          	clr	_inSetTimer
5548                     ; 483 		isUpdateDisplay = Yes;
5550  0636 72100000      	bset	_isUpdateDisplay
5551                     ; 484 		isInSetting = Yes;
5553  063a 72100000      	bset	_isInSetting
5554                     ; 486 		switch(keyActiveValue)
5556  063e b607          	ld	a,_keyActiveValue
5558                     ; 506 			default:;
5559  0640 a004          	sub	a,#4
5560  0642 270c          	jreq	L5333
5561  0644 a004          	sub	a,#4
5562  0646 2708          	jreq	L5333
5563  0648 a018          	sub	a,#24
5564  064a 2704          	jreq	L5333
5565  064c a020          	sub	a,#32
5566  064e 2600          	jrne	L5333
5567  0650               L1433:
5568  0650               L5333:
5569                     ; 509 }
5572  0650 81            	ret
5575                     	bsct
5576  0002               L3433_displayNum:
5577  0002 00            	dc.b	0
5631                     ; 511 void _displayAndKeyscan(void)
5631                     ; 512 {
5632                     	switch	.text
5633  0651               __displayAndKeyscan:
5635  0651 88            	push	a
5636       00000001      OFST:	set	1
5639                     ; 516 	PC_ODR |= 0B010101000;//Clear all  PC3/5/7
5641  0652 c6500a        	ld	a,_PC_ODR
5642  0655 aaa8          	or	a,#168
5643  0657 c7500a        	ld	_PC_ODR,a
5644                     ; 519 	PD_DDR &= 0b10010011;//PD2/3/5/6
5646  065a c65011        	ld	a,_PD_DDR
5647  065d a493          	and	a,#147
5648  065f c75011        	ld	_PD_DDR,a
5649                     ; 521 	for(i = 0;i < 20;i++);
5651  0662 0f01          	clr	(OFST+0,sp)
5652  0664               L7633:
5656  0664 0c01          	inc	(OFST+0,sp)
5659  0666 7b01          	ld	a,(OFST+0,sp)
5660  0668 a114          	cp	a,#20
5661  066a 25f8          	jrult	L7633
5662                     ; 524 	keyscan();
5664  066c cd0217        	call	_keyscan
5666                     ; 526 	PD_DDR |= 0b01101100;
5668  066f c65011        	ld	a,_PD_DDR
5669  0672 aa6c          	or	a,#108
5670  0674 c75011        	ld	_PD_DDR,a
5671                     ; 529 	if(displayNum == 2)
5673  0677 b602          	ld	a,L3433_displayNum
5674  0679 a102          	cp	a,#2
5675  067b 2703          	jreq	L462
5676  067d cc0731        	jp	L5733
5677  0680               L462:
5678                     ; 531 		displayNum = 1;
5680  0680 35010002      	mov	L3433_displayNum,#1
5681                     ; 532 		PD_ODR_2 = LEDCode[LED_Buf[2]]&0b00000001;	//a
5683  0684 b602          	ld	a,_LED_Buf+2
5684  0686 5f            	clrw	x
5685  0687 97            	ld	xl,a
5686  0688 d60000        	ld	a,(_LEDCode,x)
5687  068b a501          	bcp	a,#1
5688  068d 2602          	jrne	L662
5689  068f 2006          	jp	L041
5690  0691               L662:
5691  0691 7214500f      	bset	_PD_ODR_2
5692  0695 2004          	jra	L241
5693  0697               L041:
5694  0697 7215500f      	bres	_PD_ODR_2
5695  069b               L241:
5696                     ; 533 		PD_ODR_3 = LEDCode[LED_Buf[2]]&0b00000010;	//b
5698  069b b602          	ld	a,_LED_Buf+2
5699  069d 5f            	clrw	x
5700  069e 97            	ld	xl,a
5701  069f d60000        	ld	a,(_LEDCode,x)
5702  06a2 a502          	bcp	a,#2
5703  06a4 2602          	jrne	L072
5704  06a6 2006          	jp	L441
5705  06a8               L072:
5706  06a8 7216500f      	bset	_PD_ODR_3
5707  06ac 2004          	jra	L641
5708  06ae               L441:
5709  06ae 7217500f      	bres	_PD_ODR_3
5710  06b2               L641:
5711                     ; 534 		PD_ODR_5 = LEDCode[LED_Buf[2]]&0b00000100;	//c
5713  06b2 b602          	ld	a,_LED_Buf+2
5714  06b4 5f            	clrw	x
5715  06b5 97            	ld	xl,a
5716  06b6 d60000        	ld	a,(_LEDCode,x)
5717  06b9 a504          	bcp	a,#4
5718  06bb 2602          	jrne	L272
5719  06bd 2006          	jp	L051
5720  06bf               L272:
5721  06bf 721a500f      	bset	_PD_ODR_5
5722  06c3 2004          	jra	L251
5723  06c5               L051:
5724  06c5 721b500f      	bres	_PD_ODR_5
5725  06c9               L251:
5726                     ; 535 		PD_ODR_6 = LEDCode[LED_Buf[2]]&0b00001000;	//d
5728  06c9 b602          	ld	a,_LED_Buf+2
5729  06cb 5f            	clrw	x
5730  06cc 97            	ld	xl,a
5731  06cd d60000        	ld	a,(_LEDCode,x)
5732  06d0 a508          	bcp	a,#8
5733  06d2 2602          	jrne	L472
5734  06d4 2006          	jp	L451
5735  06d6               L472:
5736  06d6 721c500f      	bset	_PD_ODR_6
5737  06da 2004          	jra	L651
5738  06dc               L451:
5739  06dc 721d500f      	bres	_PD_ODR_6
5740  06e0               L651:
5741                     ; 536 		PA_ODR_1 = LEDCode[LED_Buf[2]]&0b00010000;	//e
5743  06e0 b602          	ld	a,_LED_Buf+2
5744  06e2 5f            	clrw	x
5745  06e3 97            	ld	xl,a
5746  06e4 d60000        	ld	a,(_LEDCode,x)
5747  06e7 a510          	bcp	a,#16
5748  06e9 2602          	jrne	L672
5749  06eb 2006          	jp	L061
5750  06ed               L672:
5751  06ed 72125000      	bset	_PA_ODR_1
5752  06f1 2004          	jra	L261
5753  06f3               L061:
5754  06f3 72135000      	bres	_PA_ODR_1
5755  06f7               L261:
5756                     ; 537 		PA_ODR_2 = LEDCode[LED_Buf[2]]&0b00100000;	//f
5758  06f7 b602          	ld	a,_LED_Buf+2
5759  06f9 5f            	clrw	x
5760  06fa 97            	ld	xl,a
5761  06fb d60000        	ld	a,(_LEDCode,x)
5762  06fe a520          	bcp	a,#32
5763  0700 2602          	jrne	L003
5764  0702 2006          	jp	L461
5765  0704               L003:
5766  0704 72145000      	bset	_PA_ODR_2
5767  0708 2004          	jra	L661
5768  070a               L461:
5769  070a 72155000      	bres	_PA_ODR_2
5770  070e               L661:
5771                     ; 538 		PA_ODR_3 = LEDCode[LED_Buf[2]]&0b01000000;	//g
5773  070e b602          	ld	a,_LED_Buf+2
5774  0710 5f            	clrw	x
5775  0711 97            	ld	xl,a
5776  0712 d60000        	ld	a,(_LEDCode,x)
5777  0715 a540          	bcp	a,#64
5778  0717 2602          	jrne	L203
5779  0719 2006          	jp	L071
5780  071b               L203:
5781  071b 72165000      	bset	_PA_ODR_3
5782  071f 2004          	jra	L271
5783  0721               L071:
5784  0721 72175000      	bres	_PA_ODR_3
5785  0725               L271:
5786                     ; 539 		PC_ODR_6 = 0;	//dp
5788  0725 721d500a      	bres	_PC_ODR_6
5789                     ; 540 		PC_ODR &= 0b01111111;							//D0
5791  0729 721f500a      	bres	_PC_ODR,#7
5793  072d ac960896      	jpf	L7733
5794  0731               L5733:
5795                     ; 542 	else if(displayNum == 1)
5797  0731 b602          	ld	a,L3433_displayNum
5798  0733 a101          	cp	a,#1
5799  0735 2703          	jreq	L403
5800  0737 cc07e9        	jp	L1043
5801  073a               L403:
5802                     ; 544 		displayNum = 0;
5804  073a 3f02          	clr	L3433_displayNum
5805                     ; 545 		PD_ODR_2 = LEDCode[LED_Buf[1]]&0b00000001;	//a
5807  073c b601          	ld	a,_LED_Buf+1
5808  073e 5f            	clrw	x
5809  073f 97            	ld	xl,a
5810  0740 d60000        	ld	a,(_LEDCode,x)
5811  0743 a501          	bcp	a,#1
5812  0745 2602          	jrne	L603
5813  0747 2006          	jp	L471
5814  0749               L603:
5815  0749 7214500f      	bset	_PD_ODR_2
5816  074d 2004          	jra	L671
5817  074f               L471:
5818  074f 7215500f      	bres	_PD_ODR_2
5819  0753               L671:
5820                     ; 546 		PD_ODR_3 = LEDCode[LED_Buf[1]]&0b00000010;	//b
5822  0753 b601          	ld	a,_LED_Buf+1
5823  0755 5f            	clrw	x
5824  0756 97            	ld	xl,a
5825  0757 d60000        	ld	a,(_LEDCode,x)
5826  075a a502          	bcp	a,#2
5827  075c 2602          	jrne	L013
5828  075e 2006          	jp	L002
5829  0760               L013:
5830  0760 7216500f      	bset	_PD_ODR_3
5831  0764 2004          	jra	L202
5832  0766               L002:
5833  0766 7217500f      	bres	_PD_ODR_3
5834  076a               L202:
5835                     ; 547 		PD_ODR_5 = LEDCode[LED_Buf[1]]&0b00000100;	//c
5837  076a b601          	ld	a,_LED_Buf+1
5838  076c 5f            	clrw	x
5839  076d 97            	ld	xl,a
5840  076e d60000        	ld	a,(_LEDCode,x)
5841  0771 a504          	bcp	a,#4
5842  0773 2602          	jrne	L213
5843  0775 2006          	jp	L402
5844  0777               L213:
5845  0777 721a500f      	bset	_PD_ODR_5
5846  077b 2004          	jra	L602
5847  077d               L402:
5848  077d 721b500f      	bres	_PD_ODR_5
5849  0781               L602:
5850                     ; 548 		PD_ODR_6 = LEDCode[LED_Buf[1]]&0b00001000;	//d
5852  0781 b601          	ld	a,_LED_Buf+1
5853  0783 5f            	clrw	x
5854  0784 97            	ld	xl,a
5855  0785 d60000        	ld	a,(_LEDCode,x)
5856  0788 a508          	bcp	a,#8
5857  078a 2602          	jrne	L413
5858  078c 2006          	jp	L012
5859  078e               L413:
5860  078e 721c500f      	bset	_PD_ODR_6
5861  0792 2004          	jra	L212
5862  0794               L012:
5863  0794 721d500f      	bres	_PD_ODR_6
5864  0798               L212:
5865                     ; 549 		PA_ODR_1 = LEDCode[LED_Buf[1]]&0b00010000;	//e
5867  0798 b601          	ld	a,_LED_Buf+1
5868  079a 5f            	clrw	x
5869  079b 97            	ld	xl,a
5870  079c d60000        	ld	a,(_LEDCode,x)
5871  079f a510          	bcp	a,#16
5872  07a1 2602          	jrne	L613
5873  07a3 2006          	jp	L412
5874  07a5               L613:
5875  07a5 72125000      	bset	_PA_ODR_1
5876  07a9 2004          	jra	L612
5877  07ab               L412:
5878  07ab 72135000      	bres	_PA_ODR_1
5879  07af               L612:
5880                     ; 550 		PA_ODR_2 = LEDCode[LED_Buf[1]]&0b00100000;	//f
5882  07af b601          	ld	a,_LED_Buf+1
5883  07b1 5f            	clrw	x
5884  07b2 97            	ld	xl,a
5885  07b3 d60000        	ld	a,(_LEDCode,x)
5886  07b6 a520          	bcp	a,#32
5887  07b8 2602          	jrne	L023
5888  07ba 2006          	jp	L022
5889  07bc               L023:
5890  07bc 72145000      	bset	_PA_ODR_2
5891  07c0 2004          	jra	L222
5892  07c2               L022:
5893  07c2 72155000      	bres	_PA_ODR_2
5894  07c6               L222:
5895                     ; 551 		PA_ODR_3 = LEDCode[LED_Buf[1]]&0b01000000;	//g
5897  07c6 b601          	ld	a,_LED_Buf+1
5898  07c8 5f            	clrw	x
5899  07c9 97            	ld	xl,a
5900  07ca d60000        	ld	a,(_LEDCode,x)
5901  07cd a540          	bcp	a,#64
5902  07cf 2602          	jrne	L223
5903  07d1 2006          	jp	L422
5904  07d3               L223:
5905  07d3 72165000      	bset	_PA_ODR_3
5906  07d7 2004          	jra	L622
5907  07d9               L422:
5908  07d9 72175000      	bres	_PA_ODR_3
5909  07dd               L622:
5910                     ; 552 		PC_ODR_6 = 0;//dp
5912  07dd 721d500a      	bres	_PC_ODR_6
5913                     ; 553 		PC_ODR &= 0b11011111;							//D1
5915  07e1 721b500a      	bres	_PC_ODR,#5
5917  07e5 ac960896      	jpf	L7733
5918  07e9               L1043:
5919                     ; 557 		displayNum = 2;
5921  07e9 35020002      	mov	L3433_displayNum,#2
5922                     ; 558 		PD_ODR_2 = LEDCode[LED_Buf[0]]&0b00000001;	//a
5924  07ed b600          	ld	a,_LED_Buf
5925  07ef 5f            	clrw	x
5926  07f0 97            	ld	xl,a
5927  07f1 d60000        	ld	a,(_LEDCode,x)
5928  07f4 a501          	bcp	a,#1
5929  07f6 2602          	jrne	L423
5930  07f8 2006          	jp	L032
5931  07fa               L423:
5932  07fa 7214500f      	bset	_PD_ODR_2
5933  07fe 2004          	jra	L232
5934  0800               L032:
5935  0800 7215500f      	bres	_PD_ODR_2
5936  0804               L232:
5937                     ; 559 		PD_ODR_3 = LEDCode[LED_Buf[0]]&0b00000010;	//b
5939  0804 b600          	ld	a,_LED_Buf
5940  0806 5f            	clrw	x
5941  0807 97            	ld	xl,a
5942  0808 d60000        	ld	a,(_LEDCode,x)
5943  080b a502          	bcp	a,#2
5944  080d 2602          	jrne	L623
5945  080f 2006          	jp	L432
5946  0811               L623:
5947  0811 7216500f      	bset	_PD_ODR_3
5948  0815 2004          	jra	L632
5949  0817               L432:
5950  0817 7217500f      	bres	_PD_ODR_3
5951  081b               L632:
5952                     ; 560 		PD_ODR_5 = LEDCode[LED_Buf[0]]&0b00000100;	//c
5954  081b b600          	ld	a,_LED_Buf
5955  081d 5f            	clrw	x
5956  081e 97            	ld	xl,a
5957  081f d60000        	ld	a,(_LEDCode,x)
5958  0822 a504          	bcp	a,#4
5959  0824 2602          	jrne	L033
5960  0826 2006          	jp	L042
5961  0828               L033:
5962  0828 721a500f      	bset	_PD_ODR_5
5963  082c 2004          	jra	L242
5964  082e               L042:
5965  082e 721b500f      	bres	_PD_ODR_5
5966  0832               L242:
5967                     ; 561 		PD_ODR_6 = LEDCode[LED_Buf[0]]&0b00001000;	//d
5969  0832 b600          	ld	a,_LED_Buf
5970  0834 5f            	clrw	x
5971  0835 97            	ld	xl,a
5972  0836 d60000        	ld	a,(_LEDCode,x)
5973  0839 a508          	bcp	a,#8
5974  083b 2602          	jrne	L233
5975  083d 2006          	jp	L442
5976  083f               L233:
5977  083f 721c500f      	bset	_PD_ODR_6
5978  0843 2004          	jra	L642
5979  0845               L442:
5980  0845 721d500f      	bres	_PD_ODR_6
5981  0849               L642:
5982                     ; 562 		PA_ODR_1 = LEDCode[LED_Buf[0]]&0b00010000;	//e
5984  0849 b600          	ld	a,_LED_Buf
5985  084b 5f            	clrw	x
5986  084c 97            	ld	xl,a
5987  084d d60000        	ld	a,(_LEDCode,x)
5988  0850 a510          	bcp	a,#16
5989  0852 2602          	jrne	L433
5990  0854 2006          	jp	L052
5991  0856               L433:
5992  0856 72125000      	bset	_PA_ODR_1
5993  085a 2004          	jra	L252
5994  085c               L052:
5995  085c 72135000      	bres	_PA_ODR_1
5996  0860               L252:
5997                     ; 563 		PA_ODR_2 = LEDCode[LED_Buf[0]]&0b00100000;	//f
5999  0860 b600          	ld	a,_LED_Buf
6000  0862 5f            	clrw	x
6001  0863 97            	ld	xl,a
6002  0864 d60000        	ld	a,(_LEDCode,x)
6003  0867 a520          	bcp	a,#32
6004  0869 2602          	jrne	L633
6005  086b 2006          	jp	L452
6006  086d               L633:
6007  086d 72145000      	bset	_PA_ODR_2
6008  0871 2004          	jra	L652
6009  0873               L452:
6010  0873 72155000      	bres	_PA_ODR_2
6011  0877               L652:
6012                     ; 564 		PA_ODR_3 = LEDCode[LED_Buf[0]]&0b01000000;	//g
6014  0877 b600          	ld	a,_LED_Buf
6015  0879 5f            	clrw	x
6016  087a 97            	ld	xl,a
6017  087b d60000        	ld	a,(_LEDCode,x)
6018  087e a540          	bcp	a,#64
6019  0880 2602          	jrne	L043
6020  0882 2006          	jp	L062
6021  0884               L043:
6022  0884 72165000      	bset	_PA_ODR_3
6023  0888 2004          	jra	L262
6024  088a               L062:
6025  088a 72175000      	bres	_PA_ODR_3
6026  088e               L262:
6027                     ; 565 		PC_ODR_6 = 0;	//dp
6029  088e 721d500a      	bres	_PC_ODR_6
6030                     ; 566 		PC_ODR &= 0b11110111;							//D2
6032  0892 7217500a      	bres	_PC_ODR,#3
6033  0896               L7733:
6034                     ; 568 	for(i = 0;i < 200;i++);
6036  0896 0f01          	clr	(OFST+0,sp)
6037  0898               L5043:
6041  0898 0c01          	inc	(OFST+0,sp)
6044  089a 7b01          	ld	a,(OFST+0,sp)
6045  089c a1c8          	cp	a,#200
6046  089e 25f8          	jrult	L5043
6047                     ; 570 }
6050  08a0 84            	pop	a
6051  08a1 81            	ret
6123                     	xdef	_keysubprocess
6124                     	xdef	_keyaddprocess
6125                     	xdef	_keysetprocess
6126                     	xdef	_keyscan
6127                     	xdef	_T_C_relay
6128                     	xdef	_LEDCode
6129                     .bit:	section	.data,bit
6130  0000               _isKeyProcess:
6131  0000 00            	ds.b	1
6132                     	xdef	_isKeyProcess
6133  0001               _isKeyLongPress:
6134  0001 00            	ds.b	1
6135                     	xdef	_isKeyLongPress
6136                     	switch	.ubsct
6137  0003               _longPressBase:
6138  0003 0000          	ds.b	2
6139                     	xdef	_longPressBase
6140  0005               _longPressCnt:
6141  0005 0000          	ds.b	2
6142                     	xdef	_longPressCnt
6143  0007               _keyActiveValue:
6144  0007 00            	ds.b	1
6145                     	xdef	_keyActiveValue
6146                     	xbit	_isAlert
6147                     	xbit	_WorkMode
6148                     	xbit	_isDataLock
6149                     	xref.b	_AlertTemp
6150                     	xref.b	_CorrectTemp
6151                     	xref.b	_LoopTemp
6152                     	xref.b	_CurrentTemp
6153                     	xref.b	_SetTemp
6154                     	xref.b	_LowTemp
6155                     	xref.b	_HighTemp
6156                     	xbit	_isInSetting
6157                     	xbit	_isBuzzerOn
6158                     	xref.b	_DelayTime_Bkp
6159                     	xref.b	_MachineStatus
6160                     	xref.b	_SetMode
6161                     	xref.b	_inSetTimer
6162                     	xref.b	_buzzerTimer
6163                     	xbit	_is4SecondTimeOn
6164                     	xbit	_isStartToCount4S
6165                     	xbit	_isUpdateDisplay
6166                     	xref.b	_LED_Buf
6167                     	xdef	__keyScanProcess
6168                     	xdef	__displayDecode
6169                     	xdef	__output
6170                     	xdef	__displayAndKeyscan
6171                     	xdef	__IOInitial
6172                     	xref.b	c_x
6173                     	xref.b	c_y
6193                     	xref	c_idiv
6194                     	xref	c_smodx
6195                     	xref	c_sdivx
6196                     	xref	c_imul
6197                     	end
