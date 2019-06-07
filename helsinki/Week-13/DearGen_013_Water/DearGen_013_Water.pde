float padding;
float noiseIncr = 0.8;
float off = 0.0;
float incrSize;

void setup(){
  size(580, 920);
  padding = height/10;
  noLoop();
  incrSize = width/30;
  colorMode(HSB, 360, 100, 100);
}

void draw(){
  //background(80, 90, 100);
  //background(255);
  
  noStroke();
  for(int y = 0; y < height; y++){
    float s = map(y, 0, height, 19, 40);
    float b = map(y, 0, height, 38, 20);
    fill(209, 19, b);
    rect(0, y, width, 1);
  }
  
  //drawLine(width/4, padding);
  //drawLine(width/2, height/2);
  
  //float incr = width/80;
  float incr = 0.5;
  for(float x = padding; x < width - padding; x += incr){
    float ang = map(x, padding, width - padding, 0, TWO_PI);
    float y = sin(ang) * (height/2 - padding*2) + height/2;
    drawLine(x, y);
  }
  
  String fileName = "saved-png/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-water.png";
  saveFrame(fileName);
}

void drawLine(float posX, float endY){
  float incr = height/20;
  for(float y = padding; y < height - endY; y += incr){
    float noise = noise(off) * width/30;
    float noisePrev = noise(off - noiseIncr) * incrSize;
    float x = noise + posX;
    float prevY = y - incr;
    float ang = map(y, padding, height - endY, PI, TWO_PI);
    float alpha = (cos(ang)/2 + 0.5) * 120 + 10;
    noStroke();
    fill(0, 0, 100, alpha);
    //fill(80, 90, 100, alpha);
    ellipse(x, y + noise*4, width/150, width/150);
    
    noFill();
    stroke(0, 0, 100, alpha);
    //stroke(80, 90, 100, alpha);
    if(y > padding){
      float prevX = noisePrev + posX;
      line(x, y + noise*4, prevX, prevY + noisePrev*4);
    }
    off = off + noiseIncr;
  }
}
