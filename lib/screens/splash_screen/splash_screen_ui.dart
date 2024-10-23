import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpg_qr/screens/splash_screen/splash_screen_cubit.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    context.read<SplashScreenCubit>().change_screen(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: splash_screen_image(context: context),
    );
  }

  Widget splashscreen({required BuildContext context}) {
    return Scaffold(
        backgroundColor: AppColor.instance().background,
        body: splash_screen_image(context: context));
  }

  Widget splash_screen_image({required BuildContext context}) {
    return Center(
      child: Stack(
        children: [
          SvgPicture.asset(
            AppAssets.instance().splash_screen_image,
            fit: BoxFit.cover, // Ensures the image covers the entire screen
            width: double
                .infinity, // Makes sure the image width covers the screen width
            height: double
                .infinity, // Makes sure the image height covers the screen height
          ),
          Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                  child: Image.asset(AppAssets.instance().logo_of_app)))
        ],
      ),
    );
  }
}
