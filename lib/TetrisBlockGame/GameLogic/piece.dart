import 'dart:math';

import 'package:flutter/material.dart';

enum Shape { none, one, two, three, four }

enum Length { none, one, two, three, four }

enum PieceState {
  normal(1),
  one(2),
  two(3),
  three(0);

  const PieceState(this.nextIndex);
  final int nextIndex;
}

class Piece {
  List<List<bool>> occupations;
  Shape shape;
  Length length;
  PieceState state;
  final List<List<bool>> _occupations;

  Piece(this.occupations, this.shape, this.length)
      : state = PieceState.normal,
        _occupations = List.from(occupations);

  void _generateFromState() {
    if (state == PieceState.normal) {
      occupations = _occupations;
      return;
    }
    var longest = _occupations
        .reduce((val, elem) => val.length > elem.length ? val : elem)
        .length;
    longest = max(longest, _occupations.length);

    var rot = List.generate(longest, (i) => List.filled(longest, false));

    for (int i = 0; i < _occupations.length; i++) {
      for (int j = 0; j < _occupations[i].length; j++) {
        if (_occupations[i][j]) rot[j][i] = _occupations[i][j];
      }
    }

    switch (state) {
      case PieceState.one:
        rot = rot.map((e) => e.reversed.toList()).toList();
        break;
      case PieceState.two:
        rot = _occupations
            .map((e) => e.reversed.toList())
            .toList()
            .reversed
            .toList();
        break;
      case PieceState.three:
        rot = rot.reversed.toList();
        break;
      default:
    }

    // for (int l = 0; l < Shape.values.length; l++) {
    //   final s = Shape.values[l];
    //   if (shape == s) {
    //     if (l < longest) {

    //     }
    //     break;
    //   }
    // }
    rot = rot.where((e) => e.isNotEmpty).toList();
    List<int> emptyCols = [];

    for (int k = 0; k < rot[0].length; k++) {
      var isEmpty = true;
      for (int l = 0; l < rot.length; l++) {
        if (rot[l][k]) {
          isEmpty = false;
          break;
        }
      }
      if (isEmpty) {
        emptyCols.add(k);
      }
    }

    for (int m = 0; m < emptyCols.length; m++) {
      for (int n = 0; n < rot.length; n++) {
        rot[n].removeAt(emptyCols[m]);
      }
    }
    debugPrint('emptyCols: ${emptyCols.length} ');
    occupations = rot;
    changeEnums();
  }

  void changeEnums() {
    switch (occupations.length) {
      case 1:
        shape = Shape.one;
        break;
      case 2:
        shape = Shape.two;
        break;
      case 3:
        shape = Shape.three;
        break;
      case 4:
        shape = Shape.four;
        break;
      default:
    }

    switch (occupations[0].length) {
      case 1:
        length = Length.one;
        break;
      case 2:
        length = Length.two;
        break;
      case 3:
        length = Length.three;
        break;
      case 4:
        length = Length.four;
        break;
      default:
    }
  }

  void changeState() {
    final nextState = PieceState.values[state.nextIndex];
    state = nextState;
    _generateFromState();
  }

  static List<Piece> pieces = [
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
