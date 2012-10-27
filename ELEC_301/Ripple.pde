
abstract class ARipple implements Comparable<ARipple>,Cloneable{
  
  protected float velocity;  //speed in pixels per frame
  protected float thickness; 
  protected float fadeSpeed; //change in alpha each frame
  protected color myColor;    //has both color AND transparency built in
  protected int distanceToCenter;
  
  public ARipple(float tempVel, float tempThick, float tempFadeSpeed, color tempCol){
    velocity = tempVel;
    thickness = tempThick;
    fadeSpeed = tempFadeSpeed;
    myColor = tempCol;
    distanceToCenter = 0;
  }
  
  public ARipple(ARipple rippleToCopy){
    this.velocity = rippleToCopy.velocity;
    this.thickness = rippleToCopy.thickness;
    this.fadeSpeed = rippleToCopy.fadeSpeed;
    this.myColor = rippleToCopy.myColor;
    this.distanceToCenter = rippleToCopy.distanceToCenter;
  }
  
  //ideally called once per frame, update all visual data
  public boolean update(){
    //update position
    distanceToCenter += velocity;
    
    //update color and transparency
    myColor = color(red(myColor), green(myColor), blue(myColor), alpha(myColor) - fadeSpeed); //need to do this with bitshifting
    //check if ripple is invisible. if it is, flip a flag to delete it.
    boolean isInvisible;
    if (alpha(myColor) <= 0){
      isInvisible = true;
    }
    else{
      isInvisible = false;
    }
    return isInvisible;
  }
  
  public abstract void display(float[] centerPosition);
  
  public abstract ARipple clone();
  
  public int getDistanceToCenter(){
    return this.distanceToCenter;
  }
  
  //When sorting, order Ripples such that ones closest to the center are first.
  public int compareTo(ARipple otherRipple){
    return otherRipple.getDistanceToCenter() - this.distanceToCenter;
  }
}

//------------------------------END OF ABSTRACT CLASS---------------------------------

class WholeCircleRipple extends ARipple{
  
  public WholeCircleRipple(float tempVel, float tempThick, float tempFadeSpeed, color tempCol){
    super(tempVel, tempThick, tempFadeSpeed, tempCol);
  }
  
  public WholeCircleRipple(ARipple rippleToCopy){
    super(rippleToCopy);
  }
  
  public void display(float[] centerPosition){
    noFill();                //don't fill in the circle
    stroke(myColor);         //make circle desired color
    strokeWeight(thickness); //and desired thickness
    ellipse(centerPosition[0], centerPosition[1], distanceToCenter, distanceToCenter);
  }
  
  //clone ripple so we keep nextRipple intact
  public ARipple clone(){
    ARipple thisClone = new WholeCircleRipple(this);
    return thisClone;
  }
}



class SegmentedCircleRipple extends ARipple{
  public SegmentedCircleRipple(){
  }
  public void display(float[] centerPos){
  }
}

//class WholePolygonRipple extends ARipple{
//  public WholePolygonRipple(){
//  }
//  public void display(float[] centerPos){
//  }
//}
//
//class SegmentedPolygonRipple extends ARipple{
//  public SegmentedPolygonRipple(){
//  }
//  public void display(float[] centerPos){
//  }
//}


