import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:http/http.dart' as http;
import 'package:platform_device_id/platform_device_id.dart';
import 'package:somtotetris/TetrisBlockGame/Ads/interstitial_ad.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_preferences.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/play_screen.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/tetris_main_page.dart';

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
  Future<void> post() async {
    final uri = Uri.parse("http://cbtportal.linkskool.com/api/post_score.php");
    Map<String, dynamic> postData = {};
    String deviceId = await PlatformDeviceId.getDeviceId ?? '';
    postData["score"] = GamePreferences.getHighScore();
    postData["username"] = GamePreferences.getNickname();
    postData["avatar"] = 0;
    postData["device_id"] = deviceId;
    postData["mode"] = 1;
    postData["game_type"] = "TetrisJigsaw";
    var response = await http.post(uri, body: jsonEncode(postData));
    if (response.statusCode == 200) {
      debugPrint('Successful: ${response.body}');
    } else {
      debugPrint('ERROR: ${response.body}');
    }
  }

  void showAd() async {
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('%ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        interstitialAd = null;
        pageAd();
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
    post();
    if (interstitialAd == null) {
      pageAd();
    }
    Timer(const Duration(seconds: 1), () {
      if (interstitialAd != null) {
        showAd();
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
              height: 30,
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
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                NiceButtons(
                    height: 60,
                    width: 145,
                    borderColor: Colors.brown.shade900,
                    startColor: Colors.brown.shade400,
                    endColor: Colors.brown.shade400,
                    progressColor: Colors.brown.shade900,
                    progressSize: 30,
                    stretch: false,
                    progress: true,
                    gradientOrientation: GradientOrientation.Horizontal,
                    onTap: (finish) {
                      Timer(const Duration(seconds: 5), () {
                        finish();
                        // showAd();
                        var route = MaterialPageRoute(
                            builder: ((context) => const PlayScreen()));
                        Navigator.push(context, route);
                      });
                    },
                    child: const Text("Home")),
                const SizedBox(
                  width: 10,
                ),
                NiceButtons(
                    height: 60,
                    width: 145,
                    borderColor: Colors.brown.shade900,
                    startColor: Colors.brown.shade400,
                    endColor: Colors.brown.shade400,
                    progressColor: Colors.brown.shade900,
                    progressSize: 30,
                    stretch: false,
                    progress: true,
                    gradientOrientation: GradientOrientation.Horizontal,
                    onTap: (finish) {
                      Timer(const Duration(seconds: 5), () {
                        finish();
                        showAd();
                        var newRoute = MaterialPageRoute(
                            builder: ((context) => const TetrisSudokuPage()));
                        Navigator.pushReplacement(context, newRoute);
                      });
                    },
                    child: const Text("Play Again")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
