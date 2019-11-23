function setup() {
  createCanvas(940, 580);
  colorMode(HSB, 360, 100, 100, 100);
  noLoop();
}

function draw() {
  noStroke();
  // background(215, 33, 61);
  background(215, 24, 73);
  // background(0,0,100);

  drawBackground();

  // fill(38, 4, 65);
  // rect(0, height/2, width, height/2);
  drawTrees();
}

function drawBackground() {
  const stepX = width/20;
  const stepY = height/40;
  // const stepX = width/10;
  // const stepY = height/20;
  // stroke(0);
  const diag = dist(0, 0, width/2, height/2);

  for (let y = 0; y < height; y+= stepY) {
    for (let x = 0; x < width; x += stepX) {
      const d = dist(x, y, width/2, height/2)/diag;
      const randS = random(-3, 3);
      const randB = random(-3, 3);
      fill(215, d*30 + randS, 100 - d*50 + randB);
      
      push();
      translate(x + random(-stepX/6, stepX/6), y + random(-stepY/6, stepY/6));
      // rotate(PI/20);
      rotate(random(-PI/10, PI/10));
      // translate(stepX, stepY);
      rect(0, 0, stepX*2, stepY*3);
      pop();
    }
  }
}

function drawTrees(){
  const treesPerRow = 10;
  const rows = 12;
  // const treesPerRow = 5;
  // const rows = 5;

  for (var j = 0; j < rows; j++) {
    for (var i = 0; i < treesPerRow; i++) {
      const varX = width/10;
      const randomX = random(-varX, varX);
      const x = map(i, 0, treesPerRow, 0, width + varX) + randomX;
      const y = map(j, 0, rows, height/3, -height/10);
      const h = height - y*2;
      const w = random(width/100, width/60);
      const s = map(j, 0, rows, 20, 50);
      const b = map(j, rows, 0, 5, 40);
      fill(15, s, b);
      // rect(x, 0, w, h);
      // rect(x, y, w, h);
      drawShadow(x, y, w, h, s, b);
      drawTree(x, y, w, h, s, b);
      noStroke();
    }
  }
}

function drawTree(startX, startY, w, h, s, b) {
  const step = height/20;
  const amplitude = random(width/500, width/300);
  const freq = random(0, PI*5);

  stroke(15, s, b);
  for (let y = startY; y < startY + h; y += step) {
    if (y > startY) {
      const prevY = y - step;
      const weight = map(y, startY, startY + h, w/10, w);

      const angle = map(y, startY, startY + h, 0, freq);
      const varX = cos(angle) * amplitude;
      const prevAngle = map(prevY, startY, startY + h, 0, freq);
      const prevVarX = cos(prevAngle) * amplitude;

      strokeWeight(weight);
      line(startX + varX, y, startX + prevVarX, prevY);
    }
  }
}

function drawShadow(startX, startY, w, h, s, b) {
  const step = height/20;
  const amplitude = random(width/500, width/300);
  const freq = random(0, PI*5);

  const startShadow = startY + h - step;
  const endShadow = height + step;

  for (let y = startShadow; y <= endShadow; y += step) {
    if (y >= startY + h) {
      const prevY = y - step;
      const weight = map(y, startY, startY + h, w/10, w);
      
      const bottomX = map(startX, 0, width, -width*2, width*2);
      const distortX = map(y, startShadow, endShadow + h, 0, 1) * bottomX;
      const prevDistortX = map(prevY, startShadow, endShadow + h, 0, 1) * bottomX;
      
      const angle = map(y, startY, startY + h, 0, freq);
      const varX = cos(angle) * amplitude;
      const prevAngle = map(prevY, startY, startY + h, 0, freq);
      const prevVarX = cos(prevAngle) * amplitude;
      
      const thisB = map(y, startShadow, endShadow, 60, 0);
      stroke(215, s, thisB);
      strokeWeight(weight);
      line(startX + varX + distortX, y, startX + prevVarX + prevDistortX, prevY);
    }
  }
}