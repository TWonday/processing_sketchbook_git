PGraphics painter;

PImage canvas;
color back, brush;

void setup()
{
  size(800,600);
  canvas = createImage( width, height, HSB);
  painter = createGraphics(width, height);
  colorMode(HSB, 360, 100, 100);
  ellipseMode( RADIUS);
  back = color( 100, 10, 90);
  brush = color(200, 80, 60);
  
  painter.beginDraw();
  painter.background(0);
  painter.endDraw();
  
  canvas.loadPixels();
  for( int i=0; i<canvas.pixels.length; i++)
    canvas.pixels[i] = back;
  
  canvas.updatePixels();
}


void draw()
{
  image(painter, 0,0);
  ellipse(mouseX, mouseY, 40, 40);
  
}



void mousePressed()
{
  /*
  canvas.loadPixels();
  canvas.set(mouseX, mouseY, brush);
  canvas.updatePixels();
*/  
}

void mouseDragged()
{
  painter.beginDraw();
  painter.stroke(brush);
  painter.line( mouseX, mouseY, pmouseX, pmouseY );
  painter.endDraw();
  
  
}

