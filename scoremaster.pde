class scoremaster
{
	int risermax = 20;
	score_riser[] score_rise_effects;
	
	basic_image good;
	basic_image ehhh;
	basic_image bad;
	
	scoremaster()
	{
		score_rise_effects = new score_riser[risermax];
		
		good = new basic_image(loadImage("data/MIT/UI/smile.png"),0,0);
		ehhh = new basic_image(loadImage("data/MIT/UI/ehhh.png"),0,0);
		bad	= new basic_image(loadImage("data/MIT/UI/sad.png"),0,0);
	}
	
	void add_riser(score_riser s)
	{
		for (int j = 0; j < risermax;j++)
		{
			// this is awful but I have to get this done so bad...
			if (score_rise_effects[j] == null)
			{
				score_rise_effects[j] = s;
				break;
			}
		}
	}
	
	int lifemax = 60;
	
	void draw()
	{
		textFont(font_ui, 14);
		for (int j = 0; j < risermax; j++)
		{
			score_riser s = score_rise_effects[j];
			if (s != null)
			{
				s.y -= 0.1;
				s.life += 1;
				
				if (s.life > lifemax)
				{
					score_rise_effects[j] = null;
				}
				else
				{
					basic_image ref = null;
					if (s.type == 0)
					{
						fill(color(128,128,128));
						ref = null;
					}
					else if (s.type == 1)
					{
						fill(color(128,128,128));
						ref = ehhh;
					}
					else if (s.type == 2)
					{
						fill(color(0,255,0));
						ref = good;
					}
					else if (s.type == 3)
					{
						fill(color(255,0,0));
						ref = bad;
					}
					
					String o = s.value;
					text(o, s.x - 4, s.y + 2);
					if (ref != null)
					{
						ref.setPos(s.x - 2 + (o.length()) * 4,s.y);
						ref.draw();
					}
				}
			}
		}
	}
	
}

class score_riser
{
	float x;
	float y;
	
	String value;
	int type;
	
	int life;
	
	 score_riser(float xpos, float ypos, String pValue, int pType)
	 {
		 x = xpos;
		 y = ypos;
		 value = pValue;
		 type = pType;
		 life = 0;
	 }
}