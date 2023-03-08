import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:somtotetris/TetrisBlockGame/GameLogic/tetris_model.dart';

class RewardedState {
  RewardedAd? _rewardedAd;

  final adUnitId = "ca-app-pub-4696224049420135/8062688194";

  /// Loads a rewarded ad.
  loadAd(BuildContext context) {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
                // Dispose the ad here to free resources.
                ad.dispose();
              },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
                // Dispose the ad here to free resources.
                ad.dispose();
                var game = context.read<TetrisSudoku>();
                game.toggleRotation();
              },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {});
          print('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          _rewardedAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          _rewardedAd = null;
          print('RewardedAd failed to load: $error');
        },
      ),
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      print("${reward.amount} ${reward.type}");
    });
  }
}
