import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData getTheme() {
  return ThemeData(
    //fontFamily: 'Inter',
    // colorScheme: ColorScheme.fromSwatch(
    //   accentColor: Colors.black,
    // ),
    primaryColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8.0.r,
            ),
          ),
        ),
        minimumSize: MaterialStatePropertyAll(
          Size.fromWidth(
            ScreenUtil.defaultSize.width,
          ),
        ),
        backgroundColor: const MaterialStatePropertyAll(
          Colors.black,
        ),
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          12.0.r,
        ),
      ),
    ),
  );
}
