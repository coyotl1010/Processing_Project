
class win {

  PVector pos; // current (x,y) position of agent
  PVector vel; // current velocity of agent
  PVector acc; // current acceleration of agent
  int d = 25;  // diameter of the agent
  int max_x, max_y; // maximum x and y values for the agent (i.e., size of the arena)
  color mycolor; // the color for drawing the agent
  /**
   * agent constructor
   */
  win( int x, int y, int c ) {
    max_x = x;
    max_y = y;
    mycolor = color( c );
    
    ellipseMode( CORNER );
    pos = new PVector( random(max_x-d), random(max_y-d));
    vel = new PVector( 0 , 0 );
    acc = new PVector( 0.5, 0.5 );
    
  } // end of agent constructor

  /**
   * reset()
   * resets the agent's position (to random) and velocity (to 0)
   */
  void reset() {
    pos.set( random( max_x-d ), random( max_y-d ), 0 );
    vel.set( 0, 0, 0 );
  } // end of reset()

  /**
   * getPos()
   * returns the agent's current (x,y) position
   */
    PVector getPos() {
    return( pos );
  } // end of getPos()

  /**
   * getDiameter()
   * returns the diameter of the agent
   */
    int getDiameter() {
    return( d );
  } // end of getDiameter()

  /**
   * draw()
   * this function draws the agent
   */
  void draw() {
    stroke(mycolor);
    fill(mycolor);
    stroke( mycolor );
    strokeWeight( 3 );
    ellipse( pos.x, pos.y, d, d );
    if (( pos.x+vel.x < 0 ) || ( pos.x+vel.x > max_x - d )) vel.x = -(vel.x);
    if (( pos.y+vel.y < 0 ) || ( pos.y+vel.y > max_y - d )) vel.y = -(vel.y);
    pos.x += vel.x;
    pos.y += vel.y;
  } // end of draw()

  /**
   * stop()
   */
    void stop() {
    vel.x = 0;
    vel.y = 0;
  } // end of stop()

}

