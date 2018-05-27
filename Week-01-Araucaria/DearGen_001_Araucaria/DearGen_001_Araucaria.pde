/*
 * Half Scheidl
 * Code for https://github.com/haschdl/dear-gen/tree/master/Week-01-Araucaria
 * Part of the Dear Gen project, see https://github.com/haschdl/dear-gen
 */

float h, w;
float stem_width = 5;
PGraphics buffer1;
PGraphics buffer2;
ArrayList<Tree> trees = new ArrayList<Tree>();
int mainColor;
void setup() {
  size(1000, 500);
  buffer1 = createGraphics(5000, 2500);
  buffer2 = createGraphics(5000, 2500);
  h = buffer1.height;
  w = buffer1.width;
  mainColor = color(56, 90, 78);
  background(255);
  smooth();
}

void draw() {
  buffer1.beginDraw();
  buffer1.background(255, 2);
  buffer1.translate(0, h/2);
  buffer1.endDraw();

  trees.clear();
  float three_height = 400;
  int t_per_row = int((float)h/three_height);
  int n_trees = 10;

  float x=0, y=0;
  Tree t = new Tree(buffer1, 0., 0., 0., 0.);
  for (int i=0; i<n_trees; i++) {
    x =  w/n_trees * (.5 + i + .1 *(1 - 2*noise(i+millis()))) + 20 ;
    y =  three_height * ((frameCount-1) % t_per_row) + frameCount*10 + 10 ;
    x = max(x, t.pos.x+t.tree_width + 10);

    float alpha = 255;
    t = new Tree(buffer1, x, y, three_height, stem_width);
    t.alpha = alpha;
    t.leaf_color = color(0, 116, 98);
    t.n_branches = int(8 + 3* randomGaussian());
    if (t.n_branches > 4)
      trees.add(t);
    else
      i--;
  }
  for (Tree tree : trees) {
    tree.draw();
  }

  buffer2.beginDraw();
  buffer1.background(255, 5);
  buffer2.image(buffer1, 0, 0, w, h);
  buffer2.endDraw();
  image(buffer2, 0, 0, width, height);
  if (frameCount >= t_per_row)
    noLoop();
}

void keyPressed() {
  if (key == 'S' || key == 's') {
    buffer2.save(String.format("/out/araucaria_%d.tiff", frameCount));
    println("Composition saved!");
  }
}
