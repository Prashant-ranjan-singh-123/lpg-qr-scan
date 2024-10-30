import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpg_qr/screens/after_scanning_page/after_scanning_ui.dart';
import 'package:lpg_qr/screens/splash_screen/splash_screen_ui.dart';

import 'screens/splash_screen/splash_screen_cubit.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => SplashScreenCubit(),
        // child: AfterScanningUi(url: 'https://lpgassociation.pmpframe.com/MjA1',),
        child: SplashScreenUi(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
