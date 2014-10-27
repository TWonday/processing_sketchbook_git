color Cbackg, BL, YE, GR;

PVector circle = new PVector();
//PVector circle_R = new PVector();
int circle_R;

PVector rel_angle = new PVector();
PVector prev = new PVector();
PVector vec = new PVector();
PVector calc = new PVector();

float alpha;
float col_f;
color paint;
int brush;

PVector col_button = new PVector();
int col_button_R;

PVector clear_button = new PVector();
PVector clear_button_size = new PVector();

int slices = 6;
int edding;

PVector slider_size = new PVector();
PVector slider_pos = new PVector();
int wheel, wheelmin, wheelmax, wheelx;

void setup() {
  size(800,800);
  frameRate(50);
  colorMode(HSB, 360, 100, 100);
  ellipseMode(RADIUS);
  
  Cbackg = color(17, 80,95);
  BL = color( 242,80,95);
  YE = color( 70,80,95);
  GR = color( 123,80,95);
  
  sym_setup();
  
  //setup
}

void draw() {
  
  // draw
}


void mousePressed()
{
  /*if( col_changer( mouseX, mouseY)  ||  clear_screen(mouseX, mouseY)  ||  slider_click(mouseX, mouseY)  )
  {
  }
  else
    sym_pressed();*/
    
  if( is_on_canvas( mouseX, mouseY) )
    sym_pressed();
  else
  {
    col_changer( mouseX, mouseY);
    
    clear_screen(mouseX, mouseY);
    
    slider_click(mouseX, mouseY);
  }
  
  //Eo pressed
}


void mouseDragged()
{
  if( is_on_canvas( mouseX, mouseY) )
    sym_dragged();
  else
  {
    slider_click(mouseX, mouseY);    
  }
  
  rel_angle.set( mouseX -circle.x, mouseY -circle.y);
  prev = rel_angle.get();
  //Eo Dragged
}


void sym_pressed()
{
  rel_angle.set( mouseX -circle.x, mouseY -circle.y);
  prev = rel_angle.get();
  
  strokeWeight(wheel);
  stroke(paint);
  for( int a=0; a< slices; a ++)
  {
    point(circle.x +rel_angle.x, circle.y +rel_angle.y);
    //rel_angle.rotate( 2*PI /slices);
    //prev.rotate( 2*PI /slices);
    rel_angle.set( manual_rotate( rel_angle, 2*PI /slices) );
    prev.set( manual_rotate( prev, 2*PI /slices) );
  }
  
  prev = rel_angle.get();
  
}


void sym_dragged()
{
  
  rel_angle.set( mouseX -circle.x, mouseY -circle.y);
  
  strokeWeight(wheel);
  stroke(paint);
  for( int a=0; a < slices; a++)
  {
    line(circle.x +rel_angle.x, circle.y +rel_angle.y,
          circle.x +prev.x, circle.y +prev.y);
    //prev.rotate( 2*PI /slices);
    //rel_angle.rotate( 2*PI /slices);
    prev.set( manual_rotate( prev, 2*PI /slices) );
    rel_angle.set( manual_rotate( rel_angle, 2*PI /slices) );
  }
  
  prev = rel_angle.get();
}


