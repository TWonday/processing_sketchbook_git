
PVector base = new PVector();
PVector A = new PVector();
PVector B = new PVector();
PVector C = new PVector();

float m;

float x,y;

Lines Line;
Lines temp;
Lines Perpend;

void setup()
{
  size (600,400);
  
  base.set( 50,50);
  m = 0.5;
  Line = new Lines(A,m);
}


void draw()
{
  background(255);
  
  strokeWeight(10);
  stroke(0);
  point(base.x, base.y);
  
  strokeWeight(2);
  stroke(0);
  line( 0, Line.f_of_x(0),   width, Line.f_of_x(width) );
  
  x = mouseX;
  y = Line.f_of_x(x);
  
  strokeWeight(10);
  stroke(0);
  point(x,y);
  
  Perpend = perpendicular_point( Line, mouseX, mouseY);
  strokeWeight(2);
  stroke(0);
  line( 0, Perpend.f_of_x(0),   width, Perpend.f_of_x(width) );
  
  C.set( intersection( Perpend, Line) );
  strokeWeight(10);
  stroke(0);
  point(C.x, C.y);
  //Eo draw
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
