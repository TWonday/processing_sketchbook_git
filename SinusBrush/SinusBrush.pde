
color col;
int thickness;

Vector2D vec = new Vector2D();

Vector2D sinus = new Vector2D();
Vector2D psinus = new Vector2D();
Vector2D direc = new Vector2D();
Vector2D pdirec = new Vector2D();

boolean left;
int point;
float f;

void setup() {
  //orientation(PORTRAIT);
  
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
  psinus.repl( mouseX, mouseY );
  left = true;
  point = 1;
}

void mouseDragged()
{
  point++;
  
  if( mouseX==pmouseX && mouseY == pmouseY)
    direc.repl(1,1);
  else
    direc.repl(mouseX-pmouseX, mouseY-pmouseY );
  
  if( point==2)
  {
    // get prependicular point
    pdirec.repl(  direc.perpendicularRH()  );
    pdirec.repl( pdirec.normalized() );
    pdirec.repl( pdirec.rescale( direc.m() ) );
    psinus.repl( psinus.addt( pdirec) );
    // get direction
    pdirec.repl(direc);
  }
  
  if(left)
    {
      left = false;
      // get L 
      sinus.repl(  direc.perpendicularLH()  );
      sinus.repl( sinus.normalized() );
      //sinus.repl( sinus.rescale(20) );
      sinus.repl( sinus.rescale( direc.m()) );
      sinus.repl( sinus.addt(mouseX, mouseY) );
    }
    else
    {
      left = true;
      // get R
      sinus.repl(  direc.perpendicularRH()  );
      sinus.repl( sinus.normalized() );
      //sinus.repl( sinus.rescale(20) );
      sinus.repl( sinus.rescale( direc.m()) );
      sinus.repl( sinus.addt(mouseX, mouseY) );
    }
    
    //curve(cpx1, cpy1, x1, y1, x2, y2, cpx2, cpy2);
    //curve( sinus.X() +pdirec.X(), sinus.Y() +pdirec.Y(),  psinus.X(), psinus.Y(),  
    //        sinus.X(), sinus.Y(),  psinus.X() +direc.X(), psinus.Y() +direc.Y() );
    //bezier(x1, y1, cpx1, cpy1, cpx2, cpy2, x2, y2);
    bezier( psinus.X(), psinus.Y(), psinus.X()+pdirec.X(), psinus.Y()+pdirec.Y(),
            sinus.X()-direc.X(), sinus.Y()-direc.Y(), sinus.X(), sinus.Y() ); 
    //replace previous
    psinus.repl( sinus );
    pdirec.repl( direc );
  //
}

void mouseReleased()
{
  //brush.add( Vector2D(mouseX, mouseY)   );
  
}


