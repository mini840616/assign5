class Bar {
  int barColor =  #FFFFFF;
  float x;
  float y;
  float len;
  float h = 10;
  
  void move() {
    
    x = constrain(mouseX,0+bar.len/2,width-bar.len/2);
  }
  
  void display() {
    fill(barColor);   
    rectMode(CENTER);
    rect(x, y, len, h);
   
  }
  
  Bar(float len) {
    this.y = height-h;
    this.len = len;
  }
}
