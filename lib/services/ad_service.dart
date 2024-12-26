import 'package:apply_at_supono/utils/ad_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdService {
  Future<BannerAd?> loadBannerAd();
  void reset();
  BannerAd? get bannerAd;
  bool get isAdLoaded;
}

class AdServiceImpl implements AdService {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  bool get isAdLoaded => _isAdLoaded;

  @override
  BannerAd? get bannerAd => _bannerAd;

  @override
  @visibleForTesting
  void reset() {
    _bannerAd?.dispose();
    _bannerAd = null;
    _isAdLoaded = false;
  }

  @override
  Future<BannerAd?> loadBannerAd() async {
    if (_isAdLoaded && _bannerAd != null) {
      return _bannerAd;
    }

    await _bannerAd?.dispose();
    _isAdLoaded = false;

    try {
      _bannerAd = _createBannerAd();
      await _bannerAd!.load();
      _isAdLoaded = true;
      return _bannerAd;
    } catch (e) {
      _bannerAd?.dispose();
      _bannerAd = null;
      _isAdLoaded = false;
      return null;
    }
  }

  BannerAd? _createBannerAd() {
    return BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isAdLoaded = true;
          _bannerAd = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _bannerAd = null;
          _isAdLoaded = false;
        },
      ),
    );
  }
}
