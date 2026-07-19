import 'package:flutter/material.dart';

enum QrType { text, website, email, phone, sms, wifi, contact, location }

extension QrTypeExtension on QrType {
  String get title {
    switch (this) {
      case QrType.text:
        return 'Text';

      case QrType.website:
        return 'Website';

      case QrType.email:
        return 'Email';

      case QrType.phone:
        return 'Phone';

      case QrType.sms:
        return 'SMS';

      case QrType.wifi:
        return 'WiFi';

      case QrType.contact:
        return 'Contact';

      case QrType.location:
        return 'Location';
    }
  }

  IconData get icon {
    switch (this) {
      case QrType.text:
        return Icons.text_fields;

      case QrType.website:
        return Icons.language;

      case QrType.email:
        return Icons.email_outlined;

      case QrType.phone:
        return Icons.phone;

      case QrType.sms:
        return Icons.sms_outlined;

      case QrType.wifi:
        return Icons.wifi;

      case QrType.contact:
        return Icons.contact_page_outlined;

      case QrType.location:
        return Icons.location_on_outlined;
    }
  }

  String get hintText {
    switch (this) {
      case QrType.text:
        return 'Enter text';

      case QrType.website:
        return 'https://example.com';

      case QrType.email:
        return 'example@gmail.com';

      case QrType.phone:
        return '+8801712345678';

      case QrType.sms:
        return 'Enter phone number';

      case QrType.wifi:
        return 'Enter WiFi name';

      case QrType.contact:
        return 'Enter contact name';

      case QrType.location:
        return 'Enter latitude';
    }
  }
}
