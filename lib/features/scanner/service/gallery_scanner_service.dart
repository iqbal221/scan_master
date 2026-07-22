import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class GalleryScannerService {
  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  Future<File?> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (image == null) return null;

    return File(image.path);
  }

  /// Scan QR / Barcode from image
  Future<BarcodeCapture?> scanFromGallery() async {
    final File? image = await pickImage();

    if (image == null) return null;

    final MobileScannerController controller = MobileScannerController();

    try {
      final BarcodeCapture? capture = await controller.analyzeImage(image.path);

      return capture;
    } finally {
      controller.dispose();
    }
  }
}
