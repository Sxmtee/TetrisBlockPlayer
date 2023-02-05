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
            gradient: LinearGradient(
                colors: game.isGameOver()
                    ? [Colors.grey.shade800, Colors.grey.shade600]
                    : game.isCompleted(currX, currY)
                        ? [Colors.brown.shade600, Colors.brown.shade600]
                        : game.isSet(currX, currY)
                            ? [
                                const Color(0xFFff9900),
                                const Color(0xFFffcc00),
                              ]
                            : game.isPreview(currX, currY)
                                ? [
                                    Colors.white.withOpacity(0.2),
                                    Colors.white.withOpacity(0.2)
                                  ]
                                : [Colors.transparent, Colors.transparent],
                stops: const [0.5, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            border: Border.all(
              color: Colors.white,
              width: 0.1,
            ),
          ),
        ),
      );
    });
  }
}
