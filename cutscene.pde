

class cutscene
{
  int current_scene = 0;
  int progress;
  
  basic_image bar;
  basic_image booze;
  basic_image bank;
  
  basic_image superboss_cut1;
  basic_image superboss_cut2;
  
  basic_image gunshot;
  
  basic_image ep1;
  basic_image ep2;
  basic_image ep3;
  basic_image ep4;
  basic_image cred;
  
  cutscene()
  {
    bar = new basic_image(loadImage("data/MIT/bar.png"),64,64);
    booze = new basic_image(loadImage("data/MIT/booze.png"),64,64);
    bank = new basic_image(loadImage("data/MIT/bank.png"),64,64);
    
    superboss_cut1 = new basic_image(loadImage("data/MIT/superboss_cutscene.png"),64,64);
    superboss_cut2 = new basic_image(loadImage("data/MIT/superboss_cutscene_2.png"),64,64);
    
    gunshot = new basic_image(loadImage("data/MIT/lv3/gunshot.png"),64,64);
    
    ep1 = new basic_image(loadImage("data/MIT/epilogue/epilogue_1.png"),64,48);
    ep2 = new basic_image(loadImage("data/MIT/epilogue/epilogue_2.png"),64,48);
    ep3 = new basic_image(loadImage("data/MIT/epilogue/epilogue_3.png"),64,48);
    ep4 = new basic_image(loadImage("data/MIT/epilogue/epilogue_4.png"),64,48);
    
    cred = new basic_image(loadImage("data/MIT/epilogue/credits.png"),64,256+128);
  }
  
  
  void play_scene(int scene)
  {
    current_scene = scene;
    
    progress = 0;
  }

  
  
  void blip()
  {
    progress++;
  }
  
