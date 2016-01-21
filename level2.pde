// level 2 OH LORDY LORD

basic_image coin_gfx[];

coin[] coinpile;

float coin_speed = 80.0/60;
float gravity = 3.0/60;

class level2
{
  basic_image HeistBG;
  basic_image bagcursor;
  
  float bag_accumulator;
  
  int c_timer = 0;
  int next_coin = 0;
  level2()
  {
    coin_gfx = new basic_image[10];
    for (int j = 0;j < 10; j++)
    {
      coin_gfx[j] = new basic_image(loadImage("data/MIT/coin" + str(j) + ".png"),64,64);      
    }
    
    coinpile = new coin[100];
    
    HeistBG = new basic_image(loadImage("data/MIT/lv2/heist.png"),64,64);
    bagcursor = new basic_image(loadImage("data/MIT/lv2/bagcursor.png"),64,64);
    
    bag_accumulator = 0;
  }
  
  void draw()
  {
    HeistBG.draw();
    
    theUI.OverrideCursor(true, bagcursor);
    
    c_timer++;
    if (c_timer % 10 == 0)
    {
      coinpile[next_coin % 100] = new coin(64,20,coin_speed);
      next_coin++;
    }
    
    float effective_cursor_x = theUI.GetCursorX();
    float effective_cursor_y = theUI.GetCursorY();
    
    float panic_state = constrain(0.8 - jitter.overall_state,0,1);
    
    
    float size_allow = 10;
    
    for (int j = 0; j < 100; j++)
    {
      coin c = coinpile[j];
      if (c != null)
      {
        boolean hit_curs = false;
        
        if (c.immunity_time <= 0)
          hit_curs = box_test(effective_cursor_x, effective_cursor_y, c.x, c.y, size_allow,size_allow);
        
        if (hit_curs)
        {
          if (!c.bounce(panic_state))
          {
            make_sound.play("good");
            coinpile[j] = null;
            scorer.add_riser(new score_riser(effective_cursor_x, effective_cursor_y, "", 2));
          }
          //AddSad();
        }
        else
        {
          if (c.draw())
          {
             coinpile[j] = null;
          }
        }
      }
    }
    
    if (abs(bag_accumulator) > 0)
      bag_accumulator *= 0.9;
    
    fill(color(0,0,0));
    rect(0,128-16,128,16);
  }
  
  void TakeInput(inputblob i)
  {
    if (i.z_down)
    {
       shake_screen(1,60,60); 
    }
    
    bag_accumulator = constrain(bag_accumulator + i.x_axis,-10,10);
    //println(bag_accumulator);
    bagcursor.setRotate((bag_accumulator / 20) * (PI / 3.0));
    
  }
}

class coin
{
    float x;
    float y;
    int frame;
    
    float vx;
    float vy;
    
    int immunity_time = 0;
    
    coin(float xpos, float ypos, float velmag)
    {
      x = xpos;
      y = ypos;
      frame = 0;
      
      float angle = (random(1) - 0.5) * PI;
      
      vx = sin(angle) * velmag;
      vy = -1 * cos(angle) * velmag;
      
      immunity_time = 30;
    }
    
    boolean draw()
    {
      if (immunity_time > 0)
        immunity_time--;
      if (frame > 9)
        frame = 0;
      
      x += vx;
      y += vy;
      
      vy += gravity;
                
      coin_gfx[frame].setPos(x,y);
      coin_gfx[frame].draw();
      
      if ((x < 6 && vx < 0) || (vx > 0 && x > (128 - 6)))
      {
        vx = -vx;
      }
      
      frame++;
      
      if (y > 136)
        return true;
      else
        return false;
    }
    
    boolean bounce(float likelihood)
    {
      if (random(1) < likelihood)
      {
        float mag = dist(vx,vy,0,0);
        float angle = (random(1) - 0.5) * PI;
        
        vx = sin(angle) * mag;
        vy = -1 * cos(angle) * mag;
        immunity_time = 15;
        return true;
      }
      else
        return false;
    }
}