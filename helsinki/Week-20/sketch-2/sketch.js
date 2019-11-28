const pointsPerSegment = 9;
let tileSize;
let stepX;
let stepY;
let points = [];
let corners = [[]];
let showPoints = true;

function setup() {
  createCanvas(940, 580);
  stepX = width/pointsPerSegment/4;
  stepY = width/pointsPerSegment/4;
  tileSize = stepX * pointsPerSegment;
  // noLoop();
  noStroke();

  corners = [...Array(4)].map( (corner, cornerIndex) => {
    return [...Array(pointsPerSegment)].map((point, index) => {
      const {x, y} = calculatePoints(cornerIndex, index);
      return {x, y, dragging: -1};
    });
  });  
}

function draw() {
  background(200,200,200);

  let j = 0;
  for (let y = -tileSize + stepX; y < height; y += tileSize - stepY) {
    let i = 0;
    for (let x = -tileSize + stepX; x < width; x += tileSize - stepX) {
      c = (i + j) % 2 === 0 ? 255 : 0;
      fill(c);
      drawCell(x, y);
      i++;
    }
    j++;
  }
  
  if (showPoints) {
    fill(255, 0, 0);
    corners[0].map( point => {
      ellipse(point.x, point.y, 10, 10);
    });
  }
}

function drawCell(x, y){
  beginShape();
  corners.map( corner => {
    corner.map( v => {
      vertex(v.x + x, v.y + y);
    })
  });
  endShape();
}

function mousePressed() {
  let index = -1;
  corners = corners.map( (corner, cornerIndex) => {
    return corner.map( (p, i) => {
      const isMouseOver = cornerIndex === 0 & mouseX >= p.x - 5 && mouseX <= p.x + 5 && mouseY >= p.y - 5 && mouseY <= p.y + 5;
      if (isMouseOver) {
        index = i;
      }
      
      return isMouseOver ? {...p, dragging: i} : p;
    });
  });

  corners = corners.map( corner => {
    return corner.map( (p, i) =>
      i === index ? {...p, dragging: i} : p
    );
  });
}

function keyPressed() {
  if (key === ' ') {
    showPoints = !showPoints;    
  }  
}

function mouseReleased() {
  corners = corners.map( corner => {
    return corner.map( p => ({...p, dragging: -1}));
  })
}

function mouseDragged() {
  cornersMod = corners.map( (corner, cornerIndex) => {
    return corner.map( (p, index) => {
      const cap = Math.floor(pointsPerSegment/2);
      let x = 0;
      let y = 0;
      switch (cornerIndex) {
        case 0:
          x = p.x + (mouseX - pmouseX);
          y = p.y + (mouseY - pmouseY);
          break;
        case 1:
          x = index < cap ? p.x + (mouseX - pmouseX) : p.x - (mouseX - pmouseX);
          y = index < cap ? p.y + (mouseY - pmouseY) : p.y - (mouseY - pmouseY);
          break;
        case 2:
          x = index < cap ? p.x + (mouseX - pmouseX) : p.x - (mouseX - pmouseX);
          y = index < cap ? p.y - (mouseY - pmouseY) : p.y - (mouseY - pmouseY);
          break;
        case 3:
          x = index < cap ? p.x + (mouseX - pmouseX) : p.x + (mouseX - pmouseX);
          y = index < cap ? p.y - (mouseY - pmouseY) : p.y + (mouseY - pmouseY);
          break;
        default:
          break;
      }

      return p.dragging >= 0 ? {...p, x, y} : p
    });
  });

  corners = cornersMod;
}

function calculatePoints(cornerIndex, index, startX, startY) {
  startX = 0;
  startY = 0;
  const reverseIndex = pointsPerSegment - index - 1;
  const cap = Math.floor(pointsPerSegment/2);
  const offsetX = (tileSize-stepX)/2;
  const offsetY = (tileSize-stepY)/2;
  let x, y;
  switch (cornerIndex) {
    case 0:
      x = Math.min(index, cap) * stepX + startX + offsetX;
      y = Math.max(index, cap) * stepY + startY - offsetY;
      break;
    case 1:
      x = Math.min(index, cap) * stepX + startX + offsetX;
      y = Math.min(reverseIndex, cap) * stepY + startY + offsetY;
      break;
    case 2:
      x = Math.max(reverseIndex, cap) * stepX + startX - offsetX;
      y = Math.min(reverseIndex, cap) * stepY + startY + offsetY;
      break;
    case 3:
      x = Math.max(reverseIndex, cap) * stepX + startX - offsetX;
      y = Math.max(index, cap) * stepY + startY - offsetY;
      break;
    default:
      break;
  }
  return {x, y};
}
