import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/generator_provider.dart';

class BarcodePreview extends StatelessWidget {
  const BarcodePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GeneratorProvider>();

    if (provider.barcodeData.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: Text("No Barcode Generated")),
      );
    }

    return BarcodeWidget(
      barcode: Barcode.code128(),
      data: provider.barcodeData,
      width: 300,
      height: 120,
    );
  }
}
