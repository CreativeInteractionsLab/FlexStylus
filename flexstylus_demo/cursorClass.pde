class cursorX
{
  float x1, y1;
  cursorX()
  {
    x1 = width/2;
    y1 = height/2;
  }
  void drawShape()
  {
    //mouse/pen cursor

    ellipseMode(CENTER);
    fill(255,255,255);
    noStroke();
    ellipse(mouseX, mouseY, 20, 20);
    
    //flex cursor
    noStroke();
    ellipse(x1, y1, 20, 20);
  }
  void moveShape(float posX, float posY)
  {
    x1 = posX + mouseX;
    y1 = posY + mouseY;
  }
}