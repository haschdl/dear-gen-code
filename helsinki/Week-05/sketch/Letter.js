'use strict';

class Letter {
  constructor(_grid, _lineHeight, _em, _strokeWeight) {
    this.grid = _grid;
    this.letter;
    this.strokeList = [];

    // Initial random points (for the first stroke)
    const randomInitX = int(random(gridSubdivisionsW));
    const randomInitY = int(random(gridSubdivisionsH));
    const randomSupportX = int(random(gridSubdivisionsW));
    const randomSupportY = int(random(gridSubdivisionsH));

    let initialPoint = _grid.points[randomInitX][randomInitY];
    let supportPoint = _grid.points[randomSupportX][randomSupportY];

    const numStrokes = int(random(2, 6));
    for (let i = 0; i < numStrokes; i++) {
      this.strokeList.push(
          new LetterStroke(initialPoint, supportPoint, _strokeWeight),
      );

      // Calculate next initial and support points
      const randomNextX = int(random(gridSubdivisionsW));
      const randomNextY = int(random(gridSubdivisionsH));

      const isContinuous = random(1) > 0.5 ? true : false;
      if (isContinuous) {
        initialPoint = supportPoint;
      } else {
        const randomNextInitX = int(random(gridSubdivisionsW));
        const randomNextInitY = int(random(gridSubdivisionsH));
        initialPoint = _grid.points[randomNextInitX][randomNextInitY];
      }

      supportPoint = _grid.points[randomNextX][randomNextY];
    }

    this.g = createGraphics(50, 50);
    this.redraw();
  }

  redraw() {
    const letter = this.g;

    letter.background(255);
    letter.push();
    letter.translate(letter.width / 2, letter.height / 2);
    letter.rectMode(CENTER);
    const w =
      this.grid.points[gridSubdivisionsW - 1][gridSubdivisionsH - 1][0] -
      this.grid.points[0][0][0];
    const h =
      this.grid.points[gridSubdivisionsW - 1][gridSubdivisionsH - 1][1] -
      this.grid.points[0][0][1];
    if (showGrid) {
      letter.stroke(100);

      letter.noFill();
      letter.strokeWeight(1);

      letter.rect(0, 0, letter.width, letter.height);

      letter.rect(...this.grid.points[0][0], w, h);
      letter.push();
      letter.translate(-w / 2, -h / 2);
      for (let i = 0; i < gridSubdivisionsW; i++) {
        for (let j = 0; j < gridSubdivisionsH; j++) {
          letter.fill(100, 20);
          letter.ellipse(...this.grid.points[i][j], 2, 2);
        }
      }
      letter.pop();
    }
    imageMode(CENTER);
    letter.translate(-w / 2, -h / 2);
    for (let i = 0; i < this.strokeList.length; i++) {
      const drawX =
        0.5 * (this.grid.points[0][0][0] - this.strokeList[i].g.width);
      const drawY =
        0.5 * (this.grid.points[0][0][1] - this.strokeList[i].g.height);
      letter.image(this.strokeList[i].g, drawX, drawY);
    }
    imageMode(CORNER);
    letter.pop();
  }
}
