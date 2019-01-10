import pLaunchController.*;
LaunchController controller;


PGraphics buffer;

//Parameters for the drawing. Change as you wish, or update the values in draw() using 
//for example mouseX or mouseY
float n_curves = 1; 
float transp = 125; 
float tightness = 5.5;



MyCurve curve; 

boolean wait = false;

void setup() {
  try {
    controller = new LaunchController(this);
    controller.getKnob(KNOBS.KNOB_1_HIGH).range(1, 500).defaultValue(1).variable("n_curves");
    controller.getKnob(KNOBS.KNOB_2_HIGH).range(0, 255).defaultValue(125).variable("transp");
    controller.getKnob(KNOBS.KNOB_3_HIGH).range(-10, 10).defaultValue(5.5).variable("tightness");
  }
  catch(Exception e) {
    println("Unfortunately we could not detect that Launch Control is connected to this computer :(");
  }

  size(600, 600);

  resetCurves();
}

void launchControllerKnobChanged(KNOBS knob) {
  resetCurves();
} 


void resetCurves() {
  wait = true;
  curve = new MyCurve(new PVector(  0, 0), int(random(30, 50)), 0x292F36); //adds 4 to 5 points

  wait = false;
}

void draw() {
  surface.setTitle(String.format("n_curves=%.0f,transp=%.1f, tightness=%.1f", n_curves, transp, tightness));



  if (wait) 
    return;

  translate(width/2, height/2);
  background(255);
  smooth();
  stroke(0, 200);

  curve.draw(((PApplet)this).g);
}
