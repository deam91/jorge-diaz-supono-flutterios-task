import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    // Replace with your ad unit IDs
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/6300978111'
        : 'ca-app-pub-3940256099942544/2934735716';
  }
}
