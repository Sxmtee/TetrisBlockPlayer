import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_preferences.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/play_screen.dart';

class StatusBar extends StatefulWidget {
  const StatusBar({super.key});

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  int? bestScore;

  @override
  void initState() {
    super.initState();
    bestScore = GamePreferences.getHighScore();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: AppBar(
        shape: const StadiumBorder(),
        leading: CircleAvatar(
          backgroundColor: const Color(0XFFff751a),
          child: IconButton(
            onPressed: () {
              var route = MaterialPageRoute(
                builder: (context) {
                  return PlayScreen();
                },
              );
              Navigator.push(context, route);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "BEST",
                  style: TextStyle(color: Colors.brown.shade700),
                ),
                Container(
                  width: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.brown.shade900,
                  ),
                  child: Text("$bestScore",
                      style: TextStyle(
                          fontFamily: "Poppins", color: Colors.brown.shade500)),
                ),
              ],
            ),
            Column(
              children: [
                Text("SCORE", style: TextStyle(color: Colors.brown.shade700)),
                Consumer<TetrisSudoku>(builder: (context, game, child) {
                  return Container(
                    width: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.brown.shade900,
                    ),
                    child: Text(
                      "${game.score}",
                      style: TextStyle(
                          fontFamily: "Poppins", color: Colors.amber.shade400),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
        actions: [
          Consumer<TetrisSudoku>(builder: (context, game, child) {
            return SpeedDial(
              overlayOpacity: 0.0,
              curve: Curves.easeInCirc,
              spaceBetweenChildren: 0.0,
              backgroundColor: Colors.green,
              icon: Icons.play_arrow_rounded,
              activeIcon: Icons.pause,
              direction: SpeedDialDirection.down,
              children: [
                SpeedDialChild(
                    backgroundColor: Colors.blue,
                    onTap: () {},
                    child: const Icon(Icons.mic)),
                SpeedDialChild(
                  backgroundColor: Colors.blue,
                  onTap: () {
                    game.reset();
                  },
                  child: const Icon(Icons.replay),
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}
