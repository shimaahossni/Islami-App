// aya_of_the_day/aya.dart
class AyaOfTheDay {
  final String? arText;
  final String? enTran;
  final String? suraaName;
  final int? suraNumber;

  AyaOfTheDay({this.arText, this.enTran, this.suraaName, this.suraNumber});

  factory AyaOfTheDay.fromJson(Map<String, dynamic> json) {
    return AyaOfTheDay(
      arText: json['data'][0]['text'],
      enTran: json['data'][2]['text'],
      suraaName: json['data'][2]['surah']['englishName'],
      suraNumber: json['data'][2]['numberInSurah'],
    );
  }
}
