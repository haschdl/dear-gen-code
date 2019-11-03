/**
 * Based on Noise2D
 * by Daniel Shiffman.
 */

const increment = 0.01;
const gridSize = 5;
const lineLength = gridSize * 2;
let initAngle;

function setup() {
  createCanvas(920, 580, WEBGL);
  strokeWeight(1);
  initAngle = random(-360, 360);
  colorMode(HSB, 360, 360, 360, 360);
}

function draw() {
  translate(-width / 2, -height / 2);
  const fileName =
    'saved/' +
    year() +
    '-' +
    month() +
    '-' +
    day() +
    '-' +
    hour() +
    '-' +
    minute() +
    '-' +
    second() +
    '-flow.pdf';

  const ang = 240;
  background(ang, ang / 2, ang / 2, 360);

  noFill();
  strokeWeight(gridSize);

  let xoff = 0.0; // Start xoff at 0
  const detail = 0.8;
  noiseDetail(8, detail);

  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (let x = 0; x < width; x += gridSize) {
    xoff += increment; // Increment xoff
    let yoff = 0.0; // For every xoff, start yoff at 0
    for (let y = 0; y < height; y += gridSize) {
      yoff += increment; // Increment yoff

      // Calculate noise and scale by 360
      const angle = noise(xoff, yoff) * 360;

      const x1 = cos(radians(angle)) * lineLength + x;
      const y1 = sin(radians(angle)) * lineLength + y;
      const x2 = cos(radians(angle + 180)) * lineLength + x;
      const y2 = sin(radians(angle + 180)) * lineLength + y;

      stroke(angle + initAngle, angle / 3, angle / 3, angle);
      line(x1, y1, x2, y2);
    }
  }

  const fileName2 =
    'saved-png/' +
    year() +
    '-' +
    month() +
    '-' +
    day() +
    '-' +
    hour() +
    '-' +
    minute() +
    '-' +
    second() +
    '-flow.png';
  save(fileName2);

  noLoop();
}
