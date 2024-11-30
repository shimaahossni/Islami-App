// core/functions/theme.dart
import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_colors.dart';

class ApplicationThemeManager {
  static const Color primaryColor = AppColors.primaryColor;

  ////////////////////////////////////////////////////////////////////lighttheme
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: AppColors.grayColor,
    appBarTheme: const AppBarTheme(
      color: AppColors.grayColor,
    ),

    //bottomNavigationBarTheme:
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: primaryColor,
      selectedIconTheme: IconThemeData(color: Colors.white, size: 38),
      unselectedItemColor: Color(0xFFC8C9CB),
      unselectedIconTheme: IconThemeData(color: Color(0xFFC8C9CB), size: 30),
    ),
  );

  ////////////////////////////////////////////////////////////////////darktheme
  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: AppColors.blackColor,
    appBarTheme: const AppBarTheme(
      color: AppColors.blackColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: primaryColor,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(color: primaryColor, size: 38),
      unselectedItemColor: AppColors.blackColor,
      unselectedIconTheme: IconThemeData(color: AppColors.blackColor, size: 30),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: primaryColor,
      padding: EdgeInsets.zero,
    ),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
      fontSize: 60,
      color: Colors.black,
    )),
  );
}
