function setup() {
  createCanvas(920, 580);
  noLoop();
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  noFill();
  ellipseMode(CENTER);
}

function draw() {
  background(240, 50, 40);

  drawBackground();

  // fill(0, 0, 100);
  // ellipse(width - width/3, height/2, width/8, width/8);

  // drawArcs(180, 360);
  drawArcs(0, 180);
}

function drawBackground() {
  const step = 180 / 23;

  const incr = 15000;

  for (let i = 0; i < incr; i += step) {
    const radius = i / 22;

    const radiusVar = random(0.98, 1.02);

    const x1 = cos(radians(i)) * radius * radiusVar + width - width / 3;
    const y1 = sin(radians(i)) * radius * radiusVar + height / 2;

    const x2 =
      cos(radians(i - step)) * radius * radiusVar * 0.9 + width - width / 3;
    const y2 = sin(radians(i - step)) * radius * radiusVar * 0.9 + height / 2;

    const radiusVar2 = random(0.98, 1.02);

    const x3 = cos(radians(i)) * radius * radiusVar2 * 0.8 + width - width / 3;
    const y3 = sin(radians(i)) * radius * radiusVar2 * 0.8 + height / 2;

    const x4 =
      cos(radians(i - step)) * radius * radiusVar2 * 0.7 + width - width / 3;
    const y4 = sin(radians(i - step)) * radius * radiusVar2 * 0.7 + height / 2;

    // strokeWeight(4);

    const h = map(i, 0, incr, 360 + 45, 180 + 30) % 360;
    const s = map(i, 0, incr, 40, 80);
    const b = map(i, 0, incr, 150, 0);

    stroke(h, s, b);

    if (i > 0) {
      blendMode(NORMAL);
      strokeWeight(constrain(i / 500, 3, 50));
      line(x1, y1, x2, y2);

      const weight = constrain(4 - i / 2000, 0, 4);
      stroke(h, s, b);
      blendMode(ADD);
      strokeWeight(weight);
      line(x3, y3, x4, y4);
    }
  }
}

function drawArcs(start, end) {
  blendMode(NORMAL);
  const step = 180 / 20;

  const incr = 8;
  const init = width / 6;

  for (let i = 0; i < init; i += incr) {
    const startAngle = start + int((sin(radians(i * 2 + 180)) * height) / 30);
    const endAngle = end + int((sin(radians(i * 3)) * height) / 30);

    const centerX =
      width - width / 3 + (sin(radians(i * 2 + 180)) * width) / 20;
    const centerY = height / 2 + pow(i, 0.7);

    const radius = width / 15 + pow(i, 1.3);

    const h = map(i, incr, init, 360 + 45, 180 + 30) % 360;
    const s = map(radius, 0, width, 40, 80);

    const lineLength = width / 30 + i / 6;
    const lineWidth = lineLength / 3 + i / 6;
    strokeWeight(lineWidth);

    const radiusVar = sin(radians(i + 180)) / 2 + 1;

    for (let j = startAngle; j < endAngle / 2; j += step) {
      const angleVar = random(10, 20);

      const x0 = cos(radians(j)) * radius * 0.7 + centerX;
      const y0 = sin(radians(j)) * radius * 0.7 * radiusVar + centerY;

      const x = cos(radians(j)) * radius + centerX - lineLength / 2;
      const y = sin(radians(j)) * radius * radiusVar + centerY;

      const x2 = cos(radians(j - angleVar)) * radius + centerX + lineLength / 2;
      const y2 = sin(radians(j - angleVar)) * radius * radiusVar + centerY;

      const bVar = sin(radians(j)) * 30 - 30;
      const b = map(radius, 0, width, 150, 0) + bVar;

      stroke(h + bVar, s, b);
      line(x, y, x2, y2);
    }

    for (let j = endAngle; j > endAngle / 2; j -= step) {
      const angleVar = random(10, 50);

      const x = cos(radians(j)) * radius + centerX - lineLength / 2;
      const y = sin(radians(j)) * radius * radiusVar + centerY;

      const x2 = cos(radians(j - angleVar)) * radius + centerX + lineLength / 2;
      const y2 = sin(radians(j - angleVar)) * radius * radiusVar + centerY;

      const bVar = sin(radians(j)) * 30 - 30;
      const b = map(radius, 0, width, 150, 0) + bVar;

      stroke(h + bVar, s, b);
      line(x, y, x2, y2);
    }
  }
}
