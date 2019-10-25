let r0, r;
let x, y, inc;
let canvas;

function setup() {
  createCanvas(1200, 800);
  colorMode(HSB, 360, 1, 1, 1);
  y = 0;
  r0 = height * 0.1;
  x = -r0;
  inc = r0 / 20;
  noFill();
}

function draw() {
  background(0, 0, 1, 2);
  y = 0;
  for (let i = 0; y <= height; i++) {
    x = 0;
    for (let j = 0; x <= width ; j++) {
      x += inc;
      push();
      translate(x, y);
      stroke(220 + 40 * sin(TWO_PI*j/50 + i*PI), 1, 1, 1);
      r = r0 * abs(sin(10 * HALF_PI * j * PI * (inc / width)));
      ellipse(0, 0, r, r);
      pop();
    }
    y += r0;
  }
}
