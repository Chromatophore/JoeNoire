


class curtains
{
	
	boolean open;
	boolean work = false;
	
	boolean active;
	int progress;
	
	curtains()
	{
		active = false;
		open = false;
		work = false;
		finish_string = "";
	}
	
	void change(boolean state, String pfinish_string)
	{
		finish_string = pfinish_string;
		if (open != state)
		{
			open = state;
			work = true;
			progress = 0;
		}
		else
		{
			progress_game(finish_string);
		}
		
	}
	
	String finish_string;
	
	void draw()
	{
		fill(0,0,0);
		
		float pos1 = 0;
		float pos2 = 64;
			
			
		if (progress >= 123)
		{
			work = false;
			progress = 0;
			if (!finish_string.equals(""))
			{
				String temp = finish_string;
				finish_string = "";
					progress_game(temp);
			}
		}
			
			
			
		if (work)
		{
			progress++;
		}
		else
		{
			if (open)
			{
				pos1 = -65;
				pos2 = 129;
			}
		}
			
			
		
		if (progress >= 1)
		{
			
			float f_prog = progress - 1;
			f_prog /= 120.0;
			
			if (!open)
				f_prog = 1 - f_prog;
			
			f_prog = 64 * (1.0 - cos(f_prog * PI / 2));
			
			pos1 -= f_prog;
			pos2 += f_prog;
		}
		
		
		rect(0,pos1,128,65);
		rect(0,pos2-0.5,128,65);
	}
}