
sideref[] side_db = null;

int crate_goal = 20;

class level1
{
	int spro = 0;

	void level_state(int state)
	{
		if (state == 0)
		{
			theUI.SetShowTracker(false);
			theUI.ResetCursor();
			texter = new textbox("intro_1");

			// make sure happy/sads are reset
			theUI.SetSmiles(smiles);
			theUI.SetSads(sads);
		}
		else if (state == 1)
		{
			eye_c.change(true,"");
			texter = new textbox("intro_2");
			frames_to_convey = 1000;
			new_box();
			
			make_sound.play_music("music2");
			
			jitter.get_rekt(0.1);
		}
		else if (state == 2)
		{
			texter = new textbox("intro_3");
		}
		else if (state == 3)
		{
			texter = new textbox("intro_4");
		}
		else if (state == 4)
		{
			texter = new textbox("intro_5");
			new_box();
			frames_to_convey = 1000;
			
			jitter.get_rekt(0.1);
		}
		// state == 5 means waiting for player to attach a label
		
		else if (state == 6)
		{
			texter = new textbox("intro_7_good");
			new_box();
			frames_to_convey = 1000;
			state = 10;
			
			jitter.get_rekt(0.1);
		}
		else if (state == 7)
		{
			texter = new textbox("intro_7_bad");
			new_box();
			frames_to_convey = 1000;
			state = 10;
			
			jitter.get_rekt(0.2);
		}
		
		else if (state == 11)
		{
			texter = new textbox("intro_8");
			show_rot_ui = true;
			
			jitter.get_rekt(0.1);
		}
		else if (state == 12)
		{
			texter = new textbox("intro_anxious");
			show_rot_ui = false;
			new_box();
			frames_to_convey = 1000;
			theUI.sounds(true);
			theUI.SetShowTracker(true);
		}
		else if (state == 13)
		{
			show_rot_ui = true;
			theUI.SetShowLearn(false);
		}
		// 14, 15 16 are based on how well you do
		else if (state == 14)
		{
			new_box();
			frames_to_convey = 1000;
			texter = new textbox("intro_10_good");
			state = 20;
		}
		else if (state == 15)
		{
			new_box();
			frames_to_convey = 1000;
			texter = new textbox("intro_10_bad");
			state = 20;
		}
		else if (state == 21)
		{
			texter = new textbox("intro_11");
			new_box();
			frames_to_convey = 1000;
			labels_unlocked = 2;
		}
		else if (state == 22)
		{
			texter = new textbox("intro_13_good");
			state = 25;
			new_box();
			frames_to_convey = 1000;
		}
		else if (state == 23)
		{
			texter = new textbox("intro_13_bad");
			state = 25;
			new_box();
			frames_to_convey = 1000;
		}
		else if (state == 26)
		{
			texter = new textbox("intro_14");
			new_box();
			frames_to_convey = 1000;
		}
		else if (state == 27)
		{
			texter = new textbox("intro_15");
			new_box();
			frames_to_convey = 1000;
		}
		else if (state == 28)
		{
			texter = new textbox("intro_16");
			new_box();
			
			state = 30;
			
			auto_crate = true;
			frames_to_convey = -1;
			start_milli = -1;
			time_between_crates = 10000;
		}
		else if (state == 100)
		{
			theUI.OverrideCursor(false, null);
			auto_crate = false;
			frames_to_convey = 0;
			make_sound.stop_music();
			
			theUI.sounds(false);
			
			jitter.anxiety(false);
			jitter.inaction_off();
			jitter.player_must_pump = false;
			
			if (sads < 5)
			{
				texter = new textbox("intro_17_good");
			}
			else
			{
				texter = new textbox("intro_17_bad");
			}
		}
		
		spro = state;
	}
	
