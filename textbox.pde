 //<>//
int[] var_width_array;
// This is going to be a thing that takes a string line of code and displays it as a text box I guess

float text_box_open_speed = 4;

PortraitSet[] portrait_db;
PImage[] avatar_list;

void textbox_setup()
{
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
  var_width_array[val++] = 3;  // shorter f since it will likely be followed by a vowel
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
  
  
  portrait_db = new PortraitSet[30];
  
  
  avatar_list = new PImage[100];
  avatar_list[0] = loadImage("data/MIT/boss1.png");
  avatar_list[1] = loadImage("data/MIT/boss2.png");
  
  
  avatar_list[10] = loadImage("data/MIT/lady_hand_rings.png");
  
  portrait_db[0] = new PortraitSet("workboss","0,1",0, "talk1");
  
  portrait_db[1] = new PortraitSet("lady_hand_rings","10",0, "talk3");
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
  
  textbox(PImage pBG, PImage pBGnox, String[] pTexts)
  {
    texts = pTexts;
    for (String sub : texts)
    {
       text_total++; 
    }
    
    textbox_background = pBG;
    textbox_background_nox = pBGnox;
    
    isOpening = 1;
    SetupLine();
  }
  
  boolean FinishedLine = false;
  PortraitSet pSet;
  
  void SetupLine()
  {
    if (current_text >= text_total)
    {
      // we need to close instead
      isOpening = 0;
    }
    else
    {
      String[] breakup = split(texts[current_text],"^");
      total_portraits = 0;
      
      pSet = get_portrait_set(breakup[0]);

      this_text = breakup[1] + " ";
      string_length = this_text.length();
      charry = int( this_text.toCharArray() );
      
      init();
    
      current_text++;
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
        
        int frame = pSet.GetFrame(int(progress_so_far) == string_length);
        
        // to do fix this crash:
        image(avatar_list[pSet.framelist[frame]], 0,0);
        
        if (progress_so_far < string_length)
        {
          if (WriteFast)
            progress_so_far += 1;
          else
            progress_so_far += 0.20;
        }
        else
        {
          FinishedLine = true; 
        }
        
        translate(16,-5);
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
                    if (tempoffset > wrapsize)
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
  
  void TakeInput(inputblob i)
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
  }
}

PortraitSet get_portrait_set(String av_name)
{
  if (av_name.equals("workboss"))
  {
    return portrait_db[0];
  }
  else if (av_name.equals("lady_hand_rings"))
  {
    return portrait_db[1];    
  }
  
  return null;
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