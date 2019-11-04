let img;
const incrX = 0.005;
const incrY = 0.005;
const powerY = 30;
const distort = 20;
const deform = 20;

function preload() {
  img = loadImage('data/IMG_20160617_224625.jpg');
}

function setup() {
  createCanvas(img.width, img.height);
  noLoop();
}

function draw() {
  background(0);
  drawWave();
  drawWave2();
}

function drawWave() {
  for (let j = 0; j < 1 + incrY; j += incrY) {
    for (let i = 0; i < 1 + incrX; i += incrX) {
      const powerX1 = pow(j - incrY, distort) * deform;
      const x1 = pow(i - incrX, powerX1) * width;
      const ang1 = map(x1, 0, width, PI, TWO_PI);

      const powerX2 = pow(j - incrY, distort) * deform;
      const x2 = pow(i, powerX2) * width;
      const ang2 = map(x2, 0, width, PI, TWO_PI);

      const powerX3 = pow(j, distort) * deform;
      const x3 = pow(i, powerX3) * width;
      const ang3 = map(x3, 0, width, PI, TWO_PI);

      const powerX4 = pow(j, distort) * deform;
      const x4 = pow(i - incrX, powerX4) * width;
      const ang4 = map(x4, 0, width, PI, TWO_PI);

      const varY1 = pow(j - incrY, powerY) * height;
      const y1 = (cos(ang1) / 2 + 0.5) * varY1;

      const varY2 = pow(j - incrY, powerY) * height;
      const y2 = (cos(ang2) / 2 + 0.5) * varY2;

      const varY3 = pow(j, powerY) * height;
      const y3 = (cos(ang3) / 2 + 0.5) * varY3;

      const varY4 = pow(j, powerY) * height;
      const y4 = (cos(ang4) / 2 + 0.5) * varY4;

      const c = img.get(int(x1), int(y1));
      fill(c);
      stroke(c);
      beginShape();
      vertex(x1, y1);
      vertex(x2, y2);
      vertex(x3, y3);
      vertex(x4, y4);
      endShape(CLOSE);
    }
  }
}

function drawWave2() {
  for (let j = 0; j < 1 + incrY; j += incrY) {
    for (let i = 0; i < 1 + incrX; i += incrX) {
      if (i > 0 && j > 0) {
        const powerX1 = pow(j - incrY, distort) * deform;
        const x1 = pow(i - incrX, powerX1) * width;
        const ang1 = map(x1, 0, width, 0, PI);

        const powerX2 = pow(j - incrY, distort) * deform;
        const x2 = pow(i, powerX2) * width;
        const ang2 = map(x2, 0, width, 0, PI);

        const powerX3 = pow(j, distort) * deform;
        const x3 = pow(i, powerX3) * width;
        const ang3 = map(x3, 0, width, 0, PI);

        const powerX4 = pow(j, distort) * deform;
        const x4 = pow(i - incrX, powerX4) * width;
        const ang4 = map(x4, 0, width, 0, PI);

        const varY1 = pow(j - incrY, powerY) * height;
        const y1 = height - (cos(ang1) / 2 + 0.5) * varY1;

        const varY2 = pow(j - incrY, powerY) * height;
        const y2 = height - (cos(ang2) / 2 + 0.5) * varY2;

        const varY3 = pow(j, powerY) * height;
        const y3 = height - (cos(ang3) / 2 + 0.5) * varY3;

        const varY4 = pow(j, powerY) * height;
        const y4 = height - (cos(ang4) / 2 + 0.5) * varY4;

        const c = img.get(int(x1), int(y1));
        fill(c);
        stroke(c);
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
