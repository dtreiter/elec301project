Wheel myWheel;
ParticleSystem particles;
color particleColour = color(255, 0, 0);
int numSectors = 20;

void setup() {
  size(900, 900, P2D);
  smooth();
  colorMode(HSB, 360, 100, 100);
  myWheel = new Wheel(numSectors, 45, width/2, height/2);
  particles = new ParticleSystem(new PVector(0, 0));
  frameRate(30);
}

void draw() {
  background(60);
  
  for(int i = 0; i < numSectors; i++) {
    myWheel.setAmplitude(i, random(100,200));
  }
  myWheel.display();
  
  particles.addParticle(particleColour, 8, 1);
  particles.run();

}
