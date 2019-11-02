// 4D Open Simplex Noise Loop

// OpenSimplexNoise code by Kurt Spencer (https://gist.github.com/KdotJPG/b1270127455a94ac5d19)
// Based on Open Simplex Noise Loop by Daniel Shiffman (https://thecodingtrain.com/CodingChallenges/137-4d-opensimplex-noise-loop)

let totalFrames = 360;
let counter = 0;
let doSave = true;

let increment = 0.01;
let d;
// Just for non-looping demo
let zOff = 0;
let noise;
function setup() {
  createCanvas(1000, 750);
  colorMode(HSB, 360, 100, 100);
  blendMode(DIFFERENCE);
  noise = new SimplexNoise();
  background(0, 0, 0);
  d = pixelDensity();
}

function draw() {
  let n;
  let xOff = 0;
  loadPixels();
  for (let x = 0; x < width; x++) {
    let yOff = 0;
    for (let y = 0; y < height; y++) {
      n = noise.noise3D(xOff, yOff, zOff);
      let hue =
        ((10 * (x * 0.02)) % 150) + ((100 * (y * 0.02)) % 150) + n * 200;
      let sat =
        ((150 * (x * 0.02)) % 150) + ((10 * (y * 0.02)) % 150) + n * 230;
      let brg = ((10 * (x * 0.02)) % 150) + ((50 * (y * 0.02)) % 150) + n * 140;
      let c = color(hue, sat, brg);
      set(x, y, c);
      yOff += increment;
    }
    xOff += increment;
  }
  updatePixels();
  zOff += increment;
}
