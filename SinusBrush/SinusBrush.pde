
color col;
int thickness;

PVector vec = new PVector();

PVector sinus = new PVector();
PVector psinus = new PVector();
PVector direc = new PVector();
PVector pdirec = new PVector();

boolean left;
int point;
float f;

void setup() {
  //orientation(PORTRAIT);
  size(800,550);
  thickness = 30;
  colorMode(RGB);
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
  vec.set(mouseX, mouseY);
  psinus.set( vec );
  left = true;
  point = 1;
}

void mouseDragged()
{
  point++;
  
  if( mouseX==pmouseX && mouseY == pmouseY)
    direc.set(1,1);
  else
    direc.set(mouseX-pmouseX, mouseY-pmouseY );
  
  if( point==2)
  {
    // get prependicular point
    pdirec =  perpendicularRH(direc);
    pdirec.normalize();
    pdirec.mult( direc.mag() );
    psinus.add( pdirec);
    // get direction
    pdirec.set(direc);
  }
  
  if(left)
    {
      left = false;
      // get L 
      /*
      sinus.repl(  direc.perpendicularLH() + );
      sinus.repl( sinus.normalized() );
      //sinus.repl( sinus.rescale(20) );
      sinus.repl( sinus.rescale( direc.m()) );
      sinus.repl( sinus.addt(mouseX, mouseY) );  */
      
      sinus =  perpendicularLH(direc);
      sinus.normalize();
      //sinus.mult(20) );
      sinus.mult( direc.mag() );
      vec.set(mouseX, mouseY);
      sinus.add(vec); 
    }
    else
    {
      left = true;
      // get R
      /*
      sinus.repl(  direc.perpendicularRH()  );
      sinus.repl( sinus.normalized() );
      //sinus.repl( sinus.rescale(20) );
      sinus.repl( sinus.rescale( direc.m()) );
      sinus.repl( sinus.addt(mouseX, mouseY) );  */
      
      sinus =  perpendicularRH(direc);
      sinus.normalize();
      //sinus.mult(20) );
      sinus.mult( direc.mag() );
      vec.set(mouseX, mouseY);
      sinus.add(vec);
      
    }
    
    //curve(cpx1, cpy1, x1, y1, x2, y2, cpx2, cpy2);
    //curve( sinus.X() +pdirec.X(), sinus.Y() +pdirec.Y(),  psinus.X(), psinus.Y(),  
    //        sinus.X(), sinus.Y(),  psinus.X() +direc.X(), psinus.Y() +direc.Y() );
    //bezier(x1, y1, cpx1, cpy1, cpx2, cpy2, x2, y2);
    bezier( psinus.x, psinus.y, psinus.x +pdirec.x, psinus.y +pdirec.y ,
            sinus.x -direc.x , sinus.y -direc.y, sinus.x, sinus.y ); 
    //replace previous
    psinus.set( sinus );
    pdirec.set( direc );
  //
}

void mouseReleased()
{
  //brush.add( PVector(mouseX, mouseY)   );
  
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
