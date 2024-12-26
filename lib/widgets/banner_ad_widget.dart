import 'package:apply_at_supono/services/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  Future<void> _loadAd() async {
    final ad = await AdService.loadBannerAd();
    if (mounted) {
      setState(() => _bannerAd = ad);
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd == null) {
      return const SizedBox.shrink();
    }

    final insets = MediaQuery.paddingOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                _bannerAd?.dispose();
              },
              child: Image.asset(
                'assets/red_button.png',
                width: 72,
                height: 22,
              ),
            ),
          ),
          Divider(
            color: Colors.red,
            height: 1,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble() + insets.bottom,
              child: AdWidget(ad: _bannerAd!),
            ),
          ),
        ],
      ),
    );
  }
}
