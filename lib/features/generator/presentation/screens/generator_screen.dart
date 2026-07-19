import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_scanner/features/generator/data/models/generator_mode.dart';
import 'package:quick_scanner/features/generator/provider/generator_provider.dart';
import 'package:quick_scanner/features/generator/widgets/action_button.dart';
import 'package:quick_scanner/features/generator/widgets/bar_code_form.dart';
import 'package:quick_scanner/features/generator/widgets/bar_code_preview.dart';
import 'package:quick_scanner/features/generator/widgets/mode_selector.dart';
import 'package:quick_scanner/features/generator/widgets/qr_code_form.dart';
import 'package:quick_scanner/features/generator/widgets/qr_preview.dart';

class GeneratorScreen extends StatefulWidget {
  const GeneratorScreen({super.key});

  static const String name = '/generator_screen';

  @override
  State<GeneratorScreen> createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GeneratorProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('QR Generator'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Form
              const ModeSelector(),

              const SizedBox(height: 20),

              provider.mode == GeneratorMode.qr
                  ? const QRCodeForm()
                  : const BarcodeForm(),

              const SizedBox(height: 24),

              /// Preview Title
              Text('Preview', style: Theme.of(context).textTheme.titleMedium),

              const SizedBox(height: 12),

              /// QR Preview
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: provider.mode == GeneratorMode.qr
                        ? const QrPreview()
                        : const BarcodePreview(),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Action Buttons
              ActionButtons(
                isGenerated: provider.mode == GeneratorMode.qr
                    ? provider.qrData.isNotEmpty
                    : provider.barcodeData.isNotEmpty,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
