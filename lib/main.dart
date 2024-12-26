import 'package:apply_at_supono/services/ad_service.dart';
import 'package:apply_at_supono/views/camera_page.dart';
import 'package:apply_at_supono/views/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Key for storing first run status
const String kFirstRunKey = 'isFirstRun';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Google Mobile Ads
  MobileAds.instance.initialize();

  // Preload the first banner ad
  await AdService.loadBannerAd();

  // Check if this is the first run
  final prefs = await SharedPreferences.getInstance();
  final isFirstRun = prefs.getBool(kFirstRunKey) ?? true;

  runApp(MyApp(isFirstRun: isFirstRun));
}

class MyApp extends StatelessWidget {
  final bool isFirstRun;

  const MyApp({super.key, required this.isFirstRun});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Use isFirstRun to determine initial route
      home: isFirstRun ? const OnboardingPage() : const CameraPage(),
    );
  }
}
