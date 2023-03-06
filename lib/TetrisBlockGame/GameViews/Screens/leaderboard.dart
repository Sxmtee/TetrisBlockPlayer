import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/Ads/adOpen.dart';
import 'package:somtotetris/TetrisBlockGame/Ads/app_cycle.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/play_screen.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/leaderboard/maintab.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  late AppLifecycleReactor appLifecycleReactor;

  @override
  void initState() {
    super.initState();
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/tetris plate_2.jpg"))),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("LeaderBoard",
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: "Poppins",
                            color: Colors.yellow.shade800)),
                    IconButton(
                      onPressed: () {
                        var route = MaterialPageRoute(
                            builder: ((context) => const PlayScreen()));
                        Navigator.push(context, route);
                      },
                      icon: Icon(
                        Icons.cancel_presentation_rounded,
                        color: Colors.yellow.shade800,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    color: Colors.transparent, child: const MainTab()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
