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
//    if(yLoc != 0)
      ellipse(xLoc, yLoc, radius, radius);
//      stroke(255);
//      strokeWeight(1);
//      line(xLoc, 0-height/2, xLoc, 3*yLoc-height*(7.0/15.0));
  }
  
}
