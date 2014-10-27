
color col;

int thickness;

PVector vec = new PVector(0,0);
PVector calc = new PVector(0,0);
PVector mouse = new PVector(0,0);
PVector point = new PVector(0,0);
PVector left = new PVector(0,0);
PVector right = new PVector(0,0);

boolean drawLeft;
boolean first;
float drain;

float cH = 0;
float cS = 0;
float cB = 0;

int w,h;

void setup() {
  
  size(800,600);
  
  colorMode(HSB, 1.0, 1.0, 1.0);
  
  thickness = 30;
  w = width/2;
  h = height/2;
  
  drain = 0.5;
  
  cH = 0.0;
  cS = 0.74;
  cB = 0.6;
  col = color( cH, cS, cB);
 
  println( "HSB : " + cH + "," + cS + "," + cB );
  
  background(0);
  
  strokeWeight(1);
  stroke(col);
  //noFill();
  noStroke();
  fill(col);
}

void draw() {
  
  
}


void mousePressed()
{
  point.set( mouseX, mouseY );
  drawLeft = true;
  first = true;
}

void mouseDragged()
{
  //background(0,0,0, 1/5);
  
  if( mouseX==pmouseX && mouseY == pmouseY)
    vec.set(1,1);
  else
    vec.set(mouseX-pmouseX, mouseY-pmouseY );
    
    println("beginning col is " +  cH + ",");
    
    cH = cH + 1/500;
    
    if(cH >= 1.0)
      cH = 0.0;
      
    println("color is " +  cH + ",");
    
    stroke(color( cH, cS, cB));
    fill(color( cH, cS, cB));
    
    
  //col = color( cal , saturation(col), brightness(col) );
 // stroke(col);
//  fill(col);
  
  
  if( first)
  {
    first = false;
    
    left.set( perpendicularLH( vec) );
    left.mult(drain);
    //left.div( vec.mag() );
    
    right.set( perpendicularRH( vec) );
    right.mult( drain);
    
    calc.set(pmouseX, pmouseY);
    left.add(calc);
    right.add(calc);
    
    right.add(vec);
    vec.div(2);
    left.add(vec);
    
    //println("Trig points" + point.x  + ", " + point.y  + ", " + left.x  + ", " + left.y  + ", " + right.x  + ", " + right.y ); 
    triangle( point.x, point.y, left.x, left.y, right.x, right.y );
  }
  else 
    if(drawLeft)
    {
      drawLeft = false;
      
      point.set( perpendicularLH( vec ) );
      point.mult(drain);
      
      calc.set(mouseX, mouseY);
      point.add(calc);
      
      //point.normalize();
      //point.mult( vec.mag() );
      
      //println("left is     " + left.x + "," + left.y);
      //println("right is     " + right.x + "," + right.y);
      //println("point is     " + point.x + "," + point.y);
      //println("");
        
      triangle( point.x, point.y, left.x, left.y, right.x, right.y );
      
      left.set(point);
    }
    else
    {
      drawLeft = true;
      
      point.set( perpendicularRH( vec ) );
      point.mult(drain);
      
      calc.set(mouseX, mouseY);
      point.add(calc);
      
      //point.normalize();
      //point.mult( vec.mag() );
      
      triangle( point.x, point.y, left.x, left.y, right.x, right.y );
      
      right.set( point);
    }
  
  //
}

void mouseReleased()
{
  //brush.add( Vector2D(mouseX, mouseY)   );
  
}


public PVector perpendicularLH(PVector first)
{
  PVector returned = new PVector( first.y, -first.x);
  return returned;
}
 
public PVector perpendicularRH(PVector dir)
{
  PVector returned = new PVector(-dir.y, dir.x);
  return returned;
}

