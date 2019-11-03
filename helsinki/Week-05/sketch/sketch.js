'use strict';
/** *****************

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
let gridSubdivisionsW = 3;
let gridSubdivisionsH = 3;

// Set text to write
const textToWrite = 'Alphabet by Regis Frias 2018';

// Set initial alphabet
let alphabetIndex = 3;
const alphabetsList = [
  'Latin (English)',
  'Latin with numbers',
  'Finnish/Swedish',
  'Finnish/Swedish with numbers',
];
const alphabet = [
  // 0: Latin (English)
  [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ],
  // 1: Latin with numbers
  [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ],
  // 2: Finnish/Swedish
  [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    'Ä',
    'Ö',
    'Å',
  ],
  // 3: Finnish/Swedish with numbers
  [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    'Ä',
    'Ö',
    'Å',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ],
];
let numLetters = alphabet[alphabetIndex].length;
let letters;

let saveImage = false;
let showGrid = false;

function setup() {
  createCanvas(1022, 638);
  createLetters();
}

function draw() {
  background(255);

  letters.redraw();

  letters.writeText();

  if (saveImage) {
    const fileName =
      'saved/' +
      year() +
      '-' +
      month() +
      '-' +
      day() +
      '-' +
      hour() +
      '-' +
      minute() +
      '-' +
      second() +
      '-alphabet.png';
    save(fileName);
    saveImage = false;
  }

  push();
  fill(80);
  const info =
    'Grid size: ' +
    gridSubdivisionsW +
    ' horizontal, ' +
    gridSubdivisionsH +
    ' vertical (user keyboard arrows to change)' +
    '      Base alphabet: ' +
    alphabetsList[alphabetIndex];
  text(info, 10, height - 10);
  pop();
}

function createLetters() {
  const rectWidth = width / 24;
  const em = rectWidth * 0.75;
  const lineHeight = em / 0.75;
  letters = new Letters(lineHeight, em);
}

function keyPressed() {
  switch (keyCode) {
    case RIGHT_ARROW:
      gridSubdivisionsW++;
      createLetters();
      break;
    case LEFT_ARROW:
      if (gridSubdivisionsW > 2) gridSubdivisionsW--;
      createLetters();
      break;
    case UP_ARROW:
      gridSubdivisionsH++;
      createLetters();
      break;
    case DOWN_ARROW:
      if (gridSubdivisionsH > 2) gridSubdivisionsH--;
      createLetters();
      break;
  }

  switch (key) {
    case 's':
      saveImage = true;
      break;
    case 'g':
      showGrid = !showGrid;
      break;
    case 'r':
      createLetters();
      break;
    case '.':
      // Loop through alphabetsList
      if (alphabetIndex > alphabetsList.length - 2) {
        alphabetIndex = 0;
      } else {
        alphabetIndex++;
      }
      numLetters = alphabet[alphabetIndex].length;
      createLetters(); // recreate alphabet
      break;
  }
}
