/**
 * [master f36b716]: Basic drawing with circles
 * [master fbc4f8a]: Random positions
 * Inspiration for flower equation: http://mathworld.wolfram.com/CannabisCurve.html
 *
 */

let buffer;

const PARAMS = Object.freeze({
  r0: 60,
  noise_f: 1.0,
  resolution: 200,
  iterations: 203
});

function setup() {
  createCanvas(900, 600);
  buffer = createGraphics(1500, 1000);
  buffer.background(255);

  noStroke();
}

//Autumn colors from picture: https://coolors.co/a4ae99-d9bca1-913641-9e8bb3-c6a74a
let palette = [
  "#CF8840",
  "#8D2538",
  "#6C3C25",
  "#FEAE5D",
  "#BB4D1A",
  "#BF4342",
  "#8C1C13",
  "#EB803C",
  "#CD7B31"
];

function draw() {
  //buffer.strokeWeight(2);
  buffer.noStroke();
  buffer.push();
  buffer.translate(0, -0.5 * PARAMS.r0);

  let n_x = buffer.width / PARAMS.r0;
  let x = (frameCount % n_x) * PARAMS.r0 * 1.5;
  let y =
    ((frameCount % PARAMS.iterations) / int(n_x)) *
    PARAMS.r0 *
    (2 + noise(frameCount));

  //rotating a little bit every frame.
  //cosine is just make "angle" alternate between positive and negative numbers
  let angle = cos(frameCount * PI) * random(0.15 * PI);

  //a larger e makes the leafs bigger, and less detailed.
  let e = int(random(3, 5)); //int(map(y, 0, height, 1, 5));
  let alpha = 0.8; //map(y, 0, height, 5, 240);

  //alternating colors according to frame count
  //this produced a more distributed color palette
  let fillCol = palette[frameCount % palette.length];

  buffer.translate(x, y);
  buffer.rotate(angle);

  leaf(e, fillCol, alpha);
  buffer.pop();
  image(buffer, 0, 0, width, height);
  if (frameCount % PARAMS.iterations == 0) {
    saveBuffer();
    buffer.background(255);
    noLoop();
  }
}

function leaf(e, fillCol, alpha) {
  let points = polygon(PARAMS.r0, PARAMS.resolution, e);
  buffer.fill(hex2rgba(fillCol, alpha));
  buffer.beginShape();
  for (let p of points) buffer.curveVertex(p.x, p.y);
  buffer.endShape(CLOSE);
}

function polygon(radius, resolution, e) {
  //e: eccentricity of the ellipse
  let step = TWO_PI / resolution;
  let points = [];
  let theta = 0;
  let a = 1;
  let b = 0.162;
  let c = 0.13;
  let d = 27.54;

  for (let i = 0; i <= resolution; i++) {
    let r =
      radius *
      a *
      (1 + b * cos(8 * theta)) *
      (e + c * cos(24 * theta)) *
      (0.2 + 0.1 * cos(0 * theta)) *
      (1 + sin(theta));
    let sx = +cos(theta) * r;
    let sy = -sin(theta) * r;
    theta += step;
    points.push(new p5.Vector(sx, sy));
  }
  return points;
}
const hex2rgba = (hex, alpha = 1) => {
  const [r, g, b] = hex.match(/\w\w/g).map(x => parseInt(x, 16));
  return `rgba(${r},${g},${b},${alpha})`;
};

function saveBuffer() {
  let date = new Date().toISOString();
  buffer.save(`/out/autumn_${date}.png`);
  console.debug("Composition saved!");
}
