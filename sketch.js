import java.text.SimpleDateFormat;  
import java.util.Date;  

let buffer;

let palette = new int[]{ #FFF8CE, #F2992A, #AF6709, #F7D083, #BA6928 };

function setup() {
  size(1200, 800);
  buffer = createGraphics(2400, 1600);
  noiseSeed(12345);
}

function straw(x, y, w, h ) {
  buffer.strokeWeight(1);
  let j_ =10;
  let i_ =10;
  for (let j=0; j<=j_; j++) {
    buffer.beginShape();
    buffer.stroke(color(palette[int(random(palette.length))]));
    for (let i=0; i<=i_; i++) {
      let v_x = lerp(x, x+w, (float)j/j_) ;
      let v_y = lerp(y, h, (float)i/i_);
      v_x += 4* (1 - 2*noise(v_x, v_y));
      buffer.vertex(v_x, v_y);
    }
    buffer.endShape();
  }
  buffer.noStroke();
}

function strawVer(l, n, start, end) {
  buffer.noStroke();  
  let x;
  for (let i= 1; i<n; i++) {
    x =2*l*(i);
    straw(x, start*buffer.height, l, end*buffer.height -1);
  }
}

function strawHor(l, n, m) {
  buffer.noStroke();
  buffer.fill(120, 255);
  let x, y;
  let L = 3*l;
  let n_v = 0;

  for (let row=4; row<m-4; row++) {
    y=row * l*2;
    x=-l;
    let offX = l *2* (row %2);
    for (let i=0; i<n; i++) {      
      n_v = 4*(1 - 2*noise(x, y));
      x+= n_v;    
      buffer.rect(x+offX, y, L-n_v, l);
      x+=L+l-n_v;
    }
  }
}

function draw() {
/* /*   buffer.beginDraw(); */ */
  buffer.background(255);
  let l = 20;
  let n = int(buffer.width/l/2);
  let m = int(buffer.height/l/2);

  strawVer(l, n, 0, 1);
  strawHor(l, n, m);

  buffer.endDraw();
  image(buffer, 0, 0, width, height);
  noLoop();
}


function keyPressed() {
  if (key == 'S' || key == 's') {
    SimpleDateFormat formatter = new SimpleDateFormat("YYYYMMDD_HHmmss");  
    Date date = new Date();  
    buffer.save(String.format("/out/palha_%s.tiff", formatter.format(date)) );
    console.debug("Composition saved!");
  }
}
