import 'dart:math';

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
    _anim = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
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
            child: Stack(
                children: List.generate(
              Dimensions.gridSize,
              (y) {
                return List.generate(Dimensions.gridSize, (x) {
                  if ((game.col != null || game.row != null) &&
                      !_controller.isAnimating) {
                    _controller.forward();
                  }
                  return AnimatedBuilder(
                      animation: _anim,
                      builder: (context, child) => Positioned(
                          top: y * itemSize +
                              ((game.col != null && game.col!.contains(x)) ||
                                      (game.row != null &&
                                          game.row!.contains(y))
                                  ? _anim.value * width * pow(-1, x)
                                  : 0),
                          left: x * itemSize -
                              ((game.col != null && game.col!.contains(x)) ||
                                      (game.row != null &&
                                          game.row!.contains(y))
                                  ? _anim.value * width * pow(-1, y)
                                  : 0),
                          child: Transform.rotate(
                            angle: (game.col != null &&
                                        game.col!.contains(x)) ||
                                    (game.row != null && game.row!.contains(y))
                                ? _anim.value * pi
                                : 0,
                            child: DecoratedBox(
                              position: DecorationPosition.foreground,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black87,
                                  width: 1,
                                ),
                              ),
                              child: BlockDragTarget(
                                  currX: x, currY: y, itemSize: itemSize),
                            ),
                          )));
                });
              },
            ).expand((elem) => elem).toList())));
  }
}
