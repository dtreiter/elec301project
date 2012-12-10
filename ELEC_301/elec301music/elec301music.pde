import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim minim;
AudioPlayer player;
BeatDetect beat;
FFT myFFT;

lineWheel myWheel;
ParticleSystem particles;
color particleColour = color(150, 120, 0);
int particlesPerFrame = 10;
int numSectors;
float[] sectorAmps;
float sectorDecay = 10;
TrailSystem trails;

int filePointer = 0;
float[][] songAmps;
float[] songFreqs;
int icaLength, numIcaComponents;


void loadData() {
  // Load the dataMatrix.txt into a float double array
  String[] songAmpsText = loadStrings("data/dataMatrix.txt");
  icaLength = (float(split(songAmpsText[0], " ") )).length;
  songAmps = new float[songAmpsText.length][icaLength];
  for (int i = 0; i < songAmpsText.length; i++) {
    songAmps[i] = float(split(songAmpsText[i], " ") );
  }

  // Load the freqVector.txt into a float array 
  String[] songFreqsText = loadStrings("data/freqVector.txt");
  songFreqs = float(split(songFreqsText[0], " ") );
  numIcaComponents = songFreqs.length;
}


void setup() {
  size(900, 900, P3D);
  smooth(4);
  colorMode(HSB, 360, 100, 100);
  frameRate(24);
  loadData();
  numSectors = 180;
  myWheel = new lineWheel(numSectors, 100, width/2, height/2);
  particles = new ParticleSystem(new PVector(0, 0));
  trails = new TrailSystem();

  minim = new Minim(this);
  player = minim.loadFile("data/good_song.wav");
  player.play();
  beat = new BeatDetect();
  myFFT = new FFT(player.bufferSize(), player.sampleRate());

  myFFT.forward(player.mix);
  sectorAmps = new float[myFFT.specSize()];
}


void draw() {
  beat.detect(player.mix);
  translate(width/2, height/2);
  background(60);
    
  if (beat.isOnset()) { // Add particlesPerFrame number of particles if a beat is detected
    for (int i = 0; i < particlesPerFrame; i++) {
      particles.addParticle(particleColour, 6, 10);
    }
  }
  particles.run();

  // Set the tone wheel's amplitude's then draw it
  float lineAmplitude = 0;
  float normalizer;
  myFFT.forward(player.mix);
  for (int i = 0; i < numSectors; i++) {
    normalizer = 45*(i+16)/(numSectors-1);
    if (myFFT.getBand(i) > sectorAmps[i]) {
      sectorAmps[i] = myFFT.getBand(i);
    }
    else sectorAmps[i] -= sectorDecay/normalizer;
    if (sectorAmps[i] < 0) sectorAmps[i] = 0;
    lineAmplitude = normalizer*sectorAmps[i] + 1.2*myWheel.innerRadius;
    myWheel.setAmplitude(i, lineAmplitude);
  }
  myWheel.display();
  
  for(int i = 0; i < songAmps.length; i++) {
    if(songAmps[i][filePointer] != 0)
      trails.addTrail(songFreqs[i], -3*songAmps[i][filePointer], 0.0);
  }
  trails.run();
  
  filePointer++; // filePointer goes through the ICA data and increments once per frame, stopping when it hits the end2
  if(filePointer == icaLength) filePointer--;

}

