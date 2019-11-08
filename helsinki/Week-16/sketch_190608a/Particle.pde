class Particle {
  float x, y, size, angle;
  float randAngle;
  float partX, partY, anchorX, anchorY;
  float radius;
  
  Particle(float _x, float _y, float _angle, float _radius){
    x = _x;
    y = _y;
    radius= _radius;
    angle = _angle;
    
    randAngle = random(-QUARTER_PI, QUARTER_PI);
    partX = cos(angle + randAngle) * radius + x;
    partY = sin(angle + randAngle) * radius + y;
    anchorX = cos(angle) * radius/3 + x;
    anchorY = sin(angle) * radius/3 + y;
  }
  
  PVector[] points(){
    PVector vertices = new PVector(partX, partY, radius/2);
    PVector control = new PVector(anchorX, anchorY);
    PVector[] points = new PVector[2];
    points[0] = vertices;
    points[1] = control;
    return points;
  }
}
