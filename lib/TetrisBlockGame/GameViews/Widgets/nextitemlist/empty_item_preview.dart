import 'package:flutter/material.dart';

class EmptyItemPreview extends StatelessWidget {
  const EmptyItemPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 120,
      height: 100,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
