import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../provider/generator_provider.dart';

class QrPreview extends StatelessWidget {
  const QrPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneratorProvider>(
      builder: (_, provider, __) {
        if (provider.qrData.isEmpty) {
          return _EmptyPreview();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RepaintBoundary(
              key: provider.qrKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: provider.backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: QrImageView(
                  data: provider.qrData,
                  version: QrVersions.auto,
                  size: 220,
                  backgroundColor: provider.backgroundColor,
                  foregroundColor: provider.foregroundColor,
                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                ),
              ),
            ),

            const SizedBox(height: 16),

            SelectableText(
              provider.qrData,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      },
    );
  }
}

class _EmptyPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.qr_code_2, size: 90, color: Colors.grey.shade400),

          const SizedBox(height: 16),

          Text(
            "Generate a QR Code",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 8),

          Text(
            "Your QR preview will appear here.",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
