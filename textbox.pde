 //<>//
int[] var_width_array;
// This is going to be a thing that takes a string line of code and displays it as a text box I guess

float text_box_open_speed = 4;

PortraitSet[] portrait_db;
PImage[] avatar_list;

PImage textbox_a;
PImage textbox_b;


PortraitSet get_portrait_set(String av_name)
{
	if (av_name.equals("workboss"))
	{
		return portrait_db[0];
	}
	else if (av_name.equals("goon1"))
	{
		return portrait_db[1];
	}
	else if (av_name.equals("goon2"))
	{
		return portrait_db[2];
	}
	else if (av_name.equals("superboss"))
	{
		return portrait_db[3];
	}
	else if (av_name.equals("lady"))
	{
		return portrait_db[4];
	}
	else if (av_name.equals("ladyh1"))
	{
		return portrait_db[5];
	}
	else if (av_name.equals("ladyh2"))
	{
		return portrait_db[6];
	}
	else if (av_name.equals("ladyh3"))
	{
		return portrait_db[7];
	}
	else if (av_name.equals("ladyh4"))
	{
		return portrait_db[8];
	}
	else if (av_name.equals("man"))
	{
		return portrait_db[9];
	}
	else if (av_name.equals("tannoy"))
	{
		return portrait_db[10];
	}
	else if (av_name.equals("jack"))
	{
		return portrait_db[11];
	}
	else if (av_name.equals("marco"))
	{
		return portrait_db[12];
	}
	
	else if (av_name.equals("joe"))
	{
		return portrait_db[13];
	}
	else if (av_name.equals("joee"))
	{
		return portrait_db[14];
	}
	else if (av_name.equals("mysteryman"))
	{
		return portrait_db[15];
	}
	else if (av_name.equals("otherlady"))
		return portrait_db[16];
	else if (av_name.equals("internaldeep"))
		return portrait_db[17];
	else if (av_name.equals("morph"))
		return portrait_db[18];

	
	return null;
}


textblob[] all_texts;

