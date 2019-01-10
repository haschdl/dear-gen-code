
import java.text.SimpleDateFormat;  
import java.util.Date;  


float n = 1000;
float s = 1;

PGraphics buffer;
float w, h;


//int[] palette = new int[]{ #88498F, #779FA1, #E0CBA8, #FF6542, #564154 };
int[] palette = new int[]{ #FFF8CE, #F2992A, #AF6709, #F7D083, #BA6928 };


void setup() {
  size(900, 600, P2D);
  buffer = createGraphics(3000, 2000, P2D);
  w = buffer.width;
  h = buffer.height;
  buffer.beginDraw();
  buffer.background(255);
  buffer.endDraw();
  background(255);
  frameRate(120);
}

float a = 100;
void draw() {  
  //a = map(mouseX,0,width,-10,10);
  surface.setTitle(String.format("Frames: %d FPS: %.0f n=%.0f", frameCount, frameRate, n));

  //int color_i = floor(frameCount / 1000);
  //float offSetY = color_i * h/5;

  buffer.beginDraw();
  buffer.noStroke();
  buffer.translate(0, h/2);
  for (float i = 0; i < n; i++) {
    color c = 80;
    float x = w/n  * i;
    float y = tan(a*x + a * x*x)  * map(mouseX, 0, width, 1, 1000);


    buffer.fill(c, 20);// + abs(y/h)*80);
    s= 8 + 6*pow(abs(y/h), 1.2);
    buffer.ellipse(x, y, s, s);
  }
  buffer.endDraw();

  image(buffer, 0, 0, width, height);
}

void keyPressed() {
  if (key == 'S' || key == 's') {
    SimpleDateFormat formatter = new SimpleDateFormat("YYYYMMDD_HHmmss");  
    Date date = new Date();  
    buffer.save(String.format("/out/infinitesimal_%s_frame=%d_s=%.1f.png", formatter.format(date), frameCount, s));
    println("Composition saved!");
  }
}
