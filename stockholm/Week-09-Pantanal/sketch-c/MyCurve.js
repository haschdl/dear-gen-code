/**
 * This class is to simplify the creation of curves.
 *
 */
class MyCurve {
  constructor(curveLocation, n, fillColor) {
    this.fillColor = fillColor;
    this.points = [];
    this.points.push(curveLocation.copy());

    for (let i = 0; i < n; i++) {
      const newPoint = curveLocation.copy();
      newPoint.x += randomGaussian() * 80;
      newPoint.y += randomGaussian() * 80;
      this.points.push(newPoint);
    }
    this.points.push(this.points[1].copy());
    this.points.push(this.points[1].copy());
  }

  draw(target) {
    target.curveTightness(tightness);
    this.fillColor.setAlpha(transp);
    target.fill(this.fillColor);
    target.beginShape();
    for (let j = 0; j < this.points.length; j++) {
      const p = this.points[j];
      // ellipse(p.x, p.y, 10, 10);
      target.curveVertex(p.x, p.y);
    }
    target.endShape();
  }
}
