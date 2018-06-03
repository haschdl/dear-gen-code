/** //<>//
  "Rosário"
  A water-color like composition with warm colors.
  Half Scheidl, 2018 
*/

ArrayList<PVector> basePolygon = new ArrayList<PVector>();
ArrayList<PVector> vertices = new ArrayList<PVector>();
int[] palette = new int[]{ 0xFFE28413, 0xFFF56416, 0xFFDD4B1A, 0xFFEF271B, 0xFFEA1744 };

int h = 2000, w = 3000;
PGraphics buffer, buffer2;

float blobRadius= 200;

void setup() {
  size(1200, 800, P2D);
  noiseMask = createGraphics(w, h);
  buffer = createGraphics(w, h);
  buffer2 = createGraphics(w, h);
  prepareMask();

  background(255);
  buffer.beginDraw();
  buffer.background(255);
  buffer.noStroke();
  buffer.endDraw();

  buffer2.beginDraw();
  buffer2.background(255);
  buffer2.endDraw();
  basePolygon = blob(blobRadius, 10, 3);
}

void draw() {
  //prepareMask();
  buffer2.beginDraw();

  buffer2.noStroke();


  float offsetX = 100;
  buffer2.translate(offsetX*2, blobRadius  );
  int loop = int((w - blobRadius -offsetX) / offsetX);
  float offsetY =  offsetX * floor((frameCount-1)/loop);
  buffer2.translate(offsetX*((frameCount)%loop),offsetY);
  buffer2.fill(palette[int(random(5))], 12);
  buffer2.beginShape();
  for (int i = 0, l = vertices.size(); i < l; i++) {
    PVector p = vertices.get(i);
    buffer2.vertex(p.x, p.y);
  }
  buffer2.endShape(CLOSE);

  buffer2.mask(noiseMask);
  buffer2.endDraw();


  buffer.beginDraw();
  buffer.image(buffer2, 0, 0);
  buffer.endDraw();

  if (offsetY < h - blobRadius - offsetX) {
    vertices = deformBlob(basePolygon, 7);
    image(buffer, 100, 100, width-200, height-200);
  } else {
    println("Done");
    noLoop();
  }
}


ArrayList<PVector> blob(float radius, int sides, int iterations) {
  ArrayList<PVector> basePolygon = polygon(radius, sides);
  return deformBlob(basePolygon, iterations);
}

/**
 Given a list of vertices of a polygon, it generates a new polygon by spliting
 and distorting the sides. 
 For details see http://www.tylerlhobbs.com/writings/watercolor
*/
ArrayList<PVector> deformBlob(ArrayList<PVector> basePolygon, int iterations) {
  ArrayList<PVector> blob = new ArrayList<PVector>();
  blob.clear();
  for (int j=0, si=basePolygon.size(); j<si; j++) {
    blob.add(basePolygon.get(j));
  }

  for (int i = 1; i < iterations; i++) {
    vertices = new ArrayList<PVector>();
    for (int v =0, l = blob.size(); v<l; v++) {
      PVector A = blob.get((v%l));
      PVector B = blob.get((v+1)%l);
      PVector C = PVector.lerp(A, B, 0.5); //medium point

      // Get a gaussian random number w/ mean of 0 and standard deviation of m
      // moves point B by adding to the Gaussian number
      float m = A.dist(B);
      C.x +=randomGaussian() * m * .25;
      C.y +=randomGaussian() * m * .25;
      
      vertices.add(A);
      vertices.add(C);      
      //Note we don't add "B", since it would be added twice
      //"B" is "A" in the next iteration of "i"

    }
    blob.clear();
    for (int j=0, si=vertices.size(); j<si; j++) {
      blob.add(vertices.get(j));
    }
  }
  vertices.clear();
  return blob;
}

void keyPressed() {
  if (key == 'S' || key == 's') {
    buffer.save(String.format("water_color_%02d%02d%02d.tiff", hour(), minute(), second()));
    println("Composition saved!");
  }
}
