
class Agent {

  PVector pos; // current (x,y) position of agent
  PVector vel; // current velocity of agent
  PVector acc; // current acceleration of agent
  int d = 25;  // diameter of the agent
  int max_x, max_y; // maximum x and y values for the agent (i.e., size of the arena)
  color mycolor; // the color for drawing the agent
  PImage sprite;

  /**
   * agent constructor
   */
    Agent( int x, int y, int c ) {
    max_x = x;
    max_y = y;
    mycolor = color( c );

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

    sprite = loadImage("cia.png");
    image(sprite,pos.x,pos.y);
    if (( pos.x+vel.x < 0 ) || ( pos.x+vel.x > max_x - d )) vel.x = -(vel.x);
    if (( pos.y+vel.y < 0 ) || ( pos.y+vel.y > max_y - d )) vel.y = -(vel.y);
    pos.x += vel.x;
    pos.y += vel.y;
  } // end of draw()

  /**
   * move()
   * adjusts the agent's velocity, as if it received a kick in the direction specified
   * by the "direction" argument
   */
  void move( int direction ) {
    switch( direction ) {
    case NORTH:
      pos.y -=20;
      break;
    case SOUTH:
      pos.y +=20;
      break;
    case WEST:
      pos.x -=20;
      break;
    case EAST:
      pos.x +=20;
      break;
    } // end switch
  } // end of kick()

  /**
   * stop()
   */
  void stop() {
    vel.x = 0;
    vel.y = 0;
  } // end of stop()

  void chase( PVector opponent ) {
    // calculate "difference" vector between this agent and the opponent
    PVector diff = pos.sub( opponent,pos );
    // compute the distance between this agent and the opponent (magnitude of difference vector)
    float d = diff.mag();
    if ( d > 0 ) {
      // normalize difference vector
      diff.normalize();  
      // adjust x and y velocity according to the difference vector
      vel = opponent.sub( diff,vel);
    }
  }
}


