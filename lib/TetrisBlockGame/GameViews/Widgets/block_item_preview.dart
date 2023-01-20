import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/piece.dart';

class BlockItemPreview extends StatelessWidget {
  final Piece piece;
  final double size;
  const BlockItemPreview({super.key, required this.piece, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
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
                  return SizedBox(
                    width: size,
                    height: size,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: (piece.occupations[y][x] == true)
                            ? Colors.brown.shade600
                            : Colors.transparent,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}