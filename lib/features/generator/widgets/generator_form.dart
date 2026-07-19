import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_scanner/features/generator/data/models/qr_type.dart';

import '../provider/generator_provider.dart';

class GeneratorForm extends StatelessWidget {
  const GeneratorForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GeneratorProvider>();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// QR Type
            DropdownButtonFormField<QrType>(
              value: provider.selectedType,
              decoration: const InputDecoration(
                labelText: "QR Type",
                border: OutlineInputBorder(),
              ),
              items: QrType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Row(
                    children: [
                      Icon(type.icon),
                      const SizedBox(width: 10),
                      Text(type.title),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  provider.changeType(value);
                }
              },
            ),

            const SizedBox(height: 20),

            _buildFields(provider),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: provider.generateQR,
                    icon: const Icon(Icons.qr_code),
                    label: const Text("Generate"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFields(GeneratorProvider provider) {
    switch (provider.selectedType) {
      case QrType.text:
      case QrType.website:
      case QrType.email:
      case QrType.phone:
        return TextFormField(
          controller: provider.contentController,
          decoration: InputDecoration(
            labelText: provider.selectedType.title,
            hintText: provider.selectedType.hintText,
            border: const OutlineInputBorder(),
          ),
        );

      case QrType.sms:
        return Column(
          children: [
            TextFormField(
              controller: provider.contentController,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: provider.smsBodyController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Message",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        );

      case QrType.wifi:
        return Column(
          children: [
            TextFormField(
              controller: provider.wifiNameController,
              decoration: const InputDecoration(
                labelText: "WiFi Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: provider.wifiPasswordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        );

      case QrType.contact:
        return TextFormField(
          controller: provider.contentController,
          decoration: const InputDecoration(
            labelText: "Contact Name",
            border: OutlineInputBorder(),
          ),
        );

      case QrType.location:
        return Column(
          children: [
            TextFormField(
              controller: provider.latitudeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Latitude",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: provider.longitudeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Longitude",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        );
    }
  }
}
