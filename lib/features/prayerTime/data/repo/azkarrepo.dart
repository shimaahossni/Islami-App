// features/prayerTime/data/repo/azkarrepo.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:islami/features/prayerTime/data/model/today_azkar/today_azkar.dart';

class AzkarRepo {
  static Future<TodayAzkar?> loadAzkar() async {
    try {
      var response = await rootBundle.loadString("assets/json/adhkar.json");
      final data = await json.decode(response);

      if (data.isNotEmpty) {
        // print(data);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
