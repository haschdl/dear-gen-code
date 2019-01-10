void setup(){
  size(920, 580);
  noLoop();
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);
}

void draw(){
  background(60, 30,100);
  //background(0,0,0);
  
  for(int i = 0; i < width; i++){
    float h = map(i, 0, width, 0, 40);
    float s = map(i, 0, width, 0, 100);

    stroke(h, s, 100);
    line(i, 0, i, height);
  }
  
  
  noStroke();

  
  
  blendMode(MULTIPLY);
  bg(0, height/2, width, height/2, true);
  bg(0, height/2, width, -height/2, true);
  
  blendMode(ADD);
  xenakis(0, height/2, width, height/2, true);
  xenakis(0, height/2, width, -height/2, true);
  
  //saveFrame("saved-png/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-xenakis.png");
}

void xenakis(float startX, float startY, float sizeX, float sizeY, boolean blend){
  float incr = width/20;
  
  for(float x = startX; x <= sizeX + startX; x += incr){
    float mapX = map(x - startX, incr, sizeX, 0, sizeY);
    float y = sizeY + startY - mapX;
    float hue = map(x - startX, incr, sizeX, 30, 50);
    
    //fill(hue, 49, 96);
    fill(hue, 40, 8);
    
    beginShape();
    vertex(startX, y);
    vertex(x, startY);
    vertex(startX, startY);
    endShape(CLOSE);
  }
}

void bg(float startX, float startY, float sizeX, float sizeY, boolean blend){
  float incr = width/40;
  
  for(float x = startX; x <= sizeX + startX; x += incr){
    float mapX = map(x - startX, incr, sizeX, 0, sizeY);
    float y = sizeY + startY - mapX;
    float hue = map(x - startX, incr, sizeX, 340, 260);

    fill(hue, 30, 97);
    
    beginShape();
    vertex(startX, startY);
    vertex(x, startY);
    vertex(x*1.5, y + sizeY);
    vertex(startX, y);
    endShape(CLOSE);
  }
}
