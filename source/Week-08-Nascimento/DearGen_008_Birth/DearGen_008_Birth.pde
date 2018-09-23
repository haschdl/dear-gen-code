int n_horiz = 3;
int n_verti = 3;

ArrayList<PShader> voronoiShaders = new ArrayList<PShader>();
PGraphics buffer;
int[] palette = new int[]{0xFFE28413, 0xFFF56416, 0xFFDD4B1A, 0xFFEF271B, 0xFFEA1744};


void setup() {
  size(1273,849, P2D);
  buffer = createGraphics(width, height, P2D);
  background(255);

  for (int s = 0; s < n_horiz * n_verti; s++) {
    PShader voronoiShader = loadShader("voronoi.frag");
    voronoiShader.set("iResolution", float(width), float(height));
    voronoiShaders.add(voronoiShader);
  }
}

void draw() {
  for (int i = 0; i < n_horiz; i++) {
    for (int j = 0; j <n_verti; j++) {
      int ix = j*n_verti+i;
      PShader voronoiShader = voronoiShaders.get(i);
      voronoiShader.set("iTime", (noise(i*24554)*1000 + millis()) / 1000.0);
      voronoiShader.set("n_points", pow(2, ix));
      voronoiShader.set("fillRate", map(ix, 0, n_horiz*n_verti, .1,.9) );
      int _c = palette[ix % palette.length];
      //R,G,B with bit shifting
      voronoiShader.set("baseColor", float( _c >> 16 & 0xFF)/255, float(_c >> 8 & 0xFF)/255,float( _c & 0xFF)/255);
      
      buffer.filter(voronoiShader);
      image(buffer, i * width/n_horiz, j * height/n_verti, width/n_horiz, height/n_verti);
    }
  }
}
