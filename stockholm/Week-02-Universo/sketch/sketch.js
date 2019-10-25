let buffer;

let lastPressed = 0;

let palette = ["#88498F", "#779FA1", "#E0CBA8", "#FF6542", "#564154"];

let subdivisions = [];
let phi = (1 + Math.sqrt(5)) / 2;
let moves_x;
let moves_y;
let margin;

function setup() {
  let size = 1000;

  buffer = createGraphics(4 * size, (4 * size) / phi);
  buffer.imageMode(CENTER);

  let margin_pct = 0.03;

  createCanvas(size, size / phi);

  let iterations = 14;
  subdivisions = [];
  margin = new p5.Vector(buffer.width * margin_pct, buffer.height * margin_pct);

  let h = buffer.height * (1 - 2 * margin_pct);

  //the directions in which the subdivisions of the golden
  //rectangle "move". See README.MD
  moves_x = [0, +1 * phi, phi - 1, -1];
  moves_y = [-1, 0, 1 * phi, 1 / phi];

  let x = 0,
    y = h;
  for (let i = 0; i < iterations; i++) {
    y += h * moves_y[i % 4];
    x += h * moves_x[i % 4];
    subdivisions[i] = new Subdivision(x + h / 2, y + h / 2, h);
    h /= phi;
  }
}

function drawGoldenRectangle() {
  buffer.push();
  buffer.translate(margin.x, margin.y);
  buffer.rectMode(CENTER);
  buffer.strokeWeight(8);
  for (let i = 0, l = subdivisions.length; i < l; i++) {
    let g = subdivisions[i];
    buffer.rect(g.pos.x, g.pos.y, g.side, g.side);
  }
  buffer.rectMode(CORNER);
  buffer.pop();
}

function drawUniverse() {
  let l = 35;
  for (let r of subdivisions) {
    buffer.push();
    buffer.noStroke();
    buffer.translate(
      margin.x + r.pos.x - r.side / 2,
      margin.y + r.pos.y - r.side / 2
    );
    let x,
      y = 0;
    let x_n = r.side / l;

    if (l <= 0) break;
    for (let i = 0; i <= pow(r.side / l, 2); i++) {
      x = (i % l) * x_n;
      y = Math.floor(i / l) * x_n;
      if (y + l / 2 >= r.side || x + l >= r.side) break;
      buffer.push();
      buffer.translate(x + l / 2, y);

      buffer.fill(color(palette[int(random(palette.length))]));
      buffer.rotate(noise(x, y) * HALF_PI);

      let whichShape = random(1.0);
      if (whichShape < 0.33)
        buffer.triangle(0, 0, x_n * 0.75, 0, (x_n * 0.75) / 2, x_n * 0.75);
      else if (whichShape < 0.66) buffer.ellipse(0, 0, x_n * 0.75, x_n * 0.75);
      else buffer.rect(0, 0, x_n * 0.75, x_n * 0.75);
      buffer.pop();
    }
    l = floor(l * 0.8);
    buffer.pop();
  }
}

function draw() {
  buffer.ellipseMode(CORNER);
  buffer.background(255);

  //uncomment to see the subdivisions of the  golden rectangle
  drawGoldenRectangle();
  drawUniverse();

  image(buffer, 0, 0, width, height);
  noLoop();
}

function keyPressed() {
  if (key == "S" || key == "s") {
    buffer.save(String.format("universe_%d.tiff", frameCount));
    console.debug("Composition saved!");
  }
}
