float screenW;
float screenH;
void setup()
{
  fullScreen(P2D);
  screenW = width;
  screenH = height;
  smooth(2);
}

void draw()
{
  //background(0);
  ellipseMode(CENTER);
  noStroke();
  ellipse(screenW/2,screenH/2,60,60);
  println(screenW);
}