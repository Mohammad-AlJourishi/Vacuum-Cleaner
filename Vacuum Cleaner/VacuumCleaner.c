// ultrasonice : Trigger on RC3 ,, Echo on RC4
// motor right and left , RD0 RD1 RD2 RD3 FOR Direction , and pwm in RC2
// Fan enable pin at RC1




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
      for(cc=0;cc<155;cc++);//1ms
    }
}

void usDelay(unsigned int usCnt)
{
    unsigned int us=0;

    for(us=0;us<usCnt;us++)
    {
      asm NOP;//0.5 uS
      asm NOP;//0.5uS
    }
}





void main() {
       int dis=0;

    TRISC=   0b00010000;
     TRISB = 0b10000000;     //declare as output
      TRISD= 0b00000000;
     T1CON = 0x10;

      CCPPWM_init(void);
     ATD_init(void);                //Initialize Timer Module

      motor2(75);
    while(1){
    v=ATD_read(void);
      speed= (((v>>2)*250)/255);// 0-250
      motor(speed)   ;

      dis=Distance()  ;


      while(dis>20){
      //strat and move front
        dis=Distance()  ;
        if(dis<=15){break;}
        v=ATD_read(void);
        speed= (((v>>2)*250)/255);// 0-250
        motor(speed)   ;
        motor2(75);
        msDelay(500);

        //move front and check distance
        PORTD=0b00001010;
        msDelay(500);
        dis=Distance()  ;
        if(dis<=20){break;}
        msDelay(500);
        dis=Distance()  ;
        if(dis<=20){break;}
        msDelay(500);
        dis=Distance()  ;
        if(dis<=20){break;}
        msDelay(500);
        dis=Distance()  ;
        if(dis<=20){break;}
        v=ATD_read(void);
        speed= (((v>>2)*250)/255);// 0-250
        motor(speed)   ;
        motor2(75);
        msDelay(500);
        dis=Distance()  ;
        if(dis<=20){break;}


        //move right and check distance
        PORTD=0b00001001;
        msDelay(250);
        dis=Distance()  ;
        if(dis<=20){break;}
        msDelay(250);
        dis=Distance()  ;
        if(dis<=20){break;}
        v=ATD_read(void);
        speed= (((v>>2)*250)/255);// 0-250
        motor(speed)   ;
        motor2(75);
        msDelay(250);


        //move front and check distance
        PORTD=0b00001010;
        msDelay(250);
        dis=Distance()  ;
        if(dis<=20){break;}
        msDelay(250);
        dis=Distance()  ;
        if(dis<=20){break;}
        msDelay(250);
        dis=Distance()  ;
        if(dis<=20){break;}
        msDelay(250);
        dis=Distance()  ;
        if(dis<=20){break;}
        msDelay(250);
        dis=Distance()  ;
        if(dis<=20){break;}
        v=ATD_read(void);
        speed= (((v>>2)*250)/255);// 0-250
        motor(speed)   ;
        motor2(75);
        msDelay(250);

         //move left and check distance
        PORTD=0b00000110;
        delay_ms(250);
        dis=Distance()  ;
        if(dis<=20){break;}
        msDelay(250);
        dis=Distance()  ;
        if(dis<=20){break;}
        msDelay(250);
        dis=Distance()  ;
        if(dis<=20){break;}
         msDelay(250);
      }


      //move right until Distance be more than 20cm
      PORTD=0b00001001;
        v=ATD_read(void);
        speed= (((v>>2)*250)/255);// 0-250
        motor(speed)   ;
        motor2(75);

         msDelay(500);


    }
}


void ATD_init(void){
ADCON0=0x41;//ON, Channel 0, Fosc/16== 500KHz, Dont Go
ADCON1=0xCE;// RA0 Analog, others are Digital, Right Allignment,
}


unsigned int ATD_read(void){
         ADCON0=ADCON0 | 0x04;//GO
         while(ADCON0&0x04);//wait until DONE
         return (ADRESH<<8)|ADRESL;

}

int Distance(){
//Trigger on RC3 ,, Echo on RC4

  int dist=5;
TMR1H = 0;                  //Sets the Initial Value of Timer
TMR1L = 0;                  //Sets the Initial Value of Timer

PORTC=PORTC | 0X04;               //TRIGGER HIGH
usDelay(10);               //10uS Delay
PORTC=PORTC & 0B11110111;           //TRIGGER LOW

while(!(PORTC&0b00010000));           //Waiting for Echo
T1CON= T1CON|0b00000001;             //Timer Starts
while(PORTC&0b00010000);            //Waiting for Echo goes LOW
T1CON= T1CON&0b11111110;                //Timer Stops

dist = (TMR1L | (TMR1H<<8));   //Reads Timer Value
dist = dist/58.82;                //Converts Time to Distance
return dist;
}


void CCPPWM_init(void){ //Configure CCP1 and CCP2 at 2ms period with 50% duty cycle
  T2CON =  0b00000111;//enable Timer2 at Fosc/4 with 1:16 prescaler (8 uS percount 2000uS to count 250 counts)
  CCP2CON = 0x0C;//enable PWM for CCP2
  CCP1CON = 0x0C;//enable PWM for CCP1
  PR2 = 250;// 250 counts =8uS *250 =2ms period
  CCPR2L= 0;
  CCPR1L= 0;

}

void motor(unsigned int speed){
      CCPR2L=speed;
}
void motor2(unsigned int speed){
      CCPR1L=speed;
}