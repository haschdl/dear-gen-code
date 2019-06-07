import processing.pdf.*;

float[] y;
float yoff = 0.0;
float yincrement = 0.05;
int iterations = 80;
boolean savePdf = false;
boolean savePng = true;

void setup(){
  size(920, 580);
  noLoop();
  noiseSeed(0);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  
  y = new float[int(width/10)];
  
  for(int i = 0; i < y.length; i++){
    float n = noise(yoff - 0.5) * (height/8);
    yoff += yincrement;
    y[i] = n;
  }
}

void draw(){
  if(savePdf){
    String fileName = "saved/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-music.pdf";
    beginRecord(PDF, fileName);
  }
  
  background(250, 20, 90);
  
  for(int y = 0; y < height; y++){
    color from = color(250, 20, 90);
    color to = color(180, 24, 99);
    float percent = map(y, 0, height, 0, 1);
    color interA = lerpColor(from, to, percent);

    stroke(interA);
    line(0, y, width, y);
  }
  
  translate(0, height/2);
  for(float y = 0; y <= iterations; y++){
    drawRow(y);
  }
  
  if(savePng){
    String fileName2 = "saved-png/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-flow.png";
    saveFrame(fileName2);
  }
  
  if(savePdf){
    endRecord();
    savePdf = false;
  }
}

void drawRow(float rowIndex){
  float[] tempY = new float[y.length];
  for(int i = 0; i < y.length; i++){
    float n = (noise(yoff) - 0.5) * (height/8);
    //float n = (noise(yoff) - 0.5)*40;
    yoff += yincrement;
    tempY[i] = y[i] + n;
    //tempY[i] = rowPos + n;
    
    float h = map(rowIndex, 0, iterations, 320, 360);
    float b = map(rowIndex, 0, iterations, 80, 50);
    stroke(h, 80, b);
    fill(h, 80, b);
    
    if(i > 0){
      float x1 = map(i, 0, y.length-1, 0, width);
      float x2 = map(i-1, 0, y.length-1, 0, width);
      beginShape();
      vertex(x1, y[i]);
      vertex(x2, y[i-1]);
      vertex(x2, tempY[i-1]);
      vertex(x1, tempY[i]);
      endShape(CLOSE);
    
      stroke(h, 80, b-10);
      line(x1, y[i], x2, y[i-1]);
    }
  }
  
  y = tempY;
  yoff = random(100);
}

void keyPressed(){
  if(key == 's'){
    savePdf = true;
  }
  if(key == 'a'){
    savePng = true;
  }
}
