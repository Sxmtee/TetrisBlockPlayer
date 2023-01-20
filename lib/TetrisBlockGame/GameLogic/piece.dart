class Piece {
  final List<List<bool>> occupations;

  const Piece(this.occupations);

  static const List<Piece> pieces = [
    // Extras
    Piece([
      [true],
    ]),
    Piece([
      [false, true],
      [true, true],
    ]),
    Piece([
      [true, false],
      [true, true],
    ]),
    Piece([
      [true, true],
      [true, false],
    ]),
    Piece([
      [true, true],
      [false, true],
    ]),
    Piece([
      [true, true],
    ]),
    Piece([
      [true],
      [true],
    ]),
    // end Extras

    // Z shape
    Piece([
      [true, true, false],
      [false, true, true],
    ]),
    Piece([
      [false, true],
      [true, true],
      [true, false],
    ]),
    // end Z Shape

    // S shape
    Piece([
      [false, true, true],
      [true, true, false],
    ]),
    Piece([
      [true, false],
      [true, true],
      [false, true],
    ]),
    // end S Shape

    // L shape
    Piece([
      [true, true],
      [false, true],
      [false, true],
    ]),
    Piece([
      [true, false],
      [true, false],
      [true, true],
    ]),
    Piece([
      [true, true, true],
      [true, false, false],
    ]),
    Piece([
      [false, false, true],
      [true, true, true],
    ]),
    // end L Shape

    // J shape
    Piece([
      [true, true],
      [true, false],
      [true, false],
    ]),
    Piece([
      [false, true],
      [false, true],
      [true, true],
    ]),
    Piece([
      [true, false, false],
      [true, true, true],
    ]),
    Piece([
      [true, true, true],
      [false, false, true],
    ]),
    // end J Shape

    // I shape
    Piece([
      [true],
      [true],
      [true],
      [true],
    ]),
    Piece([
      [true, true, true, true],
    ]),
    // end I Shape

    // O shape
    Piece([
      [true, true],
      [true, true],
    ]),
    // end O Shape

    // T shape
    Piece([
      [true, false],
      [true, true],
      [true, false],
    ]),
    Piece([
      [false, true],
      [true, true],
      [false, true],
    ]),
    Piece([
      [false, true, false],
      [true, true, true],
    ]),
    Piece([
      [true, true, true],
      [false, true, false],
    ])
    // end T Shape
  ];
}
