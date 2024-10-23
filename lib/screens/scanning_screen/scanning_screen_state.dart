part of 'scanning_screen_cubit.dart';

@immutable
abstract class ScanningScreenState {}

class ScanningScreenInitial extends ScanningScreenState {}

class ScanningScreenCodeScanned extends ScanningScreenState {
  // final Barcode scannedData;

  // ScanningScreenCodeScanned(this.scannedData);
  ScanningScreenCodeScanned();
}
