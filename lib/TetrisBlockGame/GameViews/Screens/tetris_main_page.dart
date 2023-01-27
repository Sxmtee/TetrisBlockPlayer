import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/main_block_grid.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/next_item_list.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/status_bar.dart';

class TetrisSudokuPage extends StatelessWidget {
  const TetrisSudokuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown.shade600,
          ),
          child: Column(
            children: const [
              StatusBar(),
              SizedBox(
                height: 40,
              ),
              BlockGrid(),
              SizedBox(
                height: 40,
              ),
              NextItemList(),
            ],
          ),
        ),
      ),
    );
  }
}
