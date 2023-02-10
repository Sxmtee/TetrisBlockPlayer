import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';

exitGame(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.amber,
    title: const Text(
      "Exit Game",
      style: TextStyle(
          fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 15),
    ),
    content: const Text("You're about to exit this game"),
    actions: [
      MaterialButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Cancel"),
      ),
      MaterialButton(
        onPressed: () {
          var game = context.read<TetrisSudoku>();
          game.dispose();
          SystemNavigator.pop();
        },
        child: const Text("Exit"),
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      });
}
