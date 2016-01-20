import ddf.minim.*; //<>// //<>//

int game_width = 128;
int game_height = 128;
PFont font;
PFont font_ui;
level1 lv1;
jitterbug jitter;

UI theUI;

inputblob inp;

screen_title titlescreen;

sounder make_sound;

scoremaster scorer;

textbox tbtest;

boolean show_ui = true;

void setup()
{
  size(512,512, P2D);
  ((PGraphicsOpenGL)g).textureSampling(3);
  
  inp = new inputblob();
  jitter = new jitterbug();
  
  theUI = new UI();
  
  font = loadFont("RetroDeco-20.vlw");
  font_ui = loadFont("Minimal4-14.vlw");
  textFont(font, 20);
  textbox_setup();

  scorer = new scoremaster();
  
  make_sound = new sounder();

  titlescreen = new screen_title();

  imageMode(CENTER);
  noStroke();
  background(255);
  
  String[] tbtext = new String[2];
  tbtext[0] = "Hi #SAGameDev. I am trying to make a game but will probably fail BOO HOO ME :(.";
  tbtext[1] = "Here is a second line of text to test with";
  
  tbtest = new textbox(loadImage("data/MIT/textbox.png"),"0,1",0,tbtext);
  
  lv1 = new level1();
}

void draw()
{
  // Set up our initial scale:
  scale(4.0,4.0);
  
  // we can do screen shake too lol
  //translate(random(2) - 1.0, random(2) - 1.0);
  
  // Draw whatever scene we're on
  
  //titlescreen.draw();
  
  
  lv1.TakeInput(inp);
  lv1.draw();
  
  if (show_ui)
  {
    jitter.TakeInput(inp);
    theUI.TakeInput(inp);
    theUI.draw();
    scorer.draw();
  }
  
  
  tbtest.draw();
  tbtest.TakeInput(inp);

  // Inform the input class to clear the down states because we're at the end of the frame:
  inp.input_has_been_read();
  
  //println(frameRate);
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
  
  boolean do_box_test(float x, float y)
  {
    return box_test(x,y, x_float, y_float, imageRef.width / 2, imageRef.height / 2);    
  }
}

// Input handling
void keyPressed(KeyEvent e)
{
  inp.do_input(key, 1);
}

void keyReleased(KeyEvent e)
{
  inp.do_input(key, 0);
}

void stop()
{
  make_sound.end_program();  
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

boolean box_test(float x, float y, float box_x, float box_y, float w, float h)
{
  boolean minx = x > (box_x - w);
  boolean miny = y > (box_y - h);
  boolean maxx = x < (box_x + w);
  boolean maxy = y < (box_y + h);
  // if all these things are true then we're solid.
  return minx & miny & maxx & maxy;
}