import 'package:flutter/material.dart';

class DeleteHistoryDialog extends StatelessWidget {
  const DeleteHistoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete All"),

      content: const Text("Are you sure you want to delete all history?"),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text("Cancel"),
        ),

        FilledButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
