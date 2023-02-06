import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_preferences.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/play_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController nameCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(top: 300, left: 30, right: 30),
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/TetrisBG.jpg"))),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              controller: nameCtrl,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  label: const Text("Nickname"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 100,
            ),
            NiceButtons(
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
                  Timer(const Duration(seconds: 5), () async {
                    finish();
                    await GamePreferences.setNickname(nameCtrl.text.trim());
                    var route = MaterialPageRoute(
                        builder: ((context) => const PlayScreen()));
                    Navigator.push(context, route);
                  });
                },
                child: const Text("Proceed")),
          ],
        )),
      ),
    );
  }
}
