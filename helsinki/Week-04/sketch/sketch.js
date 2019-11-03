const spacing = 2;

function setup() {
  createCanvas(551, 359);
  noLoop();
}

function draw() {
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
    '-infinitesimal.png';

  background(255);

  generateGrid(true, false);
  generateGrid(false, true);
  generateGrid(false, false);

  save(fileName);
  noLoop();
}

function generateGrid(isBentX, isBentY) {
  for (let x = 0; x < width; x += spacing) {
    for (let y = 0; y < height; y += spacing) {
      const positionXToAngle = map(x, 0, width, 0, 180);
      let offsetX = cos(radians(positionXToAngle)) * spacing;

      const positionYToAngle = map(y, 0, height, 0, 90);
      let offsetY = cos(radians(positionYToAngle + 45)) * spacing;

      if (!isBentX) {
        offsetX = 0;
      }
      if (!isBentY) {
        offsetY = 0;
      }

      noStroke();
      fill(0);
      ellipse(x + offsetX, y + offsetY, 1, 1);
    }
  }
}
