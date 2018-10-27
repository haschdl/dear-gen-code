public class Hexagon {

  PGraphics hBuffer;
  ArrayList<PVector> basePolygon = new ArrayList<PVector>();
  ArrayList<PVector> vertices = new ArrayList<PVector>();

  int maxIterations;
  private float w, h;
  int hColor;

  float gaussianD = 40;

  PShader shader;

  boolean done = false;

  public Hexagon(float radius, int sides, int iterations, int maxIterations, float gaussianD) {
    this.maxIterations = maxIterations;
    this.w = radius*2; 
    this.h = radius*2;
    this.gaussianD = gaussianD;

    basePolygon = blob(radius, sides, iterations);
    vertices = deformBlob(basePolygon, 1);
    hBuffer = createGraphics(int(this.w), int(this.h), P2D);

    hBuffer.beginDraw();
    hBuffer.background(255, 0);    
    hBuffer.noStroke();
    hBuffer.endDraw();
  }

  void draw() {
    if (done)
      return;
    hBuffer.beginDraw();

 
    hBuffer.translate(w*0.5, h*0.5);
    hBuffer.fill(hColor, 2);// - (float)frameCount/maxIterations);
    hBuffer.beginShape();
    for (int i = 0, l = this.vertices.size(); i < l; i++) {
      PVector p = this.vertices.get(i);
      hBuffer.vertex(p.x, p.y);
    }
    hBuffer.endShape(CLOSE);
    hBuffer.endDraw();

    if (frameCount < maxIterations) {
      vertices = deformBlob(basePolygon, 5);
    } else {
      done = true;
    }
  }

  ArrayList<PVector> blob(float radius, int sides, int iterations) {
    ArrayList<PVector> basePolygon = polygon(radius, sides);  
    return deformBlob(basePolygon, iterations);
  }




  ArrayList<PVector> deformBlob(ArrayList<PVector> basePolygon, int iterations) {
    ArrayList<PVector> blob = new ArrayList<PVector>();
    blob.clear();
    for (int j=0, si=basePolygon.size(); j<si; j++) {
      PVector v = basePolygon.get(j);
      blob.add(new PVector(v.x, v.y));
    }


    for (int i = 1; i < iterations; i++) {
      println(String.format("Deform blob. Iteration: %d Vertex count: %d", i, blob.size()));
      vertices = new ArrayList<PVector>();
      for (int v =0, l = blob.size(); v<l; v++) {
        PVector A = blob.get((v%l));
        PVector C = blob.get((v+1)%l);
        PVector B = PVector.lerp(A, C, .5); //medium point
   
        float D = 2;
        if (frameCount < 3) {
          D = 20;
        }
        B.x +=randomGaussian()* A.dist(C)/D;// Define a standard deviation
        B.y +=randomGaussian() * A.dist(C)/D;// Define a standard deviation



        //vertices on A, M, B
        vertices.add(A);
        vertices.add(B);
      }
      blob.clear();
      for (int j=0, si=vertices.size(); j<si; j++) {
        PVector v = vertices.get(j);
        blob.add(new PVector(v.x, v.y));
      }
    }

    println(String.format("Deform blob. Iteration: %d Vertex count: %d", iterations, blob.size()));
    vertices.clear();
    return blob;
  }

  //Source: https://processing.org/examples/regularpolygon.html
  ArrayList<PVector> polygon( float radius, int npoints) {
    float angle = TWO_PI / npoints; 
    ArrayList<PVector> p = new ArrayList<PVector>(); 
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx =  + cos(a) * radius; 
      float sy =  + sin(a) * radius; 
      p.add(new PVector(sx, sy));
    }
    return p;
  }
}
