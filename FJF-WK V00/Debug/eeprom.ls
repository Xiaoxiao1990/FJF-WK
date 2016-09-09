   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3872                     ; 9 void chardatacheck(uchar *data,uchar low,uchar high)
3872                     ; 10 {
3874                     	switch	.text
3875  0000               _chardatacheck:
3877  0000 89            	pushw	x
3878       00000000      OFST:	set	0
3881                     ; 11 	if(*data > high)*data = high;
3883  0001 f6            	ld	a,(x)
3884  0002 1106          	cp	a,(OFST+6,sp)
3885  0004 2305          	jrule	L3252
3888  0006 7b06          	ld	a,(OFST+6,sp)
3889  0008 1e01          	ldw	x,(OFST+1,sp)
3890  000a f7            	ld	(x),a
3891  000b               L3252:
3892                     ; 12 	if(*data < low)*data = low;
3894  000b 1e01          	ldw	x,(OFST+1,sp)
3895  000d f6            	ld	a,(x)
3896  000e 1105          	cp	a,(OFST+5,sp)
3897  0010 2405          	jruge	L5252
3900  0012 7b05          	ld	a,(OFST+5,sp)
3901  0014 1e01          	ldw	x,(OFST+1,sp)
3902  0016 f7            	ld	(x),a
3903  0017               L5252:
3904                     ; 13 }
3907  0017 85            	popw	x
3908  0018 81            	ret
3961                     ; 15 void intdatacheck(signed int *data,signed int low,signed int high)
3961                     ; 16 {
3962                     	switch	.text
3963  0019               _intdatacheck:
3965  0019 89            	pushw	x
3966       00000000      OFST:	set	0
3969                     ; 17 	if(*data > high)*data = high;
3971  001a 9c            	rvf
3972  001b 9093          	ldw	y,x
3973  001d 51            	exgw	x,y
3974  001e fe            	ldw	x,(x)
3975  001f 1307          	cpw	x,(OFST+7,sp)
3976  0021 51            	exgw	x,y
3977  0022 2d03          	jrsle	L5552
3980  0024 1607          	ldw	y,(OFST+7,sp)
3981  0026 ff            	ldw	(x),y
3982  0027               L5552:
3983                     ; 18 	if(*data < low)*data = low;
3985  0027 9c            	rvf
3986  0028 1e01          	ldw	x,(OFST+1,sp)
3987  002a 9093          	ldw	y,x
3988  002c 51            	exgw	x,y
3989  002d fe            	ldw	x,(x)
3990  002e 1305          	cpw	x,(OFST+5,sp)
3991  0030 51            	exgw	x,y
3992  0031 2e05          	jrsge	L7552
3995  0033 1e01          	ldw	x,(OFST+1,sp)
3996  0035 1605          	ldw	y,(OFST+5,sp)
3997  0037 ff            	ldw	(x),y
3998  0038               L7552:
3999                     ; 19 }
4002  0038 85            	popw	x
4003  0039 81            	ret
4047                     ; 21 void _EEPROM_Initial(void)
4047                     ; 22 {
4048                     	switch	.text
4049  003a               __EEPROM_Initial:
4051  003a 88            	push	a
4052       00000001      OFST:	set	1
4055                     ; 25 	temp = FLASH_ReadByte(EEPROM_CODE_ADDR);
4057  003b ae4000        	ldw	x,#16384
4058  003e 89            	pushw	x
4059  003f ae0000        	ldw	x,#0
4060  0042 89            	pushw	x
4061  0043 cd0000        	call	_FLASH_ReadByte
4063  0046 5b04          	addw	sp,#4
4064  0048 6b01          	ld	(OFST+0,sp),a
4065                     ; 26 	if (temp == EEPROM_CODE)
4067  004a 7b01          	ld	a,(OFST+0,sp)
4068  004c a1aa          	cp	a,#170
4069  004e 2656          	jrne	L3062
4070                     ; 29 		SetTemp = FLASH_ReadByte(DATA_ADDR)<<8;
4072  0050 ae4002        	ldw	x,#16386
4073  0053 89            	pushw	x
4074  0054 ae0000        	ldw	x,#0
4075  0057 89            	pushw	x
4076  0058 cd0000        	call	_FLASH_ReadByte
4078  005b 5b04          	addw	sp,#4
4079  005d 5f            	clrw	x
4080  005e 97            	ld	xl,a
4081  005f 4f            	clr	a
4082  0060 02            	rlwa	x,a
4083  0061 bf00          	ldw	_SetTemp,x
4084                     ; 30 		SetTemp += FLASH_ReadByte(DATA_ADDR+1);
4086  0063 ae4003        	ldw	x,#16387
4087  0066 89            	pushw	x
4088  0067 ae0000        	ldw	x,#0
4089  006a 89            	pushw	x
4090  006b cd0000        	call	_FLASH_ReadByte
4092  006e 5b04          	addw	sp,#4
4093  0070 bb01          	add	a,_SetTemp+1
4094  0072 b701          	ld	_SetTemp+1,a
4095  0074 2402          	jrnc	L21
4096  0076 3c00          	inc	_SetTemp
4097  0078               L21:
4098                     ; 32 		intdatacheck(&SetTemp,300,900);
4100  0078 ae0384        	ldw	x,#900
4101  007b 89            	pushw	x
4102  007c ae012c        	ldw	x,#300
4103  007f 89            	pushw	x
4104  0080 ae0000        	ldw	x,#_SetTemp
4105  0083 ad94          	call	_intdatacheck
4107  0085 5b04          	addw	sp,#4
4108                     ; 34 		WorkTime = FLASH_ReadByte(DATA_ADDR+2);
4110  0087 ae4004        	ldw	x,#16388
4111  008a 89            	pushw	x
4112  008b ae0000        	ldw	x,#0
4113  008e 89            	pushw	x
4114  008f cd0000        	call	_FLASH_ReadByte
4116  0092 5b04          	addw	sp,#4
4117  0094 b700          	ld	_WorkTime,a
4118                     ; 36 		chardatacheck(&WorkTime,30,99);
4120  0096 4b63          	push	#99
4121  0098 4b1e          	push	#30
4122  009a ae0000        	ldw	x,#_WorkTime
4123  009d cd0000        	call	_chardatacheck
4125  00a0 85            	popw	x
4126                     ; 37 		WorkTimeBkp = WorkTime;
4128  00a1 450000        	mov	_WorkTimeBkp,_WorkTime
4130  00a4               L1062:
4131                     ; 57 }
4134  00a4 84            	pop	a
4135  00a5 81            	ret
4136  00a6               L3062:
4137                     ; 43 			FLASH_Unlock(FLASH_MEMTYPE_DATA);
4139  00a6 a6f7          	ld	a,#247
4140  00a8 cd0000        	call	_FLASH_Unlock
4142                     ; 44 		}while(FLASH_GetFlagStatus(FLASH_FLAG_DUL) == 0);
4144  00ab a608          	ld	a,#8
4145  00ad cd0000        	call	_FLASH_GetFlagStatus
4147  00b0 4d            	tnz	a
4148  00b1 27f3          	jreq	L3062
4149                     ; 46 		FLASH_ProgramByte(EEPROM_CODE_ADDR, EEPROM_CODE);
4151  00b3 4baa          	push	#170
4152  00b5 ae4000        	ldw	x,#16384
4153  00b8 89            	pushw	x
4154  00b9 ae0000        	ldw	x,#0
4155  00bc 89            	pushw	x
4156  00bd cd0000        	call	_FLASH_ProgramByte
4158  00c0 5b05          	addw	sp,#5
4159                     ; 48 		SetTemp = 40;
4161  00c2 ae0028        	ldw	x,#40
4162  00c5 bf00          	ldw	_SetTemp,x
4163                     ; 49 		WorkTime = 60;
4165  00c7 353c0000      	mov	_WorkTime,#60
4166                     ; 50 		FLASH_ProgramByte(DATA_ADDR,SetTemp>>8);
4168  00cb 3b0000        	push	_SetTemp
4169  00ce ae4002        	ldw	x,#16386
4170  00d1 89            	pushw	x
4171  00d2 ae0000        	ldw	x,#0
4172  00d5 89            	pushw	x
4173  00d6 cd0000        	call	_FLASH_ProgramByte
4175  00d9 5b05          	addw	sp,#5
4176                     ; 51 		FLASH_ProgramByte(DATA_ADDR+1,SetTemp&0xff);
4178  00db b601          	ld	a,_SetTemp+1
4179  00dd a4ff          	and	a,#255
4180  00df 88            	push	a
4181  00e0 ae4003        	ldw	x,#16387
4182  00e3 89            	pushw	x
4183  00e4 ae0000        	ldw	x,#0
4184  00e7 89            	pushw	x
4185  00e8 cd0000        	call	_FLASH_ProgramByte
4187  00eb 5b05          	addw	sp,#5
4188                     ; 52 		FLASH_ProgramByte(DATA_ADDR+2,WorkTime);
4190  00ed 3b0000        	push	_WorkTime
4191  00f0 ae4004        	ldw	x,#16388
4192  00f3 89            	pushw	x
4193  00f4 ae0000        	ldw	x,#0
4194  00f7 89            	pushw	x
4195  00f8 cd0000        	call	_FLASH_ProgramByte
4197  00fb 5b05          	addw	sp,#5
4199  00fd               L3162:
4200                     ; 53 		while(FLASH_GetFlagStatus(FLASH_FLAG_EOP) == 0);
4202  00fd a604          	ld	a,#4
4203  00ff cd0000        	call	_FLASH_GetFlagStatus
4205  0102 4d            	tnz	a
4206  0103 27f8          	jreq	L3162
4207                     ; 55 		FLASH_Lock(FLASH_MEMTYPE_DATA);
4209  0105 a6f7          	ld	a,#247
4210  0107 cd0000        	call	_FLASH_Lock
4212  010a 2098          	jra	L1062
4254                     ; 59 void _EEPROM_saveSettings(void)
4254                     ; 60 {
4255                     	switch	.text
4256  010c               __EEPROM_saveSettings:
4258  010c 88            	push	a
4259       00000001      OFST:	set	1
4262                     ; 61 	uchar temp = 0;
4264  010d 0f01          	clr	(OFST+0,sp)
4265  010f               L5362:
4266                     ; 64 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
4268  010f a6f7          	ld	a,#247
4269  0111 cd0000        	call	_FLASH_Unlock
4271                     ; 65 	}while(FLASH_GetFlagStatus(FLASH_FLAG_DUL) == 0);
4273  0114 a608          	ld	a,#8
4274  0116 cd0000        	call	_FLASH_GetFlagStatus
4276  0119 4d            	tnz	a
4277  011a 27f3          	jreq	L5362
4278                     ; 67 	FLASH_ProgramByte(DATA_ADDR,SetTemp>>8);
4280  011c 3b0000        	push	_SetTemp
4281  011f ae4002        	ldw	x,#16386
4282  0122 89            	pushw	x
4283  0123 ae0000        	ldw	x,#0
4284  0126 89            	pushw	x
4285  0127 cd0000        	call	_FLASH_ProgramByte
4287  012a 5b05          	addw	sp,#5
4288                     ; 68 	FLASH_ProgramByte(DATA_ADDR+1,SetTemp&0xff);
4290  012c b601          	ld	a,_SetTemp+1
4291  012e a4ff          	and	a,#255
4292  0130 88            	push	a
4293  0131 ae4003        	ldw	x,#16387
4294  0134 89            	pushw	x
4295  0135 ae0000        	ldw	x,#0
4296  0138 89            	pushw	x
4297  0139 cd0000        	call	_FLASH_ProgramByte
4299  013c 5b05          	addw	sp,#5
4300                     ; 69 	FLASH_ProgramByte(DATA_ADDR+2,WorkTime);
4302  013e 3b0000        	push	_WorkTime
4303  0141 ae4004        	ldw	x,#16388
4304  0144 89            	pushw	x
4305  0145 ae0000        	ldw	x,#0
4306  0148 89            	pushw	x
4307  0149 cd0000        	call	_FLASH_ProgramByte
4309  014c 5b05          	addw	sp,#5
4310                     ; 70 	WorkTimeBkp = WorkTime;
4312  014e 450000        	mov	_WorkTimeBkp,_WorkTime
4314  0151               L7462:
4315                     ; 71 	while(FLASH_GetFlagStatus(FLASH_FLAG_EOP) == 0);
4317  0151 a604          	ld	a,#4
4318  0153 cd0000        	call	_FLASH_GetFlagStatus
4320  0156 4d            	tnz	a
4321  0157 27f8          	jreq	L7462
4322                     ; 73 	FLASH_Lock(FLASH_MEMTYPE_DATA);
4324  0159 a6f7          	ld	a,#247
4325  015b cd0000        	call	_FLASH_Lock
4327                     ; 74 }
4330  015e 84            	pop	a
4331  015f 81            	ret
4344                     	xdef	_intdatacheck
4345                     	xdef	_chardatacheck
4346                     	xref	_FLASH_GetFlagStatus
4347                     	xref	_FLASH_ReadByte
4348                     	xref	_FLASH_ProgramByte
4349                     	xref	_FLASH_Lock
4350                     	xref	_FLASH_Unlock
4351                     	xref.b	_WorkTimeBkp
4352                     	xref.b	_WorkTime
4353                     	xref.b	_SetTemp
4354                     	xdef	__EEPROM_saveSettings
4355                     	xdef	__EEPROM_Initial
4374                     	end
