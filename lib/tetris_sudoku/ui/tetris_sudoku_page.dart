import 'package:flutter/material.dart';
import 'package:somtotetris/tetris_sudoku/ui/block_grid.dart';
import 'package:somtotetris/tetris_sudoku/ui/next_item_list.dart';
import 'package:somtotetris/tetris_sudoku/ui/status_bar.dart';

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
                // StatusBar(),
                BlockGrid(),
                NextItemList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
