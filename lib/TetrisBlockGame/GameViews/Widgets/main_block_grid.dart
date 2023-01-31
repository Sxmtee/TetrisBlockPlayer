import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_dimensions.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/block_drag_target.dart';

class BlockGrid extends StatelessWidget {
  const BlockGrid({super.key});

  @override
  Widget build(BuildContext context) {
    var itemSize =
        (MediaQuery.of(context).size.width * 0.95) / Dimensions.gridSize;

    var screenSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.yellow.shade900, width: 6),
          borderRadius: BorderRadius.circular(15),
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/tetris plate_2.jpg"))),
      height: screenSize.width / 1.01,
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
                                    color: Colors.black87,
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
    );
  }
}