void textbox_setup()
{
	avatar_list = new PImage[100];
	avatar_list[0] = loadImage("data/MIT/chat_avs/boss1.png");
	avatar_list[1] = loadImage("data/MIT/chat_avs/boss2.png");
	avatar_list[2] = loadImage("data/MIT/chat_avs/goon1.png");
	avatar_list[3] = loadImage("data/MIT/chat_avs/goon2.png");
	avatar_list[4] = loadImage("data/MIT/chat_avs/goonB1.png");
	avatar_list[5] = loadImage("data/MIT/chat_avs/goonB2.png");
	avatar_list[6] = loadImage("data/MIT/chat_avs/superboss.png");
	avatar_list[7] = loadImage("data/MIT/chat_avs/lady.png");
	avatar_list[8] = loadImage("data/MIT/chat_avs/lady_hand_rings.png");
	avatar_list[9] = loadImage("data/MIT/chat_avs/lady_hand_rings2i.png");
	avatar_list[10] = loadImage("data/MIT/chat_avs/lady_hand_rings2.png");
	avatar_list[11] = loadImage("data/MIT/chat_avs/lady_hand_brace.png");
	avatar_list[12] = loadImage("data/MIT/chat_avs/man_end0.png");
	avatar_list[13] = loadImage("data/MIT/chat_avs/man_end1.png");
	avatar_list[14] = loadImage("data/MIT/chat_avs/tannoy1.png");
	avatar_list[15] = loadImage("data/MIT/chat_avs/tannoy2.png");
	avatar_list[16] = loadImage("data/MIT/chat_avs/marco.png");
	avatar_list[17] = loadImage("data/MIT/chat_avs/mystery_man.png");
	avatar_list[18] = loadImage("data/MIT/chat_avs/other_lady.png");
	
	portrait_db = new PortraitSet[30];
	portrait_db[0] = new PortraitSet("workboss","0,1",0, "talk1");
	portrait_db[1] = new PortraitSet("goon1","2,3",0, "talk9");
	portrait_db[2] = new PortraitSet("goon2","4,5",0, "talk8");
	portrait_db[3] = new PortraitSet("superboss","6",0, "talk2");
	portrait_db[4] = new PortraitSet("lady","7",0, "talk3");
	portrait_db[5] = new PortraitSet("ladyh1","8",0, "talk3");
	portrait_db[6] = new PortraitSet("ladyh2","9",0, "talk3");
	portrait_db[7] = new PortraitSet("ladyh3","10",0, "talk3");
	portrait_db[8] = new PortraitSet("ladyh4","11",0, "talk3");
	portrait_db[9] = new PortraitSet("man","12,13",0, "talk2");
	portrait_db[10] = new PortraitSet("tannoy","14,15",0, "talk4");
	portrait_db[11] = new PortraitSet("jack","-1",-1, "talk1");
	portrait_db[12] = new PortraitSet("marco","16",0, "talk1");
	portrait_db[13] = new PortraitSet("joe","-1",-1, "talk6");
	portrait_db[14] = new PortraitSet("joee","-1",-1, "talk5");
	portrait_db[15] = new PortraitSet("mysteryman","17",0,"talk2");
	portrait_db[16] = new PortraitSet("otherlady","18",0, "talk3");
	portrait_db[17] = new PortraitSet("internal_deep","-1",-1, "talk2");
	portrait_db[18] = new PortraitSet("morph","-1",-1, "talk7");
	
	 textbox_a = loadImage("data/MIT/UI/textbox.png");
	 textbox_b = loadImage("data/MIT/UI/textbox_nox.png");
	
	var_width_array = new int[256];
	for(int j = 0; j < 256; j++)
	{
		var_width_array[j] = 2;
	}
	
	int val = 65;
	var_width_array[val++] = 6;
	var_width_array[val++] = 6;
	var_width_array[val++] = 5;
	var_width_array[val++] = 6;
	var_width_array[val++] = 6;
	var_width_array[val++] = 5;
	var_width_array[val++] = 5;
	var_width_array[val++] = 6;
	var_width_array[val++] = 5;
	var_width_array[val++] = 5;
	
	var_width_array[val++] = 6;
	var_width_array[val++] = 4;
	var_width_array[val++] = 7;
	var_width_array[val++] = 5;
	var_width_array[val++] = 5;
	var_width_array[val++] = 6;
	var_width_array[val++] = 5;
	var_width_array[val++] = 6;
	var_width_array[val++] = 5;
	var_width_array[val++] = 5;
	
	var_width_array[val++] = 5;
	var_width_array[val++] = 5;
	var_width_array[val++] = 7;
	var_width_array[val++] = 5;
	var_width_array[val++] = 5;
	var_width_array[val++] = 5;
	
	val = 97;
	
	
	var_width_array[val++] = 4;
	var_width_array[val++] = 4;
	var_width_array[val++] = 4;
	var_width_array[val++] = 4;
	var_width_array[val++] = 4;
	var_width_array[val++] = 3;	// shorter f since it will likely be followed by a vowel
	var_width_array[val++] = 4;
	var_width_array[val++] = 4;
	var_width_array[val++] = 1;
	var_width_array[val++] = 4;
	
	var_width_array[val++] = 4;
	var_width_array[val++] = 1;
	var_width_array[val++] = 5;
	var_width_array[val++] = 4;
	var_width_array[val++] = 4;
	var_width_array[val++] = 4;
	var_width_array[val++] = 4;
	var_width_array[val++] = 4;
	var_width_array[val++] = 5;
	var_width_array[val++] = 4;
	
	var_width_array[val++] = 4;
	var_width_array[val++] = 4;
	var_width_array[val++] = 7;
	var_width_array[val++] = 4;
	var_width_array[val++] = 4;
	var_width_array[val++] = 4;
		
	for(int j = 48; j <= 57; j++)
	{
		var_width_array[j] = 4;
	}
	
	var_width_array[32] = 3;
	var_width_array[33] = 1;
	var_width_array[46] = 1;
	var_width_array[35] = 6;
	
	var_width_array[58] = 4;
	var_width_array[40] = 3;
	var_width_array[41] = 3;
	
	
	
	
	
	
	all_texts = new textblob[100];
	
	int textsofar = 0;
	
	String lines[] = loadStrings("MIT/gametext.txt");
	int read_assist = -1;
	int size_array = 0;
	String new_name = "";
	for (String l : lines)
	{
			if (l.equals("text"))
			{
					size_array = 1;
			}
			else if (size_array == 1)
			{
				new_name = l;
				size_array = 2;
			}
			else if (size_array == 2)
			{
				read_assist = int(l);
				all_texts[textsofar] = new textblob(new_name,read_assist);
				
				size_array = 0;
			}
			else if (all_texts[textsofar] != null && read_assist > 0)
			{
				all_texts[textsofar].AddLine(l);
				read_assist--;
				
				if (read_assist == 0)
				{
					textsofar++;
				}
				// end side reading
			}
	}
	
}


