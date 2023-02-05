import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/Ads/banner_ad.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/leaderboard.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/tetris_main_page.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/playscreen/exit_dialog.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  playMusic() {
    var game = context.read<TetrisSudoku>();
    final player = game.players[Sounds.neon.filename];
    player!.play(
      AssetSource(Sounds.neon.filename),
    );
  }

  stopMusic() {
    var game = context.read<TetrisSudoku>();
    final player = game.players[Sounds.neon.filename];
    player!.stop();
  }

  @override
  void initState() {
    super.initState();
    playMusic();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(-0.2, 0),
      end: const Offset(0.2, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    var game = context.read<TetrisSudoku>();
    final player = game.players[Sounds.neon.filename];
    player!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myBanner = getBanner();
    return WillPopScope(
      onWillPop: () async {
        exitGame(context);
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/TetrisBG.jpg"))),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 145,
                ),
                child: Image.asset("assets/images/TetrisLogo.png"),
              ),
              SlideTransition(
                position: _animation,
                child: NiceButtons(
                    height: 60,
                    width: 150,
                    borderColor: const Color(0xFFff751a),
                    startColor: const Color(0xFFffcc00),
                    endColor: const Color(0xFFffcc00),
                    progressColor: const Color(0xFFff751a),
                    progressSize: 30,
                    stretch: false,
                    progress: true,
                    gradientOrientation: GradientOrientation.Horizontal,
                    onTap: (finish) {
                      Timer(const Duration(seconds: 5), () {
                        finish();
                        stopMusic();
                        var route = MaterialPageRoute(
                            builder: ((context) => const TetrisSudokuPage()));
                        Navigator.push(context, route);
                      });
                    },
                    child: const Icon(
                      Icons.play_circle_fill_outlined,
                      size: 30,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NiceButtons(
                      height: 60,
                      width: 145,
                      borderColor: Colors.brown.shade900,
                      startColor: Colors.red.shade400,
                      endColor: Colors.brown.shade400,
                      progressColor: Colors.brown.shade900,
                      progressSize: 30,
                      stretch: false,
                      progress: true,
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (finish) {
                        Timer(const Duration(seconds: 5), () {
                          finish();
                          // var route = MaterialPageRoute(
                          //     builder: ((context) => const PlayScreen()));
                          // Navigator.push(context, route);
                        });
                      },
                      child: const Text("Learn a Skill")),
                  const SizedBox(
                    width: 10,
                  ),
                  NiceButtons(
                      height: 60,
                      width: 145,
                      borderColor: Colors.brown.shade900,
                      startColor: Colors.brown.shade400,
                      endColor: Colors.red.shade400,
                      progressColor: Colors.brown.shade900,
                      progressSize: 30,
                      stretch: false,
                      progress: true,
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (finish) {
                        Timer(const Duration(seconds: 5), () {
                          finish();
                          var route = MaterialPageRoute(
                              builder: ((context) => const LeaderBoard()));
                          Navigator.push(context, route);
                        });
                      },
                      child: const Text("LeaderBoard")),
                ],
              ),
              const Spacer(),
              FittedBox(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: myBanner.size.width.toDouble(),
                  height: myBanner.size.height.toDouble(),
                  child: AdWidget(ad: myBanner),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
