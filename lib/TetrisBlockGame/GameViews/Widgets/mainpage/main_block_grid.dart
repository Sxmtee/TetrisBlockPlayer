import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_dimensions.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/nextitemlist/block_drag_target.dart';

class BlockGrid extends StatefulWidget {
  const BlockGrid({super.key});

  @override
  State<BlockGrid> createState() => _BlockGridState();
}

class _BlockGridState extends State<BlockGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;

  bool isInRange(List<int>? blockX, List<int>? blockY, int x, int y) {
    if (blockX == null || blockY == null) return false;
    final len = blockX.length;
    for (int i = 0; i < len; i++) {
      final bx = blockX[i], by = blockY[i];
      if (x >= bx * Dimensions.blockSize &&
          x < (bx + 1) * Dimensions.blockSize) {
        if (y >= by * Dimensions.blockSize &&
            y < (by + 1) * Dimensions.blockSize) {
          return true;
        }
      }
    }
    return false;
  }

  Color getColor(String side, int x, int y) {
    switch (side) {
      case 'top':
        if (y == 0) break;
        if (y % Dimensions.blockSize == 0) return Colors.grey.shade800;
        break;
      case 'left':
        if (x == 0) break;
        if (x % Dimensions.blockSize == 0) return Colors.grey.shade800;
        break;
      case 'right':
        if (x == Dimensions.gridSize - 1) break;
        if (x % Dimensions.blockSize == Dimensions.blockSize - 1) {
          return Colors.grey.shade800;
        }
        break;
      case 'bottom':
        if (y == Dimensions.gridSize - 1) break;
        if (y % Dimensions.blockSize == Dimensions.blockSize - 1) {
          return Colors.grey.shade800;
        }
    }
    return Colors.black87;
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reset();
            }
          });
    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final itemSize = (width * 0.95) / Dimensions.gridSize;

    return Consumer<TetrisSudoku>(
        builder: (context, game, child) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow.shade900, width: 6),
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/tetris plate_2.jpg"))),
            height: screenSize.width / 1.01,
            child: GestureDetector(
              onTapUp: (details) {
                if (game.isBomb) {
                  final box = context.findRenderObject() as RenderBox;
                  final pos = box.globalToLocal(details.globalPosition);
                  game.explodeAt(pos.dx, pos.dy, itemSize);
                }
              },
              child: Stack(
                  children: List.generate(
                Dimensions.gridSize,
                (y) {
                  return List.generate(Dimensions.gridSize, (x) {
                    if ((game.col != null ||
                            game.row != null ||
                            game.bx != null ||
                            game.by != null) &&
                        !_controller.isAnimating) {
                      _controller.forward();
                      game.players.forEach((_, player) {
                        if (player.state == PlayerState.playing) player.stop();
                      });
                      final player = game.players[Sounds.scatter.filename];
                      player!.play(AssetSource(Sounds.scatter.filename),
                          volume: 100);
                    }
                    return AnimatedBuilder(
                        animation: _anim,
                        builder: (context, child) => Positioned(
                            top: y * itemSize +
                                ((game.col != null && game.col!.contains(x)) ||
                                        (game.row != null &&
                                            game.row!.contains(y)) ||
                                        isInRange(game.bx, game.by, x, y)
                                    ? _anim.value * width * pow(-1, x)
                                    : 0),
                            left: x * itemSize -
                                ((game.col != null && game.col!.contains(x)) ||
                                        (game.row != null &&
                                            game.row!.contains(y)) ||
                                        isInRange(game.bx, game.by, x, y)
                                    ? _anim.value * width * pow(-1, y)
                                    : 0),
                            child: Transform.rotate(
                              angle:
                                  (game.col != null && game.col!.contains(x)) ||
                                          (game.row != null &&
                                              game.row!.contains(y)) ||
                                          isInRange(game.bx, game.by, x, y)
                                      ? _anim.value * pi
                                      : 0,
                              child: DecoratedBox(
                                position: DecorationPosition.foreground,
                                decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: getColor('top', x, y),
                                          width: 1),
                                      left: BorderSide(
                                          color: getColor('left', x, y),
                                          width: 1),
                                      right: BorderSide(
                                          color: getColor('right', x, y),
                                          width: 1),
                                      bottom: BorderSide(
                                          color: getColor('bottom', x, y),
                                          width: 1)),
                                ),
                                child: BlockDragTarget(
                                    currX: x, currY: y, itemSize: itemSize),
                              ),
                            )));
                  });
                },
              ).expand((elem) => elem).toList()),
            )));
  }
}
