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
import 'package:url_launcher/url_launcher.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  final Uri _uri =
      Uri.parse("https://www.youtube.com/@digitaldreamsictacademy1353");

  _launchUrl() async {
    if (await canLaunchUrl(_uri)) {
      await launchUrl(_uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch $_uri');
    }
  }

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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        playMusic();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        stopMusic();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    WidgetsBinding.instance.removeObserver(this);
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
                      Timer(const Duration(seconds: 1), () {
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
                      borderColor: const Color(0XFF4700b3),
                      startColor: const Color(0XFF7a2eef),
                      endColor: const Color(0XFF7a2eef),
                      progressColor: Colors.brown.shade900,
                      progressSize: 30,
                      stretch: false,
                      progress: true,
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (finish) {
                        Timer(const Duration(seconds: 1), () {
                          finish();
                          _launchUrl();
                        });
                      },
                      child: const Text(
                        "Learn a Skill",
                        style: TextStyle(color: Colors.white),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  NiceButtons(
                      height: 60,
                      width: 145,
                      borderColor: const Color(0XFF4700b3),
                      startColor: const Color(0XFF7a2eef),
                      endColor: const Color(0XFF7a2eef),
                      progressColor: Colors.brown.shade900,
                      progressSize: 30,
                      stretch: false,
                      progress: true,
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (finish) {
                        Timer(const Duration(seconds: 1), () {
                          finish();
                          var route = MaterialPageRoute(
                              builder: ((context) => const LeaderBoard()));
                          Navigator.push(context, route);
                        });
                      },
                      child: const Text("LeaderBoard",
                          style: TextStyle(color: Colors.white))),
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
