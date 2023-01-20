import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_dimensions.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/block_drag_target.dart';

class BlockGrid extends StatelessWidget {
  const BlockGrid({super.key});

  @override
  Widget build(BuildContext context) {
    var itemSize =
        (MediaQuery.of(context).size.width * 0.9) / Dimensions.gridSize;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.width,
      child: Center(
        // child: Padding(
        // padding: const EdgeInsets.all(8.0),
        child: Column(
          children: List.generate(
            Dimensions.blockCount,
            (by) {
              return Row(
                children: List.generate(
                  Dimensions.blockCount,
                  (bx) {
                    return Column(
                      children: List.generate(
                        Dimensions.blockSize,
                        (y) {
                          return Row(
                            children: List.generate(
                              Dimensions.blockSize,
                              (x) {
                                int currX = bx * Dimensions.blockSize + x;
                                int currY = by * Dimensions.blockSize + y;
                                return DecoratedBox(
                                  position: DecorationPosition.foreground,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: BlockDragTarget(
                                      currX: currX,
                                      currY: currY,
                                      itemSize: itemSize),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        // ),
      ),
    );
  }
}
