import 'package:flutter/material.dart';
import 'package:petstore/data/constants.dart';

class ThemeUtils {
  static ThemeData light = ThemeData(
      fontFamily: 'Gordita',
      primarySwatch: Colors.blue,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: bgColor,
      textTheme: const TextTheme(
        bodyText2: TextStyle(color: Colors.black54),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
  ));

  static ThemeData defaultDarkTheme = ThemeData.dark();
  static ThemeData dark = ThemeData(
    fontFamily: 'Gordita',
    appBarTheme: defaultDarkTheme.appBarTheme
        .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
    scaffoldBackgroundColor: defaultDarkTheme.scaffoldBackgroundColor,
    backgroundColor: defaultDarkTheme.backgroundColor,
    brightness: defaultDarkTheme.brightness,
    bottomAppBarColor: defaultDarkTheme.bottomAppBarColor,
    bottomAppBarTheme: defaultDarkTheme.bottomAppBarTheme,
    buttonTheme: defaultDarkTheme.buttonTheme,
    toggleButtonsTheme: defaultDarkTheme.toggleButtonsTheme,
    iconTheme: const IconThemeData(color: Colors.white),
  );
}