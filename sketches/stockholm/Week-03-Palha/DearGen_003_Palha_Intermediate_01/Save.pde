void keyPressed() {
  if (key == 'S' || key == 's') {
    SimpleDateFormat formatter = new SimpleDateFormat("YYYYMMDD_HHmmss");  
    Date date = new Date();  
    save(String.format("/out/palha_%s.png", formatter.format(date)) );
    println("Composition saved!");
  }
}
