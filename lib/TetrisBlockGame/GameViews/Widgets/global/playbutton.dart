import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double elevation;
  final double minWidth;
  final double height;
  final Color color;
  final Widget child;
  const PlayButton(
      {super.key,
      required this.onPressed,
      this.elevation = 10,
      this.minWidth = 145,
      this.color = const Color(0xFFffcc00),
      this.height = 60,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: elevation,
      shape: const StadiumBorder(),
      minWidth: minWidth,
      height: height,
      color: color,
      child: child,
    );
  }
}
