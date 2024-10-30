import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class MyLoader extends StatelessWidget {
  const MyLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: AppColor.instance().red,
      ),
    );
  }
}
