import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../screens/after_scanning_page/after_scanning_ui.dart';

class ScannedBarcodeLabel extends StatefulWidget {
  const ScannedBarcodeLabel({
    super.key,
    required this.barcodes,
  });

  final Stream<BarcodeCapture> barcodes;

  @override
  State<ScannedBarcodeLabel> createState() => _ScannedBarcodeLabelState();
}

class _ScannedBarcodeLabelState extends State<ScannedBarcodeLabel> {
  String? lastScannedValue; // To store the last scanned value

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BarcodeCapture>(
      stream: widget.barcodes,
      builder: (context, snapshot) {
        final scannedBarcodes = snapshot.data?.barcodes ?? [];

        if (scannedBarcodes.isEmpty) {
          return const Text(
            'Scan something!',
            overflow: TextOverflow.fade,
            style: TextStyle(color: Colors.white),
          );
        }

        // Get the current scanned display value
        final currentDisplayValue = scannedBarcodes.first.displayValue;

        // Check if it matches the specific URL and is different from the last scanned value
        if (currentDisplayValue != null &&
            currentDisplayValue.contains('https://tlda.org.in/api/') &&
            currentDisplayValue != lastScannedValue) {

          // Update the last scanned value
          lastScannedValue = currentDisplayValue;

          // Navigate to the AfterScanningUi only once for a new value
          Future.microtask(() {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AfterScanningUi(
                  url: currentDisplayValue,
                ),
              ),
            );
          });
        }

        return const Text(
          'Invalid QR Code',
          overflow: TextOverflow.fade,
          style: TextStyle(color: Colors.white),
        );
      },
    );
  }
}