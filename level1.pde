
class level1
{
  basic_image WareHouseBG;
  basic_image WareHouseSky;
  basic_image Crate;
  
  float box_current_x;
  
  float current_camera_x;
  
  level1()
  {
    WareHouseBG = new basic_image(loadImage("data/warehouse.png"),-128,64);
    WareHouseSky = new basic_image(loadImage("data/warehouse_sky.png"),64,256);
    Crate = new basic_image(loadImage("data/crate1.png"),0,0);
    
    new_box();
    current_camera_x = 512 - 128;
  }
  
  void draw()
  {
    WareHouseSky.movePos(0,-0.02);
    WareHouseSky.draw();
    
    box_current_x -= 0.5;
    
    // attempt to draw the box in the middle of the screen but clamp it such that we don't move the camera off screen
    float camera_x = box_current_x;
    if (camera_x > 512 - 64)
      camera_x = 512 - 64;
    if (camera_x < 64)
      camera_x = 64;
      
    if (camera_x > current_camera_x)
    {
      current_camera_x += 0.1 * (camera_x - current_camera_x);
    }
    else if (camera_x < current_camera_x)
    {
      current_camera_x -= 0.1 * (current_camera_x - camera_x);
    }
      
    //print(box_current_x + "\n");
    Crate.setPos(64 + box_current_x - current_camera_x,51);
    
    if (box_current_x < -64)
    {
      box_current_x += 256;
    }
    
    // relationship from camera to the midpoint of the texture will be:
    float BGpos = -1 * current_camera_x + 256 + 64;
    WareHouseBG.setPos(BGpos,64);
    WareHouseBG.draw();
    
    Crate.draw();
  }
  
  void new_box()
  {
    box_current_x = 512 + 64;
    
  }
  
  void nextCrate()
  {
    box_current_x += 256;
  }
}