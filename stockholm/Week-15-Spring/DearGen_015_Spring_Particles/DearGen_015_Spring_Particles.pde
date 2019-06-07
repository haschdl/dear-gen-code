PImage img;
ArrayList<P> points;

int w = 1400;
int h = 1400;

PGraphics canvas;
void setup() {
  size(1500, 1500);
  background(0);
  //colorMode(HSB, 360);

  img = loadImage("IMG_0144.JPG");
  //img = loadImage("IMG_0146.JPG");

  img.resize(w, h);
  img.loadPixels();
  println("Pixels: " + img.pixels.length);

  points = new ArrayList<P>();
  for (int i = 0; i <img.pixels.length; i++) {
    P p = new P();
    int x = i%w;
    int y = floor(i/w);
    p.pos = new PVector(x, y);
    p.pStroke = img.pixels[i];


    p.v = new PVector(h/2 + noise(x,y)*2, w/2 +  + noise(x,y)*2);
    p.v.sub(p.pos);
    p.v.normalize();
    points.add(p);

    int nearest;

    float[] near = new float[25];
    float minDiff = 1000;
    int ixMinDiff = -1;
    PVector dir = new PVector();
    for (int m = -2; m <=2; m++) {
      for (int n = -2; n <=2; n++) {
        int x1 = x+m;
        int y1 = y+n;
        int ix2 = x1 + y1*h;
        if (x1 < 0 || y1 < 0 || ix2 < 0 || ix2 >= img.pixels.length)
          continue;

        int j = (m+2) + (n+2)*5;
        if (hue(img.pixels[ix2]) < 3 )
          continue;
        near[j] = abs(hue(img.pixels[ix2]) - hue(p.pStroke));
        if (near[j] < minDiff) {
          minDiff = near[j];
          ixMinDiff = ix2;
          dir = new PVector(m, n);
          dir.normalize();
        }
      }
    }
    p.v.add(dir);


    //TODO p.v
  }
}
int maxi = 0;

void draw() {
  background(255);
  surface.setTitle("Frame: " + str(frameCount));
  int x0 = (width-w)/2;
  int y0 = (height-h)/2;

  translate(x0, y0);


  for (P p : points) {
    p.update();
    p.draw();
  }


  for (P p : points) {
    float[] near = new float[25];
    float minDiff = 1000;
    PVector dir = new PVector();
    for (int m = -2; m <=2; m++) {
      for (int n = -2; n <=2; n++) {
        int x1 = int(p.pos.x)+m;
        int y1 = int(p.pos.y)+n;
        int ix2 = x1 + y1*h;
        if (x1 < 0 || y1 < 0 || ix2 >= img.pixels.length)
          continue;

        int j = (m+2) + (n+2)*5;
        near[j] = abs(hue(img.pixels[ix2]) - hue(p.pStroke));
        if (near[j] < minDiff) {
          minDiff = near[j];
          dir = new PVector(m, n);
          dir.normalize();
        }
      }
    }
    p.v.add(dir);
  }
}
