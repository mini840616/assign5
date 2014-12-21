Bar bar;
Ball ball;
Brick [] bricks;


//Game Status
final int GAME_START   = 0;
final int GAME_PLAYING = 1;
final int GAME_WIN     = 2;
final int GAME_LOSE    = 3;
int status;              //Game Status
int expoInit;            //Explode Init Size

//Variables

int red = #F25672;
int blue = #5680F2;
int yellow = #F2E556;
int purple = #E667FA;
int green = #8DFA6A;
int grey = #BFBBB9;

void setup() {

  status = GAME_START;

  size(640, 480);
  background(0, 0, 0);
  rectMode(CENTER);

  bar = new Bar(60);
  ball = new Ball();
  bricks = new Brick[100];

  reset();
}




void draw() {
  background(50, 50, 50);
  noStroke();


  switch(status) {

  case GAME_START:
    printText(width/2, 240, 60, 20, 50, "PONG GAME", "Press ENTER to Start");
    break;


  case GAME_PLAYING:
    background(50, 50, 50);

    //call function
    drawLife();
    bar.display(); //Draw Bar on the Screen
    bar.move();
    drawBricks();
    drawBall();
    barCatchBall();
    checkBallFall();
    checkBrickHit();
    checkWin();

    break;


  case GAME_WIN:
    printText(width/2, 240, 60, 20, 40, "WOW", "You Win!");
    break;

  case GAME_LOSE:
    printText(width/2, 240, 60, 20, 40, "Uh-Oh!", "Try again!");
    break;
  }
}




void keyPressed() {
  if (status == GAME_PLAYING) {
    cheatKeys();
  }
  statusCtrl();
}



// make bricks
void bricksMaker(int total, int numInRow) {

  int xSpacing = 40; 
  int ySpacing = 40; 
  int ox = (width - numInRow*xSpacing)/2 + xSpacing/2; 
  int oy = 50; 


  for (int i=0; i <total; ++i) {

    int x = ox + (xSpacing*(i % numInRow));
    int y = oy + (ySpacing*int(i / numInRow));

    bricks[i]= new Brick(x, y);
    bricks[i].display();
  }
}



//draw life
void drawLife() {
  fill(230, 74, 96);
  text("LIFE:", 36, 455);
  /*---------Draw Ship Life---------*/
  int ox = 78; 
  int oy = 459;
  int spacing = 25;
  int diameter = 15;

  for (int i=0; i<ball.life; i++) {

    int x = ox + spacing*i;
    int y = oy;

    ellipse(x, y, diameter, diameter);
  }
}





//draw bricks
void drawBricks() {
  for (int i=0; i< bricks.length-1; i++) {
    Brick brick = bricks[i];

    if (brick != null && !brick.die) { // Check Array isn't empty and alien still exist
      brick.display(); //Draw Brick
    }
  }
}


//A-2 Choose Six Bricks to Draw Red and Blue
void brickColorChange() {

  // red bricks to shorten the bar
  for (int i=0; i<3; i++) {
    int redBrick = int(random(0, 50));
    while (bricks[redBrick].bColor != #FFFFFF) {
      redBrick = int(random(0, 50));
    }
    bricks[redBrick].bColor = red;
  }
 
  // blue bricks to make bar longer
  for (int i=0; i<3; i++) {
    int blueBrick = int(random(0, 50));
    while (bricks[blueBrick].bColor != #FFFFFF) {
      blueBrick = int(random(0, 50));
    }
    bricks[blueBrick].bColor = blue;
  }
  
  // Bonus
  // yellow bricks to make ball bigger
  for (int i=0; i<2; i++) {
    int yellowBrick = int(random(0, 50));
    while (bricks[yellowBrick].bColor != #FFFFFF) {
      yellowBrick = int(random(0, 50));
    }
    bricks[yellowBrick].bColor = yellow;
  }
  
  // Bonus
  // purple bricks to make ball smaller
  for (int i=0; i<2; i++) {
    int purpleBrick = int(random(0, 50));
    while (bricks[purpleBrick].bColor != #FFFFFF) {
      purpleBrick = int(random(0, 50));
    }
    bricks[purpleBrick].bColor = purple;
  }
  
  // Bonus
  // green bricks to make ball faster
  for (int i=0; i<2; i++) {
    int greenBrick = int(random(0, 50));
    while (bricks[greenBrick].bColor != #FFFFFF) {
      greenBrick = int(random(0, 50));
    }
    bricks[greenBrick].bColor = green;
  }
  
  // Bonus
  // brown bricks to make ball slower
  for (int i=0; i<2; i++) {
    int greyBrick = int(random(0, 50));
    while (bricks[greyBrick].bColor != #FFFFFF) {
      greyBrick = int(random(0, 50));
    }
    bricks[greyBrick].bColor = grey;
  }
}


//draw ball
void drawBall() {
  if (ball.launch == true) {
    ball.move();
  }
  ball.display();
}




//B-1 Bar catches ball when ball hit bar
void barCatchBall() {
  boolean hit = isHit(ball.x, ball.y, ball.size/2, bar.x, bar.y, bar.len, bar.h);
  if (hit == true) {
    ball.ySpeed *= -1;
  }
}



