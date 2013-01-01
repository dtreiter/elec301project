class Trail {
  float xLoc, yTop, yBottom, decay, speed, lifespan, trailLength;
  int thickness;
  color colour;
  
  Trail(float xl, float yt, float yb) {
    xLoc = xl;
    yTop = yt;
    yBottom = yb;
    decay = 3; // round(10*pow(2.71, -trailLength/100) );
    speed = 10;
    lifespan = 255;
    thickness = 8;
    colour = color(255);
  }
  
  void run() {
    update();
    display();
  }
  
  void update() {
    yTop += speed;
    yBottom += speed;
    lifespan -= decay;
  }
  
  void display() {
    stroke(colour, lifespan);
    strokeWeight(thickness);
    line(xLoc-width/4, yTop-height/2, xLoc-width/4, yBottom-height/2);
  }
 
  boolean isDead() {
    if (lifespan < decay) return true;
    else return false;
  }
  
}
