lineWheel myWheel;
ParticleSystem particles;
color particleColour = color(255, 0, 0);
int numSectors = 180;

void setup() {
  size(600, 600, P2D);
  smooth(4);
  colorMode(HSB, 360, 100, 100);
  myWheel = new lineWheel(numSectors, 45, width/2, height/2);
  particles = new ParticleSystem(new PVector(0, 0));
  frameRate(24);
}

void draw() {
  translate(width/2,height/2);
  background(60);
  for (int i = 0; i < numSectors; i++) {
    myWheel.setAmplitude(i, random(100, 200));
  }
  myWheel.display();

  particles.addParticle(particleColour, 8, 1);
  particles.run();
}

