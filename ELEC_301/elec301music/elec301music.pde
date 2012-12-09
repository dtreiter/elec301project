import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim minim;
AudioPlayer player;

lineWheel myWheel;
ParticleSystem particles;
color particleColour = color(255, 120, 0);
int numSectors;

Ball[] myBall = new Ball[8];
int ballHeightCnt = 0; // prevents out of bounds exception

float[][] songAmps;
float[] songFreqs;
int songAmpsLength;


void loadData() {
  // Load the dataMatrix.txt into a float double array
  String[] songAmpsText = loadStrings("data/dataMatrix.txt");
  songAmpsLength = (float(split(songAmpsText[0], " ") )).length;
  songAmps = new float[songAmpsText.length][songAmpsLength];
  for(int i = 0; i < songAmpsText.length; i++) {
    songAmps[i] = float(split(songAmpsText[i], " ") );
  }
  
  // Load the freqVector.txt into a float array 
  String[] songFreqsText = loadStrings("data/freqVector.txt");
  songFreqs = float(split(songFreqsText[0], " ") );
}


void setup() {
  size(900, 900, P3D);
  smooth(4);
  colorMode(HSB, 360, 100, 100);
  frameRate(24);
  loadData();
  numSectors = 180;
  myWheel = new lineWheel(numSectors, 45, width/2, height/2);
  particles = new ParticleSystem(new PVector(0, 0));
  
  for(int i = 0; i < 8; i++) {
    myBall[i] = new Ball(0, (float)(50*i), 20);
  }
  
  minim = new Minim(this);
  player = minim.loadFile("data/good_song.wav");
  player.play();
  
}


void draw() {
  translate(width/2,height/2);
  background(60);
  particles.addParticle(particleColour, 6, 0.05);
  particles.run();
  
  for (int i = 0; i < numSectors; i++) {
    myWheel.setAmplitude(i, random(170, 300));
  }
  myWheel.display();

  if(ballHeightCnt >= songAmpsLength) ballHeightCnt = 0;
  for(int i = 0; i < 8; i++) {
    myBall[i].update(50*i, -songAmps[i][ballHeightCnt]/5);
    myBall[i].display();
  }
  ballHeightCnt++;
  
}

