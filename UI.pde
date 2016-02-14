
int marker_max = 36;
int bar_max = 42;

float tracker_reducer = 35.0;

class UI
{
	boolean is_on;
	
	basic_image ui_base;
	basic_image ui_base1;
	basic_image ui_base2;

	basic_image volume_graphic;
	basic_image volume_title;
	
	basic_image marker;
	basic_image marker2;
	
	basic_image Cursor;
	basic_image Cursor_Replace;

	basic_image cindicate1;
	basic_image cindicate2;
	basic_image cindicate3;
	basic_image cindicate4;
	boolean show_learn_c = false;

	basic_image learn2c1;
	basic_image learn2c2;
	
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

	void draw_volume(boolean title)
	{
		int volume_display = round((100.0 / 30.0) * (global_gain + 40));
		if (title)
		{
			volume_title.draw();
			text(str(volume_display),128-11,7);
		}
		else
		{
			volume_graphic.draw();
			text(str(volume_display),9,128 - 9);
		}
	}

	UI()
	{
		ui_base = new basic_image(loadImage("data/MIT/UI/UI_base.png"), 64,128 - 8);
		ui_base1 = new basic_image(loadImage("data/MIT/UI/UI_base_a.png"), 64,128 - 8);
		ui_base2 = new basic_image(loadImage("data/MIT/UI/UI_base_b.png"), 64,128 - 8);
		marker = new basic_image(loadImage("data/MIT/UI/calm_marker.png"), 64,128 - 10);
		marker2 = new basic_image(loadImage("data/MIT/UI/calm_marker2.png"), 64,128 - 10);
		
		Cursor = new basic_image(loadImage("data/MIT/UI/cursor1.png"),64,64);
		
		chillimg = new basic_image(loadImage("data/MIT/UI/panic.png"),97,128 - 16 + 12);

		learn2c1 = new basic_image(loadImage("data/MIT/UI/learn2c1.png"), 64,64);
		learn2c2 = new basic_image(loadImage("data/MIT/UI/learn2c2.png"), 64,64);

		learn2c1 = new basic_image(loadImage("data/MIT/UI/learn2c1.png"), 64,64);
		learn2c2 = new basic_image(loadImage("data/MIT/UI/learn2c2.png"), 64,64);

		cindicate1 = new basic_image(loadImage("data/MIT/UI/cindicate1.png"), 64,128-23);
		cindicate2 = new basic_image(loadImage("data/MIT/UI/cindicate2.png"), 64,128-23);
		cindicate3 = new basic_image(loadImage("data/MIT/UI/cindicate3.png"), 64,128-23);
		cindicate4 = new basic_image(loadImage("data/MIT/UI/cindicate4.png"), 64,128-23);

		PImage volume_art = loadImage("data/MIT/UI/volume.png");
		volume_title = new basic_image(volume_art, 128 - 16, 6);
		volume_graphic = new basic_image(volume_art, 4, 128 - 10);

		donetracks = new completed_track[100];
		playertracks = new completed_track[100];
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
			
		fill(black);
		indi_rect(0,128-16,128,16);
		
		textFont(font_ui, 14);
		
		fill(lgrey);
		
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
		indi_rect(64 - panic_bar, 128 - 14, 2 * panic_bar, 12);
		
		ui_base.draw();
		
		if (chill)
			ui_base2.draw();
		else
			ui_base1.draw();
		
		fill(white);
		
		String number = str(smiles);
		if (number.length() == 1)
			number = "0" + number;


		text(number,118,119);
		number = str(sads);
		if (number.length() == 1)
			number = "0" + number;
		text(number,118,125);

		draw_volume(false);
		
		if (marker_pulse)
		{
			marker2.draw();
		}
		else
		{
			marker.draw();
		}


		if (show_pulse_tracker)
		{
			// Pulse marker stuff:
			fill(dgrey);
			indi_rect(0,128-17,128,2);

			// update interval count?
			tracker_intervals = jitter.get_current_beat_cycle();

			float bar_width = (tracker_intervals / tracker_reducer);

			float start_x = 64 - bar_width + (tracker_target - millis()) / tracker_reducer;

			boolean alternate = marker_pulse;

			int bar_count = 0;
			while (start_x < 128)
			{
				if (alternate)
					fill(lgrey);
				else
					fill(dgrey);

				if (bar_count == 2)
					bar_width = (tracker_intervals / tracker_reducer);
				bar_count++;

				indi_rect(start_x,128-17,bar_width,2);

				start_x += bar_width;
				alternate = !alternate;
			}

			// previous display bars
			for (int j = 0; j < 100; j++)
			{
				completed_track t = donetracks[j];
				if (t != null)
				{
					if (t.draw())
					{
						donetracks[j] = null;
					}
				}
			}
			// previous held bars:
			for (int j = 0; j < 100; j++)
			{
				completed_track t = playertracks[j];
				if (t != null)
				{
					if (t.draw())
					{
						playertracks[j] = null;
					}
				}
			}

			// tiny marker:
			fill(black);
			indi_rect(64-0.25,128-17,0.5,2);

			// Held bars:
			if (tracker_held)
			{
				bar_width = (millis() - tracker_player_push_time) / tracker_reducer;
				start_x = 64 - bar_width;

				fill(white);
				indi_rect(start_x,128-17+0.5,bar_width,1);
			}

			// holder button:

			if (marker_pulse)
			{
				if (tracker_held) 
					cindicate4.draw();
				else
					cindicate3.draw();
			}
			else
			{
				if (tracker_held) 
					cindicate2.draw();
				else
					cindicate1.draw();
			}

		}

		// cursor stuff:
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

		if (show_learn_c)
		{
			if (marker_pulse)
			{
				learn2c2.draw();
			}
			else
			{
				learn2c1.draw();
			}
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
		if (i.minus_state == true)
		{
			global_gain -= volume_change_rate;
			global_gain = constrain(global_gain, volume_cap_dn, volume_cap_up);
			adjust_volume();
		}
		else if (i.plus_state == true)
		{
			global_gain += volume_change_rate;
			global_gain = constrain(global_gain, volume_cap_dn, volume_cap_up);
			adjust_volume();
		}

		

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

		if (tracker_held && i.c_state == 0)
		{
			playertracks[playertracknum] = new completed_track(2, tracker_player_push_time, -1 * (millis() - tracker_player_push_time));
			playertracknum = (playertracknum + 1) % 100;
		}

		tracker_held = (i.c_state > 0);

		if (i.c_down)
			tracker_player_push_time = millis();
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

	float tracker_intervals;
	float tracker_First_intervals;
	float tracker_target;
	void SetTrackerPulseTime(float pTargetTime, float pFirstWidth)
	{
		int colour_select = 0;
		if (marker_pulse)
			colour_select = 1;

		donetracks[tracknum] = new completed_track(colour_select, tracker_target, tracker_intervals);

		tracker_First_intervals = pFirstWidth;
		tracker_target = pTargetTime;
		tracknum = (tracknum + 1) % 100;
	}

	int tracknum;
	int playertracknum;
	completed_track[] donetracks;
	completed_track[] playertracks;

	int tracker_success_index = 0;
	int[] tracker_success_history;
	boolean tracker_held;

	float tracker_player_push_time;

	void SetShowLearn(boolean pState)
	{
		show_learn_c = pState;
	}
	boolean show_pulse_tracker = false;

	void SetShowTracker(boolean pState)
	{
		show_pulse_tracker = pState;
	}
}


class completed_track
{
	float t_start;
	float b_width;
	int colour;

	completed_track(int pColour, float pStart, float pInterval)
	{
		colour = pColour;
		t_start = pStart;
		b_width = (pInterval / tracker_reducer);
	}

	boolean draw()
	{
		if (colour == 2)
			fill(white);
		else if (colour == 1)
			fill(lgrey);
		else
			fill(dgrey);

		float start_x = 64 - b_width + (t_start - millis()) / tracker_reducer;

		if ((start_x - b_width) < -64)
			return true;
		else
		{
			if (colour == 2)
				indi_rect(start_x,128-17+0.5,b_width,1);
			else
				indi_rect(start_x,128-17,b_width,2);
			return false;
		}
	}
}