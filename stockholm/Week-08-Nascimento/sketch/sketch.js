const n_horiz = 3;
const n_verti = 3;
const voronoiShaders = [];
let buffer;

const palette = [0xffe28413, 0xfff56416, 0xffdd4b1a, 0xffef271b, 0xffea1744];

function preload() {
  for (let s = 0; s < n_horiz * n_verti; s++) {
    const voronoiShader = loadShader('data/voronoi.vert', 'data/voronoi.frag');
    voronoiShaders.push(voronoiShader);
  }
}
function setup() {
  createCanvas(1273, 849, WEBGL);
  buffer = createGraphics(width, height, WEBGL);
  buffer.background(255);
  // buffer.ellipse(0, 0, width, height);
}

function draw() {
  translate(-width / 2, -height / 2);

  for (let i = 0; i < n_horiz; i++) {
    for (let j = 0; j < n_verti; j++) {
      const ix = j * n_verti + i;
      const voronoiShader = voronoiShaders[ix];

      voronoiShader.setUniform(
          'iTime',
          (noise(i * 24554) * 1000 + millis()) / 1000.0,
      );
      // voronoiShader.setUniform('n_points', pow(2, ix));
      voronoiShader.setUniform(
          'fillRate',
          map(ix, 0, n_horiz * n_verti, 0.1, 0.9),
      );
      const _c = palette[ix % palette.length];
      const colorForShader = [
        float((_c >> 16) & 0xff) / 255,
        float((_c >> 8) & 0xff) / 255,
        float(_c & 0xff) / 255,
      ];
      // console.dir(colorForShader);
      // R,G,B with bit shifting
      voronoiShader.setUniform('baseColor', colorForShader);
      voronoiShader.setUniform('iResolution', [width, height]);
      buffer.shader(voronoiShader);
      buffer.plane(buffer.width, buffer.height);

      image(
          buffer,
          (i * width) / n_horiz,
          (j * height) / n_verti,
          width / n_horiz,
          height / n_verti,
      );
    }
  }
}
