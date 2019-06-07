float r0, r;

float t, inc;
float cx, cy;


PGraphics canvas;

void setup() {
  size(1200, 800, P2D);
  colorMode(HSB, 360., 1., 1., 1.);

  cx = width/2.;
  cy = 0;
  r0 =  height * .1 ;

  t = -r0;
  frameRate(120);
  background(0, 0, 1, 2);
  smooth(4);
  inc=r0/20;
}

void draw() {
  t += inc;
  translate(t, cy);

  if (t> width+r0) {
    t=0;
    cy+=r0;
    //saveScreen();
    //noLoop();
  } else {
    noFill();
    stroke(220 + 40 * sin(TWO_PI* frameCount/50.), 1., 1., 1.);
  }
  r = r0*(abs(sin(10*HALF_PI*frameCount * PI * (inc/width))));
  ellipse(0, 0, r, r);
}
