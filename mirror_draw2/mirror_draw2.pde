PGraphics picture;

PVector A = new PVector();
PVector B = new PVector();

PVector C = new PVector();
PVector vec = new PVector();
PVector relative = new PVector();
PVector previous = new PVector();

float m;
int radius;

float x,y;

Lines Mirror;
Lines Temp;

color back, brush;
char dragging;

void setup()
{
  size (600,400);
  picture  = createGraphics(width, height);
   
  colorMode(HSB, 360, 100,100);
  ellipseMode(RADIUS);
  
  radius = 10;
  dragging = 'N';
  
  A.set( width/5, 50);
  B.set( width*4/5, height-50);
  
  Mirror = new Lines(A,B);
  
  picture.beginDraw();
  picture.background(255);
  picture.endDraw();
  
  brush = color(200, 80, 60);
  image(picture, 0,0);
  
  strokeWeight(2);
  stroke(0);
  line( A.x, A.y, B.x, B.y);
  
  strokeWeight(10);
  stroke(0);
  point( A.x, A.y);
  point( B.x, B.y);
  
}


void draw()
{
  image( picture, 0,0);
  
  strokeWeight(2);
  stroke(0);
  line( A.x, A.y, B.x, B.y);
  
  strokeWeight(10);
  stroke(0);
  point( A.x, A.y);
  point( B.x, B.y);
  
  
  //Eo draw
}


void mousePressed()
{
  vec.set( mouseX, mouseY );
  vec.sub( A);
  if( vec.magSq() < 2*radius )
  {
    dragging = 'A';    
  }
  vec.set( mouseX, mouseY );
  vec.sub( B);
  if( vec.magSq() < 2*radius )
  {
    dragging = 'B';
  }
   
  if( dragging == 'N' )
  {
    reflect( mouseX, mouseY);
    picture.beginDraw();
    picture.strokeWeight(2);
    picture.stroke(brush);
    picture.point( C.x + relative.x, C.y +relative.y);
    
    picture.point( mouseX, mouseY);
    picture.endDraw();
    previous.set( relative);
    previous.add( C);
  
  }
  // Eo pressed
}

void mouseDragged()
{
  switch( dragging)
  {
    case 'N':
    reflect( mouseX, mouseY);
    picture.beginDraw();
    picture.strokeWeight(2);
    picture.stroke(brush);
    picture.line( C.x + relative.x, C.y +relative.y,
          previous.x, previous.y);
    picture.line( mouseX, mouseY,
          pmouseX, pmouseY);
    picture.endDraw();
    
    previous.set( relative);
    previous.add( C);
      break;
    case 'A':
      A.set(mouseX, mouseY);
      Mirror = new Lines(A,B);
      
      strokeWeight(2);
      stroke(0);
      line( A.x, A.y, B.x, B.y);
      
      strokeWeight(10);
      stroke(0);
      noFill();
      point( A.x, A.y);
      point( B.x, B.y);
      break;
    case 'B':
      B.set(mouseX, mouseY);
      Mirror = new Lines(A,B);
      
      strokeWeight(2);
      stroke(0);
      line( A.x, A.y, B.x, B.y);
      
      strokeWeight(10);
      stroke(0);
      noFill();
      point( A.x, A.y);
      point( B.x, B.y);
      break;
  }
  
  // Eo pressed
}

void reflect( int x, int y )
{
  Temp = perpendicular_point( Mirror, x, y);
  C.set( intersection( Mirror, Temp) );
  
  //strokeWeight(5);
  //stroke(0);
 // point(C.x, C.y);
  
  vec.set(x, y);
  relative.set(C);
  relative.sub(vec);
}


void mouseReleased()
{
  dragging = 'N';  
}


PVector intersection( Lines A, Lines B)
{
  float x;
  float y;
  PVector result = new PVector();
  
  x = ( B.point.y -A.point.y - B.gradient*B.point.x + A.gradient * A.point.x ) / (A.gradient - B.gradient) ;
  y = A.f_of_x( x );
  
  result.set(x, y);
  
  return result;
  // Eo intersection
}


Lines perpendicular_vec( Lines L, PVector P)
{
  Lines answer = new Lines(P, (-1/ L.gradient) );
  return answer;
}

Lines perpendicular_point( Lines L, float x, float y)
{
  PVector P = new PVector( x,y);
  
  Lines answer = new Lines(P, (-1/ L.gradient) );
  return answer;
}

// ###################################################
class Lines
{
  float gradient = 0;
  PVector point = new PVector(0,0);
  PVector other = new PVector(0,0); 
  
  Lines()
  {
    // nada    
  }
  
  Lines( PVector A, float m )
  {
    point.set(A);
    gradient = m;
  }
  
  Lines( PVector A, PVector B )
  {
    point.set(A);
    other.set(B);
    
    gradient = ( B.y - A.y) / (B.x - A.x );
  }
  
  Lines( float Ax, float Ay, float Bx, float By )
  {
    point.set(Ax, Ay);
    other.set(Bx, By);
    
    gradient = ( By - Ay) / (Bx - Ax );
  }

  
  float f_of_x( float X )
  {
    float answer;
    answer = gradient * ( X - point.x) + point.y;
    return answer;
  }
  
  
  //Eo lines
}
