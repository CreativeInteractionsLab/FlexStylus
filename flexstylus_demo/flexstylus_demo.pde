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
menuItem[] menuItems;
float[] menuItemPosX = new float[8];
float[] menuItemPosY = new float[8];
float radius = 250;
float dist = 50;
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
  
  String portName = Serial.list()[portNum];
  myPort = new Serial(this, portName, 9600);
  
  xpos = width/2;
  ypos = height/2;
  
  increaseMagnitudeX = width/255;
  increaseMagnitudeY = height/255;
  
  flexCursor = new cursorX();
  
  //menu item setup
  menuItems = new menuItem[8];
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
  
  for (int j = 0; j <= 7; j++)
  {
    menuItems[j] = new menuItem();
  }
}

void draw()
{
  background(255, 255, 255);
  flexCursor.moveShape(xpos, ypos);

  flexCursor.drawShape();
  
  for (int k = 0; k < menuItemPosX.length; k++)
  {
    if(angle < 2*PI)
    {
      menuItemPosX[k] = radius * cos(angle) + centerScreenX;
      menuItemPosY[k] = radius * sin(angle) + centerScreenY;
      angle += angle_stepsize;
    }
    
    menuItems[k].update(menuItemPosX[k], menuItemPosY[k], 50, 50);
    menuItems[k].drawShape();
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
      myPort.write('A');
      serialCount = 0;
    }
  }
}