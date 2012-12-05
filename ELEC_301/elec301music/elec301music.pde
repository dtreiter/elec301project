Wheel myWheel;
int numSectors = 20;

void setup() {
  size(900, 900, P2D);
  colorMode(HSB, 360, 100, 100);
  myWheel = new Wheel(numSectors, 35, width/2, height/2);
  frameRate(5);
}

void draw() {
  background(60);
  //myWheel.innerRadius = (int)random(25,50);
  for(int i = 0; i < numSectors; i++){
    myWheel.setAmplitude(i, random(100,400));
  }
  
  myWheel.display();
}
