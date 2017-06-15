class menuItem
{
  menuItem()
  {
    int posX = 20;
    int posY = 20;
    
  }
  
  void drawShape(int posX, int posY)
  {

    ellipseMode(CENTER);
    noStroke();
    fill(255,0,0);
    ellipse(posX, posY, 50, 50);

  }
}