//B-3 Bar hit bricks, bricks die and ball bounce to the upsit way
void checkBrickHit() {

  for (int j=0; j<bricks.length-1; j++) {
    Brick brick = bricks[j];     
    if (brick != null && !brick.die && ball.launch == true) {
      boolean hit = isHit(ball.x, ball.y, ball.size/2, brick.bX, brick.bY, brick.bSize, brick.bSize);
      if (hit == true) {
        brick.die = true;
        ball.xSpeed *= -1;
        ball.ySpeed *= -1;
        if (brick.bColor == red ) {
          bar.len *= 0.5;
        }
        if (brick.bColor == blue ) {
          bar.len *= 2;
        }
        if (brick.bColor == yellow ) {
          ball.xSpeed *= 2;
          ball.ySpeed *= 2;
        
        }
        if (brick.bColor == purple ) {
          ball.xSpeed *= 0.5;
          ball.ySpeed *= 0.5;
         
        }
        if (brick.bColor == green ) {
          ball.size *= 2;
         
        }
        if (brick.bColor == grey ) {
          ball.size *= 0.5;
         
        }
      }
    }
  }
}
    






    //B-5 GAME FLOW _ Check Win
    void checkWin() {

      boolean aliveBrick = false; 

      for (int i=0; i<bricks.length-1; i++) {
        Brick brick = bricks[i]; 
        if (brick != null && !brick.die) { 
          aliveBrick = true;
          break ;
        }
      }
      //aliveBrick == false
      if (aliveBrick == false && ball.life > 0) {
        status = GAME_WIN;
      }
    }





    //B-2 when ball fall, life--
    void checkBallFall() {
      if (ball.y > bar.y + bar.h/2 ) {

        ball.life -= 1;
        ball.launch = false;
        ball.x = width/2;
        ball.y = 430;
        bar.x = width/2;
        ball.size = 10;
        bar.len = 60;
        

        if (ball.life == 0) {
          status = GAME_LOSE;
          reset();
        }
      }
    }



    //print text when GAME_START, GAME_WIN, GAME_LOSE
    void printText(int x, int y, int size1, int size2, int distance, String line1, String line2) {
      colorMode(RGB);
      fill(95, 194, 226);
      textSize(size1);
      textAlign(CENTER, CENTER);
      text(line1, x, y);

      fill(95, 194, 226);
      textSize(size2);
      text(line2, x, y+distance);
    }




    //Reset Game
    void reset() {
      for (int i=0; i<bricks.length-1; i++) {
        bricks[i] = null;
      }

      expoInit = 0;

      ball.life = 3;

      bar.x = mouseX;
      bar.y = 440;
      bar.len = 60;
      ball.x = bar.x ;
      ball.y = bar.y - bar.h/2 - ball.size/2;
      ball.size = 10;
      ball.launch = false;
      
       
      bricksMaker(50, 10);
      brickColorChange();
    }


    //statusCtrl
    void statusCtrl() {
      if (key == ENTER) {
        switch(status) {

        case GAME_START:
          status = GAME_PLAYING;
          reset();
          break;

        case GAME_PLAYING:
          break;

        case GAME_WIN:
          status = GAME_PLAYING;
          reset();
          break;

        case GAME_LOSE:
          status = GAME_PLAYING;
          reset();
          break;
        }
      }
    }


    boolean isHit(
    float circleX, 
    float circleY, 
    float radius, 
    float rectangleX, 
    float rectangleY, 
    float rectangleWidth, 
    float rectangleHeight)
    {
      float circleDistanceX = abs(circleX - rectangleX);
      float circleDistanceY = abs(circleY - rectangleY);

      if (circleDistanceX > (rectangleWidth/2 + radius)) { 
        return false;
      }
      if (circleDistanceY > (rectangleHeight/2 + radius)) { 
        return false;
      }

      if (circleDistanceX <= (rectangleWidth/2)) { 
        return true;
      }
      if (circleDistanceY <= (rectangleHeight/2)) { 
        return true;
      }

      float cornerDistance_sq = pow(circleDistanceX - rectangleWidth/2, 2) +
        pow(circleDistanceY - rectangleHeight/2, 2);

      return (cornerDistance_sq <= pow(radius, 2));
    }

    //C-3 click Right mousebutton and launch the ball, ball bounce in random way
    void mousePressed() {
      if (mouseButton == RIGHT && ball.launch == false) {
        ball.launch = true;
        float angle = random(0, PI);
        ball.xSpeed = 5*cos(angle);
        ball.ySpeed = -5*sin(angle);
      }
    }

    //ball stop on the middle of the bar
    void mouseMoved() {
      if (ball.launch == false ) {
        ball.x = bar.x;
        ball.y = bar.y -10;
      }
    }

    void cheatKeys() {
      //when test the game, speed fast
      if (key == 'F'||key == 'f') {
        ball.xSpeed *= 1.3;
        ball.ySpeed *= 1.3;
      }
      //when test the game, speed slow
      if (key == 'S'||key == 's') {
        ball.xSpeed *= 0.7;
        ball.ySpeed *= 0.7;
      }
      //when test the game, life++
      if (key == 'L'||key == 'l') {
        ball.life += 1 ;
      }
      //when test the game, ball size increase
      if (key == 'B'||key == 'b') {
        ball.size *= 2 ;
      }
      //when test the game, ball size decrease
      if (key == 'A'||key == 'a') {
        ball.size *= 0.5 ;
      }
    }

