import 'package:flutter/material.dart';
import 'package:quick_scanner/features/generator/data/models/qr_type.dart';
import 'package:quick_scanner/features/generator/services/qr_export_service.dart';
import 'package:quick_scanner/features/generator/services/qr_share_service.dart';

class GeneratorProvider extends ChangeNotifier {
  final QrExportService _exportService = QrExportService();
  final QrShareService _shareService = QrShareService();
  final GlobalKey qrKey = GlobalKey();
  //==========================
  // Controllers
  //==========================

  final TextEditingController contentController = TextEditingController();

  final TextEditingController smsBodyController = TextEditingController();

  final TextEditingController wifiNameController = TextEditingController();

  final TextEditingController wifiPasswordController = TextEditingController();

  final TextEditingController latitudeController = TextEditingController();

  final TextEditingController longitudeController = TextEditingController();

  //==========================
  // State
  //==========================

  QrType _selectedType = QrType.text;

  QrType get selectedType => _selectedType;

  String _qrData = '';

  String get qrData => _qrData;

  Color _foregroundColor = Colors.black;

  Color get foregroundColor => _foregroundColor;

  Color _backgroundColor = Colors.white;

  Color get backgroundColor => _backgroundColor;

  //==========================
  // Change QR Type
  //==========================

  void changeType(QrType type) {
    _selectedType = type;

    clearData();

    notifyListeners();
  }

  //==========================
  // Generate QR
  //==========================

  void generateQR() {
    switch (_selectedType) {
      case QrType.text:
        _generateText();
        break;

      case QrType.website:
        _generateWebsite();
        break;

      case QrType.email:
        _generateEmail();
        break;

      case QrType.phone:
        _generatePhone();
        break;

      case QrType.sms:
        _generateSms();
        break;

      case QrType.wifi:
        _generateWifi();
        break;

      case QrType.location:
        _generateLocation();
        break;
      case QrType.contact:
        // TODO: Handle this case.
        throw UnimplementedError();
    }

    notifyListeners();
  }

  //==========================
  // Text
  //==========================

  void _generateText() {
    _qrData = contentController.text.trim();
  }

  //==========================
  // Website
  //==========================

  void _generateWebsite() {
    final url = contentController.text.trim();

    if (url.startsWith('http://') || url.startsWith('https://')) {
      _qrData = url;
    } else {
      _qrData = 'https://$url';
    }
  }

  //==========================
  // Email
  //==========================

  void _generateEmail() {
    final email = contentController.text.trim();

    _qrData = 'mailto:$email';
  }

  //==========================
  // Phone
  //==========================

  void _generatePhone() {
    final phone = contentController.text.trim();

    _qrData = 'tel:$phone';
  }

  //==========================
  // SMS
  //==========================

  void _generateSms() {
    final phone = contentController.text.trim();

    final body = smsBodyController.text.trim();

    _qrData = 'sms:$phone?body=$body';
  }

  //==========================
  // WiFi
  //==========================

  void _generateWifi() {
    final ssid = wifiNameController.text.trim();

    final password = wifiPasswordController.text.trim();

    _qrData = 'WIFI:T:WPA;S:$ssid;P:$password;;';
  }

  //==========================
  // Location
  //==========================

  void _generateLocation() {
    final lat = latitudeController.text.trim();

    final lng = longitudeController.text.trim();

    _qrData = 'geo:$lat,$lng';
  }

  //==========================
  // Colors
  //==========================

  void setForegroundColor(Color color) {
    _foregroundColor = color;
    notifyListeners();
  }

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  //==========================
  // Validation
  //==========================

  bool validate() {
    switch (_selectedType) {
      case QrType.text:
      case QrType.website:
      case QrType.email:
      case QrType.phone:
        return contentController.text.trim().isNotEmpty;

      case QrType.sms:
        return contentController.text.trim().isNotEmpty;

      case QrType.wifi:
        return wifiNameController.text.trim().isNotEmpty;

      case QrType.location:
        return latitudeController.text.trim().isNotEmpty &&
            longitudeController.text.trim().isNotEmpty;
      case QrType.contact:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  Future<void> downloadQr(BuildContext context) async {
    final success = await _exportService.saveQr(qrKey);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? "QR saved successfully." : "Failed to save QR.",
        ),
      ),
    );
  }

  Future<void> shareQr(BuildContext context) async {
    final success = await _shareService.shareQr(
      repaintKey: qrKey,
      text: qrData,
    );

    if (!context.mounted) return;

    if (!success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to share QR Code')));
    }
  }

  //==========================
  // Reset
  //==========================

  void clearData() {
    contentController.clear();

    smsBodyController.clear();

    wifiNameController.clear();

    wifiPasswordController.clear();

    latitudeController.clear();

    longitudeController.clear();

    _qrData = '';
  }

  @override
  void dispose() {
    contentController.dispose();
    smsBodyController.dispose();
    wifiNameController.dispose();
    wifiPasswordController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();

    super.dispose();
  }
}