	void sequence_hook()
	{
		if (text_box_finished)
		{
			if (text_box_finish_name.equals("intro_1"))
			{
				level_state(1);
			}
			else if (text_box_finish_name.equals("intro_2"))
			{
				frames_to_convey = 0;
				if (crate_locations[0].x > 512 - 64)
					crate_locations[0].x = 256;
				level_state(2);
			}
			else if (text_box_finish_name.equals("intro_5"))
			{
				level_state(5);
			}
			else if (text_box_finish_name.equals("intro_anxious"))
			{
				jitter.anxiety(true);
				jitter.inaction_on();
				jitter.player_must_pump = true;
				theUI.SetShowLearn(true);
				show_rot_ui = false;
			}
			else if (text_box_finish_name.equals("intro_11"))
			{
				//new_box();
				//frames_to_convey = 1000;
				/*
				auto_crate = true;
				start_milli = -1;
			
				new_box();
				frames_to_convey = 1000;
				time_between_crates = 10000;*/
			}
			else if (text_box_finish_name.equals("intro_17_good") ||
							text_box_finish_name.equals("intro_17_bad"))
			{
				
				jitter.anxiety(false);
				jitter.inaction_off();
				jitter.player_must_pump = false;
				
				eye_c.change(false,"level1_end");
			}
		}
	}
	
	boolean auto_crate = false;
	
	int frames_to_convey = 0;
	
	boolean show_rot_ui = false;
	
	
	basic_image WareHouseBG;
	basic_image WareHouseSky;
	basic_image Crate1;
	basic_image Crate2;
	basic_image conveyor_wheels;
	
	basic_image arrow_left;
	basic_image arrow_right;
	basic_image next_button;
	
	basic_image label1;
	basic_image label2;
	
	basic_image[] label_zones;
	
	int labels_unlocked = 0;
	int selected_label = 0;

	int cog_steps = 5;
	int cog_current = 0;
	int cogspin = 0;
	
	int time_between_crates = 8000;
	
	crate[] crate_locations;
	int crate_array_size = 10;
	int focus_crate = 0;
	
	float box_current_x;
	
	float current_camera_x;
	
	float point_to_kill_crate = -40;
	
	int start_milli;
	int lastcrate;
	
	int current_crates = 0;
	
	float camera_crate_offset = -8;
	float crate_speed = 0.25;
	
	boolean drawui;
	
	int crates_complete = 0;
	int level_difficulty = 3;
	
