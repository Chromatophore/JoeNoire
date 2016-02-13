
int marker_max = 36;
int bar_max = 42;

float tracker_reducer = 35.0;

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
		
		Cursor = new basic_image(loadImage("data/MIT/UI/cursor1.png"),64,64);
		
		chillimg = new basic_image(loadImage("data/MIT/UI/panic.png"),97,128 - 16 + 12);

		donetracks = new completed_track[100];

		tracker_success_history = new int[256];
		for (int k = 0;k < 256; k++)
		{
			tracker_success_history[k] = 0;
		}

		tracker_history_image = createImage(256,2,ARGB);
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
		rect(0,128-16,128,16);
		
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
		rect(64 - panic_bar, 128 - 14, 2 * panic_bar, 12);
		
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


		fill(dgrey);
		rect(0,128-17,128,2);

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

			rect(start_x,128-17,bar_width,2);

			start_x += bar_width;
			alternate = !alternate;
		}

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

		/*
		if (tracker_held == marker_pulse)
		{
			tracker_success_history[tracker_success_index] = 1;
		}
		else
		{
			tracker_success_history[tracker_success_index] = 0;
		}

		tracker_success_index = (tracker_success_index + 1) % 256;
		
		for(int j=0;j<256;j++)
		{
			color write_color = black;
			if (tracker_success_history[(j + tracker_success_index) % 256] == 1)
			{
				write_color = white;
			}

			tracker_history_image.pixels[j] = write_color;
			tracker_history_image.pixels[j+256] = write_color;
		}

		tracker_history_image.updatePixels();
		pushMatrix();

		scale(0.25,0.25);
		float magnify = 2;
		image(tracker_history_image,(64 - 32 * magnify)*4,(128-16)*4, 256 * magnify, 2);

		popMatrix();
		*/
		fill(black);
		rect(64-0.25,128-17,0.5,2);


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

		tracker_held = (i.c_state > 0);
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
		donetracks[tracknum] = new completed_track(marker_pulse, tracker_target, tracker_intervals);

		tracker_First_intervals = pFirstWidth;
		tracker_target = pTargetTime;
		tracknum = (tracknum + 1) % 100;
	}

	int tracknum;
	completed_track[] donetracks;

	int tracker_success_index = 0;
	int[] tracker_success_history;
	boolean tracker_held;
	PImage tracker_history_image;
}


class completed_track
{
	float t_start;
	float b_width;
	boolean colour;

	completed_track(boolean pColour, float pStart, float pInterval)
	{
		colour = pColour;
		t_start = pStart;
		b_width = (pInterval / tracker_reducer);
	}

	boolean draw()
	{
		if (colour)
			fill(lgrey);
		else
			fill(dgrey);

		float start_x = (64.0 - b_width) + (t_start - millis()) / tracker_reducer;
		

		if ((start_x + b_width) < -10)
			return true;
		else
		{
			rect(start_x,128-17,b_width,2);
			return false;
		}
	}
}