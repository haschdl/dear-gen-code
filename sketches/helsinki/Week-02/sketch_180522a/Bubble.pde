/**
 * This sketch was based on
 * an example from Processing:
 * Loading Tabular Data
 * by Daniel Shiffman.
 */
 
class Bubble {
  float x,y;
  float radius;
  
  boolean over = false;
  
  PVector[] positions;
  color c = color(random(5, 30), random(5, 35), random(0, 25));
  
  Bubble(float x_, float y_, float radius_) {
    x = x_;
    y = y_;
    radius = radius_;
    
    if(radius > 0){
      positions = new PVector[int(radius)];
      for(int i = 0; i < int(radius); i++){
        float randomR = random(radius);
        float randomA = random(360);
        float thisX = cos(radians(i * randomA)) * randomR + x;
        float thisY = sin(radians(i * randomA)) * randomR + y;
        positions[i] = new PVector(thisX, thisY);
      }
    }
  }
  
  void display() {
    //fill(255);
    //ellipse(x, y, 20, 20);
    
    stroke(c);
    strokeWeight(1);
    noFill();
    
    beginShape();
    if(radius > 0){
      for(int i = 0; i < int(radius); i++){
        curveVertex(positions[i].x, positions[i].y);
      }
    }
    endShape();
  }
}
