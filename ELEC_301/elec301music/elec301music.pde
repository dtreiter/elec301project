import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player;

Wheel myWheel;
ParticleSystem particles;
color particleColour = color(255, 120, 0);
int numSectors;

Ball[] myBall = new Ball[8];
int ballHeightCnt = 0;

float[][] songAmps;
float[] songFreqs;
int songAmpsLength;

void loadData(){
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
  smooth();
  colorMode(HSB, 360, 100, 100);
  frameRate(24);
  loadData();
  numSectors = 80;
  myWheel = new Wheel(numSectors, 45, width/2, height/2);
  particles = new ParticleSystem(new PVector(0, 0));
  
  for(int i = 0; i < 8; i++) {
    myBall[i] = new Ball(0, (float)(50*i), 40);
  }
  
  minim = new Minim (this);
  player = minim.loadFile("data/good_song.wav");
  player.play();
}

void draw() {
  background(60);
  
  for(int i = 0; i < numSectors; i++) {
    myWheel.setAmplitude(i, random(100,200));
  }
  myWheel.display();
  
  particles.addParticle(particleColour, 8, 1.5);
  particles.run();

  if(ballHeightCnt >= songAmpsLength) ballHeightCnt = 0;
  for(int i = 0; i < 8; i++) {
    myBall[i].update(50*i, songAmps[i][ballHeightCnt]-height/2);
    myBall[i].display();
  }
  ballHeightCnt++;
}
