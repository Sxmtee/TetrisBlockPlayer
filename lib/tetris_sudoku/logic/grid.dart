import 'dart:math';

import 'package:somtotetris/tetris_sudoku/logic/piece.dart';
import 'package:somtotetris/tetris_sudoku/tetris_sudoku_settings.dart';

enum GridState { CLEAR, SET, COMPLETED }

class Grid {
  final List<GridState> _grid;

  Grid()
      : _grid = List<GridState>.filled(
            Settings.gridSize * Settings.gridSize, GridState.CLEAR);
  Grid.copy(Grid other) : _grid = other._grid.toList();

  bool notInGrid(int x, int y) {
    return x < 0 || x >= Settings.gridSize || y < 0 || y >= Settings.gridSize;
  }

  bool isSet(int x, int y) {
    return _isState(x, y, GridState.SET);
  }

  bool isClear(int x, int y) {
    return _isState(x, y, GridState.CLEAR);
  }

  bool isCompleted(int x, int y) {
    return _isState(x, y, GridState.COMPLETED);
  }

  bool _isState(int x, int y, GridState state) {
    if (notInGrid(x, y)) throw {"Index out of range ${x}x ${y}y"};
    return _grid[x + Settings.gridSize * y] == state;
  }

  void setValue(int x, int y, GridState value) {
    if (notInGrid(x, y)) throw {"Index out of range ${x}x ${y}y"};
    _grid[x + Settings.gridSize * y] = value;
  }

  void clearGrid() {
    _grid.fillRange(0, Settings.gridSize * Settings.gridSize, GridState.CLEAR);
  }

  void set(Piece piece, int x, int y, [GridState value = GridState.SET]) {
    Point? position = _calculateBestPosition(piece.occupations, x, y);
    if (position == null) return;

    setValues(piece.occupations, position.x.toInt(), position.y.toInt(), value);
  }

  void setValues(List<List<bool>> occupations, int x, int y,
      [GridState value = GridState.SET]) {
    int currY = y;
    for (var row in occupations) {
      int currX = x;
      for (var element in row) {
        setValue(
            currX,
            currY,
            element ||
                    _grid[currX + Settings.gridSize * currY] != GridState.CLEAR
                ? value
                : GridState.CLEAR);
        currX++;
      }
      currY++;
    }
  }

  bool doesFit(Piece piece, int x, int y) {
    return _doesFit(piece.occupations, x, y);
  }

  bool _doesFit(List<List<bool>> occupations, int x, int y) {
    int currY = y;
    for (var row in occupations) {
      int currX = x;
      for (var element in row) {
        if (notInGrid(currX, currY) ||
            (isSet(currX, currY) && element == true)) {
          return false;
        }
        currX++;
      }
      currY++;
    }
    return true;
  }

  Point? calculateBestPosition(Piece piece, int x, int y) {
    return _calculateBestPosition(piece.occupations, x, y);
  }

  Point? _calculateBestPosition(List<List<bool>> occupations, int x, int y) {
    int sizeY = occupations.length;
    int sizeX = occupations[0].length;

    Point center = Point(x, y);
    Point? best;

    for (int offY = -2; offY < sizeY + 2; offY++) {
      for (int offX = -2; offX < sizeX + 2; offX++) {
        if (_doesFit(occupations, x + offX, y + offY)) {
          Point current = Point(x + offX, y + offY);

          if (best == null ||
              center.squaredDistanceTo(best) >
                  center.squaredDistanceTo(current)) {
            best = current;

            // early return if a very good fit was found to save on computation time
            if (center.squaredDistanceTo(best) < 1.0) {
              return best;
            }
          }
        }
      }
    }
    return best;
  }
}
