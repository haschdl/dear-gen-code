class Cell {
  float age;
  public boolean isAlive;
  float x, y;
  float nextX = -1;
  float nextY = -1;
  boolean isNewLine;
  float radius = 0;
  float radiusLimit;
  float angle;
  ArrayList<Particle> particles = new ArrayList<Particle>();
  
  float h = random(230, 270);
  float s = random(5, 30);
  float b = random(80, 97);
  
  Cell (float _x, float _y, boolean _isNewLine) {
    x = _x;
    y = _y;
    isNewLine = _isNewLine;
    isAlive = true;
  }
  
  void reset(){
    nextX = 0;
    nextY = 0;
  }
  
  void grow(){
    if(age <= 100){
      age += 0.25;
    } else {
      isAlive = false;
    }
  }
  
  void update(float _nextX, float _nextY){
    nextX = _nextX;
    nextY = _nextY;
    radiusLimit = dist(x, y, nextX, nextY);
    angle = atan2(nextY - y, nextX - x);
  }
  
  void draw() { 
    //ellipse(x, y, radius, radius);
    //ellipse(x, y, 1, 1);
    if(!isNewLine && nextX >= 0 && nextY >= 0){
      stroke(h, s, b, 100 - age);
      
      if(radius <= radiusLimit){
        radius += 10;
        particles.add(new Particle(x, y, angle, radius*3));
      }
      
      //stroke(0);
      line(x, y, nextX, nextY);
      //ellipse(x, y, 8, 8);

      for (int i = 0; i < particles.size(); i++) {
        Particle p = particles.get(i);
        
        PVector[] points = p.points();
        bezier(
          x, y,
          x, y,
          points[1].x, points[1].y,
          points[0].x, points[0].y
        );
        pushStyle();
        noStroke();
        fill(h, s, b, 100 - age);
        ellipse(points[0].x, points[0].y, points[0].z, points[0].z);
        popStyle();
      }
    }
  } 
} 
