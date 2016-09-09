   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3867                     ; 8 main()
3867                     ; 9 {
3869                     	switch	.text
3870  0000               _main:
3872  0000 88            	push	a
3873       00000001      OFST:	set	1
3876                     ; 10 	uchar time_CNT_M = 0;
3878  0001 0f01          	clr	(OFST+0,sp)
3879                     ; 11 	_configSet();
3881  0003 cd0000        	call	__configSet
3883                     ; 12 	_timer2_Initial();
3885  0006 cd0000        	call	__timer2_Initial
3887                     ; 13 	_timerBaseInitial();
3889  0009 cd0000        	call	__timerBaseInitial
3891                     ; 14 	_EEPROM_Initial();
3893  000c cd0000        	call	__EEPROM_Initial
3895                     ; 15 	_ADC_Initial();
3897  000f cd0000        	call	__ADC_Initial
3899                     ; 16 	_IOInitial();
3901  0012 cd0000        	call	__IOInitial
3903  0015               L3152:
3904                     ; 27 		_displayAndKeyscan();
3906  0015 cd0000        	call	__displayAndKeyscan
3908                     ; 28 		_timerBase();
3910  0018 cd0000        	call	__timerBase
3912                     ; 30 		if(isTimeProcess)
3914                     	btst	_isTimeProcess
3915  0020 24f3          	jruge	L3152
3916                     ; 32 			isTimeProcess = No;
3918  0022 72110000      	bres	_isTimeProcess
3919                     ; 33 			_output();
3921  0026 cd0000        	call	__output
3923                     ; 34 			_timerWheel();
3925  0029 cd0000        	call	__timerWheel
3927                     ; 35 			_displayDecode();
3929  002c cd0000        	call	__displayDecode
3931                     ; 36 			_keyScanProcess();
3933  002f cd0000        	call	__keyScanProcess
3935                     ; 37 			if(++time_CNT_M > 15)
3937  0032 0c01          	inc	(OFST+0,sp)
3938  0034 7b01          	ld	a,(OFST+0,sp)
3939  0036 a110          	cp	a,#16
3940  0038 25db          	jrult	L3152
3941                     ; 39 				time_CNT_M = 0;
3943  003a 0f01          	clr	(OFST+0,sp)
3944                     ; 40 				_AD_temperature();
3946  003c cd0000        	call	__AD_temperature
3948  003f 20d4          	jra	L3152
3961                     	xdef	_main
3962                     	xbit	_isTimeProcess
3963                     	xref	__output
3964                     	xref	__AD_temperature
3965                     	xref	__ADC_Initial
3966                     	xref	__EEPROM_Initial
3967                     	xref	__configSet
3968                     	xref	__timerBase
3969                     	xref	__timerWheel
3970                     	xref	__timer2_Initial
3971                     	xref	__timerBaseInitial
3972                     	xref	__keyScanProcess
3973                     	xref	__displayDecode
3974                     	xref	__displayAndKeyscan
3975                     	xref	__IOInitial
3994                     	end
