//Serial Comms
import processing.serial.*;
Serial myPort;
int[] serialInArray = new int[3];
int serialCount;
boolean firstContact = false;
int portNum = 0; // may need to change depending on which port you're using

//Circle
float xpos, ypos;
cursorX flexCursor;

//Bend Movement
int increaseMagnitudeX = 1;
int increaseMagnitudeY = 1;

void setup()
{
  size(1024,1024);
  
  String portName = Serial.list()[portNum];
  myPort = new Serial(this, portName, 9600);
  
  xpos = width/2;
  ypos = height/2;
  
  increaseMagnitudeX = width/255;
  increaseMagnitudeY = height/255;
  
  flexCursor = new cursorX();
}

void draw()
{
  background(255, 204, 0);
  flexCursor.moveShape(xpos, ypos);
  flexCursor.drawShape();

 
  //ellipse(xpos + width/2, ypos + height/2, 20, 20);
}

void serialEvent(Serial myPort)
{
  int inByte = myPort.read();
  if (firstContact == false)
  {
    if (inByte == 'A')
    {
      myPort.clear();
      firstContact = true;
      myPort.write('A');
    }
  }
  else
  {
    serialInArray[serialCount] = inByte;
    serialCount++;
    if (serialCount > 2)
    {
      xpos = increaseMagnitudeX * ((serialInArray[0]) - (255/2));
      ypos = increaseMagnitudeY * ((serialInArray[1]) - (255/2));
      println(xpos + "\t" + ypos);
      myPort.write('A');
      serialCount = 0;
    }
  }
}