import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Ranks extends StatelessWidget {
  Ranks({super.key, required this.ranks});

  Future<Map<String, dynamic>> ranks;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ranks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final list = snapshot.data;
            return ListView.builder(
                itemCount: list?.length ?? 0,
                itemBuilder: (context, position) {
                  return ListTile();
                });
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return SizedBox.shrink();
          }
        });
  }
}
