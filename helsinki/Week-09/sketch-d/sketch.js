let pantanal;
let blockSize;
let bgColor;

function preload() {
  pantanal = loadImage('data/pantanal.jpg');
}

function setup() {
  createCanvas(pantanal.width, pantanal.height);
  pantanal.loadPixels();
  blockSize = int(pantanal.height / 6);
  noLoop();
  noStroke();
  ellipseMode(CORNER);
}

function draw() {
  background(255);

  for (let x = 0; x < width-blockSize; x += blockSize) {
    for (let y = 0; y < height-blockSize; y += blockSize) {
      fill(colorBlock(x, y));
      ellipse(
        x + blockSize * 0.05,
        y + blockSize * 0.05,
        blockSize * 0.9,
        blockSize * 0.9
      );
    }
  }
  noLoop();
}

function colorBlock(x, y) {
  let c = color(0);
  let br = 0;
  let sat = 0;
  for (let blockY = y; blockY < y + blockSize - 1; blockY++) {
    for (let blockX = x; blockX < x + blockSize - 1; blockX++) {
      const ix = 4 * int(blockY * width + blockX);
      const pixelColor = color(...pantanal.pixels.slice(ix, ix + 4));
      const pixelBrightness = brightness(pixelColor);
      const pixelSaturation = saturation(pixelColor);
      if (
        pixelBrightness > br &&
        pixelSaturation > sat &&
        pixelBrightness > 20
      ) {
        br = pixelBrightness;
        sat = pixelSaturation;
        c = pixelColor;
      }
      // c = pantanal.pixels[blockY*width+blockX];
    }
  }
  return c;
}
