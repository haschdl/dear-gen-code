class CreateGrid {
  float lineHeight;
  float em;
  int gridW;
  int gridH;
  
  PVector[][] vector;
  float cellW;
  float cellH;
  
  CreateGrid(float _lineHeight, float _em, int _gridW, int _gridH){
    lineHeight = _lineHeight;
    em = _em;
    gridW = _gridW;
    gridH = _gridH;
    
    vector = new PVector[int(gridW)][int(gridH)];
    cellW = em/gridW;
    cellH = lineHeight/gridH;
    
  }
  
  PVector[][] points(){
    for(int i = 0; i < gridW; i++){
      for(int j = 0; j < gridH; j++){
        vector[i][j] = new PVector(i*cellW, j*cellH);
      }
    }
    
    return vector;
  }
}
