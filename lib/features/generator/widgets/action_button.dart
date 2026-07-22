import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/generator_provider.dart';

class ActionButtons extends StatelessWidget {
  final bool isGenerated;

  const ActionButtons({super.key, required this.isGenerated});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<GeneratorProvider>();

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: isGenerated
                ? () async {
                    await provider.downloadQr(context);
                  }
                : null,
            icon: const Icon(Icons.download),
            label: const Text("Download"),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: ElevatedButton.icon(
            onPressed: isGenerated
                ? () async {
                    await provider.shareQr(context);
                  }
                : null,
            icon: const Icon(Icons.share),
            label: const Text("Share"),
          ),
        ),
      ],
    );
  }
}
