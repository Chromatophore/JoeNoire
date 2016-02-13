// level 2 OH LORDY LORD

basic_image coin_gfx[];

coin[] coinpile;

float coin_speed = 80.0/60;
float gravity = 3.0/60;

class level2
{
  
  int spro = 0;
  void level_state(int state)
  {
    if (state == 0)
    {
      theUI.OverrideCursor(false, null);
      theUI.SetCursorConstraints(0,48,127,127);
      texter = new textbox("chap2_1_2");
      state = 1;
      jitter.get_rekt(-1);
      
      theUI.SetSmiles(0);
      theUI.SetSads(0);
    }
    else if (state == 2)
    {
      jitter.MoveMarker(75);
      eye_c.change(true,"");
      shake_screen(1,120,120);
      texter = new textbox("chap2_2_1");
    }
    else if (state == 3)
    {
       game_on = true; 
       next_t = 300;
       texter = new textbox("chap2_2_2");
       
       theUI.sounds(true);
       jitter.anxiety(true);
       jitter.inaction_on();
       jitter.player_must_pump = true;
       
       
       make_sound.play_music("music5");
    }
    else if (state == 20)
    {
       game_on = false; 
       texter = new textbox("chap2_2_4");

       theUI.sounds(false);
       jitter.anxiety(false);
       jitter.inaction_off();
       jitter.player_must_pump = false;
       
       theUI.OverrideCursor(false, null);
       eye_c.change(false,"");
    }
    
    else if (state == 50)
    {
      eye_c.change(true,"heist2_eyes_open");
      
      theUI.ResetCursor();
      theUI.SetSmiles(0);
      theUI.SetSads(0);
      
      make_sound.stop_music();
    }
    else if (state == 51)
    {
      texter = new textbox("chap2_5_2");
      
       theUI.sounds(true);
       jitter.anxiety(true);
       jitter.inaction_off();
       jitter.player_must_pump = false;
       jitter.MoveMarker(50);
    }
    else if (state == 60)
    {
        texter = new textbox("chap2_5_5"); 
        make_sound.play("gun");
        make_sound.play("alarm");
        make_sound.play_music("music6");
        jitter.get_rekt(-0.6);
        jitter.MoveMarker(50);
        
        shards = new shard[5];
        for (int j = 0;j<5;j++)
        {
           shards[j] = new shard(shard_image, 64,20); 
        }
        
        theUI.special_race_mode(true);
        theUI.cursor_x = 64;
        
        float start_y = 128 - 24;
        theUI.cursor_y = 128 - 24;
        
        
        bagcursor_L.x_float = 22;
        bagcursor_R.x_float = 100;
        
        bagcursor_L.y_float = start_y;
        bagcursor_R.y_float = start_y;
        
        enemybag1_vx = 1;
        enemybag2_vx = 3;
        
        theUI.SetCursorConstraints(20,0,108,127);
    }
    else if (state == 70 || state == 71)
    {
       game_on = false;
       theUI.sounds(false);
       jitter.anxiety(false);
       jitter.inaction_off();
       jitter.player_must_pump = false;
       
       
        theUI.special_race_mode(false);
        theUI.ResetCursor();
        
        if (state == 70)
        {
          texter = new textbox("chap2_5_6_win"); 
        }
        else
        {
          texter = new textbox("chap2_5_6_lose");
        }
    }
    
    spro = state;
  }
  
  void sequence_hook()
  {
    if (text_box_finished)
    {
      if (spro < 50)
      {
        if (text_box_finish_name.equals("chap2_1_2"))
        {
           level_state(2); 
        }
        if (text_box_finish_name.equals("chap2_2_1"))
        {
           level_state(3); 
        }
        if (text_box_finish_name.equals("chap2_2_4"))
        {
          eye_c.change(false,"level_2_cutscene_1");
        }
      }
      
      if (text_box_finish_name.equals("chap2_5_2"))
        preshoot = true;

      if (text_box_finish_name.equals("chap2_5_5"))
      {
        game_on = true;
        preshoot = false;
        jitter.inaction_on();
        jitter.player_must_pump = true;
      }
      
      if ((text_box_finish_name.equals("chap2_5_6_win")) ||
          (text_box_finish_name.equals("chap2_5_6_lose")))
      {
        eye_c.change(false,"level2_finalend");
        make_sound.stop_music();
      }
    }
  }
  
  void race(int xtra)
  {
    level_state(50 + xtra);
  }
  
  int smiles = 0;
  int sads = 0;
  
