class screen_title
{
  PImage title_img_bg, title_img_city;
  PImage spotlight_img;
  
  basic_image pressXtoStart;

  spotlight[] title_spots;
  wave[] waves;
  
  int pressxframes = 0;
  
  screen_title()
  {
    title_img_bg = loadImage("data/MIT/title_grey_noav.png");
    title_img_city = loadImage("data/MIT/city.png");
    spotlight_img = loadImage("data/MIT/spotlight.png");
    
    color lightgrey = color(191,191,191);
  
    PImage[] waveset = new PImage[6];
    for (int j = 0; j < 6; j++)
    {
      waveset[j] = createImage(j+1,1,ARGB);
      for (int k = 0;k <= j; k++)
      {
        waveset[j].pixels[k] = lightgrey;
      }
    }
    
    waves = new wave[256];
    for (int j = 0; j < 256; j++)
    {
      float curvefunction = pow(random(1.0),2);
      float thisheight = map(curvefunction, 0, 1.0, 0, 36);
      
      float px_select = thisheight;
      px_select /= 6;
      px_select += random(0.5);
      int thisselect = int(px_select);
      
      if (thisselect >= 6)
        thisselect -= 1;
      
      waves[j] = new wave(92 + int(thisheight), float(1 + int(thisheight)) / 64, waveset[thisselect]);
      waves[j].randomX();
      
    }
    
    int maxlen = 5;
    int x_offset = 32;
    title_spots = new spotlight[maxlen];
    for (int j = 0; j < maxlen; j++)
    {
      float ratio = float(j) / (maxlen - 1);
      title_spots[j] = new spotlight(int(x_offset + ratio * (128 - 2 * x_offset)),91,(1.0 + 0.8 + ratio * 0.4) * PI, spotlight_img);
    }
    
    pressXtoStart = new basic_image(loadImage("data/MIT/pressXtoStart.png"),64,115);
    
  }
  
  void draw()
  {
    pushMatrix();
    translate(game_width / 2,game_width / 2);
    image(title_img_bg, 0,0, game_width, game_height);
    popMatrix();
    
    for (spotlight light : title_spots)
    {
      light.draw();
    }
    
    pushMatrix();
    translate(game_width / 2,game_width / 2);
    image(title_img_city, 0,0, game_width, game_height);
    popMatrix();
    
    for (wave subwave : waves)
    {
      subwave.draw();    
    }
    
    text("AVERAGE",37,15);
    
    pressxframes += 1;
    
    if (pressxframes < 60)
    {
      pressXtoStart.draw();
    }
    else if (pressxframes > 120)
    {
      pressxframes -= 120;
    }
  }
  
  void TakeInput(inputblob i)
  {
    if (i.x_down)
    {
      progress_game("title_start");
    }
    
    if (i.k1_down)
    {
      progress_game("skip1");
    }
    if (i.k2_down)
    {
      progress_game("skip2");
    }
    if (i.k3_down)
    {
      progress_game("skip3");
    }
    if (i.k4_down)
    {
      progress_game("skip4");
    }
  }
}

class spotlight
{
  float rotation;
  float base;
  
  int x;
  int y;
  
  int w;
  int h;
  
  float direction;
  float scalar_varience;
  
  float rate;
  
  PImage myImage;
  
  spotlight(int xpos, int ypos, float base_angle, PImage pImage)
  {
    x = xpos;
    y = ypos;
    
    w = 8;
    h = 38 + int(random(16));
    
    base = base_angle;
    
    direction = random(TWO_PI);
    
    scalar_varience = 0.3;
    
    rate = PI / 360 * (0.7 + random(0.6));
    
    myImage = pImage;
  }
  
  void draw()
  {
    textFont(font, 20);
    fill(255,255,255);
    pushMatrix();

    translate(x,y);
    rotate(base + scalar_varience * sin(direction));
    
    //rect(-(w/2), 0, w, h);
    image(myImage,0,0,myImage.width / 4,myImage.height / 4);//,w,2 * h);
    
    direction += rate;
    if (direction > TWO_PI)
    {
      direction -= TWO_PI;
    }
    
    
    
    popMatrix();
  }
}

class wave
{
  int x;
  float x_float;
  int y;
  PImage waveref;
  
  float speed;
  
  wave(int ypos, float pSpeed, PImage pWave)
  {
    x_float = -5.0;
    x = int(x_float);
    y = ypos;
    waveref = pWave; 
    speed = pSpeed;
  }
  
  void randomX()
  {
    x_float = random(128);    
  }
  
  void draw()
  {
    pushMatrix();
    
    x_float += speed;
    translate(x_float,y);
    image(waveref,0,0);
    
    if (x_float > 128)
    {
      x_float -= 135;
    }
    
    popMatrix();
  }
}