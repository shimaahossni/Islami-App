class Hadith {
  int? number;
  String? arab;
  String? id;

  Hadith({this.number, this.arab, this.id});

  factory Hadith.fromJson(Map<String, dynamic> json) => Hadith(
        number: json['number'] as int?,
        arab: json['arab'] as String?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'number': number,
        'arab': arab,
        'id': id,
      };
}
