function setup() {
  createCanvas(920, 580);
  noLoop();
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);
}

function draw() {
  background(60, 30, 100);
  // background(0,0,0);

  for (let i = 0; i < width; i++) {
    const h = map(i, 0, width, 0, 40);
    const s = map(i, 0, width, 0, 100);

    stroke(h, s, 100);
    line(i, 0, i, height);
  }

  noStroke();

  blendMode(MULTIPLY);
  bg(0, height / 2, width, height / 2, true);
  bg(0, height / 2, width, -height / 2, true);

  blendMode(ADD);
  xenakis(0, height / 2, width, height / 2, true);
  xenakis(0, height / 2, width, -height / 2, true);

  // save("saved-png/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-time.png");
}

function xenakis(startX, startY, sizeX, sizeY, blend) {
  const incr = width / 20;

  for (let x = startX; x <= sizeX + startX; x += incr) {
    const mapX = map(x - startX, incr, sizeX, 0, sizeY);
    const y = sizeY + startY - mapX;
    const hue = map(x - startX, incr, sizeX, 30, 50);

    // fill(hue, 49, 96);
    fill(hue, 40, 8);

    beginShape();
    vertex(startX, y);
    vertex(x, startY);
    vertex(startX, startY);
    endShape(CLOSE);
  }
}

function bg(startX, startY, sizeX, sizeY, blend) {
  const incr = width / 40;

  for (let x = startX; x <= sizeX + startX; x += incr) {
    const mapX = map(x - startX, incr, sizeX, 0, sizeY);
    const y = sizeY + startY - mapX;
    const hue = map(x - startX, incr, sizeX, 340, 260);

    fill(hue, 30, 97);

    beginShape();
    vertex(startX, startY);
    vertex(x, startY);
    vertex(x * 1.5, y + sizeY);
    vertex(startX, y);
    endShape(CLOSE);
  }
}
