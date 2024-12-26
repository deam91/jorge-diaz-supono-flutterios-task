import 'dart:io';

import 'package:image/image.dart';

void main() async {
  final directory = Directory('assets');
  await for (var entity in directory.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.png')) {
      final image = decodeImage(await entity.readAsBytes());
      if (image != null) {
        final optimized = encodePng(image, level: 9); // Maximum compression
        await entity.writeAsBytes(optimized);
      }
    }
  }
}
