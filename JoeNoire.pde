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
level3 lv3;
jitterbug jitter;

basic_image guncursor;

UI theUI;

inputblob inp;

screen_title titlescreen;

sounder make_sound;

scoremaster scorer;

textbox texter;

cutscene cutscene_engine;

boolean show_ui = true;

int shake_descaler = 0;
int shake_frames = 0;
float shake_scale;
float shake_start_scale;


int SUPER_GAME_STATE = 0;

boolean text_box_finished = false;
String text_box_finish_name = "";

curtains eye_c;

void setup()
{
  size(512,512, P2D);
  ((PGraphicsOpenGL)g).textureSampling(3);
  
  surface.setResizable(false);
  
  inp = new inputblob();
  jitter = new jitterbug();
  
  theUI = new UI();
  
  font = loadFont("RetroDeco-20.vlw");
  font_ui = loadFont("Minimal4-14.vlw");
  textFont(font, 20);
  textbox_setup();

  scorer = new scoremaster();
  
  make_sound = new sounder();

  eye_c = new curtains();

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
  
  cutscene_engine = new cutscene();
  
  progress_game("game_reset");
  
  //eye_c.change(true,"");
  
}

void shake_screen(float mag, int how_many_frames, int how_to_scale)
{
  shake_frames = how_many_frames;
  shake_scale = mag;
  shake_start_scale = mag;
  shake_descaler = how_to_scale;
}

