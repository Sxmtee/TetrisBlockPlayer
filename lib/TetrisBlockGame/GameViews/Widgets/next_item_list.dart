import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/drag_data.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/piece.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/block_item_preview.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/empty_item_preview.dart';

class NextItemList extends StatelessWidget {
  const NextItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TetrisSudoku>(builder: (context, game, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) {
          Piece piece = game.nextPieces[index];
          if (piece == null) {
            return const EmptyItemPreview();
          } else {
            return Draggable<DragData>(
              data: DragData(piece, index),
              childWhenDragging: const EmptyItemPreview(),
              feedback: BlockItemPreview(piece: piece, size: 30),
              child: BlockItemPreview(piece: piece, size: 15),
            );
          }
        }),
      );
    });
  }
}
