/*
 *  Version:                1.0
 *  Design:                 Jeff Dillon
 *  Implementation:         Jeff Dillon
 */

#include <WaspWIFI.h>

uint8_t socket=SOCKET0;

#define REMOTE_PORT 33333
#define LOCAL_PORT 2000
#define IP_ADDRESS "xxxx.xxxx.xxxx.xxxx"
#define DELAY_TIME 100

#define ESSID "MyNetwork"
#define AUTHKEY "MyPassword"

char tosend[128]; 
unsigned long time = 0;

void setup()
{ 
  
  ACC.ON(); 
   
  WIFI.ON(socket); 
  USB.println(F("WiFi switched ON"));

  WIFI.setConnectionOptions(CLIENT_SERVER|UDP); 
  WIFI.setDHCPoptions(DHCP_ON);
  WIFI.setJoinMode(MANUAL);   
  WIFI.setAuthKey(WPA1,AUTHKEY);   
  WIFI.storeData();
  
} 

void loop()
{ 
   
  if(WIFI.join(ESSID))
  { 
    USB.println(F("Joined network"));
    
    Utils.setLED(LED1, LED_ON); 

    if (WIFI.setUDPclient(IP_ADDRESS, REMOTE_PORT, LOCAL_PORT))
    { 
      while(1)
      {             
        time = millis();
        sprintf(tosend,"{\"Time\":\"%lu\",\"x\":\"%d\",\"y\":\"%d\",\"z\":\"%d\"}", time, ACC.getX(),ACC.getY(),ACC.getZ());         
        WIFI.send(tosend); 
               
        delay(DELAY_TIME); 
      } 
    }
    else
    {
      USB.println(F("UDP client NOT set"));
    } 
  }
  else
  {
    USB.println(F("Error joining network"));
  } 
} 



