// Draws a color wheel made of lines whose lengths are individually manageable 
class lineWheel {
  public int smoothness, innerRadius, offset, xcenter, ycenter, numSectors, colorDegrees;
  public float[] sectorAmplitudes;
  
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
    colorDegrees = 240;
  }
  
  public void setAmplitude(int sector, float amplitude) {
    sectorAmplitudes[sector] = amplitude;
  }

  public void display(){
    float xInner, yInner, xOuter, yOuter;
    strokeWeight(2);
    for(int j = 0; j < numSectors; j++) {
      if(numSectors == 1)
        stroke(colorDegrees, 90, 70);
      else
        stroke(colorDegrees-(j*colorDegrees/(numSectors-1)), 90, 70);
      noFill();
      xInner = innerRadius*cos(radians(offset+j*360/numSectors));
      yInner = innerRadius*sin(radians(offset+j*360/numSectors));
      xOuter = sectorAmplitudes[j]*cos(radians(offset+j*360/numSectors));
      yOuter = sectorAmplitudes[j]*sin(radians(offset+j*360/numSectors));
      line(xInner, yInner, xOuter, yOuter);
    }
  }
  
}
