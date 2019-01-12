import processing.pdf.*; 
int spacing = 2;

void setup() {
  size(551, 359);
  noLoop();
}

void draw() {
  String fileName = "saved/" +
                    year() +"-" +
                    month() + "-" +
                    day() + "-" +
                    hour() + "-" +
                    minute() + "-" +
                    second() +
                    "-infinitesimal.pdf";
  beginRecord(PDF, fileName);
  background(255);
  
  generateGrid(true, false);
  generateGrid(false, true);
  generateGrid(false, false);
  
  endRecord();
  exit();
}

void generateGrid(boolean isBentX, boolean isBentY){
  for (int x = 0; x < width; x+=spacing) {
    for (int y = 0; y < height; y+=spacing) {
      float positionXToAngle = map(x, 0, width, 0, 180);
      float offsetX = cos(radians(positionXToAngle)) * spacing;
      
      float positionYToAngle = map(y, 0, height, 0, 90);
      float offsetY = cos(radians(positionYToAngle+45)) * spacing;
      
      if(!isBentX) { offsetX = 0; }
      if(!isBentY) { offsetY = 0; }
      
      noStroke();
      fill(0);
      ellipse(x + offsetX, y + offsetY, 1, 1);
    }
  }
}
