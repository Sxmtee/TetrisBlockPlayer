import 'package:flutter/material.dart';
import 'package:somtotetris/tetris_sudoku/logic/piece.dart';

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
                              ? Colors.transparent
                              // Colors.brown.shade600
                              : Colors.transparent,
                        ),
                        child: (piece.occupations[y][x] == true)
                            ? Container(
                                child: const Center(
                                  child: Text("1"),
                                ),
                              )
                            : Container(
                                child: Center(
                                  child: Text("0"),
                                ),
                              )),
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
