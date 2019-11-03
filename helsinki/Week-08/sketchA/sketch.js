function setup() {
  createCanvas(920, 580, WEBGL);
  noLoop();
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  ellipseMode(CENTER);
}

function draw() {
  background(240, 50, 40);
  fill(0, 0, 100);
  translate(-width/2, -height/2);
  ellipse(width / 2 + width / 8, height / 2, width / 9, width / 9);

  // drawArcs(.53);
  drawArcs(0.12);

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
    '-telhado.pdf';
  save(fileName);
}

function drawArcs(incr) {
  const init = 14;
  for (let i = init; i > 0; i -= incr) {
    const offset = map(i, incr, init, 0, width / 8);
    const waveFactor = map(i, incr, init, 0, 360);
    const h = map(i, incr, init, 180, 360 + 60) % 360;
    drawArc(width / i, width / 2 + offset, h, waveFactor);
  }
}

function drawArc(radiusSmall, centerX, h, waveFactor) {
  const radiusBig = radiusSmall * 1.2;
  const radiusBigger = radiusSmall * 1.5;
  const step = 360 / 60;
  const centerY = height / 2;
  const wave = cos(radians(waveFactor + 135)) * 30;
  // wave = 0;
  const startAngle = int(wave);
  const endAngle = int(180 - wave);

  for (let i = startAngle; i <= endAngle; i += step) {
    const randomFactor = random(0.95, 1.05);

    const x1 = cos(radians(i)) * radiusSmall + centerX;
    const y1 = sin(radians(i)) * radiusSmall + centerY;

    const i2 = map(i, startAngle, endAngle, startAngle - 5, endAngle + 5);
    const x2 = cos(radians(i2)) * radiusBig * randomFactor + centerX;
    const y2 = sin(radians(i2)) * radiusBig * randomFactor + centerY;

    const i3 = map(i, startAngle, endAngle, startAngle - 30, endAngle + 30);
    const x3 = cos(radians(i3)) * radiusBigger + centerX;
    const y3 = sin(radians(i3)) * radiusBigger + centerY;

    const x4 = cos(radians(i)) * (radiusSmall * 0.99) + centerX;
    const y4 = sin(radians(i)) * (radiusSmall * 0.99) + centerY;

    const s = map(radiusSmall, 0, height, 40, 80);
    const b = map(radiusSmall, 0, height, 150, 0);
    const b2 = map(radiusSmall, 0, height, 60, 0);

    // Alternate blend mode for each triangle
    // if(i % (step*2) == 0){
    //  blendMode(ADD);
    // } else {
    //  blendMode(NORMAL);
    // }

    blendMode(BLEND);
    fill(h, s, b);
    beginShape();
    vertex(x1, y1);
    vertex(x2, y2);
    fill(h, s, b2);
    vertex(x3, y3);
    endShape(CLOSE);

    blendMode(ADD);
    fill(h, s, b);
    beginShape();
    vertex(x1, y1);
    vertex(x4, y4);
    fill(h, s, b2);
    vertex(x3, y3);
    endShape(CLOSE);
  }
}
