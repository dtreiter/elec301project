class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  color colour;
  float particleSize, decay;

  PVector genPVector(float pmin, float pmax) {
    float randNum, sign;
    randNum = random(pmin, pmax);
    sign = random(0, 2);
    if(sign == 0) sign = -1;
    else sign = 1;
    return new PVector(sign*cos(randNum), sign*sin(randNum));
  }

  Particle(PVector l, color clr, float prtclSz, float dcy) {
    acceleration = genPVector(0, TWO_PI);
    velocity = genPVector(0, TWO_PI);
    location = l.get();
    lifespan = 255.0;
    colour = clr;
    particleSize = prtclSz;
    decay = dcy;
  }

  void run() {
    update();
    display();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= decay;
  }

  void display() {
    noStroke();
    fill(colour, lifespan);
    ellipse(location.x, location.y, particleSize, particleSize);
  }
  
  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < decay) return true;
    else return false;
  }
  
}
