let buffer;

let lastPressed = 0;

int[] palette = new int[]{ #88498F, #779FA1, #E0CBA8, #FF6542, #564154 };

Subdivision[] subdivisions;
let phi = (1 + sqrt(5))/2;
float[] moves_x;
float[] moves_y;
let margin ;

function setup() {
  buffer = createGraphics(6000, 3000);
  buffer.imageMode(CENTER);

  let margin_pct = .03;

  size(1000, 500);


  let iterations = 14;
  subdivisions = new Subdivision[iterations];
  margin = new p5.Vector(buffer.width*margin_pct, buffer.height*margin_pct);


  let h = buffer.height * (1-2*margin_pct);

  //the directions in which the subdvisions of the golden
  //rectangle "move". See README.MD
  moves_x = new float[]{0, +1*phi, phi -1, -1};
  moves_y = new float[]{-1, 0, 1*phi, 1/phi};

  let x = 0, y = h;
  for (let i=0; i<iterations; i++) {
    y += h*  moves_y[i%4];
    x += h  * moves_x[i%4];
    subdivisions[i] = new Subdivision(x + h/2, y+h/2, h);
    h/=phi;
  }
}

function drawGoldenRectangle() {
/* /*   buffer.beginDraw(); */ */  
  buffer.translate(margin.x, margin.y);
  buffer.rectMode(CENTER);
  buffer.strokeWeight(8);
  for (let i=0, l = subdivisions.length; i<l; i++) {
    Subdivision g = subdivisions[i]; 
    buffer.rect(g.pos.x, g.pos.y, g.side, g.side);
  }
  buffer.rectMode(CORNER);
  buffer.endDraw();
}

function drawUniverso() {
  let l = 35;
  for (Subdivision r : subdivisions) {
/* /*     buffer.beginDraw(); */ */
    buffer.noStroke();
    buffer.translate(margin.x + r.pos.x - r.side/2, margin.y + r.pos.y- r.side/2);
    let x, y=0;
    let x_n = r.side/l;

    if (l<=0)
      break;
    for (let i=0; i<=pow(r.side/l, 2); i++) {
      x =  (i % l) * x_n;
      y =  floor((float)i/l) * x_n;
      if ((y+l/2) >=r.side || (x+l) >= r.side)
        break;
      buffer.push();
      buffer.translate(x +l/2, y);

      buffer.fill(color(palette[int(random(palette.length))]));
      buffer.rotate(noise(x, y) * HALF_PI);

      let whichShape = random(1.0); 
      if (whichShape<.33)
        buffer.triangle(0, 0, x_n * .75, 0, x_n * .75/2, x_n * .75);
      else if (whichShape <.66)
        buffer.ellipse(0, 0, x_n * .75, x_n * .75);
      else
        buffer.rect(0, 0, x_n * .75, x_n * .75);
      buffer.pop();
    }
    l = floor(l* .8);
  }
  buffer.endDraw();
}

function draw() {
/* /*   buffer.beginDraw(); */ */
  buffer.ellipseMode(CORNER); 
  buffer.background(255);
  buffer.endDraw();

  //uncomment to see the subdivisions of the  golden rectangle
  //drawGoldenRectangle();

  drawUniverso();

  image(buffer, 0, 0, width, height);
  noLoop();
}

function keyPressed() {
  if (key == 'S' || key == 's') {
    buffer.save(String.format("universo_%d.tiff", frameCount));
    console.debug("Composition saved!");
  }
}
