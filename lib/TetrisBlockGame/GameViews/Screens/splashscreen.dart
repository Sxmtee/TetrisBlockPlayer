import 'dart:async';

import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/Ads/adOpen.dart';
import 'package:somtotetris/TetrisBlockGame/Ads/app_cycle.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_preferences.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/authscreen.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/play_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String? nickname = GamePreferences.getNickname();
  late AppLifecycleReactor appLifecycleReactor;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (nickname == '') {
        var route =
            MaterialPageRoute(builder: ((context) => const AuthScreen()));
        Navigator.push(context, route);
      } else {
        var route =
            MaterialPageRoute(builder: ((context) => const PlayScreen()));
        Navigator.push(context, route);
      }
    });
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                    "assets/images/Tetris Jigsaw Splash Screen BG.jpg"))),
      ),
    );
  }
}
