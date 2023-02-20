import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/drag_data.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_dimensions.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/nextitemlist/block_item_preview.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/nextitemlist/empty_item_preview.dart';

class NextItemList extends StatelessWidget {
  const NextItemList({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final itemSize = (size.width * 0.95) / Dimensions.gridSize;

    return Container(
      height: size.height / 5,
      width: size.width,
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: Colors.yellow.shade900, width: 6)),
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/tetris plate_2.jpg"))),
      child: Consumer<TetrisSudoku>(builder: (context, game, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (index) {
            final piece = game.nextPieces[index];
            if (piece.occupations.isEmpty) {
              return const EmptyItemPreview();
            } else {
              return Draggable<DragData>(
                onDragStarted: () {
                  final player = game.players[Sounds.pick.filename];
                  player!.play(AssetSource(Sounds.pick.filename));
                },
                data: DragData(piece, index),
                childWhenDragging: const EmptyItemPreview(),
                dragAnchorStrategy: (Draggable<Object> draggable,
                    BuildContext context, Offset position) {
                  return Offset(50, itemSize * 4);
                },
                feedback: Transform.scale(
                    scale: 1.25,
                    child: BlockItemPreview(piece: piece, size: 30)),
                child: BlockItemPreview(piece: piece, size: 15),
                onDragCompleted: () {
                  game.players.forEach((_, player) {
                    if (player.state == PlayerState.playing) player.stop();
                  });
                  final player = game.players[Sounds.drop.filename];
                  player!.play(AssetSource(Sounds.drop.filename), volume: 100);
                },
              );
            }
          }),
        );
      }),
    );
  }
}
