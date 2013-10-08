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
                  // 0x80,0x84 = master8 select key
                  //  irsend.sendNEC(0x807f847b,32)
                  //   delay(100);
                    break;
                  case 50:
                    Serial.print("50");
                 // 0x80,0x88 = master8 mute
                 //   irsend.sendNEC(0x807f8877,32)
                 //   delay(100);
                    break;
                  case 51:
                    Serial.print("51");
                 // 0x80,8c = master8 vol+
                 //   irsend.sendNEC(0x807f8c73,32)
                 //   delay(100);
                    break;
                  case 52:
                    Serial.print("52");
                 // 0x80,0x90 = master8 vol_
                 //   irsend.sendNEC(0x807f906f,32)
                 //   delay(100);
                    break;
                  case 53:
                    Serial.print("53");
                 // 0x48,0x0d = NFB17 select1
                 //   irsend.sendNEC(0x48b709f6,32)
                 //   delay(100);
                    break;
                  case 54:
                    Serial.print("54");
                 // 0x48,0x0d = NFB17 select2
                 //   irsend.sendNEC(0x48b70df2,32)
                 //   delay(100);
                    break;
                  case 55:
                    Serial.print("55");
                 // 0x48,0x1a = NFB17 select3
                 // irsend.sendNEC(0x48b71ae5,32)
                    delay(100);
                    break;
                  case 56:
                    Serial.print("56");
                 // 0x48,0x01 = NFB17 select4
                 // irsend.sendNEC(0x48b701fe,32)
                    delay(100);
                    break;
                  case 57:
                    Serial.print("57");
                 // 0x48,0x00 = NFB17 select5
                 // irsend.sendNEC(0x48b700ff,32)
                    delay(100);
                    break;
                }
               
        }
}
