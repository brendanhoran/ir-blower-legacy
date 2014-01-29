// Author  : Brendan Horan
// License : BSD 3-Clause
// Version : 0.0.1



#include <IRremote.h>
IRsend irsend;

// Variable to hold incoming serial comms
int ctlmsg = 0;   

// Define Power controler pin
int pctl = 4;


void setup() {
        pinMode(pctl,OUTPUT);
        digitalWrite(pctl,HIGH);
        Serial.begin(9600);     
        Serial.println ("Connected:9600");
        Serial.println ("OK");
}

void loop() {
  

        // wait for data
        if (Serial.available() > 0) {
                // read data 
                ctlmsg = Serial.read();
                Serial.print (ctlmsg);
                

               // send IR signal based on value from ir-blower server
               // 49 = dev 1, btn1 (rubyval, 1)
               // 97 = dev 2, btn1 (rubyval, a)
               
                switch (ctlmsg) {
                  case 49:
                    // Value 1 
                    // Master 9 input select +
                    irsend.sendNEC(0x1FE01FE,32);
                    delay(100);
                    break;
                  case 50:
                    // Value 2
                    // Master 9 input select -
                    irsend.sendNEC(0x1FE21DE,32);
                    delay(100);
                    break;
                  case 51:
                    // Value 3
                    // Master 9 Mute
                    irsend.sendNEC(0x1FE11EE,32);
                    delay(100);
                    break;
                  case 52:
                    // Value 4
                    // Master 9 vol +
                    irsend.sendNEC(0x1FE31CE,32);
                   delay(100);
                    break;
                  case 53:
                    // Value 5
                    // Master 9 vol -
                    irsend.sendNEC(0x1FE09F6,32);
                    delay(100);
                    break;
                  case 54:
                    // Value 6
                    // Master 9 power control
                    digitalWrite(pctl,LOW);
                    delay(500);
                    digitalWrite(pctl,HIGH);
                    break;
                  case 97:
                    // Value a
                    // Ref 5.32 USB input
                    irsend.sendNEC(0x12ED906F,32);
                    delay(100);
                    break;
                  case 98:
                    // Value b
                    // Ref 5.32 coaxial 2
                    irsend.sendNEC(0x12EDB04F,32);
                    delay(100);
                    break;
                  case 99:
                    // Value c
                    // Ref 5.32 coaxial 3
                    irsend.sendNEC(0x12ED58A7,32);
                    delay(100);
                    break;
                  case 100:
                    // Value d
                    // Ref 5.32 optical 4
                    irsend.sendNEC(0x12ED807F,32);
                    delay(100);
                    break;
                  case 101:
                    // Value e
                    // Ref 5.32 optical 5 
                    irsend.sendNEC(0x12ED00FF,32);
                    delay(100);
                    break;
                  case 102:
                    // Value f
                    // Ref 5.32 Gain high/low
                    irsend.sendNEC(0x12ED40BF,32);
                    delay(100);
                    break;
                }
               
        }
}
