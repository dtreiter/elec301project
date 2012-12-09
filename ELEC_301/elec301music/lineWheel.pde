// Draws a segmented color wheel where the thickness of each segment can be adjusted individually
// NOTE: Only works for < 20 numSectors

class lineWheel {
  public int smoothness, innerRadius, offset, xcenter, ycenter;
  public float[] sectorAmplitudes;
  public int numSectors;
  int numberTest = 0;
  
  lineWheel(int numSct, int inRad, int xcntr, int ycntr) {
    numSectors = numSct;
    sectorAmplitudes = new float[numSectors];
    for(int i = 0; i < numSectors; i++) {
      sectorAmplitudes[i] = 0;
    }
    innerRadius = inRad;
    offset = 270;
    xcenter = xcntr;
    ycenter = ycntr;
  }
  
  public void setAmplitude(int sector, float amplitude) {
    sectorAmplitudes[sector] = amplitude;
  }

  public void display(){
    float xInner, yInner, xOuter, yOuter;
    strokeWeight(2);
    for(int j = 0; j < numSectors; j++) {
      if(numSectors == 1)
        stroke(240, 90, 70);
      else
        stroke(240-(j*240/(numSectors-1)), 90, 70);
      noFill();
      xInner = innerRadius*cos(radians(offset+j*360/numSectors)); // to fix translation issue, add xcenter
      yInner = innerRadius*sin(radians(offset+j*360/numSectors)); // add ycenter
      xOuter = sectorAmplitudes[j]*cos(radians(offset+j*360/numSectors)); // + xcenter
      yOuter = sectorAmplitudes[j]*sin(radians(offset+j*360/numSectors)); // + ycenter
      line(xInner, yInner, xOuter, yOuter);
      numberTest++;
      print(numberTest + "\n");
      
    }
    
  }
}
