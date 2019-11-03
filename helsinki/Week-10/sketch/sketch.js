let stepX;
let stepY;
let halfStepX;
let halfStepY;
let quarterStepX;
let quarterStepY;
let lastY;

let padding;

function setup() {
  createCanvas(920, 580);
  noLoop();
  colorMode(HSB, 360, 100, 100, 100);
  padding = width / 30;

  stepX = width / 30;
  stepY = height / 60;
  halfStepX = stepX / 2;
  halfStepY = stepY / 2;
  quarterStepX = stepX / 4;
  quarterStepY = stepY / 4;

  lastY = height - padding * 2 + stepY;
}

function draw() {
  repeatSky();
  landscape();
}

function landscape() {
  for (let i = 0; i < 6; i++) {
    const freq = random(5, 10);
    const ampl = random(height / 10, height / 2);
    waves(freq, ampl);
  }
}

function waves(freq, ampl) {
  noFill();
  stroke(200, 90, 20, 60);
  beginShape();
  for (let x = width - padding; x > padding; x -= 1) {
    const angleY = sin(radians(map(x, 0, width, 0, 360 * freq) + 180));
    const angleY2 = sin(radians(map(x, 0, width, 0, 360 / 2) + 30));
    const angleY3 = sin(radians(map(x, 0, width, 180, 360) + 30));

    // angleY3 to the [odd number] will make the wave go up
    // large numbers make the spike narrow
    const y =
      (angleY * pow(angleY2, 3) * height) / 20 +
      pow(angleY3, 301) * ampl +
      height -
      padding -
      stepY;
    vertex(x, y);
  }
  endShape();
}

function repeatSky() {
  background(0, 0, 100);
  noStroke();
  for (let i = 0; i < 10; i++) {
    sky();
  }
}

function sky() {
  for (let x = padding; x < width - padding * 2; x += stepX) {
    for (let y = padding; y < height - padding * 2; y += stepY) {
      const angle = radians(20);
      const angleRadians = random(-angle, angle);
      const offsetX = random(-halfStepX, halfStepX);
      const offsetY = random(-halfStepY, halfStepY);
      const offsetW = random(quarterStepX);
      const offsetH = random(quarterStepY);

      const hueOffset = random(-10, 10);
      const brightnessOffset = random(-5, 5);

      const hue = map(y, 0, height, 220, 170) + hueOffset;
      const saturation = map(y, 0, height, 40, 20);
      const brightness = map(y, 0, height, 60, 90) + brightnessOffset;

      push();
      fill(hue, saturation, brightness, 50);
      translate(x - halfStepX + offsetX, y - halfStepY + offsetY);
      rotate(angleRadians);
      rect(
          halfStepX + quarterStepX,
          halfStepY + quarterStepX,
          stepX + offsetW,
          stepY + offsetH,
      );
      pop();
    }
  }
}

function keyPressed() {
  if (key == 's') {
    save(
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
        '-autumn.png',
    );
  }
}
