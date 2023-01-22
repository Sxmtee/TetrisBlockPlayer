import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final int score;
  final int highscore;
  const GameOver({
    super.key,
    required this.score,
    required this.highscore,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        color: Colors.black,
        // alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              color: Colors.brown,
              child: const Text("GAME OVER"),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      "BEST",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      "$highscore",
                      style: const TextStyle(fontSize: 10),
                    )
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    const Text(
                      "SCORE",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      "$score",
                      style: const TextStyle(fontSize: 10),
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
