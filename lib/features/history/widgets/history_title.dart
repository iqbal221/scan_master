import 'package:flutter/material.dart';
import 'package:quick_scanner/features/history/data/models/history_model.dart';
import 'package:quick_scanner/features/history/presentation/screens/history_details_screen.dart';

class HistoryTile extends StatelessWidget {
  final HistoryModel history;

  const HistoryTile({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HistoryDetailScreen(history: history),
            ),
          );
        },

        leading: CircleAvatar(
          child: Icon(
            history.type.toLowerCase() == "qr"
                ? Icons.qr_code
                : Icons.barcode_reader,
          ),
        ),

        title: Text(
          history.content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        subtitle: Text(history.type),

        trailing: Icon(
          history.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
      ),
    );
  }
}
