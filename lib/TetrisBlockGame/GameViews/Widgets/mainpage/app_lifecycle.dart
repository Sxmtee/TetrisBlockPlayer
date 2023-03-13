import 'package:flutter/material.dart';
import 'package:somtotetris/TetrisBlockGame/Ads/adOpen.dart';
import 'package:somtotetris/TetrisBlockGame/Ads/app_cycle.dart';

class AppLifecycle extends StatefulWidget {
  const AppLifecycle({super.key, required this.child});
  final Widget child;

  @override
  State<AppLifecycle> createState() => _AppLifecycleState();
}

class _AppLifecycleState extends State<AppLifecycle> {
  late AppLifecycleReactor appLifecycleReactor;

  @override
  void initState() {
    super.initState();
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
