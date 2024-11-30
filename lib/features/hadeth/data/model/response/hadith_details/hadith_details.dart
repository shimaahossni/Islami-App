import 'data.dart';

class HadithDetails {
  int? code;
  String? message;
  Data? data;
  bool? error;

  HadithDetails({this.code, this.message, this.data, this.error});

  factory HadithDetails.fromJson(Map<String, dynamic> json) => HadithDetails(
        code: json['code'] as int?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        error: json['error'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'data': data?.toJson(),
        'error': error,
      };
}
