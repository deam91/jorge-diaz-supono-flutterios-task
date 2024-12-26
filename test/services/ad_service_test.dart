import 'package:apply_at_supono/services/ad_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AdServiceImpl adService;

  setUp(() {
    adService = AdServiceImpl();
    adService.reset();
  });

  group('AdService Tests', () {
    test('loadBannerAd returns null when ad fails to load', () async {
      final ad = await adService.loadBannerAd();
      expect(ad, isNull);
    });
  });
}
