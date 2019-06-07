PImage img;
float incrX = 0.005;
float incrY = 0.005;
float powerY = 30;
float distort = 20;
float deform = 20;

void settings(){
  img = loadImage("IMG_20160617_224625.jpg");
  size(img.width, img.height);
}

void setup(){
  noLoop();
}

void draw(){
  background(0);
  drawWave();
  drawWave2();
  
  String fileName = "saved/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-pixels.png";
  saveFrame(fileName);
}


void drawWave2(){
  for(float j = 0; j < 1; j += incrY){
    for(float i = 0; i < 1; i += incrX){
      if(i > 0 && j > 0){
        float powerX1 = pow(j-incrY, distort) * deform;
        float x1 = pow(i-incrX, powerX1) * width;
        float ang1 = map(x1, 0, width, 0, PI);
        
        float powerX2 = pow(j-incrY, distort) * deform;
        float x2 = pow(i, powerX2) * width;
        float ang2 = map(x2, 0, width, 0, PI);
        
        float powerX3 = pow(j, distort) * deform;
        float x3 = pow(i, powerX3) * width;
        float ang3 = map(x3, 0, width, 0, PI);
        
        float powerX4 = pow(j, distort) * deform;
        float x4 = pow(i-incrX, powerX4) * width;
        float ang4 = map(x4, 0, width, 0, PI);
        
        float varY1 = pow(j-incrY, powerY) * height;
        float y1 = height - (cos(ang1)/2 + 0.5) * varY1;
        
        float varY2 = pow(j-incrY, powerY) * height;
        float y2 = height - (cos(ang2)/2 + 0.5) * varY2;
        
        float varY3 = pow(j, powerY) * height;
        float y3 = height - (cos(ang3)/2 + 0.5) * varY3;
        
        float varY4 = pow(j, powerY) * height;
        float y4 = height - (cos(ang4)/2 + 0.5) * varY4;
        
        color c = img.get((int)x1, (int)y1);
        fill(c);
        stroke(c);
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

void drawWave(){
  for(float j = 0; j < 1; j += incrY){
    for(float i = 0; i < 1; i += incrX){
      if(i > 0 && j > 0){
        float powerX1 = pow(j-incrY, distort) * deform;
        float x1 = pow(i-incrX, powerX1) * width;
        float ang1 = map(x1, 0, width, PI, TWO_PI);
        
        float powerX2 = pow(j-incrY, distort) * deform;
        float x2 = pow(i, powerX2) * width;
        float ang2 = map(x2, 0, width, PI, TWO_PI);
        
        float powerX3 = pow(j, distort) * deform;
        float x3 = pow(i, powerX3) * width;
        float ang3 = map(x3, 0, width, PI, TWO_PI);
        
        float powerX4 = pow(j, distort) * deform;
        float x4 = pow(i-incrX, powerX4) * width;
        float ang4 = map(x4, 0, width, PI, TWO_PI);
        
        float varY1 = pow(j-incrY, powerY) * height;
        float y1 = (cos(ang1)/2 + 0.5) * varY1;
        
        float varY2 = pow(j-incrY, powerY) * height;
        float y2 = (cos(ang2)/2 + 0.5) * varY2;
        
        float varY3 = pow(j, powerY) * height;
        float y3 = (cos(ang3)/2 + 0.5) * varY3;
        
        float varY4 = pow(j, powerY) * height;
        float y4 = (cos(ang4)/2 + 0.5) * varY4;
        
        color c = img.get((int)x1, (int)y1);
        fill(c);
        stroke(c);
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
