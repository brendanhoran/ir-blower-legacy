// Author : Brendan Horan
// Licence : BSD 3-Clause
// Arduino-IRremote Licence : GNU LESSER GENERAL PUBLIC LICENCE Version 2.1
// Version : 0.0.1

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
                  //  irsend.sendNEC(0x80???,32)
                  //   delay(100);
                    break;
                  case 50:
                    Serial.print("50");
                 //   irsend.sendNEC(0x80???,32)
                 //   delay(100);
                    break;
                  case 51:
                    Serial.print("51");
                 //   irsend.sendNEC(0x80???,32)
                 //   delay(100);
                    break;
                  case 52:
                    Serial.print("52");
                 //   irsend.sendNEC(0x48???,32)
                 //   delay(100);
                    break;
                  case 53:
                    Serial.print("53");
                 //   irsend.sendNEC(0x48???,32)
                 //   delay(100);
                    break;
                  case 54:
                    Serial.print("54");
                 //   irsend.sendNEC(0x48???,32)
                 //   delay(100);
                    break;
                }
               
        }
}
