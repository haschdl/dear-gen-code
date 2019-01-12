import java.text.SimpleDateFormat;  
import java.util.Date;  



void setup() {
  size(200, 200);
  noiseSeed(12345);
}


void strawStraightLines(float x, float y, float w, float h ) {
  for (int j=0; j<=10; j++) {
    line(x, y, x, y+h);
    translate(w/10, 0);
  }
}

void strawLineSegments(float x, float y, float w, float h ) {

  int i_ = 10; //number of segments in each line
  int j_ = 10; //number of vertical lines
  for (int j=0; j<=10; j++) {
    
    beginShape();
    
    for (int i=0; i<=i_; i++) {
    
      float v_x = lerp(x, x+w, (float)j/j_) ;
      float v_y = lerp(y, h, (float)i/i_);
      //v_x += 4* (1 - 2*noise(v_x, v_y));
      vertex(v_x, v_y);
      
      //draws a small ellipse at
      //end of each segment, for illustration only
      fill(255, 0, 0);noStroke();
      ellipse(v_x, v_y, 3, 3);
      stroke(0);
      
    }
    endShape();
  }
}

void strawSegmentsWithNoise(float x, float y, float w, float h ) {

  int i_ = 10; //number of segments in each line
  int j_ = 10; //number of vertical lines
  for (int j=0; j<=10; j++) {
    
    beginShape();
    
    for (int i=0; i<=i_; i++) {
    
      float v_x = lerp(x, x+w, (float)j/j_) ;
      float v_y = lerp(y, h, (float)i/i_);
      v_x += 4* (1 - 2*noise(v_x, v_y));
      vertex(v_x, v_y);
      
      //draws a small ellipse at
      //end of each segment, for illustration only
      fill(255, 0, 0);noStroke();
      ellipse(v_x, v_y, 3, 3);
      stroke(0);noFill();
      
    }
    endShape();
  }
}

void straw(float x, float y, float w, float h ) {

  int j_ =10;
  int i_ =10;
  for (int j=0; j<=j_; j++) {
    beginShape();
    stroke(0);//color(palette[int(random(palette.length))]));
    for (int i=0; i<=i_; i++) {
      float v_x = lerp(x, x+w, (float)j/j_) ;
      float v_y = lerp(y, h, (float)i/i_);
      v_x += 4* (1 - 2*noise(v_x, v_y));
      vertex(v_x, v_y);
    }
    endShape();
  }
}


void draw() {

  background(255);
  strokeWeight(1);
  stroke(0);

  float l = 50;
  translate((width-l)/2, 0);

  //strawVer(l, 10, 0, 1);
  //strawStraightLines(0, 0, l, height);
  //strawLineSegments(0, 0, l, height);
strawSegmentsWithNoise(0, 0, l, height);
  noLoop();
}
