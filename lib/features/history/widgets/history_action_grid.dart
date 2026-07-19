import 'package:flutter/material.dart';
import 'package:quick_scanner/features/history/data/models/history_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryActionGrid extends StatelessWidget {
  final HistoryModel history;

  const HistoryActionGrid({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.8,
      children: [
        _button(
          icon: Icons.share,
          title: "Share",
          onTap: () {
            SharePlus.instance.share(ShareParams(text: history.content));
          },
        ),

        _button(
          icon: Icons.open_in_browser,
          title: "Open",
          onTap: _openContent,
        ),

        _button(
          icon: Icons.favorite,
          title: history.isFavorite ? "Unfavorite" : "Favorite",
          onTap: () {
            // TODO
          },
        ),

        _button(
          icon: Icons.delete,
          title: "Delete",
          onTap: () {
            // TODO
          },
        ),
      ],
    );
  }

  Future<void> _openContent() async {
    final uri = Uri.tryParse(history.content);

    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _button({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(title),
    );
  }
}
