// 4D Open Simplex Noise Loop

// OpenSimplexNoise code by Kurt Spencer (https://gist.github.com/KdotJPG/b1270127455a94ac5d19)
// Based on Open Simplex Noise Loop by Daniel Shiffman (https://thecodingtrain.com/CodingChallenges/137-4d-opensimplex-noise-loop)

int totalFrames = 50;
float increment = 0.03;

// Just for non-looping demo
float zoff = 0;
float percent = 0;
PGraphics buffer;

OpenSimplexNoise noise;
void setup() {
  size(1000, 1000, P3D);
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 100);
  noise = new OpenSimplexNoise();
}

void draw() {
  surface.setTitle("Frames: " + frameCount);
  percent = float(frameCount % totalFrames) / totalFrames;
  render(percent);
}
void render(float percent) {
  float angle = map(percent, 0, 1, 0, TWO_PI);
  float uoff = map(sin(angle), -1, 1, 0, 2);
  float voff = map(sin(angle), -1, 1, 0, 2);

  float xoff = 0;
  //loadPixels();
  beginShape();
  vertex(0, 0);
  for (int x = 0; x < width; x++) {
    float yoff = 0;
    for (int y = 0; y < height; y++) {
      float n;

      // If you aren't worried about looping run this instead for speed!
      n = (float) noise.eval(xoff, yoff, zoff);

      //float hue = n > 0 ? 255 : 0;

      float hue =  n* (40 +  20*sin(millis()/100.));

      float sat = n*230;
      float brg = 40+n*255;//10.*(x*.02)%150 +  50*(y*.02)%75.+ n*140;
      //pixels[x + y * width] = color(hue, sat, brg, 250);
      stroke(hue, sat, brg, 100);
      if ((abs(n))>.50)
        vertex(y, x);
      yoff += increment;
      ;
    }
    xoff +=  increment;
  }
  //updatePixels();
  vertex(width, height);
  endShape();

  zoff += increment;
}
