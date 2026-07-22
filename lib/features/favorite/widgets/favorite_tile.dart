import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_scanner/features/history/data/models/history_model.dart';

class FavoriteTile extends StatelessWidget {
  final HistoryModel history;

  const FavoriteTile({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            history.type == "QR" ? Icons.qr_code : Icons.barcode_reader,
          ),
        ),

        title: Text(
          history.content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        subtitle: Text(
          DateFormat('dd MMM yyyy • hh:mm a').format(history.scannedAt),
        ),

        trailing: const Icon(Icons.favorite, color: Colors.red),
      ),
    );
  }
}
