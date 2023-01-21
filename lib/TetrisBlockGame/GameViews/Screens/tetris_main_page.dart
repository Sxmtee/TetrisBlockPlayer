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
        child: Center(
          child: Column(
            children: const [
              StatusBar(),
              SizedBox(
                height: 108,
              ),
              BlockGrid(),
              SizedBox(
                height: 56,
              ),
              NextItemList(),
            ],
          ),
        ),
      ),
    );
  }
}
