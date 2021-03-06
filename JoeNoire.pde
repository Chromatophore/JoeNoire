/* @pjs preload="data/MIT/chat_avs/boss1.png,data/MIT/chat_avs/boss2.png,data/MIT/chat_avs/goon1.png,data/MIT/chat_avs/goon2.png,data/MIT/chat_avs/goonB1.png,data/MIT/chat_avs/goonB2.png,data/MIT/chat_avs/lady.png,data/MIT/chat_avs/lady_hand.png,data/MIT/chat_avs/lady_hand_brace.png,data/MIT/chat_avs/lady_hand_rings.png,data/MIT/chat_avs/lady_hand_rings2.png,data/MIT/chat_avs/lady_hand_rings2i.png,data/MIT/chat_avs/man_end0.png,data/MIT/chat_avs/man_end1.png,data/MIT/chat_avs/marco.png,data/MIT/chat_avs/mystery_man.png,data/MIT/chat_avs/other_lady.png,data/MIT/chat_avs/portraitbase.png,data/MIT/chat_avs/superboss.png,data/MIT/chat_avs/tannoy1.png,data/MIT/chat_avs/tannoy2.png,data/MIT/cutscenes/bank.png,data/MIT/cutscenes/bar.png,data/MIT/cutscenes/booze.png,data/MIT/cutscenes/superboss_cutscene.png,data/MIT/cutscenes/superboss_cutscene_2.png,data/MIT/epilogue/credits.png,data/MIT/epilogue/epilogue_1.png,data/MIT/epilogue/epilogue_2.png,data/MIT/epilogue/epilogue_3.png,data/MIT/epilogue/epilogue_4.png,data/MIT/game_shot.png,data/MIT/lv1/conveyor.png,data/MIT/lv1/conveyorwheels.png,data/MIT/lv1/crate1.png,data/MIT/lv1/crate2.png,data/MIT/lv1/l1.png,data/MIT/lv1/l1z1.png,data/MIT/lv1/l1z2.png,data/MIT/lv1/l1z3.png,data/MIT/lv1/l2.png,data/MIT/lv1/l2z1.png,data/MIT/lv1/l2z2.png,data/MIT/lv1/l2z3.png,data/MIT/lv1/leftside_arrow.png,data/MIT/lv1/next.png,data/MIT/lv1/rightside_arrow.png,data/MIT/lv1/warehouse.png,data/MIT/lv1/warehouse_sky.png,data/MIT/lv2/bagcursor.png,data/MIT/lv2/bat.png,data/MIT/lv2/coin0.png,data/MIT/lv2/coin1.png,data/MIT/lv2/coin2.png,data/MIT/lv2/coin3.png,data/MIT/lv2/coin4.png,data/MIT/lv2/coin5.png,data/MIT/lv2/coin6.png,data/MIT/lv2/coin7.png,data/MIT/lv2/coin8.png,data/MIT/lv2/coin9.png,data/MIT/lv2/glass_shatter.png,data/MIT/lv2/goonbag1.png,data/MIT/lv2/goonbag2.png,data/MIT/lv2/heist.png,data/MIT/lv2/heist_2.png,data/MIT/lv2/heist_2_break.png,data/MIT/lv2/heist_2_mid.png,data/MIT/lv2/heist_3.png,data/MIT/lv2/neck1.png,data/MIT/lv2/neck2.png,data/MIT/lv2/neck3.png,data/MIT/lv2/ring_blue.png,data/MIT/lv2/ring_green.png,data/MIT/lv2/ring_pink.png,data/MIT/lv2/ring_red.png,data/MIT/lv2/streetview.png,data/MIT/lv2/streetview_a.png,data/MIT/lv2/streetview_ar.png,data/MIT/lv2/streetview_b.png,data/MIT/lv2/streetview_br.png,data/MIT/lv2/streetview_c.png,data/MIT/lv3/arm_down.png,data/MIT/lv3/arm_up.png,data/MIT/lv3/family.png,data/MIT/lv3/gunshot.png,data/MIT/lv3/man_base.png,data/MIT/lv3/necklace.png,data/MIT/lv3/tiepin.png,data/MIT/lv3/watch.png,data/MIT/skinnyteeth.png,data/MIT/title/city.png,data/MIT/title/pressXtoStart.png,data/MIT/title/spotlight.png,data/MIT/title/title_grey.png,data/MIT/title/title_grey_noav.png,data/MIT/UI/calm_marker.png,data/MIT/UI/calm_marker2.png,data/MIT/UI/cindicate1.png,data/MIT/UI/cindicate2.png,data/MIT/UI/cindicate3.png,data/MIT/UI/cindicate4.png,data/MIT/UI/crosshair.png,data/MIT/UI/cursor1.png,data/MIT/UI/ehhh.png,data/MIT/UI/helppage.png,data/MIT/UI/learn2c1.png,data/MIT/UI/learn2c2.png,data/MIT/UI/panic.png,data/MIT/UI/sad.png,data/MIT/UI/smile.png,data/MIT/UI/textbox.png,data/MIT/UI/textbox_nox.png,data/MIT/UI/UI_base.png,data/MIT/UI/UI_base_a.png,data/MIT/UI/UI_base_b.png,data/MIT/UI/volume.png"; font="data/Minimal4.ttf,data/RetroDeco.ttf"; */  //<>//

