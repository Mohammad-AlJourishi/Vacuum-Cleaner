#line 1 "C:/Users/Moham/OneDrive/Desktop/Vacuum Cleaner/VacuumCleaner.c"







void motor2(unsigned int speed);
void ATD_init(void);
unsigned int ATD_read(void);
void CCPPWM_init(void);
void motor(unsigned int speed) ;
int Distance();
unsigned int speed;

unsigned int v;





void msDelay(unsigned int msCnt)
{
 unsigned int ms=0;
 unsigned int cc=0;
 for(ms=0;ms<(msCnt);ms++)
 {
 for(cc=0;cc<155;cc++);
 }
}

void usDelay(unsigned int usCnt)
{
 unsigned int us=0;

 for(us=0;us<usCnt;us++)
 {
 asm NOP;
 asm NOP;
 }
}





void main() {
 int dis=0;

 TRISC= 0b00010000;
 TRISB = 0b10000000;
 TRISD= 0b00000000;
 T1CON = 0x10;

 CCPPWM_init(void);
 ATD_init(void);

 motor2(75);
 while(1){
 v=ATD_read(void);
 speed= (((v>>2)*250)/255);
 motor(speed) ;

 dis=Distance() ;


 while(dis>20){

 dis=Distance() ;
 if(dis<=15){break;}
 v=ATD_read(void);
 speed= (((v>>2)*250)/255);
 motor(speed) ;
 motor2(75);
 msDelay(500);


 PORTD=0b00001010;
 msDelay(500);
 dis=Distance() ;
 if(dis<=20){break;}
 msDelay(500);
 dis=Distance() ;
 if(dis<=20){break;}
 msDelay(500);
 dis=Distance() ;
 if(dis<=20){break;}
 msDelay(500);
 dis=Distance() ;
 if(dis<=20){break;}
 v=ATD_read(void);
 speed= (((v>>2)*250)/255);
 motor(speed) ;
 motor2(75);
 msDelay(500);
 dis=Distance() ;
 if(dis<=20){break;}



 PORTD=0b00001001;
 msDelay(250);
 dis=Distance() ;
 if(dis<=20){break;}
 msDelay(250);
 dis=Distance() ;
 if(dis<=20){break;}
 v=ATD_read(void);
 speed= (((v>>2)*250)/255);
 motor(speed) ;
 motor2(75);
 msDelay(250);



 PORTD=0b00001010;
 msDelay(250);
 dis=Distance() ;
 if(dis<=20){break;}
 msDelay(250);
 dis=Distance() ;
 if(dis<=20){break;}
 msDelay(250);
 dis=Distance() ;
 if(dis<=20){break;}
 msDelay(250);
 dis=Distance() ;
 if(dis<=20){break;}
 msDelay(250);
 dis=Distance() ;
 if(dis<=20){break;}
 v=ATD_read(void);
 speed= (((v>>2)*250)/255);
 motor(speed) ;
 motor2(75);
 msDelay(250);


 PORTD=0b00000110;
 delay_ms(250);
 dis=Distance() ;
 if(dis<=20){break;}
 msDelay(250);
 dis=Distance() ;
 if(dis<=20){break;}
 msDelay(250);
 dis=Distance() ;
 if(dis<=20){break;}
 msDelay(250);
 }



 PORTD=0b00001001;
 v=ATD_read(void);
 speed= (((v>>2)*250)/255);
 motor(speed) ;
 motor2(75);

 msDelay(500);


 }
}


void ATD_init(void){
ADCON0=0x41;
ADCON1=0xCE;
}


unsigned int ATD_read(void){
 ADCON0=ADCON0 | 0x04;
 while(ADCON0&0x04);
 return (ADRESH<<8)|ADRESL;

}

int Distance(){


 int dist=5;
TMR1H = 0;
TMR1L = 0;

PORTC=PORTC | 0X04;
usDelay(10);
PORTC=PORTC & 0B11110111;

while(!(PORTC&0b00010000));
T1CON= T1CON|0b00000001;
while(PORTC&0b00010000);
T1CON= T1CON&0b11111110;

dist = (TMR1L | (TMR1H<<8));
dist = dist/58.82;
return dist;
}


void CCPPWM_init(void){
 T2CON = 0b00000111;
 CCP2CON = 0x0C;
 CCP1CON = 0x0C;
 PR2 = 250;
 CCPR2L= 0;
 CCPR1L= 0;

}

void motor(unsigned int speed){
 CCPR2L=speed;
}
void motor2(unsigned int speed){
 CCPR1L=speed;
}
