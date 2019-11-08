float padding;
//float b = random(1) > 0.5 ? 20 : 100;
float b = 15;

void setup(){
  size(580, 920, P2D);
  //size(580, 820, P2D);
  padding = width/5;
  noLoop();
  colorMode(HSB, 360, 100, 100, 100);
}

void draw(){ 
  background(260, 35, 35);
  noStroke();
  
  PVector lastPoint = new PVector(width - padding, padding);
  
  while(lastPoint.y < height - padding){
    PVector newTriangle = drawTriangle(lastPoint);
    lastPoint = newTriangle;
  }
  
  String fileName = "saved/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + ".png";
  saveFrame(fileName);
}

PVector drawTriangle(PVector startPoint) {
  //float increment = map(startPoint.y, padding, height - padding, padding * 0.8, padding * 0.3);
  float increment = padding * 0.6;
  float endPointY = startPoint.y + increment;
  float mapEndPoint = map(endPointY, padding, height - padding, padding, width/2 - padding/2);
  float endPointRandomFactor = random(-padding, padding); // break teleology
  float endPointX = startPoint.x < width/2 ? width - mapEndPoint : mapEndPoint;
  PVector endPoint = new PVector(endPointX + endPointRandomFactor, endPointY);
  float slope = (startPoint.y - endPoint.y) / (startPoint.x - endPoint.x);
  
  float distanceToNewPoint = height/2;
  float perpendicularSlope = -1 / slope;
  PVector midPoint = midPoint(startPoint, endPoint);
  
  PVector center = pointFromMidpoint(midPoint, distanceToNewPoint, perpendicularSlope);
  float radius = dist(center.x, center.y, startPoint.x, startPoint.y);
  
  noStroke();
  //fill(0, 50);
  //ellipse(startPoint.x, startPoint.y, 10, 10);
  //ellipse(endPoint.x, endPoint.y, 10, 10);
  //ellipse(center.x, center.y, 4, 4);
  
  // Angle between center and startPoint
  float angStart = atan2(startPoint.y - center.y, startPoint.x - center.x);
  // Angle between center and endPoint
  float angEnd = atan2(endPoint.y - center.y, endPoint.x - center.x);
  
  float angStep = QUARTER_PI/20;
  float radiusVar = radius/12;
  float ang1 = 0;
  float ang2 = 0;
  if(angStart < angEnd){
    ang1 = angStart;
    ang2 = angEnd;
  } else {
    ang1 = angEnd;
    ang2 = angStart;
  }

  //stroke(0);
  for(float ang = ang1; ang < ang2; ang += angStep){
    float alpha = map(ang, angStart, angEnd, 255, 0);
    
    float x1 = cos(ang - angStep) * (radius + radiusVar) + center.x;
    float y1 = sin(ang - angStep) * (radius + radiusVar) + center.y;
    float x2 = cos(ang) * (radius + radiusVar) + center.x;
    float y2 = sin(ang) * (radius + radiusVar) + center.y;
    float x3 = cos(ang) * (radius - radiusVar) + center.x;
    float y3 = sin(ang) * (radius - radiusVar) + center.y;
    float x4 = cos(ang - angStep) * (radius - radiusVar) + center.x;
    float y4 = sin(ang - angStep) * (radius - radiusVar) + center.y;

    //ellipse(x, y, 5, 5);
    //stroke(0, 100);
    //line(x, y, x2, y2);
    float hue = 225;
    float saturation = 35;
    beginShape();
    fill(hue, saturation, b, alpha);
    vertex(x1, y1);
    fill(hue, saturation, b, constrain(alpha - 60, 0, 255));
    vertex(x2, y2);
    fill(hue, saturation, b, constrain(alpha - 100, 0, 255));
    vertex(x3, y3);
    fill(hue, saturation, b, constrain(alpha - 80, 0, 255));
    vertex(x4, y4);
    endShape(CLOSE);
    
    float h = random(300, 360);
    float randomAlpha = random(-10, 10);
    fill(h, 30, 80, alpha);
    for(int i = 0; i < 10; i++){
      float x = random(-radiusVar/2, radiusVar/2) + x1 + (x2 - x1)/2;
      float y = random(-radiusVar*1.3, radiusVar*1.3) + y4 - (y4 - y1)/2;
      float size = random(padding/100, padding/10);
      ellipse(x, y, size, size);
    }
  }

  //stroke(255, 0, 0, 120);
  //line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
  return endPoint;
}

PVector midPoint(PVector startPoint, PVector endPoint) {
  float midPointX = (startPoint.x + endPoint.x) / 2;
  float midPointY = (startPoint.y + endPoint.y) / 2;
  PVector midPoint = new PVector(midPointX, midPointY);
  return midPoint;
}

// Calculate point l pixels away from midpoint with given slope
// Found here:
// https://www.geeksforgeeks.org/find-points-at-a-given-distance-on-a-line-of-given-slope/
PVector pointFromMidpoint(PVector source, float l, float m) {
  // m is the slope of line, and the  
  // required Point lies distance l  
  // away from the source Point 
  PVector pointA, pointB;

  // slope is 0 
  //if (m == 0) { 
  //  point = new PVector(source.x + l, source.y);
  //} 

  // if slope is infinte 
  //else if (m == std::numeric_limits<float>::max()) { 
  //    a.x = source.x; 
  //    a.y = source.y + l; 

  //    b.x = source.x; 
  //    b.y = source.y - l; 
  //}  
  //else { 
    float dx = (l / sqrt(1 + (m * m))); 
    float dy = m * dx; 
    pointA = new PVector(source.x + dx, source.y + dy);
    pointB = new PVector(source.x - dx, source.y - dy);
  //}
  
  PVector point;
  
  if(m < 0){
    point = pointB;
  } else {
    point = pointA;
  }

  //stroke(0, 50);
  //line(point.x, point.y, source.x, source.y);
  return point;
} 
