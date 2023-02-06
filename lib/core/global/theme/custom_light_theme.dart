import 'package:flutter/material.dart';

ThemeData customLightTheme() {
  TextTheme _customLightThemesTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1?.copyWith(
        fontFamily: 'Roboto',
        fontSize: 22,
        color: Colors.green,
      ),
      headline6: base.headline6?.copyWith(
        fontSize: 15,
        color: Colors.orange,
      ),
      headline4: base.headline1?.copyWith(
        fontSize: 24,
        color: Colors.white,
      ),
      headline3: base.headline1?.copyWith(
        fontSize: 22,
        color: Colors.grey,
      ),
      caption: base.caption?.copyWith(
        color: const Color(0xFFCCC5AF),
      ),
      bodyText2: base.bodyText2?.copyWith(color: const Color(0xFF807A6B)),
      bodyText1: base.bodyText1?.copyWith(color: Colors.brown),
    );
  }

  final lightTheme = ThemeData.light();
  return lightTheme.copyWith(
    textTheme: _customLightThemesTextTheme(lightTheme.textTheme),
    primaryColor: const Color(0xffce107c),
    indicatorColor: const Color(0xFF807A6B),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    //accentColor: const Color(0xFFFFF8E1),
    primaryIconTheme: lightTheme.primaryIconTheme.copyWith(
      color: Colors.white,
      size: 20,
    ),
    iconTheme: lightTheme.iconTheme.copyWith(
      color: Colors.white,
    ),
    //buttonColor: Colors.white,
    backgroundColor: Colors.white,
    tabBarTheme: lightTheme.tabBarTheme.copyWith(
      labelColor: const Color(0xffce107c),
      unselectedLabelColor: Colors.grey,
    ),
    buttonTheme: lightTheme.buttonTheme.copyWith(buttonColor: Colors.red),
    //cursorColor: Colors.deepPurple,
    errorColor: Colors.red,
  );
}
