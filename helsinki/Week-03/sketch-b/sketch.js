const save = false; // change this to 'true' to save PDF
const rectWidth = 10;
const rectHeight = 3;
const period = 360;
let variationX;
let variationY;

function setup() {
  createCanvas(1200, 800);
  variationY = height / 20;
  variationX = width / 7;
  colorMode(HSB, 360, 100, 100);
}

function draw() {
  for (let y = 0; y < height; y++) {
    stroke(map(y, 0, height, 0, 360), 70, 40);
    line(0, y, width, y);
  }

  drawRects();

  if (save) {
    const fileName =
      'saved_' +
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
      '-palha.pdf';
    save(fileName);

    noLoop();
  }
}

function drawRects() {
  for (let y = -int(period); y <= period * 2; y += rectHeight) {
    const prevY = y - rectHeight;
    const prevPhase = map(y - rectHeight, 0, height, 0, period);
    const phase = map(y, 0, height, 0, period);

    const prevPhaseVar = cos(radians(prevPhase)) * variationX;
    const phaseVar = cos(radians(phase)) * variationX;

    for (let x = -int(period); x <= period * 2; x += rectWidth) {
      const prevX = x - rectWidth;

      // let varVar3 = cos(radians(prevY));
      // let varVar4 = cos(radians(y));
      const varVar3 = 1;
      const varVar4 = 1;

      if (y > -variationY && x > -period) {
        const varVar1 = sin(radians(prevX));
        const varVar2 = sin(radians(x));
        // let varVar1 = 1;
        // let varVar2 = 1;

        const bendX1 = sin(radians(prevY)) * variationX * varVar1;
        const x1 = (width * prevX) / period + bendX1;

        const bendX2 = sin(radians(prevY)) * variationX * varVar2;
        const x2 = (width * x) / period + bendX2;

        const bendX3 = sin(radians(y)) * variationX * varVar2;
        const x3 = (width * x) / period + bendX3;

        const bendX4 = sin(radians(y)) * variationX * varVar1;
        const x4 = (width * prevX) / period + bendX4;

        // yyyyyyy

        const bendY1 = cos(radians(prevX)) * variationY * varVar3;
        const y1 = (height * prevY) / period + bendY1;

        const bendY2 = cos(radians(x)) * variationY * varVar3;
        const y2 = (height * prevY) / period + bendY2;

        const bendY3 = cos(radians(x)) * variationY * varVar4;
        const y3 = (height * y) / period + bendY3 - 3;

        const bendY4 = cos(radians(prevX)) * variationY * varVar4;
        const y4 = (height * y) / period + bendY4;

        const hueShift = map(y, -variationY, height + variationY, 10, 50);
        const h = (sin(radians(y * 20 - x * 10)) / 2 + 0.5) * 20 + hueShift;
        const b = (sin(radians(y * 20 - x * 10)) / 2 + 0.5) * 20 + 70;

        strokeWeight(1);
        stroke(h, 80, b - 30);
        fill(h, 80, b);

        beginShape();
        vertex(x1, y1);
        vertex(x2, y2);
        vertex(x3, y3);
        vertex(x4, y4);
        endShape(CLOSE);
      }
    }
  }
}
