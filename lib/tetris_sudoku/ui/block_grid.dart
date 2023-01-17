import 'package:flutter/material.dart';
import 'package:somtotetris/tetris_sudoku/tetris_sudoku_settings.dart';
import 'package:somtotetris/tetris_sudoku/ui/block_drag_target.dart';

class BlockGrid extends StatelessWidget {
  const BlockGrid({super.key});

  @override
  Widget build(BuildContext context) {
    var itemSize =
        (MediaQuery.of(context).size.width * 0.95) / Settings.gridSize;

    return Container(
      height: MediaQuery.of(context).size.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: List.generate(
              Settings.blockCount,
              (by) {
                return Row(
                  children: List.generate(
                    Settings.blockCount,
                    (bx) {
                      return DecoratedBox(
                        position: DecorationPosition.foreground,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: List.generate(
                            Settings.blockSize,
                            (y) {
                              return Row(
                                children: List.generate(
                                  Settings.blockSize,
                                  (x) {
                                    int currX = bx * Settings.blockSize + x;
                                    int currY = by * Settings.blockSize + y;
                                    return BlockDragTarget(
                                        currX: currX,
                                        currY: currY,
                                        itemSize: itemSize);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
