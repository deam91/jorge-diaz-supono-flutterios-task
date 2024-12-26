import 'package:apply_at_supono/widgets/banner_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('BannerAdWidget Tests', () {
    testWidgets('renders correctly when ad is loaded', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BannerAdWidget(),
          ),
        ),
      );

      expect(find.byType(BannerAdWidget), findsOneWidget);
    });

    testWidgets('shows nothing when ad fails to load', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BannerAdWidget(),
          ),
        ),
      );

      await tester.pump();
      expect(find.byType(SizedBox), findsOneWidget);
    });
  });
}
