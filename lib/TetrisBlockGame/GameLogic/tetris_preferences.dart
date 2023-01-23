import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/tetris_gameover.dart';

class GamePreferences {
  static late SharedPreferences _preferences;
  static int highscore = 0;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    highscore = _preferences.getInt('highscore') ?? 0;
  }

  static Future setHighScore(BuildContext context, int score) async {
    if (score > highscore) {
      highscore = score;
      await _preferences.setInt('highscore', score);
    }

    //navigate to game over screen
    var route = MaterialPageRoute(
      builder: (context) {
        return GameOver(score: score, highscore: highscore);
      },
    );
    Navigator.push(context, route);
  }

  static int? getHighScore() => highscore;
}
