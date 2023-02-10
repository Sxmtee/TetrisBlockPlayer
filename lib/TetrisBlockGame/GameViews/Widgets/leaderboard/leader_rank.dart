import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ranks extends StatelessWidget {
  Ranks({super.key, required this.ranks});

  Future<List<dynamic>> ranks;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ranks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator(
              color: Color(0xFFffcc00),
              radius: 50,
            );
          } else if (snapshot.hasData) {
            final list = snapshot.data!
              ..sort((e1, e2) => e1['score'].compareTo(e2['score']));
            return ListView.builder(
                // shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 16, right: 10, left: 10),
                    child: Card(
                      color: const Color(0xFFffcc00),
                      shape: const StadiumBorder(),
                      elevation: 10,
                      child: ListTile(
                        leading: Text(
                          '${index + 1}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        title: Text(
                          "${list[index]['username']}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        trailing: Text(
                          "${list[index]['score']}",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No Data"),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
