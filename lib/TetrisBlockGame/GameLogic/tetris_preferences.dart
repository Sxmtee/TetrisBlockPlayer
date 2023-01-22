import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/tetris_gameover.dart';

Future<void> showGameOverDialog(BuildContext context, int score) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int highscore = prefs.getInt('highscore') ?? 0;
  if (score > highscore) {
    await prefs.setInt('highscore', score);
  }

  // show the GameScreen
  var route = MaterialPageRoute(
    builder: (context) {
      return GameOver(score: score, highscore: highscore);
    },
  );
  Navigator.push(context, route);
}