	level1()
	{
		WareHouseBG = new basic_image(loadImage("data/MIT/lv1/warehouse.png"),-128,64);
		WareHouseSky = new basic_image(loadImage("data/MIT/lv1/warehouse_sky.png"),64,256);
		Crate1 = new basic_image(loadImage("data/MIT/lv1/crate1.png"),0,0);
		Crate2 = new basic_image(loadImage("data/MIT/lv1/crate2.png"),0,0);
		
		conveyor_wheels = new basic_image(loadImage("data/MIT/lv1/conveyorwheels.png"),15,64);
		
		arrow_left = new basic_image(loadImage("data/MIT/lv1/leftside_arrow.png"),15,64);
		arrow_right = new basic_image(loadImage("data/MIT/lv1/rightside_arrow.png"),113,64);
		next_button = new basic_image(loadImage("data/MIT/lv1/next.png"),113,96);
		
		label1 = new basic_image(loadImage("data/MIT/lv1/l1.png"),64,64);
		label2 = new basic_image(loadImage("data/MIT/lv1/l2.png"),64,64);
		
		label_zones = new basic_image[6];
		
		label_zones[0] = new basic_image(loadImage("data/MIT/lv1/l1z1.png"),64,64);
		label_zones[1] = new basic_image(loadImage("data/MIT/lv1/l1z2.png"),64,64);
		label_zones[2] = new basic_image(loadImage("data/MIT/lv1/l1z3.png"),64,64);
		label_zones[3] = new basic_image(loadImage("data/MIT/lv1/l2z1.png"),64,64);
		label_zones[4] = new basic_image(loadImage("data/MIT/lv1/l2z2.png"),64,64);
		label_zones[5] = new basic_image(loadImage("data/MIT/lv1/l2z3.png"),64,64);

		current_camera_x = 512 - 128;
		
		String lines[] = loadStrings("data/MIT/lv1/level1.txt");
		//crate_locations = new crate[10];
		//for (int j = 0;j < 10;j ++)
		//{
			//crate_locations[j] = new crate(1,false,0,0);
		//}
		
		int sidesofar = 0;
		int cratesofar = 0;

		int side_datas = -1;
		int crate_datas = -1;
		boolean size_side_array = false;
		boolean size_crate_array = false;
		for (String l : lines)
		{
			// side reading
			if (l.equals("numsides"))
			{
					size_side_array = true;
			}
			else if (size_side_array)
			{
				size_side_array = false;
				side_db = new sideref[int(l)];
			}
			
			if (side_db != null)
			{
				if (l.equals("side"))
				{
					side_datas = -2;
				}
				else if (side_datas == -2)
				{
					side_datas = int(l);
					side_db[sidesofar] = new sideref(side_datas);
				}
				else if (side_datas > 0)
				{
					String[] subs = split(l,",");
					side_data t = new side_data(int(subs[0]), int(subs[1]), float(subs[2]), float(subs[3]));
					side_db[sidesofar].addside(t);
					side_datas--;
					if (side_datas == 0)
					{
						side_datas = -1;
						sidesofar++;
					}
				}
				// end side reading
			}
			
			// crate reading
			if (l.equals("numcrates"))
			{
				size_crate_array = true;
			}
			else if (size_crate_array)
			{
				size_crate_array = false;
				crate_array_size = int(l) + 5;
				crate_locations = new crate[crate_array_size];
				//println(crate_array_size);
			}
			
			if (crate_locations != null)
			{
				if (l.equals("crate"))
				{
					crate_datas = -2;
				}
				else if (crate_datas == -2)
				{
					crate_locations[cratesofar] = new crate();
					crate_datas = int(l);
				}
				else if (crate_datas > 0)
				{
					String[] subs = split(l,",");
					//println(l);
					crate_locations[cratesofar].ApplySide(int(subs[0]),side_db[int(subs[1])]);
					crate_datas--;
					if (crate_datas == 0)
					{
						crate_datas = -1;
						cratesofar++;
					}
				}
			}
		}
		
		//new_box();
		start_milli = -1;
		
		level_state(0);
	}
	
	void TakeInput(inputblob i)
	{
		if (i.k1_down && spro != 100)
		{
			level_state(100);
		}
		
		if (i.z_down && spro >= 2)	// treat as swap?
		{
			
			selected_label++;
			
			if (selected_label > labels_unlocked)
				selected_label = 1;
			
			if (selected_label == 0)
			{
				theUI.OverrideCursor(false, null);
			}
			else if (selected_label == 1)
			{
				theUI.OverrideCursor(true, label1);
				make_sound.play("ehhh");
			}
			else if (selected_label == 2)
			{
				theUI.OverrideCursor(true, label2);
				make_sound.play("ehhh");
			}
		}
		if (i.x_down)	// treat as click?
		{
			if (drawui)
			{
				float effective_cursor_x = theUI.GetCursorX();
				float effective_cursor_y = theUI.GetCursorY();
				
				boolean pushed_button = false;
				// test current cursor:
				if (show_rot_ui)
				{
					if (arrow_left.do_box_test(effective_cursor_x, effective_cursor_y))
					{
						pushed_button = true;
						crate_locations[focus_crate].showside += 3;
						make_sound.play("ehhh");
					}
					else if (arrow_right.do_box_test(effective_cursor_x, effective_cursor_y))
					{
						pushed_button = true;
						crate_locations[focus_crate].showside += 1;
						make_sound.play("ehhh");
					}
				}
				
				if (next_button.do_box_test(effective_cursor_x, effective_cursor_y))
				{
					if (spro != 11)
					{
						pushed_button = true;
						nextCrate();
					}
					
					if (spro == 3)
						level_state(4);
				}
				
				if (crate_locations[focus_crate] != null)
				{
					crate_locations[focus_crate].showside = crate_locations[focus_crate].showside % 4;
				}
				
				if (selected_label >= 1 && selected_label <= 2)
				{
					float rel_box_x = effective_cursor_x - current_box_mid_x - crate_center_offset_x;
					float rel_box_y = effective_cursor_y - current_box_mid_y - crate_center_offset_y;
					float bound_x = 2 + 31.0 / 2;
					float bound_y = 2 + 43.0 / 2;
					if (selected_label == 2)
					{
						bound_x = 2 + 46.0/2;
						bound_y = 2 + 36.0/2;
					}
					
					if ((abs(rel_box_x) < (bound_x)) && (abs(rel_box_y) < (bound_y)))
					{
						float score = crate_locations[focus_crate].ApplyLabel(selected_label - 1, rel_box_x, rel_box_y);

						if (score > 900)
						{
							// play an error sound?
							make_sound.play("beep");
						}
						else
						{
							int type = 1;
							if (score > 80)
							{
								make_sound.play("good");
								AddSmile();
								type = 2;
								
							}
							else if (score < 50 && spro != 2)
							{
								make_sound.play("bad");
								AddSad();
								type = 3;
							}
							else
							{
								make_sound.play("ehhh");
								AddMeh();
							}
							
							if (spro == 2)
								level_state(3);
							else if (spro == 11)
									level_state(12);
							
							scorer.add_riser(new score_riser(effective_cursor_x, effective_cursor_y, str(int(score)), type));
						}
					}
					else
					{
						if (!pushed_button)
							make_sound.play("beep");
					}
				}
			}
			else
			{
				make_sound.play("beep");
			}
		}
	}
	
