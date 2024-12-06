// features/quran/data/repo/quran_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islami/core/functions/random_aya_number.dart';
import 'package:islami/features/quran/data/model/recieve/ayah_of_the_day/aya_of_the-day.dart';

class QuranService {
  static var data;
///////////////////////////////   view ayah
  static Future<void> getAyah() async {
    var client = http.Client();
    var res = await client
        .get(Uri.parse('https://api.alquran.cloud/v1/quran/quran-uthmani'));
    var jsonData = jsonDecode(res.body);
    data = jsonData["data"];
  }

////////////////////////////// filter surahs
  static List<dynamic> filterSurahs(String query, List<dynamic> allSurahs) {
    List<dynamic> results = [];

    if (query.isEmpty) {
      results = allSurahs;
    } else {
      results = allSurahs.where((surah) {
        var arabicName = surah['name'].toString().toLowerCase();
        var englishName = surah['englishName'].toString().toLowerCase();

        return arabicName.contains(query.toLowerCase()) ||
            englishName.contains(query.toLowerCase());
      }).toList();
    }

    return results;
  }

  /////////////////////////////  ayah of the day
  static Future<AyaOfTheDay> getAyaOfTheDay() async {
    String url =
        "https://api.alquran.cloud/v1/ayah/${randomFunction(1, 6237)}/editions/quran-uthmani,en.asad,en.pickthall";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //print("-----------------------${json.decode(response.body)}");

      return AyaOfTheDay.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load aya of the day');
    }
  }
}
