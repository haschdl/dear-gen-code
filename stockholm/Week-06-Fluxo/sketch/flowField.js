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
    let xoff = 0;
    for (let i = 0; i < this.cols; i++) {
      let yoff = 0;
      for (let j = 0; j < this.rows; j++) {
        const theta = map(noise(xoff, yoff, z), 0, 1, 0, TWO_PI);
        // TODO this.field[i][j] = new p5.Vector(cos(theta), sin(theta));
        this.field.push(new p5.Vector(cos(theta), sin(theta)));
        yoff += this.x_increment;
      }
      xoff += this.y_increment;
    }
  }

  lookup(l) {
    const col = int(constrain(l.x / this.res, 0, this.cols - 1));
    const row = int(constrain(l.y / this.res, 0, this.rows - 1));
    const ix = col + row * (this.cols-1);
    return this.field[ix];
  }

  display() {
    stroke(0);
    strokeWeight(1);
    let x = 0;
    for (let i = 0; i < this.cols; i++) {
      let y = 0;
      for (let j = 0; j < this.rows; j++) {
        const v1 = this.field[i][j];
        pushMatrix();
        translate(x, y);
        rotate(v1.heading());
        line(-10, 0, 0, 0);
        line(-5, -3, 0, 0);
        line(-5, +3, 0, 0);
        // ellipse(x,y,2,2);
        popMatrix();
        y += this.res;
      }
      x += this.res;
    }
  }
}
