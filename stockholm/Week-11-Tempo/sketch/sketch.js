// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain

// Double Pendulum
// https://youtu.be/uWzPe_S-RVE

let r1 = 180;
const r2 = 300 - r1;
const m1 = 40;
const m2 = 40;
let a1 = Math.PI / 2;
let a2 = Math.PI / 2;
let a1_v = 0.1;
let a2_v = 0;

let px2 = -1;
let py2 = -1;
let cx;
let cy;

let buffer;

function setup() {
  createCanvas(900, 600);
  colorMode(HSB, 360, 100, 100);
  cx = width / 2;
  cy = height / 2;
  buffer = createGraphics(width, height);
  buffer.background(255);
}

function draw() {
  imageMode(CORNER);
  image(buffer, 0, 0, width, height);
  // ellipse(0, 0, 200, 200);
  r1 = 5 + 20 * (1 + sin(millis() / 4000));

  let num1 = (2 * m1 + m2) * sin(a1);
  let num2 = -m2 * sin(a1 - 2 * a2);
  let num3 = -2 * sin(a1 - a2) * m2;
  let num4 = a2_v * a2_v * r2 + a1_v * a1_v * r1 * cos(a1 - a2);
  let den = r1 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));
  const a1_a = 0; // (num1 + num2 + num3*num4) / den;

  num1 = 2 * sin(a1 - a2);
  num2 = a1_v * a1_v * r1 * (m1 + m2);
  num3 = (m1 + m2) * cos(a1);
  num4 = a2_v * a2_v * r2 * m2 * cos(a1 - a2);
  den = r2 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));
  const a2_a = (num1 * (num2 + num3 + num4)) / den;

  translate(cx, cy);
  stroke(0);
  strokeWeight(2);

  const x1 = r1 * sin(a1);
  const y1 = r1 * cos(a1);

  const x2 = x1 + r2 * sin(a2);
  const y2 = y1 + r2 * cos(a2);

  line(0, 0, x1, y1);
  fill(0);
  ellipse(x1, y1, m1, m1);

  line(x1, y1, x2, y2);
  fill(0);
  ellipse(x2, y2, m2, m2);

  a1_v += a1_a;
  a2_v += a2_a;
  a1 += a1_v;
  a2 += a2_v;

  // buffer.background(0, 1);
  buffer.colorMode(HSB, 360, 100, 100);
  buffer.push();
  buffer.translate(cx, cy);
  // buffer.noStroke();

  const n = 12 + 2 * int(frameCount / 50);
  if (frameCount % n == 0) {
    buffer.fill(200 + 160 * abs(sin(a1 + millis())), 100, 100, 20);
    buffer.endShape();
    buffer.beginShape();
  }
  if (frameCount > 1) {
    buffer.vertex(px2, py2);
    buffer.vertex(x2 + a1_v, y2);
  }
  buffer.pop();

  px2 = x2;
  py2 = y2;
}