import ddf.minim.*; //<>// //<>//

// GLOBAL JS SETTINGS:
boolean js_mode = false;
boolean js_scale_images = false;
float js_scale = 4;

// GLOBAL SETTINGS:
float global_gain = -10;
float volume_change_rate = 0.1;
float volume_cap_up = -10;
float volume_cap_dn = -40;

float breath_ms_delay = -100;

int game_width = 128;
int game_height = 128;

// GLOBAL VARIABLES
jitterbug jitter;
basic_image guncursor;
UI theUI;
inputblob inp;
sounder make_sound;
scoremaster scorer;
textbox texter;
curtains eye_c;

boolean show_ui = true;

boolean text_box_finished = false;
String text_box_finish_name = "";

PFont font;
PFont font_ui;

int necklace_select = 0;
int ending_get = 0;

// VARIABLES THAT ARE GLOBAL BUT REALLY ONLY USED HERE:
int SUPER_GAME_STATE = 0;

screen_title titlescreen;

level1 lv1;
level2 lv2;
level2_street lv2_b;
level3 lv3;
cutscene cutscene_engine;

int shake_descaler = 0;
int shake_frames = 0;
float shake_scale;
float shake_start_scale;

color black;
color dgrey;
color lgrey;
color white;

basic_image help_screen;

void setup()
{
	// Set up window:
	size(512,512, P2D);

	js_mode = js_test();

	if (!js_mode)
	{
		((PGraphicsOpenGL)g).textureSampling(3);
		// Try and prevent resizing because it does not work at all
		surface.setResizable(false);
	}
	
	// Setup image mode, stroke and background settings
	imageMode(CENTER);
	noStroke();
	background(255);

	// Create instances of all our classes.
	inp = new inputblob();
	theUI = new UI();
	scorer = new scoremaster();
	make_sound = new sounder();
	eye_c = new curtains();
	cutscene_engine = new cutscene();

	black = color(0,0,0);
	dgrey = color(85,85,85);
	lgrey = color(170,170,170);
	white = color(255,255,255);
	
	// Load fonts:

	String font_string1 = "RetroDeco";
	String font_string2 = "Minimal4";

	int size1 = 20;
	int size2 = 14;

	if (!js_mode)
	{
		font_string1 += ".ttf";
		font_string2 += ".ttf";
	}
	else
	{
		size1 *= js_scale;
		size2 *= js_scale;
	}


	font = createFont(font_string1,size1,false);
	font_ui = createFont(font_string2,size2,false);

	indi_textFont(font, 20);

	// Initialise text system
	textbox_setup();

	// Load the gun cursor because it's used in multiple levels and globals are lazy!
	guncursor = new basic_image(indi_loadImage("data/MIT/UI/crosshair.png"),64,64);
	help_screen = new basic_image(indi_loadImage("data/MIT/UI/helppage.png"),64,64);
	
	// Start the game
	progress_game("game_reset");
}

// Allows us to shake the screen. Screen shake doesn't effect some elements, as visible in the main draw routine
void shake_screen(float mag, int how_many_frames, int how_to_scale)
{
	shake_frames = how_many_frames;
	shake_scale = mag;
	shake_start_scale = mag;
	shake_descaler = how_to_scale;
}

