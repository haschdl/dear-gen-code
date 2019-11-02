/* exported setup, draw, keyPressed */

/**
 * 'Contrast', by H.Scheidl
 * Part of Dear-Gen project.
 */

// A monochromatic drawing. This is the version printed
// To experiment with other colors, change the assignment
// of
// let palette = palette1;
// to
// let palette = palette2;
// or
// let palette = palette3;
const palette1 = ['#0'];
// eslint-disable-next-line no-unused-vars
const palette2 = ['#FF3111', '#0F009EF'];
// eslint-disable-next-line no-unused-vars
const palette3 = [
  '#CF8840',
  '#8D2538',
  '#6C3C25',
  '#FEAE5D',
  '#BB4D1A',
  '#BF4342',
  '#8C1C13',
  '#EB803C',
  '#CD7B31',
];

const palette = palette1;
let w2;
let h2;

function setup() {
  createCanvas(900, 600);
  h2 = height / 2;
  w2 = width / 2;
  rectMode(CENTER);
  ellipseMode(CENTER);
}

function draw() {
  background(255);
  blendMode(DIFFERENCE);
  translate(w2, h2);
  for (let i = 0; i < 100; i++) {
    const p = randomGaussian();
    const x = p * width * 4;
    if (x < -w2 || x > w2) {
      i--;
      continue;
    }

    const y = 1 * height * randomGaussian();
    if (y > h2 || y < -h2) {
      i--;
      continue;
    }
    const s = map(abs(y), 0, +h2, 10, 150);
    fill(palette[i % palette.length]);
    if (random() < 0.2) circle(x, y, s * 10);
    else rect(x, y, s, s);
  }
  noLoop();
}

/**
 * Use 'r' to run a new iteration of the drawing.
 * This will increase the details.
 */
function keyPressed() {
  if (key === 'r') loop();
}
