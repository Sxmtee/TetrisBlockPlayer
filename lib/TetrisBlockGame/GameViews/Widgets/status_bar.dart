import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_preferences.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/play_screen.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/settings_dialog.dart';

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
    var sizeHeight = MediaQuery.of(context).size.height;

    return Container(
        padding: EdgeInsets.only(top: sizeHeight / 13.33),
        height: sizeHeight / 4.71,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow.shade900, width: 6),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/tetris plate_2.jpg"))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                var route = MaterialPageRoute(
                  builder: (context) {
                    return PlayScreen();
                  },
                );
                Navigator.push(context, route);
              },
              iconSize: 25,
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.yellow.shade700,
              ),
            ),
            Column(
              children: [
                Text(
                  "BEST",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.yellow.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: 70,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                  ),
                  child: Text("$bestScore",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.yellow.shade700)),
                ),
              ],
            ),
            Image.asset(
              "assets/images/scoretrophy.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Text(
                  "SCORE",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.yellow.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<TetrisSudoku>(builder: (context, game, child) {
                  return Container(
                    width: 70,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black,
                    ),
                    child: Text("${game.score}",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.yellow.shade700)),
                  );
                }),
              ],
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const SettingsDialog();
                  },
                );
              },
              iconSize: 25,
              icon: Icon(
                Icons.settings,
                color: Colors.yellow.shade700,
              ),
            ),
          ],
        ));
  }
}
