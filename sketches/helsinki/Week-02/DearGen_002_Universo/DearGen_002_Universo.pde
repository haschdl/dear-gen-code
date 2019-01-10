Table table;
int scale = 20;
float proportion = 1.244;
String radiusType = "PL_ORBPER";
/*
 * Options for radiusType:
 * PL_ORBPER: Orbital Period [days]
 * PL_MASSE: Planet Mass (Earth mass)
 * PL_RADE: Planet Radius (Earth radii)
*/

Bubble[] bubbles;

void settings() {
  size(360*scale, int(180*scale*proportion));
}

void setup() {
  background(0);
  strokeWeight(1);
  noFill();
  blendMode(ADD);
  loadData();
}

void draw() {
  for (Bubble b : bubbles) {
    b.display();
  }

  String fileName = "saved-png/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-" + radiusType + ".png";
  saveFrame(fileName);
  exit();
}

void loadData() {
  table = loadTable("planets.csv", "header");

  // The size of the array of Bubble objects is determined by the total number of rows in the CSV
  bubbles = new Bubble[table.getRowCount()]; 

  int rowCount = 0;
  for (TableRow row : table.rows()) {
    float st_glon = row.getFloat("st_glon") * scale; // Galactic Longitude [deg]
    float st_glat = (row.getFloat("st_glat") + 90) * scale * proportion; // Galactic Latitude [deg]
    float radius = radius(row);

    bubbles[rowCount] = new Bubble(st_glon, st_glat, radius);
    rowCount++;
  }
}

float radius(TableRow row){
  float radius = 0;
  switch(radiusType){
    case "PL_ORBPER":
      int pl_orbper = constrain(row.getInt("pl_orbper"), 0, 300);
      radius = log(pl_orbper) * 100;
      break;
    case "PL_MASSE":
      float pl_masse = row.getFloat("pl_masse");
      radius = pl_masse/5;
      break;
    case "PL_RADE":
      float pl_rade = row.getFloat("pl_rade"); 
      radius = pl_rade * 30;
      break;
  }
  
  return radius;
}
