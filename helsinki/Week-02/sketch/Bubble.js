/**
 * This sketch was based on
 * an example from Processing:
 * Loading Tabular Data
 * by Daniel Shiffman.
 */

class Bubble {
  constructor(x_, y_, radius_) {
    this.x = x_;
    this.y = y_;
    this.radius = radius_;
    this.over = false;
    this.c = color(random(5, 30), random(5, 35), random(0, 25));
    this.positions = [];
    if (radius_ > 0) {
      for (let i = 0; i < int(radius_); i++) {
        const randomR = random(radius_);
        const randomA = random(360);
        const thisX = cos(radians(i * randomA)) * randomR + x_;
        const thisY = sin(radians(i * randomA)) * randomR + y_;
        this.positions.push(new p5.Vector(thisX, thisY));
      }
    }
  }

  display() {
    // fill(255);
    // ellipse(x, y, 20, 20);

    stroke(this.c);
    strokeWeight(1);
    noFill();

    beginShape();
    if (this.radius > 0) {
      for (let i = 0; i < int(this.radius); i++) {
        curveVertex(this.positions[i].x, this.positions[i].y);
      }
    }
    endShape();
  }
}
