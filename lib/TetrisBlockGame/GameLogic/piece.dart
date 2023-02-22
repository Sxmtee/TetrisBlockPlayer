enum Shape { none, one, two, three, four }

class Piece {
  final List<List<bool>> occupations;
  final Shape shape;

  const Piece(this.occupations, this.shape);

  static const List<Piece> pieces = [
    // ones
    Piece([
      [true],
    ], Shape.one),
    Piece([
      [true, true],
    ], Shape.one),
    Piece([
      [true, true, true, true],
    ], Shape.one),

    // twos
    Piece([
      [false, true],
      [true, true],
    ], Shape.two),
    Piece([
      [true, false],
      [true, true],
    ], Shape.two),
    Piece([
      [true, true],
      [true, false],
    ], Shape.two),
    Piece([
      [true, true],
      [false, true],
    ], Shape.two),
    Piece([
      [true],
      [true],
    ], Shape.two),
    Piece([
      [false, true, false],
      [true, true, true],
    ], Shape.two),
    Piece([
      [true, true, true],
      [false, true, false],
    ], Shape.two),
    Piece([
      [true, true, false],
      [false, true, true],
    ], Shape.two),
    Piece([
      [false, true, true],
      [true, true, false],
    ], Shape.two),
    Piece([
      [true, true, true],
      [true, false, false],
    ], Shape.two),
    Piece([
      [false, false, true],
      [true, true, true],
    ], Shape.two),
    Piece([
      [true, false, false],
      [true, true, true],
    ], Shape.two),
    Piece([
      [true, true, true],
      [false, false, true],
    ], Shape.two),
    Piece([
      [true, true],
      [true, true],
    ], Shape.two),

    //threes
    Piece([
      [false, true],
      [true, true],
      [true, false],
    ], Shape.three),
    Piece([
      [true, false],
      [true, true],
      [true, false],
    ], Shape.three),
    Piece([
      [false, true],
      [true, true],
      [false, true],
    ], Shape.three),
    Piece([
      [true, false],
      [true, true],
      [false, true],
    ], Shape.three),
    Piece([
      [true, true],
      [false, true],
      [false, true],
    ], Shape.three),
    Piece([
      [true, false],
      [true, false],
      [true, true],
    ], Shape.three),
    Piece([
      [true, true],
      [true, false],
      [true, false],
    ], Shape.three),
    Piece([
      [false, true],
      [false, true],
      [true, true],
    ], Shape.three),

    // fours
    Piece([
      [true],
      [true],
      [true],
      [true],
    ], Shape.four),
  ];
}
