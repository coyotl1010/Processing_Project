
static final int NORTH = 0;
static final int WEST  = 1;
static final int SOUTH = 2;
static final int EAST  = 3;


boolean menu;
boolean howtoplay;
boolean running;

PImage bg;

int score;
int min_x = 0;
int min_y = 0;
int max_x = 600;
int max_y = 375;
int grid_size = 25;
int time;
int wait = 60;

PFont font;

Agent avatar; 
opponent op5;
opponent op4;
opponent op3;
opponent op2;
opponent op1;
win winner;

PVector obstacles = getRandomLoc();

void setup() {
  
  size( 600,375 ); 
  
  avatar = new Agent(550,325,#000000 );
  op5 = new opponent(550, 325, #000000 );
  op4 = new opponent(550, 325, #000000 );
  op3 = new opponent(550, 325, #000000 );
  op2 = new opponent(550, 325, #000000 );
  op1 = new opponent(550, 325, #000000 );
  winner  = new win(550,325,#08FF1A);
 
  bg = loadImage("background.jpg");
  
  menu  = true;
  running = false;
  howtoplay = false;

  
} // end of setup()

void draw(){
   
  if (menu){
    showmenu();
  //  howtoplay = false;
   //r running = false;
  }
    
  if (howtoplay){
    showhowtoplay();
    menu = false;
    running = false;
  }

  if ( running ){
    
      menu = false;
      howtoplay = false; 
      
      time = millis();
      background(bg); 
      avatar.draw();
      op5.draw();
      op4.draw();
      op3.draw();
      op2.draw();
      op1.draw();
      winner.draw();
    
      font = loadFont( "AgencyFB-Reg-20.vlw" ); 
      textFont( font );  
      fill(#E81E1E);
      
      if (wait - time/1000 > 0 ){  //count down time. could not find a way to reset timer after every game
      text( wait - time/1000   + " seconds",150,50);
      }
      else text("Beware",150,50);
 
      
     stroke( #cccccc );
     fill( #cccccc );
     rect( obstacles.x, obstacles.y, grid_size, grid_size );
      }
 

      
      if ( isSpotted()){    // if player gets to close AI begins to chase
        op5.chase(avatar.getPos());
        op4.chase(avatar.getPos());
        op3.chase(avatar.getPos());
        op2.chase(avatar.getPos());
        op1.chase(avatar.getPos());
      }
        else {
          op5.stop();
          op4.stop();
          op3.stop();
          op2.stop();
          op1.stop();
        }

     if ( isCaught() ) {    // gameover if caught
         avatar.stop();
         op5.stop();
         op4.stop();
         op3.stop();
         op2.stop();
         op1.stop();
         font = loadFont( "AgencyFB-Reg-20.vlw" ); 
         textFont( font );  
         fill(#E81E1E);
         textAlign( CENTER );
         text( "GAMEOVER!", 500, 300 );
         text( "Press 'r' to play again ", 500, 350 );
         running = false;      
         menu = false;
       }
     if ( win() )  {    //if you win
        avatar.stop();
        op5.stop();
        op4.stop();
        op3.stop();
        op2.stop();
        op1.stop();
        score = (wait - millis()/1000)*10;
        font = loadFont( "AgencyFB-Reg-20.vlw" ); 
        textFont( font );  
        fill(#E81E1E);
        textAlign( CENTER );
        text( "You've Escaped,"+ "  Score: " + score  , 500, 300 );  
        running = false;
        menu = false;
      }
     if ( wait  - time/1000 <= 0 ){    //AI chse when timer hits zero
         op5.chase(avatar.getPos()); 
         op4.chase(avatar.getPos()); 
         op3.chase(avatar.getPos()); 
         op2.chase(avatar.getPos()); 
         op1.chase(avatar.getPos());
    }
      
 }

  boolean isCaught() {
  float r1 = avatar.getDiameter() / 2;
  PVector avatarCenter = new PVector( avatar.getPos().x+r1, avatar.getPos().y+r1 );
  float r2 = op1.getDiameter() / 2;
  float r3 = op2.getDiameter() / 2;
  float r4 = op3.getDiameter() / 2;
  float r5 = op4.getDiameter() / 2;
  float r6 = op5.getDiameter() / 2;

  PVector op1Center = new PVector( op1.getPos().x+r2, op1.getPos().y+r2 );
  PVector op2Center = new PVector( op2.getPos().x+r3, op2.getPos().y+r3 );
  PVector op3Center = new PVector( op3.getPos().x+r4, op3.getPos().y+r4 );
  PVector op4Center = new PVector( op4.getPos().x+r5, op4.getPos().y+r5 );
  PVector op5Center = new PVector( op5.getPos().x+r6, op5.getPos().y+r6 );

  float d = sqrt( sq(avatarCenter.x - op1Center.x) + sq(avatarCenter.y - op1Center.y ));
  float d1 = sqrt( sq(avatarCenter.x - op2Center.x) + sq(avatarCenter.y - op2Center.y ));
  float d2 = sqrt( sq(avatarCenter.x - op3Center.x) + sq(avatarCenter.y - op3Center.y ));
  float d3 = sqrt( sq(avatarCenter.x - op4Center.x) + sq(avatarCenter.y - op4Center.y ));
  float d4 = sqrt( sq(avatarCenter.x - op5Center.x) + sq(avatarCenter.y - op5Center.y ));
  if ( d < r1 + r2 ||d1 < r1 + r3 || d2 < r1 + r4 || d3 < r1 + r5 || d4 < r1 + r6   ) {
    return( true );
  }
  else {
    return( false );
  }
} 

  boolean win() {    //check to see if player has reached destintion
  float r1 = avatar.getDiameter() / 2;
  PVector avatarCenter = new PVector( avatar.getPos().x+r1, avatar.getPos().y+r1 );
  float r2 = winner.getDiameter() / 2;
  PVector winnerCenter = new PVector( winner.getPos().x+r1, winner.getPos().y+r2 );
  float d = sqrt( sq(avatarCenter.x - winnerCenter.x) + sq(avatarCenter.y - winnerCenter.y ));
  if ( d < r1 + r2 ) {
    return( true );
  }
  else {
    return( false );
  }
  
}
boolean isSpotted(){    // chcks if player is in guards radius
  float d = op1.getPos().dist(avatar.getPos()) ;
  float d1 = op2.getPos().dist(avatar.getPos()) ;
  float d2 = op3.getPos().dist(avatar.getPos()) ;
  float d3 = op4.getPos().dist(avatar.getPos()) ;
  float d4 = op5.getPos().dist(avatar.getPos()) ;
  float distance  = 150;
  if ( d <= distance || d1 <= distance || d2 <= distance || d3 <= distance || d4 <= distance ) {
    return( true );
  }
    else {
    return( false );
    } 
}

PVector getRandomLoc() {
    return( new PVector(
  ((int)random(min_x,max_x)/grid_size)*grid_size,
  ((int)random(min_y,max_y)/grid_size)*grid_size ));
}


boolean showmenu(){
  background(bg); 

  font = loadFont( "AgencyFB-Reg-30.vlw" ); 
  textFont(font); 
  fill(#E81E1E);
  text("Hostage",225,50);
  text("Main Menu", 200,100);
 
  font = loadFont( "AgencyFB-Reg-20.vlw" );
  textFont(font);
  fill(#001C02);
  rect(185,175,50,50);
  rect(345,175,70,50); 
  fill(#E81E1E);
  text("Play",200,200);
  text("how to play",350,200);
 
 if(mousePressed){
  if(mouseX>185 && mouseX <235 && mouseY>175 && mouseY <225){
    running = true;
    return (running);
 }
  
  else if(mouseX>345 && mouseX <415 && mouseY>175 && mouseY <225) {
    
    howtoplay = true;
    return (howtoplay);
  }
 }
 return running;
}

 void showhowtoplay() {
  background(bg);
  text("Welcome to Hostage",100,100);
  text("The objective is simple: escape dro your kidnappers!",100,120);
  text("Guards will chase if if they see you so dont get too close",100,140);
  text("You have 60 seconds before you are discoverd",100,160);
  text("The green circle is the escape point",100,180);
  text("Good luck",100,200);
  text("Press r key to go back",100,300);
  
  if ( keyPressed ) {      // check for "return" request from userr
    if ( key == 'r' || key == 'R' ) {
      showmenu();
      running = false;
      howtoplay = false;
    }
  }
}
/**
 * keyPressed()
 *   the arrow keys act move the avatar in the direction of the arrow.
 * in addition:
 *  s or S to stop the avatar moving (set velocity to 0)
 *  r or R to reset both the avatar and the opponent (move to random positions and set velocities to 0)
 *  q or Q to quit the game
 */
void keyPressed() {
  if ( key == CODED ) {
    switch ( keyCode ) {
    case UP:
      avatar.move( NORTH );
      break;
    case DOWN:
      avatar.move( SOUTH );
      break;
    case LEFT:
      avatar.move( WEST );
      break;
    case RIGHT:
      avatar.move( EAST );
      break;
    }
  }
  else if (( key == 's' ) || ( key == 'S' )) {
    avatar.stop();
  }
  else if (( key == 'r' ) || ( key == 'R' )) {
    avatar.reset();
    op1.reset();
    op2.reset();
    op3.reset();
    op4.reset();
    op5.reset();
    winner.reset();
    menu = true;

  }
  else if (( key == 'q' ) || ( key == 'Q' )) {
    exit();
    
  }
} 