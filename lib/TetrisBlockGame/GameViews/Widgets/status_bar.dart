import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: AppBar(
        shape: const StadiumBorder(),
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: IconButton(
            onPressed: () {},
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
                Consumer<TetrisSudoku>(builder: (context, game, child) {
                  return Container(
                    width: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.brown.shade900,
                    ),
                    child: const Text("0"),
                  );
                }),
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
                    child: Text("${game.score}"),
                  );
                }),
              ],
            ),
          ],
        ),
        actions: [
          SpeedDial(
            overlayOpacity: 0.0,
            curve: Curves.easeInCirc,
            spaceBetweenChildren: 0.0,
            backgroundColor: Colors.green,
            icon: Icons.play_arrow_rounded,
            activeIcon: Icons.pause,
            direction: SpeedDialDirection.down,
            children: [
              SpeedDialChild(
                onTap: () {},
                child: const Icon(Icons.mic),
              ),
              SpeedDialChild(
                onTap: () {},
                child: const Icon(Icons.replay),
              ),
            ],
          )
        ],
      ),
    );
  }
}
