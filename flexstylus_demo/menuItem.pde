class menuItem
{
  float posX;
  float posY;
  float sizeX;
  float sizeY;
  
  menuItem()
  {
    posX = 20;
    posY = 20;
    sizeX = 50;
    sizeY = 50;
  }
  
  void update(float posXTemp, float posYTemp, float sizeXTemp, float sizeYTemp)
  {
    posX = posXTemp;
    posY = posYTemp;
    
  }
  void drawShape()
  {
    ellipseMode(CENTER);
    noStroke();
    fill(0,0,0);
    ellipse(posX, posY, sizeX, sizeY);
  }
}