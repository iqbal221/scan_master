import 'package:quick_scanner/features/scanner/data/model/scan_result_model.dart';
import 'package:quick_scanner/features/scanner/data/model/scan_type.dart';

class ScannerService {
  ScanResultModel parse(String value) {
    final text = value.trim();

    return ScanResultModel(
      rawValue: text,
      type: _detectType(text),
      scannedAt: DateTime.now(),
    );
  }

  ScanType _detectType(String text) {
    final lower = text.toLowerCase();

    if (lower.startsWith('http://') || lower.startsWith('https://')) {
      return ScanType.url;
    }

    if (lower.startsWith('mailto:')) {
      return ScanType.email;
    }

    if (lower.startsWith('tel:')) {
      return ScanType.phone;
    }

    if (lower.startsWith('sms:')) {
      return ScanType.sms;
    }

    if (lower.startsWith('wifi:')) {
      return ScanType.wifi;
    }

    if (lower.startsWith('geo:')) {
      return ScanType.location;
    }

    if (lower.startsWith('begin:vcard')) {
      return ScanType.contact;
    }

    return ScanType.text;
  }

  bool isUrl(String value) => _detectType(value) == ScanType.url;

  bool isPhone(String value) => _detectType(value) == ScanType.phone;

  bool isEmail(String value) => _detectType(value) == ScanType.email;

  bool isWifi(String value) => _detectType(value) == ScanType.wifi;

  bool isSms(String value) => _detectType(value) == ScanType.sms;

  bool isLocation(String value) => _detectType(value) == ScanType.location;
}
