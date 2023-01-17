import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/tetris_sudoku/logic/tetris_sudoku.dart';
import 'package:somtotetris/tetris_sudoku/ui/tetris_sudoku_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TetrisSudoku>(
      create: (_) => TetrisSudoku(),
      lazy: false,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.brown,
          ),
          home: const TetrisSudokuPage(),
        );
      },
    );
  }
}
