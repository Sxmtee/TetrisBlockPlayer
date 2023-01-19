import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:somtotetris/tetris_sudoku/logic/drag_data.dart';
import 'package:somtotetris/tetris_sudoku/logic/piece.dart';
import 'package:somtotetris/tetris_sudoku/logic/tetris_sudoku.dart';
import 'package:somtotetris/tetris_sudoku/ui/block_item_preview.dart';
import 'package:somtotetris/tetris_sudoku/ui/empty_item_preview.dart';

class NextItemList extends StatelessWidget {
  const NextItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TetrisSudoku>(builder: (context, game, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(1, (index) {
          Piece piece = game.nextPieces[index];
          if (piece == null) {
            return const EmptyItemPreview();
          } else {
            return Draggable<DragData>(
              data: DragData(piece, index),
              childWhenDragging: const EmptyItemPreview(),
              feedback: BlockItemPreview(piece: piece, size: 20),
              child: BlockItemPreview(piece: piece, size: 25),
            );
          }
        }),
      );
    });
  }
}
