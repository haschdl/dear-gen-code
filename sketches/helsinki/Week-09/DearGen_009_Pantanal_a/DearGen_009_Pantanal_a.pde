PImage pantanal;
float bandHeight;

void settings(){
  pantanal = loadImage("pantanal.jpg");
  size(pantanal.width, pantanal.height);
  bandHeight = height/20;
}

void setup(){
  pantanal.loadPixels();
  //noLoop();
  colorMode(HSB, 100, 100, 100, 100);
}

void draw(){
  //image(pantanal, 0, 0);
  
  //blendMode(SCREEN);
  background(0, 0, 0);
  
  for(int y = 0; y < height - bandHeight; y += bandHeight){
    drawBand(y);
  }
}

void drawBand(int y){
  for(int x = 0; x < width; x++){
    float sat = 0;
    float br = 0;
    color rowColor = 0;
    for(int bandY = y; bandY < y + bandHeight; bandY++){
      color pixelColor = pantanal.pixels[bandY*width+x];
      float pixelSaturation = saturation(pixelColor);
      float pixelBrightness = brightness(pixelColor);
      if(pixelSaturation > sat && pixelBrightness > br && pixelBrightness > 10){
      //if(pixelSaturation > sat || pixelBrightness > br){
        sat = pixelSaturation;
        br = pixelBrightness;
        rowColor = pantanal.pixels[bandY*width+x];
      }
    }
    stroke(rowColor);
    strokeWeight(2);
    
    float lineHeight = map(br, 0, 100, 0, bandHeight/2);
    
    float r1 = (height - y + bandHeight/2 - lineHeight)/2 - bandHeight/2;
    float r2 = (height - y + bandHeight/2 + lineHeight)/2 - bandHeight/2;
    //float r1 = (height - y - lineHeight*2) - bandHeight/2;
    //float r2 = (height - y + lineHeight*2) - bandHeight/2;
    //float r1 = (height - y)/2 - bandHeight/2;
    //float r2 = (height - y + bandHeight)/2 - bandHeight/2;
    
    float angle = map(x, 0 , width, 0, 180);
    float x1 = cos(radians(angle)) * r1 + width/2;
    float y1 = sin(radians(angle)) * r1 + height/2;
    float x2 = cos(radians(angle)) * r2 + width/2;
    float y2 = sin(radians(angle)) * r2 + height/2;
    line(x1, y1, x2, y2);
    
    float angle2 = map(x, 0 , width, 360, 180);
    float x3 = cos(radians(angle2)) * r1 + width/2;
    float y3 = sin(radians(angle2)) * r1 + height/2;
    float x4 = cos(radians(angle2)) * r2 + width/2;
    float y4 = sin(radians(angle2)) * r2 + height/2;
    line(x3, y3, x4, y4);
  }
}
