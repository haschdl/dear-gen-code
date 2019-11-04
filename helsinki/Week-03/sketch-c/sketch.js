let savePDF = false;
let fileName;
const rectWidth = 6;
const rectHeight = 60;
const period = 360;
let variationY;
let variationX;
let phaseX = 0;
let phaseY = 0;
const freqX = 1;
const freqY = 1;

function setup() {
  createCanvas(920, 580);
  variationX = 40;
  variationY = 40;

  colorMode(HSB, 360, 100, 100);
}

function draw() {
  background(0);

  for (let y = 0; y < height; y++) {
    const h = map(y, 0, height, 180, 360);
    stroke(h, 70, 30);
    line(0, y, width, y);
  }

  noStroke();
  drawRects();

  if (savePDF) {
    fileName =
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
      '-palha.png';
    save(fileName);
    colorMode(HSB, 360, 100, 100);
    savePDF = false;
  }
}

function drawRects() {
  const compensateX = sin(radians(phaseX)) * variationX;
  const compensateY = sin(radians(phaseY)) * variationY;

  for (
    let x = -int(variationX + rectWidth);
    x <= width + variationX + rectWidth;
    x += rectWidth
  ) {
    if (x > -variationX - rectWidth) {
      const prevX = x - rectWidth;
      const prevAngleX = map(prevX, 0, width, 0, period);
      const angleX = map(x, 0, width, 0, period);
      const prevBendX =
        sin(radians(prevAngleX * freqX + phaseX)) * variationX - compensateX;
      const bendX =
        sin(radians(angleX * freqX + phaseX)) * variationX - compensateX;

      for (
        let y = -int(variationY + rectHeight);
        y <= height + variationY + rectHeight;
        y += rectHeight
      ) {
        if (y > -variationY - rectHeight) {
          const prevY = y - rectHeight;
          const prevAngleY = map(prevY, 0, height, 0, period);
          const angleY = map(y, 0, height, 0, period);

          const prevBendY =
            sin(radians(prevAngleY * freqY + phaseY + prevAngleX)) *
              variationY -
            compensateY;
          const bendY =
            sin(radians(angleY * freqY + phaseY + angleX)) * variationY -
            compensateY;

          const x1 = prevX + prevBendX + prevBendY;
          const x2 = x + bendX + prevBendY - 1;
          const x3 = x + bendX + bendY - variationY / 10;
          const x4 = prevX + prevBendX + bendY;

          const y1 = prevY + prevBendY + prevBendX;
          const y2 = prevY + prevBendY + bendX;
          const y3 = y + bendY + bendX;
          const y4 = y + bendY + prevBendX;

          const h = sin(radians(y1 * 20 + x1)) * 10 + 40;

          fill(h, 90, 80);
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
}

function keyPressed() {
  if (key == 's') {
    fileName =
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
      '-palha.png';
    save(fileName);
  }

  if (key == 's') {
    savePDF = true;
  }
}

function mouseDragged() {
  phaseX += (float(pmouseX - mouseX) / width) * 360;
  phaseY += (float(pmouseY - mouseY) / height) * 360;
}
