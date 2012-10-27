ArrayList emitters;

void setup(){
  size(800,800);
  emitters = new ArrayList();
}

void draw(){
  background(0);
  
  for (int i = 0; i < emitters.size(); i++){
    AEmitter thisEmitter = (AEmitter) emitters.get(i);
    thisEmitter.update();
    thisEmitter.display();
  }
}

void mousePressed(){
  if (mouseButton == LEFT){
    float[] pos = {mouseX, mouseY};
    AEmitter emitterToAdd = new RegularEmitter(pos, 4);
    emitterToAdd.nextRipple(new WholeCircleRipple(5, 4, 5, color(255,255,255)));
    emitters.add(emitterToAdd);
  }
  if (mouseButton == RIGHT){
    for (int i = 0; i < emitters.size(); i++){
      AEmitter emitter = (AEmitter) emitters.get(i);
      emitter.emitRipple();
    }
  }
}
