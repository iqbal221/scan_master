import 'package:flutter/material.dart';
import 'package:quick_scanner/features/history/data/models/history_model.dart';

class HistoryHeader extends StatelessWidget {
  final HistoryModel history;

  const HistoryHeader({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(.1),
          child: Icon(
            _icon(),
            size: 50,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),

        const SizedBox(height: 16),

        Text(history.type, style: Theme.of(context).textTheme.headlineSmall),

        const SizedBox(height: 6),

        Text(history.format, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  IconData _icon() {
    switch (history.type.toLowerCase()) {
      case "website":
        return Icons.language;

      case "phone":
        return Icons.phone;

      case "email":
        return Icons.email;

      case "sms":
        return Icons.sms;

      case "wifi":
        return Icons.wifi;

      case "location":
        return Icons.location_on;

      case "contact":
        return Icons.person;

      default:
        return Icons.qr_code;
    }
  }
}
