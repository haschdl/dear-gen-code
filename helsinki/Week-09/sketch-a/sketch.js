let pantanal;
let bandHeight;

function preload() {
  pantanal = loadImage('data/pantanal.jpg');
}

function setup() {
  createCanvas(pantanal.width, pantanal.height);
  pantanal.loadPixels();
  bandHeight = height / 20;
  noLoop();
}

function draw() {
  background(0, 0, 0);
  for (let y = 0; y < height - bandHeight; y += bandHeight) {
    drawBand(y);
  }
}

function drawBand(y) {
  for (let x = 0; x < width; x++) {
    let sat = 0;
    let br = 0;
    let rowColor = color(0);
    for (let bandY = y; bandY < y + bandHeight-1; bandY++) {
      const ix = 4*int(bandY * width + x);
      const pixelColor = color(...pantanal.pixels.slice(ix, ix + 3));
      const pixelSaturation = saturation(pixelColor);
      const pixelBrightness = brightness(pixelColor);
      if (
        pixelSaturation > sat &&
        pixelBrightness > br &&
        pixelBrightness > 10
      ) {
        // if(pixelSaturation > sat || pixelBrightness > br){
        sat = pixelSaturation;
        br = pixelBrightness;
        rowColor = pixelColor;
      }
    }
    stroke(rowColor);
    strokeWeight(2);

    const lineHeight = map(br, 0, 100, 0, bandHeight / 2);

    const r1 = (height - y + bandHeight / 2 - lineHeight) / 2 - bandHeight / 2;
    const r2 = (height - y + bandHeight / 2 + lineHeight) / 2 - bandHeight / 2;
    // let r1 = (height - y - lineHeight*2) - bandHeight/2;
    // let r2 = (height - y + lineHeight*2) - bandHeight/2;
    // let r1 = (height - y)/2 - bandHeight/2;
    // let r2 = (height - y + bandHeight)/2 - bandHeight/2;

    const angle = map(x, 0, width, 0, 180);
    const x1 = cos(radians(angle)) * r1 + width / 2;
    const y1 = sin(radians(angle)) * r1 + height / 2;
    const x2 = cos(radians(angle)) * r2 + width / 2;
    const y2 = sin(radians(angle)) * r2 + height / 2;
    line(x1, y1, x2, y2);

    const angle2 = map(x, 0, width, 360, 180);
    const x3 = cos(radians(angle2)) * r1 + width / 2;
    const y3 = sin(radians(angle2)) * r1 + height / 2;
    const x4 = cos(radians(angle2)) * r2 + width / 2;
    const y4 = sin(radians(angle2)) * r2 + height / 2;
    line(x3, y3, x4, y4);
  }
}