	int smiles = 0;
	int sads = 0;
	
	void AddSmile()
	{
		smiles++;
		theUI.SetSmiles(smiles);
		
		if (spro == 5)
		{
			level_state(6);
		}
	}
	void AddSad()
	{
		sads++;
		theUI.SetSads(sads);
		jitter.get_rekt(0.1);
		shake_screen(0.25,30,30);
		if (spro == 5)
		{
			level_state(7);
		}
		
	}
	void AddMeh()
	{
		jitter.get_rekt(0.05);
		if (spro == 5)
		{
			level_state(6);
		}
	}
	
	int crate_center_offset_x = -5;
	int crate_center_offset_y = +7;
	float current_box_mid_x = 0;
	float current_box_mid_y = 0;
	
	void draw()
	{
		sequence_hook();
		
		if (start_milli < 0)
		{
			start_milli = millis();
			lastcrate = start_milli;
		}
			
		if (auto_crate && (millis() > lastcrate + time_between_crates))
		{
			new_box();
			lastcrate = millis();
		}

		if (WareHouseSky.y_float > -128)
			WareHouseSky.movePos(0,-0.02);
		WareHouseSky.draw();

		for (crate box : crate_locations)
		{
			if (box != null)
			{
				box_current_x = box.x;
				if (box_current_x > -1000 && frames_to_convey != 0)
				{
					box_current_x -= crate_speed;
					box.x = box_current_x;
				}
				else
				{
					break;
				}
			}
			else
				break;
		}
		
		if (frames_to_convey > 0)
			frames_to_convey--;
		else if (frames_to_convey == 0)
		{
			if (spro == 1 && texter == null)
			{
				level_state(2);
			}
		}

		if (crate_locations[focus_crate] != null)
			box_current_x = crate_locations[focus_crate].x + camera_crate_offset;
		else
			box_current_x = -9999;
		
		// If there is no box, go to the far right
		if (box_current_x < -1000)
			box_current_x = 600;
		
		// attempt to draw the box in the middle of the screen but clamp it such that we don't move the camera off screen
		float camera_x = box_current_x;


		if (spro == 12)
			camera_x += 96;

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
		if ((abs(current_camera_x - box_current_x) < 5 || box_current_x < 64) || spro == 12)
		{
				drawui = true;
		}
			
		// relationship from camera to the midpoint of the texture will be:
		float BGpos = -1 * current_camera_x + 256 + 64;
		WareHouseBG.setPos(BGpos,64);
		WareHouseBG.draw();
		
		if (frames_to_convey != 0)
		{
			if (cog_current > cog_steps)
			{
				cog_current = 0;
				cogspin = 9 - cogspin;
			}
			else
			{
				cog_current++;
			}
		}
		
		float nearest_cog = BGpos + cogspin;

		//nearest_cog -= nearest_cog % 9;
		conveyor_wheels.setPos(64 + nearest_cog % 18,103);
		conveyor_wheels.draw();
		
		//print(box_current_x + "\n");

		for( int j = 0; j < crate_array_size; j++)
		{
			float crate_x = -9999;
			if (crate_locations[j] != null)
				crate_x = crate_locations[j].x;
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
					if (crate_x < 20 && focus_crate == 0)
					{
						nextCrate();
					}
					
					float box_x = 64 + crate_x - current_camera_x;
					float box_y = 51;
					
					if (j == focus_crate)
					{
						current_box_mid_x = box_x;
						current_box_mid_y = box_y;
					}
					if ((crate_locations[j].showside % 2) == 0)
					{
						Crate1.setPos(box_x,box_y);
						Crate1.draw();
					}
					else
					{
						Crate2.setPos(box_x,box_y);
						Crate2.draw();
					}

					int face = crate_locations[j].showside;
					for (labelgame label : crate_locations[j].labels_needed[face])
					{
						if (label != null)
						{
							if (crate_locations[j].CheckShowReq(label.type))
							{
								basic_image label_place;
								int index = constrain(label.type * 3 + label.hardness, 0, 5);
								label_place = label_zones[index];
								label_place.setPos(box_x +crate_center_offset_x + label.x, box_y + crate_center_offset_y + label.y);
								label_place.draw();
							}
						}
					}
					
					for (labelgame label : crate_locations[j].labels_applied[face])
					{
						if (label != null)
						{
							basic_image label_place;
							if (label.type == 0)
								label_place = label1;
							else
								label_place = label2;
							label_place.setPos(box_x + crate_center_offset_x + label.x, box_y + crate_center_offset_y + label.y);
							label_place.draw();
						}
					}
				}
			}
		}
		
		textFont(font_ui, 14);
		text("Remaining: " + str(crate_goal - crates_complete),5,5);
		
		// Draw the black box at the bottom:
		fill(black);
		indi_rect(0,128-16,128,16);

		if (drawui)
		{
			if (show_rot_ui)
			{
				arrow_left.draw();
				arrow_right.draw();
			}
			if (spro >= 3)
				next_button.draw();
		}
		

	}
	
	void new_box()
	{
		//if (crate_locations == null)
			//return;
			
		for (int j = 0; j < crate_array_size ; j++)
		{
			//print("trying box " + j + " : " + crate_locations[j] + "\n");
			
			// if we find an empty crate:
			if (crate_locations[j] == null)
			{
				if (crate_locations[j] == null)
				{
					crate_locations[j] = new crate();
					crate_locations[j].SetRandom(level_difficulty);
				}
			}
			
			if (crate_locations[j].x < -1000)
			{
				crate_locations[j].x = 512 + 64;
				current_crates++;
				//print("making new box at: " + j + "\n");
				break;
			}
		}
	}
	
	void nextCrate()
	{
		// check current crate is finished
		boolean was_good = true;
		crate thiscrate = crate_locations[focus_crate];
		if (!thiscrate.IsFinished())
		{
			was_good = false;
			make_sound.play("bad");
			AddSad();
			int type = 3;
			scorer.add_riser(new score_riser(64 - 20, 20, "unfinished", type));
		}
		
		
		if (focus_crate < (crate_array_size - 1))
			focus_crate += 1;
		
		
		crates_complete++;
		//println("completed: " + crates_complete);
		if (crates_complete % 4 == 3 && crates_complete > 8)
		{
			level_difficulty++;
			//println("difficulty: " + level_difficulty);
			if (level_difficulty == 2)
				texter = new textbox("intro_diff_up_1");
			else if (level_difficulty == 3)
				texter = new textbox("intro_diff_up_2");
			else if (level_difficulty == 4)
				texter = new textbox("intro_diff_up_3");
		}
		else
		{
			if (spro > 30 && !was_good)
			{
				int r_str = int(random(6)) + 1;
				texter = new textbox("intro_abuse_" + str(r_str));
			}
		}
		
		if (spro == 10)
		{
			level_state(11);
		}
		else if (spro == 13 && was_good)
		{
			level_state(spro + 1);
		}
		else if (spro == 13 && !was_good)
		{
			level_state(spro + 2);
		}
		else if (spro == 12)
		{
			level_state(spro + 1);
		}
		else if (spro == 20)
		{
			level_state(spro + 1);
		}
		else if (spro == 21)
		{
			if (was_good)
				level_state(spro + 1);
			else
				level_state(spro + 2);
		}
		
		else if (spro == 25 || spro == 26 || spro == 27)
		{
			level_state(spro + 1);
		}
		
		if (crates_complete == crate_goal)
		{
			level_state(100);
		}
		
	}
	
	void shift_crate_list()
	{		
			for (int j = 0;j < crate_array_size - 1;j++)
			{
				crate_locations[j] = crate_locations[j+1];
			}
			
			crate_locations[crate_array_size - 1] = null;//new crate();
			//crate_locations[crate_array_size - 1].SetRandom(level_difficulty);
			
			current_crates--;
			
			if (focus_crate > 0)
				focus_crate -= 1;
				
			
	}
}

