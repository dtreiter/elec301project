// A simple Particle class
class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  color colour;
  float particleSize, decay;

  Particle(PVector l, color clr, float prtclSz, float dcy) {
    acceleration = new PVector(random(-0.05, 0.05), random(-0.05, 0.1));
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

  // Method to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= decay;
  }

  // Method to display
  void display() {
    //stroke(colour, lifespan);
    noStroke();
    fill(colour, lifespan);
    ellipse(location.x, location.y, particleSize, particleSize);
  }
  
  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 1.0) return true;
    else return false;
  }
  
}
