

class UI
{
  basic_image ui_base;
  basic_image ui_base1;
  basic_image ui_base2;
  
  basic_image marker;
  
  float calmness = 1.0;
  
  int smiles = 0;
  int sads = 0;
  
  boolean chill = false;
  
  float marker_jitter = 0;
  
  UI()
  {
    ui_base = new basic_image(loadImage("data/MIT/UI/UI_base.png"), 64,128 - 8);
    ui_base1 = new basic_image(loadImage("data/MIT/UI/UI_base_a.png"), 64,128 - 8);
    ui_base2 = new basic_image(loadImage("data/MIT/UI/UI_base_b.png"), 64,128 - 8);
    marker = new basic_image(loadImage("data/MIT/UI/calm_marker.png"), 64,128 - 10);
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
  
  void calc_jitter()
  {
    marker_jitter = random(abs(calmness - 1)*2) - 1;    
  }
  
  void draw()
  {
    textFont(font_ui, 14);
    marker.setPos((64 - 36) + 36 * calmness + marker_jitter, 128 - 10);
    
    ui_base.draw();
    
    if (chill)
      ui_base2.draw();
    else
      ui_base1.draw();
    
    fill(color(255,255,255));
    
    text("00",118,119);
    text("00",118,125);
    
    
    marker.draw();
  }
  
}