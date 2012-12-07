// Draws a segmented color wheel where the thickness of each segment can be adjusted individually
// NOTE: Only works for < 20 numSectors

class Wheel {
  public int smoothness, innerRadius, offset, xcenter, ycenter;
  public float[] sectorAmplitudes;
  public int numSectors;
  public PShape sector;
  int numberTest = 0;
  
  Wheel(int numSct, int inRad, int xcntr, int ycntr) {
    numSectors = numSct;
    sectorAmplitudes = new float[numSectors];
    for(int i = 0; i < numSectors; i++) {
      sectorAmplitudes[i] = 0;
    }
    innerRadius = inRad;
    offset = 180;
    smoothness = 4;
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
        sector.fill(240, 90, 70);
      else
        sector.fill(240-(j*240/(numSectors-1)), 90, 70);
      sector.noStroke();
      for(int i = 0; i < smoothness; i++) {
        xInner = innerRadius*cos(radians(vertexOffset*i+offset)); // to fix translation issue, add xcenter
        yInner = innerRadius*sin(radians(vertexOffset*i+offset)); // add ycenter
        xOuter = sectorAmplitudes[j]*cos(radians(vertexOffset*i+offset)); // + xcenter
        yOuter = sectorAmplitudes[j]*sin(radians(vertexOffset*i+offset)); // + ycenter
        sector.vertex(xInner, yInner);
        sector.vertex(xOuter, yOuter);
      }
      sector.end(CLOSE);
      rotate(TWO_PI/numSectors);
      shape(sector);
      numberTest++;
      print(numberTest + "\n");
      
    }
    
  }
}
