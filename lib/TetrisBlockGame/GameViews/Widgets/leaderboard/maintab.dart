import 'package:flutter/material.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
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
      ),
    );
  }
}
