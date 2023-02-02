import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/Ads/banner_ad.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/main_block_grid.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/next_item_list.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/status_bar.dart';

class TetrisSudokuPage extends StatelessWidget {
  const TetrisSudokuPage({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
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
                  SizedBox(
                    height: sizeHeight / 20,
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
