class FlowField {
  constructor(r) {
    this.res = r;
    this.cols = width / r;
    this.rows = height / r;
    this.field = [];
    this.x_increment = 0.3;
    this.y_increment = 0.3;
    this.init();
  }

  init() {
    this.update(0);
  }

  update(z) {
    let xOff = 0;
    for (let i = 0; i < this.cols; i++) {
      let yOff = 0;
      this.field[i] = [];
      for (let j = 0; j < this.rows; j++) {
        const theta = map(noise(xOff, yOff, z), 0, 1, 0, TWO_PI);
        this.field[i].push(new p5.Vector(cos(theta), sin(theta)));
        yOff += this.x_increment;
      }
      xOff += this.y_increment;
    }
  }

  lookup(l) {
    const c = int(constrain(l.x / res, 0, this.cols - 1));
    const r = int(constrain(l.y / res, 0, this.rows - 1));
    return this.field[c][r];
  }

  draw(drawArrows) {
    strokeWeight(2);
    let x = 0;
    for (let i = 0; i < this.cols; i++) {
      let y = 0;
      for (let j = 0; j < this.rows; j++) {
        const v1 = this.field[i][j];
        push();
        translate(x, y);
        rotate(v1.heading());
        const hue1 = map(abs(v1.heading()), 0, TWO_PI, 0, 100);

        if (drawArrows) {
          stroke(hue1, 100, 100);
          fill(hue1, 100, 100);

          line(-10, 0, 0, 0);
          line(-5, -3, 0, 0);
          line(-5, +3, 0, 0);
        } else {
          noStroke();
          const alpha = map(mouseY, 0, height, 10, 200);
          fill(hue1, 100, 100, alpha);
          const s = map(mouseX, 0, width, 10, 50);

          ellipse(0, 0, s, s);
        }
        pop();
        y += this.res;
      }
      x += this.res;
    }
  }
}
