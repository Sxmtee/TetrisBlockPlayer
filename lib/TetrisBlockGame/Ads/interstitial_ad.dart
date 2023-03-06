import 'package:google_mobile_ads/google_mobile_ads.dart';

InterstitialAd? interstitialAd;

pageAd() {
  InterstitialAd.load(
      adUnitId: 'ca-app-pub-4696224049420135/5150272759',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          interstitialAd = null;
          print('InterstitialAd failed to load: $error');
        },
      ));
}
