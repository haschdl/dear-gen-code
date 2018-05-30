import java.text.SimpleDateFormat;  
import java.util.Date;  

PGraphics buffer;

int[] palette = new int[]{ #FFF8CE, #F2992A, #AF6709, #F7D083, #BA6928 };

void setup() {
  size(1200, 800);
  buffer = createGraphics(2400, 1600);
  noiseSeed(12345);
}

void straw(float x, float y, float w, float h ) {
  buffer.strokeWeight(1);
  int j_ =10;
  int i_ =10;
  for (int j=0; j<=j_; j++) {
    buffer.beginShape();
    buffer.stroke(color(palette[int(random(palette.length))]));
    for (int i=0; i<=i_; i++) {
      float v_x = lerp(x, x+w, (float)j/j_) ;
      float v_y = lerp(y, h, (float)i/i_);
      v_x += 4* (1 - 2*noise(v_x, v_y));
      buffer.vertex(v_x, v_y);
    }
    buffer.endShape();
  }
  buffer.noStroke();
}

void strawVer(float l, int n, float start, float end) {
  buffer.noStroke();  
  float x;
  for (float i= 1; i<n; i++) {
    x =2*l*(i);
    straw(x, start*buffer.height, l, end*buffer.height -1);
  }
}

void strawHor(float l, int n, int m) {
  buffer.noStroke();
  buffer.fill(120, 255);
  float x, y;
  float L = 3*l;
  float n_v = 0;

  for (int row=4; row<m-4; row++) {
    y=row * l*2;
    x=-l;
    float offX = l *2* (row %2);
    for (int i=0; i<n; i++) {      
      n_v = 4*(1 - 2*noise(x, y));
      x+= n_v;    
      buffer.rect(x+offX, y, L-n_v, l);
      x+=L+l-n_v;
    }
  }
}

void draw() {
  buffer.beginDraw();
  buffer.background(255);
  float l = 20;
  int n = int(buffer.width/l/2);
  int m = int(buffer.height/l/2);

  strawVer(l, n, 0, 1);
  strawHor(l, n, m);

  buffer.endDraw();
  image(buffer, 0, 0, width, height);
}


void keyPressed() {
  if (key == 'S' || key == 's') {
    SimpleDateFormat formatter = new SimpleDateFormat("YYYYMMDD_HHmmss");  
    Date date = new Date();  
    buffer.save(String.format("/out/palha_%s.tiff", formatter.format(date)) );
    println("Composition saved!");
  }
}
