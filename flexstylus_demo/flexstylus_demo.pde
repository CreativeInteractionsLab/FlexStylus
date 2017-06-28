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

//Radial menu items
menuItem[] menuItems;
float[] menuItemPosX = new float[8];
float[] menuItemPosY = new float[8];
int activeMenuItem;
float radius;
float dist = 50;
float angle = 0;
float angle_stepsize = 0.785;
float centerScreenX;
float centerScreenY;
float defaultMenuItemSizeX;
float defaultMenuItemSizeY;
float defaultMenuItemOpacity;
int btnDrawTimer;
boolean drawMenu;
int numMenuItems_noOverlap;
boolean isOverlappingMenuItem;

//Bend Movement
int increaseMagnitudeX = 1;
int increaseMagnitudeY = 1;

//menuButton
mainMenu mainRadialMenu;
boolean menuPressed;
int defaultMainMenuSize;
boolean isOverlappingMainMenu;

//timer for menu
int m;

//drawing
boolean mouseHeld;
float oldX;
float oldY;

void setup()
{
  size(1024,1024);
  
  //String portName = Serial.list()[portNum];
  //myPort = new Serial(this, portName, 9600);
  
  //cursor setup
  xpos = width/2;
  ypos = height/2;
  increaseMagnitudeX = width/255;
  increaseMagnitudeY = height/255;
  flexCursor = new cursorX();
  
  //main menu setup
  mainRadialMenu = new mainMenu();
  
  //menu item setup
  menuItems = new menuItem[8];
  centerScreenX = width/2;
  centerScreenY = height/2;
  menuPressed = false;
  defaultMenuItemOpacity = 220;
  drawMenu = false;
  isOverlappingMenuItem = false;
  activeMenuItem = 100;
  
  if (width <= height)
  {
    defaultMenuItemSizeX = width/10;
    defaultMenuItemSizeY = width/10;
    radius = width / 5;
    defaultMainMenuSize = width/17;
  }
  else if (width > height)
  {
    defaultMenuItemSizeX = height/10;
    defaultMenuItemSizeY = height/10;
    radius = height / 5;
    defaultMainMenuSize = height/17;
  }
  
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
    menuItems[j] = new menuItem(j);
  }
}

void draw()
{
  background(255, 255, 255);
  
  //Radial Menu
  if (drawMenu)
  {
    if (menuPressed)
    {
      for (int k = 0; k < menuItemPosX.length; k++)
      {
        if(angle < 2*PI)
        {
          menuItemPosX[k] = radius * cos(angle-1.57) + centerScreenX;
          menuItemPosY[k] = radius * sin(angle-1.57) + centerScreenY;
          angle += angle_stepsize;
        }
        
        if(overMenuItem(menuItemPosX[k], menuItemPosY[k], defaultMenuItemSizeX))
        {
          menuItems[k].update(menuItemPosX[k], menuItemPosY[k], defaultMenuItemSizeX+50, defaultMenuItemSizeY+50, 255);
          menuItems[k].drawShape();
          menuItems[k].isOverlapping = true;
        }
        else if(!(overMenuItem(menuItemPosX[k], menuItemPosY[k], defaultMenuItemSizeX)))
        {
          menuItems[k].update(menuItemPosX[k], menuItemPosY[k], defaultMenuItemSizeX, defaultMenuItemSizeY, defaultMenuItemOpacity);
          menuItems[k].drawShape();
          menuItems[k].isOverlapping = false;
        }
      }
    }
    else if(!menuPressed)
    {
      for (int k = 0; k < menuItemPosX.length; k++)
      {
        menuItems[k].update(width/2,height/2, 1, 1, 0);
        menuItems[k].drawShape();
      }
      
      if(millis() >= m+300)
      {
         drawMenu = false;
      }
    }
  }
  
  //Main Menu
  if(overMenuItem(mainRadialMenu.posX, mainRadialMenu.posY, mainRadialMenu.sizeX))
  {
    mainRadialMenu.update(defaultMainMenuSize+10, defaultMainMenuSize+10, 255);
    isOverlappingMainMenu = true;
  }
  else if(!overMenuItem(mainRadialMenu.posX, mainRadialMenu.posY, mainRadialMenu.sizeX))
  {
    mainRadialMenu.update(defaultMainMenuSize, defaultMainMenuSize, defaultMenuItemOpacity);
    isOverlappingMainMenu = false;
  }
  
  //execute action if mouse is held
  if(mouseHeld && !isOverlappingMenuItem && !isOverlappingMainMenu)
  {
    switch(activeMenuItem)
    {
      case 0:
      println("draw");
      drawing();
      break;
      
      case 1:
      println("color");
      break;
    }
  }
  
  
  
  flexCursor.moveShape(xpos, ypos);
  flexCursor.drawShape();
  
  mainRadialMenu.drawShape();
  
  /*
  fill(0,0,0);
  text("menu 0 act: " + str(menuItems[0].isActive), 20, 30);
  text("menu 0 ol: " + str(menuItems[0].isOverlapping), 20, 50);
  text("menu 1 act: " + str(menuItems[1].isActive), 20, 70);
  text("menu 1 ol: " + str(menuItems[1].isOverlapping), 20, 90);
  text("num no ol: " + str(numMenuItems_noOverlap), 20, 110);
  text("isOverlappingMenuItem: " + str(isOverlappingMenuItem), 20, 130);
  */
  

}

