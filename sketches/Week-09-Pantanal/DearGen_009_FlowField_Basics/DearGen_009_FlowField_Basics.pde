FlowField flowField ;
boolean drawArrows = false;
void setup() {

  size(1200, 900);

  colorMode(HSB, 360, 100, 100, 100);

  flowField = new FlowField(20);
}

void draw() {
  background(0, 0, 10);
  flowField.update((float)millis()/5000);
  flowField.draw(drawArrows);
}


void mousePressed() {
  //inverts the value of drawArrows 
  //at every mouse click
  drawArrows = !drawArrows;
}
