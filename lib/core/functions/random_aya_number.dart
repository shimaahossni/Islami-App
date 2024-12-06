// core/functions/random_aya_number.dart
import 'dart:async';
import 'dart:math';

import 'package:islami/core/services/app_local_storage.dart';
import 'package:islami/features/quran/data/repo/quran_service.dart';


randomFunction(min, max) {
  var rm = Random();
  var result = rm.nextInt(max - min + 1) + min;
  return result;
}

 scheduleHourlyUpdates() {
  Timer hourlyTimer;
  hourlyTimer = Timer.periodic(const Duration(hours: 1), (timer) {
    QuranService.getAyaOfTheDay();
    //AppLocalStorage.getCachedAyahData(AppLocalStorage.AyahKey);
  });
}