'use strict';

class Grid {
  constructor(_lineHeight, _em, _gridW, _gridH) {
    this.lineHeight = _lineHeight;
    this.em = _em;
    this.gridW = _gridW;
    this.gridH = _gridH;

    this.vector = [];
    this.cellW = _em / _gridW;
    this.cellH = _lineHeight / _gridH;

    this.points = [];

    this.calculatePoints();
  }

  calculatePoints() {
    this.points = [];
    for (let i = 0; i < this.gridW; i++) {
      const row = [];
      for (let j = 0; j < this.gridH; j++) {
        row.push([i * this.cellW, j * this.cellH]);
      }
      this.points.push(row);
    }
  }
}
