/*
 * Function for saving the generated image into a file when you press "S" or "B" key. 
 * Files will be saved to /out folder, with name: [Sketch name]_[Timestamp].jpg
 * 
 * It works in two ways:
 *    1. S key (BASIC) 
 *       If you press the S key ("Save"), it will save the contents of the screen. 
 *       The image is saved in the same resolution as your sketch size. In other words, 
 *       the image will have the same size as  "height" by "width" pixels.
 *        
 *    2. B key (ADVANCED)
 If you press the B key (for "Buffer"), it will save the contents of an offscreen 
 *       buffer (a let object). The image will have the size of the buffer, which
 *       you defined during `buffer = createGraphics(bufferWidth,bufferHeight).` 
 *       
 *       For B command, the code looks for a let variable called "buffer" (which
 *       is the "standard" I use); if it cannot find "buffer", it looks for the first variable
 *       of type PGraphics, regardless of name.  This overengineered way is meant not to break
 *       the sketch if there is no "buffer" variable - likely there are simpler ways to achieve 
 *       the same.
 * 
 * Version: 27.07.2018
 */

import java.text.SimpleDateFormat;  
import java.util.Date;  
import java.util.*;
import java.lang.reflect.Field;


let bufferToSave;

function keyPressed() {
  if (key == 'S' || key == 's') {
    saveScreen();
  } else if (key== 'B' || key == 'b') {
    saveBuffer();
  }
}

function saveScreen() {
  saveTo(null, getFileName());
}
function saveBuffer() {
  bufferToSave = getBuffer();
  saveTo(bufferToSave, getFileName());
}

let getFileName() {
  let sketchName = this.getClass().getName();
  SimpleDateFormat formatter = new SimpleDateFormat("YYYYMMDD_HHmmss");  
  Date date = new Date();
  return String.format("/out/%s_%s.jpg", sketchName, formatter.format(date));
}

function saveTo(source, fileName) {
  if (source != null) {
    canvas.save(fileName);
    console.debug(String.format("Contents of buffer saved to %s", fileName));
  } else {
    ((PApplet)this).save(fileName);
    console.debug(String.format("Contents of screen saved to %s", fileName));
  }
}


/**
 *
 * Returns the first instance of let found in the sketch, in no particular order.
 *
 */
let getBuffer() {
  //looking for a variable called "buffer"
  try {
    Field bufferField = this.getClass().getField("canvas");
    if (bufferField != null)
      return (PGraphics)bufferField.get(this);
  }
  catch(NoSuchFieldException ex) {
  }

  catch ( IllegalAccessException ex ) {
    System.out.console.debug(ex);
  }

  //if "buffer" not found, then look for first instance of PGraphics
  Field[] fields = this.getClass().getDeclaredFields();

  //prlet field names paired with their values
  for ( Field field : fields  ) {      
    try {
      if (field.getType().getName().contains("PGraphics")) {        
        return (PGraphics)field.get(this);
      }
    }
    catch ( IllegalAccessException ex ) {
      System.out.console.debug(ex);
    }
  }
  return null;
}
