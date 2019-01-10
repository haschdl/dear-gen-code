
class Vehicle {

  PVector iniloc;
  PVector loc;
  PVector v;
  PVector a;
  float maxspeed;
  float maxforce;
  float r;


  //styling
  float alpha = 80;

  PGraphics target; //where to draw

  Vehicle(float x, float y, float maxspeed, float maxforce, float alpha) {

    loc = new PVector(x, y);
    iniloc = loc.copy(); // makes a copy and stores the initial location
    v = new PVector(0, 0);
    a = new PVector(0, 0);
    this.alpha = alpha;
    this.maxspeed = maxspeed;
    this.maxforce = maxforce;
    r = 2;
  }
  void seek(PVector target) {

    PVector desired = PVector.sub(target, loc);
    desired.normalize();
    desired.mult(maxspeed);

    PVector steer = PVector.sub(desired, v);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void applyForce(PVector force) {
    a.add(force);
  }
  void update() {
    v.add(a);
    loc.add(v);
    a.mult(0);
    //checkEdges();
  }

  void follow(FlowField flow) {
    PVector desired = flow.lookup(loc);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, v);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void display(PGraphics target) {
    float theta = v.heading() + HALF_PI;

    target.strokeWeight(1);
    target.stroke(palette[frameCount % palette.length], alpha);
    target.fill(255, 10);
    target.pushMatrix();
    target.translate(loc.x, loc.y);

    //target.rotate(randomGaussian()/2 + theta);
    target.rotate(theta);
    target.beginShape();
    target.vertex(iniloc.x, iniloc.y);
    target.vertex(loc.x, loc.y); 
    target.vertex(loc.x* (1 + (float)frameCount / p.maxframes), loc.y * (1 + frameCount / p.maxframes)); 
    target.endShape(CLOSE);
    target.popMatrix();
    ;
  }


  void checkEdges() {
    if (loc.x>buffer.width) {
      loc.x=buffer.width;
      v.x*=-1;
    } else if (loc.x<0) {
      loc.x=0;
      v.x*=-1;
    }
    if (loc.y>buffer.height) {
      loc.y=buffer.height;
      v.y*=-1;
    } else if (loc.y<0) {
      loc.y=0;
      v.y*=-1;
    }
  }
}
