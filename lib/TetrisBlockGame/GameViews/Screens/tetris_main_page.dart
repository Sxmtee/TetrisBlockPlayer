import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/main_block_grid.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/next_item_list.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/status_bar.dart';

class TetrisSudokuPage extends StatelessWidget {
  const TetrisSudokuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: const [
                StatusBar(),
                SizedBox(
                  height: 30,
                ),
                BlockGrid(),
                SizedBox(
                  height: 100,
                ),
                NextItemList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
