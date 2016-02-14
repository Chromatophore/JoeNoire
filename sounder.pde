
Minim minim;//audio context
AudioPlayer[] sounds;
boolean[] sounds_loaded;

boolean loaded = false;
void load_sounds()
{
	if (loaded)
		return;
		
	minim = new Minim(this);
		
	sounds = new AudioPlayer[30];

	sounds_loaded = new boolean[30];

	for (int j = 0;j<30;j++)
		sounds_loaded[j] = true;

	// Short sounds:
	sounds[0] = minim.loadFile("data/MIT/sounds/beep.mp3");
	sounds[1] = minim.loadFile("data/sound/242501__gabrielaraujo__powerup-success.mp3");
	sounds[2] = minim.loadFile("data/sound/242503__gabrielaraujo__failure-wrong-action.mp3");
	sounds[3] = minim.loadFile("data/sound/171521__fins__button.mp3");
	sounds[4] = minim.loadFile("data/MIT/sounds/talk1.mp3");
	sounds[5] = minim.loadFile("data/MIT/sounds/talk2.mp3");
	sounds[6] = minim.loadFile("data/MIT/sounds/talk3.mp3");
	sounds[7] = minim.loadFile("data/MIT/sounds/pulse_real1.mp3");
	sounds[8] = minim.loadFile("data/MIT/sounds/pulse_real2.mp3");
	sounds[9] = minim.loadFile("data/sound/snow_shriek.mp3");
	sounds[10] = minim.loadFile("data/MIT/sounds/talk4.mp3");
	sounds[13] = minim.loadFile("data/MIT/sounds/talk5.mp3");
	sounds[14] = minim.loadFile("data/MIT/sounds/talk6.mp3");
	sounds[18] = minim.loadFile("data/sound/gunshot.mp3");
	sounds[19] = minim.loadFile("data/sound/alarm_short.mp3");
	sounds[23] = minim.loadFile("data/sound/170272__knova__gun-click.mp3");
	sounds[24] = minim.loadFile("data/MIT/sounds/talk7.mp3");
	sounds[25] = minim.loadFile("data/MIT/sounds/talk8.mp3");
	sounds[26] = minim.loadFile("data/MIT/sounds/talk9.mp3");

	configure_non_music();
	
	// Long music:
	// Title screen
	sounds[11] = minim.loadFile("data/music_KevinMacloud/Comfortable Mystery 4 (EP).mp3");				// 1
	// Level 1:
	sounds_loaded[12] = false;
	//sounds[12] = minim.loadFile("data/music_KevinMacloud/Rollin at 5_edit.mp3");						// 2
	// Bar and credits:
	sounds_loaded[15] = false;
	//sounds[15] = minim.loadFile("data/music_MiodragMarjanovQuintet/Miodrag_Marjanov_Quintet_-_05_-_Gamblers_Blues.mp3");		// 3
	// Cutscene chapter 2
	sounds_loaded[16] = false;
	//sounds[16] = minim.loadFile("data/music_KevinMacloud/Bass Walker.mp3");							// 4
	// Jewelry heist
	sounds_loaded[17] = false;
	//sounds[17] = minim.loadFile("data/music_KevinMacloud/Kevin_MacLeod_-_Faster_Does_It.mp3");		// 5
	// Jewelry race
	sounds_loaded[20] = false;
	//sounds[20] = minim.loadFile("data/music_MiodragMarjanovQuintet/Miodrag_Marjanov_Quintet_-_02_-_Good_Old_Club_Days.mp3");	// 6
	// Cutscene chapter 3
	sounds_loaded[21] = false;
	//sounds[21] = minim.loadFile("data/music_KevinMacloud/Just As Soon.mp3");							// 7
	// ending?
	sounds_loaded[22] = false;
	//sounds[22] = minim.loadFile("data/music_KevinMacloud/Backed Vibes Clean.mp3");					// 8
	

	adjust_volume();
	
	//sounds[11].setGain(global_gain + 10);
	
	loaded = true;
}


void configure_non_music()
{
	non_music_sounds = new AudioPlayer[30];

	int j = 0;

	for (AudioPlayer thing : sounds)
	{
		non_music_sounds[j++] = thing;
	}
}

AudioPlayer[] non_music_sounds;
void adjust_volume()
{
	for (AudioPlayer thing : non_music_sounds)
	{
		if (thing != null)
		{
			//println("Gain before: " + thing.getGain());
			thing.setGain(global_gain);
			//println("Gain after: " + thing.getGain());
		}
	}
}

void load_id(int id)
{
	if (sounds_loaded[id] == true)
			return;

	println("Loading audio ID " + str(id));
	// Level 1:
	if (id == 12)
		sounds[12] = minim.loadFile("data/music_KevinMacloud/Rollin at 5_edit.mp3");
	// Bar and credits:
	if (id == 15)
		sounds[15] = minim.loadFile("data/music_MiodragMarjanovQuintet/Miodrag_Marjanov_Quintet_-_05_-_Gamblers_Blues.mp3");
	// Cutscene chapter 2
	if (id == 16)
		sounds[16] = minim.loadFile("data/music_KevinMacloud/Bass Walker.mp3");
	// Jewelry heist
	if (id == 17)
		sounds[17] = minim.loadFile("data/music_KevinMacloud/Kevin_MacLeod_-_Faster_Does_It.mp3");
	// Jewelry race
	if (id == 20)
		sounds[20] = minim.loadFile("data/music_MiodragMarjanovQuintet/Miodrag_Marjanov_Quintet_-_02_-_Good_Old_Club_Days.mp3");
	// Cutscene chapter 3
	if (id == 21)
		sounds[21] = minim.loadFile("data/music_KevinMacloud/Just As Soon.mp3");
	// ending?
	if (id == 22)
		sounds[22] = minim.loadFile("data/music_KevinMacloud/Backed Vibes Clean.mp3");

	sounds_loaded[id] = true;
}

