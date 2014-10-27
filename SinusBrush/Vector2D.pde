// by Thomas Britnell

public class Vector2D
{
  int X, Y;
  float MAG, ANGLE;
  
  boolean floating = false;
  float x, y;
  
  public Vector2D()
  {
    X = 0;
    Y = 0;
    x = 0;
    y = 0;
    MAG = 0;
    ANGLE = 0;
    this.floating = false;
  }
  
  public Vector2D(boolean floating)
  {
    X = 0;
    Y = 0;
    x = 0;
    y = 0;
    MAG = 0;
    ANGLE = 0;
    this.floating = floating;
  }
  
  public Vector2D(int x, int y)
   {
     this.floating = false;
     this.X = x;
     this.Y = y; 
     this.MAG = dist(0,0,this.X,this.Y);
     this.x = x;
     this.y = y; 
     calc_angle();
   }
   
   public Vector2D(float x, float y)
   {
     this.floating = true;
     this.x = x;
     this.y = y;  
     this.MAG = dist(0,0,this.x,this.y);
     calc_angle();
   }
   
  
  public void repl(int x, int y)
   {
     if(!floating)
     {
       this.x = x;
       this.y = y;  
       this.X = x;
       this.Y = y;
       this.MAG = dist(0,0,this.X,this.Y);
     }  
     else
     {
       this.x = (float)(x);
       this.y = (float)(y);
       this.X = x;
       this.Y = y;
       this.MAG = dist(0,0,this.x,this.y);
     }
     calc_angle();
   }
   
   public void repl(float x, float y)
   {
       floating = true;
       
       this.X = (int)(x);
       this.Y = (int)(y);
       this.x = x;
       this.y = y;  
       this.MAG = dist(0,0,this.x,this.y);
       calc_angle();
   }
 
  public void repl( Vector2D vec)
   {
     if( !vec.is_floating() )
     {
       this.X = vec.X();
       this.Y = vec.Y();
       this.x = vec.X();
       this.y = vec.Y();
       this.MAG = dist(0,0,this.X,this.Y);
     }  
     else
     {
       this.floating = true;
       this.x = vec.x();
       this.y = vec.y();
       this.X = (int)(vec.x() );
       this.Y = (int)(vec.y() );
       this.MAG = dist(0,0,this.x,this.y);
     }
     calc_angle();
     
   }   
   
   public int X()
   {
     return X;    
   }
   
   public float x()
   {
      return x; 
   }
   
   public int Y()
   {
       return Y;    
   }
   
   public float y()
   {
       return y;    
   }
   
   public float m()
   {
     return MAG;
   }
   
   public float angle()
   {
     return ANGLE;
     
   }
   
   public boolean is_floating()
   {
      return this.floating; 
   }
   
   public void set_x(int val)
   {
    this.X = val;
    this.MAG = dist(0,0,this.X,this.Y);
    calc_angle();
   }
   
   public void set_y(int val)
   {
    this.Y = val;
    this.MAG = dist(0,0,this.X,this.Y); 
    calc_angle();
   }
   
   
   public void set_x(float val)
   {
    this.x = val;
    this.MAG = dist(0,0,this.X,this.Y);
    calc_angle();
   }
   
   public void set_y(float val)
   {
    this.y = val;
    this.MAG = dist(0,0,this.X,this.Y); 
    calc_angle();
   }
  
  
  public Vector2D addt( int x, int y)
  {
     Vector2D result = new Vector2D( this.floating );
     
     if(!this.floating)
       result.repl( this.X + x, this.Y + y );
     else 
       result.repl( this.x + (float)(x), this.y + (float)(y) );
       
     return result;
  }
  
  public Vector2D subt( int x, int y)
  {
    Vector2D result = new Vector2D( floating );
     
     if(!floating)
       result.repl( this.X - x, this.Y - y );
     else 
       result.repl( this.x - (float)(x), this.y - (float)(y) );
        
    return result;  
  }
  
  
  public Vector2D addt( float x, float y)
  {
     Vector2D result = new Vector2D( floating );
     
     if(!floating)
       result.repl( this.X + (int)(x), this.Y + (int)(y) );
     else 
       result.repl( this.x + x, this.y + y );
       
     return result;
  }
  
  public Vector2D subt( float x, float y)
  {
    Vector2D result = new Vector2D( floating) ;
    
    if(!floating)
       result.repl( this.X - (int)(x), this.Y - (int)(y) );
     else 
       result.repl( this.x - x, this.y - y );
       
    return result;  
  }
  
  public Vector2D addt( Vector2D vec)
  {  
     Vector2D result = new Vector2D( floating | vec.is_floating() );
     
     if( floating)
     {
       if(vec.is_floating() )
         result.repl( this.x + vec.x(), this.y + vec.y() );
       else
         result.repl( this.x + vec.X(), this.y + vec.Y() );      
     }
     else
     {
       if(vec.is_floating() )
         result.repl( this.X + vec.x(), this.Y + vec.y() );
       else
         result.repl( this.X + vec.X(), this.Y + vec.Y() );
     }
         
     return result; 
  }
  
  public Vector2D subt( Vector2D vec)
  {
     Vector2D result = new Vector2D( floating | vec.is_floating() );
     
     if( floating)
     {
       if(vec.is_floating() )
         result.repl( this.x - vec.x(), this.y - vec.y() );
       else
         result.repl( this.x - vec.X(), this.y - vec.Y() );    
     }
     else
     {
       if(vec.is_floating() )
         result.repl( this.X - vec.x(), this.Y - vec.y() );
       else
         result.repl( this.X - vec.X(), this.Y - vec.Y() );
     }
         
     return result;   
  }
  
  
  public Vector2D rescale( float factor)
  {
     Vector2D result = new Vector2D(true);
    
     if(!floating)
       result.repl( this.X * factor, this.Y * factor);
     else
       result.repl( this.x * factor, this.y * factor);
  
     return result;
  }
  
   float calc_angle()
   {
     float cos, sin;
     
     if( !floating )
     {
       cos = this.X / this.MAG;
       sin = -this.Y / this.MAG;
     } 
     else  
     {
       cos = this.x / this.MAG;
       sin = -this.y / this.MAG;       
     }
     
     if( sin >= 0)
     {
       if( cos >= 0)
         this.ANGLE = asin(sin);
       else if( cos < 0)
         this.ANGLE = PI - asin(sin);   
     }
     if( sin < 0)
     {
       if( cos >= 0)
         this.ANGLE = 2* PI + asin(sin);
       else if( cos < 0)
         this.ANGLE = PI - asin(sin);        
     }
     return this.ANGLE;
   }
   
   
   public Vector2D as_int()
   {
     Vector2D result = new Vector2D(false);
     
     result.repl( (int)(this.x), (int)(this.y) );
     
     return result;
   }
   
   public Vector2D as_float()
   {
     Vector2D result = new Vector2D(true);
     
     result.repl( (float)(this.X), (float)(this.Y) );
     
     return result;
   }
   
   
   public Vector2D normalized()
   {
     Vector2D returned = new Vector2D(true);
     
     if( !floating)
     {
       returned.set_x( this.X / this.MAG );
       returned.set_y( this.Y / this.MAG );
     }
     else
     {
       returned.set_x( this.x / this.MAG);
       returned.set_y( this.y / this.MAG );       
     }
     return returned;
   }
   
   
   public Vector2D perpendicularRH()
   {
     Vector2D returned = new Vector2D( this.Y, -this.X);
     return returned;
   }
   
   public Vector2D perpendicularLH()
   {
     Vector2D returned = new Vector2D(-this.Y, this.X);
     return returned;
   }
   
  // END
}
