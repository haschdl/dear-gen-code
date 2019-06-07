PImage img;
ArrayList<P> points;

int w = 800;
int h = 800;

PGraphics canvas;
void setup() {
  size(900, 900);
  background(0);

  img = loadImage("IMG_E0085.jpg");
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
    p.v = new PVector();
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
        near[j] = abs(hue(img.pixels[ix2]) - hue(p.pStroke));

        if (near[j] < minDiff) {
          minDiff = near[j];
          ixMinDiff = ix2;
          dir = new PVector(m, n);          
          //dir.normalize();
          //dir.mult(.2);
        }
      }
    }
    p.v = dir.copy();


    //TODO p.v
  }
}
int maxi = 0;

void draw() {
  //background(0);
  surface.setTitle("Frame: " + str(frameCount));
  int x0 = (width-w)/2;
  int y0 = (height-h)/2;

  for (P p : points) {
    p.update();
    //p.draw();
  }

  for (int i = 0; i < 300000; i++) {

    int ix = int(random(points.size()));
    P p = points.get(ix);

    float x = p.pos.x;
    float y = p.pos.y;

    if (x == 0 || y == 0)
      continue;

    float a = 5;
    float fx = 1 / (a * sqrt(x/w * (1-x/w)));
    float fy = 1 / (a * sqrt(y/h * (1-y/h)));

    //draws the probability curve
    //point(x * width, fx * height);


    float px = random(1.);
    float py = random(1.);


    float point_x = x0 + x;
    float point_y = y0 + y;
    if (px < fx  && py < fy) {     

      stroke(p.pStroke);
      point(point_x, point_y);
    }
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
          //dir.normalize();
        }
      }
    }
    p.v = dir.copy();
  }
}
