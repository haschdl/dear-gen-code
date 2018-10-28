class  Params {
  float r0 = 30;
  float noise_f = 1.0;

  float resolution = 300;
  int iterations = 200;
}

Params param = new Params();


void setup() {
  size(800, 600, P2D);
  background(255);
  noStroke();
}

//Summer colors: https://coolors.co/e28413-f56416-dd4b1a-ef271b-ea1744
int[] palette = new int[]{ 0xFFE28413, 0xFFF56416, 0xFFDD4B1A, 0xFFEF271B, 0xFFEA1744 };


void draw() {

  float x = random(width);
  float y = random(height);
  float angle = random(TWO_PI);

  translate(x, y);
  rotate(angle);  
  leaf();

  if (frameCount > param.iterations)
    noLoop();
}


void leaf() {
  ArrayList<PVector> points = polygon(param.r0, param.resolution, .66);
  fill(palette[int(random(palette.length))], 200);
  beginShape();
  for (PVector p : points) 
    vertex(p.x, p.y); 

  endShape(CLOSE);
}

PVector path(float a, float radius, float e) {
  //e: eccentricity of the ellipse
  float p =  a*5;
  float r = (e * p) /(1 - e * cos(a));
  float sx =  + cos(a) * r;
  float sy =  + sin(a) * r;
  return new PVector(sx, sy);
}


ArrayList<PVector> polygon(float radius, float resolution, float  e) {
  //e: eccentricity of the ellipse
  float angle = TWO_PI / resolution ;
  ArrayList<PVector> points = new ArrayList<PVector>();
  float a = 0;
  for (int i = 0; i <= resolution; i++ ) { 
    a += angle;
    float radius_offset = 1 ; // #a*.9    
    PVector t = path(a, radius, e);

    float p =  radius + radius_offset;
    float r = (e * p) /(1 - e * cos(a));
    r = (e * p) /(1 - e * pow(sin(a), 4)*cos(a*3)  + noise(a));
    float sx =  + cos(a) * r;
    float sy =  + sin(a) * r;

    points.add(new PVector(sx, sy));
    //points.add(new PVector(sx +(1 -2*noise(radius/10 + 123232)/param.noise_f)* t.x, sy +(1 - 2*noise(a*radius+878763)/param.noise_f) * t.y));
  }
  return points;
}
