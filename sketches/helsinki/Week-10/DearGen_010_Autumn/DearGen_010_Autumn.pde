float stepX;
float stepY;
float halfStepX;
float halfStepY;
float quarterStepX;
float quarterStepY;
float lastY;

int padding;

void setup(){
  size(920, 580);
  noLoop();
  colorMode(HSB, 360, 100, 100, 100);
  padding = width/30;
  
  stepX = width/30;
  stepY = height/60;
  halfStepX = stepX/2;
  halfStepY = stepY/2;
  quarterStepX = stepX/4;
  quarterStepY = stepY/4;
  
  lastY = height - padding*2 + stepY;
}

void draw(){
  repeatSky();
  landscape();
}

void landscape(){
  for(int i = 0; i < 6; i++){
    float freq = random(5, 10);
    float ampl = random(height/10, height/2);
    waves(freq, ampl);
  }
}

void waves(float freq, float ampl){
  noFill();
  stroke(200, 90, 20, 60);
  beginShape();
  for(int x = width - padding; x > padding; x -= 1){
    
    float angleY = sin(radians(map(x, 0, width, 0, 360 * freq) + 180));
    float angleY2 = sin(radians(map(x, 0, width, 0, 360/2) + 30));
    float angleY3 = sin(radians(map(x, 0, width, 180, 360) + 30));
    
    // angleY3 to the [odd number] will make the wave go up
    // large numbers make the spike narrow
    float y = (angleY * pow(angleY2, 3) * height/20) + (pow(angleY3, 301) * ampl) + height - padding - stepY;
    vertex(x, y);
  }
  endShape();
}

void repeatSky(){
  background(0, 0, 100);
  noStroke();
  for(int i = 0; i < 10; i++){
    sky();
  }
}

void sky(){
  for(float x = padding; x < width - padding*2; x += stepX){
    for(float y = padding; y < height - padding*2; y += stepY){
      float angle = radians(20);
      float angleRadians = random(-angle, angle);
      float offsetX = random(-halfStepX, halfStepX);
      float offsetY = random(-halfStepY, halfStepY);
      float offsetW = random(quarterStepX);
      float offsetH = random(quarterStepY);

      float hueOffset = random(-10, 10);
      float brightnessOffset = random(-5, 5);
      
      float hue = map(y, 0, height, 220, 170) + hueOffset;
      float saturation = map(y, 0, height, 40, 20);
      float brightness = map(y, 0, height, 60, 90) + brightnessOffset;
      
      pushMatrix();
      fill(hue, saturation, brightness, 50);
      translate(x - halfStepX + offsetX, y - halfStepY + offsetY);
      rotate(angleRadians);
      rect(
        halfStepX + quarterStepX,
        halfStepY + quarterStepX,
        stepX + offsetW,
        stepY + offsetH
      );
      popMatrix();
    }
  }
}

void keyPressed(){
  if(key == 's'){
    saveFrame("saved-png/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-autumn.png");
  }
}
