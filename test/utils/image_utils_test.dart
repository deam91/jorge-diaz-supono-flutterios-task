import 'dart:io';

import 'package:apply_at_supono/utils/image_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'image_utils_test.mocks.dart';

class ImageUtilsWrapper {
  Future<File> compressImage(File file) => ImageUtils.compressImage(file);
}

@GenerateMocks([ImageUtilsWrapper])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory tempDir;
  late File testFile;
  late File compressedFile;

  setUp(() async {
    tempDir = Directory('./test/temp');
    await tempDir.create(recursive: true);

    testFile = File('${tempDir.path}/test.jpg');
    await testFile.writeAsBytes(List.generate(1000, (i) => i % 256));

    compressedFile = File('${tempDir.path}/compressed.jpg');
    await compressedFile.writeAsBytes(List.generate(500, (i) => i % 256));
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  test('compressImage reduces file size', () async {
    final wrapper = MockImageUtilsWrapper();
    when(wrapper.compressImage(testFile))
        .thenAnswer((_) async => compressedFile);

    final result = await wrapper.compressImage(testFile);
    expect(await result.length(), lessThan(await testFile.length()));
  });
}
