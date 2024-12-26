import 'package:apply_at_supono/core/service_locator.dart';
import 'package:apply_at_supono/services/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({
    super.key,
  });

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  final _adService = getIt.get<AdService>();

  @override
  void initState() {
    super.initState();
    _loadAdIfNeeded();
  }

  Future<void> _loadAdIfNeeded() async {
    if (!_adService.isAdLoaded) {
      final ad = await _adService.loadBannerAd();
      if (mounted && ad != null) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bannerAd = _adService.bannerAd;
    if (!_adService.isAdLoaded || bannerAd == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                _adService.reset();
                setState(() {});
              },
              child: Image.asset(
                'assets/red_button.png',
                width: 72,
                height: 22,
              ),
            ),
          ),
          const Divider(
            color: Colors.red,
            height: 1,
          ),
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: SizedBox(
              width: bannerAd.size.width.toDouble(),
              height: bannerAd.size.height.toDouble(),
              child: AdWidget(ad: bannerAd),
            ),
          ),
        ],
      ),
    );
  }
}
