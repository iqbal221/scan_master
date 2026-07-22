import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quick_scanner/features/scanner/provider/result_provider.dart';

class ScanResultScreen extends StatelessWidget {
  static const String name = '/scan-result';

  final String content;
  final String type;
  final String format;
  final DateTime scannedAt;

  const ScanResultScreen({
    super.key,
    required this.content,
    required this.type,
    required this.format,
    required this.scannedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Result"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 90),

            const SizedBox(height: 20),

            SelectableText(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 25),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _infoTile("Type", type),

                    const Divider(),

                    _infoTile("Format", format),

                    const Divider(),

                    _infoTile("Scanned At", scannedAt.toString()),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            FilledButton.icon(
              onPressed: () {
                context.read<ResultProvider>().copy(context, content);
              },
              icon: const Icon(Icons.copy),
              label: const Text("Copy"),
            ),

            const SizedBox(height: 12),

            FilledButton.icon(
              onPressed: () {
                context.read<ResultProvider>().share(content);
              },
              icon: const Icon(Icons.share),
              label: const Text("Share"),
            ),

            const SizedBox(height: 12),

            FilledButton.icon(
              onPressed: context.read<ResultProvider>().canOpen(content)
                  ? () {
                      context.read<ResultProvider>().open(content);
                    }
                  : null,
              icon: const Icon(Icons.open_in_browser),
              label: const Text("Open"),
            ),

            const SizedBox(height: 12),

            FilledButton.icon(
              onPressed: () async {
                await context.read<ResultProvider>().saveHistory(
                  content: content,
                  type: type,
                  format: format,
                  scannedAt: scannedAt,
                );

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Saved successfully")),
                  );
                }
              },

              icon: const Icon(Icons.save),
              label: const Text("Save History"),
            ),

            const SizedBox(height: 12),

            FilledButton.icon(
              onPressed: () {
                final provider = context.read<ResultProvider>();

                if (provider.historyId != null) {
                  provider.toggleFavorite(provider.historyId!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please save history first.")),
                  );
                }
              },
              icon: const Icon(Icons.favorite_border),
              label: const Text("Favorite"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
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
