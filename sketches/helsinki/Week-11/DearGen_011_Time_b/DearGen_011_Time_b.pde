float vStep;

void setup(){
  //size(580, 920);
  size(464, 736);
  noLoop();
  vStep = height/10;
}

void draw(){
  //strokeWeight(5);
  
  //line(width/2, 0, width/2, height);
  
  //xenakis(height/2, height/8, 5);
  //xenakis(height - 20, height/2, 21);
  
  for(int y = 0; y <= height + vStep; y += vStep){
    int pow = int(map(y, 0, height, 5, 21));
    if(pow % 2 == 0){
      pow += 1;
    }
    xenakis(y, y/2, pow);
  }
  
  //saveFrame("saved-png/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-xenakis.png");
}

void xenakis(float top, float ampl, float pow){
  halfXenakis(top, ampl, pow, true);
  halfXenakis(top, ampl, pow, false);
}

void halfXenakis(float top, float ampl, float pow, boolean firstHalf){
  float step = width/60;
  int addAngle = firstHalf ? -20 : 20;
  float begin = firstHalf ? 0 : width/2;
  float end = firstHalf ? width/2 : width;
  float threshold = firstHalf ? 0 : width/2;
  
  beginShape();
  for(float x = begin; x <= end; x += step){
    if(x > threshold){
      float prevX = x - step;
      
      float angleX = map(x, 0, width, 180, 360 + addAngle);
      float anglePrevX = map(prevX, 0, width, 180, 360 + addAngle);
      
      float angleY = sin(radians(angleX));
      float anglePrevY = sin(radians(anglePrevX));
      float y = (pow(angleY, pow) * ampl) + top;
      float prevY = (pow(anglePrevY, pow) * ampl) + top;
      
      float oscX = (sin(radians(angleX - 90))/2 + 1) * step*2;
      float oscPrevX = (sin(radians(anglePrevX - 90))/2 + 1) * step*2;
      
      vertex(prevX + oscPrevX, top+vStep);
      vertex(prevX, prevY);
      vertex(x, y);
      vertex(x + oscX, top+vStep);
    }
  }
  endShape(CLOSE);
}
