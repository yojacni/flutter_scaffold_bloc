import 'package:flutter/material.dart';

ThemeData customDarkTheme() {
  final darkTheme = ThemeData.dark();
  return darkTheme.copyWith(
    primaryColor: Colors.black38,
    indicatorColor: const Color(0xFF807A6B),
    //accentColor: const Color(0xFFFFF8E1),
    primaryIconTheme: darkTheme.primaryIconTheme.copyWith(
      color: Colors.green,
      size: 20,
    ),
    //cursorColor: Colors.green,
  );
}