String[] find_text(String name)
{
	for (textblob t : all_texts)
	{
		if (t != null)
		{
			if (t.name.equals(name))
				return t.line_list;
		}
	}
	return null;
}


class textblob
{
	String name;
	int lines;
	String[] line_list;
	 textblob(String pName, int pLines)
	 {
		 name = pName;
		 lines = pLines;
		 line_list = new String[lines];
	 }
	 
	 int lines_so_far = 0;
	 void AddLine(String s)
	 {
		 if (lines_so_far >= lines)
		 {
			 println("trying to load too many lines for " + name);
			 println(s);
				return;
		 }
		 
		 line_list[lines_so_far] = s;
		 lines_so_far++;
	 }
}


class textbox
{
	int test_progress;
	
	int current_text;
	int text_total;
	String[] texts;
	
	String this_text;
	float progress_so_far;
	int string_length;
	PImage[] portrait;
	
	float text_box_height;
	PImage textbox_background;
	PImage textbox_background_nox;
	
	int isOpening;
	
	int[] charry;
	
	int firstline_clip_marker = 0;
	int secondline_clip_marker = 0;
	
	int total_portraits;
	int finished_portrait;
	
	String name_of_sequence;
	
	textbox(String name)
	{
		texts = find_text(name);
		regular_constructor(name);
	}
	
	textbox(String name, String[] custom_text)
	{
		texts = custom_text;
		regular_constructor(name);
	}
	
	void regular_constructor(String name)
	{
		name_of_sequence = name;
		textbox_background = textbox_a;
		textbox_background_nox = textbox_b;

		for (String sub : texts)
		{
			 text_total++;
		}

		isOpening = 1;
		SetupLine();
	}
	
	boolean FinishedLine = false;
	PortraitSet pSet;
	
	boolean NoPortrait = false;
	
	void SetupLine()
	{
		if (current_text >= text_total)
		{
			// we need to close instead
			isOpening = 0;
		}
		else
		{
			String next_line = texts[current_text];
			if (!next_line.equals(""))
			{
				String[] breakup = split(next_line,"^");
				total_portraits = 0;
				
				int s_in = 0;
				if (breakup[0].equals("shake"))
				{
					String[] s_info = split(breakup[1],",");
					shake_screen(float(s_info[0]),int(s_info[1]),int(s_info[1]));
					 s_in += 2;
				}
				
				if (breakup[s_in].equals("none"))
				{
					NoPortrait = true;
				}
				else
				{
					NoPortrait = false;
					pSet = get_portrait_set(breakup[s_in]);
				}
				
				if (pSet == null)
				{
					NoPortrait = true;
				}
	
				this_text = breakup[s_in+1] + " ";
				string_length = this_text.length();
				charry = int( this_text.toCharArray() );
				
				init();
			
				current_text++;
			}
			else
			{
				 isOpening = 0;
			}
		}
	}
	
	void init()
	{
		FinishedLine = false;
		progress_so_far = 0;
		test_progress = 0;
		firstline_clip_marker = 0;
		secondline_clip_marker = 0;
	}
	
	boolean WriteFast = false;
	
