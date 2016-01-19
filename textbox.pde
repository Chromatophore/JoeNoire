 //<>//
int[] var_width_array;
// This is going to be a thing that takes a string line of code and displays it as a text box I guess

float text_box_open_speed = 4;

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
}

class textbox
{
  int test_progress;
  String this_text;
  float progress_so_far;
  int string_length;
  PImage[] portrait;
  
  float text_box_height;
  PImage textbox_background;
  
  int isOpening;
  
  int[] charry;
  
  int firstline_clip_marker = 0;
  int secondline_clip_marker = 0;
  
  
  textbox(PImage pBG, PImage[] pPortraits, String pText)
  {
    portrait = pPortraits;
    this_text = pText + " ";
    string_length = this_text.length();
    
    textbox_background = pBG;

    charry = int( this_text.toCharArray() );
    
    init();
  }
  
  void init()
  {
    progress_so_far = 0;
    isOpening = 1;
    test_progress = 0;
    firstline_clip_marker = 0;
    secondline_clip_marker = 0;    
  }
  
  void draw()
  {
    int wrapsize = 86;
    
    test_progress += 1; //<>//
    if (test_progress > 600)
    {
      isOpening = 0;
    }
    
    pushMatrix();
    if (isOpening == 1)
    {
      translate(64,128 - 20);
      if (text_box_height < 40)
      {
        text_box_height += text_box_open_speed;
        image(textbox_background,0,0,128,text_box_height);
      }
      else
      {
        image(textbox_background,0,0);
        translate(-44,0);
        
        int frame = int(progress_so_far) % 2;
        if (int(progress_so_far) == string_length)
          frame = 0;
        image(portrait[frame], 0,0);
        
        if (progress_so_far < string_length)
        {
          progress_so_far += 0.20;
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
        image(textbox_background,0,0,128,text_box_height);
      }
    }
    
    if (test_progress > 1000)
    {
      test_progress = 0;
      init();
    }
  
    
    popMatrix();
  }
  
}