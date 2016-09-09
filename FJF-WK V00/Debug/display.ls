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
3806  0010 37            	dc.b	55
3807  0011 46            	dc.b	70
3876                     ; 27 void tempdecode(signed int temp)
3876                     ; 28 {
3878                     	switch	.text
3879  0000               _tempdecode:
3881  0000 89            	pushw	x
3882       00000000      OFST:	set	0
3885                     ; 29 	if(temp < 0)
3887  0001 9c            	rvf
3888  0002 a30000        	cpw	x,#0
3889  0005 2e34          	jrsge	L3152
3890                     ; 32 		if(temp > -100)
3892  0007 9c            	rvf
3893  0008 a3ff9d        	cpw	x,#65437
3894  000b 2f16          	jrslt	L5152
3895                     ; 34 			LED_Buf[0] = LEDCode[0x0A];//-
3897  000d 35400000      	mov	_LED_Buf,#64
3898                     ; 35 			LED_Buf[1] = LEDCode[-temp%100/10];//with dot
3900  0011 50            	negw	x
3901  0012 a664          	ld	a,#100
3902  0014 cd0000        	call	c_smodx
3904  0017 a60a          	ld	a,#10
3905  0019 cd0000        	call	c_sdivx
3907  001c d60000        	ld	a,(_LEDCode,x)
3908  001f b701          	ld	_LED_Buf+1,a
3910  0021 207e          	jra	L1252
3911  0023               L5152:
3912                     ; 39 			LED_Buf[0] = LEDCode[0x11];//-1
3914  0023 35460000      	mov	_LED_Buf,#70
3915                     ; 40 			LED_Buf[1] = LEDCode[-temp%100/10];//without dot
3917  0027 1e01          	ldw	x,(OFST+1,sp)
3918  0029 50            	negw	x
3919  002a a664          	ld	a,#100
3920  002c cd0000        	call	c_smodx
3922  002f a60a          	ld	a,#10
3923  0031 cd0000        	call	c_sdivx
3925  0034 d60000        	ld	a,(_LEDCode,x)
3926  0037 b701          	ld	_LED_Buf+1,a
3927  0039 2066          	jra	L1252
3928  003b               L3152:
3929                     ; 45 		if(temp > 999)
3931  003b 9c            	rvf
3932  003c 1e01          	ldw	x,(OFST+1,sp)
3933  003e a303e8        	cpw	x,#1000
3934  0041 2f24          	jrslt	L3252
3935                     ; 47 			LED_Buf[0] = LEDCode[temp/1000];
3937  0043 1e01          	ldw	x,(OFST+1,sp)
3938  0045 90ae03e8      	ldw	y,#1000
3939  0049 cd0000        	call	c_idiv
3941  004c d60000        	ld	a,(_LEDCode,x)
3942  004f b700          	ld	_LED_Buf,a
3943                     ; 48 			LED_Buf[1] = LEDCode[temp%1000/100];
3945  0051 1e01          	ldw	x,(OFST+1,sp)
3946  0053 90ae03e8      	ldw	y,#1000
3947  0057 cd0000        	call	c_idiv
3949  005a 51            	exgw	x,y
3950  005b a664          	ld	a,#100
3951  005d cd0000        	call	c_sdivx
3953  0060 d60000        	ld	a,(_LEDCode,x)
3954  0063 b701          	ld	_LED_Buf+1,a
3956  0065 203a          	jra	L1252
3957  0067               L3252:
3958                     ; 50 		else if(temp < 100)
3960  0067 9c            	rvf
3961  0068 1e01          	ldw	x,(OFST+1,sp)
3962  006a a30064        	cpw	x,#100
3963  006d 2e15          	jrsge	L7252
3964                     ; 52 			LED_Buf[0] = LEDCode[0x0F];//Null
3966  006f 3f00          	clr	_LED_Buf
3967                     ; 53 			LED_Buf[1] = LEDCode[temp%100/10];			
3969  0071 1e01          	ldw	x,(OFST+1,sp)
3970  0073 a664          	ld	a,#100
3971  0075 cd0000        	call	c_smodx
3973  0078 a60a          	ld	a,#10
3974  007a cd0000        	call	c_sdivx
3976  007d d60000        	ld	a,(_LEDCode,x)
3977  0080 b701          	ld	_LED_Buf+1,a
3979  0082 201d          	jra	L1252
3980  0084               L7252:
3981                     ; 57 			LED_Buf[0] = LEDCode[temp/100];
3983  0084 1e01          	ldw	x,(OFST+1,sp)
3984  0086 a664          	ld	a,#100
3985  0088 cd0000        	call	c_sdivx
3987  008b d60000        	ld	a,(_LEDCode,x)
3988  008e b700          	ld	_LED_Buf,a
3989                     ; 58 			LED_Buf[1] = LEDCode[temp%100/10];
3991  0090 1e01          	ldw	x,(OFST+1,sp)
3992  0092 a664          	ld	a,#100
3993  0094 cd0000        	call	c_smodx
3995  0097 a60a          	ld	a,#10
3996  0099 cd0000        	call	c_sdivx
3998  009c d60000        	ld	a,(_LEDCode,x)
3999  009f b701          	ld	_LED_Buf+1,a
4000  00a1               L1252:
4001                     ; 61 }
4004  00a1 85            	popw	x
4005  00a2 81            	ret
4037                     ; 63 void _displayDecode(void)
4037                     ; 64 {
4038                     	switch	.text
4039  00a3               __displayDecode:
4043                     ; 66 	if(isUpdateDisplay)
4045                     	btst	_isUpdateDisplay
4046  00a8 244e          	jruge	L3552
4047                     ; 68 		isUpdateDisplay = 0;
4049  00aa 72110000      	bres	_isUpdateDisplay
4050                     ; 69 		switch(MachineStatus)
4052  00ae b600          	ld	a,_MachineStatus
4054                     ; 89 			default:;
4055  00b0 4d            	tnz	a
4056  00b1 2708          	jreq	L3352
4057  00b3 4a            	dec	a
4058  00b4 270b          	jreq	L5352
4059  00b6 4a            	dec	a
4060  00b7 270f          	jreq	L7352
4061  00b9 203d          	jra	L3552
4062  00bb               L3352:
4063                     ; 73 				LED_Buf[0] = LEDCode[0x0f];//Null
4065  00bb 3f00          	clr	_LED_Buf
4066                     ; 74 				LED_Buf[1] = LEDCode[0x0f];//Null
4068  00bd 3f01          	clr	_LED_Buf+1
4069                     ; 75 			}break;
4071  00bf 2037          	jra	L3552
4072  00c1               L5352:
4073                     ; 78 				tempdecode(CurrentTemp);
4075  00c1 be00          	ldw	x,_CurrentTemp
4076  00c3 cd0000        	call	_tempdecode
4078                     ; 79 			}break;
4080  00c6 2030          	jra	L3552
4081  00c8               L7352:
4082                     ; 82 				if(SetMode == SET_TEMP)tempdecode(SetTemp);
4084  00c8 3d00          	tnz	_SetMode
4085  00ca 2605          	jrne	L1652
4088  00cc be00          	ldw	x,_SetTemp
4089  00ce cd0000        	call	_tempdecode
4091  00d1               L1652:
4092                     ; 83 				if(SetMode == SET_TIME)
4094  00d1 b600          	ld	a,_SetMode
4095  00d3 a101          	cp	a,#1
4096  00d5 2621          	jrne	L3552
4097                     ; 85 					LED_Buf[0] = LEDCode[WorkTime%100/10];
4099  00d7 b600          	ld	a,_WorkTime
4100  00d9 5f            	clrw	x
4101  00da 97            	ld	xl,a
4102  00db a664          	ld	a,#100
4103  00dd cd0000        	call	c_smodx
4105  00e0 a60a          	ld	a,#10
4106  00e2 cd0000        	call	c_sdivx
4108  00e5 d60000        	ld	a,(_LEDCode,x)
4109  00e8 b700          	ld	_LED_Buf,a
4110                     ; 86 					LED_Buf[1] = LEDCode[WorkTime%10];
4112  00ea b600          	ld	a,_WorkTime
4113  00ec 5f            	clrw	x
4114  00ed 97            	ld	xl,a
4115  00ee a60a          	ld	a,#10
4116  00f0 cd0000        	call	c_smodx
4118  00f3 d60000        	ld	a,(_LEDCode,x)
4119  00f6 b701          	ld	_LED_Buf+1,a
4120  00f8               L7552:
4121  00f8               L3552:
4122                     ; 96 }
4125  00f8 81            	ret
4128                     	bsct
4129  0000               L5652_displayNum:
4130  0000 00            	dc.b	0
4183                     ; 98 void _displayAndKeyscan(void)
4183                     ; 99 {
4184                     	switch	.text
4185  00f9               __displayAndKeyscan:
4187  00f9 88            	push	a
4188       00000001      OFST:	set	1
4191                     ; 103 	PC_ODR |= 0B010101000;//Clear all  PC3/5/7
4193  00fa c6500a        	ld	a,_PC_ODR
4194  00fd aaa8          	or	a,#168
4195  00ff c7500a        	ld	_PC_ODR,a
4196                     ; 106 	PD_DDR &= 0B11010011;//PD2/3/5/6
4198  0102 c65011        	ld	a,_PD_DDR
4199  0105 a4d3          	and	a,#211
4200  0107 c75011        	ld	_PD_DDR,a
4201                     ; 108 	for(i = 0;i < 20;i++);
4203  010a 0f01          	clr	(OFST+0,sp)
4204  010c               L1162:
4208  010c 0c01          	inc	(OFST+0,sp)
4211  010e 7b01          	ld	a,(OFST+0,sp)
4212  0110 a114          	cp	a,#20
4213  0112 25f8          	jrult	L1162
4214                     ; 111 	keyscan();
4216  0114 cd0000        	call	_keyscan
4218                     ; 113 	PD_DDR |= 0B00101100;
4220  0117 c65011        	ld	a,_PD_DDR
4221  011a aa2c          	or	a,#44
4222  011c c75011        	ld	_PD_DDR,a
4223                     ; 115 	if(displayNum == 1)
4225  011f b600          	ld	a,L5652_displayNum
4226  0121 a101          	cp	a,#1
4227  0123 2703          	jreq	L411
4228  0125 cc01c2        	jp	L7162
4229  0128               L411:
4230                     ; 117 		displayNum = 0;
4232  0128 3f00          	clr	L5652_displayNum
4233                     ; 118 		PD_ODR_2 = LED_Buf[1]&0b00000001;	//a
4235  012a b601          	ld	a,_LED_Buf+1
4236  012c a501          	bcp	a,#1
4237  012e 2602          	jrne	L611
4238  0130 2006          	jp	L41
4239  0132               L611:
4240  0132 7214500f      	bset	_PD_ODR_2
4241  0136 2004          	jra	L61
4242  0138               L41:
4243  0138 7215500f      	bres	_PD_ODR_2
4244  013c               L61:
4245                     ; 119 		PC_ODR_6 = LED_Buf[1]&0b00000010;	//b
4247  013c b601          	ld	a,_LED_Buf+1
4248  013e a502          	bcp	a,#2
4249  0140 2602          	jrne	L021
4250  0142 2006          	jp	L02
4251  0144               L021:
4252  0144 721c500a      	bset	_PC_ODR_6
4253  0148 2004          	jra	L22
4254  014a               L02:
4255  014a 721d500a      	bres	_PC_ODR_6
4256  014e               L22:
4257                     ; 120 		PA_ODR_2 = LED_Buf[1]&0b00000100;	//c
4259  014e b601          	ld	a,_LED_Buf+1
4260  0150 a504          	bcp	a,#4
4261  0152 2602          	jrne	L221
4262  0154 2006          	jp	L42
4263  0156               L221:
4264  0156 72145000      	bset	_PA_ODR_2
4265  015a 2004          	jra	L62
4266  015c               L42:
4267  015c 72155000      	bres	_PA_ODR_2
4268  0160               L62:
4269                     ; 121 		PA_ODR_1 = LED_Buf[1]&0b00001000;	//d
4271  0160 b601          	ld	a,_LED_Buf+1
4272  0162 a508          	bcp	a,#8
4273  0164 2602          	jrne	L421
4274  0166 2006          	jp	L03
4275  0168               L421:
4276  0168 72125000      	bset	_PA_ODR_1
4277  016c 2004          	jra	L23
4278  016e               L03:
4279  016e 72135000      	bres	_PA_ODR_1
4280  0172               L23:
4281                     ; 122 		PD_ODR_6 = LED_Buf[1]&0b00010000;	//e
4283  0172 b601          	ld	a,_LED_Buf+1
4284  0174 a510          	bcp	a,#16
4285  0176 2602          	jrne	L621
4286  0178 2006          	jp	L43
4287  017a               L621:
4288  017a 721c500f      	bset	_PD_ODR_6
4289  017e 2004          	jra	L63
4290  0180               L43:
4291  0180 721d500f      	bres	_PD_ODR_6
4292  0184               L63:
4293                     ; 123 		PD_ODR_3 = LED_Buf[1]&0b00100000;	//f
4295  0184 b601          	ld	a,_LED_Buf+1
4296  0186 a520          	bcp	a,#32
4297  0188 2602          	jrne	L031
4298  018a 2006          	jp	L04
4299  018c               L031:
4300  018c 7216500f      	bset	_PD_ODR_3
4301  0190 2004          	jra	L24
4302  0192               L04:
4303  0192 7217500f      	bres	_PD_ODR_3
4304  0196               L24:
4305                     ; 124 		PD_ODR_5 = LED_Buf[1]&0b01000000;	//g
4307  0196 b601          	ld	a,_LED_Buf+1
4308  0198 a540          	bcp	a,#64
4309  019a 2602          	jrne	L231
4310  019c 2006          	jp	L44
4311  019e               L231:
4312  019e 721a500f      	bset	_PD_ODR_5
4313  01a2 2004          	jra	L64
4314  01a4               L44:
4315  01a4 721b500f      	bres	_PD_ODR_5
4316  01a8               L64:
4317                     ; 125 		PA_ODR_3 = LED_Buf[1]&0b10000000;	//dp
4319  01a8 b601          	ld	a,_LED_Buf+1
4320  01aa a580          	bcp	a,#128
4321  01ac 2602          	jrne	L431
4322  01ae 2006          	jp	L05
4323  01b0               L431:
4324  01b0 72165000      	bset	_PA_ODR_3
4325  01b4 2004          	jra	L25
4326  01b6               L05:
4327  01b6 72175000      	bres	_PA_ODR_3
4328  01ba               L25:
4329                     ; 126 		PC_ODR &= 0b11011111;							//D0
4331  01ba 721b500a      	bres	_PC_ODR,#5
4333  01be ac5a025a      	jpf	L1262
4334  01c2               L7162:
4335                     ; 130 		displayNum = 1;
4337  01c2 35010000      	mov	L5652_displayNum,#1
4338                     ; 131 		PD_ODR_2 = LED_Buf[0]&0b00000001;	//a
4340  01c6 b600          	ld	a,_LED_Buf
4341  01c8 a501          	bcp	a,#1
4342  01ca 2602          	jrne	L631
4343  01cc 2006          	jp	L45
4344  01ce               L631:
4345  01ce 7214500f      	bset	_PD_ODR_2
4346  01d2 2004          	jra	L65
4347  01d4               L45:
4348  01d4 7215500f      	bres	_PD_ODR_2
4349  01d8               L65:
4350                     ; 132 		PC_ODR_6 = LED_Buf[0]&0b00000010;	//b
4352  01d8 b600          	ld	a,_LED_Buf
4353  01da a502          	bcp	a,#2
4354  01dc 2602          	jrne	L041
4355  01de 2006          	jp	L06
4356  01e0               L041:
4357  01e0 721c500a      	bset	_PC_ODR_6
4358  01e4 2004          	jra	L26
4359  01e6               L06:
4360  01e6 721d500a      	bres	_PC_ODR_6
4361  01ea               L26:
4362                     ; 133 		PA_ODR_2 = LED_Buf[0]&0b00000100;	//c
4364  01ea b600          	ld	a,_LED_Buf
4365  01ec a504          	bcp	a,#4
4366  01ee 2602          	jrne	L241
4367  01f0 2006          	jp	L46
4368  01f2               L241:
4369  01f2 72145000      	bset	_PA_ODR_2
4370  01f6 2004          	jra	L66
4371  01f8               L46:
4372  01f8 72155000      	bres	_PA_ODR_2
4373  01fc               L66:
4374                     ; 134 		PA_ODR_1 = LED_Buf[0]&0b00001000;	//d
4376  01fc b600          	ld	a,_LED_Buf
4377  01fe a508          	bcp	a,#8
4378  0200 2602          	jrne	L441
4379  0202 2006          	jp	L07
4380  0204               L441:
4381  0204 72125000      	bset	_PA_ODR_1
4382  0208 2004          	jra	L27
4383  020a               L07:
4384  020a 72135000      	bres	_PA_ODR_1
4385  020e               L27:
4386                     ; 135 		PD_ODR_6 = LED_Buf[0]&0b00010000;	//e
4388  020e b600          	ld	a,_LED_Buf
4389  0210 a510          	bcp	a,#16
4390  0212 2602          	jrne	L641
4391  0214 2006          	jp	L47
4392  0216               L641:
4393  0216 721c500f      	bset	_PD_ODR_6
4394  021a 2004          	jra	L67
4395  021c               L47:
4396  021c 721d500f      	bres	_PD_ODR_6
4397  0220               L67:
4398                     ; 136 		PD_ODR_3 = LED_Buf[0]&0b00100000;	//f
4400  0220 b600          	ld	a,_LED_Buf
4401  0222 a520          	bcp	a,#32
4402  0224 2602          	jrne	L051
4403  0226 2006          	jp	L001
4404  0228               L051:
4405  0228 7216500f      	bset	_PD_ODR_3
4406  022c 2004          	jra	L201
4407  022e               L001:
4408  022e 7217500f      	bres	_PD_ODR_3
4409  0232               L201:
4410                     ; 137 		PD_ODR_5 = LED_Buf[0]&0b01000000;	//g
4412  0232 b600          	ld	a,_LED_Buf
4413  0234 a540          	bcp	a,#64
4414  0236 2602          	jrne	L251
4415  0238 2006          	jp	L401
4416  023a               L251:
4417  023a 721a500f      	bset	_PD_ODR_5
4418  023e 2004          	jra	L601
4419  0240               L401:
4420  0240 721b500f      	bres	_PD_ODR_5
4421  0244               L601:
4422                     ; 138 		PA_ODR_3 = LED_Buf[0]&0b10000000;//dp
4424  0244 b600          	ld	a,_LED_Buf
4425  0246 a580          	bcp	a,#128
4426  0248 2602          	jrne	L451
4427  024a 2006          	jp	L011
4428  024c               L451:
4429  024c 72165000      	bset	_PA_ODR_3
4430  0250 2004          	jra	L211
4431  0252               L011:
4432  0252 72175000      	bres	_PA_ODR_3
4433  0256               L211:
4434                     ; 139 		PC_ODR &= 0b01111111;							//D1
4436  0256 721f500a      	bres	_PC_ODR,#7
4437  025a               L1262:
4438                     ; 142 	for(i = 0;i < 200;i++);
4440  025a 0f01          	clr	(OFST+0,sp)
4441  025c               L3262:
4445  025c 0c01          	inc	(OFST+0,sp)
4448  025e 7b01          	ld	a,(OFST+0,sp)
4449  0260 a1c8          	cp	a,#200
4450  0262 25f8          	jrult	L3262
4451                     ; 144 }
4454  0264 84            	pop	a
4455  0265 81            	ret
4480                     	xref	_keyscan
4481                     	xdef	_tempdecode
4482                     	xdef	_LEDCode
4483                     	xref.b	_WorkTime
4484                     	xref.b	_CurrentTemp
4485                     	xref.b	_SetTemp
4486                     	xref.b	_SetMode
4487                     	xref.b	_MachineStatus
4488                     	xbit	_isUpdateDisplay
4489                     	xref.b	_LED_Buf
4490                     	xdef	__displayDecode
4491                     	xdef	__displayAndKeyscan
4492                     	xref.b	c_x
4511                     	xref	c_idiv
4512                     	xref	c_sdivx
4513                     	xref	c_smodx
4514                     	end
