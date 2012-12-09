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

ICABox[] myICABox = new ICABox[8];
int boxCounter = 0;

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
    myICABox[i] = new ICABox((int)i*width/(8),(int)width/8,0);
  }
  
  minim = new Minim(this);
  player = minim.loadFile("data/good_song.wav");
  player.play();
}


void draw() {
  background(0,0,0);
  if(boxCounter >= songAmpsLength) boxCounter = 0;
  for(int i = 0; i < 8; i++) {
    myICABox[i].update((int)songAmps[i][boxCounter]/100);
    myICABox[i].display();
  }
  boxCounter++;
  
  translate(width/2,height/2); //translate after drawing the boxes
  
  particles.addParticle(particleColour, 6, 0.05);
  particles.run();
  
  for (int i = 0; i < numSectors; i++) {
    myWheel.setAmplitude(i, random(170, 400));
  }
  myWheel.display();
  
}

