import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/drag_data.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_preferences.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/nextitemlist/blockpiece.dart';

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
        return game.canPlaceFrom(data!.piece, currX, currY - 2);
      },
      onLeave: (data) {
        context.read<TetrisSudoku>().clearPreview();
      },
      onMove: (details) {
        var game = context.read<TetrisSudoku>();
        game.setPreview(details.data.piece, currX, currY - 2);
      },
      onAccept: (data) async {
        var game = context.read<TetrisSudoku>();
        game.clearPreview();
        await game.set(data.piece, currX, currY - 2, data.index);
        if (game.isGameOver()) {
          game.players.forEach((_, player) {
            if (player.state == PlayerState.playing) player.stop();
          });
          final player = game.players[Sounds.gameover.filename];
          player!.play(AssetSource(Sounds.gameover.filename), volume: 100);
          Future.delayed(const Duration(seconds: 2)).then(
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
