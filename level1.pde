
class level1
{
  basic_image WareHouseBG;
  basic_image WareHouseSky;
  basic_image Crate1;
  basic_image Crate2;
  basic_image conveyor_wheels;
  
  basic_image arrow_left;
  basic_image arrow_right;
  basic_image next_button;
  
  basic_image Cursor;
  
  float cursor_x = 64;
  float cursor_y = 64;
  float effective_cursor_x = 64;
  float effective_cursor_y = 64;
  
  int cog_steps = 5;
  int cog_current = 0;
  int cogspin = 0;
  
  int time_between_crates = 3000;
  
  crate[] crate_locations;
  int focus_crate = 0;
  
  float box_current_x;
  
  float current_camera_x;
  
  float point_to_kill_crate = -40;
  
  float cursor_speed = 1.0;
  
  int start_milli;
  int lastcrate;
  
  int current_crates = 0;
  
  float camera_crate_offset = -8;
  float crate_speed = 0.5;
  
  boolean drawui;
  
  level1()
  {
    WareHouseBG = new basic_image(loadImage("data/MIT/warehouse.png"),-128,64);
    WareHouseSky = new basic_image(loadImage("data/MIT/warehouse_sky.png"),64,256);
    Crate1 = new basic_image(loadImage("data/MIT/lv1/crate1.png"),0,0);
    Crate2 = new basic_image(loadImage("data/MIT/lv1/crate2.png"),0,0);
    
    conveyor_wheels = new basic_image(loadImage("data/MIT/lv1/conveyorwheels.png"),15,64);
    
    arrow_left = new basic_image(loadImage("data/MIT/lv1/leftside_arrow.png"),15,64);
    arrow_right = new basic_image(loadImage("data/MIT/lv1/rightside_arrow.png"),113,64);
    next_button = new basic_image(loadImage("data/MIT/lv1/next.png"),113,96);
    
    Cursor = new basic_image(loadImage("data/MIT/cursor1.png"),64,64);
    
    
    current_camera_x = 512 - 128;
    
    crate_locations = new crate[10];
    for (int j = 0;j < 10;j ++)
    {
      crate_locations[j] = new crate();      
    }
    
    new_box();
    
    start_milli = -1;
  }
  
  void TakeInput(inputblob i)
  {
    if (i.z_down)  // treat as swap?
    {
      
    }
    if (i.x_down)  // treat as click?
    {
      if (drawui)
      {
        // test current cursor:
        if (arrow_left.do_box_test(effective_cursor_x, effective_cursor_y))
        {
          crate_locations[focus_crate].showside += 3;
        }
        else if (arrow_right.do_box_test(effective_cursor_x, effective_cursor_y))
        {
          crate_locations[focus_crate].showside += 1;
        }
        else if (next_button.do_box_test(effective_cursor_x, effective_cursor_y))
        {
          nextCrate();
        }
      }
      
    }
    cursor_x = constrain( cursor_x + cursor_speed * i.x_axis, 0, 127);
    cursor_y = constrain( cursor_y + cursor_speed * i.y_axis, 0, 127);
  }
  
  void draw()
  {
    if (start_milli < 0)
    {
      start_milli = millis();
      lastcrate = start_milli;
    }
      
    if (millis() > lastcrate + time_between_crates)
    {
      new_box();
      lastcrate = millis();
    }
      
    WareHouseSky.movePos(0,-0.02);
    WareHouseSky.draw();

    for (int j = 0; j < 10; j++)
    {
      box_current_x = crate_locations[j].x;
      if (box_current_x > -1000)
      {
        box_current_x -= crate_speed;
        crate_locations[j].x = box_current_x; 
      }
      else
      {
         j = 9999;
      }
    }
    
    box_current_x = crate_locations[focus_crate].x + camera_crate_offset;
    
    // If there is no box, go to the far right
    if (box_current_x < -1000)
      box_current_x = 600;
    
    
    // attempt to draw the box in the middle of the screen but clamp it such that we don't move the camera off screen
    float camera_x = box_current_x;
    if (camera_x > 512 - 64)
      camera_x = 512 - 64;
    if (camera_x < 64)
      camera_x = 64;
      
    if (camera_x > current_camera_x)
    {
      current_camera_x += 0.1 * (camera_x - current_camera_x);
    }
    else if (camera_x < current_camera_x)
    {
      current_camera_x -= 0.1 * (current_camera_x - camera_x);
    }
    
    // if we are close to the crate we should draw the crate UI:
    drawui = false;
    if (abs(current_camera_x - box_current_x) < 5 || box_current_x < 64)
    {
        drawui = true;
    }
      
    // relationship from camera to the midpoint of the texture will be:
    float BGpos = -1 * current_camera_x + 256 + 64;
    WareHouseBG.setPos(BGpos,64);
    WareHouseBG.draw();
    
    
    
    if (cog_current > cog_steps)
    {
      cog_current = 0;
      cogspin = 9 - cogspin;
    }
    else
    {
      cog_current++;
    }
    
    float nearest_cog = BGpos + cogspin;

    //nearest_cog -= nearest_cog % 9;
    conveyor_wheels.setPos(64 + nearest_cog % 18,103);
    conveyor_wheels.draw();
    
    //print(box_current_x + "\n");

    for( int j = 0; j < 10; j++)
    {
      float crate_x = crate_locations[j].x;
      // end of the list:
      if (crate_x < -1000)
      {
        //j = 9999;
      }
      else
      {
        if (crate_x < point_to_kill_crate)
        {
          shift_crate_list();
          j--;
        }
        else
        {
          if ((crate_locations[j].showside % 2) == 0)
          {
            Crate1.setPos(64 + crate_x - current_camera_x,51);
            Crate1.draw();
          }
          else
          {
            Crate2.setPos(64 + crate_x - current_camera_x,51);
            Crate2.draw();
          }
        }
      }
    }
    
    
    
    // Draw the black box at the bottom:
    fill(color(0,0,0));
    rect(0,128-16,128,16);

    if (drawui)
    {
      arrow_left.draw();
      arrow_right.draw();
      next_button.draw();
    }

    jitter.set_calm(cursor_y / 128.0);

    jitter.calc_jitter();
    effective_cursor_x = jitter.apply_jitter_x(cursor_x);
    effective_cursor_y = jitter.apply_jitter_y(cursor_y);
    
    Cursor.setPos(effective_cursor_x,effective_cursor_y);
    Cursor.draw();
  }
  
  void new_box()
  {
    for (int j = 0; j < 10 ; j++)
    {
      //print("trying box " + j + " : " + crate_locations[j] + "\n");     
      if (crate_locations[j].x < -1000)
      {
        crate_locations[j].x = 512 + 64;
        current_crates++;
        //print("making new box at: " + j + "\n");
        j = 9999;
      }
    }
  }
  void nextCrate()
  {
    if (focus_crate < 9)
      focus_crate += 1;
    
  }
  void shift_crate_list()
  {
      for (int j = 0;j < 9;j++)
      {
        crate_locations[j] = crate_locations[j+1];
      }
      crate_locations[9] = new crate();
      current_crates--;
      
      if (focus_crate > 0)
        focus_crate--;
  }
}

class crate
{
  float x;
  int showside;
  int[] labelneeds;
  crate()
  {
    x = -1100;
  }
  
  void resetthiscrate()
  {
    x = -1100;
    showside = 0;
  }
}