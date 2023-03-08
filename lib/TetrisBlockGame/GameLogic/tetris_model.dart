import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/grid_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/piece.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_dimensions.dart';

enum Sounds {
  pick('Music/pick.wav'),
  scatter('Music/scatter.wav'),
  drop("Music/drop.wav"),
  gameover("Music/gameover.wav"),
  neon("Music/neon.mp3");

  const Sounds(this.filename);
  final String filename;
}

class TetrisSudoku extends ChangeNotifier {
  late Grid _valueGrid;
  late Grid _previewGrid;

  int score = 0;
  int scoreMultiplier = 1;
  bool scoredLastInteraction = false;
  Map<String, List<int>> _setEntries = {};

  late List<Piece> nextPieces;
  final cache = AudioCache();
  final Map<String, AudioPlayer> players = {};
  bool canPlace = true;
  bool onRotation = false;
  // static const offsetY = 2;

  List<int>? get col => _setEntries['col'];
  List<int>? get row => _setEntries['row'];
  List<int>? get by => _setEntries['by'];
  List<int>? get bx => _setEntries['bx'];

  TetrisSudoku() {
    nextPieces = generateNextPieces();
    _valueGrid = Grid();
    _previewGrid = Grid();
    cache.loadAll(Sounds.values.map((e) => e.filename).toList());
    for (var e in Sounds.values) {
      players[e.filename] = AudioPlayer();
    }
  }
  
  @override
  void dispose() {
    super.dispose();
    players.forEach((_, player) {
      player.dispose();
    });
  }

  //rotate piece
  void changePieceState(int index) {
    final piece = nextPieces[index];
    piece.changeState();
    notifyListeners();
  }

  //toggle the rotation of the pieces
  void toggleRotation() {
    onRotation = !onRotation;
    notifyListeners();
  }

  //random piece generator
  List<Piece> generateNextPieces() {
    List<Piece> elements = [];

    Random random = Random();
    for (int i = 0; i < 3;) {
      final piece = Piece.pieces[random.nextInt(Piece.pieces.length)];
      if (elements.contains(piece)) continue;
      elements.add(piece);
      i++;
    }
    return elements;
  }

  //setting the piece and score multiplier
  Future<bool> set(Piece piece, int x, int y, int index) async {
    if (!canPlace) return false;
    canPlace = false;
    nextPieces[index] = Piece([], Shape.none, Length.none);
    if (!nextPieces.any((elem) => elem.occupations.isNotEmpty)) {
      nextPieces = generateNextPieces();
    }

    score += Dimensions.scoreForBlockSet * scoreMultiplier;
    _valueGrid.set(piece, x, y);
    notifyListeners();
    bool hasScoredLastInteraction = scoredLastInteraction;
    scoredLastInteraction = await clearIfSet();

    if (hasScoredLastInteraction && scoredLastInteraction) {
      scoreMultiplier++;
    } else {
      scoreMultiplier = 1;
    }
    canPlace = true;

    notifyListeners();
    return scoredLastInteraction;
  }

  //preview before setting block tiles
  void setPreview(Piece piece, int currX, int currY) {
    if (!canPlace) return;
    _previewGrid.clearGrid();
    Point? position = _valueGrid.calculateBestPosition(piece, currX, currY);
    if (position == null) return;
    _previewGrid.setValues(
        piece.occupations, position.x.toInt(), position.y.toInt());
    clearIfSet(editValueGrid: false);

    notifyListeners();
  }

  // game over
  bool isGameOver() {
    for (final piece in nextPieces) {
      if (piece.occupations.isNotEmpty) {
        for (int y = 0; y < Dimensions.gridSize; y++) {
          for (int x = 0; x < Dimensions.gridSize; x++) {
            if (_valueGrid.doesFit(piece, x, y)) return false;
          }
        }
      }
    }
    return true;
  }

  // bool scanForFitness(Piece piece) {
  //   final rowLen = piece.occupations.length;
  //   for (int y = 0; y < rowLen; y++) {
  //     final row = piece.occupations[y], colLen = row.length;
  //     for (int x = 0; x < colLen; x++) {
  //       final elem = row[x];
  //       if (!elem) continue;
  //       if (doesFit(piece.occupations, x, y)) return true;
  //     }
  //   }
  //   return false;
  // }