void draw()
{
	boolean shake_ui = true;
	// Set up our initial scale:
	if (!js_mode)
		scale(4.0,4.0);
	
	// Set up the screen shake black out:
	fill(black);
	indi_rect(-10,-10,148,148);
	fill(white);
	
	if (!shake_ui)
	{
		pushMatrix();
	}
	
	if (shake_frames > 0)
	{
		if (shake_descaler != 0)
		{
			float ratio = shake_frames;
			ratio /= shake_descaler;
			ratio = constrain(ratio,0,1);
			shake_scale = shake_start_scale * ratio;
		}
		
		float shake_x = random(2 * shake_scale) - shake_scale;
		float shake_y = random(2 * shake_scale) - shake_scale;
		if (js_mode)
		{
			shake_x *= js_scale;
			shake_y *= js_scale;
		}
		translate(shake_x,shake_y);
		shake_frames--;
	}
	
	if (texter != null)
	{
		if (texter.TakeInput(inp))
		{
			inp.input_has_been_read(false);
		}
		else
		{
			// we finished
			text_box_finished = true;
			text_box_finish_name = texter.name_of_sequence;
			texter = null;
			
		}
	}
	
	if (SUPER_GAME_STATE == 0 || SUPER_GAME_STATE == 1)
	{
		if (SUPER_GAME_STATE == 0)
			titlescreen.TakeInput(inp);
			
		if (titlescreen != null)
			titlescreen.draw();
	}
	else if (SUPER_GAME_STATE == 100)
	{
		lv1.TakeInput(inp);
		lv1.draw();
	}
	else if (SUPER_GAME_STATE == 200 || SUPER_GAME_STATE == 220)
	{
		lv2.TakeInput(inp);
		lv2.draw();
	}
	else if (SUPER_GAME_STATE == 210)
	{
		lv2_b.TakeInput(inp);
		lv2_b.draw();
	}
	else if (SUPER_GAME_STATE == 300)
	{
		lv3.TakeInput(inp);
		lv3.draw();
	}
	
	
	// we can do screen shake too lol
	//translate(random(2) - 1.0, random(2) - 1.0);
	
	// Draw whatever scene we're on
	
	//
	

	
	//lv2.TakeInput(inp);
	//lv2.draw();
	
	//lv2_b.TakeInput(inp);
	//lv2_b.draw();
	
	if (show_ui)
	{
		jitter.TakeInput(inp);
		theUI.TakeInput(inp);
		if (!shake_ui)
		{
			popMatrix();
		}
		theUI.draw();
		scorer.draw();
	}
	
	
	cutscene_engine.draw();
	
	eye_c.draw();
	
	if (texter != null)
		texter.draw();
	
	// Inform the input class to clear the down states because we're at the end of the frame:
	inp.input_has_been_read(true);

	make_sound.service();
	text_box_finished = false;
	//println(frameRate);

	if (inp.h_state)
		help_screen.draw();
}

