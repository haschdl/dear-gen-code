// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain

// Double Pendulum
// https://youtu.be/uWzPe_S-RVE

float r1 = 180;
float r2 = 300 - r1;
float m1 = 40;
float m2 = 40;
float a1 = PI/2;
float a2 = PI/2;
float a1_v = 0.1;
float a2_v = 0;


float px2 = -1;
float py2 = -1;
float cx, cy;

PGraphics canvas;

void setup() {
  size(900, 600);
  cx = width/2;
  cy = height/2;
  canvas = createGraphics(width*2, height*2);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
}

void draw() {
  surface.setTitle(String.format("frames: %d", frameCount));
  background(255);
  imageMode(CORNER);
  image(canvas, 0, 0, width, height);
  //r1 = 50 + 120 *(1 + sin(millis()/4000.));



  float num1 =  (2 * m1 + m2) * sin(a1);
  float num2 = -m2  * sin(a1-2*a2);
  float num3 = -2*sin(a1-a2)*m2;
  float num4 = a2_v*a2_v*r2+a1_v*a1_v*r1*cos(a1-a2);
  float den = r1 * (2*m1+m2-m2*cos(2*a1-2*a2));
  float a1_a = 0;// (num1 + num2 + num3*num4) / den;

  num1 = 2 * sin(a1-a2);
  num2 = (a1_v*a1_v*r1*(m1+m2));
  num3 = (m1 + m2) * cos(a1);
  num4 =  a2_v*a2_v*r2*m2*cos(a1-a2);
  den = r2 * (2*m1+m2-m2*cos(2*a1-2*a2));
  float a2_a = (num1*(num2+num3+num4)) / den;

  translate(cx, cy);
  stroke(0);
  strokeWeight(2);

  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);

  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);


  line(0, 0, x1, y1);
  fill(0);
  ellipse(x1, y1, m1, m1);

  line(x1, y1, x2, y2);
  fill(0);
  ellipse(x2, y2, m2, m2);

  a1_v += a1_a;
  a2_v += a2_a;
  a1 += a1_v;
  a2 += a2_v;

  canvas.beginDraw();
  canvas.colorMode(HSB, 360, 100, 100);
  //canvas.background(0, 1);
  canvas.scale(2);
  canvas.translate(cx, cy);
  // canvas.noStroke();
  canvas.noStroke();

  int n = 12 +  2*int( frameCount/50.);
  if (frameCount % (n) == 0) {
    canvas.endShape();
    canvas.beginShape();
  }
  if (frameCount > 1) {
    canvas.fill(200 + 160 * abs(sin(a1 + millis())), 100, 100, 20);
    canvas.vertex(px2, py2);
    canvas.vertex(x2 +a1_v, y2);
  }
  canvas.endDraw();


  px2 = x2;
  py2 = y2;
}
