
color col;
int thickness;

PVector vec = new PVector(0,0);
PVector calc = new PVector(0,0);

PVector point = new PVector(0,0);
PVector left = new PVector(0,0);
PVector right = new PVector(0,0);

boolean drawLeft;
boolean first;
float f;

void setup() {
  //orientation(PORTRAIT);
  size(800,600);
  
  colorMode(RGB);
  
  thickness = 30;
  col = color(17, 160,170);
  
  background(0);
  
  strokeWeight(3);
  stroke(col);
  noFill();
}

void draw() {
  //
  
}


void mousePressed()
{
  point.set( mouseX, mouseY );
  drawLeft = true;
  first = true;
}

void mouseDragged()
{
  if( mouseX==pmouseX && mouseY == pmouseY)
    vec.set(1,1);
  else
    vec.set(mouseX-pmouseX, mouseY-pmouseY );
  
  if( first)
  {
    first = false;
    
    left = perpendicularLH( vec);
    left.normalize();
    left.mult( vec.mag() );
    calc.set(mouseX, mouseY);
    left.add(calc);
    
    //left.set(  vec.perpendicularLH()  );
    //left.set( left.normalized() );
    //left.set( left.rescale( vec.m()) );
    //left.set( left.addt(mouseX, mouseY) );
    
    right = perpendicularRH( vec);
    right.normalize();
    right.mult( vec.mag() );
    calc.set(mouseX, mouseY);
    right.add(calc);
    
    //right.set(  vec.perpendicularRH() );
    //right.set( right.normalized() );
    //right.set( right.rescale( vec.m()) );
    //right.set( right.addt(mouseX, mouseY) );
    
    println("Trig points" + point.x  + ", " + point.y  + ", " + left.x  + ", " + left.y  + ", " + right.x  + ", " + right.y ); 
    triangle( point.x, point.y, left.x, left.y, right.x, right.y );
  }
  else
    if(drawLeft)
    {
      drawLeft = false;
      
      point = perpendicularLH( vec );
      point.normalize();
      point.mult( vec.mag() );
      
      //point.set(  vec.perpendicularLH()  );
      //point.set( point.normalized() );
      //point.set( point.rescale( vec.m()) );
      
      triangle( mouseX +point.x, mouseY +point.y, left.x, left.y, right.x, right.y );
      calc.set(mouseX, mouseY);
      left = PVector.add(point, calc);
    }
    else
    {
      drawLeft = true;
      
      point = perpendicularRH( vec );
      point.normalize();
      point.mult( vec.mag() );
      
      //point.repl(  vec.perpendicularRH() );
      //point.repl( point.normalized() );
      //point.repl( point.rescale( vec.m()) );
      
      triangle( mouseX +point.x, mouseY +point.y, left.x, left.y, right.x, right.y );
      calc.set(mouseX, mouseY);
      right = PVector.add(point, calc);
      //right.repl( point.addt(mouseX, mouseY) );
    }
  
  //
}

void mouseReleased()
{
  //brush.add( Vector2D(mouseX, mouseY)   );
  
}


public PVector perpendicularRH(PVector first)
{
  PVector returned = new PVector( first.y, -first.x);
  return returned;
}
 
public PVector perpendicularLH(PVector dir)
{
  PVector returned = new PVector(-dir.y, dir.x);
  return returned;
}


