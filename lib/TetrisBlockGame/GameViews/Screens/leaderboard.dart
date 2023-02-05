import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/play_screen.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/leaderboard/maintab.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

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
                        Icons.cancel,
                        color: Colors.yellow.shade800,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: size.height / 2, child: const MainTab())
            ],
          ),
        ),
      ),
    );
  }
}
