let palette = [
  //purple
  "#7B1FA2",
  //indigo
  "#303F9F",
  //pink
  "#FF4081",
  //light green
  "#8BC34A",
  //yellow
  "#FFEB3B",
  //amber
  "#FFC107",
  //cyan
  "#00BCD4",
  //teal
  "#009688",
  //orange
  "#FF9800",
  //deep orange
  "#FF5722",
  //grey
  "#9E9E9E",
  //blue grey
  "#607D8B"
];

let json, segment;

let segments, timbre, pitches;
let nBeats, nSegments;
let h, f;

let meta_duration;

let canvas;

function preload() {
  json = loadJSON("data/falando-de-amor.json");
}

function setup() {
  createCanvas(1200, 800);
  colorMode(HSB, 360, 1, 1, 1);

  //to read track metadata (duration, tempo, tempo_confidence, key, etc):
  let track = json["track"];
  meta_duration = track["duration"];
  console.debug(`Duration of song (seconds): ${meta_duration}`);

  /*
   * Spotify analysis has 4 arrays:
   * bars {start, duration, confidence}
   * beats {start,duration, confidence}
   * tatum {start, duration, confidence}
   * section {start, duration, confidence, tempo, key, mode, time_signature }
   * segments {start, duration, loudness, pitches[], timbre[]
   *
   */
  segments = json["segments"];
  nSegments = segments.length;
  f = width / meta_duration;
  h = height / 12;
}

function draw() {
  background(0, 0, 1, 1);
  noStroke();

  for (let i = 0; i < nSegments; i++) {
    segment = segments[i];
    timbre = segment["timbre"];
    pitches = segment["pitches"];
    let start = segment["start"];
    let duration = segment["duration"];

    let x = start * f;
    for (let j = 0; j < 12; j++) {
      let y = j * h;
      let pitch = pitches[j];
      let b = (300 * mouseY) / height;
      let hue = b * ((1 * mouseX) / width) + (360 - b) * pitch;
      fill(hue, 1, 1, 1);
      rect(x, y, duration * f, h);
    }
  }
}
