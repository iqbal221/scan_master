import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:quick_scanner/features/scanner/presentation/screens/result_screen.dart';
import 'package:quick_scanner/features/scanner/provider/result_provider.dart';
import 'package:quick_scanner/features/scanner/service/gallery_scanner_service.dart';
import 'package:quick_scanner/features/scanner/service/scanner_service.dart';
import 'package:quick_scanner/features/scanner/widgets/scanner_overlay.dart';

import '../../provider/scanner_provider.dart';

class ScannerScreen extends StatefulWidget {
  static const String name = '/scanner';

  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScannerProvider>();

    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: provider.controller,
            onDetect: (capture) async {
              if (provider.hasScanned) return;

              final service = GalleryScannerService();

              final capture = await service.scanFromGallery();

              if (capture == null) {
                return;
              }

              if (capture.barcodes.isEmpty) {
                return;
              }

              final barcode = capture.barcodes.first;

              if (barcode.rawValue == null) return;

              provider.onDetect(capture);

              final result = ScannerService().parse(barcode.rawValue!);

              await provider.pauseScanner();

              if (!mounted) return;

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ScanResultScreen(
                    content: result.rawValue,
                    type: result.type.name,
                    format: barcode.format.name,
                    scannedAt: result.scannedAt,
                  ),
                ),
              );

              provider.resetScan();
              await provider.resumeScanner();
            },
          ),

          const ScannerOverlay(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),

                  const Spacer(),

                  IconButton(
                    onPressed: provider.toggleFlash,
                    icon: Icon(
                      provider.torchEnabled ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                    ),
                  ),

                  IconButton(
                    onPressed: provider.switchCamera,
                    icon: const Icon(Icons.cameraswitch, color: Colors.white),
                  ),

                  IconButton(
                    icon: const Icon(Icons.photo_library, color: Colors.white),
                    onPressed: () async {
                      final capture = await GalleryScannerService()
                          .scanFromGallery();

                      if (capture == null || capture.barcodes.isEmpty) return;

                      final barcode = capture.barcodes.first;

                      if (barcode.rawValue == null || !context.mounted) return;

                      final result = ScannerService().parse(barcode.rawValue!);

                      await context.read<ResultProvider>().saveHistory(
                        content: result.rawValue,
                        type: result.type.name,
                        format: barcode.format.name,
                        scannedAt: result.scannedAt,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ScanResultScreen(
                            content: result.rawValue,
                            type: result.type.name,
                            format: barcode.format.name,
                            scannedAt: result.scannedAt,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
