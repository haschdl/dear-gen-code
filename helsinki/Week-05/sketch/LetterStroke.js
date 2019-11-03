'use strict';

class LetterStroke {
  constructor(_initialPoint, _supportPoint, _strokeWeight) {
    this.initialPoint = _initialPoint;
    this.supportPoint = _supportPoint;
    this.strokeWeight = _strokeWeight;
    this.isStraightLine = random(1) > 0.5;

    this.g = createGraphics(100, 100);
    this.g.translate(50, 50);
    this.g.noFill();
    this.g.stroke(0);
    this.g.strokeWeight(2);
    this.g.strokeCap(ROUND);
    this.g.strokeJoin(ROUND);
    this.g.beginShape(LINES); // @REVIEW: not using 'LINES' as a param causes weird rendering
    if (this.isStraightLine) {
      this.g.vertex(...this.initialPoint);
      this.g.vertex(...this.supportPoint);
    } else {
      this.drawArc(this.initialPoint, this.supportPoint, 180);
    }
    this.g.endShape();
  }

  drawArc(initialPoint, supportPoint, arcAngle) {
    const angleIncr = 5;
    const centerX = (supportPoint[0] + initialPoint[0]) / 2;
    const centerY = (supportPoint[1] + initialPoint[1]) / 2;
    const radius = dist(...initialPoint, centerX, centerY);

    const deltaX = centerX - initialPoint[0];
    const deltaY = centerY - initialPoint[1];
    const initAngle = (atan2(deltaY, deltaX) * 180.0) / PI;

    for (
      let theta = initAngle;
      theta <= arcAngle + initAngle;
      theta += angleIncr
    ) {
      const x1 = cos(radians(theta)) * radius + centerX;
      const y1 = sin(radians(theta)) * radius + centerY;
      const x2 = cos(radians(theta - angleIncr)) * radius + centerX;
      const y2 = sin(radians(theta - angleIncr)) * radius + centerY;
      this.g.vertex(x1, y1);
      this.g.vertex(x2, y2);
    }
  }
}
