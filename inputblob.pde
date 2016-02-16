class inputblob
{
	int z_state;
	int x_state;
	int c_state;
	
	boolean z_down;
	boolean x_down;
	boolean c_down;
	
	boolean a_down;
	
	// JS is not detecting our key down event state the same way that processing does so we need to edge detect manually.
	int z_edge;
	int x_edge;
	int c_edge;
	int a_edge;
	
	boolean k1_down;
	boolean k2_down;
	boolean k3_down;
	boolean k4_down;

	boolean minus_state;
	boolean plus_state;
	boolean h_state;
	
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
			if (c == 'z' || c == 'Z')
			{
				z_state = down;
				if (z_edge == 0 && down == 1)
				{
					z_down = true;
					z_edge = 1;
				}
				else if (z_edge == 1 && down == 1)
				{
					z_down = false; 
				}
				else
				{
					z_edge = 0;
				}
				//println(z_down);
			}
			if (c == 'x' || c == 'X')
			{
				x_state = down;
				if (x_edge == 0 && down == 1)
				{
					x_down = true;
					x_edge = 1;
				}
				else if (x_edge == 1 && down == 1)
				{
					x_down = false; 
				}
				else
				{
					x_edge = 0;
				}
			}
			if (c == 'c' || c == 'C')
			{
				c_state = down;
				if (c_edge == 0 && down == 1)
				{
					c_down = true;
					c_edge = 1;
				}
				else if (c_edge == 1 && down == 1)
				{
					c_down = false; 
				}
				else
				{
					c_edge = 0;
				}
			}
			if (c == 'a' || c == 'A')
			{
				// no held state for a
				if (a_edge == 0 && down == 1)
				{
					a_down = true;
					a_edge = 1;
				}
				else if (a_edge == 1 && down == 1)
				{
					a_down = false; 
				}
				else
				{
					a_edge = 0;
				}
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



			if (c == '-' || c == '_')
			{
				minus_state = (down == 1);
			}
			if (c == '=' || c == '+')
			{
				plus_state = (down == 1);
			}

			if (c == 'h' || c == 'H')
			{
				h_state = (down == 1);
			}
		}
		
		x_axis = -1 * left_state + 1 * right_state;
		y_axis = -1 * up_state + 1 * down_state;
		
		//print(x_axis + " " + y_axis + "\n");

	}
}