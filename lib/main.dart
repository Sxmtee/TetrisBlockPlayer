import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/digital_dream.dart';

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
          home: const DigitalDreams(),
        );
      },
    );
  }
}
