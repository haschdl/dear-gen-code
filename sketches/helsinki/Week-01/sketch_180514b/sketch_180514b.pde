int[] sortedColors;
PImage img;
int imgScale = 3;

void settings(){
  String imgName = "img-placeholder.jpg";
  img = loadImage(imgName);
  img.loadPixels();
  size(img.width * imgScale, img.height * imgScale);
}

void setup(){
  noLoop();
  noStroke();
  
  sortedColors = new int[img.pixels.length];
  sortedColors = bubbleSort(img.pixels);
}

void draw(){
  colorMode(HSB, 360, 100, 100);
  
  for(int i = 0; i < sortedColors.length; i++){
    float brightness = brightness(sortedColors[i]);
    fill(sortedColors[i]);
    float x = (i % img.width) * imgScale;
    float y = (i / img.width) * imgScale;
    float ellipseSize = map(brightness, 0, 100, imgScale/7, imgScale*5);
    //float ellipseSize = map(brightness, 0, 100, imgScale*2, imgScale*20);
    ellipse(x, y, ellipseSize, ellipseSize);
    //rect(x, y, imgScale, imgScale);
  }
  
  saveFrame("saved-png/" +year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-hue.png");
  exit();
}

// sort colors by hue, ripped off from:
// https://www.cs.cmu.edu/~adamchik/15-121/lectures/Sorting%20Algorithms/sorting.html
int[] bubbleSort(int ar[]) {
  for (int i = (ar.length - 1); i >= 0; i--){
    for (int j = 1; j <= i; j++){
      if (hue(ar[j-1]) > hue(ar[j])){
        int temp = ar[j-1];
        ar[j-1] = ar[j];
        ar[j] = temp;
      }
    }
  }
  return ar;
}
