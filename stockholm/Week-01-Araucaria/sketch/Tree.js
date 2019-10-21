class Tree {
  constructor(p, x, y, tree_height, stem_width) {
    this.buffer = p;
    this.pos = new p5.Vector(x, y);
    this.tree_height = tree_height;
    this.tree_width = 0;
    this.stem_width = stem_width;
    this.n_branches = 10;
    this.strokeWeight = 5;
  }

  draw() {
    /*     this.buffer.beginDraw(); */
    this.buffer.push();
    this.buffer.translate(this.pos.x, this.pos.y);
    this.stem(0, 0, this.stem_width, this.tree_height);
    for (let i = -this.n_branches; i <= this.n_branches; i += 1) {
      if (i == 0) continue;
      let y =
        ((w / 15) * abs(i)) / this.n_branches + 10 * (1 - 2 * noise(i * 23230));
      let lengthB = 10 + sqrt(y) * 10;
      this.tree_width = max(this.tree_width, 2 * lengthB + this.stem_width);

      this.buffer.push();
      this.buffer.scale(Math.sign(i), 1);
      let a = map(abs(i), 0, this.n_branches, 0.00001, 0.000001);
      this.branch(this.stem_width, y, lengthB, a);
      this.buffer.pop();
    }
    this.buffer.pop();
    
  }

  leaf(x, y, s) {
    this.buffer.push();
    this.buffer.translate(x, y);
    this.buffer.noStroke();
    this.buffer.fill(this.leaf_color);
    this.buffer.ellipse(0, 0, s, s);

    this.buffer.pop();
  }

  stem(x, y, w1, h1) {
    this.buffer.fill(mainColor);
    this.buffer.noStroke();
    this.buffer.rect(x - w1, y, w1 * 2, h1);
    this.leaf(x, y, w1 * 4);
  }

  branch(x, y, w1, a) {
    this.buffer.push();
    this.buffer.translate(x, y);
    this.buffer.beginShape();
    this.buffer.vertex(0, 0);
    this.buffer.noFill();
    this.buffer.stroke(mainColor);
    this.buffer.strokeWeight(this.strokeWeight);
    let n = 100;
    let x_i = 0,
      y_i = 0;
    for (let i = 1; i <= n; i++) {
      x_i = (i / n) * w1;
      y_i = -a * pow(x_i / 2, 4);
      this.buffer.vertex(x_i, y_i);
    }
    this.buffer.endShape();
    let s = randomGaussian() * 5 + this.tree_height / 20;
    this.leaf(x_i, y_i, s);
    this.buffer.pop();
  }
}
