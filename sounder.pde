
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
  }
  
  void play(String name)
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
    
    
    if (id >= 0)
    {
      sounds[id].rewind();
      sounds[id].play();
    }
  }
  
  void end_program()
  {
    unload_sounds();    
  }
}