void mousePressed()
{
  mouseHeld = true;
  //if clicking radial menu item
  if (drawMenu && menuPressed)
  {
    for (int i = 0; i < menuItemPosX.length; i++)
    {
      numMenuItems_noOverlap = 0;
      //checks if overlapping at least 1 menu item
      for (int k = 0; k < menuItemPosX.length; k++)
      {
        if (menuItems[k].isOverlapping == true)  
        {
          isOverlappingMenuItem = true;
        }
        else if (menuItems[k].isOverlapping == false)
        {
          numMenuItems_noOverlap++;
          if (numMenuItems_noOverlap == menuItemPosX.length)
          {
            isOverlappingMenuItem = false;
            
            //closes menu if misclick
            menuPressed = false;
            mainRadialMenu.isActive = false;
            m = millis();
          }
        }
      }  
      if(isOverlappingMenuItem)
      {
        if(menuItems[i].isOverlapping == true)
        {
          menuItems[i].isActive = true;
          activeMenuItem = i;
        }
        else if(menuItems[i].isOverlapping == false)
        {
          menuItems[i].isActive = false;
        }
      }
    }
  }
  
  //if clicking main menu
  if (isOverlappingMainMenu)
  {
    if(drawMenu)
    {
      menuPressed = false;
      m = millis();
      mainRadialMenu.isActive = false;
    }
    else if(!drawMenu)
    {
      menuPressed = true;
      drawMenu = true;
      mainRadialMenu.isActive = true;
    }
  }

}

void mouseReleased()
{
  mouseHeld = false; 
}

void keyPressed()
{
  if(key == '1')
  {
    if(!menuPressed)
    {
      drawMenu = true;
      menuPressed = true;
    }
    else if(menuPressed)
    {
      //closes menu
      menuPressed = false;
      m = millis();
    }
  }
  else if(key == '2')
  {
    background(255);
  }
}

void drawing()
{
  stroke(0);
  strokeWeight(7);
  line(mouseX, mouseY, oldX, oldY);
  oldX=mouseX;
  oldY=mouseY;
}

boolean overMenuItem(float tempMenuItemX, float tempMenuItemY, float tempDiameter)
{
  float distX = tempMenuItemX - mouseX;
  float distY = tempMenuItemY - mouseY;
  
  if(sqrt(sq(distX) + sq(distY)) < tempDiameter/2)
  {
    return true;
  }
  else
  {
   return false; 
  }
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