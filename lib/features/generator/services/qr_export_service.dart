import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class QrExportService {
  Future<bool> saveQr(GlobalKey repaintKey) async {
    try {
      final permission = await Permission.photos.request();

      if (!permission.isGranted &&
          !await Permission.storage.request().isGranted) {
        return false;
      }

      final boundary =
          repaintKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 3);

      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return false;

      Uint8List pngBytes = byteData.buffer.asUint8List();

      final result = await ImageGallerySaverPlus.saveImage(
        pngBytes,
        quality: 100,
        name: "qr_${DateTime.now().millisecondsSinceEpoch}",
      );

      return result["isSuccess"] == true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
