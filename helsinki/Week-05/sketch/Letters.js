'use strict';

class Letters {
  constructor(_lineHeight, _em) {
    this.em = _em;
    this.rectRatio = 1.3;
    this.padding = width / 12;
    this.letters = [];

    this.lineHeight = _lineHeight;
    this.grid = new Grid(
        _lineHeight,
        _em,
        gridSubdivisionsW,
        gridSubdivisionsH,
    );

    this.calculateSizes();

    const strokeWeight = _em / 15;

    for (let i = 0; i < numLetters; i++) {
      this.letters.push(new Letter(this.grid, _lineHeight, _em, strokeWeight));
    }

    const textToWriteLetters = textToWrite.toUpperCase().split('');
    this.textToWriteIx = [];

    for (let i = 0; i < textToWriteLetters.length; i++) {
      this.textToWriteIx.push(this.alphabetIndexOf(textToWriteLetters[i]));
    }
  }

  alphabetIndexOf(letter) {
    return alphabet[alphabetIndex].indexOf(letter);
  }

  calculateSizes() {
    this.containerWidth = width - this.padding * 2;
    this.containerHeight = height - this.padding * 2;
    this.containerRatio = this.containerWidth / this.containerHeight;
    this.rectWidth =
      sqrt(this.containerRatio / (numLetters * this.rectRatio)) *
      this.containerHeight;
    this.rectHeight = this.rectWidth * this.rectRatio;

    const bigSmallRatioW = this.containerWidth / this.rectWidth;
    const numCols = ceil(bigSmallRatioW);
    const extraWidth = numCols * this.rectWidth - this.containerWidth;

    const bigSmallRatioH = this.containerHeight / this.rectHeight;
    const numRows = ceil(bigSmallRatioH);
    const extraHeight = numRows * this.rectHeight - this.containerHeight;

    if (extraWidth > extraHeight) {
      this.rectWidth = this.rectWidth - extraWidth / numCols;
      this.rectHeight = this.rectWidth * this.rectRatio;
    } else {
      this.rectHeight = this.rectHeight - extraHeight / numRows;
      this.rectWidth = this.rectHeight / this.rectRatio;
    }
  }

  redraw() {
    let total = 0;
    for (
      let y = this.padding;
      y <= this.containerHeight + this.padding;
      y += this.rectHeight
    ) {
      for (
        let x = this.padding;
        x <= this.containerWidth + this.padding - this.rectWidth;
        x += this.rectWidth
      ) {
        if (total < numLetters) {
          this.letters[total].redraw();
          image(this.letters[total].g, x, y);
          if (showGrid) {
            push();
            fill(0);
            text(alphabet[alphabetIndex][total], x - 10, y - 10);
            pop();
          }
        }
        total++;
      }
    }
  }

  writeText() {
    // Write some text with alphabet
    for (let i = 0; i < this.textToWriteIx.length; i++) {
      const id = this.textToWriteIx[i];
      if (id >= 0) {
        image(
            letters.letters[id].g,
            this.padding + this.em * i,
            height - this.padding,
        );
      }
    }
  }
}
