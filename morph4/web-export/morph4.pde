// by Thomas Britnell
float saturation, brightness, hue;
int gridx, rad, n, m;
color [][]grid;
float mut_rate;
//float h, s, b;
float r, p;

int val;
float f;

color col, mut;



void setup()
{
  size(800,600);
  frameRate(50);
  colorMode(HSB, 1.0, 1.0, 1.0);
  
  noStroke();
  ellipseMode(RADIUS);
  
  mut_rate = 0.05;
  gridx = 12;
  rad = (int)(gridx * 3/4);
  
  n = (int)(width / gridx);
  m = (int)(height / gridx);
  grid = new color [n][m];
  
  for( int r=0; r<n; r++)
  {
    for( int c=0; c<m; c++)
    {      
      col = random_HSB();
      
      grid[r][c] = col;
      
      fill( col );
      ellipse(r*gridx, c*gridx, gridx, gridx);
    }
  }

  println("n , m, gridx  are  " + n + "," + m  + ","  + gridx ); 
  
}


void draw()
{
  //println("I TRIED");
  //morph_furthest_hue();
  //change_random();
  //mouse_show();
  
  //println("grow");
  grow();
  //println("chose random");
}


color random_HSB()
{
  color sup;
  float h = random(0, 1.0);
  float s = random(0.1,0.7);
  float b = random(0.1,0.7);
  
  sup = color(h, s, b);
  //print( hue(sup) + "." + saturation(sup) + "."+ brightness(sup) );
  return sup;
}


color random_RGB()
{
  color sup;
  float r = random(0,0.6);
  //float s = saturation + random(-0.2, 0.2);
  //float b = brightness + random(-0.2, 0.2);
  float g = random(0,0.6);
  float b = random(0,0.6); 
  sup = color(r, g, b);
  
  //println(r + "," + g + "," + b);
  
  return sup;
}



// ##############################################################
void grow()
{
  println("grow");
  
  color left, right;
  float r;
  int v,w;
  
  int [] out = new int[2];
  
  r = random(1,n-1);
  int x = (int)(r);
  r = random(1,m-1);
  int y = (int)(r);
  
  col = grid[x][y];
  
  //out = neighbour_random(x,y);
  //out = neighbour_find_HSB(x,y);
  out = neighbour_find_RGB(x,y);
  
  println("found using rgb");
  
  v = out[0];
  w = out[1];
  
  println(" v "+ v + ",  w" + w );
  
  println("was col " + red( grid[v][w] ) );
  
  //grid[v][w] = merge_HSB( col ,grid[v][w] );
  grid[v][w] = mutate_RGB( col); 
  
  println("and now is col " + red( grid[v][w] ) );
  //draw selected one
  fill(col);
  ellipse(x*gridx, y*gridx, gridx, gridx);
  
  // draw new, replaced one
  fill(grid[v][w]);
  ellipse( v*gridx, w*gridx, gridx, gridx);
  
  println("here");
  f = hue( col);
  //println("after");
  // Eo grow()
}

// ##############################################################
color merge_HSB( color parent, color child)
{
  float h;
  
  // average hue
  float d = hue(parent) - hue(child);
  if( d> 0.5)
    h = ( hue(parent) + hue(child) + 1.0 ) / 2;    
  else
    h = ( hue(parent) + hue(child) ) /2;
    
  // avergage Sat + Bright
  float s = ( saturation(parent) + saturation(child) ) /2;
  float b = ( brightness(parent) + brightness(child) ) /2;
  
 // println("color out");
  //println( h, s, b );
  
  return color(h,s,b);
}

// ##############################################################
color mutate_HSB( color next)
{
  //println("color in");
  //println( hue(in), saturation(in), brightness(in) );
  
  // mutate 
  float h = hue(next) + random(-mut_rate, mut_rate) ;
  if(h > 1.0)
    h -= 1.0;
  if( h < 0)
    h += 1.0;
  float s = constrain( saturation(next) + random(-mut_rate, mut_rate), 0, 1.0);
  float b = constrain( brightness(next) + random(-mut_rate, mut_rate), 0, 1.0);
  
 // println("color out");
  //println( h, s, b );
  
  return color(h,s,b);
}



// ##############################################################
color mutate_RGB( color next)
{
  //println("color in");
  //println( hue(in), saturation(in), brightness(in) );
  
  // mutate 
  float r = constrain( red(next) + random(-mut_rate, mut_rate), 0, 1 );
  float b = constrain( blue(next) + random(-mut_rate, mut_rate), 0, 1 );
  float g = constrain( green(next) + random(-mut_rate, mut_rate), 0, 1 );
  
 // println("color out");
  //println( h, s, b );
  
  return color(r,g,b);
}




// ##############################################################
int[] neighbour_find_HSB( int x, int y)
{
  col = grid[x][y];
  
  color[] order = new color[4];
  int [] most = new int[2];
  
  float diff = 0;
  float largest = 0;
  int result = 5;
  
  int replx, reply;
  
  //println("chose " + x + "," + y); 
  col = grid[x][y];
  //println("element color is " + hue(col) );
  
  order[0] = grid[x-1][y];
  order[1] = grid[x+1][y];
  order[2] = grid[x][y-1];
  order[3] = grid[x][y+1];
  
  for(int l=0; l< 4; l++)
  {
    diff = hue(order[l]) - hue(col) ;
    
    // Account for wrap around edges of hue spectrum
    if(diff > 0.5)
      diff = 1 - diff;
    if(diff < -0.5)
      diff = 1 + diff;
    
    // find largest
    if( abs(diff) > largest)
    {
      largest = abs(diff);
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
      replx = x;
      reply = y;
      break;
  }
  
  most[0] = replx;
  most[1] = reply;
  return most;
}


// ##############################################################
int[] neighbour_find_RGB( int x, int y)
{
  col = grid[x][y];
  
  color[] order = new color[4];
  int [] most = new int[2];
  
  float diff = 0;
  float largest = 0;
  int result = 5;
  
  int replx, reply;
  
  //println("chose " + x + "," + y); 
  col = grid[x][y];
  //println("element color is " + hue(col) );
  
  order[0] = grid[x-1][y];
  order[1] = grid[x+1][y];
  order[2] = grid[x][y-1];
  order[3] = grid[x][y+1];
  
  for(int l=0; l< 4; l++)
  {
    diff = 0;
    diff += abs( red(order[l]) - red(col) );
    diff += abs( blue(order[l]) - blue(col) );
    diff += abs( green(order[l]) - green(col) );
    
    
    // find largest
    if( abs(diff) > largest)
    {
      largest = abs(diff);
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
      replx = x;
      reply = y;
      break;
  }
  
  most[0] = replx;
  most[1] = reply;
  return most;
}

