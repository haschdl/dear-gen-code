let flowField;
let drawArrows = false;

function setup() {
  createCanvas(1200, 900);
  colorMode(HSB, 360, 100, 100, 100);
  flowField = new FlowField(20);
}

function draw() {
  background(0, 0, 10);
  flowField.update(millis() / 5000);
  flowField.draw(drawArrows);
}

function mousePressed() {
  // inverts the value of drawArrows
  // at every mouse click
  drawArrows = !drawArrows;
}
