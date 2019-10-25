let buffer;
let noise;
let scale = 0.01;
let n = 800;

function setup() {
  createCanvas(1200, 800, P2D);
  buffer = createGraphics(1800, 1200);
  noise = new SimplexNoise();
  background(255);
  smooth();
}

function draw() {
  buffer.noStroke();
  buffer.background(255);

  // roof
  let w = 50;
  let h = buffer.height / 20;

  let n_across = floor(buffer.width / w);

  let W = w * 20;
  let H = 5 * h;

  let x_space = 0;
  fill(180);

  for (let i = 0; i < n; i++) {
    let totalW = w * n_across;

    let noiseV = noise.noise3D(
      scale * i,
      scale * frameCount,
      cos(TWO_PI * millis() / 50000)
    );
    let row = floor((1.0 * i) / n_across);
    let col = (i % n_across) * (w * 2 + x_space) + (row % 2) * w;

    buffer.push();

    diamondShape(col, row * (h + 0), w, h, abs(noiseV) * 150);
    buffer.pop();
  }

  image(buffer, 0, 0, width, height);
}

function diamondShape(x, y, w, h, hue) {
  buffer.push();
  buffer.translate(x, y);
  if (
    x < buffer.width * 0.55 &&
    x > buffer.width * 0.45 &&
    y < buffer.height * 0.55 &&
    y > buffer.height * 0.45
  ) {
    //"wall"
    buffer.fill(200);
    buffer.rect(-w * 0.8, h * 0.5, w * 1.6, h * 0.7);

    //door
    buffer.fill(100);
    buffer.rect(-w * 0.1, h * 0.9, w * 0.2, h * 0.3);
  }
  buffer.fill(hue);
  buffer.beginShape();
  buffer.vertex(0, 0);
  buffer.vertex(w, h / 2);
  buffer.vertex(w, h);
  buffer.vertex(0, h / 2);
  buffer.endShape(CLOSE);
  buffer.fill(hue + 100);

  buffer.beginShape();
  buffer.vertex(0, 0);
  buffer.vertex(-w, h / 2);
  buffer.vertex(-w, h);
  buffer.vertex(0, h / 2);
  buffer.endShape(CLOSE);

  buffer.pop();
}
