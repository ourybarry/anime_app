import 'package:anime/ui/themes/custom_colors.dart';
import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: CustomColors.BACKGROUND_COLOR,
      appBarTheme: AppBarTheme(backgroundColor: CustomColors.SURFACE_COLOR),
      fontFamily: 'Lato',
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: CustomColors.PRIMARY_COLOR,
          unselectedItemColor: CustomColors.TEXT_GREY,
          backgroundColor: CustomColors.SURFACE_COLOR),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          fillColor: CustomColors.TEXT_LIGHT,
          focusedBorder: OutlineInputBorder(),
          focusColor: Colors.black,
          filled: true),
      textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomColors.TEXT_LIGHT),
          headline2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CustomColors.TEXT_GREY),
          headline3: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CustomColors.TEXT_LIGHT)),
    );
  }
}
