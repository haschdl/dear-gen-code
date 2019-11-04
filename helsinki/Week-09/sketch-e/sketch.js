let pantanal;
let bandHeight;

function preload() {
  pantanal = loadImage('data/pantanal.jpg');
}

function setup() {
  createCanvas(pantanal.width, pantanal.height);
  bandHeight = int(height / 10);
  pantanal.loadPixels();
}

function draw() {
  background(0, 0, 0);

  for (let y = 0; y < height - bandHeight; y += bandHeight) {
    drawBand(y);
  }

  save(
    'saved-png/' +
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
      '-pantanal.png'
  );
  noLoop();
}

function drawBand(y) {
  for (let x = 0; x < width; x++) {
    let sat = 0;
    let br = 0;
    let rowColor = 0;
    for (let bandY = y; bandY < y + bandHeight; bandY++) {
      const ix = 4 * int(bandY * width + x);
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
    const lineHeight = map(br, 0, 100, 0, bandHeight / 2);
    const padding = bandHeight / 4;
    // line(x, y + bandHeight/2 - lineHeight, x, y + bandHeight/2 + lineHeight);
    line(
      x,
      y + bandHeight / 2 - lineHeight + padding / 2,
      x,
      y + bandHeight / 2 + lineHeight - padding / 2
    );
    // line(x, y - lineHeight, x, y + bandHeight);
  }
}
