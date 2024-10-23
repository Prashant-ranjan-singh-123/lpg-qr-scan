import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../scanning_screen/scanning_screen.dart';
import '../scanning_screen/scanning_screen_cubit.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenInitial());

  Future<void> change_screen({required BuildContext context}) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) =>
        BlocProvider(
          create: (context) => ScanningScreenCubit(),
          child: ScanningScreen(),
        )));
  }
}
