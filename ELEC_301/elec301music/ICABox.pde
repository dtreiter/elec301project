class ICABox {
  float xcenter,wide,bright;
  
  ICABox(int xc, int wi, float br) {
    xcenter = xc;
    wide = wi;
    bright = br;
  }
  
  void update(int newB) {
    bright = newB;
  }
  
  void display() {
    noStroke();
    fill(0,0,bright);
    rect((int)xcenter,0,(int)wide,(int)height);
  }
  
}
