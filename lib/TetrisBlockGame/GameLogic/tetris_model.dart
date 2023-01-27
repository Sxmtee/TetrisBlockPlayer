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
  int bestScore = 0;
  bool scoredLastInteraction = false;

  late List<Piece> nextPieces;
  final cache = AudioCache();
  final Map<String, AudioPlayer> players = {};

  TetrisSudoku() {
    nextPieces = generateNextPieces();
    _valueGrid = Grid();
    _previewGrid = Grid();
    cache.loadAll(Sounds.values.map((e) => e.filename).toList());
    Sounds.values.forEach((e) {
      players[e.filename] = AudioPlayer();
    });
  }

  void dispose() {
    players.forEach((_, player) {
      player.dispose();
    });
  }

  //random piece generator
  List<Piece> generateNextPieces() {
    List<Piece> elements = [];

    Random random = Random();
    for (int i = 0; i < 3; i++) {
      elements.add(Piece.pieces[random.nextInt(Piece.pieces.length)]);
    }
    return elements;
  }

  //setting the piece and score multiplier
  bool set(Piece piece, int x, int y, int index) {
    nextPieces[index];
    if (nextPieces.any((element) => element != null)) {
      nextPieces = generateNextPieces();
    }

    score += Dimensions.scoreForBlockSet * scoreMultiplier;
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

  //preview before setting block tiles
  void setPreview(Piece piece, int currX, int currY) {
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
    for (Piece piece in nextPieces) {
      if (piece != null) {
        for (int y = 0; y < Dimensions.gridSize; y++) {
          for (int x = 0; x < Dimensions.gridSize; x++) {
            if (_valueGrid.doesFit(piece, x, y)) return false;
          }
        }
      }
    }
    return true;
  }

  //To clear The Columns and Rows when they've aligned
  bool clearIfSet({bool editValueGrid = true}) {
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

    bool wasCleared = false;
    Grid newValueGrid = Grid.copy(_valueGrid);

    for (int row = 0; row < Dimensions.gridSize; row++) {
      if (isRowSet(row)) {
        wasCleared = true;
        _previewGrid.setValues([
          [true, true, true, true, true, true, true, true, true]
        ], 0, row, GridState.COMPLETED);
        if (editValueGrid) {
          score += Dimensions.scoreForBlockCleared * scoreMultiplier;
          for (int x = 0; x < Dimensions.gridSize; x++) {
            newValueGrid.setValue(x, row, GridState.CLEAR);
            // here would an animation start to show
          }
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
          score += Dimensions.scoreForBlockCleared * scoreMultiplier;
          for (int y = 0; y < Dimensions.gridSize; y++) {
            newValueGrid.setValue(col, y, GridState.CLEAR);
            // here would an animation start to show
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
