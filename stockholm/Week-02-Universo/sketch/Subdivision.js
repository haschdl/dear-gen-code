/*
 * Represents a square subdivision of the drawing.
 * pos: the center of the subdivision
 * side: the side of the square, in pixels
 */
class Subdivision {
  constructor( _x, _y, side) {

    this.pos = new p5.Vector(_x, _y);
    this.side = side;
  }
}
