
int maximum_cycle = 1000;
int minimum_cycle = 250;

class jitterbug
{
  boolean player_must_pump = false;
  
  jitterbug()
  {
    pulse_milli = millis() + map(overall_state, 0,1.0,minimum_cycle,maximum_cycle);
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
  float displayed_marker = 50;
  
  // How out of place it is adds to the panic bar behind it.
  
  float overall_state = 1.0;
  float state_pregradient = 1.0;
  
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
    
    float next_calm = overall_state;
    
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
  
  float calm_start = -1;
  float release_start = -1;
  
  float hold_timer = 0.0;
  
  float hold_total;
  float release_total;
  
  float ideal_beat_total = 2000;
  
  void reset_pulse()
  {
    ideal_beat_total = map(overall_state, 0,1.0,minimum_cycle,maximum_cycle);
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
    float wrong_delta = (0.5 - (hold_total / total_delta)) / 0.5;
    // wrong delta now stores how wrong we were for the delta from -1 to 1
    
    float score = 1 - map(total_delta,0,2 * ideal_beat_total,0.0,1.0);
    float score2 = wrong_delta;
    
    println(score2);
    
    if (abs(score2) > abs(score))
      score = score2;
    
    // TODO to integrage % held here somehow
    
    // numbers below 1 will indicate that the beat was too fast, and numbers above 1 will indicate that the beat was too slow
    // we want hyper ventilating to go up, so, we do this:
    marker_position = 50 * (constrain(1 + score,0.0,2.0));
    
    pump_bar();
  }
  
  void pump_bar()
  {
    // this is called every time we pump c or fail to pump c
    make_sound.breath_loudness(overall_state);
  }
  
  void apply_bar_math()
  {
    // this is called every frame
    float difference = abs(marker_position - 50) / 50;
    // difference will be a value from 0 to 1 based on how wrong we are
    // we want to get better if we're within 0.1
    
    float tick = 1.0/60;
    //println(difference);
    
    float modifier = 0;
    if (difference < 0.2)
    {
        modifier = 0.1 * tick * constrain(difference,0.3,1.0);
    }
    else if (difference < 0.4)
    {
      // we want to get worse but with a cap
      if (overall_state > 0.8)
      {
        modifier = - 0.1 * tick;
      }
      else if (overall_state < 0.4)
      {
        modifier = 0.05 * tick;
      }
    }
    else if (difference < 0.6)
    {
       if (overall_state > 0.4)
       {
         modifier = -0.06 * tick;
       }
       else
       {
         modifier = 0.05 * tick;
       }
    }
    else if (difference < 0.8)
    {
      modifier = -0.1 * tick;
    }
    else
    {
      modifier = -0.2 * tick;
    }
    
    // gradient effect where we move along a curve
    
    state_pregradient += modifier;
    state_pregradient = constrain(state_pregradient,0.0,1.0);
    
    overall_state = sin(state_pregradient * 0.5 * PI);
    
    overall_state = constrain(overall_state,0,1.0);
  }
  
  void check_did_anything()
  {
    println(things_done);
    if (things_done > 1)
    {
      // we're ok this turn
      things_done = 1;
    }
    else if (things_done == 0)
    {
      // we should be punished
      marker_position = 0;
      pump_bar();
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
    
    apply_bar_math();
    theUI.set_buildup(overall_state);
    
    marker_position = constrain(marker_position,0,100);
    displayed_marker += (marker_position - displayed_marker) * 0.1;
    
    theUI.SetMarker(map(displayed_marker,0,100,0.0,2.0));

    if (millis() > pulse_milli)
    {
      reset_pulse();
      pulse = !pulse;
      theUI.pulse(pulse);
      
      if (pulse == false && player_must_pump)
      {
        check_did_anything();
      }
    }

  }
}