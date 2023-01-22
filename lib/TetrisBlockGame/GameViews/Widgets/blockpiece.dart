import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';

class Block extends StatelessWidget {
  final double itemSize;
  final int currX;
  final int currY;

  const Block(
      {super.key,
      required this.itemSize,
      required this.currX,
      required this.currY});

  @override
  Widget build(BuildContext context) {
    return Consumer<TetrisSudoku>(builder: (context, game, child) {
      return SizedBox(
        width: itemSize,
        height: itemSize,
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 0.1,
              ),
              color: game.isGameOver()
                  ? Colors.grey[800]
                  : game.isCompleted(currX, currY)
                      ? Colors.amber.shade500
                      : game.isSet(currX, currY)
                          ? Colors.brown.shade600
                          : (game.isPreview(currX, currY)
                              ? Colors.brown.shade400
                              : Colors.brown.shade300)),
        ),
      );
    });
  }
}
