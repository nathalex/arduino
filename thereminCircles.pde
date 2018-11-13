/*
edited from SimpleRead example code
*/
import processing.serial.*;

Serial myPort;  // Create object from Serial class
String ew, portName;      // Data received from the serial port
int Volume, Tone, Meter;  //values returned by arduino, radiuses of the circles

void setup() 
{
  //set background to black
  background(0);
  size(900,300);
  frameRate(30);
  ellipseMode(CENTER);
  portName = Serial.list()[2];
  //portName is "/dev/cu.usbmodemFA131" on this mac
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
}

void serialEvent(Serial myPort) 
{
  String ew = myPort.readStringUntil('\n');
  println(ew);
  if (ew !=null) {
    String[] splitVal = ew.split(":"); //splitVal[1] = "1500hz....
    Tone = Integer.parseInt(splitVal[1].split("h")[0]);//Tone = 1500 for example
    Volume = Integer.parseInt(splitVal[2].split(",")[0]);
    Meter = Integer.parseInt(splitVal[3].split("b")[0]);
  }
}

void draw()
{
  if(myPort.available() > 0)
  {
    //clear the old screen before we make more circles
    clear();
    
    fill(255, 0, 0);//makes the volume circle red
    ellipse(150,150,Volume,Volume);
  
    fill(0, 255, 0);//makes the tone circle green
    ellipse(450,150,Tone/10,Tone/10);//values in Hz are particularly large, so we scale them
      
    fill(0, 0, 255);//makes the meter circle blue
    ellipse(750,150,Meter,Meter);
  }
}