  void AddSmile()
  {
    smiles++;
    theUI.SetSmiles(smiles);
  }
  
  void AddSad()
  {
    sads++;
    theUI.SetSads(sads);
  }
  
  
  basic_image HeistBG;
  basic_image Heist2BG;
  basic_image Heist2BG_break;
  basic_image bagcursor;
  
  basic_image bagcursor_L;
  basic_image bagcursor_R;
  
  basic_image[] ring_treasures;
  
  
  
  float bag_accumulator;
  
  int c_timer = 0;
  int next_coin = 0;
  
  int t_timer = 0;
  int next_treasure = 0;
  
  treasure[] ringpile;
  
  shard[] shards;
  basic_image shard_image;
  
  boolean preshoot = false;
  
  level2()
  {
    coin_gfx = new basic_image[10];
    for (int j = 0;j < 10; j++)
    {
      coin_gfx[j] = new basic_image(loadImage("data/MIT/lv2/coin" + str(j) + ".png"),64,64);      
    }
    
    coinpile = new coin[100];
    ringpile = new treasure[20];
    
    HeistBG = new basic_image(loadImage("data/MIT/lv2/heist.png"),64,64);
    Heist2BG = new basic_image(loadImage("data/MIT/lv2/heist_2.png"),64,64);
    Heist2BG_break   = new basic_image(loadImage("data/MIT/lv2/heist_2_break.png"),64,64);
    bagcursor = new basic_image(loadImage("data/MIT/lv2/bagcursor.png"),64,64);
    
    bagcursor_L = new basic_image(loadImage("data/MIT/lv2/goonbag1.png"),-64,64);
    bagcursor_R = new basic_image(loadImage("data/MIT/lv2/goonbag2.png"),-64,64);
    
    shard_image = new basic_image(loadImage("data/MIT/lv2/glass_shatter.png"),-64,64);
    
    ring_treasures = new basic_image[4];
    
    ring_treasures[0] = new basic_image(loadImage("data/MIT/lv2/ring_blue.png"),64,64);
    ring_treasures[1] = new basic_image(loadImage("data/MIT/lv2/ring_green.png"),64,64);
    ring_treasures[2] = new basic_image(loadImage("data/MIT/lv2/ring_pink.png"),64,64);
    ring_treasures[3] = new basic_image(loadImage("data/MIT/lv2/ring_red.png"),64,64);
    
    bag_accumulator = 0;
    
    game_on = false;
    
    level_state(0);
  }
  
  boolean game_on;
  
  
  int lastgoon = 0;
  
  float enemybag1_x = -100;
  float enemybag2_x = -100;
  
  float enemybag1_vx = -100;
  float enemybag2_vx = -100;
  int norepeats = 0;
  
  int next_t;
  
  int rings = 50;
  
