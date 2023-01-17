import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/tetris_sudoku/logic/tetris_sudoku.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer<TetrisSudoku>(
            builder: (context, game, child) => Text(
              'Score: ${game.score}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
