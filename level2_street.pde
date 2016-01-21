


class level2_street
{
  basic_image streetBG;
  basic_image scary1;
  basic_image lessscary1;
  basic_image scary2;
  basic_image lessscary2;
  basic_image scary3;
  basic_image morescary3;
  basic_image bat;
  
  level2_street()
  {
    streetBG = new basic_image(loadImage("data/MIT/lv2/streetview.png"),64,64);
    
    scary1 = new basic_image(loadImage("data/MIT/lv2/streetview_a.png"),64,64);
    lessscary1 = new basic_image(loadImage("data/MIT/lv2/streetview_ar.png"),64,64);
    
    scary2 = new basic_image(loadImage("data/MIT/lv2/streetview_b.png"),64,64);
    lessscary2 = new basic_image(loadImage("data/MIT/lv2/streetview_br.png"),64,64);
    
    scary3 = new basic_image(loadImage("data/MIT/lv2/streetview_c.png"),64,64);
    
    bat = new basic_image(loadImage("data/MIT/lv2/bat.png"),64,64);
  }
  
  int bat_frames = 0;
  

  float bat_vx = 0;
  float bat_vy = 0;
  
  void draw()
  {
    theUI.OverrideCursor(true, guncursor);
    
    streetBG.draw();
    
    if (!murder_man)
      scary1.draw();
    else
      lessscary1.draw();
      
    if (!monster)
      scary2.draw();
    else
      lessscary2.draw();
      
    if (bat_show)
      scary3.draw();
      
    if (bat_attack)
    {
      if (bat_frames == 0)
      {
        float angle = 0.3;
        float velmag = 6.0;
        bat_vx = sin(angle) * velmag;
        bat_vy = -1 * cos(angle) * velmag;
        make_sound.play("bat");
        shake_screen(2,60,60); 
        jitter.get_rekt(0.4);
      }
      else if (bat_frames > 30)
      {
        bat.modRotate(0.15);        
        bat.movePos(bat_vx,bat_vy);
        bat_vy += 7 * gravity;
      }
      
      bat_frames++;
      bat.draw();
    }
      
    
    //scary3.draw();
    
  }
  
  boolean murder_man = false;
  boolean monster = false;
  
  boolean bat_show = false;
  boolean bat_attack = false;
  
  void TakeInput(inputblob i)
  {
    //println(theUI.cursor_x);
    //println(theUI.cursor_y);
    
    float effective_cursor_x = theUI.GetCursorX();
    float effective_cursor_y = theUI.GetCursorY();
    

    if (i.x_down)
    {
      // scary murder man
      if (box_test(effective_cursor_x, effective_cursor_y, 65, 68, 10,20))
      {
        if (!murder_man)
        {
          murder_man = true;
        }
      }
      if (box_test(effective_cursor_x, effective_cursor_y, 25, 93, 7,7))
      {
        if (!monster)
        {
          monster = true;
        }
      }
      if (box_test(effective_cursor_x, effective_cursor_y, 53, 10, 7,7))
      {
        if (bat_show && !bat_attack)
        {
          bat_attack = true;
          bat_show = false;
        }
      }
      
      if (murder_man && monster && !bat_attack)
      {
       bat_show = true; 
      }
    }
  }
}