  void draw()
  {
    if (current_scene == 1)
    {
      bar.draw();
      if (progress == 0)
      {
        eye_c.change(true,"eyes_open_cutscene_1");
        progress++;
        make_sound.play_music("music3");
      }
      else if (progress == 2)
      {
        texter = new textbox("chap1_2_1");
        progress++;
      }
      
      if (text_box_finished)
      {
        if (text_box_finish_name.equals("chap1_2_1"))
          progress++;
        if (text_box_finish_name.equals("chap1_2_2"))
          progress++;
        if (text_box_finish_name.equals("chap1_2_4"))
          progress++;
      }
      
      if (progress == 4)
      {
        booze.fade(true);
        progress++;
      }
      
      if (progress == 5)
      {
         if (booze.fader == -1)
           progress++;
      }
      
      if (progress == 6)
      {
        texter = new textbox("chap1_2_2");
        progress++;
      }
      
      if (progress == 8)
      {
        booze.fade(false);
        progress++;
      }
      
      if (progress == 9)
      {
        if (booze.fader == -1)
          progress++;
      }
      
      if (progress == 10)
      {
        texter = new textbox("chap1_2_4");
        progress++;
      }
      
      if (progress == 12)
      {
        make_sound.stop_music();
        eye_c.change(false,"eyes_close_cutscene_1");
        progress++;
      }
      
      if (progress >= 4 && progress < 10)
      {
        booze.draw();
      }
    }
    
    else if (current_scene == 2)
    {
      if (progress < 4)
        superboss_cut1.draw();
      else
        superboss_cut2.draw();
        
      if (text_box_finished)
      {
        if (text_box_finish_name.equals("chap2_1"))
          progress++;
        if (text_box_finish_name.equals("chap2_1_mid"))
          progress++;
      }
        
      if (progress == 0)
      {
        make_sound.play_music("music4");
        eye_c.change(true,"eyes_open_cutscene_2");
        progress++;
      }
      else if (progress == 2)
      {
        texter = new textbox("chap2_1");
        progress++;
      }
      else if (progress == 4)
      {
        texter = new textbox("chap2_1_mid");
        shake_screen(2,60,60);
        progress++;
      }
      
      else if (progress == 6)
      {
        progress++;
        eye_c.change(false,"eyes_close_cutscene_2");
        make_sound.stop_music();
      }
      
    }
    
    else if (current_scene == 10)
    {
      superboss_cut2.draw();
        
      if (text_box_finished)
      {
        if (text_box_finish_name.equals("chap2_3_1"))
          progress++;
        if (text_box_finish_name.equals("chap2_3_2"))
          progress++;
      }
        
      if (progress == 0)
      {
        make_sound.play_music("music4");
        eye_c.change(true,"eyes_open_cutscene_10");
        progress++;
      }
      else if (progress == 2)
      {
        texter = new textbox("chap2_3_1");
        progress++;
      }
      else if (progress == 4)
      {
        texter = new textbox("chap2_3_2");
        shake_screen(2,60,60);
        progress++;
      }
      
      else if (progress == 6)
      {
        progress++;
        eye_c.change(false,"eyes_close_cutscene_10");
      }
    }
    else if (current_scene == 20)
    {
      superboss_cut2.draw();
        
      if (text_box_finished)
      {
        if (text_box_finish_name.equals("chap2_5_1"))
          progress++;
      }
        
      if (progress == 0)
      {
        make_sound.play_music("music4");
        eye_c.change(true,"eyes_open_cutscene_20");
        progress++;
      }
      else if (progress == 2)
      {
        texter = new textbox("chap2_5_1");
        progress++;
      }
      else if (progress == 4)
      {
        progress++;
        eye_c.change(false,"eyes_close_cutscene_20");
      }
    }
    else if (current_scene == 30)
    {
      superboss_cut2.draw();
      
      if (text_box_finished)
      {
        if (text_box_finish_name.equals("chap2_6_1"))
          progress++;
        if (text_box_finish_name.equals("chap2_6_2"))
          progress++;
      }
      
      
      if (progress == 0)
      {
        make_sound.play_music("music4");
        eye_c.change(true,"eyes_open_cutscene_30");
        progress++;
      }
      
      else if (progress == 2)
      {
        texter = new textbox("chap2_6_1");
        progress++;
      }
      else if (progress == 4)
      {
        eye_c.change(false,"");
        texter = new textbox("chap2_6_2");
        progress++;
      }
      else if (progress >= 6)
      {
         make_sound.stop_music();
         progress++;
         progress_game("end_chapter_2"); 
      }
    }
    else if (current_scene == 40)
    {
      if (progress <= 8)
        bank.draw();
      
      if (text_box_finished)
      {
        if (text_box_finish_name.equals("chap3_1"))
          progress++;
        if (text_box_finish_name.equals("chap3_2_1"))
          progress++;
        if (text_box_finish_name.equals("chap3_2_2"))
          progress++;
        if (text_box_finish_name.equals("chap3_3_1"))
          progress++;
        if (text_box_finish_name.equals("chap3_3_2"))
          progress++;
      }
      
      if (progress == 0)
      {
        jitter.MoveMarker(50);
        jitter.get_rekt(-1.0);
        make_sound.play_music("music7");
        texter = new textbox("chap3_1");
        progress++;
      }
      else if (progress == 2)
      {
        eye_c.change(true,"");
        jitter.get_rekt(0.4);
        theUI.sounds(true);
        texter = new textbox("chap3_2_1");
        progress++;
      }
      else if (progress == 4)
      {
        eye_c.change(true,"");
        jitter.get_rekt(0.4);
        texter = new textbox("chap3_2_2");
         jitter.anxiety(true);
         jitter.inaction_off();
         jitter.player_must_pump = false;
         jitter.MoveMarker(50);
        progress++;
      }
      else if (progress == 6)
      {
        eye_c.change(false,"");
        texter = new textbox("chap3_3_1");
        progress++;
      }
      else if (progress == 8)
      {
        make_sound.stop_music();
        texter = new textbox("chap3_3_2");
        progress++;
      }
      else if (progress == 10)
      {
        make_sound.play_music("music8");
        eye_c.change(true,"chapter_3_eyes_open");
        play_scene(0);
        progress++;
      }
    }
    
    else if (current_scene == 100)
    {
      if (text_box_finished)
      {
        if (text_box_finish_name.equals("epi1_2"))
          progress++;
      }
      
      
      if (progress == 0)
      {
        make_sound.play("gun");
      }
      
      if (progress < 5)
      {
        gunshot.draw();
      }
      else
      {
        fill(0,0,0);
        rect(0,0,128,128);
      }
      
      if (progress < 240)
      {
        progress++;        
      }
      
      if (progress == 0 || progress == 120)
      {
        make_sound.play("gun");
        progress++;
      }
      
      if (progress >= 240 && progress < 300)
      {
        progress++;
        float p = progress - 240;
        p /= 60.0;
        float w = lerp(0,128,p);
        
        float r = lerp(0,PI * 6.1,p);
        
        ep1.setRotate(r);
        ep1.w = w;
        ep1.h = w;
        ep1.draw();
      }
      
      if (progress >= 300)
      {
        ep1.draw();
      }
      
      if (progress == 300)
      {
        texter = new textbox("epi1_2");
        progress++;
      }
      else if (progress == 302)
      {
        eye_c.change(false,"credits");
        progress++;
      }
    }
    else if (current_scene == 110)
    {
      if (text_box_finished)
      {
        if (text_box_finish_name.equals("epi4_1"))
          progress++;
      }
      
      if (progress == 0)
      {
        make_sound.play("gun");
      }
      
      if (progress < 5)
      {
        gunshot.draw();
      }
      else
      {
        fill(0,0,0);
        rect(0,0,128,128);
      }
      
      if (progress < 240)
      {
        progress++;        
      }
      
      if (progress == 0 || progress == 120)
      {
        make_sound.play("gun");
        progress++;
      }
      
      if (progress >= 240 && progress < 300)
      {
        progress++;
        float p = progress - 240;
        p /= 60.0;
        float w = lerp(0,128,p);
        
        float r = lerp(0,PI * 6.1,p);
        
        ep2.setRotate(r);
        ep2.w = w;
        ep2.h = w;
        ep2.draw();
      }
      
      if (progress >= 300)
      {
        ep2.draw();
      }
      
      if (progress == 300)
      {
        texter = new textbox("epi4_1");
        progress++;
      }
      else if (progress == 302)
      {
        eye_c.change(false,"credits");
        progress++;
      }
    }
    
    else if (current_scene == 120)
    {
      if (text_box_finished)
      {
        if (text_box_finish_name.equals("epi2_1_1"))
          progress = 240;
        if (text_box_finish_name.equals("epi2_2"))
          progress++;
      }
      
      if (progress == 0)
      {
        make_sound.play("gun");
      }
      
      if (progress < 5)
      {
        gunshot.draw();
      }
      else
      {
        fill(0,0,0);
        rect(0,0,128,128);
      }
      
      if (progress < 120)
      {
        progress++;        
      }
      
      if (progress == 0)
      {
        progress++;
      }
      
      if (progress == 120)
      {
        texter = new textbox("epi2_1_1");
        progress++;
      }
      
      if (progress >= 240 && progress < 300)
      {
        progress++;
        float p = progress - 240;
        p /= 60.0;
        float w = lerp(0,128,p);
        
        float r = lerp(0,PI * 6.1,p);
        
        ep3.setRotate(r);
        ep3.w = w;
        ep3.h = w;
        ep3.draw();
      }
      
      if (progress >= 300)
      {
        ep3.draw();
      }
      
      if (progress == 300)
      {
        texter = new textbox("epi2_2");
        progress++;
      }
      else if (progress == 302)
      {
        eye_c.change(false,"credits");
        progress++;
      }
    }
    
    else if (current_scene == 130)
    {
      fill(0,0,0);
      rect(0,0,128,128);
      if (text_box_finished)
      {
        if (text_box_finish_name.equals("epi3_1_1"))
          progress++;
        if (text_box_finish_name.equals("epi3_1_2"))
        {
          progress++;
          shake_screen(0,0,0);
        }
        if (text_box_finish_name.equals("epi3_2"))
          progress++;
      }
      
      if (progress == 0)
      {
        eye_c.change(false,"");
        texter = new textbox("epi3_1_1");
        progress++;
      }
      
      if (progress >= 2 && progress <= 180)
      {
        progress++;
      }
      
      if (progress == 140)
      {
        make_sound.play("gunclick");
      }
      
      if (progress == 181)
      {
        texter = new textbox("epi3_1_2");
        
        eye_c.change(true,"");
        progress++;
      }
      else if (progress == 183)
      {
        progress = 240;
      }
      
      if (progress >= 240 && progress < 300)
      {
        progress++;
        float p = progress - 240;
        p /= 60.0;
        float w = lerp(0,128,p);
        
        float r = lerp(0,PI * 6.1,p);
        
        ep4.setRotate(r);
        ep4.w = w;
        ep4.h = w;
        ep4.draw();
      }
      
      if (progress >= 300)
      {
        ep4.draw();
      }
      
      if (progress == 300)
      {
        texter = new textbox("epi3_2");
        
        progress++;
      }
      else if (progress == 302)
      {
        eye_c.change(false,"credits");
        progress++;
      }
    }
    
    else if (current_scene == 1000)
    {
      if (progress == 0)
      {
        cred.setPos(64,512+128);
        make_sound.play_music("music3");
        eye_c.change(true,"");
      }
      fill(0,0,0);
      rect(0,0,128,128);
      progress++;
      
      cred.movePos(0,-0.25);
      cred.draw();
      
      if (progress > ((1024 + 256) / 0.25))
      {
        eye_c.change(false,"game_reset");
      }
    }
  }
  
  
}