let img;
let points = [];

let w = 500;
let h = 500;

let canvas;

class P {
  constructor() {
    this.v = new p5.Vector();
    this.pos;
    this.pStroke;
  }
  update() {
    this.pos.add(this.v);
  }
  draw() {
    stroke(this.pStroke);
    point(this.pos.x, this.pos.y);
  }
}

function preload() {
  img = loadImage("../data/IMG_0133_s.JPG");
}

function setup() {
  createCanvas(w, h);
  colorMode(RGB);
  background(0);

  img.resize(w, h);
  img.loadPixels();
  console.debug("Pixels: " + img.pixels.length);

  points = [];
  let x, y;
  let x1, y1;
  let l = img.pixels.length;
  let dir = new p5.Vector();
  for (let i = 0; i < l; i += 4) {
    let p = new P();
    x = Math.floor(i / 4) % w;
    y = Math.floor(i / 4 / w);
    p.pos = new p5.Vector(x, y);

    // this is equivalent to
    //p.pStroke = [img.pixels[i],img.pixels[i+1],img.pixels[i+2]] ;
    let slice = img.pixels.slice(i, i + 3);
    p.pStroke = [slice[0], slice[1], slice[2]];

    p.v = new p5.Vector(h / 2 + noise(x, y) * 2, w / 2 + +noise(x, y) * 2);
    p.v.sub(p.pos);
    p.v.normalize();
    points.push(p);

    let near = [];
    let minDiff = 1000;
    let pixelColor = [];
    dir.x = 0;
    dir.y = 0;

    let huePoint = hue(p.pStroke);
    
    for (let m = -1; m <= 1; m++) {
      for (let n = -1; n <= 1; n++) {
        x1 = x + m * 4;
        y1 = y + n * 4;
        let ix2 = x1 + y1 * h;
        if (x1 < 0 || y1 < 0 || ix2 < 0 || ix2 >= l) continue;

        pixelColor = img.pixels.slice(ix2, ix2 + 3);

        let hueImage = hue([pixelColor[0], pixelColor[1], pixelColor[2]]);
        if (hueImage < 3) continue;
        let j = m + 2 + (n + 2) * 5;
        near[j] = abs(hueImage - huePoint);
        if (near[j] < minDiff) {
          minDiff = near[j];
          ixMinDiff = ix2;
          dir.x = m;
          dir.y = n;
        }
      }
    }

    dir.normalize();
    p.v.add(dir);

  }
}
let maxi = 0;

function draw() {
  background(255);

  let x0 = (width - w) / 2;
  let y0 = (height - h) / 2;

  translate(x0, y0);
  for (let p of points) {
    p.update();
    p.draw();
  }
  let i = frameCount;
  let p = points[i];
  let near = [];
  let minDiff = 1000;
  let dir = new p5.Vector();
  for (let m = -2; m <= 2; m++) {
    for (let n = -2; n <= 2; n++) {
      let x1 = int(p.pos.x) + m;
      let y1 = int(p.pos.y) + n;
      let ix2 = x1 + y1 * h;
      if (x1 < 0 || y1 < 0 || ix2 >= img.pixels.length) continue;

      let j = m + 2 + (n + 2) * 5;
      let pixelColor = [
        img.pixels[ix2],
        img.pixels[ix2 + 1],
        img.pixels[ix2 + 2]
      ];
      near[j] = abs(hue(pixelColor) - hue(p.pStroke));
      if (near[j] < minDiff) {
        minDiff = near[j];
        dir = new p5.Vector(m, n);
        dir.normalize();
      }
    }
  }
  p.v.add(dir);

  if (i >= points.length) noLoop();
}
