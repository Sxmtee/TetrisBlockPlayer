import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/tetris_sudoku/logic/tetris_sudoku.dart';

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
              // color: Colors.brown.shade300
              // game.isCompleted(currX, currY)
              //     ? Colors.amber.shade500
              //     :
              color: game.isSet(currX, currY)
                  ? Colors.transparent
                  : (game.isPreview(currX, currY)
                      ? Colors.transparent
                      : Colors.transparent),
            ),
            child: game.isSet(currX, currY)
                ? Container(
                    child: const Center(
                      child: Text("1"),
                    ),
                  )
                : (game.isPreview(currX, currY)
                    ? Container(
                        child: const Center(
                          child: Text("0"),
                        ),
                      )
                    : Container(
                        child: const Center(
                          child: Text("0"),
                        ),
                      )),
          ));
    });
  }
}
