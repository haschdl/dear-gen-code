PGraphics buffer;
PShape ant;

//input control
int lastPressed = 0;

//int[] palette = new int[]{ #415350, #AAA89C, #E7E7E6, #3F5D77, #A35279 };
int[] palette = new int[]{ #88498F, #779FA1, #E0CBA8, #FF6542, #564154 };



Galaxy[] universe;
float phi = (1 + sqrt(5))/2;
float[] moves_x;
float[] moves_y;
PVector margin ;
void setup() {
  buffer = createGraphics(6000, 3000);
  buffer.imageMode(CENTER);

  ant = loadShape("ant.svg");
  float margin_pct = .03;

  size(1000, 500);
  moves_x = new float[]{+1, +pow(1/phi, 2), -1/phi, 0};
  moves_y = new float[]{-1, 0, 1*phi, 1/phi};

  int iterations = 14;
  universe = new Galaxy[iterations];
  margin = new PVector(buffer.width*margin_pct, buffer.height*margin_pct);


  float h = buffer.height * (1-2*margin_pct);


  float x = 0, y = h;
  for (int i=0; i<iterations; i++) {
    y += h*  moves_y[i%4];//* (i%2);
    //buffer.rect(x, y, h, h);
    universe[i] = new Galaxy(x + h/2, y+h/2, h);
    x += h  * moves_x[i%4];
    h/=phi;
  }
}

void drawGoldRectangle() {
  buffer.beginDraw();  
  buffer.translate(margin.x, margin.y);
  buffer.rectMode(CENTER);
  buffer.strokeWeight(5); //buffer.rect(0, 0, h, h);
  for (int i=0, l = universe.length; i<l; i++) {
    Galaxy g = universe[i]; 
    buffer.rect(g.pos.x , g.pos.y, g.max_width, g.max_width);
  }
  buffer.endDraw();
}

void draw() {
  buffer.beginDraw();
  buffer.ellipseMode(CORNER); 
  buffer.background(255);

  drawGoldRectangle() ;
  buffer.endDraw();
  float l = 35;
  for (Galaxy r : universe) {
    buffer.beginDraw();
    buffer.noStroke();
    buffer.translate(margin.x + r.pos.x - r.max_width/2, margin.y + r.pos.y- r.max_width/2);
    float x, y=0;
    float x_n = r.max_width/l;

    if (l<=0)
      break;
    for (int i=0; i<=pow(r.max_width/l, 2); i++) {
      x =  (i % l) * x_n;
      y =  floor((float)i/l) * x_n;
      if ((y+l/2) >=r.max_width || (x+l) >= r.max_width)
        break;
      buffer.pushMatrix();
      buffer.translate(x +l/2, y);

      int color_i;


      color_i =  int(random(palette.length));
      buffer.fill(color(palette[color_i]));

      buffer.rotate(noise(x, y) * HALF_PI);
      // Disable the colors found in the SVG file
      ant.disableStyle();
      //buffer.shape(ant, 0, 0, x_n * .75 * (m-j)/m, x_n * .75 * (m-j)/m);

      float whichShape = random(1.0); 
      if (whichShape<.33)
        buffer.triangle(0, 0, x_n * .75, 0, x_n * .75/2, x_n * .75);
      else if (whichShape <.66)
        buffer.ellipse(0, 0, x_n * .75, x_n * .75);
      else
        buffer.rect(0, 0, x_n * .75, x_n * .75);



      buffer.popMatrix();
    }
    l = floor(l* .8);
  }


  buffer.endDraw();

  //img.mask(buffer);
  image(buffer, 0, 0, width, height);
  noLoop();
}

void keyPressed() {
  if (key == 'S' || key == 's') {
    buffer.save(String.format("universe%d.tiff", frameCount));
    println("Composition saved!");
  }
}