void progress_game(String info)
{
	if (info.equals("game_reset"))
	{
		// throw out old jitter
		jitter = new jitterbug();

		cutscene_engine.play_scene(0);
		eye_c.change(true,"");
		titlescreen = new screen_title();
		make_sound.play_music("music1");
		SUPER_GAME_STATE = 0;
		theUI.showhide(false);
		theUI.chill = false;
		theUI.sounds(false);
		theUI.hijack_quit = false;
		theUI.SetShowLearn(false);
		theUI.SetShowTracker(true);
		theUI.ResetCursor();
		theUI.OverrideCursor(false,null);
		
		jitter.anxiety(false);
		jitter.inaction_off();
		jitter.player_must_pump = false;
		jitter.MoveMarker(50);
		
		lv1 = null;
		lv2 = null;
		lv2_b = null;
		lv3 = null;
	}
	else if (SUPER_GAME_STATE == 0 && info.equals("title_start"))
	{
		load_id(make_sound.IDfromName("music2"));	// try to preload the audio.

		eye_c.change(false, "title_fade_out");
		make_sound.stop_music();
		
		SUPER_GAME_STATE = 1;
	}
	else if (SUPER_GAME_STATE == 1 && info.equals("title_fade_out"))
	{
		eye_c.draw();
		lv1 = new level1();
		titlescreen = null;
		theUI.showhide(true);
		theUI.sounds(false);
		SUPER_GAME_STATE = 100;
	}
	else if (SUPER_GAME_STATE == 100 && info.equals("level1_end"))
	{
		SUPER_GAME_STATE = 101;
		cutscene_engine.play_scene(1);
	}
	else if (SUPER_GAME_STATE == 101 && info.equals("eyes_open_cutscene_1"))
	{
		SUPER_GAME_STATE = 102;
		cutscene_engine.blip();

		load_id(make_sound.IDfromName("music4"));	// try to preload the audio.
	}
	else if (SUPER_GAME_STATE == 102 && info.equals("eyes_close_cutscene_1"))
	{
		SUPER_GAME_STATE = 110;
		cutscene_engine.play_scene(2);
	}
	
	else if (SUPER_GAME_STATE == 110 && info.equals("eyes_open_cutscene_2"))
	{
		SUPER_GAME_STATE = 111;
		cutscene_engine.blip();

		load_id(make_sound.IDfromName("music5"));	// try to preload the audio.
	}
	else if (SUPER_GAME_STATE == 111 && info.equals("eyes_close_cutscene_2"))
	{
		cutscene_engine.play_scene(0);
		theUI.showhide(true);
		SUPER_GAME_STATE = 200;
		eye_c.draw();
		lv2 = new level2();
	}
	else if (SUPER_GAME_STATE == 200 && info.equals("level_2_cutscene_1"))
	{
		cutscene_engine.play_scene(10);
		SUPER_GAME_STATE = 201;
	}
	else if (SUPER_GAME_STATE == 201 && info.equals("eyes_open_cutscene_10"))
	{
		SUPER_GAME_STATE = 202;
		cutscene_engine.blip();
	}
	else if (SUPER_GAME_STATE == 202 && info.equals("eyes_close_cutscene_10"))
	{
		SUPER_GAME_STATE = 210;
		cutscene_engine.play_scene(0);
		eye_c.draw();
		lv2_b = new level2_street();

		load_id(make_sound.IDfromName("music6"));	// try to preload the audio.
	}
	else if (SUPER_GAME_STATE == 210 && info.equals("level2b_end"))
	{
		cutscene_engine.play_scene(20);
		SUPER_GAME_STATE = 211;
	}
	else if (SUPER_GAME_STATE == 211 && info.equals("eyes_open_cutscene_20"))
	{
		SUPER_GAME_STATE = 212;
		cutscene_engine.blip();
	}
	else if (SUPER_GAME_STATE == 212 && info.equals("eyes_close_cutscene_20"))
	{
		SUPER_GAME_STATE = 220;
		cutscene_engine.play_scene(0);
		
		theUI.showhide(true);
		
		if (lv2 == null)
		{
			eye_c.draw();
			lv2 = new level2();
		}
			
		lv2_b = null;
		lv2.race(0);

		load_id(make_sound.IDfromName("music7"));	// try to preload the audio.
	}
	else if (SUPER_GAME_STATE == 220 && info.equals("heist2_eyes_open"))
	{
		lv2.race(1);
	}
	else if (SUPER_GAME_STATE == 220 && info.equals("level2_finalend"))
	{
		SUPER_GAME_STATE = 221;
		cutscene_engine.play_scene(30);
	}
	else if (SUPER_GAME_STATE == 221 && info.equals("eyes_open_cutscene_30"))
	{
		SUPER_GAME_STATE = 222;
		cutscene_engine.blip();

		load_id(make_sound.IDfromName("music8"));	// try to preload the audio.
	}
	else if (SUPER_GAME_STATE == 222 && info.equals("end_chapter_2"))
	{
		SUPER_GAME_STATE = 300;
		theUI.showhide(true);
		if (lv3 == null)
		{
			eye_c.draw();
			lv3 = new level3();
		}
	}
	else if (SUPER_GAME_STATE == 300 & info.equals("chapter_3_eyes_open"))
	{
		lv3.callback(1);
	}
	else if (info.equals("credits"))
	{
		SUPER_GAME_STATE = 400;
		cutscene_engine.play_scene(1000);
	}
	
	
	else if (info.equals("skip1"))
	{
		SUPER_GAME_STATE = 100;
		progress_game("level1_end");
	}
	else if (info.equals("skip2"))
	{
		theUI.showhide(true);
		make_sound.play_music("music4");
		eye_c.open = false;
		SUPER_GAME_STATE = 202;
		progress_game("eyes_close_cutscene_10");
	}
	else if (info.equals("skip3"))
	{
		eye_c.open = false;
		SUPER_GAME_STATE = 222;
		progress_game("end_chapter_2");
	}
	else if (info.equals("skip4"))
	{
		SUPER_GAME_STATE = 400;
		cutscene_engine.play_scene(1000);
	}
	
	
}

