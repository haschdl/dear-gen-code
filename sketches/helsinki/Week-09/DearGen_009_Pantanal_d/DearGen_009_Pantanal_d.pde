PImage pantanal;
int blockSize;
color bgColor;

void settings(){
  pantanal = loadImage("pantanal.jpg");
  blockSize = pantanal.height/6;
  size(pantanal.width, pantanal.height);
  println(pantanal.width % blockSize);
  
}

void setup(){
  pantanal.loadPixels();
  noLoop();
  noStroke();
  ellipseMode(CORNER);
  colorMode(HSB, 100, 100, 100, 100);
}

void draw(){
  background(0, 0, 100);
  
  for(int x = 0; x < width - blockSize; x += blockSize){
    for(int y = 0; y < height - blockSize; y += blockSize){
      fill(colorBlock(x, y));
      ellipse(x + blockSize*0.05, y + blockSize*0.05, blockSize*0.9, blockSize*0.9);
    }
  }
}

color colorBlock(int x, int y){
  color c = 0;
  float br = 0;
  float sat = 0;
  for(int blockY = y; blockY < y + blockSize; blockY++){
    for(int blockX = x; blockX < x + blockSize; blockX++){
      color pixelColor = pantanal.pixels[blockY*width+blockX];
      float pixelBrightness = brightness(pixelColor);
      float pixelSaturation = saturation(pixelColor);
      if(pixelBrightness > br && pixelSaturation > sat && pixelBrightness > 20){
        br = pixelBrightness;
        sat = pixelSaturation;
        c = pantanal.pixels[blockY*width+blockX];
      }
      //c = pantanal.pixels[blockY*width+blockX];
    }
  }
  return c;
}
