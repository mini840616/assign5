class Brick {

  int bColor = #FFFFFF;
  int bSize = 25;
  int bX;
  int bY;
  boolean die = false; 



  Brick(int x, int y) {
    bX = x;
    bY = y;
  }

  void display() {
    fill(bColor);
    rect(bX, bY, bSize, bSize);
  }
}
