import 'dart:async';

import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/GameViews/Screens/splashscreen.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

class DigitalDreams extends StatefulWidget {
  const DigitalDreams({super.key});

  @override
  State<DigitalDreams> createState() => _DigitalDreamsState();
}

class _DigitalDreamsState extends State<DigitalDreams> {
  bool idleStateOver = false;
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
      (() => setState(() {
            idleStateOver = true;
          })),
    );
    Timer(const Duration(seconds: 10), (() {
      var route = MaterialPageRoute(builder: (context) => const SplashView());
      Navigator.push(context, route);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF701ebd),
              Color(0xFF873bcc),
              Color(0xFFfe4a97),
              Color(0xFFe17763),
            ],
            stops: [0.1, 0.4, 0.8, 1],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 70,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/images/digital_dreams.png"))),
              ),
              Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    "ICT Academy",
                    style: TextStyle(
                      letterSpacing: 5,
                      color: Colors.amber,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(
                height: 100,
              ),
              Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "We Train You On",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Container(
                    alignment: null,
                    child: Row(
                      children: [
                        const CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Icon(
                              Icons.webhook_outlined,
                              color: Color(0xFF1a1a1a),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        idleStateOver
                            ? AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  TyperAnimatedText(
                                    "Web Development",
                                    speed: const Duration(milliseconds: 100),
                                    textStyle: const TextStyle(
                                      color: Color(0xFFffffff),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: null,
                    child: Row(
                      children: [
                        const CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Icon(
                              Icons.mobile_friendly_rounded,
                              color: Color(0xFF1a1a1a),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        idleStateOver
                            ? AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  TyperAnimatedText(
                                    "Mobile App Development",
                                    speed: const Duration(milliseconds: 100),
                                    textStyle: const TextStyle(
                                      color: Color(0xFFffffff),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: null,
                    child: Row(
                      children: [
                        const CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Icon(
                              Icons.gamepad_rounded,
                              color: Color(0xFF1a1a1a),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        idleStateOver
                            ? AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  TyperAnimatedText(
                                    "Game Development",
                                    speed: const Duration(milliseconds: 100),
                                    textStyle: const TextStyle(
                                      color: Color(0xFFffffff),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: null,
                    child: Row(
                      children: [
                        const CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Icon(
                              Icons.design_services_rounded,
                              color: Color(0xFF1a1a1a),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        idleStateOver
                            ? AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  TyperAnimatedText(
                                    "Product Design",
                                    speed: const Duration(milliseconds: 100),
                                    textStyle: const TextStyle(
                                      color: Color(0xFFffffff),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: null,
                    child: Row(
                      children: [
                        const CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Icon(
                              Icons.room_service_rounded,
                              color: Color(0xFF1a1a1a),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        idleStateOver
                            ? AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  TyperAnimatedText(
                                    "Digital Marketing",
                                    speed: const Duration(milliseconds: 100),
                                    textStyle: const TextStyle(
                                      color: Color(0xFFffffff),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: null,
                    child: Row(
                      children: [
                        const CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Icon(
                              Icons.data_exploration_rounded,
                              color: Color(0xFF1a1a1a),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        idleStateOver
                            ? AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  TyperAnimatedText(
                                    "Data Science",
                                    speed: const Duration(milliseconds: 100),
                                    textStyle: const TextStyle(
                                      color: Color(0xFFffffff),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
