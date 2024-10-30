import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../test/barcode_scanner_controller.dart';
import '../../test/barcode_scanner_listview.dart';
import '../../test/barcode_scanner_pageview.dart';
import '../../test/barcode_scanner_returning_image.dart';
import '../../test/barcode_scanner_simple.dart';
import '../../test/barcode_scanner_window.dart';
import '../../test/barcode_scanner_zoom.dart';
import '../../test/mobile_scanner_overlay.dart';
import '../../test/my_scanner.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../after_scanning_page/after_scanning_ui.dart';
import '../show_attendance/show_attendance.dart';

class ScanningScreen extends StatefulWidget {
  const ScanningScreen({super.key});

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // QRViewController? controller;
  bool isScanned = false; // To avoid multiple scans
  // Barcode? result;

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.instance().red,
        title: const Text(
          'LPG QR Scanner',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _ui(context: context)
      // Column(
      //   children: [
      //     // _buildQrView(context),
      //     // _buildScanResult(),
      //   ],
      // ),
    );
  }

  // Widget _buildQrView(BuildContext context) {
  //   return Expanded(
  //     flex: 5,
  //     child: QRView(
  //       key: qrKey,
  //       onQRViewCreated: (controller) {
  //         this.controller = controller;
  //         _scanLogic(); // Start scanning logic when QRView is created
  //       },
  //       overlay: QrScannerOverlayShape(
  //         borderColor: Colors.red,
  //         borderRadius: 10,
  //         borderLength: 30,
  //         borderWidth: 10,
  //         cutOutSize: 300,
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildScanResult() {
  //   return Expanded(
  //     flex: 0,
  //     child: Center(
  //       child: (result != null)
  //           ? Text('Scanned: ${result!.code}')
  //           : const Text('Scan a code'),
  //     ),
  //   );
  // }

  // void _scanLogic() {
  //   controller?.scannedDataStream.listen((scanData) {
  //     if (!isScanned) {
  //       result = scanData;
  //
  //       if (_isValidQrCode(result?.code)) {
  //         setState(() {
  //           isScanned = true; // Mark as scanned to avoid multiple scans
  //         });
  //         controller?.pauseCamera(); // Pause camera only for valid scans
  //         Future.microtask(() {
  //           Navigator.of(context)
  //               .push(MaterialPageRoute(
  //             builder: (context) => AfterScanningUi(
  //               url: result?.code ?? '',
  //             ),
  //           ))
  //               .then((_) => _resumeCamera());
  //         });
  //       } else {
  //         print('Invalid QR Code: ${result?.code}');
  //         // Do nothing here, keep the camera scanning without pausing
  //       }
  //     }
  //   });
  // }

  // Helper function to validate the QR code content
  bool _isValidQrCode(String? code) {
    if (code == null) return false;
    return code.contains('https:');
  }

  // void _resumeCamera() {
  //   controller?.resumeCamera();
  //   setState(() {
  //     isScanned = false; // Allow scanning again after returning to the screen
  //   });
  // }

  Widget _buildItem(BuildContext context, String label, Widget page) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => page,
              ),
            );
          },
          child: Text(label),
        ),
      ),
    );
  }

  Widget _ui({required BuildContext context}){
    return Center(
      child: Column(
        children: [
          // _buildItem(
          //   context,
          //   'MobileScanner Simple',
          //   const BarcodeScannerSimple(),
          // ),
          // _buildItem(
          //   context,
          //   'MobileScanner with ListView',
          //   const BarcodeScannerListView(),
          // ),
          // _buildItem(
          //   context,
          //   'MobileScanner with Controller',
          //   const BarcodeScannerWithController(),
          // ),
          // _buildItem(
          //   context,
          //   'MobileScanner with ScanWindow',
          //   const BarcodeScannerWithScanWindow(),
          // ),
          // _buildItem(
          //   context,
          //   'MobileScanner with Controller (return image)',
          //   const BarcodeScannerReturningImage(),
          // ),
          // _buildItem(
          //   context,
          //   'MobileScanner with zoom slider',
          //   const BarcodeScannerWithZoom(),
          // ),
          // _buildItem(
          //   context,
          //   'MobileScanner with PageView',
          //   const BarcodeScannerPageView(),
          // ),
          // _buildItem(
          //   context,
          //   'MobileScanner with Overlay',
          //   const BarcodeScannerWithOverlay(),
          // ),
          SizedBox(height: MediaQuery.of(context).size.height*0.1),
          _attendance_illustration(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
            child: _build_buttons(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1, vertical: 25),
            child: _build_button_show_attendance(),
          ),
          // _buildItem(
          //   context,
          //   'Analyze image from file',
          //   BarcodeScannerAnalyzeImage(),
          // ),
        ],
      ),
    );
  }

  Widget _attendance_illustration() {
    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width*0.6,
            child: SvgPicture.asset(AppAssets.instance().svg_qr_code)),
        // Text(widget.url!),
      ],
    );
  }

  Widget _build_buttons() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MyScanner(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.instance().red,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12))),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          'Scan QR Code',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _build_button_show_attendance() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ShowAttendance(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.instance().red,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12))),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          'Show Attendance',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

class BarcodeScannerAnalyzeImage {
  const BarcodeScannerAnalyzeImage();
}
