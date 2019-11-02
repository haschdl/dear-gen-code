/* exported draw, preload, setup */
function setup() {
  createCanvas(1500, 1000, WEBGL);
  smooth(32);
  strokeWeight(2);
  rectMode(CENTER);
  background(255);
  stroke(color(0, 9));
  noFill();
}

function draw() {
  reflection1();
}

function reflection1() {
  translate(0, -height / 2);
  beginShape();
  for (let i = 1; i <= 100; i++) {
    const f = 1 / pow(2, floor(i / 2) * 0.02);
    // sequence  [0,0,1,1]
    const xf = [-1, -1, 1, 1][i % 4];
    const x = (xf * f * f * f * width) / 2;

    const heightList = [
      height * (1 - f),
      f * height,
      f * height,
      height * (1 - f),
    ];
    const y = heightList[i % 4];
    const yy = y + random();
    const xx = x;
    vertex(xx, yy);
  }
  endShape();
}
function reflection2() {
  translate(width / 2, height / 2);
  push();
  for (let i = 0; i < 50; i++) {
    const f = pow(2, i * 0.2);
    rect(0, 0, width / f, height / f);
  }
  pop();
}
