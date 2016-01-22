import ddf.minim.*; //<>// //<>//

float global_volume = 0.3;
float global_gain = -10;

int game_width = 128;
int game_height = 128;
PFont font;
PFont font_ui;
level1 lv1;
level2 lv2;
level2_street lv2_b;
jitterbug jitter;

basic_image guncursor;

UI theUI;

inputblob inp;

screen_title titlescreen;

sounder make_sound;

scoremaster scorer;

textbox texter;

boolean show_ui = true;

int shake_descaler = 0;
int shake_frames = 0;
float shake_scale;
float shake_start_scale;



int SUPER_GAME_STATE = 0;

boolean text_box_finished = false;
String text_box_finish_name = "";


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
  
  guncursor = new basic_image(loadImage("data/MIT/crosshair.png"),64,64);
  
  /*
  String[] tbtext = new String[3];
  tbtext[0] = "tannoy^Hi #SAGameDev. I am trying to make a game but will probably fail BOO HOO ME :(.";
  tbtext[1] = "goon2^Here is a second line of text to test with";
  tbtext[2] = "superboss^Look at my beautiful rings!";
  
  String[] tbtext2 = find_text("chap2_1");
  */
  //lv1 = new level1();
  //lv2 = new level2();
  //lv2_b = new level2_street();
  
  //make_sound.play_music("music1");
  
  progress_game("game_reset");
}

void shake_screen(float mag, int how_many_frames, int how_to_scale)
{
  shake_frames = how_many_frames;
  shake_scale = mag;
  shake_start_scale = mag;
  shake_descaler = how_to_scale;
}

void draw()
{
  boolean shake_ui = true;
  // Set up our initial scale:
  scale(4.0,4.0);
  
  // Set up the screen shake black out:
  fill(0,0,0);
  rect(-10,-10,148,148);
  fill(255,255,255);
  
  if (!shake_ui)
  {
    pushMatrix();
  }
  
  if (shake_frames > 0)
  {
    if (shake_descaler != 0)
    {
      float ratio = shake_frames;
      ratio /= shake_descaler;
      ratio = constrain(ratio,0,1);
      shake_scale = shake_start_scale * ratio;
    }
    
    float shake_x = random(2 * shake_scale) - shake_scale;
    float shake_y = random(2 * shake_scale) - shake_scale;
    translate(shake_x,shake_y);
    shake_frames--;
  }
  
  if (texter != null)
  {
    if (texter.TakeInput(inp))
    {
      inp.input_has_been_read(false);    
    }
    else
    {
      // we finished
      text_box_finished = true;
      text_box_finish_name = texter.name;
      texter = null;
      
    }
  }
  
  if (SUPER_GAME_STATE == 0)
  {
    titlescreen.TakeInput(inp);
    titlescreen.draw();
  }
  else if (SUPER_GAME_STATE == 1)
  {
    lv1.TakeInput(inp);
    lv1.draw();
  }
  
  
  

  // we can do screen shake too lol
  //translate(random(2) - 1.0, random(2) - 1.0);
  
  // Draw whatever scene we're on
  
  //
  

  
  //lv2.TakeInput(inp);
  //lv2.draw();
  
  //lv2_b.TakeInput(inp);
  //lv2_b.draw();
  
  if (show_ui)
  {
    jitter.TakeInput(inp);
    theUI.TakeInput(inp);
    if (!shake_ui)
    {
      popMatrix();
    }
    theUI.draw();
    scorer.draw();
  }
  
  if (texter != null)
    texter.draw();
  
  // Inform the input class to clear the down states because we're at the end of the frame:
  inp.input_has_been_read(true);

  make_sound.service();
  text_box_finished = false;
  //println(frameRate);
}

void progress_game(String info)
{
   if (info.equals("game_reset"))
   {
     SUPER_GAME_STATE = 0;
     theUI.showhide(false);
     theUI.sounds(false);
      lv1 = null;
      lv2 = null;
   }
   else if (SUPER_GAME_STATE == 0 && info.equals("title_start"))
   {
      theUI.showhide(true);
      theUI.sounds(false);
      SUPER_GAME_STATE = 1;
      lv1 = new level1();
      
   }
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
  void modRotate(float rot)
  {
    rotation += rot;
  }
  
  void draw()
  {
    pushMatrix();
    
    translate(x_float,y_float);

    if (rotation != 0.0)
    {
      rotate(rotation);
    }
    
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

boolean box_test(float x, float y, float box_x, float box_y, float w, float h)
{
  boolean minx = x > (box_x - w);
  boolean miny = y > (box_y - h);
  boolean maxx = x < (box_x + w);
  boolean maxy = y < (box_y + h);
  // if all these things are true then we're solid.
  return minx & miny & maxx & maxy;
}