import 'dart:async';

import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/play_screen.dart';

class GameOver extends StatefulWidget {
  final int score;
  final int highscore;
  const GameOver({
    super.key,
    required this.score,
    required this.highscore,
  });

  @override
  State<GameOver> createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), (() {
      var route = MaterialPageRoute(
        builder: (context) {
          return PlayScreen();
        },
      );
      Navigator.push(context, route);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Text("GameOver",
                style: TextStyle(
                    fontSize: 50,
                    fontFamily: "Poppins",
                    color: Colors.brown.shade400)),
            Image.asset(
              "assets/images/scoretrophy.png",
              height: 300,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "BEST",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Intel",
                          color: Colors.brown.shade400),
                    ),
                    Text(
                      "${widget.highscore}",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Intel",
                          color: Colors.brown.shade400),
                    )
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  children: [
                    Text(
                      "SCORE",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Intel",
                          color: Colors.brown.shade400),
                    ),
                    Text(
                      "${widget.score}",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Intel",
                          color: Colors.brown.shade400),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
