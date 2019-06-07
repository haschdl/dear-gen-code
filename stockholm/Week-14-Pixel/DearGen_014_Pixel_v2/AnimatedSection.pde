class AnimatedSection {
  private float x;
  private float y;
  private float sideLength;
  private Dot[] animatedDots;

  AnimatedSection(Dot dot) {
    x = dot.x;
    y = dot.y;
    sideLength = dot.radius * 2;
    
    float halfOldRadius = sideLength / 4;
    Dot topLeft = new Dot(x - halfOldRadius, y - halfOldRadius, halfOldRadius);
    Dot topRight = new Dot(x + halfOldRadius, y - halfOldRadius, halfOldRadius);
    Dot bottomLeft = new Dot(x - halfOldRadius, y + halfOldRadius, halfOldRadius);
    Dot bottomRight = new Dot(x + halfOldRadius, y + halfOldRadius, halfOldRadius);
    animatedDots = new Dot[] {topLeft, topRight, bottomLeft, bottomRight};
  }
  
  boolean drawSection() {
    fill(255);
    rect(x, y, sideLength, sideLength);
    boolean doneAnimating = true;
    for (Dot dot : animatedDots) {
      if(!dot.drawDot(x, y)) {
        doneAnimating = false;
      }
    }
    return doneAnimating;
  }
  
  Dot[] getDotsCreated() {
    return animatedDots;
  }
  
}
