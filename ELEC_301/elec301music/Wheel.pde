// Draws a segmented color wheel where the thickness of each segment can be adjusted individually
// NOTE: Only works for < 20 numSectors

class Wheel {
  public int smoothness, innerRadius, offset, xcenter, ycenter, numSectors, colorDegrees;
  public float[] sectorAmplitudes;
  public PShape sector;
  
  Wheel(int numSct, int inRad, int xcntr, int ycntr) {
    numSectors = numSct;
    sectorAmplitudes = new float[numSectors];
    for(int i = 0; i < numSectors; i++) {
      sectorAmplitudes[i] = 0;
    }
    innerRadius = inRad;
    offset = 270;
    smoothness = 4;
    colorDegrees = 240;
    xcenter = xcntr;
    ycenter = ycntr;
  }
  
  public void setAmplitude(int sector, float amplitude) {
    sectorAmplitudes[sector] = amplitude;
  }

  public void display(){
    float xInner, yInner, xOuter, yOuter;
    float vertexOffset = (360/numSectors)/smoothness; // distance between vertices when creating a sector
    for(int j = 0; j < numSectors; j++) {
      sector = createShape(TRIANGLE_STRIP);
      if(j==0) translate(xcenter, ycenter);
      if(numSectors == 1)
        sector.fill(colorDegrees, 90, 70);
      else
        sector.fill(colorDegrees-(j*colorDegrees/(numSectors-1)), 90, 70);
      sector.noStroke();
      for(int i = 0; i < smoothness; i++) {
        xInner = innerRadius*cos(radians(vertexOffset*i+offset));
        yInner = innerRadius*sin(radians(vertexOffset*i+offset));
        xOuter = sectorAmplitudes[j]*cos(radians(vertexOffset*i+offset));
        yOuter = sectorAmplitudes[j]*sin(radians(vertexOffset*i+offset));
        sector.vertex(xInner, yInner);
        sector.vertex(xOuter, yOuter);
      }
      sector.end(CLOSE);
      rotate(TWO_PI/numSectors);
      //shape(sector);
    }
  }
  
}
