import 'data.dart';

class PrayerTime {
  int? code;
  String? status;
  Data? data;

  PrayerTime({this.code, this.status, this.data});

  factory PrayerTime.fromJson(Map<String, dynamic> json) => PrayerTime(
        code: json['code'] as int?,
        status: json['status'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'data': data?.toJson(),
      };
}
