// Noto Sans: Lating, Greek, Cirylic, Devanagari

// Unicode blocks: https://en.wikipedia.org/wiki/Category:Unicode_blocks
// Latin A-Z: 0x0061 - 0x007A  https://en.wikipedia.org/wiki/Basic_Latin_(Unicode_block)
// Greek A-Z: 0x03B1 - 0x03EF

ArrayList<UnicodeBlock> unicodeBlocks;
PGraphics buffer, bufLetters;
float W, H, l;
int cols, rows;
PShape hexagon;

ArrayList<Hexagon> hexagons;
ArrayList<Hexagon> hexagonsBlur;

int[] palette = new int[]{ #BCF8EC, #F74040, #FFEF3F, #E25C2F, #FF924F, 0xFF0A2E36, 0xFF193C44, 0xFF2C5760, 0xFF316672, 0xFF2E2E2E  };


//The height of the hexagon is two times the height of
//each of the six equilateral rectangles of side l, which is l * sqrt(3)/2
float HEXAGON_HEIGHT = sqrt(3)/2;
float angle;

PFont notoSans, notoSansCJK, franRuhlLibre, pridi, suranna;
void setup() {
  size(1200, 800, P2D);
  buffer = createGraphics(1200, 800, P2D);
  bufLetters= createGraphics(1200, 800, P2D);
  notoSans = loadFont("NotoSans-128.vlw");
  notoSansCJK = loadFont("NotoSansCJKjp-Regular-48.vlw");
  franRuhlLibre = loadFont("FrankRuhlLibre-Regular-48.vlw");
  pridi = loadFont("Pridi-Regular-48.vlw");
  suranna = loadFont("Suranna-48.vlw");

  smooth(8);

  unicodeBlocks = new ArrayList<UnicodeBlock>();

  //Code blocks from Noto Sans
  unicodeBlocks.add(new UnicodeBlock(notoSans, 0x0061, 0x007A, 80)); // Latin
  unicodeBlocks.add(new UnicodeBlock(notoSans, 0x03B1, 0x03EF, 80)); // Greek
  unicodeBlocks.add(new UnicodeBlock(notoSans, 0x0430, 0x044F, 80)); // Cyrillic
  unicodeBlocks.add(new UnicodeBlock(notoSans, 0x0905, 0x0939, 80)); // Devaganari


  ////Code blocks from NotoSans CJK
  unicodeBlocks.add(new UnicodeBlock(notoSansCJK, 0x7B02, 0x7C6C, 40));  // Japanese Kanji  https://en.wikipedia.org/wiki/Katakana_(Unicode_block)
  unicodeBlocks.add(new UnicodeBlock(notoSansCJK, 0x4F3D, 0x99D5, 40));  // Korean Hanja by Hangul
  unicodeBlocks.add(new UnicodeBlock(notoSansCJK, 0x5315, 0x8953, 40));  // Traditional Chinese by Bomofo

  ////Code block from FrankRuhlLibre (Hebrew)
  unicodeBlocks.add(new UnicodeBlock(franRuhlLibre, 0x05D0, 0x05EA, 80)); // Hebrew
  unicodeBlocks.add(new UnicodeBlock(pridi, 0x0E01, 0x0E2E, 80));  // Thai
  unicodeBlocks.add(new UnicodeBlock(suranna, 0x0C05, 0x0C39, 80)); // Telugu

  W = buffer.width;
  H = buffer.height;

  //the checker
  cols = 5;
  l =  .5 * W / cols ; //Radius of the ellipse around the polygon
  rows = floor(H/(l)*2);
  hexagons = new ArrayList<Hexagon>();
  hexagonsBlur= new ArrayList<Hexagon>();
  for (int i = 0; i < cols * rows; i ++) {
    int hexagonColor = palette[int(random(palette.length))];
    Hexagon oHexagon = new Hexagon(l, 6, 5, 50, 20);
    oHexagon.hColor = hexagonColor;
    hexagons.add(oHexagon);

    Hexagon oHexagonBlur = new Hexagon(l, 6, 5, 50, 2);
    oHexagonBlur.hColor = hexagonColor;
    hexagonsBlur.add(oHexagonBlur);

    println(String.format("Hexagon setup ready! (%d/%d)", i+1, cols*rows));
  }
}


void draw() {
  background(255);

  bufLetters.beginDraw();  
  bufLetters.background(20, 0);
  bufLetters.endDraw();

  buffer.beginDraw();
  buffer.strokeWeight(0);

  hexagon  = polygon(l* .8, 6);
  surface.setTitle(String.format("frame=%d buf=[%.0f,%.0f] Cols = %d, rows = %d , l = %.2f", frameCount, W, H, cols, rows, l));


  //hexagons
  buffer.pushMatrix();
  for (int j = 0; j < rows; j++) {
    buffer.pushMatrix();
    buffer.translate(l * 1.5 * ( j % 2), 0);
    for (int i = 0; i < cols; i ++) {
      Hexagon oHexagon = hexagons.get(j*cols + i);
      Hexagon oHexagonBlur = hexagonsBlur.get(j*cols + i);
      oHexagon.draw();

      buffer.pushMatrix();
      buffer.translate(-l/2, -l/2);
      buffer.image(oHexagonBlur.hBuffer, -l/2, -l/2);
      buffer.image(oHexagon.hBuffer, -l/2, -l/2);
      buffer.popMatrix();

      buffer.translate(l * 3, 0 );
    }
    buffer.popMatrix();
    buffer.translate(0, l * HEXAGON_HEIGHT);
  }
  buffer.popMatrix();

  // Letters
  if (frameCount > 100) {
    drawLetters( bufLetters, l, rows, cols);

    buffer.image(bufLetters, 0, 0);
  }
  buffer.endDraw();



  //placing composition on screen
  image(buffer, 0, 0, width, height);

  if (frameCount > 100)
    saveFrame();
}

void drawLetters(PGraphics target, float l, int rows, int cols) {
  target.beginDraw();
  target.noStroke();
  target.textAlign(CENTER, CENTER);
  for (int j = 0; j < rows; j++) {
    target.pushMatrix();
    target.translate(l * 1.5 * ( j % 2), 0);

    for (int i = 0; i < cols; i ++) {
      UnicodeBlock g = unicodeBlocks.get((j*rows + i )% unicodeBlocks.size());
      target.textFont(g.font, 64);

      target.pushMatrix();

      int n = 1000;
      float textSize = 30;

      target.textSize(textSize);

      //generating a few letters inside hexagon
      float validLetters = 0;

      for (int letterCounter = 0; letterCounter <= n; letterCounter++) {
        if (validLetters >= g.density) {
          break;
        }

        PVector point = new PVector(randomGaussian()* l, randomGaussian()* l  );
        int charToPrint = int(random(g.low, g.high));
        String text = new String(Character.toChars(charToPrint));

        if (!InsideHexagon(point.x, point.y, l*.93) || !InsideHexagon(point.x + textWidth(text)/2, point.y, l*.93) ) 
          continue;

        float textSizeAdj = floor(textSize * (.3 + .9 * pow((float)validLetters/g.density, 5)));
        target.textSize(textSizeAdj);
        target.fill(0, 255);
        target.pushMatrix();
        target.translate(point.x, point.y);
        target.rotate(-HALF_PI/3);

        target.text(text, 0, 0);    
        target.popMatrix();
        validLetters++;
      }
      target.popMatrix();
      target.translate(l * 3, 0 );
    }
    target.popMatrix();
    target.translate(0, l * HEXAGON_HEIGHT);
  }
  target.endDraw();
}


//Source: https://processing.org/examples/regularpolygon.html
PShape polygon( float radius, int npoints) {
  float angle = TWO_PI / npoints; 
  PShape p = buffer.createShape();

  p.beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx =  + cos(a) * radius; 
    float sy =  + sin(a) * radius; 
    p.vertex(sx, sy);
  }
  p.endShape(CLOSE);
  return p;
}
