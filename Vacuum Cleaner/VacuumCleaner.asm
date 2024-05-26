
_msDelay:

;VacuumCleaner.c,22 :: 		void msDelay(unsigned int msCnt)
;VacuumCleaner.c,24 :: 		unsigned int ms=0;
	CLRF       msDelay_ms_L0+0
	CLRF       msDelay_ms_L0+1
	CLRF       msDelay_cc_L0+0
	CLRF       msDelay_cc_L0+1
;VacuumCleaner.c,26 :: 		for(ms=0;ms<(msCnt);ms++)
	CLRF       msDelay_ms_L0+0
	CLRF       msDelay_ms_L0+1
L_msDelay0:
	MOVF       FARG_msDelay_msCnt+1, 0
	SUBWF      msDelay_ms_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__msDelay37
	MOVF       FARG_msDelay_msCnt+0, 0
	SUBWF      msDelay_ms_L0+0, 0
L__msDelay37:
	BTFSC      STATUS+0, 0
	GOTO       L_msDelay1
;VacuumCleaner.c,28 :: 		for(cc=0;cc<155;cc++);//1ms
	CLRF       msDelay_cc_L0+0
	CLRF       msDelay_cc_L0+1
L_msDelay3:
	MOVLW      0
	SUBWF      msDelay_cc_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__msDelay38
	MOVLW      155
	SUBWF      msDelay_cc_L0+0, 0
L__msDelay38:
	BTFSC      STATUS+0, 0
	GOTO       L_msDelay4
	INCF       msDelay_cc_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       msDelay_cc_L0+1, 1
	GOTO       L_msDelay3
L_msDelay4:
;VacuumCleaner.c,26 :: 		for(ms=0;ms<(msCnt);ms++)
	INCF       msDelay_ms_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       msDelay_ms_L0+1, 1
;VacuumCleaner.c,29 :: 		}
	GOTO       L_msDelay0
L_msDelay1:
;VacuumCleaner.c,30 :: 		}
L_end_msDelay:
	RETURN
; end of _msDelay

_usDelay:

;VacuumCleaner.c,32 :: 		void usDelay(unsigned int usCnt)
;VacuumCleaner.c,34 :: 		unsigned int us=0;
	CLRF       usDelay_us_L0+0
	CLRF       usDelay_us_L0+1
;VacuumCleaner.c,36 :: 		for(us=0;us<usCnt;us++)
	CLRF       usDelay_us_L0+0
	CLRF       usDelay_us_L0+1
L_usDelay6:
	MOVF       FARG_usDelay_usCnt+1, 0
	SUBWF      usDelay_us_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__usDelay40
	MOVF       FARG_usDelay_usCnt+0, 0
	SUBWF      usDelay_us_L0+0, 0
L__usDelay40:
	BTFSC      STATUS+0, 0
	GOTO       L_usDelay7
;VacuumCleaner.c,38 :: 		asm NOP;//0.5 uS
	NOP
;VacuumCleaner.c,39 :: 		asm NOP;//0.5uS
	NOP
;VacuumCleaner.c,36 :: 		for(us=0;us<usCnt;us++)
	INCF       usDelay_us_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       usDelay_us_L0+1, 1
;VacuumCleaner.c,40 :: 		}
	GOTO       L_usDelay6
L_usDelay7:
;VacuumCleaner.c,41 :: 		}
L_end_usDelay:
	RETURN
; end of _usDelay

_main:

