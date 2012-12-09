class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  color colour;
  float particleSize, decay;

  Particle(PVector l, color clr, float prtclSz, float dcy) {
    acceleration = new PVector(random(-0.05, 0.1), random(-0.05, 0.1));
    velocity = new PVector(random(-1, 1), random(-2, 0));
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
