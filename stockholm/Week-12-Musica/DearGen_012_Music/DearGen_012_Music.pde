JSONObject json, segment;

JSONArray segments, timbre, pitches;
;
int nBeats, nSegments;
float h, f;

int meta_duration;

PGraphics canvas;

void setup() {
  size(1200, 800);
  colorMode(HSB, 360, 1, 1, 1);
  json = loadJSONObject("falando-de-amor.json");

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
  segments = json.getJSONArray("segments");
  nSegments = segments.size();
  f = (float)width/meta_duration;
  h = height/12.;

  println(String.format("Segments: %s", segments.size()));
  println(String.format("Seconds to pixels: %.5f", f));
}


void draw() {
  background(0, 0, 1, 1);
  noStroke();
  

  for (int i=0; i<nSegments; i++) {
    segment = segments.getJSONObject(i);
    timbre = segment.getJSONArray("timbre");
    pitches = segment.getJSONArray("pitches");
    float start = segment.getFloat("start");    
    float duration = segment.getFloat("duration");

    float x = start*f;
    for (int j = 0; j < 12; j++) {
      float y = j * h;

      float pitch = pitches.getFloat(j);
      float timbre_v = timbre.getFloat(j);

      float b = 300. * mouseY/height;
      float hue = b * (1. * mouseX/width) + (360-b)*(pitch);
      fill(hue, 1, 1, 1);

      rect(x, y, duration*f, h);
    }
  }
  //noLoop();
}
