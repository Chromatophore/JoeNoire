



class level3
{
	
	int spro = 0;
	void level_state(int state)
	{
		if (state == 0)
		{
			cutscene_engine.play_scene(40);
		}
		else if (state == 3)
		{
			texter = new textbox("chap3_4_1");
			gold_frame_delay = 0;
		}
		else if (state == 5)
		{
			texter = new textbox("chap3_4_3");
			fader = 0;
		}
		else if (state == 6)
		{
			necklace.fade(true);
		}
		
		else if (state == 7)
		{
			// goes for the necklace 1st time
				texter = new textbox("chap3_4_5");
		}
		else if (state == 8)
		{
			// goes for the necklace 2nd time
				texter = new textbox("chap3_4_5_2");
		}
		else if (state == 9)
		{
			// goes for the necklace 3rd time
				texter = new textbox("chap3_4_5_3");
		}
		else if (state == 10)
		{
			// goes for the necklace the final time
				texter = new textbox("epi1_1_1");
				shake_screen(4,300,0);
		}
		else if (state == 50)
		{
			cutscene_engine.play_scene(100);
		}
		else if (state == 60)
		{
			cutscene_engine.play_scene(110);
		}
		else if (state == 70)
		{
			cutscene_engine.play_scene(120);
		}
		else if (state == 80)
		{
			cutscene_engine.play_scene(130);
		}
		
		if (state >= 50 && state <= 80)
		{
			make_sound.stop_music();
			theUI.sounds(false);
			jitter.anxiety(false);
			jitter.inaction_off();
			jitter.player_must_pump = false;
		}
		
		spro = state;
	}
	
	void sequence_hook()
	{
		if (text_box_finished)
		{
			if (text_box_finish_name.equals("chap3_3_3"))
			{
					theUI.go_chill();
					
					theUI.sounds(true);
					jitter.anxiety(true);
					jitter.inaction_on();
					jitter.player_must_pump = true;
			}
			if (text_box_finish_name.equals("chap3_4_2_2"))
			{
				if (tiepin_get && watch_get)
					level_state(5);
			}
			if (text_box_finish_name.equals("chap3_4_2_1"))
			{
				if (tiepin_get && watch_get)
					level_state(5);
			}
			if (text_box_finish_name.equals("chap3_4_3"))
			{
				level_state(6);
			}
			if (text_box_finish_name.equals("epi1_1_1"))
			{
				level_state(50);
			}
		}
	}
	
	basic_image arm_down;
	basic_image arm_up;
	basic_image family;
	basic_image man_base;
	basic_image necklace;
	basic_image tiepin;
	basic_image watch;
	
	boolean out_message = false;
	
	level3()
	{
			arm_down = new basic_image(indi_loadImage("data/MIT/lv3/arm_down.png"),64,64);
			arm_up = new basic_image(indi_loadImage("data/MIT/lv3/arm_up.png"),64,64);
			family = new basic_image(indi_loadImage("data/MIT/lv3/family.png"),64,64);
			man_base = new basic_image(indi_loadImage("data/MIT/lv3/man_base.png"),64,64);
			necklace = new basic_image(indi_loadImage("data/MIT/lv3/necklace.png"),64,64);
			tiepin = new basic_image(indi_loadImage("data/MIT/lv3/tiepin.png"),64,64);
			watch = new basic_image(indi_loadImage("data/MIT/lv3/watch.png"),64,64);
			
			level_state(0);
	}
	
	float fader = -1;
	
	int gold_frame_delay = -1;
	
	
	void callback(int cb)
	{
		if (cb == 1)
		{
			texter = new textbox("chap3_3_3");
		}
	}
	
	int time_at_minimum = 0;
	boolean shoot_state = false;
	void draw()
	{
		sequence_hook();
		

		if (theUI.markerpos < 0.25 && jitter.get_state() < 0.3 && spro >= 3 && spro < 50 && texter == null)
		{
			time_at_minimum++;
		}
		
		if (time_at_minimum > 600 && !out_message && texter == null)
		{
			out_message = true;
			texter = new textbox("epi_secret_quit");
			theUI.hijack_quit = true;
		}
			
		if (theUI.markerpos > 0.75 && jitter.get_state() < 0.3)
		{
			shoot_state = true;
		}
		else
		{
			shoot_state = false;
		}
		
		theUI.OverrideCursor(true, guncursor);
		
		
		fill(black);
		if (fader >= 0)
		{
			if (fader < 40)
				fader += 0.1;
			fill(fader,fader,fader);
		}
		
		
		indi_rect(0,0,128,128);
		
		family.draw();
		man_base.draw();
		
		if (spro < 3)
			arm_up.draw();
		else
			arm_down.draw();
			
		if (gold_frame_delay > 60)
		{
			if (!watch_get)
				watch.draw();
			if (!tiepin_get)
					tiepin.draw();
				
			
		}
		else if (gold_frame_delay >= 0)
		{
			gold_frame_delay++;
		}
		
		if (spro >= 6 && spro <= 10)
		{
			necklace.draw();
		}
		
		
	}
	
	boolean watch_get;
	boolean tiepin_get;
	
	void TakeInput(inputblob inp)
	{
		if (spro >= 50)
			return;
			
		if (inp.x_down)
		{
			float effective_cursor_x = theUI.GetCursorX();
			float effective_cursor_y = theUI.GetCursorY();
			
			if (shoot_state)
			{
				if (box_test(effective_cursor_x, effective_cursor_y,	60,88, 20,20) || 
						box_test(effective_cursor_x, effective_cursor_y,	20,70, 20,20))
				{
					level_state(60);
				}
				else if (box_test(effective_cursor_x, effective_cursor_y,	99,85, 10,20))
				{
					level_state(70);
				}
				
				
			}
			else
			{
				// check if over the money
			if (box_test(effective_cursor_x, effective_cursor_y,	56,90, 13,10) && spro == 0)
			{
				level_state(3);
			}
			else if (box_test(effective_cursor_x, effective_cursor_y,	87,102, 13,10) && spro >= 3 && !watch_get)
			{
				watch_get = true;
				texter = new textbox("chap3_4_2_2");
			}
			else if (box_test(effective_cursor_x, effective_cursor_y,	59,88, 5,5) && spro >= 3 && !tiepin_get)
			{
				tiepin_get = true;
				texter = new textbox("chap3_4_2_1");
			}
			else if (box_test(effective_cursor_x, effective_cursor_y,	25,60, 10,10) && spro >= 6 && spro <= 9)
			{
				level_state(spro + 1);
			}

			}
			
			
			if (out_message && effective_cursor_x <= 15 && effective_cursor_y >= 128 - 9 && spro < 50)
			{
				level_state(80);
					
			}
			
			
			
		}
		
	}
	
}