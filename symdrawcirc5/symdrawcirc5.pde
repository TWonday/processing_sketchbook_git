PGraphics pizza;

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

int s,b;

int slices = 6;
int edding;


void setup() {
  size(800,700);
  frameRate(50);
  
  pizza = createGraphics(width, height);
  
  pizza.colorMode(HSB, 360, 100, 100);
  colorMode(HSB, 360, 100, 100);
  pizza.ellipseMode(RADIUS);
  
  Cbackg = color(0,0,0);
  BL = color( 242,80,95);
  YE = color( 70,80,95);
  GR = color( 123,80,95);
  
  sym_setup();
  
  //setup
}

void draw() {
  image(pizza, 0,0);
  draw_buttons();
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
  {
    if(!SELECTING)
      sym_pressed();
    else
      select_col(mouseX, mouseY);
      
  }
  else
  {
    col_changer( mouseX, mouseY);
    
    clear_screen(mouseX, mouseY);
    
    slider_click(mouseX, mouseY);
    
    selector_click(mouseX, mouseY);
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
  
  pizza.beginDraw();
  pizza.strokeWeight(wheel);
  pizza.stroke(paint);
  for( int a=0; a< slices; a ++)
  {
    pizza.point(circle.x +rel_angle.x, circle.y +rel_angle.y);
    //rel_angle.rotate( 2*PI /slices);
    //prev.rotate( 2*PI /slices);
    rel_angle.set( manual_rotate( rel_angle, 2*PI /slices) );
    prev.set( manual_rotate( prev, 2*PI /slices) );
  }
  
  prev = rel_angle.get();
  
  pizza.endDraw();
}


void sym_dragged()
{
  
  rel_angle.set( mouseX -circle.x, mouseY -circle.y);
  
  pizza.beginDraw();
  pizza.strokeWeight(wheel);
  pizza.stroke(paint);
  for( int a=0; a < slices; a++)
  {
    pizza.line(circle.x +rel_angle.x, circle.y +rel_angle.y,
          circle.x +prev.x, circle.y +prev.y);
    //prev.rotate( 2*PI /slices);
    //rel_angle.rotate( 2*PI /slices);
    prev.set( manual_rotate( prev, 2*PI /slices) );
    rel_angle.set( manual_rotate( rel_angle, 2*PI /slices) );
  }
  
  prev = rel_angle.get();
  pizza.endDraw();
}


void sym_setup( )
{
  //slices = 8;
  edding = 6;
  col_f = 0;
  brush = 2;
  
  s = 74;
  b = 60;


  paint = color(0, s, b );
  
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
  
  // init buttons
  buttons_setup();
  
  
  draw_all();
  //eo sym setup
}

void draw_all()
{
  
  draw_surface();
  
  // Draw Buttons
  col_button_draw();
  
  clear_button_draw();
  
  slider_draw();
  
  selector_draw();
  
}

void draw_buttons()
{  
  // Draw Buttons
  col_button_draw();
  
  clear_button_draw();
  
  slider_draw();
  
  selector_draw();
  
}


void draw_surface()
{
// Draw background and main circle.
  pizza.beginDraw();
  pizza.background(0);
  pizza.strokeWeight(3);
  pizza.fill(Cbackg);
  pizza.stroke(0,0,90);
  pizza.ellipse( circle.x, circle.y, 2*circle_R, 2*circle_R );
  
  //draw slices
  vec.set( 0, -circle_R);
  pizza.stroke( hue(paint), saturation(paint)-30, brightness(paint)-30 );
  //stroke( paint);
  pizza.strokeWeight(1);
  for( int a=0; a< slices; a ++)
  {
    pizza.line( circle.x, circle.y, circle.x +vec.x, circle.y +vec.y );
    //vec.rotate( 2*PI/ slices
    vec.set( manual_rotate( vec, 2*PI/ slices) );
  }
  pizza.endDraw();
}

boolean is_on_canvas( int x, int y)
{
  int magnitude;
  //vec.set( x - circle.x, y -circle.y);
  //vec.set( x,y);
  //vec.sub(circle);
  magnitude = (int)( (x - circle.x)*(x - circle.x) + (y -circle.y) * (y -circle.y) );
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



// #######   BUTTONS    #########

PVector col_button = new PVector();
int col_button_R;
PVector bright_button = new PVector();
PVector dark_button = new PVector();

PVector white_button = new PVector();
PVector black_button = new PVector();
PVector fill_button = new PVector();
PVector clear_button_size = new PVector();

PVector slider_size = new PVector();
PVector slider_pos = new PVector();
int wheel, wheelmin, wheelmax, wheelx;

PVector selector = new PVector();
PVector selector_size = new PVector();
boolean SELECTING;

int bright, dark;

void buttons_setup()
{
  col_button_R = 40;
  col_button.set( width -col_button_R -15, height -col_button_R -15);
  bright_button.set( col_button.x, col_button.y - col_button_R - 40 );
  dark_button.set( col_button.x -col_button_R -40 , col_button.y );
  
  
  clear_button_size.set( 30, 30);
  white_button.set( 15,15);
  black_button.set(15, white_button.y*2+clear_button_size.y);
  fill_button.set( 15, white_button.y*3+clear_button_size.y*2);
  
  wheelmin = 2;
  wheelmax = 25;
  
  slider_size.set( 180, wheelmax*2);
  slider_pos.set( 15, height -slider_size.y -15 );
  
  wheel = 4;
  wheelx = (int) ( map( wheel, wheelmin, wheelmax, slider_pos.x, slider_pos.x+slider_size.x )  );
  
  selector.set( width-90 , 15);
  selector_size.set( width - selector.x - 15, 100);
  SELECTING = false;
  
  bright = 110;
  dark = 19;
}

void selector_draw()
{
  
  if( !SELECTING)
  {
    stroke(0,0,100);
    fill(0,0,0);
    rect( selector.x, selector.y, selector_size.x, selector_size.y);
    
    textSize(15);
    fill( 0,0,100);
    text("Select color from Image", selector.x, selector.y, selector_size.x, selector_size.y);
  }
  else
  {
    fill(0,0,100);
    noStroke();
    rect( selector.x, selector.y, selector_size.x, selector_size.y);
    
    textSize(15);
    fill( 0,0,0);
    text("Select on your drawing", selector.x, selector.y, selector_size.x, selector_size.y);
  }
  
}

boolean selector_click( int x, int y)
{
  if( abs( selector.x -x) < selector_size.x && abs( selector.y - y) < selector_size.y)
  {
    SELECTING = true;
    selector_draw();
    return true;
  }
  return false;
}


void select_col( int x, int y)
{
 if( is_on_canvas(x,y) )
  {
     paint = get(x,y);
     SELECTING = false; 
     col_button_draw();
     clear_button_draw();
     selector_draw();
  }
}

void col_button_draw()
{
  // draw col changer
  fill( paint);
  stroke(0,0,80);
  strokeWeight(1);
  ellipse( col_button.x, col_button.y, 2*col_button_R, 2*col_button_R);
  
  // white button
  fill( color( hue(paint)  ,  s, bright ) );
  noStroke();
  ellipse(bright_button.x, bright_button.y, 2*col_button_R /2, 2*col_button_R /2 );
  
  // black button
  noStroke();
  fill( color( hue(paint)  ,  s, dark ) );
  ellipse(dark_button.x, dark_button.y, 2*col_button_R /2, 2*col_button_R /2 );
  
  textSize(30);
  fill( 0,0,10 );
  text( "color", col_button.x -col_button_R +4, 
          col_button.y-20, col_button_R*2, col_button_R*2 );
  
}
 
void clear_button_draw()
{ 
  
  // draw white clear button
  fill(0,0,100);
  noStroke();
  rect( white_button.x, white_button.y, clear_button_size.x, clear_button_size.y );

  // draw black clear button
  fill(0,0,0);
  strokeWeight(3);
  stroke(0,0,100);
  rect( black_button.x, black_button.y, clear_button_size.x, clear_button_size.y );
  
  // paint col
  fill(paint);
  stroke(0,0,80);
  strokeWeight(1);
  rect( fill_button.x, fill_button.y, clear_button_size.x, clear_button_size.y );
  
  // label 
  textSize( 17 );
  fill(0,0,100);
  text( "Whipe surface with color", black_button.y, white_button.y, 100,100 );
  
  
}
 
void slider_draw()
{
  
  // draw slider
  stroke(YE);
  strokeWeight(2);
  fill(0);
  rect(slider_pos.x, slider_pos.y, slider_size.x+wheelmax, slider_size.y );
  fill(YE);
  noStroke();
  ellipse(wheelx, slider_pos.y + slider_size.y/2, 2*wheel, 2*wheel);
  
  // label
  textSize(17);
  fill(YE);
  text("Change Brush Size", slider_pos.x, height -slider_size.y -15*2);
  
}

boolean clear_screen( int x, int y)
{
  // WHITE BUTTON
  if( x > white_button.x  &&  x < white_button.x+clear_button_size.x 
      &&  y > white_button.y  &&  y < white_button.y + clear_button_size.y )
      {
        Cbackg = color(0,0,100);
        draw_all();
        return true;
      }
      
  // BLACK BUTTON
  if( x > black_button.x  &&  x < black_button.x+clear_button_size.x 
      &&  y > black_button.y  &&  y < black_button.y + clear_button_size.y )
      {
        Cbackg = color(0,0,0);
        draw_all();
        return true;
      }
      
  // FILL BUTTON
  if( x > fill_button.x  &&  x < fill_button.x+clear_button_size.x 
      &&  y > fill_button.y  &&  y < fill_button.y + clear_button_size.y )
      {
        Cbackg = paint;
        draw_all();
        return true;
      }
      
  return false;
  //
}

boolean col_changer( int x, int y)
{
  // random button
  if( abs( col_button.x -x) < col_button_R && abs( col_button.y -y) < col_button_R)
  {
    paint = color( random(0, 360)  ,  s*random(0.8, 1.2), b*random(0.8, 1.2) );
    
    col_button_draw();
    clear_button_draw();
    return true;
  }
  
  //bright button
  if( abs( bright_button.x -x)  <  col_button_R/2 
      && abs( bright_button.y -y)  <  col_button_R/2 )
  {
    paint = color( hue(paint)  ,  s, bright );
    
    col_button_draw();
    clear_button_draw();
    return true;
  }
  
  //dark button
    if( abs( dark_button.x -x)  <  col_button_R/2 
      && abs( dark_button.y -y)  <  col_button_R/2 )
  {
    paint = color( hue(paint)  ,  s, dark );
    
    col_button_draw();
    clear_button_draw();
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
    ellipse(wheelx, slider_pos.y + slider_size.y/2, 2*wheel, 2*wheel);
    
    return true;
  }
  else
    return false;
}

void keyPressed()
{
  if(key == 's')
  {
  save_pic("tommy", "abc1");  
 
  }
  
}

void save_pic(String user_id, String img_id)
{
  noLoop();
  image(pizza,0,0);
  saveFrame("/gallery/pizzasketch_" + user_id + "_" + img_id);
  
  
}

