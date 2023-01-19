import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:somtotetris/tetris_sudoku/logic/grid.dart';
import 'package:somtotetris/tetris_sudoku/logic/piece.dart';
import 'package:somtotetris/tetris_sudoku/tetris_sudoku_settings.dart';

class TetrisSudoku extends ChangeNotifier {
  late Grid _valueGrid;
  late Grid _previewGrid;

  int score = 0;
  int scoreMultiplier = 1;
  bool scoredLastInteraction = false;

  late List<Piece> nextPieces;

  TetrisSudoku() {
    nextPieces = generateNextPieces();
    _valueGrid = Grid();
    _previewGrid = Grid();
  }

  List<Piece> generateNextPieces() {
    List<Piece> elements = [];

    Random random = Random();
    for (int i = 0; i < 3; i++) {
      elements.add(Piece.pieces[random.nextInt(Piece.pieces.length)]);
    }
    return elements;
  }

  bool set(Piece piece, int x, int y, int index) {
    nextPieces[index];
    if (nextPieces.any((element) => element != null)) {
      nextPieces = generateNextPieces();
    }

    _valueGrid.set(piece, x, y);

    bool hasScoredLastInteraction = scoredLastInteraction;
    scoredLastInteraction = clearIfSet();

    if (hasScoredLastInteraction && scoredLastInteraction) {
      scoreMultiplier++;
    } else {
      scoreMultiplier = 1;
    }

    notifyListeners();
    return scoredLastInteraction;
  }

  void setPreview(Piece piece, int currX, int currY) {
    _previewGrid.clearGrid();
    Point? position = _valueGrid.calculateBestPosition(piece, currX, currY);
    if (position == null) return;
    _previewGrid.setValues(
        piece.occupations, position.x.toInt(), position.y.toInt());
    clearIfSet(editValueGrid: false);

    notifyListeners();
  }

  //To clear The Columns and Rows when they've aligned
  bool clearIfSet({bool editValueGrid = true}) {
    bool isRowSet(int row) {
      for (int x = 0; x < Settings.gridSize; x++) {
        if (_valueGrid.isClear(x, row) &&
            (editValueGrid || _previewGrid.isClear(x, row))) {
          return false;
        }
      }
      return true;
    }

    bool isColSet(int col) {
      for (int y = 0; y < Settings.gridSize; y++) {
        if (_valueGrid.isClear(col, y) &&
            (editValueGrid || _previewGrid.isClear(col, y))) {
          return false;
        }
      }
      return true;
    }

    bool wasCleared = false;
    Grid newValueGrid = Grid.copy(_valueGrid);

    for (int row = 0; row < Settings.gridSize; row++) {
      if (isRowSet(row)) {
        wasCleared = true;
        _previewGrid.setValues([
          [true, true, true, true, true, true, true, true, true]
        ], 0, row, GridState.COMPLETED);
        if (editValueGrid) {
          for (int x = 0; x < Settings.gridSize; x++) {
            newValueGrid.setValue(x, row, GridState.CLEAR);
          }
        }
      }
    }

    for (int col = 0; col < Settings.gridSize; col++) {
      if (isColSet(col)) {
        wasCleared = true;
        _previewGrid.setValues([
          [true],
          [true],
          [true],
          [true],
          [true],
          [true],
          [true],
          [true],
          [true]
        ], col, 0, GridState.COMPLETED);
        if (editValueGrid) {
          for (int y = 0; y < Settings.gridSize; y++) {
            newValueGrid.setValue(col, y, GridState.CLEAR);
          }
        }
      }
    }

    _valueGrid = newValueGrid;

    if (wasCleared && editValueGrid) {
      Timer(
        const Duration(seconds: 1),
        clearPreview,
      );
    }
    return wasCleared;
  }

  void clearPreview() {
    _previewGrid.clearGrid();
    notifyListeners();
  }

  bool canPlaceFrom(Piece piece, int currX, int currY) {
    return _valueGrid.calculateBestPosition(piece, currX, currY) != null;
  }

  void reset() {
    // score = 0;
    // scoreMultiplier = 1;
    // scoredLastInteraction = false;

    nextPieces = generateNextPieces();
    _valueGrid = Grid();
    _previewGrid = Grid();
  }

  bool isCompleted(int x, int y) {
    return _previewGrid.isCompleted(x, y);
  }

  bool isSet(int x, int y) {
    return _valueGrid.isSet(x, y);
  }

  bool isPreview(int x, int y) {
    return _previewGrid.isSet(x, y);
  }
}
