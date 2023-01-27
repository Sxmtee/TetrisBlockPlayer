import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/tetris_main_page.dart';

class PlayScreen extends StatelessWidget {
  PlayScreen({super.key});

  int count = 0;
  goBack() {
    if (count >= 1) {
      SystemNavigator.pop();
    } else {
      count++;
    }
  }

  // void startMusic(AudioPlayer player) async {
  //   // player.play('');
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<TetrisSudoku>(builder: (context, game, child) {
      // if (game.musicOn && game.players[''].state != PlayerState.playing) {
      //   startMusic(game.players[''])
      // }
      return WillPopScope(
        onWillPop: () async {
          game.dispose();
          goBack();
          return false;
        },
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/TetrisBG.jpg"))),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 145, bottom: 65),
                  child: Image.asset("assets/images/TetrisLogo.png"),
                ),
                NiceButtons(
                    borderColor: Colors.transparent,
                    startColor: const Color(0xFFff751a),
                    endColor: const Color(0xFFff751a),
                    stretch: false,
                    progress: true,
                    gradientOrientation: GradientOrientation.Horizontal,
                    onTap: (finish) {
                      Timer(const Duration(seconds: 5), () {
                        finish();
                        var route = MaterialPageRoute(
                            builder: ((context) => const TetrisSudokuPage()));
                        Navigator.push(context, route);
                      });
                    },
                    child: const Icon(Icons.play_circle_fill_outlined)),
              ],
            ),
          ),
        ),
      );
    });
  }
}
