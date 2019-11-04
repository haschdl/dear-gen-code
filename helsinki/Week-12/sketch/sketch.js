let yArr = [];
let yOff = 0.0;
const yIncrement = 0.05;
const iterations = 200;

function setup() {
  createCanvas(920, 580);
  noLoop();
  noiseSeed(123);
  colorMode(HSB, 360, 100, 100);
  for (let i = 0; i < width / 10; i++) {
    const n = noise(yOff - 0.5) * (height / 8);
    yOff += yIncrement;
    yArr.push(n);
  }
}

function draw() {
  background(250, 20, 90);

  const from = color(250, 20, 90);
  const to = color(180, 24, 99);
  for (let y = 0; y < height; y++) {
    const percent = y / height;
    const interA = lerpColor(from, to, percent);
    stroke(interA);
    line(0, y, width, y);
  }

  translate(0, height / 2);
  for (let y = 0; y <= iterations; y++) {
    drawRow(y);
  }
}

function drawRow(rowIndex) {
  const tempY = [];

  for (let i = 0; i < yArr.length; i++) {
    const n = (noise(yOff) - 0.5) * (height / 16);
    yOff += yIncrement;
    tempY.push(yArr[i] + n);
    const h = map(rowIndex, 0, iterations, 320, 360);
    const b = map(rowIndex, 0, iterations, 80, 50);
    stroke(h, 80, b);
    fill(h, 80, b);

    if (i > 0) {
      const x1 = map(i, 0, yArr.length - 1, 0, width);
      const x2 = map(i - 1, 0, yArr.length - 1, 0, width);
      beginShape();
      vertex(x1, yArr[i]);
      vertex(x2, yArr[i - 1]);
      vertex(x2, tempY[i - 1]);
      vertex(x1, tempY[i]);
      endShape(CLOSE);

      stroke(h, 80, b - 10);
      line(x1, yArr[i], x2, yArr[i - 1]);
    }
  }

  yArr = tempY;
  yOff = random(100);
}
