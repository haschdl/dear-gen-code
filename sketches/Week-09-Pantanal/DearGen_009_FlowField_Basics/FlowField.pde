class FlowField {
  PVector[][] field;
  int cols, rows;
  int res;
  float x_increment = .3;
  float y_increment = .3;

  FlowField(int r) {
    res = r;
    cols = width/res;
    rows = height/res;
    field = new PVector[cols][rows];
    init();
  }

  void init() {
    update(0);
  }

  void update(float z) {
    float xoff= 0;
    for (int i=0; i<cols; i++) {
      float yoff= 0;
      for (int j=0; j<rows; j++) {
        float theta= map(noise(xoff, yoff, z), 0, 1, 0, TWO_PI);
        field[i][j] = new PVector(cos(theta), sin(theta));
        yoff+=x_increment;
      }
      xoff+=y_increment;
    }
  }

  PVector lookup(PVector l) {
    int c = int(constrain(l.x/res, 0, cols-1));
    int r = int(constrain(l.y/res, 0, rows-1));

    return field[c][r].get();
  }

  void draw(boolean drawArrows) {

    strokeWeight(2);
    float x= 0;
    for (int i=0; i<cols; i++) {
      float y= 0;
      for (int j=0; j<rows; j++) {
        PVector v1 = field[i][j];
        pushMatrix();
        translate(x, y);
        rotate(v1.heading());
        float hue1 = map(abs(v1.heading()), 0, TWO_PI, 0, 100);

        if (drawArrows) {
          stroke( hue1, 100, 100);
          fill(hue1, 100, 100);

          line(-10, 0, 0, 0);
          line(-5, -3, 0, 0);
          line(-5, +3, 0, 0);
        } else {
          noStroke();
          float alpha = map(mouseY, 0, height, 10, 200);
          fill(hue1, 100, 100, alpha);
          float s = map(mouseX, 0, width, 10, 50);

          ellipse(0, 0, s, s);
        }
        popMatrix();
        y+=res;
      }
      x+=res;
    }
  }
}
