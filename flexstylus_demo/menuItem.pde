class menuItem
{
  float posX;
  float posY;
  float sizeX;
  float sizeY;
  boolean isOverlapping;
  boolean isActive;
  float strokeWeight;
  
  menuItem()
  {
    posX = width/2;
    posY = height/2;
    isOverlapping = false;
    
    if (width <= height)
    {
      sizeX = width/10;
      sizeY = width/10;
    }
    else if (width > height)
    {
      sizeX = height/10;
      sizeY = height/10;
    }

  }
  
  void update(float posXTemp, float posYTemp, float sizeXTemp, float sizeYTemp)
  {
    posX = posXTemp;
    posY = posYTemp;
    sizeX = lerp(sizeX, sizeXTemp, 0.5);
    sizeY = lerp(sizeY, sizeYTemp, 0.5);
  }
  
  void drawShape()
  {
    ellipseMode(CENTER);
    if(!isActive)
    {
      strokeWeight = lerp(strokeWeight, 0, 0.5);
    }
    else if(isActive)
    {
      strokeWeight = lerp(strokeWeight, 7.5, 0.5);
    }
    
    stroke(50,250,100);
    strokeWeight(strokeWeight);
    fill(0,0,0);
    ellipse(posX, posY, sizeX, sizeY);
  }
}