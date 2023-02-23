enum Shape { none, one, two, three, four }

enum Length { none, one, two, three, four }

class Piece {
  final List<List<bool>> occupations;
  final Shape shape;
  final Length length;

  const Piece(this.occupations, this.shape, this.length);

  static const List<Piece> pieces = [
    // ones
    Piece([
      [true],
    ], Shape.one, Length.one),
    Piece([
      [true, true],
    ], Shape.one, Length.two),
    Piece([
      [true, true, true, true],
    ], Shape.one, Length.four),

    // twos
    Piece([
      [false, true],
      [true, true],
    ], Shape.two, Length.two),
    Piece([
      [true, false],
      [true, true],
    ], Shape.two, Length.two),
    Piece([
      [true, true],
      [true, false],
    ], Shape.two, Length.two),
    Piece([
      [true, true],
      [false, true],
    ], Shape.two, Length.two),
    Piece([
      [true],
      [true],
    ], Shape.two, Length.one),
    Piece([
      [false, true, false],
      [true, true, true],
    ], Shape.two, Length.three),
    Piece([
      [true, true, true],
      [false, true, false],
    ], Shape.two, Length.three),
    Piece([
      [true, true, false],
      [false, true, true],
    ], Shape.two, Length.three),
    Piece([
      [false, true, true],
      [true, true, false],
    ], Shape.two, Length.three),
    Piece([
      [true, true, true],
      [true, false, false],
    ], Shape.two, Length.three),
    Piece([
      [false, false, true],
      [true, true, true],
    ], Shape.two, Length.three),
    Piece([
      [true, false, false],
      [true, true, true],
    ], Shape.two, Length.three),
    Piece([
      [true, true, true],
      [false, false, true],
    ], Shape.two, Length.three),
    Piece([
      [true, true],
      [true, true],
    ], Shape.two, Length.two),

    //threes
    Piece([
      [false, true],
      [true, true],
      [true, false],
    ], Shape.three, Length.two),
    Piece([
      [true, false],
      [true, true],
      [true, false],
    ], Shape.three, Length.two),
    Piece([
      [false, true],
      [true, true],
      [false, true],
    ], Shape.three, Length.two),
    Piece([
      [true, false],
      [true, true],
      [false, true],
    ], Shape.three, Length.two),
    Piece([
      [true, true],
      [false, true],
      [false, true],
    ], Shape.three, Length.two),
    Piece([
      [true, false],
      [true, false],
      [true, true],
    ], Shape.three, Length.two),
    Piece([
      [true, true],
      [true, false],
      [true, false],
    ], Shape.three, Length.two),
    Piece([
      [false, true],
      [false, true],
      [true, true],
    ], Shape.three, Length.two),

    // fours
    Piece([
      [true],
      [true],
      [true],
      [true],
    ], Shape.four, Length.one),
  ];
}
