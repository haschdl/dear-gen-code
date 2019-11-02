/*
 *
 * Keyboard commands:
 *   S - saves the sketch to a JPG image, as shown in the screen.
 *      Image resolution is the sketch size
 *   F - saves the Final image, for printing. Re
 *
 */

// let palette = [  "#780116, "#F7B538, "#DB7C26, "#D8572A, "#C32F27 ];
const palette = ['#7c0034', '#f02d57', '#0b1240', '#343c9f'];
const vs = [];
let flowField;
let buffer;
const p = {};

function setup() {
  createCanvas(1200, 800);
  p.maxspeed = 0.2;
  p.maxforce = 1;
  p.maxframes = 250;
  p.opacity = 80;
  p.n = 300;
  p.res = 20;

  console.dir(p);
  buffer = createGraphics(1800, 1200);

  // making a matrix with p.n elements
  const ratio = buffer.width / buffer.height;

  const cols = int(sqrt(p.n * ratio));
  const rows = int(sqrt(p.n * ratio) / ratio);
  const xo = buffer.width / cols;
  const yo = buffer.height / rows;

  console.log(`Cols: ${cols} Rows: ${rows}`);

  for (let x = 0; x < buffer.width; x += xo) {
    for (let y = 0; y < buffer.height; y += yo) {
      vs.push(new Vehicle(x, y, p.maxspeed, p.maxforce, p.opacity));
    }
  }

  flowField = new FlowField(p.res);
  background(255);
  buffer.background(255);
}

function draw() {
  for (const v of vs) {
    v.seek(new p5.Vector(v.loc.x, buffer.height *100));
    v.follow(flowField);
    v.update();
    v.display(buffer);
  }
  // shows the content of the buffer in the screen
  image(buffer, 0, 0, width, height);

  // flowField.display();
  if (frameCount == p.maxframes) {
    fill(0);
    text(JSON.stringify(p), 10, 10);
    noLoop();
    console.log(`Stopped at ${frameCount} frames`);
  }
}
