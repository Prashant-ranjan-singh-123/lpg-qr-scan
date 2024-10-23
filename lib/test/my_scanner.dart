import 'package:flutter/material.dart';
import 'package:lpg_qr/test/scanned_barcode_label.dart';
import 'package:lpg_qr/utils/app_color.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MyScanner extends StatefulWidget {
  const MyScanner({super.key});

  @override
  State<MyScanner> createState() => _MyScannerState();
}

class _MyScannerState extends State<MyScanner> {
  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

// Calculate the offset for 40% from the top
    final topOffset = screenSize.height * 0.4;
    final scanWindow = Rect.fromCenter(
      center: Offset(screenSize.width / 2, topOffset),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.width * 0.6,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.instance().red,
        title: const Text(
          'QR Scanner (LPG)',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: MobileScanner(
              fit: BoxFit.cover,
              controller: controller,
              scanWindow: scanWindow,
              // errorBuilder: (context, error, child) {
              //   return ScannerErrorWidget(error: error);
              // },
              overlayBuilder: (context, constraints) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ScannedBarcodeLabel(barcodes: controller.barcodes),
                  ),
                );
              },
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, child) {
              if (!value.isInitialized ||
                  !value.isRunning ||
                  value.error != null) {
                return const SizedBox();
              }

              return CustomPaint(
                painter: ScannerOverlay(scanWindow: scanWindow),
              );
            },
          )
        ],
      ),
    );
  }
}




class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the 40% offset from the top
    final double topOffset = size.height * 0.4;

    // Create a new `Rect` with the offset applied
    final Rect adjustedScanWindow = scanWindow.shift(Offset(0, topOffset));

    // Create the background path to cover the full screen
    final backgroundPath = Path()..addRect(Offset.zero & size);

    // Create the cutout path for the scan window area
    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          adjustedScanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    // Paint the background with a transparent cutout for the scan window
    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    // Combine the background and cutout paths
    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    // Paint the border around the scan window
    final borderPaint = Paint()
      ..color = AppColor.instance().red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    // Create a border with the adjusted scan window position
    final borderRect = RRect.fromRectAndCorners(
      adjustedScanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    // Draw the background with a transparent cutout and the border
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}
