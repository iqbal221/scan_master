import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quick_scanner/features/scanner/service/scanner_service.dart';

class ScannerProvider extends ChangeNotifier {
  ScannerProvider();

  final ScannerService _scannerService = ScannerService();

  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    returnImage: false,
  );

  bool _torchEnabled = false;
  bool get torchEnabled => _torchEnabled;

  bool _isFrontCamera = false;
  bool get isFrontCamera => _isFrontCamera;

  bool _isScanning = true;
  bool get isScanning => _isScanning;

  bool _hasScanned = false;
  bool get hasScanned => _hasScanned;

  String? _scanResult;
  String? get scanResult => _scanResult;

  BarcodeFormat? _barcodeFormat;
  BarcodeFormat? get barcodeFormat => _barcodeFormat;

  //------------------------------------------------
  // Toggle Flash
  //------------------------------------------------

  Future<void> toggleFlash() async {
    await controller.toggleTorch();

    _torchEnabled = !_torchEnabled;

    notifyListeners();
  }

  //------------------------------------------------
  // Switch Camera
  //------------------------------------------------

  Future<void> switchCamera() async {
    await controller.switchCamera();

    _isFrontCamera = !_isFrontCamera;

    notifyListeners();
  }

  //------------------------------------------------
  // Pause Scanner
  //------------------------------------------------

  Future<void> pauseScanner() async {
    await controller.stop();

    _isScanning = false;

    notifyListeners();
  }

  //------------------------------------------------
  // Resume Scanner
  //------------------------------------------------

  Future<void> resumeScanner() async {
    await controller.start();

    _hasScanned = false;
    _isScanning = true;

    notifyListeners();
  }

  //------------------------------------------------
  // Handle Scan Result
  //------------------------------------------------

  void onDetect(BarcodeCapture capture) {
    if (_hasScanned) return;

    final barcode = capture.barcodes.first;

    if (barcode.rawValue == null) return;

    final result = _scannerService.parse(barcode.rawValue!);

    _scanResult = result.rawValue;
    _barcodeFormat = barcode.format;

    _hasScanned = true;

    notifyListeners();
  }

  //------------------------------------------------
  // Reset Scan
  //------------------------------------------------

  void resetScan() {
    _hasScanned = false;
    _scanResult = null;
    _barcodeFormat = null;

    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
