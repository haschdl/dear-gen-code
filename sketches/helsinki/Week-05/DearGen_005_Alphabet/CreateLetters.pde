class CreateLetters {
  CreateGrid grid;
  CreateLetter[] letters = new CreateLetter[numLetters];
  
  int padding = width/12;
  float containerRatio;
  float rectWidth;
  float rectHeight;
  float rectRatio = 1.3;
  float em;
  float lineHeight;
  
  float containerWidth;
  float containerHeight;
  
  int[] text;
  
  CreateLetters(float _lineHeight, float _em){
    em = _em;
    lineHeight= _lineHeight;
    grid = new CreateGrid(_lineHeight, em, gridSubdivisionsW, gridSubdivisionsH);
    
    this.calculateSizes();
    
    float strokeWeight = em/15;
    
    for(int i = 0; i < numLetters; i++){
      letters[i] = new CreateLetter(grid, _lineHeight, em, strokeWeight);
    }
    
    String[] textToWriteLetters = textToWrite.toUpperCase().split("");
    text = new int[textToWriteLetters.length];
    
    for(int i = 0; i < textToWriteLetters.length; i++){
      text[i] = this.writeText(textToWriteLetters[i]);
    }
  }
  
  int writeText(String letter){
    return new String(alphabet[alphabetIndex]).indexOf(letter);
  }
  
  void calculateSizes(){
    containerWidth = width - padding*2;
    containerHeight = height - padding*2;
    containerRatio = containerWidth/containerHeight;
    rectWidth = sqrt(containerRatio/(numLetters*rectRatio)) * containerHeight;
    rectHeight = rectWidth * rectRatio;
    
    float bigSmallRatioW = containerWidth/rectWidth;
    int numCols = ceil(bigSmallRatioW);
    float extraWidth = numCols*rectWidth - containerWidth;
  
    float bigSmallRatioH = containerHeight/rectHeight;
    int numRows = ceil(bigSmallRatioH);
    float extraHeight = numRows*rectHeight - containerHeight;
  
    if(extraWidth > extraHeight){
      rectWidth = rectWidth - extraWidth/numCols;
      rectHeight = rectWidth * rectRatio;
    } else {
      rectHeight = rectHeight - extraHeight/numRows;
      rectWidth = rectHeight / rectRatio;
    }
  }
  
  void returnLetters(){
    int total = 0;
    for (float y = padding; y <= containerHeight + padding; y += rectHeight) {
      for (float x = padding; x <= containerWidth + padding - rectWidth; x += rectWidth) {
        if (total < numLetters) {
          shape(letters[total].returnLetter(), x, y);
          if(showGrid){
            pushStyle();
            fill(0);
            text(alphabet[alphabetIndex][total], x - 10, y - 10);
            popStyle();
          }
        }
        total++;
      }
    }
  }
  
  void writeText(){
    // Write some text with alphabet
    for(int i = 0; i < text.length; i++){
      int id = text[i];
      if(id >= 0) {
        shape(letters[id].returnLetter(), padding + em*i, height-padding);
      }
    }
  }
}
