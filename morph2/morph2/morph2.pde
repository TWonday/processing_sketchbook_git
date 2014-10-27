// by Thomas Britnell
float saturation, brightness, hue;
int gridx, n, m;
color [][]grid;
float h, s, b;

color col;


void setup()
{
  size(800,600);
  frameRate(50);
  colorMode(HSB, 1.0, 1.0, 1.0);
  gridx = 8;
  n = (int)(width / gridx);
  m = (int)(height / gridx);
  grid = new color [n][m];
  
  saturation = 0.68;
  brightness = 0.43;
  
  random_grid();
  
  // Redraw Grid
  for( int r=0; r<n; r++)
  {
    for( int c=0; c<m; c++)
    {      
      
      col = grid[r][c];
      
      noStroke();
      fill( col );
      
      ellipseMode(RADIUS);
      ellipse(r*gridx, c*gridx, gridx, gridx);
      
      //rect(r*gridx, c*gridx, gridx, gridx );
      //println(hue + "," + saturation + "," + brightness);
    }
  }
  println("n , m, gridx  are  " + n + "," + m  + ","  + gridx ); 
}

color random_HSB()
{
  color sup;
  float h = random(0,1.0);
  //float s = saturation + random(-0.2, 0.2);
  //float b = brightness + random(-0.2, 0.2);
  float s = random(0,1.0);
  float b = random(0,1.0);
  
  sup = color(h, s, b);
  //print(sup.hue(su) + sup.saturation() + sup.brightness() );
  return sup;
  //println(h + "," + s + "," + b);
  
}

void random_grid()
{
  for( int r=0; r<n; r++)
  {
    for( int c=0; c<m; c++)
    {      
      col = random_HSB();
      grid[r][c] = col;
      
      //grid[r][c][1] = saturation(col);
      //grid[r][c][2] = brightness(col);
      //col = random_RGB();
     
      //noStroke();
      //fill( col );
      
      //rect(r*gridx, c*gridx, gridx, gridx );
      //println(hue + "," + saturation + "," + brightness);
    }
  }
}

void draw()
{
  //println("I TRIED");
  morph_furthest_hue();
  //change_random();
}

void change_random()
{
  float r;
  r = random(1,n-1);
  int x = (int)(r);
  r = random(1,m-1);
  int y = (int)(r);
  
  col = random_HSB();
  grid[x][y] = col;
  
  noStroke();
  fill( col );
  ellipseMode(RADIUS);
  ellipse(x*gridx, y*gridx, gridx, gridx);
}

void morph_furthest_hue()
{
  float r;
  r = random(1,n-1);
  int x = (int)(r);
  r = random(1,m-1);
  int y = (int)(r);
  //println("chose " + x + "," + y); 
  
  color[] order = new color[4];
  float difference = 0;
  float largest = 0;
  int result = 5;
  
  float wrap;
  
  int replx, reply;
  boolean smaller;
  
  col = grid[x][y];
  order[0] = grid[x-1][y];
  order[1] = grid[x+1][y];
  order[2] = grid[x][y-1];
  order[3] = grid[x][y+1];
  
  for(int l=0; l< 4; l++)
  {
    difference = hue(order[l]) - hue(col) ;
    
    // Account for wrap around edges of hue spectrum
    if(difference > 0.5)
      difference = 0.5 - difference;
    if(difference < -0.5)
      difference = difference - 0.5;
    
    // find largest
    if( abs(difference) > largest)
    {
      largest = abs(difference);
      result = l;
    }
    //end for
  }
  
  //identify neighbour
  switch(result)
  {
    case 0:
      replx = x-1;
      reply = y;
      break;
    case 1:
      replx = x+1;
      reply = y;
      break;
    case 2:
      replx = x;
      reply = y-1;
      break;
    case 3:
      replx = x;
      reply = y+1;
      break;
    default:
      r = random(0,1.0);
      if(r>0.5)
      {
        replx = x - 1;
        reply = y;
      }
      else
      {
        replx = x + 1;
        reply = y;
      }
      break;
  }
  //println("replaced result" + result );
  
  // mutate 
  h = hue(grid[x][y]) + random(-0.05,0.05) ;
  if(h > 1.0)
    h -= 1.0;
  s = constrain( saturation(grid[x][y]) + random(-0.05,0.05), 0, 1.0);
  b = constrain( brightness(grid[x][y]) + random(-0.05, 0.05), 0, 1.0);
  col = color(h,s,b);
  
  grid[replx][reply] = col;
  
  // Draw New Element
  noStroke();
  fill( col );
  ellipseMode(RADIUS);
  ellipse(replx*gridx, reply*gridx, gridx, gridx);
      
  println("HSB original "+hue(grid[x][y])+","+saturation(grid[x][y]) 
  + ","+ brightness(grid[x][y]) ); 
  println("morphed into "+ hue(col) +","+ saturation(col)
  +","+ brightness(col) );
  // End of 
}


void morph_furthest_hubby(int G, int H)
{
  float r;
  int x = G;
  int y = H;
  println("chose " + x + "," + y); 
  
  color[] order = new color[4];
  float difference = 0;
  float largest = 0;
  int result = 5;
  
  float wrap;
  
  int replx, reply;
  boolean smaller;
  
  col = grid[x][y];
  order[0] = grid[x-1][y];
  order[1] = grid[x+1][y];
  order[2] = grid[x][y-1];
  order[3] = grid[x][y+1];
  
  for(int l=0; l< 4; l++)
  {
    difference = hue(order[l]) - hue(col) ;
    
    // Account for wrap around edges of hue spectrum
    if(difference > 0.5)
      difference = 0.5 - difference;
    if(difference < -0.5)
      difference = difference - 0.5;
    
    // find largest
    if( abs(difference) > largest)
    {
      largest = abs(difference);
      result = l;
    }
    //end for
  }
  
  //identify neighbour
  switch(result)
  {
    case 0:
      replx = x-1;
      reply = y;
      break;
    case 1:
      replx = x+1;
      reply = y;
      break;
    case 2:
      replx = x;
      reply = y-1;
      break;
    case 3:
      replx = x;
      reply = y+1;
      break;
    default:
      r = random(0,1.0);
      if(r>0.5)
      {
        replx = x - 1;
        reply = y;
      }
      else
      {
        replx = x + 1;
        reply = y;
      }
      break;
  }
  println("replaced result" + result );
  
  // mutate 
  h = hue(grid[x][y]) + random(-0.05,0.05) ;
  if(h > 1.0)
    h -= 1.0;
  s = constrain( saturation(grid[x][y]) + random(-0.05,0.05), 0, 1.0);
  b = constrain( brightness(grid[x][y]) + random(-0.05, 0.05), 0, 1.0);
  col = color(h,s,b);
  
  grid[replx][reply] = col;
  
  // Draw New Element
  noStroke();
  fill( col );
  ellipseMode(RADIUS);
  ellipse(replx*gridx, reply*gridx, gridx, gridx);
      
  println("HSB original "+hue(grid[x][y])+","+saturation(grid[x][y]) 
  + ","+ brightness(grid[x][y]) ); 
  println("morphed into "+ hue(col) +","+ saturation(col)
  +","+ brightness(col) );
  // End of 
}
