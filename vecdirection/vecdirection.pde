
PVector pos, dir, vec;

int Radius = 100;
int R = 35;
int rad = 60;

void setup()
{
  size(800,600);
  frameRate(50);
  
  pos = new PVector( width/3,height/3);
  dir = new PVector(0,0);
  vec = new PVector(0,0);
  
  stroke(240);
  ellipseMode(RADIUS);
}

void draw()
{
  background(0);
  dir.set(mouseX, mouseY);
  dir.sub(pos);
  
  stroke(120);
  line( pos.x, pos.y, dir.x + pos.x, dir.y+pos.y); 
  //line(pos.x, pos.y, mouseX, mouseY);
  
  dir.limit(R);
  noStroke();
  fill(240);
  ellipse( pos.x, pos.y, Radius, Radius);
  fill(5);
  ellipse( pos.x+ dir.x, pos.y+dir.y, rad,rad);
  
  
}
