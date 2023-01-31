import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_dimensions.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/main_block_grid.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/next_item_list.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/status_bar.dart';

class TetrisSudokuPage extends StatelessWidget {
  const TetrisSudokuPage({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var itemSize =
        (MediaQuery.of(context).size.width * 0.95) / Dimensions.gridSize;

    return Scaffold(
      body: Consumer<TetrisSudoku>(builder: (context, game, child) {
        return Container(
          height: sizeHeight,
          decoration: BoxDecoration(
            color: Colors.brown.shade600,
          ),
          child: Column(
            children: [
              const Flexible(child: StatusBar()),
              SizedBox(
                height: sizeHeight / 20,
              ),
              Stack(children: [
                const BlockGrid(),
                // if (game.isCompleted(x, y))
                for (var _ in List.filled(9, 0))
                  Align(
                    alignment: const Alignment(0, 0),
                    child: Container(
                      width: itemSize,
                      height: itemSize,
                    ),
                  )
              ]),
              SizedBox(
                height: sizeHeight / 20,
              ),
              const FittedBox(child: NextItemList()),
            ],
          ),
        );
      }),
    );
  }
}
