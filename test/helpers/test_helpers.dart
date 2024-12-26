import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mockito/mockito.dart';

class MockCameraController extends Mock implements CameraController {
  @override
  CameraValue get value => CameraValue(
        isInitialized: true,
        previewSize: const Size(1920, 1080),
        isRecordingVideo: false,
        isTakingPicture: false,
        isStreamingImages: false,
        isRecordingPaused: false,
        flashMode: FlashMode.off,
        exposureMode: ExposureMode.auto,
        focusMode: FocusMode.auto,
        exposurePointSupported: true,
        focusPointSupported: true,
        deviceOrientation: DeviceOrientation.portraitUp,
        description: CameraDescription(
          name: 'test',
          lensDirection: CameraLensDirection.back,
          sensorOrientation: 0,
        ),
      );
}

class MockBannerAd extends Mock implements BannerAd {
  @override
  Future<void> load() async => true;
}

Future<void> setupTestMocks() async {
  TestWidgetsFlutterBinding.ensureInitialized();
}
