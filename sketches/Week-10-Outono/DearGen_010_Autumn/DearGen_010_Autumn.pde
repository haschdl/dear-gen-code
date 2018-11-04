/**
 * [master f36b716]: Basic drawing with circles
 * [master fbc4f8a]: Random positions
 * Inspiration for flower equation: http://mathworld.wolfram.com/CannabisCurve.html
 * 
 */

PGraphics buffer;

class  Params {
  float r0 = 60;
  float noise_f = 1.0;

  float resolution = 200;
  int iterations = 203;
}

Params param = new Params();


void setup() {
  size(900, 600, P2D);

  buffer = createGraphics(1500, 1000, P2D);
  buffer.beginDraw();
  buffer.background(255);
  buffer.endDraw();

  noStroke();
}

//Autumn colors from picture: https://coolors.co/a4ae99-d9bca1-913641-9e8bb3-c6a74a
int[] palette = new int[]{ 0xFFCF8840, 0xFF8D2538, 0xFF6C3C25, 0xFFFEAE5D, 0xFFBB4D1A, 
  0xFFBF4342, 0xFF8C1C13, 0xFFEB803C, 0xFFCD7B31

};

void draw() {
  //a little hack to move the composition a litte up
  buffer.beginDraw();

  buffer.smooth();
  //buffer.strokeWeight(2);
  buffer.noStroke();
  buffer.translate(0, -.5 * param.r0);

  float  n_x = (buffer.width / param.r0) ;
  float x = (frameCount % n_x) * param.r0 *1.5;
  float y = (frameCount% param.iterations) / int(n_x) * param.r0 * (2 + noise(frameCount));

  //rotating a little bit every frame. 
  //cossine is just make "angle" alternate between positive and negative numbers  
  float angle = cos(frameCount* PI)* random(.15*PI);

  //a larger e makes the leafs bigger, and less detailed. 
  int e = int(random(3, 5)); //int(map(y, 0, height, 1, 5));
  float alpha = 200; //map(y, 0, height, 5, 240);


  //alternating colors according to frame count
  //this produced a more distributed color palette 
  int fillCol = palette[frameCount % palette.length];


  buffer.translate(x, y);
  buffer.rotate(angle);  
  leaf(e, fillCol, alpha);

  buffer.endDraw();
  image(buffer, 0, 0, width, height);

  if (frameCount % param.iterations == 0) {

    saveBuffer();
    buffer.beginDraw();
    buffer.background(255);
    buffer.endDraw();
  }
}


void leaf(int e, int fillCol, float alpha) {
  ArrayList<PVector> points = polygon(param.r0, param.resolution, e);
  buffer.fill(fillCol, alpha);
  buffer.beginShape();
  for (PVector p : points) 
    buffer.curveVertex(p.x, p.y); 
  buffer.endShape(CLOSE);
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