class crate
{
	float x;
	int showside;
	
	labelgame[][] labels_applied;
	labelgame[][] labels_needed;
	int[] labelmask;
	int[] labelneeds;
	
	crate()
	{
		labels_applied = new labelgame[4][2];
		labels_needed = new labelgame[4][2];
		labelmask = new int[4];
		labelneeds = new int[4];
		
		for (int j=0;j<4;j++)
		{
			labelmask[j] = 0;
		}

		x = -1100;
	}
	
	boolean IsFinished()
	{
		for (int j = 0; j < 4; j++)
		{
			if ((labelneeds[j] & labelmask[j]) != labelneeds[j])
			{
				return false;
			}
		}
		return true;
	}
	
	boolean CheckShowReq(int id)
	{
		return ((labelmask[showside] & (1 + id)) == 0);
	}
	
	float ApplyLabel(int id, float x_off, float y_off)
	{
		float score = 9999;
		if ((labelmask[showside] & (1 + id)) > 0)
			return score;
		
		labels_applied[showside][id] = new labelgame(id,0,x_off,y_off);
		
		labelmask[showside] |= (1 + id);
		
		boolean bad = false;
		if ((labelmask[showside] & (1 + id)) == 0)
		{
			bad = true;
		}
		if (bad == false)
		{
			// score it:
			// depending on ID and difficulty we have different numbers
			// so we can't use dist() unfortunately
			score = labels_applied[showside][id].compare(labels_needed[showside][id]);
		}
		return score;
	}
	
