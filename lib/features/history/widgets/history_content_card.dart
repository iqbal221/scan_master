import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quick_scanner/features/history/data/models/history_model.dart';

class HistoryContentCard extends StatelessWidget {
  final HistoryModel history;

  const HistoryContentCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Content", style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: 12),

            SelectableText(history.content),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: history.content));

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Copied successfully")),
                    );
                  }
                },
                icon: const Icon(Icons.copy),
                label: const Text("Copy"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
