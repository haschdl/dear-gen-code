class P {
  PVector v = new PVector();
  PVector pos;
  color pStroke;
  void update() {
    pos.add(v);
  }
  void draw() {
    stroke(pStroke);
    point(pos.x, pos.y);
  }
}
