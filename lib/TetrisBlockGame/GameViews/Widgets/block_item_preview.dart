import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/piece.dart';

class BlockItemPreview extends StatelessWidget {
  final Piece piece;
  final double size;
  const BlockItemPreview({super.key, required this.piece, required this.size});

  @override
  Widget build(BuildContext context) {
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
                  return SizedBox(
                    width: size,
                    height: size,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        //asset image for the block piece will come here
                        border: Border.all(
                          color: (piece.occupations[y][x] == true)
                              ? Colors.black
                              : Colors.transparent,
                          width: 1,
                        ),
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
