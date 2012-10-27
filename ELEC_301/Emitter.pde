import java.util.Collections;

abstract class AEmitter{
  
  protected float emitterSize;
  protected float[] position;
  protected ArrayList myRipples;
  protected ARipple nextRipple; //next ripple to shoot out
  
  
  public AEmitter(float[] tempPos, float tempSize){
    position = tempPos;
    emitterSize = tempSize;
    myRipples = new ArrayList();
    nextRipple = null;
  }
  
  //Defines next ripple to be pulsed when emitted is called. Ripple stays
  //in this variable even after it is emitted, so that it can be done multiple
  //times.
  public void nextRipple(ARipple tempRipple){
    nextRipple = tempRipple;
  }
  
  public void emitRipple(){
    //emit a copy of nextRipple, not nextRipple itself
    ARipple myCopy = nextRipple.clone();
    myRipples.add(myCopy);
  }
  
  public void update(){
    if (myRipples.isEmpty() == false){
      for (int i = 0; i < myRipples.size(); i++){
        ARipple thisRipple = (ARipple) myRipples.get(i);
        boolean isInvisible = thisRipple.update();
        if (isInvisible == true){
          myRipples.remove(i);
          i--;
        }
      }
    }
  }
  
  public void display(){
    Collections.sort(myRipples);
    //display each ripple
    for (int i = 0; i < myRipples.size(); i++){
      ARipple thisRipple = (ARipple) myRipples.get(i);
      thisRipple.display(position);
    }
    //display this emitter
    fill(color(255,255,255));
    ellipse(position[0], position[1], emitterSize, emitterSize); //NEED TO MAKE THIS GENERALIZE FOR ANY SHAPE
  }
}

class RegularEmitter extends AEmitter{
  public RegularEmitter(float[] tempPos, float tempSize){
    super(tempPos, tempSize);
  }
}
