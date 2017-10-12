/******************************************************************************
Heart_Rate_Display.ino
Demo Program for AD8232 Heart Rate sensor.
Casey Kuhns @ SparkFun Electronics
6/27/2014
https://github.com/sparkfun/AD8232_Heart_Rate_Monitor
The AD8232 Heart Rate sensor is a low cost EKG/ECG sensor.  This example shows
how to create an ECG with real time display.  The display is using Processing.
This sketch is based heavily on the Graphing Tutorial provided in the Arduino
IDE. http://www.arduino.cc/en/Tutorial/Graph
Resources:
This program requires a Processing sketch to view the data in real time.
Development environment specifics:
  IDE: Arduino 1.0.5
  Hardware Platform: Arduino Pro 3.3V/8MHz
  AD8232 Heart Monitor Version: 1.0
This code is beerware. If you see me (or any other SparkFun employee) at the
local pub, and you've found our code helpful, please buy us a round!
Distributed as-is; no warranty is given.
Modificato By Peppe Ultima modifica in data: 19/05/2017
******************************************************************************/

import processing.serial.*;


Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph
float height_old = 0;
float height_new = 0;
float inByte = 0;
//bottone salva
float xb = 1400;
float yb = 870;
float wb = 80;
float hb = 50;
int tempo;
int attesa = 10000;
int bpm;
int bpmfinali;
int bpmstandard = 6;
//PImage bg;
void setup () {
  // set the window size:
  size(1500, 950);        
  // List all the available serial ports
  println(Serial.list());
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[1], 9600);
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  // set inital backgroun//:
  background(0x000000);
  tempo = millis();
 // bg = loadImage("bg.png");
 // background(bg);
}


void draw () {
  int d = day();    // Values from 1 - 31
  int m = month();  // Values from 1 - 12
  int y = year();   // 2003, 2004, 2005, etc.
  int s = second();  // Values from 0 - 59
  int min = minute();  // Values from 0 - 59
  int h = hour();    // Values from 0 - 23
  String da = str(d);
  String mo = str(m);
  String ye = str(y);
  String se = str(s);
  String mi = str(min);
  String ho = str(h);
  String data = da + mo + ye + ho + mi + se;
  rect(xb,yb,wb,hb);
  fill(255);
   if(mousePressed){
  if(mouseX>xb && mouseX <xb+wb && mouseY>yb && mouseY <yb+hb){
    save(data);
  }
 }
      if (height_old < 150) {
      bpm = bpm + 1; 
     }
 if ( millis() - tempo >= attesa){
 bpmfinali = bpm * bpmstandard;
 print(bpmfinali);
 text(bpmfinali, 800, 350);
 bpm= 0;
 tempo = millis(); 
 }
}


void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
      stroke(0, 135, 0); //Set stroke to green ( R, G, B)
      inByte = float(inString); 
     //Map and draw the line for new data point
     inByte = map(inByte, 0, 1150, 0, height);
     height_new = height - inByte; 
     line(xPos - 1, height_old, xPos, height_new);
     height_old = height_new;
    
      // at the edge of the screen, go back to the beginning:
      if (xPos >= width) {
        xPos = 0;
       // background(bg);
        background(0x000000);
      } 
      else {
        // increment the horizontal position:
        xPos++;
      }
      //image(tracciato, 0, 0);
  }
}