	void draw()
	{
		int wrapsize = 86;
		
		if (NoPortrait)
			wrapsize = 120;
		
		textFont(font, 20);
		fill(color(255,255,255));
		
		/*
		test_progress += 1; //<>//
		if (test_progress > 600)
		{
			isOpening = 0;
		}*/
		
		pushMatrix();
		if (isOpening == 1)
		{
			translate(64,128 - 20);
			if (text_box_height < 40)
			{
				text_box_height += text_box_open_speed;
				image(textbox_background_nox,0,0,128,text_box_height);
			}
			else
			{
				if (!FinishedLine)
					image(textbox_background_nox,0,0);
				else
					image(textbox_background,0,0);
				translate(-44,0);
				
				boolean UseBig = NoPortrait;
				if (!NoPortrait && pSet != null)
				{
					int frame = pSet.GetFrame(int(progress_so_far) == string_length);
					if (frame != -1)
						image(avatar_list[pSet.framelist[frame]], 0,0);
					else
						UseBig = true;
				}
				
				if (progress_so_far < string_length)
				{
					if (WriteFast)
						progress_so_far += 1;
					else
						progress_so_far += 0.25;
				}
				else
				{
					FinishedLine = true;
				}
				
				translate(16,-5);
				if (UseBig)
				{
					wrapsize = 120;
					translate(-31,0);
				}
				
				int x_offset = 0;
				String textwrite = this_text;
				int linedrops = 0;
				int lastspace = 0;
				//int nextspace = 0;
				
				int chars_on_line = 0;
				
				// We go from our clip marker to however far we've gotten so far
				for (int j = secondline_clip_marker; j < int(progress_so_far); j++)
				{
					String substring = textwrite.substring(j,j+1); //<>//
					
					if (!(chars_on_line == 0 && charry[j] == 32))
					{
						// Draw this character
						text(substring,x_offset,0);
						// And extend our offset by its width
						x_offset += var_width_array[charry[j]] + 1;
						
						// We record how many characters we have on a line so we can remove unneeded initial spaces:
						chars_on_line++;
						
						// This variable if set to 1 causes us to wrap earlier than running out of length.
						int wrap_early = 0;
						
						// If we hit a space or a new line:
						if (charry[j] == 32 || charry[j] == 10)
						{
							lastspace = j;
							// Compute the location of the next space:
							// if we are on the FIRST LINE ONLY?
							// Nah, always.
							if (linedrops < 2)
							{
								// Start at the next character
								int k = j + 1;
								int tempoffset = x_offset;
								// and continue until the end of the string
								while (k < string_length)
								{
									// until we hit a space or new line
									if (charry[k] == 32 || charry[k] == 10)
									{
										// record this index
										//nextspace = k;
										// break the loop;
										k = string_length;
										// Check the x position isn't outside of our wrapping size
										if (tempoffset > wrapsize && (k != string_length - 1))
										{
											// if it is, we need to wrap at this space, because we won't be able to fit the rest of the characters
											// on the line
											wrap_early = 1;
										}
									}
									else
									{
										// Increase our fake copy of the offset by the width of the next characters
										tempoffset += var_width_array[charry[k]] + 1;
									}
									k++;
								}
							}
						}

						// When we wrap around we want to clip off the first line
						if (charry[j] == 10 || x_offset > wrapsize || wrap_early == 1)
						{
							wrap_early = 0;
							if (linedrops != 0)
							{
								// This time we know we need to start at the point we recorded in == 0:
								secondline_clip_marker = firstline_clip_marker;
								// And we're wrapping again, so, we need to store this too
								firstline_clip_marker = lastspace;
							}
							else
							{
								// The first time, we will know where the first line ends, so we store this:
								firstline_clip_marker = lastspace;
								// However we don't need this until we wrap again
							}
							x_offset = 0;
							translate(0,16);
							chars_on_line = 0;
							
							linedrops++;
						}
					}
				}
				
			}
		}
		else
		{
			if (text_box_height > 0)
			{
				translate(64,128 - 20);
				text_box_height -= text_box_open_speed;
				image(textbox_background_nox,0,0,128,text_box_height);
			}
		}
		
		popMatrix();
	}
	
	boolean TakeInput(inputblob i)
	{
		if (i.x_down && FinishedLine)
		{
			SetupLine();
		}
		
		if (i.z_state > 0)
		{
			 WriteFast = true;
		}
		else
			WriteFast = false;
			
		if (i.a_down)
		{
			isOpening = 0;
		}
			
		if (isOpening == 0 && text_box_height <= 0)
		{
			return false;
		}
		else
			return true;
	}
}

class PortraitSet
{
	String name;
	String soundlookup;
	 PortraitSet(String pName, String frameset, int idle, String pSoundLookup)
	 {
		 name = pName;
		 String[] s = split(frameset,",");
		 framecount = 0;
		 for (String sub : s)
		 {
			 framecount++;
		 }
		 
		 framelist = new int[framecount];
		 
		 for (int j=0;j<framecount;j++)
		 {
				framelist[j] = int(s[j]);
		 }
		 
		 idleframe = idle;
		 soundlookup = pSoundLookup;
	 }
	 int framecount;
	 int[] framelist;
	 int idleframe;
	 
	 int cycles = 0;
	 int rate = 5;
	 int return_index = 0;
	 int GetFrame(boolean idle)
	 {
		 if (idleframe == -1)
		 {
			 if (!idle)
			 {
					cycles++;
					if (cycles > rate)
					{
						cycles = 0;
						make_sound.play(soundlookup);
					}
			 }
				return -1;
		 }
			 
		 if (idle)
			 return idleframe;
			 
		 cycles++;
		 if (cycles > rate)
		 {
			 return_index = (return_index + 1) % framecount;
			 cycles = 0;
			 make_sound.play(soundlookup);
		 }
		 return return_index;
	 }
}