	void ApplySide(int face, sideref sRef)
	{
		// this will apply an actual label side to us
		// we need to read all the sides in the sideref and apply them to ourself
		int needed = 0;
		int applied = 0;
		
		for (int j=0;j<sRef.entries;j++)
		{
			int id = sRef.myList[j].ID;
			if (id >= 10)
			{
				id -= 10;
				float x = sRef.myList[j].GetX();
				float y = sRef.myList[j].GetY();
				
				// we both need and have applied a label here already
				labels_needed[face][id] = new labelgame(id, sRef.myList[j].Diff, x, y);
				labels_applied[face][id] = new labelgame(id, sRef.myList[j].Diff, x, y);
				
				labelmask[face] |= (1 + id);
				labelneeds[face] |= (id + 1);
				applied++;
			}
			else
			{
				float x = sRef.myList[j].GetX();
				float y = sRef.myList[j].GetY();
				labels_needed[face][id] = new labelgame(id, sRef.myList[j].Diff, x, y);
				labelneeds[face] |= (id + 1);
				needed++;
			}
		}
	}
	
	void SetRandom(int general_difficulty_level)
	{
		if (side_db == null)
			return;
			
		//println("Making crate with diffiuclty: " + str(general_difficulty_level));
		
		int sides_to_write = 2;
		if (general_difficulty_level >= 1)
			sides_to_write = 3;
		if (general_difficulty_level >= 3)
			sides_to_write = 4;
			
		int size_difficulty = 0;
		if (general_difficulty_level >= 2)
			size_difficulty = 1;
		if (general_difficulty_level >= 4)
			size_difficulty = 2;
		
		int random_side = int(random(4));
		
		boolean run_backwards = (random(100) > 50);
		
		for (int j = 0;j < sides_to_write; j++)
		{
			int address = (j + random_side) % 4;
			if (run_backwards)
				address = 3 - address;
			
			
			int side_id = 1;
			if (general_difficulty_level >= 4 && random(100) > 70)
			{
				side_id = 8 + int(random(4));
				if (side_id >= 12)
					side_id = 11;
			}
			else
			{
				if ((random(100) > 50 && j != 0) || j == 1)
					side_id += 3;
					
				side_id += size_difficulty;
				
			}
			ApplySide(address, side_db[side_id]);
			// Set this side to be a reference side
		}
	}
}