  void draw()
  {
    sequence_hook();
    
    
    if (spro < 50)
      HeistBG.draw();
    else
      Heist2BG.draw();
      
    if (spro >= 60)
    {
       Heist2BG_break.draw(); 
    }
    
    if (preshoot == true)
    {
      theUI.OverrideCursor(true, guncursor);
      
    }
    
    for (int j = 0; j < 5; j++)
    {
      if (shards != null)
      {
        if (shards[j] != null)
        {
          if (shards[j].draw())
          {
            shards[j] = null;
          }
        }
      }
    }
    
    
    if (!game_on)
    {
      return;
    }
    
    theUI.OverrideCursor(true, bagcursor);
    
    
    c_timer++;
    if (c_timer % 10 == 0 && (rings > 1 || spro == 60))
    {
      coinpile[next_coin % 100] = new coin(64,20,coin_speed);
      next_coin++;
    }
    
    if (spro < 50)
    {
      t_timer++;
      if (t_timer > next_t)
      {
        if (rings > 0)
        {
          next_t = 50 + int(random(100));
          t_timer = 0;
          rings--;
          
           ringpile[next_treasure % 20] = new treasure(64,20,coin_speed, ring_treasures[int(random(4))]);
           next_treasure++;
           
           if (random(100) > 50)
           {
             // pick a random side
             boolean right = (random(100) > 50); 
             
             float speed = 4;
             float rotation = 0.3;
             float pos = -15;
             if (right)
             {
               speed = -speed;
               pos = 15 + 128;
               rotation = -rotation;
             }
             
             if (lastgoon == 0)
             {
               bagcursor_L.setPos(pos,20);
               bagcursor_L.setRotate(rotation);
               enemybag1_vx = speed;
             }
             else
             {
               bagcursor_R.setPos(pos,20);
               bagcursor_R.setRotate(rotation);
               enemybag2_vx = speed;
             }
             
             lastgoon = 1 - lastgoon;
           }
        }
        else
        {
          if (rings == 0 && spro < 20)
            level_state(20);
        }
      }
    }
    
    float effective_cursor_x = theUI.GetCursorX();
    float effective_cursor_y = theUI.GetCursorY();
    
    float panic_state = constrain(0.8 - jitter.overall_state,0,1);
    
    if (spro < 50)
    {
      if (enemybag1_vx > -100)
        bagcursor_L.movePos(enemybag1_vx,0);
        
      if (bagcursor_L.x_float < -30 || bagcursor_L.x_float > 150)
        enemybag1_vx = -100;
        
      if (enemybag2_vx > -100)
        bagcursor_R.movePos(enemybag2_vx,0);
        
      if (bagcursor_R.x_float < -30 || bagcursor_R.x_float > 150)
        enemybag2_vx = -100;
    }
    else
    {
      bagcursor_L.movePos(enemybag1_vx,0);
      if (bagcursor_L.x_float < 0 && enemybag1_vx < 0)
      {
        enemybag1_vx = -enemybag1_vx;
      }
      else if  (bagcursor_L.x_float > 43 && enemybag1_vx > 0)
      {
        enemybag1_vx = -enemybag1_vx;
      }
      
      bagcursor_R.movePos(enemybag2_vx,0);
      
      if (bagcursor_R.x_float < 85 && enemybag2_vx < 0)
      {
        enemybag2_vx = -enemybag2_vx;
      }
      else if  (bagcursor_R.x_float > 128 && enemybag2_vx > 0)
      {
        enemybag2_vx = -enemybag2_vx;
      }
      
      
      // check everyone's heights
      
      if (spro == 60)
      {
        float winnerheight = 37;
        if (theUI.cursor_y <= winnerheight)
        {
          level_state(70);
        }
        else if (bagcursor_R.y_float <= winnerheight || bagcursor_L.y_float <= winnerheight)
        {
          level_state(71);
        }
      }
      
      
      
    }
      
    bagcursor_L.draw();
    bagcursor_R.draw();
    
    float size_allow = 10;
    
    for (int j = 0; j < 100; j++)
    {
      coin c = coinpile[j];
      if (c != null)
      {
        boolean hit_curs = false;
        
        float enemy_grab = size_allow;
        if (spro > 50)
        {
          enemy_grab = 5;
        }
        
        if (box_test(bagcursor_L.x_float, bagcursor_L.y_float, c.x, c.y, enemy_grab,enemy_grab))
        {
           coinpile[j] = null;
           
           if (spro > 50)
             bagcursor_L.y_float -= 0.8;

        }
        else if (box_test(bagcursor_R.x_float, bagcursor_R.y_float, c.x, c.y, enemy_grab,enemy_grab))
        {
           coinpile[j] = null;
           if (spro > 50)
             bagcursor_R.y_float -= 0.8;
        }
        
        
        
        if (c.immunity_time <= 0)
          hit_curs = box_test(effective_cursor_x, effective_cursor_y, c.x, c.y, size_allow,size_allow);
        
        if (hit_curs)
        {
          if (!c.bounce(panic_state))
          {
            make_sound.play("good");
            jitter.get_rekt(-0.01);
            coinpile[j] = null;
            scorer.add_riser(new score_riser(effective_cursor_x, effective_cursor_y, "", 2));
            
            if (spro > 50)
              theUI.mod_up(-1);
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
    
    for (int j = 0; j < 20; j++)
    {
      treasure c = ringpile[j];
      if (c != null)
      {
        boolean hit_curs = false;
        
        int randchat = -1;
        boolean swiped = false;
        if (box_test(bagcursor_L.x_float, bagcursor_L.y_float, c.x, c.y, size_allow,size_allow))
        {
          swiped = true;
          scorer.add_riser(new score_riser(bagcursor_L.x_float - 10, bagcursor_L.y_float, "stolen?? ring", 3));
        }
        else if (box_test(bagcursor_R.x_float, bagcursor_R.y_float, c.x, c.y, size_allow,size_allow))
        {
          swiped = true;
          scorer.add_riser(new score_riser(bagcursor_R.x_float - 10, bagcursor_R.y_float, "stolen?? ring", 3));
        }
        
        if (swiped)
        {
           AddSad();
            make_sound.play("bad");
            ringpile[j] = null;
            jitter.get_rekt(0.05);
            shake_screen(1,30,30);
            randchat = int(random(5));
        }
        
        if (randchat >= 0 && (texter == null))
        {
          if (randchat == 0  && ((norepeats & 1) == 0))
          {
            texter = new textbox("chap2_2_3_1");
            norepeats |= 1;
          }
          else if (randchat == 1 && ((norepeats & 2) == 0))
          {
            texter = new textbox("chap2_2_3_2");
            norepeats |= 2;
          }
          else if (randchat == 2 && ((norepeats & 4) == 0))
          {
            texter = new textbox("chap2_2_3_3");
            norepeats |= 4;
          }
        }

        if (c.immunity_time <= 0)
          hit_curs = box_test(effective_cursor_x, effective_cursor_y, c.x, c.y, size_allow,size_allow);
        
        if (hit_curs)
        {
          if (!c.bounce(panic_state))
          {
            AddSmile();
            make_sound.play("good");
            ringpile[j] = null;
            scorer.add_riser(new score_riser(effective_cursor_x, effective_cursor_y, "ring get", 2));
          }
          //AddSad();
        }
        else
        {
          if (c.draw())
          {

            AddSad();
            make_sound.play("bad");
            ringpile[j] = null;
            scorer.add_riser(new score_riser(c.x - 10, c.y - 30, "missed ring", 3));
            jitter.get_rekt(0.05);
            shake_screen(1,30,30);
            
            ringpile[j] = null;
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
    
    if (preshoot)
    {
      if (spro == 51 || spro == 52)
      {
        float effective_cursor_x = theUI.GetCursorX();
        float effective_cursor_y = theUI.GetCursorY();
        if (i.x_down)
        {
          if (box_test(effective_cursor_x,effective_cursor_y, 64, 16, 12,12))
          {
            if (jitter.get_state() > 0.3)
            {
              make_sound.play("beep"); 
              
              if (spro == 51)
                texter = new textbox("chap2_5_3");
              
              level_state(52);
            }
            else
            {
              level_state(60);
            }
          }
          
        }
        
      }
      
    }
    
    if (!game_on)
      return;
    
    bag_accumulator = constrain(bag_accumulator + i.x_axis,-10,10);
    //println(bag_accumulator);
    bagcursor.setRotate((bag_accumulator / 20) * (PI / 3.0));
    
  }
}

class shard
{
   float x;
   float y;
   
    float vx;
    float vy;
   
   float rotation;
   float rot_spd;
   
   basic_image refBI;
   shard(basic_image pShard, float xpos, float ypos)
   {
     refBI = pShard;
     x = xpos;
     y = ypos;
    float angle = (random(0.8) - 0.4) * PI;
    
    vx = sin(angle) * 1;
    vy = -1 * cos(angle) * 1;
    
    rot_spd = random(0.3);
    if (rot_spd > 0)
      rot_spd += 0.1;
    else
      rot_spd -= 0.1;
   }
   
    boolean draw()
    {
      rotation += rot_spd;
      
      x += vx;
      y += vy;
      
      vy += gravity;
                
      refBI.setRotate(rotation);
      refBI.setPos(x,y);
      refBI.draw();
      
      if (y > 136)
        return true;
      else
        return false;
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
      
      float angle = (random(0.8) - 0.4) * PI;
      
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

class treasure
{
    float x;
    float y;
    float rotation;
    
    basic_image refBI;
    
    float rot_spd;
    
    float vx;
    float vy;
    
    int immunity_time = 0;
    
    treasure(float xpos, float ypos, float velmag, basic_image pRefBI)
    {
      x = xpos;
      y = ypos;
      
      rot_spd = random(0.5);
      if (rot_spd > 0)
        rot_spd += 0.5;
      else
        rot_spd -= 0.5;
      
      float angle = (random(1) - 0.5) * PI;
      
      vx = sin(angle) * velmag;
      vy = -1 * cos(angle) * velmag;
      
      immunity_time = 30;
      
      refBI = pRefBI;
    }
    
    boolean draw()
    {
      if (immunity_time > 0)
        immunity_time--;

      rotation += rot_spd;
      
      x += vx;
      y += vy;
      
      vy += gravity;
                
      refBI.setRotate(rotation);
      refBI.setPos(x,y);
      refBI.draw();
      
      if ((x < 6 && vx < 0) || (vx > 0 && x > (128 - 6)))
      {
        vx = -vx;
      }
      
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