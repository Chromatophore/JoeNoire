
Minim minim;//audio context
AudioPlayer[] sounds;

boolean loaded = false;
void load_sounds()
{
  if (loaded)
    return;
    
   minim = new Minim(this);
    
  sounds = new AudioPlayer[30];

  sounds[0] = minim.loadFile("data/test.mp3");
  sounds[1] = minim.loadFile("data/sound/242501__gabrielaraujo__powerup-success.wav");
  sounds[2] = minim.loadFile("data/sound/242503__gabrielaraujo__failure-wrong-action.wav");
  sounds[3] = minim.loadFile("data/sound/171521__fins__button.wav");
  sounds[4] = minim.loadFile("data/MIT/talk1.wav");
  sounds[5] = minim.loadFile("data/MIT/talk2.wav");
  sounds[6] = minim.loadFile("data/MIT/talk3.wav");
  sounds[7] = minim.loadFile("data/MIT/pulse_real1.wav");
  sounds[8] = minim.loadFile("data/MIT/pulse_real2.wav");
  sounds[9] = minim.loadFile("data/sound/snow_shriek.wav");
  sounds[10] = minim.loadFile("data/MIT/talk4.wav");
  
  sounds[11] = minim.loadFile("data/I Knew a Guy.mp3");
  sounds[12] = minim.loadFile("data/Fast Talkin.mp3");
  
  
  sounds[13] = minim.loadFile("data/MIT/talk5.wav");
  sounds[14] = minim.loadFile("data/MIT/talk6.wav");
  
  for (AudioPlayer thing : sounds)
  {
    if (thing != null)
    {
      //println("Gain before: " + thing.getGain());
      thing.setGain(global_gain);
      //println("Gain after: " + thing.getGain());      
    }
  }
  
  sounds[11].setGain(global_gain + 5);
  
  loaded = true;
}

void unload_sounds()
{
  for (AudioPlayer thing : sounds)
  {
    if (thing != null)
      thing.close();
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
      
      
      
    else if (name.equals("music1"))
      id = 11;
    else if (name.equals("music2"))
      id = 12;
      
    return id;
  }
  
  void play(String name)
  {
    play(IDfromName(name));
  }
  
  void play(int id)
  {
    if (id >= 0)
    {
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
    fade_progress = 0;
    full_pass = 0;
    
    if (last_music == -1)
    {
      fade_progress = 30;
      last_music = next_music;
      play(next_music);
      full_pass = 1;
    }
  }
  
  int full_pass = 0;
  
  void service()
  {
    if (last_music != -1)
    {
      if (fade_progress < 30)
      {
        fade_progress += fade_interval;
        sounds[last_music].setGain(down_gain + global_gain - fade_progress);
      }
      else if (full_pass == 0 && fade_progress < 60)
      {
        full_pass = 1;
        halt(last_music);
        last_music = next_music;
        play(next_music);
        fade_progress += fade_interval;
      }
    }
    
    if (next_music != -1 & fade_progress > 30)
    {
      if (fade_progress < 60)
      {
        fade_progress += fade_interval;
        float gain = down_gain + global_gain - (60 - fade_progress);
        sounds[next_music].setGain(gain);
      }
      else if (next_music != -1)
      {
        next_music = -1;
        full_pass = 2;
      }
    }
    
    
    
  }
  
  void halt(String name)
  {
    halt(IDfromName(name));
  }
  
  void halt(int id)
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
      sounds[last_music].setGain(global_gain + down_gain);
    }
    
    // make breathing louder
    sounds[7].setGain(up_gain);
    sounds[8].setGain(up_gain);
    
    // reduce music files by down_gain:
    
  }
}