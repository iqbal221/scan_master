import 'package:quick_scanner/features/scanner/data/model/scan_type.dart';

class ScanResultModel {
  final String rawValue;
  final ScanType type;
  final DateTime scannedAt;

  const ScanResultModel({
    required this.rawValue,
    required this.type,
    required this.scannedAt,
  });
}
