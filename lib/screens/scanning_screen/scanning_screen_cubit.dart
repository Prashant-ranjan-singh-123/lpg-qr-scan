import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'scanning_screen_state.dart';

class ScanningScreenCubit extends Cubit<ScanningScreenState> {
  // QRViewController? controller;
  // bool isScanned = false;

  ScanningScreenCubit() : super(ScanningScreenInitial());

  // void onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     if (!isScanned) {
  //       isScanned = true;
  //       controller.pauseCamera(); // Pause the camera to prevent multiple scans
  //       emit(ScanningScreenCodeScanned(scanData)); // Emit state with scan result
  //     }
  //   });
  // }
  //
  // void navigateBackAndResumeCamera() {
  //   controller?.resumeCamera();
  //   isScanned = false;
  //   emit(ScanningScreenInitial()); // Reset state for a new scan
  // }
  //
  // @override
  // Future<void> close() {
  //   controller?.dispose();
  //   return super.close();
  // }
}
