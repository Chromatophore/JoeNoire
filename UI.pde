
int marker_max = 36;
int bar_max = 42;

class UI
{
  basic_image ui_base;
  basic_image ui_base1;
  basic_image ui_base2;
  
  basic_image marker;
  basic_image marker2;
  
  basic_image Cursor;
  
  float cursor_x = 64;
  float cursor_y = 64;
  float effective_cursor_x = 64;
  float effective_cursor_y = 64;
  
  float cursor_speed = 1.0;
  
  float calmness = 1.0;
  float panic_buildup = 0.0;
  
  int smiles = 0;
  int sads = 0;
  
  boolean chill = false;
  
  float marker_jitter = 0;
  
  boolean marker_pulse = false;
  
  UI()
  {
    ui_base = new basic_image(loadImage("data/MIT/UI/UI_base.png"), 64,128 - 8);
    ui_base1 = new basic_image(loadImage("data/MIT/UI/UI_base_a.png"), 64,128 - 8);
    ui_base2 = new basic_image(loadImage("data/MIT/UI/UI_base_b.png"), 64,128 - 8);
    marker = new basic_image(loadImage("data/MIT/UI/calm_marker.png"), 64,128 - 10);
    marker2 = new basic_image(loadImage("data/MIT/UI/calm_marker2.png"), 64,128 - 10);
    
    Cursor = new basic_image(loadImage("data/MIT/cursor1.png"),64,64);
  }
  
  void reset_score()
  {
    smiles = 0;
    sads = 0;
  }
  
  void set_calm(float pCalm)
  {
    calmness = pCalm;
  }
  void set_buildup(float buildup)
  {
    panic_buildup = buildup; 
  }
    
  void calc_jitter()
  {
    marker_jitter = random(abs(calmness - 1)*2) - 1;
  }
  
  void pulse(boolean state)
  {
    marker_pulse = state;
  }
  
  void SetMarker(float ratio)
  {
    marker.setPos((64 - marker_max) + marker_max * ratio + marker_jitter, 128 - 10);
    marker2.setPos((64 - marker_max) + marker_max * ratio + marker_jitter, 128 - 10);
  }
  
  void draw()
  {
    textFont(font_ui, 14);
    
    fill(color(170,170,170));
 
    float panic_bar = constrain(panic_buildup,0,bar_max);
    rect(64 - panic_bar, 128 - 14, 2 * panic_bar, 12);
    
    ui_base.draw();
    
    if (chill)
      ui_base2.draw();
    else
      ui_base1.draw();
    
    fill(color(255,255,255));
    text("00",118,119);
    text("00",118,125);
    
    if (marker_pulse)
      marker2.draw();
    else
      marker.draw();
      
    jitter.calc_jitter();
    effective_cursor_x = jitter.apply_jitter_x(cursor_x);
    effective_cursor_y = jitter.apply_jitter_y(cursor_y);

    Cursor.setPos(effective_cursor_x,effective_cursor_y);
    Cursor.draw();
  }
  
  float GetCursorX()
  {
    return effective_cursor_x;
  }
  float GetCursorY()
  {
    return effective_cursor_y;
  }
  
  void TakeInput(inputblob i)
  {
    cursor_x = constrain( cursor_x + cursor_speed * i.x_axis, 0, 127);
    cursor_y = constrain( cursor_y + cursor_speed * i.y_axis, 0, 127);
  }
}