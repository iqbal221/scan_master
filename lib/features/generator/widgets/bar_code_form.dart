import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/barcode_type.dart';
import '../provider/generator_provider.dart';

class BarcodeForm extends StatelessWidget {
  const BarcodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GeneratorProvider>();

    return Column(
      children: [
        DropdownButtonFormField<BarcodeType>(
          value: provider.barcodeType,
          decoration: const InputDecoration(labelText: "Barcode Type"),
          items: BarcodeType.values.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.title));
          }).toList(),
          onChanged: (value) {
            provider.changeBarcodeType(value!);
          },
        ),

        const SizedBox(height: 20),

        TextFormField(
          controller: provider.contentController,
          decoration: const InputDecoration(labelText: "Barcode Content"),
        ),

        const SizedBox(height: 20),

        FilledButton(
          onPressed: provider.generate,
          child: const Text("Generate Barcode"),
        ),
      ],
    );
  }
}
