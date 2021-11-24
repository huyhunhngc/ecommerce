import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(centerTitle: true),
  brightness: Brightness.light,
  primaryColor: primaryColor,
  accentColor: Color(0xFFFFA53E),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: FONT_REGULAR,
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    buttonColor: Colors.blueAccent,
  ),
);
