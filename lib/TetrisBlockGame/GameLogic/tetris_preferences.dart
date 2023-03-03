// import 'dart:io';

// import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/tetris_gameover.dart';

class GamePreferences {
  static late SharedPreferences _preferences;
  static int _highscore = 0;
  static String _nickName = "";

  static Future init() async {
    // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    //   await DesktopWindow.setWindowSize(const Size(400, 700));
    //   DesktopWindow.setMinWindowSize(const Size(400, 700));
    // }

    _preferences = await SharedPreferences.getInstance();
    _highscore = _preferences.getInt('highscore') ?? 0;
    _nickName = _preferences.getString('nickName') ?? '';
  }

  static Future setHighScore(BuildContext context, int score) async {
    if (score > _highscore) {
      _highscore = score;
      await _preferences.setInt('highscore', score);
    }

    // navigate to game over screen
    var route = MaterialPageRoute(
      builder: (context) {
        return GameOver(score: score, highscore: _highscore);
      },
    );
    Navigator.push(context, route);
  }

  static int? getHighScore() => _highscore;

  static Future setNickname(String nickname) async {
    _nickName = nickname;
    await _preferences.setString("nickName", nickname);
  }

  static String? getNickname() => _nickName;
}
