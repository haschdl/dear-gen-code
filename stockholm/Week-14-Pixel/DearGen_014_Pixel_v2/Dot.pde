class Dot {

  float x;
  float y;
  float radius;
  color dotColor;
  long timeLastDivided;
  static final int ANIMATION_TIME = 210;  

  Dot(float x, float y, float radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    calculateColor();
    timeLastDivided = millis();
  }
  
  /**
   * Draw the Dot to the screen with a radius and position based on how long 
   * the Dot has been animataing. Return True iff dot is done animating. 
   * Important we check this at time of drawing and not before or after 
   * so we do not get innacurate results due to imprecise timing.
   *
   * @param oldDotX The x position of the Dot that was divided to create this Dot.
   * @param oldDotY The y position of the Dot that was divided to create this Dot.
   * @return true iff the dot is finished animating.
   */
  boolean drawDot(float oldDotX, float oldDotY) {
    fill(dotColor);
    long timeSinceDivision = millis() - timeLastDivided;
    if (timeSinceDivision >= ANIMATION_TIME) {
      ellipse(x, y, radius, radius);
      return true;
    }
    float percentComplete = (float) timeSinceDivision / ANIMATION_TIME;
    float xDiff = x - oldDotX;
    float yDiff = y - oldDotY;
    float rDiff = -radius; //radius - oldRadius = radius - 2*radius = -radius
    float displayX = oldDotX + (percentComplete * xDiff);
    float displayY = oldDotY + (percentComplete * yDiff);
    float displayR = (2 * radius) + (percentComplete * rDiff);
    
    
    
    ellipse(displayX, displayY, displayR, displayR);
    
    

    return false;
  }

  void draw() {
    fill(dotColor);
    ellipse(x, y, radius, radius);
  }

  /**
   * Caculate the value of dotColor; the fill color of the Dot. Accomplishes this by 
   * averaging the colors of the pixels of photo which are overapped by the square 
   * centered at (x,y) with side length 2*radius. This is the square centered around 
   * the Dot and of minimal size such that it still contains the Dot.
   */
  private void calculateColor() {


    // Accumulated r, g, b values 
    float r = 0;
    float g = 0;
    float b = 0;


    int rRadius = round(radius);
    int rx = round(x);
    int ry = round(y);

    // Iterate over the pixels of photo which are overapped by the square 
    // centered at (rx,ry) with side length 2 * rRadius
    for (int i = 0; i < 2 * rRadius; i++) {
      for (int j = 0; j < 2 * rRadius; j++) {
        // photo.get(0,0) is the top left corner
        r += red(photo.get(rx - rRadius + i, ry - rRadius + j));
        g += green(photo.get(rx - rRadius + i, ry - rRadius + j));
        b += blue(photo.get(rx - rRadius + i, ry - rRadius + j));
      }
    }
    // Take mean.
    int numIterations = (4*rRadius*rRadius);
    r /= numIterations;
    g /= numIterations;
    b /= numIterations;
    this.dotColor = color(r, g, b, 100 + 155 * (MIN_DOT_SIZE/radius) );
  }
}
