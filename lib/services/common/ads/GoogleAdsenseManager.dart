import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ramadan/utils/constants/string_constant.dart';

abstract class IGoogleAdsenseManager {
  Future<BannerAd> loadBannerAd({required VoidCallback adLoaded});
}

class GoogleAdsenseManager implements IGoogleAdsenseManager {
  @override
  Future<BannerAd> loadBannerAd({required VoidCallback adLoaded}) async {
    return await BannerAd(
      adUnitId: ProjectConstant.bannerAd1,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          adLoaded();
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )
      ..load();
  }
}
