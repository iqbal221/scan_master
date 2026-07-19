import 'package:flutter/material.dart';
import 'package:quick_scanner/features/history/data/models/history_model.dart';

class HistoryTile extends StatelessWidget {
  final HistoryModel history;
  final VoidCallback? onFavorite;
  final VoidCallback? onTap;

  const HistoryTile({
    super.key,
    required this.history,
    this.onFavorite,
    this.onTap,
  });

  IconData _icon() {
    switch (history.type.toLowerCase()) {
      case 'url':
      case 'website':
        return Icons.language;

      case 'phone':
        return Icons.phone;

      case 'email':
        return Icons.email;

      case 'wifi':
        return Icons.wifi;

      case 'sms':
        return Icons.sms;

      case 'location':
        return Icons.location_on;

      case 'contact':
        return Icons.person;

      default:
        return Icons.qr_code_2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,

        leading: CircleAvatar(child: Icon(_icon())),

        title: Text(
          history.content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(history.format),

            Text(
              history.createdAt.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),

        trailing: IconButton(
          onPressed: onFavorite,
          icon: Icon(
            history.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: history.isFavorite ? Colors.red : null,
          ),
        ),
      ),
    );
  }
}
