/**
 * [master f36b716]: Basic drawing with circles
 * Inspiration for flower equation: http://mathworld.wolfram.com/CannabisCurve.html
 * 
 */

PGraphics buffer;

class  Params {
  float r0 = 50;
  float noise_f = 1.0;

  float resolution = 200;
  int iterations = 50;
}

Params param = new Params();


void setup() {
  size(800, 600, P2D);
  colorMode(HSB);

  noStroke();
}

//Summer colors: https://coolors.co/e28413-f56416-dd4b1a-ef271b-ea1744
int[] palette = new int[]{ 0xFFE28413, 0xFFF56416, 0xFFDD4B1A, 0xFFEF271B, 0xFFEA1744, 
  //https://coolors.co/a25a0f-d61013-920014-c50017-bf0037
  0xFFA25A0F, 0xFFD61013, 0xFF920014, 0xFFC50017, 0xFFBF0037 
};

void draw() { 

  //float x = random(1) * (width);
  //float y = random(1) * (height);

  float x = (frameCount % (width / param.r0))  * param.r0;
  float y = random(1) * (height);

  float angle = random(-HALF_PI, HALF_PI);

  int e = int(map(y, 0, height, 1, 5));
  float alpha = map(y, 0, height, 5, 240);

  //using random: produced "clusters" with the same colors
  //not very pleasing
  //int fillCol = palette[int(random(palette.length))];

  //alternating colors according to frame count
  //this produced a more distributed color palette 
  int fillCol = palette[frameCount % palette.length];


  translate(x, y);
  rotate(angle);  
  leaf(e, fillCol, alpha);

  if (frameCount % param.iterations == 0) {
    saveScreen();
    background(255);
  }
}


void leaf(int e, int fillCol, float alpha) {
  ArrayList<PVector> points = polygon(param.r0, param.resolution, e);
  fill(fillCol, alpha);
  beginShape();
  for (PVector p : points) 
    curveVertex(p.x, p.y); 
  endShape(CLOSE);
}


ArrayList<PVector> polygon(float radius, float resolution, int  e) {
  //e: eccentricity of the ellipse
  float step = TWO_PI / resolution ;
  ArrayList<PVector> points = new ArrayList<PVector>();
  float theta = 0;
  float a = 1; 
  float b = .162; 
  float c = .13; 
  float d = 27.54;


  for (int i = 0; i <= resolution; i++ ) { 

    float r = radius * a * (1 + b * cos(8*theta))*(e + c * cos(24* theta))
      *(.2 + .1 * cos(0 * theta))*(1+sin(theta));
    float sx =  + cos(theta) * r;
    float sy =  - sin(theta) * r;
    theta += step;
    points.add(new PVector(sx, sy));
  }
  return points;
}
