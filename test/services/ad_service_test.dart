import 'package:apply_at_supono/services/ad_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    AdService.reset();
  });

  group('AdService Tests', () {
    test('loadBannerAd returns null when ad fails to load', () async {
      final ad = await AdService.loadBannerAd();
      expect(ad, isNull);
    });
  });
}
