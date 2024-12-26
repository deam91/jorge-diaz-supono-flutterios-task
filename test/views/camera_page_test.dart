import 'package:apply_at_supono/views/camera_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Mock camera platform channel
    const channel = MethodChannel('plugins.flutter.io/camera');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'availableCameras':
          return [
            {
              'name': 'test',
              'lensDirection': 'back',
              'sensorOrientation': 0,
              'deviceId': '0',
            }
          ];
        case 'initialize':
        case 'create':
        case 'dispose':
          return null;
        default:
          return null;
      }
    });
  });

  group('CameraPage Tests', () {
    testWidgets('shows loading indicator initially', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CameraPage(),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
