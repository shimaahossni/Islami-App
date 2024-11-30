// features/setting/data/setting_provider.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islami/features/hadeth/page/views/hadeth_screen.dart';
import 'package:islami/features/prayerTime/page/views/prayer_time_screen.dart';
import 'package:islami/features/quran/page/views/quran_screen.dart';
import 'package:islami/features/seb7a/page/views/seb7a_screen.dart';
import 'package:islami/features/today_werd/page/views/today_werd.dart';

class SettingProvider extends ChangeNotifier {
  late List<Widget> screens;

  SettingProvider() {
    _initScreens();
  }

  void _initScreens() {
    screens = [
      QuranScreen(),
      HadethScreen(),
      SebhaScreen(),
      PrayerTimeScreen(),
      TodayWerd()
    ];
  }

  ///////////////////////////////////////////////theme
  ThemeMode currentTheme = ThemeMode.dark;
  changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }

  bool isDark() {
    return currentTheme == ThemeMode.dark;
  }

  /////////////////////////////////////////////language
  String currentLanguage = 'en';
  changeLanguage(String newLanguage) {
    if (currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;
    notifyListeners();
  }

  bool isEnglish() {
    return currentLanguage == 'en';
  }

  String getBackground() {
    return currentTheme == ThemeMode.light ? 'white' : 'black';
  }

  /////////////////////////////////////////////layoutScreen
  int currentIndex = 0;
  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
