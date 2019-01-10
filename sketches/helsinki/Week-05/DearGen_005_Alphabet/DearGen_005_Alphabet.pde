import processing.pdf.*;

/*******************

  ===================
  Keyboard shortcuts:
  ===================
  
  * 'r': regenerate alphabet
  * 's': save PDF
  * 'g': show letter grid
  * arrow left/right: increase/decrease gridSubdivisionsW
  * arrow top/down: increase/decrease gridSubdivisionsH
  * '.' (point): to loop through alphabets and regenerate alphabet

********************/

// Set number of points in the letter grid
// more points make letters more complicated
int gridSubdivisionsW = 3;
int gridSubdivisionsH = 3;

// Set text to write
String textToWrite = "Alphabet by Regis Frias 2018";

// Set initial alphabet
int alphabetIndex = 3;
String[] alphabetsList = {
  "Latin (English)",
  "Latin with numbers",
  "Finnish/Swedish",
  "Finnish/Swedish with numbers"
};
char[][] alphabet = {
  // 0: Latin (English)
  {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'},
  // 1: Latin with numbers
  {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','0','1','2','3','4','5','6','7','8','9'},
  // 2: Finnish/Swedish
  {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','Ä','Ö','Å'},
  // 3: Finnish/Swedish with numbers
  {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','Ä','Ö','Å','0','1','2','3','4','5','6','7','8','9'}
};
int numLetters = alphabet[alphabetIndex].length;

CreateLetters letters;

boolean savePdf = false;
boolean showGrid = false;

void setup(){
  size(1022, 638);
  createLetters();
}

void draw(){
  background(255);
  
  if(savePdf){
    String fileName = "saved/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-alphabet.pdf";
    beginRecord(PDF, fileName);
  }
  
  letters.returnLetters();
  
  letters.writeText();
  
  if(savePdf){
    endRecord();
    savePdf = false;
  }
  
  pushStyle();
  fill(80);
  String info =
    "Grid size: " + gridSubdivisionsW + 
    " horizontal, " + gridSubdivisionsH +
    " vertical (user keyboard arrows to change)" +
    "      Base alphabet: " + alphabetsList[alphabetIndex]
  ; 
  text(info, 10, height - 10);
  popStyle();
}

void createLetters(){
  float rectWidth = width/24;
  float em = rectWidth * 0.75;
  float lineHeight = em / 0.75;
  
  letters = new CreateLetters(lineHeight, em);
}

void keyPressed(){
  
switch(keyCode){
    case RIGHT:
      gridSubdivisionsW ++;
      createLetters();
      break;
    case LEFT:
      if(gridSubdivisionsW > 2) gridSubdivisionsW --;
      createLetters();
      break;
    case UP:
      gridSubdivisionsH ++;
      createLetters();
      break;
    case DOWN:
      if(gridSubdivisionsH > 2) gridSubdivisionsH --;
      createLetters();
      break;
  }
  
  switch(key){
    case 's':
      savePdf = true;
      break;
    case 'g':
      showGrid = !showGrid;
      break;
    case 'r':
      createLetters();
      break;
    case '.':
      // Loop through alphabetsList
      if(alphabetIndex > alphabetsList.length-2){
        alphabetIndex = 0;
      } else {
        alphabetIndex++;
      }
      numLetters = alphabet[alphabetIndex].length;
      createLetters(); // recreate alphabet
      break;
  }
}
