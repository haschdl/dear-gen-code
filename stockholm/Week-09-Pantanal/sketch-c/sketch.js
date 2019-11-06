/*
 import pLaunchController.*;
 LaunchController controller;
 */

let buffer;

// Parameters for the drawing. Change as you wish, or update the values in draw() using
// for example mouseX or mouseY
const n_curves = 72;
const transp = 125;
const tightness = 5.5;

// Colors for the drawing, in hexadecimal
const palette = ['#292f36', '#4ecdc4', '#e1e8e1', '#ff6b6b', '#ffe66d'];
let curves = [];

let wait = false;

function setup() {
  createCanvas(900, 600);
  buffer = createGraphics(1800, 1200);
  resetCurves();
}

function resetCurves() {
  wait = true;
  curves = [];
  let m;
  const n_x = 10;
  const n_y = n_curves / n_x;

  const w = buffer.width;
  const h = buffer.height;

  for (let i = 1; i <= n_curves; i++) {
    const x = ((i % int(n_x)) * w) / (n_x - 1);
    const y = (floor(i / (n_x - 1)) * h) / n_y;
    m = new p5.Vector(x + randomGaussian() * 0, y + randomGaussian() * 0);
    const nextColor = palette[int(random(palette.length))];
    // adds 4 to 5 points
    curves.push(new MyCurve(m, int(random(10, 15)), color(nextColor)));
  }
  wait = false;
}

function draw() {
  if (wait) return;

  buffer.background(255);
  buffer.stroke(0, 200);
  for (let i = 0; i < curves.length; i++) {
    const curve = curves[i];
    curve.draw(buffer);
  }
  image(buffer, 0, 0, width, height);
}
