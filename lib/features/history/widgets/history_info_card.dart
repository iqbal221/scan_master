import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_scanner/features/history/data/models/history_model.dart';

class HistoryInfoCard extends StatelessWidget {
  final HistoryModel history;

  const HistoryInfoCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMMd().format(history.createdAt);

    final time = DateFormat.jm().format(history.createdAt);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _item("Type", history.type),

            const Divider(),

            _item("Format", history.format),

            const Divider(),

            _item("Date", date),

            const Divider(),

            _item("Time", time),
          ],
        ),
      ),
    );
  }

  Widget _item(String title, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: Text(value, textAlign: TextAlign.end)),
      ],
    );
  }
}
