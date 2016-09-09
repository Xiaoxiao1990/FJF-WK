   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3842                     ; 32 void _IOInitial(void)
3842                     ; 33 {
3844                     	switch	.text
3845  0000               __IOInitial:
3849                     ; 35 }
3852  0000 81            	ret
3855                     	bsct
3856  0000               L5052_keyNewValue:
3857  0000 00            	dc.b	0
3858  0001               L3152_time_CNT:
3859  0001 00            	dc.b	0
3860                     	switch	.ubsct
3861  0000               L7052_keyScanCnt:
3862  0000 0000          	ds.b	2
3863  0002               L1152_steps:
3864  0002 00            	ds.b	1
3939                     ; 37 void keyscan(void)
3939                     ; 38 {
3940                     	switch	.text
3941  0001               _keyscan:
3943  0001 88            	push	a
3944       00000001      OFST:	set	1
3947                     ; 45 	if(++time_CNT < 10)
3949  0002 3c01          	inc	L3152_time_CNT
3950  0004 b601          	ld	a,L3152_time_CNT
3951  0006 a10a          	cp	a,#10
3952  0008 2402          	jruge	L3652
3953                     ; 47 		return;
3956  000a 84            	pop	a
3957  000b 81            	ret
3958  000c               L3652:
3959                     ; 49 	time_CNT = 0;
3961  000c 3f01          	clr	L3152_time_CNT
3962                     ; 51 	keyStatus = PORT_KEY ^ KEYRELEASE_PORTVALUE;
3964  000e c65010        	ld	a,_PD_IDR
3965  0011 a42c          	and	a,#44
3966  0013 6b01          	ld	(OFST+0,sp),a
3967                     ; 52 	switch(steps)
3969  0015 b602          	ld	a,L1152_steps
3971                     ; 104 		default:;
3972  0017 4d            	tnz	a
3973  0018 2708          	jreq	L5152
3974  001a 4a            	dec	a
3975  001b 271e          	jreq	L7152
3976  001d 4a            	dec	a
3977  001e 273e          	jreq	L1252
3978  0020 2070          	jra	L7652
3979  0022               L5152:
3980                     ; 56 			if(keyStatus != 0)
3982  0022 0d01          	tnz	(OFST+0,sp)
3983  0024 2708          	jreq	L1752
3984                     ; 58 				keyNewValue = keyStatus; 			//store the keys value;
3986  0026 7b01          	ld	a,(OFST+0,sp)
3987  0028 b700          	ld	L5052_keyNewValue,a
3988                     ; 59 				steps++;											//turn to next step
3990  002a 3c02          	inc	L1152_steps
3992  002c 2064          	jra	L7652
3993  002e               L1752:
3994                     ; 63 				keyScanCnt = 0;
3996  002e 5f            	clrw	x
3997  002f bf00          	ldw	L7052_keyScanCnt,x
3998                     ; 64 				isKeyLongPress = 0;
4000  0031 72110002      	bres	_isKeyLongPress
4001                     ; 65 				isCanEffect = 1;
4003  0035 72100000      	bset	_isCanEffect
4004  0039 2057          	jra	L7652
4005  003b               L7152:
4006                     ; 70 			if(keyStatus == keyNewValue)		//if the keys value is not change
4008  003b 7b01          	ld	a,(OFST+0,sp)
4009  003d b100          	cp	a,L5052_keyNewValue
4010  003f 2616          	jrne	L5752
4011                     ; 72 				if(++keyScanCnt > KEY_SHORT_PRESS)					//dealy
4013  0041 be00          	ldw	x,L7052_keyScanCnt
4014  0043 1c0001        	addw	x,#1
4015  0046 bf00          	ldw	L7052_keyScanCnt,x
4016  0048 a3001f        	cpw	x,#31
4017  004b 2545          	jrult	L7652
4018                     ; 74 					keyScanCnt = 0;							//clear counter
4020  004d 5f            	clrw	x
4021  004e bf00          	ldw	L7052_keyScanCnt,x
4022                     ; 75 					steps++;										//turn to next step
4024  0050 3c02          	inc	L1152_steps
4025                     ; 76 					keyActiveValue = keyNewValue;
4027  0052 450007        	mov	_keyActiveValue,L5052_keyNewValue
4028  0055 203b          	jra	L7652
4029  0057               L5752:
4030                     ; 81 				keyScanCnt = 0;								//clear time counter
4032  0057 5f            	clrw	x
4033  0058 bf00          	ldw	L7052_keyScanCnt,x
4034                     ; 82 				steps--;       								//back to first step
4036  005a 3a02          	dec	L1152_steps
4037  005c 2034          	jra	L7652
4038  005e               L1252:
4039                     ; 87 			if(keyStatus != keyNewValue)//Key release
4041  005e 7b01          	ld	a,(OFST+0,sp)
4042  0060 b100          	cp	a,L5052_keyNewValue
4043  0062 2717          	jreq	L3062
4044                     ; 89 				if(!isKeyLongPress)isKeyProcess = 1;
4046                     	btst	_isKeyLongPress
4047  0069 2504          	jrult	L5062
4050  006b 72100001      	bset	_isKeyProcess
4051  006f               L5062:
4052                     ; 90 				steps = 0;
4054  006f 3f02          	clr	L1152_steps
4055                     ; 91 				keyScanCnt = 0;
4057  0071 5f            	clrw	x
4058  0072 bf00          	ldw	L7052_keyScanCnt,x
4059                     ; 92 				longPressBase = LONG_PRESS_COUNT;
4061  0074 ae1f40        	ldw	x,#8000
4062  0077 bf03          	ldw	_longPressBase,x
4064  0079 2017          	jra	L7652
4065  007b               L3062:
4066                     ; 96 				if(++keyScanCnt > KEY_LONG_PRESS)  //if key long time press
4068  007b be00          	ldw	x,L7052_keyScanCnt
4069  007d 1c0001        	addw	x,#1
4070  0080 bf00          	ldw	L7052_keyScanCnt,x
4071  0082 a302bd        	cpw	x,#701
4072  0085 2509          	jrult	L1162
4073                     ; 98 					keyScanCnt = KEY_SHORT_PRESS;
4075  0087 ae001e        	ldw	x,#30
4076  008a bf00          	ldw	L7052_keyScanCnt,x
4077                     ; 99 					isKeyLongPress = 1;						  //set key long time press flag
4079  008c 72100002      	bset	_isKeyLongPress
4080  0090               L1162:
4081                     ; 101 				inSetTimer = 0;										//Any key is pressed clear the time counter
4083  0090 3f00          	clr	_inSetTimer
4084  0092               L7652:
4085                     ; 106 }
4088  0092 84            	pop	a
4089  0093 81            	ret
4116                     ; 108 void keyaddprocess(void)
4116                     ; 109 {
4117                     	switch	.text
4118  0094               _keyaddprocess:
4122                     ; 110 	switch(MachineStatus)
4124  0094 b600          	ld	a,_MachineStatus
4126                     ; 133 		default:;
4127  0096 4d            	tnz	a
4128  0097 2730          	jreq	L5362
4129  0099 4a            	dec	a
4130  009a 272d          	jreq	L5362
4131  009c 4a            	dec	a
4132  009d 262a          	jrne	L5362
4133                     ; 116 			if(SetMode == SET_TEMP)
4135  009f 3d00          	tnz	_SetMode
4136  00a1 2618          	jrne	L7362
4137                     ; 118 				if(SetTemp < 900)
4139  00a3 9c            	rvf
4140  00a4 be00          	ldw	x,_SetTemp
4141  00a6 a30384        	cpw	x,#900
4142  00a9 2e09          	jrsge	L1462
4143                     ; 120 					SetTemp += 10;
4145  00ab be00          	ldw	x,_SetTemp
4146  00ad 1c000a        	addw	x,#10
4147  00b0 bf00          	ldw	_SetTemp,x
4149  00b2 2015          	jra	L5362
4150  00b4               L1462:
4151                     ; 124 					SetTemp = 900;
4153  00b4 ae0384        	ldw	x,#900
4154  00b7 bf00          	ldw	_SetTemp,x
4155  00b9 200e          	jra	L5362
4156  00bb               L7362:
4157                     ; 129 				if(WorkTime < 99)WorkTime++;
4159  00bb b600          	ld	a,_WorkTime
4160  00bd a163          	cp	a,#99
4161  00bf 2404          	jruge	L7462
4164  00c1 3c00          	inc	_WorkTime
4166  00c3 2004          	jra	L5362
4167  00c5               L7462:
4168                     ; 130 				else WorkTime = 99; 
4170  00c5 35630000      	mov	_WorkTime,#99
4171  00c9               L5362:
4172                     ; 135 }
4175  00c9 81            	ret
4202                     ; 136 void keysubprocess(void)
4202                     ; 137 {
4203                     	switch	.text
4204  00ca               _keysubprocess:
4208                     ; 138 	switch(MachineStatus)
4210  00ca b600          	ld	a,_MachineStatus
4212                     ; 161 		default:;
4213  00cc 4d            	tnz	a
4214  00cd 2730          	jreq	L5762
4215  00cf 4a            	dec	a
4216  00d0 272d          	jreq	L5762
4217  00d2 4a            	dec	a
4218  00d3 262a          	jrne	L5762
4219                     ; 144 			if(SetMode == SET_TEMP)
4221  00d5 3d00          	tnz	_SetMode
4222  00d7 2618          	jrne	L7762
4223                     ; 146 				if(SetTemp > 300)
4225  00d9 9c            	rvf
4226  00da be00          	ldw	x,_SetTemp
4227  00dc a3012d        	cpw	x,#301
4228  00df 2f09          	jrslt	L1072
4229                     ; 148 					SetTemp -= 10;
4231  00e1 be00          	ldw	x,_SetTemp
4232  00e3 1d000a        	subw	x,#10
4233  00e6 bf00          	ldw	_SetTemp,x
4235  00e8 2015          	jra	L5762
4236  00ea               L1072:
4237                     ; 152 					SetTemp = 300;
4239  00ea ae012c        	ldw	x,#300
4240  00ed bf00          	ldw	_SetTemp,x
4241  00ef 200e          	jra	L5762
4242  00f1               L7762:
4243                     ; 157 				if(WorkTime > 30)WorkTime--;
4245  00f1 b600          	ld	a,_WorkTime
4246  00f3 a11f          	cp	a,#31
4247  00f5 2504          	jrult	L7072
4250  00f7 3a00          	dec	_WorkTime
4252  00f9 2004          	jra	L5762
4253  00fb               L7072:
4254                     ; 158 				else WorkTime = 30;
4256  00fb 351e0000      	mov	_WorkTime,#30
4257  00ff               L5762:
4258                     ; 163 }
4261  00ff 81            	ret
4286                     ; 165 void keysetprocess(void)
4286                     ; 166 {
4287                     	switch	.text
4288  0100               _keysetprocess:
4292                     ; 167 	switch(MachineStatus)
4294  0100 b600          	ld	a,_MachineStatus
4296                     ; 180 		default:;
4297  0102 4d            	tnz	a
4298  0103 271a          	jreq	L5372
4299  0105 4a            	dec	a
4300  0106 2705          	jreq	L5172
4301  0108 4a            	dec	a
4302  0109 270a          	jreq	L7172
4303  010b 2012          	jra	L5372
4304  010d               L5172:
4305                     ; 172 			MachineStatus = SETTING;
4307  010d 35020000      	mov	_MachineStatus,#2
4308                     ; 173 			SetMode = SET_TEMP;
4310  0111 3f00          	clr	_SetMode
4311                     ; 174 		}break;
4313  0113 200a          	jra	L5372
4314  0115               L7172:
4315                     ; 177 			if(++SetMode > SET_TIME)SetMode = SET_TEMP;
4317  0115 3c00          	inc	_SetMode
4318  0117 b600          	ld	a,_SetMode
4319  0119 a102          	cp	a,#2
4320  011b 2502          	jrult	L5372
4323  011d 3f00          	clr	_SetMode
4324  011f               L5372:
4325                     ; 182 }
4328  011f 81            	ret
4364                     ; 184 void _keyScanProcess(void)
4364                     ; 185 {
4365                     	switch	.text
4366  0120               __keyScanProcess:
4370                     ; 186 	if (isKeyLongPress)
4372                     	btst	_isKeyLongPress
4373  0125 2465          	jruge	L1672
4374                     ; 188 		longPressCnt += LONG_PRESS_ADD_UINT;
4376  0127 be05          	ldw	x,_longPressCnt
4377  0129 1c0004        	addw	x,#4
4378  012c bf05          	ldw	_longPressCnt,x
4379                     ; 189 		if(++longPressCnt > longPressBase)
4381  012e be05          	ldw	x,_longPressCnt
4382  0130 1c0001        	addw	x,#1
4383  0133 bf05          	ldw	_longPressCnt,x
4384  0135 b303          	cpw	x,_longPressBase
4385  0137 2353          	jrule	L1672
4386                     ; 191 			longPressCnt = 0;
4388  0139 5f            	clrw	x
4389  013a bf05          	ldw	_longPressCnt,x
4390                     ; 192 			if(longPressBase > LONG_PRESS_LIMIT)
4392  013c be03          	ldw	x,_longPressBase
4393  013e a30bb9        	cpw	x,#3001
4394  0141 2507          	jrult	L5672
4395                     ; 194 				longPressBase -= LONG_PRESS_SUB_UNIT;
4397  0143 be03          	ldw	x,_longPressBase
4398  0145 1d00b4        	subw	x,#180
4399  0148 bf03          	ldw	_longPressBase,x
4400  014a               L5672:
4401                     ; 197 			if((keyActiveValue == KEY_ADD)||(keyActiveValue == KEY_SUB))
4403  014a b607          	ld	a,_keyActiveValue
4404  014c a108          	cp	a,#8
4405  014e 2706          	jreq	L1772
4407  0150 b607          	ld	a,_keyActiveValue
4408  0152 a120          	cp	a,#32
4409  0154 260c          	jrne	L7672
4410  0156               L1772:
4411                     ; 199 				if(MachineStatus == SETTING)isKeyProcess = 1;
4413  0156 b600          	ld	a,_MachineStatus
4414  0158 a102          	cp	a,#2
4415  015a 2630          	jrne	L1672
4418  015c 72100001      	bset	_isKeyProcess
4419  0160 202a          	jra	L1672
4420  0162               L7672:
4421                     ; 201 			else if(keyActiveValue == KEY_SET)
4423  0162 b607          	ld	a,_keyActiveValue
4424  0164 a104          	cp	a,#4
4425  0166 2624          	jrne	L1672
4426                     ; 203 				if(isCanEffect)
4428                     	btst	_isCanEffect
4429  016d 241d          	jruge	L1672
4430                     ; 205 					isCanEffect = 0;//Clear
4432  016f 72110000      	bres	_isCanEffect
4433                     ; 206 					isUpdateDisplay = Yes;
4435  0173 72100000      	bset	_isUpdateDisplay
4436                     ; 207 					if(MachineStatus == WORK)
4438  0177 b600          	ld	a,_MachineStatus
4439  0179 a101          	cp	a,#1
4440  017b 2604          	jrne	L3003
4441                     ; 209 						MachineStatus = SHUTDOWN;
4443  017d 3f00          	clr	_MachineStatus
4445  017f 200b          	jra	L1672
4446  0181               L3003:
4447                     ; 211 					else if(MachineStatus == SHUTDOWN)
4449  0181 3d00          	tnz	_MachineStatus
4450  0183 2607          	jrne	L1672
4451                     ; 213 						MachineStatus = WORK;
4453  0185 35010000      	mov	_MachineStatus,#1
4454                     ; 214 						WorkTimeBkp = WorkTime;
4456  0189 450000        	mov	_WorkTimeBkp,_WorkTime
4457  018c               L1672:
4458                     ; 220 	if(isKeyProcess)
4460                     	btst	_isKeyProcess
4461  0191 2425          	jruge	L1103
4462                     ; 222 		isKeyProcess = 0;
4464  0193 72110001      	bres	_isKeyProcess
4465                     ; 223 		isUpdateDisplay = Yes;
4467  0197 72100000      	bset	_isUpdateDisplay
4468                     ; 224 		switch(keyActiveValue)
4470  019b b607          	ld	a,_keyActiveValue
4472                     ; 239 			default:;
4473  019d a004          	sub	a,#4
4474  019f 270a          	jreq	L1472
4475  01a1 a004          	sub	a,#4
4476  01a3 270b          	jreq	L3472
4477  01a5 a018          	sub	a,#24
4478  01a7 270c          	jreq	L5472
4479  01a9 200d          	jra	L1103
4480  01ab               L1472:
4481                     ; 228 				keysetprocess();
4483  01ab cd0100        	call	_keysetprocess
4485                     ; 230 			break;
4487  01ae 2008          	jra	L1103
4488  01b0               L3472:
4489                     ; 233 				keyaddprocess();
4491  01b0 cd0094        	call	_keyaddprocess
4493                     ; 234 			}break;
4495  01b3 2003          	jra	L1103
4496  01b5               L5472:
4497                     ; 237 				keysubprocess();
4499  01b5 cd00ca        	call	_keysubprocess
4501                     ; 238 			}break;
4503  01b8               L5103:
4504  01b8               L1103:
4505                     ; 242 }
4508  01b8 81            	ret
4580                     	xdef	_keysetprocess
4581                     	xdef	_keysubprocess
4582                     	xdef	_keyaddprocess
4583                     	xdef	_keyscan
4584                     .bit:	section	.data,bit
4585  0000               _isCanEffect:
4586  0000 00            	ds.b	1
4587                     	xdef	_isCanEffect
4588  0001               _isKeyProcess:
4589  0001 00            	ds.b	1
4590                     	xdef	_isKeyProcess
4591  0002               _isKeyLongPress:
4592  0002 00            	ds.b	1
4593                     	xdef	_isKeyLongPress
4594                     	switch	.ubsct
4595  0003               _longPressBase:
4596  0003 0000          	ds.b	2
4597                     	xdef	_longPressBase
4598  0005               _longPressCnt:
4599  0005 0000          	ds.b	2
4600                     	xdef	_longPressCnt
4601  0007               _keyActiveValue:
4602  0007 00            	ds.b	1
4603                     	xdef	_keyActiveValue
4604                     	xref.b	_WorkTimeBkp
4605                     	xref.b	_WorkTime
4606                     	xref.b	_SetTemp
4607                     	xref.b	_SetMode
4608                     	xref.b	_MachineStatus
4609                     	xref.b	_inSetTimer
4610                     	xbit	_isUpdateDisplay
4611                     	xdef	__keyScanProcess
4612                     	xdef	__IOInitial
4632                     	end
