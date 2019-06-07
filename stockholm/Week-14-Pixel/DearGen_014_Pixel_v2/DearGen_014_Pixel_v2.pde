/*
 *
 *
 */ 

/**
 * The maximum number of times a dot can be divided.
 */
private static final int MAX_DOT_DIVISIONS = 8; 

/**
 * The minimal radius of a dot, in pixels.
 */
private float MIN_DOT_SIZE;

/**
 * The smallest radius a dot can have before the program makes it easier to clear.
 */
private static float MIN_UNASISTED_RADIUS; 


/**
 * All the Dots on the screen.
 */
private ArrayList<Dot> dots;

/**
 * All the AnimatedSections currently being animated (drawn each frame).
 */
private ArrayList<AnimatedSection> sections;

/**
 * The background image that will be revealed.
 */
static PImage photo;

/**
 * A vector from the cursor position in the previous frame to the current cursor position.
 * Linearly approximates the path the cursor took between frames.
 */
PVector cursorPath;

/**
 * Sets up the program, runs at program start-up / reset.
 */
void setup() {

  photo = loadImage("klimt.jpg");
  
  size(1200, 800); 
  photo.resize(width, height);
  
  noStroke();
  ellipseMode(RADIUS);
  rectMode(CENTER);
  int minHeightWidth = min(width, height);
  
  MIN_DOT_SIZE = minHeightWidth / pow(2, MAX_DOT_DIVISIONS);
  MIN_UNASISTED_RADIUS = minHeightWidth / pow(2, 7);

  // Update the pixels[] array for photo
  photo.loadPixels();
  
  sections = new ArrayList<AnimatedSection>();
  dots = new ArrayList<Dot>();
  Dot firstDot = new Dot(0,0, width);
  dots.add(firstDot);

  background(255);
  firstDot.draw();
}


void draw() {
  drawSections();
  cursorPath = new PVector(mouseX - pmouseX, mouseY - pmouseY);
  // If the cursor has moved. 
  if (cursorPath.magSq() >= 1) { 
    ArrayList<Dot> tempDotsToRemove = new ArrayList<Dot>();
    for (Dot dot : dots) {
      // dot should only divide if cursor starts outside of dot and then enters it.
      boolean pathStartsOutsideDot = dist(dot.x, dot.y, pmouseX, pmouseY) > dot.radius; 
      if (pathStartsOutsideDot && pathIntersectsDot(dot)) {
        sections.add(new AnimatedSection(dot));
        tempDotsToRemove.add(dot);
      }
    }
    dots.removeAll(tempDotsToRemove);
  }
}

void drawSections() {
  ArrayList<AnimatedSection> tempSectionsToRemove = new ArrayList<AnimatedSection>();

  for (AnimatedSection section : sections) {
    if (section.drawSection()) {
      Dot[] dotsCreated = section.getDotsCreated();
      // All dots in section same size, if Dot is min size, don't add the Dots from this 
      // section to dots because we don't want to divide them anymore.
      if (dotsCreated[0].radius > MIN_DOT_SIZE) { 
        for (Dot dot : section.getDotsCreated()) {
          dots.add(dot);
        }
      }
      tempSectionsToRemove.add(section);
    }
  }
  sections.removeAll(tempSectionsToRemove);
}

/**
 * Return the minimal distance from the center of dot to anywhere on the cursorPath vector.
 * 
 * @param dot The dot which we are computing the distance to.
 * @return the minimal distance from the center of dot to anywhere on the cursorPath vector.
 */
private float distToCursorPath(Dot dot) {
  PVector oldCursorToDot = new PVector(dot.x - pmouseX, dot.y - pmouseY); // Vector from old cursor position to center of dot.
  PVector currentCursorToDot = new PVector(dot.x - mouseX, dot.y - mouseY); // Vector from current cursor position to center of dot.
  PVector reverseCursorPath = PVector.mult(cursorPath, -1); // Vector from the current cursor position to the old cursor position.

  // Case (1)
  float angleOldToCurrent_OldToDot = PVector.angleBetween(cursorPath, oldCursorToDot);
  /*
   If the angle between these vectors is obtuse, then the dot lies behind the cursorPath 
   vector and the point on the cursorPath vector which is closest to dot is the starting 
   point; the old cursor position.
   */
  if (angleOldToCurrent_OldToDot > HALF_PI) {
    return dist(dot.x, dot.y, pmouseX, pmouseY);
  }

  // Case (2)
  float angleCurrentToOld_CurrentToDot = PVector.angleBetween(reverseCursorPath, currentCursorToDot);
  /*
   If the angle between these vectors is obtuse, then the dot lies in front of the cursorPath 
   vector and the point on the cursorPath vector which is closest to dot is the ending point; the 
   current cursor position.
   */
  if (angleCurrentToOld_CurrentToDot > HALF_PI) {
    return dist(dot.x, dot.y, mouseX, mouseY);
  }

  // Case (3)
  /* 
   If both of the above angles are acute, then the dot is between the endpoints of the cursorPath vector and the 
   point on the path which is closest to the dot is somewhere along the path and not one of the endpoints. The 
   magnitude of vector perpendicular to cursorPath with endpoints at the intersection points of dot and cursorPath 
   is the minimal distance from dot to cursorPath. We calculate this by forming a right triangle and using trigonometry.
   */
  return sin(angleOldToCurrent_OldToDot) * oldCursorToDot.mag(); // Angles always positive for non-zero vectors -> sin(angle) is positive.
}

boolean pathIntersectsDot(Dot dot) {
  float maxDistance;
  float radius = dot.radius;
  if (radius < MIN_UNASISTED_RADIUS) {
    // It's annoyingly difficult to clear the very small dots, so we make it slightly more forgiving.
    maxDistance =  radius * 1.4;
  } else {
    maxDistance = radius;
  }
  return distToCursorPath(dot) <= maxDistance;
}

void keyPressed() {
  if (key == ' ' || key == 'n' || key == 'r') {
    setup();
  }
}
