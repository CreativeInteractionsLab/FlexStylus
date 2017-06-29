class cursorX
{
  float x1, y1;
  int mode;
  cursorX()
  {
    x1 = width/2;
    y1 = height/2;
    mode = 0;
  }
  void drawShape()
  {
    //mouse/pen cursor
    
    ellipseMode(CENTER);
    switch (mode)
    {
      case 0:
      fill(0);
      noStroke();
      ellipse(mouseX, mouseY, 5, 5);
      break;
      case 1:
      noFill();
      stroke(0);
      strokeWeight(2);
      ellipse(mouseX, mouseY, 10, 10);
      break;
      case 2:
      break;
    }
    
    
    //flex cursor
    //noStroke();
    //ellipse(x1, y1, 20, 20);
  }
  void moveShape(float posX, float posY)
  {
    x1 = posX + mouseX;
    y1 = posY + mouseY;
  }
}