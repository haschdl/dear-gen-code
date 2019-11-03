let padding;
const noiseIncr = 0.8;
let off = 0.0;
let incrSize;

function setup() {
  createCanvas(580, 920);
  padding = height / 10;
  noLoop();
  incrSize = width / 30;
  colorMode(HSB, 360, 100, 100);
}

function draw() {
  // background(80, 90, 100);
  // background(255);

  noStroke();
  for (let y = 0; y < height; y++) {
    const s = map(y, 0, height, 19, 40);
    const b = map(y, 0, height, 38, 20);
    fill(209, 19, b);
    rect(0, y, width, 1);
  }

  // drawLine(width/4, padding);
  // drawLine(width/2, height/2);

  // let incr = width/80;
  const incr = 0.5;
  for (let x = padding; x < width - padding; x += incr) {
    const ang = map(x, padding, width - padding, 0, TWO_PI);
    const y = sin(ang) * (height / 2 - padding * 2) + height / 2;
    drawLine(x, y);
  }

  const fileName =
    'saved-png-' +
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
    '-water.png';
  save(fileName);
}

function drawLine(posX, endY) {
  const incr = height / 20;
  for (let y = padding; y < height - endY; y += incr) {
    const noiseV = (noise(off) * width) / 30;
    const noisePrev = noise(off - noiseIncr) * incrSize;
    const x = noiseV + posX;
    const prevY = y - incr;
    const ang = map(y, padding, height - endY, PI, TWO_PI);
    const alpha = (cos(ang) / 2 + 0.5) * 120 + 10;
    noStroke();
    fill(0, 0, 100, alpha);
    // fill(80, 90, 100, alpha);
    ellipse(x, y + noiseV * 4, width / 150, width / 150);

    noFill();
    stroke(0, 0, 100, alpha);
    // stroke(80, 90, 100, alpha);
    if (y > padding) {
      const prevX = noisePrev + posX;
      line(x, y + noiseV * 4, prevX, prevY + noisePrev * 4);
    }
    off = off + noiseIncr;
  }
}
