int game_width = 128;
int game_height = 128;
PFont font;
level1 lv1;

screen_title titlescreen;

textbox tbtest;

void setup()
{
  size(512,512, P2D);
  ((PGraphicsOpenGL)g).textureSampling(3);
  
  font = loadFont("RetroDeco-20.vlw");
  textFont(font, 20);
  textbox_setup();

  titlescreen = new screen_title();

  imageMode(CENTER);
  noStroke();
  background(255);
  
  PImage[] bossAnim = new PImage[2];
  bossAnim[0] = loadImage("data/boss1.png");
  bossAnim[1] = loadImage("data/boss2.png");
  
  tbtest = new textbox(loadImage("data/textbox.png"),bossAnim,
  "Hello Olive!!! This is a test. A really really long test that should span many many lines.");
  
  lv1 = new level1();
}

void draw() { 
  // Displays the image at its actual size at point (0,0)
  
  scale(4.0,4.0);
  
  //titlescreen.draw();
  
  //tbtest.draw(); //<>//
  
  lv1.draw();
}

class basic_image
{
  float x_float, y_float;
  int w, h;
  PImage imageRef;
  float rotation;
  
  basic_image(PImage pImageRef, int xpos, int ypos)
  {
    imageRef = pImageRef;
    x_float = xpos;
    y_float = ypos;
    rotation = 0.0;
    w = 0;
    h = 0;
  }
  
  void setPos(float xpos, float ypos)
  {
    x_float = xpos;
    y_float = ypos;
  }

  void movePos(float xpos, float ypos)
  {
    x_float += xpos;
    y_float += ypos;
  }
  
  void setRotate(float rot)
  {
    rotation = rot;
  }
  void rotate(float rot)
  {
    rotation += rot;
  }
  
  void draw()
  {
    pushMatrix();
    translate(x_float,y_float);
    if (rotation != 0.0)
      rotate(rotation);
    if (w != 0 || h != 0)
    {
      image(imageRef,0,0,w,h);
    }
    else
    {
      image(imageRef,0,0);
    }
    popMatrix();
  }
} //<>//

void keyPressed() {
  if (key == 'z')
  {
    lv1.nextCrate();
  }
}