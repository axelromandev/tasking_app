import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdModService {
  static String get _appId {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/6300978111'
        : 'ca-app-pub-3940256099942544/2934735716';
  }

  static BannerAd? bannerAdHome;
  static BannerAd? bannerAdSettings;

  static Future<void> configure() async {
    bannerAdHome = BannerAd(
      adUnitId: _appId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    );
    await bannerAdHome?.load();
    bannerAdSettings = BannerAd(
      adUnitId: _appId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    );
    await bannerAdSettings?.load();
  }
}
