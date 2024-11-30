import 'dart:convert';
import 'package:http/http.dart' as http;

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
}
