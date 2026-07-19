import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/generator_mode.dart';
import '../provider/generator_provider.dart';

class ModeSelector extends StatelessWidget {
  const ModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GeneratorProvider>();

    return SegmentedButton<GeneratorMode>(
      segments: const [
        ButtonSegment(
          value: GeneratorMode.qr,
          label: Text("QR Code"),
          icon: Icon(Icons.qr_code),
        ),
        ButtonSegment(
          value: GeneratorMode.barcode,
          label: Text("Barcode"),
          icon: Icon(Icons.view_week),
        ),
      ],
      selected: {provider.mode},
      onSelectionChanged: (value) {
        provider.changeMode(value.first);
      },
    );
  }
}
