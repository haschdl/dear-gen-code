/*
 *
 * Keyboard commands:
 *   S - saves the sketch to a JPG image, as shown in the screen. Image resolution is the sketch size
 *   F - saves the Final image, for printing. Re
 *
 */

//int[] palette = new int[]{  0xFF780116, 0xFFF7B538, 0xFFDB7C26, 0xFFD8572A, 0xFFC32F27 };
int[] palette = new int[]{ 0xFF7C0034, 0xFFF02D57, 0xFF0B1240, 0xFF343C9F};

ArrayList<Vehicle> vs = new ArrayList<Vehicle>();
FlowField flowField ;
PGraphics buffer;
Params p = new Params();

void setup() {

  size(1200, 800);
  p.maxspeed = .2;
  p.maxforce = 1;
  p.maxframes = 250;
  p.alpha = 80;
  p.n = 300;
  p.res = 20;

  println(p.toString());
  //randomSeed(144542);
  buffer = createGraphics(1800, 1200);

  //making a matrix with p.n elements
  float ratio = (float)buffer.width/buffer.height;

  int cols = int(sqrt(p.n * ratio));
  int rows = int(sqrt(p.n * ratio) / ratio);
  float xo = buffer.width/cols;
  float yo = buffer.height/rows;

  println(String.format("Cols: %d Rows: %d", cols, rows));

  for (float x=0; x<buffer.width; x+=xo) {
    for (float y=0; y<buffer.height; y+=yo) {
      vs.add(new Vehicle(x, y, p.maxspeed, p.maxforce, p.alpha));
    }
  }


  flowField = new FlowField(p.res);
  background(255);
  buffer.beginDraw();
  buffer.background(255);
  buffer.endDraw();
}

void draw() {
  surface.setTitle(String.format("FPS: %.1f Frames: %d", frameRate, frameCount));

  buffer.beginDraw();
  for (Vehicle v : vs) {
    //v.seek(new PVector(mouseX,mouseY));
    v.seek(new PVector(v.loc.x, buffer.height*4));
    v.follow(flowField);
    v.update();
    v.display(buffer);
  }
  buffer.endDraw();
  
  //shows the content of the buffer in the screen
  image(buffer, 0, 0, width, height);
  
  //flowField.display();
  if (frameCount == p.maxframes)
  {
    fill(0);
    text(p.toString(), 10, 10);
    noLoop();
    println(String.format("Stopped at %d frames", frameCount));
  }
}
