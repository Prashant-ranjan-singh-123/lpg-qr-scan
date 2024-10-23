import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'after_scanning_state.dart';

class AfterScanningCubit extends Cubit<AfterScanningState> {
  AfterScanningCubit() : super(AfterScanningInitial());
}
