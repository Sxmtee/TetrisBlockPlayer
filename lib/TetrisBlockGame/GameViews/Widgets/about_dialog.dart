import 'package:flutter/material.dart';

aboutGame(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    title: Text(
      "ABOUT",
      style: TextStyle(
          fontFamily: "Poppins",
          color: Colors.yellow.shade700,
          fontWeight: FontWeight.bold,
          fontSize: 15),
    ),
    content: const Text(
        "Tetris Jigsaw© is a work of  art created by the Games Team of Digital Dreams Limited.\n Credits go to:\n 1) Mr. Chux Edoga (CEO & Project Manager)\n 2) Mr. Victor Anya (Team Lead)\n 3) Mr. Amos Chibueze (Snr. Software Dev.)\n 4) Mr. Somto Ochiabutor (Game Dev.)\n 5) Mr. Harrison Ilodiuba (UI/UX Designer)"),
  );
  showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      });
}
