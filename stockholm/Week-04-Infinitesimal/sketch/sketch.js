let n = 1000.0;
let s = 1.0;
let a = 100;

let buffer;
let w, h, f;

function setup() {
  createCanvas(900, 600);
  buffer = createGraphics(3000, 2000);
  w = buffer.width;
  h = buffer.height;
  f = (1.0 * w) / n;
  buffer.background(255);
  buffer.noStroke();
  background(255);
}

function draw() {
  let c = 80;

  buffer.push();
  buffer.translate(0, h / 2);
  buffer.fill(c, 20);

  for (let i = 0; i < n; i++) {
    let x = f * i;
    let y = Math.tan(a * x + a * x * x) * map(mouseX, 0, width, 1, 100);
    s = 8 + 6 * Math.pow(abs(y / h), 1.2);

    buffer.ellipse(x, y, s, s);
    //adds another element to the drawing
    buffer.ellipse(random() * w, (random() * y) / 2, s, s);
  }
  buffer.pop();
  image(buffer, 0, 0, width, height);
}

function keyPressed() {
  if (key == "S" || key == "s") {
    let date = new Date().toISOString();
    buffer.save(`/out/infinitesimal_${date}_frame_${frameCount}_s_${s}.png`);
    console.debug("Composition saved!");
  }
}
