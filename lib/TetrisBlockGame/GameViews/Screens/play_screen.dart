import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/tetris_main_page.dart';

class PlayScreen extends StatelessWidget {
  PlayScreen({super.key});

  int count = 0;
  goBack() {
    if (count >= 1) {
      SystemNavigator.pop();
    } else {
      count++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        goBack();
        return false;
      },
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/TetrisBG.jpg"))),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 145, bottom: 65),
              child: Image.asset("assets/images/TetrisLogo.png"),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  var route = MaterialPageRoute(
                      builder: ((context) => const TetrisSudokuPage()));
                  Navigator.push(context, route);
                },
                icon: const Icon(
                  CupertinoIcons.play_circle_fill,
                  size: 35,
                  color: Colors.white,
                ),
                label: const Text("PLAY"),
                style: ElevatedButton.styleFrom(
                  textStyle:
                      const TextStyle(fontFamily: "Poppins", fontSize: 20),
                  backgroundColor: const Color(0xFFff751a),
                  minimumSize: const Size(double.infinity, 56),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(25),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
