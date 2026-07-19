import 'package:flutter/material.dart';
import 'package:quick_scanner/features/history/widgets/history_action_grid.dart';
import 'package:quick_scanner/features/history/widgets/history_content_card.dart';
import 'package:quick_scanner/features/history/widgets/history_header.dart';
import 'package:quick_scanner/features/history/widgets/history_info_card.dart';

import '../../data/models/history_model.dart';

class HistoryDetailScreen extends StatelessWidget {
  static const String name = "/history-detail";

  final HistoryModel history;

  const HistoryDetailScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            HistoryHeader(history: history),

            const SizedBox(height: 20),

            HistoryContentCard(history: history),

            const SizedBox(height: 20),

            HistoryInfoCard(history: history),

            const SizedBox(height: 20),

            HistoryActionGrid(history: history),
          ],
        ),
      ),
    );
  }
}
