import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/drag_data.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_preferences.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/blockpiece.dart';

class BlockDragTarget extends StatelessWidget {
  final int currX;
  final int currY;
  final double itemSize;
  const BlockDragTarget(
      {super.key,
      required this.currX,
      required this.currY,
      required this.itemSize});

  @override
  Widget build(BuildContext context) {
    return DragTarget<DragData>(
      onWillAccept: (data) {
        var game = context.read<TetrisSudoku>();
        game.setPreview(data!.piece, currX, currY);
        return game.canPlaceFrom(data.piece, currX, currY);
      },
      onLeave: (data) {
        context.read<TetrisSudoku>().clearPreview();
      },
      onAccept: (data) {
        var game = context.read<TetrisSudoku>();
        game.clearPreview();
        game.set(data.piece, currX, currY, data.index);
        if (game.isGameOver()) {
          Future.delayed(const Duration(seconds: 6)).then(
            (value) async {
              await GamePreferences.setHighScore(context, game.score);
              game.reset();
            },
          );
        }
      },
      builder: (context, candidateData, rejectedData) {
        return Block(itemSize: itemSize, currX: currX, currY: currY);
      },
    );
  }
}
