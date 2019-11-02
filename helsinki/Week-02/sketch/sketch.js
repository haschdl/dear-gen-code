let table;
const scale = 20;
const proportion = 1.244;
const radiusType = 'PL_ORBPER';
/*
 * Options for radiusType:
 * PL_ORBPER: Orbital Period [days]
 * PL_MASSE: Planet Mass (Earth mass)
 * PL_RADE: Planet Radius (Earth radii)
 */

let bubbles = [];

function preload() {
  table = loadTable('data/planets.csv', 'header');
}

function setup() {
  createCanvas(360 * scale, int(180 * scale * proportion));
  background(0);
  strokeWeight(1);
  noFill();
  blendMode(ADD);
  loadData();

  console.debug('Data loaded!');
}

function draw() {
  bubbles[frameCount].display();

  if (frameCount >= bubbles.length) noLoop();
  const fileName =
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
    '-' +
    radiusType +
    '.png';
  // save(fileName);
}

function loadData() {
  // The size of the array of Bubble objects is determined by the total number of rows in the CSV
  bubbles = [];
  for (const row of table.rows) {
    const st_glon = row.getNum('st_glon') * scale; // Galactic Longitude [deg]
    const st_glat = (row.getNum('st_glat') + 90) * scale * proportion; // Galactic Latitude [deg]
    const radius = getRadius(row);

    bubbles.push(new Bubble(st_glon, st_glat, radius));
  }
}

function getRadius(row) {
  let radius = 0;
  switch (radiusType) {
    case 'PL_ORBPER':
      const pl_orbper = constrain(row.get('pl_orbper'), 0, 300);
      radius = log(pl_orbper) * 100;
      break;
    case 'PL_MASSE':
      const pl_masse = row.getNum('pl_masse');
      radius = pl_masse / 5;
      break;
    case 'PL_RADE':
      const pl_rade = row.getNum('pl_rade');
      radius = pl_rade * 30;
      break;
  }

  return radius;
}
