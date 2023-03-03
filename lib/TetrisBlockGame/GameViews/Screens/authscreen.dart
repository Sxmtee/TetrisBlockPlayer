import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_preferences.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/play_screen.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/global/playbutton.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController nameCtrl = TextEditingController();
  GlobalKey<FormState> authKey = GlobalKey<FormState>();

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
            key: authKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameCtrl,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      label: const Text("Nickname"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please fill this field";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
                kIsWeb
                    ? PlayButton(
                        onPressed: () async {
                          if (authKey.currentState!.validate()) {
                            authKey.currentState!.save();
                            await GamePreferences.setNickname(
                                nameCtrl.text.trim());
                            var route = MaterialPageRoute(
                                builder: ((context) => const PlayScreen()));
                            Navigator.push(context, route);
                          }
                        },
                        child: const Text("Proceed"),
                      )
                    : NiceButtons(
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
                          if (authKey.currentState!.validate()) {
                            authKey.currentState!.save();
                            Timer(const Duration(seconds: 2), () async {
                              finish();
                              await GamePreferences.setNickname(
                                  nameCtrl.text.trim());
                              var route = MaterialPageRoute(
                                  builder: ((context) => const PlayScreen()));
                              Navigator.push(context, route);
                            });
                          } else {
                            Timer(const Duration(seconds: 2), () {
                              finish();
                            });
                          }
                        },
                        child: const Text("Proceed")),
              ],
            )),
      ),
    );
  }
}
