// Author : Brendan Horan
// Licence : BSD 3-Clause
// Arduino-IRremote Licence : GNU LESSER GENERAL PUBLIC LICENCE Version 2.1
// Version : 0.0.1
//
// DOCUMENT NEC hex values bettter!


#include <IRremote.h>
IRsend irsend;

// Variable to hold incoming serial comms
int ctlmsg = 0;   

// Define Power controler pin
pindMode(4,OUTPUT)

void setup() {
        Serial.begin(9600);     
        Serial.println ("Connected:9600");
        Serial.println ("OK");
}

void loop() {

        // wait for data
        if (Serial.available() > 0) {
                // read data 
                ctlmsg = Serial.read();

               // send IR signal based on value from ir-blower server
               // 49 = dev 1, btn1 (rubyval, 1)
               // 54 = dev 2, btn3 (rubyval, 6)
               
                switch (ctlmsg) {
                  case 49:
                    Serial.print("49");
                    // Master 9 input select +
                    irsend.sendNEC(0x1FE01FE,32);
                    delay(100);
                    break;
                  case 50:
                    Serial.print("50");
                    // Master 9 input select -
                    irsend.sendNEC(0x1FE21DE,32);
                    delay(100);
                    break;
                  case 51:
                    Serial.print("51");
                    // Master 9 Mute
                    irsend.sendNEC(0x1FE11EE,32);
                    delay(100);
                    break;
                  case 52:
                    Serial.print("52");
                    // Master 9 vol +
                    irsend.sendNEC(0x1FE31CE,32);
                   delay(100);
                    break;
                  case 53:
                    Serial.print("53");
                    // Master 9 vol -
                    irsend.sendNEC(0x1FE09F6,32);
                    delay(100);
                    break;
                  case 54:
                    Serial.print("54");
                    // Ref 5.32 USB input
                    irsend.sendNEC(0x12ED906F,32);
                    delay(100);
                    break;
                  case 55:
                    Serial.print("55");
                    // Ref 5.32 coaxial 2
                    irsend.sendNEC(0x12EDB04F,32);
                    delay(100);
                    break;
                  case 56:
                    Serial.print("56");
                    // Ref 5.32 coaxial 3
                    irsend.sendNEC(0x12ED58A7,32);
                    delay(100);
                    break;
                  case 57:
                    Serial.print("57");
                    // Ref 5.32 optical 4
                    irsend.sendNEC(0x12ED807F,32);
                    delay(100);
                    break;
                  case 58:
                    Serial.print("58");
                    // Ref 5.32 optical 5
                    irsend.sendNEC(0x12ED00FF,32);
                    delay(100);
                    break;
                  case 59:
                    Serial.print("59");
                    // Ref 5.32 Gain high/low
                    irsend.sendNEC(0x12ED40BF,32);
                    delay(100);
                    break;
                  case 60:
                    Serial.print("60");
                    // Master 9 power control
                    digitalWrite(4,HIGH);
                    delay(500)
                    digitalWrite(4,LOW);
                    break;
                }
               
        }
}
