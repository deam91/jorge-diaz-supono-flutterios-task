import 'package:apply_at_supono/utils/ad_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static BannerAd? _bannerAd;
  static bool _isAdLoaded = false;

  // Add for testing
  @visibleForTesting
  static void reset() {
    _bannerAd = null;
    _isAdLoaded = false;
  }

  // Make this injectable for testing
  @visibleForTesting
  static Future<BannerAd?> createBannerAd() {
    return Future.value(BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          _isAdLoaded = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _bannerAd = null;
          _isAdLoaded = false;
        },
      ),
    ));
  }

  static Future<BannerAd?> loadBannerAd() async {
    if (_isAdLoaded && _bannerAd != null) {
      return _bannerAd;
    }

    await _bannerAd?.dispose();
    _bannerAd = await createBannerAd();

    try {
      await _bannerAd!.load();
      return _bannerAd;
    } catch (e) {
      _bannerAd = null;
      _isAdLoaded = false;
      return null;
    }
  }
}
