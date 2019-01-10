/*
 * Function for saving the generated image into a file when you press "S" key.
 * The code can be re-used in most sketches, but it requires that you create your drawings 
 * into a PGraphics object called "buffer"
 * 
 * Files will be saved with the following name: [Sketch name]_[Timestamp].jpg
 */

import java.text.SimpleDateFormat;  
import java.util.Date;  


void keyPressed() {
  String sketchName = this.getClass().getName();
  SimpleDateFormat formatter = new SimpleDateFormat("YYYYMMDD_HHmmss");  
  Date date = new Date();


  String fileName = String.format("/out/%s_%s.jpg", sketchName, formatter.format(date));
  if (key == 'S' || key == 's') {
    saveTo(null, fileName);
  } else if (key== 'F' || key == 'f') {
    saveTo(buffer, fileName);
  }
}

void saveTo(PGraphics source, String fileName) {
  if (source != null)
    buffer.save(fileName);
  else {
    ((PApplet)this).save(fileName);
  }
  println("Composition saved!");
}
