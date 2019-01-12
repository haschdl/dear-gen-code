PImage pantanal;
float bandHeight;

void settings(){
  pantanal = loadImage("pantanal.jpg");
  size(pantanal.width, pantanal.height);
  bandHeight = height/10;
}

void setup(){
  pantanal.loadPixels();
  noLoop();
  colorMode(HSB, 100, 100, 100, 100);
}

void draw(){
  //image(pantanal, 0, 0);
  
  //blendMode(SCREEN);
  background(0, 0, 0);
  
  for(int y = 0; y < height - bandHeight; y += bandHeight){
    drawBand(y);
  }
  
  saveFrame("saved-png/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-pantanal.png");
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
    float lineHeight = map(br, 0, 100, 0, bandHeight/2);
    float padding = bandHeight/4;
    //line(x, y + bandHeight/2 - lineHeight, x, y + bandHeight/2 + lineHeight);
    line(x, y + bandHeight/2 - lineHeight + padding/2, x, y + bandHeight/2 + lineHeight - padding/2);
    //line(x, y - lineHeight, x, y + bandHeight);
  }
}
