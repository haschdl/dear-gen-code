/**
 * This class is to simplify the creation of curves.
 *
 */
class MyCurve {
  constructor(curveLocation, n, fillColor) {
    this.points = [];
    this.fillColor = fillColor;
    this.points.push(curveLocation.copy());

    for (let i = 0; i < n; i++) {
      const newPoint = curveLocation.copy();
      newPoint.x += randomGaussian()*80;
      newPoint.y += randomGaussian()*80;
      this.points.push(newPoint);
    }
    this.points.push(this.points[1].copy());
    this.points.push(this.points[1].copy());
  }

  draw() {
    curveTightness(tightness);
    beginShape();
    for (let j = 0; j < this.points.length; j++) {
      const p = this.points[j];
      fill(0);
      ellipse(p.x, p.y, 5, 5);
      fill((this.fillColor & 0xffffff) | (int(transp) << 24));
      curveVertex(p.x, p.y);
    }
    endShape();
  }
}
