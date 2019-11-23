/*
 * @name Noise2D
 * @frame 710,400 (optional)
 * @description Create a 2D noise with different parameters.
 *
 */

let noiseScale = 0.02;
let canvas;

function setup() {
  canvas = createCanvas(940, 580);
  noLoop();
}

function draw() {
  background(255);
  noStroke();
  const stepX = width/20;
  const stepY = height/2;
  for (let y = 0; y < height; y+=stepY) {
    for (let x = 0; x < width; x+=stepX) {
      // noiseDetail of the pixels octave count and falloff value
      noiseDetail(2, 0.8);
      const noiseVal = noise(x * noiseScale, y * noiseScale);
      
      if(y >= height/2){
        fill(0, noiseVal * 255, 155 - noiseVal * 100);
        //rect(x, y, stepX, noiseVal*stepY);
      } else {
        fill(noiseVal * 255, 0, 155 - noiseVal * 100);
        //rect(x, y + height/2 - noiseVal*stepY, stepX, noiseVal*stepY);
      }
      
      rect(x, y, stepX, stepY);
    }
  }
}
