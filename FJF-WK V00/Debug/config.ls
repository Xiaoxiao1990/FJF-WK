   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3856                     ; 3 void _configSet(void)
3856                     ; 4 {
3858                     	switch	.text
3859  0000               __configSet:
3863                     ; 17 	PA_DDR = 0B00001110;
3865  0000 350e5002      	mov	_PA_DDR,#14
3866                     ; 18 	PA_CR1 = 0B00001110;
3868  0004 350e5003      	mov	_PA_CR1,#14
3869                     ; 19 	PA_CR2 = 0B00000000;
3871  0008 725f5004      	clr	_PA_CR2
3872                     ; 20 	PA_ODR = 0B00000000;
3874  000c 725f5000      	clr	_PA_ODR
3875                     ; 22 	PB_DDR = 0B00110000;
3877  0010 35305007      	mov	_PB_DDR,#48
3878                     ; 23 	PB_CR1 = 0B00110000;
3880  0014 35305008      	mov	_PB_CR1,#48
3881                     ; 24 	PB_CR2 = 0B00000000;
3883  0018 725f5009      	clr	_PB_CR2
3884                     ; 25 	PB_ODR = 0B00010000;
3886  001c 35105005      	mov	_PB_ODR,#16
3887                     ; 27 	PC_DDR = 0B11101000;
3889  0020 35e8500c      	mov	_PC_DDR,#232
3890                     ; 28 	PC_CR1 = 0B11101000;
3892  0024 35e8500d      	mov	_PC_CR1,#232
3893                     ; 29 	PC_CR2 = 0B00000000;
3895  0028 725f500e      	clr	_PC_CR2
3896                     ; 30 	PC_ODR = 0B10101000;
3898  002c 35a8500a      	mov	_PC_ODR,#168
3899                     ; 32 	PD_DDR = 0B01010011;
3901  0030 35535011      	mov	_PD_DDR,#83
3902                     ; 33 	PD_CR1 = 0B01111111;
3904  0034 357f5012      	mov	_PD_CR1,#127
3905                     ; 34 	PD_CR2 = 0B00000000;
3907  0038 725f5013      	clr	_PD_CR2
3908                     ; 35 	PD_ODR = 0B00000000;
3910  003c 725f500f      	clr	_PD_ODR
3911                     ; 45 	CLK_SWR = 0xE1; 		//internal clock 16M as main clock
3913  0040 35e150c4      	mov	_CLK_SWR,#225
3914                     ; 46 	CLK_CKDIVR = 0x08;  //fcpu = fmaster = fHSI/2 = 8MHz
3916  0044 350850c6      	mov	_CLK_CKDIVR,#8
3917                     ; 47 }
3920  0048 81            	ret
3933                     	xdef	__configSet
3952                     	end
