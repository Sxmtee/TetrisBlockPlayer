import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/piece.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';

class BlockItemPreview extends StatelessWidget {
  final Piece piece;
  final double size;
  const BlockItemPreview({super.key, required this.piece, required this.size});

  @override
  Widget build(BuildContext context) {
    return Consumer<TetrisSudoku>(builder: (context, game, child) {
      debugPrint("ROTATION: ${game.onRotation}");
      return SizedBox(
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            piece.occupations.length,
            (y) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  piece.occupations[y].length,
                  (x) {
                    return Container(
                        width: size,
                        height: size,
                        decoration:
                            piece.occupations[y][x] == true && game.onRotation
                                ? const BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [Colors.blue, Colors.blue],
                                        stops: [0.5, 1],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight))
                                : piece.occupations[y][x] == true
                                    ? const BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                            Color(0xFFff9900),
                                            Color(0xFFffcc00),
                                          ],
                                            stops: [
                                            0.5,
                                            1
                                          ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight))
                                    : const BoxDecoration());
                  },
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
