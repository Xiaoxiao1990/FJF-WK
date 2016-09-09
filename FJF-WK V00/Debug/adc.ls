   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3788                     .const:	section	.text
3789  0000               _tempTable:
3790  0000 2451          	dc.w	9297
3791  0002 2276          	dc.w	8822
3792  0004 20b4          	dc.w	8372
3793  0006 1f0e          	dc.w	7950
3794  0008 1d7e          	dc.w	7550
3795  000a 1c04          	dc.w	7172
3796  000c 1aa0          	dc.w	6816
3797  000e 194e          	dc.w	6478
3798  0010 180f          	dc.w	6159
3799  0012 16e3          	dc.w	5859
3800  0014 15c7          	dc.w	5575
3801  0016 14b1          	dc.w	5297
3802  0018 13aa          	dc.w	5034
3803  001a 12b0          	dc.w	4784
3804  001c 11c6          	dc.w	4550
3805  001e 10e5          	dc.w	4325
3806  0020 1014          	dc.w	4116
3807  0022 0f4c          	dc.w	3916
3808  0024 0e90          	dc.w	3728
3809  0026 0ddb          	dc.w	3547
3810  0028 0d32          	dc.w	3378
3811  002a 0c96          	dc.w	3222
3812  002c 0c01          	dc.w	3073
3813  002e 0b75          	dc.w	2933
3814  0030 0aef          	dc.w	2799
3815  0032 0a70          	dc.w	2672
3816  0034 09f8          	dc.w	2552
3817  0036 0986          	dc.w	2438
3818  0038 0919          	dc.w	2329
3819  003a 08b2          	dc.w	2226
3820  003c 0850          	dc.w	2128
3821  003e 07f3          	dc.w	2035
3822  0040 079b          	dc.w	1947
3823  0042 0747          	dc.w	1863
3824  0044 06f7          	dc.w	1783
3825  0046 06ab          	dc.w	1707
3826  0048 0661          	dc.w	1633
3827  004a 061c          	dc.w	1564
3828  004c 05d9          	dc.w	1497
3829  004e 059a          	dc.w	1434
3830  0050 055e          	dc.w	1374
3831  0052 0525          	dc.w	1317
3832  0054 04ee          	dc.w	1262
3833  0056 04ba          	dc.w	1210
3834  0058 0488          	dc.w	1160
3835  005a 0459          	dc.w	1113
3836  005c 042c          	dc.w	1068
3837  005e 0401          	dc.w	1025
3838  0060 03d7          	dc.w	983
3839  0062 03b1          	dc.w	945
3840  0064 038b          	dc.w	907
3841  0066 0367          	dc.w	871
3842  0068 0345          	dc.w	837
3843  006a 0324          	dc.w	804
3844  006c 0305          	dc.w	773
3845  006e 02e7          	dc.w	743
3846  0070 02cb          	dc.w	715
3847  0072 02b0          	dc.w	688
3848  0074 0296          	dc.w	662
3849  0076 027d          	dc.w	637
3850  0078 0265          	dc.w	613
3851  007a 024e          	dc.w	590
3852  007c 0239          	dc.w	569
3853  007e 0224          	dc.w	548
3854  0080 0210          	dc.w	528
3855  0082 01fc          	dc.w	508
3856  0084 01e9          	dc.w	489
3857  0086 01d8          	dc.w	472
3858  0088 01c6          	dc.w	454
3859  008a 01b6          	dc.w	438
3860  008c 01a6          	dc.w	422
3861  008e 0197          	dc.w	407
3862  0090 0189          	dc.w	393
3863  0092 017a          	dc.w	378
3864  0094 016d          	dc.w	365
3865  0096 0161          	dc.w	353
3866  0098 0154          	dc.w	340
3867  009a 0148          	dc.w	328
3868  009c 013d          	dc.w	317
3869  009e 0132          	dc.w	306
3870  00a0 0128          	dc.w	296
3871  00a2 011e          	dc.w	286
3872  00a4 0114          	dc.w	276
3873  00a6 010b          	dc.w	267
3874  00a8 0102          	dc.w	258
3875  00aa 00fa          	dc.w	250
3876  00ac 00f1          	dc.w	241
3877  00ae 00e9          	dc.w	233
3878  00b0 00e2          	dc.w	226
3879  00b2 00db          	dc.w	219
3880  00b4 00d3          	dc.w	211
3881  00b6 00cd          	dc.w	205
3882  00b8 00c6          	dc.w	198
3883  00ba 00c0          	dc.w	192
3884  00bc 00ba          	dc.w	186
3885  00be 00b4          	dc.w	180
3886  00c0 00ae          	dc.w	174
3887  00c2 00a9          	dc.w	169
3888  00c4 00a4          	dc.w	164
3889  00c6 009f          	dc.w	159
3890  00c8 009a          	dc.w	154
3891  00ca 0096          	dc.w	150
3892  00cc 0091          	dc.w	145
3893  00ce 008d          	dc.w	141
3894  00d0 0088          	dc.w	136
3895  00d2 0084          	dc.w	132
3896  00d4 0081          	dc.w	129
3897  00d6 007d          	dc.w	125
3898  00d8 0079          	dc.w	121
3899  00da 0076          	dc.w	118
3900  00dc 0072          	dc.w	114
3970                     ; 28 void _ADC_Initial(void)
3970                     ; 29 {
3972                     	switch	.text
3973  0000               __ADC_Initial:
3975  0000 88            	push	a
3976       00000001      OFST:	set	1
3979                     ; 32 	ADC_CR2 = ADC1_ALIGN_RIGHT; // A/D data rigth align
3981  0001 35085402      	mov	_ADC_CR2,#8
3982                     ; 33 	ADC_CR1 = 0x00; // ADC clock=main clock/2=4MHZm,sigle converterm,disable convert
3984  0005 725f5401      	clr	_ADC_CR1
3985                     ; 34 	ADC_CSR = 0x02; // choose channel 2
3987  0009 35025400      	mov	_ADC_CSR,#2
3988                     ; 36 	bitADC1_CR1_ADON = 1;	//ADC_CR1 = 0x01; // enable AD start
3990  000d 72105401      	bset	_bitADC1_CR1_ADON
3991                     ; 38 	for(i=0;i<100;i++); // wait at least 7us
3993  0011 0f01          	clr	(OFST+0,sp)
3994  0013               L3152:
3998  0013 0c01          	inc	(OFST+0,sp)
4001  0015 7b01          	ld	a,(OFST+0,sp)
4002  0017 a164          	cp	a,#100
4003  0019 25f8          	jrult	L3152
4004                     ; 39 	for(i=0;i<100;i++); // wait at least 7us
4006  001b 0f01          	clr	(OFST+0,sp)
4007  001d               L1252:
4011  001d 0c01          	inc	(OFST+0,sp)
4014  001f 7b01          	ld	a,(OFST+0,sp)
4015  0021 a164          	cp	a,#100
4016  0023 25f8          	jrult	L1252
4017                     ; 40 	bitADC1_CR1_ADON = 1;
4019  0025 72105401      	bset	_bitADC1_CR1_ADON
4020                     ; 41 	bitADC1_CSR_EOC = 0;
4022  0029 721f5400      	bres	_bitADC1_CSR_EOC
4023                     ; 42 }
4026  002d 84            	pop	a
4027  002e 81            	ret
4030                     	bsct
4031  0000               L7252_sumTimes:
4032  0000 00            	dc.b	0
4033  0001               L1352_sum_AD_value:
4034  0001 0000          	dc.w	0
4035  0003               L3352_CurrentTempBkp:
4036  0003 0000          	dc.w	0
4037  0005               L5352_CurrentTempValue:
4038  0005 0000          	dc.w	0
4131                     ; 44 void _AD_temperature(void)
4131                     ; 45 {
4132                     	switch	.text
4133  002f               __AD_temperature:
4135  002f 5207          	subw	sp,#7
4136       00000007      OFST:	set	7
4139                     ; 53 	if (ADC1_GetFlagStatus(ADC1_FLAG_EOC)== 0) return;// SET or RESET
4141  0031 a680          	ld	a,#128
4142  0033 cd0000        	call	_ADC1_GetFlagStatus
4144  0036 4d            	tnz	a
4145  0037 2603          	jrne	L41
4146  0039 cc018a        	jp	L21
4147  003c               L41:
4150                     ; 54 	sum_AD_value += ADC1_GetConversionValue();
4152  003c cd0000        	call	_ADC1_GetConversionValue
4154  003f 72bb0001      	addw	x,L1352_sum_AD_value
4155  0043 bf01          	ldw	L1352_sum_AD_value,x
4156                     ; 55 	bitADC1_CR1_ADON = 1;
4158  0045 72105401      	bset	_bitADC1_CR1_ADON
4159                     ; 56 	if (++sumTimes >= 16)
4161  0049 3c00          	inc	L7252_sumTimes
4162  004b b600          	ld	a,L7252_sumTimes
4163  004d a110          	cp	a,#16
4164  004f 2403          	jruge	L61
4165  0051 cc018a        	jp	L7062
4166  0054               L61:
4167                     ; 58 		sumTimes = 0;
4169  0054 3f00          	clr	L7252_sumTimes
4170                     ; 59 		sum_AD_value >>= 4;
4172  0056 a604          	ld	a,#4
4173  0058               L01:
4174  0058 3401          	srl	L1352_sum_AD_value
4175  005a 3602          	rrc	L1352_sum_AD_value+1
4176  005c 4a            	dec	a
4177  005d 26f9          	jrne	L01
4178                     ; 60 		if(sum_AD_value >= 1000)//NTC may Open circuit
4180  005f be01          	ldw	x,L1352_sum_AD_value
4181  0061 a303e8        	cpw	x,#1000
4182  0064 250f          	jrult	L1162
4183                     ; 62 			ResistorValue = RESISTOR_TEMP_LOWLIMIT;
4185  0066 ae2451        	ldw	x,#9297
4186  0069 1f05          	ldw	(OFST-2,sp),x
4187                     ; 63 			if(MachineStatus == WORK)MachineStatus = SHUTDOWN;
4189  006b b600          	ld	a,_MachineStatus
4190  006d a101          	cp	a,#1
4191  006f 2629          	jrne	L5162
4194  0071 3f00          	clr	_MachineStatus
4195  0073 2025          	jra	L5162
4196  0075               L1162:
4197                     ; 67 			ResistorValue = (long)sum_AD_value*RES_UPVALUE/(1024-sum_AD_value);
4199  0075 ae0400        	ldw	x,#1024
4200  0078 72b00001      	subw	x,L1352_sum_AD_value
4201  007c cd0000        	call	c_uitolx
4203  007f 96            	ldw	x,sp
4204  0080 1c0001        	addw	x,#OFST-6
4205  0083 cd0000        	call	c_rtol
4207  0086 be01          	ldw	x,L1352_sum_AD_value
4208  0088 90ae063a      	ldw	y,#1594
4209  008c cd0000        	call	c_umul
4211  008f 96            	ldw	x,sp
4212  0090 1c0001        	addw	x,#OFST-6
4213  0093 cd0000        	call	c_ldiv
4215  0096 be02          	ldw	x,c_lreg+2
4216  0098 1f05          	ldw	(OFST-2,sp),x
4217  009a               L5162:
4218                     ; 69 		if (ResistorValue >= RESISTOR_TEMP_LOWLIMIT)//-30`c ,
4220  009a 1e05          	ldw	x,(OFST-2,sp)
4221  009c a32451        	cpw	x,#9297
4222  009f 2509          	jrult	L7162
4223                     ; 71 			ResistorValue = RESISTOR_TEMP_LOWLIMIT;
4225                     ; 72 			CurrentTempValue = -100;
4227  00a1 aeff9c        	ldw	x,#65436
4228  00a4 bf05          	ldw	L5352_CurrentTempValue,x
4230  00a6 ac620162      	jpf	L1262
4231  00aa               L7162:
4232                     ; 74 		else if (ResistorValue < RESISTOR_TEMP_UPLIMIT)//NTC may short circuit
4234  00aa 1e05          	ldw	x,(OFST-2,sp)
4235  00ac a30072        	cpw	x,#114
4236  00af 2414          	jruge	L3262
4237                     ; 76 			ResistorValue = RESISTOR_TEMP_UPLIMIT;
4239                     ; 77 			CurrentTempValue = 1000;
4241  00b1 ae03e8        	ldw	x,#1000
4242  00b4 bf05          	ldw	L5352_CurrentTempValue,x
4243                     ; 78 			if(MachineStatus == WORK)MachineStatus = SHUTDOWN;
4245  00b6 b600          	ld	a,_MachineStatus
4246  00b8 a101          	cp	a,#1
4247  00ba 2703          	jreq	L02
4248  00bc cc0162        	jp	L1262
4249  00bf               L02:
4252  00bf 3f00          	clr	_MachineStatus
4253  00c1 ac620162      	jpf	L1262
4254  00c5               L3262:
4255                     ; 82 			for (i = 0;ResistorValue <= tempTable[i];i++)if(i > 200)break;
4257  00c5 0f07          	clr	(OFST+0,sp)
4259  00c7 2014          	jra	L5362
4260  00c9               L1362:
4263  00c9 7b07          	ld	a,(OFST+0,sp)
4264  00cb a1c9          	cp	a,#201
4265  00cd 250c          	jrult	L1462
4267  00cf               L7362:
4268                     ; 83 			if(i == 0)
4270  00cf 0d07          	tnz	(OFST+0,sp)
4271  00d1 261c          	jrne	L3462
4272                     ; 85 				CurrentTempValue = -100;
4274  00d3 aeff9c        	ldw	x,#65436
4275  00d6 bf05          	ldw	L5352_CurrentTempValue,x
4277  00d8 cc0162        	jra	L1262
4278  00db               L1462:
4279                     ; 82 			for (i = 0;ResistorValue <= tempTable[i];i++)if(i > 200)break;
4281  00db 0c07          	inc	(OFST+0,sp)
4282  00dd               L5362:
4285  00dd 7b07          	ld	a,(OFST+0,sp)
4286  00df 5f            	clrw	x
4287  00e0 97            	ld	xl,a
4288  00e1 58            	sllw	x
4289  00e2 9093          	ldw	y,x
4290  00e4 51            	exgw	x,y
4291  00e5 de0000        	ldw	x,(_tempTable,x)
4292  00e8 1305          	cpw	x,(OFST-2,sp)
4293  00ea 51            	exgw	x,y
4294  00eb 24dc          	jruge	L1362
4295  00ed 20e0          	jra	L7362
4296  00ef               L3462:
4297                     ; 89 				temp0 = (long)10*(tempTable[i-1]-ResistorValue)/(tempTable[i-1]-tempTable[i])+1;
4299  00ef 7b07          	ld	a,(OFST+0,sp)
4300  00f1 5f            	clrw	x
4301  00f2 97            	ld	xl,a
4302  00f3 58            	sllw	x
4303  00f4 5a            	decw	x
4304  00f5 5a            	decw	x
4305  00f6 de0000        	ldw	x,(_tempTable,x)
4306  00f9 7b07          	ld	a,(OFST+0,sp)
4307  00fb 905f          	clrw	y
4308  00fd 9097          	ld	yl,a
4309  00ff 9058          	sllw	y
4310  0101 90de0000      	ldw	y,(_tempTable,y)
4311  0105 90bf00        	ldw	c_x,y
4312  0108 72b00000      	subw	x,c_x
4313  010c cd0000        	call	c_uitolx
4315  010f 96            	ldw	x,sp
4316  0110 1c0001        	addw	x,#OFST-6
4317  0113 cd0000        	call	c_rtol
4319  0116 7b07          	ld	a,(OFST+0,sp)
4320  0118 5f            	clrw	x
4321  0119 97            	ld	xl,a
4322  011a 58            	sllw	x
4323  011b 5a            	decw	x
4324  011c 5a            	decw	x
4325  011d de0000        	ldw	x,(_tempTable,x)
4326  0120 72f005        	subw	x,(OFST-2,sp)
4327  0123 a60a          	ld	a,#10
4328  0125 cd0000        	call	c_cmulx
4330  0128 96            	ldw	x,sp
4331  0129 1c0001        	addw	x,#OFST-6
4332  012c cd0000        	call	c_ldiv
4334  012f a601          	ld	a,#1
4335  0131 cd0000        	call	c_ladc
4337  0134 be02          	ldw	x,c_lreg+2
4338  0136 1f05          	ldw	(OFST-2,sp),x
4339                     ; 90 				CurrentTempValue = -100+(i-1)*10+temp0;
4341  0138 7b07          	ld	a,(OFST+0,sp)
4342  013a 97            	ld	xl,a
4343  013b a60a          	ld	a,#10
4344  013d 42            	mul	x,a
4345  013e 1d006e        	subw	x,#110
4346  0141 72fb05        	addw	x,(OFST-2,sp)
4347  0144 bf05          	ldw	L5352_CurrentTempValue,x
4348                     ; 91 				if (CurrentTempValue <= -100)
4350  0146 9c            	rvf
4351  0147 be05          	ldw	x,L5352_CurrentTempValue
4352  0149 a3ff9d        	cpw	x,#65437
4353  014c 2e07          	jrsge	L7462
4354                     ; 93 					CurrentTempValue = -100;
4356  014e aeff9c        	ldw	x,#65436
4357  0151 bf05          	ldw	L5352_CurrentTempValue,x
4359  0153 200d          	jra	L1262
4360  0155               L7462:
4361                     ; 97 					if(CurrentTempValue > 1000)
4363  0155 9c            	rvf
4364  0156 be05          	ldw	x,L5352_CurrentTempValue
4365  0158 a303e9        	cpw	x,#1001
4366  015b 2f05          	jrslt	L1262
4367                     ; 99 						CurrentTempValue = 1000;
4369  015d ae03e8        	ldw	x,#1000
4370  0160 bf05          	ldw	L5352_CurrentTempValue,x
4371  0162               L1262:
4372                     ; 105 		CurrentTempBkp = (13*CurrentTempBkp + CurrentTempValue*3)>>4;//filter
4374  0162 be05          	ldw	x,L5352_CurrentTempValue
4375  0164 90ae0003      	ldw	y,#3
4376  0168 cd0000        	call	c_imul
4378  016b 1f03          	ldw	(OFST-4,sp),x
4379  016d be03          	ldw	x,L3352_CurrentTempBkp
4380  016f 90ae000d      	ldw	y,#13
4381  0173 cd0000        	call	c_imul
4383  0176 72fb03        	addw	x,(OFST-4,sp)
4384  0179 57            	sraw	x
4385  017a 57            	sraw	x
4386  017b 57            	sraw	x
4387  017c 57            	sraw	x
4388  017d bf03          	ldw	L3352_CurrentTempBkp,x
4389                     ; 106 		CurrentTemp = CurrentTempBkp;//+ CorrectTemp*10;
4391  017f be03          	ldw	x,L3352_CurrentTempBkp
4392  0181 bf00          	ldw	_CurrentTemp,x
4393                     ; 107 		isUpdateDisplay = Yes;
4395  0183 72100000      	bset	_isUpdateDisplay
4396                     ; 110 		sum_AD_value = 0;
4398  0187 5f            	clrw	x
4399  0188 bf01          	ldw	L1352_sum_AD_value,x
4400  018a               L7062:
4401                     ; 112 }
4402  018a               L21:
4405  018a 5b07          	addw	sp,#7
4406  018c 81            	ret
4431                     	xdef	_tempTable
4432                     	xref	_ADC1_GetFlagStatus
4433                     	xref	_ADC1_GetConversionValue
4434                     	xref.b	_CurrentTemp
4435                     	xref.b	_MachineStatus
4436                     	xbit	_isUpdateDisplay
4437                     	xdef	__AD_temperature
4438                     	xdef	__ADC_Initial
4439                     	xref.b	c_lreg
4440                     	xref.b	c_x
4441                     	xref.b	c_y
4460                     	xref	c_imul
4461                     	xref	c_ladc
4462                     	xref	c_cmulx
4463                     	xref	c_ldiv
4464                     	xref	c_rtol
4465                     	xref	c_uitolx
4466                     	xref	c_umul
4467                     	end
