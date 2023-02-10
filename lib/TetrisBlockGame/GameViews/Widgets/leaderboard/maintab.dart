import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:somtotetris/TetrisBlockGame/GameViews/Widgets/leaderboard/leader_rank.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  String filter = "null";

  Future<List<dynamic>> getRanking(String filter) async {
    var uri = Uri.parse(
        "http://cbtportal.linkskool.com/api/get_leaderboard.php?game_type=TetrisJigsaw&period=$filter");
    // {daily, week, null}
    List<dynamic> results = [];
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      results = jsonDecode(response.body);
    }
    debugPrint('results:$results');
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: TabBar(
            indicatorColor: Colors.yellow.shade800,
            indicatorWeight: 4,
            labelColor: Colors.grey,
            unselectedLabelColor: Colors.grey,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            tabs: const [
              Tab(
                text: 'All Time',
              ),
              Tab(
                text: 'Weekly',
              ),
              Tab(
                text: 'Daily',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Center(
            child: Ranks(ranks: getRanking("null")),
          ),
          Center(
            child: Ranks(ranks: getRanking("week")),
          ),
          Center(
            child: Ranks(ranks: getRanking("daily")),
          ),
        ]),
      ),
    );
  }
}
