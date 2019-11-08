let img;
let side;
let altitude;

function setup() {
  createCanvas(940, 580, WEBGL);
  img = loadImage('assets/IMG_20160617_224625.jpg');
  side = height/2;
  altitude = (side * sqrt(3))/2;
}


function draw() {
  background(255);

  drawHexagon(0, {x: 0, y: 0,}, true);
}

function drawHexagon(startAngle, center, _odd){
  let odd = false;
  for(let i = startAngle; i < TWO_PI; i += PI / 3){
    if(i > startAngle){
      const imgFraction = 1; //img.height/2.5;
      const x1 = cos(i - PI/3) * side + center.x;
      const y1 = sin(i - PI/3) * side + center.y;
      
      const x2 = cos(i) * side + center.x;
      const y2 = sin(i) * side + center.y;
      
      const tex1 = odd ? {u: imgFraction, v: imgFraction,} : {u: img.width - imgFraction, v: imgFraction,};
      const tex2 = odd ? {u: img.width - imgFraction, v: imgFraction,} : {u: imgFraction, v: imgFraction,};
      
      texture(img);
      beginShape();
      vertex(x1, y1, tex1.u, tex1.v);
      vertex(x2, y2, tex2.u, tex2.v);
      vertex(center.x, center.y, img.width/2, img.height - imgFraction);
      endShape();
      
      odd = !odd;
    }
  }
}
