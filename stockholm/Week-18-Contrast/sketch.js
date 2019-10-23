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
let palette1 = ["#0"];
let palette2 = ["#FF3111", "#0F009EF"];
let palette3 = [
  "#CF8840",
  "#8D2538",
  "#6C3C25",
  "#FEAE5D",
  "#BB4D1A",
  "#BF4342",
  "#8C1C13",
  "#EB803C",
  "#CD7B31"
];

let palette = palette1;
let w_2;
let h_2;
function setup() {
  createCanvas(900, 600);
  h_2 = height / 2;
  w_2 = width / 2;
  rectMode(CENTER);
  ellipseMode(CENTER);
}

function draw() {
  background(255);
  blendMode(DIFFERENCE);
  translate(w_2, h_2);
  for (let i = 0; i < 100; i++) {
    let p = randomGaussian();

    let x = p * width * 4;
    if (x < -w_2 || x > w_2) {
      i--;
      continue;
    }

    let y = 1 * height * randomGaussian();
    if (y > h_2 || y < -h_2) {
      i--;
      continue;
    }

    let d = sqrt(x * x + y * y);
    let s = map(abs(y), 0, +h_2, 10, 150);

    let c = 200 - sin((d / height) * PI) * 140;
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
  if (key == "r") loop();
}
