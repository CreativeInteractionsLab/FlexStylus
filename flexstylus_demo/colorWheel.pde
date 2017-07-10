class colorWheel
{
  float posX;
  float posY;
  float sizeX;
  float sizeY;
  boolean isActive;
  PShape cW;
  
  float posCheckX;
  float posCheckY;
  float sizeCheckX;
  float sizeCheckY;
  PShape cWCheck;
  
  colorWheel()
  {
    posX = width/2;
    posY = height/2;
    cW = loadShape("colorWheel.svg");
    cW.enableStyle();
  }
  
  void update(float sizeXTemp, float sizeYTemp)
  {
    sizeX = lerp(sizeX, sizeXTemp, 0.5);
    sizeY = lerp(sizeY, sizeYTemp, 0.5);
  }
  
  void drawShape()
  {
    shapeMode(CENTER);
    shape(cW, width/2, height/2, 350, 350);
  }
}
    