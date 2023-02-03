import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:somtotetris/TetrisBlockGame/Ads/interstitial_ad.dart';
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
  void showAd() {
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('%ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        interstitialAd = null;
        pageAd();
        Timer(const Duration(seconds: 4), (() {
          var route = MaterialPageRoute(
            builder: (context) {
              return const PlayScreen();
            },
          );
          Navigator.push(context, route);
        }));
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        pageAd();
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );
    interstitialAd!.show();
  }

  @override
  void initState() {
    super.initState();
    if (interstitialAd == null) {
      pageAd();
    }
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (interstitialAd != null) {
        timer.cancel();
        showAd();
      } else if (timer.tick > 3) {
        var route = MaterialPageRoute(
          builder: (context) {
            return const PlayScreen();
          },
        );
        Navigator.push(context, route);
      }
    });
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
            Text("Game Over",
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
