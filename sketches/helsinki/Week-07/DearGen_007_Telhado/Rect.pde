class Rectangle {
  float x;
  float y;
  float prevX;
  float prevY;
  float rectWidth;
  float rectHeight;
  float hue;
  PImage img;
  boolean done;

  public Rectangle(
    float x,
    float y,
    float rectWidth,
    float rectHeight,
    float hue,
    PImage img
  ){
    this.x = x;
    this.y = y;
    this.rectWidth = rectWidth;
    this.rectHeight = rectHeight;
    this.hue = hue;
    this.done = false;
    this.img = img;
  }
}
