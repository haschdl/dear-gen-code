JSONObject json, segment;

JSONArray beats, segments, timbre, pitches;
;
int nBeats, nSegments;
float h, w, f;

int meta_duration;



void setup() {
  size(900, 900, P2D);
  colorMode(RGB);
  json = loadJSONObject("sir-duke.json");
  //json = loadJSONObject("falando-de-amor.json");


  //to read track metadata (duration, tempo, tempo_confidence, key, etc):
  JSONObject track = json.getJSONObject("track"); 
  meta_duration = track.getInt("duration");
  println(String.format("Duration of song (seconds): %s", meta_duration));

  /*
   * Spotify analysis has 4 arrays:
   * bars {start, duration, confidence}
   * beats {start,duration, confidence}
   * tatum {start, duration, confidence}
   * section {start, duration, confidence, tempo, key, mode, time_signature }
   * segments {start, duration, loudness, pitches[], timbre[]
   *
   */
  JSONArray bars = json.getJSONArray("bars");
  beats = json.getJSONArray("beats");
  segments = json.getJSONArray("segments");
  nSegments = segments.size();
  nBeats = beats.size();
  w = floor(width/sqrt(nBeats));
  h = 35;
  f = (float)width/meta_duration;
  println(String.format("Beats: %s", beats.size()));
  println(String.format("Segments: %s", segments.size()));
  println(String.format("Seconds to pixels: %.5f", f));
}


void draw() {
  background(255);
  noStroke();
  //translate(w/2, w/2);
  //TATUMS: use lerp() or map() to find the position in the screen for each beat.start
  //or tatum.start
  float H = height/12 -10;

  
  float r = 10;
  int res = 100;
  float angle = 0;
  translate(width/2, height/2);
  stroke(0);
  beginShape();
  for (int i = 0; i < nSegments; i++) {
    r+=.4;
    float x = r*cos(angle);
    float y = r*sin(angle);
    stroke(noise(angle, r)*255);
    //strokeWeight(int(noise(angle, r,millis())*15.));

    vertex(x, y);
    angle+=TWO_PI/nSegments*12;
  }
  endShape();

  /*
  for (int i=0; i<nSegments; i++) {
   segment = segments.getJSONObject(i);
   timbre = segment.getJSONArray("timbre");
   pitches = segment.getJSONArray("pitches");
   float start = segment.getFloat("start");    
   float duration = segment.getFloat("duration");
   float confidence = segment.getFloat("confidence");
   
   float x = start*f;
   for (int j = 0; j < 12; j++) {
   float y = j * (H+10);
   
   float pitch = pitches.getFloat(j);
   float timbre_v = timbre.getFloat(j);
   
   fill(palette[j], pitch *255*confidence);
   rect(x, y + H*(1-pitch), duration*f*5*confidence, H*pitch);
   }
   }
   noLoop();
   
   */
  /*
  for (int x=0; x<width-w; x+=w) {
   for (int y=0; y<height-w; y+=w) {
   JSONObject beat = beats.getJSONObject(i);
   
   float alpha = beat.getFloat("confidence");
   float s = beat.getFloat("duration") * 20;
   fill(255, alpha*255);
   rect(x, y, s, s);
   i++;
   }
   }
   */
}
