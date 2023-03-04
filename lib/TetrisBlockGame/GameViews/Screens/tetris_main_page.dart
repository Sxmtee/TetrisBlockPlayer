import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/Ads/banner_ad.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_dimensions.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/mainpage/main_block_grid.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/mainpage/next_item_list.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/mainpage/status_bar.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/nextitemlist/block_drag_target.dart';

class TetrisSudokuPage extends StatelessWidget {
  const TetrisSudokuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    final itemSize = size.width * 0.9 / Dimensions.gridSize;
    final myBanner = getBanner();
    return Scaffold(
      body: Consumer<TetrisSudoku>(builder: (context, game, child) {
        return SingleChildScrollView(
          child: Container(
            height: sizeHeight,
            decoration: BoxDecoration(
              color: Colors.brown.shade600,
            ),
            child: Stack(children: [
              Column(
                children: [
                  const Flexible(child: StatusBar()),
                  SizedBox(
                    height: sizeHeight / 20,
                  ),
                  const BlockGrid(),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.amber,
                              child: Icon(
                                Icons.rotate_90_degrees_ccw,
                                color: Colors.brown.shade500,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.amber,
                              child: Icon(
                                Icons.thunderstorm,
                                color: Colors.brown.shade500,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.amber,
                              child: Icon(
                                Icons.scatter_plot,
                                color: Colors.brown.shade500,
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                          children: List.generate(
                        2,
                        (y) => Row(
                          children: List.generate(
                              Dimensions.gridSize,
                              (x) => Expanded(
                                    child: SizedBox(
                                      width: itemSize,
                                      height: itemSize,
                                      child: BlockDragTarget(
                                          currX: x,
                                          currY: Dimensions.gridSize + y,
                                          itemSize: itemSize),
                                    ),
                                  )),
                        ),
                      ))
                    ],
                  ),
                  const FittedBox(child: NextItemList()),
                ],
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: myBanner.size.width.toDouble(),
                    height: myBanner.size.height.toDouble(),
                    child: AdWidget(ad: myBanner),
                  )),
            ]),
          ),
        );
      }),
    );
  }
}
