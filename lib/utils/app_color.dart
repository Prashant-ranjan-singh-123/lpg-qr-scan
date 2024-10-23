import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor{
  AppColor._();
  static instance()=> AppColor._();

  var secondaryColor = const Color(0xFFFFFFFF);
  var primaryTextColor = const Color(0xFF414042);
  Color white = Colors.white;
  Color purple = const Color(0xff2b3478);

  Color mainGrey = Colors.grey;
  Color grey = const Color(0xffBAC0CB);
  Color main = const Color(0xff161985);
  Color lightYellow = const Color(0xffFAccA3);
  Color black = const Color(0xff454B51);
  Color black87 =  Colors.black87;
  Color orange = const Color(0xffDB693F);
  Color blue = const Color(0xffADD8E6);//Colors.blue;//const Color(0xff151DEE);
  Color lightBlue = const Color(0xff5E79D1);
  Color blue1 = const Color(0xff3F52B3);
  Color grey1 = const Color(0xffA5B0D8);

  Color grey2 = const Color(0xffDEE3E6);
  Color green = const Color(0xff089000);
  Color textColor = const Color(0xFFFFFECF);

  //shyam figma design screens color
  //loader color
  Color loadercolor = const Color(0xffCC2396);
  //screen backgrond color
  Color background = const Color(0xffFFFFFF);
  //appbar color
  final Color red = const Color(0xffA259FF);
  Color originalred = Colors.red;


  Color primaryColor = Colors.grey;
  Color forgotcolor = const Color(0xff0F1B8A);
  //drawer
  Color iconscolor = const Color(0xffCC2396);
  Color textcolor = const Color(0xff7C8B8D);
  Color devidercolor = const Color(0xff7C8B8D);
  //details //about us
  Color titlecolor = const Color(0xff6D4F93);
  Color descriptioncolor = Colors.black; //const Color(0xff7C8B8D);
  Color readmorecolor = const Color(0xffFF620A);
  //notification //notification detail
  Color notititlecolor = const Color(0xffCC2396);
  Color notidescriptioncolor = const Color(0xffA8B1B3);
  Color notidetailtitlecolor = const Color(0xff0B31FD);
  Color shimmerBaseColor = Color(0xFFE0DBE7);
  Color shimmerHilightColor = Color(0xFFB1A6C2);
}