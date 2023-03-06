// import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:somtotetris/TetrisBlockGame/Ads/adOpen.dart';
// import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';

class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;
  // final TetrisSudoku model;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable();
    }

    // if (appState == AppState.background) {
    //   model.players.forEach((_, player) {
    //     if (player.state != PlayerState.paused) {
    //       player.pause();
    //     }
    //   });
    // }
  }
}
