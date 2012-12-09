class Ball {
  float xLoc, yLoc, radius;
  
  Ball(float xl, float yl, float rad) {
    xLoc = xl;
    yLoc = yl;
    radius = rad;
  }
  
  void update(float newX, float newY) {
    xLoc = newX;
    yLoc = newY;
  }
  
  void display() {
    noStroke();
    fill(255);
    //if(yLoc != 0)
      ellipse(xLoc, yLoc, radius, radius);
  }
  
}
