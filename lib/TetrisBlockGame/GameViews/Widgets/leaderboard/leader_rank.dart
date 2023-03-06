import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ranks extends StatelessWidget {
  const Ranks({super.key, required this.ranks});

  final Future<List<dynamic>> ranks;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ranks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(
                color: Color(0xFFffcc00),
                radius: 50,
              ),
            );
          } else if (snapshot.hasData) {
            final list = snapshot.data!
              ..sort((e1, e2) =>
                  int.parse(e2['score']).compareTo(int.parse(e1['score'])));
            return ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Card(
                      color: const Color(0xFFffcc00),
                      shape: const StadiumBorder(),
                      elevation: 10,
                      child: ListTile(
                        leading: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontFamily: "Poppins",
                          ),
                        ),
                        title: Text(
                          "${list[index]['username']}",
                          style: const TextStyle(
                            fontSize: 17,
                            fontFamily: "Poppins",
                          ),
                        ),
                        trailing: Text(
                          "${list[index]['score']}",
                          style: const TextStyle(
                            fontSize: 17,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Error",
                style: TextStyle(
                  color: Color(0xFFffcc00),
                  fontSize: 35,
                  fontFamily: "Poppins",
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text(
                "No Data",
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: "Poppins",
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
