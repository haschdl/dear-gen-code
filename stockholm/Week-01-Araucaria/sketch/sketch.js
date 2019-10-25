/*
 * Half Scheidl
 * Code for https://github.com/haschdl/dear-gen/tree/master/Week-01-Araucaria
 * Part of the Dear Gen project, see https://github.com/haschdl/dear-gen
 */

let h, w;
let stem_width = 5;
let buffer1;
let buffer2;
let trees = [];
let mainColor;
function setup() {
  createCanvas(900, 600);
  buffer1 = createGraphics(5000, 3333);
  buffer2 = createGraphics(5000, 3333);
  h = buffer1.height;
  w = buffer1.width;
  mainColor = color(56, 90, 78);
  background(255);
}

function draw() {
  /*   buffer1.beginDraw(); */
  buffer1.background(255, 2);
  buffer1.translate(0, 0);

  trees = [];
  let three_height = 450;
  let t_per_row = Math.floor(h / three_height);
  console.log(t_per_row);
  let n_trees = 8;

  let x = 0,
    y = 0;
  let t = new Tree(buffer1, 0, 0, 0, 0);
  for (let i = 0; i < n_trees; i++) {
    x = (w / n_trees) * (0.5 + i + 0.1 * (1 - 2 * noise(i + millis()))) + 20;
    y = three_height * ((frameCount - 1) % t_per_row) + frameCount * 10 + 10;
    x = max(x, t.pos.x + t.tree_width + 10);
    t = new Tree(buffer1, x, y, three_height, stem_width);
    t.leaf_color = color(0, 116, 98);
    t.n_branches = int(8 + 3 * randomGaussian());
    if (t.n_branches > 4) trees.push(t);
    else i--;
  }
  for (tree of trees) {
    tree.draw();
  }

  /*   buffer2.beginDraw(); */
  buffer1.background(255, 5);
  buffer2.image(buffer1, 0, 0, w, h);

  image(buffer2, 0, 0, width, height);

  if (frameCount >= t_per_row) noLoop();
}

function keyPressed() {
  if (key == "S" || key == "s") {
    buffer2.save(String.format("/out/araucaria_%d.tiff", frameCount));
    console.debug("Composition saved!");
  }
}
