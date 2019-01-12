void setup(){
  size(920, 580, P3D);
  noLoop();
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  ellipseMode(CENTER);
}

void draw(){
  background(240, 50, 40);
  fill(0, 0, 100);
  ellipse(width/2 + width/8, height/2, width/9, width/9);
  
  //drawArcs(.53);
  drawArcs(.12);
  
  String fileName = "saved-png/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-telhado.pdf";
  saveFrame(fileName);
}

void drawArcs(float incr){
  int init = 14;
  for(int i = init; i > 0; i -= incr){
    float offset = map(i, incr, init, 0, width/8);
    float waveFactor = map(i, incr, init, 0, 360);
    float h = map(i, incr, init, 180, 360 + 60) % 360;
    drawArc(width/i, width/2 + offset, h, waveFactor);
  }
}

void drawArc(float radiusSmall, float centerX, float h, float waveFactor){
  float radiusBig = radiusSmall * 1.2;
  float radiusBigger = radiusSmall * 1.5;
  int step = 360/60;
  float centerY = height/2;
  float wave = cos(radians(waveFactor + 135)) * 30;
  //wave = 0;
  int startAngle = int(wave);
  int endAngle = int(180 - wave);
  
  for(int i = startAngle; i <= endAngle; i += step){
    float randomFactor = random(.95, 1.05);
    
    float x1 = cos(radians(i)) * radiusSmall + centerX;
    float y1 = sin(radians(i)) * radiusSmall + centerY;
    
    float i2 = map(i, startAngle, endAngle, startAngle - 5, endAngle + 5);
    float x2 = cos(radians(i2)) * radiusBig*randomFactor + centerX;
    float y2 = sin(radians(i2)) * radiusBig*randomFactor + centerY;
    
    float i3 = map(i, startAngle, endAngle, startAngle - 30, endAngle + 30);
    float x3 = cos(radians(i3)) * radiusBigger + centerX;
    float y3 = sin(radians(i3)) * radiusBigger + centerY;
    
    float x4 = cos(radians(i)) * (radiusSmall*.99) + centerX;
    float y4 = sin(radians(i)) * (radiusSmall*.99) + centerY;
    
    float s = map(radiusSmall, 0, height, 40, 80);
    float b = map(radiusSmall, 0, height, 150, 0);
    float b2 = map(radiusSmall, 0, height, 60, 0);
    
    // Alternate blend mode for each triangle
    //if(i % (step*2) == 0){
    //  blendMode(ADD);
    //} else {
    //  blendMode(NORMAL);
    //}
    
    blendMode(NORMAL);
    fill(h, s, b);
    beginShape();
    vertex(x1, y1);
    vertex(x2, y2);
    fill(h, s, b2);
    vertex(x3, y3);
    endShape(CLOSE);
    
    blendMode(ADD);
    fill(h, s, b);
    beginShape();
    vertex(x1, y1);
    vertex(x4, y4);
    fill(h, s, b2);
    vertex(x3, y3);
    endShape(CLOSE);
  }
}
