import 'hadith.dart';

class Data {
  String? name;
  String? id;
  int? available;
  int? requested;
  List<Hadith>? hadiths;

  Data({this.name, this.id, this.available, this.requested, this.hadiths});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json['name'] as String?,
        id: json['id'] as String?,
        available: json['available'] as int?,
        requested: json['requested'] as int?,
        hadiths: (json['hadiths'] as List<dynamic>?)
            ?.map((e) => Hadith.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'available': available,
        'requested': requested,
        'hadiths': hadiths?.map((e) => e.toJson()).toList(),
      };
}
