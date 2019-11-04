let strawWidth = 4;
let strawSeparation = strawWidth*1.8; 
let phaseShift = 120;
let frequency;

function setup() {
  //createCanvas(1200, 900, WEBGL);
  createCanvas(800, 600, WEBGL);
  frequency = width/strawSeparation;

  ortho();
  noFill();
  stroke(0);
  strokeWeight(strawWidth);
  colorMode(HSB, 360, 100, 100);
}

function draw() {
  background(360);
  translate(-width/2, height);
  rotateX(PI);

  for (let i = 0; i < width; i += width/frequency) {
    stroke(
      map(i, 0, width, 45, 60),
      90,
      90
    );
    drawWaves(true, i, i * phaseShift);
    stroke(
      map(i, 0, width, 40, 55),
      80,
      80
    );
    drawWaves(false, i, i * phaseShift);
  }
}

function drawWaves( horizontal, posY, phase) {
  let period = 360;
  let size = horizontal ? width : height;
  beginShape();
  for (let i = 0; i <= period; i += strawSeparation) {
    let bendPhase = i/4;
    let bendRadius = map(i, 0, period*2, -size/6, size/6);
    let bend = cos(radians(i - bendPhase)) * bendRadius;
    
    let x = horizontal ? map(i, 0, period, 0, size) : posY + bend;
    let y = horizontal ? posY + bend : map(i, 0, period, 0, size);
    let z = sin(radians(i * frequency + phase)) * 3;
    vertex(x, y, z);
  }
  endShape();
  
  stroke(0, 100);
  beginShape();
  for (let i = 0; i <= period; i += strawSeparation) {
    let bendPhase = i/4;
    let bendRadius = map(i, 0, period*2, -size/6, size/6);
    let bend = cos(radians(i - bendPhase)) * bendRadius;
    
    let x = horizontal ? map(i, 0, period, 0, size) : posY + bend + 1;
    let y = horizontal ? posY + bend + 1 : map(i, 0, period, 0, size);
    let z = sin(radians(i * frequency + phase)) * 3 + 3;
    vertex(x, y, z);
  }
  endShape();
}
