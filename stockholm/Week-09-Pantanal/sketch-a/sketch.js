let buffer;

//Parameters for the drawing. Change as you wish, or update the values in draw() using
//for example mouseX or mouseY
let n_curves = 1;
let transp = 125;
let tightness = 5.5;
let curve;

let wait = false;

function setup() {
  createCanvas(600, 600);
  resetCurves();
}

function mousePressed() {
  resetCurves();
}

function resetCurves() {
  wait = true;
  curve = new MyCurve(new p5.Vector(0, 0), int(random(30, 50)), 0x292f36); //adds 4 to 5 points
  wait = false;
}

function draw() {
  if (wait) return;

  translate(width / 2, height / 2);
  background(255);
  smooth();
  stroke(0, 200);
  curve.draw();
}
