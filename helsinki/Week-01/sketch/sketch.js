let sortedColors = [];
let img;
const imgScale = 3;

function preload() {
  const imgName = 'data/img-placeholder.jpg';
  img = loadImage(imgName);
}

function setup() {
  img.loadPixels();
  createCanvas(img.width * imgScale, img.height * imgScale);
  noLoop();
  noStroke();

  const hueArr = [];
  for (let i = 0, l = img.pixels.length; i < l; i += 4) {
    const c = color(...img.pixels.slice(i, i + 3));
    hueArr.push({hue: hue(c), color: c});
  }

  console.log('Sorting pixels... this might take a while!');
  sortedColors = bubbleSort(hueArr);
  console.log('Sorting pixels... done!');
}

function draw() {
  colorMode(HSB, 360, 100, 100);

  for (let i = 0, l = sortedColors.length; i < l; i++) {
    const brightnessValue = brightness(sortedColors[i].color);
    fill(sortedColors[i].color);
    const x = (i % img.width) * imgScale;
    const y = (i / img.width) * imgScale;
    const ellipseSize = map(
        brightnessValue,
        0,
        100,
        imgScale / 7,
        imgScale * 5,
    );
    // let ellipseSize = map(brightness, 0, 100, imgScale*2, imgScale*20);
    ellipse(x, y, ellipseSize, ellipseSize);
    // rect(x, y, imgScale, imgScale);
  }
  console.log('we\'re done!');

  save(
      'saved-png/' +
      year() +
      '-' +
      month() +
      '-' +
      day() +
      '-' +
      hour() +
      '-' +
      minute() +
      '-' +
      second() +
      '-hue.png',
  );
}

// sort colors by hue, ripped off from:
// https://www.cs.cmu.edu/~adamchik/15-121/lectures/Sorting%20Algorithms/sorting.html
function bubbleSort(ar) {
  for (let i = ar.length - 1; i >= 0; i--) {
    for (let j = 1; j <= i; j++) {
      if (ar[j - 1].hue > ar[j].hue) {
        const temp = ar[j - 1];
        ar[j - 1] = ar[j];
        ar[j] = temp;
      }
    }
  }
  return ar;
}
