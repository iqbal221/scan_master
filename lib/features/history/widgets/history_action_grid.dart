import 'package:flutter/material.dart';
import 'package:quick_scanner/features/history/data/models/history_model.dart';
import 'package:quick_scanner/features/history/widgets/history_action_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryActionGrid extends StatelessWidget {
  final HistoryModel history;

  const HistoryActionGrid({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.6,
      children: [
        HistoryActionButton(
          icon: Icons.share,
          title: "Share",
          onPressed: () {
            SharePlus.instance.share(ShareParams(text: history.content));
          },
        ),

        // HistoryActionButton(
        //   icon: Icons.open_in_browser,
        //   title: "Open",
        //   onPressed: _openContent,
        // ),
        HistoryActionButton(
          icon: history.isFavorite ? Icons.favorite : Icons.favorite_border,
          title: "Favorite",
          onPressed: () {
            // TODO
          },
          backgroundColor: Colors.red,
        ),

        HistoryActionButton(
          icon: Icons.delete,
          title: "Delete",
          onPressed: () {
            // TODO
          },
          backgroundColor: Colors.red.shade700,
        ),
      ],
    );
  }
}
