/* exported draw, preload, setup */
let json;
let segment;
let segments;
let pitches;
let nSegments;
let h;
let f;

function preload() {
  json = loadJSON('data/falando-de-amor.json');
}

function setup() {
  createCanvas(1200, 800);
  colorMode(HSB, 360, 1, 1, 1);

  // to read track metadata (duration, tempo, tempo_confidence, key, etc):
  const track = json.track;
  const metaDuration = track.duration;
  console.debug(`Duration of song (seconds): ${metaDuration}`);

  /*
   * Spotify analysis has 4 arrays:
   * bars {start, duration, confidence}
   * beats {start,duration, confidence}
   * tatum {start, duration, confidence}
   * section {start, duration, confidence, tempo, key, mode, time_signature }
   * segments {start, duration, loudness, pitches[], timbre[]
   *
   */
  segments = json.segments;
  nSegments = segments.length;
  f = width / metaDuration;
  h = height / 12;
}

function draw() {
  background(0, 0, 1, 1);
  noStroke();

  for (let i = 0; i < nSegments; i++) {
    segment = segments[i];
    pitches = segment.pitches;
    const start = segment.start;
    const duration = segment.duration;

    const x = start * f;
    for (let j = 0; j < 12; j++) {
      const y = j * h;
      const pitch = pitches[j];
      const b = (300 * mouseY) / height;
      const hue = b * ((1 * mouseX) / width) + (360 - b) * pitch;
      fill(hue, 1, 1, 1);
      rect(x, y, duration * f, h);
    }
  }
}
