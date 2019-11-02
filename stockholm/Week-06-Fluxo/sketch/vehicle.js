class Vehicle {
  constructor(x, y, maxspeed, maxforce, opacity) {
    this.loc = new p5.Vector(x, y);
    this.iniloc = this.loc.copy(); // makes a copy and stores the initial location
    this.v = new p5.Vector(0, 0);
    this.a = new p5.Vector(0, 0);
    this.opacity = opacity || 80;
    this.maxspeed = maxspeed;
    this.maxforce = maxforce;
    this.r = 2;
  }

  seek(target) {
    const desired = p5.Vector.sub(target, this.loc);
    desired.normalize();
    desired.mult(this.maxspeed);

    const steer = p5.Vector.sub(desired, this.v);
    steer.limit(this.maxforce);
    this.applyForce(steer);
  }

  applyForce(force) {
    this.a.add(force);
  }
  update() {
    this.v.add(this.a);
    this.loc.add(this.v);
    this.a.mult(0);
    // checkEdges();
  }

  follow(flow) {
    const desired = flow.lookup(this.loc);
    desired.mult(this.maxspeed);
    const steer = p5.Vector.sub(desired, this.v);
    steer.limit(this.maxforce);
    this.applyForce(steer);
  }

  display(target) {
    const theta = this.v.heading();
    target.strokeWeight(1);
    const c = color(palette[frameCount % palette.length]);
    c.setAlpha(this.opacity);
    target.stroke(c);

    target.fill(255, 10);
    target.push();
    target.translate(this.loc.x, this.loc.y);

    target.rotate( theta);
    // target.translate(-this.loc.x, -this.loc.y);
    // target.rotate(theta);
    target.beginShape();
    target.vertex(this.iniloc.x, this.iniloc.y);
    target.vertex(this.loc.x, this.loc.y);

    target.vertex(
        this.loc.x * (1+frameCount / p.maxframes),
        this.loc.y * (1+frameCount / p.maxframes),
    );

    target.endShape(CLOSE);
    target.pop();
  }

  checkEdges() {
    if (loc.x > buffer.width) {
      loc.x = buffer.width;
      v.x *= -1;
    } else if (loc.x < 0) {
      loc.x = 0;
      v.x *= -1;
    }
    if (loc.y > buffer.height) {
      loc.y = buffer.height;
      v.y *= -1;
    } else if (loc.y < 0) {
      loc.y = 0;
      v.y *= -1;
    }
  }
}
