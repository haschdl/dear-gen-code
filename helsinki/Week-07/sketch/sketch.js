'use strict';

// Collision detection adapted from:
// http://happycoding.io/tutorials/processing/collision-detection

const rectangles = [];
let initW;
let initH;
let isDone = false;
let saveFile = false;
const canvasWidth = 920;
const canvasHeight = 580;

function preload() {
  initW = canvasWidth / 17;
  initH = canvasHeight / 17;

  for (let i = 0; i < canvasWidth; i += initW) {
    for (let j = 0; j < canvasHeight; j += initH) {
      const w = random(initW / 3, initW / 1.5);
      const h = random(initW / 3, initW / 1.5);
      // let randomI = random(-initW/10, initH/10) - w/2;
      // let randomJ = random(-initW/10, initH/10) - h/2;
      const randX = random(0, canvasWidth);
      const randY = random(0, canvasHeight);
      const hue = random(1) > 0.2 ? 6 : 28;

      let path = 'data/roofs';
      let randomIndex = -1;
      if (hue < 10) {
        path = 'data/roofs';
        randomIndex = int(random(1, 6));
      } else {
        path = 'data/greens';
        randomIndex = int(random(1, 7));
      }
      const fileName = path + '/' + randomIndex + '.jpg';
      const img = loadImage(fileName);

      rectangles.push(
          new Rectangle(
          // i + randomI,
          // j + randomJ,
              randX,
              randY,
              w,
              h,
              hue,
              img,
          ),
      );
    }
  }
}

function setup() {
  createCanvas(canvasWidth, canvasHeight);
  noStroke();
  background(255);
}

function draw() {
  if (!isDone) {
    checkDone();
  }

  // iterate over the rectangles
  for (let i = 0; i < rectangles.length; i++) {
    const rectangle = rectangles[i];

    rectangle.prevX = rectangle.x;
    rectangle.prevY = rectangle.y;

    // compare this rectangle (i) with all the others
    for (let j = 0; j < rectangles.length; j++) {
      const rectangle2 = rectangles[j];

      if (i != j) {
        // except with itself
        const checkCollision =
          (rectangle2.x + rectangle2.rectWidth > rectangle.x &&
            rectangle2.x < rectangle.x + rectangle.rectWidth &&
            rectangle2.y + rectangle2.rectHeight > rectangle.y &&
            rectangle2.y < rectangle.y + rectangle.rectHeight) ||
          rectangle.x < -initW ||
          rectangle.x + rectangle.rectWidth > width + initW ||
          rectangle.y < -initH ||
          rectangle.y + rectangle.rectHeight > height + initH;
        if (checkCollision) {
          rectangle.x += random(-initW / 8, initW / 8);
          rectangle.y += random(-initH / 8, initH / 8);
        }
      }
    }

    if (rectangle.prevX == rectangle.x && rectangle.prevY == rectangle.y) {
      rectangle.done = true;
    } else {
      rectangle.done = false;
    }

    drawRect(rectangle);
  }

  if (saveFile) {
    const fileName =
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
      '-telhado.png';
    save(fileName);
    saveFile = false;
  }

  if (isDone) {
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
      '-telhado.png';
    save(fileName);
    noLoop();
  }
}

function checkDone() {
  for (let i = 0; i < rectangles.length; i++) {
    const rectangle = rectangles[i];
    if (!rectangle.done) return false;
  }
  isDone = true;
  return true;
}

function drawRect(rectangle) {
  image(
      rectangle.img,
      rectangle.x,
      rectangle.y,
      rectangle.rectWidth,
      rectangle.rectHeight,
  );
}

function keyPressed() {
  if (key == 's') {
    saveFile = true;
  }
}
