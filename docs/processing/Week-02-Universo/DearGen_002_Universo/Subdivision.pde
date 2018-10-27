/*
 * Represents a square subdivision of the drawing.
 * pos: the center of the subdivision
 * side: the side of the square, in pixels
 */
class Subdivision {
  float side;
  PVector pos;

  Subdivision( float _x, float _y, float side) {

    this.pos = new PVector(_x, _y);
    this.side = side;
  }
}
