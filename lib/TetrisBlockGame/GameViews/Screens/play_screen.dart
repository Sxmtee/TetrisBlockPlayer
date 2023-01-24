import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/tetris_main_page.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(color: Colors.brown),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton.icon(
          onPressed: () {
            var route = MaterialPageRoute(
                builder: ((context) => const TetrisSudokuPage()));
            Navigator.push(context, route);
          },
          icon: const Icon(
            CupertinoIcons.play_circle_fill,
            size: 50,
            color: Color(0xFFFE0037),
          ),
          label: const Text(""),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size(double.infinity, 56),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
