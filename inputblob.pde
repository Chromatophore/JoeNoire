class inputblob
{
  int z_state;
  int x_state;
  int c_state;
  
  boolean z_down;
  boolean x_down;
  boolean c_down;
  
  boolean a_down;
  
  
  boolean k1_down;
  boolean k2_down;
  boolean k3_down;
  boolean k4_down;
  
  int up_state;
  int down_state;
  int left_state;
  int right_state;
  
  float x_axis;
  float y_axis;
  
  inputblob()
  {
    
  }
  
  void input_has_been_read(boolean true_wipe)
  {
    z_down = false;
    x_down = false;
    
    if (true_wipe)
    {
      c_down = false;
      a_down = false;
      k1_down = false;
      k2_down = false;
      k3_down = false;
      k4_down = false;
    }
    
  }
  
  void do_input(char c, int down)
  {
    if (key == CODED)
    {
      if (keyCode == UP)
        up_state = down;
      if (keyCode == DOWN)
        down_state = down;
      if (keyCode == LEFT)
        left_state = down;
      if (keyCode == RIGHT)
        right_state = down;
    }
    else
    {
       if (c == 'z')
       {
         z_state = down;
         if (down == 1)
           z_down = true;
       }
       if (c == 'x')
       {
         x_state = down;
         if (down == 1)
           x_down = true;
       }
       if (c == 'c')
       {
         c_state = down;
         if (down == 1)
           c_down = true;
       }
       if (c == 'a')
       {
         if (down == 1)
           a_down = true;
       }
       
       if (c == '1')
       {
         if (down == 1)
           k1_down = true;
       }
       if (c == '2')
       {
         if (down == 1)
           k2_down = true;
       }
       if (c == '3')
       {
         if (down == 1)
           k3_down = true;
       }
       if (c == '4')
       {
         if (down == 1)
           k4_down = true;
       }
    }
    
    x_axis = -1 * left_state + 1 * right_state;
    y_axis = -1 * up_state + 1 * down_state; 
    
    //print(x_axis + " " + y_axis + "\n");

  }
}