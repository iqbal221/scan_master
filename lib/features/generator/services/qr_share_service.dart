import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class QrShareService {
  Future<bool> shareQr({
    required GlobalKey repaintKey,
    String fileName = 'qr_code',
    String? text,
  }) async {
    try {
      final boundary =
          repaintKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;

      if (boundary == null) {
        return false;
      }

      final image = await boundary.toImage(pixelRatio: 3);

      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        return false;
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();

      final file = File('${tempDir.path}/$fileName.png');

      await file.writeAsBytes(pngBytes);

      final result = await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], text: text),
      );

      return result.status == ShareResultStatus.success;
    } catch (e) {
      debugPrint('Share QR Error: $e');
      return false;
    }
  }
}
