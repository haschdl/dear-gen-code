import processing.pdf.*;

boolean save = false; // change this to 'true' to save PDF
int rectWidth = 10;
int rectHeight = 3;
float period = 360;
float variationX;
float variationY;

void setup(){
  size(1200, 800);
  variationY = height/20;
  variationX = width/7;
  
  if(save){
    String fileName = "saved/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-palha.pdf";
    beginRecord(PDF, fileName);
  }
  colorMode(HSB, 360, 100, 100);
}

void draw(){
  for(int y = 0; y < height; y++){
    stroke(
      map(y, 0, height, 0, 360),
      70,
      40
    );
    line(0, y, width, y);
  }
  
  drawRects();
  
  if(save){
    endRecord();
    exit();
  }
}

void drawRects(){
  for(int y = - int(period); y <= period*2; y += rectHeight){
    int prevY = y - rectHeight;
    float prevPhase = map(y-rectHeight, 0, height, 0, period);
    float phase = map(y, 0, height, 0, period);
    
    float prevPhaseVar = cos(radians(prevPhase)) * variationX;
    float phaseVar = cos(radians(phase)) * variationX;
    
    for(int x = - int(period); x <= period*2; x += rectWidth){
      int prevX = x - rectWidth;

      //float varVar3 = cos(radians(prevY));
      //float varVar4 = cos(radians(y));
      float varVar3 = 1;
      float varVar4 = 1;
      
      if(y > -variationY && x > -period){
        float varVar1 = sin(radians(prevX));
        float varVar2 = sin(radians(x));
        //float varVar1 = 1;
        //float varVar2 = 1;
        
        float bendX1 = sin(radians(prevY)) * variationX * varVar1;
        float x1 = (width * prevX)/period + bendX1;
        
        float bendX2 = sin(radians(prevY)) * variationX * varVar2;
        float x2 = (width * x)/period + bendX2;
        
        float bendX3 = sin(radians(y)) * variationX * varVar2;
        float x3 = (width * x)/period + bendX3;
        
        float bendX4 = sin(radians(y)) * variationX * varVar1;
        float x4 = (width * prevX)/period + bendX4;
        
        //yyyyyyy
        
        float bendY1 = cos(radians(prevX)) * variationY * varVar3;
        float y1 = (height * prevY)/period + bendY1;
        
        float bendY2 = cos(radians(x)) * variationY * varVar3;
        float y2 = (height * prevY)/period + bendY2;
        
        float bendY3 = cos(radians(x)) * variationY * varVar4;
        float y3 = (height * y)/period + bendY3 - 3;
        
        float bendY4 = cos(radians(prevX)) * variationY * varVar4;
        float y4 = (height * y)/period + bendY4;
        
        float hueShift = map(y, -variationY, height + variationY, 10, 50);
        float h = (sin(radians(y*20 - x*10))/2 + .5)*20 + hueShift;
        float b = (sin(radians(y*20 - x*10))/2 + .5)*20 + 70;
        
        strokeWeight(1);
        stroke(h, 80, b-30);
        fill(h, 80, b);
        
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