boolean test = false;

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
      text_box_finish_name = texter.name_of_sequence;
      texter = null;
      
    }
  }
  
  if (SUPER_GAME_STATE == 0 || SUPER_GAME_STATE == 1)
  {
    if (SUPER_GAME_STATE == 0)
      titlescreen.TakeInput(inp);
      
    if (titlescreen != null)
      titlescreen.draw();
  }
  else if (SUPER_GAME_STATE == 100)
  {
    lv1.TakeInput(inp);
    lv1.draw();
  }
  else if (SUPER_GAME_STATE == 200 || SUPER_GAME_STATE == 220)
  {
     lv2.TakeInput(inp);
     lv2.draw();
  }
  else if (SUPER_GAME_STATE == 210)
  {
     lv2_b.TakeInput(inp);
     lv2_b.draw();
  }
  else if (SUPER_GAME_STATE == 300)
  {
    lv3.TakeInput(inp);
    lv3.draw();
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
  
  
  cutscene_engine.draw();
  
  eye_c.draw();
  
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
     cutscene_engine.play_scene(0);
     eye_c.change(true,"");
     titlescreen = new screen_title();
     make_sound.play_music("music1");
     SUPER_GAME_STATE = 0;
     theUI.showhide(false);
     theUI.chill = false;
     theUI.sounds(false);
     theUI.hijack_quit = false;
     
     jitter.anxiety(false);
     jitter.inaction_off();
     jitter.player_must_pump = false;
     jitter.MoveMarker(50);
     
      lv1 = null;
      lv2 = null;
      lv2_b = null;
      lv3 = null;
   }
  else if (SUPER_GAME_STATE == 0 && info.equals("title_start"))
  {
    eye_c.change(false, "title_fade_out");
    make_sound.stop_music();
    
    SUPER_GAME_STATE = 1;
  }
  else if (SUPER_GAME_STATE == 1 && info.equals("title_fade_out"))
  {
    lv1 = new level1();
    titlescreen = null;
    theUI.showhide(true);
    theUI.sounds(false);
    SUPER_GAME_STATE = 100;
  }
  else if (SUPER_GAME_STATE == 100 && info.equals("level1_end"))
  {
    SUPER_GAME_STATE = 101;
    cutscene_engine.play_scene(1);
  }
  else if (SUPER_GAME_STATE == 101 && info.equals("eyes_open_cutscene_1"))
  {
    SUPER_GAME_STATE = 102;
    cutscene_engine.blip();
  }
  else if (SUPER_GAME_STATE == 102 && info.equals("eyes_close_cutscene_1"))
  {
    SUPER_GAME_STATE = 110;
    cutscene_engine.play_scene(2);
  }
  
  else if (SUPER_GAME_STATE == 110 && info.equals("eyes_open_cutscene_2"))
  {
    SUPER_GAME_STATE = 111;
    cutscene_engine.blip();
  }
  else if (SUPER_GAME_STATE == 111 && info.equals("eyes_close_cutscene_2"))
  {
    cutscene_engine.play_scene(0);
    theUI.showhide(true);
    SUPER_GAME_STATE = 200;
    lv2 = new level2();
  }
  else if (SUPER_GAME_STATE == 200 && info.equals("level_2_cutscene_1"))
  {
    cutscene_engine.play_scene(10);
    SUPER_GAME_STATE = 201;
  }
  else if (SUPER_GAME_STATE == 201 && info.equals("eyes_open_cutscene_10"))
  {
    SUPER_GAME_STATE = 202;
    cutscene_engine.blip();
  }
  else if (SUPER_GAME_STATE == 202 && info.equals("eyes_close_cutscene_10"))
  {
   SUPER_GAME_STATE = 210;
   cutscene_engine.play_scene(0);
   lv2_b = new level2_street();
  }
  else if (SUPER_GAME_STATE == 210 && info.equals("level2b_end"))
  {
    cutscene_engine.play_scene(20);
    SUPER_GAME_STATE = 211;
  }
  else if (SUPER_GAME_STATE == 211 && info.equals("eyes_open_cutscene_20"))
  {
    SUPER_GAME_STATE = 212;
    cutscene_engine.blip();
  }
  else if (SUPER_GAME_STATE == 212 && info.equals("eyes_close_cutscene_20"))
  {
     SUPER_GAME_STATE = 220;
     cutscene_engine.play_scene(0);
     
     theUI.showhide(true);
     
     if (lv2 == null)
       lv2 = new level2();
       
     lv2_b = null;
     lv2.race(0);
  }
  else if (SUPER_GAME_STATE == 220 && info.equals("heist2_eyes_open"))
  {
    lv2.race(1);
  }
  else if (SUPER_GAME_STATE == 220 && info.equals("level2_finalend"))
  {
    SUPER_GAME_STATE = 221;
    cutscene_engine.play_scene(30);
  }
  else if (SUPER_GAME_STATE == 221 && info.equals("eyes_open_cutscene_30"))
  {
    SUPER_GAME_STATE = 222;
    cutscene_engine.blip();
  }
  else if (SUPER_GAME_STATE == 222 && info.equals("end_chapter_2"))
  {
    SUPER_GAME_STATE = 300;
    theUI.showhide(true);
    if (lv3 == null)
      lv3 = new level3();
  }
  else if (SUPER_GAME_STATE == 300 & info.equals("chapter_3_eyes_open"))
  {
     lv3.callback(1); 
  }
  else if (info.equals("credits"))
  {
    SUPER_GAME_STATE = 400;
    cutscene_engine.play_scene(1000);
  }
  
  
  else if (info.equals("skip1"))
  {
    SUPER_GAME_STATE = 100;
    progress_game("level1_end");
  }
  else if (info.equals("skip2"))
  {
    theUI.showhide(true);
    make_sound.play_music("music4");
    eye_c.open = false;
    SUPER_GAME_STATE = 202;
    progress_game("eyes_close_cutscene_10");
  }
  else if (info.equals("skip3"))
  {
    eye_c.open = false;
    SUPER_GAME_STATE = 222;
    progress_game("end_chapter_2");
  }
  else if (info.equals("skip4"))
  {
    SUPER_GAME_STATE = 400;
    cutscene_engine.play_scene(1000);
  }
  
   
}

class basic_image
{
  float x_float, y_float;
  float w, h;
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
  
  int fader = -1;
  int fademod = 1;
  
  void fade(boolean in)
  {
    
    
    if (in)
    {
      fademod = 3;
      fader = 0;
    }
    else
    {
      fademod = -3;
      fader = 256;
    }
    // tint(255, 127);  // Display at half opacity
    
  }
  
  void draw()
  {
    pushMatrix();
    
    translate(x_float,y_float);

    if (rotation != 0.0)
    {
      rotate(rotation);
    }
    
    if (fader >= 0)
    {
      tint(255, fader);
      fader = constrain(fader + fademod,0,256);
      if (fader == 0 || fader == 256)
      {
        fader = -1;
      }
    }
    
    if (w != 0 || h != 0)
    {
      image(imageRef,0,0,w,h);
    }
    else
    {
      image(imageRef,0,0);
    }
    
    tint(255, 255);
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