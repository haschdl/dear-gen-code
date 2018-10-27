



/* 
 import pLaunchController.*;
 LaunchController controller;
 */

PGraphics buffer;

//Parameters for the drawing. Change as you wish, or update the values in draw() using 
//for example mouseX or mouseY
float n_curves = 72;
float transp = 125;
float tightness = 5.5;


//Colors for the drawing, in hexadecimal 
int[] palette = new int[]{(0x292F36), (0x4ECDC4), (0xE1E8E1), (0xFF6B6B), (0xFFE66D)};


ArrayList<MyCurve> curves = new ArrayList<MyCurve>();

boolean wait = false;

void setup() {

  /*
  try {
   controller = new LaunchController(this);
   controller.getKnob(KNOBS.KNOB_1_HIGH).range(10, 500).defaultValue(72).variable("n_curves");
   controller.getKnob(KNOBS.KNOB_2_HIGH).range(0, 255).defaultValue(125).variable("transp");
   controller.getKnob(KNOBS.KNOB_3_HIGH).range(-10, 10).defaultValue(5.5).variable("tightness");
   }
   catch(Exception e) {
   println("Unfortunately we could not detect that Launch Control is connected to this computer :(");
   }
   */
  size(900, 600);
  buffer = createGraphics(1800, 1200);

  resetCurves();
}

/*
void launchControllerKnobChanged(KNOBS knob) {
 if (knob == KNOBS.KNOB_1_HIGH)
 resetCurves();
 } 
 */

void resetCurves() {
  wait = true;
  curves.clear();
  PVector m;
  float n_x = 10;
  float n_y = n_curves/n_x;

  float w = buffer.width; 
  float h = buffer.height;

  for (int i = 1; i <= n_curves; i++) {
    float x = (i % int(n_x)) * w/(n_x-1);
    float y = floor(i / (n_x-1)) * h/n_y;
    m = new PVector( x + randomGaussian()*0, y + randomGaussian()*0);
    int nextColor = palette[(int)random(palette.length)];
    curves.add(new MyCurve(m, int(random(10, 15)), nextColor)); //adds 4 to 5 points
  }
  wait = false;
}

void draw() {
  surface.setTitle(String.format("n_curves=%.0f,transp=%.1f, tightness=%.1f", n_curves, transp, tightness));

  if (wait) 
    return;

  buffer.beginDraw();
  buffer.background(255);
  buffer.smooth();
  buffer.stroke(0, 200);



  for (int i = 0; i < curves.size(); i++) {
    MyCurve curve = curves.get(i);
    curve.draw(buffer);
  }

  buffer.endDraw();
  image(buffer, 0, 0, width, height);
}


public void mousePressed(MouseEvent evt) {
  MyCurve lastCurve = curves.get(curves.size()-1);
  if (mouseButton == CENTER) {

    lastCurve.points.add(lastCurve.points.get(1).copy());
    lastCurve.points.add(lastCurve.points.get(1).copy());
  } else  if (mouseButton == LEFT) {
  } else if (mouseButton == RIGHT) {

    int nextColor = palette[(int)random(palette.length)];
    curves.add(new MyCurve( new PVector(100, 100), 15, nextColor ));
  }
}
