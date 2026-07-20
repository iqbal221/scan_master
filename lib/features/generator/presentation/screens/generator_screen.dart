import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_scanner/core/theme/theme_provider.dart';
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
    final generatorProvider = context.watch<GeneratorProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR & Barcode Generator'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: "Change Theme",
            onPressed: themeProvider.toggleTheme,
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                themeProvider.isDark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                key: ValueKey(themeProvider.isDark),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Generator Mode
              const ModeSelector(),

              const SizedBox(height: 20),

              /// Input Form
              generatorProvider.mode == GeneratorMode.qr
                  ? const QRCodeForm()
                  : const BarcodeForm(),

              const SizedBox(height: 24),

              /// Preview Title
              Text(
                "Preview",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 12),

              /// Preview Card
              Card(
                color: theme.cardColor,
                elevation: 3,
                shadowColor: colorScheme.shadow.withOpacity(.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: generatorProvider.mode == GeneratorMode.qr
                        ? const QrPreview()
                        : const BarcodePreview(),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Action Buttons
              ActionButtons(
                isGenerated: generatorProvider.mode == GeneratorMode.qr
                    ? generatorProvider.qrData.isNotEmpty
                    : generatorProvider.barcodeData.isNotEmpty,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
