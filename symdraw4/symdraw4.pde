color Cbackg, c1, c2, c3;

PVector canvas = new PVector();
PVector canvas_size = new PVector();

PVector frame = new PVector();
PVector frame_size = new PVector();
PVector separation = new PVector();

PVector relative = new PVector();
PVector previous = new PVector();
PVector A = new PVector();
PVector B = new PVector();

float x,y;
int n,m;

int scale;

void setup() {
  size(800,600);
  frameRate(50);
  colorMode(HSB, 360,100,100);
    
  Cbackg = color(17, 80,95);
  c1 = color( 242,80,95);
  c2 = color( 70,80,95);
  c3 = color( 123,80,95);
  
  sym_setup();
  
  //setup
}

void draw() {
  
}


void mousePressed()
{
  sym_dot();
  
  if( is_on_canvas(mouseX, mouseY) )
    sym_pressed();
    else
    {
      relative.set( mouseX - canvas.x, mouseY - canvas.y);
      relative.div(scale);
      previous.set( relative);
    }
    
  //
}

void mouseDragged()
{
  sym_dot();
  
  if( is_on_canvas(mouseX, mouseY) )
    sym_dragged();
  else
  {
    relative.set( mouseX - canvas.x, mouseY - canvas.y);
    relative.div(scale);
    previous.set( relative);
  }
  //Eo Dragged
}


void sym_setup()
{
  scale = 5;
  
  canvas.set( 20, 20 );
  if( width/2 > height)
    canvas_size.set( height*6/8, height *6/8 );
  else
    canvas_size.set( width/2*6/8, width/2 *6/8 );
 
  frame_size.set( width/2 , height );
  separation.set( (int)(canvas_size.x/(scale) ) ,  (int)( canvas_size.y/(scale) ) );
  frame.set( width/2 + separation.x, separation.y);
  
  // Draw background and canvas-rectangle
  background(0);
  
  strokeWeight(scale);
  noFill();
  stroke(c2);
  rect(canvas.x, canvas.y, canvas_size.x, canvas_size.y );
  
  strokeWeight(2*scale);
  stroke(c3);
  point( canvas.x, canvas.y );
  
  for( int p = 0; p< frame_size.x; p+= 2*separation.x)
  {
    for(int q=0; q<frame_size.y; q+= 2*separation.y)
    {
      strokeWeight(1);
      stroke(c3);
      point( frame.x + p, frame.y +q ); 
    }
  }
  // sym setup
}


void sym_dot()
{
  strokeWeight(scale);
  stroke(c1);
  point(mouseX, mouseY );
  
  // Eo sym_dot
}


void sym_pressed()
{
  relative.set( mouseX - canvas.x, mouseY - canvas.y);
  
  relative.div(scale);
  //relative.set( relative.x *scale /frame_size.x, relative.y *scale /frame_size.y );
  strokeWeight(1);
  stroke(c1);
      
  for( int p = 0; p< frame_size.x; p+= 2*separation.x)
  {
    for(int q=0; q<frame_size.y; q+= 2*separation.y)
    {
      
      point( frame.x + p +relative.x, frame.y +q +relative.y);
      point( frame.x + p +relative.x, frame.y +q -relative.y);
      point( frame.x + p -relative.x, frame.y +q +relative.y);
      point( frame.x + p -relative.x, frame.y +q -relative.y);
      
    }//For
    
   
  }// For
  
  
  previous.set( relative);
  // sym_pressed
}


void sym_dragged()
{
  relative.set( mouseX - canvas.x, mouseY - canvas.y);
  
  strokeWeight(scale);
  stroke(c1);
  point( canvas.x + relative.x, canvas.y + relative.y );
  
  relative.div(scale);
  //relative.set( relative.x *scale /frame_size.x, relative.y *scale /frame_size.y );
  strokeWeight(1);
  stroke(c1);
      
  for( int p = 0; p< frame_size.x; p+= 2*separation.x)
  {
    for(int q=0; q<frame_size.y; q+= 2*separation.y)
    {
      
      line( frame.x + p +relative.x, frame.y +q +relative.y,
              frame.x + p +previous.x, frame.y +q +previous.y);
      line( frame.x + p +relative.x, frame.y +q -relative.y,
              frame.x + p +previous.x, frame.y +q -previous.y);
      line( frame.x + p -relative.x, frame.y +q +relative.y,
              frame.x + p -previous.x, frame.y +q +previous.y);
      line( frame.x + p -relative.x, frame.y +q -relative.y,
              frame.x + p -previous.x, frame.y +q -previous.y);
      
    }//For
    
   
  }// For
  
  
  previous.set( relative);
  
  //Eo sym_dragged
}

boolean is_on_canvas( int x, int y)
{
  boolean answer = false;
  if ( x > canvas.x && x < canvas.x + canvas_size.x &&
        y > canvas.y && y < canvas.y + canvas_size.y )
        answer = true;

  return answer;
  
  
}

void mouseReleased()
{
  
}

void keyPressed() {
  
}

void keyTyped() {

}

void keyReleased() {
  
}


