
Minim minim;//audio context
AudioPlayer[] sounds;

boolean loaded = false;
void load_sounds()
{
  if (loaded)
    return;
    
   minim = new Minim(this);
    
  sounds = new AudioPlayer[10];

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
    
  for (AudioPlayer thing : sounds)
  {
    if (thing != null)
    {
      //println("Gain before: " + thing.getGain());
      thing.setGain(global_gain);
      //println("Gain after: " + thing.getGain());      
    }
  }
  
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
      
    return id;
  }
  
  void play(String name)
  {
    int id = IDfromName(name);
    
    if (id >= 0)
    {
      sounds[id].rewind();
      sounds[id].play();
    }
  }
  
  void halt(String name)
  {
    int id = IDfromName(name);
    
    if (id >= 0)
    {
      sounds[id].pause();
    }
  }
  
  void end_program()
  {
    unload_sounds();    
  }
  
  void breath_loudness(float factor)
  {
    // as is our calmness, 1.0 is fully calm
    // we need to reverse this:
    factor = 1 - factor;
    
    float up_gain = global_gain + (20 * factor) - 15;
    float down_gain = global_gain - (10 * factor);
    
    // make breathing louder
    sounds[7].setGain(up_gain);
    sounds[8].setGain(up_gain);
    
    // reduce music files by down_gain:
    
  }
}