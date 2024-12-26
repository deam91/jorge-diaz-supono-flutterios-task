import 'dart:io';

import 'package:apply_at_supono/constants/app_colors.dart';
import 'package:apply_at_supono/views/settings_page.dart';
import 'package:apply_at_supono/widgets/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreviewPage extends StatefulWidget {
  final String imagePath;

  const PreviewPage({super.key, required this.imagePath});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image preview
          Image.file(
            File(widget.imagePath),
            fit: BoxFit.cover,
          ),
          // Top buttons
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularButton(
                      icon: Icons.close,
                      onTap: () => Navigator.pop(context),
                    ),
                    CircularButton(
                      icon: Icons.settings_outlined,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Banner ad at bottom
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BannerPreview(),
          ),
        ],
      ),
    );
  }
}

class BannerPreview extends StatefulWidget {
  const BannerPreview({super.key});

  @override
  State<BannerPreview> createState() => _BannerPreviewState();
}

class _BannerPreviewState extends State<BannerPreview> {
  BannerAd? _bannerAd;
  bool _isAdRemoved = false;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final size =
          await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.sizeOf(context).width.truncate(),
      );
      _checkAdStatus();
      _createBannerAd(size);
    });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  Future<void> _checkAdStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAdRemoved = prefs.getBool('adRemoved') ?? false;
    });
  }

  void _createBannerAd(AnchoredAdaptiveBannerAdSize? size) {
    // Test ad unit IDs
    final adUnitId = Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/6300978111'
        : 'ca-app-pub-3940256099942544/2934735716';

    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: size ?? AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() => _isAdLoaded = true),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdRemoved && _isAdLoaded && _bannerAd != null) {
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
                  setState(() => _isAdLoaded = false);
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
    return const SizedBox.shrink();
  }
}
