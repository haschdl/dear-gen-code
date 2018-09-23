PGraphics buffer;
OpenSimplexNoise noise;
float scale = 0.01;
int n = 800;

void setup() {
  size(1200, 800, P2D);
  buffer = createGraphics(1800, 1200);
  noise = new OpenSimplexNoise();
  background(255);
  smooth();
}

void draw() {
  surface.setTitle(str(frameCount% n));
  //if (frameCount% n ==0)
  buffer.beginDraw();
  buffer.noStroke();
  buffer.background(255);

  //telhado 
  float w = 50;//+ 20 * (float)noise.eval(scale*frameCount, cos(TWO_PI*millis()));
  float h = buffer.height/20;

  float n_across = floor(buffer.width/w);

  float W = w*20;
  float H = 5*h;

  float x_space =0;
  fill(180);

  //buffer.translate(buffer.width/2,0);
  //int i = floor(frameCount * noiseV);
  for (int i = 0; i<n; i++) {

    float totalW = w * n_across;

    float noiseV = (float)noise.eval(scale*i, scale*frameCount, cos(TWO_PI*millis()));
    float row = floor(1.0*i / n_across); 
    float col = (i%n_across)*(w*2 + x_space) + row % 2 * w ;


    buffer.pushMatrix();
    //buffer.translate();

    diamondShape(col, row * (h + 0 ), w, h, abs(noiseV) * 150);
    buffer.popMatrix();
  }
  buffer.endDraw();

  image(buffer, 0, 0, width, height);
}


void diamondShape(float x, float y, float w, float h, float hue) {
  buffer.pushMatrix();
  buffer.translate(x, y);
  if (x < buffer.width *.55 && x > buffer.width * .45 && 
    y < buffer.height*.55 && y > buffer.height * .45) {

    //"wall"
    buffer.fill(200);
    buffer.rect(-w * .8, h * .5, w*1.6, h*.7);

    //door
    buffer.fill(100);
    buffer.rect(-w * .1, h*.9, w*.2, h*.3);
  }
  buffer.fill(hue);
  buffer.beginShape();
  buffer.vertex(0, 0);
  buffer.vertex(w, h/2);
  buffer.vertex(w, h);
  buffer.vertex(0, h/2);
  buffer.endShape(CLOSE);
  buffer.fill(hue + 100);

  buffer.beginShape();
  buffer.vertex(0, 0);
  buffer.vertex(-w, h/2);
  buffer.vertex(-w, h);
  buffer.vertex(0, h/2);
  buffer.endShape(CLOSE);




  buffer.popMatrix();
}
