/**
 * This class is to simplify the creation of curves.
 * 
 */
class MyCurve {
  float tightness;
  int fillColor;

  ArrayList<PVector> points = new ArrayList<PVector>();


  public MyCurve(PVector curveLocation, int n, int fillColor) {
    this.fillColor = fillColor;
    this.points.add(curveLocation.copy());

    for (int i = 0; i < n; i++) {
      PVector newPoint = curveLocation.copy();
      newPoint.x += randomGaussian()*80;
      newPoint.y += randomGaussian()*80;
      this.points.add(newPoint);
    }
    this.points.add(this.points.get(1).copy());
    this.points.add(this.points.get(1).copy());
  }

  void draw(PGraphics target) {
    target.curveTightness(tightness);
    target.fill(fillColor);//
    target.fill((fillColor & 0xffffff) | (int(transp) << 24)); 
    target.beginShape();
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      //ellipse(p.x, p.y, 10, 10);
      target.curveVertex(p.x, p.y);
    }
    target.endShape();
  }
}


//Shortcut for curveVertex(p.x, p.y);
void curveVertex(PVector p) {
  curveVertex(p.x, p.y);
}
