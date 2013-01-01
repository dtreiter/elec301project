// A group of Particles
// An ArrayList is used to manage the list of Particles 
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particle>();
  }

  void addParticle(color colour, float particleSize, float decay, int numParticles) {
    for(int i = 0; i < numParticles; i++) {
      particles.add(new Particle(origin, colour, particleSize, decay));
    }
  }

  void run() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.run();
      if (p.isDead()) {
        it.remove(); 
      }
    }
  }
  
}