class labelgame
{
	int type;
	int hardness;
	
	float x;
	float y;
	
	labelgame(int pType, int pHardness, float pos_x, float pos_y)
	{
		type = pType;
		hardness = pHardness;
		x = pos_x;
		y = pos_y;
	}
		
	float compare(labelgame other)
	{
		if (other == null)
			return 0.0;
		float dist_x = abs(other.x - x);
		float dist_y = abs(other.y - y);
		
		// start with the strictest:
		float min_x = 0;
		float min_y = 0;
		
		float size_x = 25;
		float size_y = 13;
		
		if (type == 1)
		{
			size_x = 10;
			size_y = 20;
		}
		
		
		if (type == 0 && other.hardness == 0)
		{
			min_x = 14.0/2;
			min_y = 21.0/2;
		}
		if (type == 0 && other.hardness == 1)
		{
			min_x = 2.0/2;
			min_y = 7.0/2;
		}
		
		if (type == 1 && other.hardness == 0)
		{
			min_x = 20.0/2;
			min_y = 22.0/2;
		}
		if (type == 1 && other.hardness == 1)
		{
			min_x = 12.0/2;
			min_y = 13.0/2;
		}
		
		if (dist_x < min_x && dist_y < min_y)
			return 100;
		else
		{
			dist_x -= min_x;
			dist_y -= min_y;
			
			dist_x /= size_x;
			dist_y /= size_y;
			
			return constrain(100 - 50 * dist_x - 50 * dist_y,0,100);
		}
	}
}

class sideref
{
	int entries;
	side_data[] myList;
	sideref(int datas)
	{
		entries = datas;
		myList = new side_data[entries];
	}

	int added_so_far = 0;
	void addside(side_data newside)
	{
		if (added_so_far > entries)
			return;
		myList[added_so_far] = newside;
		added_so_far++;
	}
}

// side data for an invidiual side of a crate
class side_data
{
	int ID;
	int Diff;
	float x;
	float y;
	side_data(int pID, int pDiff, float xpos, float ypos)
	{
		ID = pID;
		Diff = pDiff;
		x = xpos;
		y = ypos;
	}

	float GetX()
	{
		if (x > 1000)
		{
			float mid = (x - 1000) / 2;
			return random(x - 1000) - mid;
		}
		else
			return x;
	}

	float GetY()
	{
		if (y > 1000)
		{
			float mid = (y - 1000) / 2;
			return random(y - 1000) - mid;
		}
		else
			return y;
	}

}