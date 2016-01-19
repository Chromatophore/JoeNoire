int game_width = 128;
int game_height = 128;
PFont font;
level1 lv1;

inputblob inp;

screen_title titlescreen;

textbox tbtest;

void setup()
{
  size(512,512, P2D);
  ((PGraphicsOpenGL)g).textureSampling(3);
  
  inp = new inputblob();
  
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
  // Set up our initial scale:
  scale(4.0,4.0);
  
  // Draw whatever scene we're on
  
  //titlescreen.draw();
  //tbtest.draw(); //<>//
  
  lv1.TakeInput(inp);
  lv1.draw();
  
  
  // Inform the input class to clear the down states because we're at the end of the frame:
  inp.input_has_been_read();
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

// Input handling
void keyPressed(KeyEvent e)
{
  inp.do_input(key, 1);
}

void keyReleased(KeyEvent e)
{
  inp.do_input(key, 0);
}


class inputblob
{
  int z_state;
  int x_state;
  int c_state;
  
  boolean z_down;
  boolean x_down;
  boolean c_down;
  
  int up_state;
  int down_state;
  int left_state;
  int right_state;
  
  float x_axis;
  float y_axis;
  
  inputblob()
  {
    
  }
  
  void input_has_been_read()
  {
    z_down = false;
    x_down = false;
    c_down = false;
  }
  
  void do_input(char c, int down)
  {
    if (key == CODED)
    {
      if (keyCode == UP)
        up_state = down;
      if (keyCode == DOWN)
        down_state = down;
      if (keyCode == LEFT)
        left_state = down;
      if (keyCode == RIGHT)
        right_state = down;
    }
    else
    {
       if (c == 'z')
       {
         z_state = down;
         if (down == 1)
           z_down = true;
       }
       if (c == 'x')
       {
         x_state = down;
         if (down == 1)
           x_down = true;
       }
       if (c == 'c')
       {
         c_state = down;
         if (down == 1)
           c_down = true;
       }
    }
    
    x_axis = -1 * left_state + 1 * right_state;
    y_axis = -1 * up_state + 1 * down_state; 
    
    //print(x_axis + " " + y_axis + "\n");

  }

}