import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        child: const SplashScreenUi(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
