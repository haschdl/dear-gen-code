// 4D Open Simplex Noise Loop

// OpenSimplexNoise code by Kurt Spencer (https://gist.github.com/KdotJPG/b1270127455a94ac5d19)
// Based on Open Simplex Noise Loop by Daniel Shiffman (https://thecodingtrain.com/CodingChallenges/137-4d-opensimplex-noise-loop)

int totalFrames = 360;
int counter = 0;
boolean record = true;

float increment = 0.01;

// Just for non-looping demo
float zoff = 0;

OpenSimplexNoise noise;
void setup() {
  size(1500, 1000);
  colorMode(HSB, 360, 100, 100);
  blendMode(DIFFERENCE);
  noise = new OpenSimplexNoise();
  background(0, 0, 0);
}

void draw() {
  float percent = 0;
  if (record) {
    percent = float(counter) / totalFrames;
  } else {
    percent = float(counter % totalFrames) / totalFrames;
  }
  render(percent);
  if (record) {
    saveFrame("output/gif-"+nf(counter, 3)+".png");
    if (counter == totalFrames-1) {
      exit();
    }
  }
  counter++;
}

void render(float percent) {
  float angle = map(percent, 0, 1, 0, TWO_PI);
  float uoff = map(sin(angle), -1, 1, 0, 2);
  float voff = map(sin(angle), -1, 1, 0, 2);

  float xoff = 0;
  loadPixels();
  for (int x = 0; x < width; x++) {
    float yoff = 0;
    for (int y = 0; y < height; y++) {
      float n;
      if (record) {
        // 4D Open Simplex Noise is very slow!
        n = (float) noise.eval(xoff, yoff, uoff, voff);
      } else {
        // If you aren't worried about looping run this instead for speed!
        n = (float) noise.eval(xoff, yoff, zoff);
      }
      //float hue = n > 0 ? 255 : 0;

      float hue = 10*(x*.02)%150 +  100*(y*.02)%150.+ n*200;
      float sat = 150.*(x*.02)%150 +  10*(y*.02)%150.+ n*230;
      float brg = 10.*(x*.02)%150 +  50*(y*.02)%150.+ n*140;
      pixels[x + y * width] += color(hue, sat, brg);
      yoff += increment;
      ;
    }
    xoff +=  increment;
  }
  updatePixels();

  zoff += increment;
}
