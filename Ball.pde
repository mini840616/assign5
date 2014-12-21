class Ball {
  int ballColor = #FFFFFF;
  float x;
  float y;
  float xSpeed;
  float ySpeed;
  float size;
  int life;
  boolean launch;

  void move() {
    x+=xSpeed;
    y+=ySpeed;
    if (x<0 || x>width) {
      xSpeed *= -1;
    }
    if (y<0 || y>height) {
      ySpeed *= -1;
    }
  }



  void display() {
    fill(ballColor);
    ellipse(x, y, size, size);
  }



  Ball() {
    x = random(width);
    y = random(height);
    xSpeed = 5;
    ySpeed = 3;
    size = 10;
  }

  Ball(float size, float xSpeed) {
    x = random(width);
    y = random(height);
    this.xSpeed = xSpeed;
    this.ySpeed = size;
    this.size = size;
  }
}
