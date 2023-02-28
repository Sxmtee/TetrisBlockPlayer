// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'dart:io' show Platform;

// class AppOpenAdManager {
//   String adUnitId = '/6499/example/app-open';

//   AppOpenAd? _appOpenAd;
//   final bool _isShowingAd = false;

//   /// Load an AppOpenAd.
//   void loadAd() {
//     // We will implement this below.
//   }

//   /// Whether an ad is available to be shown.
//   bool get isAdAvailable {
//     return _appOpenAd != null;
//   }


//   void loadAd() {
//     AppOpenAd.loadWithAdManagerAdRequest(
//       adUnitId: adUnitId,
//       orientation: AppOpenAd.orientationPortrait,
//       adManagerAdRequest: AdManagerAdRequest(),
//       adLoadCallback: AppOpenAdLoadCallback(
//         onAdLoaded: (ad) {
//           _appOpenAd = ad;
//         },
//         onAdFailedToLoad: (error) {
//           print('AppOpenAd failed to load: $error');
//           // Handle the error.
//         },
//       ),
//     );
//   }
// }

