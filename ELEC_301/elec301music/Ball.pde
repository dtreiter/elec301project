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
    fill(255);
    ellipse(xLoc, yLoc, radius, radius);
  }
  
}
