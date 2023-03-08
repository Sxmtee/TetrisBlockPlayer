import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/Ads/rewarded.dart';

RewardedState rewardedState = RewardedState();

adDialog(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.brown.shade400,
    title: const Text(
      "Rotate BlockPiece",
      style: TextStyle(
          fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 20),
    ),
    content: const Text(
        "In order to rotate a Block Piece, you have to watch an Ad",
        style: TextStyle(fontFamily: "Poppins", fontSize: 15)),
    actions: [
      MaterialButton(
        onPressed: () {
          rewardedState.loadAd(context);
          Navigator.pop(context);
        },
        child: const Text("Watch Ad"),
      ),
      MaterialButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Cancel"),
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      });
}
