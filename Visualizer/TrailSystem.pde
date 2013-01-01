class TrailSystem {
  ArrayList<Trail> trails;
  
  TrailSystem() {
    trails = new ArrayList<Trail>();
  }

  void addTrail(float xLoc, float yTop, float yBottom) {
    trails.add(new Trail(xLoc, yTop, yBottom));
  }

  void run() {
    Iterator<Trail> trailIter = trails.iterator();
    while (trailIter.hasNext()) {
      Trail myTrail = trailIter.next();
      myTrail.run();
      if(myTrail.isDead()) trailIter.remove();
    }
  }

}
