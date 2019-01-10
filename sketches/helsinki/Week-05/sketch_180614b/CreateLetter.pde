class CreateLetter {
  PShape letter;
  int numStrokes = int(random(2, 6));
  CreateStroke[] stroke = new CreateStroke[numStrokes];
  CreateGrid grid;
  
  CreateLetter(CreateGrid _grid, float _lineHeight, float _em, float _strokeWeight){
    grid = _grid;
    
    // Initial random points (for the first stroke)
    int randomInitX = int(random(gridSubdivisionsW));
    int randomInitY = int(random(gridSubdivisionsH));
    int randomSupportX = int(random(gridSubdivisionsW));
    int randomSupportY = int(random(gridSubdivisionsH));
    grid = new CreateGrid(_lineHeight, _em, gridSubdivisionsW, gridSubdivisionsH);
    PVector initialPoint = grid.points()[randomInitX][randomInitY];
    PVector supportPoint = grid.points()[randomSupportX][randomSupportY];
    
    for(int i = 0; i < numStrokes; i++){
      stroke[i] = new CreateStroke(initialPoint, supportPoint, _strokeWeight);
      
      // Calculate next initial and support points
      int randomNextX = int(random(gridSubdivisionsW));
      int randomNextY = int(random(gridSubdivisionsH));
      
      boolean isContinuous = random(1) > 0.5 ? true : false;
      if(isContinuous){
        initialPoint = supportPoint;
      } else {
        int randomNextInitX = int(random(gridSubdivisionsW));
        int randomNextInitY = int(random(gridSubdivisionsH));
        initialPoint = grid.points()[randomNextInitX][randomNextInitY];
      }
      
      supportPoint = grid.points()[randomNextX][randomNextY];
    }
  }
  
  PShape returnLetter(){
    letter = createShape(GROUP);
    
    if(showGrid) {
      PShape rect = createShape();
      rect.setStroke(100);
      rect.setFill(false);
      rect.beginShape();
      rect.strokeWeight(1);
      rect.vertex(grid.points()[0][0].x, grid.points()[0][0].y);
      rect.vertex(grid.points()[gridSubdivisionsW-1][0].x, grid.points()[gridSubdivisionsW-1][0].y);
      rect.vertex(grid.points()[gridSubdivisionsW-1][gridSubdivisionsH-1].x, grid.points()[gridSubdivisionsW-1][gridSubdivisionsH-1].y);
      rect.vertex(grid.points()[0][gridSubdivisionsH-1].x, grid.points()[0][gridSubdivisionsH-1].y);
      rect.endShape(CLOSE);
      letter.addChild(rect);
      
      for(int i = 0; i < gridSubdivisionsW; i++){
        for(int j = 0; j < gridSubdivisionsH; j++){
          PShape point = createShape(ELLIPSE, grid.points()[i][j].x, grid.points()[i][j].y, 5, 5);
          point.setFill(color(100));
          point.setStroke(false);
          letter.addChild(point);
        }
      }
    }
    
    for(int i = 0; i < numStrokes; i++){
      PShape newStroke = stroke[i].returnStroke();
      letter.addChild(newStroke);
    }
    
    return letter;
  }
}