;VacuumCleaner.c,47 :: 		void main() {
;VacuumCleaner.c,48 :: 		int dis=0;
	CLRF       main_dis_L0+0
	CLRF       main_dis_L0+1
;VacuumCleaner.c,50 :: 		TRISC=   0b00010000;
	MOVLW      16
	MOVWF      TRISC+0
;VacuumCleaner.c,51 :: 		TRISB = 0b10000000;     //declare as output
	MOVLW      128
	MOVWF      TRISB+0
;VacuumCleaner.c,52 :: 		TRISD= 0b00000000;
	CLRF       TRISD+0
;VacuumCleaner.c,53 :: 		T1CON = 0x10;
	MOVLW      16
	MOVWF      T1CON+0
;VacuumCleaner.c,55 :: 		CCPPWM_init(void);
	CALL       _CCPPWM_init+0
;VacuumCleaner.c,56 :: 		ATD_init(void);                //Initialize Timer Module
	CALL       _ATD_init+0
;VacuumCleaner.c,58 :: 		motor2(75);
	MOVLW      75
	MOVWF      FARG_motor2_speed+0
	MOVLW      0
	MOVWF      FARG_motor2_speed+1
	CALL       _motor2+0
;VacuumCleaner.c,59 :: 		while(1){
L_main9:
;VacuumCleaner.c,60 :: 		v=ATD_read(void);
	CALL       _ATD_read+0
	MOVF       R0+0, 0
	MOVWF      _v+0
	MOVF       R0+1, 0
	MOVWF      _v+1
;VacuumCleaner.c,61 :: 		speed= (((v>>2)*250)/255);// 0-250
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	MOVLW      250
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Mul_16X16_U+0
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _speed+0
	MOVF       R0+1, 0
	MOVWF      _speed+1
;VacuumCleaner.c,62 :: 		motor(speed)   ;
	MOVF       R0+0, 0
	MOVWF      FARG_motor_speed+0
	MOVF       R0+1, 0
	MOVWF      FARG_motor_speed+1
	CALL       _motor+0
;VacuumCleaner.c,64 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,67 :: 		while(dis>20){
L_main11:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_dis_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main42
	MOVF       main_dis_L0+0, 0
	SUBLW      20
L__main42:
	BTFSC      STATUS+0, 0
	GOTO       L_main12
;VacuumCleaner.c,69 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,70 :: 		if(dis<=15){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main43
	MOVF       R0+0, 0
	SUBLW      15
L__main43:
	BTFSS      STATUS+0, 0
	GOTO       L_main13
	GOTO       L_main12
L_main13:
;VacuumCleaner.c,71 :: 		v=ATD_read(void);
	CALL       _ATD_read+0
	MOVF       R0+0, 0
	MOVWF      _v+0
	MOVF       R0+1, 0
	MOVWF      _v+1
;VacuumCleaner.c,72 :: 		speed= (((v>>2)*250)/255);// 0-250
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	MOVLW      250
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Mul_16X16_U+0
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _speed+0
	MOVF       R0+1, 0
	MOVWF      _speed+1
;VacuumCleaner.c,73 :: 		motor(speed)   ;
	MOVF       R0+0, 0
	MOVWF      FARG_motor_speed+0
	MOVF       R0+1, 0
	MOVWF      FARG_motor_speed+1
	CALL       _motor+0
;VacuumCleaner.c,74 :: 		motor2(75);
	MOVLW      75
	MOVWF      FARG_motor2_speed+0
	MOVLW      0
	MOVWF      FARG_motor2_speed+1
	CALL       _motor2+0
;VacuumCleaner.c,75 :: 		msDelay(500);
	MOVLW      244
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      1
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,78 :: 		PORTD=0b00001010;
	MOVLW      10
	MOVWF      PORTD+0
;VacuumCleaner.c,79 :: 		msDelay(500);
	MOVLW      244
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      1
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,80 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,81 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main44
	MOVF       R0+0, 0
	SUBLW      20
L__main44:
	BTFSS      STATUS+0, 0
	GOTO       L_main14
	GOTO       L_main12
L_main14:
;VacuumCleaner.c,82 :: 		msDelay(500);
	MOVLW      244
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      1
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,83 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,84 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main45
	MOVF       R0+0, 0
	SUBLW      20
L__main45:
	BTFSS      STATUS+0, 0
	GOTO       L_main15
	GOTO       L_main12
L_main15:
;VacuumCleaner.c,85 :: 		msDelay(500);
	MOVLW      244
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      1
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,86 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,87 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main46
	MOVF       R0+0, 0
	SUBLW      20
L__main46:
	BTFSS      STATUS+0, 0
	GOTO       L_main16
	GOTO       L_main12
L_main16:
;VacuumCleaner.c,88 :: 		msDelay(500);
	MOVLW      244
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      1
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,89 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,90 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main47
	MOVF       R0+0, 0
	SUBLW      20
L__main47:
	BTFSS      STATUS+0, 0
	GOTO       L_main17
	GOTO       L_main12
L_main17:
;VacuumCleaner.c,91 :: 		v=ATD_read(void);
	CALL       _ATD_read+0
	MOVF       R0+0, 0
	MOVWF      _v+0
	MOVF       R0+1, 0
	MOVWF      _v+1
;VacuumCleaner.c,92 :: 		speed= (((v>>2)*250)/255);// 0-250
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	MOVLW      250
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Mul_16X16_U+0
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _speed+0
	MOVF       R0+1, 0
	MOVWF      _speed+1
;VacuumCleaner.c,93 :: 		motor(speed)   ;
	MOVF       R0+0, 0
	MOVWF      FARG_motor_speed+0
	MOVF       R0+1, 0
	MOVWF      FARG_motor_speed+1
	CALL       _motor+0
;VacuumCleaner.c,94 :: 		motor2(75);
	MOVLW      75
	MOVWF      FARG_motor2_speed+0
	MOVLW      0
	MOVWF      FARG_motor2_speed+1
	CALL       _motor2+0
;VacuumCleaner.c,95 :: 		msDelay(500);
	MOVLW      244
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      1
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,96 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,97 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main48
	MOVF       R0+0, 0
	SUBLW      20
L__main48:
	BTFSS      STATUS+0, 0
	GOTO       L_main18
	GOTO       L_main12
L_main18:
;VacuumCleaner.c,101 :: 		PORTD=0b00001001;
	MOVLW      9
	MOVWF      PORTD+0
;VacuumCleaner.c,102 :: 		msDelay(250);
	MOVLW      250
	MOVWF      FARG_msDelay_msCnt+0
	CLRF       FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,103 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,104 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVF       R0+0, 0
	SUBLW      20
L__main49:
	BTFSS      STATUS+0, 0
	GOTO       L_main19
	GOTO       L_main12
L_main19:
;VacuumCleaner.c,105 :: 		msDelay(250);
	MOVLW      250
	MOVWF      FARG_msDelay_msCnt+0
	CLRF       FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,106 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,107 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVF       R0+0, 0
	SUBLW      20
L__main50:
	BTFSS      STATUS+0, 0
	GOTO       L_main20
	GOTO       L_main12
L_main20:
;VacuumCleaner.c,108 :: 		v=ATD_read(void);
	CALL       _ATD_read+0
	MOVF       R0+0, 0
	MOVWF      _v+0
	MOVF       R0+1, 0
	MOVWF      _v+1
;VacuumCleaner.c,109 :: 		speed= (((v>>2)*250)/255);// 0-250
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	MOVLW      250
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Mul_16X16_U+0
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _speed+0
	MOVF       R0+1, 0
	MOVWF      _speed+1
;VacuumCleaner.c,110 :: 		motor(speed)   ;
	MOVF       R0+0, 0
	MOVWF      FARG_motor_speed+0
	MOVF       R0+1, 0
	MOVWF      FARG_motor_speed+1
	CALL       _motor+0
;VacuumCleaner.c,111 :: 		motor2(75);
	MOVLW      75
	MOVWF      FARG_motor2_speed+0
	MOVLW      0
	MOVWF      FARG_motor2_speed+1
	CALL       _motor2+0
;VacuumCleaner.c,112 :: 		msDelay(250);
	MOVLW      250
	MOVWF      FARG_msDelay_msCnt+0
	CLRF       FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,116 :: 		PORTD=0b00001010;
	MOVLW      10
	MOVWF      PORTD+0
;VacuumCleaner.c,117 :: 		msDelay(250);
	MOVLW      250
	MOVWF      FARG_msDelay_msCnt+0
	CLRF       FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,118 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,119 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVF       R0+0, 0
	SUBLW      20
L__main51:
	BTFSS      STATUS+0, 0
	GOTO       L_main21
	GOTO       L_main12
L_main21:
;VacuumCleaner.c,120 :: 		msDelay(250);
	MOVLW      250
	MOVWF      FARG_msDelay_msCnt+0
	CLRF       FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,121 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,122 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVF       R0+0, 0
	SUBLW      20
L__main52:
	BTFSS      STATUS+0, 0
	GOTO       L_main22
	GOTO       L_main12
L_main22:
;VacuumCleaner.c,123 :: 		msDelay(250);
	MOVLW      250
	MOVWF      FARG_msDelay_msCnt+0
	CLRF       FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,124 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,125 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main53
	MOVF       R0+0, 0
	SUBLW      20
L__main53:
	BTFSS      STATUS+0, 0
	GOTO       L_main23
	GOTO       L_main12
L_main23:
;VacuumCleaner.c,126 :: 		msDelay(250);
	MOVLW      250
	MOVWF      FARG_msDelay_msCnt+0
	CLRF       FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,127 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,128 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main54
	MOVF       R0+0, 0
	SUBLW      20
L__main54:
	BTFSS      STATUS+0, 0
	GOTO       L_main24
	GOTO       L_main12
L_main24:
;VacuumCleaner.c,129 :: 		msDelay(250);
	MOVLW      250
	MOVWF      FARG_msDelay_msCnt+0
	CLRF       FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,130 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,131 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVF       R0+0, 0
	SUBLW      20
L__main55:
	BTFSS      STATUS+0, 0
	GOTO       L_main25
	GOTO       L_main12
L_main25:
;VacuumCleaner.c,132 :: 		v=ATD_read(void);
	CALL       _ATD_read+0
	MOVF       R0+0, 0
	MOVWF      _v+0
	MOVF       R0+1, 0
	MOVWF      _v+1
;VacuumCleaner.c,133 :: 		speed= (((v>>2)*250)/255);// 0-250
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	MOVLW      250
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Mul_16X16_U+0
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _speed+0
	MOVF       R0+1, 0
	MOVWF      _speed+1
;VacuumCleaner.c,134 :: 		motor(speed)   ;
	MOVF       R0+0, 0
	MOVWF      FARG_motor_speed+0
	MOVF       R0+1, 0
	MOVWF      FARG_motor_speed+1
	CALL       _motor+0
;VacuumCleaner.c,135 :: 		motor2(75);
	MOVLW      75
	MOVWF      FARG_motor2_speed+0
	MOVLW      0
	MOVWF      FARG_motor2_speed+1
	CALL       _motor2+0
;VacuumCleaner.c,136 :: 		msDelay(250);
	MOVLW      250
	MOVWF      FARG_msDelay_msCnt+0
	CLRF       FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,139 :: 		PORTD=0b00000110;
	MOVLW      6
	MOVWF      PORTD+0
;VacuumCleaner.c,140 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main26:
	DECFSZ     R13+0, 1
	GOTO       L_main26
	DECFSZ     R12+0, 1
	GOTO       L_main26
	DECFSZ     R11+0, 1
	GOTO       L_main26
	NOP
	NOP
;VacuumCleaner.c,141 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,142 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVF       R0+0, 0
	SUBLW      20
L__main56:
	BTFSS      STATUS+0, 0
	GOTO       L_main27
	GOTO       L_main12
L_main27:
;VacuumCleaner.c,143 :: 		msDelay(250);
	MOVLW      250
	MOVWF      FARG_msDelay_msCnt+0
	CLRF       FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,144 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,145 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVF       R0+0, 0
	SUBLW      20
L__main57:
	BTFSS      STATUS+0, 0
	GOTO       L_main28
	GOTO       L_main12
L_main28:
;VacuumCleaner.c,146 :: 		msDelay(250);
	MOVLW      250
	MOVWF      FARG_msDelay_msCnt+0
	CLRF       FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,147 :: 		dis=Distance()  ;
	CALL       _Distance+0
	MOVF       R0+0, 0
	MOVWF      main_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dis_L0+1
;VacuumCleaner.c,148 :: 		if(dis<=20){break;}
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	MOVF       R0+0, 0
	SUBLW      20
L__main58:
	BTFSS      STATUS+0, 0
	GOTO       L_main29
	GOTO       L_main12
L_main29:
;VacuumCleaner.c,149 :: 		msDelay(250);
	MOVLW      250
	MOVWF      FARG_msDelay_msCnt+0
	CLRF       FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,150 :: 		}
	GOTO       L_main11
L_main12:
;VacuumCleaner.c,154 :: 		PORTD=0b00001001;
	MOVLW      9
	MOVWF      PORTD+0
;VacuumCleaner.c,155 :: 		v=ATD_read(void);
	CALL       _ATD_read+0
	MOVF       R0+0, 0
	MOVWF      _v+0
	MOVF       R0+1, 0
	MOVWF      _v+1
;VacuumCleaner.c,156 :: 		speed= (((v>>2)*250)/255);// 0-250
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	MOVLW      250
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Mul_16X16_U+0
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _speed+0
	MOVF       R0+1, 0
	MOVWF      _speed+1
;VacuumCleaner.c,157 :: 		motor(speed)   ;
	MOVF       R0+0, 0
	MOVWF      FARG_motor_speed+0
	MOVF       R0+1, 0
	MOVWF      FARG_motor_speed+1
	CALL       _motor+0
;VacuumCleaner.c,158 :: 		motor2(75);
	MOVLW      75
	MOVWF      FARG_motor2_speed+0
	MOVLW      0
	MOVWF      FARG_motor2_speed+1
	CALL       _motor2+0
;VacuumCleaner.c,160 :: 		msDelay(500);
	MOVLW      244
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      1
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;VacuumCleaner.c,163 :: 		}
	GOTO       L_main9
;VacuumCleaner.c,164 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_ATD_init:

;VacuumCleaner.c,167 :: 		void ATD_init(void){
;VacuumCleaner.c,168 :: 		ADCON0=0x41;//ON, Channel 0, Fosc/16== 500KHz, Dont Go
	MOVLW      65
	MOVWF      ADCON0+0
;VacuumCleaner.c,169 :: 		ADCON1=0xCE;// RA0 Analog, others are Digital, Right Allignment,
	MOVLW      206
	MOVWF      ADCON1+0
;VacuumCleaner.c,170 :: 		}
L_end_ATD_init:
	RETURN
; end of _ATD_init

_ATD_read:

;VacuumCleaner.c,173 :: 		unsigned int ATD_read(void){
;VacuumCleaner.c,174 :: 		ADCON0=ADCON0 | 0x04;//GO
	BSF        ADCON0+0, 2
;VacuumCleaner.c,175 :: 		while(ADCON0&0x04);//wait until DONE
L_ATD_read30:
	BTFSS      ADCON0+0, 2
	GOTO       L_ATD_read31
	GOTO       L_ATD_read30
L_ATD_read31:
;VacuumCleaner.c,176 :: 		return (ADRESH<<8)|ADRESL;
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;VacuumCleaner.c,178 :: 		}
L_end_ATD_read:
	RETURN
; end of _ATD_read

_Distance:

;VacuumCleaner.c,180 :: 		int Distance(){
;VacuumCleaner.c,183 :: 		int dist=5;
;VacuumCleaner.c,184 :: 		TMR1H = 0;                  //Sets the Initial Value of Timer
	CLRF       TMR1H+0
;VacuumCleaner.c,185 :: 		TMR1L = 0;                  //Sets the Initial Value of Timer
	CLRF       TMR1L+0
;VacuumCleaner.c,187 :: 		PORTC=PORTC | 0X04;               //TRIGGER HIGH
	BSF        PORTC+0, 2
;VacuumCleaner.c,188 :: 		usDelay(10);               //10uS Delay
	MOVLW      10
	MOVWF      FARG_usDelay_usCnt+0
	MOVLW      0
	MOVWF      FARG_usDelay_usCnt+1
	CALL       _usDelay+0
;VacuumCleaner.c,189 :: 		PORTC=PORTC & 0B11110111;           //TRIGGER LOW
	MOVLW      247
	ANDWF      PORTC+0, 1
;VacuumCleaner.c,191 :: 		while(!(PORTC&0b00010000));           //Waiting for Echo
L_Distance32:
	BTFSC      PORTC+0, 4
	GOTO       L_Distance33
	GOTO       L_Distance32
L_Distance33:
;VacuumCleaner.c,192 :: 		T1CON= T1CON|0b00000001;             //Timer Starts
	BSF        T1CON+0, 0
;VacuumCleaner.c,193 :: 		while(PORTC&0b00010000);            //Waiting for Echo goes LOW
L_Distance34:
	BTFSS      PORTC+0, 4
	GOTO       L_Distance35
	GOTO       L_Distance34
L_Distance35:
;VacuumCleaner.c,194 :: 		T1CON= T1CON&0b11111110;                //Timer Stops
	MOVLW      254
	ANDWF      T1CON+0, 1
;VacuumCleaner.c,196 :: 		dist = (TMR1L | (TMR1H<<8));   //Reads Timer Value
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;VacuumCleaner.c,197 :: 		dist = dist/58.82;                //Converts Time to Distance
	CALL       _int2double+0
	MOVLW      174
	MOVWF      R4+0
	MOVLW      71
	MOVWF      R4+1
	MOVLW      107
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _double2int+0
;VacuumCleaner.c,198 :: 		return dist;
;VacuumCleaner.c,199 :: 		}
L_end_Distance:
	RETURN
; end of _Distance

_CCPPWM_init:

;VacuumCleaner.c,202 :: 		void CCPPWM_init(void){ //Configure CCP1 and CCP2 at 2ms period with 50% duty cycle
;VacuumCleaner.c,203 :: 		T2CON =  0b00000111;//enable Timer2 at Fosc/4 with 1:16 prescaler (8 uS percount 2000uS to count 250 counts)
	MOVLW      7
	MOVWF      T2CON+0
;VacuumCleaner.c,204 :: 		CCP2CON = 0x0C;//enable PWM for CCP2
	MOVLW      12
	MOVWF      CCP2CON+0
;VacuumCleaner.c,205 :: 		CCP1CON = 0x0C;//enable PWM for CCP1
	MOVLW      12
	MOVWF      CCP1CON+0
;VacuumCleaner.c,206 :: 		PR2 = 250;// 250 counts =8uS *250 =2ms period
	MOVLW      250
	MOVWF      PR2+0
;VacuumCleaner.c,207 :: 		CCPR2L= 0;
	CLRF       CCPR2L+0
;VacuumCleaner.c,208 :: 		CCPR1L= 0;
	CLRF       CCPR1L+0
;VacuumCleaner.c,210 :: 		}
L_end_CCPPWM_init:
	RETURN
; end of _CCPPWM_init

_motor:

;VacuumCleaner.c,212 :: 		void motor(unsigned int speed){
;VacuumCleaner.c,213 :: 		CCPR2L=speed;
	MOVF       FARG_motor_speed+0, 0
	MOVWF      CCPR2L+0
;VacuumCleaner.c,214 :: 		}
L_end_motor:
	RETURN
; end of _motor

_motor2:

;VacuumCleaner.c,215 :: 		void motor2(unsigned int speed){
;VacuumCleaner.c,216 :: 		CCPR1L=speed;
	MOVF       FARG_motor2_speed+0, 0
	MOVWF      CCPR1L+0
;VacuumCleaner.c,217 :: 		}
L_end_motor2:
	RETURN
; end of _motor2
