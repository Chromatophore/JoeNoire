


class jitterbug
{
  jitterbug()
  {
    
  }
  
  int jitter_steps = 15;
  float jitter_range = 2;
  int jitter_current = 0;
  float jitter_x_last;
  float jitter_y_last;
  float jitter_x;
  float jitter_y;
  
  float next_calm = 1.0;
  
  void set_calm(float calmness)
  {
    next_calm = calmness;
    theUI.set_calm(constrain(next_calm,0.0,2.0));
  }
  
  void recalc_calm()
  {
    theUI.calc_jitter();
    
    if (next_calm > 1)
    {
      next_calm = 2 - next_calm;      
    }
    if (next_calm < 0)
      next_calm = 0;
    //print(next_calm + "\n");
    
    jitter_range = map(next_calm,  0.0,0.9,  12,0);
    if (jitter_range < 0)
      jitter_range = 0;
    jitter_steps = int(map(next_calm,  0.0,1.0,  1,15));
    
    jitter_x = random(jitter_range) - jitter_range / 2;
    jitter_y = random(jitter_range) - jitter_range / 2;
  }
  
  void calc_jitter()
  {
    if (jitter_current == jitter_steps)
    {
      jitter_x_last = jitter_x;
      jitter_y_last = jitter_y;

      jitter_current = 0;
      recalc_calm();
    }
    else
    {
      jitter_current++;
    }
  }
  
  float apply_jitter_x(float x)
  {
    return x + lerp(jitter_x_last,jitter_x,jitter_current / float(jitter_steps));
  }
  
  float apply_jitter_y(float y)
  {
    return y + lerp(jitter_y_last,jitter_y,jitter_current / float(jitter_steps));
  }
}