void sym_setup( )
{
  //slices = 8;
  edding = 6;
  col_f = 0;
  brush = 2;
  
  wheelmin = 2;
  wheelmax = 25;
  
  slider_size.set( 180, wheelmax*2);
  slider_pos.set( 15, height -slider_size.y -15 );
  

  wheel = 4;
  wheelx = (int) ( map( wheel, wheelmin, wheelmax, slider_pos.x, slider_pos.x+slider_size.x )  );
  
  paint = color(0, 85, 50 );
  
  circle.set(width/2, height/2);
  if( height > width)
  {
    circle_R = width/2 *7/8;
    //col_button_R = (int) (( circle_R - width/2 ) /2 );
  }
  else
  {
    circle_R = height/2 *7/8;
    //col_button_R = (int) (( circle_R - height/2 ) /2 );
  }
  col_button_R = 40;
  col_button.set( width -col_button_R -15, height -col_button_R -15);
  
  clear_button_size.set( 70, 30);
  clear_button.set( 15,15);
  
  // Draw background and main circle.
  background(0);
  strokeWeight(edding);
  noFill();
  stroke(YE);
  ellipse( circle.x, circle.y, circle_R, circle_R );
  
  //draw slices
  vec.set( 0, -circle_R);
  stroke( hue(paint), saturation(paint)-30, brightness(paint)-30 );
  //stroke( paint);
  strokeWeight(wheel);
  for( int a=0; a< slices; a ++)
  {
    line( circle.x, circle.y, circle.x +vec.x, circle.y +vec.y );
    //vec.rotate( 2*PI/ slices
    vec.set( manual_rotate( vec, 2*PI/ slices) );
  }
  
  // draw col changer
  fill( paint);
  noStroke();
  ellipse( col_button.x, col_button.y, col_button_R, col_button_R);
  
  // draw clear button
  fill(YE);
  noStroke();
  rect( clear_button.x, clear_button.y, clear_button_size.x, clear_button_size.y );
  // sym setup
  
  // draw slider
  stroke(YE);
  strokeWeight(2);
  fill(0);
  rect(slider_pos.x, slider_pos.y, slider_size.x+wheelmax, slider_size.y );
  fill(YE);
  noStroke();
  ellipse(wheelx, slider_pos.y + slider_size.y/2, wheel, wheel);
}

boolean clear_screen( int x, int y)
{
  
  if( x > clear_button.x  &&  x < clear_button.x+clear_button_size.x 
      &&  y > clear_button.y  &&  y < clear_button.y + clear_button_size.y )
      {
        sym_setup();
        return true;
      }
  return false;
  //
}

boolean col_changer( int x, int y)
{
  if( abs( col_button.x -x) < col_button_R && abs( col_button.y -y) < col_button_R)
  {
    paint = color( random(0, 360)  , saturation( paint),  brightness(paint) );
    fill( paint);
    noStroke();
    ellipse( col_button.x, col_button.y, col_button_R, col_button_R);
    noFill();
    return true;
  }
  return false;
}

boolean slider_click( int x, int y)
{
  if( x > slider_pos.x  &&  x < slider_pos.x+slider_size.x 
      &&  y > slider_pos.y  &&  y < slider_pos.y + slider_size.y ) 
  {
    wheelx = mouseX;
    wheel = (int)( map( wheelx, slider_pos.x,  slider_pos.x+slider_size.x, wheelmin, wheelmax)  );
    
    // redraw slider
    stroke(YE);
    strokeWeight(2);
    fill(0);
    rect(slider_pos.x, slider_pos.y, slider_size.x +wheelmax, slider_size.y );
    fill(YE);
    noStroke();
    ellipse(wheelx, slider_pos.y + slider_size.y/2, wheel, wheel);
    return true;
  }
  else
    return false;
}

boolean is_on_canvas( int x, int y)
{
  int magnitude;
  //vec.set( x - circle.x, y -circle.y);
  //vec.set( x,y);
  //vec.sub(circle);
  magnitude = (x - circle.x)*(x - circle.x) + (y -circle.y) * (y -circle.y);
  //println(magnitude);
  if( magnitude <= circle_R*circle_R )
    return true;
  else
    return false;
}

void change_slices( String num)
{
  slices = int(num);
  sym_setup( );  
}


PVector manual_rotate(PVector vec, float theta) {
  //float temp = x;
  // Might need to check for rounding errors like with angleBetween function?
  //x = x*PApplet.cos(theta) - y*PApplet.sin(theta);
  //y = temp*PApplet.sin(theta) + y*PApplet.cos(theta);
  
  float temp = vec.x;
  vec.set(  vec.x*cos(theta) - vec.y*sin(theta),   
            temp*sin(theta) + vec.y*cos(theta) );
  return vec;
}




