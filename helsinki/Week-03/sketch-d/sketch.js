const subdivisionsX = 40;
const subdivisionsY = 130;

const periodX = 360 * 0.9;
const periodY = 360 * 1.1;

let distortionX;
let distortionY;

let rectWidth;
let rectHeight;

function setup() {
  createCanvas(900, 600);

  rectWidth = width / subdivisionsX;
  rectHeight = height / subdivisionsY;

  distortionX = width / 8;
  distortionY = height / 40;

  colorMode(HSB, 360, 100, 100);
}

function draw() {
  background(0);

  for (let y = 0; y < height; y++) {
    stroke(map(y, 0, height, 180, 360), 70, 30);
    line(0, y, width, y);
  }

  noStroke();
  drawRects();
}

function drawRects() {
  for (
    let y = -rectHeight - distortionY;
    y <= height + rectHeight + distortionY;
    y += rectHeight
  ) {
    if (y > -rectHeight - distortionY) {
      const prevY = y - rectHeight;
      for (
        let x = -rectWidth - distortionX;
        x <= width + rectWidth + distortionX;
        x += rectWidth
      ) {
        if (x > -rectWidth - distortionX) {
          const prevX = x - rectWidth;

          const prevPhaseX = map(prevX, 0, width, 0, periodX);
          const phaseX = map(x, 0, width, 0, periodX);

          const prevAngleY = map(prevY, 0, height, 0, periodY);
          const angleY = map(y, 0, height, 0, periodY);

          const varPrevAmplX = cos(radians(prevPhaseX));
          const varAmplX = cos(radians(phaseX));

          const bendX1 =
            sin(radians(prevAngleY + prevPhaseX)) * distortionX * varPrevAmplX;
          const bendX2 =
            sin(radians(prevAngleY + phaseX)) * distortionX * varAmplX;
          const bendX3 = sin(radians(angleY + phaseX)) * distortionX * varAmplX;
          const bendX4 =
            sin(radians(angleY + prevPhaseX)) * distortionX * varPrevAmplX;

          const x1 = prevX + bendX1;
          const x2 = x + bendX2;
          const x3 = x + bendX3;
          const x4 = prevX + bendX4;

          const y1 = prevY + bendX1 / 3;
          const y2 = prevY + bendX2 / 3;
          const y3 = y + bendX3 / 3 - distortionY / 5;
          const y4 = y + bendX4 / 3;

          const h = cos(radians(angleY * 30 - x * 4)) * 10 + 40;

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
  if (key == ' ') {
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
      '-palha.png';
    save(fileName);
  }
}