class basic_image
{
	float x_float, y_float;
	float w, h;
	PImage imageRef;
	float rotation;
	
	basic_image(PImage pImageRef, int xpos, int ypos)
	{
		imageRef = pImageRef;
		x_float = xpos;
		y_float = ypos;
		rotation = 0.0;
		w = 0;
		h = 0;
	}
	
	void setPos(float xpos, float ypos)
	{
		x_float = xpos;
		y_float = ypos;
	}

	void setWH(float pW, float pH)
	{
		w = pW;
		h = pH;
	}
	void setImage(PImage pImageRef)
	{
		imageRef = pImageRef;
	}

	void movePos(float xpos, float ypos)
	{
		x_float += xpos;
		y_float += ypos;
	}
	
	void setRotate(float rot)
	{
		rotation = rot;
	}
	void modRotate(float rot)
	{
		rotation += rot;
	}
	
	int fader = -1;
	int fademod = 1;
	
	void fade(boolean pDirection)
	{
		if (pDirection)
		{
			fademod = 3;
			fader = 0;
		}
		else
		{
			fademod = -3;
			fader = 256;
		}
		// tint(255, 127);	// Display at half opacity
	}
	
	void draw()
	{
		pushMatrix();
		
		if (js_mode)
			translate(x_float * js_scale,y_float * js_scale);
		else
			translate(x_float,y_float);

		if (rotation != 0.0)
		{
			rotate(rotation);
		}
		
		boolean correct_fade = false;
		if (fader >= 0)
		{
			correct_fade = true;
			tint(255, fader);
			fader = constrain(fader + fademod,0,256);
			if (fader == 0 || fader == 256)
			{
				fader = -1;
			}
		}
		
		if (w != 0 || h != 0)
		{
			if (js_mode)
				image(imageRef,0,0,w * 4,h * 4);
			else
				image(imageRef,0,0,w,h);
		}
		else
		{
			if (js_mode)	
			{
				if (js_scale_images) // images need to be scaled
					image(imageRef,0,0,imageRef.width * js_scale, imageRef.height * js_scale);
				else // images bigger already
					image(imageRef,0,0);
			}
			else
				image(imageRef,0,0);
		}
		
		if (correct_fade)
		{
			noTint();
		}
		
		popMatrix();
	}
	
	boolean do_box_test(float x, float y)
	{
		if (js_mode)
			return box_test(x,y, x_float, y_float, imageRef.width / (2 * js_scale), imageRef.height / (2 * js_scale));
		else
			return box_test(x,y, x_float, y_float, imageRef.width / 2, imageRef.height / 2);
	}
}

// Input handling
void keyPressed() // KeyEvent e)
{
	inp.do_input(key, 1);
}

void keyReleased() // KeyEvent e)
{
	inp.do_input(key, 0);
}

void stop()
{
	make_sound.end_program();
}

boolean box_test(float x, float y, float box_x, float box_y, float w, float h)
{
	boolean minx = x > (box_x - w);
	boolean miny = y > (box_y - h);
	boolean maxx = x < (box_x + w);
	boolean maxy = y < (box_y + h);
	// if all these things are true then we're solid.
	return minx & miny & maxx & maxy;
}

void indi_rect(float x, float y, float w, float h)
{
	if (js_mode)
		rect(4 * x,4 * y,4 * w,4 * h);
	else
		rect(x,y,w,h);
}

void indi_text(String s, float x, float y)
{
	if (js_mode)
	{
		text(s,4 * x,4 * y);
	}
	else
		text(s,x,y);
}

void indi_textFont(PFont f, float size)
{
	if (js_mode)
		size *= js_scale;
	
	textFont(f, size);
}

PImage indi_loadImage(String path)
{
	if (js_mode)
	{
		// example path:
		//"data/MIT/lv3/arm_down.png"
		String path_cut = path.substring(8);
		return loadImage("data/MIT_4x" + path_cut);
	}
	else
	{
		return loadImage(path);
	}
}