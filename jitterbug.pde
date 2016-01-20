
int maximum_cycle = 1000;
int minimum_cycle = 250;

class jitterbug
{
  jitterbug()
  {
    pulse_milli = millis() + map(next_calm, 0,1.0,minimum_cycle,maximum_cycle);
  }
  
  int jitter_steps = 15;
  float jitter_range = 2;
  int jitter_current = 0;
  float jitter_x_last;
  float jitter_y_last;
  float jitter_x;
  float jitter_y;
  
  // We pump the marker into position by getting the pulse right:
  float marker_position = 50;
  
  // How out of place it is adds to the panic bar behind it.
  
  float overall_state = 1.0;
  float next_calm = 1.0;
  
  // We can have our calmness set here but we will stop using this:
  void set_calm(float calmness)
  {
    next_calm = calmness;
    theUI.set_calm(constrain(next_calm,0.0,2.0));
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
  
  // Recalculate Calm is called whenever we reach the end of our jitter cycle. It is called internally
  private void recalc_calm()
  {
    // Tell the UI to recalculate the amount of jitter to apply to the cursor.
    theUI.calc_jitter();
    
    if (next_calm > 1)
    {
      next_calm = 2 - next_calm;      
    }
    if (next_calm < 0)
      next_calm = 0;
    //print(next_calm + "\n");
    
    pulse_nextmax = int(map(next_calm, 0,1.0,minimum_cycle,maximum_cycle));
    
    jitter_range = map(next_calm,  0.0,0.9,  12,0);
    if (jitter_range < 0)
      jitter_range = 0;
    jitter_steps = int(map(next_calm,  0.0,1.0,  1,15));
    
    jitter_x = random(jitter_range) - jitter_range / 2;
    jitter_y = random(jitter_range) - jitter_range / 2;
  }
  
  float apply_jitter_x(float x)
  {
    return x + lerp(jitter_x_last,jitter_x,jitter_current / float(jitter_steps));
  }
  
  float apply_jitter_y(float y)
  {
    return y + lerp(jitter_y_last,jitter_y,jitter_current / float(jitter_steps));
  }
  
  boolean pulse = false;
  int pulse_progress = 0;
  int pulse_nextmax = maximum_cycle;
  int pulse_max = maximum_cycle;
  
  float pulse_milli = 0;
  
  int calm_button_score = 0;
  
  
  float calm_start = -1;
  float release_start = -1;
  
  float hold_timer = 0.0;
  
  float hold_total;
  float release_total;
  
  float ideal_beat_total = 2000;
  
  void reset_pulse()
  {
    ideal_beat_total = map(next_calm, 0,1.0,minimum_cycle,maximum_cycle);
    pulse_milli = millis() + ideal_beat_total;
  }
  
  int things_done;
  
  void assess_input_score()
  {
    things_done += 1;
    float total_delta = hold_total + release_total;
    //println("delta: " + total_delta);
    //println("% held: " + (hold_total/total_delta));

    // we need to work out how even the breathe was
    // and we need to work out how close it is to the correct cycle of time
    
    float score = map(total_delta,0,ideal_beat_total,0.0,1.0);
    
    // numbers below 1 will indicate that the beat was too fast, and numbers above 1 will indicate that the beat was too slow
    // we want hyper ventilating to go up, so, we do this:
    marker_position += 2.0 - (constrain(score,0.0,2.0));
  }
  
  void check_did_anything()
  {
    if (things_done > 1)
    {
      // we're ok this turn
      things_done = 1;
    }
    else if (things_done == 0)
    {
      // we should be punished
      float difference = marker_position - 50;
      if (marker_position <= 50)
      {
        marker_position -= (1 + difference / 20); 
      }
      else
      {
        marker_position += (1 + difference / 20); 
      }
      
      marker_position = constrain(marker_position,0,100);
    }
    else if (things_done == 1)
    {
      // weve skipped a beat, but, we could easily get stiffed on this so we have this one beat window each time.
      things_done = 0;
    }
  }
  
  void TakeInput(inputblob i)
  {
    // This is also called every frame so we should make use of it
    // Take input first so we give them the benefit of an extra frame to see it coming I guess

    if (i.c_down)
    {
      release_total = millis() - release_start;      
      if (release_start > 0)
      {
        //println("Released time: " + hold_total);
        assess_input_score();
      }
      
      calm_start = millis();
      //println("Calm start: " + calm_start);
    }
    
    if (i.c_state > 0)
    {
      hold_timer = millis();
    }
    else if (calm_start > 0)
    {
      //println("Held end: " + hold_timer);
      hold_total = hold_timer - calm_start;
      //println("Held time: " + hold_total);
      
      calm_start = -1;
      
      release_start = millis();
    }
    
    marker_position = constrain(marker_position,0,100);
    float difference = abs(marker_position - 50);
    overall_state -= difference;
    theUI.set_buildup(overall_state);
    
    theUI.SetMarker(map(marker_position,0,100,0.0,2.0));
    
    pulse_progress++;
    if (millis() > pulse_milli)
    {
      reset_pulse();
      pulse = !pulse;
      theUI.pulse(pulse);
      
      if (pulse == false)
      {
        check_did_anything();
      }
    }
  }
}