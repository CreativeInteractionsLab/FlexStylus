//http://www.helixsoft.nl/articles/circle/sincos.htm
//Serial Comms
import processing.serial.*;
Serial myPort;
int[] serialInArray = new int[3];
int serialCount;
boolean firstContact = false;
int portNum = 0; // may need to change depending on which port you're using

//Cursor
float xpos, ypos;
cursorX flexCursor;

//Menu items
menuItem menuItem01;
float[] menuItemPosX = new float[8];
float[] menuItemPosY = new float[8];
float radius = 100;
float angle = 0;
float angle_stepsize = 0.785;
float centerScreenX;
float centerScreenY;

//Bend Movement
int increaseMagnitudeX = 1;
int increaseMagnitudeY = 1;

void setup()
{
  size(1024,1024);
  
  //String portName = Serial.list()[portNum];
 // myPort = new Serial(this, portName, 9600);
  
  xpos = width/2;
  ypos = height/2;
  
  increaseMagnitudeX = width/255;
  increaseMagnitudeY = height/255;
  
  flexCursor = new cursorX();
  
  //menu item setup
  menuItem01 = new menuItem();
  centerScreenX = width/2;
  centerScreenY = height/2;
  
  for (int i = 0; i == menuItemPosX.length; i++)
  {
    
      menuItemPosX[i] = radius * cos(angle);
      menuItemPosY[i] = radius * sin(angle);
      angle += angle_stepsize;
    
    ellipseMode(CENTER);
    ellipse(menuItemPosX[i], menuItemPosY[i], 50, 50);
  }
  println(menuItemPosX.length);

}

void draw()
{
  background(255, 204, 0);
  flexCursor.moveShape(xpos, ypos);

  menuItem01.drawShape(100,100);
  flexCursor.drawShape();
  
    for (int i = 0; i < menuItemPosX.length; i++)
  {
    if(angle < 2*PI)
    {
      menuItemPosX[i] = radius * cos(angle) + centerScreenX;
      menuItemPosY[i] = radius * sin(angle) + centerScreenY;
      angle += angle_stepsize;
    }
    ellipseMode(CENTER);
    fill(0,0,0);
    ellipse(menuItemPosX[i], menuItemPosY[i], 10, 10);
  }
 
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