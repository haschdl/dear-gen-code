// Collision detection adapted from:
// http://happycoding.io/tutorials/processing/collision-detection

ArrayList<Rectangle> rectangles = new ArrayList<Rectangle>();
float initW;
float initH;
boolean isDone = false;
boolean saveFile = false;

void setup() {
  size(920, 580);
  noStroke();
  
  initW = width/17;
  initH = height/17;
  
  for(int i = 0; i < width; i += initW){
    for(int j = 0; j < height; j += initH){
      float w = random(initW/3, initW/1.5);
      float h = random(initW/3, initW/1.5);
      //float randomI = random(-initW/10, initH/10) - w/2;
      //float randomJ = random(-initW/10, initH/10) - h/2;
      float randX = random(0, width);
      float randY = random(0, height);
      float hue = random(1) > 0.2 ? 6 : 28;
      
      String path = sketchPath() + "/data/roofs";
      
      if(hue < 10){
        path = sketchPath() + "/data/roofs";
      } else {
        path = sketchPath() + "/data/greens";
      }
      
      File[] files = listFiles(path);
     
      int randomIndex = int(random(files.length));
      File f = files[randomIndex];
      PImage img = loadImage(path + "/" +f.getName());
      
      rectangles.add(new Rectangle(
        //i + randomI,
        //j + randomJ,
        randX, randY,
        w, h, hue,
        img
      ));
    }
  }
  
  background(255);
}

void draw() {
  if(!isDone){
    isDone();
  }
  
  //iterate over the rectangles
  for (int i = 0; i < rectangles.size(); i++) {
    Rectangle rectangle = rectangles.get(i);
    
    rectangle.prevX = rectangle.x;
    rectangle.prevY = rectangle.y;
    
    // compare this rectangle (i) with all the others
    for (int j = 0; j < rectangles.size(); j++) {
      Rectangle rectangle2 = rectangles.get(j);
      
      if(i != j){ // except with itself
        boolean checkCollision = (
            rectangle2.x + rectangle2.rectWidth > rectangle.x && 
            rectangle2.x < rectangle.x + rectangle.rectWidth &&
            rectangle2.y + rectangle2.rectHeight > rectangle.y && 
            rectangle2.y < rectangle.y + rectangle.rectHeight
          ) ||
          rectangle.x < -initW ||
          rectangle.x + rectangle.rectWidth > width + initW ||
          rectangle.y < -initH ||
          rectangle.y + rectangle.rectHeight > height + initH
        ;
        
        if(checkCollision){
          rectangle.x += random(-initW/8, initW/8);
          rectangle.y += random(-initH/8, initH/8);
        }
      }
    }

    if(
      rectangle.prevX == rectangle.x &&
      rectangle.prevY == rectangle.y
    ){
      rectangle.done = true;
    } else {
      rectangle.done = false;
    }

    drawRect(rectangle);
  }
  
  if(saveFile){
    String fileName = "saved-png/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-telhado.pdf";
    saveFrame(fileName);
    saveFile = false;
  }
  
  if(isDone){
    String fileName = "saved-png/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-telhado.pdf";
    saveFrame(fileName);
    exit();
  }

}

boolean isDone(){
  for (int i = 0; i < rectangles.size(); i++) {
    Rectangle rectangle = rectangles.get(i);
    if(!rectangle.done) return false;
  }
  isDone = true;
  return true;
}

void drawRect(Rectangle rectangle){
  image(rectangle.img, rectangle.x, rectangle.y, rectangle.rectWidth, rectangle.rectHeight);
}
  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

void keyPressed(){
  if(key == 's'){
    saveFile = true;
  }
}
