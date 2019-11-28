const pointsPerSegment = 41;
let tileSize;
let stepX;
let stepY;

function setup() {
  createCanvas(940, 580);
  // stepX = parseInt(width/pointsPerSegment/4);
  // stepY = parseInt(width/pointsPerSegment/4);
  stepX = width/pointsPerSegment/4;
  stepY = width/pointsPerSegment/4;
  tileSize = stepX * pointsPerSegment;
  noLoop();
  noStroke();
}

function draw() {
  background(200,200,200);
  // stroke(255,0,0);

  // fill(0);
  // drawPattern(width/2 - tileSize/2, height/2 - tileSize/2);
  // fill(255);
  // drawPattern(width/2 + tileSize/2 - stepX, height/2 - tileSize/2);
  
  let j = 0;
  for (let y = 0; y < height; y+=tileSize - stepY) {
    let i = 0;
    for (let x = 0; x < width; x+=tileSize - stepX) {
      const c = ((i+j) % 2) === 0 ? 0 : 255;
      fill(c);
      drawPattern(x, y);
      i++;
    }
    j++;
  }
}

function drawCorner(startX, startY, cornerIndex) {
  // for (let index = 0; index < pointsPerSegment; index++) {
  //   const x = index * stepX + startX;
  //   ellipse(x, height/4, 10, 10);
  // }
  
  for (let index = 0; index < pointsPerSegment; index++) {
    const cap = Math.floor(pointsPerSegment/2);
    const reverseIndex = pointsPerSegment - index - 1;
    // const distortX = map(mouseX, 0, width, -tileSize/2, tileSize/2) * index;
    // const distortY = map(mouseY, 0, height, -tileSize/2, tileSize/2) * index;
    // const distortX = 0;
    // const distortY = 0;
    
    const angle = map(index, 0, pointsPerSegment, 0, TWO_PI);
    const distortX = cos(angle) * stepX;
    const distortY = sin(angle) * stepY;

    const offsetX = (tileSize-stepX)/2;
    const offsetY = (tileSize-stepY)/2;

    let x;
    let y;

    switch (cornerIndex) {
      case 0:
        x = Math.min(index, cap) * stepX + startX + offsetX + distortX;
        y = Math.max(index, cap) * stepY + startY - offsetY + distortY;
        break;
      case 1:
        x = Math.min(index, cap) * stepX + startX + offsetX + distortX;
        y = Math.min(reverseIndex, cap) * stepY + startY + offsetY + distortY;
        break;
      case 2:
        x = Math.max(reverseIndex, cap) * stepX + startX - offsetX + distortX;
        y = Math.min(reverseIndex, cap) * stepY + startY + offsetY + distortY;
        break;
      case 3:
        x = Math.max(reverseIndex, cap) * stepX + startX - offsetX + distortX;
        y = Math.max(index, cap) * stepY + startY - offsetY + distortY;
        break;
      default:
        break;
    }

    vertex(x, y);
    
    // const x1 = Math.min(index, cap) * stepX + startX + offsetX + distortX;
    // const y1 = Math.max(index, cap) * stepY + startY - offsetY + distortY;
    // const x2 = Math.min(index, cap) * stepX + startX + offsetX + distortX;
    // const y2 = Math.min(reverseIndex, cap) * stepY + startY + offsetY + distortY;
    // const x3 = Math.max(reverseIndex, cap) * stepX + startX - offsetX + distortX;
    // const y3 = Math.min(reverseIndex, cap) * stepY + startY + offsetY + distortY;
    // const x4 = Math.max(reverseIndex, cap) * stepX + startX - offsetX + distortX;
    // const y4 = Math.max(index, cap) * stepY + startY - offsetY + distortY;

    // const t = index + ', ' + reverseIndex;
    // const c = map(index, 0, pointsPerSegment, 0, 255);
    // fill(c,0,0);
    // text(t, x1, y1);
    // text(t, x2, y2);
    // text(t, x3, y3);
    // text(t, x4, y4);
    
    // const c = map(index, 0, pointsPerSegment, 0, 255);
    // fill(c,0,0);
    // ellipse(x1, y1, 15, 15);
    // fill(0,c,0);
    // ellipse(x2, y2, 15, 15);
    // fill(0,0,c);
    // ellipse(x3, y3, 15, 15);
    // fill(0,c,c);
    // ellipse(x4, y4, 15, 15);
  }
}

function drawPattern(startX, startY){
  // fill(0);
  beginShape();
  drawCorner(startX, startY, 0);
  drawCorner(startX, startY, 1);
  drawCorner(startX, startY, 2);
  drawCorner(startX, startY, 3);
  endShape();
}