  //To clear The Columns and Rows when they've aligned
  Future<bool> clearIfSet({bool editValueGrid = true}) async {
    bool wasCleared = false;
    Grid newValueGrid = Grid.copy(_valueGrid);

    bool isBlockSet(int bx, int by) {
      for (int y = 0; y < Dimensions.blockSize; y++) {
        for (int x = 0; x < Dimensions.blockSize; x++) {
          if (_valueGrid.isClear(bx * Dimensions.blockSize + x,
                  by * Dimensions.blockSize + y) &&
              (editValueGrid ||
                  _previewGrid.isClear(bx * Dimensions.blockSize + x,
                      by * Dimensions.blockSize + y))) {
            return false;
          }
        }
      }
      return true;
    }

    bool isRowSet(int row) {
      for (int x = 0; x < Dimensions.gridSize; x++) {
        if (_valueGrid.isClear(x, row) &&
            (editValueGrid || _previewGrid.isClear(x, row))) {
          return false;
        }
      }
      return true;
    }

    bool isColSet(int col) {
      for (int y = 0; y < Dimensions.gridSize; y++) {
        if (_valueGrid.isClear(col, y) &&
            (editValueGrid || _previewGrid.isClear(col, y))) {
          return false;
        }
      }
      return true;
    }

    for (int by = 0; by < Dimensions.blockCount; by++) {
      for (int bx = 0; bx < Dimensions.blockCount; bx++) {
        if (isBlockSet(bx, by)) {
          wasCleared = true;
          _previewGrid.setValues([
            [true, true, true],
            [true, true, true],
            [true, true, true]
          ], bx * Dimensions.blockSize, by * Dimensions.blockSize,
              GridState.COMPLETED);

          if (editValueGrid) {
            if (!_setEntries.containsKey('by') ||
                !_setEntries.containsKey('bx')) {
              _setEntries['by'] = [];
              _setEntries['bx'] = [];
              _setEntries['by']!.add(by);
              _setEntries['bx']!.add(bx);
            }

            Future.delayed(const Duration(seconds: 3), () {
              score += Dimensions.scoreForBlockCleared * scoreMultiplier;
              for (int y = 0; y < Dimensions.blockSize; y++) {
                for (int x = 0; x < Dimensions.blockSize; x++) {
                  newValueGrid.setValue(bx * Dimensions.blockSize + x,
                      by * Dimensions.blockSize + y, GridState.CLEAR);
                }
              }
            });
          }
        }
      }
    }

    for (int row = 0; row < Dimensions.gridSize; row++) {
      if (isRowSet(row)) {
        wasCleared = true;
        _previewGrid.setValues([
          [true, true, true, true, true, true, true, true, true]
        ], 0, row, GridState.COMPLETED);
        if (editValueGrid) {
          if (!_setEntries.containsKey('row')) _setEntries['row'] = [];
          _setEntries['row']!.add(row);
          Future.delayed(const Duration(seconds: 3), () {
            score += Dimensions.scoreForBlockCleared * scoreMultiplier;
            for (int x = 0; x < Dimensions.gridSize; x++) {
              newValueGrid.setValue(x, row, GridState.CLEAR);
            }
          });
        }
      }
    }

    for (int col = 0; col < Dimensions.gridSize; col++) {
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
          if (!_setEntries.containsKey('col')) _setEntries['col'] = [];
          _setEntries['col']!.add(col);
          Future.delayed(const Duration(seconds: 3), () {
            score += Dimensions.scoreForBlockCleared * scoreMultiplier;
            for (int y = 0; y < Dimensions.gridSize; y++) {
              newValueGrid.setValue(col, y, GridState.CLEAR);
            }
          });
        }
      }
    }
    if (_setEntries.containsKey('col') ||
        _setEntries.containsKey('row') ||
        _setEntries.containsKey('by') ||
        _setEntries.containsKey('bx')) {
      notifyListeners();
      await Future.delayed(const Duration(seconds: 3));
    }
    _valueGrid = newValueGrid;

    if (wasCleared && editValueGrid) {
      Timer(
        const Duration(seconds: 1),
        clearPreview,
      );
    }
    _setEntries = {};
    return wasCleared;
  }

  void clearPreview() {
    _previewGrid.clearGrid();
    notifyListeners();
  }

  //calculating the best position to place the piece
  bool canPlaceFrom(Piece piece, int currX, int currY) {
    return _valueGrid.calculateBestPosition(piece, currX, currY) != null;
  }

  //reset all
  void reset() {
    score = 0;
    scoreMultiplier = 1;
    scoredLastInteraction = false;

    nextPieces = generateNextPieces();
    _valueGrid = Grid();
    _previewGrid = Grid();

    notifyListeners();
  }

  bool doesFit(List<List<bool>> occupations, int x, int y) {
    int currY = y;
    for (var row in occupations) {
      int currX = x;
      for (var _ in row) {
        if (_valueGrid.notInGrid(currX, currY) ||
            _valueGrid.isSet(currX, currY)) {
          return false;
        }
        currX++;
      }
      currY++;
    }
    return true;
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
