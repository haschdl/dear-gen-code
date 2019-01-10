/**
 * In this composition, UnicodeBlock holds an actual font file (loaded from a .vlw file),
 * plus a range of unicode codes which we want to use in the drawing.
 * The reason for that is fonts do not have glyphs for all possible unicode codes.
 *
 */
class UnicodeBlock {
  PFont font;

  int low;
  int high;
  int density;

  public UnicodeBlock(PFont font, int low, int high, int density) {

    this.font = font;
    this.low = low;
    this.high = high;
    this.density = density;
  }
}
