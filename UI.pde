
int marker_max = 36;
int bar_max = 42;

class UI
{
  boolean is_on;
  
  basic_image ui_base;
  basic_image ui_base1;
  basic_image ui_base2;
  
  basic_image marker;
  basic_image marker2;
  
  basic_image Cursor;
  basic_image Cursor_Replace;
  
  float cursor_x = 64;
  float cursor_y = 64;
  float effective_cursor_x = 64;
  float effective_cursor_y = 64;
  
  float cursor_speed = 1.5;
  float panic_buildup = 0.0;
  
  boolean chill = false;
  
  float marker_jitter = 0;
  
  boolean marker_pulse = false;
  
  
  
  boolean play_sounds = false;
  void sounds(boolean state)
  {
     play_sounds = state;
  }
  void showhide(boolean state)
  {
     is_on = state; 
  }

  UI()
  {
    ui_base = new basic_image(loadImage("data/MIT/UI/UI_base.png"), 64,128 - 8);
    ui_base1 = new basic_image(loadImage("data/MIT/UI/UI_base_a.png"), 64,128 - 8);
    ui_base2 = new basic_image(loadImage("data/MIT/UI/UI_base_b.png"), 64,128 - 8);
    marker = new basic_image(loadImage("data/MIT/UI/calm_marker.png"), 64,128 - 10);
    marker2 = new basic_image(loadImage("data/MIT/UI/calm_marker2.png"), 64,128 - 10);
    
    Cursor = new basic_image(loadImage("data/MIT/cursor1.png"),64,64);
    
    chillimg = new basic_image(loadImage("data/MIT/panic.png"),97,128 - 16 + 12);
  }
  
  void reset_score()
  {
    smiles = 0;
    sads = 0;
  }
  
  void set_buildup(float buildup)
  {
    panic_buildup = constrain(buildup,0,1.0); 
  }
    
  void calc_jitter()
  {
    marker_jitter = random(abs(panic_buildup - 1)*2) - 1;
  }
  
  void pulse(boolean state)
  {
    marker_pulse = state;
    
    if (play_sounds)
    {
      if (marker_pulse)
      {
        make_sound.play("pulse2");
        make_sound.halt("pulse1");
      }
      else
      {
        make_sound.play("pulse1");
        make_sound.halt("pulse2");
      }
    }
  }
  
  float markerpos;
  void SetMarker(float ratio)
  {
    markerpos = ratio / 2;
    marker.setPos((64 - marker_max) + marker_max * ratio + marker_jitter, 128 - 10);
    marker2.setPos((64 - marker_max) + marker_max * ratio + marker_jitter, 128 - 10);
  }
  
  void draw()
  {
    if (!is_on)
      return;
      
      
    fill(color(0,0,0));
    rect(0,128-16,128,16);
    
    textFont(font_ui, 14);
    
    fill(color(170,170,170));
 
     
     if (chill && markerpos > 0.6 && panic_buildup < 0.5)
     {
       float pb = 1.0 - (panic_buildup / 0.5);
       // pb will be 0 when we are only just beginning
       float mark = (markerpos - 0.6) / 0.4;
       // mark will be 0 when we are only just beginning
       float res = mark * pb;
       
       float v1 = 170 + (res) * (255-170);
       float v2 = (1 - res) * 170;
       fill(v1,v2,v2);
     }
 
    float panic_bar = map(panic_buildup,0,1.0,bar_max,0);
    rect(64 - panic_bar, 128 - 14, 2 * panic_bar, 12);
    
    ui_base.draw();
    
    if (chill)
      ui_base2.draw();
    else
      ui_base1.draw();
    
    fill(color(255,255,255));
    
    String number = str(smiles);
    if (number.length() == 1)
      number = "0" + number;


    text(number,118,119);
    number = str(sads);
    if (number.length() == 1)
      number = "0" + number;
    text(number,118,125);
    
    if (marker_pulse)
    {
      marker2.draw();
    }
    else
    {
      marker.draw();
    }
      
    jitter.calc_jitter();
    effective_cursor_x = jitter.apply_jitter_x(cursor_x);
    effective_cursor_y = jitter.apply_jitter_y(cursor_y);

    if (cursor_y > 128 - 16)
    {
      float amount_below = pow(constrain((cursor_y - (128-16)) / 8.0,0,1.0), 0.5);
      effective_cursor_x = lerp(effective_cursor_x, cursor_x, amount_below);
      effective_cursor_y = lerp(effective_cursor_y, cursor_y, amount_below);
    }

    if (cursor_override_state && Cursor_Replace != null && cursor_y < 128-16)
    {
      Cursor_Replace.setPos(effective_cursor_x,effective_cursor_y);
      Cursor_Replace.draw();
    }
    else
    {
      Cursor.setPos(effective_cursor_x,effective_cursor_y);
      Cursor.draw();
    }
    
    if (chiller != null)
    {
      if (chiller.draw())
        chiller = null;
    }
    
  }
  
  
  boolean cursor_override_state = false;
  
  float GetCursorX()
  {
    return effective_cursor_x;
  }
  float GetCursorY()
  {
    return effective_cursor_y;
  }
 
  void OverrideCursor(boolean state, basic_image pReplace)
  {
    cursor_override_state = state;
    Cursor_Replace = pReplace;    
  }
  
  float cursor_minx = 0;
  float cursor_miny = 0;
  float cursor_maxx = 127;
  float cursor_maxy = 127;
  
  void ResetCursor()
  {
    cursor_minx = 0;
    cursor_miny = 0;
    cursor_maxx = 127;
    cursor_maxy = 127;
  }
  
  void SetCursorConstraints(float x1, float y1, float x2, float y2)
  {
    cursor_minx = x1;
    cursor_miny = y1;
    cursor_maxx = x2;
    cursor_maxy = y2;
  }
  
  boolean no_up = false;
  void special_race_mode(boolean state)
  {
    no_up = state;
    
  }
  void mod_up(float amount)
  {
    cursor_y = constrain( cursor_y + amount, cursor_miny, cursor_maxy);
  }
  
  basic_image chillimg;
  shard chiller;
  void go_chill()
  {
     chiller = new shard(chillimg,97,128 - 16 + 12);
     chill = true;
  }
  
  
  boolean hijack_quit = false;
  
  void TakeInput(inputblob i)
  {
    if (!is_on)
      return;
    cursor_x = constrain( cursor_x + cursor_speed * i.x_axis, cursor_minx, cursor_maxx);
    if (!no_up)
      cursor_y = constrain( cursor_y + cursor_speed * i.y_axis, cursor_miny, cursor_maxy);
      
    if (i.x_down)
    {
      if (cursor_x <= 15 && cursor_y >= 128 - 9)
      {
        if (!hijack_quit)
          progress_game("game_reset");
      }
    }
  }
  
  int smiles = 0;
  int sads = 0;
  void SetSmiles(int pSmiles)
  {
    smiles = pSmiles;
  }
  void SetSads(int pSads)
  {
    sads = pSads;
  }
}