void unload_sounds()
{
	for (AudioPlayer thing : sounds)
	{
		if (thing != null)
		{
			thing.pause();
			thing.close();
		}
	}
	
	minim.stop();
}

class sounder
{
	sounder()
	{
		load_sounds();
		breath_loudness(1.0);
	}
	
	int IDfromName(String name)
	{
		int id = -1;
		
		if (name.equals("beep"))
			id = 0;
		else if (name.equals("good"))
			id = 1;
		else if (name.equals("bad"))
			id = 2;
		else if (name.equals("ehhh"))
			id = 3;
		else if (name.equals("talk1"))
			id = 4;
		else if (name.equals("talk2"))
			id = 5;
		else if (name.equals("talk3"))
			id = 6;
		else if (name.equals("pulse1"))
			id = 7;
		else if (name.equals("pulse2"))
			id = 8;
		else if (name.equals("bat"))
			id = 9;
		else if (name.equals("talk4"))
			id = 10;
		else if (name.equals("talk5"))
			id = 13;
		else if (name.equals("talk6"))
			id = 14;
		else if (name.equals("gun"))
			id = 18;
		else if (name.equals("alarm"))
			id = 19;
			
			
			
			
		else if (name.equals("music1"))
			id = 11;
		else if (name.equals("music2"))
			id = 12;
		else if (name.equals("music3"))
			id = 15;
		else if (name.equals("music4"))
			id = 16;
		else if (name.equals("music5"))
			id = 17;
		else if (name.equals("music6"))
			id = 20;
			
		else if (name.equals("music7"))
			id = 21;
		else if (name.equals("music8"))
			id = 22;
			
		else if (name.equals("gunclick"))
			id = 23;
			
		else if (name.equals("talk7"))
			id = 24;
		else if (name.equals("talk8"))
			id = 25;
		else if (name.equals("talk9"))
			id = 26;
			
		return id;
	}
	
	void play(String name)
	{
    	play_by_id(IDfromName(name));
	}
	
	void play_by_id(int id)
	{
		if (id >= 0)
		{
			if (sounds_loaded[id] == false)
				load_id(id);

			sounds[id].rewind();
			sounds[id].play();
		}
	}
	
	float fade_progress = 0;
	float fade_interval = 0.25;
	
	int last_music = -1;
	int next_music = -1;
	void play_music(String name)
	{
		next_music = IDfromName(name);

		if (sounds_loaded[next_music] == false)
			load_id(next_music);

		fade_progress = 0;
		full_pass = 0;
		
		if (last_music == -1)
		{
			fade_progress = 30;
			last_music = next_music;
			loop_by_id(next_music);
			full_pass = 1;
		}
	}
	
	void stop_music()
	{
		next_music = -1;
		fade_progress = 0;
		full_pass = 0;
	}
	
	int full_pass = 0;
	
	float music_boost = 15.0;

	void loop_by_id(int id)
	{
		if (id != -1)
		{
			if (sounds_loaded[id] == false)
				load_id(id);
		}

		if (id != -1 && sounds[id] != null)
			sounds[id].loop();
	}

	void service()
	{
		if (last_music != -1)
		{
			if (fade_progress < 30)
			{
				fade_progress += fade_interval;
				float gain = music_boost + down_gain + global_gain - fade_progress;
				//println("fade out gain: " + str(gain));
				sounds[last_music].setGain(gain);
			}
			else if (full_pass == 0 && fade_progress < 60)
			{
				full_pass = 1;
				halt_by_id(last_music);
				last_music = next_music;
				loop_by_id(next_music);
				fade_progress += fade_interval;
			}
		}
		
		
		if (next_music != -1 & fade_progress >= 30 && full_pass == 1)
		{
			
			if (fade_progress < 60)
			{
				fade_progress += fade_interval;
				float gain = music_boost + down_gain + global_gain - (60 - fade_progress);
				//println("calc gain: " + gain);
				sounds[next_music].setGain(gain);
			}
			else if (next_music != -1)
			{
				last_music = next_music;
				next_music = -1;
				full_pass = 2;
			}
		}
		else if (full_pass == 1)
		{
			//println(next_music + " " + fade_progress + " " + full_pass);
			full_pass = 2;
		}
		
		//println(last_music);
		if (last_music != -1)
		{
			//println(sounds[last_music].getGain());
			//println(sounds[last_music].position() + " Vs " + sounds[last_music].length());
			/*
			if (sounds[last_music].position() >= sounds[last_music].length() - 1)
			{
				// solved by using .loop omg why did I search for 'repeat' lol
				//sounds[last_music].rewind();
			}
			*/
			//println(sounds[last_music].getGain());
		}

	}
	
	void halt(String name)
	{
		halt_by_id(IDfromName(name));
	}
	
	void halt_by_id(int id)
	{
		if (id >= 0)
		{
			sounds[id].pause();
		}
	}
	
	void end_program()
	{
		unload_sounds();
	}
	
	float down_gain;
	
	void breath_loudness(float factor)
	{
		// as is our calmness, 1.0 is fully calm
		// we need to reverse this:
		factor = 1 - factor;
		
		float up_gain = global_gain + (20 * factor) - 15;
		down_gain = global_gain - (10 * factor);
		
		if (full_pass == 2 && last_music != -1)
		{
			sounds[last_music].setGain(music_boost + global_gain + down_gain);
		}
		
		// make breathing louder
		sounds[7].setGain(up_gain);
		sounds[8].setGain(up_gain);
		
		// reduce music files by down_gain:
		
	}
}