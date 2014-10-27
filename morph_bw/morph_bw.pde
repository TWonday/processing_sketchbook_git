
int div, rad, n,m;
int grid[][];
int v, w, x, y; 

float r, p;
int col, val;
int speed;

void setup()
{
  size(800,600);
  frameRate(100);
  
  ellipseMode(RADIUS);
  noStroke();
  
  speed = 10;
  
  div = 12;
  rad = (int)(div*3/4);
  
  n = (int)(width / div);
  m = (int)(height / div);
  grid = new int [n][m];
  
  background(0);
  /* draw background white circles to see better
  background(255);
  for( int r=0; r<n; r++)
  {
    for( int c=0; c<m; c++)
    {   
      fill(255);
      ellipse(r*div, c*div, rad, rad);
    }
  }*/
  
}
void draw()
{
  p = random(0,1);
  if( p < 0.05)
  {
    r = random(25,125);
    col = (int)( r );
    
    r = random(0,n-1);
    x = (int)(r);
    r = random(0,m-1);
    y = (int)(r);
    
    grid[x][y] += col;
    grid[x][y] = constrain(grid[x][y], 0,255);
      
    
    fill(col);
    ellipse(x*div, y*div, rad, rad);
  }
  else
  {
    r = random(1,n-1);
    int x = (int)(r);
    r = random(1,m-1);
    int y = (int)(r);
    
    /* add average of neighbouring col to selected
    val = 0;
    val += grid[x-1][y];
    val += grid[x+1][y];
    val += grid[x][y-1];
    val += grid[x][y+1];
    val /= 4;
    */
    
    // add 1/10 ; 1/speed of selected to one neighbour
    r = random(0,1);
    if( r < 0.25)
    {
      v = x;
      w = y+1;
    } else 
    if(r < 0.5)
    {
      v = x-1;
      w = y;
    } else 
    if(r < 0.75)
    {
      v = x+1;
      w = y;
    } 
    else
    {
      v = x;
      w = y-1;
    }
    grid[v][w] += (int)( grid[x][y]/ speed);
    grid[v][w] = constrain(grid[v][w], 0,255);
    
    fill(grid[v][w] );
    ellipse( v*div, w*div, rad, rad);
    
    //fill(grid[x][y]);
    //ellipse( x*div, y*div, rad, rad);
  }
  
  
}
