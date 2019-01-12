int subdivisionsX = 40;
int subdivisionsY = 130;

float periodX = 360 * 0.9;
float periodY = 360 * 1.1;

float distortionX;
float distortionY;

float rectWidth;
float rectHeight;

void setup(){
  size(900, 600);
  
  rectWidth = width/subdivisionsX;
  rectHeight = height/subdivisionsY;
  
  distortionX = width/8;
  distortionY = height/40;
  
  colorMode(HSB, 360, 100, 100);
}

void draw(){
  background(0);
  
  for(int y = 0; y < height; y++){
    stroke(map(y, 0, height, 180, 360), 70, 30);
    line(0, y, width, y);
  }
  
  noStroke();
  drawRects();
}

void drawRects(){
  for(float y = -rectHeight - distortionY; y <= height +rectHeight + distortionY; y += rectHeight){
    if(y > -rectHeight - distortionY){
      float prevY = y - rectHeight;
      for(float x = -rectWidth - distortionX; x <= width + rectWidth + distortionX; x += rectWidth){
        if(x > -rectWidth - distortionX){
          float prevX = x - rectWidth;
          
          float prevPhaseX = map(prevX, 0, width, 0, periodX);
          float phaseX = map(x, 0, width, 0, periodX);
          
          float prevAngleY = map(prevY, 0, height, 0, periodY);
          float angleY = map(y, 0, height, 0, periodY);
          
          float varPrevAmplX = cos(radians(prevPhaseX));
          float varAmplX = cos(radians(phaseX));
          
          float bendX1 = sin(radians(prevAngleY + prevPhaseX)) * distortionX*varPrevAmplX;
          float bendX2 = sin(radians(prevAngleY + phaseX)) * distortionX*varAmplX;
          float bendX3 = sin(radians(angleY + phaseX)) * distortionX*varAmplX;
          float bendX4 = sin(radians(angleY + prevPhaseX)) * distortionX*varPrevAmplX;
          
          float x1 = prevX + bendX1;
          float x2 = x + bendX2;
          float x3 = x + bendX3;
          float x4 = prevX + bendX4;
          
          float y1 = prevY + bendX1/3;
          float y2 = prevY + bendX2/3;
          float y3 = y + bendX3/3 - distortionY/5;
          float y4 = y + bendX4/3;
          
          float h = cos(radians(angleY*30 - x*4))*10 + 40;
          
          fill(h, 90, 80);
          beginShape();
          vertex(x1, y1);
          vertex(x2, y2);
          vertex(x3, y3);
          vertex(x4, y4);
          endShape(CLOSE);
        }
      }
    }
  }
}

void keyPressed(){
  if(key == ' '){
    String fileName = "saved-png/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-palha.png";
    saveFrame(fileName);
  }
}
