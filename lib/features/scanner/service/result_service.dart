import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultService {
  Future<void> copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));

    if (!context.mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Copied successfully")));
  }

  Future<void> share(String text) async {
    await SharePlus.instance.share(ShareParams(text: text));
  }

  Future<void> open(String text) async {
    final uri = Uri.tryParse(text);

    if (uri == null) return;

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  bool isUrl(String text) {
    return text.startsWith("http://") || text.startsWith("https://");
  }

  bool isPhone(String text) {
    return text.startsWith("tel:");
  }

  bool isEmail(String text) {
    return text.startsWith("mailto:");
  }

  bool isWifi(String text) {
    return text.startsWith("WIFI:");
  }

  bool isContact(String text) {
    return text.contains("BEGIN:VCARD");
  }
}
